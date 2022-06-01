Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584B8539C5A
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 06:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349603AbiFAEvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 00:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349601AbiFAEvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 00:51:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E666C93
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 21:51:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e4so694001ljb.13
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 21:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1WD9/5iGhzoXyBOfg+hebnz+R8QURHQDwUFhVg3TUs=;
        b=SOYqTacTSOuVwncheFZokXNPV6boQtN86Z9NSTKJmv+9WaO/uzp66NaLsuypLlSnIs
         ebDw6rzbityXdZ4c0aqkdiAmec/yEoqonQrNFBCTWjto7UXskKhog/b+yira4s3c+GoG
         iCmUAhSYx2OYV+SOKEMPn7/V8n0bUVtvqCfYDnWu8ht7BOHLowep8m9tBQlXdfaQkqqR
         NHoE+Qx83lizXQVWWmTeduBrVvxvLPveuXlvsJxjuKrV29MCSdCILg4MyqhVJS5a9vjy
         H5JHAoUKU6xHbdBn8tD0Z1OAmESYDTFEpwZXI80Lm+LvzHKByWsZHG7civSkKNpduFeF
         /XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1WD9/5iGhzoXyBOfg+hebnz+R8QURHQDwUFhVg3TUs=;
        b=wFcPu3uw0poFaxu/NXqBydZMnHLbRLWQHal/1Aw+JNJu2bD5Mb9P6heUfuTIhIbFaz
         fXsAzqILdI2yF/YHYW44IjUQuJX4PEaQEjZIsf92XjTVifFpKZmANf15UF2YXy75qcVk
         jMIZyWfaPb+kiQpL448LIS16AZb2nGOcVGZsj1AxAe38uhfF03T1VHrHYjyNiL2pezGI
         dNAro7QAW2WisrDUE1t9bJ2ZOgpoQ6cwuCiINA/qBbvTaNJm16A0okgZd9W9iLvyfm1U
         dbUoSqfoiZEeNfJMzpS4kA/EweB9nz3xIS7OqqHloxqz5P7r/vIlPGwIsmJhRCiIMLY2
         8BcA==
X-Gm-Message-State: AOAM532zzkr4a/2GVz5Pu3M8xNbsbz3y9q4yIEr6xtsL9Jy1mKlcbs4d
        Mke+og97BA3zk0/cmGb/NEZ0rHveuX4ARbtsfW4=
X-Google-Smtp-Source: ABdhPJwVzoNsBRqHgTf0Ly48Xu2/rPpWJm7vUgvyES8E5N9f+sKssj8LZmyMoukzhW7oranCQPHqv8hWwTlDQl3fJ8M=
X-Received: by 2002:a2e:87c8:0:b0:255:6d59:ebce with SMTP id
 v8-20020a2e87c8000000b002556d59ebcemr299589ljj.455.1654059111090; Tue, 31 May
 2022 21:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHd+hHXFjc3DvK0G5RWnLChOTbGXHZp_W-exCE6onCMSRuA@mail.gmail.com>
 <CAEf4BzbiiZd7OJxN17=3ikZTor_mcqVO2XTdK6dbpcm9NqgX8w@mail.gmail.com> <CAPxVHdJL6-m3BbDSaHOn_kq31cBh2LEHeEqNnw7ecOXz7Aqijg@mail.gmail.com>
In-Reply-To: <CAPxVHdJL6-m3BbDSaHOn_kq31cBh2LEHeEqNnw7ecOXz7Aqijg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 May 2022 21:51:40 -0700
Message-ID: <CAEf4BzYKsf2BSgxbqFH0EVThj+14wx4p2SX7HVpkzXZxPQzvdA@mail.gmail.com>
Subject: Re: BPF_CORE_READ issue with nvme_submit_cmd kprobe.
To:     John Mazzie <john.p.mazzie@gmail.com>
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

