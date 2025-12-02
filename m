Return-Path: <bpf+bounces-75924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBCC9CBD6
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 20:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50863A8895
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5042D3233;
	Tue,  2 Dec 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVGhO4Sp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5331F09B3
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703072; cv=none; b=cH0fFYO/Vqf2i1RDETkfOyHxIEPPRTATLHrFyppvE3coJY5koXM5W7SmERK1YHRbIPQtBWNp3ugYb067A1Po5M80ZsldFl4IB5l0U9Vt+YDktopN5E0yCMHEuepuegJH0P+DoaRMnZvTQPGXmZFKVWE9n1O98an6M1yiqfB+7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703072; c=relaxed/simple;
	bh=EgZ9dt575hcxl1cNoQ8OZxCB3dq4zZKDMqiAXXl6kiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8UFDvddLQ/Z+wDXcy79m0sW5wsWTMLtPGFIgBhhzJRQBM/cjN++ZgsJCphYpjUo9+owWrTxj/s3PXICPw6zrFIG47+oakkyouN/wZvWSnFX3UgCrKfEy2YTOoSmTRkIRjdO6q2iS5tN7sNuQudZYsF19Y7RD2eaXfIRpuojbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVGhO4Sp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b73875aa527so930288166b.3
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764703069; x=1765307869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g40IQyEaVFmRs3mcXUy5GhEu9UYoViT0ZsoonoDWbuE=;
        b=DVGhO4SpEYTe8jLiTWf6tFnVQFAJS3x6gQHmOy4FnJQ2+b2IdvUnkS0ZMAgmldfcQf
         RYsKYSzjXGYJm+KL3XwnPX1NtRhATq0G4QRp4gPUnLLZKczuxZnZkEJe/nH4iV/GW8s3
         XHFlq7kputJS1d8BjIbpP6GP5YR6xZBB1p6Tnlcp+b2zjmLnYs9rrF18jL5IWGtf0TRj
         Oml0DCE4AJcNl2NXQEuG+s/2tmWkOPM7faVr4T+PabK58cAxsbjdRTwmcvqBi7DEOd4w
         ZHit3n1RvrZQLLk73u1EaVDDw+MA37wo4BlWWvbL/0f4qf80aInqro3SH7K0zdv4FLHX
         KqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764703069; x=1765307869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g40IQyEaVFmRs3mcXUy5GhEu9UYoViT0ZsoonoDWbuE=;
        b=UIoUyICfmk9+G2a5W03JFMVqrXJyVMilymFIL3cTdTeaDuGGBAuHa/E8wYDi0M6OeL
         YDPAKaCxClq4xSCGrWLZYZ0vK7wyTnFhZ7MEhCNizLayhS0GY5rp/ob03zAcqSrh0BQ/
         AUYuQghgf/Y+aBPDtBciwHlJyUc5QMl2BTV4ycZU5g/mxvA7hjRRsNdIPZo0YBrpEVkn
         1gi3mK+hQxAHyh52y3qV5sl3shv46bbvZnLWWQmwW90qkKsuAwSa7kY+8bJytwOtm4FJ
         BPbzbHJeB6DsDrkRUa2ChFuGcHJDPcIOCwt3j7otUqcxvDVrVVKswLth8I8TeGAbZpi+
         CgUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKETyXcKXm3U/hhzuifenk2KIGfDzeG3uGA4ucX1TU7sE8/6sdyXsEOtwYndEj5g8XHhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrN4cqHe7vrH0XHSSsijVaKrxqZwbthDfmkZOhS1H2bos0H68
	Mf292eLR9PcM8ujwexHp8KM6IgzdZKnsKHTEGm849iXZrv0RP9M+305j8aWi+o6Exw==
