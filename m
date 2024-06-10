Return-Path: <bpf+bounces-31756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B76902BFF
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 00:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9642827F5
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E14153BE3;
	Mon, 10 Jun 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEyjp+59"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520FF1534FB;
	Mon, 10 Jun 2024 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060216; cv=none; b=PVyNYM6B2ng/V5ogtHidJYVk4KZMmIUvnzHM3/sgYebCSCY7hJnjP8sTWu4hLUuijTKsUqiKWFRFZpkKAO8bET/VikwrnA0ZNokZPf+JImC8mg9eJ8WtSZLekfhaHKL/s0RmJlEPl5yYVJ8aapAC5G4yG/r7qfvcVk2CAgfsVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060216; c=relaxed/simple;
	bh=Dmx+tLODf++e4ikrdyNwKhoKb2zPsnmvNhImXTiY7ko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o98BAdWprKQure223p9nG3ZXhwVXYQLq/RYBEoPGwMyNbA9TxMA3J4QUQvFFZzZev6YZj2ETmWdN034Id48up8EbOTLa+Yz2x8qn3hrjcPM3NlA+nWTQvqMcOugDOnnxVmK0Jh6CMuKkjqRkrF1JTJe8seQmzfMnZDlQNDYZPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEyjp+59; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-701b0b0be38so4692351b3a.0;
        Mon, 10 Jun 2024 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718060214; x=1718665014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rodnQkY0rmk6LgCMMegBSWUozCZBzVjSkzUr5Hd2tdI=;
        b=gEyjp+59LecnEqnIEvkwRQsPudGobo0L7Pkt3lGCN+5iccquXoTq19juPGAGq+RlSK
         OSd9C4IsrD/r4zvhYbpbMMVqZagIOy5l3Y9PCb8iFH2Qtr7fjXNreL6WjQ9yOOFikhfJ
         HiFELoOcRWTWcK1uGU5F+Gv3b8PZVsRAcDYITvHpF5JlKDMwwW3RK0+lU7NluCNx5NDR
         eJcAmQ6FCpkXgq1v4DCGefoAeP0wD/wXVT9AKAV17wpv41jj5WaxEEdZyUuRsMxJZfXL
         k2sIEks6gJiQHReL4dqXz6jRcsn+2p2xAQvrQPNUcbH26RxldW7eu9TH0Smq00o6mb+y
         CYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060214; x=1718665014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rodnQkY0rmk6LgCMMegBSWUozCZBzVjSkzUr5Hd2tdI=;
        b=Q0hYIBiofYtnunAIhT0ZRqRumABQ1UQasxQ1hVucsuuZGGtsBLm9aAXA7FHEIK8zJs
         U30HQexgmmxTaSlEmPJ9S75BAtnoCXW2lmNkNlGQcdDPFo42J+WrGMp3M0tsOoh/BeNs
         boNDSE3Fa5h3lGepYAYZifKLotLWOW3YH+V+hPPJPLj1spHWHTty6EJO2UIY5jHX8pCm
         8DN+QDP8U+W8Kgx39HI/x0fO1JUf7/N0VxL0xQA7ssED/1wLNyNcs+iDFtkAy0aQOxrj
         GTfeQIm52xi0wgzbsfmutt+70od8jrJ8lUSQe0bnEU4HWZjaAC5Fvjq/yxi5WWH5/cMP
         GlUg==
X-Forwarded-Encrypted: i=1; AJvYcCXDqOC8Og9p8mJrPeprRovbbGkkK0wRyADc2jcgz/ZkMRMGPeqJ21dmcm7KkJFCekZHm/AVHDXDCBztqfBjUUGzbPPemYSR
X-Gm-Message-State: AOJu0Ywgv1kRyLBJh6MJgO8VbK/feiHeDemh7TL9ACtxqkoZOpyrsf5/
	AH4NjOnkiZMhL5faAjp9jnHs/HZUR4hv3icTAjGyTILMe1mH1n2w
