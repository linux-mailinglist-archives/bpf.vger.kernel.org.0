Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313865C504
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 18:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjACR33 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 12:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjACR32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 12:29:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD05CE28;
        Tue,  3 Jan 2023 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KesCTdq3mlijR1GjVvhL2+3YxDFnDL5BOvuiaw/kI54=; b=dQQLsDRKIG/7qI2OVeSHKvK2G0
        2TAzPqaOuUEBLXawYiQNb6SHqGTfTUQAHvTIwSuglmRI6Lq907iC2rpkBmV1PYAAsVqqZvLnYrGKw
        DhWEMbaOCVJfEqc/GtHBHjpgqJWS/RTix3mLw0GskFhThguCNPatIi2BkMw7O5r2eZtxW5biUGBXU
        vzKHSjBCHaPGu95m6EjMe2WsvdlvGsdJP0ZG4QBag16rrm/PSd4WJ3xgSqqpU2Qitym03nlZRd34B
        R2czkGGk7mZfEVzkSdWMTVredoL/samwVHTAI6TnblwJX3aLawoSFDlR1LaqFYZ33L0EZe4tunybg
        tx/gBVRg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCl6J-003Pum-0S; Tue, 03 Jan 2023 17:29:23 +0000
Message-ID: <b27e6aa6-5560-e509-a1fd-21807dd5b23e@infradead.org>
Date:   Tue, 3 Jan 2023 09:29:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 03/25] kvx: Add build infrastructure
Content-Language: en-US
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        =?UTF-8?Q?Marc_Poulhi=c3=a8s?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-4-ysionneau@kalray.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230103164359.24347-4-ysionneau@kalray.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 1/3/23 08:43, Yann Sionneau wrote:
> Add Kbuild, Makefile, Kconfig and link script for kvx build infrastructure.
> 
> CC: linux-kernel@vger.kernel.org
> CC: bpf@vger.kernel.org
> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> Co-developed-by: Jonathan Borne <jborne@kalray.eu>
> Signed-off-by: Jonathan Borne <jborne@kalray.eu>
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> Co-developed-by: Marc Poulhiès <dkm@kataplop.net>
> Signed-off-by: Marc Poulhiès <dkm@kataplop.net>
> Co-developed-by: Marius Gligor <mgligor@kalray.eu>
> Signed-off-by: Marius Gligor <mgligor@kalray.eu>
> Co-developed-by: Samuel Jones <sjones@kalray.eu>
> Signed-off-by: Samuel Jones <sjones@kalray.eu>
> Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
> Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
> Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
>  arch/kvx/Kconfig                 | 249 +++++++++++++++++++++++++++++++
>  arch/kvx/Kconfig.debug           |  70 +++++++++
>  arch/kvx/Makefile                |  52 +++++++
>  arch/kvx/include/asm/Kbuild      |  20 +++
>  arch/kvx/include/uapi/asm/Kbuild |   1 +
>  arch/kvx/kernel/Makefile         |  27 ++++
>  arch/kvx/kernel/kvx_ksyms.c      |  24 +++
>  arch/kvx/kernel/vmlinux.lds.S    | 173 +++++++++++++++++++++
>  arch/kvx/lib/Makefile            |   6 +
>  arch/kvx/mm/Makefile             |  10 ++
>  arch/kvx/platform/Makefile       |   7 +
>  11 files changed, 639 insertions(+)
>  create mode 100644 arch/kvx/Kconfig
>  create mode 100644 arch/kvx/Kconfig.debug
>  create mode 100644 arch/kvx/Makefile
>  create mode 100644 arch/kvx/include/asm/Kbuild
>  create mode 100644 arch/kvx/include/uapi/asm/Kbuild
>  create mode 100644 arch/kvx/kernel/Makefile
>  create mode 100644 arch/kvx/kernel/kvx_ksyms.c
>  create mode 100644 arch/kvx/kernel/vmlinux.lds.S
>  create mode 100644 arch/kvx/lib/Makefile
>  create mode 100644 arch/kvx/mm/Makefile
>  create mode 100644 arch/kvx/platform/Makefile
> 
> diff --git a/arch/kvx/Kconfig b/arch/kvx/Kconfig
> new file mode 100644
> index 000000000000..8e8820c5c860
> --- /dev/null
> +++ b/arch/kvx/Kconfig
> @@ -0,0 +1,249 @@
> +#
> +# For a description of the syntax of this configuration file,
> +# see Documentation/kbuild/kconfig-language.txt.
> +#
> +
> +config 64BIT
> +	def_bool y
> +
> +config GENERIC_CALIBRATE_DELAY
> +	def_bool y
> +
> +config FIX_EARLYCON_MEM
> +	def_bool y
> +
> +config MMU
> +	def_bool y
> +
> +config KALLSYMS_BASE_RELATIVE
> +	def_bool n
> +
> +config GENERIC_CSUM
> +	def_bool y
> +
> +config RWSEM_GENERIC_SPINLOCK
> +	def_bool y
> +
> +config GENERIC_HWEIGHT
> +	def_bool y
> +
> +config ARCH_MMAP_RND_BITS_MAX
> +	default 24
> +

