Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12D34D62A
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhC2RkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 13:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhC2RkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 13:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FE3061879;
        Mon, 29 Mar 2021 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617039608;
        bh=hqDFN1PHX0lC8BFIQouXXkBsfm16cSBycETfzht6mIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCi8P6odho7l/LP8NExzMcmxCIJ0rhiONSsQSNXfyv4DhyG6He450C/0gsjq0jo1l
         KY9x24XCjaqJCH6OS/qhffY8fw0JCFcAy+XdCi6+S0EnrIA5s/M2ZYRpvK95rFdEYB
         aIQ2NwwN1Esz4+H2hih++3Vk4RxMT+OWg7kcIOh9XH+8ofou2UYJQBH0K1FbGn2jQq
         JfwfFX5NEN7HaPO1nP4TgxG1P7Cis+OZggxB3NrBypwBnZ6fZlxUdvYafNZgj79KCs
         CWaaX971FmBXMpOSPCgoxsIXtOboDa01NCgS0aDh4iPunxr2rS7gQ41crUr0f5HMSQ
         4P7/RNmevroKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C411640647; Mon, 29 Mar 2021 14:40:05 -0300 (-03)
Date:   Mon, 29 Mar 2021 14:40:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
Message-ID: <YGIQ9c3Qk+DMa+C7@kernel.org>
References: <20210328201400.1426437-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328201400.1426437-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Mar 28, 2021 at 01:14:00PM -0700, Yonghong Song escreveu:
> For vmlinux built with clang thin-lto or lto for latest bpf-next,
> there exist cross cu debuginfo type references. For example,
>       compile unit 1:
>          tag 10:  type A
>       compile unit 2:
>          ...
>            refer to type A (tag 10 in compile unit 1)
> I only checked a few but have seen type A may be a simple type
> like "unsigned char" or a complex type like an array of base types.
> I am using latest llvm trunk and bpf-next. I suspect llvm12 or
> linus tree >= 5.12 rc2 should be able to exhibit the issue as well.
> Both thin-lto and lto have the same issues.

Works, now we're again at:

[acme@five pahole]$ time btfdiff vmlinux
real	0m7.679s
user	0m7.337s
sys	0m0.303s
[acme@five pahole]$ time btfdiff vmlinux.clang.thin.LTO
--- /tmp/btfdiff.dwarf.Ls059V	2021-03-29 14:36:02.675859035 -0300
+++ /tmp/btfdiff.btf.rxRd6R	2021-03-29 14:36:02.935864663 -0300
@@ -67255,7 +67255,7 @@ struct cpu_rmap {
 	struct {
 		u16                index;                /*    16     2 */
 		u16                dist;                 /*    18     2 */
-	} near[0]; /*    16     0 */
+	} near[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 5 */
 	/* last cacheline: 16 bytes */
@@ -101181,7 +101181,7 @@ struct linux_efi_memreserve {
 	struct {
 		phys_addr_t        base;                 /*    16     8 */
 		phys_addr_t        size;                 /*    24     8 */
-	} entry[0]; /*    16     0 */
+	} entry[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* last cacheline: 16 bytes */
@@ -113516,7 +113516,7 @@ struct netlink_policy_dump_state {
 	struct {
 		const struct nla_policy  * policy;       /*    16     8 */
 		unsigned int       maxtype;              /*    24     4 */
-	} policies[0]; /*    16     0 */
+	} policies[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* sum members: 12, holes: 1, sum holes: 4 */

real	0m20.402s
user	0m19.163s
sys	0m1.096s
[acme@five pahole]$

And:

[acme@five pahole]$ ulimit -c 10000000
[acme@five pahole]$
[acme@five pahole]$ file tcp_bbr.o
tcp_bbr.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), with debug_info, not stripped
[acme@five pahole]$ readelf -wi tcp_bbr.o | grep DW_AT_producer
    <d>   DW_AT_producer    : (indirect string, offset: 0x4a97): GNU C89 10.2.1 20200723 (Red Hat 10.2.1-1) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu90 -p -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -fno-var-tracking-assignments -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fstack-check=no -fconserve-stack -fcf-protection=none
[acme@five pahole]$ fullcircle tcp_bbr.o
/home/acme/bin/fullcircle: line 38: 3969006 Segmentation fault      (core dumped) ${pfunct_bin} --compile $file > $c_output
/tmp/fullcircle.4XujnI.c:1435:2: error: unterminated comment
 1435 |  /* si
      |  ^
/tmp/fullcircle.4XujnI.c:1433:2: error: expected specifier-qualifier-list at end of input
 1433 |  u32 *                      saved_syn;            /*  2184     8 */
      |  ^~~
codiff: couldn't load debugging info from /tmp/fullcircle.ZOVXGv.o
/home/acme/bin/fullcircle: line 40: 3969019 Segmentation fault      (core dumped) ${codiff_bin} -q -s $file $o_output
[acme@five pahole]$

Both seem unrelated to what you've done here, I'm investigating it now.

- Arnaldo
