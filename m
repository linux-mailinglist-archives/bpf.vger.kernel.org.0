Return-Path: <bpf+bounces-57274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA60AA7A33
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6D43A5968
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0BC1F1522;
	Fri,  2 May 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9bFra7m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60A185B73
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213960; cv=none; b=C0bDo0PhdY7Bb40kkJQNyMJNoMPzNjOxQoY09K0GXihP8XS0rERLsDsB4EyHGo1EnDfJC0StFJXShUxgm2B5ZuZx95yvvpFA5hhrSRpS3JGH67uvfxE4TaH4Cfnvsk5wvCDi1He/BTKQIIYPMQ6EAXRkgkCVpPf2xylQa8vBQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213960; c=relaxed/simple;
	bh=17Bz4Yr0oR6iT1B0MkY+g4Tmq58uGwIfJVNTMVL2Qa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHlqQCXluzS7I2gC1qTsHje0KXtVi47uGXb44LXZWgJAptIKjZswfSN+XoyhiQnLV3NRxxCzSE7EXawUqqRK5vGwzFitlGSsHzSvJztYhxr0jVu9rWujvoSMhyPOMO03sYXVNt9lRUXm0LLH+3nHAc/Nz1XbD8/owmCT+CoYKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9bFra7m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ace94273f0dso518893366b.3
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746213956; x=1746818756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2E+gcjbMN2PyFmrACbuhCiuGXgFmKEb2T5uF5Km1ABQ=;
        b=m9bFra7mSb4PuNb/K79xWiLya2PX4gtsxmY9fkAKunXT75FeOqVmdwv31DNgijZ8bM
         dtbfCOmCnaoXVeJjz8WNRhaIh+Xl7FioFDRhYwiYxaMP7GtS7Gk4S4JY5BEBxQhgxEeN
         KioKUbiE6DsEbKH2MGB+RiEWSYZ6KjkG3tGOOGYLS0gYK4LumlJzj5v8JJEC1Dz10N9a
         UwQr/86/FJxgyz7JcFdHnNvVGhYhy5yPMCYXgo5H420/bAO19FUllfofJvVt5Oa0PCkW
         0hGNPOX7hCgJx8tbdnuk/AmNSoFd1Aaw31GOC/VgMais/8PBYEnVU+LBoi8ScgLHRJcD
         lENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746213956; x=1746818756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2E+gcjbMN2PyFmrACbuhCiuGXgFmKEb2T5uF5Km1ABQ=;
        b=eLdtaHnS2QVTFWVz4UWPo+JAIExOytSX2Zkp6Ja1RYqJ9P+81QJZG/igbHEK9VWeU4
         q4tO1VVp//Hiny+KazlYXUYe3tu5wjsBpEjGBbVv5mN6/XZeJZ3FlOtpaXFXVKIG7bkz
         hvb1xCmvvm86ZUh5MU2aFnBhKXae59jNdj0NMRzgBc+2WYt/jlxQ3QCs4qqwrF69wSHt
         9flDZp2HaDPeucz/P2h2cQF6RkOJ0YE65JqaupPjczCnTsPDriKS3CpAD6soHYlhd+uh
         Ia5XYtAL3HguPWdavzIjHjrztWZZuyqwGRSx/IT8dIumRhu+LDUfCjSbAXvUiCMCG0Mj
         1rmg==
X-Gm-Message-State: AOJu0YyakSJIAhycMQsYoAr493aYHzDslcI1HQveya23c1FtdM7I/iYi
	lNAqz2qKgTUQvzzkLiZxUbisND+hVBSwSSzX4fKZURUism3gSkGYPLcD5Q==
X-Gm-Gg: ASbGncvz1clxw7ICDmsGtq7Pdu9Q4KWNJ+SgicGv14hniS22JZJUcwpHC96iHLyXGyL
	UAAn08G30qkLj1kph41DRDEoEwXy82AM+S+1A8Ods287oJT0OfFnhDWPnCRpO1FiMKZQu6iqP+k
	iD6jhNKeEHBxN8LKvHZS1wUBM+GRWlHomtJZzOKzGi4ihUz5SgnPT1StxVnrz7V06P5rKA//VxP
	B2zvlM0BcoqXRhpATzF3ccP1o6k1jwUaSqD+1aWyy7NshJE5mW4s3nd01FHWllXatGaN6ZUzQj+
	8Di9AgVqZ5SWbF5sjFYRFxEWu9l5xRaUjT/NscTEoLz0mHP0INxNaafRXFWrmlqrFMB+Qks=
X-Google-Smtp-Source: AGHT+IG3bLGnURUUuRBT2o4XbScaAKZkcgsL7EMGMfwQhye74+hOlP0jJcwnVfI+DZuRQlgvlxxP+Q==
X-Received: by 2002:a17:907:3d4e:b0:ad1:7858:a775 with SMTP id a640c23a62f3a-ad17addc0e3mr376645166b.28.1746213956232;
        Fri, 02 May 2025 12:25:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894c3853sm89235966b.94.2025.05.02.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 12:25:55 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next] bpf: fix uninitialized values in BPF_{CORE,PROBE}_READ
Date: Fri,  2 May 2025 19:30:31 +0000
Message-Id: <20250502193031.3522715-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the latest LLVM bpf selftests build will fail with
the following error message:

    progs/profiler.inc.h:710:31: error: default initialization of an object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigned int') leaves the object uninitialized and is incompatible with C++ [-Werror,-Wdefault-const-init-unsafe]
      710 |         proc_exec_data->parent_uid = BPF_CORE_READ(parent_task, real_cred, uid.val);
          |                                      ^
    tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35: note: expanded from macro 'BPF_CORE_READ'
      520 |         ___type((src), a, ##__VA_ARGS__) __r;                               \
          |                                          ^

This happens because BPF_CORE_READ (and other macro) declare the
variable __r using the ___type macro which can inherit const modifier
from intermediate types.

Fix this by using __typeof_unqual__, when supported. (And when it
is not supported, the problem shouldn't appear, as older compilers
haven't complained.)

Fixes: 792001f4f7aa ("libbpf: Add user-space variants of BPF_CORE_READ() family of macros")
Fixes: a4b09a9ef945 ("libbpf: Add non-CO-RE variants of BPF_CORE_READ() macro family")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/bpf_core_read.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index c0e13cdf9660..b997c68bd945 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -388,7 +388,13 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
 #define ___arrow10(a, b, c, d, e, f, g, h, i, j) a->b->c->d->e->f->g->h->i->j
 #define ___arrow(...) ___apply(___arrow, ___narg(__VA_ARGS__))(__VA_ARGS__)
 
+#if defined(__clang__) && (__clang_major__ >= 19)
+#define ___type(...) __typeof_unqual__(___arrow(__VA_ARGS__))
+#elif defined(__GNUC__) && (__GNUC__ >= 14)
+#define ___type(...) __typeof_unqual__(___arrow(__VA_ARGS__))
+#else
 #define ___type(...) typeof(___arrow(__VA_ARGS__))
+#endif
 
 #define ___read(read_fn, dst, src_type, src, accessor)			    \
 	read_fn((void *)(dst), sizeof(*(dst)), &((src_type)(src))->accessor)
-- 
2.34.1


