Return-Path: <bpf+bounces-63903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2BB0C1C6
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EFC176475
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619829345A;
	Mon, 21 Jul 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FY892jK+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5F28DB74
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095215; cv=none; b=BLr/7YPHZsjoPcFX1JGemV4SVI/ctXrv68+lF/9nTau0ZmeoGEgoEgBF/aZQsMmol8J+yt8SlOSphBZmmK2LRA6yEgJ+PrJIiM5vftV9OZzb8SIeUKoxngYqpvrnzIAeaz5PleQBIhEZW49XbhBZoce8Ca2jTuZDqoDhRzoY0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095215; c=relaxed/simple;
	bh=5sucfcekR6mfS933e2rJSPc+7Q//wV1KFm98S+aVSG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHRZofH9PIy+E0mYIHXX3v7linS+JlkrznIejvBameWigjn+Gi4/IP0fzc37OzsmVumzF6bNqhRqM8MFHRqBEuO1HYqFTXyD1vpzapgWQ4kS1ualkGqjuxsm9zfpkS0PR1isnhz4fbOXvp8im31Ryn+dA2EPZFVeZ9BxVKD/01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FY892jK+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6129ff08877so6549723a12.1
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 03:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095212; x=1753700012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mscKavLvXzEa+mVaH2owrKNriHucVI9xry09mCnttp8=;
        b=FY892jK+rVLcpJVaOMPuGezQUPMjYZ7vkkvGmpOYG+v8tBAMzxiodKPvtqCnx+GqwN
         Wq4IKM5Y7cNobnk02M+Nzd11x2D5762lMWqp8mxXasPMS1hM/0VHraEFA8f5iSLHJAhx
         VUakKZcaQte5+9tCYmJOmHEgx0Vq+O+UQJckM5lhsiji1qhCi+ZfiBJmoxaQj6pGXJ9p
         iaT75tc920x+YCgY1AoVLdhyCjJ8Hp23sqwWq7TJP1muv6FjT5Z0xwN681xlH/2144OI
         XYSWXtXG78/prtmduH3U30PmNtQnUFvXAL0fRrEGkfJCXnt4PaBAjADcqh4viE5XHEGe
         wmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095212; x=1753700012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mscKavLvXzEa+mVaH2owrKNriHucVI9xry09mCnttp8=;
        b=toJuUPABhNZpsGOLgVZ+DCVcyy3tMxnzmgfkN2iKzSS9Zc7D8FEPpR33nzRTsQpfC8
         lx5/A/wWuZIzZgvIAgIt8OUHiAxhxzRAeWlSnMUAHgPsbYKrdm70jqkU5NAIrdSoT11b
         f6UjNa2OsMbHbRZIff873GgQhssQ77Nd/rvpZRMMHqff1QDa1fJaBd2VLt8FQ0k474Bm
         5YQs9xsEzgCuL0QYcEHOm0qmmOFB1gv6wsNgpTb4nPfDm5Nc3f5uK/OSDqzuACaGwoA4
         dAo1FdtVQFzrC0v8cv88biS2l7F1DHuxFXIwA/RgXs+G8N3s8KzT3xLXdY6Jza2FyBZt
         gw+w==
X-Gm-Message-State: AOJu0YziF0CGwg9WQ2Gqbh9GkCaOwKVS5gdWnJ6/PkVylvPP+ORECSMj
	oMK4Gr2LI/h2LQE9Y2eblnnhp9EjbvF9rbDw4deMLINxPjwy5wveCPjMiLNP6ILr3ys=
X-Gm-Gg: ASbGnct9nsTlvzfNbM+neEw38poDF59Gc2uV5uw/MC2I/UiW160nr7HA+DcLYOB/L8X
	PsylpV+BhpOzmZlTizXNI1BU4VBO24NPJ6Sqz+myEkZo8R2sZM0p+0Xsz3xsNqiwRhL5AS9Ll4p
	PmRaDl2m7/WvV5YG8KZA+6UdTffvmYn7JFCtK1IGoBmdY1zBaEOSFOZlNJnQqINsWM3WPpeSoeK
	HRiMR3D33Ki0SJ7a7/AEDMONUJCBU6MXrYtLARlBN3J32s0YXtKl+oEjftkfpa5W9TQuMNa+A+H
	K2IE/+0UEp+q8t7/CT4KeTpuzoRBazIXwgyoxWOC9Lz6EjK50/jlzRSFV+1ML8hVj7kptQrYuPK
	2L6vlmqGX+OzLErI6zoo+O4Fx
X-Google-Smtp-Source: AGHT+IFlmBK7f7eATyfPhF2tYq1BuV9PITVAmR+lWAHE4Htw90BOwNnEeQz9jElL0FXRkomKLQehng==
X-Received: by 2002:a17:906:ee89:b0:ad5:6174:f947 with SMTP id a640c23a62f3a-aec6601cc5fmr1177346366b.22.1753095212127;
        Mon, 21 Jul 2025 03:53:32 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79b8bcsm657255566b.13.2025.07.21.03.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 21 Jul 2025 12:52:44 +0200
Subject: [PATCH bpf-next v3 06/10] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-6-e92be5534174@cloudflare.com>
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Prepare for parametrizing the xdp_context tests. The assert_test_result
helper doesn't need the whole skeleton. Pass just what it needs.

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


