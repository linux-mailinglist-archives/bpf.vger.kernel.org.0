Return-Path: <bpf+bounces-77825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA56CF3789
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B1A330389BA
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61003375CD;
	Mon,  5 Jan 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="L7KJmqYt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5132335567
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615296; cv=none; b=DuGI7I70seRVSxr094D8YdMLH76enlbvlh9WW//XglcTuOL5EouLqudRULPAAeKCmGC4RNh40eFiVgZMcOM08LSOxuydkWcUK0PufMYaGoXi4LAulMFCSsti7ciSa4VpfVRNVrpDu/hWUAo7F7CJXQcu0Pqh7DThRewKlQ9/KPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615296; c=relaxed/simple;
	bh=DaIeyPBMFqFYGsZHXQ0hVs67eHvOKjWXifAmJrQ+MW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwdeqdH4E2UZCMxZdn1tAuC7XMNrcRX3AxDK+pDuTRSt2VloDJ2X2d3Ppyd16tefz0Gj381TPbW+0tp5Vt9Nrh/0cHtlrtfhju7alJUduYs6uIz9KD/+ZyX7n43RmgBPjUmvOFkLSPstVQvlknj1YKxKnY+SB3BaPBY97YHbzIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=L7KJmqYt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so18163765a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615293; x=1768220093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DMCjP6Xfa6cwtaPa6/JDGibR3hIGiV9FDaprfLm3q8=;
        b=L7KJmqYtSlRmVqiSh58aYBAn3LSBXISupdRclf7VVb2SXJZMzm/OAVrklAxaHADwSd
         KRmVss2dZx6/i/6nb6g+UZxMKvyJQTiZdEqBItDokT3Sl5mlQUK42y4m9FogFR+4qh/M
         V3qXCUtXeXzI2iaP60K3hC3KSZ8kU/oegcbynDnKIhIOCt3g+jgmZ9045o25NpPE4ZoH
         NVNOW0WASL40EeniQd4Nl3gVbU9vfR26Qvkvu3zsdCx7ntBB6DJYozJ0T+iuIS2rkk2t
         qr7J3f4w6fkXqa5GKzTtQf/as4DsQMc88H4gPU5lggQDb9LrzuGVoTFVXdjqGjuVvIjh
         kGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615293; x=1768220093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7DMCjP6Xfa6cwtaPa6/JDGibR3hIGiV9FDaprfLm3q8=;
        b=Pvjc5oDevj22YP47fAjAJYHokduDaoS+Kq4sQZtw6llImtv6QtE8mm9VjXY2lubVAn
         9EsC4PmpETaeSkkK4n/RcVXqefr/V07/5N1VjE3QJNODg4ywtoVYor4qQku4IVat5CYp
         LrLCDBb/hBW1dRX13UXqDRM2j4NP3XrUBCZru5utp3l9/t7SgbdTHIeO0xpLBxn0yJ/W
         QPj7Y3qas00uQTmeMFmJBzzJIbTVVqhI2wpBKHEF+jTMkv1RAe+3xLU2ukoVUDzPP3fK
         b5t1kcTHiR5AAMUWjV9N1Mr3vySmqYVfoXSoyzmSNLcAJLmrcumi/qPJXd/qAJfGQ4L6
         R4MA==
X-Gm-Message-State: AOJu0YypqV0wSaKmhXbQfcnSme4rTEBWM72ANvjX4CfZNYkagO4BMf4M
	aLIwLYmbyemDmvZOOHOPurx26tfA2KKAEj+6GwL5QHHKfUCm7Ef+F08xearu2Mi8v7k=
X-Gm-Gg: AY/fxX5DABz1Qu+WFtBUZIZqrsFx9xQx7vPsy82lMdu0GQH0fZ2U6ryoXbyr0jZ7DkN
	L7PcmxHBC6tWtEohdysi+zsELqrEjBBtn468ER2RKQw43jLFPx/chndbJ0GDM3vKipJjlKkMhXR
	NK8rlDiGMMB0MyikPk4iqXOppgsdfo2EPDi6N3nhFikjQz02K9DMyaye4geXIwe0RNet+EWVv/S
	saUIDTXuXrmp9NdU0G7922wd/u1hypSEpjT4t2zGiH8rl7ZHO6Cv/3AALhe42NOoaiOkTMoGsha
	ME3ywGXpSgVaRUaajZSdrUlyNwuGEDFLyIws9nd3uH784bVWvb7KnHOkobmKjDkE+ZF5MxEelyq
	3YIUrVb4Ja1WtP0l4SbL48L8iJRB8QRhFd5x3yi6HYC++JbUTd14oURWUbzHkpLZxO+V4qGVl8t
	BMwMGK7f2RkB0D3LkdY6gsvb3r45PQriqeoA3zgD3Vjpv60v9/hEROWNyXm3I=
X-Google-Smtp-Source: AGHT+IG66amTSG8ZI3H2ZppOB2AWjGL67LnDrtNiDLr1HXChgoO/4dw7QkbcInoy3NRSnhyuunR9ww==
X-Received: by 2002:a17:907:3dac:b0:b7d:1cbb:5d29 with SMTP id a640c23a62f3a-b80371da6d9mr4906955366b.36.1767615292844;
        Mon, 05 Jan 2026 04:14:52 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53be0sm53191678a12.2.2026.01.05.04.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:52 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:36 +0100
Subject: [PATCH bpf-next v2 11/16] bpf, verifier: Remove side effects from
 may_access_direct_pkt_data
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-11-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
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

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9394b0de2ef0..52d76a848f65 100644
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
@@ -13883,11 +13881,11 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
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
@@ -22388,7 +22386,6 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc, int insn_idx)
 {
 	struct bpf_prog *prog = env->prog;
-	bool seen_direct_write;
 	void *xdp_kfunc;
 	bool is_rdonly;
 	u32 func_id = desc->func_id;
@@ -22404,16 +22401,10 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
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


