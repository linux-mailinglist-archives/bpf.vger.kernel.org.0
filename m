Return-Path: <bpf+bounces-75956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66119C9E4D0
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 09:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60F254E0EB8
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 08:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791962D63FF;
	Wed,  3 Dec 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3BYEGUQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A81EF0B9
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751668; cv=none; b=eUyJzceLo5H++PMMTPSt3BpKJAjyc4OYvkcgSnNhX26SNAIokuehPTZi69MOgnrnXfa6ZQ7pNGoWa6MTgsu95m8s9ee6vHCHG14voBnWBo2lOuwHoXWrnWfnkU2Ll95iwMGyPs06L2Zw411UjciWKssI4mrHaNbkopJtu8WHkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751668; c=relaxed/simple;
	bh=dO++dsVY7uZ9+/KFEuH3yGhNKzMJ0fkqgH3MUwe53u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLFAlFjLoKeVdx+HOaockB6DvFVk42GRnI2q6VCUtRQeFux1peZk/eBdXA7Hceur8CaoJw6p0zw10BAqwlbFs2SxU1Oly+EcERwLSOjEDulNgzlykfv1FAN3XCNvRVtJIFJrS2HhPhLFNtd6CGyzFI52QRlIFxaqpzhukYgZKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3BYEGUQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b725ead5800so860969366b.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 00:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764751664; x=1765356464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=739pamOVsmIRmmGtT8AWs1QWzQP6qTF1FifK0MQODck=;
        b=k3BYEGUQQpkAo/MsGit0GXGYVK/6HmXgr4S5JUqAZ9aGHcPKI1XuQ/l++HPpfmQNZn
         krm0gBwwVa1qgSxzXFrQW74uuoAKB4+KDOMgUkXd54nGs+0yo/9ahoJbWwcra5XsvsQe
         YKWaOjUnn6BlyUMYFJbK28OkoykMwHrGWef7+UXCIxerPUZbd6w8JieCZGm8LRWEE91+
         mg6gOvu1NPq68jGgryzg7rRIh+O5sDrTbkcbV272bpNPbbCHVsEfKySnFw9aePLx6Pzp
         vjiGRhIBdQ1A0vXWqe15589Z7Tg0jS1Q/nE0C4mEmmrV0XiAM2KPEjs7+A3LfAhffOnJ
         pIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764751664; x=1765356464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=739pamOVsmIRmmGtT8AWs1QWzQP6qTF1FifK0MQODck=;
        b=ZkN55hn3MFrTtnxiQwN292j3YDb+whJY+khZVJo+STS+440oF8JK47JE7r6fLaj1kv
         U28TKK3GiS0y115B5oRoQm1LDZrO9oLONMfwHmW6pG8yQgIg3sjPbXxI6qz8hgq9MaMq
         G6GuzZBvXFka7UvfmSqiRGIXbN9t9k3gJ6BzfhVZNlWhDme9rU3yKigMTkzMJfhibcuZ
         UB/oGxGsunm7z04pLsM3iHz3Z5uCESUq49+4xgYE/GTb5gxphubTojVawBa0lR/kE8qD
         t2yeq0hJ82iQb51BSURhWxZuQ6OmD7g9kDdscKX7Vr9ubscQy7/k6+KtlmaE5qXpNZ04
         nGhg==
X-Forwarded-Encrypted: i=1; AJvYcCVRy6Rv36PQTUCdOelvwjpmd7ozpDe5ezdMIdNx/AukjOCRmmtoA/evEhjMElabEIEh64k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHYlgOEVrgMzp4UUIuq4VoM6G4D4kKYy2BaduDuKwkQmQRCIB
	cmKJHXySwAoae0ypeDP4nVO58FmSGVYRShHYCViBaQxM3FOS9IftTb12+RPdORaO7VNcatR7Iyc
	EletjnA==
