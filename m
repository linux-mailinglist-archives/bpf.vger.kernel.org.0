Return-Path: <bpf+bounces-5658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E175D7E6
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 01:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56C01C21715
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 23:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AB23BCD;
	Fri, 21 Jul 2023 23:33:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429FDF6D;
	Fri, 21 Jul 2023 23:33:43 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8211FE1;
	Fri, 21 Jul 2023 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=tftwJrvxrIPluSStl59nZKh2VAaqKkanzBE/of2CS7I=; b=fdhOuATLhAY+E6H8Db7XXMih5+
	PKMzyOWhy3BAdJT7Se/sl8Z6zU4PC+xVvFSbFaALCzSL6fHR4B4Pn75JWmO6UwOARC9B17pQLvoZ1
	dVWinqHZR+Nc3LaABbGwMclQPevSpQGhSFaQhnjTgT4gL53qUPascxb8ARtuLVaxDss0iVIhNesJ/
	JVB1e4PbLfUlyGwJIwngURpET84wZLAFHpGTfA7JuevM2ljEjerob+cVgyIZKMmgYvRZ8mJNMRGUr
	aopKv71iHcJXOt46fU9ghYlDqsIDReVx5MqGTpdWE0cJOuXqaWkbemtIuG1/BWSc4LCjbtbayOVx5
	JLwyWhcg==;
Received: from 123-243-13-99.tpgi.com.au ([123.243.13.99] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qMzcv-000Lhp-M7; Sat, 22 Jul 2023 01:33:38 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
	syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
	syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
Subject: [PATCH net-next] tcx: Fix splat in ingress_destroy upon tcx_entry_free
Date: Sat, 22 Jul 2023 01:33:30 +0200
Message-Id: <20230721233330.5678-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26976/Fri Jul 21 09:28:26 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On qdisc destruction, the ingress_destroy() needs to update the correct
entry, that is, tcx_entry_update must NULL the dev->tcx_ingress pointer.
Therefore, fix the typo.

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/sched/sch_ingress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index 04e886f6cee4..a463a63192c3 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -123,7 +123,7 @@ static void ingress_destroy(struct Qdisc *sch)
 	if (entry) {
 		tcx_miniq_set_active(entry, false);
 		if (!tcx_entry_is_active(entry)) {
-			tcx_entry_update(dev, NULL, false);
+			tcx_entry_update(dev, NULL, true);
 			tcx_entry_free(entry);
 		}
 	}
-- 
2.34.1


