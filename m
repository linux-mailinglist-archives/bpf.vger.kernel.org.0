Return-Path: <bpf+bounces-75617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA61C8C315
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 23:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6EE3B915C
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 22:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504B346765;
	Wed, 26 Nov 2025 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHu6MsOi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031C345738
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195459; cv=none; b=OMLSGwrYzcap9Kv3TfIwz9XXqyHd2C911WW2+6NN1SXDyNLbjPvT4PbJNIeJsFTGlpo1TqKDuQwsMXegKfCCMVxPW10Ffb3s6VwyBoYHFi9BgXtq6V9rk6Nmm/8mEV+nYlltPM8aRutVVJ7y2mt3u3Sa600UHsak/PaoPUg9vkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195459; c=relaxed/simple;
	bh=WoPr0D480sRfz6MWlBIwr0fT3bxHa92NetIHpnkS2K0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JVXCpXZBDauCmMiHTbDPR4tS8iuMcfIGU/keNLpuaRZifQhyPpu7HY6jXn1I+mcptKAmIieEyCrayx8Nm7M/HtoN9lOkReqerHyGeHUCrohzn5Ar5etePFicN9HSJuHPB6EQf2FKrMNEW/MRbc5n91C8G1dJBcUI7k8/zTqk72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHu6MsOi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc240cdb249so205154a12.3
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764195458; x=1764800258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsdGxAHy7+Lr8WP2LpE73bfJe0tYWCB0gy6QVRcQ+0k=;
        b=XHu6MsOifsF8zdUId5Yss1tWgoaHVYpxURxnb1GugIJichlQ1YwVvPn+sNPvNEYyZJ
         +ydtAyc1a2b15fD3Yv6PO6UHe4nO7/kxmDMIzxdn6uRB6UF6nU9R9aNWJZR0oMbe02i3
         li5FYacdBuRQ4DQvngU3WkmRF+4mvB8rsZ9tGf0doAQ1j0VMCiLTzlGqnD7Vpp3iS8zV
         lh4mhSOch/Vp3Lw3hqZT2S7+S45kV2xNNo46qiFKu/2/ciiknJCDdQmyhDLLa0bPoiKc
         w1x1Wen5DiENcHNjRjEanoKaiIuiwfSK7wv1V3xuaoTNvWu/23lyLjDu5I/Uwr0eMS4m
         tkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195458; x=1764800258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsdGxAHy7+Lr8WP2LpE73bfJe0tYWCB0gy6QVRcQ+0k=;
        b=FY5OpRIvGsn90m+VESIoBfQA7SlWNtIFFsPh7XykLr6WCFGcPR+Ase/xRn/i39mlkP
         RJJatuCTc4WHKdaln7FhF6+leermn3WE7j34zmUSVjt49H1bTmmcbVI+SXyfRQoNlkc+
         JdBySE7btT8MFAcA1kf2ig+MqQiSjF7ALXxfKdC0WnUO1jPGaGZqCmk5kiLEYPMpK2v4
         3/Hom2h1UMTz7uPUpRg8X4Zld5+TOV9ihfNbttd2Z0m6AoQnQDqryDvqFjMfjPqqq0q4
         NvOunUaDC5adlFiDK4rLKmB0agTF90IslJPw9r+tyziy0JmPkY50GDtIWLOgjeWpnXQd
         JE1w==
X-Gm-Message-State: AOJu0YxdB+2LpXQ+sws1DDRE4h5/xn3vjp2RZ2H8gnEYIRXW3NqzMdYg
	AG6E4JY4ruVvr7IoKYVikPlbIm7FnIMRz7FiQt9qjD+G8p8de8o1zwP0JS0VMnBTu51nrCgsaC0
	y8D7onD+HYl+yxCwKcO30sLL3KYxfaYZDfL50QWYNKdaOV6w1BCH+QF7BGmOg82qIJzESPZtPfU
	iN5UcjQpr1VEMMZXeiptiOPjXxgjkNU6J3Rl0CKTY1bfv4zUawc6HBJWr+GbTsAUN1
X-Google-Smtp-Source: AGHT+IF+NJvGtMUf7g2ELzHlH7eqyOms5MRbRzRX3sg4jry5QurPb9wZ/lrXsK3lya/WwBfrnvChARM33YajCsYgIpg=
X-Received: from dyu1.prod.google.com ([2002:a05:693c:8101:b0:2a4:5178:f11f])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1014:b0:2a4:3593:4664 with SMTP id 5a478bee46e88-2a9413bc7a6mr4857020eec.0.1764195457160;
 Wed, 26 Nov 2025 14:17:37 -0800 (PST)
Date: Wed, 26 Nov 2025 22:17:29 +0000
In-Reply-To: <20251126221724.897221-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126221724.897221-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=samitolvanen@google.com;
 h=from:subject; bh=WoPr0D480sRfz6MWlBIwr0fT3bxHa92NetIHpnkS2K0=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJnqNWU2kmKOZhdXtB690uwVv6L7v/qjOgFzz7NXjD6c4
 70U4b+jo5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEykWJjhf+ZlF/E3bzy643Ji
 giKXMGbbsbQEtv3YtzD8QWH2In6FTkaGP2E/gr+r6dbOXqv6v/CVpvabbQ2mapNV+Nzi+m7Z8a5 kBwA=
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126221724.897221-10-samitolvanen@google.com>
Subject: [PATCH bpf-next v4 4/4] bpf, btf: Enforce destructor kfunc type with CFI
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that registered destructor kfuncs have the same type
as btf_dtor_kfunc_t to avoid a kernel panic on systems with
CONFIG_CFI enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..0346658172ec 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8845,6 +8845,13 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 		 */
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
+
+		if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+			/* Ensure the destructor kfunc type matches btf_dtor_kfunc_t */
+			t = btf_type_by_id(btf, t->type);
+			if (!btf_type_is_void(t))
+				return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.52.0.487.g5c8c507ade-goog