Do the above and below configs need an "int" line for their type?
I notice that the patch does that below for PGTABLE_LEVELS.

> +config ARCH_MMAP_RND_BITS_MIN
> +	default 18
> +
> +config STACKTRACE_SUPPORT
> +	def_bool y
> +
> +config LOCKDEP_SUPPORT
> +	def_bool y
> +
> +config GENERIC_BUG
> +	def_bool y
> +	depends on BUG
> +
> +config KVX_4K_PAGES
> +	def_bool y
> +
> +config KVX
> +	def_bool y
[deletes]
> +
> +config PGTABLE_LEVELS
> +	int
> +	default 3
^^^^^^^^^^^^^^^^^^^^^^^^

> +
> +config HAVE_KPROBES
> +	def_bool n
> +
> +menu "System setup"
> +
> +config POISON_INITMEM
> +	bool "Enable to poison freed initmem"
> +	default y
> +	help
> +	  In order to debug initmem, using poison allows to verify if
> +	  some data/code is stille using them. Enable this for debug

	                    still

> +	  purposes

	  purposes.

> +
> +config KVX_PHYS_OFFSET
> +	hex "RAM address of memory base"
> +	default 0x100000000
> +
> +config KVX_PAGE_OFFSET
> +	hex "kernel virtual address of memory base"
> +	default 0xFFFFFF8000000000
> +
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +
> +config ARCH_SPARSEMEM_ENABLE
> +	def_bool y
> +
> +config ARCH_SPARSEMEM_DEFAULT
> +	def_bool ARCH_SPARSEMEM_ENABLE
> +
> +config ARCH_SELECT_MEMORY_MODEL
> +	def_bool ARCH_SPARSEMEM_ENABLE
> +
> +config STACK_MAX_DEPTH_TO_PRINT
> +	int "Maximum depth of stack to print"
> +	range 1 128
> +	default "24"
> +
> +config L2_CACHE
> +	bool "Enable l2 cache driver"

	             L2

> +	default y
> +	help
> +	  Enable L2 cache driver in order to handle it. This driver can be
> +	  disabled to eliminate any overhead related to L2 cache
> +	  inval/writeback. Note that L2 cache is mandatory for SMP in order
> +	  to maintain coherency on DDR between all PEs.
> +
> +config SECURE_DAME_HANDLING
> +	bool "Secure DAME handling"
> +	default y
> +	help
> +	  In order to securely handle Data Asynchronous Memory Errors, we need
> +	  to do a barrier upon kernel entry when coming from userspace. This
> +	  barrier guarantee us that any pending DAME will be serviced right

	          guarantees

> +	  away. We also need to do a barrier when returning from kernel to user.
> +	  This way, if the kernel or the user triggered a DAME, it will be
> +	  serviced by knowing we are coming from kernel or user and avoid
> +	  pulling the wrong lever (panic for kernel or sigfault for user).
> +	  This can be costly but ensure that user cannot interfere with kernel.

	                         ensures

> +	  /!\ Do not disable unless you want to open a giant breach between
> +	  user and kernel /!\
> +
> +config CACHECTL_UNSAFE_PHYS_OPERATIONS
> +	bool "Enable cachectl syscall unsafe physical operations"
> +	default n
> +	help
> +	  Enable cachectl syscall to allow writebacking/invalidating ranges
> +	  based on physical addresses. These operations requires the
> +	  CAP_SYS_ADMIN capability

	                capability.

