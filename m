Return-Path: <bpf+bounces-20953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C098184587E
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FC41F22EDF
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09E5336D;
	Thu,  1 Feb 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ak6/8uPC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ak6/8uPC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055F53369;
	Thu,  1 Feb 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792989; cv=none; b=Knsn4fI4vOhL4H0AFwBvWHgobrVhmoh5m0ttF2LpYn7JsiFkIN9sRS2d17J6OZepTv2n0OzDo4y73VtBYMXnjiNw/rqqo74rBF4IxUDqrBfCetewbVqCQeBUDdZ2REJfmvArVusMKAZRC1ntMT+4rzyKRaW0lsS5ZbKrntu6XoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792989; c=relaxed/simple;
	bh=CWsec72laiH13hslDdt/tQ5pFRPvNGWlQZH0jn7t9Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJhvCvSwDlceQecDkYuvBWQqfdudq2BVZKzvLRWuKUxuGgTznXN59VvL3/zpWUgKh8oINDoxAkDFwDLTBn15otC0S9cJQkmFwbiiNN/zm5uPUefCGWWIhekKMP8Bw/5NEJUlR0OSgzRG8/ZZ7rHbo6LSfa92aoMHksakQQUHzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ak6/8uPC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ak6/8uPC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B71F722140;
	Thu,  1 Feb 2024 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706792985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm++baup3koyn3Nz/n1HWTFZIXb00d390m5J46YHdYE=;
	b=ak6/8uPCq9RQwKpa88YgEQQI+jGzo+X/ZgRQvMeDOGBmCc6AMegY2kZSdDD0ouYCvblh09
	fw4zPlbtNMZpR+lmfMHI67rN/5CUrPrE4j/XwCSBV9RfTKeI5VFoY2oQ5f9ugZ0ZuNifyI
	Z5nWGgyMjq4HGR2KMSnsMbrWChyNqz4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706792985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm++baup3koyn3Nz/n1HWTFZIXb00d390m5J46YHdYE=;
	b=ak6/8uPCq9RQwKpa88YgEQQI+jGzo+X/ZgRQvMeDOGBmCc6AMegY2kZSdDD0ouYCvblh09
	fw4zPlbtNMZpR+lmfMHI67rN/5CUrPrE4j/XwCSBV9RfTKeI5VFoY2oQ5f9ugZ0ZuNifyI
	Z5nWGgyMjq4HGR2KMSnsMbrWChyNqz4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 965CB139E1;
	Thu,  1 Feb 2024 13:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6EWUJBmYu2VafgAAn2gu4w
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
Subject: [PATCH v5 1/4] net/sched: Add helper macros with module names
Date: Thu,  1 Feb 2024 14:09:40 +0100
Message-ID: <20240201130943.19536-2-mkoutny@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="ak6/8uPC"
X-Spamd-Result: default: False [2.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 BAYES_HAM(-0.00)[31.01%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLogq4uai3psdy7gygdsfysmzr)];
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
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.19
X-Rspamd-Queue-Id: B71F722140
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

The macros are preparation for adding module aliases en mass in a
separate commit.
Although it would be tempting to create aliases like cls-foo for name
cls_foo, this could not be used because modprobe utilities treat '-' and
'_' interchangeably.
In the end, the naming follows pattern of proto modules in linux/net.h.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/net/act_api.h   | 2 ++
 include/net/pkt_cls.h   | 2 ++
 include/net/pkt_sched.h | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index e1e5e72b901e..77ee0c657e2c 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -201,6 +201,8 @@ int tcf_idr_release(struct tc_action *a, bool bind);
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
+#define NET_ACT_ALIAS_PREFIX "net-act-"
+#define MODULE_ALIAS_NET_ACT(kind)	MODULE_ALIAS(NET_ACT_ALIAS_PREFIX kind)
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index f308e8268651..a4ee43f493bb 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -24,6 +24,8 @@ struct tcf_walker {
 
 int register_tcf_proto_ops(struct tcf_proto_ops *ops);
 void unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
+#define NET_CLS_ALIAS_PREFIX "net-cls-"
+#define MODULE_ALIAS_NET_CLS(kind)	MODULE_ALIAS(NET_CLS_ALIAS_PREFIX kind)
 
 struct tcf_block_ext_info {
 	enum flow_block_binder_type binder_type;
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 1e200d9a066d..d7b7b6cd4aa1 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -100,6 +100,8 @@ struct Qdisc *fifo_create_dflt(struct Qdisc *sch, struct Qdisc_ops *ops,
 
 int register_qdisc(struct Qdisc_ops *qops);
 void unregister_qdisc(struct Qdisc_ops *qops);
+#define NET_SCH_ALIAS_PREFIX "net-sch-"
+#define MODULE_ALIAS_NET_SCH(id)	MODULE_ALIAS(NET_SCH_ALIAS_PREFIX id)
 void qdisc_get_default(char *id, size_t len);
 int qdisc_set_default(const char *id);
 
-- 
2.43.0


