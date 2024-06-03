Return-Path: <bpf+bounces-31193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F978D8208
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9793D1F22CD7
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50212AADD;
	Mon,  3 Jun 2024 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezy40xEY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A619129E8E;
	Mon,  3 Jun 2024 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417016; cv=none; b=h7QVtPP9DbPlRmGFsW7UWceqq1qvGc1auDaTMQYB0y6mi+H0SDTlCtAh/VqYNCAl7k8JLKXAfRvT/J/wodZ2O2WkryoPN7Sn4WVzkaiI9AgorH+G3nhB0fm6YbWQqqLWquBXxrubMfPN1Pp+elb8zvhUkLXXOIY+h3aPd5CUIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417016; c=relaxed/simple;
	bh=gAwp8yYUnceVBn5scRDmLBn983/3nY5FUXQpnAfxA4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaDUCjZGsfwatOBpQOmLAPsDFch1e4DWbkZWo1OYHy1fFymV95OGPTarXXPq2SBsxHdk1jwm8LLfc93ZZG9fg1/aqragURlFAxcgvEQqvO4Tqb7qBC02warCr++IU+osK2p6P8DofbZ+mgzWd3fGpPrXIc+FamfN16DwsbUb8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ezy40xEY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0fso31811415ad.1;
        Mon, 03 Jun 2024 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717417014; x=1718021814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV9DumgWigNz8izFoAXbyFQWDVcRbsgIhRa9w5EE8so=;
        b=Ezy40xEYPaFhezMeejSvFt2kZ+MgZYhbDIyuKQV+vZsJIYR2Vt+qlVTSjOi92h28gS
         6HH2bYiqEAH75hlGgr/VkDnKj59r2iTmbW6h/3rIZ8OczCwuMP/BciHeTDXIwu1YGYUU
         3ShiXRoTVB9WmtClWh1ejp+ISa4Cqc4JtsEMT9PmdNkag8u5HUSpVRl1EBH7q9Zzuthd
         MmFVlw5S55Q/TZAoEFk0WMUCUuALbT0Kx81LIHNtgfAhOlmOdawgW8PokhKz4uVX/K5L
         b2YW6/Yft/Gw6256jpwEJckiM+iRHbuqtvLNy0JLatvFf7tPSNAI7vRJErXcQ4K1329W
         u/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717417014; x=1718021814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV9DumgWigNz8izFoAXbyFQWDVcRbsgIhRa9w5EE8so=;
        b=kh4Rul2Rx+2JK/bHppAL4AjuGJ7V0cpQXGwbvBOf5uZgPZ279nz4/nOd0y42Mi76Zn
         Ht9bxHm8retdGu4lpebSWiKkdSHxz0moatwcHqc7AjdV3ULiee7zXclBuwPptJp7JjI+
         JU5nahtcOCIONrO/o6SeqvcgcclYxen6NXze7EHv6q/1jsd5PkaD2Tj7rClhYh6QfihE
         sH/ONPQMxp/GrqBR89QlBg72vFz/n23/jGvtxngI/7cd/C2i1qiz+SZmu/LZVvYVE6Zj
         45wabiVagrfcgQo6buR5NNchqV7Bbeq0+HyHR6PdR9GYiAUi8Fqyyi4c3UIRft+AY7E4
         qauA==
X-Forwarded-Encrypted: i=1; AJvYcCWL1PJxPjF8FJbeh9821nplamOHt7ZY7qNhmg4v/G0FNAVSqbY3K/d7ozPmSLO0VqTjp1muD3307hM0NQ6TmLXumjsd2hJ+
X-Gm-Message-State: AOJu0YwUZXcUGIv/4bwUaNZKPViLWa+UR+Qljs1ADwLTz06LLN10tcUQ
	lNGaq5P5Ihnu3jWFRAvyPH59YywWtneOFFmrjiYFbI2pjm9Mx/1SFDHIRnOj
X-Google-Smtp-Source: AGHT+IGdxb+vI/H6XZG0Ofw/pjF/mGH+P4AD2GKh7+hySgsW8eiq5miB/tAJIU7b2PA+6FyFrFVPxw==
X-Received: by 2002:a17:90a:e00a:b0:2bd:fa57:b35c with SMTP id 98e67ed59e1d1-2c1dc590a25mr7119648a91.28.1717417013620;
        Mon, 03 Jun 2024 05:16:53 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776f526sm8340820a91.13.2024.06.03.05.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:16:53 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <Tony.Ambardar@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v1 2/2] bpf: Harden __bpf_kfunc tag against linker kfunc removal
Date: Mon,  3 Jun 2024 05:16:44 -0700
Message-Id: <5ed38a5ed9e30232682ac9a57a9ca4bc0a1b9bd3.1717413886.git.Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717413886.git.Tony.Ambardar@gmail.com>
References: <Zl2GtXy7+Xfr66lX@kodidev-ubuntu> <cover.1717413886.git.Tony.Ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF kfuncs are often not directly referenced and may be inadvertently
removed by optimization steps during kernel builds, thus the __bpf_kfunc
tag mitigates against this removal by including the __used macro. However,
this macro alone does not prevent removal during linking, and may still
yield build warnings (e.g. on mips64el):

    LD      vmlinux
    BTFIDS  vmlinux
  WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
  WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
  WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
  WARN: resolve_btfids: unresolved symbol bpf_key_put
  WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
  WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
  WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
  WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
  WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
  WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
  WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
  WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
    NM      System.map
    SORTTAB vmlinux
    OBJCOPY vmlinux.32

Update the __bpf_kfunc tag to better guard against linker optimization by
including the new __retain compiler macro, which fixes the warnings above.

Verify the __retain macro with readelf by checking object flags for 'R':

  $ readelf -Wa kernel/trace/bpf_trace.o
  Section Headers:
    [Nr]  Name              Type     Address  Off  Size ES Flg Lk Inf Al
  ...
    [178] .text.bpf_key_put PROGBITS 00000000 6420 0050 00 AXR  0   0  8
  ...
  Key to Flags:
  ...
    R (retain), D (mbind), p (processor specific)

Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202401211357.OCX9yllM-lkp@intel.com/
Fixes: 57e7c169cd6a ("bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs")
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
---
 include/linux/btf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9e56fd12a9f..7c3e40c3295e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -82,7 +82,7 @@
  * as to avoid issues such as the compiler inlining or eliding either a static
  * kfunc, or a global kfunc in an LTO build.
  */
-#define __bpf_kfunc __used noinline
+#define __bpf_kfunc __used __retain noinline
 
 #define __bpf_kfunc_start_defs()					       \
 	__diag_push();							       \
-- 
2.34.1


