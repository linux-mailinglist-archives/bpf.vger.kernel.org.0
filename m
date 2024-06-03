Return-Path: <bpf+bounces-31202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A2E8D8598
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487B91C21AF5
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C21304BA;
	Mon,  3 Jun 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPFxzNCV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14B12F5A1;
	Mon,  3 Jun 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426603; cv=none; b=sdn/eQRP5mDzLxIZ4PmlJvkwHV1ctr9/6UIKiQ1DeVbkya/gElKbO6CRhUoOK2gzCKauU6OxWLKupNVr/TZDua4aXwOVELnxIXdIKBhklOsrPnJ96uWB5qEVH2yqeRni1r3JP5tG97LnvAqVCWXqCcfb4k1L6QGt3VrQGP995MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426603; c=relaxed/simple;
	bh=fPLUJUlGwF38wCqoBnKBmPkiZFf5zPi1v8G/WIUkZjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPi19WkvvmtSJUFj0i1ozyoQzOE8A+R/haNO8SSmNkf0GQP4PaJm+t2i14EKzdHGD4Ss5BlWOFzDES/9Am41tOsaU0YqYfDRluwKkTJg2LL1iYNOM9DeoyTQrarIW/9v5ZB554gzNucx7rDXATgwcGRUaMlkmAknjy/3DyhjRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPFxzNCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9EAC2BD10;
	Mon,  3 Jun 2024 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717426603;
	bh=fPLUJUlGwF38wCqoBnKBmPkiZFf5zPi1v8G/WIUkZjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPFxzNCV1N+28ga9JSAVcTTOcBQh1AHn0lDQ4efk1QRW1bRJ4tO1xr/jnfLTfa16E
	 UL3ZcxDWtwMYEIy1KgmIDfsEE+NE/spDGSejYlk4Ot9eiKtULym8CZvjMbA1uYAFja
	 fDgk0mq9jBpuryk1Pmwb5/XyLSgXlxXKkMC+PS5YwFPuFBpKUMLy4sQJEViWqzVjJW
	 tMoYDzFEaafPiVWprT0rc3KQhGm7MRvdOjqBQYpvjB5SuZtw2uVk5BeN2cLkH9Su4i
	 PXNW15Z+Il8BSv5SBdZFI0ETwM6Uz/0ftzwvfZqA2s3Dr/M8W5fTQbls7mXKtCwT6i
	 KKqsZWwLkpC5g==
Date: Mon, 3 Jun 2024 11:56:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <Zl3Zp5r9m6X_i_J4@x1>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
 <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>

On Mon, Jun 03, 2024 at 04:20:01AM -0700, Tony Ambardar wrote:
> On Fri, May 31, 2024 at 01:06:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, May 31, 2024 at 03:49:38AM -0700, Tony Ambardar wrote:
> > > On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> > > > On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > > > > For some time now I'm seeing multiple issues during BTF generation while
> > > > > building recent kernels targeting mips64el, and would appreciate some help
> > > > > to understand and fix the problems.

> > > > SNIP

> > > > > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > > > > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > > > > >   CC [M]  net/psample/psample.mod.o
> > > > > >   LD [M]  crypto/cmac.ko
> > > > > >   BTF [M] crypto/cmac.ko
> > > > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > > > > or DW_TAG_skeleton_unit expected got member (0xd)!

> > Can you check the kernel CONFIG_ variables related to DEBUG information
> > and post them here? I have this on fedora:

> > [acme@nine linux]$ grep CONFIG_DEBUG_INFO /boot/config-5.14.0-362.18.1.el9_3.x86_64 
> > CONFIG_DEBUG_INFO=y
> > # CONFIG_DEBUG_INFO_REDUCED is not set
> > # CONFIG_DEBUG_INFO_COMPRESSED is not set
> > # CONFIG_DEBUG_INFO_SPLIT is not set
> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_DEBUG_INFO_DWARF5 is not set
> > CONFIG_DEBUG_INFO_BTF=y
> > CONFIG_DEBUG_INFO_BTF_MODULES=y
> > [acme@nine linux]$

