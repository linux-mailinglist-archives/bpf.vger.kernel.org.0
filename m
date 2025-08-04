Return-Path: <bpf+bounces-64994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12DB1A265
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6A181DBC
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD7D25CC73;
	Mon,  4 Aug 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J4vbHe/Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081226AA93
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311972; cv=none; b=u+mPMOgbQUE4cgqqQOUuKHkFPcMimVUaNP3s5TLHqrweBYqdYQlKA8n/P8uQjastZEy2w+glRVoWGteewUj7UCgIeizIPTGfpvpyoSU4kqVTE6KX0bJJgaJlsUARY28o3p0SPS1w4/bGoKd5Vx6NdhVpxGMy2VjHDA0++GWB5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311972; c=relaxed/simple;
	bh=6lefPy4pLLhuIjRSarK/JZllaot0EAvW9lX25Tym5zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEOEFvXjPSM+UxN/PU+HCIejmsx2qEVJJS5ptjNeBk8I6yXxRnwLt/5f9Nc7GJFpOy4ERqTO5ruOCxPC3Fh44yHUkVA2008HL72L4dOdZ0Q3TLbo+EA0oOEl4ULN5aGeOwmFq4Z73sHm7QrvbRWFq+B/OKziu0Vk7mnw7rmx+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J4vbHe/Z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so7975810a12.1
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311969; x=1754916769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/WU4t3bXNXHytiZBMYllM2g5xtPpYjdz0N6ykqxU6s=;
        b=J4vbHe/ZL7/J8OKlDoKZY71KExlKoSlJVRoqPP1bEXEXc1GcfRYyumK8ox0azHvokV
         y7bN8gdTTB6oJD7oIulnQremAAKdh1lpKULVrh2OkoobHbRvnKZIFUvW9rPRFnfZ24Y0
         mERI8FHxudiAwdlwfR6/XKzX5i56a6YFZSRLQsVLXjcBedFeO4adz5TWZr/u+tnnwwVr
         m2L/5PGTmECE8Wna+NaiQk+nu+IJK64DA5Gtk7nSBP/snblixfZkqwqtHY26RplupWRI
         V4tsKRGB3GJHKW+67cuYSGPlY29J9hQ1K5GUdSbFyX1faH2O3lAtfiF98dfLKctOjZ3f
         Luew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311969; x=1754916769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/WU4t3bXNXHytiZBMYllM2g5xtPpYjdz0N6ykqxU6s=;
        b=A16qvKP6Gb6annpxt1YQouE3rlmiljQHj/DUQcmTRBunQx59/37cOifS567se1nJRg
         A2AOaaUs10ymDYiFfl39S1d1ELHgLsTNrpC/QvV8lFynyTiQxYRll6+spb7JxnjPI6Zm
         0kyu7Z5qKZSlH0wJk/esMmfBbTCsoo1uFIdMeZuq05ec6rxlmT2l9czHTfOzi1wsM4QA
         c8L+D25qmQb4D8K9gCMZuFMaTEnvjkxC8sEqPvjBxOq2llYFf4OS7Ih4UcyeOUDEYo1Z
         M99UW2UIvN+f39XV0e94mHE2KqgWfwHUrg+ptkw1Si5HNNb2+UbGry3yrmwlvANU5wAf
         zijw==
X-Gm-Message-State: AOJu0Yytf7RxJLq5VplHxyOLAUNkTsfi5DnGKSEUESSkpBWL0gdPnvgp
	UKeIxxCdP98Ct1DSOrsKhNWy3LWN8oQwTZrAPKe0uweEYyfBtqJGJJpsRGRwMSVGwQ0=
X-Gm-Gg: ASbGncvWZox3siY59U4BCT0Va6Z8YXQWyhCpEc4SepmE/5VwRSL0qc+XuGOJk3dT8LW
	7kevUesrq8PJbdarLWgtN7UCspYf39S1DKnZ+gYIwFjmz7o48SBhLlZtuEXqaPfY5afncnP+gSJ
	sA+yh+S/YzVWnBdejBNZu2kjQTmk9BGDS3miAJKCQMJYLXF+yMlWqdEUAfjKuVzMS580NUK5JLx
	LwSpWOiVnc1r/13CVHvtNFRiFPCJqlsFz5OlqtMimcZa4kaDHp/m0ZsmAMMAVM+nnatwUMvfrxy
	RDdjtJWX54RD8VV9+gdk4FlC/4m9b6zFcJpK1DZhVk2qOVdtAH32/K12ELm8p1PQDTpCiJuAhnP
	+FP7l9ZOkNqN8teJcReZAIWBFkD3Apww=
X-Google-Smtp-Source: AGHT+IEfpPTyFFbmTF/6DFCWVoHGaUnvgU0T/VegyLYr95hHg/CK0+nLYYbmq3YuwXebgr7Qw3OkLw==
X-Received: by 2002:a17:907:7296:b0:af9:479b:8c80 with SMTP id a640c23a62f3a-af9479bb167mr787413966b.4.1754311968955;
        Mon, 04 Aug 2025 05:52:48 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763e4sm732092266b.1.2025.08.04.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 04 Aug 2025 14:52:27 +0200
Subject: [PATCH bpf-next v6 4/9] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-4-05da400bfa4b@cloudflare.com>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
In-Reply-To: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
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


