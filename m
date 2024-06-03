Return-Path: <bpf+bounces-31192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B945C8D8205
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 14:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90F71C2380E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF812AAD3;
	Mon,  3 Jun 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnTuWlvj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8512A142;
	Mon,  3 Jun 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417015; cv=none; b=GBvEget0004PwQuWKThbsus7xpMxOghfy9h39dFR55VPXghrsL+KFOO/7kvU2n0JzLSYlat7xtCLYuR31wFau2kzMT1yJcwemuy8kruR0TSKpeSbfwI3iQq3KUeV1kWO0LelZU6fS9h4OWJMOBj5hjrbMYERKVW3uZeC/WZTjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417015; c=relaxed/simple;
	bh=wJbBb7m2T+NjpvyKs6LFLzrHy6bKzV3H5a5pbGj4oT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Le0aDiXrjdSQ8mhxpt9r7ed3RMYE5CE684bfsDAHD6n7ASM0ZNgkUoQ/U2L1QytdK4W/nmi+QQ7ogM6AfSsyepDtOPsXG5E8OOQYdQ6kzfguU19eC1z9/5ejeYNtA3GcYCgmvn5jh8OMxfL+sdqa6n2smlDmFR2NVm0ctg69R6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnTuWlvj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c217727902so941638a91.1;
        Mon, 03 Jun 2024 05:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717417012; x=1718021812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sd34brJz2LmRufAc75kDVDkXK/x+3FfZcQK4xNLOc4=;
        b=GnTuWlvjy4mu0rBtLd0xqQsBBfvo1oDUHg1g/1yORnccAeD4l3eESN8jN2o3f0ZqtJ
         g40mIG4jJs9Sr3Ie14dYboZdUGQROMkVrP2Tk+OYynF71Vf/JRbx17aR8xM4M4G2Sqf+
         OM7vOet2/j6aEZHLGxeVk5bfBnGO//vWyuxz9Ovg48e5vv61uga9hFxfkskr/vC24U9J
         ryVvSbH4PLasiDRJwyVHmJ0T/aZ9b7OXVpvgBETn3b0DNRB3nmDenTG0hOJLTWOEm4qj
         KO42HOiLi7Tqsi8FoDANvhR1B2MeXBe9TGd6wfMzY0CgK7JNF7reI6dVcmXneum2ke/v
         3B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717417012; x=1718021812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sd34brJz2LmRufAc75kDVDkXK/x+3FfZcQK4xNLOc4=;
        b=TKy66D/IJyKLel4sERRkxypvqh+6h/ZYLhPZHXXIj+i6RC6PdHpWFAZCJlI5d2KAm+
         SbBjOD3wauoVXaK+GvfWQ+Hua+NTUsOvKGaADrHbYQT4RZrzjRWuoN5QVHZVBS3GAQnI
         CcDxkMiV4V1YKim5YgiOmYN4n719FVOl4RzWzIRnw7cZJXwm5N+EE8VHnIk13cAAUzvn
         LsDZjXI8W5vyNezDK8jepgDaFENw137/cHwB8gA7tE0uWgBZkeNEuRFpiD7XbfHDnQ4C
         VXra2oCCIZC/xjA50IKjqLwwaclYOjxgUn8XPuyAChjY/xywCkWoFOE/0YBmrFWzoxd7
         lppw==
X-Forwarded-Encrypted: i=1; AJvYcCWbbdYlSWzVo4pc4DS0CdfQVbD20S9ojqRHH/4KWpKxphU72klmVlNf++IACG0bRkVZpF3nRHVzrwEvyOXoqAButDIrgabi
X-Gm-Message-State: AOJu0YxyP1lvfRGmattJFazkhM3Yqfh5x02+7JfDHN4g7JbCXS6GjIs6
	7RWq3TdndZw+QwuDGeGEqYpptLw3YHpbHFR3ruGhMoq8ub0ao3GQ7Dcf6xVy
X-Google-Smtp-Source: AGHT+IF//EGWHWC6xMZwK91WkBMRsUgBKoKacOYgQicIaXDtWA8tC4Qs4mDWyx31kB7jjkPHRtgeiQ==
X-Received: by 2002:a17:90a:d707:b0:2ae:78cd:59fe with SMTP id 98e67ed59e1d1-2c1dc5c867emr7789964a91.31.1717417012437;
        Mon, 03 Jun 2024 05:16:52 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776f526sm8340820a91.13.2024.06.03.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:16:52 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH bpf v1 1/2] Compiler Attributes: Add __retain macro
Date: Mon,  3 Jun 2024 05:16:43 -0700
Message-Id: <5416a38a194bb97930f5a2e672165e573b82857b.1717413886.git.Tony.Ambardar@gmail.com>
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

Some code includes the __used macro to prevent functions and data from
being optimized out. This macro implements __attribute__((__used__)), which
operates at the compiler and IR-level, and so still allows a linker to
remove objects intended to be kept.

Compilers supporting __attribute__((__retain__)) can address this gap by
setting the flag SHF_GNU_RETAIN on the section of a function/variable,
indicating to the linker the object should be retained. This attribute is
available since gcc 11, clang 13, and binutils 2.36.

Provide a __retain macro implementing __attribute__((__retain__)), whose
first user will be the '__bpf_kfunc' tag.

Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
---
 include/linux/compiler_attributes.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 32284cd26d52..1c22e1a734dc 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -326,6 +326,20 @@
  */
 #define __pure                          __attribute__((__pure__))
 
+/*
+ * Optional: only supported since gcc >= 11, clang >= 13
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-retain-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#retain
+ */
+#if __has_attribute(__retain__) && \
+	(defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
+	 defined(CONFIG_LTO_CLANG))
+# define __retain			__attribute__((__retain__))
+#else
+# define __retain
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
-- 
2.34.1


