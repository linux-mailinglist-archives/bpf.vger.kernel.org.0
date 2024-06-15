Return-Path: <bpf+bounces-32215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FF90966F
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C9FB22AC4
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C0171CD;
	Sat, 15 Jun 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB+ey9CJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1E79F5;
	Sat, 15 Jun 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718434636; cv=none; b=j0FhQj3BFaWwCVsWP7sqhCgynEHrDyvdOUfL6bt04NOJBEKqQRXyRbmnrTm2ia0sPOZFaCulSPysnaF+whV+HyiTpYfH517uBS7SqgfLN9o61yvjlwKAF8bQXd4X3CzwPjF/8zN6oEOAAmz9UamoXi1uDwJCDsZXj+6heNLYmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718434636; c=relaxed/simple;
	bh=Bb2fQMOo6UM0Iq/AExfXpsirIMy9JXvRkm9QLWI3IiE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvFh2cMRGCza7vhj/iTxsP2LIo6bNoioDa8stJTuvoyF4tTO6KFzMMjIVhYf2ouczmH/0RE1Oex4EUSeyPyxM+WGQu08m3EfR24MIzDGJU8fRI2SxFZWCV84oMI5faNeRuZ4dve9Fo7T0g2cQPLv0iWKAcL+cJxUL5uhwKeDyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB+ey9CJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a5344ec7so20723975ad.1;
        Fri, 14 Jun 2024 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718434634; x=1719039434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVMEGqz4A/oZR85YRDZvBBeHsokCXOHWVtWvAwH7aFM=;
        b=PB+ey9CJZcNOd2Y7xK+5j+/zzK1EjbkDwqjqvsP0Qf6D10/0Kt/R/LcxFA3zip6pMP
         cKUbZ8tlhGgU2HXWpfH7yCtyrmYyeq+W7rWou3nb+4towCcQTOlotDE0zG5YyE0RWaH8
         D0Wn/gyafq8l6j131nnfsmzwR/RsRZO9nJT6fLvhYKL48CrgARRc2Kb1hNsaVYbaUhXa
         kmWFal0AUt6fwmAeQ6LI8FUXr+R4Sl4RotvTG8pVsD76XnaYzuykn3CWNUOGq7hZuhSH
         2lWFAHeYi7s4pAA166Zf0AWhVxJ6kWTpX0TXckQa/od+qOfANOnKe2Lfezi/M3IxsQzL
         HZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718434634; x=1719039434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVMEGqz4A/oZR85YRDZvBBeHsokCXOHWVtWvAwH7aFM=;
        b=qU8iuk0JVq+MRfAg7sEKM8wHxHX7Up/CVEUuS/j63B2xGMKiUE07cvx2TRiwQuw4vQ
         eRMOuDEQnOyJIN7kk4pHKFeHQ4NLApt1VeMQjhng5hVsLMtnz7jNKxlxdmu8+UDsonhe
         EDNah5IZUKIXB4xzGGmEgVUm/F/OJg8vEiL/1S7+snLFpqgKBJOxvIjpj+0szgxl2gPh
         DyERJ9zx8VXngoJ818Qo1izEQtOodm8Ys8cjaCdLAj5YCgozfn8cLmnWMblS/7DhwTsi
         4mqpSNJsUhUTX+m32VDIuz4D4e3rK44j4X49hd44hF9lvwcZS8tPTX9gNlHqgBtwF10W
         4abQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTz/uqepnTVzLwePZkxHbSGOAKvsFhv0XGLTxOxvGO1fOrRC3y+UqO4gM7M3mgBY4jM2sB3/4m3mWfXXKpY+7sy1aIj8XG
X-Gm-Message-State: AOJu0YypRRdUHz/i4XzrcWuXTJYgUMAO9HZR0OJPAYhAps+wyvyZxozv
	K67k6nKbydxC1yLfNt384dNKHJhyeNyFc87wSPVMgaXtkDngrNMp
X-Google-Smtp-Source: AGHT+IENWQ0rYfP6lAWrBlTy88pAx2jOUjavxDtQQdVQ5u5412jk45t0V6M3l4hAQP8K/9WZ52hIPA==
X-Received: by 2002:a17:902:ef50:b0:1f8:4a12:ed6e with SMTP id d9443c01a7336-1f84e42e34dmr128332785ad.25.1718434633671;
        Fri, 14 Jun 2024 23:57:13 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e81130sm43215345ad.116.2024.06.14.23.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 23:57:13 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 14 Jun 2024 23:57:10 -0700
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
Message-ID: <Zm07RtJLjIZqq763@kodidev-ubuntu>
References: <cover.1717413886.git.Tony.Ambardar@gmail.com>
 <cover.1717477560.git.Tony.Ambardar@gmail.com>
 <b31bca5a5e6765a0f32cc8c19b1d9cdbfaa822b5.1717477560.git.Tony.Ambardar@gmail.com>
 <7540222d-92e0-47f7-a880-7c4440671740@linux.dev>
 <ZmeEs2eaRe0E1Hk8@kodidev-ubuntu>
 <f1459b36-fd78-4ac3-8c37-e34222c546bf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1459b36-fd78-4ac3-8c37-e34222c546bf@linux.dev>

