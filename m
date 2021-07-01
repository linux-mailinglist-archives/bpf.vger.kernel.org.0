Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D403B9303
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhGAOSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 10:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232081AbhGAOSX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Jul 2021 10:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625148952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQuBNqnXtrucufI+PPJzux6WeHo7CQIrHe9vbJeS+xA=;
        b=LWqpym9VzZz3RTNin7HkZg2ho4xMMz6P1Q8lt1qcGIGMMi6pjaThRxlAfjdwYzAbRw315Z
        tKdj7Jk4k60h+lasReJJaVb+UeuunyPk5a74QkvW5AcNuFTDR2xxTEkQzGLl0mnTBeK0m+
        1wu4kLYwgNQ2xcNR1vX86bbxjIAyuqY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-yKIo32r8N_-js8fdyFegZg-1; Thu, 01 Jul 2021 10:15:51 -0400
X-MC-Unique: yKIo32r8N_-js8fdyFegZg-1
Received: by mail-ed1-f70.google.com with SMTP id w15-20020a05640234cfb02903951279f8f3so3173334edc.11
        for <bpf@vger.kernel.org>; Thu, 01 Jul 2021 07:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQuBNqnXtrucufI+PPJzux6WeHo7CQIrHe9vbJeS+xA=;
        b=Ilf5DuHZzNgzJCZw5ftfYeES6I7WL6fGSbomnuaCItBlMh5+/XSUEnEK7skz8SkFin
         2/TDlT4akCc7OvNcjJ9efnBVDk9JZdNcXr+1DsmAMfiNcUwoiHiN9O4FOTt6zp2Mg2/z
         vzH9FXAoT3xgqsJmgFWWVEhW72LIq2QuOD9A9yhROzXb8gS4IK3ddT3WRNl/aa4q5Fnx
         BNiJaEStH5mPSXolM8bpKt2WYzBxl8FD3OxkINdCMLK0aTEo7lhoTvUUCPcAh/PE6f8A
         ErCPRXu5qxpUT3Yi2KAF9MwI67BKs/zu28X1MzjRlq1v5mFlgePkNLj1yt6xFct9amHd
         J9EQ==
X-Gm-Message-State: AOAM531FuDjNr/oFgp8neks4TVpsD/VkTJCQtclDO3t0i44l1rHmVd3P
        KgCr+n0JAqHwKolfVrOVGhpqo0/6NRn2OSOiE3fAsQISxbJuSA3cc6R9iSxXWDHY+2xBmGmKx/+
        QHp/wRZJCrQO6
X-Received: by 2002:a17:906:7315:: with SMTP id di21mr10130852ejc.511.1625148950314;
        Thu, 01 Jul 2021 07:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8+fZHlQYTx1lHxW02w5jBxsLJMZbpyGox4k3DzlqokvEZ8C1gtgGk7SsPHAZnCXYXlibLVQ==
X-Received: by 2002:a17:906:7315:: with SMTP id di21mr10130826ejc.511.1625148950118;
        Thu, 01 Jul 2021 07:15:50 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id cd4sm10870515ejb.104.2021.07.01.07.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:15:49 -0700 (PDT)
Date:   Thu, 1 Jul 2021 16:15:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Brendan Jackman <jackmanb@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
Message-ID: <YN3OEbjzxPgCWN0v@krava>
References: <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava>
 <YNtEcjYvSvk8uknO@krava>
 <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
 <YNtNMSSZh3LTp2we@krava>
 <YNuL442y2yn5RRdc@krava>
 <CA+i-1C1-7O5EYHZcDtgQaDVrRW+gEQ1WOtiNDZ19NKXUQ_ZLtw@mail.gmail.com>
 <YNxmwZGtnqiXGnF0@krava>
 <CA+i-1C2-MGe0BziQc8t4ry3mj45W0ULVrGsU+uQw9952tFZ1nA@mail.gmail.com>
 <1625133383.8r6ttp782l.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625133383.8r6ttp782l.naveen@linux.ibm.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 01, 2021 at 04:32:03PM +0530, Naveen N. Rao wrote:
