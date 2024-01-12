Return-Path: <bpf+bounces-19470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77382C538
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA741F223E1
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C5C1CD25;
	Fri, 12 Jan 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lP+aCQ9A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lP+aCQ9A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37CC1AAA3;
	Fri, 12 Jan 2024 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C7A21FCEC;
	Fri, 12 Jan 2024 18:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705082811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0F2d4BJMcUVHr046RLpu5qUOAgurqEUzNBNzxNFQbRU=;
	b=lP+aCQ9AFESA99GlM6ZwMBKXUz8V1iA/dtW57fxyV+X1mMMhviAWQQIJVN0DEzv2MqyBdl
	Xy2Sg9c7Gkh9uZZYypZoi+NP4PzZnEcC2TwVoxIiNap/rizYtlZNpHpqw+s5einZEIHOYX
	CR0L5FKJn+P269RAtfUe5wd4AfCBnAs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705082811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0F2d4BJMcUVHr046RLpu5qUOAgurqEUzNBNzxNFQbRU=;
	b=lP+aCQ9AFESA99GlM6ZwMBKXUz8V1iA/dtW57fxyV+X1mMMhviAWQQIJVN0DEzv2MqyBdl
	Xy2Sg9c7Gkh9uZZYypZoi+NP4PzZnEcC2TwVoxIiNap/rizYtlZNpHpqw+s5einZEIHOYX
	CR0L5FKJn+P269RAtfUe5wd4AfCBnAs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8832B136A4;
	Fri, 12 Jan 2024 18:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yDDnH7p/oWXLQwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 12 Jan 2024 18:06:50 +0000
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
Subject: [PATCH v3 4/4] net/sched: Remove aliases of act_xt and sch_clsact
Date: Fri, 12 Jan 2024 19:06:46 +0100
Message-ID: <20240112180646.13232-5-mkoutny@suse.com>
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
X-Spam-Level: *
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL63s8thh5w8zyxj4waeg9pq8e),to(RLb6xbx6omp19g4abqyks5qxk)];
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
X-Spam-Flag: NO

The modules act_ipt and sch_ingress standout among net/sched modules
because they provide multiple act/sch functionalities in a single .ko.
They have aliases to make autoloading work for any of the provided
functionalities.

Since the autoloading was changed to uniformly request any functionality
under its alias, the non-systemic aliases can be removed now (i.e.
assuming the alias were only used to ensure autoloading).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/sched/act_ipt.c     | 1 -
 net/sched/sch_ingress.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index 098ea7e06f4c..d2fb6b19f7f0 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -436,7 +436,6 @@ static struct pernet_operations xt_net_ops = {
 MODULE_AUTHOR("Jamal Hadi Salim(2002-13)");
 MODULE_DESCRIPTION("Iptables target actions");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("act_xt");
 
 static int __init ipt_init_module(void)
 {
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index 48a800131e99..c2ef9dcf91d2 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -370,6 +370,5 @@ static void __exit ingress_module_exit(void)
 module_init(ingress_module_init);
 module_exit(ingress_module_exit);
 
-MODULE_ALIAS("sch_clsact");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Ingress and clsact based ingress and egress qdiscs");
-- 
2.43.0