X-Gm-Gg: ASbGncuZzs8Qb9ZubmhDIXCH4Tpo+NCkH/XXOC8D1GkIc88OhyKBOklBtjPIPcpB/5t
	HMQ8033ZAfexXu2zVQtcQKwrIFIjMWA+fViMgYxs8LUBnTAzl1VJ3ARikmtclkyxLWICZMRt4zI
	tMPv/gPnhXY8pNQuDNW16XOzMgPn2oC4NFjKlTPIyH+Er5+ajpeceUJfF9ZviQS9LMWHoEGpWdi
	g7Q9fkx95tdPu/gbFRTWNedK534v+0QMgt5hi5+1ZzhLvZ/jlkRW0WB0zKOkZx+YYQS1/QW6qkk
	OAU9kMxqv/kACJKS5ErJ8aj4VOIAnYfb8TXTIr6oos6hmYCVN5i4S9hPOhr/mxqZZnJwk3mYTcm
	h7XqlUOwUIHeoCN2Ty4rJ3b7UbB6R17oYwaVu1RCADRIMktHeUJ4B1zHfwAZc+km1w/Jz/hAdIt
	ILsSS848ldcW8OIox6CzcPQnhPjfnvVdvWYjocP1+d+asOVlRDdkINM19v
X-Google-Smtp-Source: AGHT+IGrBSIkWfemTsmCaVkA29L9EzBQK8A752QDxHd8yAcZkhFhtJDGjJNP6/YAWKiBFx8D5Bqhvw==
X-Received: by 2002:a17:907:7205:b0:b73:54b6:f892 with SMTP id a640c23a62f3a-b767154a4efmr5211749766b.4.1764703068869;
        Tue, 02 Dec 2025 11:17:48 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a1d750sm1549151466b.56.2025.12.02.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:17:47 -0800 (PST)
Date: Tue, 2 Dec 2025 19:17:43 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn,
	KP Singh <kpsingh@kernel.org>
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
Message-ID: <aS87V-zpo-ZHZzu0@google.com>
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
 <aS7BvzTJ-2Xo7ncq@google.com>
 <aS79vYLul06oLPT2@google.com>
 <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>

On Tue, Dec 02, 2025 at 09:27:17AM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 2, 2025 at 6:55 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Tue, Dec 02, 2025 at 10:38:55AM +0000, Matt Bobrowski wrote:
> > > On Tue, Dec 02, 2025 at 03:09:42PM +0800, 梅开彦 wrote:
> > > > Our fuzzer tool discovered a NULL pointer dereference vulnerability in the BPF subsystem. The vulnerability is triggered when a BPF LSM program, attached to the `bpf_lsm_mmap_file`, receives a NULL pointer for the `struct file *` argument during an anonymous memory mapping operation but attempts to dereference it without a NULL check.
> > > >
> > > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> > > >
> > > > ## Root Cause
> > > >
> > > > The crash is caused by a NULL pointer dereference within an eBPF program attached to the `bpf_lsm_mmap_file` LSM hook. The trigger occurs when a user calls the `mmap` syscall with the `MAP_ANONYMOUS` flag. This action creates a file-less memory mapping, causing the kernel to invoke the `security_mmap_file` hook with a NULL `struct file *` argument. If the attached BPF program assumes this pointer is always valid and attempts to dereference it without a NULL check, it immediately causes a page fault, leading to a kernel panic.
> > >
> > > Thanks for the report. Can confirm, and a more simplified reproducer
> > > can be found below:
> > >
> > > BPF:
> > > ```
> > > SEC("lsm.s/mmap_file")
> > > int BPF_PROG(mmap_file, struct file *file)
> > > {
> > >         bpf_printk("i_ino=%llu", file->f_inode->i_ino);
> > >         return 0;
> > > }
> > > ```
> > >
> > > Stimulus:
> > > ```
> > > #include <stdio.h>
> > > #include <string.h>
> > > #include <sys/mman.h>
> > >
> > > int main(int argc, char** argv) {
> > >   void* p;
> > >
> > >   p = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
> > >            MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >   if (p == MAP_FAILED) {
> > >     perror("mmap");
> > >     return 1;
> > >   }
> > >
> > >   memset(p, 0, 4096);
> > >   munmap(p, 4096);
> > >   return 0;
> > > }
> > > ```
> > >
> > > My initial thought here is that bpf_lsm_is_trusted() is treating
> > > pointer arguments provided to security_mmap_file() simply as
> > > PTR_TRUSTED, when in reality it should be something like PTR_TRUSTED |
> > > PTR_MAYBE_NULL instead. Anyway, I can take a look and send through an
> > > appropriate fix.
> >
> > So, thinking about this a little I think we have a couple options when
> > it comes to addressing this. We can either:
> >
> > a) Add bpf_lsm_mmap_file() to the untrusted_lsm_hooks set. This will
> > effectively mark the struct file pointer argument passed into
> > bpf_lsm_mmap_file() as being untrusted (i.e. the register will not
> > carry a PTR_TRUSTED type). The caveat with this approach however is
> > that it'll have negative effects (i.e. cannot be supplied to BPF
> > kfuncs that accept KF_TRUSTED_ARGS arguments) on those struct file
> > pointer arguments that are considered to be valid and trusted.
> >
> > b) Update the generic LSM_HOOK() declaration for mmap_file
> > (security_mmap_file()) within lsm_hook_defs.h such that the struct
> > file pointer argument name contains a "__nullable" suffix. This will
> > allow btf_ctx_access() to apply the PTR_MAYBE_NULL type onto the
> > backing register holding a reference to the struct file pointer,
> > ultimately forcing the BPF program to perform a NULL check before
> > attempting to dereference it. The caveat with this approach is that
> > BPF program verification, and ultimately its runtime safety
> > guarantees, would be tied in with generic LSM infrastructure which I
> > don't think is a good idea. Subtle breakage could occur literally at
> > any point.
> >
> > c) Provide an override declaration/definition for bpf_lsm_mmap_file()
> > within include/linux/bpf_lsm.h and kernel/bpf/bpf_lsm.c such that the
> > struct file pointer argument is named file__nullable instead. Similar
> 
> I don't yet see how you can accomplish this, but it's indeed the best
> option.
> There is already:
> FUNC 'bpf_lsm_mmap_file' type_id=...
> Magic hack to
> #define LSM_HOOK(RET, DEFAULT, NAME, ...)       \
> noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
> ?