> Hi Brendan, Hi Jiri,
> 
> 
> Brendan Jackman wrote:
> > On Wed, 30 Jun 2021 at 14:42, Jiri Olsa <jolsa@redhat.com> wrote:
> > > 
> > > On Wed, Jun 30, 2021 at 12:34:58PM +0200, Brendan Jackman wrote:
> > > > On Tue, 29 Jun 2021 at 23:09, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jun 29, 2021 at 06:41:24PM +0200, Jiri Olsa wrote:
> > > > > > On Tue, Jun 29, 2021 at 06:25:33PM +0200, Brendan Jackman wrote:
> > > > > > > On Tue, 29 Jun 2021 at 18:04, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > > > > On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
> > > > > > > > > On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:
> > > >
> > > > > > > > > > atomics in .imm). Any idea if this test was ever passing on PowerPC?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > hum, I guess not.. will check
> > > > > > > >
> > > > > > > > nope, it locks up the same:
> > > > > > >
> > > > > > > Do you mean it locks up at commit 91c960b0056 too?
> > > >
> > > > Sorry I was being stupid here - the test didn't exist at this commit
> > > >
> > > > > > I tried this one:
> > > > > >   37086bfdc737 bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH
> > > > > >
> > > > > > I will check also 91c960b0056, but I think it's the new test issue
> > > >
> > > > So yeah hard to say whether this was broken on PowerPC all along. How
> > > > hard is it for me to get set up to reproduce the failure? Is there a
> > > > rootfs I can download, and some instructions for running a PowerPC
> > > > QEMU VM? If so if you can also share your config and I'll take a look.
> > > >
> > > > If it's not as simple as that, I'll stare at the code for a while and
> > > > see if anything jumps out.
> > > >
> > > 
> > > I have latest fedora ppc server and compile/install latest bpf-next tree
> > > I think it will be reproduced also on vm, I attached my config
> > 
> > OK, getting set up to boot a PowerPC QEMU isn't practical here unless
> > someone's got commands I can copy-paste (suspect it will need .config
> > hacking too). Looks like you need to build a proper bootloader, and
> > boot an installer disk.
> 
> There are some notes put up here, though we can do better:
> https://github.com/linuxppc/wiki/wiki/Booting-with-Qemu
> 
> If you are familiar with ubuntu/fedora cloud images (and cloud-init), you
> should be able to grab one of the ppc64le images and boot it in qemu:
> https://cloud-images.ubuntu.com/releases/hirsute/release/
> https://alt.fedoraproject.org/alt/
> 
> > 
> > Looked at the code for a bit but nothing jumped out. It seems like the
> > verifier is seeing a BPF_ADD | BPF_FETCH, which means it doesn't
> > detect an infinite loop, but then we lose the BPF_FETCH flag somewhere
> > between do_check in verifier.c and bpf_jit_build_body in
> > bpf_jit_comp64.c. That would explain why we don't get the "eBPF filter
> > atomic op code %02x (@%d) unsupported", and would also explain the
> > lockup because a normal atomic add without fetch would leave BPF R1
> > unchanged.
> > 
> > We should be able to confirm that theory by disassembling the JITted
> > code that gets hexdumped by bpf_jit_dump when bpf_jit_enable is set to
> > 2... at least for PowerPC 32-bit... maybe you could paste those lines
> > into the 64-bit version too? Here's some notes I made for
> > disassembling the hexdump on x86, I guess you'd just need to change
> > the objdump flags:
> > 
> > -- 
> > 
> > - Enable console JIT output:
> > ```shell
> > echo 2 > /proc/sys/net/core/bpf_jit_enable
> > ```
> > - Load & run the program of interest.
> > - Copy the hex code from the kernel console to `/tmp/jit.txt`. Here's what a
> > short program looks like. This includes a line of context - don't paste the
> > `flen=` line.
> > ```
> > [ 79.381020] flen=8 proglen=54 pass=4 image=000000001af6f390
> > from=test_verifier pid=258
> > [ 79.389568] JIT code: 00000000: 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 08 00
> > [ 79.397411] JIT code: 00000010: 00 00 48 c7 45 f8 64 00 00 00 bf 04 00 00 00 48
> > [ 79.405965] JIT code: 00000020: f7 df f0 48 29 7d f8 8b 45 f8 48 83 f8 60 74 02
> > [ 79.414719] JIT code: 00000030: c9 c3 31 c0 eb fa
> > ```
> > - This incantation will split out and decode the hex, then disassemble the
> > result:
> > ```shell
> > cat /tmp/jit.txt | cut -d: -f2- | xxd -r >/tmp/obj && objdump -D -b
> > binary -m i386:x86-64 /tmp/obj
> > ```
> > 
> > --
> > 
> > Sandipan, Naveen, do you know of anything in the PowerPC code that
> > might be leading us to drop the BPF_FETCH flag from the atomic
> > instruction in tools/testing/selftests/bpf/verifier/atomic_bounds.c?
> 
> Yes, I think I just found the issue. We aren't looking at the correct BPF
> instruction when checking the IMM value.

great, nice catch! :-) that fixes it for me.. 

Tested-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> 
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -673,7 +673,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                 * BPF_STX ATOMIC (atomic ops)
>                 */
>                case BPF_STX | BPF_ATOMIC | BPF_W:
> -                       if (insn->imm != BPF_ADD) {
> +                       if (insn[i].imm != BPF_ADD) {
>                                pr_err_ratelimited(
>                                        "eBPF filter atomic op code %02x (@%d) unsupported\n",
>                                        code, i);
> @@ -695,7 +695,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                        PPC_BCC_SHORT(COND_NE, tmp_idx);
>                        break;
>                case BPF_STX | BPF_ATOMIC | BPF_DW:
> -                       if (insn->imm != BPF_ADD) {
> +                       if (insn[i].imm != BPF_ADD) {
>                                pr_err_ratelimited(
>                                        "eBPF filter atomic op code %02x (@%d) unsupported\n",
>                                        code, i);
> 
> 
> 
> Thanks,
> Naveen
> 

