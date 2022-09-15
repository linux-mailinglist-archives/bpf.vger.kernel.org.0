Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E745B93B9
	for <lists+bpf@lfdr.de>; Thu, 15 Sep 2022 06:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIOEod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 00:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIOEoa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 00:44:30 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8DDA8
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 21:44:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n81so13581441iod.6
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 21:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vwQH+FaO6ZKRxhBlRk5DdxjC5gTHQSdTfmGJbrZGEkc=;
        b=iGyDWFlIC6T3wN8q4K9fMckpM0ibtMIW9Tv0TYp7dzzZO/fE3PXTqbknzUzjZhqNtX
         3f1FG4RohtmfCbvnvJvWx2I2c2qb64kfGuMVN0ugiPTWizTPKFiZyJH9Fc2O6uie8WwG
         SWUOhAvd0eVD3jFXPzzt95of/UdWa/F3SQA9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vwQH+FaO6ZKRxhBlRk5DdxjC5gTHQSdTfmGJbrZGEkc=;
        b=jOWUQBv3+zUiAV1hAEOpwy2PP3ik7rpz5IaValqlhMteTz87JE6u4INJDmBN9RaA0V
         E8OoRY6K2yS7UZWrWDp+pCUvd0LDhJuJ8FQWpoSm3mRFdy2O3FY6dHS6Jht0pML/YZ8t
         dF4dDzEyLTY6gRAGkupH3G5qnJdbtnk+EbRiPQBeQsp6Ri3sHvhIGw8UkVmECJ+sw+FH
         QjWl6lEVGjcKJtg3K7EKIVLK55vRgPW2Syh+qVxeupS5m81W+0Y4wXUcHk6uJWuiQ92h
         hDmJ7XaiCuKVSURaNB8nmlNlgCGbjZEvyaErq5dXAJT2aTCEI6w82/qRnlF926nwZNUv
         W9Kw==
X-Gm-Message-State: ACgBeo1vgbn9dGVicaDmjIVs+E1u+9xhAJ/oQZXaWVE2Eev93rMsEC7w
        ouos+s9M0fDq531Gbyln0E/VS06n8NzicXME03npvuQB3zJd6A==
X-Google-Smtp-Source: AA6agR6cv3LNOZP/L93dmi/9AnidcqmF/GmuSveUjshBNfZNnALUOQ2oICy4pFL+nlaprfpdmBymx6W6EHDaa87G3kk=
X-Received: by 2002:a6b:2a83:0:b0:6a1:821a:9d61 with SMTP id
 q125-20020a6b2a83000000b006a1821a9d61mr5353548ioq.25.1663217066913; Wed, 14
 Sep 2022 21:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkUVSMM-+7RzGu0z0nwsWT_2NiUZzTMNKsEc0iOPSiNr9A@mail.gmail.com>
 <1b9e4d2c-34d4-2809-6c91-d14092061581@oracle.com> <CABi2SkVMRtbrzrPeYEhf_zP-9AoUcs10KwJRXXTKPA0K1qY8PQ@mail.gmail.com>
 <CABi2SkXtNOFP1Gg_dDz4bHC=P42iL1DxJ6irfz6T0MeiGkTgCQ@mail.gmail.com>
 <CAK3+h2y-vk9eE0uNDWAQwjAeO1fNaY4Tf9USMPAxqUVuQ7pBrg@mail.gmail.com>
 <CABi2SkWKjBMRBdi=C9ePYDO-2ZofsytdLxc0-N3jMx5JeTsS+Q@mail.gmail.com> <CAK3+h2zp6p=iEGJ0Z8Z=LcsTM19DoxT5cS5cq=Dgspeo=MQgrA@mail.gmail.com>
