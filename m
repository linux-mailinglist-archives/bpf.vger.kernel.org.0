Return-Path: <bpf+bounces-77828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766D2CF3814
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C575E30C3BF3
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085C3376B0;
	Mon,  5 Jan 2026 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JNVeU+u5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9523358C9
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615299; cv=none; b=ZbBh1KD6KB77ikQVkTlWWBvqV8VoaD1pjOtWnSeShqnkJ01SpWmAxOSJwF1COCzh/WMjlZ7XZk2eKkFIc7MIOJHJ947mKGQWT123TEFJ3k7IZxTwrJoR0osdNwoRQmnqWWx6EtDCT/7BoAhC0snk0zUzl535i9M8P3mO7prpn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615299; c=relaxed/simple;
	bh=/RTXIEaeAOB8N6tXgc0QHew6YDHppAaUiUHmnUBmhf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PjEAT8N/6S4iMat3Upnw4wv7Fc8JpdHB7c82p1El3ubjm45HWWyScAqcexIm6hQ1iLHzn8+FAHWiQnE7Q8CEPFIWZ6RaqsU/msh9zbT0S/5AhnQ4P38t/BAepuEB0JF9cq/huzOQdUZLpfnowbuiSWj2sKgUeuzpf0xIThYydiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JNVeU+u5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso1893823166b.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615296; x=1768220096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i17ZOEv88IUPvsCeeQIPsmFfWW2ihyTdJvy10I9K4EE=;
        b=JNVeU+u5fhBJdobbriv7vryU5vl5baLICKJgM/jeCqkjKX7nsalFdjkDyGHIc1vyFK
         G5DWTwI71E8sIb+0ly40Gy3Z+8X4aiBnrZjJ0jtTe12PO76U3t+kXlbgaGNkPAb3bITA
         uAs+me1TDf2f1qZPaJtEIdwPkVOv9WQqtTzNM6pRdZj/eV4sYlfgjqDmGg6lbERGgkWV
         JAEPt+HImAAhVRG9ZbrLKoG2Lagp6Dsio6hA9QOb/G+YQSBPnIH94MEleFHk/9zRO4kE
         XBqQaDggx22COVYIl3xnBQsCKLpEm7BWPEaHZN9vuB1Ptww+odgRdo+yfV5QxNCkjBbz
         GG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615296; x=1768220096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i17ZOEv88IUPvsCeeQIPsmFfWW2ihyTdJvy10I9K4EE=;
        b=iOsFPF7PvOVcQb+BX+kIjwj1HjDXCnXIyEYHJ6upymF2NvJ2/3l9Od4YI1IveYuvWV
         iunhfnL8U/e9eBY5M/DXeKghkd4LlTObJ1TZFDyJmOZV340aifmt7xiPQJ9XqBeA1vhV
         J28x9nf9XG9AzbdGO3YlUKeFEBdASZTbpHbpBkzHlLrokSrK2juRGRE5nbmhBVMda/4B
         Pgd0dD8QEu+2z/Nxpni9ZCG6Tfp4sJERm1CIm3cTLUcjPOLSBGw6txcteNKrQ7dMD48+
         TnZL9pHhyhqZV6/Px16UHq46zZtJbGm54jjmW9MIw95JYJM4jCE+IhAfRUZhH35SQCng
         rD0A==
X-Gm-Message-State: AOJu0YwpdtiFuFumU+wtV/Dpamzt98tUjGFcKNIp8EGmYwSentXfV6tz
	9/olAPcYO+yigAR13oQF0jOxv4c+ucSe3UnjjeZS+1Rse+gnPxRbrcSTjMScglLgCrI=
X-Gm-Gg: AY/fxX79YFivtX2y/mjr1mcyiQzDTSmgxEp/psRR8rHK2jATm2MBuDsDs+wgpQ4iy+f
	Xa7jU57VpIG1rQNTEM1yzsUt8nGkM69PhfA0cIa0hrsyNhD0Qk5ujxiQKybJwewRJRNhzcuFq68
	MG+iqCMQECsIkipMp8o6mwHZZzGweDKTPVqSzxZMkq0nnWPOuTEQEZdBBMZLHjcIGveS8b2+DzU
	HexRGHV5PAhnvmvcxXe0jUqnhONS3nFwllHIPglMaJFZuci1SXdsn9fljSXoreP62F5srmpDrbF
	2oXjmP8y6W0pV6RY5b2AJoC452yjseFK+oV0jqqYQckgLej3OfvH/42i1LSt7B+axB24o02TN3r
	Yt1KafJ4ysKuIAeF9kfAPuK47f8GUuw6lp2FYhctMMUS1Iu1KGaNZ36UYRxTBLyvGRB/fPWoybT
	QRIFKDfaYs/Dd/+CYtX7pBw1ImBK4k5u6Dke0GCYoDiVhUHTsGjZ6GkbO5hWM=
X-Google-Smtp-Source: AGHT+IHFtAXT8wrbFXnrryfLVZu8ll4KpRHg/kmcKQVowTW2A8nxw6/HzXImIkzNk9vZ0ubPmARkCg==
X-Received: by 2002:a17:907:1b0f:b0:b83:ee0d:e03d with SMTP id a640c23a62f3a-b83ee0de13amr577260466b.19.1767615296321;
        Mon, 05 Jan 2026 04:14:56 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de1421sm5611280866b.41.2026.01.05.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:39 +0100
Subject: [PATCH bpf-next v2 14/16] bpf, verifier: Track when data_meta
 pointer is loaded
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-14-a21e679b5afa@cloudflare.com>
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

Introduce PA_F_DATA_META_LOAD flag to track when a BPF program loads the
skb->data_meta pointer.

This information will be used by gen_prologue() to handle cases where there
is a gap between metadata end and skb->data, requiring metadata to be
realigned.

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
index 558c983f30e3..1ca5c5e895ee 100644
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


