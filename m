Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB053B0C0
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 02:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiFBADU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 20:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiFBADS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 20:03:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F717DF31
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 17:03:17 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a10so3358237ioe.9
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 17:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3d8PGtDM5k/hw/NHaklqMWmXmrYitqVDqNHM0k19Jg=;
        b=JD0sHnMT0SCk9ZzvdxZ50/vOnrvbb1ZoHVcY1fcqugOOKho6rbQzqoH11XcyYkFoDO
         l1D59jWtRvAwe4tTF8Wu/F8vXsr7yT+XnJix8WiWzhOExVlwtBdU5EAFs/x2PLDo/iEV
         yzziEBheVBtqjmKW9wawBI9caFmJhgBYyEqn/BHL4m2O8YMIdUTfqwlg2bJ2vItKIt0/
         MgHzxqeI/bwCeON98/P+eYkUUIeu1UMsW9Ub0r9QpB1ciL4YVAb4dhvObKsFxQAriiez
         fhSB7ehwmN9kX5KSleVt4bnjCF8c5aynqG5gARoykj0XQ6mN0+60xdG6elRfHVHG3v8I
         GdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3d8PGtDM5k/hw/NHaklqMWmXmrYitqVDqNHM0k19Jg=;
        b=KvbUcV6Of7k/MQ6if4K5FM4jUBLT0y6j2MdtaucnAbDXQu3xCy+Qpqf7MM4em1KVlV
         9+NCwp4D8bztz7kIR0AdeoIO8I0CMHrUox1IVcMH1ZzyoCgqMkGjSSqVQuSIWhCiyt77
         J/EVeIZM/sAmlXNzpQXzz6wLi3BxJeSfMgKOnbeydrR4/LBUcP4k53XQQH4T5Sur3mk1
         9pxYWi1vb7jvJDwDtnWMT5kL+CO2S2dZeCT9eTkHWU6AI9W/9qIRbTgLEf2SaQ6IejOP
         SigSHawQD1JX/NaYC6wKrBGZjCkcPIgw1lvuetp4c05/7R68kPgsy6B3AmhtjPMMOw+q
         iJtA==
X-Gm-Message-State: AOAM530j2NugdzfQFhF8gS+LEbCtAbk2vxO/N02H8iSpQ5XyAHESMCq7
        uegnxYgZ9qzGio/HUiWAG6xUL1uxuhiK7ikeAD/PDjRA6So=
X-Google-Smtp-Source: ABdhPJxnLiq7i/hK0VAz7fBvN+MhrQkWXOhSEDcDxcJMfXq892ZSf+mmEtOiur7srUCNbJ+YCcZba8vEsW2j0QTUHOo=
X-Received: by 2002:a05:6638:2586:b0:32e:edca:380c with SMTP id
 s6-20020a056638258600b0032eedca380cmr1532598jat.299.1654128196416; Wed, 01
 Jun 2022 17:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHd+hHXFjc3DvK0G5RWnLChOTbGXHZp_W-exCE6onCMSRuA@mail.gmail.com>
 <CAEf4BzbiiZd7OJxN17=3ikZTor_mcqVO2XTdK6dbpcm9NqgX8w@mail.gmail.com>
 <CAPxVHdJL6-m3BbDSaHOn_kq31cBh2LEHeEqNnw7ecOXz7Aqijg@mail.gmail.com>
 <CAEf4BzYKsf2BSgxbqFH0EVThj+14wx4p2SX7HVpkzXZxPQzvdA@mail.gmail.com>
 <CAPxVHd+mXTgjssKT9ChyDuo7S9B9c+qGW_jVRz3B0mO-afb0GQ@mail.gmail.com> <CAEf4BzaeRDwOjMBxVcroFkYP0Z4inBfj7z8ukbK1ZjcD43pX0g@mail.gmail.com>
In-Reply-To: <CAEf4BzaeRDwOjMBxVcroFkYP0Z4inBfj7z8ukbK1ZjcD43pX0g@mail.gmail.com>
From:   John Mazzie <john.p.mazzie@gmail.com>
Date:   Wed, 1 Jun 2022 19:03:05 -0500
Message-ID: <CAPxVHdKbydVMv5OVxhkX8F=f--3C6zbn_Mcf4FtsZV-CYWjo5g@mail.gmail.com>
Subject: Re: BPF_CORE_READ issue with nvme_submit_cmd kprobe.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "John Mazzie (jmazzie)" <jmazzie@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for the help that makes sense and was our suspicion, though we
weren't familiar enough to prove it or know what to look for. We are
just moving to Kernel 5.13 on Ubuntu with HWE which is working and has
the propper configuration.

