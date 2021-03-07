Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F22330169
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 14:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCGNvA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 08:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231469AbhCGNuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Mar 2021 08:50:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA67650F8;
        Sun,  7 Mar 2021 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615125022;
        bh=FpksQnLILT6XpFTu/cTIgkLUe5NKtHi/M1mXwPw8fnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPrrevRnBiUzecWltb2ncXqlWzqT1n0F6ubsqw2XrYIfp3Mcy6QcolUvqK0XabIvn
         een23bbtYbj4kYRms+6KRbm5mLrYBOkA7aQot3MaayEpiHmYSOaVK/TzWr1Y4R2SKv
         9T0unXqVSBXeSFonT38I4kDYsfo53xuQerTxY8qRGNdxrfOKz5EwG2amLL1xE9Z5nz
         +Wm4Ef1kTetJh89BiBhfDl78fQnxjqfWr7rpyQeSe/gga0xGufbPWgNR+p5mJ8Leq/
         M1zfYF2vLtMRKCD5uqQxasbOVTpuWubd2zbp/Lz74tp4hdbVqqAhmEi5wZqh9GGBT/
         kRjUVrQSJ8yQA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF22E40647; Sun,  7 Mar 2021 10:50:19 -0300 (-03)
Date:   Sun, 7 Mar 2021 10:50:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] btf: Add support for the floating-point types
Message-ID: <YETaG9CZbrzMNmbh@kernel.org>
References: <20210306022203.152930-1-iii@linux.ibm.com>
 <CAEf4BzYvawU4jTKwoUagY0Bn0SYNwcSohb-ZAPq_rLvF5qLamg@mail.gmail.com>
 <YETSLwfibXxelBIN@kernel.org>
 <YETYtWwSFVMDAnCA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YETYtWwSFVMDAnCA@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Mar 07, 2021 at 10:44:21AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Mar 07, 2021 at 10:16:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, Mar 06, 2021 at 07:16:08PM -0800, Andrii Nakryiko escreveu:
> > > On Fri, Mar 5, 2021 at 6:22 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > > >
> > > > Some BPF programs compiled on s390 fail to load, because s390
> > > > arch-specific linux headers contain float and double types.
> > > >
> > > > Fix as follows:
> > > >
> > > > - Make DWARF loader fill base_type.float_type.
> > > >
> > > > - libbpf introduced support for the floating-point types in commit
> > > >   986962fade5, so update the libbpf submodule to that version and use
> > > >   the new btf__add_float() function in order to emit the floating-point
> > > >   types when base_type.float_type is set.
> > > >
> > > > Example of the resulting entry in the vmlinux BTF:
> > > >
> > > >     [7164] FLOAT 'double' size=8
> 
> > > [PATCH dwarves] would make it a bit clearer that this is pahole patch.
> 
> > > But LGTM.
>  
> > So older versions of bpftool will fail with a .BTF section having this
> > new float? I thought it would just skip it emitting a warning? Probably
> > not possible as we don't have the record size encoded in a header,
> > right?
>  
> > [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT
> > [acme@five pahole]$ type pahole
> > pahole is /home/acme/bin/pahole
> > [acme@five pahole]$ ls -la ~/bin/pahole
> > lrwxrwxrwx. 1 acme acme 34 Jan 29 11:00 /home/acme/bin/pahole -> /home/acme/git/pahole/build/pahole
> > [acme@five pahole]$ pahole -J vmlinux
> > [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT | head
> > Error: failed to load BTF from vmlinux: Invalid argument
> > [acme@five pahole]$
> > 
> > Perhaps the warning emitted by bpftool should suggest updating the tool
> > as it found a record type it doesn't know about?
> > 
> > /me goes to update bpftool...
> 
> Works with the bpftool in bpf-next:
> 
> [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT | head
> [8006] FLOAT 'double' size=8
> [acme@five pahole]$

Applied, with this committer notes:

Committer testing:

  $ rm -rf build  # To update the libbpf git submodule
  $ mkdir build
  $ cd build
  $ cmake ..
  $ cd ..
  $ make -C build
  # No BTF_KIND_FLOAT before:
  $ bpftool btf dump file vmlinux | grep -w FLOAT
  $ type pahole
  pahole is /home/acme/bin/pahole
  $ ls -la ~/bin/pahole
  lrwxrwxrwx. 1 acme acme 34 Jan 29 11:00 /home/acme/bin/pahole -> /home/acme/git/pahole/build/pahole
  # Encode BTF:
  $ pahole -J vmlinux
  $ bpftool btf dump file vmlinux | grep -w FLOAT | head
  Error: failed to load BTF from vmlinux: Invalid argument
  $
  # Update bpftool to what is in bpf-next, then try again:
  $ bpftool btf dump file vmlinux | grep -w FLOAT
  [8006] FLOAT 'double' size=8
  $
  # Now check that pahole works well, i.e. that the BTF loader works
  $ pahole -F btf vmlinux -C sk_buff_head
  struct sk_buff_head {
        struct sk_buff *           next;                 /*     0     8 */
        struct sk_buff *           prev;                 /*     8     8 */
        __u32                      qlen;                 /*    16     4 */
        spinlock_t                 lock;                 /*    20     4 */

        /* size: 24, cachelines: 1, members: 4 */
        /* last cacheline: 24 bytes */
  };
  $
  $ pahole -F btf vmlinux  | wc -l
  122676
  $

Now will build a kernel with this new version, reboot, then push
publicly.

- Arnaldo