X-Gm-Gg: ASbGnctcvS2UeCM9K5DWDvP84sb0TR3FQsBRMdnO2P+TXwqVs8eWw1gmbbDi/XScwLg
	GWeninnYvNph1m3NQ37hUOrtlXJ/m69YwcKPiUPeyt7r9OrpnPXOiTXeDu9dD/cdJ5YNJnweKgt
	b3/9owdoommV1vm1W9ivEPDHAFIC1MK7U+rR0YeG0svnEG1ZNl3F3FRenVLTe1FU837Zdy29DOH
	n0ubf31mDdIs8kqa8aNzY4g6Ty7l2RjwpXXUn0oR1vrqH6KilRybKLARAfJnaVIaEle3EjzWphO
	MkgDXuu31NMBx3VmTcB46gdxq+2+/IO8BBqY84tXR17wW78tFP/Vxq5KXmg+PA/hqcVxXgaXrNu
	f6AO0s4/xOUb1uHVnm25AZhBuJI+ikweHrfS6X9u6V2UWAjopq1MCNoFkKYe8MCkegObRaWwnnQ
	YAs9w47z3gHyEZq2lfj5AAn9gn0gKPivhtGZOmAAIMDH5tKfDSIv89OiJp
X-Google-Smtp-Source: AGHT+IHL3LBo5rr/mnSz/9OhNuKC8+j19bCWiJLGI+xiwzgZZh/N5YPYonbbEu6cVGsofjgS6j3RLQ==
X-Received: by 2002:a17:907:3e04:b0:b73:78f3:15c1 with SMTP id a640c23a62f3a-b79dc78918fmr145737466b.52.1764751663845;
        Wed, 03 Dec 2025 00:47:43 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c68d0sm1763417566b.28.2025.12.03.00.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 00:47:43 -0800 (PST)
Date: Wed, 3 Dec 2025 08:47:39 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn,
	KP Singh <kpsingh@kernel.org>
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
Message-ID: <aS_5K_CJcB1rIEVj@google.com>
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
 <aS7BvzTJ-2Xo7ncq@google.com>
 <aS79vYLul06oLPT2@google.com>
 <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>
 <aS87V-zpo-ZHZzu0@google.com>
 <CAADnVQ+UDCh5JKjUpX63xcaV3CEcj18W2C+8TZ4QFYKGV6GZKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+UDCh5JKjUpX63xcaV3CEcj18W2C+8TZ4QFYKGV6GZKw@mail.gmail.com>

