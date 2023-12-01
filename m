Return-Path: <bpf+bounces-16476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079C801832
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 00:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FBE281C25
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 23:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D6B59B6B;
	Fri,  1 Dec 2023 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHNbxQH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C219F
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 15:54:52 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so878237241.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 15:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474891; x=1702079691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pol7hI1Hy96E33miCesPUidUjW/JKgnpIaa4LePlFSs=;
        b=cHNbxQH58fP/SljUhRwXB5T7I0grZWfdt3leYdcSrhUDIuOEmwkUY4Jylj3HazbfNC
         1bY23dJMdKyVvj1J0UCM34FzGGZswVcE6IkaVix/N6gHz4bOC7lQ/h1AZbcfNVEMvLma
         wzeodblYt0ENFV6PiJW9wYAnRALmcrJV23FFWH/qQNM9neS+b8DGLtK+3iJ1NivsrVgN
         IjnqMdRZA5WYghTKR/hzs1sXSH6eeQele6KmQq80jzEr1Jf4VRNBX0BmhpPtp5waLW1s
         b/AKaAaExWgN300EjUmpE8Mxtr4XXxJicGfgZQbKeKEPf4hbSSjAw5dlUwz+yN1P+H8v
         gkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474891; x=1702079691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pol7hI1Hy96E33miCesPUidUjW/JKgnpIaa4LePlFSs=;
        b=FJ/km249ISaB3rjr4euIIS1a34MbqzXYIPKfp5bXLY+ejc7I7djX92mCUz9HQ+2t5b
         gd0KKnj1fhmJ3O7ZBZFcdUx4hBrDd0uPAFrhWhxnCN33FSyHY7c8OJ2QOryFc5GKoS7o
         eOPCuFjIsGYeBosF/0SAha1aYnLI6f1Ax3L015q8qwP7VyjllYppy3R5EBYT7snvr30T
         zvyPW7JcYb3YEACCBP9KP0wqMYB6FrygWe5wC8ANi0E0v6SVCi1qTRMFISGQ0L+g/wOg
         oZvFRWhOZPTvyhofVzlU9MRKxEq3JeRAIaXOC4EAkk+vsI+FqDxKVHuNZml2W6DD7cNe
         PlmA==
X-Gm-Message-State: AOJu0Yx2nZ5wah7xbseParFQFLXw5Am1Lgi6AV+CjZqk5FtuhCC3p8bz
	fTwjQRWuB+ykrfG3HuAvl5GsygXRw9x2afbd3KizXQ==
X-Google-Smtp-Source: AGHT+IFhYdGfLbE8mSyQJ9sVITWjwja5raT5mVt0aQs6YqvlVg9Hcm3bf9FfCdJYLNUrv209BolhENIl06CXXpMM8rM=
X-Received: by 2002:a05:6122:319f:b0:4b2:c555:383 with SMTP id
 ch31-20020a056122319f00b004b2c5550383mr302268vkb.25.1701474891180; Fri, 01
 Dec 2023 15:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120144642.591358648@infradead.org> <20231120154948.708762225@infradead.org>
 <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com> <20231122111517.GR8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231122111517.GR8262@noisy.programming.kicks-ass.net>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 1 Dec 2023 15:54:13 -0800
Message-ID: <CABCJKufBiJjUdmnuy=HkV+dDnZ=xne-OBwPSfJ21RX9c0AzCZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/cfi,bpf: Fix BPF JIT call
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, davem@davemloft.net, dsahern@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, keescook@chromium.org, nathan@kernel.org, 
	ndesaulniers@google.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, jpoimboe@kernel.org, 
	joao@overdrivepizza.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 3:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> So the kCFI thing is 'new' but readily inspected by objdump or godbolt:
>
>   https://godbolt.org/z/sGe18z3ca
>
> (@Sami, that .Ltmp15 thing, I don't see that in the kernel, what
> compiler flag makes that go away?)

Hmm, that looks like that's what we emit to .kcfi_traps. I suppose
Godbolt just doesn't show the section directives?

https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/X86/kcfi.l=
l#L30

Sami

