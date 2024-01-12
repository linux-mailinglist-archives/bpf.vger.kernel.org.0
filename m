Return-Path: <bpf+bounces-19468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5985682C533
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E230B286685
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7626D1AF;
	Fri, 12 Jan 2024 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ld6gB+ol";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ld6gB+ol"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635217C98;
	Fri, 12 Jan 2024 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A2A91FCEB;
	Fri, 12 Jan 2024 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705082810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kvv7cofGHv1O8GC1/w0Czci64PVz2U0LwGXpBbRob9A=;
	b=ld6gB+olV2n8K0Cy648yABfRbDZDCAN/VH3spGP4Am9KZ2vu05chV2brbAn51Flvdh5uDz
	HFSUyTzzN8emXa0Og0wxKtrJbvmHWDQGLvSagtZR/SFCsAy4dT846FAyrXpp0JbDAI3wsr
	j8ZNK8ccGL46+Nc9nvodST1yPDohmiU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705082810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kvv7cofGHv1O8GC1/w0Czci64PVz2U0LwGXpBbRob9A=;
	b=ld6gB+olV2n8K0Cy648yABfRbDZDCAN/VH3spGP4Am9KZ2vu05chV2brbAn51Flvdh5uDz
	HFSUyTzzN8emXa0Og0wxKtrJbvmHWDQGLvSagtZR/SFCsAy4dT846FAyrXpp0JbDAI3wsr
	j8ZNK8ccGL46+Nc9nvodST1yPDohmiU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D485C139AB;
	Fri, 12 Jan 2024 18:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sE+vMrl/oWXLQwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 12 Jan 2024 18:06:49 +0000
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
Subject: [PATCH v3 3/4] net/sched: Load modules via their alias
Date: Fri, 12 Jan 2024 19:06:45 +0100
Message-ID: <20240112180646.13232-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112180646.13232-1-mkoutny@suse.com>
References: <20240112180646.13232-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ld6gB+ol
X-Spamd-Result: default: False [2.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLhcw5w5rtick65589d1tggrs1)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.19
X-Rspamd-Queue-Id: 8A2A91FCEB
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

The cls_,sch_,act_ modules may be loaded lazily during network
configuration but without user's awareness and control.

Switch the lazy loading from canonical module names to a module alias.
This allows finer control over lazy loading, the precedent from
commit 7f78e0351394 ("fs: Limit sys_mount to only request filesystem
modules.") explains it already:

	Using aliases means user space can control the policy of which
	filesystem^W net/sched modules are auto-loaded by editing
	/etc/modprobe.d/*.conf with blacklist and alias directives.
	Allowing simple, safe, well understood work-arounds to known
	problematic software.

By default, nothing changes. However, if a specific module is
blacklisted (its canonical name), it won't be modprobe'd when requested
under its alias (i.e. kernel auto-loading). It would appear as if the
given module was unknown.

The module can still be loaded under its canonical name, which is an
explicit (privileged) user action.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/sched/act_api.c | 2 +-
 net/sched/cls_api.c | 2 +-
 net/sched/sch_api.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c39252d61ebb..463bc1109c45 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1331,7 +1331,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 #ifdef CONFIG_MODULES
 		if (rtnl_held)
 			rtnl_unlock();
-		request_module("act_%s", act_name);
+		request_module("net-act-%s", act_name);
 		if (rtnl_held)
 			rtnl_lock();
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..14e20948273a 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -257,7 +257,7 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_held,
 #ifdef CONFIG_MODULES
 	if (rtnl_held)
 		rtnl_unlock();
-	request_module("cls_%s", kind);
+	request_module("net-cls-%s", kind);
 	if (rtnl_held)
 		rtnl_lock();
 	ops = __tcf_proto_lookup_ops(kind);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e9eaf637220e..9bc03d22f155 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1246,7 +1246,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			 * go away in the mean time.
 			 */
 			rtnl_unlock();
-			request_module("sch_%s", name);
+			request_module("net-sch-%s", name);
 			rtnl_lock();
 			ops = qdisc_lookup_ops(kind);
 			if (ops != NULL) {
-- 
2.43.0


