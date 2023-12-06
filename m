Return-Path: <bpf+bounces-16923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637D5807899
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498A51C20F0B
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FDA6EB76;
	Wed,  6 Dec 2023 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMF0cV5R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272CED68;
	Wed,  6 Dec 2023 11:27:59 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91D2921DE2;
	Wed,  6 Dec 2023 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701890877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3rOG8tNDrz/UaTONHfRc+U+0BGGNGTWzhshWawNXhg=;
	b=oMF0cV5Rhta4SMfHiTrwLB7eI/pQqg5yr/1SOZQZ8OAC4jHOHVP/625pEYGBeNKblXXcpl
	uK/FwaYGNdV1lUmW5TRubeGPgrlD6KJBcXBhp6OlqCEqnKuK1JyJBA6Aa8G/YOq1ilbu8m
	JHRV0VUgMB3SrfmdFKI2Ye87lTCELPA=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BBEE13B6F;
	Wed,  6 Dec 2023 19:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aH+lCT3LcGUeYAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Wed, 06 Dec 2023 19:27:57 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cake@lists.bufferbloat.net
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Petr Pavlu <ppavlu@suse.cz>,
	Michal Kubecek <mkubecek@suse.cz>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH 3/3] net/sched: act: Load TC action modules via alias
Date: Wed,  6 Dec 2023 20:27:52 +0100
Message-ID: <20231206192752.18989-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231206192752.18989-1-mkoutny@suse.com>
References: <20231206192752.18989-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

The action modules may be loaded lazily without user's awareness and
control. Add respective aliases to modules and request them under these
aliases so that modprobe's blacklisting mechanism works also for
these modules. (The same pattern exists e.g. for filesystem
modules.)

Original module names remain unchanged.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/net/act_api.h      | 1 +
 net/sched/act_api.c        | 2 +-
 net/sched/act_bpf.c        | 1 +
 net/sched/act_connmark.c   | 1 +
 net/sched/act_csum.c       | 1 +
 net/sched/act_ct.c         | 1 +
 net/sched/act_ctinfo.c     | 1 +
 net/sched/act_gact.c       | 1 +
 net/sched/act_gate.c       | 1 +
 net/sched/act_ife.c        | 1 +
 net/sched/act_ipt.c        | 2 ++
 net/sched/act_mirred.c     | 1 +
 net/sched/act_mpls.c       | 1 +
 net/sched/act_nat.c        | 1 +
 net/sched/act_pedit.c      | 1 +
 net/sched/act_police.c     | 1 +
 net/sched/act_sample.c     | 1 +
 net/sched/act_simple.c     | 1 +
 net/sched/act_skbedit.c    | 1 +
 net/sched/act_skbmod.c     | 1 +
 net/sched/act_tunnel_key.c | 1 +
 net/sched/act_vlan.c       | 1 +
 22 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4ae0580b63ca..c8bd834f963f 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -200,6 +200,7 @@ int tcf_idr_release(struct tc_action *a, bool bind);
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
+#define MODULE_ALIAS_TCA(kind)	MODULE_ALIAS("tca-" __stringify(kind))
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c39252d61ebb..1775b3ad5200 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1331,7 +1331,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 #ifdef CONFIG_MODULES
 		if (rtnl_held)
 			rtnl_unlock();
-		request_module("act_%s", act_name);
+		request_module("tca-%s", act_name);
 		if (rtnl_held)
 			rtnl_lock();
 
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index b0455fda7d0b..76a4bbad3d0d 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -401,6 +401,7 @@ static struct tc_action_ops act_bpf_ops __read_mostly = {
 	.init		=	tcf_bpf_init,
 	.size		=	sizeof(struct tcf_bpf),
 };
