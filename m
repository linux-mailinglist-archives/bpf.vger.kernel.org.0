Return-Path: <bpf+bounces-26757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B538A499C
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 09:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55EC1F21C80
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5A39AF3;
	Mon, 15 Apr 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HAvSx/M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4B376E0
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167933; cv=none; b=UH1NpqpRm/9cxRh2ggwM8gv4rkrpJyR5K9iRxWbQrf5G1dS6Mlg7AiaVFEjIQKckK5GH5sEr1Akrn4zBCNzDAsgIzpVf0Sv5NnKF6NUoTNb+eyUPQOOluI8uhxL4n2a6/MOnEl5gSu5dwGzfMU6/Uw3SvHQzBMlaMM1rpwlIQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167933; c=relaxed/simple;
	bh=pSFwalqd3s5K1XjaH3Dk31u90WGesAg2Ef0b/1JvrU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kdIsbhB2+hjeBKxg2p/gZkq09p8MR48MxmSQYtx2sv7e4SM0duO3VCjmi/S0XeBwd8y/iQSsiXM+2Jop5PZ2GkctfN7U9U/yY6kC7KXGiYUOIc8c/VwpSoqruUl0p+nYe7Y0Ed2KbBPcqeIIOoVONGjLSO6A2esLdbOQ/FkuKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HAvSx/M; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343ee356227so1871564f8f.2
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713167930; x=1713772730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xg18GyqyaeWty+ItqB3Iy6JPUVdZJOOF1IDiLwlHKNc=;
        b=1HAvSx/MirLi8qZCPzjzHBXa65Ssoi1NxSr1WbXE1tcQ/ICSMSEvcygfVcfd1Nrepn
         AG8rvW3Y2OuQ/bs/JreqLGS5lySPq6TSbz+k8k8tZlQnjS3ZdsinDqMBuvyIIOgjVDTg
         Jgq4+6BGPyW9roK9uwf/YHo9pJZUnWF16e7dK3AIvAmZIkJUeseFYMWNaOx5nidl+zOU
         A4QCbzitJSEGzEyDULWUkbwuY2Ayy9rZKiyNvoXHNQEqi8NjCoE6NVaTDXifoOtVZROd
         1qa4UxvQfpgqw77SpQISVBsThS5PSArm4TrBY6K+q8As7oygPyoGY+yBRzHuTEjq4ZJZ
         6PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713167930; x=1713772730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg18GyqyaeWty+ItqB3Iy6JPUVdZJOOF1IDiLwlHKNc=;
        b=b6y567XXIfKeelyhjRNCc5LtmjqD8NP7pTZ92f3VrJVau4qMYD3VOIJHBiHQTJOI2s
         XjypKmcJzM+IdOQWAWr8JTDjbuwQj4XAJevofZSqSl0Oj8clieMp5TzkVSaLKSoPjBwY
         jxTm+IUanFUbDBiIeumVvubkg/Ao/p5tYI9Ae4ZircTktHjtnxlm2wbSvKYgyQYMfCle
         niUAj9f2pRSuGnRoSlzo9xI2JGBh7GbJubHoousWjjUJwviV+MBTLjihTFW462RmWmF1
         kYfpeESULgcASbN/nLcfHp5fQ9zXsZeECeOBKHn904sYlLNPmWRAl3QzqtLmLLlJfO/b
         /etA==
X-Forwarded-Encrypted: i=1; AJvYcCXj1kif3WQJ+ZQ8eUywQvPN9bl8QbnweJzq3vcG6tH7tvUQCdb70qGA/iNJ3jA+fDyzMxKPx7/krFA2QTOaGR/mEQ48
X-Gm-Message-State: AOJu0YxFYDe4oHC4sdZd71nxYF122jgpEUctIXG8xIq6ChbE48vusYS4
	xB0qBSOKWKImizgQ4q2fc/bZ9kWDAkM6fCUjayz0632mQec1JsHKU7SQf9Ism2iV+GnvGA==
X-Google-Smtp-Source: AGHT+IE97GkpOEK9YN53r8TW33m7d47GDaBE4OxjbIYnBf83acHkn+Q93xPJ4LiaGWK3NiKjNb4cPYZs
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:e351:0:b0:346:5932:a05d with SMTP id
 n17-20020adfe351000000b003465932a05dmr19116wrj.8.1713167930559; Mon, 15 Apr
 2024 00:58:50 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:58:41 +0200