Hm, I too was questioning whether this was initially even possible,
but I managed to get it working by doing the following (perhaps this
is also what you had meant when you mentioned using the distinct
suffix below):

```
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c3..ddb328ba856d 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -14,11 +14,18 @@

 #ifdef CONFIG_BPF_LSM

+int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
+                     unsigned long prot, unsigned long flags);
+
+#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
        RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK

+#undef bpf_lsm_mmap_file
+
 struct bpf_storage_blob {
        struct bpf_local_storage __rcu *storage;
 };
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 7cb6e8d4282c..48259738e032 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -20,6 +20,14 @@
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
  */
+noinline int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
+                             unsigned long prot, unsigned long flags)
+{
+       return 0;
+}
+
+#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
 noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
 {                                              \
@@ -29,6 +37,8 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)      \
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK

+#undef bpf_lsm_mmap_file
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
```

> or a flavor named with a distinct suffix ?
> bpf_lsm_mmap_file___suffix(struct file *file__nullable, ...) ?
> 
> To address the same issue with tracepoints we went with
> raw_tp_null_args[].
> It's ugly, but gets the job done. We can probably apply it
> to lsm args too.

Unfortunately, I'm not overly familiar with the whole
raw_tp_null_args[] thing, so I don't really know how this works. I'll
need to take a look.

> tbh option (b) could have been a choice or even:
> -int security_mmap_file(struct file *file, unsigned long prot,
> +int security_mmap_file(struct file *file__nullable, unsigned long prot,
> 
> but it's an operational headache due to different subsystems/maintainers.

Agree, hence why I think we should just add the necessary workaround
directly within the BPF LSM.

> Long term the plan is to wait for gcc/pahole to fully support
> btf_decl_tags and switch to that.

Yes, I literally hit send on my previous email only for this exact
option to also pop into my head. But as I read more into it on my
commute home, I gathered that there was some inherent dependency on
the BPF toolchain which probably isn't ideal at this point either.

Another alternative that has literally just come to mind is the
possibility of introducing another BTF set (i.e. nullable_args). A
function (LSM hook) associated with this new BTF set will basically
force the BPF verifier to strictly treat all of its associated pointer
type arguments as nullable. Therefore, resulting in the PTR_MAYBE_NULL
type being applied to any register that may be referencing one of
these function pointer type arguments. This kind of check against this
new BTF set could be performed alongside the btf_param_match_suffix()
check within btf_ctx_access(). What do you think?

