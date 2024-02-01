Return-Path: <bpf+bounces-20954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D30184587F
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 14:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA961C22970
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DE53381;
	Thu,  1 Feb 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HKkZHz/H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ddv46Z1C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F765336A;
	Thu,  1 Feb 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792989; cv=none; b=EtbsMh40J50cvBal6CsjOKE9Bj4rXjUEcAzeu8C3mW//2m4+EHV1Gis2GvLxkqwaSIlIv/ovYyBycBxeM0xwMvvCHG2oKZOhBI1ytYh17NR3CpZtR4XNmaGe3oq8MHmPnllZCAzKVgZW0l+Y2KGWTYES90VHE57E4lYbqye0/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792989; c=relaxed/simple;
	bh=FzAiMYeMh68RoRGFUIzQHwDOgjpJOq2COApA0s/WXhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYpKS+BNpyZIze0zcP7HH38TUzbxwKzIXGQz7MfQB5HNFvaolcwA38tJdshWJ+73FFhiuy6fL0cHXbh0U9jcF9yHk5nOwr187kOZa6C+aRXklAGolYNhMeOOx/zJhkAsqbtFMMK387Nqj7Tu1zC7ClE9i+iQeZc0Xq9OZTDa1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HKkZHz/H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ddv46Z1C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBD801FBBF;
	Thu,  1 Feb 2024 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706792986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9P5sAb8IAwm4Mxv1KOuqoS+Y1pRu3bKYNnVzuk0M4w=;
	b=HKkZHz/H4Dz4RtuJAWGnJbdUpY+Grrms4+5THnbHimMcDxqsL9XuqsB0xbmOgvxYhVal5m
	yc5BajahKe3gcyhLjOGJYrwE0HMvibi9GPB0NhefxwhsvpdD0bUKKKpoDnCkzX0UeLucO2
	L9YcUwDtrygwozBWTX9FlZOKlqju5Ts=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706792985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9P5sAb8IAwm4Mxv1KOuqoS+Y1pRu3bKYNnVzuk0M4w=;
	b=Ddv46Z1C/TUI9wEYuqG+hADEy+o58EPVlaaRdQDjkcZ2kbp2Ah1yUsYCYcL4xs7BPEDgX4
	BH7JnseQouDf7SOxqA4dvO2f1mreYVdvTjSI/CwJGvMOBiKoo3N8bQfmeX8iY2JCjcp80O
	yEruyVf1eQnpdYgPACgzV1bJxumBiuM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CE3851329F;
	Thu,  1 Feb 2024 13:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GGg5MhmYu2VafgAAn2gu4w
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
Subject: [PATCH v5 3/4] net/sched: Load modules via their alias
Date: Thu,  1 Feb 2024 14:09:42 +0100
Message-ID: <20240201130943.19536-4-mkoutny@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLk7of1183i6tu11bgyseu9iy5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.60

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
 net/sched/sch_api.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3e30d7260493..9ee622fb1160 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1363,7 +1363,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 
 		if (rtnl_held)
 			rtnl_unlock();
-		request_module("act_%s", act_name);
+		request_module(NET_ACT_ALIAS_PREFIX "%s", act_name);
 		if (rtnl_held)
 			rtnl_lock();
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index ff3d396a65aa..ca5676b2668e 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -257,7 +257,7 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_held,
 #ifdef CONFIG_MODULES
 	if (rtnl_held)
 		rtnl_unlock();
-	request_module("cls_%s", kind);
+	request_module(NET_CLS_ALIAS_PREFIX "%s", kind);
 	if (rtnl_held)
 		rtnl_lock();
 	ops = __tcf_proto_lookup_ops(kind);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 36b025cc4fd2..9d928f6a473a 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -228,7 +228,7 @@ int qdisc_set_default(const char *name)
 	if (!ops) {
 		/* Not found, drop lock and try to load module */
 		write_unlock(&qdisc_mod_lock);
-		request_module("sch_%s", name);
+		request_module(NET_SCH_ALIAS_PREFIX "%s", name);
 		write_lock(&qdisc_mod_lock);
 
 		ops = qdisc_lookup_default(name);
@@ -1275,7 +1275,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			 * go away in the mean time.
 			 */
 			rtnl_unlock();
-			request_module("sch_%s", name);
+			request_module(NET_SCH_ALIAS_PREFIX "%s", name);
 			rtnl_lock();
 			ops = qdisc_lookup_ops(kind);
 			if (ops != NULL) {
-- 
2.43.0