On Wed, Jun 1, 2022 at 4:43 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 1, 2022 at 11:06 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
> >
> > It appears that it might be some kind of kernel dependency. I tested
> > on Rocky Linux (RHEL based image) with Kernel 4.18 and Ubuntu 20.04
> > (Kernel 5.4) with the same issue running the simplified code.
> >
> > Error
> > -----------------------
> > libbpf: sec 'kprobe/nvme_submit_cmd': found 2 CO-RE relocations
> > libbpf: CO-RE relocating [2] struct pt_regs: found target candidate
> > [202] struct pt_regs in [vmlinux]
> > libbpf: prog 'nvme_submit_cmd': relo #0: <byte_off> [2] struct
> > pt_regs.si (0:13 @ offset 104)
> > libbpf: prog 'nvme_submit_cmd': relo #0: matching candidate #0
> > <byte_off> [202] struct pt_regs.si (0:13 @ offset 104)
> > libbpf: prog 'nvme_submit_cmd': relo #0: patched insn #0 (LDX/ST/STX)
> > off 104 -> 104
> > libbpf: prog 'nvme_submit_cmd': relo #1: <byte_off> [7] struct
> > nvme_command.common.opcode (0:0:0:0 @ offset 0)
> > libbpf: prog 'nvme_submit_cmd': relo #1: no matching targets found
> > libbpf: prog 'nvme_submit_cmd': relo #1: substituting insn #1 w/ invalid insn
> > libbpf: prog 'nvme_submit_cmd': BPF program load failed: Invalid argument
> > libbpf: prog 'nvme_submit_cmd': -- BEGIN PROG LOAD LOG --
> > Unrecognized arg#0 type PTR
> > ; int BPF_KPROBE(nvme_submit_cmd, void *nvmeq, struct nvme_command
> > *cmd, bool write_sq)
> > 0: (79) r3 = *(u64 *)(r1 +104)
> > 1: <invalid CO-RE relocation>
> > failed to resolve CO-RE relocation <byte_off> [7] struct
> > nvme_command.common.opcode (0:0:0:0 @ offset 0)
> > processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> >
> > I did have a breakthrough when upgrading Ubuntu to the HWE kernel
> > (5.13) where the tool worked properly. We can start using the HWE
> > Kernel for our development and make progress with our tools, but I
> > would still like to try to understand why it may not be working on
> > Ubuntu 20.04 Kernel 5.4 or RedHat's version of 4.18.
> >
> > I verified the following kernel configuration parameters.
> >
> > CONFIG_KPROBES=y
> > CONFIG_UPROBES=y
> > CONFIG_DEBUG_FS=y
> > CONFIG_FTRACE=y
> > CONFIG_FTRACE_SYSCALLS=y
> > CONFIG_KPROBE_EVENTS=y
> > CONFIG_UPROBE_EVENTS=y
> > CONFIG_BPF_EVENTS=y
> >
> > Are there other config settings that I might not be thinking of for
> > these kernels?
> >
>
> Oh, I think I know what it is. In my case struct nvme_command comes
> from kernel modules nvme and nvme_core. But for that to work your
> kernel should have kernel module BTF generated. Which was added a bit
> later than vmlinux (kernel) BTF itself. You can check in
> /sys/kernel/btf, if the only entry you see there is vmlinux then you
> most probably don't have kernel modules.
>
> So your realistic options are either compiling in the nvme driver (and
> thus all its types will be present in vmlinux BTF) or upgrading the
> kernel to the version that supports kernel modules (plus make sure
> that you have recent enough pahole that supports generation of module
> BTFs). You need to have:
>
> $ zcat /proc/config.gz | grep BTF_MODULE
> CONFIG_DEBUG_INFO_BTF_MODULES=y
>
>
> >
> > On Tue, May 31, 2022 at 11:51 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, May 31, 2022 at 7:16 PM John Mazzie <john.p.mazzie@gmail.com> wrote:
> > > >
> > > > I pulled the latest libbpf-bootstrap and rebuilt my programs. The
> > > > error message is clearer now. I think last time I tried
> > > > libbpf-bootstrap was still linked to 0.7 instead of 0.8.
> > > >
> > > > The new message is the following which makes sense in regard to what you said.
> > > >
> > > > <invalid CO-RE relocation>
> > > > failed to resolve CO-RE relocation <byte_off> [14] struct
> > > > nvme_command.common.opcode (0:0:0:0 @ offset 0)
> > > > processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > > > peak_states 0 mark_read 0
> > > >
> > > > This struct is part of the nvme driver, which is running on this
> > > > system as it only has nvme devices (including boot device). I've been
> > > > able to access this data using bpftrace on the same system. If I don't
> > > > try to access this struct I can count the correct number of
> > > > nvme_submit_cmd triggers, so I believe the probe is working correctly.
> > > > Is this a case where I need to define more/all of the struct?
> > > >
> > >
> > > Look at debug logs from libbpf. I tried simplified version of your
> > > program and it all works for me.
> > >
> > > struct nvme_common_command {
> > >     __u8         opcode;
> > > } __attribute__((preserve_access_index));
> > >
> > > struct nvme_command {
> > >     union {
> > >         struct nvme_common_command common;
> > >     };
> > > } __attribute__((preserve_access_index));
> > >
> > > SEC("kprobe/nvme_submit_cmd")
> > > int BPF_KPROBE(nvme_submit_cmd, void *nvmeq, struct nvme_command *cmd,
> > > bool write_sq)
> > > {
> > >     bpf_printk("OPCODE %d", BPF_CORE_READ(cmd, common.opcode));
> > >
> > >    return 0;
> > > }
> > >
> > >
> > > Libbpf logs:
> > >
> > > libbpf: sec 'kprobe/nvme_submit_cmd': found 2 CO-RE relocations
> > > libbpf: CO-RE relocating [6] struct pt_regs: found target candidate
> > > [226] struct pt_regs in [vmlinux]
> > > libbpf: prog 'nvme_submit_cmd': relo #0: kind <byte_off> (0), spec is
> > > [6] struct pt_regs.si (0:13 @ offset 104)
> > > libbpf: prog 'nvme_submit_cmd': relo #0: matching candidate #0 [226]
> > > struct pt_regs.si (0:13 @ offset 104)
> > > libbpf: prog 'nvme_submit_cmd': relo #0: patched insn #0 (LDX/ST/STX)
> > > off 104 -> 104
> > > libbpf: CO-RE relocating [10] struct nvme_command: found target
> > > candidate [107390] struct nvme_command in [nvme_core]
> > > libbpf: CO-RE relocating [10] struct nvme_command: found target
> > > candidate [106451] struct nvme_command in [nvme]
> > > libbpf: prog 'nvme_submit_cmd': relo #1: kind <byte_off> (0), spec is
> > > [10] struct nvme_command.common.opcode (0:0:0:0 @ offset 0)
> > > libbpf: prog 'nvme_submit_cmd': relo #1: matching candidate #0
> > > [107390] struct nvme_command.common.opcode (0:0:0:0 @ offset 0)
> > > libbpf: prog 'nvme_submit_cmd': relo #1: matching candidate #1
> > > [106451] struct nvme_command.common.opcode (0:0:0:0 @ offset 0)
> > > libbpf: prog 'nvme_submit_cmd': relo #1: patched insn #1 (ALU/ALU64) imm 0 -> 0
> > > Successfully started! Please run `sudo cat
> > > /sys/kernel/debug/tracing/trace_pipe` to see output of the BPF
> > > programs.
> > > ..............^C
> > >
> > >
> > >
> > > > On Tue, May 31, 2022 at 7:22 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, May 27, 2022 at 3:07 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
> > > > > >
> > > > > > While attempting to learn more about BPF and libbpf, I ran into an
> > > > > > issue I can't quite seem to resolve.
> > > > > >
> > > > > > While writing some tools to practice tracing with libbpf, I came
> > > > > > across a situation where I get an error when using BPF_CORE_READ,
> > > > > > which appears to be that CO-RE relocation failed to find a
> > > > > > corresponding field. Compilation doesn't complain, just when I try to
> > > > > > execute.
> > > > > >
> > > > > > Error Message:
> > > > > > ---------------------------------------------
> > > > > > 8: (85) call unknown#195896080
> > > > > > invalid func unknown#195896080
> > > > >
> > > > > This means CO-RE relocation failed. If you update libbpf submodule (or
> > > > > maybe we already did it for libbpf-bootstrap recently), you'll get
> > > > > more meaningful error and details. But basically in running kernel
> > > > > there is no cmd->common.opcode.
> > > > >
> > > > > >
> > > > > > I'm using the Makefile from libbpf-bootstrap to build my program. The
> > > > > > other example programs build and execute properly, and I've also
> > > > > > successfully used tracepoints to trace the nvme_setup_cmd and
> > > > > > nvme_complete_rq functions. My issue appears to be when I attempt to
> > > > > > use kprobes for the nvme_submit_cmd function.
> > > > > >
> > > > >
> > > > > [...]