+MODULE_ALIAS_TCA("bpf");
 
 static __net_init int bpf_init_net(struct net *net)
 {
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 0d7aee8933c5..3fed64024035 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -242,6 +242,7 @@ static struct tc_action_ops act_connmark_ops = {
 	.cleanup	=	tcf_connmark_cleanup,
 	.size		=	sizeof(struct tcf_connmark_info),
 };
+MODULE_ALIAS_TCA("connmark");
 
 static __net_init int connmark_init_net(struct net *net)
 {
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 8ed285023a40..6cb090a966ad 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -709,6 +709,7 @@ static struct tc_action_ops act_csum_ops = {
 	.offload_act_setup = tcf_csum_offload_act_setup,
 	.size		= sizeof(struct tcf_csum),
 };
+MODULE_ALIAS_TCA("csum");
 
 static __net_init int csum_init_net(struct net *net)
 {
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index b3f4a503ee2b..21e535fb3ab7 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1578,6 +1578,7 @@ static struct tc_action_ops act_ct_ops = {
 	.offload_act_setup =	tcf_ct_offload_act_setup,
 	.size		=	sizeof(struct tcf_ct),
 };
+MODULE_ALIAS_TCA("ct");
 
 static __net_init int ct_init_net(struct net *net)
 {
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 4d15b6a6169c..9fb55b9b79fe 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -363,6 +363,7 @@ static struct tc_action_ops act_ctinfo_ops = {
 	.cleanup= tcf_ctinfo_cleanup,
 	.size	= sizeof(struct tcf_ctinfo),
 };
+MODULE_ALIAS_TCA("ctinfo");
 
 static __net_init int ctinfo_init_net(struct net *net)
 {
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 904ab3d457ef..d69fc861854e 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -296,6 +296,7 @@ static struct tc_action_ops act_gact_ops = {
 	.offload_act_setup =	tcf_gact_offload_act_setup,
 	.size		=	sizeof(struct tcf_gact),
 };
+MODULE_ALIAS_TCA("gact");
 
 static __net_init int gact_init_net(struct net *net)
 {
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 393b78729216..4fdb293c71f5 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -645,6 +645,7 @@ static struct tc_action_ops act_gate_ops = {
 	.offload_act_setup =	tcf_gate_offload_act_setup,
 	.size		=	sizeof(struct tcf_gate),
 };
+MODULE_ALIAS_TCA("gate");
 
 static __net_init int gate_init_net(struct net *net)
 {
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index bc7611b0744c..44657978e2b0 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -889,6 +889,7 @@ static struct tc_action_ops act_ife_ops = {
 	.init = tcf_ife_init,
 	.size =	sizeof(struct tcf_ife_info),
 };
+MODULE_ALIAS_TCA("ife");
 
 static __net_init int ife_init_net(struct net *net)
 {
diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index 598d6e299152..d3b6a9a1d310 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -381,6 +381,7 @@ static struct tc_action_ops act_ipt_ops = {
 	.init		=	tcf_ipt_init,
 	.size		=	sizeof(struct tcf_ipt),
 };
+MODULE_ALIAS_TCA("ipt");
 
 static __net_init int ipt_init_net(struct net *net)
 {
@@ -411,6 +412,7 @@ static struct tc_action_ops act_xt_ops = {
 	.init		=	tcf_xt_init,
 	.size		=	sizeof(struct tcf_ipt),
 };
+MODULE_ALIAS_TCA("xt");
 
 static __net_init int xt_init_net(struct net *net)
 {
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 0a711c184c29..be98e3882cb2 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -505,6 +505,7 @@ static struct tc_action_ops act_mirred_ops = {
 	.size		=	sizeof(struct tcf_mirred),
 	.get_dev	=	tcf_mirred_get_dev,
 };
+MODULE_ALIAS_TCA("mirred");
 
 static __net_init int mirred_init_net(struct net *net)
 {
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 1010dc632874..2ac73889f826 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -452,6 +452,7 @@ static struct tc_action_ops act_mpls_ops = {
 	.offload_act_setup =	tcf_mpls_offload_act_setup,
 	.size		=	sizeof(struct tcf_mpls),
 };
+MODULE_ALIAS_TCA("mpls");
 
 static __net_init int mpls_init_net(struct net *net)
 {
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index 4184af5abbf3..7f5b0d5f53a3 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -324,6 +324,7 @@ static struct tc_action_ops act_nat_ops = {
 	.cleanup	=	tcf_nat_cleanup,
 	.size		=	sizeof(struct tcf_nat),
 };
+MODULE_ALIAS_TCA("nat");
 
 static __net_init int nat_init_net(struct net *net)
 {
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 1ef8fcfa9997..15902d378ceb 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -620,6 +620,7 @@ static struct tc_action_ops act_pedit_ops = {
 	.offload_act_setup =	tcf_pedit_offload_act_setup,
 	.size		=	sizeof(struct tcf_pedit),
 };
+MODULE_ALIAS_TCA("pedit");
 
 static __net_init int pedit_init_net(struct net *net)
 {
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index f3121c5a85e9..e386f326408f 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -502,6 +502,7 @@ static struct tc_action_ops act_police_ops = {
 	.offload_act_setup =	tcf_police_offload_act_setup,
 	.size		=	sizeof(struct tcf_police),
 };
+MODULE_ALIAS_TCA("police");
 
 static __net_init int police_init_net(struct net *net)
 {
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 4c670e7568dc..92ba9e0fc98d 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -316,6 +316,7 @@ static struct tc_action_ops act_sample_ops = {
 	.offload_act_setup    = tcf_sample_offload_act_setup,
 	.size	  = sizeof(struct tcf_sample),
 };
+MODULE_ALIAS_TCA("sample");
 
 static __net_init int sample_init_net(struct net *net)
 {
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index 4b84514534f3..61f06ad03e1c 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -209,6 +209,7 @@ static struct tc_action_ops act_simp_ops = {
 	.init		=	tcf_simp_init,
 	.size		=	sizeof(struct tcf_defact),
 };
+MODULE_ALIAS_TCA("simple");
 
 static __net_init int simp_init_net(struct net *net)
 {
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index ce7008cf291c..fb5c09ab6718 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -426,6 +426,7 @@ static struct tc_action_ops act_skbedit_ops = {
 	.offload_act_setup =	tcf_skbedit_offload_act_setup,
 	.size		=	sizeof(struct tcf_skbedit),
 };
+MODULE_ALIAS_TCA("skbedit");
 
 static __net_init int skbedit_init_net(struct net *net)
 {
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index dffa990a9629..468bc230d278 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -287,6 +287,7 @@ static struct tc_action_ops act_skbmod_ops = {
 	.cleanup	=	tcf_skbmod_cleanup,
 	.size		=	sizeof(struct tcf_skbmod),
 };
+MODULE_ALIAS_TCA("skbmod");
 
 static __net_init int skbmod_init_net(struct net *net)
 {
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 0c8aa7e686ea..43d3e250277f 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -842,6 +842,7 @@ static struct tc_action_ops act_tunnel_key_ops = {
 	.offload_act_setup =	tcf_tunnel_key_offload_act_setup,
 	.size		=	sizeof(struct tcf_tunnel_key),
 };
+MODULE_ALIAS_TCA("tunnel_key");
 
 static __net_init int tunnel_key_init_net(struct net *net)
 {
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 0251442f5f29..e7424ca0af95 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -427,6 +427,7 @@ static struct tc_action_ops act_vlan_ops = {
 	.offload_act_setup =	tcf_vlan_offload_act_setup,
 	.size		=	sizeof(struct tcf_vlan),
 };
+MODULE_ALIAS_TCA("vlan");
 
 static __net_init int vlan_init_net(struct net *net)
 {
-- 
2.42.1


