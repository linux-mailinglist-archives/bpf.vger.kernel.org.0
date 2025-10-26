Return-Path: <bpf+bounces-72244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFE8C0A978
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EF8C4E5B9C
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6132EB863;
	Sun, 26 Oct 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Csg9X50C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF892EAB89
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488338; cv=none; b=AO9Eec4pkgKrLmzlMUtdwnQXF/dOtqySy+0XfnPmlSTdE123YtaZu5y6pOwi0fZ95XQZRXsglPR5aSTM0QiL02JwOEWkC63Ea70O2o+hD1Nfoskv6yGM/aZ6IewPHu/yQKy2pwDUTN14ip/oRXul8c6t10yl2gRKdffHvZ5mUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488338; c=relaxed/simple;
	bh=pBIPl0Sj69DM8pTOAoip8oieBc8gUckTxtkPnxzx6n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtIqeRxalKWTECrN6vVgwtmEpLriN3Zsi2MDYMQzEzvQi65vZI4KgPduDjenemyCZIbB0MP1X+T0bK8h8ruwDyUbF0d8IxRG3/lzhk8p0E29pL+Kr25ogWY/k3ZmI6LgUcb+U6ipaUudJODP2njK/RuJb44y14beehCNQJrq2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Csg9X50C; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d83bf1077so327908766b.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488335; x=1762093135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JY8euxhjSxZrEWfi+Bt2Wa2V4/aMRr49LtAScynF/tU=;
        b=Csg9X50C+/9R0FaBgapiaX+kVFNygPV/VXm0Ueu/jS/WliFK6KX7jWuKR3sw0+sF+h
         sGfeJ0Ow1fGEeH5UdFWNTTyiHi3p0mErQWLnwH8NEwGBBK90PV7PT0T42A+G46r0WFbp
         jaldtrVf8z4NYyH7nG9Qhd0GjvlOIQOCQY0eONEyQMahz+mcZwlhC661LrVVIEm6uXfd
         fDEY4O/ZaFqqbiyk9lBEIo8xwpVUTWgsIAJBa1xYrsYa/pRux9A7QvLQXr0oPAG6i7bI
         NCzzJn5oHBFI73cjekXLnNQBWmwNXQl0GIQmg6Iynep2jXkhl3K5P3ntZwFXKlnu45Vx
         g8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488335; x=1762093135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY8euxhjSxZrEWfi+Bt2Wa2V4/aMRr49LtAScynF/tU=;
        b=RDzuN2N/hysXVr3kP8mMGX4MsCCqzVeA6jOijyqsujJG76qG6Fw8tEwR+ZTjGpgzDZ
         297P+RXw0SyvsPVT9GWCcNOrP+hUUAHTo1L+so8N+VrwfocaXRkssA+26/fKURByc+68
         NNdaod/Sbdxot3vq2DOsEaE0NBoRx5GG0QcB+vkY3SSM41q3Roewy2q+ttjQ5WdQb3BW
         HB56HmYNu/ad6UslG/SGRKcaEgNyr4W1wi9xY++Vo0ShobHTSHnm/Q3jGT3XRFywpd/S
         +qj63NdPd8Yf5R10DMERddFXf35+zq7Z9sdp9z50oGWd7hBjUFm0lyrYm/tnbiuMybYG
         3prQ==
X-Gm-Message-State: AOJu0YyrbCi5SUIczKLU4IGpR6MaNmobT3Q4FBuOx1n8yePZz1jfm/ZV
	bro77apyJF3awk2lUEN9siTBr+hCegd0bmqbPybKFw2pZ1K88PEgz/N8zyerd3UCz5s=
X-Gm-Gg: ASbGncuZmMPmovsUMnLfihwlcmdGud+2ri5g7bZIKMvMWmiWnJMZ8GBXanZB2ShoRWd
	gSuzu4PczvV4srH2nEV7Up3bUB+3C67qummsHXidfAN30Ke6MEvgnmEt17SYt9XaaF1RNYC/Zb3
	LXmVh1XGyjv4XrVE5RXDzNnbLQlDAeYHUGbEB3OODC8XRFdTBqhdmu++FleqiE2BETjF323ZHPd
	OA3lnTDuWUbKO5IpO0Tf+6cfk89Qtpr4jV5vlw5m3JctyskRtFO4X0VeIxYdgjoD+s3esgdHmNP
	9zJYd4ZdB5S0JZQgLvptM1PmnP0pB1iPIaFFgPq3TJYITU4I3DabUijSa2fFSlUEzaxYrR87ZLL
	7F55SuUiOVXjCX5ujm3WYHR0QjE58r0DeWdKI+Z8XUqoktom4AL1uVjuxWrODFfNkc3wacQmF85
	mQtEIjyybJV0fqocmwcJrTMj7RQE3Zo5iIKEW+QG3Te/TCjQXG3/uqMMlB
X-Google-Smtp-Source: AGHT+IEwJNWc/+h4JzNiZ5lThxqJnC7kZPTHf5RuXlOgga+GOzDS/nOn2zV6EQ8WYQgPNrnB7B/kXw==
X-Received: by 2002:a17:906:f589:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b647195b6c9mr3717174466b.7.1761488335111;
        Sun, 26 Oct 2025 07:18:55 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm469862466b.39.2025.10.26.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:33 +0100
Subject: [PATCH bpf-next v3 13/16] selftests/bpf: Cover skb metadata access
 after vlan push/pop helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-13-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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
index ee89e1124cd8..41e1d76e90a0 100644
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


