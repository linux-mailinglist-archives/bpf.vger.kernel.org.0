Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A245B679C
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 08:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiIMGFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 02:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIMGFM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 02:05:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DB23163
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 23:05:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id b17so5734084ilh.0
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 23:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=88jYKV7igQaRKAMJcSp0mGuxY/bE0FgorkyjjO0srL8=;
        b=jMDejXSCQ+bDOZStTbaJDPxpZXrH724CoZfBPrnH5Vbk/FNuKpFeeZvMBSgUfNzoIe
         dKFUHBlDwzMm/yAmR8fRuP/AnFqD5TmTTkWJ12zfQNoih/7iEojgHq21rksdkGRaJMwj
         R3obRO3pj+hjepSqp5uBCv/6leYWgHUsxp95Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=88jYKV7igQaRKAMJcSp0mGuxY/bE0FgorkyjjO0srL8=;
        b=j9eIdkWfJIBxocppqhUV2UPM9M535rHRpxX6sghU82h3B6LGW4mCzSE1j2tRbt3ddv
         bnUTLijSTLPCWOTC+IaNOSoQQkOfd9Pw1jMjl+Y1cSNYtXd3yLqC4n++++QkAes9QR3E
         uwFZGigxih3mh7z2yDVCycgY3f4/p+SzVmS+YGA8ByB7HttHPuoZ/cOtxdOad56YqJUK
         /xzcQyohjFtFtG+evhMmNmVtiDLpOjuVyvnislWKw+ARYWzTJAChMYke7Ztpb5aJi4+i
         InjZmv/ysJfbu89O+CIHc0yqbMlcuiH71BwG4k/oQQM7sKr52vgqLUrS2wjhYINScvuy
         uXzg==
X-Gm-Message-State: ACgBeo2VBev7WUAmc+92VjT/NmM1XK4epu8iL9wTAqP7wwxRlChVMzCS
        LYWVT3SOm2xT1aHgovTLHrswjSv2Kmz6b/Fe3hnG9g==
X-Google-Smtp-Source: AA6agR7nSGwJ0B2Sx1bNlAeKKmAbTnuZ9cFI1NdIqt/OD7MOtOhxTJZIpEEyV2WWACSv/YRb6sLw9Vq3W5NK1EmMJvc=
X-Received: by 2002:a05:6e02:158a:b0:2d3:f1c0:6b68 with SMTP id
 m10-20020a056e02158a00b002d3f1c06b68mr12401276ilu.38.1663049110051; Mon, 12
 Sep 2022 23:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkUVSMM-+7RzGu0z0nwsWT_2NiUZzTMNKsEc0iOPSiNr9A@mail.gmail.com>
 <1b9e4d2c-34d4-2809-6c91-d14092061581@oracle.com> <CABi2SkVMRtbrzrPeYEhf_zP-9AoUcs10KwJRXXTKPA0K1qY8PQ@mail.gmail.com>
 <CABi2SkXtNOFP1Gg_dDz4bHC=P42iL1DxJ6irfz6T0MeiGkTgCQ@mail.gmail.com> <CAK3+h2y-vk9eE0uNDWAQwjAeO1fNaY4Tf9USMPAxqUVuQ7pBrg@mail.gmail.com>
In-Reply-To: <CAK3+h2y-vk9eE0uNDWAQwjAeO1fNaY4Tf9USMPAxqUVuQ7pBrg@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 12 Sep 2022 23:04:59 -0700
Message-ID: <CABi2SkWKjBMRBdi=C9ePYDO-2ZofsytdLxc0-N3jMx5JeTsS+Q@mail.gmail.com>
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

