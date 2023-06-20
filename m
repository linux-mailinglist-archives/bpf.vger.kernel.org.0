Return-Path: <bpf+bounces-2948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB507372B3
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9686D281326
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D228D2AB50;
	Tue, 20 Jun 2023 17:24:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAF2AB3A;
	Tue, 20 Jun 2023 17:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F88C433CA;
	Tue, 20 Jun 2023 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687281894;
	bh=Rd2KQT7Sg/jj2vpD/+cypNQq21vO707uBhL4Wt60ONQ=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=qVLzEw3DYllRsW1kHmBV862G6LOZFXc4fKTQnIpsgdD3rkTdoAKKcvq1gRTVFpyy5
	 XbCuDXOA1g1mZTF7xKYW2DvV4WvN2nArEOEJgYcwd4dfupuNCgrJ1TcrC087JauSrD
	 bRc/e3gFOmGsVaMU9qcLfWmy5T2ln7Jbkx9hx3XU2mUqramf+q8rMAFYMpM7+uX76N
	 kL3uRI0aY94qeKbLwAOT9R5Vt7d0a4F/1qUypEQw4GZYFbdsYPH/DlFJM0rqVnm3R6
	 pFduwHV7iGgrpKWkxEPmXRIlBYyw1sOUEKglC1dG6CWAHw+KOuedQ+eu2dj3ec+4eB
	 /QpIQ01kgaTbg==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id C920427C005A;
	Tue, 20 Jun 2023 13:24:51 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 20 Jun 2023 13:24:51 -0400
X-ME-Sender: <xms:4uCRZGPuv7m8KaXFojrVeCbfWrMZ7IJoui-4aoDexdm_V34ZG0-I6g>
    <xme:4uCRZE-OH2xt14uLz-FF7dbdv-gHG5w14JwsdNtUTTBditVKBbvq_q8tXxJx8iDzO
    WaowhDX_m63-nZ50aI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:4uCRZNTpfg2cGu-JZbGK0lauKT6LTXTvSpjwrRQTqsoePCHX_VolEg>
    <xmx:4uCRZGtzcXFiHy54TUV3vETkj3W0NygxpQUty3hSE43wjAfN8bvT-A>
    <xmx:4uCRZOcK6KfTYx9uY7noUEoncUDShNm2IP8FjLgB4nFv3QpkDL6MpA>
    <xmx:4-CRZOAOrENLDeV3AOynkkTJ3wDHPyrZf0jxchqFsnzGmPnTrQoXvQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 85C9831A0063; Tue, 20 Jun 2023 13:24:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <6145cabf-d016-4dba-b5d2-0fb793352058@app.fastmail.com>
In-Reply-To: <7F566E60-C371-449B-992B-0C435AD6016B@gmail.com>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-3-rppt@kernel.org>
 <f9a7eebe-d36e-4587-b99d-35d4edefdd14@app.fastmail.com>
 <20230618080027.GA52412@kernel.org>
 <a17c65c6-863f-4026-9c6f-a04b659e9ab4@app.fastmail.com>
 <7F566E60-C371-449B-992B-0C435AD6016B@gmail.com>
Date: Tue, 20 Jun 2023 10:24:29 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Nadav Amit" <nadav.amit@gmail.com>, "Song Liu" <song@kernel.org>
Cc: "Mike Rapoport" <rppt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Helge Deller" <deller@gmx.de>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Puranjay Mohan" <puranjay12@gmail.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Will Deacon" <will@kernel.org>,
 bpf <bpf@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org,
 "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH v2 02/12] mm: introduce execmem_text_alloc() and jit_text_alloc()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Jun 19, 2023, at 1:18 PM, Nadav Amit wrote:
>> On Jun 19, 2023, at 10:09 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> But jit_text_alloc() can't do this, because the order of operations d=
oesn't match.  With jit_text_alloc(), the executable mapping shows up be=
fore the text is populated, so there is no atomic change from not-there =
to populated-and-executable.  Which means that there is an opportunity f=
or CPUs, speculatively or otherwise, to start filling various caches wit=
h intermediate states of the text, which means that various architecture=
s (even x86!) may need serialization.
>>=20
>> For eBPF- and module- like use cases, where JITting/code gen is quite=
 coarse-grained, perhaps something vaguely like:
>>=20
>> jit_text_alloc() -> returns a handle and an executable virtual addres=
s, but does *not* map it there
>> jit_text_write() -> write to that handle
>> jit_text_map() -> map it and synchronize if needed (no sync needed on=
 x86, I think)
>
> Andy, would you mind explaining why you think a sync is not needed? I=20
> mean I have a =E2=80=9Cfeeling=E2=80=9D that perhaps TSO can guarantee=
 something based=20
> on the order of write and page-table update. Is that the argument?

Sorry, when I say "no sync" I mean no cross-CPU synchronization.  I'm as=
suming the underlying sequence of events is:

allocate physical pages (jit_text_alloc)

write to them (with MOV, memcpy, whatever), via the direct map or via a =
temporary mm

do an appropriate *local* barrier (which, on x86, is probably implied by=
 TSO, as the subsequent pagetable change is at least a release; also, an=
y any previous temporary mm stuff would have done MOV CR3 afterwards, wh=
ich is a full "serializing" barrier)

optionally zap the direct map via IPI, assuming the pages are direct map=
ped (but this could be avoided with a smart enough allocator and tempora=
ry_mm above)

install the final RX PTE (jit_text_map), which does a MOV or maybe a LOC=
K CMPXCHG16B.  Note that the virtual address in question was not readabl=
e or executable before this, and all CPUs have serialized since the last=
 time it was executable.

either jump to the new text locally, or:

1. Do a store-release to tell other CPUs that the text is mapped
2. Other CPU does a load-acquire to detect that the text is mapped and j=
umps to the text

This is all approximately the same thing that plain old mmap(..., PROT_E=
XEC, ...) does.

>
> On this regard, one thing that I clearly do not understand is why=20
> *today* it is ok for users of bpf_arch_text_copy() not to call=20
> text_poke_sync(). Am I missing something?

I cannot explain this, because I suspect the current code is wrong.  But=
 it's only wrong across CPUs, because bpf_arch_text_copy goes through te=
xt_poke_copy, which calls unuse_temporary_mm(), which is serializing.  A=
nd it's plausible that most eBPF use cases don't actually cause the load=
ed program to get used on a different CPU without first serializing on t=
he CPU that ends up using it.  (Context switches and interrupts are seri=
alizing.)

FRED could make interrupts non-serializing. I sincerely hope that FRED d=
oesn't cause this all to fall apart.

--Andy

