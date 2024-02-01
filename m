Return-Path: <bpf+bounces-20955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10250845884
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 14:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343751C25E1F
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D25B69C;
	Thu,  1 Feb 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UHamsDf+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UHamsDf+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11295336C;
	Thu,  1 Feb 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792990; cv=none; b=JbxRxz1xwWsAaqQ7xBT8YP5zOIFIhlOlSLb3z0z0oC2OEJdhzQ30Gk90VxYEys5iwLjIe5nhP/jVTgobU55zYrB4LjV01gEGDJhHxBUayuxCRdNI5RV45SZ4OgzATTchg+raRqsNHdzl9fwXAu82uaPi35qHC+GGuM3cBEhKEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792990; c=relaxed/simple;
	bh=cerl1rPrcB/dcUlmRzttt9gkPM6FJ69hpc2y+1wE1Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QecxzeWwJvMMhoicFwzHGt9kmj4BEKOMmAGUwKbgbjsE/57l5hjxKacz7qAjUTxrO/R9lvRprRaMoM17oAFa7qNtrtz/CTk+LZ41icKxXwOrwq2bakoGwVMHz5ik6s6SbG/8I/KE84vEh5SmldjRO+Wph5SmOAZOq3YXs+G17/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UHamsDf+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UHamsDf+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D13FA1FBB9;
	Thu,  1 Feb 2024 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706792985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgzpZSm/dXn0Nv43ktIqR2rcq+FLIurz6bw9cpTMD+E=;
	b=UHamsDf+BS+IfoM/6+OXdTHm8GYIHi21F30iG9SogcKi1T/GM86AwyvTi7J0V81ALiPh8b
	BeG9fq7VzdxAFmSWgbNTbbSA3I1IFPyWGqlzBtg/L1pDmuVy06ethckibnz8O80uJ/sGwX
	utapudG4p/TUzcmUlnNjVCrultZU3mc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706792985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgzpZSm/dXn0Nv43ktIqR2rcq+FLIurz6bw9cpTMD+E=;
	b=UHamsDf+BS+IfoM/6+OXdTHm8GYIHi21F30iG9SogcKi1T/GM86AwyvTi7J0V81ALiPh8b
	BeG9fq7VzdxAFmSWgbNTbbSA3I1IFPyWGqlzBtg/L1pDmuVy06ethckibnz8O80uJ/sGwX
	utapudG4p/TUzcmUlnNjVCrultZU3mc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C6D139FF;
	Thu,  1 Feb 2024 13:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2J8WKxmYu2VafgAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Thu, 01 Feb 2024 13:09:45 +0000
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
	Eduard Zingerman <eddyz87@gmail.com>,
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
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH v5 2/4] net/sched: Add module aliases for cls_,sch_,act_ modules
Date: Thu,  1 Feb 2024 14:09:41 +0100
Message-ID: <20240201130943.19536-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201130943.19536-1-mkoutny@suse.com>
References: <20240201130943.19536-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UHamsDf+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLogq4uai3psdy7gygdsfysmzr)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: D13FA1FBB9
X-Spam-Flag: NO

No functional change intended, aliases will be used in followup commits.
Note for backporters: you may need to add aliases also for modules that
are already removed in mainline kernel but still in your version.

Patches were generated with the help of Coccinelle scripts like:

cat >scripts/coccinelle/misc/tcf_alias.cocci <<EOD
virtual patch
virtual report

@ haskernel @
@@

@ tcf_has_kind depends on report && haskernel @
identifier ops;
constant K;
@@

  static struct tcf_proto_ops ops = {
    .kind = K,
    ...
  };
+char module_alias = K;
EOD

/usr/bin/spatch -D report --cocci-file scripts/coccinelle/misc/tcf_alias.cocci \
        --dir . \
        -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include \
        -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi \
        -I ./include/uapi -I ./include/generated/uapi \
        --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h \
        --jobs 8 --chunksize 1 2>/dev/null | \
        sed 's/char module_alias = "\([^"]*\)";/MODULE_ALIAS_NET_CLS("\1");/'

