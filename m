Return-Path: <bpf+bounces-62205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E843AF6589
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C1B1C46058
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521A2DCF6B;
	Wed,  2 Jul 2025 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba3zWB7F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538024DFE6
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496144; cv=none; b=jxwsfy+tqa4JXPro8Xlb070m7w+BRyXDI1nk9MlbsDTE/bpF+vWj+jWVFgju7QMLQWrBYz1F/uJzeN74oxiqY6XuPeHZO8Jth8eBR0xsqpSs/A6FW9uscqQamUdleLc9FSn0ZUMjh/Ejf2RiJi0Eqj998d5LdvPZ6SjqCn5UpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496144; c=relaxed/simple;
	bh=oqHkcDtkqG0SpA3JTbBwiQ4kcTvP+j5uSJOxNed0Gd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqR337a1kARk75+BXOvqsQfDdB31G+nGhp7nHnwnKaUE+udrFlxfO97yCqwjs9b7KsGLQg+R8mWuRqBNsNOtpDt/faYkZJ9z0kdjrD71TAHm+9mGPaJbBcQmXeqlL8yTM4T0+Rc+rl10mFg9kkCcmTBXPdDhs4yGBV4FClHsOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba3zWB7F; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e82278e3889so4856556276.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496141; x=1752100941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/WYGJqMTrCQhg7CC4AmbcORg9FNhG1nZ8iK0zCFmqE=;
        b=ba3zWB7F/50eu44NFD85FIQGyrPiOJPsA/HdxSZwjgtsWQZQfT/ZvCEZFVNt6SeON7
         ecP5r7O5cizO7JoxtGgMK1GxFloEhDeNtuJa4oZ8UJGpK5pW/Im3a2a+3NVumkhnd4Vl
         zLsUqqhTTu9G997tElxOhpR7ngbops4IbZGA2roR5BNf/eNjCdhiuHt+oDXgfqi9nTl4
         GQ0bf/9HY928lfkw66mJ27FKCfQuGaT8FlJxvcd687owCRxdBu6Zm3tHc9jA00Lo2z8y
         H3V2Ka42geny8xcvxEoqMif6tjw3kZ1wcuwFqpt6hpf14iv5a5quLPyxPeqyUeX2KHaO
         sXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496141; x=1752100941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/WYGJqMTrCQhg7CC4AmbcORg9FNhG1nZ8iK0zCFmqE=;
        b=VffUXq0LvXFfodfzFcpElA5jAT2qiavIRcEHAvkYCO8TLEyv0loSdw1VWuXp98p4RQ
         RgooldeBhb6QrQG0v6C5FNf1hhsGY3qXNErHoY3USBp5181Bs+qbyb0skbLTjkNsW4d/
         A5Y3iNVNvolTlHLbjgQ+9ormuY4qC3xeVx5aSzgaKmSlvxLYewnFVA0klqobnhJqFXXK
         6tepFnrRtuTdh7bXywKNwOS6LfTEwBxEo9DTKzlGy/0o3L6Rm4CxCdc8jbr26Lm3T4fY
         skYd+BR55JT3Rz7axV1W+VildLEN2nj99os5oc1ssCOy0QAbgKHUPLKOFCLZpdbfGvnX
         r++g==
X-Gm-Message-State: AOJu0YzqPKJ+GmJ+JKS7WFkcU1ghkZilNaGyW97E3kkt4/BW09ghQnwg
	QiCl6C+CLaZfYVA7vw88R5AdQ5UWlNGexR0AtBGp53t3UlFgh5s2YN1yTyyt6hN/
