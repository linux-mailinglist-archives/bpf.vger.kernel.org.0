Return-Path: <bpf+bounces-11131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA77B3B55
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 947191C209D4
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7570B15ADB;
	Fri, 29 Sep 2023 20:41:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B98C13
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 20:41:45 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959721B0
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QigJyyA6Ce1O6UwbrHLZ40nBIRVv8QhknmdSt9kKXuI=; b=NXM1L9CgFTc+NTsgZvHUZmv17D
	KnF4WCGeSfqKmyqT79ISHcmpk7z8KwGvu/ZjmndQjZWYXPpKvOrY82mLLWNHFm0jdA1LWEHcFaHI9
	DKvTqQ/r0Euu88bWb8I7KO3TCSGAPqBQDNGEqZJhk9I0qeaPCz8PcIxGCxLmUrpAsJzxGncwy48LP
	pIi+v2kvGS1bBrTo0ppHF8jW6AYYT5BRCMvucSwjEvzcYGrknUsixHPDO6zXvQyO6aR0cKaKRAjAN
	Vr+6s+yyZF+nDPqHkvMWwy9U5BmPdbmLxJp1AqkJPy8MJevZIKfMretagIjzfFglcc+UH4OIrU6ry
	vyhR3dbw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qmKIt-0009x2-7Y; Fri, 29 Sep 2023 22:41:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: martin.lau@kernel.org,
	razor@blackwall.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	syzbot+baa44e3dbbe48e05c1ad@syzkaller.appspotmail.com,
	syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com,
	syzbot+2558ca3567a77b7af4e3@syzkaller.appspotmail.com
Subject: [PATCH bpf 1/2] bpf, mprog: Fix maximum program check on mprog attachment
Date: Fri, 29 Sep 2023 22:41:20 +0200
Message-Id: <20230929204121.20305-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27046/Fri Sep 29 09:41:56 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After Paul's recent improvement to syzkaller to improve coverage for
bpf_mprog and tcx, it hit a splat that the program limit was surpassed.
What happened is that the maximum number of progs got added, followed
by another prog add request which adds with BPF_F_BEFORE flag relative
to the last program in the array. The idx >= bpf_mprog_max() check in
bpf_mprog_attach() still passes because the index is below the maximum
but the maximum will be surpassed. We need to add a check upfront for
insertions to catch this situation.

Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-progs")
Reported-by: syzbot+baa44e3dbbe48e05c1ad@syzkaller.appspotmail.com
Reported-by: syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com
Reported-by: syzbot+2558ca3567a77b7af4e3@syzkaller.appspotmail.com
Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: syzbot+baa44e3dbbe48e05c1ad@syzkaller.appspotmail.com
Tested-by: syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com
Link: https://github.com/google/syzkaller/pull/4207
---
 kernel/bpf/mprog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 32d2c4829eb8..007d98c799e2 100644
--- a/kernel/bpf/mprog.c
+++ b/kernel/bpf/mprog.c
@@ -253,6 +253,9 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 			goto out;
 		}
 		idx = tidx;
+	} else if (bpf_mprog_total(entry) == bpf_mprog_max()) {
+		ret = -ERANGE;
+		goto out;
 	}
 	if (flags & BPF_F_BEFORE) {
 		tidx = bpf_mprog_pos_before(entry, &rtuple);
-- 
2.34.1