> +
> +config ENABLE_TCA
> +	bool "Enable TCA coprocessor support"
> +	default y
> +	help
> +	  This option enables TCA coprocessor support. It will allow the user to
> +	  use the coprocessor and save registers on context switch if used.
> +	  Registers content will also be cleared when switching.
> +
> +config SMP
> +	bool "Symmetric multi-processing support"
> +	default n
> +	select GENERIC_SMP_IDLE_THREAD
> +	select GENERIC_IRQ_IPI
> +	select IRQ_DOMAIN_HIERARCHY
> +	select IRQ_DOMAIN
> +	select L2_CACHE
> +	help
> +	  This enables support for systems with more than one CPU. If you have
> +	  a system with only one CPU, say N. If you have a system with more
> +	  than one CPU, say Y.
> +
> +	  If you say N here, the kernel will run on uni- and multiprocessor
> +	  machines, but will use only one CPU of a multiprocessor machine. If
> +	  you say Y here, the kernel will run on many, but not all,
> +	  uniprocessor machines. On a uniprocessor machine, the kernel
> +	  will run faster if you say N here.
> +
> +config NR_CPUS
> +	int "Maximum number of CPUs"
> +	range 1 16
> +	default "16"
> +	depends on SMP
> +	help
> +	  Kalray support can handle a maximum of 16 CPUs.
> +
> +config KVX_PAGE_SHIFT
> +	int
> +	default 12
> +
> +config CMDLINE
> +	string "Default kernel command string"
> +	default ""
> +	help
> +	  On some architectures there is currently no way for the boot loader
> +	  to pass arguments to the kernel. For these architectures, you should
> +	  supply some command-line options at build time by entering them
> +	  here.
> +
> +endmenu
> +
> +menu "Kernel Features"
> +source "kernel/Kconfig.hz"
> +endmenu
> diff --git a/arch/kvx/Kconfig.debug b/arch/kvx/Kconfig.debug
> new file mode 100644
> index 000000000000..027e919a1e14
> --- /dev/null
> +++ b/arch/kvx/Kconfig.debug
> @@ -0,0 +1,70 @@
> +menu "KVX debugging"
> +
> +config KVX_DEBUG_ASN
> +	bool "Check ASN before writing TLB entry"
> +	default n
> +	help
> +	  This option allows to check if the ASN of the current
> +	  process is matching the ASN found in MMC. If it is not the

	s/is matching/matches/

> +	  case an error will be printed.
> +
> +config KVX_DEBUG_TLB_WRITE
> +	bool "Enable TLBs write checks"
> +	default n
> +	help
> +	  Enabling this option will enable TLB access checks. This is
> +	  particularly helpful when modifying the assembly code responsible
> +	  of TLB refill. If set, mmc.e will be checked each time the tlb are

	  for TLB refill.                                            TLB

> +	  written and a panic will be thrown on error.
> +
> +config KVX_DEBUG_TLB_ACCESS
> +	bool "Enable TLBs accesses logging"
> +	default n
> +	help
> +	  Enabling this option will enable TLB entry manipulation logging.
> +	  Each time an entry will be added to the TLBs, it will be logged in

	                    s/will be/is/               s/will be/is/

> +	  an array readable via gdb scripts. This can be useful to understand
> +	  strange crashes related to suspicious virtual/physical addresses.
> +
> +config KVX_DEBUG_TLB_ACCESS_BITS
> +	int "Number of bits used as index of entries in log table"
> +	default 12
> +	depends on KVX_DEBUG_TLB_ACCESS
> +	help
> +	  Set the number of bits used as index of entries that will be logged
> +	  in a ring buffer called kvx_tlb_access. One entry in the table
> +	  contains registers TEL, TEH and MMC. It also logs the type of the
> +	  operations (0:read, 1:write, 2:probe). Buffer is per CPU. For one
> +	  entry 24 bytes are used. So by default it uses 96Ko of memory per

What does "Ko" mean?

> +	  CPU to store 2^12 (4096) entries.
> +
> +config KVX_MMU_STATS
> +	bool "Register mmu stats debugfs entries"

Preferably             MMU

> +	default n
> +	select DEBUG_FS

Preferably:
	depends on DEBUG_FS

> +	help
> +	  Enable debugfs attribute which will allow inspecting various metric

	                                                               metrics

> +	  regarding MMU:
> +	  - Number of nomapping traps handled
> +	  - avg/min/max time for nomapping refill (user/kernel)
> +
> +config DEBUG_EXCEPTION_STACK
> +	bool "Enable exception stack debugging"
> +	default n
> +	help
> +	  Enable stack check debugging when entering/exiting
> +	  exception handlers.
> +	  This can be particularly helpful after modifying stack
> +	  handling to see if stack when exiting is the same as the one
> +	  when entering exception handler.
> +
> +config DEBUG_SFR_SET_MASK
> +	bool "Enable sfr set_mask debugging"
> +	default n
> +	help
> +	  Verify that values written using kvx_sfr_set_mask are matching the

	  s/are matching/match/

> +	  mask. This ensure that no extra bits of sfr will be overridden by some

	             ensures

and preferably s/sfr/SFR/ in 2 places (not in kvx_sfr_set_mask).

> +	  incorrectly truncated values. This can lead to huge problems by
> +	  modifying important bits in system registers.
> +
> +endmenu


Thanks.

-- 
~Randy
