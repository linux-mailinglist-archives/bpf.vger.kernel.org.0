Return-Path: <bpf+bounces-18316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A6818D08
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281AA28802F
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D70208C6;
	Tue, 19 Dec 2023 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmJ1UAFB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E420DDA
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso2096977f8f.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 08:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703004933; x=1703609733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr1gwYwEAqV3CPDFt5tJeZc4Ej3mhik7sPY5D9i4L+4=;
        b=qmJ1UAFBfZ4ahVGkaLyRsoMDVYtCQes7HeM62U+vzeFk3ZVVdgg1vfXb/WgqTdHYLG
         RxZs5YIA2yusvw7zBQ4gmjr6CmTttUnjf8rxsY+ZycnbY7FWl+b19Uv/Gv7W00djvUTt
         zzuihPgrjItSSdUGH7QVI+R5TdKp5KrojWRie0IIilVM8islbrnFg59q6lu982cXdzqN
         3ZdLGf4GedeEmDHSBcNeveM72dmgK3lu2Wdg78d1wDk3CsIhpjbYLcLPVQ0UHQm+4Ntw
         a3mQ/vR+iOh0MO6Byw87tI/ETdRaI9EQjY54KSD/fUooASgvnk4H8gEtKqAmi7jmc89D
         pAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004933; x=1703609733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pr1gwYwEAqV3CPDFt5tJeZc4Ej3mhik7sPY5D9i4L+4=;
        b=mC6xcin22OxshTWX1qQzeTerYQaJJMML+g1aMFodXdpt0Lz6exMjLpJ0b7IwlAjYXc
         D8mAOtDlZg/BD1LloRZBQPuF+b7ORU7YJvG1djBNqTFxQcK5aCcgVmvhgnjmEzzc+2HA
         eYi618YivLTIgzTw6Uz9bAiD9GZpKvtHtgz2FSF32fslo1mnPKzYmZbY3wCvX/I/uK2F
         gok75l5XS+ZCvdxI8c+GpcEAOSBEyQ2n68dpBqlO/bgTxP2GSS9fh+bC4nd32Ll5Sdla
         NMCAJIt7ssAQLAGIfCBCRGVYklLW3NMjk/t3oZTsdYvo8BBGZdIRJQ8NKYix5KPhhgsp
         hfng==
X-Gm-Message-State: AOJu0YyF/ueU3qwSz6E2h4r6P6BcS6n5odq7wBtpKFJX4BXkqaLjAzLU
	8HlacpwbbmcZTmXLx9uifuhywuJ+7grgi1+5D8wtcA==
X-Google-Smtp-Source: AGHT+IHdJSnW1uoy3+KysPNVwLZ4H/jx1KVZ/uOvjz42emCllqfn1IhGJ3uQ5Ral4Y9max8Bshqiu+TgQgc/H/ReIBY=
X-Received: by 2002:adf:e4c3:0:b0:336:60da:7530 with SMTP id
 v3-20020adfe4c3000000b0033660da7530mr1849799wrm.158.1703004932880; Tue, 19
 Dec 2023 08:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215171020.687342-21-bigeasy@linutronix.de>
 <202312161212.D5tju5i6-lkp@intel.com> <20231219000116.GA3956476@dev-arch.thelio-3990X>
In-Reply-To: <20231219000116.GA3956476@dev-arch.thelio-3990X>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 19 Dec 2023 08:55:21 -0800
Message-ID: <CAKwvOdkfjyKz6686RzAGjfKMVPriLM8XuNueYyWcd_Sj-WnJbg@mail.gmail.com>
Subject: Re: [PATCH net-next 20/24] net: intel: Use nested-BH locking for XDP redirect.
To: Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, John Fastabend <john.fastabend@gmail.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 4:01=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Sat, Dec 16, 2023 at 12:53:43PM +0800, kernel test robot wrote:
> > Hi Sebastian,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrze=
j-Siewior/locking-local_lock-Introduce-guard-definition-for-local_lock/2023=
1216-011911
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20231215171020.687342-21-bigea=
sy%40linutronix.de
> > patch subject: [PATCH net-next 20/24] net: intel: Use nested-BH locking=
 for XDP redirect.
> > config: arm-defconfig (https://download.01.org/0day-ci/archive/20231216=
/202312161212.D5tju5i6-lkp@intel.com/config)
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.gi=
t f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20231216/202312161212.D5tju5i6-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312161212.D5tju5i6-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/net/ethernet/intel/igb/igb_main.c:8620:3: error: cannot jump=
 from this goto statement to its label
> >                    goto xdp_out;
> >                    ^

^ The problematic goto should be replaced with an early return. (and
perhaps a comment that you can't jump over __cleanup variable
initialization).

Otherwise the compiler cannot put the cleanup in the destination basic
block; it would have to split the edges and have all the happy paths
go to a synthesized basic block that runs the cleanup, then jumps to
the original destination.

> >    drivers/net/ethernet/intel/igb/igb_main.c:8624:2: note: jump bypasse=
s initialization of variable with __attribute__((cleanup))
> >            guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
> >            ^
> >    include/linux/cleanup.h:142:15: note: expanded from macro 'guard'
> >            CLASS(_name, __UNIQUE_ID(guard))
> >                         ^
> >    include/linux/compiler.h:180:29: note: expanded from macro '__UNIQUE=
_ID'
> >    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), _=
_COUNTER__)
> >                                ^
> >    include/linux/compiler_types.h:84:22: note: expanded from macro '__P=
ASTE'
> >    #define __PASTE(a,b) ___PASTE(a,b)
> >                         ^
> >    include/linux/compiler_types.h:83:23: note: expanded from macro '___=
PASTE'
> >    #define ___PASTE(a,b) a##b
> >                          ^
> >    <scratch space>:52:1: note: expanded from here
> >    __UNIQUE_ID_guard753
> >    ^
> >    1 error generated.
>
> I initially thought that this may have been
> https://github.com/ClangBuiltLinux/linux/issues/1886 but asm goto is not
> involved here.
>
> This error occurs because jumping over the initialization of a variable
> declared with __attribute__((__cleanup__(...))) does not prevent the
> clean up function from running as one may expect it to, but could
> instead result in the clean up function getting run on uninitialized
> memory. A contrived example (see the bottom of the "Output" tabs for the
> execution output):
>
> https://godbolt.org/z/9bvGboxvc
>
> While there is a warning from GCC in that example, I don't see one in
> the kernel's case. I see there is an open GCC issue around this problem:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D91951
>
> While it is possible that there may not actually be a problem with how
> the kernel uses __attribute__((__cleanup__(...))) and gotos, I think
> clang's behavior is reasonable given the potential footguns that this
> construct has.
>
> Cheers,
> Nathan
>


--=20
Thanks,
~Nick Desaulniers

