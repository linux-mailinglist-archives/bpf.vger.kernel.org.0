Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7B65EC97
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 14:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjAENNG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 08:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjAENMm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 08:12:42 -0500
Received: from fx403.security-mail.net (smtpout140.security-mail.net [85.31.212.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611D5A8AC
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 05:12:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id 8A0B214E9FE
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 14:12:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672924356;
        bh=9WB6GmoBK+yOkgiR2vt2Yu8QcJKamwH/vIHlzkk4Rzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=vlU5EiAuyEWHI6EkyVsPeSzl9lQE9y9u8SM7mc2ZIRjugtTh2cksdv030hPszxd3R
         NeAto+K7HetdXMCqiYW8LdVEUWcoF1mA9tUWhdEJFtWzYQOprxtfzKPXkPK2bJ/Y2r
         1heqnNM/m4OG8SQNfueeoGyecKvL73C1artfbN2U=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 5F69B14F501; Thu,  5 Jan 2023 14:12:36 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx403.security-mail.net (Postfix) with ESMTPS id 8423914F0B8; Thu,  5 Jan
 2023 14:12:35 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 5A8A027E02AC; Thu,  5 Jan 2023
 14:12:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 3E54427E02E4; Thu,  5 Jan 2023 14:12:35 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 BmaMETebmHmr; Thu,  5 Jan 2023 14:12:35 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 1F31A27E02AC; Thu,  5 Jan 2023
 14:12:35 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <10e54.63b6ccc3.8318d.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 3E54427E02E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672924355;
 bh=Os7yBdjKEQxwrmBBrz6wLHlejfUcsBUSLT+/ykjGvF4=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=FJnGh7d1QCfwodQuuNjrITZHsSDpLie1/NM/tCPWUZ2LOk1CRvaGZQPmBrheWmJNn
 /LJGvRTjbhzYzIHoTblCA8wmgn+zJ23kmjxcPYSDfaKLfVFWL/gVG98jaxgz5KoMtK
 nP9QEFhDUEl7wFVgP7FwBYqwbJxfCvUXMHLJw3ys=
Date:   Thu, 5 Jan 2023 14:12:34 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH 03/25] kvx: Add build infrastructure
Message-ID: <20230105131233.GB7446@tellis.lin.mbt.kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-4-ysionneau@kalray.eu>
 <b27e6aa6-5560-e509-a1fd-21807dd5b23e@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b27e6aa6-5560-e509-a1fd-21807dd5b23e@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Tue, Jan 03, 2023 at 09:29:21AM -0800, Randy Dunlap wrote:
> Hi,
> 
-- snip snip
> > +config ARCH_MMAP_RND_BITS_MAX
> > +	default 24
> > +
> 
> Do the above and below configs need an "int" line for their type?
> I notice that the patch does that below for PGTABLE_LEVELS.
> 
I don't think it needs an "int" line, it is added in arch/Kconfig
(which includes arch/kvx/Kconfig)

> > +config ARCH_MMAP_RND_BITS_MIN
> > +	default 18
> > +
> > +config STACKTRACE_SUPPORT
> > +	def_bool y
> > +
> > +config LOCKDEP_SUPPORT
> > +	def_bool y
> > +
> > +config GENERIC_BUG
> > +	def_bool y
> > +	depends on BUG
> > +
> > +config KVX_4K_PAGES
> > +	def_bool y
> > +
> > +config KVX
> > +	def_bool y
> [deletes]
> > +
> > +config PGTABLE_LEVELS
> > +	int
> > +	default 3
> ^^^^^^^^^^^^^^^^^^^^^^^^
I think the "int" here can be removed, as done for
ARCH_MMAP_RND_BITS_MAX and ARCH_MMAP_RND_BITS_MIN

> > +
> > +config HAVE_KPROBES
> > +	def_bool n
> > +
> > +menu "System setup"
> > +
> > +config POISON_INITMEM
> > +	bool "Enable to poison freed initmem"
> > +	default y
> > +	help
> > +	  In order to debug initmem, using poison allows to verify if
> > +	  some data/code is stille using them. Enable this for debug
> 
> 	                    still
> 
> > +	  purposes
> 
> 	  purposes.
> 
> > +
> > +config KVX_PHYS_OFFSET
> > +	hex "RAM address of memory base"
> > +	default 0x100000000
> > +
> > +config KVX_PAGE_OFFSET
> > +	hex "kernel virtual address of memory base"
> > +	default 0xFFFFFF8000000000
> > +
> > +config ARCH_FLATMEM_ENABLE
> > +	def_bool y
> > +
> > +config ARCH_SPARSEMEM_ENABLE
> > +	def_bool y
> > +
> > +config ARCH_SPARSEMEM_DEFAULT
> > +	def_bool ARCH_SPARSEMEM_ENABLE
> > +
> > +config ARCH_SELECT_MEMORY_MODEL
> > +	def_bool ARCH_SPARSEMEM_ENABLE
> > +
> > +config STACK_MAX_DEPTH_TO_PRINT
> > +	int "Maximum depth of stack to print"
> > +	range 1 128
> > +	default "24"
> > +
> > +config L2_CACHE
> > +	bool "Enable l2 cache driver"
> 
> 	             L2
> 
> > +	default y
> > +	help
> > +	  Enable L2 cache driver in order to handle it. This driver can be
> > +	  disabled to eliminate any overhead related to L2 cache
> > +	  inval/writeback. Note that L2 cache is mandatory for SMP in order
> > +	  to maintain coherency on DDR between all PEs.
> > +
> > +config SECURE_DAME_HANDLING
> > +	bool "Secure DAME handling"
> > +	default y
> > +	help
> > +	  In order to securely handle Data Asynchronous Memory Errors, we need
> > +	  to do a barrier upon kernel entry when coming from userspace. This
> > +	  barrier guarantee us that any pending DAME will be serviced right
> 
> 	          guarantees
> 
> > +	  away. We also need to do a barrier when returning from kernel to user.
> > +	  This way, if the kernel or the user triggered a DAME, it will be
> > +	  serviced by knowing we are coming from kernel or user and avoid
> > +	  pulling the wrong lever (panic for kernel or sigfault for user).
> > +	  This can be costly but ensure that user cannot interfere with kernel.
> 
> 	                         ensures
> 
> > +	  /!\ Do not disable unless you want to open a giant breach between
> > +	  user and kernel /!\
> > +
> > +config CACHECTL_UNSAFE_PHYS_OPERATIONS
> > +	bool "Enable cachectl syscall unsafe physical operations"
> > +	default n
> > +	help
> > +	  Enable cachectl syscall to allow writebacking/invalidating ranges
> > +	  based on physical addresses. These operations requires the
> > +	  CAP_SYS_ADMIN capability
> 
> 	                capability.
> 
> > +
> > +config ENABLE_TCA
> > +	bool "Enable TCA coprocessor support"
> > +	default y
> > +	help
> > +	  This option enables TCA coprocessor support. It will allow the user to
> > +	  use the coprocessor and save registers on context switch if used.
> > +	  Registers content will also be cleared when switching.
> > +
> > +config SMP
> > +	bool "Symmetric multi-processing support"
> > +	default n
> > +	select GENERIC_SMP_IDLE_THREAD
> > +	select GENERIC_IRQ_IPI
> > +	select IRQ_DOMAIN_HIERARCHY
> > +	select IRQ_DOMAIN
> > +	select L2_CACHE
> > +	help
> > +	  This enables support for systems with more than one CPU. If you have
> > +	  a system with only one CPU, say N. If you have a system with more
> > +	  than one CPU, say Y.
> > +
> > +	  If you say N here, the kernel will run on uni- and multiprocessor
> > +	  machines, but will use only one CPU of a multiprocessor machine. If
> > +	  you say Y here, the kernel will run on many, but not all,
> > +	  uniprocessor machines. On a uniprocessor machine, the kernel
> > +	  will run faster if you say N here.
> > +
> > +config NR_CPUS
> > +	int "Maximum number of CPUs"
> > +	range 1 16
> > +	default "16"
> > +	depends on SMP
> > +	help
> > +	  Kalray support can handle a maximum of 16 CPUs.
> > +
> > +config KVX_PAGE_SHIFT
> > +	int
> > +	default 12
> > +
> > +config CMDLINE
> > +	string "Default kernel command string"
> > +	default ""
> > +	help
> > +	  On some architectures there is currently no way for the boot loader
> > +	  to pass arguments to the kernel. For these architectures, you should
> > +	  supply some command-line options at build time by entering them
> > +	  here.
> > +
> > +endmenu
> > +
> > +menu "Kernel Features"
> > +source "kernel/Kconfig.hz"
> > +endmenu
> > diff --git a/arch/kvx/Kconfig.debug b/arch/kvx/Kconfig.debug
> > new file mode 100644
> > index 000000000000..027e919a1e14
> > --- /dev/null
> > +++ b/arch/kvx/Kconfig.debug
> > @@ -0,0 +1,70 @@
> > +menu "KVX debugging"
> > +
> > +config KVX_DEBUG_ASN
> > +	bool "Check ASN before writing TLB entry"
> > +	default n
> > +	help
> > +	  This option allows to check if the ASN of the current
> > +	  process is matching the ASN found in MMC. If it is not the
> 
> 	s/is matching/matches/
> 
> > +	  case an error will be printed.
> > +
> > +config KVX_DEBUG_TLB_WRITE
> > +	bool "Enable TLBs write checks"
> > +	default n
> > +	help
> > +	  Enabling this option will enable TLB access checks. This is
> > +	  particularly helpful when modifying the assembly code responsible
> > +	  of TLB refill. If set, mmc.e will be checked each time the tlb are
> 
> 	  for TLB refill.                                            TLB
> 
> > +	  written and a panic will be thrown on error.
> > +
> > +config KVX_DEBUG_TLB_ACCESS
> > +	bool "Enable TLBs accesses logging"
> > +	default n
> > +	help
> > +	  Enabling this option will enable TLB entry manipulation logging.
> > +	  Each time an entry will be added to the TLBs, it will be logged in
> 
> 	                    s/will be/is/               s/will be/is/
> 
> > +	  an array readable via gdb scripts. This can be useful to understand
> > +	  strange crashes related to suspicious virtual/physical addresses.
> > +
> > +config KVX_DEBUG_TLB_ACCESS_BITS
> > +	int "Number of bits used as index of entries in log table"
> > +	default 12
> > +	depends on KVX_DEBUG_TLB_ACCESS
> > +	help
> > +	  Set the number of bits used as index of entries that will be logged
> > +	  in a ring buffer called kvx_tlb_access. One entry in the table
> > +	  contains registers TEL, TEH and MMC. It also logs the type of the
> > +	  operations (0:read, 1:write, 2:probe). Buffer is per CPU. For one
> > +	  entry 24 bytes are used. So by default it uses 96Ko of memory per
> 
> What does "Ko" mean?

Ko stands for kilo-octet which is the french equivalent for kilo byte.
I've found more typos like this in the documentation and they will be
corrected as well.

> > +	  CPU to store 2^12 (4096) entries.
> > +
> > +config KVX_MMU_STATS
> > +	bool "Register mmu stats debugfs entries"
> 
> Preferably             MMU
> 
> > +	default n
> > +	select DEBUG_FS
> 
> Preferably:
> 	depends on DEBUG_FS
ack

> > +	help
> > +	  Enable debugfs attribute which will allow inspecting various metric
> 
> 	                                                               metrics
> 
> > +	  regarding MMU:
> > +	  - Number of nomapping traps handled
> > +	  - avg/min/max time for nomapping refill (user/kernel)
> > +
> > +config DEBUG_EXCEPTION_STACK
> > +	bool "Enable exception stack debugging"
> > +	default n
> > +	help
> > +	  Enable stack check debugging when entering/exiting
> > +	  exception handlers.
> > +	  This can be particularly helpful after modifying stack
> > +	  handling to see if stack when exiting is the same as the one
> > +	  when entering exception handler.
> > +
> > +config DEBUG_SFR_SET_MASK
> > +	bool "Enable sfr set_mask debugging"
> > +	default n
> > +	help
> > +	  Verify that values written using kvx_sfr_set_mask are matching the
> 
> 	  s/are matching/match/
> 
> > +	  mask. This ensure that no extra bits of sfr will be overridden by some
> 
> 	             ensures
> 
> and preferably s/sfr/SFR/ in 2 places (not in kvx_sfr_set_mask).
> 
> > +	  incorrectly truncated values. This can lead to huge problems by
> > +	  modifying important bits in system registers.
> > +
> > +endmenu

Thanks, all the typos will be corrected :)

  Jules




