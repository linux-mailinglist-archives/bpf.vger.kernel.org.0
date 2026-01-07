Return-Path: <bpf+bounces-78111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7DCFE547
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 479DD3007923
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480EC34DB48;
	Wed,  7 Jan 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PeVMmie8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309D34DB49
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796110; cv=none; b=hq9Cgo3LL4l/EGehWzNTXpOTVXMpjIOUjSK0eZwYTkpANswmgceeZyHTuwbQXkqmKbBOwRKe7Ws1IoSgdkiiha01apbS6kfsmrUfxGde9wQojXjDIl/IgHdwW0/Z0HjsqkD8Ce/N38jVK+NyWt7CEyDaiLG7wITzbI3ewT/Vuig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796110; c=relaxed/simple;
	bh=xwrB/b5QrEV/rUuOB8P9BAxfua4cQLk+rP/xgLLeUkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8abwikaZ5HgQ2pyH5R9gilhs8PjpyifcFVG4qx1dFphNmna01p4gyfkY6X55ShlDwQwDPZkfrwD+AeOdfltNxVOGoBUvDiK2gcZcz2UD8AkjN9bAFsU29aWp3/QQnfE6tjw7Vq/0+C8G/15l/kclNPAXVdNcK4gxGeBllWrMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PeVMmie8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7a72874af1so401194666b.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796106; x=1768400906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40lIxFU/M7AeqLeGFjm5F7DuV67hMWTgLEj6ZEsO05s=;
        b=PeVMmie84aOR18+VVCpJPkosOBKP7SFjROVPvT+WjQwdPKDTnlp4rSgVZiu6WmrRou
         mAoaz2kLwMjFYA0nH5uUCqZ6iG3xfwW+pSKjhIe6uY8anxHaf8jwNbp8SJvVOO7K3LXc
         uw6QZ7wgqAI8DRcLC3mkFh7oXIB06PZDUPfkFb2BLMNQQOdl8uajsxMknzk1iwuFO+QT
         f2SE+a02arDugVE7z+TYRMg/sXQeoS2kMLemRQ+zJ0CyUpdO3v0SiSVXu6rjjzSRHOGn
         JkbHU6xQ7mEzjC6FwQqH0gUWb9VjYQOt1wrhETUutzn4uNnPaU5SxSeyDj263m8S7yFw
         sHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796106; x=1768400906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=40lIxFU/M7AeqLeGFjm5F7DuV67hMWTgLEj6ZEsO05s=;
        b=PHyw80Fwks6YicUAaGofvyYvJ7aibJqXZb7I/EVoG14/gh9rC6F2hl1SEF3weBWFVK
         kfrXrCl58OgVomfbwfWhn/V4dFM+mguUci38mC/mQAE+HOKLjonLDWMsdlrM90/DoKGY
         lyTWItK+vqQVUFvqjD/tbxdAxAVcGqzDEbSRuHAKNYXAeVoj9tFy5VWvZc793Fm43Nqv
         GYwiz/6IGMKy3Jedvp3dpxJ6edrmErEDxL9w+cBNDGK8xN1F/Us/Tc4F8ds/UoA9E/rY
         Qk9kJs5LEZ1mcznXXdLAzFDXv5muvoRLCvy9hVOnpk7yveP1C5GGVy+kqFzEkR378vS3
         HQXA==
X-Gm-Message-State: AOJu0YzfQ1rlZvOc0SZ2d4uVZ4K6Wn7hgeWKv4PwGHUXprRXwAr+Gb15
	7JIdiZxxynd+CVH+BTZnbK7l1u6JK8SbgpAMvJelkemAESX+xA2KscYyYsW1+g/zrAU=
X-Gm-Gg: AY/fxX7AL9hyKv9x657GJYUg8CYsBWLNT9J3EV1HFLt4huqw/jKfAWVCvMY245Vqm5M
	YDFVw8Q9uOuqLE1FgqgdFKPR2bml3uGUc9/10OlUZcFlBMfjJI5PjerRCAIouyF/5Alx1g3vv6k
	TO8nVyELPr0whDEokN8DBV/e6rC52xGIqHGe3jp5fRJ5zyua6spqWzoXi5RxeK7rJfyL7+0bpP6
	ofP6+Fx691vkJVFhYt5t8+r3s+dU7gZSjANfcBtqyBwCvC5vlYFJIo1iklaLxK1ddDIybRULZUB
	+/A85dfHcLujgU/oDeM26oHekFisoWKsELvcrS4e4OVinD3f1u0nHly9PNcuoKU4vPBd6fUhr7g
	8v+zAhig/Vqv9j+Q7DjBGvp9KtWCkKX/6AvvsXoZagVQlOyNeZEaqMRu1OT/RVAPvDSz+Vaj5lV
	S6EODIQJhiIs0ZLOinRg1YqGk7f5GvDEaXXFS3OKyQ1EloKk/5qExPFg3Prf4=
X-Google-Smtp-Source: AGHT+IFSbEh4/xMkvAihmgqWgevCSBRqmh1v3qkJfxrR3Zd6+maDQXuvOA7HtiqZ0/K3ds8lXmfMeQ==
X-Received: by 2002:a17:907:9704:b0:b6d:7288:973d with SMTP id a640c23a62f3a-b844503a6f6mr301552566b.56.1767796106307;
        Wed, 07 Jan 2026 06:28:26 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm545959766b.0.2026.01.07.06.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:25 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:14 +0100
Subject: [PATCH bpf-next v3 14/17] bpf, verifier: Track when data_meta
 pointer is loaded
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-14-0d461c5e4764@cloudflare.com>
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

Introduce PA_F_DATA_META_LOAD flag to track when a BPF program loads the
skb->data_meta pointer.

This information will be used by gen_prologue() to handle cases where there
is a gap between metadata end and skb->data, requiring metadata to be
realigned.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c8397ae51880..b32ddf0f0ab3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -649,6 +649,7 @@ enum priv_stack_mode {
 
 enum packet_access_flags {
 	PA_F_DIRECT_WRITE = BIT(0),
+	PA_F_DATA_META_LOAD = BIT(1),
 };
 
 struct bpf_subprog_info {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index daa90c81d802..76f2befc8159 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6226,6 +6226,10 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size = info->ctx_field_size;
 		}
+
+		if (base_type(info->reg_type) == PTR_TO_PACKET_META)
+			env->seen_packet_access |= PA_F_DATA_META_LOAD;
+
 		/* remember the offset of last byte accessed in ctx */
 		if (env->prog->aux->max_ctx_offset < off + size)
 			env->prog->aux->max_ctx_offset = off + size;

-- 
2.43.0


