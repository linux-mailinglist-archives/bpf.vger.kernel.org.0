Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC03AA18B
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhFPQmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 12:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhFPQmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 12:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 370DD6135C;
        Wed, 16 Jun 2021 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861606;
        bh=+RKRMI2AMVJmwWo3deYOMu1QBhy7+9oLoKiiex0J9EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwYe3j/eY3ADIwEaY8B/bFEqS3xPeEy9bjoi7E1x/xMETUjDDs//KgznXBAtMMFQB
         ZF3z6Dcs3RLY24FckZnFi89WdD8nOHN8K8c/7YKgxaFMcETowrYgZUFxiWbnGy3y7a
         draQfZqk0EagtLRrTBQDAOD6iUY6w6nLbh3MAlOtBHJcj6h6wYpL2iGpn7QTk8K2UG
         71qdkBo9qevycZnar5/ETo+XzPUn9gmNfx7G8t+aCA8oRkJKjMPl6Qy5rwsv/REXec
         dzXnxG0PBa/O25rrxr5Wd4kXoUi+Qb3dN0zgxmwAg8uq5UFLs3x3+Pfvnx/Rrc9j5c
         6adRwwvDzt15g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4782540B1A; Wed, 16 Jun 2021 13:40:03 -0300 (-03)
Date:   Wed, 16 Jun 2021 13:40:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, siudin@fb.com
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
Message-ID: <YMopYxHgmoNVd3Yl@kernel.org>
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMoRBvTdD0qzjYf4@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 16, 2021 at 11:56:06AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jun 15, 2021 at 04:30:03PM -0700, Andrii Nakryiko escreveu:
> > Hey Arnaldo,
> > 
> > Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu()
> > by moving function encoding to separate method") break two selftests
> > in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
> > because both tests rely on kernel BTF info.
> > 
> > You've previously asked about staging pahole changes. Did you make up
> > your mind about branch names and the process overall? Seems like a
> > good chance to bring this up ;-P
> > 
> >   [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152
> 
> Ok, please add tmp.master as the staging branch, I'll move things to
> master only after it passing thru CI.
> 
> Now looking at that code, must be something subtle...

Running selftests I'm getting a failure at:

  GEN-SKEL [test_progs] bpf_cubic.skel.h
libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
Error: failed to open BPF object file: No such file or directory
make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 255
make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h'
make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
[acme@seventh linux]$


I'll try to reproduce what you reported, i.e. revert that patch, and
rebuild the kernel.



[acme@seventh linux]$ uname -a
Linux seventh 5.13.0-rc6+ #1 SMP Wed Jun 16 11:59:35 -03 2021 x86_64 x86_64 x86_64 GNU/Linux

[acme@seventh linux]$ sudo make -C tools/testing/selftests/bpf/
make: Entering directory '/mnt/linux/tools/testing/selftests/bpf'
  MKDIR    include
  MKDIR    libbpf
  HOSTCC  /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/fixdep.o
  HOSTLD  /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/fixdep-in.o
  LINK    /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/fixdep
  GEN     /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/bpf_helper_defs.h
  MKDIR   /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/nlattr.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_errno.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/str_error.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/netlink.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf_probes.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/xsk.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/hashmap.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/btf_dump.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/ringbuf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/strset.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/linker.o
  LD      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/staticobjs/libbpf-in.o
  LINK    /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differs from latest version at 'include/uapi/linux/netlink.h'
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'
  MKDIR   /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/nlattr.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_errno.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/str_error.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/netlink.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/bpf_prog_linfo.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf_probes.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/xsk.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/hashmap.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/btf_dump.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/ringbuf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/strset.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/linker.o
  LD      /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf-in.o
  LINK    /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.so.0.4.0
  GEN     /mnt/linux/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.pc
  INSTALL headers
  CC       test_stub.o
  BINARY   test_verifier
  BINARY   test_tag
  MKDIR    bpftool

Auto-detecting system features:
...                        libbfd: [ on  ]
...        disassembler-four-args: [ on  ]
...                          zlib: [ on  ]
...                        libcap: [ on  ]
...               clang-bpf-co-re: [ on  ]


  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/btf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/cfg.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/cgroup.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/common.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/feature.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/gen.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/iter.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/json_writer.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/link.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/main.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/map.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/map_perf_ring.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/net.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/netlink_dumper.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/perf.o
  MKDIR   /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/main.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/common.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/json_writer.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/gen.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/btf.o
  MKDIR   /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/
  GEN     /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/bpf_helper_defs.h
  MKDIR   /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/bpf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/nlattr.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/btf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/str_error.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/netlink.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/xsk.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/hashmap.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/btf_dump.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/ringbuf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/strset.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/linker.o
  LD      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK    /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/libbpf/libbpf.a
  LINK    /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//bootstrap/bpftool
  GEN     /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
  MKDIR   /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/
  GEN     /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/bpf_helper_defs.h
  MKDIR   /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/bpf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/nlattr.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/btf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf_errno.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/str_error.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/netlink.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/bpf_prog_linfo.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf_probes.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/xsk.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/hashmap.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/btf_dump.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/ringbuf.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/strset.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/linker.o
  LD      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/staticobjs/libbpf-in.o
  LINK    /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool//libbpf/libbpf.a
  CLANG   /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/pid_iter.bpf.o
  GEN     /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/pid_iter.skel.h
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/pids.o
  CLANG   /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/profiler.bpf.o
  GEN     /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/profiler.skel.h
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/prog.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/struct_ops.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/tracelog.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/jit_disasm.o
  CC      /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/disasm.o
  LINK    /mnt/linux/tools/testing/selftests/bpf/tools/build/bpftool/bpftool
  INSTALL bpftool
  GEN      vmlinux.h
  CLNG-BPF [test_maps] atomic_bounds.o
  CLNG-BPF [test_maps] atomics.o
  CLNG-BPF [test_maps] bind4_prog.o
  CLNG-BPF [test_maps] bind6_prog.o
  CLNG-BPF [test_maps] bind_perm.o
  CLNG-BPF [test_maps] bpf_cubic.o
  CLNG-BPF [test_maps] bpf_dctcp.o
  CLNG-BPF [test_maps] bpf_flow.o
  CLNG-BPF [test_maps] bpf_iter_bpf_array_map.o
  CLNG-BPF [test_maps] bpf_iter_bpf_hash_map.o
  CLNG-BPF [test_maps] bpf_iter_bpf_map.o
  CLNG-BPF [test_maps] bpf_iter_bpf_percpu_array_map.o
  CLNG-BPF [test_maps] bpf_iter_bpf_percpu_hash_map.o
  CLNG-BPF [test_maps] bpf_iter_bpf_sk_storage_helpers.o
  CLNG-BPF [test_maps] bpf_iter_bpf_sk_storage_map.o
  CLNG-BPF [test_maps] bpf_iter_ipv6_route.o
  CLNG-BPF [test_maps] bpf_iter_netlink.o
  CLNG-BPF [test_maps] bpf_iter_sockmap.o
  CLNG-BPF [test_maps] bpf_iter_task_btf.o
  CLNG-BPF [test_maps] bpf_iter_task.o
  CLNG-BPF [test_maps] bpf_iter_task_file.o
  CLNG-BPF [test_maps] bpf_iter_task_stack.o
  CLNG-BPF [test_maps] bpf_iter_task_vma.o
  CLNG-BPF [test_maps] bpf_iter_tcp4.o
  CLNG-BPF [test_maps] bpf_iter_tcp6.o
  CLNG-BPF [test_maps] bpf_iter_test_kern1.o
  CLNG-BPF [test_maps] bpf_iter_test_kern2.o
  CLNG-BPF [test_maps] bpf_iter_test_kern3.o
  CLNG-BPF [test_maps] bpf_iter_test_kern4.o
  CLNG-BPF [test_maps] bpf_iter_test_kern5.o
  CLNG-BPF [test_maps] bpf_iter_test_kern6.o
  CLNG-BPF [test_maps] bpf_iter_udp4.o
  CLNG-BPF [test_maps] bpf_iter_udp6.o
  CLNG-BPF [test_maps] bpf_tcp_nogpl.o
  CLNG-BPF [test_maps] bprm_opts.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___diff_arr_dim.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___diff_arr_val_sz.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___equiv_zero_sz_arr.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___err_bad_zero_sz_arr.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___err_non_array.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___err_too_shallow.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___err_too_small.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___err_wrong_val_type.o
  CLNG-BPF [test_maps] btf__core_reloc_arrays___fixed_arr.o
  CLNG-BPF [test_maps] btf__core_reloc_bitfields___bitfield_vs_int.o
  CLNG-BPF [test_maps] btf__core_reloc_bitfields___bit_sz_change.o
  CLNG-BPF [test_maps] btf__core_reloc_bitfields.o
  CLNG-BPF [test_maps] btf__core_reloc_bitfields___err_too_big_bitfield.o
  CLNG-BPF [test_maps] btf__core_reloc_bitfields___just_big_enough.o
  CLNG-BPF [test_maps] btf__core_reloc_enumval.o
  CLNG-BPF [test_maps] btf__core_reloc_enumval___diff.o
  CLNG-BPF [test_maps] btf__core_reloc_enumval___err_missing.o
  CLNG-BPF [test_maps] btf__core_reloc_enumval___val3_missing.o
  CLNG-BPF [test_maps] btf__core_reloc_existence.o
  CLNG-BPF [test_maps] btf__core_reloc_existence___minimal.o
  CLNG-BPF [test_maps] btf__core_reloc_existence___wrong_field_defs.o
  CLNG-BPF [test_maps] btf__core_reloc_flavors.o
  CLNG-BPF [test_maps] btf__core_reloc_flavors__err_wrong_name.o
  CLNG-BPF [test_maps] btf__core_reloc_ints___bool.o
  CLNG-BPF [test_maps] btf__core_reloc_ints.o
  CLNG-BPF [test_maps] btf__core_reloc_ints___reverse_sign.o
  CLNG-BPF [test_maps] btf__core_reloc_misc.o
  CLNG-BPF [test_maps] btf__core_reloc_mods.o
  CLNG-BPF [test_maps] btf__core_reloc_mods___mod_swap.o
  CLNG-BPF [test_maps] btf__core_reloc_mods___typedefs.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___anon_embed.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___dup_compat_types.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___err_array_container.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___err_array_field.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___err_dup_incompat_types.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___err_missing_container.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___err_missing_field.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___err_nonstruct_container.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___err_partial_match_dups.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___err_too_deep.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___extra_nesting.o
  CLNG-BPF [test_maps] btf__core_reloc_nesting___struct_union_mixup.o
  CLNG-BPF [test_maps] btf__core_reloc_primitives.o
  CLNG-BPF [test_maps] btf__core_reloc_primitives___diff_enum_def.o
  CLNG-BPF [test_maps] btf__core_reloc_primitives___diff_func_proto.o
  CLNG-BPF [test_maps] btf__core_reloc_primitives___diff_ptr_type.o
  CLNG-BPF [test_maps] btf__core_reloc_primitives___err_non_enum.o
  CLNG-BPF [test_maps] btf__core_reloc_primitives___err_non_int.o
  CLNG-BPF [test_maps] btf__core_reloc_primitives___err_non_ptr.o
  CLNG-BPF [test_maps] btf__core_reloc_ptr_as_arr.o
  CLNG-BPF [test_maps] btf__core_reloc_ptr_as_arr___diff_sz.o
  CLNG-BPF [test_maps] btf__core_reloc_size.o
  CLNG-BPF [test_maps] btf__core_reloc_size___diff_sz.o
  CLNG-BPF [test_maps] btf__core_reloc_size___err_ambiguous.o
  CLNG-BPF [test_maps] btf__core_reloc_type_based___all_missing.o
  CLNG-BPF [test_maps] btf__core_reloc_type_based.o
  CLNG-BPF [test_maps] btf__core_reloc_type_based___diff_sz.o
  CLNG-BPF [test_maps] btf__core_reloc_type_based___fn_wrong_args.o
  CLNG-BPF [test_maps] btf__core_reloc_type_based___incompat.o
  CLNG-BPF [test_maps] btf__core_reloc_type_id.o
  CLNG-BPF [test_maps] btf__core_reloc_type_id___missing_targets.o
  CLNG-BPF [test_maps] btf_data.o
  CLNG-BPF [test_maps] btf_dump_test_case_bitfields.o
  CLNG-BPF [test_maps] btf_dump_test_case_multidim.o
  CLNG-BPF [test_maps] btf_dump_test_case_namespacing.o
  CLNG-BPF [test_maps] btf_dump_test_case_ordering.o
  CLNG-BPF [test_maps] btf_dump_test_case_packing.o
  CLNG-BPF [test_maps] btf_dump_test_case_padding.o
  CLNG-BPF [test_maps] btf_dump_test_case_syntax.o
  CLNG-BPF [test_maps] cgroup_skb_sk_lookup_kern.o
  CLNG-BPF [test_maps] cg_storage_multi_egress_only.o
  CLNG-BPF [test_maps] cg_storage_multi_isolated.o
  CLNG-BPF [test_maps] cg_storage_multi_shared.o
  CLNG-BPF [test_maps] connect4_prog.o
  CLNG-BPF [test_maps] connect6_prog.o
  CLNG-BPF [test_maps] connect_force_port4.o
  CLNG-BPF [test_maps] connect_force_port6.o
  CLNG-BPF [test_maps] dev_cgroup.o
  CLNG-BPF [test_maps] fentry_test.o
  CLNG-BPF [test_maps] fexit_bpf2bpf.o
  CLNG-BPF [test_maps] fexit_bpf2bpf_simple.o
  CLNG-BPF [test_maps] fexit_sleep.o
  CLNG-BPF [test_maps] fexit_test.o
  CLNG-BPF [test_maps] fmod_ret_freplace.o
  CLNG-BPF [test_maps] for_each_array_map_elem.o
  CLNG-BPF [test_maps] for_each_hash_map_elem.o
  CLNG-BPF [test_maps] freplace_attach_probe.o
  CLNG-BPF [test_maps] freplace_cls_redirect.o
  CLNG-BPF [test_maps] freplace_connect4.o
  CLNG-BPF [test_maps] freplace_connect_v4_prog.o
  CLNG-BPF [test_maps] freplace_get_constant.o
  CLNG-BPF [test_maps] get_cgroup_id_kern.o
  CLNG-BPF [test_maps] ima.o
  CLNG-BPF [test_maps] kfree_skb.o
  CLNG-BPF [test_maps] kfunc_call_test.o
  CLNG-BPF [test_maps] kfunc_call_test_subprog.o
  CLNG-BPF [test_maps] linked_funcs1.o
  CLNG-BPF [test_maps] linked_funcs2.o
  CLNG-BPF [test_maps] linked_maps1.o
  CLNG-BPF [test_maps] linked_maps2.o
  CLNG-BPF [test_maps] linked_vars1.o
  CLNG-BPF [test_maps] linked_vars2.o
  CLNG-BPF [test_maps] load_bytes_relative.o
  CLNG-BPF [test_maps] local_storage.o
  CLNG-BPF [test_maps] loop1.o
  CLNG-BPF [test_maps] loop2.o
  CLNG-BPF [test_maps] loop3.o
  CLNG-BPF [test_maps] loop4.o
  CLNG-BPF [test_maps] loop5.o
  CLNG-BPF [test_maps] loop6.o
  CLNG-BPF [test_maps] lsm.o
  CLNG-BPF [test_maps] map_ptr_kern.o
  CLNG-BPF [test_maps] metadata_unused.o
  CLNG-BPF [test_maps] metadata_used.o
  CLNG-BPF [test_maps] modify_return.o
  CLNG-BPF [test_maps] netcnt_prog.o
  CLNG-BPF [test_maps] netif_receive_skb.o
  CLNG-BPF [test_maps] perfbuf_bench.o
  CLNG-BPF [test_maps] perf_event_stackmap.o
  CLNG-BPF [test_maps] profiler1.o
  CLNG-BPF [test_maps] profiler2.o
  CLNG-BPF [test_maps] profiler3.o
  CLNG-BPF [test_maps] pyperf100.o
  CLNG-BPF [test_maps] pyperf180.o
  CLNG-BPF [test_maps] pyperf50.o
  CLNG-BPF [test_maps] pyperf600.o
  CLNG-BPF [test_maps] pyperf600_nounroll.o
  CLNG-BPF [test_maps] pyperf_global.o
  CLNG-BPF [test_maps] pyperf_subprogs.o
  CLNG-BPF [test_maps] recursion.o
  CLNG-BPF [test_maps] recvmsg4_prog.o
  CLNG-BPF [test_maps] recvmsg6_prog.o
  CLNG-BPF [test_maps] ringbuf_bench.o
  CLNG-BPF [test_maps] sample_map_ret0.o
  CLNG-BPF [test_maps] sample_ret0.o
  CLNG-BPF [test_maps] sendmsg4_prog.o
  CLNG-BPF [test_maps] sendmsg6_prog.o
  CLNG-BPF [test_maps] skb_pkt_end.o
  CLNG-BPF [test_maps] socket_cookie_prog.o
  CLNG-BPF [test_maps] sockmap_parse_prog.o
  CLNG-BPF [test_maps] sockmap_tcp_msg_prog.o
  CLNG-BPF [test_maps] sockmap_verdict_prog.o
  CLNG-BPF [test_maps] sockopt_inherit.o
  CLNG-BPF [test_maps] sockopt_multi.o
  CLNG-BPF [test_maps] sockopt_sk.o
  CLNG-BPF [test_maps] strobemeta.o
  CLNG-BPF [test_maps] strobemeta_nounroll1.o
  CLNG-BPF [test_maps] strobemeta_nounroll2.o
  CLNG-BPF [test_maps] strobemeta_subprogs.o
  CLNG-BPF [test_maps] tailcall1.o
  CLNG-BPF [test_maps] tailcall2.o
  CLNG-BPF [test_maps] tailcall3.o
  CLNG-BPF [test_maps] tailcall4.o
  CLNG-BPF [test_maps] tailcall5.o
  CLNG-BPF [test_maps] tailcall_bpf2bpf1.o
  CLNG-BPF [test_maps] tailcall_bpf2bpf2.o
  CLNG-BPF [test_maps] tailcall_bpf2bpf3.o
  CLNG-BPF [test_maps] tailcall_bpf2bpf4.o
  CLNG-BPF [test_maps] task_local_storage.o
  CLNG-BPF [test_maps] task_local_storage_exit_creds.o
  CLNG-BPF [test_maps] task_ls_recursion.o
  CLNG-BPF [test_maps] tcp_rtt.o
  CLNG-BPF [test_maps] test_attach_probe.o
  CLNG-BPF [test_maps] test_autoload.o
  CLNG-BPF [test_maps] test_btf_haskv.o
  CLNG-BPF [test_maps] test_btf_map_in_map.o
  CLNG-BPF [test_maps] test_btf_newkv.o
  CLNG-BPF [test_maps] test_btf_nokv.o
  CLNG-BPF [test_maps] test_btf_skc_cls_ingress.o
  CLNG-BPF [test_maps] test_cgroup_link.o
  CLNG-BPF [test_maps] test_check_mtu.o
  CLNG-BPF [test_maps] test_cls_redirect.o
  CLNG-BPF [test_maps] test_cls_redirect_subprogs.o
  CLNG-BPF [test_maps] test_core_autosize.o
  CLNG-BPF [test_maps] test_core_extern.o
  CLNG-BPF [test_maps] test_core_read_macros.o
  CLNG-BPF [test_maps] test_core_reloc_arrays.o
  CLNG-BPF [test_maps] test_core_reloc_bitfields_direct.o
  CLNG-BPF [test_maps] test_core_reloc_bitfields_probed.o
  CLNG-BPF [test_maps] test_core_reloc_enumval.o
  CLNG-BPF [test_maps] test_core_reloc_existence.o
  CLNG-BPF [test_maps] test_core_reloc_flavors.o
  CLNG-BPF [test_maps] test_core_reloc_ints.o
  CLNG-BPF [test_maps] test_core_reloc_kernel.o
  CLNG-BPF [test_maps] test_core_reloc_misc.o
  CLNG-BPF [test_maps] test_core_reloc_mods.o
  CLNG-BPF [test_maps] test_core_reloc_module.o
  CLNG-BPF [test_maps] test_core_reloc_nesting.o
  CLNG-BPF [test_maps] test_core_reloc_primitives.o
  CLNG-BPF [test_maps] test_core_reloc_ptr_as_arr.o
  CLNG-BPF [test_maps] test_core_reloc_size.o
  CLNG-BPF [test_maps] test_core_reloc_type_based.o
  CLNG-BPF [test_maps] test_core_reloc_type_id.o
  CLNG-BPF [test_maps] test_core_retro.o
  CLNG-BPF [test_maps] test_d_path.o
  CLNG-BPF [test_maps] test_enable_stats.o
  CLNG-BPF [test_maps] test_endian.o
  CLNG-BPF [test_maps] test_get_stack_rawtp.o
  CLNG-BPF [test_maps] test_get_stack_rawtp_err.o
  CLNG-BPF [test_maps] test_global_data.o
  CLNG-BPF [test_maps] test_global_func10.o
  CLNG-BPF [test_maps] test_global_func11.o
  CLNG-BPF [test_maps] test_global_func12.o
  CLNG-BPF [test_maps] test_global_func13.o
  CLNG-BPF [test_maps] test_global_func14.o
  CLNG-BPF [test_maps] test_global_func15.o
  CLNG-BPF [test_maps] test_global_func16.o
  CLNG-BPF [test_maps] test_global_func1.o
  CLNG-BPF [test_maps] test_global_func2.o
  CLNG-BPF [test_maps] test_global_func3.o
  CLNG-BPF [test_maps] test_global_func4.o
  CLNG-BPF [test_maps] test_global_func5.o
  CLNG-BPF [test_maps] test_global_func6.o
  CLNG-BPF [test_maps] test_global_func7.o
  CLNG-BPF [test_maps] test_global_func8.o
  CLNG-BPF [test_maps] test_global_func9.o
  CLNG-BPF [test_maps] test_global_func_args.o
  CLNG-BPF [test_maps] test_hash_large_key.o
  CLNG-BPF [test_maps] test_ksyms_btf.o
  CLNG-BPF [test_maps] test_ksyms_btf_null_check.o
  CLNG-BPF [test_maps] test_ksyms.o
  CLNG-BPF [test_maps] test_ksyms_module.o
  CLNG-BPF [test_maps] test_l4lb.o
  CLNG-BPF [test_maps] test_l4lb_noinline.o
  CLNG-BPF [test_maps] test_link_pinning.o
  CLNG-BPF [test_maps] test_lirc_mode2_kern.o
  CLNG-BPF [test_maps] test_lwt_ip_encap.o
  CLNG-BPF [test_maps] test_lwt_seg6local.o
  CLNG-BPF [test_maps] test_map_init.o
  CLNG-BPF [test_maps] test_map_in_map.o
  CLNG-BPF [test_maps] test_map_lock.o
  CLNG-BPF [test_maps] test_misc_tcp_hdr_options.o
  CLNG-BPF [test_maps] test_mmap.o
  CLNG-BPF [test_maps] test_module_attach.o
  CLNG-BPF [test_maps] test_ns_current_pid_tgid.o
  CLNG-BPF [test_maps] test_obj_id.o
  CLNG-BPF [test_maps] test_overhead.o
  CLNG-BPF [test_maps] test_pe_preserve_elems.o
  CLNG-BPF [test_maps] test_perf_branches.o
  CLNG-BPF [test_maps] test_perf_buffer.o
  CLNG-BPF [test_maps] test_pinning.o
  CLNG-BPF [test_maps] test_pinning_invalid.o
  CLNG-BPF [test_maps] test_pkt_access.o
  CLNG-BPF [test_maps] test_pkt_md_access.o
  CLNG-BPF [test_maps] test_probe_read_user_str.o
  CLNG-BPF [test_maps] test_probe_user.o
  CLNG-BPF [test_maps] test_queue_map.o
  CLNG-BPF [test_maps] test_raw_tp_test_run.o
  CLNG-BPF [test_maps] test_rdonly_maps.o
  CLNG-BPF [test_maps] test_ringbuf.o
  CLNG-BPF [test_maps] test_ringbuf_multi.o
  CLNG-BPF [test_maps] test_seg6_loop.o
  CLNG-BPF [test_maps] test_select_reuseport_kern.o
  CLNG-BPF [test_maps] test_send_signal_kern.o
  CLNG-BPF [test_maps] test_sk_assign.o
  CLNG-BPF [test_maps] test_skb_cgroup_id_kern.o
  CLNG-BPF [test_maps] test_skb_ctx.o
  CLNG-BPF [test_maps] test_skb_helpers.o
  CLNG-BPF [test_maps] test_skeleton.o
  CLNG-BPF [test_maps] test_sk_lookup.o
  CLNG-BPF [test_maps] test_sk_lookup_kern.o
  CLNG-BPF [test_maps] test_skmsg_load_helpers.o
  CLNG-BPF [test_maps] test_sk_storage_trace_itself.o
  CLNG-BPF [test_maps] test_sk_storage_tracing.o
  CLNG-BPF [test_maps] test_snprintf.o
  CLNG-BPF [test_maps] test_snprintf_single.o
  CLNG-BPF [test_maps] test_sock_fields.o
  CLNG-BPF [test_maps] test_sockhash_kern.o
  CLNG-BPF [test_maps] test_sockmap_invalid_update.o
  CLNG-BPF [test_maps] test_sockmap_kern.o
  CLNG-BPF [test_maps] test_sockmap_listen.o
  CLNG-BPF [test_maps] test_sockmap_skb_verdict_attach.o
  CLNG-BPF [test_maps] test_sockmap_update.o
  CLNG-BPF [test_maps] test_spin_lock.o
  CLNG-BPF [test_maps] test_stack_map.o
  CLNG-BPF [test_maps] test_stacktrace_build_id.o
  CLNG-BPF [test_maps] test_stacktrace_map.o
  CLNG-BPF [test_maps] test_stack_var_off.o
  CLNG-BPF [test_maps] test_static_linked1.o
  CLNG-BPF [test_maps] test_static_linked2.o
  CLNG-BPF [test_maps] test_subprogs.o
  CLNG-BPF [test_maps] test_subprogs_unused.o
  CLNG-BPF [test_maps] test_sysctl_loop1.o
  CLNG-BPF [test_maps] test_sysctl_loop2.o
  CLNG-BPF [test_maps] test_sysctl_prog.o
  CLNG-BPF [test_maps] test_tc_edt.o
  CLNG-BPF [test_maps] test_tc_neigh.o
  CLNG-BPF [test_maps] test_tc_neigh_fib.o
  CLNG-BPF [test_maps] test_tcpbpf_kern.o
  CLNG-BPF [test_maps] test_tcp_check_syncookie_kern.o
  CLNG-BPF [test_maps] test_tc_peer.o
  CLNG-BPF [test_maps] test_tcp_estats.o
  CLNG-BPF [test_maps] test_tcp_hdr_options.o
  CLNG-BPF [test_maps] test_tcpnotify_kern.o
  CLNG-BPF [test_maps] test_tc_tunnel.o
  CLNG-BPF [test_maps] test_trace_ext.o
  CLNG-BPF [test_maps] test_trace_ext_tracing.o
  CLNG-BPF [test_maps] test_tracepoint.o
  CLNG-BPF [test_maps] test_trampoline_count.o
  CLNG-BPF [test_maps] test_tunnel_kern.o
  CLNG-BPF [test_maps] test_varlen.o
  CLNG-BPF [test_maps] test_verif_scale1.o
  CLNG-BPF [test_maps] test_verif_scale2.o
  CLNG-BPF [test_maps] test_verif_scale3.o
  CLNG-BPF [test_maps] test_vmlinux.o
  CLNG-BPF [test_maps] test_xdp_adjust_tail_grow.o
  CLNG-BPF [test_maps] test_xdp_adjust_tail_shrink.o
  CLNG-BPF [test_maps] test_xdp_bpf2bpf.o
  CLNG-BPF [test_maps] test_xdp.o
  CLNG-BPF [test_maps] test_xdp_devmap_helpers.o
  CLNG-BPF [test_maps] test_xdp_link.o
  CLNG-BPF [test_maps] test_xdp_loop.o
  CLNG-BPF [test_maps] test_xdp_meta.o
  CLNG-BPF [test_maps] test_xdp_noinline.o
  CLNG-BPF [test_maps] test_xdp_redirect.o
  CLNG-BPF [test_maps] test_xdp_vlan.o
  CLNG-BPF [test_maps] test_xdp_with_cpumap_helpers.o
  CLNG-BPF [test_maps] test_xdp_with_devmap_helpers.o
  CLNG-BPF [test_maps] trace_printk.o
  CLNG-BPF [test_maps] trigger_bench.o
  CLNG-BPF [test_maps] udp_limit.o
  CLNG-BPF [test_maps] xdp_dummy.o
  CLNG-BPF [test_maps] xdping_kern.o
  CLNG-BPF [test_maps] xdp_redirect_map.o
  CLNG-BPF [test_maps] xdp_tx.o
  GEN-SKEL [test_progs] atomic_bounds.skel.h
  GEN-SKEL [test_progs] atomics.skel.h
  GEN-SKEL [test_progs] bind4_prog.skel.h
libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
  GEN-SKEL [test_progs] bind6_prog.skel.h
libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
  GEN-SKEL [test_progs] bind_perm.skel.h
  GEN-SKEL [test_progs] bpf_cubic.skel.h
libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
Error: failed to open BPF object file: No such file or directory
make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 255
make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h'
make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
[acme@seventh linux]$


