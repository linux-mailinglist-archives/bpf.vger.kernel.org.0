Return-Path: <bpf+bounces-37836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C791E95B0BB
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0320D1C22C34
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C1716DEDF;
	Thu, 22 Aug 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYCbRjBu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B17F170A03
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316093; cv=none; b=HLqoXYRBBSwL60FDhEBqSVdWbRb/eSOhz2uaRHFr5a5TFleZTpebM3mBveyf5NQa+P2hMiRIgAiLAUHpANonxXjxG4iXjAX6KLRNyCopEkvVESqlHfmSk02ku9Z/LCIdkD9/Wik5sRVlR4q6xbJsHmOcfsYKeqrcBpBeRTfESPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316093; c=relaxed/simple;
	bh=1jNeTHyjYKd15gGzLyViANnTwl0v1Qyp38JPFULuTZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otnKnqi2gN69KKhGIUXEARCw3E5aBhAgSBx4TM5XYslpUDRC+RyFOX0esZMt+uV2Hp+bD0OcoDTfiAKJMjib97YS9i1GkQ9ldAfVNZy4OHAkSQpG9gJW5rEjfhCBixFNGEmDjWWqU77Fz7j3U0MTpuZLIvaoaRKEtqyu4YPupmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYCbRjBu; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3de13126957so352489b6e.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316091; x=1724920891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RicDvKkSIbKYxoMdlAjvong9R0egR80C6DFshD8PuOY=;
        b=lYCbRjBup6YoBOt/SkFJQ0oCFEtpOERDd8iReYSCUGB3I4Y4+rwEPwdP8/iWLEoMju
         SjKKppa7lnm7URU4xjjAZpvAAESValV+0kZKKfEECM7UWSRD3eo6aoaDCGTRapLoehcM
         TJ0rHEuGxRePmVO99eX3vrhXCBj/ljilHpq0EQAHyTvWDU3NxmSMJ+pJm0RpPMOPfOgz
         m+NWdIe7fbJ4yOnrdsyjHCkilrBQ5TZaoZ60LK0EztdFRLlRGvaI80nr6wPvfzQqxKgC
         DZAK/GjzP1mOOyJEX8aKhhrGEnwXRX3qOc9g06ekTuBBqREXJQJ7ASjvX5MJHqZ4CIot
         ZYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316091; x=1724920891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RicDvKkSIbKYxoMdlAjvong9R0egR80C6DFshD8PuOY=;
        b=EIlrIBdnxOPTYpjgyfBj4SuK0xcKKuoMLHX0ALPjRDRPx2QzneVeLcT5B6HnK1Pxu9
         SU2CoP4n7Up9vGL1neQacPeWqCXQTHzXyrXa3fR0Tr0e9easNMefypjtWDUhGUcWQaAo
         xc7iEOFu+4ZDE4dgV/0wTDb0OAw43RObrVOgafdpQZ7ol+ihJwuzvcpW/gDI+POXtDHx
         LJrfUeh4FnA1Tw8sd5+Qt8KMflJFkyL2ALc3ny8IcG5BxAFRIL6EEyXU4EFK3pGiffN2
         32V+wKTOKpGljgPMhbeOEhp3lXHv8Bcy5WiPSwzOVBkyAL0t0zdxS4k3IuXBtmfX24M/
         sDnA==
X-Gm-Message-State: AOJu0YzphyuBUWlIkQP6EQThbG4QP0CZF3tXd22wv62ob/SByj8ikXsk
	9jzxsIPHgu5SJIlkHuHHyVbaMv4Wc6pCGL534O38a9je+A5zixXiWzOnpj3Q
X-Google-Smtp-Source: AGHT+IElSW7pgCCXFALKJzHw1Wh6hsE4ox8qhpy4Thw+gPkUJpfYlGjMzuiTIec9heDqgOl9TjeAmw==
X-Received: by 2002:a05:6808:3a10:b0:3da:e2b1:1100 with SMTP id 5614622812f47-3de19d16775mr6014955b6e.32.1724316091050;
        Thu, 22 Aug 2024 01:41:31 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340449sm881692b3a.218.2024.08.22.01.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:41:30 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 3/6] bpf: support bpf_fastcall patterns for kfuncs
Date: Thu, 22 Aug 2024 01:41:09 -0700
Message-ID: <20240822084112.3257995-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822084112.3257995-1-eddyz87@gmail.com>
References: <20240822084112.3257995-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recognize bpf_fastcall patterns around kfunc calls.
For example, suppose bpf_cast_to_kern_ctx() follows bpf_fastcall
contract (which it does), in such a case allow verifier to rewrite BPF
program below:

  r2 = 1;
  *(u64 *)(r10 - 32) = r2;
  call %[bpf_cast_to_kern_ctx];
  r2 = *(u64 *)(r10 - 32);
  r0 = r2;

By removing the spill/fill pair:

  r2 = 1;
  call %[bpf_cast_to_kern_ctx];
  r0 = r2;

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0dfd91f36417..94308cc7c503 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16125,7 +16125,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
  */
 static u32 helper_fastcall_clobber_mask(const struct bpf_func_proto *fn)
 {
-	u8 mask;
+	u32 mask;
 	int i;
 
 	mask = 0;
@@ -16153,6 +16153,26 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
+/* Same as helper_fastcall_clobber_mask() but for kfuncs, see comment above */
+static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
+{
+	u32 vlen, i, mask;
+
+	vlen = btf_type_vlen(meta->func_proto);
+	mask = 0;
+	if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
+		mask |= BIT(BPF_REG_0);
+	for (i = 0; i < vlen; ++i)
+		mask |= BIT(BPF_REG_1 + i);
+	return mask;
+}
+
+/* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
+static bool is_fastcall_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return false;
+}
+
 /* LLVM define a bpf_fastcall function attribute.
  * This attribute means that function scratches only some of
  * the caller saved registers defined by ABI.
@@ -16250,6 +16270,19 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 				  bpf_jit_inlines_helper_call(call->imm));
 	}
 
+	if (bpf_pseudo_kfunc_call(call)) {
+		struct bpf_kfunc_call_arg_meta meta;
+		int err;
+
+		err = fetch_kfunc_meta(env, call, &meta, NULL);
+		if (err < 0)
+			/* error would be reported later */
+			return;
+
+		clobbered_regs_mask = kfunc_fastcall_clobber_mask(&meta);
+		can_be_inlined = is_fastcall_kfunc_call(&meta);
+	}
+
 	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
 		return;
 
-- 
2.45.2