X-Google-Smtp-Source: AGHT+IE/O8yeHe/8fbAoayIaWQoxFdHG/QC7rEE2KGtvSxlcfspBoRRfBtTcZQeW6FCRcu3RR9JsRw==
X-Received: by 2002:a05:6a20:3c8c:b0:1b8:3f6d:3037 with SMTP id adf61e73a8af0-1b83f6d3494mr3033904637.18.1718060214413;
        Mon, 10 Jun 2024 15:56:54 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041ec6f9cesm4897654b3a.78.2024.06.10.15.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:56:53 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 10 Jun 2024 15:56:51 -0700
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] compiler_types.h: Define __retain for
 __attribute__((__retain__))
Message-ID: <ZmeEs2eaRe0E1Hk8@kodidev-ubuntu>
References: <cover.1717413886.git.Tony.Ambardar@gmail.com>
 <cover.1717477560.git.Tony.Ambardar@gmail.com>
 <b31bca5a5e6765a0f32cc8c19b1d9cdbfaa822b5.1717477560.git.Tony.Ambardar@gmail.com>
 <7540222d-92e0-47f7-a880-7c4440671740@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7540222d-92e0-47f7-a880-7c4440671740@linux.dev>

On Tue, Jun 04, 2024 at 10:55:39PM -0700, Yonghong Song wrote:
> 
> On 6/3/24 10:23 PM, Tony Ambardar wrote:
> > Some code includes the __used macro to prevent functions and data from
> > being optimized out. This macro implements __attribute__((__used__)), which
> > operates at the compiler and IR-level, and so still allows a linker to
> > remove objects intended to be kept.
> > 
> > Compilers supporting __attribute__((__retain__)) can address this gap by
> > setting the flag SHF_GNU_RETAIN on the section of a function/variable,
> > indicating to the linker the object should be retained. This attribute is
> > available since gcc 11, clang 13, and binutils 2.36.
> > 
> > Provide a __retain macro implementing __attribute__((__retain__)), whose
> > first user will be the '__bpf_kfunc' tag.
> > 
> > Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
> > Cc: stable@vger.kernel.org # v6.6+
> > Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> > ---
> >   include/linux/compiler_types.h | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> > 
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 93600de3800b..f14c275950b5 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -143,6 +143,29 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
> >   # define __preserve_most
> >   #endif
> > +/*
> > + * Annotating a function/variable with __retain tells the compiler to place
> > + * the object in its own section and set the flag SHF_GNU_RETAIN. This flag
> > + * instructs the linker to retain the object during garbage-cleanup or LTO
> > + * phases.
> > + *
> > + * Note that the __used macro is also used to prevent functions or data
> > + * being optimized out, but operates at the compiler/IR-level and may still
> > + * allow unintended removal of objects during linking.
> > + *
> > + * Optional: only supported since gcc >= 11, clang >= 13
> > + *
> > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-retain-function-attribute
> > + * clang: https://clang.llvm.org/docs/AttributeReference.html#retain
> > + */
> > +#if __has_attribute(__retain__) && \
> > +	(defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
> > +	 defined(CONFIG_LTO_CLANG))
> 
> Could you explain why CONFIG_LTO_CLANG is added here?
> IIUC, the __used macro permits garbage collection at section
> level, so CLANG_LTO_CLANG without
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> shuold not change final section dynamics, right?

Hi Yonghong,

I included the conditional guard to ensure consistent behaviour between
__retain and other features forcing split sections. In particular, the same
guard is used in vmlinux.lds.h to merge split sections where needed. For
example, using __retain in llvm builds without CONFIG_LTO was failing CI
tests on kernel-patches/bpf because the kernel didn't boot properly. And in
further testing, the kernel had no issues loading BPF kfunc modules with
such split sections, so I left the module (partial) linking scripts alone.

Maybe I misunderstand you question re: __used?

Thanks,
Tony
> 
> > +# define __retain			__attribute__((__retain__))
> > +#else
> > +# define __retain
> > +#endif
> > +
> >   /* Compiler specific macros. */
> >   #ifdef __clang__
> >   #include <linux/compiler-clang.h>

