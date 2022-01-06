Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F124B486005
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 05:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiAFEz0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 23:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiAFEz0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 23:55:26 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4870DC061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 20:55:26 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y18so1727367iob.8
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 20:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ax3HMlspm7Sn8OOijWpJciZU/8BcCSzAO/UFvAftboM=;
        b=nFANSk1vOWuzpzEdgZAgouP2qbzzYF1N+zldJDXfTT6WQUXShqgHkEEq0WcXAjhBo1
         ieJbpkBM/16Z6+czcPmCNY/iEwwKSFbULA+ACWqwJb4eerm0uQKVjukSPf37EjsUOd+S
         LoqfuxQlTAxkwbLJmAOnc8eig6w56s3GgiRYXK+s20t1A+WvIxatXknrI3/WHnuDZM1E
         pHeLVEVDGdxvC+yEp0HUum0QYOF6qyBxS38GBxMg5be+sG8H3nAB8vEbw6MZVsW4z9+x
         5PBny6uFLbCbrWIf0uLmI0e7iGQUzO0qqk922ghbwnWJf5LM7rEicYbml0N/sAg+Yk8D
         PfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax3HMlspm7Sn8OOijWpJciZU/8BcCSzAO/UFvAftboM=;
        b=1qIuGKfYtaG4HHRDb+0MdTHiWwQxdurtCXS+G6xz4aIffTybMHEbxrtgmfUrC3o06m
         vEo2ktdhjgPXCa5Yq1TTUYgH7yAXKsbaOtjy3fROIM5xqvjmru5OdBeyBw2S9KqM9Vc0
         yMhxI01eosvnV1fOPN39QJVPaHOUZB7wCxTSzVOigCAWHBsrabXoqtYGCwfyTZs2aD7o
         wq2YEC7Etd4kSC6jTdvyt6TxIC/V4zDTUc2SSXF9ZFe45KKA7uVmwPuj2B2u0oLgcpXu
         kNtGNQAbGO4OLTvGVXuHIOmJbOA26o0OJ47NsMo3ulhSqTdngoMkACIzvjAIYBXXS1tS
         lCOA==
X-Gm-Message-State: AOAM532pm8Y94UJjx2xF5nHE8qKryi93UsYRAHfYrcvob9ZCtf/JZ6HJ
        FC97iJZ0rKhSjj2eWfnPBSgRVuHg9K+jlSyq/6c6DNvn7mQ=
X-Google-Smtp-Source: ABdhPJzpgEpttjRi6FDZMaucLrjzram0Qmbt6ajfvQk1d5FWQaAFs16JYn3QG5Dji4qIfi4sGaXANjq4RCKAKpE9aqk=
X-Received: by 2002:a6b:3b51:: with SMTP id i78mr26813957ioa.63.1641444925558;
 Wed, 05 Jan 2022 20:55:25 -0800 (PST)
MIME-Version: 1.0
References: <1641377010132.82356@hs-osnabrueck.de>
In-Reply-To: <1641377010132.82356@hs-osnabrueck.de>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 20:55:14 -0800
Message-ID: <CAEf4BzYfu49iG=mmokC6VpBKoyKfqVDjCpkusjsXGLQTXS1tSQ@mail.gmail.com>
Subject: Re: Problem loading eBPF program on Kernel 4.18 (best with CO:RE): -EINVAL
To:     "Buchberger, Dennis" <dennis.buchberger@hs-osnabrueck.de>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 5, 2022 at 2:12 PM Buchberger, Dennis
<dennis.buchberger@hs-osnabrueck.de> wrote:
>
> Hello :)
>
> I am currently having a problem and hope you can help me: My goal is to develop a BPF-program (see below) on a development machine and then deploy it to another machine to run it there using BPF CO:RE.
> But the program does not load; bpf_object__load returns -EINVAL.
>
> Development machine:
> - Ubuntu 20.04 LTS
> - Linux 5.4.0-90-generic x86_64
> - Kernel compiled with CONFIG_DEBUG_INFO_BTF=y, so BTF is available under /sys/kernel/btf/vmlinux
> - clang version: 10.0.0-4ubuntu1
> - llc version: 10.0.0
>
> Target machine:
> - Ubuntu 18.10
> - Linux 4.18.0-25-generic x86_64
> - clang version: 13.0.0
> - llc version: 13.0.0
>
> As the target kernel does not support CONFIG_DEBUG_INFO_BTF, I used pahole -J (v1.22) to create vmlinux file with BTF info embedded there.
> Basically, I followed this mails: https://lore.kernel.org/bpf/CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com/
>
> Right now, the bpf program is just a uProbe for a simple test app, which writes some output to the tracing pipe. As Kernel 4.18. does not support global data for bpf programs, I had to remove (comment out) the bpf_trace_printk statements.

You can do #define BPF_NO_GLOBAL_DATA before including bpf_helpers.h
and then you can still use bpf_printk() helper macro.