On Fri, Jun 14, 2024 at 11:47:19AM -0700, Yonghong Song wrote:
> 
> On 6/10/24 3:56 PM, Tony Ambardar wrote:
> > On Tue, Jun 04, 2024 at 10:55:39PM -0700, Yonghong Song wrote:
> > > On 6/3/24 10:23 PM, Tony Ambardar wrote:
> > > > Some code includes the __used macro to prevent functions and data from
> > > > being optimized out. This macro implements __attribute__((__used__)), which
> > > > operates at the compiler and IR-level, and so still allows a linker to
> > > > remove objects intended to be kept.
> > > > 
> > > > Compilers supporting __attribute__((__retain__)) can address this gap by
> > > > setting the flag SHF_GNU_RETAIN on the section of a function/variable,
> > > > indicating to the linker the object should be retained. This attribute is
> > > > available since gcc 11, clang 13, and binutils 2.36.
> > > > 
> > > > Provide a __retain macro implementing __attribute__((__retain__)), whose
> > > > first user will be the '__bpf_kfunc' tag.
> > > > 
> > > > Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
> > > > Cc: stable@vger.kernel.org # v6.6+
> > > > Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> > > > ---
> > > >    include/linux/compiler_types.h | 23 +++++++++++++++++++++++
> > > >    1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > > index 93600de3800b..f14c275950b5 100644
> > > > --- a/include/linux/compiler_types.h
> > > > +++ b/include/linux/compiler_types.h
> > > > @@ -143,6 +143,29 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
> > > >    # define __preserve_most
> > > >    #endif
> > > > +/*
> > > > + * Annotating a function/variable with __retain tells the compiler to place
> > > > + * the object in its own section and set the flag SHF_GNU_RETAIN. This flag
> > > > + * instructs the linker to retain the object during garbage-cleanup or LTO
> > > > + * phases.
> > > > + *
> > > > + * Note that the __used macro is also used to prevent functions or data
> > > > + * being optimized out, but operates at the compiler/IR-level and may still
> > > > + * allow unintended removal of objects during linking.
> > > > + *
> > > > + * Optional: only supported since gcc >= 11, clang >= 13
> > > > + *
> > > > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-retain-function-attribute
> > > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#retain
> > > > + */
> > > > +#if __has_attribute(__retain__) && \
> > > > +	(defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
> > > > +	 defined(CONFIG_LTO_CLANG))
> > > Could you explain why CONFIG_LTO_CLANG is added here?
> > > IIUC, the __used macro permits garbage collection at section
> > > level, so CLANG_LTO_CLANG without
> > > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> > > shuold not change final section dynamics, right?
> > Hi Yonghong,
> > 
> > I included the conditional guard to ensure consistent behaviour between
> > __retain and other features forcing split sections. In particular, the same
> > guard is used in vmlinux.lds.h to merge split sections where needed. For
> > example, using __retain in llvm builds without CONFIG_LTO was failing CI
> > tests on kernel-patches/bpf because the kernel didn't boot properly. And in
> > further testing, the kernel had no issues loading BPF kfunc modules with
> > such split sections, so I left the module (partial) linking scripts alone.
> 
> I tried with both bpf and bpf-next tree and I cannot make CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
> in .config file. The following are all occurances in Kconfig:

My understanding is one doesn't directly set HAVE_LD_DEAD_CODE_...; it's a
per-arch capability flag which guards setting LD_DEAD_CODE_DATA_ELIMINATION
but only targets "small systems" (i.e. embedded), so no surprise x86 isn't
in the arch list below.

> 
> $ egrep -r HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> arch/mips/Kconfig:      select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> arch/powerpc/Kconfig:   select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if HAVE_OBJTOOL_MCOUNT && (!ARCH_USING_PATCHABLE_FUNCTION_ENTRY || (!CC_IS_GCC || GCC_VERSION >= 110100))
> arch/riscv/Kconfig:     select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> init/Kconfig:config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> init/Kconfig:   depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> 
> Are there some pending patches to enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> for x86?

I doubt it given the target arches above, but curious what's the need for
x86 support? Only x86_32? My patches were motivated seeing resolve_btfids
and pahole errors for a couple years on MIPS routers. I don't recall seeing
the same for x86 builds, so my testing focussed more on preserving x86
builds rather than adding/testing the arch flag for x86.

> 
> I could foce CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y with the following hack:
> diff --git a/init/Kconfig b/init/Kconfig
> index 72404c1f2157..adf8718e2f5b 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1402,7 +1402,7 @@ config CC_OPTIMIZE_FOR_SIZE
>  endchoice
>  config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> -       bool
> +       def_bool y
>         help
>           This requires that the arch annotates or otherwise protects
>           its external entry points from being discarded. Linker scripts
> 
> But with the above, I cannot boot the kernel.

OK, interesting exercise. Setting HAVE_LD_DEAD_CODE_DATA_ELIMINATION
shouldn't change anything itself so I suppose you are also setting
LD_DEAD_CODE_DATA_ELIMINATION? From previous testing on kernel-patches/CI,
first guess would be vmlinux linker script doing section merges unaware of
some x86 quirk. Or x86-specific linker script unhappy with split sections.

> 
> 
> Did I miss anything?
> 
> > 
> > Maybe I misunderstand you question re: __used?
> > 
> > Thanks,
> > Tony
> > > > +# define __retain			__attribute__((__retain__))
> > > > +#else
> > > > +# define __retain
> > > > +#endif
> > > > +
> > > >    /* Compiler specific macros. */
> > > >    #ifdef __clang__
> > > >    #include <linux/compiler-clang.h>

