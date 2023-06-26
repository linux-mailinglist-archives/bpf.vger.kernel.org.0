Return-Path: <bpf+bounces-3474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E0C73E6D9
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074251C2099F
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAE12B94;
	Mon, 26 Jun 2023 17:48:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB8125A7;
	Mon, 26 Jun 2023 17:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86401C43397;
	Mon, 26 Jun 2023 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687801731;
	bh=fFWuzhLLiGkinhaWeToFLkDX/dcx5OWER83aW8VgRow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qn7TSH5fBy879Kn45s8a/YCOEx1oTS+0VCd/Q+kNmCB7uRTTg7TK3CW2K5FgKL5SO
	 RoBVKuhnNkjoWxoU5K2xmCMLOL3TePePVRvun87gj3KrTnQpXgAMXLWOX/L2U+vGMb
	 wy6CqBDWmWhCmphC6Q8EiBNziTaMXriaczMp6DJiN1Ej/WUjTzJ6N+lvXogj4eiJcj
	 PJKRTqLP+Zecd+1KGIrC38/JsFePpZ84jlJVtuUPeUpe+0KdJssjei1KlWQsAb8xqI
	 wX+VWs0F7zWSqHLgR+NZLp09+VOq+k1qPrGR83NuByW+4SQgicdeCKOv73ZNgnYywR
	 IXCdgqJe6fP2Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f8689fbf59so5765332e87.0;
        Mon, 26 Jun 2023 10:48:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDwHOCXBDBdGd9b4lMdSKT8qVBasv78TzKVknxYGcI7OVT7Ygd8R
	4MKUxER8LP9Ic52vOMgwJgoERu5KyoiNGxxH/7k=
X-Google-Smtp-Source: ACHHUZ6w6e1OYy7QM9S+YTdK71Dx4cd9s642AcRaJSfPZb8UXF8n/hvi2zuHhdV8C7DcTgUpaxVtcUwpuH0YchvBFOg=
X-Received: by 2002:a19:5f5d:0:b0:4f8:5e62:b94b with SMTP id
 a29-20020a195f5d000000b004f85e62b94bmr8655403lfj.9.1687801729333; Mon, 26 Jun
 2023 10:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-3-rppt@kernel.org>
 <f9a7eebe-d36e-4587-b99d-35d4edefdd14@app.fastmail.com> <20230618080027.GA52412@kernel.org>
 <a17c65c6-863f-4026-9c6f-a04b659e9ab4@app.fastmail.com> <20230625161417.GK52412@kernel.org>
 <ZJmFFmexl_1GUhIL@FVFF77S0Q05N>
In-Reply-To: <ZJmFFmexl_1GUhIL@FVFF77S0Q05N>
From: Song Liu <song@kernel.org>
Date: Mon, 26 Jun 2023 10:48:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4pDkd7rCWRM6938ve36rfhGxyu=8t1-GjcKnNajofpQA@mail.gmail.com>
Message-ID: <CAPhsuW4pDkd7rCWRM6938ve36rfhGxyu=8t1-GjcKnNajofpQA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] mm: introduce execmem_text_alloc() and jit_text_alloc()
To: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, 
	"the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 5:31=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
[...]
> >
> > So the idea was that jit_text_alloc() will have a cache of large pages
> > mapped ROX, will allocate memory from those caches and there will be
> > jit_update() that uses text poking for writing to that memory.
> >
> > Upon allocation of a large page to increase the cache, that large page =
will
> > be "invalidated" by filling it with breakpoint instructions (e.g int3 o=
n
> > x86)
>
> Does that work on x86?
>
> That is in no way gauranteed for other architectures; on arm64 you need
> explicit cache maintenance (with I-cache maintenance at the VA to be exec=
uted
> from) followed by context-synchronization-events (e.g. via ISB instructio=
ns, or
> IPIs).

I guess we need:
1) Invalidate unused part of the huge ROX pages;
2) Do not put two jit users (including module text, bpf, etc.) in the
same cache line;
3) Explicit cache maintenance;
4) context-synchronization-events.

Would these (or a subset of them) be sufficient to protect us from torn rea=
d?

Thanks,
Song