X-Gm-Gg: ASbGncvHV8cigbSGIiQVtEZKPml+o8dNTcZBQxPYEgRsxYcfHwM/OjLutDQycCLkc0T
	hnvRN//tstpPhnbteylhcux/wuHSeBmvgDeLCsZYEjocd1iMXo8SUQIea6zDOkMFBZ/K9DjMKjS
	1+rWEEV2RoY1HAd7zRNE5C4+GH6tNkux8wedpbX4oWcgEikFthdTd7m6F32dXYaSUFTFoJJ1/zW
	88vuCh157h0ztQykL5wEpfFMYTxT2PWrkGrt2g2DVo2nT1Lz6le/UqAL6kyHJk9aDngk+DbfznN
	Oul6Fi5mKBovQ2BR+hPQGtGajOgk0AJmx3YtzBowxR9/WN0wXg3FhQ==
X-Google-Smtp-Source: AGHT+IH5tTdtRF9OfYiINAanF35o8Jj+G/QtMnsxTXKiKzEWPgCuBLHxkJaUXmuhW/NHnNPXyaZzpg==
X-Received: by 2002:a05:690c:4442:b0:70e:18c0:dac5 with SMTP id 00721157ae682-7165a33803cmr12396147b3.10.1751496141530;
        Wed, 02 Jul 2025 15:42:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cc6e76sm26556627b3.111.2025.07.02.15.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v1 7/8] bpf: support for void/primitive __arg_untrusted global func params
Date: Wed,  2 Jul 2025 15:42:08 -0700
Message-ID: <20250702224209.3300396-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702224209.3300396-1-eddyz87@gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow specifying __arg_untrusted for void */char */int */long *
parameters. Treat such parameters as
PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED of size zero.
Intended usage is as follows:

  int memcmp(char *a __arg_untrusted, char *b __arg_untrusted, size_t n) {
    bpf_for(i, 0, n) {
      if (a[i] - b[i])      // load at any offset is allowed
        return a[i] - b[i];
    }
    return 0;
  }

Allocate register id for ARG_PTR_TO_MEM parameters only when
PTR_MAYBE_NULL is set. Register id for PTR_TO_MEM is used only to
propagate non-null status after conditionals.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/btf.c      | 13 +++++++++++++
 kernel/bpf/verifier.c |  7 ++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index a40beb9cf160..9eda6b113f9b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -223,6 +223,7 @@ u32 btf_nr_types(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
+bool btf_type_is_primitive(const struct btf_type *t);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 28cb0a2a5402..ffe560c0ec65 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -891,6 +891,12 @@ bool btf_type_is_i64(const struct btf_type *t)
 	return btf_type_is_int(t) && __btf_type_int_is_regular(t, 8);
 }
 
+bool btf_type_is_primitive(const struct btf_type *t)
+{
+	return (btf_type_is_int(t) && btf_type_int_is_regular(t)) ||
+	       btf_is_any_enum(t);
+}
+
 /*
  * Check that given struct member is a regular int with expected
  * offset and size.
@@ -7829,6 +7835,13 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				return -EINVAL;
 			}
 
+			ref_t = btf_type_skip_modifiers(btf, t->type, NULL);
+			if (btf_type_is_void(ref_t) || btf_type_is_primitive(ref_t)) {
+				sub->args[i].arg_type = ARG_PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED;
+				sub->args[i].mem_size = 0;
+				continue;
+			}
+
 			kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);
 			if (kern_type_id < 0)
 				return kern_type_id;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dfb5a2f8e58f..53f70ef9adc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23158,11 +23158,12 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
-				if (arg->arg_type & PTR_MAYBE_NULL)
-					reg->type |= PTR_MAYBE_NULL;
+				reg->type |= arg->arg_type &
+					     (PTR_MAYBE_NULL | PTR_UNTRUSTED | MEM_RDONLY);
 				mark_reg_known_zero(env, regs, i);
 				reg->mem_size = arg->mem_size;
-				reg->id = ++env->id_gen;
+				if (arg->arg_type & PTR_MAYBE_NULL)
+					reg->id = ++env->id_gen;
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
 				reg->type = PTR_TO_BTF_ID;
 				if (arg->arg_type & PTR_MAYBE_NULL)
-- 
2.47.1


