Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9334CCA6F
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 01:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiCDAGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 19:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiCDAGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 19:06:08 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEAFECB35
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 16:05:21 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d187so6118905pfa.10
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 16:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6kSUFctZfI/YchZo5RsCcQPvQAdCC0KVtCxqqxsImQ=;
        b=c0qtnKchQaAw4wDTinluctfpUSpFWd6kDbA0mfCH2R5aRlVZNiWuGz+M0QNn19BGiB
         S3rqNDwO1TB7dK7Ljf8QST0FqGACTBzxuqsO41aBk+TmiLoJ5er3m1u/m/st8yylHLQk
         8cFvvxFjhSv3uvDwKOfdbofVCCX7BugynAdduoi9BqBwsPO6Fb/qZmtmFu+xR82HQecq
         dvR7j6E6H0LBc5SKawi3vIpYyApaI21j4p+G1kT6RRUL83WAgn810jtcaVo1D8P5xLdz
         s7F0AFwGRxqBgqmjHU9ZBBDf/X6YyNTBxi/hMBEVklE6jzdAcos2sp3aVMHwtqFkQjY2
         8lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6kSUFctZfI/YchZo5RsCcQPvQAdCC0KVtCxqqxsImQ=;
        b=Cieibg6pOPpcOoMRrUVNw8WcAonvtMLhe+jaUK79Ni7qgarvPgP0qv5okkQiyQFw0O
         GBS1K/BIYOVKW9P0+Ys6ZwPtBP3jpWAqjKVU1vudQfLdnmPx5o/UaHQn7EuEgfwCjr9+
         wqW4EHO31ezpcmy5NLXxvteJT4CPQ/YpoJ5/yeV8A/dR2j+A5uTrhifLoo1OPFrkhsGP
         OOI47H4tk1/9gXclx/61pOZMwP8dhiFQYj2I4m8NqHwwGT5zg+svY7qGMfDq2p4yH2zl
         2d+gemHNUlAz8+fcJchc5tC4Xd2bKZbUKdA473YMsnkDkStV/th8CL+n+x/yTW1xlJ3V
         dCBQ==
X-Gm-Message-State: AOAM532XMMw/jSD+2E9D9LyLxc9L7UKxBQAdPTtl+sEnPpIFajOgS3Zk
        ggnb2EQVyjqqQPmeMe14m3/p5kO3+9k=
X-Google-Smtp-Source: ABdhPJwkhcbZSvqO0Yl3dQ82iSWj2mikSdjKMsqfBd1MmDd1LVjatWILZxznnU3HHQD9nWbL28zVxQ==
X-Received: by 2002:a63:3dc5:0:b0:370:d638:5826 with SMTP id k188-20020a633dc5000000b00370d6385826mr32264777pga.184.1646352321296;
        Thu, 03 Mar 2022 16:05:21 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id kb6-20020a17090ae7c600b001bee8664d82sm8108242pjb.35.2022.03.03.16.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:05:21 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 3/8] bpf: Disallow negative offset in check_ptr_off_reg
Date:   Fri,  4 Mar 2022 05:35:03 +0530
Message-Id: <20220304000508.2904128-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304000508.2904128-1-memxor@gmail.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3278; h=from:subject; bh=gjo4yMlDUFz8jc0xX19/30cTQ0Kvjk8SrrfHiz6dWOw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIVd//QuYXXGVLFP15MMFWVFbqEKKa+QvRca/BHOR RnolGWyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiFXfwAKCRBM4MiGSL8RysZhD/ oC98qZIjVgikahC8noQ8cIwl7ujBjPn07ctlfyC+pQ9S0uXQJ2w4cJ9jBWcEqHhk8KAJE69/WSSXUh hkZ3NLdoZOn0Wha7zVz/yKT6IQyET0TOoHIVeY4OSfi5e2g1k3/X6YEVZCEBbzihendg+HI/Vp5oU+ P6s/8fMjlgwhMvNvJNSsT/vC7S6aMAqlpNiqjazQFKoWmO5Ku54QO5Bd7tUNnw0kl3tCxSmbJgqt0A UzkHcUT5NZmCS7qWO6yc1h+zWG/8uVvnHL0jpKRbGlKL7/Dr7I4uZRGTgd8i4fXcprAZDNMpCCCTD2 aUEXmgqPDqYnHbdEUERTx2JVwpXNR9CgnjfoqAJuY99r6FMATZQm2Po9Wqq626/1aUJqVmNAI8+snG G+L0C3DgYOzQUpMPA7AWWoQoUV1o4sWDXfYzke58eUstG8RwXLc+UDTooUq6I6ko0ArdT7BQMJ6XqV hQvDtxWXDqskK77YbABbNWEcNIalRuo1flHqKcYs8WJCW7aJkQ0Y3p3ZwhMYV3iZ9vApI8KzWh/ly7 QHyWhWO2hw5uBD0uemLqM65zPj8ZlgBpP7eFtzO0ZjcRs0DayXSzDJKqxn8cjOsiXWo7kXbaKLTIGn QSo9jCy+I24dz68Ty8faAS2rf+oB8sK4QqYOgMeKlp33OgJSTNXN0zPNHlag==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

check_ptr_off_reg only allows fixed offset to be set for PTR_TO_BTF_ID,
where reg->off < 0 doesn't make sense. This would shift the pointer
backwards, and fails later in btf_struct_ids_match or btf_struct_walk
due to out of bounds access (since offset is interpreted as unsigned).

Improve the verifier by rejecting this case by using a better error
message for BPF helpers and kfunc, by putting a check inside the
check_func_arg_reg_off function.

Also, update existing verifier selftests to work with new error string.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                                   | 6 ++++++
 tools/testing/selftests/bpf/verifier/bounds_deduction.c | 2 +-
 tools/testing/selftests/bpf/verifier/ctx.c              | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c85f4b2458f4..e55bfd23e81b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3990,6 +3990,12 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	 * is only allowed in its original, unmodified form.
 	 */
 
+	if (reg->off < 0) {
+		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
+		return -EACCES;
+	}
+
 	if (!fixed_off_ok && reg->off) {
 		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
 			reg_type_str(env, reg->type), regno, reg->off);
diff --git a/tools/testing/selftests/bpf/verifier/bounds_deduction.c b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
index 91869aea6d64..3931c481e30c 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_deduction.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
@@ -105,7 +105,7 @@
 		BPF_EXIT_INSN(),
 	},
 	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-1 disallowed",
 	.result = REJECT,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/selftests/bpf/verifier/ctx.c
index 60f6fbe03f19..c8eaf0536c24 100644
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ b/tools/testing/selftests/bpf/verifier/ctx.c
@@ -58,7 +58,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass modified ctx pointer to helper, 2",
@@ -71,8 +71,8 @@
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
-	.errstr_unpriv = "dereference of modified ctx ptr",
-	.errstr = "dereference of modified ctx ptr",
+	.errstr_unpriv = "negative offset ctx ptr R1 off=-612 disallowed",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass modified ctx pointer to helper, 3",
@@ -141,7 +141,7 @@
 	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG,
 	.result = REJECT,
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass ctx or null check, 5: null (connect)",
-- 
2.35.1

