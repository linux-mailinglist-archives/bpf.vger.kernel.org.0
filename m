Return-Path: <bpf+bounces-20088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9899183907F
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 14:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BBF1F22A79
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 13:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB595FBB7;
	Tue, 23 Jan 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IboYbwOi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kko701xO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859D5F565;
	Tue, 23 Jan 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017972; cv=none; b=P4jPLMZeRsvl+gluesFuCvXrkGPyTDTnuJo+oxhFg8u215qlBdte5iYrLkLIsF7Y5rvqAgAcd6jMWk6HjA591kgJjbnopP71enIp4BJyo+fSg6mK1iPXQ0FwNculpPcUxFjxPVLwasTzAwT66/AhWZ6lhxzcZS8R3wuvIyzp+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017972; c=relaxed/simple;
	bh=pISfP3Hzv5P7bazKFw8x24gFRtSxfRqfs11zSQ5Dbys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfywlABQO+5rtjm5fmJjNQyoRAZzVDbx5Pv/O3XwB+kEas1sGG48EdjfgqMiEtk6cangY+lfDKwAimzM4GvVKwAJu5cAU4p5T4G+pibTyl0VUQR0aJ2MlRvvaeeFdTZuNe+f61rKzO/bc2JuIx+LVGSVO9QaYJ9tRTLt0xt7KN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IboYbwOi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kko701xO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22DEC1FD52;
	Tue, 23 Jan 2024 13:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706017968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUKCAfTVoUrxB4zijGrDV9tJzwRsfCTR6KHiqfmXiK8=;
	b=IboYbwOiqlbaX2wd0HmSqCbYgYrOKSDteGasFw296lSHkEyhATr/cH9zoRtqXElPiGxbnR
	HxfNiJztorKYwBEJVT7yUSaSpkc9OlVcIU3hEEogrevpfSOJ3zHkMrxkVzRqlKuxR9qNdQ
	RuaXoz0uAlp40FjCZCgIpHdkvQ8jt9k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706017967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUKCAfTVoUrxB4zijGrDV9tJzwRsfCTR6KHiqfmXiK8=;
	b=Kko701xOZnUWqfDnlanF9u3rpQaVvN8IRdddv5a6v07dZ/hUHjSJS0D6Bjwno5Ui+ppHgb
	osLwB01sY//O1VtfadNso6aoj9X5Fk+0R+egC/CyYSt040mF+sLFqYf5bMLssnnldLmVQl
	0ARVwqFMvYvdbf8Xzb9sSXOMj0FxLz8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04C62139B9;
	Tue, 23 Jan 2024 13:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8KICAa/Er2UMVwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 23 Jan 2024 13:52:47 +0000
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
Subject: [PATCH v4 4/4] net/sched: Remove alias of sch_clsact
Date: Tue, 23 Jan 2024 14:52:42 +0100
Message-ID: <20240123135242.11430-5-mkoutny@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Kko701xO
X-Spamd-Result: default: False [2.02 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RLhcw5w5rtick65589d1tggrs1)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.17)[69.66%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[29];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.02
X-Rspamd-Queue-Id: 22DEC1FD52
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

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


