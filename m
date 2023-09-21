Return-Path: <bpf+bounces-10596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B577AA47C
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 00:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 5EDCDB20A13
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 22:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8724820322;
	Thu, 21 Sep 2023 22:10:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC161947B;
	Thu, 21 Sep 2023 22:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5E4C433CB;
	Thu, 21 Sep 2023 22:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695334240;
	bh=N5hdFpyXSiGpYG0511NDyp6fv24cJcs4QSVnP7w1UAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wvqk0n6jq0ct52sblCUd8L/Xq8+N+SorW8zAWVSuS8RApVD17k7plQRRz/k5AtqcZ
	 GfT0CHWwJxWi4gUehtxR+8ljjuQTqjvYKgxWb2XNuVdjKevxRu1ENJFvPX5YXAHSbF
	 Ix9CdbGlyzCm8uVsj2Qxltwpt5fiLP3w48irVYCfZTdJDqTfRku6xjijf57j/ZypWU
	 97yg0mO2y5J78oLs+yCmKD+nXRc3T+EFcvHppUt3wuFXOaWZdvIvQ4j8dq0mhxHV1+
	 hn7FVpnRYo4KhRE7dodDocdh21fQMMb+Di7kRnH5vPdK32pTNVgx3GHtydByNaiHSX
	 2EmQpYW6b+alA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so2466137e87.1;
        Thu, 21 Sep 2023 15:10:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFcVtmEm3oEWo8idFtMNYq2G4WIU9xIxKGAeDSLaC8XzC5nHA6
	A/Os7unXe6c0ie2bw3wFW2fEWkGcW0nssbBNJ5k=
X-Google-Smtp-Source: AGHT+IFpnRd6TFzlAtTmG0SVL+ey3URugDNbqT5vmaLEkxDXDZHK88BxPcak1tSmyXSq9q54rWpyKjCd5XFO26LBHOk=
X-Received: by 2002:a19:6903:0:b0:4fe:2d93:2b50 with SMTP id
 e3-20020a196903000000b004fe2d932b50mr5173357lfc.31.1695334238605; Thu, 21 Sep
 2023 15:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-3-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-3-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Sep 2023 15:10:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4bQY5fo_+K2z4uUdd4r0wYF1eT3bAya=YqcEcmqdGXvg@mail.gmail.com>
Message-ID: <CAPhsuW4bQY5fo_+K2z4uUdd4r0wYF1eT3bAya=YqcEcmqdGXvg@mail.gmail.com>
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
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/execmem.h>
> +#include <linux/moduleloader.h>
> +
> +static void *execmem_alloc(size_t size)
> +{
> +       return module_alloc(size);
> +}
> +
> +void *execmem_text_alloc(enum execmem_type type, size_t size)
> +{
> +       return execmem_alloc(size);
> +}

execmem_text_alloc (and later execmem_data_alloc) both take "type" as
input. I guess we can just use execmem_alloc(type, size) for everything?

Thanks,
Song

> +
> +void execmem_free(void *ptr)
> +{
> +       /*
> +        * This memory may be RO, and freeing RO memory in an interrupt i=
s not
> +        * supported by vmalloc.
> +        */
> +       WARN_ON(in_interrupt());
> +       vfree(ptr);
> +}
> --
> 2.39.2
>