On Tue, Dec 02, 2025 at 01:40:04PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 2, 2025 at 11:17 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Tue, Dec 02, 2025 at 09:27:17AM -0800, Alexei Starovoitov wrote:
> > > On Tue, Dec 2, 2025 at 6:55 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > >
> > > > On Tue, Dec 02, 2025 at 10:38:55AM +0000, Matt Bobrowski wrote:
> > > > > On Tue, Dec 02, 2025 at 03:09:42PM +0800, 梅开彦 wrote:
> > > > > > Our fuzzer tool discovered a NULL pointer dereference vulnerability in the BPF subsystem. The vulnerability is triggered when a BPF LSM program, attached to the `bpf_lsm_mmap_file`, receives a NULL pointer for the `struct file *` argument during an anonymous memory mapping operation but attempts to dereference it without a NULL check.
> > > > > >
> > > > > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > > > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > > > > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> > > > > >
> > > > > > ## Root Cause
> > > > > >
> > > > > > The crash is caused by a NULL pointer dereference within an eBPF program attached to the `bpf_lsm_mmap_file` LSM hook. The trigger occurs when a user calls the `mmap` syscall with the `MAP_ANONYMOUS` flag. This action creates a file-less memory mapping, causing the kernel to invoke the `security_mmap_file` hook with a NULL `struct file *` argument. If the attached BPF program assumes this pointer is always valid and attempts to dereference it without a NULL check, it immediately causes a page fault, leading to a kernel panic.
> > > > >
> > > > > Thanks for the report. Can confirm, and a more simplified reproducer
> > > > > can be found below:
> > > > >
> > > > > BPF:
> > > > > ```
> > > > > SEC("lsm.s/mmap_file")
> > > > > int BPF_PROG(mmap_file, struct file *file)
> > > > > {
> > > > >         bpf_printk("i_ino=%llu", file->f_inode->i_ino);
> > > > >         return 0;
> > > > > }
> > > > > ```
> > > > >
> > > > > Stimulus:
> > > > > ```
> > > > > #include <stdio.h>
> > > > > #include <string.h>
> > > > > #include <sys/mman.h>
> > > > >
> > > > > int main(int argc, char** argv) {
> > > > >   void* p;
> > > > >
> > > > >   p = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
> > > > >            MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > > > >   if (p == MAP_FAILED) {
> > > > >     perror("mmap");
> > > > >     return 1;
> > > > >   }
> > > > >
> > > > >   memset(p, 0, 4096);
> > > > >   munmap(p, 4096);
> > > > >   return 0;
> > > > > }
> > > > > ```
> > > > >
> > > > > My initial thought here is that bpf_lsm_is_trusted() is treating
> > > > > pointer arguments provided to security_mmap_file() simply as
> > > > > PTR_TRUSTED, when in reality it should be something like PTR_TRUSTED |
> > > > > PTR_MAYBE_NULL instead. Anyway, I can take a look and send through an
> > > > > appropriate fix.
> > > >
> > > > So, thinking about this a little I think we have a couple options when
> > > > it comes to addressing this. We can either:
> > > >
> > > > a) Add bpf_lsm_mmap_file() to the untrusted_lsm_hooks set. This will
> > > > effectively mark the struct file pointer argument passed into
> > > > bpf_lsm_mmap_file() as being untrusted (i.e. the register will not
> > > > carry a PTR_TRUSTED type). The caveat with this approach however is
> > > > that it'll have negative effects (i.e. cannot be supplied to BPF
> > > > kfuncs that accept KF_TRUSTED_ARGS arguments) on those struct file
> > > > pointer arguments that are considered to be valid and trusted.
> > > >
> > > > b) Update the generic LSM_HOOK() declaration for mmap_file
> > > > (security_mmap_file()) within lsm_hook_defs.h such that the struct
> > > > file pointer argument name contains a "__nullable" suffix. This will
> > > > allow btf_ctx_access() to apply the PTR_MAYBE_NULL type onto the
> > > > backing register holding a reference to the struct file pointer,
> > > > ultimately forcing the BPF program to perform a NULL check before
> > > > attempting to dereference it. The caveat with this approach is that
> > > > BPF program verification, and ultimately its runtime safety
> > > > guarantees, would be tied in with generic LSM infrastructure which I
> > > > don't think is a good idea. Subtle breakage could occur literally at
> > > > any point.
> > > >
> > > > c) Provide an override declaration/definition for bpf_lsm_mmap_file()
> > > > within include/linux/bpf_lsm.h and kernel/bpf/bpf_lsm.c such that the
> > > > struct file pointer argument is named file__nullable instead. Similar
> > >
> > > I don't yet see how you can accomplish this, but it's indeed the best
> > > option.
> > > There is already:
> > > FUNC 'bpf_lsm_mmap_file' type_id=...
> > > Magic hack to
> > > #define LSM_HOOK(RET, DEFAULT, NAME, ...)       \
> > > noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
> > > ?
> >
> > Hm, I too was questioning whether this was initially even possible,
> > but I managed to get it working by doing the following (perhaps this
> > is also what you had meant when you mentioned using the distinct
> > suffix below):
> >
> > ```
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index 643809cc78c3..ddb328ba856d 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -14,11 +14,18 @@
> >
> >  #ifdef CONFIG_BPF_LSM
> >
> > +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
> > +                     unsigned long prot, unsigned long flags);
> > +
> > +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
> > +
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> >         RET bpf_lsm_##NAME(__VA_ARGS__);
> >  #include <linux/lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >
> > +#undef bpf_lsm_mmap_file
> > +
> >  struct bpf_storage_blob {
> >         struct bpf_local_storage __rcu *storage;
> >  };
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 7cb6e8d4282c..48259738e032 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -20,6 +20,14 @@
> >  /* For every LSM hook that allows attachment of BPF programs, declare a nop
> >   * function where a BPF program can be attached.
> >   */
> > +noinline int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
> > +                             unsigned long prot, unsigned long flags)
> > +{
> > +       return 0;
> > +}
> > +
> > +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
> 
> so both functions will be in BTF and in .text ?
> That's suboptimal. Hopefully there won't be many hooks that
> need such annotation, but let's think of ways to avoid the waste.

Sure, perhaps not optimal, but it may very well be the best and most
trivial option at this point. See comments below.

> Like there is BTF_TYPE_EMIT(). We haven't used it
> to emit FUNC kind. It works for FUNC_PROTO kind, but that's not
> enough here.
> 
> We can play tricks with __weak. Like:
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 7cb6e8d4282c..60d269a85bf1 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -21,7 +21,7 @@
>   * function where a BPF program can be attached.
>   */
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
> -noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
> +__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
> 
> diff kernel/bpf/bpf_lsm_proto.c
> 
> +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
> +                     unsigned long prot, unsigned long flags)
> +{
> +       return 0;
> +}
> 
> and above one with __nullable will be in vmlinux BTF.
> 
> afaik __weak functions are not removed by linker when in non-LTO,
> but it's still better than
> +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
> No need to change bpf_lsm.h either.

Annotating with a weak attribute would be quite nice, but the compiler
will complain about the redefinition of the symbol
bpf_lsm_mmap_file. To avoid this, we'd still need to rely on the
rename and ignore dance by using the aforementioned define, which at
that point would still result in both symbols being exposed in both
BTF and the .text section.

> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
> >  noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
> >  {                                              \
> > @@ -29,6 +37,8 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)      \
> >  #include <linux/lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >
> > +#undef bpf_lsm_mmap_file
> > +
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
> >  BTF_SET_START(bpf_lsm_hooks)
> >  #include <linux/lsm_hook_defs.h>
> > ```
> >
> > > or a flavor named with a distinct suffix ?
> > > bpf_lsm_mmap_file___suffix(struct file *file__nullable, ...) ?
> > >
> > > To address the same issue with tracepoints we went with
> > > raw_tp_null_args[].
> > > It's ugly, but gets the job done. We can probably apply it
> > > to lsm args too.
> >
> > Unfortunately, I'm not overly familiar with the whole
> > raw_tp_null_args[] thing, so I don't really know how this works. I'll
> > need to take a look.
> 
> I'll take back this suggestion. __weak hack above is cleaner
> than raw_tp_null_args[].
> 
> > > tbh option (b) could have been a choice or even:
> > > -int security_mmap_file(struct file *file, unsigned long prot,
> > > +int security_mmap_file(struct file *file__nullable, unsigned long prot,
> > >
> > > but it's an operational headache due to different subsystems/maintainers.
> >
> > Agree, hence why I think we should just add the necessary workaround
> > directly within the BPF LSM.
> >
> > > Long term the plan is to wait for gcc/pahole to fully support
> > > btf_decl_tags and switch to that.
> >
> > Yes, I literally hit send on my previous email only for this exact
> > option to also pop into my head. But as I read more into it on my
> > commute home, I gathered that there was some inherent dependency on
> > the BPF toolchain which probably isn't ideal at this point either.
> >
> > Another alternative that has literally just come to mind is the
> > possibility of introducing another BTF set (i.e. nullable_args). A
> > function (LSM hook) associated with this new BTF set will basically
> > force the BPF verifier to strictly treat all of its associated pointer
> > type arguments as nullable.
> 
> This hammer is too big. imo

