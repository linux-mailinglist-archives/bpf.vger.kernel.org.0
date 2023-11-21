Return-Path: <bpf+bounces-15567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124B87F3565
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19B7282970
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526665B20D;
	Tue, 21 Nov 2023 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Aa0nTlqo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD212C;
	Tue, 21 Nov 2023 09:56:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDBBF1F8B8;
	Tue, 21 Nov 2023 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700589403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BRUlXAJOlgJyfK030JbpQyqs8hbHXrZ60DaHyZm0foM=;
	b=Aa0nTlqoq8GQwGFbCKlcATI6TKWypBO1S8mLSDWoN1QWlYgPTnoZPEgKGgQeUdH/mNfxfL
	tOnDSnshswlu1ORBBjUaWdxvsCrXMNDjE9F6LYCTYnlPQiQMj01cvaFzhnOcBlXSZkNX9Z
	8qoKsMQvqPXf7OGRwxGPZYdTS0PB//0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9221C139FD;
	Tue, 21 Nov 2023 17:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id O3x5IlrvXGW1QAAAMHmgww
	(envelope-from <mkoutny@suse.com>); Tue, 21 Nov 2023 17:56:42 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Petr Pavlu <ppavlu@suse.cz>,
	Michal Kubecek <mkubecek@suse.cz>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH] net/sched: cls: Load net classifier modules via alias
Date: Tue, 21 Nov 2023 18:56:40 +0100
Message-ID: <20231121175640.9981-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,suse.cz,suse.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

The classifier modules may be loaded lazily without user's awareness and
control. Add respective aliases to modules and request them under these
aliases so that modprobe's blacklisting mechanism works also for
classifier modules. (The same pattern exists e.g. for filesystem
modules.)

Original module names remain unchanged.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/net/pkt_cls.h    | 1 +
 net/sched/cls_api.c      | 2 +-
 net/sched/cls_basic.c    | 1 +
 net/sched/cls_bpf.c      | 1 +
 net/sched/cls_cgroup.c   | 1 +
 net/sched/cls_flow.c     | 1 +
 net/sched/cls_flower.c   | 1 +
 net/sched/cls_fw.c       | 1 +
 net/sched/cls_matchall.c | 1 +
 net/sched/cls_route.c    | 1 +
 net/sched/cls_u32.c      | 1 +
 11 files changed, 11 insertions(+), 1 deletion(-)

This is primarily for TC subsystem maintainers where the
request_module() resides but Cc list is large because of touches in
various classifier modules.

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a76c9171db0e..424b4f889feb 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -24,6 +24,7 @@ struct tcf_walker {
 
 int register_tcf_proto_ops(struct tcf_proto_ops *ops);
 void unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
+#define MODULE_ALIAS_TCF(kind)	MODULE_ALIAS("tcf-" __stringify(kind))
 
 struct tcf_block_ext_info {
 	enum flow_block_binder_type binder_type;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..02fdcceee083 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -257,7 +257,7 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_held,
 #ifdef CONFIG_MODULES
 	if (rtnl_held)
 		rtnl_unlock();
-	request_module("cls_%s", kind);
+	request_module("tcf-%s", kind);
 	if (rtnl_held)
 		rtnl_lock();
 	ops = __tcf_proto_lookup_ops(kind);
diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index a1f56931330c..a3500ac7fc1a 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -328,6 +328,7 @@ static struct tcf_proto_ops cls_basic_ops __read_mostly = {
 	.bind_class	=	basic_bind_class,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_TCF("basic");
 
 static int __init init_basic(void)
 {
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 382c7a71f81f..8d57ac155c0c 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -693,6 +693,7 @@ static struct tcf_proto_ops cls_bpf_ops __read_mostly = {
 	.dump		=	cls_bpf_dump,
 	.bind_class	=	cls_bpf_bind_class,
 };
+MODULE_ALIAS_TCF("bpf");
 
 static int __init cls_bpf_init_mod(void)
 {
diff --git a/net/sched/cls_cgroup.c b/net/sched/cls_cgroup.c
index 7ee8dbf49ed0..0ded7d79894c 100644
--- a/net/sched/cls_cgroup.c
+++ b/net/sched/cls_cgroup.c
@@ -209,6 +209,7 @@ static struct tcf_proto_ops cls_cgroup_ops __read_mostly = {
 	.dump		=	cls_cgroup_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_TCF("cgroup");
 
 static int __init init_cgroup_cls(void)
 {
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 6ab317b48d6c..2806aa1254e1 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -702,6 +702,7 @@ static struct tcf_proto_ops cls_flow_ops __read_mostly = {
 	.walk		= flow_walk,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_TCF("flow");
 
 static int __init cls_flow_init(void)
 {
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e5314a31f75a..739e09e0fa57 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -3633,6 +3633,7 @@ static struct tcf_proto_ops cls_fl_ops __read_mostly = {
 	.owner		= THIS_MODULE,
 	.flags		= TCF_PROTO_OPS_DOIT_UNLOCKED,
 };
+MODULE_ALIAS_TCF("flower");
 
 static int __init cls_fl_init(void)
 {
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index afc534ee0a18..86c833885a2d 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -433,6 +433,7 @@ static struct tcf_proto_ops cls_fw_ops __read_mostly = {
 	.bind_class	=	fw_bind_class,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_TCF("fw");
 
 static int __init init_fw(void)
 {
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index c4ed11df6254..21ba73978c6a 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -398,6 +398,7 @@ static struct tcf_proto_ops cls_mall_ops __read_mostly = {
 	.bind_class	= mall_bind_class,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_TCF("matchall");
 
 static int __init cls_mall_init(void)
 {
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 12a505db4183..a4701c0752df 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -671,6 +671,7 @@ static struct tcf_proto_ops cls_route4_ops __read_mostly = {
 	.bind_class	=	route4_bind_class,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_TCF("route");
 
 static int __init init_route4(void)
 {
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d5bdfd4a7655..a969adbd7423 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1453,6 +1453,7 @@ static struct tcf_proto_ops cls_u32_ops __read_mostly = {
 	.bind_class	=	u32_bind_class,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_TCF("u32");
 
 static int __init init_u32(void)
 {
-- 
2.42.1


