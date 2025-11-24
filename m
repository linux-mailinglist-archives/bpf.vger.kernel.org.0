Return-Path: <bpf+bounces-75364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1EC8193C
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F6F1347849
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38A31AF3E;
	Mon, 24 Nov 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Gj9rRbGI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA331A548
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001771; cv=none; b=YOxtg+VDoIZM48w0q1G5di/po8jInKuzvxQnJeOO+c/7nN/nptCMstgB4L4V0iXkb6Jwg/oguHjV5wM8TS3kijOUFk5AtF6BXdCI/pJl5hunPd3/204v26W1mKBc6zsgelHcg43ysEPVXqfXgExSDPbEPL8eKd3Cczyz4O2mt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001771; c=relaxed/simple;
	bh=gn3lwu0lwNNZQxYoDTnJ3/kNnMccZeCRcDy79hG6uvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZaTwrdtlgeRhUbAPDVHLyK9i8icKHYdI6WXCO5v8lo8nosz1x0E2A71zHxRz8XQXCNb57FsA+glyffPOQiFD8yliecrwPh+W1Xx6xwFq78TfmDUoYa81mzSZb0kUFni4RIN3j/evIrPKJrx+cp1KMIxxwkAfTwdbs1ri6lJ/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Gj9rRbGI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso7539193a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001767; x=1764606567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcnZA3oocUjPm1Pbs0JivQauclUVtFumqh9U/++qzrg=;
        b=Gj9rRbGIcUphfGlsDFaA9dVmOVMIPWugIYQsslLHRV1yTigcmbWBOdUAbcXR5PuVUR
         JI6mUc0/pBioPw1DJ/j6LVjpom3QJ/fMkJdXViuDDCZsuEGETDko8rTeM+Mo7a38mh6K
         7W5Ii0Ed2CPKJW9c+dmzLRm2Vlva3srKvpgdYrmc+91/fu2kKZBgwUAaWAkzG/G8Mwz0
         6vfGDeguCqSAwCCIYpu3A65X2RDt+XsAoTx8n+OFLfcf8aLQQdSPw+3FGJpRA1TVMR+Q
         xyNTy93C0RhDuDFjCu8UCRT+EmMY7d2uhxOLK3Ep11G5+Yf7sHQnnnEco/sixglNzMYQ
         /x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001767; x=1764606567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WcnZA3oocUjPm1Pbs0JivQauclUVtFumqh9U/++qzrg=;
        b=NOIod6XKruxYWK85dDAgGa+7L6rVWTTnwhB3osPby4lum+UZRrKgCJzWi+IR0Nyf55
         pWdOlYX7rvcxuNrhVg4cAROaGh9QSnN29/IYZWEZLSYGS5A30JRl4Pi+E7pNXvDnAwoi
         g/nnub2m8fL2DrPs0WsnaX7znCVs771Hr5ICSOdpYZ1lf92f3YIvFhe5KPL1x8zcA0Cv
         fVb5YxwYUIb95ErXW6a/WF7U3UcLJyxfnbMaA9AGkdq9YwQp/horJOAXeYD4VgboxzYq
         wTTgh8pmRwjZWBC1Zhoy48F6671bmVM+EBewtiOeqzHl4EuwD/2vxFSoAlNT8pXi9MHN
         xw7Q==
X-Gm-Message-State: AOJu0Yw3A2L/k1nsW8VhLnIpgyyR1txd9kXhocFtqdm7y+ty6bHX42RF
	6SGfiKR3iuIL9vgMENZ76MsdDOoHMWUsGC3fjYsmBDh1WvkJrThGj0XHp4DhhlZspH0kUolpbmp
	4SFkm
X-Gm-Gg: ASbGnctNk54DDLGcacAR9s3gKXfEKd3cjmGqYVby+661zTD/O0G+g5nsJkq6UQpC5Rx
	9XclCjpkORPz989FtTdX3H8YMzv/f+KkiJIxSaV+USlrc60oQPkAeQ2L02WVbyqSydO03/X82Y2
	fpjbOa67KqChsHy/E3z8cf3zaZElFlBcbM8D7kLS/ogYGWCBassyeMY3EYm3QBBiKdFgLMgivVx
	a32HWZPYyQsSE6ePq2Gc4OzD/DqhINcDNxb7gm19d+cN+de5G3JN2ppo2dO6pb0plN+2Hw5sk/E
	yPp9YhQZ/6c1I5rR6kg+IROWSciIsRA8id2fGGgJToLx4yFXHLDRNG7F9x32YanecKAi0wyWzxg
	yV0mYu+cEydoZAbVbVRBL6Vm8CRdP2nz58CriWvnpoWhZeshkiYKJRkzED7fKZKEE8zLMlNTWmT
	7cdTgubc8+IOy7c1DXguP3ivZ4Tmbq+g9FJ2+30D31nI1y9Nt6m8hWEouw
X-Google-Smtp-Source: AGHT+IHzHVKZgWlwFJNITVk1pZE24H5+ccpjEjWf8TxJm96X1BCpW4pnpkDGeBI3dUiPPsjpQf2KLg==
X-Received: by 2002:a05:6402:27c6:b0:63e:600b:bc86 with SMTP id 4fb4d7f45d1cf-64554459661mr11495118a12.14.1764001767493;
        Mon, 24 Nov 2025 08:29:27 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536460ee1sm12393313a12.34.2025.11.24.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:27 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:50 +0100
Subject: [PATCH RFC bpf-next 14/15] bpf, verifier: Track when data_meta
 pointer is loaded
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-14-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
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
index 42ce94ce96ba..fa330e4dc14a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -639,6 +639,7 @@ enum priv_stack_mode {
 
 enum packet_access_flags {
 	PA_F_DIRECT_WRITE = BIT(0),
+	PA_F_DATA_META_LOAD = BIT(1),
 };
 
 struct bpf_subprog_info {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb4e70913ab4..32989e29a5e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6160,6 +6160,10 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
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


