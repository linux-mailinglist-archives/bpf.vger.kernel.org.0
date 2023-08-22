Return-Path: <bpf+bounces-8314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58409784D01
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1213D281184
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878F34CF3;
	Tue, 22 Aug 2023 22:55:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7892019C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 22:55:33 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C99CFC
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 15:55:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso6106158a12.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 15:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692744931; x=1693349731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WrhIrT98nQaWTPAY4ahhbVHoNEUTChler7/GQveF3Js=;
        b=q3Lw73k970hLU4CYFcRn/80fjz3ET9EOlPCn6D8qLU+n1EZRcrWKv/kR9UZedzVBfx
         I3Yh0heQoYk8ww9PDGZHEN/hqDZ4isE8NjRfaJLfG9Li0AvQdnwDSBY7/XJ+49w7G9e0
         gWjnnuRTxv3xRnZLXOjDwMiTlpCzGBpjrQmzpTgwym61Rgl2PtclXenFjY34GzFiCYjW
         2Wci/mcc3AtBtZ2b+Ie97csOUFefu5Ufyw2NNHpDjM3FrnpvGpJE+auPWGjz58rb0uK3
         A4UvDa24Xf9Gc9t/dIhErDNC5Tm3EEgSG9N/IRFS7C2iJiHvH8QU2TZVD32dqfgQ3EHP
         ZxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692744931; x=1693349731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrhIrT98nQaWTPAY4ahhbVHoNEUTChler7/GQveF3Js=;
        b=lyle/TPk3HaB8IPOO2rExb6wAD6J+pWq1PUUXO5kkIGJbwjM+E0ur2f2xn22nWXMho
         8IO2yIupc7C1OIZ3Dn48qvTcSJOepeYNLEyC3o9WTeQOBLQwCt81m1IcfN00X2Jl0TrT
         o8/GKUlUM8FZqnRWMyhBIXXuruXMupQvBvBNtR0TrhoGXRt1buJvWGibo08YV68L3Vjb
         c7fBNDB9bbT+dDnH/oD7/4Vx18uI5OF2hHXOr37YYQfIGg/DyKYO5ME4OVpQqCyCKeEv
         85UwVyG5q0SF9sS/7U1bgGiev2Tno7stK+09G2+9PxAEB1Kxlygc9ZLfa10/A3lu646K
         JHYw==
X-Gm-Message-State: AOJu0YxrJZ+QZBep0gz0wN+SnB6FUOYHqNMIJuXmfZ1p/0mYbSsiocNK
	Ae5JtYeFMfSuKZFGiDtrhkDq+PjdgGbxQVuHrlw=
X-Google-Smtp-Source: AGHT+IFN8KpAISzp2+LuknqZ8TKIWb4SDo/pEcfQcLEsiw91UoK4hnS3aFPA9cZ/HjO89dcsxs7CVHLxtbPBL0Vox4I=
X-Received: by 2002:a05:6402:788:b0:523:40f3:11a6 with SMTP id
 d8-20020a056402078800b0052340f311a6mr8330479edy.9.1692744931008; Tue, 22 Aug
 2023 15:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
 <87lee2enow.fsf@oracle.com>
In-Reply-To: <87lee2enow.fsf@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 23 Aug 2023 04:24:54 +0530
Message-ID: <CAP01T77G0Oy9rpKPN0xUdOtMqYx4-mZ_jVCxGAVuw6JfDJ0pCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/14] Exceptions - 1/2
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 23 Aug 2023 at 03:37, Jose E. Marchesi <jose.marchesi@oracle.com> wrote:
>
>
> > On Wed, 9 Aug 2023 at 17:11, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >>
> >> [...]
> >>
> >> Known issues
> >> ------------
> >>
> >>  * Just asm volatile ("call bpf_throw" :::) does not emit DATASEC .ksyms
> >>    for bpf_throw, there needs to be explicit call in C for clang to emit
> >>    the DATASEC info in BTF, leading to errors during compilation.
> >>
> >
> > Hi Yonghong, I'd like to ask you about this issue to figure out
> > whether this is something worth fixing in clang or not.
> > It pops up in programs which only use bpf_assert macros (which emit
> > the call to bpf_throw using inline assembly) and not bpf_throw kfunc
> > directly.
> >
> > I believe in case we emit a call bpf_throw instruction, the BPF
> > backend code will not see any DWARF debug info for the respective
> > symbol, so it will also not be able to convert it and emit anything to
> > .BTF section in case no direct call without asm volatile is present.
> > Therefore my guess is that this isn't something that can be fixed in
> > clang/LLVM.
>
> Besides, please keep in mind that GCC doens't have an integrated
> assembler, and therefore relying on clang's understanding on the
> instructions in inline assembly is something to avoid.
>

Thank you for reminding me that. I will be more careful about this.
We certainly cannot rely on clang-specific behavior for this.

> > There are also options like the one below to work around it.
> > if ((volatile int){0}) bpf_throw();
> > asm volatile ("call bpf_throw");
>
> I can confirm the above results in a BTF entry for bpf_throw with
> bpf-unknown-none-gcc -gbtf.

Thanks for confirming.