> On the development machine, it works fine. But on the target machine, loading the program fails: libbpf: load bpf program failed: Invalid argument (full libbpf log see below).
> When compiling the programs on the target machine without using CO:RE, I get a similar error (invalid argument, -22).
> What could be the problem? I don't think the eBPF program uses anything that is available on Kernel 5.4.0 and not available on the system with Kernel 4.18, does it?
>
> Thanks in advance for your help.
> Best
> Dennis
>
>
>
>
> ============ log ============
>
> sudo ./ebpf
> libbpf: loading main.bpf.o
> libbpf: elf: section(3) kprobe/, size 272, link 0, flags 6, type=1
> libbpf: sec 'kprobe/': found program 'trace_func_entry' at insn offset 0 (0 bytes), code size 34 insns (272 bytes)
> libbpf: elf: section(4) .relkprobe/, size 16, link 24, flags 0, type=9
> libbpf: elf: section(5) kretprobe/, size 88, link 0, flags 6, type=1
> libbpf: sec 'kretprobe/': found program 'trace_func_exit' at insn offset 0 (0 bytes), code size 11 insns (88 bytes)
> libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
> libbpf: license of main.bpf.o is GPL
> libbpf: elf: section(7) maps, size 20, link 0, flags 3, type=1
> libbpf: elf: section(16) .BTF, size 1406, link 0, flags 0, type=1
> libbpf: elf: section(18) .BTF.ext, size 460, link 0, flags 0, type=1
> libbpf: elf: section(24) .symtab, size 2160, link 1, flags 0, type=2
> libbpf: looking for externs among 90 symbols...
> libbpf: collected 0 externs total
> libbpf: elf: found 1 legacy map definitions (20 bytes) in main.bpf.o
> libbpf: map 'stackdata_map' (legacy): at sec_idx 7, offset 0.
> libbpf: map 87 is "stackdata_map"
> libbpf: sec '.relkprobe/': collecting relocation for section(3) 'kprobe/'
> libbpf: sec '.relkprobe/': relo #0: insn #20 against 'stackdata_map'
> libbpf: prog 'trace_func_entry': found map 0 (stackdata_map, sec 7, off 0) for insn #20
> >> Loading eBPF program
> libbpf: loading kernel BTF '/usr/lib/debug/boot/vmlinux-4.18.0-25-generic': 0
> libbpf: map:stackdata_map container_name:____btf_map_stackdata_map cannot be found in BTF. Missing BPF_ANNOTATE_KV_PAIR?
> libbpf: map 'stackdata_map': created successfully, fd=4
> libbpf: sec 'kprobe/': found 2 CO-RE relocations
> libbpf: CO-RE relocating [0] struct pt_regs: found target candidate [201] struct pt_regs in [vmlinux]
> libbpf: prog 'trace_func_entry': relo #0: kind <byte_off> (0), spec is [2] struct pt_regs.di (0:14 @ offset 112)
> libbpf: prog 'trace_func_entry': relo #0: matching candidate #0 [201] struct pt_regs.di (0:14 @ offset 112)
> libbpf: prog 'trace_func_entry': relo #0: patched insn #2 (ALU/ALU64) imm 112 -> 112
> libbpf: prog 'trace_func_entry': relo #1: kind <byte_off> (0), spec is [2] struct pt_regs.si (0:13 @ offset 104)
> libbpf: prog 'trace_func_entry': relo #1: matching candidate #0 [201] struct pt_regs.si (0:13 @ offset 104)
> libbpf: prog 'trace_func_entry': relo #1: patched insn #9 (ALU/ALU64) imm 104 -> 104
> libbpf: sec 'kretprobe/': found 1 CO-RE relocations
> libbpf: prog 'trace_func_exit': relo #0: kind <byte_off> (0), spec is [2] struct pt_regs.ax (0:10 @ offset 80)
> libbpf: prog 'trace_func_exit': relo #0: matching candidate #0 [201] struct pt_regs.ax (0:10 @ offset 80)
> libbpf: prog 'trace_func_exit': relo #0: patched insn #2 (ALU/ALU64) imm 80 -> 80

CO-RE relocations succeeded, btf_custom_path worked, the problem is
not in CO-RE.

> libbpf: load bpf program failed: Invalid argument
> libbpf: failed to load program 'trace_func_entry'

I suspect this is due to your target machine running Ubuntu 18.10.
Ubuntu has infamous problem with reporting kernel version through
uname() syscall. I've just improved libbpf's detection of it few days
ago (see [0]), but it didn't yet make it into Github mirror of libbpf.
I'm going to start the sync right now, but you can manually specify
correct version code with bpf_object__set_kversion() as you already
realized. See how I do that in my patch [0], you can do that manually
as well.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20211222231003.2334940-1-andrii@kernel.org/

> libbpf: failed to load object 'main.bpf.o'
> bpf_object__load: -22
>
>
>

[...]
