Return-Path: <bpf+bounces-10858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4627AE6F0
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4203B28141A
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F25A107B6;
	Tue, 26 Sep 2023 07:34:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7746AA5;
	Tue, 26 Sep 2023 07:34:16 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC05FB;
	Tue, 26 Sep 2023 00:34:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id C07C03200962;
	Tue, 26 Sep 2023 03:34:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 03:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1695713650; x=1695800050; bh=LB
	GMXw95teWGAkpYjMD4yl8r6TRMMDISQAqR/M1cGNQ=; b=Rkj4/ro9taZZHblsOD
	/G8RJaZMr5EoZi3BiBVuPydXcqLBt6JUnEwEBSkbH9zdT7CVUQuwhIR4vjOvrJz7
	RZ3Epil4/1SvO77nFH1rFPyl9t2f+Q3SRKIN5+S4FzuiUdD22wwkSW/OYnjpuALL
	HtrICoJLxOpcEVcHu9AQxv5pZ6n5GVT1uDBGpmDdsYnAQw6s5OIHZilwNqnUGPkm
	4OjsMTRyNEOUw1tZgRF9dlyeKj8s8seL81kM8PIIQFyxX0qyog9Nsf+CDsm3zk8h
	ezgMFSodT5jl9S32PkpOMs3SS0XWcl664oOOjadAHKGA1Ihbl0lrhFruTxPcgfco
	mn5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695713650; x=1695800050; bh=LBGMXw95teWGA
	kpYjMD4yl8r6TRMMDISQAqR/M1cGNQ=; b=AUbkuoypa4Wsdj208B6uCagaZC/Xk
	A1dPx5DaS9T0xX5d79iQJKairrxWJfzJIhsL7KqjrQbLgE5SLde8s6vzO2Sgu7sc
	06ynHhZftaf9a44gz/tuW8lW6ktE/LPxdi/tVwr9o/giNuQS7K9R78duFOULJVvk
	1k2A1E6wKGy90242NbwgZjUpS/iNNlAkmDAYcKfQzd00vuPUSehSxxUFVE1h0t2e
	NLQf14NhEcO8lrG9/A5cKEmPG4gi+I2E+epzgguRRtykOaSiMVKbfBpOOt0GKV+w
	YvfRUboIrciFszM3IJHagkCio2kLoAGar1HvM8dXPFSk3ZdLkcytutiKA==
X-ME-Sender: <xms:cYkSZei1SR5UPNNwQIvWckEurLaebETqRWSoe1SREsrLxTVN2cfUEw>
    <xme:cYkSZfD_pkjEu8dR3QjlqgYUPyj0jlDPXLqqoWtk7WQpD0KW-d24VzNsz6B0lI0R5
    9d7qW7heI_wXZZFBSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegteeihfejvdfhfeffhfdvvddvfffgtedvteeigfehhfehudffleejuedu
    vdelgfenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cYkSZWHxrAFODnyh7EhOUS_cy0g3aKZ0eNP-llshn5XGCVAYyWOqqw>
    <xmx:cYkSZXRYz_9Vh0d45QZpmlHlsHUwuFMyElJw8MW88YsJw5F9MbDIGQ>
    <xmx:cYkSZbyl9JOnC5D2_lPQYyAQE2fF3SjTPKuthxvBsWixLxxuu4fNLA>
    <xmx:cokSZRkGE1pp9XZSFYh5zDGevCl3JsMLQPNoMBE3R8EJIWN1PZZ3Aw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4513AB60089; Tue, 26 Sep 2023 03:34:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44867c60-db1a-4a0c-8973-c8a03e8da0f3@app.fastmail.com>
In-Reply-To: <20230918072955.2507221-11-rppt@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
 <20230918072955.2507221-11-rppt@kernel.org>
Date: Tue, 26 Sep 2023 09:33:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Rapoport" <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Helge Deller" <deller@gmx.de>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nadav Amit" <nadav.amit@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Puranjay Mohan" <puranjay12@gmail.com>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Russell King" <linux@armlinux.org.uk>, "Song Liu" <song@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Will Deacon" <will@kernel.org>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 10/13] arch: make execmem setup available regardless of
 CONFIG_MODULES
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023, at 09:29, Mike Rapoport wrote:
> index a42e4cd11db2..c0b536e398b4 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> +#ifdef CONFIG_XIP_KERNEL
> +/*
> + * The XIP kernel text is mapped in the module area for modules and
> + * some other stuff to work without any indirect relocations.
> + * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
> + * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned 
> on/off.
> + */
> +#undef MODULES_VADDR
> +#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & 
> PMD_MASK)
> +#endif
> +
> +#if defined(CONFIG_MMU) && defined(CONFIG_EXECMEM)
> +static struct execmem_params execmem_params __ro_after_init = {
> +	.ranges = {
> +		[EXECMEM_DEFAULT] = {
> +			.start = MODULES_VADDR,
> +			.end = MODULES_END,
> +			.alignment = 1,
> +		},

This causes a randconfig build failure for me on linux-next now:

arch/arm/mm/init.c:499:25: error: initializer element is not constant
  499 | #define MODULES_VADDR   (((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
      |                         ^
arch/arm/mm/init.c:506:34: note: in expansion of macro 'MODULES_VADDR'
  506 |                         .start = MODULES_VADDR,
      |                                  ^~~~~~~~~~~~~
arch/arm/mm/init.c:499:25: note: (near initialization for 'execmem_params.ranges[0].start')
  499 | #define MODULES_VADDR   (((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
      |                         ^
arch/arm/mm/init.c:506:34: note: in expansion of macro 'MODULES_VADDR'
  506 |                         .start = MODULES_VADDR,
      |                                  ^~~~~~~~~~~~~

I have not done any analysis on the issue so far, I hope
you can see the problem directly. See
https://pastebin.com/raw/xVqAyakH for a .config that runs into
this problem with gcc-13.2.0.

      Arnd

