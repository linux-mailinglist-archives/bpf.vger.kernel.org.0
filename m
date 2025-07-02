Return-Path: <bpf+bounces-62198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FF9AF6580
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A727A953A
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D473024BBF0;
	Wed,  2 Jul 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUqQ4n8E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D01DED52
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496138; cv=none; b=uxbWc0XpCeIlo9H+10kBMrUbRD7t3wWs5iJMrIs3UxzwNIjm93sa5rG5pZIaa9wokEwp3xuKpH7U4CMPbnnHYdiHtJarvCuL/gZ6F6/SP3CyMxYgIQaH0dslqeiN+pepd5kDAa0i7Uz14aAiL4IXZPphMbf7kxyoWgDYwgV6ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496138; c=relaxed/simple;
	bh=9ey5Y/1P7qQV7dnyHyriKaqeET56Y+qVD+rmacxc97k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyMur2lxPEtJ2knivWKWUvJ3RFDcTvZxslGrGjKgJPZ93cv/q4VMnyzNygWyB/fe6TzETCIvY704JITLu6E3qnd7SShpUUKLY9qtyvnAjG50vW9avawhChG34xRSou92UruJrIp9eSOUytckEmSIy3EOwuwdsc0rgF/9bx12uAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUqQ4n8E; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e73e9e18556so476206276.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496135; x=1752100935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgce3oeOuvaoA0e+L4+IZ/DYKqd0gDCh+qmJtUIrX5g=;
        b=HUqQ4n8EwEShJF1wQbgmSeAJ+L9uwaq/Gbhh8MeGFDN+u3xvXANt5geTT/l1VkfnCy
         AQ566kmj2T94uN7iwOFPFVGNB5aO6ooAp1+XPz4UfrdJkneBkMM+E21Zt5j60f0S/Zcz
         xbL1s5B6dXscNccPLgdaivy0oOoVA0r81cpm+A8oJPEZiTClM97W3MJ3XHAdvAi50c1s
         +MN/acl3XZJkBkK6EVQSfFZV6T1wkbOhaeMXjCPwuH+yw8s39/ekbIh+seEVyklPVb3v
         AJjo8gbqhOX5JHq7sxZ8EFMmi6YI2N4vYxQrTSP1rMYn5o4tHoU/w+cdH3UgsgVF/oaf
         6//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496135; x=1752100935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vgce3oeOuvaoA0e+L4+IZ/DYKqd0gDCh+qmJtUIrX5g=;
        b=WCAuhzk7vUfNsWchaMcGyp7vog9GVABmeTRcg355mJ4148diUJ84P5c+cVushegVm0
         dINejM858jP7QuVdHFhn3RJl8HKUI43RPHQoPn5RUKC2W8tv4HSj1l+hLSoD0jkZT7V2
         urxuPZVOapLCL0zCYcH8Wr5R62ptYwlX2lKqW4GWocwqbp7/4EbNWXNqeTYpTRKFaPhp
         dHyAp3bwJzneLUmvSSqrdwUA3qlqA0SRAe0UoC09cEvOxM6M39AqZvXiNMftEWJvESOR
         qS0LrUMEv7wrvDKaGklLPDivAeEDgxKNiFaoAueNYmECJBA5DxWQ3BNqOBxGaxsxBF1g
         jaCA==
X-Gm-Message-State: AOJu0YwV3TqDcgJoNskSNzeoUFutYCs4kZdQLimcSbOQrvZ9R9+Y8fTJ
	9TYc0UyBGVi0NryW8IES3+WVMpKghr7ZjIPR+pnDtf1dIQEese27caqUZvXwTT8n
