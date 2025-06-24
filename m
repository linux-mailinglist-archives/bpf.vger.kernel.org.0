Return-Path: <bpf+bounces-61342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C20AE5A64
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7270C7B1D29
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D38C19DF4A;
	Tue, 24 Jun 2025 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxqysD6C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40B192D87
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734784; cv=none; b=ez2hwhr0sGQy9NpzInCyIS6M9IHG85o7Ck/4zqA0bsV2NyMayxgOSGUQt3VaM5CpUEgGj24GWpCOaMQnE+00mrGs6KHcaSnMaAqqorETyouoawchuZqKNN6XmfHlUbOdAlkngH/SNdkioCUjjO8nCatPzENeycVPcmTGE1ivNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734784; c=relaxed/simple;
	bh=oiP/xIzbI9W70AcEsurmTpHWGJ3Das1QgoRAA/lnGvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue0RzfBxYrPQJf8495RQFODJKqRPTgDlkxs5pVH35R09lDLu2MftzzRByd2jVxAp4K1bdSKR7lQMS028hRi9dODwb8qEZJkZM44ZcZoaGBJuJWvCrDmr7BVwwkCox5sB55dDN31z4FXmzokzX9VqTs1Ea/fumiELe5JioqSyFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxqysD6C; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so9198866a12.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734780; x=1751339580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLyoqod/zuIklcM+sK+IH7gCHXwuy1XcbKOLRlqC0yU=;
        b=IxqysD6CuK1H+t3w9QgbJfWSvMd6r7p7oeumBYQ8ifdlBIQTgwPdVWPxKgSbMt8Y5z
         iFSi1fuJ0AGYzbRF9FETZb1lx7S/2A9L1vRtrxFNZL4ygxw2C/vWPzUdEyWrHondNBe+
         C757E77w/vpdVQRA4eyZPgWWhjoZL1Ms0XIDea5x1LUA7KL8L51dqeyV4mcQylJ9Qqa9
         rHlCPofohANo6z7upHggsqu/e2U5SXPA9EAZuUA5iMngOZlgMQYra5gFuU/ZRRFps7Lq
         TwBvB/OtMcZ53MDuvGGmVGJ7MJSbLIBFPtamDwRihqo7B09wZ/F0cMAZsPzOBer0Lwbh
         R5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734780; x=1751339580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLyoqod/zuIklcM+sK+IH7gCHXwuy1XcbKOLRlqC0yU=;
        b=YckxT/P+myc5h4x/YgtgHe2ltXZtyCsgA4Bt0xTqA44srqD1q+3qyVTpf5k7zOKg0G
         oVQeWpirG2Sd8uspAUeO8hpWfne02cqxr/nXqPu1YXmN9nNL8VR5ENjVS5z8EsV4NwCG
         T1UDgJn5GlVDnMINQmSe+bUB+UUsafyO04zad/+U9kAs/vw3UettB907g7nPf7KT2HpF
         LcgnArSChwhpxUGEpX74ThIfsFwFExBqwS7d106AtodCgukGrH/DWDpl5SMQ65+NSDYv
         TDRn8jwx57P0au7X3BuR5JLNdJAJ2TO2IDBG/7b+7DeAwqb2Ybj3xUIJGsUTuUUyQGRY
         BZmA==
X-Gm-Message-State: AOJu0YyxiEhuzMiV7TaILHGmiFcdzJD6pxpUyClNHTvYlnNKi7bRANjM
	jNOFkvNUAA+xUM3zCbEidLGYMI9BC3zW0sDqvUv/QwidJVUI8mog0g9vu49cz940ii46Jw==
X-Gm-Gg: ASbGncvi1aCnJemOvh6fFKoi62xd7hDQpbdjNsZaf9Amhz41fRGVxNY+AdQTDlFvAn3
	rygvLIlAzVLXwJqLHwc0gCHHBASxKLbKhKJzhattw7/8cjWzwp40OWaKkul7NmFqFN8vSYgfTbe
	ccbq2ZSg8lyXzw5pvtllTKlvAU3Y7/cUDnAHRReMQzzRR+oG02IBFKnJZBtvlZVASV1eZ0MOA/D
	UM95K3a6YC7w4TGwoMvg+5FoTvfeHgoVpzyPMImJ7j5mZQH7dDW7vmCBax0MI/cJFzVBdKjb0eW
	Vkjrk+dUoohQJSM7A0/c1WGmyyTte+B1R9jZiIC+RG4m9QM8AZlN/6Ry5EztyQ==