On Mon, Sep 12, 2022 at 8:41 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 5:17 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > On Sun, Sep 11, 2022 at 4:36 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > >
> > > Thanks for the quick response.
> > >
> > > > > Greeting,
> > > > >
> > > > > I have questions related to CONFIG_DEBUG_INFO_BTF, and  libbpf_0.8.1.
> > > > > Please kindly let me know if this is not the right group to ask, since I'm new.
> > > > >
> > > > > To give context of this question:
> > > > > This system has limited disk size, doesn't need the CO-RE feature,
> > > > > and has all debug symbols stripped in release build.   Having an extra
> > > > > btf/vmlinux file might be problematic, disk-wise.
> > >
> > > > Thanks for getting in touch - ideally I think we'd like to be
> > > > able to support BTF even on small systems. It would probably
> > > > help to understand what space constraints you have - is it just
> > > > disk space, or are disk space and memory highly constrained? The
> > > > mechanics of BTF are that it is generated and then embedded in the vmlinux
> > > > binary in a .BTF section. The BTF info is then exposed at runtime
> > > > via a /sys/kernel/btf/vmlinux pseudo-file.  So when assessing overhead,
> > > > there are two questions to ask I think:
> > >
> > > > 1. how does BTF inclusion effect disk space?
> > > > 2. how does BTF inclusion effect memory footprint?
> > >
> > > > For 1, on a recent bpf-next kernel, core vmlinux BTF is around 6Mb.
> > > > However, an important thing to bear in mind is that it is in the
> > > > vmlinux binary, that on most space-constrained systems is compressed
> > > > to /boot/vmlinuz-<VERSION>.  When I compress the BTF by hand, it reduces
> > > > by a factor of around 6, so a ballpark figure is around 1.5Mb of
> > > > the vmlinuz binary on-disk, which equates to around 10% of the overall
> > > > binary size in my case. Your results may vary, especially if
> > > > a lot of CONFIG options are switched off (as they might be on a
> > > > space-sensitive system).
> > >
> > > > For memory footprint, BTF will be extracted from the .BTF section
> > > > and will then take up around 6Mb.
> > >
> > > > Another piece of the puzzle is module BTF - it contains the
> > > > per-module type info not in the core kernel, but again if modules
> > > > are compressed, on-disk storage might not be a massive issue.
> > >
> > > > Anyway, hopefully the above gives you a sense for the kinds of
> > > > costs BTF has.
> > >
> > > Thank you. This information on disk and memory is really helpful.
> > > At this moment, I'm only looking at disk-size.
> > >
> > > > >
> > > > > Question 1>
> > > > > Will libbpf_0.8.1(or later) work with kernel 5.10 (or later),  without
> > > > > CONFIG_DEBUG_INFO_BTF ?
> > > > > Or work with kernel compiled with CONFIG_DEBUG_INFO_BTF but have
> > > > > /sys/kernel/btf/vmlinux removed.
> > > > >
> > >
> > > > It really depends on what you're planning on doing.
> > >
> > > > BTF has become central to a lot of aspects of BPF; higher-performance
> > > > fentry/fexit() BPF programs, CO-RE, and even XDP will be using BTF
> > > > soon I believe.
> > >
> > > > So if you're using BPF without BTF, there are generally ways to make
> > > things work (using kprobes instead of fentry for example), but you
> > > > will have less options.  I seem to recall some fixes landed to
> > > > ensure that absence of BTF shouldn't prevent program loading in
> > > > cases where BTF is not needed. If you run into any such failures,
> > > > I'd suggest reporting them and hopefully we can get them fixed.
> > >
> > > I have a follow up question on how CO-RE uses BTF: where exactly does
> > > the relocation happen ?
> > > It seems, in theory,  it can happens in two places: 1> from libBPF at
> > > user space 2> from kernel
> > >
> > > https://nakryiko.com/posts/bpf-portability-and-co-re/
> > > " It takes compiled BPF ELF object file, post-processes it as
> > > necessary, sets up various kernel objects (maps, programs, etc),
> > > and triggers BPF program loading and verification."
> > >
> > > I assume there is a syscall to provide BTF information from kernel to
> > > user space, and libBPF uses that info to post-processing the ELF file.
> > >
> > > Is there a sample BPF code with explanation of a sequence of actions
> > > done by libBPF (roughly) to look at ?
> > > And why do maps need to be relocated ?
> > >
> > > 2>
> > > https://nakryiko.com/posts/bpf-core-reference-guide/ BTF-enabled BPF
> > > program types with direct memory reads
> > > In this mode, is that kernel doing relocation ? or is that still libBPF?
> > > For example: how/where vma->vm_start is relocated.
> > >
> > > SEC("lsm/file_mprotect")
> > > int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> > >     unsigned long reqprot, unsigned long prot, int ret)
> > > {
> > >    /* .. omit ..*/
> > > int is_heap;
> > > is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > >   vma->vm_end <= vma->vm_mm->brk);
> > >    /* .. omit .. */
> > > }
> > >
> > > Thanks
> > > Best Regards,
> > > Jeff Xu
> > >
> > >
> > > On Fri, Sep 9, 2022 at 8:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >
> > > > On 09/09/2022 06:22, Jeff Xu wrote:
> > > > > Greeting,
> > > > >
> > > > > I have questions related to CONFIG_DEBUG_INFO_BTF, and  libbpf_0.8.1.
> > > > > Please kindly let me know if this is not the right group to ask, since I'm new.
> > > > >
> > > > > To give context of this question:
> > > > > This system has limited disk size, doesn't need the CO-RE feature,
> > > > > and has all debug symbols stripped in release build.   Having an extra
> > > > > btf/vmlinux file might be problematic, disk-wise.
> > > >
> > > > Thanks for getting in touch - ideally I think we'd like to be
> > > > able to support BTF even on small systems. It would probably
> > > > help to understand what space constraints you have - is it just
> > > > disk space, or are disk space and memory highly constrained? The
> > > > mechanics of BTF are that it is generated and then embedded in the vmlinux
> > > > binary in a .BTF section. The BTF info is then exposed at runtime
> > > > via a /sys/kernel/btf/vmlinux pseudo-file.  So when assessing overhead,
> > > > there are two questions to ask I think:
> > > >
> > > > 1. how does BTF inclusion effect disk space?
> > > > 2. how does BTF inclusion effect memory footprint?
> > > >
> > > > For 1, on a recent bpf-next kernel, core vmlinux BTF is around 6Mb.
> > > > However, an important thing to bear in mind is that it is in the
> > > > vmlinux binary, that on most space-constrained systems is compressed
> > > > to /boot/vmlinuz-<VERSION>.  When I compress the BTF by hand, it reduces
> > > > by a factor of around 6, so a ballpark figure is around 1.5Mb of
> > > > the vmlinuz binary on-disk, which equates to around 10% of the overall
> > > > binary size in my case. Your results may vary, especially if
> > > > a lot of CONFIG options are switched off (as they might be on a
> > > > space-sensitive system).
> > > >
> > > > For memory footprint, BTF will be extracted from the .BTF section
> > > > and will then take up around 6Mb.
> > > >
> > > > Another piece of the puzzle is module BTF - it contains the
> > > > per-module type info not in the core kernel, but again if modules
> > > > are compressed, on-disk storage might not be a massive issue.
> > > >
> > > > Anyway, hopefully the above gives you a sense for the kinds of
> > > > costs BTF has.
> > > >
> > > > >
> > > > > Question 1>
> > > > > Will libbpf_0.8.1(or later) work with kernel 5.10 (or later),  without
> > > > > CONFIG_DEBUG_INFO_BTF ?
> > > > > Or work with kernel compiled with CONFIG_DEBUG_INFO_BTF but have
> > > > > /sys/kernel/btf/vmlinux removed.
> > > > >
> > > >
> > > > It really depends what you're planning on doing.
> > > >
> > > > BTF has become central to a lot of aspects of BPF; higher-performance
> > > > fentry/fexit() BPF programs, CO-RE, and even XDP will be using BTF
> > > > soon I believe.
> > > >
> > > > So if you're using BPF without BTF, there are generally ways to make
> > > > things work (using kprobes instead of fentry for example), but you
> > > > will have less options.  I seem to recall some fixes landed to
> > > > ensure that absence of BTF shouldn't prevent program loading in
> > > > cases where BTF is not needed. If you run into any such failures,
> > > > I'd suggest reporting them and hopefully we can get them fixed.
> > > >
> > > > >  Question 2: From debug information included at run time point of view,
> > > > > (1) having btf/vmlinux vs (2) kernel build with
> > > > > CONFIG_DEBUG_INFO_DWARF5 but not stripped,
> > > > > are those two contains the same amount of debug information at runtime?
> > > > >
> > > >
> > > > DWARF5 will contain more debug info, but will likely have a larger footprint
> > > > as a consequence. I'd suggest running the experiment yourself to compare.
> > > >
> > > > > Question 3: Will libbpf + btf/vmlinx, break expectation of kernel ASLR
> > > > > feature ? I assume it shouldn't, but would like to double check.
> > > > >
> > > >
> > > > Nope, no issue here that I'm aware of. I've used KASLR + BTF and haven't seen
> > > > any problems at least.
> > > >
> > > > > Thanks
> > > > > Best Regards,
> > > > > Jeff Xu
> > > > >
> >
> > Can I understand the BTF usage in this way ?
> >
> > When BTF is available in the kernel runtime, it helps in two ways:
> > 1> By BTF verifier (kernel) to find the offset of a member in struct
> > (no libbpf modification of BYTE code needed)
> > The example usage is BTF RAW tracepoint, BFP_LSM.
> > Typically, those BPF programs will includes "vmlinux.h" , and  uses C
> > pointer style(vma->vm_start)
> >
> > 2> By libbpf (user space) to post-processing BPF bytecode.
> > Typically, those BPF programs doesn't need to include "vmlinux.h", and
> > uses bpf_core_read, such as:
> > BPF_CORE_READ(vma,vm_start)
> >
> > Much appreciated to confirm this is right/wrong.
> >
>
> Does not answer your question directly :) from my limited
> understanding, could be incorrect, BTF is processed at compile time
> and load time,  load time is processed  by libbpf
>
So even for BTF RAW tracepoint, the relocation is happening at libbpf ?
According to this post:
https://mozillazg.com/2022/06/ebpf-libbpf-btf-powered-enabled-raw-tracepoint-common-questions-en.html#hidthe-difference-between-btf-raw-tracepoint-and-raw-tracepoint

// btf enabled
struct task_struct *task = (struct task_struct *) bpf_get_current_task_btf();
u32 ppid = task->real_parent->tgid;

"The btf version can access kernel memory directly from within the ebpf program.
There is no need to use a helper function like bpf_core_read or
bpf_probe_read_kernel to access the kernel memory as in regular raw
tracepoint:"

It talks about accessing kernel memory directly, so I was reading it
as  the kernel is doing the relocation.

> > Best Regards
> > Jeff Xu