X-Gm-Gg: ASbGnctog1+gKuyNqyoMlDNNO1cv5dOnZMgbdwpzoJHNDqOn/QTarES9J8a3HDqJkfX
	okZHTe4jecbZjT5ab6XybSel0yABEFUAuTnehoCyRfZDF9NGPLbfciKTxaAQSyVbwdZ45CYnXDq
	+YS3+28EG2JYfITaK427FBixB/giuPGjY4JD1KgvV8JhyrhuacF9/3mWCefEr1cSd2EfoaH9Uuz
	/iBDr61aeGGRAhnl92otJGP48PTbTsJ0XkAi/2VZ+RDR7VpnLtoOqeIy4lcx58duwlGFhc9Fast
	XMGbKUnebJ3/EBVXc4I+8XPC6256K4TRGRH2zwBqFljaIDFmr0mdBw==
X-Google-Smtp-Source: AGHT+IE4UMMlQmEpgZNMrfECygTanSQkmHUO3nfbVAOzYGyV+MghWB6iz8OYXBEwccwKKoAc0boMuA==
X-Received: by 2002:a05:6902:138b:b0:e87:9bab:8ce with SMTP id 3f1490d57ef6-e898eaabf02mr1851312276.23.1751496135584;
        Wed, 02 Jul 2025 15:42:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6bf0071sm3968723276.51.2025.07.02.15.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 0/8] bpf: additional use-cases for untrusted PTR_TO_MEM
Date: Wed,  2 Jul 2025 15:42:01 -0700
Message-ID: <20250702224209.3300396-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set introduces two usability enhancements leveraging
untrusted pointers to mem:
- When reading a pointer field from a PTR_TO_BTF_ID, the resulting
  value is now assumed to be PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED
  instead of SCALAR_VALUE, provided the pointer points to a primitive
  type.
- __arg_untrusted attribute for global function parameters,
  allowed for pointer arguments of both structural and primitive
  types:
  - For structural types, the attribute produces
    PTR_TO_BTF_ID|PTR_UNTRUSTED.
  - For primitive types, it yields
    PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED.

Here are examples enabled by the series:

  struct foo {
    int *arr;
  };
  ...
  p = bpf_core_cast(..., struct foo);
  bpf_for(i, 0, ...) {
    ... p->arr[i] ...       // load at any offset is allowed
  }

  int memcmp(void *a __arg_untrusted, void *b __arg_untrusted, size_t n) {
    bpf_for(i, 0, n)
      if (a[i] - b[i])      // load at any offset is allowed
        return ...;
    return 0;
  }

The patch-set was inspired by Anrii's series [1]. The goal of that
series was to define a generic global glob_match function, capable to
accept any pointer type:

  __weak int glob_match(const char *pat, const char *str);

  char filename_glob[32];

  void foo(...) {
    ...
    task = bpf_get_current_task_btf();
    filename = task->mm->exe_file->f_path.dentry->d_name.name;
    ... match_glob(filename_glob,  // pointer to map value
                   filename) ...   // scalar
  }

At the moment, there is no straightforward way to express such a
function. This patch-set makes it possible to define it as follows:

  __weak int glob_match(const char *pat __arg_untrusted,
                        const char *str __arg_untrusted);

[1] https://github.com/anakryiko/linux/tree/bpf-mem-cast

Eduard Zingerman (8):
  bpf: make makr_btf_ld_reg return error for unexpected reg types
  bpf: rdonly_untrusted_mem for btf id walk pointer leafs
  selftests/bpf: ptr_to_btf_id struct walk ending with primitive pointer
  bpf: attribute __arg_untrusted for global function parameters
  libbpf: __arg_untrusted in bpf_helpers.h
  selftests/bpf: test cases for __arg_untrusted
  bpf: support for void/primitive __arg_untrusted global func params
  selftests/bpf: tests for __arg_untrusted void * global func params

 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  48 +++++++-
 kernel/bpf/verifier.c                         |  78 +++++++++----
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 .../selftests/bpf/prog_tests/linked_list.c    |   2 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |  31 +++++
 .../bpf/progs/verifier_global_ptr_args.c      | 107 ++++++++++++++++++
 7 files changed, 239 insertions(+), 29 deletions(-)

-- 
2.47.1


