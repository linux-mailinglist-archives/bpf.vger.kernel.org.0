Return-Path: <bpf+bounces-62206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FCEAF658A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4776E1642A6
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335E2E4983;
	Wed,  2 Jul 2025 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmZqOoYy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744562D9496
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496145; cv=none; b=HW+9wPXa2gJgK2e7cKQIaFBMF59k2yTQgLk1J+a0qCzSWReLgVATJm9pN/zkNHKLzBYYNyUCblLdL8zEJqFGeAlx7E5DDaQDlDO9XTIIrwlkw79zSvJ8xlq5CRLmEyeWp7C5OV92UC7vv6k4OelVfOhL5EwUnOxZDAGzIC4Gyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496145; c=relaxed/simple;
	bh=JHF/WOQGbCsrE9pmWONaPMDFvdR0TPZaYhyInX39pUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGvS8GJliUh/Idm1l7Yyrob36qwvYCPdKb5N4YlpbbV8kUDtrKFeJu0ACjbnxmqib0bZyeub0TWDYuuTEGZBoqfgsVYIV0tXGGm+NM/NGuhZQXCvFC9c3Er6EVztUorDrfJectPI4iOIuwGWHtdPie78Gf+13BqYG71l21dNuhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmZqOoYy; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e819ebc3144so6541038276.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496142; x=1752100942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f04wUz+87ZRxzfhUVSCY9LS4vSY8+MApwVKZF19z18=;
        b=UmZqOoYyy2vymcOUQBrptXfMcALtwNeBhzE5TU26FzXOl/ezp3vmGnzbe4RxTaN3OY
         hCJZQ6jQVBoRgz4o0KinD2WL8bRJfI48iT15B75dfJI7EkoevIW/jeQ9G3cvP8bwS5m0
         nzhsvpGPEg7mZ5JlDnuqbgkKFd0NxsXWzmBbjSoGHNSzWqotZlxU0+jC2kba3g5tuA8C
         nnumRlN0nU2GslouJAyJ5Qgsb5JJ0wgekreEnO0m9pbJI6D2FPGFQRe8ufRXfz+jUFjc
         7qIyNtJs2yhImGczzR8ZWKoMHoGGjtvXWQdDCmP+Enx7VsKiQlBQNNW1wYh4qol/6d+G
         Qm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496142; x=1752100942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f04wUz+87ZRxzfhUVSCY9LS4vSY8+MApwVKZF19z18=;
        b=KYpRDT8H26lOqFHFV0+7rJ57EJCC0o2ZPem77O0VPiXd186CKmap3wACb7B9gGwcqt
         TbRzyefMC/qmiojillCqUsZYhA49XFYYnsSEzGD4tWqMHoVRPDj7NygOX6YgMxoBofb7
         JU78LjWaCBGvZAMAWnHaYdeUSr7hVqEn3jRYOlKac4hzsb/ecPOI/NnLqLS7a3DMGNHO
         QGlwEGcKdWrq2+kATHJz5a02+qqptqmvro8M6T67DtEFMxL/sgmsgLAkdM1XSG01CL2U
         pCIEYa7I4gbqZ4/R8y7zX/BKIIfj2VBmwy2czLGbL+wnsR9c2grnBPo6m/Cwp1upiuVX
         fLKA==
X-Gm-Message-State: AOJu0Yyp3CVQNPjtdnVC65qmOXlGODJetdXb+BZixSFlwf44YZZY2Uha
	vF+iwbGCk/I+vtDDVIMaLIHLcWDsIf7260DhuEjiL0UgXjgrn6tAYKj2FhQeiNZY
X-Gm-Gg: ASbGncusAknL7Wx6W2CR6F05bA8GGViOYAGNloaGSvsxkp9P6hkPY/iiokovBinRLOv
	87/iLhRUKjF5sVvG+4xB1e04eS02+/P0aF+YSZ4taiBzXDgJSS9jGA4H5VWtkn+dRxq9y4K7cea
	6TPD2iK8t5JIZT8n/nVmPM+Cv+IEI5/RHftZwqm8i1jl57qRIPVsAKynSSosPsosWH/dHVzCZE4
	4kQ0QoFG9NVxdOrjmj3rsn7/DTfhiIyN+HQKXBuRCn+jW28O8bHYRwgSwRe99jbtPpt19LDAGgf
	PAusASFtVSMlWcQDJ8K/kRHQr7T8sHWMFLnJ+/uggwkmyWaimvTKXWw3xmWXfCM=
X-Google-Smtp-Source: AGHT+IHyBlV8ajZRvqZxoVLhuM+jRzaINm+4WzxT0GAmLLF2SRVRfkbxgrXY3QResBqrSgYQV5q5kg==
X-Received: by 2002:a05:690c:6186:b0:70c:bd93:452d with SMTP id 00721157ae682-7165a338b0fmr13170707b3.15.1751496142335;
        Wed, 02 Jul 2025 15:42:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515c8f5afsm26908317b3.79.2025.07.02.15.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 8/8] selftests/bpf: tests for __arg_untrusted void * global func params
Date: Wed,  2 Jul 2025 15:42:09 -0700
Message-ID: <20250702224209.3300396-9-eddyz87@gmail.com>
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

Check usage of __arg_untrusted parameters of primitive type:
- passing of {trusted, untrusted, map value, scalar value, values with
  variable offset} to untrusted `void *` or `char *` is ok;
- varifier represents such parameters as rdonly_untrusted_mem(sz=0).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_global_ptr_args.c      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 772e8dd3e001..f91d9c2906aa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -245,4 +245,45 @@ int untrusted_to_trusted(void *ctx)
 	return subprog_untrusted2(bpf_get_current_task_btf());
 }
 
+__weak int subprog_void_untrusted(void *p __arg_untrusted)
+{
+	return *(int *)p;
+}
+
+__weak int subprog_char_untrusted(char *p __arg_untrusted)
+{
+	return *(int *)p;
+}
+
+SEC("tp_btf/sys_enter")
+__success
+__log_level(2)
+__msg("r1 = {{.*}}; {{.*}}R1_w=trusted_ptr_task_struct()")
+__msg("Func#1 ('subprog_void_untrusted') is global and assumed valid.")
+__msg("Validating subprog_void_untrusted() func#1...")
+__msg(": R1=rdonly_untrusted_mem(sz=0)")
+int trusted_to_untrusted_mem(void *ctx)
+{
+	return subprog_void_untrusted(bpf_get_current_task_btf());
+}
+
+SEC("tp_btf/sys_enter")
+__success
+int anything_to_untrusted_mem(void *ctx)
+{
+	/* untrusted to untrusted mem */
+	subprog_void_untrusted(bpf_core_cast(0, struct task_struct));
+	/* map value to untrusted mem */
+	subprog_void_untrusted(mem);
+	/* scalar to untrusted mem */
+	subprog_void_untrusted(0);
+	/* variable offset to untrusted mem (map) */
+	subprog_void_untrusted((void *)mem + off);
+	/* variable offset to untrusted mem (trusted) */
+	subprog_void_untrusted(bpf_get_current_task_btf() + off);
+	/* variable offset to untrusted char (map) */
+	subprog_char_untrusted(mem + off);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


