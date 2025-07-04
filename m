Return-Path: <bpf+bounces-62451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA81AF9CA9
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412461CA12BD
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808A28DF3A;
	Fri,  4 Jul 2025 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdRxontE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DE26D4C6
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670249; cv=none; b=OY+1ciUqsqahX/x4NfZpKEtaWxnns55NFq13ohm9D1WdPoYx6ufsDJi1kIFILCCMVpFuWEl7rhnntwjHeLsnJeJcYtCHONRvdnlf3soKcpBEO/5WkLDTnfOMS6LCq6jGZ9+24hegcJj//CNskQ28zr/L9WWlGydjQC2x7tIMdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670249; c=relaxed/simple;
	bh=CXAg+60U8okqecAdg0Spr+5OesFrkf4PZfl1KAERDBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8CK/54JFcwIT9I4X48mHAm4F08ZbOZM7ZU+yXYf52OzlH3mN/Ml/frk0saGHvuR7XqADXmDt5yXHsoAYx5ExHDk0zqOKS7wzNIPypdidWX9BlXUz3D4MRfGL3biKZ7tKAWW7zhcj3S+sr9wVCpgZFHxCct2bTZ+KAksfIkLsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdRxontE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490702fc7cso850399b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670246; x=1752275046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCZWZGtnnSWzkuokCcWTrugKR6SxbuKduaf9xJI6Hys=;
        b=mdRxontEF0TGQon9zeFphb4TbblL93shN2guwXM3+4KdHAZwvAqEGeRaEn+LlgHDbr
         GoFf5TZc7yJZrwr2sHllm3JzGjn+4mdNut4Y7nb/snKWzE0PRI8W/lzbte7fxUlRt6Yu
         6gpm+ETX2xpkQnb7ayQ922JaOZzsk5gzil0GRXwFNMxWYllIoB9/ByVPeqgHrmKDeR2B
         sYG0IqPy2FkCEbFYVQXYCgTbO0ERBUVCc0TaNPwdQMfFD+F7NsMgAnQbBog7TF7m4o+O
         7G2UpaWLC0YtIocB7MOzNaQ/tnHtzMTw+xx+Jra/RJzYSQf3ggbOx+z4rtT1IMgagFN5
         TlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670246; x=1752275046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCZWZGtnnSWzkuokCcWTrugKR6SxbuKduaf9xJI6Hys=;
        b=F8zFmmED+K0hLxdt9Y902EHrkHSLTOb3//lU/s0mo268nYHdVd5PbIKQmqbDjp+hsK
         LLvDB4SHAjCx0l7Jw++6+YUq0rHSbvWeuM++TEfwkL0DCSkYmfS5UFRqCn7dZazedSsl
         OvHN/6nTV/qs1d6QnuAYUUPweP7B1N03YxhynNYcvQBVJvH0GI88JBUvcBYT5qXA1wb+
         ZZh8GiDH6B4XB8GUrVq8+EAlJyPxnwqhuYg6OXNO3nJ7lykE5tPwmZAHEXP0Q490hQ9Q
         9J4K09PW+sqfwsKSZkn1zyVQmisGMSYuid+rWiNegBYZu34h3G/PoTv5n8bSVgBdLcRP
         1HAQ==
X-Gm-Message-State: AOJu0YxZ7rnEiyVf/snXEjkv9CK4vpVon/toPXL6+SEcgSVwCpBrLRVL
	wwPg06dsXgMOwwio0nE8buHBXTmEpmFtUjVDqnsONXHGI86sF5DdgRXh3BjDKg==
X-Gm-Gg: ASbGncsAWTad1ZIKJKCKbcwl082jMBunan/OXRdfUZ4r9qKj7AwibMSCaYWmksMpudh
	xZFy+KxE9/A3AojN1RFNtjAO4KV3cZjrPAzLr9p2aWx/aE51ji0ylkGpgHYAfqg/E/h9/QY/lNt
	CHF1a+egfxVPFHYaxksLz8h6Nj5InNWs1VSzXskV7lWLR0ktpbKK+Dq1m3SfQ+48g/ztEJkEYwE
	P3hQ//heIcTexyRHZPCStrbv1sh1T+lPl1GQyRf3pmzffwdJCNMpUqjKpjzidNjxJWwSVwP+RKD
	5PHIcs3vEp/Ele16cM18SPCdA2Qs9nuA1Oxwjb4Nlof1whPJAvQd9BSSHA==
