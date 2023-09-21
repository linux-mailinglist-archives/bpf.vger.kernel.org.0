Return-Path: <bpf+bounces-10597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3627AA4AB
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 00:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BDB4E286231
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E102032E;
	Thu, 21 Sep 2023 22:15:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA97F2;
	Thu, 21 Sep 2023 22:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFB4C433B6;
	Thu, 21 Sep 2023 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695334508;
	bh=j+YpilMLGCC5ERDcgjdZY/UEYbvSwBxJ4mCRlrG3+go=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L+gPhURipQCVv5lQ6lMZEeHafe2Map2Z3SouhfPMvOq3LIN5npAvywgTLrdsrYoDw
	 lcSQt8Ka8fmcf1d8ZM8qIlXPNumlpX3JZKdESMC/KpenaIBv7uGMi+LUkvfCfO+Vlt
	 Ms3BphwgqclEjVmwfHiEkkrb7+Ta8zh3Ag+RqoFwGGlsIzXfHKrtVOjxsaXB9alIhH
	 JK+MwyCKXlDL+alHW9KkokkF6FFQuanhqMW2Sdmh2NRZkCVnTo9ppIcJLwe1SwZkYz
	 JQdTcMm4ZdnaSVT+CVcsNzzz7DKO5EXfQ9zO0FIrMF11/hIqK2vZeqyr2ZUZVULtBX
	 NHK7vuo8iml0w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50337b43ee6so2384844e87.3;
        Thu, 21 Sep 2023 15:15:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz6LQ7OFX4l8PRAF6m5TPSjW+jAccwG8ucpwcrP41ii8KG8riIo
	p5zrHoy/uro0IDaCuObv8tfVteYpmks0JnVOHoE=
X-Google-Smtp-Source: AGHT+IEOsdVYa+3bdtK+lEO/ooz4+HKzafq7xPbE1njdx3C8+57KFx3hJ2XTTULe0kNONSMtwPONNYKDgjY7yPaLcMU=
X-Received: by 2002:a05:6512:3254:b0:503:1c07:f7f9 with SMTP id
 c20-20020a056512325400b005031c07f7f9mr5552939lfr.29.1695334506735; Thu, 21
 Sep 2023 15:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-3-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-3-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Sep 2023 15:14:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7y2T+tajK71NfYhquhGJKpLpL+EoxxzqrVhEuAamDH3w@mail.gmail.com>
Message-ID: <CAPhsuW7y2T+tajK71NfYhquhGJKpLpL+EoxxzqrVhEuAamDH3w@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] mm: introduce execmem_text_alloc() and execmem_free()
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nadav Amit <nadav.amit@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 12:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
[...]
> +
> +/**
> + * enum execmem_type - types of executable memory ranges
> + *
> + * There are several subsystems that allocate executable memory.
> + * Architectures define different restrictions on placement,
> + * permissions, alignment and other parameters for memory that can be us=
ed
> + * by these subsystems.
> + * Types in this enum identify subsystems that allocate executable memor=
y
> + * and let architectures define parameters for ranges suitable for
> + * allocations by each subsystem.
> + *
> + * @EXECMEM_DEFAULT: default parameters that would be used for types tha=
t
> + * are not explcitly defined.
> + * @EXECMEM_MODULE_TEXT: parameters for module text sections
> + * @EXECMEM_KPROBES: parameters for kprobes
> + * @EXECMEM_FTRACE: parameters for ftrace
> + * @EXECMEM_BPF: parameters for BPF
> + * @EXECMEM_TYPE_MAX:
> + */
> +enum execmem_type {
> +       EXECMEM_DEFAULT,

I found EXECMEM_DEFAULT more confusing than helpful.

Song

> +       EXECMEM_MODULE_TEXT =3D EXECMEM_DEFAULT,
> +       EXECMEM_KPROBES,
> +       EXECMEM_FTRACE,
> +       EXECMEM_BPF,
> +       EXECMEM_TYPE_MAX,
> +};
> +
[...]

