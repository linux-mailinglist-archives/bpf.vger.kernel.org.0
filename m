Return-Path: <bpf+bounces-10616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05E7AAD3A
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id E60DA1F2264C
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A801171D2;
	Fri, 22 Sep 2023 08:55:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4514F6F;
	Fri, 22 Sep 2023 08:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B218CC433C9;
	Fri, 22 Sep 2023 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695372943;
	bh=8QkGhwghTGYPhExKboS3z0PsUiDKGGvXCleAsd5SH5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CjAAOHnW+m8+RDAztDmFbJSI8mdUHvPboMtroHiybyvatO27zYyfR1Wv55g8Fv01I
	 te0s9HGkJ0VGUxcVzi6S21q5ZnP3kW3G91E9EzkcgwFh/S+KI1A7tuuEMTGE3HIqBt
	 6nRrji+IFh6kZxhnMEpdwcEddc5XEiLgoKEsYESe9+KRFo95Dw/rmUlDTh3/54BTTX
	 9KM5MArpAD0s7o4CKVI6Ii4apE868YOc1Vz8d3/fGW7P9s5e+247+f0d/ycaOQufD9
	 8mHhukuVVMeyYfCV4bv8fVCeskg+IFFN9ztlmxGPfhc3ExSSu6BsWAGJwgW8ktELWJ
	 FSaXLLenObg+g==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-502a4f33440so3234084e87.1;
        Fri, 22 Sep 2023 01:55:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YyoBMjZb8rQESVje9/kRPLVWuTOkCtq5JEZr4gWNmQaTKnELTh/
	rNJEHyctSpE+6kVmt2HO/SEyUHB8fr33pwPeRNw=
X-Google-Smtp-Source: AGHT+IF8cgUepodrWyUy99Ge6z4o9GbKwpmdAjZ3R33ypUsIeilkKxYeO+uhK8l2iNZFEKGHs3hnsEm9jfUciGjro48=
X-Received: by 2002:ac2:5bc5:0:b0:503:79e:fb7b with SMTP id
 u5-20020ac25bc5000000b00503079efb7bmr6817575lfn.68.1695372941964; Fri, 22 Sep
 2023 01:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-7-rppt@kernel.org>
 <CAPhsuW73NMvdpmyrhGouQSAHEL9wRw_A+8dZ-5R4BU=UHH83cw@mail.gmail.com> <9b73ad3d-cfda-bce5-2589-e8674a58c827@csgroup.eu>
In-Reply-To: <9b73ad3d-cfda-bce5-2589-e8674a58c827@csgroup.eu>
From: Song Liu <song@kernel.org>
Date: Fri, 22 Sep 2023 01:55:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4_3oYhN6LnPPyBVA4VAM=7voXKmcJNKLqiNEUboq1rnA@mail.gmail.com>
Message-ID: <CAPhsuW4_3oYhN6LnPPyBVA4VAM=7voXKmcJNKLqiNEUboq1rnA@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] mm/execmem: introduce execmem_data_alloc()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mike Rapoport <rppt@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, 
	Dinh Nguyen <dinguyen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, 
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 12:17=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 22/09/2023 =C3=A0 00:52, Song Liu a =C3=A9crit :
> > On Mon, Sep 18, 2023 at 12:31=E2=80=AFAM Mike Rapoport <rppt@kernel.org=
> wrote:
> >>
> > [...]
> >> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> >> index 519bdfdca595..09d45ac786e9 100644
> >> --- a/include/linux/execmem.h
> >> +++ b/include/linux/execmem.h
> >> @@ -29,6 +29,7 @@
> >>    * @EXECMEM_KPROBES: parameters for kprobes
> >>    * @EXECMEM_FTRACE: parameters for ftrace
> >>    * @EXECMEM_BPF: parameters for BPF
> >> + * @EXECMEM_MODULE_DATA: parameters for module data sections
> >>    * @EXECMEM_TYPE_MAX:
> >>    */
> >>   enum execmem_type {
> >> @@ -37,6 +38,7 @@ enum execmem_type {
> >>          EXECMEM_KPROBES,
> >>          EXECMEM_FTRACE,
> >
> > In longer term, I think we can improve the JITed code and merge
> > kprobe/ftrace/bpf. to use the same ranges. Also, do we need special
> > setting for FTRACE? If not, let's just remove it.
>
> How can we do that ? Some platforms like powerpc require executable
> memory for BPF and non-exec mem for KPROBE so it can't be in the same
> area/ranges.

Hmm... non-exec mem for kprobes?

       if (strict_module_rwx_enabled())
               execmem_params.ranges[EXECMEM_KPROBES].pgprot =3D PAGE_KERNE=
L_ROX;
       else
               execmem_params.ranges[EXECMEM_KPROBES].pgprot =3D PAGE_KERNE=
L_EXEC;

Do you mean the latter case?

Thanks,
Song

