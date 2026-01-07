Return-Path: <bpf+bounces-78108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E2CFE553
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8E95300E83E
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE434D92B;
	Wed,  7 Jan 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OTW7PRbX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2734D4F9
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796106; cv=none; b=IgV5sAi+cRyjp37/+iYRniPoD9NjZMHqQWLCrpjnyUODZ4IkfvTzKvRfsMpsnVJGJG39YhO/R86O+anlOEoWRPSHMyN8Tfl1f+NC/qm93K+fFi12mtfRdLU/N0TGCOq4ET2RYiNOzREjnklQ22XZot7DxvXsRvI8aqU94bFkaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796106; c=relaxed/simple;
	bh=6lMcvdGQpi2foE2oBOW6tI/SoaizyaDOcJJTSblfqDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fxd4kAxo0Jsjf5YZsuNtUIkq8oPAaHT8hWjbjrpmUYnKgkF1+LA84Urxh0MbfHJIvg5o8UPJNfBb12GdVwcPqECg/FlkCtGCPirNyQivc6RbTz+L0APrS/+qSwmGFrBgKmCp414b7waJ69tIYB6eV+CdNa3UAyBfYNJxzi8IDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OTW7PRbX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso2890246a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796103; x=1768400903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrW1MKYtA+mRp8728oM7KJK7fuvYwT0zUVH3NAyGVNQ=;
        b=OTW7PRbXIVe2LqIaHOIi5CiqE9xRRAnFtRXQSTWGTT2HIXZt9F9WCnS2FEbWQe8UWn
         2a3za/DrOeNnqr9knlLJqnzLrtLUaDyd5pemNk4MIdoREcPxRjY+EC/+fJt/XL3ntgmX
         wnHippzrJtWrCDkzH+jnRf4DlxSAznqcwg2PxSaY3Ypo84RBEo0cw+59OAnornTdGgab
         SPMdz8fTV8busTp6Rt7L+fTHY6B/P23TPdL5b+sPQvUqzDwE0voeX/nWZp8cQlddDtCP
         BaV0icZ7KZFcjwscmoi7i0ppFHuUllUrVA9DylCD0y+FqbOJ8v72dA0bvc8VKr2Vw05K
         FHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796103; x=1768400903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FrW1MKYtA+mRp8728oM7KJK7fuvYwT0zUVH3NAyGVNQ=;
        b=R+EdsX/1l4G7Io9NfJgfpQtrkdWdrYuWENPINsRF/fVnSGPSCcU/CbobximocQzfhx
         d0mGP27J+wCyTNNqabOr/SLV6RmnWauXEYM9LolToKMIXqJgzgUjHbC9JfSHaybAbIH9
         5BMQrIrJy1mKnwDJH8qZsq5vlTU0xh5Mj9OP8Ign8LHgBupB7B5koYnnXXMmRI0jZQ6S
         f6eCPfULpIlSTzpQA9CSigq4S3EAzr4rHlC/MmrI43P0UkkwqlYzOv7c10aq5yUxPiK+
         xTWNuOFRpTwkzQ4teovD8cmOguLouTZZRWqAJnuvfLr0s/0Dvk4eOkv3neZ/29kNsNeK
         srgQ==
X-Gm-Message-State: AOJu0YzG3WXcCjfNAAbUpxLnxSCC2KK5/taN7yuBqYE96b6hEFR3dFQA
	fqcizGIMKCL2plk8REiLa+IuZuvKCcjdXFuATwgyxEPGggHOErblPucAfroRvWfdNj0=
X-Gm-Gg: AY/fxX5xR8R2/CY6fiDYxcW5wxJ40wgY0MclnXHtyZ44cwYK191eP4ALiF5rEVrB+us
	EkW/i42kH49N4ZZKhBgpicYFWEUyUfONRug71cjos5/DpQwrD9lGaN4KYRpUwksPzk23ydkczHb
	U8ZVNcmQOkLzcP0xNVlecmFfe++6iNyi0CtYaqK748kjIj2x11hpZVUFKvQpmZuD7z8IiIcXysO
	TPUOjgSWyoAz2PX0fKWDfEVlI1auR76q83I6LDZp9zemlAQDUk92EM7D1kHWlp/+7hVAfNkuc6U
	hu6itilj3HRajPaJgiJ56dg2TNOD7/klEWfo7dNJFkCxyANdwt8psEtaqYALSbCGnkxEEfclhHJ
	lqEtbkBtfq87++YW7NXQu0C0t9z/GxWZ6Jhj3YdrNmOVdDLrh3cajcDi4DodzrU8cmAdEA2HSXH
	agMpn6mQl02Sc8loyjvaQsoxrhlXLuFghhA+6wKrH9sZszxdzmiY2+SKaLL6k=
