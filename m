Return-Path: <bpf+bounces-16612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799B803DE1
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0920328120D
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B830F89;
	Mon,  4 Dec 2023 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVppsoUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736BFA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 10:59:28 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-464a3b84ef7so63561137.1
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 10:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701716367; x=1702321167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhTNasiWgh+dkfX0Dm+ISFeJznRbPndi9WOsk0B0xUY=;
        b=gVppsoUuN4dqz8Syy1kQUrjoI9C/nqzgvQfx9nxccS1+RNS89BFXrTngJIOrk1P6If
         VplsZJ65o6IHbLWieGBql0IaVkQDWogVu+eI8is0EtgTP0CONumAwdj4iJfQys0/4eMk
         Iryix0SeSnwxRXh2vSivhXqpgzPjawruaCoQ5ylbQvbXZ9QuXZa0BfcgdycQDQSAHn61
         a4nSahHkBplyN0wqnAtQotFnTvEPpC6jXp5q+DbUtCi9EowADUZmq8jeuIr89+F+UB6n
         xbQCIRISWxN9a3sFhAUCq3AEFFWk6PnBYeV0Hv2gnLd7K9HhxKM6WjOEUdOz9tG8WSi5
         LU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716367; x=1702321167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhTNasiWgh+dkfX0Dm+ISFeJznRbPndi9WOsk0B0xUY=;
        b=OIjrFjgBGKrJK5+x19dty2NIBzF57XFsivCDBqY5aSBZQAj/OhK+UMaxoD3upBY+nv
         hcoWBfIXzJzNdsRXt5lWPex8upGMeQ+FsLseSNzkvawxu1SgjI8XD/lU+xzhw5gecGCO
         9jOKrCoKwR58uY/NRKdEwl0lefL5t/0ltXFj1cxPdFY55o9ZmqQTkWwROByoFr4xUqP6
         mQSRRkEfm7TceCeiQjHGBL6VEUChU5NjVX7yED3nuWrn3ou3HMAQG4Oj2vBsYMinpMRy
         eeLhb0qX1sbcQOrS7iOvqj5aqdLFWE3EDudZpXqNDND020qavP5jUSK+eoiMag3KAQCP
         CGuA==
X-Gm-Message-State: AOJu0Yxq78v5s3vbeYR1yQHXhReKjIpACvmt1VS171zZOUrbINkxF9Ze
	174HOk7NiXc/FwlsSDm0qAmM9mAfuMpcN/4EbrYA/w==
X-Google-Smtp-Source: AGHT+IEfIkpQz/M9GZdrLZVheDNrcWpdTi70JO843+0WuxJNqy5io3mjCriO6X0r0jWpNfjDIVrEn82cF2d3kchgVn8=
X-Received: by 2002:a05:6102:a53:b0:452:6d82:56e3 with SMTP id
 i19-20020a0561020a5300b004526d8256e3mr383189vss.6.1701716367163; Mon, 04 Dec
 2023 10:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130133630.192490507@infradead.org> <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net> <20231204111128.GV8262@noisy.programming.kicks-ass.net>
 <20231204125239.GA1319@noisy.programming.kicks-ass.net> <ZW4LjmUKj1q6RWdL@krava>
 <20231204181614.GA7299@noisy.programming.kicks-ass.net> <20231204183354.GC7299@noisy.programming.kicks-ass.net>
In-Reply-To: <20231204183354.GC7299@noisy.programming.kicks-ass.net>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 4 Dec 2023 10:58:48 -0800
Message-ID: <CABCJKudYc5GtO7TLV=d0-ZYFfBxofrV3-q1vpsaT3MD7oTKpnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Song Liu <song@kernel.org>, Song Liu <songliubraving@meta.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	linux-riscv <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Joao Moreira <joao@overdrivepizza.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 10:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> So afaict this is used through bpf_for_each_map_elem(), where the
> argument still is properly callback_fn. However, in the desriptor
> bpf_for_each_map_elem_proto the argument gets described as:
> ARG_PTR_TO_FUNC, which in turn has a comment like:
>
>   ARG_PTR_TO_FUNC,        /* pointer to a bpf program function */
>
> Which to me sounds like there is definite type punning involved. The
> call in bpf_for_each_array_elem() is a regular C indirect call, which
> gets adorned with the kCFI magic.
>
> But I doubt the BPF function that gets used gets the correct matching
> bits on.
>
> TL;DR, I think this is a pre-existing problem with kCFI + eBPF and not
> caused by my patches.

It is a pre-existing problem, I ran into the same failures when I
looked into this briefly last year:

https://github.com/ClangBuiltLinux/linux/issues/1727

In addition to bpf_for_each_array_elem, a few other callers also use
the same function pointer type that doesn't match cfi_bpf_hash.

Sami

