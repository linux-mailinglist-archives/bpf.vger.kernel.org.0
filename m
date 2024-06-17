Return-Path: <bpf+bounces-32331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B650490BBA3
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F156282E1C
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A2818FC93;
	Mon, 17 Jun 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnaXtYBl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6162E542;
	Mon, 17 Jun 2024 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654539; cv=none; b=o6ruptZyJjsNEhSfV3iwWJHNJh1Jx+fA0KmkAID2IvFNEaw/XiKNyjQObpK/fuwlqIBJcTbGgJD5/pLF6IOulz9qhSIHwWn/LgVH/zJM9tRG7ZOIUrb+ztC4naAJsj0sechWgWBrBqgBr1NFO8ybaiIjCPNLoxOfdMAlsbBSxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654539; c=relaxed/simple;
	bh=ZQg+C16vaQwAiz5ZMEu7M36+6IbshIe39DjBqK4jVDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPJD3LVCBE1IMyBICZ8WzANYY5yciFaKESCHd5bnCtWgwtD4Q4+Tc5rRKKa5CgQ+eEZrACZrUTkPV9qcxIed3dcyCCGRvuwAoYhY06MhmcJvtLO8bJPidUUJ6VaoKnW6QAcBnfJoshuDX4sqVeFZqy6oP2JS/wtXK2iFmizFQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnaXtYBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A4BC2BD10;
	Mon, 17 Jun 2024 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718654538;
	bh=ZQg+C16vaQwAiz5ZMEu7M36+6IbshIe39DjBqK4jVDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnaXtYBlodVw6zPhOSxlLyu9DsCQIshnGe835SlvRgLNYKeVP9ly+sArSHeS34cDo
	 0yiGSdfwLYrOhfoIhWRHenjLvteOR8y0RLT3325xVv8/hTm9Ei1oJoBc1zKttETkO6
	 MyNp0QM/d8+UYsucqiJCbtBJcuEI3sDMYOgA50tgg6rR3ikmq2Tt+mPvYQJ+w2s4RJ
	 p+T4xPsu8uOUsZv0SlD5bON9JPd6spJhREwZ+OvQNrJngsDGKHIzmtp68DGSVYtUtq
	 4rM9bowL6Hl5UyIBzb/JlCdGfxUZGMcMRtLuwT66FbG4++2fJpmX16yTk7xpMXVbsM
	 qvhpLPQXS2Gng==
Date: Mon, 17 Jun 2024 17:02:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>,
	llvm@lists.linux.dev
Subject: [PATCH/RFT] Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF
 kfuncs)
Message-ID: <ZnCWRMfRDMHqSxBb@x1>
References: <ZmjBHWw-Q5hKBiwA@x1>
 <20240613214019.GA1423015@thelio-3990X>
 <ZnCQ-Psf_WswMk1W@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnCQ-Psf_WswMk1W@x1>

On Mon, Jun 17, 2024 at 04:39:40PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 13, 2024 at 02:40:19PM -0700, Nathan Chancellor wrote:
> > On Tue, Jun 11, 2024 at 06:26:53PM -0300, Arnaldo Carvalho de Melo wrote:
> > > 	The v1.27 release of pahole and its friends is out, supporting
> > > parallel reproducible builds and encoding kernel kfuncs in BTF, allowing
> > > tools such as bpftrace to enumerate the available kfuncs and obtain its
> > > function signatures and return types.
> > 
> > After commit f632e75 ("dwarf_loader: Add the cu to the cus list early,
> > remove on LSK_DELETE"), I (and others[1]) notice a crash when running
> > pahole on modules built with Clang when CONFIG_LTO_CLANG is enabled:
> > 
> >   $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config
> > 
> >   $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN
> > 
> >   $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig vmlinux crypto/cast_common.ko
> >   make[3]: *** [scripts/Makefile.modfinal:59: crypto/cast_common.ko] Error 139
> > 
> > I've isolated this to the following commands using the files available
> > at [2] (these were built with LLVM 18 but I could reproduce it with LLVM
> > 17 and LLVM 19, so it appears to impact a number of versions):
> > 
> >   $ tar -tf clang-lto-pahole-1.27-crash.tar.zst
> >   clang-lto-pahole-1.27-crash/
> >   clang-lto-pahole-1.27-crash/cast_common.mod.o
> >   clang-lto-pahole-1.27-crash/module.lds
> >   clang-lto-pahole-1.27-crash/cast_common.o
> >   clang-lto-pahole-1.27-crash/cast_common.ko.bak
> >   clang-lto-pahole-1.27-crash/vmlinux
> >   clang-lto-pahole-1.27-crash/cast_common.ko
> > 
> >   $ tar -axf clang-lto-pahole-1.27-crash.tar.zst
> > 
> >   $ cd clang-lto-pahole-1.27-crash
> > 
> >   $ LLVM_OBJCOPY="llvm-objcopy" pahole-1.26 -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func --lang_exclude=rust --btf_base vmlinux cast_common.ko
> > 
> >   $ cp cast_common.ko{.bak,}
> > 
> >   $ LLVM_OBJCOPY="llvm-objcopy" pahole-1.27 -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func --lang_exclude=rust --btf_base vmlinux cast_common.ko
> >   fish: Job 1, '...' terminated by signal SIGSEGV (Address boundary error)
> > 
> > If there is any more information I can provide or patches I can test, I
> > am more than happy to do so.
> 
> I reproduced the problem by just running 'pahole cast_common.ko", so
> this isn't even related to the BTF parts, its about the DWARF loader,
> I'm on it, thanks for the detailed report and for providing the files.

One liner + explanation at the end, with it both DWARF and BTF loaders
work:

⬢[acme@toolbox clang-lto-pahole-1.27-crash]$ pahole -F btf -C task_struct cast_common.ko | tail
	/* XXX last struct has 1 hole, 1 bit hole */

	/* size: 11584, cachelines: 181, members: 265 */
	/* sum members: 11483, holes: 22, sum holes: 85 */
	/* sum bitfield members: 82 bits, bit holes: 2, sum bit holes: 46 bits */
	/* member types with holes: 4, total: 6, bit holes: 2, total: 2 */
	/* paddings: 6, sum paddings: 49 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 8 */
};