X-Google-Smtp-Source: AGHT+IG9S832t/GmJ6bON5ImUVh8F8mluym/eZLcS6JRyYMVE8t4z2ExSLG9zFlIQQbJRb49x/yg/w==
X-Received: by 2002:a17:907:3da3:b0:ad4:f517:ca3 with SMTP id a640c23a62f3a-ae05794251bmr1534090266b.20.1750734780193;
        Mon, 23 Jun 2025 20:13:00 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209a80sm811991366b.176.2025.06.23.20.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:12:59 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/12] bpf: Add function to find program from stack trace
Date: Mon, 23 Jun 2025 20:12:45 -0700
Message-ID: <20250624031252.2966759-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2903; h=from:subject; bh=oiP/xIzbI9W70AcEsurmTpHWGJ3Das1QgoRAA/lnGvI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWd39gsR8EGCom+w+gONDBqXEowfFQd34aQkskw Fq4q1zmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVnQAKCRBM4MiGSL8RymOdEA C3bDAVKnzHCFb6sRwku86TdlCVYZ39l/wICUHtZ3cIU7bMR7cxcUTdQE1e9SPCXfr5V6t4b796CW3M HgUBBh3R+/AWtKI1ONYZsWtfBxhRqxVq5KMtR67FDer0hypzLb6HhHTmziVU1UPYu/JJzH4l4HK5V2 s6XTuWnEf6vO4ieCjXRWXsZonB+zJqxCLrJ5ThNOF6leVfWDG02K189H1QMrj5VpemkNKJeWzwFi1R ubCLliFS7JbNfizsYYr4PJwfnFvLN8/Se77KfDi13rUh03fBO0IPJJvD40mZBA2nabY3Iwsb1geBl9 +rjvaCRXI9dy5vARM8gyjBrH80OGbecy08g5BlQ1WWlLitvuO3GBHtS1slUOB9BIxNzjMprv9ZognR 948fB52RI2e+15djyqstYH6KP46tGCEtSb/jQzuy3jtmRG/fM0/0eb8jgWRWCbafVeibh1gNeqgXG4 cOJqYNiMPn3KmnF2s17gRHq6087rrqKgL3RR/bmdiAzGgivhM78+kgtatxMND/9ZI/dVtyk7sKpZXt mXZ2ojQ8RwQGf84bErdnOHIPeZc1yacfEkmBGJ4ZUQn8lJXa/PlPqbMGDsxswHibrBT4oHTvsuQn0E zHqFfZnsLxiaaYKPGcxvwb5AtDqQwRH+yGt0zERmKWPVEV3n4kXaCxhRySAw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In preparation of figuring out the closest program that led to the
current point in the kernel, implement a function that scans through the
stack trace and finds out the closest BPF program when walking down the
stack trace.

Special care needs to be taken to skip over kernel and BPF subprog
frames. We basically scan until we find a BPF main prog frame. The
assumption is that if a program calls into us transitively, we'll
hit it along the way. If not, we end up returning NULL.

Contextually the function will be used in places where we know the
program may have called into us.

Due to reliance on arch_bpf_stack_walk(), this function only works on
x86 with CONFIG_UNWINDER_ORC, arm64, and s390. Remove the warning from
arch_bpf_stack_walk as well since we call it outside bpf_throw()
context.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  1 -
 include/linux/bpf.h         |  1 +
 kernel/bpf/core.c           | 28 ++++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc..40e1b3b9634f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3845,7 +3845,6 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 	}
 	return;
 #endif
-	WARN(1, "verification of programs using bpf_throw should have failed\n");
 }
 
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f30697c72ba9..cc14ff8e0b88 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3669,5 +3669,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump);
+struct bpf_prog *bpf_prog_find_from_stack(void);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b4203f68cf33..3871d817396d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3262,4 +3262,32 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	return 0;
 }
 
+struct walk_stack_ctx {
+	struct bpf_prog *prog;
+};
+
+static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct walk_stack_ctx *ctxp = cookie;
+	struct bpf_prog *prog;
+
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (!prog)
+		return true;
+	if (bpf_is_subprog(prog))
+		return true;
+	ctxp->prog = prog;
+	return false;
+}
+
+struct bpf_prog *bpf_prog_find_from_stack(void)
+{
+	struct walk_stack_ctx ctx = {};
+
+	arch_bpf_stack_walk(find_from_stack_cb, &ctx);
+	return ctx.prog;
+}
+
 #endif
-- 
2.47.1