On Tue, May 31, 2022 at 7:16 PM John Mazzie <john.p.mazzie@gmail.com> wrote:
>
> I pulled the latest libbpf-bootstrap and rebuilt my programs. The
> error message is clearer now. I think last time I tried
> libbpf-bootstrap was still linked to 0.7 instead of 0.8.
>
> The new message is the following which makes sense in regard to what you said.
>
> <invalid CO-RE relocation>
> failed to resolve CO-RE relocation <byte_off> [14] struct
> nvme_command.common.opcode (0:0:0:0 @ offset 0)
> processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
>
> This struct is part of the nvme driver, which is running on this
> system as it only has nvme devices (including boot device). I've been
> able to access this data using bpftrace on the same system. If I don't
> try to access this struct I can count the correct number of
> nvme_submit_cmd triggers, so I believe the probe is working correctly.
> Is this a case where I need to define more/all of the struct?
>

Look at debug logs from libbpf. I tried simplified version of your
program and it all works for me.

struct nvme_common_command {
    __u8         opcode;
} __attribute__((preserve_access_index));

struct nvme_command {
    union {
        struct nvme_common_command common;
    };
} __attribute__((preserve_access_index));

SEC("kprobe/nvme_submit_cmd")
int BPF_KPROBE(nvme_submit_cmd, void *nvmeq, struct nvme_command *cmd,
bool write_sq)
{
    bpf_printk("OPCODE %d", BPF_CORE_READ(cmd, common.opcode));

   return 0;
}


Libbpf logs:

libbpf: sec 'kprobe/nvme_submit_cmd': found 2 CO-RE relocations
libbpf: CO-RE relocating [6] struct pt_regs: found target candidate
[226] struct pt_regs in [vmlinux]
libbpf: prog 'nvme_submit_cmd': relo #0: kind <byte_off> (0), spec is
[6] struct pt_regs.si (0:13 @ offset 104)
libbpf: prog 'nvme_submit_cmd': relo #0: matching candidate #0 [226]
struct pt_regs.si (0:13 @ offset 104)
libbpf: prog 'nvme_submit_cmd': relo #0: patched insn #0 (LDX/ST/STX)
off 104 -> 104
libbpf: CO-RE relocating [10] struct nvme_command: found target
candidate [107390] struct nvme_command in [nvme_core]
libbpf: CO-RE relocating [10] struct nvme_command: found target
candidate [106451] struct nvme_command in [nvme]
libbpf: prog 'nvme_submit_cmd': relo #1: kind <byte_off> (0), spec is
[10] struct nvme_command.common.opcode (0:0:0:0 @ offset 0)
libbpf: prog 'nvme_submit_cmd': relo #1: matching candidate #0
[107390] struct nvme_command.common.opcode (0:0:0:0 @ offset 0)
libbpf: prog 'nvme_submit_cmd': relo #1: matching candidate #1
[106451] struct nvme_command.common.opcode (0:0:0:0 @ offset 0)
libbpf: prog 'nvme_submit_cmd': relo #1: patched insn #1 (ALU/ALU64) imm 0 -> 0
Successfully started! Please run `sudo cat
/sys/kernel/debug/tracing/trace_pipe` to see output of the BPF
programs.
..............^C



> On Tue, May 31, 2022 at 7:22 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, May 27, 2022 at 3:07 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
> > >
> > > While attempting to learn more about BPF and libbpf, I ran into an
> > > issue I can't quite seem to resolve.
> > >
> > > While writing some tools to practice tracing with libbpf, I came
> > > across a situation where I get an error when using BPF_CORE_READ,
> > > which appears to be that CO-RE relocation failed to find a
> > > corresponding field. Compilation doesn't complain, just when I try to
> > > execute.
> > >
> > > Error Message:
> > > ---------------------------------------------
> > > 8: (85) call unknown#195896080
> > > invalid func unknown#195896080
> >
> > This means CO-RE relocation failed. If you update libbpf submodule (or
> > maybe we already did it for libbpf-bootstrap recently), you'll get
> > more meaningful error and details. But basically in running kernel
> > there is no cmd->common.opcode.
> >
> > >
> > > I'm using the Makefile from libbpf-bootstrap to build my program. The
> > > other example programs build and execute properly, and I've also
> > > successfully used tracepoints to trace the nvme_setup_cmd and
> > > nvme_complete_rq functions. My issue appears to be when I attempt to
> > > use kprobes for the nvme_submit_cmd function.
> > >
> >
> > [...]
