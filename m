Return-Path: <bpf+bounces-19467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5582C52E
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8031C22433
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2D81AACB;
	Fri, 12 Jan 2024 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eWV0YOpr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eWV0YOpr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A117C95;
	Fri, 12 Jan 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E8221FCE8;
	Fri, 12 Jan 2024 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705082809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiZKmcBfhUwyucttFraFdSTZKVbJV3vqXBGniwGuBto=;
	b=eWV0YOprL4dVYITe6nOmvsEBLbkaT8i/sLXBg+JCvhPhlTOGvgR/6B2Gn1dGgnhvxwQqkq
	ho4IhrGg9QhWk2mqVDRo5nYqdEUjZO+kTtbOOn8wBeD7u64Fh36//19PGtPzQ1HOii01ii
	4fbsNN0WuSUvs7XJuWRVMc7F6HdT83o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705082809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiZKmcBfhUwyucttFraFdSTZKVbJV3vqXBGniwGuBto=;
	b=eWV0YOprL4dVYITe6nOmvsEBLbkaT8i/sLXBg+JCvhPhlTOGvgR/6B2Gn1dGgnhvxwQqkq
	ho4IhrGg9QhWk2mqVDRo5nYqdEUjZO+kTtbOOn8wBeD7u64Fh36//19PGtPzQ1HOii01ii
	4fbsNN0WuSUvs7XJuWRVMc7F6HdT83o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BB80139AB;
	Fri, 12 Jan 2024 18:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mE0EJbh/oWXLQwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 12 Jan 2024 18:06:48 +0000
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
Subject: [PATCH v3 1/4] net/sched: Add helper macros with module names
Date: Fri, 12 Jan 2024 19:06:43 +0100
Message-ID: <20240112180646.13232-2-mkoutny@suse.com>
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
	none
X-Spamd-Result: default: False [2.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RL63s8thh5w8zyxj4waeg9pq8e)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
X-Spam-Score: 2.40
X-Spam-Flag: NO

The macros are preparation for adding module aliases en mass in a
separate commit.
Although it would be tempting to create aliases like cls-foo for name
cls_foo, this could not be used because modprobe utilities treat '-' and
'_' interchangeably.
In the end, the naming follows pattern of proto modules in linux/net.h.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/net/act_api.h   | 1 +
 include/net/pkt_cls.h   | 1 +
 include/net/pkt_sched.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4ae0580b63ca..ade63a9157f2 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -200,6 +200,7 @@ int tcf_idr_release(struct tc_action *a, bool bind);
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
+#define MODULE_ALIAS_NET_ACT(kind)	MODULE_ALIAS("net-act-" __stringify(kind))
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a76c9171db0e..906ccfea81f2 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -24,6 +24,7 @@ struct tcf_walker {
 
 int register_tcf_proto_ops(struct tcf_proto_ops *ops);
 void unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
+#define MODULE_ALIAS_NET_CLS(kind)	MODULE_ALIAS("net-cls-" __stringify(kind))
 
 struct tcf_block_ext_info {
 	enum flow_block_binder_type binder_type;
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9fa1d0794dfa..88ab6d0ab08b 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -100,6 +100,7 @@ struct Qdisc *fifo_create_dflt(struct Qdisc *sch, struct Qdisc_ops *ops,
 
 int register_qdisc(struct Qdisc_ops *qops);
 void unregister_qdisc(struct Qdisc_ops *qops);
+#define MODULE_ALIAS_NET_SCH(id)	MODULE_ALIAS("net-sch-" __stringify(id))
 void qdisc_get_default(char *id, size_t len);
 int qdisc_set_default(const char *id);
 
-- 
2.43.0