In-Reply-To: <CAK3+h2zp6p=iEGJ0Z8Z=LcsTM19DoxT5cS5cq=Dgspeo=MQgrA@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 14 Sep 2022 21:44:16 -0700
Message-ID: <CABi2SkUR8qWB=gb_6Hi7ngePHzWAGt2LCVkjwhqV4EYh0hCtvA@mail.gmail.com>
Subject: Re: BTF and libBPF
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 13, 2022 at 10:05 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 11:05 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > On Mon, Sep 12, 2022 at 8:41 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > >
> > > On Mon, Sep 12, 2022 at 5:17 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > > >
> > > > On Sun, Sep 11, 2022 at 4:36 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > > > >
> > > > > Thanks for the quick response.
> > > > >
> > > > > > > Greeting,
> > > > > > >
> > > > > > > I have questions related to CONFIG_DEBUG_INFO_BTF, and  libbpf_0.8.1.
> > > > > > > Please kindly let me know if this is not the right group to ask, since I'm new.
> > > > > > >
> > > > > > > To give context of this question:
> > > > > > > This system has limited disk size, doesn't need the CO-RE feature,
> > > > > > > and has all debug symbols stripped in release build.   Having an extra
> > > > > > > btf/vmlinux file might be problematic, disk-wise.
> > > > >
> > > > > > Thanks for getting in touch - ideally I think we'd like to be
> > > > > > able to support BTF even on small systems. It would probably
> > > > > > help to understand what space constraints you have - is it just
> > > > > > disk space, or are disk space and memory highly constrained? The
> > > > > > mechanics of BTF are that it is generated and then embedded in the vmlinux
> > > > > > binary in a .BTF section. The BTF info is then exposed at runtime
> > > > > > via a /sys/kernel/btf/vmlinux pseudo-file.  So when assessing overhead,
> > > > > > there are two questions to ask I think:
> > > > >
> > > > > > 1. how does BTF inclusion effect disk space?
> > > > > > 2. how does BTF inclusion effect memory footprint?
> > > > >
> > > > > > For 1, on a recent bpf-next kernel, core vmlinux BTF is around 6Mb.
> > > > > > However, an important thing to bear in mind is that it is in the
> > > > > > vmlinux binary, that on most space-constrained systems is compressed
> > > > > > to /boot/vmlinuz-<VERSION>.  When I compress the BTF by hand, it reduces
> > > > > > by a factor of around 6, so a ballpark figure is around 1.5Mb of
> > > > > > the vmlinuz binary on-disk, which equates to around 10% of the overall
> > > > > > binary size in my case. Your results may vary, especially if
> > > > > > a lot of CONFIG options are switched off (as they might be on a
> > > > > > space-sensitive system).
> > > > >
> > > > > > For memory footprint, BTF will be extracted from the .BTF section
> > > > > > and will then take up around 6Mb.
> > > > >
> > > > > > Another piece of the puzzle is module BTF - it contains the
> > > > > > per-module type info not in the core kernel, but again if modules
> > > > > > are compressed, on-disk storage might not be a massive issue.
> > > > >
> > > > > > Anyway, hopefully the above gives you a sense for the kinds of
> > > > > > costs BTF has.
> > > > >
> > > > > Thank you. This information on disk and memory is really helpful.
> > > > > At this moment, I'm only looking at disk-size.
> > > > >
> > > > > > >
> > > > > > > Question 1>
> > > > > > > Will libbpf_0.8.1(or later) work with kernel 5.10 (or later),  without
> > > > > > > CONFIG_DEBUG_INFO_BTF ?
> > > > > > > Or work with kernel compiled with CONFIG_DEBUG_INFO_BTF but have
> > > > > > > /sys/kernel/btf/vmlinux removed.
> > > > > > >
> > > > >
> > > > > > It really depends on what you're planning on doing.
> > > > >
> > > > > > BTF has become central to a lot of aspects of BPF; higher-performance
> > > > > > fentry/fexit() BPF programs, CO-RE, and even XDP will be using BTF
> > > > > > soon I believe.
> > > > >
> > > > > > So if you're using BPF without BTF, there are generally ways to make
> > > > > things work (using kprobes instead of fentry for example), but you
> > > > > > will have less options.  I seem to recall some fixes landed to
> > > > > > ensure that absence of BTF shouldn't prevent program loading in
> > > > > > cases where BTF is not needed. If you run into any such failures,
> > > > > > I'd suggest reporting them and hopefully we can get them fixed.
> > > > >
> > > > > I have a follow up question on how CO-RE uses BTF: where exactly does
> > > > > the relocation happen ?
> > > > > It seems, in theory,  it can happens in two places: 1> from libBPF at
> > > > > user space 2> from kernel
> > > > >
> > > > > https://nakryiko.com/posts/bpf-portability-and-co-re/
> > > > > " It takes compiled BPF ELF object file, post-processes it as
> > > > > necessary, sets up various kernel objects (maps, programs, etc),
> > > > > and triggers BPF program loading and verification."
> > > > >
> > > > > I assume there is a syscall to provide BTF information from kernel to
> > > > > user space, and libBPF uses that info to post-processing the ELF file.
> > > > >
> > > > > Is there a sample BPF code with explanation of a sequence of actions
> > > > > done by libBPF (roughly) to look at ?
> > > > > And why do maps need to be relocated ?
> > > > >
> > > > > 2>
> > > > > https://nakryiko.com/posts/bpf-core-reference-guide/ BTF-enabled BPF
> > > > > program types with direct memory reads
> > > > > In this mode, is that kernel doing relocation ? or is that still libBPF?
> > > > > For example: how/where vma->vm_start is relocated.
> > > > >
> > > > > SEC("lsm/file_mprotect")
> > > > > int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> > > > >     unsigned long reqprot, unsigned long prot, int ret)
> > > > > {
> > > > >    /* .. omit ..*/
> > > > > int is_heap;
> > > > > is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > > > >   vma->vm_end <= vma->vm_mm->brk);
> > > > >    /* .. omit .. */
> > > > > }
> > > > >
> > > > > Thanks
> > > > > Best Regards,
> > > > > Jeff Xu
> > > > >
> > > > >
> > > > > On Fri, Sep 9, 2022 at 8:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > > > >
> > > > > > On 09/09/2022 06:22, Jeff Xu wrote:
> > > > > > > Greeting,
> > > > > > >
> > > > > > > I have questions related to CONFIG_DEBUG_INFO_BTF, and  libbpf_0.8.1.
> > > > > > > Please kindly let me know if this is not the right group to ask, since I'm new.
> > > > > > >
> > > > > > > To give context of this question:
> > > > > > > This system has limited disk size, doesn't need the CO-RE feature,
> > > > > > > and has all debug symbols stripped in release build.   Having an extra
> > > > > > > btf/vmlinux file might be problematic, disk-wise.
> > > > > >
> > > > > > Thanks for getting in touch - ideally I think we'd like to be
> > > > > > able to support BTF even on small systems. It would probably
> > > > > > help to understand what space constraints you have - is it just
> > > > > > disk space, or are disk space and memory highly constrained? The
> > > > > > mechanics of BTF are that it is generated and then embedded in the vmlinux
> > > > > > binary in a .BTF section. The BTF info is then exposed at runtime
> > > > > > via a /sys/kernel/btf/vmlinux pseudo-file.  So when assessing overhead,
> > > > > > there are two questions to ask I think:
> > > > > >
> > > > > > 1. how does BTF inclusion effect disk space?
> > > > > > 2. how does BTF inclusion effect memory footprint?
> > > > > >
> > > > > > For 1, on a recent bpf-next kernel, core vmlinux BTF is around 6Mb.
> > > > > > However, an important thing to bear in mind is that it is in the
> > > > > > vmlinux binary, that on most space-constrained systems is compressed
> > > > > > to /boot/vmlinuz-<VERSION>.  When I compress the BTF by hand, it reduces
> > > > > > by a factor of around 6, so a ballpark figure is around 1.5Mb of
> > > > > > the vmlinuz binary on-disk, which equates to around 10% of the overall
> > > > > > binary size in my case. Your results may vary, especially if
> > > > > > a lot of CONFIG options are switched off (as they might be on a
> > > > > > space-sensitive system).
> > > > > >
> > > > > > For memory footprint, BTF will be extracted from the .BTF section
> > > > > > and will then take up around 6Mb.
> > > > > >
> > > > > > Another piece of the puzzle is module BTF - it contains the
> > > > > > per-module type info not in the core kernel, but again if modules
> > > > > > are compressed, on-disk storage might not be a massive issue.
> > > > > >
> > > > > > Anyway, hopefully the above gives you a sense for the kinds of
> > > > > > costs BTF has.
> > > > > >
> > > > > > >
> > > > > > > Question 1>
> > > > > > > Will libbpf_0.8.1(or later) work with kernel 5.10 (or later),  without
> > > > > > > CONFIG_DEBUG_INFO_BTF ?
> > > > > > > Or work with kernel compiled with CONFIG_DEBUG_INFO_BTF but have
> > > > > > > /sys/kernel/btf/vmlinux removed.
> > > > > > >
> > > > > >
> > > > > > It really depends what you're planning on doing.
> > > > > >
> > > > > > BTF has become central to a lot of aspects of BPF; higher-performance
> > > > > > fentry/fexit() BPF programs, CO-RE, and even XDP will be using BTF
> > > > > > soon I believe.
> > > > > >
> > > > > > So if you're using BPF without BTF, there are generally ways to make
> > > > > > things work (using kprobes instead of fentry for example), but you
> > > > > > will have less options.  I seem to recall some fixes landed to
> > > > > > ensure that absence of BTF shouldn't prevent program loading in
> > > > > > cases where BTF is not needed. If you run into any such failures,
> > > > > > I'd suggest reporting them and hopefully we can get them fixed.
> > > > > >
> > > > > > >  Question 2: From debug information included at run time point of view,
> > > > > > > (1) having btf/vmlinux vs (2) kernel build with
> > > > > > > CONFIG_DEBUG_INFO_DWARF5 but not stripped,
> > > > > > > are those two contains the same amount of debug information at runtime?
> > > > > > >
> > > > > >
> > > > > > DWARF5 will contain more debug info, but will likely have a larger footprint
> > > > > > as a consequence. I'd suggest running the experiment yourself to compare.
> > > > > >
> > > > > > > Question 3: Will libbpf + btf/vmlinx, break expectation of kernel ASLR
> > > > > > > feature ? I assume it shouldn't, but would like to double check.
> > > > > > >
> > > > > >
> > > > > > Nope, no issue here that I'm aware of. I've used KASLR + BTF and haven't seen
> > > > > > any problems at least.
> > > > > >
> > > > > > > Thanks
> > > > > > > Best Regards,
> > > > > > > Jeff Xu
> > > > > > >
> > > >
> > > > Can I understand the BTF usage in this way ?
> > > >
> > > > When BTF is available in the kernel runtime, it helps in two ways:
> > > > 1> By BTF verifier (kernel) to find the offset of a member in struct
> > > > (no libbpf modification of BYTE code needed)
> > > > The example usage is BTF RAW tracepoint, BFP_LSM.
> > > > Typically, those BPF programs will includes "vmlinux.h" , and  uses C
> > > > pointer style(vma->vm_start)
> > > >
> > > > 2> By libbpf (user space) to post-processing BPF bytecode.
> > > > Typically, those BPF programs doesn't need to include "vmlinux.h", and
> > > > uses bpf_core_read, such as:
> > > > BPF_CORE_READ(vma,vm_start)
> > > >
> > > > Much appreciated to confirm this is right/wrong.
> > > >
> > >
> > > Does not answer your question directly :) from my limited
> > > understanding, could be incorrect, BTF is processed at compile time
> > > and load time,  load time is processed  by libbpf
> > >
> > So even for BTF RAW tracepoint, the relocation is happening at libbpf ?
> > According to this post:
> > https://mozillazg.com/2022/06/ebpf-libbpf-btf-powered-enabled-raw-tracepoint-common-questions-en.html#hidthe-difference-between-btf-raw-tracepoint-and-raw-tracepoint
> >
> > // btf enabled
> > struct task_struct *task = (struct task_struct *) bpf_get_current_task_btf();
> > u32 ppid = task->real_parent->tgid;
> >
> > "The btf version can access kernel memory directly from within the ebpf program.
> > There is no need to use a helper function like bpf_core_read or
> > bpf_probe_read_kernel to access the kernel memory as in regular raw
> > tracepoint:"
> >
> > It talks about accessing kernel memory directly, so I was reading it
> > as  the kernel is doing the relocation.
> >
>
> Would this help ?
> https://lore.kernel.org/bpf/20191016032505.2089704-6-ast@kernel.org/
>
I'm not sure. But thanks.

