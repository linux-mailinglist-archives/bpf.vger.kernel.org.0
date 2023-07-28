Return-Path: <bpf+bounces-6270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BB7677E7
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F128274F
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 21:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC91FB2C;
	Fri, 28 Jul 2023 21:47:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEB23B8;
	Fri, 28 Jul 2023 21:47:48 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C95BF;
	Fri, 28 Jul 2023 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=n+xEMeWf7RddKr5Smt/pWISVzBzYHTks/7mHeXgs/Ek=; b=QAGnepymo03lOqXOd+Yz+O0dde
	AtjiUffYPha5NmyNMudg3IPXm6YCLW6+KpDqCnQblj3lwUSJWBk6WGC6bhjcXDQGSqSFnfCj0TsQ+
	Ud/UDIiElThRwPOJsqGtpaQtLTtQIl3v+1peopuNQpFBGRpwQzlgDhx/8Zow//BznpZNt7/6PFRKb
	UZCe3oode7Fb4I8XHD4ACEPwC8g0/FvIH+nkDQsTXyYAXhVps2YFpMXbbZw5LpYHJSfrr3yMKHSJT
	OdIC8dRquYIxbMf2xjuH2ISAuM7Sf6YdCQdljrWW1st6xJWneJPE/K6jCWTz175KNnsDAkGR6FVkV
	r/Z6ELaw==;
Received: from 14-202-107-205.tpgi.com.au ([14.202.107.205] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qPVJA-0005cC-OF; Fri, 28 Jul 2023 23:47:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@nvidia.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next] tcx: Fix splat during dev unregister
Date: Fri, 28 Jul 2023 23:47:17 +0200
Message-Id: <222255fe07cb58f15ee662e7ee78328af5b438e4.1690549248.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26983/Fri Jul 28 09:28:05 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@kernel.org>

During unregister_netdevice_many_notify(), the ordering of our concerned
function calls is like this:

  unregister_netdevice_many_notify
    dev_shutdown
	qdisc_put
            clsact_destroy
    tcx_uninstall

The syzbot reproducer triggered a case that the qdisc refcnt is not
zero during dev_shutdown().

tcx_uninstall() will then WARN_ON_ONCE(tcx_entry(entry)->miniq_active)
because the miniq is still active and the entry should not be freed.
The latter assumed that qdisc destruction happens before tcx teardown.

This fix is to avoid tcx_uninstall() doing tcx_entry_free() when the
miniq is still alive and let the clsact_destroy() do the free later, so
that we do not assume any specific ordering for either of them.

If still active, tcx_uninstall() does clear the entry when flushing out
the prog/link. clsact_destroy() will then notice the "!tcx_entry_is_active()"
and then does the tcx_entry_free() eventually.

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Reported-by: syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com
Reported-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: syzbot+376a289e86a0fd02b9ba@syzkaller.appspotmail.com
---
 [ Sending directly to net-next given the issue was reported there by Leon. ]

 include/linux/bpf_mprog.h | 16 ++++++++++++++++
 kernel/bpf/tcx.c          | 12 ++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 2b429488f840..929225f7b095 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -256,6 +256,22 @@ static inline void bpf_mprog_entry_copy(struct bpf_mprog_entry *dst,
 	memcpy(dst->fp_items, src->fp_items, sizeof(src->fp_items));
 }
 
+static inline void bpf_mprog_entry_clear(struct bpf_mprog_entry *dst)
+{
+	memset(dst->fp_items, 0, sizeof(dst->fp_items));
+}
+
+static inline void bpf_mprog_clear_all(struct bpf_mprog_entry *entry,
+				       struct bpf_mprog_entry **entry_new)
+{
+	struct bpf_mprog_entry *peer;
+
+	peer = bpf_mprog_peer(entry);
+	bpf_mprog_entry_clear(peer);
+	peer->parent->count = 0;
+	*entry_new = peer;
+}
+
 static inline void bpf_mprog_entry_grow(struct bpf_mprog_entry *entry, int idx)
 {
 	int total = bpf_mprog_total(entry);
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 69a272712b29..13f0b5dc8262 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -94,15 +94,19 @@ int tcx_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
 
 void tcx_uninstall(struct net_device *dev, bool ingress)
 {
+	struct bpf_mprog_entry *entry, *entry_new = NULL;
 	struct bpf_tuple tuple = {};
-	struct bpf_mprog_entry *entry;
 	struct bpf_mprog_fp *fp;
 	struct bpf_mprog_cp *cp;
+	bool active;
 
 	entry = tcx_entry_fetch(dev, ingress);
 	if (!entry)
 		return;
-	tcx_entry_update(dev, NULL, ingress);
+	active = tcx_entry(entry)->miniq_active;
+	if (active)
+		bpf_mprog_clear_all(entry, &entry_new);
+	tcx_entry_update(dev, entry_new, ingress);
 	tcx_entry_sync();
 	bpf_mprog_foreach_tuple(entry, fp, cp, tuple) {
 		if (tuple.link)
@@ -111,8 +115,8 @@ void tcx_uninstall(struct net_device *dev, bool ingress)
 			bpf_prog_put(tuple.prog);
 		tcx_skeys_dec(ingress);
 	}
-	WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
-	tcx_entry_free(entry);
+	if (!active)
+		tcx_entry_free(entry);
 }
 
 int tcx_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
-- 
2.21.0


