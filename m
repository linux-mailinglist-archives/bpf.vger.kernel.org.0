Return-Path: <bpf+bounces-26299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC889DDA6
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB0528E0A9
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA491350D2;
	Tue,  9 Apr 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xjvwx9k3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0B1350DA
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674911; cv=none; b=F5hXfJfhztOgJvELVAT/GAWYK1I0H2Wey6CPlOUeYf0ogqxGCl8q8BQdGDPdHr8EIPSB4RrfR3EAtJautq0tL5psNg55rCH0HdcDPlFz22shYCzGyX+w+1Tc4Jilot9R2i72wkZB6UjhTA8GFE+W5jwrKcfU6y3vwpeSlX71vq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674911; c=relaxed/simple;
	bh=2XRLBMqkeM5HXNl5EWou8ZB0E0TV13o8LSI5x8BSvlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qCos7Q8O8cP6KV5brnmLaSZWPjYwn8QZUK0+21X4GaIE+DIly6kc3XGwwjst8Zp1hqtWKLAhqliFeYd11XRlXV4RBCQwG27UZr+Jr3EDyutAJfzFUa/7++MrUcoFD7F2t2rhdxymiG47KQSozZYmlZ6rtaAzX0su3oOfDTTOpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xjvwx9k3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4166b96002dso10630715e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712674907; x=1713279707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+c7Nae7lWjUxFMlj/H2Ns6fhkmPqVh4ydm9u7CZiONI=;
        b=Xjvwx9k3qQCxCqCPdMfNuiDIs0K/ej3onc8KTfYn8pWkSS4Ix8PnySLBwYMt+aAEh1
         SEM5HwkuUPwEC3ftN0Oy07gEsbmWLfeJiIgRlLOH7x0d4mtVAyzQJDLOU8i18LT7XCHY
         bkwFtdSFCB/IIwPMfeJ4sk8WJ9HJ5fW+PELHzkz2BCRvaOH05GVK+gLYDJTZYha9kHz1
         NDCN5F64Q2PVakeKVNLpSLHssJ9xB+pegmXosI5DAgv7USVVBmaYNZAq4Q24DNrozqJi
         Qt5kkFfMs/CpNDW9/gUToAkQRRnTrbsPkQ2vR2kO+Br5wSUsxVruyIMZ8CVGMoK/0XKi
         10NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674907; x=1713279707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c7Nae7lWjUxFMlj/H2Ns6fhkmPqVh4ydm9u7CZiONI=;
        b=vKtD4hvjATrtL+fpcCJ8LW/icc2SRgLprPA3fzplUJxD1bJwYfTilEYtU9nrhIrrCf
         KCT5O/na5Fu012yn1TOrrA5oD4DNWDNiPCAiJXWkbGnAldQ6ZKufc8VCae70CEP21+3n
         JsVU5EkGXGPmyFK9bBtw2/ez9SR0eIGwitetByPDrMEltwtFnZrKmheqXWNp2ft7v3K5
         UnPD0p8nDtWEwajIVbYmogZxh75JEankIButbCY85/FVuneix3pBGEg+3GgsH2ahePpp
         FFtBPC6t+QP/BnNVaUsyh7tM7dNideFt8cSokUoOjmv4BvKE8+Yx6XED8Q97oa/rF0eL
         vWJw==
X-Forwarded-Encrypted: i=1; AJvYcCUZwusuQVGtsX3g6ORT3Uhe34HCUvPc1gt3T55ZE+sUICMuir/R2mWmKM7tksxMecPBrkMyKP9mFT5QjJJiZ0Jpr1+U
X-Gm-Message-State: AOJu0YyYcWMD2GhC6PGjyRmZGErvPZp4vB7hP1apIMKPAlLcmZtpiVij
	9WTsR0VTy4XSKho+psK0lAxXbSbFNL7yDNFCZGJOIFZViXdv2t8Yl6IWwTf0jS7hkZkwLA==
X-Google-Smtp-Source: AGHT+IFXgzgigm6gF3ssRomZsMb2tDkm1/NBAMp7/v4nwt6/VHQkX6fUKALfUDlw7BZpcWQWvAe2T1rU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3b29:b0:414:a0c:a82c with SMTP id
 m41-20020a05600c3b2900b004140a0ca82cmr31439wms.4.1712674907499; Tue, 09 Apr
 2024 08:01:47 -0700 (PDT)
Date: Tue,  9 Apr 2024 17:01:36 +0200
In-Reply-To: <20240409150132.4097042-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409150132.4097042-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3124; i=ardb@kernel.org;
 h=from:subject; bh=AkRYLBTm6VuFUE4hRnB+rntHpPOXzattnmr7pMUxTAQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU00IkD3NPOKFTu0Hs7W2XPVxMPG4eyLtet0z14zVlho3
 KFyPPBNRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZgINw/D/5zHBY8Yjzz8ViLP
 eCfHpP8DU+J8q72OZiqLNCeGfRA3es/IMIf9kPTBh1IGWxLPFGtVLXWe99aYPWVPvPNpXZv3S38 6MgIA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409150132.4097042-8-ardb+git@google.com>
Subject: [PATCH v2 3/3] btf: Avoid weak external references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
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
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 9 +++++++++
 kernel/bpf/btf.c                  | 4 ++--
 kernel/bpf/sysfs_btf.c            | 6 +++---
 3 files changed, 14 insertions(+), 5 deletions(-)

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
index 90c4a32d89ff..46a56bf067a8 100644
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
2.44.0.478.gd926399ef9-goog


