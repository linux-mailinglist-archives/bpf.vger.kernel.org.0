Return-Path: <bpf+bounces-71382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D5BF0484
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89F124F3680
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC82FDC23;
	Mon, 20 Oct 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYC0cjCO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C662FD1AA
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953208; cv=none; b=iHLgXrp0BfpmUvAKmJ3e6YYYimJ9HZT8IPBEB4KUfCst0wibDmRJp6YJ83EpphTVyXCiT2itT+JcI7vtJfkgn7CB4SmRW3q3m7RpV6lNH+4KzyeZG0dAnvy20awsYXH1JtFBATeQtfdh7htGwlyZv1FZDEJ3RtGuhTqiTHLbkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953208; c=relaxed/simple;
	bh=UMitIlA2M4WXFaslfg7FKwsyM5qUsWB8ogi61DvsqC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6ZOiO4CrKiGQIfjR1IclWB3z66aUfDb7NQvJqI+2K1Q3jwwY5RHmT3F5GUN/v9jvQevkKl2OM+E7aNaS16sg6YGFqCLBTf53lOtNSMp32aakjM7Cr8bsGLbuumDoZ8Z1AmdMpUfwxaHpejodO7y+HaYHGDBpBdIb8T8cARVYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYC0cjCO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33d962c0e9aso920725a91.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953206; x=1761558006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH/+6EWs5O6C4gBrSqboPsAfsrt+0avNoGpNPf0X1zc=;
        b=RYC0cjCOXkoKU/JgkO2g2RDERiSW6ZAvMJagsFWwZesmcfiTypv5D/BzrVx797HsdG
         bGFYdhvKyHJVvO9dgOSCCLWFqwCurM2z8mVC+f5mi06Ox/mhTx49/AJMes4F7i6ROT8+
         agRMvZtXnGGn4w4oXj2aLRNr/GYIgBjRdbkaU2ZZhyfRdWjVnEC338OlnAFQW8hDDZI1
         9hAHlFK2dGBoLwJE47iHW89mugfQls0tKFy7sJwVvYv5R8dZGSg12laoLNpxSkb03/RF
         5g8hY4UWTJYdhN0BCcubuiKRw1ANf4URl1O9nyOBxqq6EcIZO+ul76F/hfytzwOwXQJh
         M1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953206; x=1761558006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH/+6EWs5O6C4gBrSqboPsAfsrt+0avNoGpNPf0X1zc=;
        b=MPsnu33loemqOgCrwKzYdlKSSsukv9Kg6dRtuqRgusM74MHvCLqpqEyWKhypD6Lpm3
         6hW3+OylHGAZyPAxkd6u7+7TofEd37OZlWm7YZ/rnDX3ec+kU5WqYmCs8nIeGaz8zKl1
         g75XhnZljbf0x0AMxMOfzykWl+E9if/u+zKkQMMDLh+XrtiebBanqZwqSN4xuSRqG3Di
         wd0vuhqOHy9cnANn5OtzgMkRAzSlrHdLJfzcQRXTbrwHdkL+EYcwWsk5cEZO/nuh1qpw
         THSC8jnlZprFll4zAxRQHGG8C/2yy0leUZjsIZ1DFGRNt6NPfZfUsGDWPEINqJhSRBGu
         pzZw==
X-Forwarded-Encrypted: i=1; AJvYcCUGRBGCC2M/+jepD6g4HqxhPOvNt3mtw1n2GJ9CeUE2x6zwHZKUDyBY8Vzq7fhqFDd1vdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsqz/XCbIg2j9rGjXJAKyCZ669EdmFniKvHoG8RQIPkkyJLxd
	apVKhfnEH7Ig+8u4aES36GagO1Q5aftLBw46H+2F2qTLWSHosyRqrwtL
X-Gm-Gg: ASbGnctotEy1iDo2CvsBXzGLsjdLHKMDB6Xezdc/LbAaLj4J8bmOdinOKe8YNS3Oyek
	NbNuwOZYHVf8VQZdn1a9u8dtLcGO3az9/NqAzUQUrtXlkn7AUxM1AVeylfNPrd0gXeorkCeutoz
	DIVayqDdDV+SfUNjCJNTawcVrdHcr83wyXmoryv1XGcHL+nqmqwLU4egskHPTQD5VrzvxqO844z
	5bJvHd2bMILJaN1w8iBYq99YJA/tO+Wzr5mlCTAmIQDeb285UYGN7MIdt9w7tYh9cu45SRWUJ0k
	JAFocY127ogNeWMNomx3Vo9COBg9QgU5KSQ8dC31KaFSJE7KfkC38BeZF7GsTaJRTeFpxrqK7I3
	HTgnVEUUx4JRfBIsjjQaYQaf1VJobCsrN7ss84YpYAfrJ1fJK8V1SYMCSgufvX40rURpwhEILzV
	mcVaxdXKdkvqlwGnovS8TOkGedpbc=
X-Google-Smtp-Source: AGHT+IG2Wxz9mrCktw0rxT6tFvVvYsqONsh7h6jzym46SEzftpP3aJXfFuuE4RwM1VODUU/DgDWoJg==
X-Received: by 2002:a17:90b:2882:b0:33b:d8ad:b69c with SMTP id 98e67ed59e1d1-33bd8adc731mr14497209a91.3.1760953206522;
        Mon, 20 Oct 2025 02:40:06 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8091fsm7617200a91.19.2025.10.20.02.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:40:05 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v2 5/5] btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME
Date: Mon, 20 Oct 2025 17:39:41 +0800
Message-Id: <20251020093941.548058-6-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020093941.548058-1-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pahole v1.32 and later supports BTF sorting. Add a new configuration
option to control whether to enable this feature for vmlinux and
kernel modules.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/bpf/Kconfig   | 8 ++++++++
 scripts/Makefile.btf | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..08251a250f06 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -101,4 +101,12 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_SORT_BTF_BY_KIND_NAME
+	bool "Sort BTF types by kind and name"
+	depends on BPF_SYSCALL
+	help
+	  This option sorts BTF types in vmlinux and kernel modules by their
+	  kind and name, enabling binary search for btf_find_by_name_kind()
+	  and significantly improving its lookup performance.
+
 endmenu # "BPF subsystem"
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..3f1a0b3c3f3f 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -29,6 +29,11 @@ ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
 endif
 
+ifeq ($(call test-ge, $(pahole-ver), 132),y)
+pahole-flags-$(CONFIG_BPF_SORT_BTF_BY_KIND_NAME) 	+= --btf_features=sort
+module-pahole-flags-$(CONFIG_BPF_SORT_BTF_BY_KIND_NAME) += --btf_features=sort
+endif
+
 endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
-- 
2.34.1


