Return-Path: <bpf+bounces-73713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E784C37B68
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4EA3AC55D
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF4434F244;
	Wed,  5 Nov 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TWKJnZQ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12A34EEE7
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374011; cv=none; b=qaJ04ZFJAa4LtLAA8m91aV8BGmPE8SG/K5kYsW0LPZlC/88LhjMomkGaIi+pCzcLM0jPyK9PnKLIadtbNlSefZr3R78MTpJTXZsfa9KTbHgV2H0xVpxbiusoVc4UwKj4ME3cavDmR2Sg/ti5JqHkvMDKrx8XVs9Ymgdc+hRyInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374011; c=relaxed/simple;
	bh=uhu0sRpXgug9K1t55YK9U9d2pdZu/7f5aErzrjJKfwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjjxoQ5VTXbSCP1TX9VYjqMRDkWToWwelxbmNJ/n5vXuAuFBSdZY2Z006sbkfVFF3gQrpplaKAh+4cdcDduZ36LyQJjmwBvSdyAfPGD4B9BxpMMDolRIEbS7heNdibTje9Tlqo0j9bCigl8gyeNz3Err33VKcKF7d2EP4VoqDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TWKJnZQ4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7200568b13so41173266b.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374008; x=1762978808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rv+wMki2mCxR77hpbTFywu+l5+/0oJt0cFCPtAcjVTQ=;
        b=TWKJnZQ4JZ/i2S6GtW6UevdRKcl+irqGpplLwnxQvSLu8qAxqgNZ9mcRTQB2XObCS9
         dYJ9lS1fti5liM/K6lUgcX2oDMywe0bVTAGoQZJJAuTUk0UEOP1gKpAJPsHN2R9WnrCw
         oE9/O/7MRmtSLG52yATK1zXoU+A82LLcmPXdmUqMfIQIeEpIgtYKS471P+vY6HxP3xcx
         0j3fo/8SZfqJDlavaKALCOUxmK1fBYCMR7u+7Nx2q5kPTtKmFy+yb8D0zAzc38zsBfhE
         rr582VXLk7rJc2rPxgsLnGcaDHKAAg87ADaerDz/yRg4EhpdOA1l3vJBCabI47weQAlC
         qhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374008; x=1762978808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv+wMki2mCxR77hpbTFywu+l5+/0oJt0cFCPtAcjVTQ=;
        b=I1Hb66LgAFkFUL6C2cpGNKRbO1Q/z5/EyLW4XaX/7l6N7LX6OiVw2JURlJMWD2gQWW
         yzmL48LDQ52cRNkLgVVa2kDh+D70GtRUkrEwTQIqHWp94X8LzG8OTtuNbI+0C9pRFE9B
         0nf7ix7huTuXW+YwJ0xfIO4eyrlce1K4jbcpNmM31dGmOme3GKkP7OGZICdN3Njr3T3w
         /qNkPkOflXukLlpRX7yHFPmJnTKNtTHZ0Cd1rAUAZ/Zf4GIcnHAkrLDon2KjcywjeZ3l
         1Pwmo4X2aBEKyg4RbDu7AClFuHNUFEAg5dkd+6zEulI5S9BRz/tc3DPa+aWCnby3fWvG
         2MUw==
X-Gm-Message-State: AOJu0YwKnXYaWEh4WlI2QQqzP7pdZVEjj9gPWIF63wbuCVsv7xk9Lqjr
	e2ojt1fwKPd/8i7dOKkXhr4UqymmkNGYHlcTWGv3l1HK+pzhumtYVcJJR/HTmlaei1I=
X-Gm-Gg: ASbGncsKT26tNmCn0Ypsj3ofQRbBwtUE0MuhpdNiJpmHlHJlEddCZHRS2o0duEtW9Ki
	mhrtSjA93anWlegZqgPRHSuG7gYkQSxVx/3+qpsvNmNExC8lnHH4FFHEHkkhrF4zS2a4TvQylCR
	wndB56dy7b9mHbOfOZv707tbFp3buSGb6JR3f+wx7nsicZ9C9OKkxfbVp2PpuOK2/rlzvZzzx3F
	SCdhhFMW9lNN4c6W3TuMqCDt3csgvuBdhKYWkzLJWzoNVg0Wy7vp4fUbZVS4oHeWUfqGuj6tJYM
	F+wu0zcVc7mDT0Tnps2JfhAVyKV/0ItE9NbwTi9TIAz1MLsJkMQv8tpHjZw3ibvtNO2Hd1XmWxM
	DP9opC6YXOroAbo/xGAKgsse3Zg3sHIwj6PMl8Pp4TF/Qlxlmi3LvV7PoT0md3EMYdHpNmIS9ox
	wB3/RVNxuX3OMaDTzwxjr3smD7HLRDepMMX3pm5QF9pjZ0LpGbxbI5x8Jk
X-Google-Smtp-Source: AGHT+IFJl6cV/igj9ynYt/np2euiEErVUs6ipzRxDpzOrmiIGK5pn6V7TFkRn0BV8m+0B6n5vWZfJA==
X-Received: by 2002:a17:906:c346:b0:b72:6b3c:1f0d with SMTP id a640c23a62f3a-b726b3c21a3mr289980266b.35.1762374008260;
        Wed, 05 Nov 2025 12:20:08 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728968208esm41400266b.52.2025.11.05.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:07 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:50 +0100
Subject: [PATCH bpf-next v4 13/16] selftests/bpf: Cover skb metadata access
 after vlan push/pop helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-13-5ceb08a9b37b@cloudflare.com>
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
bpf_skb_vlan_push() and bpf_skb_vlan_pop(), which modify the packet
headroom.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  6 +++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 43 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a129c3057202..97c8f876f673 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -478,6 +478,12 @@ void test_xdp_context_tuntap(void)
 		test_tuntap_mirred(skel->progs.ing_xdp,
 				   skel->progs.clone_meta_dynptr_rw_before_meta_dynptr_write,
 				   &skel->bss->test_pass);
+	/* Tests for BPF helpers which touch headroom */
+	if (test__start_subtest("helper_skb_vlan_push_pop"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_vlan_push_pop,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index a70de55c6997..04c7487bb350 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -44,6 +44,16 @@ static bool check_metadata(const char *file, int line, __u8 *meta_have)
 
 #define check_metadata(meta_have) check_metadata(__FILE__, __LINE__, meta_have)
 
+static bool check_skb_metadata(const char *file, int line, struct __sk_buff *skb)
+{
+	__u8 *data_meta = ctx_ptr(skb, data_meta);
+	__u8 *data = ctx_ptr(skb, data);
+
+	return data_meta + META_SIZE <= data && (check_metadata)(file, line, data_meta);
+}
+
+#define check_skb_metadata(skb) check_skb_metadata(__FILE__, __LINE__, skb)
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -525,4 +535,37 @@ int clone_meta_dynptr_rw_before_meta_dynptr_write(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_vlan_push_pop(struct __sk_buff *ctx)
+{
+	int err;
+
+	/* bpf_skb_vlan_push assumes HW offload for primary VLAN tag. Only
+	 * secondary tag push triggers an actual MAC header modification.
+	 */
+	err = bpf_skb_vlan_push(ctx, 0, 42);
+	if (err)
+		goto out;
+	err = bpf_skb_vlan_push(ctx, 0, 207);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	err = bpf_skb_vlan_pop(ctx);
+	if (err)
+		goto out;
+	err = bpf_skb_vlan_pop(ctx);
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


