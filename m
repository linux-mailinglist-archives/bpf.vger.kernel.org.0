Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43C4867EE
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbiAFQxd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Jan 2022 11:53:33 -0500
Received: from mail.hs-osnabrueck.de ([131.173.88.34]:65080 "EHLO
        msx.hs-osnabrueck.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiAFQxd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 11:53:33 -0500
Received: from sea-02.fhos.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id C356B75_1D71E8AB;
        Thu,  6 Jan 2022 16:53:30 +0000 (GMT)
Received: from msx.hs-osnabrueck.de (RODDERBERG.FHOS.DE [192.168.179.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "msx.hs-osnabrueck.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by sea-02.fhos.de (Sophos Email Appliance) with ESMTPS id 7BF2E2A5F85_1D71E8AF;
        Thu,  6 Jan 2022 16:53:30 +0000 (GMT)
Received: from ROCKENSTEIN.FHOS.DE (192.168.179.25) by Rodderberg.FHOS.DE
 (192.168.179.29) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 6 Jan
 2022 17:53:29 +0100
Received: from ROCKENSTEIN.FHOS.DE ([fe80::d109:b519:b2eb:52b4]) by
 Rockenstein.FHOS.DE ([fe80::d109:b519:b2eb:52b4%12]) with mapi id
 15.00.1497.026; Thu, 6 Jan 2022 17:53:29 +0100
From:   "Buchberger, Dennis" <dennis.buchberger@hs-osnabrueck.de>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: AW: [Extern] Re: Problem loading eBPF program on Kernel 4.18 (best
 with CO:RE): -EINVAL
Thread-Topic: [Extern] Re: Problem loading eBPF program on Kernel 4.18 (best
 with CO:RE): -EINVAL
Thread-Index: AQHYAhp5eI29nHop60CO4GOJmoPCtqxVXjYAgADX9Pc=
Date:   Thu, 6 Jan 2022 16:53:29 +0000
Message-ID: <1641488009887.85104@hs-osnabrueck.de>
References: <1641377010132.82356@hs-osnabrueck.de>,<CAEf4BzYfu49iG=mmokC6VpBKoyKfqVDjCpkusjsXGLQTXS1tSQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYfu49iG=mmokC6VpBKoyKfqVDjCpkusjsXGLQTXS1tSQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.179.140]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> >  [...]
> > As the target kernel does not support CONFIG_DEBUG_INFO_BTF, I used pahole -J (v1.22) to create vmlinux file with BTF info embedded there.
> > Basically, I followed this mails:
> > https://urldefense.com/v3/__https://lore.kernel.org/bpf/CADmGQ*1euj7Uv
> > 9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com/__;Kw!!MeVeBiz6!5
> > PZT7QBM-W93AhbZnRJ3kmTO4JyBUiapxeJrPCl4k4gKHidI5Ri0WQp19MbBDFP1nWOL3A$
> >
> > Right now, the bpf program is just a uProbe for a simple test app, which writes some output to the tracing pipe. As Kernel 4.18. does not support global data for bpf programs, I had to remove (comment out) the bpf_trace_printk statements.
>
> You can do #define BPF_NO_GLOBAL_DATA before including bpf_helpers.h and then you can still use bpf_printk() helper macro.
>

Thank you! That's really helpful. Is there any collection of up-to-date documentation and best practices in writing bpf code (without skeletons) besides the sources in libbpf/libbpf-bootstrap, iovisor /libbpf-tools and linux/tools/testing/selftests/bpf ?


>
> > On the development machine, it works fine. But on the target machine, loading the program fails: libbpf: load bpf program failed: Invalid argument (full libbpf log see below).
> > When compiling the programs on the target machine without using CO:RE, I get a similar error (invalid argument, -22).
> > What could be the problem? I don't think the eBPF program uses anything that is available on Kernel 5.4.0 and not available on the system with Kernel 4.18, does it?
> >
> > Thanks in advance for your help.
> > Best
> > Dennis
> >
> >
> >
> >
> > ============ log ============
> >
> > sudo ./ebpf
> > libbpf: loading main.bpf.o
> > [...]
> > libbpf: CO-RE relocating [0] struct pt_regs: found target candidate
> > [201] struct pt_regs in [vmlinux]
> > libbpf: prog 'trace_func_entry': relo #0: kind <byte_off> (0), spec is
> > [2] struct pt_regs.di (0:14 @ offset 112)
> > libbpf: prog 'trace_func_entry': relo #0: matching candidate #0 [201]
> > struct pt_regs.di (0:14 @ offset 112)
> > libbpf: prog 'trace_func_entry': relo #0: patched insn #2 (ALU/ALU64)
> > imm 112 -> 112
> > libbpf: prog 'trace_func_entry': relo #1: kind <byte_off> (0), spec is
> > [2] struct pt_regs.si (0:13 @ offset 104)
> > libbpf: prog 'trace_func_entry': relo #1: matching candidate #0 [201]
> > struct pt_regs.si (0:13 @ offset 104)
> > libbpf: prog 'trace_func_entry': relo #1: patched insn #9 (ALU/ALU64)
> > imm 104 -> 104
> > libbpf: sec 'kretprobe/': found 1 CO-RE relocations
> > libbpf: prog 'trace_func_exit': relo #0: kind <byte_off> (0), spec is
> > [2] struct pt_regs.ax (0:10 @ offset 80)
> > libbpf: prog 'trace_func_exit': relo #0: matching candidate #0 [201]
> > struct pt_regs.ax (0:10 @ offset 80)
> > libbpf: prog 'trace_func_exit': relo #0: patched insn #2 (ALU/ALU64)
> > imm 80 -> 80
>
> CO-RE relocations succeeded, btf_custom_path worked, the problem is not in CO-RE.
>
> > libbpf: load bpf program failed: Invalid argument
> > libbpf: failed to load program 'trace_func_entry'
>
> I suspect this is due to your target machine running Ubuntu 18.10.
> Ubuntu has infamous problem with reporting kernel version through
> uname() syscall. I've just improved libbpf's detection of it few days ago (see [0]), but it didn't yet make it into Github mirror of libbpf.
> I'm going to start the sync right now, but you can manually specify correct version code with bpf_object__set_kversion() as you already realized. See how I do that in my patch [0], you can do that manually as well.
>
>   [0] https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbpf/patch/20211222231003.2334940-1-andrii@kernel.org/__;!!MeVeBiz6!5PZT7QBM-W93AhbZnRJ3kmTO4JyBUiapxeJrPCl4k4gKHidI5Ri0WQp19MbBDFM_zuNNKA$

That's it, thank you very much!

I just added
	__u32 currKernelVersion = get_kernel_version();
	bpf_object__set_kversion(main_bpf_obj, currKernelVersion)
with get_kernel_version() from libbpf.c and your patch [0] and now it is working. :)

However, there is something I do not understand:
(a): Why did it work on the development machine in the first place with Ubuntu 20.04?
	- the old get_kernel_version() returned 328704 (5.4.0), the new version returns 328852 (5.4.148) so there already is a missmatch. (and I did not call it, so libbpf set the kernel version to 0?)
	- on the target machine, it is 266752 (4.2.0) vs. 266772 (4.2.4)
(b): I use a uProbe. Why is the bpf program type kProbe? Is it just for usability of libbpf as for a uProbe the user must specify the address while for a kprobe only the symbol is required?
(c): Why does the kernel version matter at all?

It would be really nice if you could answer these questions as well or point me to a source.

Best
Dennis

[...]

