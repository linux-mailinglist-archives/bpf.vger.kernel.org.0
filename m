Return-Path: <bpf+bounces-65625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9860B261BB
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010845C36A8
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3CB2F99BC;
	Thu, 14 Aug 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GR28qlTW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E62F9984
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165597; cv=none; b=AdF1N5uhP6BpqYKsMtRK2SZR+a3PC+/64asjZGHsvREiLsaUmV274TiIF7qS2djRiBY70ciUpeZjsEMja7sRxR0+OGMHCAvG/nDb0mMcr04sRbbhGseiDvHxjAQFp9BjJBT3KmZSfFsmXlDITAhFRju2bJOdHnw5r4fOzsfeyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165597; c=relaxed/simple;
	bh=6lefPy4pLLhuIjRSarK/JZllaot0EAvW9lX25Tym5zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oZrw/iOgXcyH+YF9vk5aAcnPSYLOkUp/7ocXEP3ydZRoL9U8Wp0YiLNjfazqpnOotpGDFvZ1C3OHxWYJ+mqj8aEJvzzyCib+3poCIkVRiG6cJwocQO6JmdZPxJPdWxVNNNnqHQyo9ffoWsp0aa6f0imxsQdlt3xbskzHX4Ecrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GR28qlTW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so1164164a12.3
        for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165594; x=1755770394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/WU4t3bXNXHytiZBMYllM2g5xtPpYjdz0N6ykqxU6s=;
        b=GR28qlTWhHA/enY/Y+C9fgx6a3cXDfuSBouZwVg7jXVvq3DUbQXrDiteSTOSW6tLGN
         /KrPQ6fdB9A9FgXOVyMwq9Xq/k30QwBwSadLxuuTnmghzfJbLIufSnDhjuJFt65XWX1K
         HJcEOVm5sHmNUcd2kTYOaIBMLOoAIEUY6bJWkdVgEz7Chbl+0s8k1jcAHBH1hbnDK1ep
         gXXEio+HlfzBKEDq+5IhYOOV+V0MxIn6IuTTnw8Iq3RSuD72FuDbezfJfi3J7v6g308E
         tp6lSlGWFuVoszG94+GN4fvUzLAMcT/3nfXLcor0lBfWlgtrE+lhNAE6K4V9Xy5bi58v
         AU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165594; x=1755770394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/WU4t3bXNXHytiZBMYllM2g5xtPpYjdz0N6ykqxU6s=;
        b=S7CQnESMjokIKSFcaDpVoTz3CBLKG+XAU66N5JkkGHaLy+00MeY2UhC5e6c/eypNmW
         ntF7HyVCqePpyCB8YtD78LpUEh+3P2PSjXsVo+biLATBB9oJkSGsvhPvTrKaPMsSBz9A
         WZXVjrv2vqumqbXhHgXep4LjiMOpvezva+m96f2dDkYiLleY7eWwZowpVKQwCwU997YQ
         NRBYptOFwMPundmml4+D9+UVENqQKl/ENXvSP1SZyoXDdhNibxEpZ/Kf/KhXH5tK52uh
         rMHnoiNFHKCbLevz9MISXRHPGk9xaUEeUfz3+Ur2skBK2VsRtfFG6Bg3iVIvhuuA1s4U
         1zXw==
X-Gm-Message-State: AOJu0YyUxOD92NPVKULM3yFgrXFu0IfmTxuruq1u8h3ek4nzklDaU8Zn
	98PTRf0NmRZGPKvPMO5L3AqhGBCVpebcHqXHzbl1EyHPQgx/mXee/5LfXD8Zzn4CbeM=
X-Gm-Gg: ASbGncu9A9dYBe99qZ3fl28Y1MgPs4s19oaH5yMcsTS4kpWZ44wMAejxynxq9o3sG/7
	EYaG8XwtG9S+wa3no0D0plRagLKCBczL9UlxJeUkClQh3s31L9SMOp4Venbr4Ud423guvzNTWET
	y9us6b936yDCtj9h5nBklL2eVIe0COv/FO6qING7jvzUjLwy+JPbI9htTF+3WjJ8dBy6tLTEmI7
	32HAIQiwBcmo9tImoLrsdEdDQgxMj32eb290g2BvQDqvQdPwE2ZvX6Nhmw89xREwJIgFdv/4hgl
	sM3PYDa6j8DSUwDNgEStiV7pbyVAeOlJW4G/VLOLmKJWn4Ce9nJlouKibKGIfIvhg3SeQDFU+W0
	6RemoI2AvrbV/PMMGLzyF
X-Google-Smtp-Source: AGHT+IH36/n02R/i4TJC+1iQOV+OciBplBbdWZlg3xnNgH2EIEvmqL02LRuqsZ6bR1XQDtsMC5nW+A==
X-Received: by 2002:a05:6402:354c:b0:615:cb9c:d5a2 with SMTP id 4fb4d7f45d1cf-6188c1fb55dmr2080133a12.18.1755165593455;
        Thu, 14 Aug 2025 02:59:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61850794509sm4631499a12.31.2025.08.14.02.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:59:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 Aug 2025 11:59:30 +0200
Subject: [PATCH bpf-next v7 4/9] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-4-8a39e636e0fb@cloudflare.com>
References: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
In-Reply-To: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Prepare for parametrizing the xdp_context tests. The assert_test_result
helper doesn't need the whole skeleton. Pass just what it needs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index b9d9f0a502ce..0134651d94ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -156,15 +156,14 @@ static int send_test_packet(int ifindex)
 	return -1;
 }
 
-static void assert_test_result(struct test_xdp_meta *skel)
+static void assert_test_result(const struct bpf_map *result_map)
 {
 	int err;
 	__u32 map_key = 0;
 	__u8 map_value[TEST_PAYLOAD_LEN];
 
-	err = bpf_map__lookup_elem(skel->maps.test_result, &map_key,
-				   sizeof(map_key), &map_value,
-				   TEST_PAYLOAD_LEN, BPF_ANY);
+	err = bpf_map__lookup_elem(result_map, &map_key, sizeof(map_key),
+				   &map_value, TEST_PAYLOAD_LEN, BPF_ANY);
 	if (!ASSERT_OK(err, "lookup test_result"))
 		return;
 
@@ -248,7 +247,7 @@ void test_xdp_context_veth(void)
 	if (!ASSERT_OK(ret, "send_test_packet"))
 		goto close;
 
-	assert_test_result(skel);
+	assert_test_result(skel->maps.test_result);
 
 close:
 	close_netns(nstoken);
@@ -313,7 +312,7 @@ void test_xdp_context_tuntap(void)
 	if (!ASSERT_EQ(ret, sizeof(packet), "write packet"))
 		goto close;
 
-	assert_test_result(skel);
+	assert_test_result(skel->maps.test_result);
 
 close:
 	if (tap_fd >= 0)

-- 
2.43.0