X-Google-Smtp-Source: AGHT+IHoRDBUNDHWSFQS90wXV7K/iPnyzXuqrnA64cpSd+2VL7iJOUN7jlScxnon0HOpLq7J1zBkrg==
X-Received: by 2002:a05:6a21:3381:b0:222:d89:7a6b with SMTP id adf61e73a8af0-227239c081emr477668637.19.1751670246501;
        Fri, 04 Jul 2025 16:04:06 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 2/8] bpf: rdonly_untrusted_mem for btf id walk pointer leafs
Date: Fri,  4 Jul 2025 16:03:48 -0700
Message-ID: <20250704230354.1323244-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
References: <20250704230354.1323244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing a load from a PTR_TO_BTF_ID, the verifier calculates
the type of the loaded structure field based on the load offset.
For example, given the following types:

  struct foo {
    struct foo *a;
    int *b;
  } *p;

The verifier would calculate the type of `p->a` as a pointer to
`struct foo`. However, the type of `p->b` is currently calculated as a
SCALAR_VALUE.

This commit updates the logic for processing PTR_TO_BTF_ID to instead
calculate the type of p->b as PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED.
This change allows further dereferencing of such pointers (using probe
memory instructions).

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c                                     | 6 ++++++
 kernel/bpf/verifier.c                                | 5 +++++
 tools/testing/selftests/bpf/prog_tests/linked_list.c | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 05fd64a371af..b3c8a95d38fb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6915,6 +6915,7 @@ enum bpf_struct_walk_result {
 	/* < 0 error */
 	WALK_SCALAR = 0,
 	WALK_PTR,
+	WALK_PTR_UNTRUSTED,
 	WALK_STRUCT,
 };
 
@@ -7156,6 +7157,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 					*field_name = mname;
 				return WALK_PTR;
 			}
+
+			return WALK_PTR_UNTRUSTED;
 		}
 
 		/* Allow more flexible access within an int as long as
@@ -7228,6 +7231,9 @@ int btf_struct_access(struct bpf_verifier_log *log,
 			*next_btf_id = id;
 			*flag = tmp_flag;
 			return PTR_TO_BTF_ID;
+		case WALK_PTR_UNTRUSTED:
+			*flag = MEM_RDONLY | PTR_UNTRUSTED;
+			return PTR_TO_MEM;
 		case WALK_SCALAR:
 			return SCALAR_VALUE;
 		case WALK_STRUCT:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e8328f40b88..87ab00b40d9f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2814,6 +2814,11 @@ static int mark_btf_ld_reg(struct bpf_verifier_env *env,
 		if (type_may_be_null(flag))
 			regs[regno].id = ++env->id_gen;
 		return 0;
+	case PTR_TO_MEM:
+		mark_reg_known_zero(env, regs, regno);
+		regs[regno].type = PTR_TO_MEM | flag;
+		regs[regno].mem_size = 0;
+		return 0;
 	default:
 		verifier_bug(env, "unexpected reg_type %d in %s\n", reg_type, __func__);
 		return -EFAULT;
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 5266c7022863..14c5a7ef0e87 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -72,7 +72,7 @@ static struct {
 	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
 	{ "obj_new_acq", "Unreleased reference id=" },
 	{ "use_after_drop", "invalid mem access 'scalar'" },
-	{ "ptr_walk_scalar", "type=scalar expected=percpu_ptr_" },
+	{ "ptr_walk_scalar", "type=rdonly_untrusted_mem expected=percpu_ptr_" },
 	{ "direct_read_lock", "direct access to bpf_spin_lock is disallowed" },
 	{ "direct_write_lock", "direct access to bpf_spin_lock is disallowed" },
 	{ "direct_read_head", "direct access to bpf_list_head is disallowed" },
-- 
2.49.0


