Return-Path: <bpf+bounces-78109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A58CFE5B3
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E65A7306D513
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E7E34D916;
	Wed,  7 Jan 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XE2X5kxJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFD34D917
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796107; cv=none; b=L+TqkUmxOs4pHbD2E08NVro6lnhoE2mH7pnGbGGNl7tFVU1IyVJiZN84mMLCH3m+qCfMAqhkzacE6/6EG+V9XDfODy9fiUxBRP/kJYzH3w13o8RTiYjVReyICKyMeh5YpDW2jD4UgFHodQtmoPpt5K/jMFwL/28bZRqBChAQDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796107; c=relaxed/simple;
	bh=l6RcmO3Gls8j+2vSUi+GZOL/ReACnjE2hP7L8Y/srPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjjUCzA19leqSJDiI1cK27WCEYPwP372sHdlLybcP0cLs+hEbU8O5xIhBd2jb4kg/YUrtq0a209tgiod2uf6D9HvZKpYrGp6x8VEUAxVwV5HRJhbdd/uLLC+44AwKmpHFeKcVn2/bG4sTj4MIlfykkBU+l5jyH4aSkQg0lOUxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XE2X5kxJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso309672266b.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796104; x=1768400904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heRVIssMddPtSafwXJcHFhk3bxkqAgYAFQ1TklhGvPM=;
        b=XE2X5kxJoyBn6er/t0YLuiwCUMAOfo1Hvb7iex3NSdXPqz9xgzrJChwbOw//f8M4GF
         zPkuJB335I+pSi8/aICY5FajJw89z0y/uBUYoyHTVvVEWF33suAwry93xyBNqW/fiHxv
         bxe5i7KV/Y/esnk2xVgcuz7Qqk3P/JYNPWGeyORxdCuAX6u/g+cuBmCLHMGk6jGl/NET
         YolC3TJlmkL9TMXHIwnz8lJFgfvyBonmav5X+EMCVA5ZCNleZXWlJgyQkyHCPbb6BYNd
         xpZQVmqiRqRHIdKAZ/DNIJh1XfqSe0A39T3hwO23TYjB3wuztw+htknm2aDyv264y16M
         uRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796104; x=1768400904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=heRVIssMddPtSafwXJcHFhk3bxkqAgYAFQ1TklhGvPM=;
        b=E6AOhizh8bPEQBosBHtHb/t08Gzs1gfof3PkL0HePpp52A48AeehiRQ7tfzGBissHQ
         G3bDDPTbzgHlp2YEeAzNO70bFXw4OREsXAHDPiizDrh0q8MIHkzwQoBcA/1NxBlz/ZNv
         7VvOU0eLe4YAo9p5oZ6JuDIWEnc6GN9Or6ly1H/xmJmDdIt3W7pwRtuGZklBI6rMYMsb
         fvWTRt51P2EmeiQeQMoaYMWQ6Da5Tvlkf+okXGvr5FtAnszeFU6t6iiE8KBwk+4dOG4B
         Zzl7n6uncOwiaYwj5plV467ly77cZcu8BbEZfjbYksj41ahCeZU46nocQ7tSp9f5G9dM
         VAlQ==
X-Gm-Message-State: AOJu0YxXZ/73/x/ji+k2QT+SDEPHPYKSJt+rwfyk3nP59LZ2DMw0oDsX
	CJ6WOJ61Vg0/djZRTLnq7115K4RUxoDVCIlmfUJkMeO2Yy5KSiq17YuIXDNVzD/+DTM=
X-Gm-Gg: AY/fxX6GLCcOHK+VwzBX622PTuyCMBwGsNtccSCjj3JM3xQlkjjt9rEM1B0FvnEn2SF
	Aelj5TeTt11+RAdpMtBNJi4XKxmJSugFzKl7m2PnDQyEdPgiJPik0XDdsQdlspCKNQj/DkmZeyA
	3uVVZUji9K+YjAC5G7OFxLtcGWKMdBzS012LtZMKnucqVNByabx6i2Al46Pv8Nwj0HTe+tALFmB
	WUbYLpt9nvxx2PME1/lK+aGnBydplNTNmBL+HVFrpoLETF0kL5E5wCZh58Qf7nHMuni/6ZRtBAJ
	6vpP9v8VVBZTnSbWIdYdlEDO83vu9V8zIEA/XijS3V8Fhu3A7d764nbyOmJdzqwDOSZORfOcTOE
	kL16aZSqT1+CLNdxqxagXIHWuADx3VZylkWDFn/wEY/qZudqj0kFiVvp7zYGpCZGhiTw75ji0gF
	PNfNxAXIRmcxvfJHbKMzey3uskxVX3L5MsXNCzAjsxC1tE0P+T3HU1mJ4tTYk=
X-Google-Smtp-Source: AGHT+IEHxyKBs9BtZiY7RQMsSy9mGqYXG25pbHUi9IrtneaaJqypau87QfGhS476lbMtkfWCEQHcfA==
X-Received: by 2002:a17:907:3e0f:b0:b73:42df:29a with SMTP id a640c23a62f3a-b84453b3f02mr256782866b.59.1767796103997;
        Wed, 07 Jan 2026 06:28:23 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56db21sm510933566b.71.2026.01.07.06.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:12 +0100
Subject: [PATCH bpf-next v3 12/17] bpf, verifier: Turn seen_direct_write
 flag into a bitmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-12-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Convert seen_direct_write from a boolean to a bitmap (seen_packet_access)
in preparation for tracking additional packet access patterns.

No functional change.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  6 +++++-
 kernel/bpf/verifier.c        | 11 ++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..c8397ae51880 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -647,6 +647,10 @@ enum priv_stack_mode {
 	PRIV_STACK_ADAPTIVE,
 };
 
+enum packet_access_flags {
+	PA_F_DIRECT_WRITE = BIT(0),
+};
+
 struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
@@ -773,7 +777,7 @@ struct bpf_verifier_env {
 	bool bpf_capable;
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
-	bool seen_direct_write;
+	u8 seen_packet_access;	/* combination of enum packet_access_flags */
 	bool seen_exception;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1158c7764a34..95818a7eedff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7714,7 +7714,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 					value_regno);
 				return -EACCES;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 		err = check_packet_access(env, regno, off, size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
@@ -13895,7 +13895,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 				verbose(env, "the prog does not allow writes to packet data\n");
 				return -EINVAL;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 
 		if (!meta->initialized_dynptr.id) {
@@ -21768,6 +21768,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
+	bool seen_direct_write;
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
@@ -21795,13 +21796,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	if (ops->gen_prologue || env->seen_direct_write) {
+	seen_direct_write = env->seen_packet_access & PA_F_DIRECT_WRITE;
+	if (ops->gen_prologue || seen_direct_write) {
 		if (!ops->gen_prologue) {
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
-		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
-					env->prog);
+		cnt = ops->gen_prologue(insn_buf, seen_direct_write, env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;

-- 
2.43.0


