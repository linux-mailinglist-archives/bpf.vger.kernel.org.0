Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD03301DD
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 15:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCGOJn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 09:09:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhCGOJU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Mar 2021 09:09:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9F75650F5;
        Sun,  7 Mar 2021 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615126160;
        bh=1PCkBuPm3X0Kbi8l4VLu/H2Nm9RZCQsZWl+XSKXevkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hV79PAYgbLWw+ZhjFltPuUFwAElJZLDPJrMlczFpr9adf3suRlvWNQwrd4hmtSFqQ
         lwgC06hfDE4Zq0jMc2RkQ1nFKxmDcij0cNi//V1CKQxDCUVJzERZVlj+lPBMPnwHkB
         aT5n9B8a6Ypv/V6LI+APX/LCa4V2YOJ7PSFpRQC0o9iQs6JGdRzb77jWbuld3sh5bo
         +Thes4ylTfYGVs273G95xHS9sti+N1Llxv7rginrFuzl3gvShCIIP1d3U5hBbNl/QX
         jwyDiWBFGbZcBx58mO4r9vjL6eqjCRUuCFU+TIXNZp4aQl53HLjJuYDUt2cTauhTxw
         AfLf3/9Z7SR9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9988840647; Sun,  7 Mar 2021 11:09:16 -0300 (-03)
Date:   Sun, 7 Mar 2021 11:09:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] btf: Add support for the floating-point types
Message-ID: <YETejOpEPkaP3UU1@kernel.org>
References: <20210306022203.152930-1-iii@linux.ibm.com>
 <CAEf4BzYvawU4jTKwoUagY0Bn0SYNwcSohb-ZAPq_rLvF5qLamg@mail.gmail.com>
 <YETSLwfibXxelBIN@kernel.org>
 <YETYtWwSFVMDAnCA@kernel.org>
 <YETaG9CZbrzMNmbh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YETaG9CZbrzMNmbh@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding Jiri to the CC list.

Em Sun, Mar 07, 2021 at 10:50:19AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Mar 07, 2021 at 10:44:21AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sun, Mar 07, 2021 at 10:16:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Sat, Mar 06, 2021 at 07:16:08PM -0800, Andrii Nakryiko escreveu:
> > > > On Fri, Mar 5, 2021 at 6:22 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > > > >
> > > > > Some BPF programs compiled on s390 fail to load, because s390
> > > > > arch-specific linux headers contain float and double types.
> > > > >
> > > > > Fix as follows:
> > > > >
> > > > > - Make DWARF loader fill base_type.float_type.
> > > > >
> > > > > - libbpf introduced support for the floating-point types in commit
> > > > >   986962fade5, so update the libbpf submodule to that version and use
> > > > >   the new btf__add_float() function in order to emit the floating-point
> > > > >   types when base_type.float_type is set.
> > > > >
> > > > > Example of the resulting entry in the vmlinux BTF:
> > > > >
> > > > >     [7164] FLOAT 'double' size=8
> > 
> > > > [PATCH dwarves] would make it a bit clearer that this is pahole patch.
> > 
> > > > But LGTM.
> >  
> > > So older versions of bpftool will fail with a .BTF section having this
> > > new float? I thought it would just skip it emitting a warning? Probably
> > > not possible as we don't have the record size encoded in a header,
> > > right?
> >  
> > > [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT
> > > [acme@five pahole]$ type pahole
> > > pahole is /home/acme/bin/pahole
> > > [acme@five pahole]$ ls -la ~/bin/pahole
> > > lrwxrwxrwx. 1 acme acme 34 Jan 29 11:00 /home/acme/bin/pahole -> /home/acme/git/pahole/build/pahole
> > > [acme@five pahole]$ pahole -J vmlinux
> > > [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT | head
> > > Error: failed to load BTF from vmlinux: Invalid argument
> > > [acme@five pahole]$
> > > 
> > > Perhaps the warning emitted by bpftool should suggest updating the tool
> > > as it found a record type it doesn't know about?
> > > 
> > > /me goes to update bpftool...
> > 
> > Works with the bpftool in bpf-next:
> > 
> > [acme@five pahole]$ bpftool btf dump file vmlinux | grep -w FLOAT | head
> > [8006] FLOAT 'double' size=8
> > [acme@five pahole]$
> 
> Applied, with this committer notes:
> 
> Committer testing:
> 
>   $ rm -rf build  # To update the libbpf git submodule
>   $ mkdir build
>   $ cd build
>   $ cmake ..
>   $ cd ..
>   $ make -C build
>   # No BTF_KIND_FLOAT before:
>   $ bpftool btf dump file vmlinux | grep -w FLOAT
>   $ type pahole
>   pahole is /home/acme/bin/pahole
>   $ ls -la ~/bin/pahole
>   lrwxrwxrwx. 1 acme acme 34 Jan 29 11:00 /home/acme/bin/pahole -> /home/acme/git/pahole/build/pahole
>   # Encode BTF:
>   $ pahole -J vmlinux
>   $ bpftool btf dump file vmlinux | grep -w FLOAT | head
>   Error: failed to load BTF from vmlinux: Invalid argument
>   $
>   # Update bpftool to what is in bpf-next, then try again:
>   $ bpftool btf dump file vmlinux | grep -w FLOAT
>   [8006] FLOAT 'double' size=8
>   $
>   # Now check that pahole works well, i.e. that the BTF loader works
>   $ pahole -F btf vmlinux -C sk_buff_head
>   struct sk_buff_head {
>         struct sk_buff *           next;                 /*     0     8 */
>         struct sk_buff *           prev;                 /*     8     8 */
>         __u32                      qlen;                 /*    16     4 */
>         spinlock_t                 lock;                 /*    20     4 */
> 
>         /* size: 24, cachelines: 1, members: 4 */
>         /* last cacheline: 24 bytes */
>   };
>   $
>   $ pahole -F btf vmlinux  | wc -l
>   122676
>   $
> 
> Now will build a kernel with this new version, reboot, then push
> publicly.

So now trying to build v5.12-rc2 with pahole supporting BTF_KIND_FLOAT:

  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  BTFIDS  vmlinux
FAILED: load BTF from vmlinux: Invalid argument
make[1]: *** [/home/acme/git/linux/Makefile:1197: vmlinux] Error 255
make[1]: Leaving directory '/home/acme/git/build/v5.12.0-rc2'
make: *** [Makefile:215: __sub-make] Error 2
[acme@five linux]$

[acme@five linux]$ egrep BTF\|DWARF  ../build/v5.12.0-rc2/.config
CONFIG_VIDEO_SONY_BTF_MPX=m
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
[acme@five linux]$

Ideas?

- Arnaldo
