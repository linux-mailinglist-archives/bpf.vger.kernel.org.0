Return-Path: <bpf+bounces-77826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE87CF37E1
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A478303D6AC
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEBF31577E;
	Mon,  5 Jan 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qh4YA3k5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F43358B8
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615297; cv=none; b=snXaOx84KDbvrkwhYEYmi0gXjF3Zg7d937eWGJNq8SRc9bU7G9ckwszIYv/L6QGzaNjNHoNvesnFRexraAtYQE01Ou5RkK+SrnWKnjCOyzEAY9Irt3s2UGeqQ3fVL75CpUFS0w0byZy3T+DCzns/FKxUKDnI1uIDGL/DoSHS0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615297; c=relaxed/simple;
	bh=IIFb51Gy/DWsJV6cFEMZaKjS0sm2RgnLEz5ayRS3wPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elN3R9SDr8D/azjvgl4bCVr8MFG8+SqfrzXDdkyX1FVC9xYXmyafqANItMHh3fHar758ojWAThL6RgpegWFh9C6I3GF7OvDBKdGhNOhyHXotTyRYfZtdfPwSnTbhF23FjT4G3sM4xv9fDXFPC8wVyV8LoZt30ujF3ScZFlI4RDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qh4YA3k5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso19421147a12.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615294; x=1768220094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLmWUlmFbL3slFSMdfLDXe6ULlPoRwYj6o7jYafn/70=;
        b=Qh4YA3k50QN8s0cGV8BoHmdlT83XPrgXpDYxKDyeBQqc0IvnbdFZ//DQClpOr64fVA
         nW4/kZiWI4omOMcHPvSxhLNht1OQvZnoJEuiDe2ZJLwXd2Nei7j53oFdbHVy99kyIqlq
         hEzftitiKBcMer67BTNWltd00d5jp/ba+/3PN3KsWJ3rCAAO7K//2yBTfrzF/DovFE0T
         c4mfR+bTEf9YOaV0QW/uUNJ8dAJaZETP99XMPydHQ1hIzW5JaJf/z7pe6Ad4pRGXPPMy
         coK3Dc1PAaQYegtGIcupWTK00ZYkAbyD+9JipQS5/5ToMpgtDoVfv2e1O/etFgEFR1Iw
         E7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615294; x=1768220094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SLmWUlmFbL3slFSMdfLDXe6ULlPoRwYj6o7jYafn/70=;
        b=q2gfdncf6UQdnGln0TGMDS+2LOkcgsE8QyyDeXvFhtrdE5aOuNZGdtrM0aqqdRnGDF
         zAXRx1agQEtbAJUQUdXP5ENqf3+j9A8A0EtVJb+vFzWPya8C/Gz70jq9nXluNyjcikhk
         w4n9v4kEc6pI4vKztCbJfliIHzXVntvGpi0vFWI4c6J8GERKOoqheVWnKhxtmThCSWQ0
         Svpwy2Mk7YyHEWWW2QpWYy8tvQEHiV3QY+e5LlKjH35aT3PisoTHeWWv5zrEA6YoCyVm
         i3OLLGRjMEIeX/O4fnxfl6//p+CIY00xDqB/tmc7ACiQpyFUMjh5bXYpj2H7OX6+8gpP
         dXfA==
X-Gm-Message-State: AOJu0YyTWVNj63r48BnHBLwBkB/wJrtFAOcPzZ3Z8fWoGzFfZKrXw1WV
	19r6WR/Zlkl3lMMiY9PAQ4NmgnLcBQJ0w+yn11aJ8lf0Gt04AmpBTt09SMBDxelysYeNcYlRYB9
	DkZZ8XQc=
X-Gm-Gg: AY/fxX4L35tp2LySDWyh8uOojNDZQ5RqdTKNgrR1Bme5sKl46yhyKswKL33t8xFkM8x
	t4TDYQysK21etGiRP5M4R0wlkoejd2hhlo/QxKSkqClwZNJ4XxoVIDBXT+NZBO/eF1IcvQ9Kf99
	7UsBLHcDsZrFdiQ4NGFMCYsGGhHZhJ8fh7gM+u33xcM1daU6LNZaxGdRYk7snqmt89WAkwVLqHP
	SXbxTcKZyBC/1XsvIcGphWDqcDY6PMPCvHhYOkJlGzaG4gzo/CqHpKrAB7dhMvcqsY2qRWeTgmu
	lQzw6sRfZtav4ewyimRVIX7UzVLjPV/yoMls6hexpr7XEmsB7L55dLFQv8px37TOhQALpBCB9qX
	4vavRRAFvRNj9xqmJCZH8odjH02RMpyPQvm+zIcC393zsrvqTzA/a/x6gUcbAPduM7Pc5cYZPE1
	7NsCYepJ9V9Vv7CDlxSzy2hhJDxgP0HUJQb570U0x3EB2l9gnP9ZM8b2zVVRw=
X-Google-Smtp-Source: AGHT+IFTJ4KekrqpPE7R5zKi6rpMjWZ3ksJ66ODNR2SOWPXSDf0DFhirt//1pXjOGuwzpA7+5TwyhA==
X-Received: by 2002:a17:907:60c9:b0:b70:b077:b957 with SMTP id a640c23a62f3a-b8036f0d7abmr4905490466b.15.1767615293997;
        Mon, 05 Jan 2026 04:14:53 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b803d3cea32sm5367167866b.34.2026.01.05.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:53 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:37 +0100
Subject: [PATCH bpf-next v2 12/16] bpf, verifier: Turn seen_direct_write
 flag into a bitmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-12-a21e679b5afa@cloudflare.com>
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

Convert seen_direct_write from a boolean to a bitmap (seen_packet_access)
in preparation for tracking additional packet access patterns.

No functional change.

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
index 52d76a848f65..f6094fd3fd94 100644
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
@@ -13885,7 +13885,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 				verbose(env, "the prog does not allow writes to packet data\n");
 				return -EINVAL;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 
 		if (!meta->initialized_dynptr.id) {
@@ -21758,6 +21758,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
+	bool seen_direct_write;
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
@@ -21785,13 +21786,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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


