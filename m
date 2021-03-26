Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2144B34AE67
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 19:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCZSTj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 14:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhCZSTg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 14:19:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 494EB619C2;
        Fri, 26 Mar 2021 18:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616782775;
        bh=oeW9SfXHPXBdl2mKOBwAhdT+DP0rRWWsvY2sjX24LB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZYs9lPJtphDK8kf+eJvW98TJLPdGptIToQt4iN/drm1BzoDulDmGi9bFzVbA9lvf
         noRnuAU1a/1V98XMFuUynwd7LFwuXN8Vh5LajMKfo6zy6fJkpR+C+Whnutr4kiOLYC
         g/Ep7p2O6XAQLXchLOpQ01ynfDtmAieGSSnNS7K9sjPCmg2H7poqliVex/A2dWW/Cz
         Khh1n2DKov5zQKSyQ9gKTJdtY/TjFpWTit4oBQIVE0K4Ymf3kQZeqm2EgNBoemZO0N
         xjDl9H9nvRzsIr5s6pF2AtU5L7FLkedsiHW6RtogxDCS+oRRiSgRbtQIYjpvd8Mshl
         ORAemZ+G+Tq1A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 067C640647; Fri, 26 Mar 2021 15:19:33 -0300 (-03)
Date:   Fri, 26 Mar 2021 15:19:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
Message-ID: <YF4ltLywXsM3YkSs@kernel.org>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com>
 <YF3ynAKXDCE0kDpp@kernel.org>
 <d618edb6-e4c0-a260-905f-e07720746594@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d618edb6-e4c0-a260-905f-e07720746594@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 26, 2021 at 08:18:07AM -0700, Yonghong Song escreveu:
> 
> 
> On 3/26/21 7:41 AM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 24, 2021 at 11:53:32PM -0700, Yonghong Song escreveu:
> > I'm also adding the man page patch below, now to build the kernel with
> > your bpf-next patch to test it.
 
> Thanks for adding man page and testing, let me know if you
> need any help!

So, this is also needed if the vmlinux was buit with LTO:

[acme@seventh pahole]$ git diff btfdiff
diff --git a/btfdiff b/btfdiff
index 4db703245e7d..440241de7c2e 100755
--- a/btfdiff
+++ b/btfdiff
@@ -18,6 +18,7 @@ dwarf_output=$(mktemp /tmp/btfdiff.dwarf.XXXXXX)
 pahole_bin=${PAHOLE-"pahole"}

 ${pahole_bin} -F dwarf \
+             --merge_cus \
              --flat_arrays \
              --suppress_aligned_attribute \
              --suppress_force_paddings \
[acme@seventh pahole]$

After that we're down tho this diff, which probably isn't related to the
patches being tested, but some difference in how clang encodes this in
DWARF and then how the BTF encoder does it, or perhaps some problem in
the dwarves_fprintf.c routine, I'll check:

[acme@seventh pahole]$ ./btfdiff vmlinux
--- /tmp/btfdiff.dwarf.ik3LN3	2021-03-26 15:08:05.833806712 -0300
+++ /tmp/btfdiff.btf.69SSZs	2021-03-26 15:08:06.124802727 -0300
@@ -67233,7 +67233,7 @@ struct cpu_rmap {
 	struct {
 		u16                index;                /*    16     2 */
 		u16                dist;                 /*    18     2 */
-	} near[0]; /*    16     0 */
+	} near[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 5 */
 	/* last cacheline: 16 bytes */
@@ -101159,7 +101159,7 @@ struct linux_efi_memreserve {
 	struct {
 		phys_addr_t        base;                 /*    16     8 */
 		phys_addr_t        size;                 /*    24     8 */
-	} entry[0]; /*    16     0 */
+	} entry[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* last cacheline: 16 bytes */
@@ -113494,7 +113494,7 @@ struct netlink_policy_dump_state {
 	struct {
 		const struct nla_policy  * policy;       /*    16     8 */
 		unsigned int       maxtype;              /*    24     4 */
-	} policies[0]; /*    16     0 */
+	} policies[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* sum members: 12, holes: 1, sum holes: 4 */
[acme@seventh pahole]$

But we need to find a way to discover if the costly --merge_cus need to
be used...

For the kernel its just a matter of looking if that CONFIG_ asking for
one of the CLANG LTO variants is present, but for pahole users wanting
to work with a LTO vmlinux this gets confusing as it crashes, perhaps I
need to count how many lookups fail, fix the segfaults and at the end
emit a warning...

OR we can look at...

[acme@five bpf]$ eu-readelf -winfo ../build/bpf_clang_thin_lto/vmlinux | grep -i producer -m1
           producer             (strp) "clang version 11.0.0 (Fedora 11.0.0-2.fc33)"
[acme@five bpf]$

oops, it seems a kernel built with clang doesn't come with the compiler
options used like when using gcc:

[acme@five bpf]$ eu-readelf -winfo ../build/v5.12.0-rc4+/vmlinux | grep -i producer -m2
           producer             (strp) "GNU AS 2.35"
           producer             (strp) "GNU C89 10.2.1 20201125 (Red Hat 10.2.1-9) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -gdwarf-4 -O2 -std=gnu90 -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -fcf-protection=none -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -fno-strict-overflow -fstack-check=no -fconserve-stack -fno-stack-protector"
[acme@five bpf]$

Humm, can't we automagically detect that we need to merge the CUs and do
it if needed?

Have to go AFK now, will try to think about it while driving Pedro from
school...

Did a last test, may be unrelated:

[acme@five pahole]$ fullcircle ./tcp_ipv4.o
/home/acme/bin/fullcircle: line 40: 984531 Segmentation fault      (core dumped) ${codiff_bin} -q -s $file $o_output
[acme@five pahole]$ pahole --help | grep merge
      --merge_cus            Merge all cus (except possible types_cu)
[acme@five pahole]$


- Arnaldo