X-Google-Smtp-Source: AGHT+IEPP+Q5FCwmvRHpwEcY1WSaFLcMya5NZNvRNO1KNjvo9pGoRDtitahVD+VXc/cVw8std524ug==
X-Received: by 2002:a17:907:3d46:b0:b83:84b0:9419 with SMTP id a640c23a62f3a-b84453eb2dcmr290909166b.46.1767796102786;
        Wed, 07 Jan 2026 06:28:22 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d1c61sm516649966b.35.2026.01.07.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:22 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:11 +0100
Subject: [PATCH bpf-next v3 11/17] bpf, verifier: Remove side effects from
 may_access_direct_pkt_data
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-11-0d461c5e4764@cloudflare.com>
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

The may_access_direct_pkt_data() helper sets env->seen_direct_write as a
side effect, which creates awkward calling patterns:

- check_special_kfunc() has a comment warning readers about the side effect
- specialize_kfunc() must save and restore the flag around the call

Make the helper a pure function by moving the seen_direct_write flag
setting to call sites that need it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..1158c7764a34 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6151,13 +6151,9 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 		if (meta)
 			return meta->pkt_access;
 
-		env->seen_direct_write = true;
 		return true;
 
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-		if (t == BPF_WRITE)
-			env->seen_direct_write = true;
-
 		return true;
 
 	default:
@@ -7708,15 +7704,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			err = check_stack_write(env, regno, off, size,
 						value_regno, insn_idx);
 	} else if (reg_is_pkt_pointer(reg)) {
-		if (t == BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
-			verbose(env, "cannot write into packet\n");
-			return -EACCES;
-		}
-		if (t == BPF_WRITE && value_regno >= 0 &&
-		    is_pointer_value(env, value_regno)) {
-			verbose(env, "R%d leaks addr into packet\n",
-				value_regno);
-			return -EACCES;
+		if (t == BPF_WRITE) {
+			if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE)) {
+				verbose(env, "cannot write into packet\n");
+				return -EACCES;
+			}
+			if (value_regno >= 0 && is_pointer_value(env, value_regno)) {
+				verbose(env, "R%d leaks addr into packet\n",
+					value_regno);
+				return -EACCES;
+			}
+			env->seen_direct_write = true;
 		}
 		err = check_packet_access(env, regno, off, size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
@@ -13893,11 +13891,11 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice]) {
 			regs[BPF_REG_0].type |= MEM_RDONLY;
 		} else {
-			/* this will set env->seen_direct_write to true */
 			if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE)) {
 				verbose(env, "the prog does not allow writes to packet data\n");
 				return -EINVAL;
 			}
+			env->seen_direct_write = true;
 		}
 
 		if (!meta->initialized_dynptr.id) {
@@ -22398,7 +22396,6 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc, int insn_idx)
 {
 	struct bpf_prog *prog = env->prog;
-	bool seen_direct_write;
 	void *xdp_kfunc;
 	bool is_rdonly;
 	u32 func_id = desc->func_id;
@@ -22414,16 +22411,10 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 			addr = (unsigned long)xdp_kfunc;
 		/* fallback to default kfunc when not supported by netdev */
 	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
-		seen_direct_write = env->seen_direct_write;
 		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
 
 		if (is_rdonly)
 			addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
-
-		/* restore env->seen_direct_write to its original value, since
-		 * may_access_direct_pkt_data mutates it
-		 */
-		env->seen_direct_write = seen_direct_write;
 	} else if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr]) {
 		if (bpf_lsm_has_d_inode_locked(prog))
 			addr = (unsigned long)bpf_set_dentry_xattr_locked;

-- 
2.43.0