Another way to look is through  objdump of the BPF bytecode
1> direct memory read.
SEC("lsm/bprm_committed_creds")
int BPF_PROG(handle_committed_creds, struct linux_binprm* binprm) {
  struct task_struct* task;
  task = (struct task_struct*)bpf_get_current_task_btf();
  return task->real_parent->tgid;
}

0000000000000000 <handle_committed_creds>:
       0: 85 00 00 00 9e 00 00 00 call 158
       1: 79 01 b0 05 00 00 00 00 r1 = *(u64 *)(r0 + 1456)
       2: 61 10 a4 05 00 00 00 00 r0 = *(u32 *)(r1 + 1444)
       3: 95 00 00 00 00 00 00 00 exit

2> relocate by libbpf.
SEC("lsm/bprm_committed_creds")
int BPF_PROG(handle_committed_creds, struct linux_binprm* binprm) {
  struct task_struct* task;
  task = (struct task_struct*)bpf_get_current_task();
  return BPF_CORE_READ(task,real_parent,tgid);
}

0000000000000000 <handle_committed_creds>:
       0: 85 00 00 00 23 00 00 00 call 35
       1: b7 01 00 00 b0 05 00 00 r1 = 1456
       2: 0f 10 00 00 00 00 00 00 r0 += r1
       3: bf a1 00 00 00 00 00 00 r1 = r10
       4: 07 01 00 00 f0 ff ff ff r1 += -16
       5: b7 02 00 00 08 00 00 00 r2 = 8
       6: bf 03 00 00 00 00 00 00 r3 = r0
       7: 85 00 00 00 71 00 00 00 call 113    <-------- (probably
bpf_probe_read_kernel ?)
       8: b7 01 00 00 a4 05 00 00 r1 = 1444
       9: 79 a3 f0 ff 00 00 00 00 r3 = *(u64 *)(r10 - 16)
      10: 0f 13 00 00 00 00 00 00 r3 += r1
      11: bf a1 00 00 00 00 00 00 r1 = r10
      12: 07 01 00 00 fc ff ff ff r1 += -4
      13: b7 02 00 00 04 00 00 00 r2 = 4
      14: 85 00 00 00 71 00 00 00 call 113. <----------
      15: 61 a0 fc ff 00 00 00 00 r0 = *(u32 *)(r10 - 4)
      16: 95 00 00 00 00 00 00 00 exit

For 1> (direct address read)
the member offset is already in the code, I assume no relocation needed.

For 2> (bfp_core_read)
My guess is that libbpf will relocate/change this code, for example,
when offset "real_parent" changes within the task struct, and libbpf
did this using some information from the elf section.

Thanks
Jeff.
