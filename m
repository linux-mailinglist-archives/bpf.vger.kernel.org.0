Return-Path: <bpf+bounces-73715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC52C37B65
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89AD24FA84D
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F134F46E;
	Wed,  5 Nov 2025 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WfPzwjfo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD004341677
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374014; cv=none; b=TGMffuaV+jV3zCQwMRJJmxICEJ3PcPnfDzerk50NSwZujcITlPGmucgkuf7HYCFZcaNbFTyGaj4zQuDppnqzdQl3iVyx8vz481Nj1kRPfbsOUXJbE/eB3r2OtCJ/Ri5/WltQmPgkTU0nwAMHHEbFwe8eBPUwYAiBn2PKeTqajpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374014; c=relaxed/simple;
	bh=yX6S3LeBCe/qGD/kjGr66cS0rg3xyuUfRHvFHBmpNRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCncbG8/l/msZHjWrODjJoo4vHZMiwvGr6DA6r36aAp1Bjj8ysVP80DGaBfiOlHh8pOA6PMYe8hp3SsxeYqU3E8AI+WFxpLcs4MXz7567Umtvd14OwnNbtQ1H0ZrNZevWMQY2dthKJiLW8gd8YEjCej2sJxVMFBB6jVicKr4jOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WfPzwjfo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d402422c2so48220866b.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374011; x=1762978811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTKVpAsZWOgfkTqkKtVnxh+VrP5InzZE/Rk0DyRN41g=;
        b=WfPzwjfoJD3w/NvoXL9yRUPHPhgbRasefFk6XiOta9TH5IdN+7HYbibXQ4EnXwTM5v
         iOypoPC26xnSYpN/LpH88ZPh6ZIen7GF7bMCz9J6dl2W2nbD6OwdpAh2jl8Csk9Ozq6Q
         2Nia8Y2U6MmCe7j3jm7rVVqlqkm0HYlNyMEmyq2HIMfujyhBHWTyD0GfgTP+V1EOQJ6O
         Wytzl486i1TF0/lj9hj1tyux6qBF0FwsrBKWmfgLILOyk3Xy6NAsYqT5oz0aK7pva3us
         H7TyYA5rHNBul2ZHjsT9kKGMP1kES2DTGVglR4qG8ci6vkzlePj8foIf8FVBSVVFXR3M
         hfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374011; x=1762978811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTKVpAsZWOgfkTqkKtVnxh+VrP5InzZE/Rk0DyRN41g=;
        b=dKgr9bPUYyC4iJ0458TfjD8aPmt25YDQ99z4Nt+c2ik4vdbJkvJY6xrEUfWb1jQ0zQ
         urYbZyO0s9no+w7UKSGy1QNx3Y9KVo4Y5sXtCkVn9KxvkEWUKrETdQhEBkID+YyGxkHg
         I3Rr0S8FSJ0tzB0W4qpySga/OB6/r9WiVu59yGcoPdRrkWvySIyENqqlugLZw0fZUZxy
         BMpQS3C4GqiltXJ0NzoCe8WX36Tk0T5b0p2HTUI7YeSz8Ko523M6MAwjweGk4tx9OR0X
         vmhaiwBJrVRFhB6tIAxV4pFM5KnhwneHv2bnMBe0SEHozfOVpiFPQf9a+yL3xbL249RX
         rQ7g==
X-Gm-Message-State: AOJu0Yx2MmuG5b5mwlZYiIyNxnYdzB957ATBR6rN7YAXWSKrxUW27mAa
	tnDkqwJmslp13f9ttoKDe0wUJTICel51FVc7QAMtuX+BxGeNv1G3InYD+87Xz4zdMb0=
X-Gm-Gg: ASbGnctuq8TUbHiW3IlR3Hl7Dn5u4valwyYzP8x7nO6IC+jai9K/Wbg/mfP5+vzHyTS
	cprIg6E6EOuAiVoOXGgUT1r2PAOfybrOWY2D3O0+guyidxVOhXyxbQvvwpkmvEhiQpuxdj9pBND
	X5Uiw3Fs+ysaOUBj6TfIcIdGkyqk4hJmRpYa0xal0Lx5w08tgxUye++yDLZcrVVfTnpiW6twohP
	hTT6sa58VpLEfikKaGiEkLj/HgqrNCPFl3bNTrSIl04rnXuN979TOxhSX0sZgErfhAutT+kaFeI
	fpEL4rjF7wlJdu72o4SGE5Dh9Sr0NiN/9eOLb6dHx38/GWwesuDabddM7SuNkCfG3nCwwXht4lv
	5JjfntJZES+h1qoMq3On88BzqhPsYycITL2CiJtb4g3SJqtojUUR2MBkiJWg9Lwh1+3afD5LEAA
	rQTLPIgH9vdG5CgdRjAi5G6fITk9ZhP5iy/0d18jOjTHKw3w==
X-Google-Smtp-Source: AGHT+IGg27dlDSbiWVRbQqy3px3bm8d2YU3mKmAc2pRhQdIoGpvqtSgKzi/IEON9rHE4kmOeiO1W/w==
X-Received: by 2002:a17:907:720e:b0:b65:dafc:cd0a with SMTP id a640c23a62f3a-b72655cde5amr403511566b.52.1762374011046;
        Wed, 05 Nov 2025 12:20:11 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c7991sm42275266b.71.2025.11.05.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:52 +0100
Subject: [PATCH bpf-next v4 15/16] selftests/bpf: Cover skb metadata access
 after change_head/tail helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-15-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Add a test to verify that skb metadata remains accessible after calling
bpf_skb_change_head() and bpf_skb_change_tail(), which modify packet
headroom/tailroom and can trigger head reallocation.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  5 ++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 34 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a3b82cf2f9e9..65735a134abb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -497,6 +497,11 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_adjust_room,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	if (test__start_subtest("helper_skb_change_head_tail"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_change_head_tail,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 6edc84d8dc52..e0b2e8ed0cc5 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -611,4 +611,38 @@ int helper_skb_adjust_room(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_change_head_tail(struct __sk_buff *ctx)
+{
+	int err;
+
+	/* Reserve 1 extra in the front for packet data */
+	err = bpf_skb_change_head(ctx, 1, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Reserve 256 extra bytes in the front to trigger head reallocation */
+	err = bpf_skb_change_head(ctx, 256, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Reserve 4k extra bytes in the back to trigger head reallocation */
+	err = bpf_skb_change_tail(ctx, ctx->len + 4096, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