And analogously for:

  static struct tc_action_ops ops = {
    .kind = K,

  static struct Qdisc_ops ops = {
    .id = K,

(Someone familiar would be able to fit those into one .cocci file
without sed post processing.)

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/sched/act_bpf.c        | 1 +
 net/sched/act_connmark.c   | 1 +
 net/sched/act_csum.c       | 1 +
 net/sched/act_ct.c         | 1 +
 net/sched/act_ctinfo.c     | 1 +
 net/sched/act_gact.c       | 1 +
 net/sched/act_gate.c       | 1 +
 net/sched/act_ife.c        | 1 +
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
 net/sched/cls_basic.c      | 1 +
 net/sched/cls_bpf.c        | 1 +
 net/sched/cls_cgroup.c     | 1 +
 net/sched/cls_flow.c       | 1 +
 net/sched/cls_flower.c     | 1 +
 net/sched/cls_fw.c         | 1 +
 net/sched/cls_matchall.c   | 1 +
 net/sched/cls_route.c      | 1 +
 net/sched/cls_u32.c        | 1 +
 net/sched/sch_cake.c       | 1 +
 net/sched/sch_cbs.c        | 1 +
 net/sched/sch_choke.c      | 1 +
 net/sched/sch_codel.c      | 1 +
 net/sched/sch_drr.c        | 1 +
 net/sched/sch_etf.c        | 1 +
 net/sched/sch_ets.c        | 1 +
 net/sched/sch_fq.c         | 1 +
 net/sched/sch_fq_codel.c   | 1 +
 net/sched/sch_gred.c       | 1 +
 net/sched/sch_hfsc.c       | 1 +
 net/sched/sch_hhf.c        | 1 +
 net/sched/sch_htb.c        | 1 +
 net/sched/sch_ingress.c    | 2 ++
 net/sched/sch_mqprio.c     | 1 +
 net/sched/sch_multiq.c     | 1 +
 net/sched/sch_netem.c      | 1 +
 net/sched/sch_pie.c        | 1 +
 net/sched/sch_plug.c       | 1 +
 net/sched/sch_prio.c       | 1 +
 net/sched/sch_qfq.c        | 1 +
 net/sched/sch_red.c        | 1 +
 net/sched/sch_sfb.c        | 1 +
 net/sched/sch_sfq.c        | 1 +
 net/sched/sch_skbprio.c    | 1 +
 net/sched/sch_taprio.c     | 1 +
 net/sched/sch_tbf.c        | 1 +
 55 files changed, 56 insertions(+)

diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 6cfee6658103..0e3cf11ae5fc 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -401,6 +401,7 @@ static struct tc_action_ops act_bpf_ops __read_mostly = {
 	.init		=	tcf_bpf_init,
 	.size		=	sizeof(struct tcf_bpf),
 };
+MODULE_ALIAS_NET_ACT("bpf");
 
 static __net_init int bpf_init_net(struct net *net)
 {
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index f8762756657d..0fce631e7c91 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -242,6 +242,7 @@ static struct tc_action_ops act_connmark_ops = {
 	.cleanup	=	tcf_connmark_cleanup,
 	.size		=	sizeof(struct tcf_connmark_info),
 };
+MODULE_ALIAS_NET_ACT("connmark");
 
 static __net_init int connmark_init_net(struct net *net)
 {
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 7f8b1f2f2ed9..5cc8e407e791 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -709,6 +709,7 @@ static struct tc_action_ops act_csum_ops = {
 	.offload_act_setup = tcf_csum_offload_act_setup,
 	.size		= sizeof(struct tcf_csum),
 };
+MODULE_ALIAS_NET_ACT("csum");
 
 static __net_init int csum_init_net(struct net *net)
 {
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 6124d8b128d1..baac083fd8f1 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1600,6 +1600,7 @@ static struct tc_action_ops act_ct_ops = {
 	.offload_act_setup =	tcf_ct_offload_act_setup,
 	.size		=	sizeof(struct tcf_ct),
 };
+MODULE_ALIAS_NET_ACT("ct");
 
 static __net_init int ct_init_net(struct net *net)
 {
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index e620f9a84afe..5dd41a012110 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -363,6 +363,7 @@ static struct tc_action_ops act_ctinfo_ops = {
 	.cleanup= tcf_ctinfo_cleanup,
 	.size	= sizeof(struct tcf_ctinfo),
 };
+MODULE_ALIAS_NET_ACT("ctinfo");
 
 static __net_init int ctinfo_init_net(struct net *net)
 {
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 4af3b7ec249f..e949280eb800 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -296,6 +296,7 @@ static struct tc_action_ops act_gact_ops = {
 	.offload_act_setup =	tcf_gact_offload_act_setup,
 	.size		=	sizeof(struct tcf_gact),
 };
+MODULE_ALIAS_NET_ACT("gact");
 
 static __net_init int gact_init_net(struct net *net)
 {
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c681cd011afd..1dd74125398a 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -645,6 +645,7 @@ static struct tc_action_ops act_gate_ops = {
 	.offload_act_setup =	tcf_gate_offload_act_setup,
 	.size		=	sizeof(struct tcf_gate),
 };
+MODULE_ALIAS_NET_ACT("gate");
 
 static __net_init int gate_init_net(struct net *net)
 {
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 0e867d13beb5..107c6d83dc5c 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -889,6 +889,7 @@ static struct tc_action_ops act_ife_ops = {
 	.init = tcf_ife_init,
 	.size =	sizeof(struct tcf_ife_info),
 };
+MODULE_ALIAS_NET_ACT("ife");
 
 static __net_init int ife_init_net(struct net *net)
 {
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 12386f590b0f..93a96e9d8d90 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -643,6 +643,7 @@ static struct tc_action_ops act_mirred_ops = {
 	.size		=	sizeof(struct tcf_mirred),
 	.get_dev	=	tcf_mirred_get_dev,
 };
+MODULE_ALIAS_NET_ACT("mirred");
 
 static __net_init int mirred_init_net(struct net *net)
 {
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 34b8edb6cc77..44a37a71ae92 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -452,6 +452,7 @@ static struct tc_action_ops act_mpls_ops = {
 	.offload_act_setup =	tcf_mpls_offload_act_setup,
 	.size		=	sizeof(struct tcf_mpls),
 };
+MODULE_ALIAS_NET_ACT("mpls");
 
 static __net_init int mpls_init_net(struct net *net)
 {
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index a180e724634e..d541f553805f 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -324,6 +324,7 @@ static struct tc_action_ops act_nat_ops = {
 	.cleanup	=	tcf_nat_cleanup,
 	.size		=	sizeof(struct tcf_nat),
 };
+MODULE_ALIAS_NET_ACT("nat");
 
 static __net_init int nat_init_net(struct net *net)
 {
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 2ef22969f274..df5a02d5f919 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -620,6 +620,7 @@ static struct tc_action_ops act_pedit_ops = {
 	.offload_act_setup =	tcf_pedit_offload_act_setup,
 	.size		=	sizeof(struct tcf_pedit),
 };
+MODULE_ALIAS_NET_ACT("pedit");
 
 static __net_init int pedit_init_net(struct net *net)
 {
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index e119b4a3db9f..8555125ed34d 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -502,6 +502,7 @@ static struct tc_action_ops act_police_ops = {
 	.offload_act_setup =	tcf_police_offload_act_setup,
 	.size		=	sizeof(struct tcf_police),
 };
+MODULE_ALIAS_NET_ACT("police");
 
 static __net_init int police_init_net(struct net *net)
 {
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index c5c61efe6db4..a69b53d54039 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -316,6 +316,7 @@ static struct tc_action_ops act_sample_ops = {
 	.offload_act_setup    = tcf_sample_offload_act_setup,
 	.size	  = sizeof(struct tcf_sample),
 };
+MODULE_ALIAS_NET_ACT("sample");
 
 static __net_init int sample_init_net(struct net *net)
 {
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index 0a3e92888295..f3abe0545989 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -209,6 +209,7 @@ static struct tc_action_ops act_simp_ops = {
 	.init		=	tcf_simp_init,
 	.size		=	sizeof(struct tcf_defact),
 };
+MODULE_ALIAS_NET_ACT("simple");
 
 static __net_init int simp_init_net(struct net *net)
 {
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 754f78b35bb8..1f1d9ce3e968 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -426,6 +426,7 @@ static struct tc_action_ops act_skbedit_ops = {
 	.offload_act_setup =	tcf_skbedit_offload_act_setup,
 	.size		=	sizeof(struct tcf_skbedit),
 };
+MODULE_ALIAS_NET_ACT("skbedit");
 
 static __net_init int skbedit_init_net(struct net *net)
 {
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index bcb673ab0008..39945b139c48 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -287,6 +287,7 @@ static struct tc_action_ops act_skbmod_ops = {
 	.cleanup	=	tcf_skbmod_cleanup,
 	.size		=	sizeof(struct tcf_skbmod),
 };
+MODULE_ALIAS_NET_ACT("skbmod");
 
 static __net_init int skbmod_init_net(struct net *net)
 {
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 300b08aa8283..1536f8b16f1b 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -842,6 +842,7 @@ static struct tc_action_ops act_tunnel_key_ops = {
 	.offload_act_setup =	tcf_tunnel_key_offload_act_setup,
 	.size		=	sizeof(struct tcf_tunnel_key),
 };
+MODULE_ALIAS_NET_ACT("tunnel_key");
 
 static __net_init int tunnel_key_init_net(struct net *net)
 {
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 836183011a7c..22f4b1e8ade9 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -427,6 +427,7 @@ static struct tc_action_ops act_vlan_ops = {
 	.offload_act_setup =	tcf_vlan_offload_act_setup,
 	.size		=	sizeof(struct tcf_vlan),
 };
+MODULE_ALIAS_NET_ACT("vlan");
 
 static __net_init int vlan_init_net(struct net *net)
 {
diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index a1f56931330c..ecfaa4f9a04e 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -328,6 +328,7 @@ static struct tcf_proto_ops cls_basic_ops __read_mostly = {
 	.bind_class	=	basic_bind_class,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_CLS("basic");
 
 static int __init init_basic(void)
 {
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 382c7a71f81f..5e83e890f6a4 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -693,6 +693,7 @@ static struct tcf_proto_ops cls_bpf_ops __read_mostly = {
 	.dump		=	cls_bpf_dump,
 	.bind_class	=	cls_bpf_bind_class,
 };
+MODULE_ALIAS_NET_CLS("bpf");
 
 static int __init cls_bpf_init_mod(void)
 {
diff --git a/net/sched/cls_cgroup.c b/net/sched/cls_cgroup.c
index 7ee8dbf49ed0..424252982d6a 100644
--- a/net/sched/cls_cgroup.c
+++ b/net/sched/cls_cgroup.c
@@ -209,6 +209,7 @@ static struct tcf_proto_ops cls_cgroup_ops __read_mostly = {
 	.dump		=	cls_cgroup_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_CLS("cgroup");
 
 static int __init init_cgroup_cls(void)
 {
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 6ab317b48d6c..5502998aace7 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -702,6 +702,7 @@ static struct tcf_proto_ops cls_flow_ops __read_mostly = {
 	.walk		= flow_walk,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_CLS("flow");
 
 static int __init cls_flow_init(void)
 {
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index efb9d2811b73..bfedc3d4423d 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -3656,6 +3656,7 @@ static struct tcf_proto_ops cls_fl_ops __read_mostly = {
 	.owner		= THIS_MODULE,
 	.flags		= TCF_PROTO_OPS_DOIT_UNLOCKED,
 };
+MODULE_ALIAS_NET_CLS("flower");
 
 static int __init cls_fl_init(void)
 {
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index afc534ee0a18..cdddc8695228 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -433,6 +433,7 @@ static struct tcf_proto_ops cls_fw_ops __read_mostly = {
 	.bind_class	=	fw_bind_class,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_CLS("fw");
 
 static int __init init_fw(void)
 {
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index c4ed11df6254..9f1e62ca508d 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -398,6 +398,7 @@ static struct tcf_proto_ops cls_mall_ops __read_mostly = {
 	.bind_class	= mall_bind_class,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_CLS("matchall");
 
 static int __init cls_mall_init(void)
 {
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 12a505db4183..b9c58c040c30 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -671,6 +671,7 @@ static struct tcf_proto_ops cls_route4_ops __read_mostly = {
 	.bind_class	=	route4_bind_class,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_CLS("route");
 
 static int __init init_route4(void)
 {
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 289e1755c26b..9412d88a99bc 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1453,6 +1453,7 @@ static struct tcf_proto_ops cls_u32_ops __read_mostly = {
 	.bind_class	=	u32_bind_class,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_CLS("u32");
 
 static int __init init_u32(void)
 {
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9cff99558694..edee926ccde8 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3103,6 +3103,7 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
 	.dump_stats	=	cake_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("cake");
 
 static int __init cake_module_init(void)
 {
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index beece8e82c23..69001eff0315 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -546,6 +546,7 @@ static struct Qdisc_ops cbs_qdisc_ops __read_mostly = {
 	.dump		=	cbs_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("cbs");
 
 static struct notifier_block cbs_device_notifier = {
 	.notifier_call = cbs_dev_notifier,
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index ae1da08e268f..ea108030c6b4 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -498,6 +498,7 @@ static struct Qdisc_ops choke_qdisc_ops __read_mostly = {
 	.dump_stats	=	choke_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("choke");
 
 static int __init choke_module_init(void)
 {
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index d7a4874543de..61904d3a593b 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -287,6 +287,7 @@ static struct Qdisc_ops codel_qdisc_ops __read_mostly = {
 	.dump_stats	=	codel_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("codel");
 
 static int __init codel_module_init(void)
 {
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 097740a9afea..c69b999fae17 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -481,6 +481,7 @@ static struct Qdisc_ops drr_qdisc_ops __read_mostly = {
 	.destroy	= drr_destroy_qdisc,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("drr");
 
 static int __init drr_init(void)
 {
diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index 4808159a5466..2e4bef713b6a 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -500,6 +500,7 @@ static struct Qdisc_ops etf_qdisc_ops __read_mostly = {
 	.dump		=	etf_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("etf");
 
 static int __init etf_module_init(void)
 {
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index f7c88495946b..835b4460b448 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -812,6 +812,7 @@ static struct Qdisc_ops ets_qdisc_ops __read_mostly = {
 	.dump		= ets_qdisc_dump,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("ets");
 
 static int __init ets_init(void)
 {
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 3a31c47fea9b..cdf23ff16f40 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1264,6 +1264,7 @@ static struct Qdisc_ops fq_qdisc_ops __read_mostly = {
 	.dump_stats	=	fq_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("fq");
 
 static int __init fq_module_init(void)
 {
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 8c4fee063436..79f9d6de6c85 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -717,6 +717,7 @@ static struct Qdisc_ops fq_codel_qdisc_ops __read_mostly = {
 	.dump_stats =	fq_codel_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("fq_codel");
 
 static int __init fq_codel_module_init(void)
 {
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 8c61eb3dc943..79ba9dc70254 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -930,6 +930,7 @@ static struct Qdisc_ops gred_qdisc_ops __read_mostly = {
 	.dump		=	gred_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("gred");
 
 static int __init gred_module_init(void)
 {
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 16c45da4036a..4e626df742d7 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1679,6 +1679,7 @@ static struct Qdisc_ops hfsc_qdisc_ops __read_mostly = {
 	.priv_size	= sizeof(struct hfsc_sched),
 	.owner		= THIS_MODULE
 };
+MODULE_ALIAS_NET_SCH("hfsc");
 
 static int __init
 hfsc_init(void)
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index d26cd436cbe3..3f906df1435b 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -702,6 +702,7 @@ static struct Qdisc_ops hhf_qdisc_ops __read_mostly = {
 	.dump_stats	=	hhf_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("hhf");
 
 static int __init hhf_module_init(void)
 {
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 7349233eaa9b..93e6fb56f3b5 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -2166,6 +2166,7 @@ static struct Qdisc_ops htb_qdisc_ops __read_mostly = {
 	.dump		=	htb_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("htb");
 
 static int __init htb_module_init(void)
 {
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index 5fa9eaa79bfc..48a800131e99 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -168,6 +168,7 @@ static struct Qdisc_ops ingress_qdisc_ops __read_mostly = {
 	.ingress_block_get	=	ingress_ingress_block_get,
 	.owner			=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("ingress");
 
 struct clsact_sched_data {
 	struct tcf_block *ingress_block;
@@ -344,6 +345,7 @@ static struct Qdisc_ops clsact_qdisc_ops __read_mostly = {
 	.egress_block_get	=	clsact_egress_block_get,
 	.owner			=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("clsact");
 
 static int __init ingress_module_init(void)
 {
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 43e53ee00a56..225353fbb3f1 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -774,6 +774,7 @@ static struct Qdisc_ops mqprio_qdisc_ops __read_mostly = {
 	.dump		= mqprio_dump,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("mqprio");
 
 static int __init mqprio_module_init(void)
 {
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index d66d5f0ec080..79e93a19d5fa 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -395,6 +395,7 @@ static struct Qdisc_ops multiq_qdisc_ops __read_mostly = {
 	.dump		=	multiq_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("multiq");
 
 static int __init multiq_module_init(void)
 {
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fa678eb88528..edc72962ae63 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1293,6 +1293,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.dump		=	netem_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("netem");
 
 
 static int __init netem_module_init(void)
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 2da6250ec346..1764059b0635 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -556,6 +556,7 @@ static struct Qdisc_ops pie_qdisc_ops __read_mostly = {
 	.dump_stats	= pie_dump_stats,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("pie");
 
 static int __init pie_module_init(void)
 {
diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index 992f0c8d7988..cefb65201e17 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -213,6 +213,7 @@ static struct Qdisc_ops plug_qdisc_ops __read_mostly = {
 	.reset       =	     qdisc_reset_queue,
 	.owner       =       THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("plug");
 
 static int __init plug_module_init(void)
 {
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 8ecdd3ef6f8e..cc30f7a32f1a 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -418,6 +418,7 @@ static struct Qdisc_ops prio_qdisc_ops __read_mostly = {
 	.dump		=	prio_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("prio");
 
 static int __init prio_module_init(void)
 {
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 48a604c320c7..d584c0c25899 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1521,6 +1521,7 @@ static struct Qdisc_ops qfq_qdisc_ops __read_mostly = {
 	.destroy	= qfq_destroy_qdisc,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("qfq");
 
 static int __init qfq_init(void)
 {
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 607b6c8b3a9b..b5f096588fae 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -548,6 +548,7 @@ static struct Qdisc_ops red_qdisc_ops __read_mostly = {
 	.dump_stats	=	red_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("red");
 
 static int __init red_module_init(void)
 {
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 1871a1c0224d..b717e15a3a17 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -709,6 +709,7 @@ static struct Qdisc_ops sfb_qdisc_ops __read_mostly = {
 	.dump_stats	=	sfb_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("sfb");
 
 static int __init sfb_module_init(void)
 {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index eb77558fa367..e66f4afb920d 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -925,6 +925,7 @@ static struct Qdisc_ops sfq_qdisc_ops __read_mostly = {
 	.dump		=	sfq_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("sfq");
 
 static int __init sfq_module_init(void)
 {
diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index 28beb11762d8..b4dd626c309c 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -292,6 +292,7 @@ static struct Qdisc_ops skbprio_qdisc_ops __read_mostly = {
 	.destroy	=	skbprio_destroy,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("skbprio");
 
 static int __init skbprio_module_init(void)
 {
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 827cb683efbf..c5de70efdc86 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2528,6 +2528,7 @@ static struct Qdisc_ops taprio_qdisc_ops __read_mostly = {
 	.dump_stats	= taprio_dump_stats,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("taprio");
 
 static struct notifier_block taprio_device_notifier = {
 	.notifier_call = taprio_dev_notifier,
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index dd6b1a723bf7..f1d09183ae63 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -608,6 +608,7 @@ static struct Qdisc_ops tbf_qdisc_ops __read_mostly = {
 	.dump		=	tbf_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("tbf");
 
 static int __init tbf_module_init(void)
 {
-- 
2.43.0


