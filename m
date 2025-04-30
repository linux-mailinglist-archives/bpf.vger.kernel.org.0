Return-Path: <bpf+bounces-57019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6250FAA3FD0
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFEA1884DCC
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F604A04;
	Wed, 30 Apr 2025 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHFOskvP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D01FC3
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974290; cv=none; b=fZ7SdjxgbSYCj0QKW7TMwpdNbX277GkKYaQtWrMKD0NVIF5tVD0bPbgq//xUSzpnEsbsB14FtHiP0loZdQAZLGMyZ5i8W5SrkVa0D8sySqC7uF5b9G/lAr7ySjZXDBptFhi6Ff6o1DyCGjaWmKW+yTp7RadrbQKKp2/tQTZdcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974290; c=relaxed/simple;
	bh=MmTUq9MzeXPJ0bP8Z7YT3atwyw/iUpUM4O8iHtzF+RI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WMg9TRurbglLeyN2ZoQcFxZY+YMHV4xKrzhxmDxvlV9JVBUy1IWp9EHzr06JOJiVK+loL+p2hy4aFkww79IimgH4Mqpxu8cyFrs9/PhThR/+SGPSMDyOXsTVJ4Tu3N/XDvKRu5YPqNktjbfDrfgMvB3TwJlx5Qxc0LoRI3+dUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHFOskvP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242f3fd213so55739155ad.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974288; x=1746579088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lW6OBXNllfj3ZgFG187xRr8MMSm7FGa21hGGlk/yqT0=;
        b=FHFOskvP/crJvRblerc2z8kjWEVYvOUQHHqvc564LxK7qi1qpqpMR2Ih1+D5IvLeXX
         fBBun2/8dDL6LyNJ1T43TPn+rzPcdBRwPdRl1QdH6Q1Y/R5EKwu7ku+qca0+kfyyYr6h
         LGA3oyTX01Cv/lEb3kS1bhGwDslm9o7QJyzHKuTFACWakUdn0kE6kzNGzJxA1NoAANA+
         MPtrc+nb7aEODohua5qbGS85MS+HmadPGZ3pmFgZ9du+/sYbihdz0nHGDM+i+0SgFvAm
         5iazf7bSLdvaeVRJkNGptXzbLb/TBcGMNG8LsON4HzdZiw4vjnIhFIpTfcau8hPmxTyC
         UM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974288; x=1746579088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lW6OBXNllfj3ZgFG187xRr8MMSm7FGa21hGGlk/yqT0=;
        b=Y3/RVrxHd5gdrfgQGjw228MwuV26MVWO0bLGrSAgUGrf7ZgBXeQiB+4WaSgQj8DmVO
         /XJyBHra4Bwv0xnJPKZkk0HtwQ38m31dz9d591oWSNKGrk2WAOQZ6LU/fVZNI58fplV7
         ZUxdh4riA/C6w1nsrSH3mZD6U9VKocbBsBpshlbw3N8gm4enF8XcttEOe7gk1u5zvdtM
         C9UIUWtEIFL1Cmzq2tbtUeQSZhmq3y1uWgqdFxxKXdkL1gA/57J03E/xbz9Qt/i136oI
         22tFXtf3GJZQd067rQ69dY/emcE1akijnwh5gczmbdVEGn8ZxnJoDm9Jj4pp3fd23B0w
         hHGg==
X-Gm-Message-State: AOJu0YxxXrR0NBEiGvB88Hn8wI1+TvPowtUlOvwBmwxrMb1apm89d2wF
	T3quby8fLig2h5VjBsIc20AoOZDCMzX81dOwjDRFeRIJu6Jjmezx6mKpLYZPHVCeuq2mQxt8DWC
	WHSeAXs4B2msoMadpPsH2OiQLem8L7YPM+iMhIQxNlCMte13PYzBqVRRO2EGykHGvbTzQSHRlfO
	rWkcFhF+SofqNIbfRO3d/mNfuOBpui0WZ/us/AFBs=
X-Google-Smtp-Source: AGHT+IFQAwpd1H++VldpouxlnX2ftKTRxKtEh+rGvToXlSu32ujpldy9pEubIFXh40BcFojVA7YUFEXUSDoFvA==
X-Received: from pfbbk10.prod.google.com ([2002:aa7:830a:0:b0:739:9e9:feea])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a89:b0:1f5:619a:8f73 with SMTP id adf61e73a8af0-20aa41839aemr904642637.26.1745974288270;
 Tue, 29 Apr 2025 17:51:28 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:51:21 +0000
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1745970908.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <9bab433f2b7e48519b26c1b8f2004635f6c179d2.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 7/8] selftests/bpf: Verify zero-extension behavior in
 load-acquire tests
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, 
	Andrea Parri <parri.andrea@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"

Verify that 8-, 16- and 32-bit load-acquires are zero-extending by using
immediate values with their highest bit set.  Do the same for the 64-bit
variant to keep the style consistent.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 tools/testing/selftests/bpf/progs/verifier_load_acquire.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
index a696ab84bfd6..74f4f19c10b8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -15,7 +15,7 @@ __naked void load_acquire_8(void)
 {
 	asm volatile (
 	"r0 = 0;"
-	"w1 = 0x12;"
+	"w1 = 0xfe;"
 	"*(u8 *)(r10 - 1) = w1;"
 	".8byte %[load_acquire_insn];" // w2 = load_acquire((u8 *)(r10 - 1));
 	"if r2 == r1 goto 1f;"
@@ -35,7 +35,7 @@ __naked void load_acquire_16(void)
 {
 	asm volatile (
 	"r0 = 0;"
-	"w1 = 0x1234;"
+	"w1 = 0xfedc;"
 	"*(u16 *)(r10 - 2) = w1;"
 	".8byte %[load_acquire_insn];" // w2 = load_acquire((u16 *)(r10 - 2));
 	"if r2 == r1 goto 1f;"
@@ -55,7 +55,7 @@ __naked void load_acquire_32(void)
 {
 	asm volatile (
 	"r0 = 0;"
-	"w1 = 0x12345678;"
+	"w1 = 0xfedcba09;"
 	"*(u32 *)(r10 - 4) = w1;"
 	".8byte %[load_acquire_insn];" // w2 = load_acquire((u32 *)(r10 - 4));
 	"if r2 == r1 goto 1f;"
@@ -75,7 +75,7 @@ __naked void load_acquire_64(void)
 {
 	asm volatile (
 	"r0 = 0;"
-	"r1 = 0x1234567890abcdef ll;"
+	"r1 = 0xfedcba0987654321 ll;"
 	"*(u64 *)(r10 - 8) = r1;"
 	".8byte %[load_acquire_insn];" // r2 = load_acquire((u64 *)(r10 - 8));
 	"if r2 == r1 goto 1f;"
-- 
2.49.0.901.g37484f566f-goog


