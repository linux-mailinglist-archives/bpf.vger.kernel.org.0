Return-Path: <bpf+bounces-63458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A49B07AFA
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2295D4A2A64
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92832F7CE1;
	Wed, 16 Jul 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FCl01u+a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37C2F6FB6
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682689; cv=none; b=HL73XsSjmuBX3ScKwMKBSpTZ1jqmgv+pq9KZR/43GESfUXoD0G0rIAUxq543/4WrascYz4CPik2r94/XsOQAPIn9k0DHrEmNtl2QUR1Iy4lyySB+tOnvV5t9/EcsGfscZ9Nmviyb7sgq2OKRJWcvtcGHlT+lz4ME8o4gDbLDKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682689; c=relaxed/simple;
	bh=5sucfcekR6mfS933e2rJSPc+7Q//wV1KFm98S+aVSG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZ1N75n570h/Ynq2LtP/1dJ2vWrQF+o8HdXqKYL6UXSiNIYZermBCB4P5PkBfFdI0EM7db8kj/Tgl4p8dZ2SVIkOPAC7a7nSr5oMqXou3XgkxANW7rP+O4TTK4DPL5TLrqoh9LW4ha/jy0o5yiTr3PSnmLS7iKP/1/s8EeVlAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FCl01u+a; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5551a770828so59416e87.1
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682686; x=1753287486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mscKavLvXzEa+mVaH2owrKNriHucVI9xry09mCnttp8=;
        b=FCl01u+aZlQ3fjsjSqydgsAbBWLm8G6urtxaOJU1Pd6oSuMK2tfXoe8lDgdLVCvdSz
         1z0WYKbaaJpM8wq5P5/ce12dy15HGozP7h4s6jYvxZ+qv+se9vJOwX4jgfw1iNL4dALM
         Y/SzUlTgYhA59cs11yE04ryQ+jlAY5642MHXVCl4aDf9b9Rgf0KrfkpRbD1pNnby3GL/
         FHQlR/jSxketZAjiFIFI+Do0o9DtKkejFw33JoAY6WYsUt64qRsyfERK+6ePycUkdMvD
         PLc2BbMHhVuIN10tD7u7hSE57ZgJ31fuCmiluA1xVB/ukCfnHRWBLNAJjDEItxdfOGjz
         6+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682686; x=1753287486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mscKavLvXzEa+mVaH2owrKNriHucVI9xry09mCnttp8=;
        b=hhI48NsetsQWirKyHoXbndfs/0/A63WD5bZasV5e5rFOVPufFe0Rl8UzAVbimhDJO7
         rDdn48WjR3umkopitmE+/BV9JI6Ql/k+ZPE/Y+3G3iOrg/J5JQVR45oIYDkmTo5QCV1J
         6niXEf2frlk6fTmOB5vHFwOpgTZufeofY5ahQYm+Uaiy09uUhqVwdQlOMKQDVJX4glWW
         dm5J6sSwv+2joleHIpBfkgrrQ3TSC9DBc2T/xbCYM1GZ+TrWzgwJ/QtqLBa1ZEzhbUpL
         eCpw2SmB4o0vnw6poucOiWvc5ccr4YZFgNntKmtG3Yzvm98LL1ZULZEjnYrZrstK6YPY
         XQ2Q==
X-Gm-Message-State: AOJu0Yy97VhALFJSojO5kvGosppimLLVZg2YXCKs4mMwODFhgvyw3HMk
	63tUacRrWSSezp2hjxdVRhsOrrpVRXo6rlqCq+bYkfDdUxVITedKkQMqlAS/Ys9GJQo=
X-Gm-Gg: ASbGncvm9yJoqTwXkeFYwilbPWeHJwTJTUFGZ2U8GIStPrH9hlgpAncy8nlz1zvk8a0
	4enMXlnlXmJGUysRGrodkCliPGH4gPKKGg0k87qG1VZfw2AHPE6en488E94KjmKgVcGpa7jkVV4
	GZRAJCtcN7cZ187KWDKX4EhF3tNYiS3AE7K6i7zf6bkJ2N0/ENU/rIC18FqLIFlm7QIQ4QH2yaM
	X6b9AA65RZw5UVh4vePOtR77/lVc39b5jnBM+gqTkSMcWvThsgxejrRZIIk5w7NzC+SOtWW5US0
	sYE6Npuvsiqr32jGc0WeXajYsB1DVc+Db3ukFCRZVZMrU6Uw5i59xckEeLc3kihLisbl4fL5naP
	51f1SEqFfe1DvqelrMnNza+BLtov2q+lOAzXlmJgClBRXoqd8KGdAMWa8sY80RLwz6Ziv
X-Google-Smtp-Source: AGHT+IFjtflamFoKYfoz1skfosfmwqnMg77UKVFe6w714iNatgB7qs8D23wsFN7sbP5g2fwixigK7Q==
X-Received: by 2002:ac2:568f:0:b0:553:2450:58a6 with SMTP id 2adb3069b0e04-55a2330100bmr1186433e87.1.1752682685644;
        Wed, 16 Jul 2025 09:18:05 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0b42sm2703689e87.136.2025.07.16.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:18:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:51 +0200
Subject: [PATCH bpf-next v2 07/13] selftests/bpf: Pass just bpf_map to
 xdp_context_test helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-7-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
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