> > If you have CONFIG_DEBUG_INFO_SPLIT, CONFIG_DEBUG_INFO_COMPRESSED or
> > CONFIG_DEBUG_INFO_REDUCED set to 'y', please try with the values in the
> > fedora config.

> One more useful observation: the pahole BTF generation problems appear only
> for mips64. If I build the same config for mips32be I see none of those
> "die__process: errors" from pahole and the processed modules load properly.

> I also tried running pahole under gdb to look further, but lack knowledge
> of pahole and libdw internals, so couldn't narrow things down to a pahole,
> elfutils or compiler-output problem.
> 
> To help troubleshoot further, I packaged my base vmlinux, some module .ko
> files showing problems, and a reproducer script. I've uploaded the tarball
> here:
> 
> https://www.dropbox.com/scl/fi/3ce22fi2q861wqvbq9mwy/repro_die__process.tar.xz?rlkey=ev494phabmfl5qe55xrn1jh3t&st=vrp5mxhh&dl=0

So, with that vmlinux, on a Fedora 39 x86_64 notebook:

⬢[acme@toolbox repro_die__process]$ readelf -wi vmlinux | head -45
Contents of the .debug_info section:

  Compilation Unit @ offset 0:
   Length:        0x3f (32-bit)
   Version:       4
   Abbrev Offset: 0
   Pointer Size:  8
 <0><b>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <c>   DW_AT_stmt_list   : 0
    <10>   DW_AT_ranges      : 0
    <14>   DW_AT_name        : (indirect string, offset: 0): arch/mips/kernel/head.S
    <18>   DW_AT_comp_dir    : (indirect string, offset: 0x18): /home/kodidev/linux
    <1c>   DW_AT_producer    : (indirect string, offset: 0x2c): GNU AS 2.42
    <20>   DW_AT_language    : 32769	(MIPS assembler)
 <1><22>: Abbrev Number: 2 (DW_TAG_subprogram)
    <23>   DW_AT_name        : (indirect string, offset: 0x38): kernel_entry
    <27>   DW_AT_external    : 1
    <27>   DW_AT_type        : <0x41>
    <28>   DW_AT_low_pc      : 0xffffffff80b0ce68
    <30>   DW_AT_high_pc     : 172
 <1><32>: Abbrev Number: 2 (DW_TAG_subprogram)
    <33>   DW_AT_name        : (indirect string, offset: 0x45): smp_bootstrap
    <37>   DW_AT_external    : 1
    <37>   DW_AT_type        : <0x41>
    <38>   DW_AT_low_pc      : 0xffffffff80b0cf14
    <40>   DW_AT_high_pc     : 44
 <1><41>: Abbrev Number: 3 (DW_TAG_unspecified_type)
 <1><42>: Abbrev Number: 0
  Compilation Unit @ offset 0x43:
   Length:        0x22ed9 (32-bit)
   Version:       4
   Abbrev Offset: 0x26
   Pointer Size:  8
 <0><4e>: Abbrev Number: 192 (DW_TAG_compile_unit)
    <50>   DW_AT_producer    : (indirect string, offset: 0x8147): GNU C11 13.3.0 -G 0 -mel -mno-check-zero-division -mabi=64 -mno-abicalls -msoft-float -march=mips64r2 -msym32 -mllsc -mips64r2 -mno-shared -g -gdwarf-4 -O2 -std=gnu11 -p -fshort-wchar -funsigned-char -fno-common -fno-strict-aliasing -fno-pic -ffreestanding -fstack-check=no -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector -fno-stack-clash-protection -fstrict-flex-arrays=3 -fno-strict-overflow -fstack-check=no -fconserve-stack -ffunction-sections -fdata-sections
    <54>   DW_AT_language    : 12	(ANSI C99)
    <55>   DW_AT_name        : (indirect string, offset: 0xce66): init/main.c
    <59>   DW_AT_comp_dir    : (indirect string, offset: 0x18): /home/kodidev/linux
    <5d>   DW_AT_ranges      : 0x1350
    <61>   DW_AT_low_pc      : 0
    <69>   DW_AT_stmt_list   : 0x80
 <1><6d>: Abbrev Number: 91 (DW_TAG_base_type)
    <6e>   DW_AT_byte_size   : 8
    <6f>   DW_AT_encoding    : 7	(unsigned)
    <70>   DW_AT_name        : (indirect string, offset: 0xb1c7): long unsigned int
