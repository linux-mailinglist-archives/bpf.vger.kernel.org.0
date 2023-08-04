Return-Path: <bpf+bounces-7003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CAB7700DB
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4011C21856
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48901BE5D;
	Fri,  4 Aug 2023 13:11:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12823A940
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 13:11:57 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACBC13D
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8xHxz9zllmQxTKtEF8QIycucg5GDH06EI/yUcT3qAi8=; b=JweABOnaDR4/Kl5LDXGZnTp2PH
	aHC8ZxU8dpmL1xXp/hZX6F15drSC5US1wgCA3bzlrN4QzgKgQmtTQslhiwvtmLhxBpFFt6L8hicu5
	5N0ZCfx65dPuWRK5qG0VRXfALM9vzPMMB19jRpenbcD3iS0E7aWSxt1VC5qI55gL2m9ma66D7SeaT
	dk+yd3HW0RqhM43XUX2dxvRY/W2/7+VFOT6yU+bm7gkUdqmdG/c5ntIm7dpHRRRVmJ4uXcVflxOku
	uec5B2M9LDkQYUcJx7yWienjAHHNKzB24RuW4rVP0QgH+q43g32Yqis4m5f3egkq+IiDcfZXTbpdz
	l8jN/9Og==;
Received: from [180.200.247.117] (helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qRuat-000IT3-Sw; Fri, 04 Aug 2023 15:11:52 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 1/2] bpf: Fix mprog detachment for empty mprog entry
Date: Fri,  4 Aug 2023 15:11:11 +0200
Message-Id: <20230804131112.11012-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26990/Fri Aug  4 09:32:00 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reported an UBSAN array-index-out-of-bounds access in bpf_mprog_read()
upon bpf_mprog_detach(). While it did not have a reproducer, I was able to
manually reproduce through an empty mprog entry which just has miniq present.

The latter is important given otherwise we get an ENOENT error as tcx detaches
the whole mprog entry. The index 4294967295 was triggered via NULL dtuple.prog
which then attempts to detach from the back. bpf_mprog_fetch() in this case
did hit the idx == total and therefore tried to grab the entry at idx -1.

Fix it by adding an explicit bpf_mprog_total() check in bpf_mprog_detach() and
bail out early with ENOENT.

Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-progs")
Reported-by: syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/mprog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index f7816d2bc3e4..32d2c4829eb8 100644
--- a/kernel/bpf/mprog.c
+++ b/kernel/bpf/mprog.c
@@ -337,6 +337,8 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 		return -EINVAL;
 	if (revision && revision != bpf_mprog_revision(entry))
 		return -ESTALE;
+	if (!bpf_mprog_total(entry))
+		return -ENOENT;
 	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
 				       prog ? prog->type :
 				       BPF_PROG_TYPE_UNSPEC);
-- 
2.34.1


