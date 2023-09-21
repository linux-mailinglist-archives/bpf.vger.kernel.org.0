Return-Path: <bpf+bounces-10599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585427AA517
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 00:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D3734286140
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD870168B3;
	Thu, 21 Sep 2023 22:31:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64B182A1;
	Thu, 21 Sep 2023 22:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC786C433CD;
	Thu, 21 Sep 2023 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695335460;
	bh=MM21fpAAqNycTt4Xaf9NDcGQ0SQTcft6//RqlmbkVyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BJxXZzf/aXubyQy2npZARHLDDjhgoXgiIEWqva3Fcvcj9zcoZxEU8fccdvHJ+HE1c
	 zzl8qTcUY9d4Go4O1phE4VHiUrxF82TprIMut63M6/i0lBXABCB/bZlTOwWqPbu1BQ
	 q5zu/0Z8B9EGkvCak3DZShCJdshYKc/r/AcXEeYIu2QyWVYI9Vx+BhQ1n26cL4/b0+
	 PS4cfkMveOYxyjpv6hbMeZ6FHOjVVnzGDFbwXlAgoIyH9v7qk7z8sPhWkYP6GlWWax
	 6oJu48Ae0Rkgt9SjGUY0GxlfVZDTstOKna+Ts701hrySxm3sOn2mvMBH6VjZ4iOt+Q
	 WLPXTkK17R7VA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50337b43ee6so2400559e87.3;
        Thu, 21 Sep 2023 15:31:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJ80atVQpPwKTRF29CYxJEvthpXSCSKKKNW/fjVvmDib0yO3aJ
	pd4b/1HM4ExSD3usFq4LwbrZRDCDzrhHjZ27SQQ=
X-Google-Smtp-Source: AGHT+IH8pmyQuqpvewRyL7QPTAL4jcebA+VNDdobgdjzXZOsPDkVCcZQaQNB105RzqTdIxkf8GblFKytjbdsRKyccPQ=
X-Received: by 2002:a05:6512:10c4:b0:500:7f71:e46b with SMTP id
 k4-20020a05651210c400b005007f71e46bmr7439120lfg.1.1695335458957; Thu, 21 Sep
 2023 15:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-10-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-10-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Sep 2023 15:30:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Vg7yDn8zb5ez4JY4efoQ6aW+vYm9OL+Xr0NJnLfMYHg@mail.gmail.com>
Message-ID: <CAPhsuW5Vg7yDn8zb5ez4JY4efoQ6aW+vYm9OL+Xr0NJnLfMYHg@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] powerpc: extend execmem_params for kprobes allocations
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

On Mon, Sep 18, 2023 at 12:31=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
[...]
> @@ -135,5 +138,13 @@ struct execmem_params __init *execmem_arch_params(vo=
id)
>
>         range->pgprot =3D prot;
>
> +       execmem_params.ranges[EXECMEM_KPROBES].start =3D VMALLOC_START;
> +       execmem_params.ranges[EXECMEM_KPROBES].start =3D VMALLOC_END;

.end =3D VMALLOC_END.

Thanks,
Song

> +
> +       if (strict_module_rwx_enabled())
> +               execmem_params.ranges[EXECMEM_KPROBES].pgprot =3D PAGE_KE=
RNEL_ROX;
> +       else
> +               execmem_params.ranges[EXECMEM_KPROBES].pgprot =3D PAGE_KE=
RNEL_EXEC;
> +
>         return &execmem_params;
>  }
> --
> 2.39.2
>
>

