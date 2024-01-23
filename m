Return-Path: <bpf+bounces-20089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD77839083
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C118288CF4
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE22B5FDD5;
	Tue, 23 Jan 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U+Kzy5tx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="siOhsW9q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E45F563;
	Tue, 23 Jan 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017973; cv=none; b=i+yDCHCQq/Q63KyrsQYFQL7U9sDEOEoLwdLJ+vM7GtxFIfq8EgpMVRV0SmPw275NdSvyfo9qvYVsyLAqt1SWzsf52qWWP/u+j31Pyb08bG52h9qo6cXVYQ1rUTQtbPgqp8lUYwemXSjrm0OJSlM6m4DAkJtIotekXsa48vnD0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017973; c=relaxed/simple;
	bh=yu94rh/i2ZJSD4Ale34FLKCyXGDz0hoULdXCqoA0MGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSt4nqUATdxHQABjA6sGoBb3z1ascLtHaUF3T4Qr3fk+F9W3qbqbKw4e8I5uTN5FIy556+MtDtiT320c8L9Jvqi/FGbJDb5arWpeD+x2H+Ue2gh6m9mrKbco3lCpxfskMdMvT5osK0qP9E2EEaEl0wVMlf846/co0mgfffc6nJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U+Kzy5tx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=siOhsW9q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5ECB1FCF6;
	Tue, 23 Jan 2024 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706017967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vI7QJke5a+L0APtAH9NMwTx+cqLOrM7Cy0hkyN/DhGI=;
	b=U+Kzy5txV0hlmSV9czAq/fenl/qZpL/SqWPYbnuVrsnkN3kZlKrv5BxswG+nF3yohrLzmG
	FMoYcqDYt7ULf4BlQrQ1Daaf43emWw5EHUISrPIGj6arcsmPf7o1f0hvzqQxCHvPST3aZn
	KReR9eEJkNH4w0TlID6j5JMniMgKCwM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706017966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vI7QJke5a+L0APtAH9NMwTx+cqLOrM7Cy0hkyN/DhGI=;
	b=siOhsW9q8DOMSUhX4AKTK/aQqX9j9eu6pPXkunr74caJQDkgWf2c75XFpO1HOPJB5+206R
	p7+SfdEPb+fU4Urb2JN8qu/qetWq/yNPWPAV7iScq4IQ4yvKmsm5AhlAvzZKRdMbxuOh+5
	XvI0vz2euKGT401XbBiEiGcz5OEzb9M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6AB8139B1;
	Tue, 23 Jan 2024 13:52:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFGLKK7Er2UMVwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 23 Jan 2024 13:52:46 +0000
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
	Martin Wilck <mwilck@suse.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH v4 1/4] net/sched: Add helper macros with module names
Date: Tue, 23 Jan 2024 14:52:39 +0100
Message-ID: <20240123135242.11430-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123135242.11430-1-mkoutny@suse.com>
References: <20240123135242.11430-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=siOhsW9q
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLhcw5w5rtick65589d1tggrs1)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[21.38%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[29];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 0.99
X-Rspamd-Queue-Id: C5ECB1FCF6
X-Spam-Flag: NO

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
index e1e5e72b901e..c7751f3787ef 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -201,6 +201,8 @@ int tcf_idr_release(struct tc_action *a, bool bind);
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
+#define NET_ACT_ALIAS_PREFIX "net-act-"
+#define MODULE_ALIAS_NET_ACT(kind)	MODULE_ALIAS(NET_ACT_ALIAS_PREFIX __stringify(kind))
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index f308e8268651..72b6c4405c5f 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -24,6 +24,8 @@ struct tcf_walker {
 
 int register_tcf_proto_ops(struct tcf_proto_ops *ops);
 void unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
+#define NET_CLS_ALIAS_PREFIX "net-cls-"
+#define MODULE_ALIAS_NET_CLS(kind)	MODULE_ALIAS(NET_CLS_ALIAS_PREFIX __stringify(kind))
 
 struct tcf_block_ext_info {
 	enum flow_block_binder_type binder_type;
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 1e200d9a066d..cf3f174e601f 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -100,6 +100,8 @@ struct Qdisc *fifo_create_dflt(struct Qdisc *sch, struct Qdisc_ops *ops,
 
 int register_qdisc(struct Qdisc_ops *qops);
 void unregister_qdisc(struct Qdisc_ops *qops);
+#define NET_SCH_ALIAS_PREFIX "net-sch-"
+#define MODULE_ALIAS_NET_SCH(id)	MODULE_ALIAS(NET_SCH_ALIAS_PREFIX __stringify(id))
 void qdisc_get_default(char *id, size_t len);
 int qdisc_set_default(const char *id);
 
-- 
2.43.0


