Return-Path: <bpf+bounces-71306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB1BEE566
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B84EA67A
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CE12EA72C;
	Sun, 19 Oct 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XQRB4pjH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37462EA174
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877965; cv=none; b=hv7Nh2o9GfOCFIW12FXgy+Lezi2tq2T5O7jHj1f7HxMoLVT/+UEso9c88wd2Df1UZzvuVZZUJy9y6qXgVbYfv5KsvvL5fGKshRONHreuzCUXKggTxGwLog5D88WuvcIXqVnrKRzO6YQoGuuPs1abWh6aWedSiJvJOkLiT6QdIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877965; c=relaxed/simple;
	bh=s8ejYighvmLMq95T7S87043rXSbZ91PrBVPsAZq7lQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnGjk0JquG0+T+F6itfCgWxInebVDdBaGceaUEOj+V6logm2hFier5dvqOzQ/EnTToI5PgJN0+/22wNKCEnH6RzwzMI8SOSQgeC2ppkUmYJ3Y6zW1Ebv9CeqHU09p9IFHBSJf2JSmzi4kIgS18aMfSxVYyjBnRnoSmCjxN+t1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XQRB4pjH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07d4d24d09so590793766b.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877962; x=1761482762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrmrPg7KoaPB7foFkLKPjuRekkrBByS4QryzdooURAY=;
        b=XQRB4pjHPmAa/RNftPK2YKQQEZI8wDnQSeLvG1EjhVnUfrOimHR/Nj+HsPqw7AMh50
         bjtAvJDniqoYfyhg11OuakxCm85+J0qpS8YDpYhBCLhsoI0VG7nJDDJeVjGaKSuN0ERl
         GUBAooVww+kNIM817pUcCjXsgOSTtvcxTEhZGU0tPr/7Qf2vLj54lhh15RR3ojq7cBWw
         C6bDiCfqN2oAts5tK0zCXVbjztY56pp+dGOTN7/mStLxeeR4lkbV/hjcYIlqy1BvHq8Q
         Zh5nS0wGbZkusc4NrUgNmmV4GAfDUkOR5h0u7JEbfHXohvtS03QX/vJf29bEbL5p/WRf
         MCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877962; x=1761482762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrmrPg7KoaPB7foFkLKPjuRekkrBByS4QryzdooURAY=;
        b=cI2xD9Yz3DjHuWEizBAb3zTLYsVPzVspaWbqkevJMymSk0p49678uGzwMxojLZakl0
         7co74DJAam7fxHmdFJ6+qUJPBvOwNoFAD0SUcKjd1AL/Y8JDx5TL8Id2lPAn0ot0YEBr
         1s6/7Qx4ej+Ujim48p5WUG9khr01zkdIumBzLdgScVjvQWy6y8C4zl8Jkdsa4+CiPt/6
         xEqPIg9llDO90h29K5XBrdrk71GFVNFruqHVOZKKUC4pKZLmNbOHHi0l/XU7LP3+mJJL
         AeC/XC5Tg/kCnu05RyWO3W8atB7pLPGjwqeiAvXjvT2aLrOuxe1pgRffa0ZMcN+azCWr
         /HWw==
X-Gm-Message-State: AOJu0YzN80c6WeSAFMdlrUNjwXn376nZtKb4g66JsIBTkdur/CtzLR4C
	YxK4a2j4foc5ilIWkjRCcdsRnHmT3ms+P+cRpp3mLfizzCXe30ZAG6Bpn6L+N59fzpM=
X-Gm-Gg: ASbGncuYWal4cJMXLtta+sdh3wP4tUjrGfFJRFQnW1OG6JsOq2nuM5KjOQ6harf8pV3
	R8dCpzwdBPnr1J6OLHS4UtRZFipgJsoV/wNjmRD9OpsepzKfg8IIvK5q5cFBjcvOLs6IrRE7uBH
	3Dl5n4xnUwV3wiSx0UfA/XCoo70XYzc95OWWCrDxf5aTCg4RcGN6jq2bibgnXUwjObtVtoyOVTp
	kqreM+8DqvrpeWwFD8V0a0cs6WChjDO8lyMqpEEWsc1EEP69XDESY3TevJht7D3WjfvLhO6CjJc
	oGhMzcLKqjYuhlSNDpjPRY5IzCyvs00QQAj854w6xyXF5BJZbCqv15NCzxrSyCF96TzdLO26SDs
	2JuN3g5xLL6H7oOTfqV5uMOHs/YFY7JFc390vIcO4Dv4izU08ok7VpURossOf1yOiUFwf7NgwUR
	YXNodchwoyTheX9DQ4PBhizIcEOt03zFLx2nFC9rz+BEgs74nGTQ2x86ooBFdjMGZOvKfCNQ==
X-Google-Smtp-Source: AGHT+IFsZIyWeyIKdrUkwOLkqgr6Vqyu4++1ILzF6JxAKn8J0k7Z8tTU+SOPMPjA0jwI/TVyRKo/UQ==
X-Received: by 2002:a17:906:9c84:b0:b3e:1400:6cab with SMTP id a640c23a62f3a-b647314956cmr1152138266b.17.1760877962223;
        Sun, 19 Oct 2025 05:46:02 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83960e6sm502615866b.33.2025.10.19.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:46:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:36 +0200
Subject: [PATCH bpf-next v2 12/15] selftests/bpf: Cover skb metadata access
 after vlan push/pop helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-12-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com
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
index df6248dbaae8..e83b33526595 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -482,6 +482,12 @@ void test_xdp_context_tuntap(void)
 		test_tuntap_mirred(skel->progs.ing_xdp,
 				   skel->progs.clone_dynptr_rdonly_before_meta_dynptr_write,
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
index dba76f84c0c5..8d2b0512f8d3 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -49,6 +49,16 @@ static bool check_metadata(const char *file, int line, __u8 *meta_have)
 
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
@@ -525,4 +535,37 @@ int clone_dynptr_rdonly_before_meta_dynptr_write(struct __sk_buff *ctx)
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