In-Reply-To: <20240415075837.2349766-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415075837.2349766-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445; i=ardb@kernel.org;
 h=from:subject; bh=Kj7lwSufbF5VMIDGpWufnrtYiMGkl56Qhtk1J6ZR1Ew=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3mnsG81wt++v+NZFuZ8fnStSL1Se6xebsflCjflPkhX
 3RywmGJjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRBwWMDAslmD5NmVr72WvH
 h01cW2oeF76f5MB8fzHHv63X3Fnb9bQZ/sdxMK/3LyxKd/4XrHicbfaGY/l5q7bNjjr9OOdygW/ ZKh4A
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415075837.2349766-8-ardb+git@google.com>
Subject: [PATCH v3 3/3] btf: Avoid weak external references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

If the BTF code is enabled in the build configuration, the start/stop
BTF markers are guaranteed to exist in the final link but not during the
first linker pass.

Avoid GOT based relocations to these markers in the final executable by
providing preliminary definitions that will be used by the first linker
pass, and superseded by the actual definitions in the subsequent ones.

Make the preliminary definitions dependent on CONFIG_DEBUG_INFO_BTF so
that inadvertent references to this section will trigger a link failure
if they occur in code that does not honour CONFIG_DEBUG_INFO_BTF.

Note that Clang will notice that taking the address of__start_BTF cannot
yield NULL any longer, so testing for that condition is no longer
needed.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 9 +++++++++
 kernel/bpf/btf.c                  | 7 +++++--
 kernel/bpf/sysfs_btf.c            | 6 +++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e8449be62058..4cb3d88449e5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -456,6 +456,7 @@
  * independent code.
  */
 #define PRELIMINARY_SYMBOL_DEFINITIONS					\
+	PRELIMINARY_BTF_DEFINITIONS					\
 	PROVIDE(kallsyms_addresses = .);				\
 	PROVIDE(kallsyms_offsets = .);					\
 	PROVIDE(kallsyms_names = .);					\
@@ -466,6 +467,14 @@
 	PROVIDE(kallsyms_markers = .);					\
 	PROVIDE(kallsyms_seqs_of_names = .);
 
+#ifdef CONFIG_DEBUG_INFO_BTF
+#define PRELIMINARY_BTF_DEFINITIONS					\
+	PROVIDE(__start_BTF = .);					\
+	PROVIDE(__stop_BTF = .);
+#else
+#define PRELIMINARY_BTF_DEFINITIONS
+#endif
+
 /*
  * Read only Data
  */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 90c4a32d89ff..6d46cee47ae3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5642,8 +5642,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	return ERR_PTR(err);
 }
 
-extern char __weak __start_BTF[];
-extern char __weak __stop_BTF[];
+extern char __start_BTF[];
+extern char __stop_BTF[];
 extern struct btf *btf_vmlinux;
 
 #define BPF_MAP_TYPE(_id, _ops)
@@ -5971,6 +5971,9 @@ struct btf *btf_parse_vmlinux(void)
 	struct btf *btf = NULL;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+		return ERR_PTR(-ENOENT);
+
 	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
 	if (!env)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index ef6911aee3bb..fedb54c94cdb 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -9,8 +9,8 @@
 #include <linux/sysfs.h>
 
 /* See scripts/link-vmlinux.sh, gen_btf() func for details */
-extern char __weak __start_BTF[];
-extern char __weak __stop_BTF[];
+extern char __start_BTF[];
+extern char __stop_BTF[];
 
 static ssize_t
 btf_vmlinux_read(struct file *file, struct kobject *kobj,
@@ -32,7 +32,7 @@ static int __init btf_vmlinux_init(void)
 {
 	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
 
-	if (!__start_BTF || bin_attr_btf_vmlinux.size == 0)
+	if (bin_attr_btf_vmlinux.size == 0)
 		return 0;
 
 	btf_kobj = kobject_create_and_add("btf", kernel_kobj);
-- 
2.44.0.683.g7961c838ac-goog


