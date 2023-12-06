Return-Path: <bpf+bounces-16922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A0807896
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 20:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18001C20F5C
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CCD6DCFE;
	Wed,  6 Dec 2023 19:28:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F51D67;
	Wed,  6 Dec 2023 11:27:58 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2667221DE0;
	Wed,  6 Dec 2023 19:27:57 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5895513403;
	Wed,  6 Dec 2023 19:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wDzMEzzLcGUeYAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Wed, 06 Dec 2023 19:27:56 +0000
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
Subject: [PATCH 2/3] net/sched: sch: Load qdisc modules via alias
Date: Wed,  6 Dec 2023 20:27:51 +0100
Message-ID: <20231206192752.18989-3-mkoutny@suse.com>
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
X-Rspamd-Queue-Id: 2667221DE0
X-Spam-Score: 15.00
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 BAYES_HAM(-3.00)[100.00%];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out1.suse.de: domain of mkoutny@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=mkoutny@suse.com
X-Rspamd-Server: rspamd1
X-Spam: Yes

The qdisc modules may be loaded lazily without user's awareness and
control. Add respective aliases to modules and request them under these
aliases so that modprobe's blacklisting mechanism works also for
these modules. (The same pattern exists e.g. for filesystem
modules.)

Original module names remain unchanged.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/net/pkt_sched.h  | 1 +
 net/sched/sch_api.c      | 2 +-
 net/sched/sch_cake.c     | 1 +
 net/sched/sch_cbs.c      | 1 +
 net/sched/sch_choke.c    | 1 +
 net/sched/sch_codel.c    | 1 +
 net/sched/sch_drr.c      | 1 +
 net/sched/sch_etf.c      | 1 +
 net/sched/sch_ets.c      | 1 +
 net/sched/sch_fq.c       | 1 +
 net/sched/sch_fq_codel.c | 1 +
 net/sched/sch_gred.c     | 1 +
 net/sched/sch_hfsc.c     | 1 +
 net/sched/sch_hhf.c      | 1 +
 net/sched/sch_htb.c      | 1 +
 net/sched/sch_ingress.c  | 2 ++
 net/sched/sch_mqprio.c   | 1 +
 net/sched/sch_multiq.c   | 1 +
 net/sched/sch_netem.c    | 1 +
 net/sched/sch_pie.c      | 1 +
 net/sched/sch_plug.c     | 1 +
 net/sched/sch_prio.c     | 1 +
 net/sched/sch_qfq.c      | 1 +
 net/sched/sch_red.c      | 1 +
 net/sched/sch_sfb.c      | 1 +
 net/sched/sch_sfq.c      | 1 +
 net/sched/sch_skbprio.c  | 1 +
 net/sched/sch_taprio.c   | 1 +
 net/sched/sch_tbf.c      | 1 +
 29 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9fa1d0794dfa..cfa1b58bf7ec 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -100,6 +100,7 @@ struct Qdisc *fifo_create_dflt(struct Qdisc *sch, struct Qdisc_ops *ops,
 
 int register_qdisc(struct Qdisc_ops *qops);
 void unregister_qdisc(struct Qdisc_ops *qops);
+#define MODULE_ALIAS_QD(id)	MODULE_ALIAS("qd-" __stringify(id))
 void qdisc_get_default(char *id, size_t len);
 int qdisc_set_default(const char *id);
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e9eaf637220e..c822eda7d331 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1246,7 +1246,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			 * go away in the mean time.
 			 */
 			rtnl_unlock();
-			request_module("sch_%s", name);
+			request_module("qd-%s", name);
 			rtnl_lock();
 			ops = qdisc_lookup_ops(kind);
 			if (ops != NULL) {
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9cff99558694..7b5f2c64a90d 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3103,6 +3103,7 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
 	.dump_stats	=	cake_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("cake");
 
 static int __init cake_module_init(void)
 {
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 9a0b85190a2c..c640b55145b7 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -546,6 +546,7 @@ static struct Qdisc_ops cbs_qdisc_ops __read_mostly = {
 	.dump		=	cbs_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("cbs");
 
 static struct notifier_block cbs_device_notifier = {
 	.notifier_call = cbs_dev_notifier,
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index ae1da08e268f..684a4c0c06ef 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -498,6 +498,7 @@ static struct Qdisc_ops choke_qdisc_ops __read_mostly = {
 	.dump_stats	=	choke_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("choke");
 
 static int __init choke_module_init(void)
 {
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index d7a4874543de..8694a45dd659 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -287,6 +287,7 @@ static struct Qdisc_ops codel_qdisc_ops __read_mostly = {
 	.dump_stats	=	codel_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("codel");
 
 static int __init codel_module_init(void)
 {
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 097740a9afea..271672fbbb8c 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -481,6 +481,7 @@ static struct Qdisc_ops drr_qdisc_ops __read_mostly = {
 	.destroy	= drr_destroy_qdisc,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_QD("drr");
 
 static int __init drr_init(void)
 {
diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index 4808159a5466..291a60968ec0 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -500,6 +500,7 @@ static struct Qdisc_ops etf_qdisc_ops __read_mostly = {
 	.dump		=	etf_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("etf");
 
 static int __init etf_module_init(void)
 {
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index f7c88495946b..c386359930ac 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -812,6 +812,7 @@ static struct Qdisc_ops ets_qdisc_ops __read_mostly = {
 	.dump		= ets_qdisc_dump,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_QD("ets");
 
 static int __init ets_init(void)
 {
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 3a31c47fea9b..91f735aec93d 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1264,6 +1264,7 @@ static struct Qdisc_ops fq_qdisc_ops __read_mostly = {
 	.dump_stats	=	fq_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("fq");
 
 static int __init fq_module_init(void)
 {
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 8c4fee063436..63e15c29e740 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -717,6 +717,7 @@ static struct Qdisc_ops fq_codel_qdisc_ops __read_mostly = {
 	.dump_stats =	fq_codel_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("fq_codel");
 
 static int __init fq_codel_module_init(void)
 {
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 8c61eb3dc943..a405fa2f44ee 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -930,6 +930,7 @@ static struct Qdisc_ops gred_qdisc_ops __read_mostly = {
 	.dump		=	gred_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("gred");
 
 static int __init gred_module_init(void)
 {
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 16c45da4036a..505d3cf3be7c 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1679,6 +1679,7 @@ static struct Qdisc_ops hfsc_qdisc_ops __read_mostly = {
 	.priv_size	= sizeof(struct hfsc_sched),
 	.owner		= THIS_MODULE
 };
+MODULE_ALIAS_QD("hfsc");
 
 static int __init
 hfsc_init(void)
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index d26cd436cbe3..c5eb6c460141 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -702,6 +702,7 @@ static struct Qdisc_ops hhf_qdisc_ops __read_mostly = {
 	.dump_stats	=	hhf_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("hhf");
 
 static int __init hhf_module_init(void)
 {
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 7349233eaa9b..aa869443ba58 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -2166,6 +2166,7 @@ static struct Qdisc_ops htb_qdisc_ops __read_mostly = {
 	.dump		=	htb_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("htb");
 
 static int __init htb_module_init(void)
 {
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index 5fa9eaa79bfc..b29cae932a09 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -168,6 +168,7 @@ static struct Qdisc_ops ingress_qdisc_ops __read_mostly = {
 	.ingress_block_get	=	ingress_ingress_block_get,
 	.owner			=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("ingress");
 
 struct clsact_sched_data {
 	struct tcf_block *ingress_block;
@@ -344,6 +345,7 @@ static struct Qdisc_ops clsact_qdisc_ops __read_mostly = {
 	.egress_block_get	=	clsact_egress_block_get,
 	.owner			=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("clsact");
 
 static int __init ingress_module_init(void)
 {
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 43e53ee00a56..3cc0dd80d8d3 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -774,6 +774,7 @@ static struct Qdisc_ops mqprio_qdisc_ops __read_mostly = {
 	.dump		= mqprio_dump,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_QD("mqprio");
 
 static int __init mqprio_module_init(void)
 {
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index d66d5f0ec080..8fb642710c2b 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -395,6 +395,7 @@ static struct Qdisc_ops multiq_qdisc_ops __read_mostly = {
 	.dump		=	multiq_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("multiq");
 
 static int __init multiq_module_init(void)
 {
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fa678eb88528..f6757227ab4c 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1293,6 +1293,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.dump		=	netem_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("netem");
 
 
 static int __init netem_module_init(void)
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 2da6250ec346..897cfec42231 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -556,6 +556,7 @@ static struct Qdisc_ops pie_qdisc_ops __read_mostly = {
 	.dump_stats	= pie_dump_stats,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_QD("pie");
 
 static int __init pie_module_init(void)
 {
diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index 992f0c8d7988..9e33f638a85d 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -213,6 +213,7 @@ static struct Qdisc_ops plug_qdisc_ops __read_mostly = {
 	.reset       =	     qdisc_reset_queue,
 	.owner       =       THIS_MODULE,
 };
+MODULE_ALIAS_QD("plug");
 
 static int __init plug_module_init(void)
 {
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 8ecdd3ef6f8e..319c7e01cf31 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -418,6 +418,7 @@ static struct Qdisc_ops prio_qdisc_ops __read_mostly = {
 	.dump		=	prio_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("prio");
 
 static int __init prio_module_init(void)
 {
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 48a604c320c7..1cb67c68071a 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1521,6 +1521,7 @@ static struct Qdisc_ops qfq_qdisc_ops __read_mostly = {
 	.destroy	= qfq_destroy_qdisc,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_QD("qfq");
 
 static int __init qfq_init(void)
 {
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 607b6c8b3a9b..1bf42089b081 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -548,6 +548,7 @@ static struct Qdisc_ops red_qdisc_ops __read_mostly = {
 	.dump_stats	=	red_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("red");
 
 static int __init red_module_init(void)
 {
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 1871a1c0224d..5d43a105b351 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -709,6 +709,7 @@ static struct Qdisc_ops sfb_qdisc_ops __read_mostly = {
 	.dump_stats	=	sfb_dump_stats,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("sfb");
 
 static int __init sfb_module_init(void)
 {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index eb77558fa367..410f4b0a9e72 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -925,6 +925,7 @@ static struct Qdisc_ops sfq_qdisc_ops __read_mostly = {
 	.dump		=	sfq_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("sfq");
 
 static int __init sfq_module_init(void)
 {
diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index 28beb11762d8..9e00d64d6e3b 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -292,6 +292,7 @@ static struct Qdisc_ops skbprio_qdisc_ops __read_mostly = {
 	.destroy	=	skbprio_destroy,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("skbprio");
 
 static int __init skbprio_module_init(void)
 {
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c..204992bad59a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2548,6 +2548,7 @@ static struct Qdisc_ops taprio_qdisc_ops __read_mostly = {
 	.dump_stats	= taprio_dump_stats,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_QD("taprio");
 
 static struct notifier_block taprio_device_notifier = {
 	.notifier_call = taprio_dev_notifier,
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index dd6b1a723bf7..84ffe6c7f3e7 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -608,6 +608,7 @@ static struct Qdisc_ops tbf_qdisc_ops __read_mostly = {
 	.dump		=	tbf_dump,
 	.owner		=	THIS_MODULE,
 };
+MODULE_ALIAS_QD("tbf");
 
 static int __init tbf_module_init(void)
 {
-- 
2.42.1


