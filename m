Return-Path: <bpf+bounces-31288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E48FA9F2
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 07:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CF41C2191D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 05:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6D513DBA4;
	Tue,  4 Jun 2024 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcYbQrLm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21B13BC0C;
	Tue,  4 Jun 2024 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478611; cv=none; b=P4msZggWht3z5g9H5YZYL5Xnb72LEs30VFnSdPJCaa4fwqhMWV5ZdAfCzpDP8MFT5Eq/dOHLH8KFEOXx/dAWTn78cdTJV8JuFfv8qv5PWi4FvychGyyNQ0cm9rEAWAeDmpqWBNxBemPeWyHLETyro4qCeBY115R3uC1SE7SQYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478611; c=relaxed/simple;
	bh=Py+3C2S2vlJjfwsX1788LiTLhhBSCD+Qb9I0xkOHaSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgZ94AF6q0uhZzuetj1TfFvE2ixN7ijgY2duadycFxraQuzHCaG6zYH9QRjXGghu2NACzl39UgD9RqagHt7FWipgxRTdL4RmMFk+h3dC3un+Aylbf98qtreZyLHzacDar5ucGFNoexHmGUVyNXYVoclQ8pTl/F9xldydhnwYNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcYbQrLm; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f8ea563a46so394900a34.2;
        Mon, 03 Jun 2024 22:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717478609; x=1718083409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naMt4t31CZge9Me/OZP2bEkQXQbrT9vZr0UBm1SPKCo=;
        b=EcYbQrLm6AEXCJvyxR6td3aTAvri+zehzZGLqYOU3tJw/8IQefcd4gnTTqRFSJnFbO
         yaewvjUOkhu+SfOw2I5db/n8SZIlI9dgcsq/6AwGyfmSMPE+vhHFPoSoMqKLQqGvlJpR
         iUEmUhQYYgzEd2YJFU+mBHFdR8t3tqoMRVge5XlfStYR21BejdLCOTQmq00GGfpkNRHA
         /AXGxP45qCDyn2IXBsxZb0pzXC6BjJkOdkjAxkirvPbLf+H49ZFw5bePVzvxs5f1Qt1g
         Dp7W4Xm4MmWkFMKhzdYlDFlpcP4UH62JYqcUwuc3k012kOeEdZkibxjohqyqmLK5c4d2
         0+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717478609; x=1718083409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naMt4t31CZge9Me/OZP2bEkQXQbrT9vZr0UBm1SPKCo=;
        b=VL7TwLcdOH1bx5c7CETVsP4WhgPy/Bhc3ftp+LpN0hC3dDmB/ZInc57lAfaYIlU9vJ
         y8Pc7EdYgZCDk1DTLVghyEGgnZUDuRRyoHbC4sqDuTG+CDnKvcmyqhC8Q2oDHLa3h5PL
         PeZd5NEpI6FWdRq0iB4N5lAtUtPdOztdetAer8QZSr3bnMOk/v33TKtt0Z7WQr0aE4Aa
         bhVBpLaCiuRB83nCIEXvW90fq+nZrFt+rzNG3YB754mrzmw8GM5WnQJ8qRXU/vi4RGdt
         NSZBP4Xtf+W0Gfs72LrSnSRB+FmtFQ/KNl0DPrHRuunel29GS0dDgRj+Vrzrw/REbz0Q
         Ddfg==
X-Forwarded-Encrypted: i=1; AJvYcCXofHOAlhcQFGnRQuCzdFKyaqI6GlDNzNihV21INEs4uCcbp3Ydje0OyWEWYh/3PvT8uIXZuQvSpbFkKyAWCv9J9KBaliy7
X-Gm-Message-State: AOJu0Ywu19duqHKA6AB1oeQlotho/2MwJ0OE/traGdE5mYWGryfKbGqg
	d5FPspLJXTjtRn5exrmaCyW+hQ6SXwnKP1Dx4f2xxRDOjR8puutqSkfCV/02
X-Google-Smtp-Source: AGHT+IHOKaSr8ixcDY7+kgSk+umOf4K+1ALXvAmEKMOa3nat11B9JSF4anMXUTwvg/I0lGq3L5+48A==
X-Received: by 2002:a05:6830:1510:b0:6f1:23de:2f11 with SMTP id 46e09a7af769-6f911f26957mr12689889a34.8.1717478608592;
        Mon, 03 Jun 2024 22:23:28 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35937a496sm5303785a12.73.2024.06.03.22.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:23:28 -0700 (PDT)
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
Subject: [PATCH bpf v2 1/2] compiler_types.h: Define __retain for __attribute__((__retain__))
Date: Mon,  3 Jun 2024 22:23:15 -0700
Message-Id: <b31bca5a5e6765a0f32cc8c19b1d9cdbfaa822b5.1717477560.git.Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717477560.git.Tony.Ambardar@gmail.com>
References: <cover.1717413886.git.Tony.Ambardar@gmail.com> <cover.1717477560.git.Tony.Ambardar@gmail.com>
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
 include/linux/compiler_types.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 93600de3800b..f14c275950b5 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -143,6 +143,29 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __preserve_most
 #endif
 
+/*
+ * Annotating a function/variable with __retain tells the compiler to place
+ * the object in its own section and set the flag SHF_GNU_RETAIN. This flag
+ * instructs the linker to retain the object during garbage-cleanup or LTO
+ * phases.
+ *
+ * Note that the __used macro is also used to prevent functions or data
+ * being optimized out, but operates at the compiler/IR-level and may still
+ * allow unintended removal of objects during linking.
+ *
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
 /* Compiler specific macros. */
 #ifdef __clang__
 #include <linux/compiler-clang.h>
-- 
2.34.1


