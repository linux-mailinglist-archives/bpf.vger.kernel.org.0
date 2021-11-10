Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAAA44BFE6
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhKJLNb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhKJLNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 06:13:24 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83819C06120A
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:10:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so3276533wru.13
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6Nfvgybe3gWaIfJceTq1wzqKHM3tdQPjimGmPusYRo=;
        b=J3UwV1YoXUQzHhK+O3d4Nv+8eiho2ZrpJgFPC30VSJ5PZ6km9SZLkJMdgTUh1YWfqt
         ps6IbzwQZpw/QMXGF2BCbtkp39IYi4NgNcsCKo8wTpRp5dnmbYarEFMWEtjiaLnllE6R
         zXxWlAR0yOljUWOLJRyFSy1nsO23VsyvNULWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6Nfvgybe3gWaIfJceTq1wzqKHM3tdQPjimGmPusYRo=;
        b=gW+ly0Tl/toNhQ7cwrqfBv66EkDriEk2XMrMsE4OOyg4Lj+6XOMmQJ8mT7YOgaVDox
         nL8q+ouS4Ir8L9AHBJFYHS5Wumx3U1h+B/6jXq39t8xgg0kSu4Id8JQahSUqr4JbdcS+
         JKzG6dL0pu3TTs4o5DCJE9IB4ZMC/cR3JMueXkrWJRUJ2gXuISjK4+XtUSgiiswZLiVz
         S8buPtP6zto30gv9D87p1poGpGLEEkijUpMhnZmeEqFDQQL+xEHUNUyv7sYNGFQp+b8i
         3X/Wgqcd+yCKNgZiNNxGAauJlzi213mzJ7wI/osI/pA1IiCsurn/xgZeLtiw9e+FpzBu
         uCDA==
X-Gm-Message-State: AOAM530UH4mjXdztnGRiSFQjdFNzuZPbPXh4IXYIfLWtu9FKrc4MQGVn
        bL5c5owq/d6iQApXHSIrgrXgNw==
X-Google-Smtp-Source: ABdhPJyc7vJ2FW2FH5ljnEAGvH2JAEs+Zlo1oQmgqPTp03RkNlsazcmM6iTdsH7gZAj4BJrVXLmvOg==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr19222447wrn.72.1636542623030;
        Wed, 10 Nov 2021 03:10:23 -0800 (PST)
Received: from kharboze.dr-pashinator-m-d.gmail.com.beta.tailscale.net (cust97-dsl60.idnet.net. [212.69.60.97])
        by smtp.gmail.com with ESMTPSA id m14sm18780682wrp.28.2021.11.10.03.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:10:22 -0800 (PST)
From:   Mark Pashmfouroush <markpash@cloudflare.com>
To:     markpash@cloudflare.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for accessing ingress_ifindex in bpf_sk_lookup
Date:   Wed, 10 Nov 2021 11:10:16 +0000
Message-Id: <20211110111016.5670-3-markpash@cloudflare.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110111016.5670-1-markpash@cloudflare.com>
References: <20211110111016.5670-1-markpash@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new field was added to the bpf_sk_lookup data that users can access.
Add tests that validate that the new ingress_ifindex field contains the
right data.

Signed-off-by: Mark Pashmfouroush <markpash@cloudflare.com>

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 6db07401bc49..57846cc7ce36 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -937,6 +937,37 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 			.connect_to	= { EXT_IP6, EXT_PORT },
 			.listen_at	= { EXT_IP6, INT_PORT },
 		},
+		/* The program will drop on success, meaning that the ifindex
+		 * was 1.
+		 */
+		{
+			.desc		= "TCP IPv4 drop on valid ifindex",
+			.lookup_prog	= skel->progs.check_ifindex,
+			.sotype		= SOCK_STREAM,
+			.connect_to	= { EXT_IP4, EXT_PORT },
+			.listen_at	= { EXT_IP4, EXT_PORT },
+		},
+		{
+			.desc		= "TCP IPv6 drop on valid ifindex",
+			.lookup_prog	= skel->progs.check_ifindex,
+			.sotype		= SOCK_STREAM,
+			.connect_to	= { EXT_IP6, EXT_PORT },
+			.listen_at	= { EXT_IP6, EXT_PORT },
+		},
+		{
+			.desc		= "UDP IPv4 drop on valid ifindex",
+			.lookup_prog	= skel->progs.check_ifindex,
+			.sotype		= SOCK_DGRAM,
+			.connect_to	= { EXT_IP4, EXT_PORT },
+			.listen_at	= { EXT_IP4, EXT_PORT },
+		},
+		{
+			.desc		= "UDP IPv6 drop on valid ifindex",
+			.lookup_prog	= skel->progs.check_ifindex,
+			.sotype		= SOCK_DGRAM,
+			.connect_to	= { EXT_IP6, EXT_PORT },
+			.listen_at	= { EXT_IP6, EXT_PORT },
+		},
 	};
 	const struct test *t;
 
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index 19d2465d9442..83b0aaa52ef7 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -84,6 +84,14 @@ int lookup_drop(struct bpf_sk_lookup *ctx)
 	return SK_DROP;
 }
 
+SEC("sk_lookup")
+int check_ifindex(struct bpf_sk_lookup *ctx)
+{
+	if (ctx->ingress_ifindex == 1)
+		return SK_DROP;
+	return SK_PASS;
+}
+
 SEC("sk_reuseport")
 int reuseport_pass(struct sk_reuseport_md *ctx)
 {
diff --git a/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c b/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
index d78627be060f..a2b006e2fd06 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
@@ -229,6 +229,24 @@
 		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 			    offsetof(struct bpf_sk_lookup, local_port)),
 
+		/* 1-byte read from ingress_ifindex field */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, ingress_ifindex)),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, ingress_ifindex) + 1),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, ingress_ifindex) + 2),
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, ingress_ifindex) + 3),
+		/* 2-byte read from ingress_ifindex field */
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, ingress_ifindex)),
+		BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, ingress_ifindex) + 2),
+		/* 4-byte read from ingress_ifindex field */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, ingress_ifindex)),
+
 		/* 8-byte read from sk field */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
 			    offsetof(struct bpf_sk_lookup, sk)),
@@ -351,6 +369,20 @@
 	.expected_attach_type = BPF_SK_LOOKUP,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
+{
+	"invalid 8-byte read from bpf_sk_lookup ingress_ifindex field",
+	.insns = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
+			    offsetof(struct bpf_sk_lookup, ingress_ifindex)),
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.errstr = "invalid bpf_context access",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+	.expected_attach_type = BPF_SK_LOOKUP,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
 /* invalid 1,2,4-byte reads from 8-byte fields in bpf_sk_lookup */
 {
 	"invalid 4-byte read from bpf_sk_lookup sk field",
-- 
2.31.1

