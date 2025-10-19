Return-Path: <bpf+bounces-71308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA1BEE58A
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB9F4212BD
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855D2E88A6;
	Sun, 19 Oct 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QNyhKnzP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2852E88A2
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877973; cv=none; b=KDM9poOKM82r5BCUuvBnmjgIYg/rajQCwXiJ+VRR0Gwqf0oMPF+/SFirKTi+bqLQxoLG+mP+IcuSTCOy26hUNu7vJByiUDwPJy2scQDV5n6vtzQhWcllQ8njw2FsunKB+yvYgUfRNow+XrYPDeCHACI6VQbQJXqI6QFCCINA0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877973; c=relaxed/simple;
	bh=Z6Acauiw5VNlWtHv7oF3ZXGpUNutQOAURn9JnzG5E6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbJG1vCKLauE69RKV+V8xi+6IVcGGd2Dwr3mnCUeWmisxqvhT2dHjTJ8vnkWBKSfJ0/8MqOPPzd7t/+8oMbFgyESuI72AkvY1eTW3ZbuPGIDHxfgH817jbGsWJ94iPbFIPcCfL6J4b2rABzVd90GbxhvKIssaWXwLlUijSGMr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QNyhKnzP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c3429bb88so3329538a12.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877969; x=1761482769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGNOtq6edfpdoKT7aMe3lnq3YZWKA20XmMp9oC/vqAc=;
        b=QNyhKnzP3O0khSHBNiLjbDWxgSQN7KiYP3T/lcBvlbDrAod+zbTTMEH1Sya0Runhhv
         TJlEUhkwE8jfXytJOJdWgdGVZPbcCkBEQpRQhWZm3zN8vA6ePPcnKdPk1Uint+8jDwRM
         QdfWz3Q5gxaj9T6SCTuGul0+oy8qy3VJEI5lxtyfFUx5waL+N1NrC/pMQs1XM1fwZgFr
         ajbv1W0P28EQ5C5ACff/ZyiC/vuBjKVvB03I84NYMs6/fPBr7eKIhU9N6wfufnmZlR8i
         TrXbfSfR3bVbaOdi7iZFXSphKywayh5w3r7rl8Wh9wQpuJ442jrqEWaCiQfhj81bhsWu
         nzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877969; x=1761482769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGNOtq6edfpdoKT7aMe3lnq3YZWKA20XmMp9oC/vqAc=;
        b=C31anGstmoI0KD1+1hku03iezCdC7HPHOeUwi1XdYpTRSwtnQEfwO+w9xStWkXbgxe
         9dwHciX40VhdsKHCzI6GTm/UdQ+5GQpMU363n26lrKH47mKdnsVsU1Wdh1Asit1fqqm4
         XtzjpQUxWvIh3pEwbcNz30siSZL5e+10Fzvk+Eo/OjV6sUiPinUK962zq0cMdH4jO/uh
         oU0muyjy61LZTJxYjtrtxod1btVQC3LLRuX1MAWkoE74yrK93iYGVXCHClq0TMnnJAPi
         iv4BYogJ2VKThCOvt7H8aRKlKn/G6cz+TXSkzsdxY077fgXMCz2cOs6hHD+mkzrPInqq
         52KQ==
X-Gm-Message-State: AOJu0YwykhBdQPGI3qm3ROz/MBs6KvX0ivqjFaeSpHzGmpBmCwpBcT0t
	LZ56bRwC9SZMOyAfXV8BHYlIh8kAofwEKN+lfvlzFje47pnbMVWwxuHtP9YvvM8fbW4=
X-Gm-Gg: ASbGncvaYAm4P0qGE0gJfsGF2vqusVk5dSodo82cFi6GUQSp8YBRL4cWjgcbVLt9H6K
	PQ1mSiSUrTpjB6FHrTOLt08ISCJMYyhhCnQpe5MSnyF7UiXMON+GlqDdamtktIPPWOXEn190zOJ
	6sgSQS1bJPKXAJz/rS7bWg5GRLu1ESNF+XPJ5RYl2qY2YBZotkmyDD6TauVL19ErdFrFnzcjGuJ
	KhRlUqhFyXEH1DZ52MI8iAWZbHv3gRYNzOdv5tsOeJUKyypqAuieO9hdvMa67zdBaCwYuOIV38A
	DSAnwrN6UyHh7eJLbfX3cEIvmOnUP9a3aB/ePGYFGYRFmsup5ilKJH4UdVqRrTp2Ks0bMGg3sen
	eEibkSg8oJtgG1L1RlAIKdP9MEyC8a8l4qEt3IBOq3qDk40cpqSdhG+emhYmkUVGeGtShfAE/qg
	SfuRZj5I9g3uBtaSF4MFt3BW+2pk+SWLKj6YrGMmQTG8MOEbKuETwqxGi3D0I=
X-Google-Smtp-Source: AGHT+IEm9hlIkjPauXzag3/GcymgnYK9h2G9gzy4CDlrsD27on+NLDcY/a9PAN+OwENFrdNhuuyg5w==
X-Received: by 2002:a05:6402:2742:b0:63c:4bc9:569c with SMTP id 4fb4d7f45d1cf-63c4bc95907mr5230680a12.19.1760877969144;
        Sun, 19 Oct 2025 05:46:09 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a93998sm4091285a12.4.2025.10.19.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:46:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:38 +0200
Subject: [PATCH bpf-next v2 14/15] selftests/bpf: Cover skb metadata access
 after change_head/tail helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-14-f9a58f3eb6d6@cloudflare.com>
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
bpf_skb_change_head() and bpf_skb_change_tail(), which modify packet
headroom/tailroom and can trigger head reallocation.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  5 ++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 34 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 05d862e460b5..8880feb84cbf 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -501,6 +501,11 @@ void test_xdp_context_tuntap(void)
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
index e29df7f82a89..30ad4b1d00d5 100644
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