⬢[acme@toolbox clang-lto-pahole-1.27-crash]$ pahole -F dwarf -C task_struct cast_common.ko | tail
	/* XXX last struct has 1 hole, 1 bit hole */

	/* size: 11584, cachelines: 181, members: 265 */
	/* sum members: 11483, holes: 22, sum holes: 85 */
	/* sum bitfield members: 82 bits, bit holes: 2, sum bit holes: 46 bits */
	/* member types with holes: 4, total: 6, bit holes: 2, total: 2 */
	/* paddings: 6, sum paddings: 49 */
	/* forced alignments: 8, forced holes: 1, sum forced holes: 8 */
};

⬢[acme@toolbox clang-lto-pahole-1.27-crash]$

Also the BTF encoder (that uses the DWARF loader), etc.

⬢[acme@toolbox clang-lto-pahole-1.27-crash]$ pahole -j --btf_encode cast_common.ko
⬢[acme@toolbox clang-lto-pahole-1.27-crash]$ readelf -SW cast_common.ko | grep BTF
  [30] .BTF              PROGBITS        0000000000000000 0223c9 01172c 00      0   0  1
⬢[acme@toolbox clang-lto-pahole-1.27-crash]$ pahole -F btf cast_common.ko | wc -l
4302
⬢[acme@toolbox clang-lto-pahole-1.27-crash]$ set -o vi
⬢[acme@toolbox clang-lto-pahole-1.27-crash]$ pahole -F btf cast_common.ko | head
struct elf32_note {
	Elf32_Word                 n_namesz;             /*     0     4 */
	Elf32_Word                 n_descsz;             /*     4     4 */
	Elf32_Word                 n_type;               /*     8     4 */

	/* size: 12, cachelines: 1, members: 3 */
	/* last cacheline: 12 bytes */
};
struct module {
	enum module_state          state;                /*     0     4 */
⬢[acme@toolbox clang-lto-pahole-1.27-crash]$ pahole -F btf cast_common.ko | tail
	const char  *              mod_name;             /*    24     8 */
	const char  * *            class_names;          /*    32     8 */
	const int                  length;               /*    40     4 */
	const int                  base;                 /*    44     4 */
	enum class_map_type        map_type;             /*    48     4 */

	/* size: 56, cachelines: 1, members: 7 */
	/* padding: 4 */
	/* last cacheline: 56 bytes */
};
⬢[acme@toolbox clang-lto-pahole-1.27-crash]$

Can you try with the one liner below? We remove it from the cus list
unconditionally, and since we alloc space with zalloc/calloc in
cu__new() and missed initializing that list_head (cu->node) we ended up
hitting list_del with a zeroed 'struct list_head' :-\

I'll try and get this cast_common.ko checked into a test repo for pahole
so that this gets regression tested.

Please test this patch so that we see if this is the only problem and
your kernel build with clang completes successfully.

Thanks,

- Arnaldo

diff --git a/dwarves.c b/dwarves.c
index 1ec259f50dbd3778..823a01524a12bb37 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -739,6 +739,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 		cu->dfops	= NULL;
 		INIT_LIST_HEAD(&cu->tags);
 		INIT_LIST_HEAD(&cu->tool_list);
+		INIT_LIST_HEAD(&cu->node);
 
 		cu->addr_size = addr_size;
 		cu->extra_dbg_info = 0;