⬢[acme@toolbox repro_die__process]$

⬢[acme@toolbox repro_die__process]$ time pahole -F dwarf vmlinux | wc -l
84377

real	0m10.992s
user	0m9.526s
sys	0m1.445s
⬢[acme@toolbox repro_die__process]$

No warnings, 84377 lines of types printed from DWARF that file, which is
comparable to the BTF in it:

⬢[acme@toolbox repro_die__process]$ time pahole -F btf vmlinux | wc -l
83994

real	0m0.121s
user	0m0.095s
sys	0m0.031s
⬢[acme@toolbox repro_die__process]$

There are a few diffs from types generated from DWARF to those generated
from BTF (unexpected ones, that is) as noticed by btfdiff (found in the
pahole git repo), that its just some print ordering issue:

⬢[acme@toolbox repro_die__process]$ btfdiff vmlinux 
--- /tmp/btfdiff.dwarf.oX71hp	2024-06-03 11:42:32.228618100 -0300
+++ /tmp/btfdiff.btf.u762WM	2024-06-03 11:42:18.042748246 -0300
@@ -10027,6 +10027,24 @@ struct bio_map_data {
 };
 struct bio_post_read_ctx {
 	struct bio *               bio;                                                  /*     0     8 */
+	struct work_struct {
+		/* typedef atomic_long_t -> atomic64_t */ struct {
+			/* typedef s64 -> __s64 */ long long int counter;                /*     8     8 */
+		} data; /*     8     8 */
+		struct list_head {
+			struct list_head * next;                                         /*    16     8 */
+			struct list_head * prev;                                         /*    24     8 */
+		} entry; /*    16    16 */
+		/* typedef work_func_t */ void               (*func)(struct work_struct *); /*    32     8 */
+	} work; /*     8    32 */
+	unsigned int               cur_step;                                             /*    40     4 */
+	unsigned int               enabled_steps;                                        /*    44     4 */
+
+	/* size: 48, cachelines: 1, members: 4 */
+	/* last cacheline: 48 bytes */
+};
+struct bio_post_read_ctx {
+	struct bio *               bio;                                                  /*     0     8 */
 	struct f2fs_sb_info *      sbi;                                                  /*     8     8 */
 	struct work_struct {
 		/* typedef atomic_long_t -> atomic64_t */ struct {
@@ -10049,24 +10067,6 @@ struct bio_post_read_ctx {
 	/* sum members: 57, holes: 1, sum holes: 3 */
 	/* padding: 4 */
 };
-struct bio_post_read_ctx {
-	struct bio *               bio;                                                  /*     0     8 */
-	struct work_struct {
-		/* typedef atomic_long_t -> atomic64_t */ struct {
-			/* typedef s64 -> __s64 */ long long int counter;                /*     8     8 */
-		} data; /*     8     8 */
-		struct list_head {
-			struct list_head * next;                                         /*    16     8 */
-			struct list_head * prev;                                         /*    24     8 */
-		} entry; /*    16    16 */
-		/* typedef work_func_t */ void               (*func)(struct work_struct *); /*    32     8 */
-	} work; /*     8    32 */
-	unsigned int               cur_step;                                             /*    40     4 */
-	unsigned int               enabled_steps;                                        /*    44     4 */
-
-	/* size: 48, cachelines: 1, members: 4 */
-	/* last cacheline: 48 bytes */
-};
 struct bio_set {
 	struct kmem_cache *        bio_slab;                                             /*     0     8 */
 	unsigned int               front_pad;                                            /*     8     4 */
@@ -43044,6 +43044,17 @@ struct dma_block {
 	/* last cacheline: 16 bytes */
 };
 struct dma_chan {
+	int                        lock;                                                 /*     0     4 */
+
+	/* XXX 4 bytes hole, try to pack */
+
+	const char  *              device_id;                                            /*     8     8 */
+
+	/* size: 16, cachelines: 1, members: 2 */
+	/* sum members: 12, holes: 1, sum holes: 4 */
+	/* last cacheline: 16 bytes */
+};
+struct dma_chan {
 	struct dma_device *        device;                                               /*     0     8 */
 	struct device *            slave;                                                /*     8     8 */
 	/* typedef dma_cookie_t -> s32 -> __s32 */ int                        cookie;    /*    16     4 */
@@ -43071,17 +43082,6 @@ struct dma_chan {
 	/* sum members: 108, holes: 1, sum holes: 4 */
 	/* last cacheline: 48 bytes */
 };
-struct dma_chan {
-	int                        lock;                                                 /*     0     4 */
-
-	/* XXX 4 bytes hole, try to pack */
-
-	const char  *              device_id;                                            /*     8     8 */
-
-	/* size: 16, cachelines: 1, members: 2 */
-	/* sum members: 12, holes: 1, sum holes: 4 */
-	/* last cacheline: 16 bytes */
-};
 struct dma_chan_dev {
 	struct dma_chan *          chan;                                                 /*     0     8 */
 	struct device {
@@ -125786,12 +125786,11 @@ struct perf_aux_event {
 		/* typedef __u16 */ short unsigned int misc;                             /*     4     2 */
 		/* typedef __u16 */ short unsigned int size;                             /*     6     2 */
 	} header; /*     0     8 */
-	/* typedef u64 -> __u64 */ long long unsigned int     offset;                    /*     8     8 */
-	/* typedef u64 -> __u64 */ long long unsigned int     size;                      /*    16     8 */
-	/* typedef u64 -> __u64 */ long long unsigned int     flags;                     /*    24     8 */
+	/* typedef u32 -> __u32 */ unsigned int               pid;                       /*     8     4 */
+	/* typedef u32 -> __u32 */ unsigned int               tid;                       /*    12     4 */
 
-	/* size: 32, cachelines: 1, members: 4 */
-	/* last cacheline: 32 bytes */
+	/* size: 16, cachelines: 1, members: 3 */
+	/* last cacheline: 16 bytes */
 };
 struct perf_aux_event {
 	struct perf_event_header {
@@ -125799,11 +125798,12 @@ struct perf_aux_event {
 		/* typedef __u16 */ short unsigned int misc;                             /*     4     2 */
 		/* typedef __u16 */ short unsigned int size;                             /*     6     2 */
 	} header; /*     0     8 */
-	/* typedef u32 -> __u32 */ unsigned int               pid;                       /*     8     4 */
-	/* typedef u32 -> __u32 */ unsigned int               tid;                       /*    12     4 */
+	/* typedef u64 -> __u64 */ long long unsigned int     offset;                    /*     8     8 */
+	/* typedef u64 -> __u64 */ long long unsigned int     size;                      /*    16     8 */
+	/* typedef u64 -> __u64 */ long long unsigned int     flags;                     /*    24     8 */
 
-	/* size: 16, cachelines: 1, members: 3 */
-	/* last cacheline: 16 bytes */
+	/* size: 32, cachelines: 1, members: 4 */
+	/* last cacheline: 32 bytes */
 };
 struct perf_bpf_event {
 	struct bpf_prog *          prog;                                                 /*     0     8 */
@@ -163037,10 +163037,11 @@ struct syscall_tp_t {
 
 	/* XXX 4 bytes hole, try to pack */
 
-	long unsigned int          args[6];                                              /*    16    48 */
+	long unsigned int          ret;                                                  /*    16     8 */
 
-	/* size: 64, cachelines: 1, members: 3 */
-	/* sum members: 60, holes: 1, sum holes: 4 */
+	/* size: 24, cachelines: 1, members: 3 */
+	/* sum members: 20, holes: 1, sum holes: 4 */
+	/* last cacheline: 24 bytes */
 };
 struct syscall_tp_t {
 	struct trace_entry {
@@ -163053,11 +163054,10 @@ struct syscall_tp_t {
 
 	/* XXX 4 bytes hole, try to pack */
 
-	long unsigned int          ret;                                                  /*    16     8 */
+	long unsigned int          args[6];                                              /*    16    48 */
 
-	/* size: 24, cachelines: 1, members: 3 */
-	/* sum members: 20, holes: 1, sum holes: 4 */
-	/* last cacheline: 24 bytes */
+	/* size: 64, cachelines: 1, members: 3 */
+	/* sum members: 60, holes: 1, sum holes: 4 */
 };
 struct syscall_trace_enter {
 	struct trace_entry {
⬢[acme@toolbox repro_die__process]$ 

But if we do it manually and without expanding types as btfdiff does:

⬢[acme@toolbox repro_die__process]$ pahole -F btf -C dma_chan vmlinux 
struct dma_chan {
	struct dma_device *        device;               /*     0     8 */
	struct device *            slave;                /*     8     8 */
	dma_cookie_t               cookie;               /*    16     4 */
	dma_cookie_t               completed_cookie;     /*    20     4 */
	int                        chan_id;              /*    24     4 */

	/* XXX 4 bytes hole, try to pack */

	struct dma_chan_dev *      dev;                  /*    32     8 */
	const char  *              name;                 /*    40     8 */
	char *                     dbg_client_name;      /*    48     8 */
	struct list_head           device_node;          /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	struct dma_chan_percpu *   local;                /*    72     8 */
	int                        client_count;         /*    80     4 */
	int                        table_count;          /*    84     4 */
	struct dma_router *        router;               /*    88     8 */
	void *                     route_data;           /*    96     8 */
	void *                     private;              /*   104     8 */

	/* size: 112, cachelines: 2, members: 15 */
	/* sum members: 108, holes: 1, sum holes: 4 */
	/* last cacheline: 48 bytes */
};

⬢[acme@toolbox repro_die__process]$ pahole -F dwarf -C dma_chan vmlinux 
struct dma_chan {
	int                        lock;                 /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	const char  *              device_id;            /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* sum members: 12, holes: 1, sum holes: 4 */
	/* last cacheline: 16 bytes */
};

⬢[acme@toolbox repro_die__process]$

⬢[acme@toolbox perf-tools]$ git grep 'struct dma_chan {'
arch/mips/include/asm/mach-au1x00/au1000_dma.h:struct dma_chan {
include/linux/dmaengine.h:struct dma_chan {
kernel/dma.c:struct dma_chan {
⬢[acme@toolbox perf-tools]$

So we have this 'struct dma_chan' in the common kernel in include/linux/dmaengine.h

struct dma_chan {
        struct dma_device *device;
        struct device *slave;
        dma_cookie_t cookie;
        dma_cookie_t completed_cookie;

        /* sysfs */
        int chan_id;
        struct dma_chan_dev *dev;
        const char *name;       
#ifdef CONFIG_DEBUG_FS
        char *dbg_client_name;
#endif

        struct list_head device_node;
        struct dma_chan_percpu __percpu *local;
        int client_count;       
        int table_count;

        /* DMA router */
        struct dma_router *router;
        void *route_data;

        void *private;
};


And also this one in kernel/dma.c

struct dma_chan {
        int  lock;
        const char *device_id;
};

If we don't specify the name but grep for it:

⬢[acme@toolbox repro_die__process]$ pahole -F btf vmlinux | grep 'struct dma_chan {' -A5
struct dma_chan {
	struct dma_device *        device;               /*     0     8 */
	struct device *            slave;                /*     8     8 */
	dma_cookie_t               cookie;               /*    16     4 */
	dma_cookie_t               completed_cookie;     /*    20     4 */
	int                        chan_id;              /*    24     4 */
--
struct dma_chan {
	int                        lock;                 /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	const char  *              device_id;            /*     8     8 */
⬢[acme@toolbox repro_die__process]$ pahole -F dwarf vmlinux | grep 'struct dma_chan {' -A5
struct dma_chan {
	int                        lock;                 /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	const char  *              device_id;            /*     8     8 */

--
struct dma_chan {
	struct dma_device *        device;               /*     0     8 */
	struct device *            slave;                /*     8     8 */
	dma_cookie_t               cookie;               /*    16     4 */
	dma_cookie_t               completed_cookie;     /*    20     4 */
	int                        chan_id;              /*    24     4 */
⬢[acme@toolbox repro_die__process]$

So the vmlinux seems to have its BTF section successfully generated,
lemme check the .ko files.

- Arnaldo

