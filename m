Return-Path: <bpf+bounces-20957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691CE845887
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 14:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D55E1C216E6
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846695CDED;
	Thu,  1 Feb 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UijMuGJp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UijMuGJp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F553366;
	Thu,  1 Feb 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792991; cv=none; b=QtLvZBOtXMaOA2Nni5YvJTDL3NVWgWVijj6FlTNHvo0qDB9FpXl/0jiBiF+tfGjjRyqoBgTHQ5BCYHL5By8nnKZgfOT1rcHIFcC/QrTwSNOgvRYj/cAZ8D4dVB0d4GTuR9yREyx8707Qv+nE+bSO0CQcLC9//9u1G+SUPBRVkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792991; c=relaxed/simple;
	bh=pISfP3Hzv5P7bazKFw8x24gFRtSxfRqfs11zSQ5Dbys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwtqHdyl0rftnpE3LY+M/lzS5p/vzu86qzmxXW+pynJRFi/TwNSNrRjClIQ36Xc8VuOYtTckF3M3uBsNhgz5FTO/Jd58L0/zSSQkMDCE78SyUZVGEoSscQUKl84Y38TWUK84cC7T3AV+GoEpNEKytgfsgRHHquPG2++CRISMa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UijMuGJp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UijMuGJp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1711722147;
	Thu,  1 Feb 2024 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706792986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUKCAfTVoUrxB4zijGrDV9tJzwRsfCTR6KHiqfmXiK8=;
	b=UijMuGJpe3SfxW+1Pa+kKELvVKpcKljLUpGWkDPuIdt2hhb8Afa0MOKc6+aRoPYgiXmE+w
	QZ19FIitBTazsJrm0EudoeUJnyouGtG98vHV8Vb9Xdh8tWq4zURVKEM3a4RQeM0nsSGXzi
	OqCTVdI248guWFEpigsz/SDL0N3sJC0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706792986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUKCAfTVoUrxB4zijGrDV9tJzwRsfCTR6KHiqfmXiK8=;
	b=UijMuGJpe3SfxW+1Pa+kKELvVKpcKljLUpGWkDPuIdt2hhb8Afa0MOKc6+aRoPYgiXmE+w
	QZ19FIitBTazsJrm0EudoeUJnyouGtG98vHV8Vb9Xdh8tWq4zURVKEM3a4RQeM0nsSGXzi
	OqCTVdI248guWFEpigsz/SDL0N3sJC0=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E4EBF13A04;
	Thu,  1 Feb 2024 13:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GOnBNxmYu2VafgAAn2gu4w
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
Subject: [PATCH v5 4/4] net/sched: Remove alias of sch_clsact
Date: Thu,  1 Feb 2024 14:09:43 +0100
Message-ID: <20240201130943.19536-5-mkoutny@suse.com>
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
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UijMuGJp
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 BAYES_HAM(-1.57)[92.20%];
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
X-Spam-Score: -0.58
X-Rspamd-Queue-Id: 1711722147
X-Spam-Flag: NO

The module sch_ingress stands out among net/sched modules
because it provides multiple act/sch functionalities in a single .ko.
They have aliases to make autoloading work for any of the provided
functionalities.

Since the autoloading was changed to uniformly request any functionality
under its alias, the non-systemic aliases can be removed now (i.e.
assuming the alias were only used to ensure autoloading).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/sched/sch_ingress.c | 1 -
 1 file changed, 1 deletion(-)

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


