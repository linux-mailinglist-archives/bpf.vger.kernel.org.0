Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CCE5B663D
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 05:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIMDlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 23:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIMDle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 23:41:34 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D045441D3F
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 20:41:32 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id x66so5194506vkb.8
        for <bpf@vger.kernel.org>; Mon, 12 Sep 2022 20:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1VFpHF1nfvrHi7mH4XH8LGE8qA6FwDGPQC0p7uWxDII=;
        b=QGA/Rs3lMGPVgim8DQu4FH1AeiQdo53wviiJHtLt7wmyqd/shGZTrNmspzrnW71wKR
         gu0CeBSf3NtjxsFlxPgfP2PNksl8fv75nTCqllzPOO8QgmnfdV1P0bnDpAiLSSeQuMQG
         RKxg7aUuzsn6GqOp2ioFTu6bcTAIV1Sjz5WIo2L9s9QasJ2aoJ1n74IVZPdRTSqSYJMi
         eUpVt0Ldp56HVvkG2+HuggKBC8jVFzTQhkSGzAp4wVFB82i9Lxm2/kJlYSCMOPzefC6H
         A0gb7+tLfJgis0CM9KugrrUEwRs+Qw7/wosaC70ZFnLUvvc0Ym7Xy1AMDEovSSJGLACA
         JU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1VFpHF1nfvrHi7mH4XH8LGE8qA6FwDGPQC0p7uWxDII=;
        b=49pbxjvC29hYZ828OG5THXh9yk8goQizlrOkOhcWkEITNNzgrc6bL+GNzHfRr3R2zp
         rMyWiQYt9QoXuOOLOymhycPjEWka2owCbg2CagrHqwzA1FBcwX0bzlWFIOscP7VgHOyl
         BVbSyQghvPJXY8LecaCYBCHNXr7yXYD0mCoS8+BBXFbIs5NUW1gVnuLCfpNs02qkkLAf
         Ed07h9tOHbhi09JYkz/2xTwjB3qWRtPqRsb3wSgAr/Oi9qcSQzCSe/4ijHkcWUlw/Gen
         x8s/+9k1qsIlj+0PTSHPcSTZm3gW0+Pocy5758iVLc6PZx8ggdSInDYMAmmUIOAoUt/I
         Gwtw==
X-Gm-Message-State: ACgBeo0HgUDLyRFypGfU8GkGsNsUkz3NdTq15ssfVQwB3qaIYuB6lgcY
        Vzj0gE3kdu7/hudwJSCgzlR29MViZcPSPoyrpo9v0mAyRTs=
X-Google-Smtp-Source: AA6agR6+3JRsIIfKND6XQkAWc/A9T/CfBVHiRGyty+oBIw7OA9LXOyPADIcLaDWMlo9T+wL7y1vPOB+d/TRMQXJVd3I=
X-Received: by 2002:a1f:e5c4:0:b0:3a2:1fef:7a13 with SMTP id
 c187-20020a1fe5c4000000b003a21fef7a13mr3407980vkh.13.1663040491793; Mon, 12
 Sep 2022 20:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkUVSMM-+7RzGu0z0nwsWT_2NiUZzTMNKsEc0iOPSiNr9A@mail.gmail.com>
 <1b9e4d2c-34d4-2809-6c91-d14092061581@oracle.com> <CABi2SkVMRtbrzrPeYEhf_zP-9AoUcs10KwJRXXTKPA0K1qY8PQ@mail.gmail.com>
 <CABi2SkXtNOFP1Gg_dDz4bHC=P42iL1DxJ6irfz6T0MeiGkTgCQ@mail.gmail.com>
In-Reply-To: <CABi2SkXtNOFP1Gg_dDz4bHC=P42iL1DxJ6irfz6T0MeiGkTgCQ@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Mon, 12 Sep 2022 20:41:20 -0700
Message-ID: <CAK3+h2y-vk9eE0uNDWAQwjAeO1fNaY4Tf9USMPAxqUVuQ7pBrg@mail.gmail.com>
Subject: Re: BTF and libBPF
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
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

On Mon, Sep 12, 2022 at 5:17 PM Jeff Xu <jeffxu@chromium.org> wrote:
>
> On Sun, Sep 11, 2022 at 4:36 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > Thanks for the quick response.
> >
> > > > Greeting,
> > > >
> > > > I have questions related to CONFIG_DEBUG_INFO_BTF, and  libbpf_0.8.1.
> > > > Please kindly let me know if this is not the right group to ask, since I'm new.
> > > >
> > > > To give context of this question:
> > > > This system has limited disk size, doesn't need the CO-RE feature,
> > > > and has all debug symbols stripped in release build.   Having an extra
> > > > btf/vmlinux file might be problematic, disk-wise.
> >
> > > Thanks for getting in touch - ideally I think we'd like to be
> > > able to support BTF even on small systems. It would probably
> > > help to understand what space constraints you have - is it just
> > > disk space, or are disk space and memory highly constrained? The
> > > mechanics of BTF are that it is generated and then embedded in the vmlinux
> > > binary in a .BTF section. The BTF info is then exposed at runtime
> > > via a /sys/kernel/btf/vmlinux pseudo-file.  So when assessing overhead,
> > > there are two questions to ask I think:
> >
> > > 1. how does BTF inclusion effect disk space?
> > > 2. how does BTF inclusion effect memory footprint?
> >
> > > For 1, on a recent bpf-next kernel, core vmlinux BTF is around 6Mb.
> > > However, an important thing to bear in mind is that it is in the
> > > vmlinux binary, that on most space-constrained systems is compressed
> > > to /boot/vmlinuz-<VERSION>.  When I compress the BTF by hand, it reduces
> > > by a factor of around 6, so a ballpark figure is around 1.5Mb of
> > > the vmlinuz binary on-disk, which equates to around 10% of the overall
> > > binary size in my case. Your results may vary, especially if
> > > a lot of CONFIG options are switched off (as they might be on a
> > > space-sensitive system).
> >
> > > For memory footprint, BTF will be extracted from the .BTF section
> > > and will then take up around 6Mb.
> >
> > > Another piece of the puzzle is module BTF - it contains the
> > > per-module type info not in the core kernel, but again if modules
> > > are compressed, on-disk storage might not be a massive issue.
> >
> > > Anyway, hopefully the above gives you a sense for the kinds of
> > > costs BTF has.
> >
> > Thank you. This information on disk and memory is really helpful.
> > At this moment, I'm only looking at disk-size.
> >
> > > >
> > > > Question 1>
> > > > Will libbpf_0.8.1(or later) work with kernel 5.10 (or later),  without
> > > > CONFIG_DEBUG_INFO_BTF ?
> > > > Or work with kernel compiled with CONFIG_DEBUG_INFO_BTF but have
> > > > /sys/kernel/btf/vmlinux removed.
> > > >
> >
> > > It really depends on what you're planning on doing.
> >
> > > BTF has become central to a lot of aspects of BPF; higher-performance
> > > fentry/fexit() BPF programs, CO-RE, and even XDP will be using BTF
> > > soon I believe.
> >
> > > So if you're using BPF without BTF, there are generally ways to make
> > things work (using kprobes instead of fentry for example), but you
> > > will have less options.  I seem to recall some fixes landed to
> > > ensure that absence of BTF shouldn't prevent program loading in
> > > cases where BTF is not needed. If you run into any such failures,
> > > I'd suggest reporting them and hopefully we can get them fixed.
> >
> > I have a follow up question on how CO-RE uses BTF: where exactly does
> > the relocation happen ?
> > It seems, in theory,  it can happens in two places: 1> from libBPF at
> > user space 2> from kernel
> >
> > https://nakryiko.com/posts/bpf-portability-and-co-re/
> > " It takes compiled BPF ELF object file, post-processes it as
> > necessary, sets up various kernel objects (maps, programs, etc),
> > and triggers BPF program loading and verification."
> >
> > I assume there is a syscall to provide BTF information from kernel to
> > user space, and libBPF uses that info to post-processing the ELF file.
> >
> > Is there a sample BPF code with explanation of a sequence of actions
> > done by libBPF (roughly) to look at ?
> > And why do maps need to be relocated ?
> >
> > 2>
> > https://nakryiko.com/posts/bpf-core-reference-guide/ BTF-enabled BPF
> > program types with direct memory reads
> > In this mode, is that kernel doing relocation ? or is that still libBPF?
> > For example: how/where vma->vm_start is relocated.
> >
> > SEC("lsm/file_mprotect")
> > int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> >     unsigned long reqprot, unsigned long prot, int ret)
> > {
> >    /* .. omit ..*/
> > int is_heap;
> > is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> >   vma->vm_end <= vma->vm_mm->brk);
> >    /* .. omit .. */
> > }
> >
> > Thanks
> > Best Regards,
> > Jeff Xu
> >
> >
> > On Fri, Sep 9, 2022 at 8:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > On 09/09/2022 06:22, Jeff Xu wrote:
> > > > Greeting,
> > > >
> > > > I have questions related to CONFIG_DEBUG_INFO_BTF, and  libbpf_0.8.1.
> > > > Please kindly let me know if this is not the right group to ask, since I'm new.
> > > >
> > > > To give context of this question:
> > > > This system has limited disk size, doesn't need the CO-RE feature,
> > > > and has all debug symbols stripped in release build.   Having an extra
> > > > btf/vmlinux file might be problematic, disk-wise.
> > >
> > > Thanks for getting in touch - ideally I think we'd like to be
> > > able to support BTF even on small systems. It would probably
> > > help to understand what space constraints you have - is it just
> > > disk space, or are disk space and memory highly constrained? The
> > > mechanics of BTF are that it is generated and then embedded in the vmlinux
> > > binary in a .BTF section. The BTF info is then exposed at runtime
> > > via a /sys/kernel/btf/vmlinux pseudo-file.  So when assessing overhead,
> > > there are two questions to ask I think:
> > >
> > > 1. how does BTF inclusion effect disk space?
> > > 2. how does BTF inclusion effect memory footprint?
> > >
> > > For 1, on a recent bpf-next kernel, core vmlinux BTF is around 6Mb.
> > > However, an important thing to bear in mind is that it is in the
> > > vmlinux binary, that on most space-constrained systems is compressed
> > > to /boot/vmlinuz-<VERSION>.  When I compress the BTF by hand, it reduces
> > > by a factor of around 6, so a ballpark figure is around 1.5Mb of
> > > the vmlinuz binary on-disk, which equates to around 10% of the overall
> > > binary size in my case. Your results may vary, especially if
> > > a lot of CONFIG options are switched off (as they might be on a
> > > space-sensitive system).
> > >
> > > For memory footprint, BTF will be extracted from the .BTF section
> > > and will then take up around 6Mb.
> > >
> > > Another piece of the puzzle is module BTF - it contains the
> > > per-module type info not in the core kernel, but again if modules
> > > are compressed, on-disk storage might not be a massive issue.
> > >
> > > Anyway, hopefully the above gives you a sense for the kinds of
> > > costs BTF has.
> > >
> > > >
> > > > Question 1>
> > > > Will libbpf_0.8.1(or later) work with kernel 5.10 (or later),  without
> > > > CONFIG_DEBUG_INFO_BTF ?
> > > > Or work with kernel compiled with CONFIG_DEBUG_INFO_BTF but have
> > > > /sys/kernel/btf/vmlinux removed.
> > > >
> > >
> > > It really depends what you're planning on doing.
> > >
> > > BTF has become central to a lot of aspects of BPF; higher-performance
> > > fentry/fexit() BPF programs, CO-RE, and even XDP will be using BTF
> > > soon I believe.
> > >
> > > So if you're using BPF without BTF, there are generally ways to make
> > > things work (using kprobes instead of fentry for example), but you
> > > will have less options.  I seem to recall some fixes landed to
> > > ensure that absence of BTF shouldn't prevent program loading in
> > > cases where BTF is not needed. If you run into any such failures,
> > > I'd suggest reporting them and hopefully we can get them fixed.
> > >
> > > >  Question 2: From debug information included at run time point of view,
> > > > (1) having btf/vmlinux vs (2) kernel build with
> > > > CONFIG_DEBUG_INFO_DWARF5 but not stripped,
> > > > are those two contains the same amount of debug information at runtime?
> > > >
> > >
> > > DWARF5 will contain more debug info, but will likely have a larger footprint
> > > as a consequence. I'd suggest running the experiment yourself to compare.
> > >
> > > > Question 3: Will libbpf + btf/vmlinx, break expectation of kernel ASLR
> > > > feature ? I assume it shouldn't, but would like to double check.
> > > >
> > >
> > > Nope, no issue here that I'm aware of. I've used KASLR + BTF and haven't seen
> > > any problems at least.
> > >
> > > > Thanks
> > > > Best Regards,
> > > > Jeff Xu
> > > >
>
> Can I understand the BTF usage in this way ?
>
> When BTF is available in the kernel runtime, it helps in two ways:
> 1> By BTF verifier (kernel) to find the offset of a member in struct
> (no libbpf modification of BYTE code needed)
> The example usage is BTF RAW tracepoint, BFP_LSM.
> Typically, those BPF programs will includes "vmlinux.h" , and  uses C
> pointer style(vma->vm_start)
>
> 2> By libbpf (user space) to post-processing BPF bytecode.
> Typically, those BPF programs doesn't need to include "vmlinux.h", and
> uses bpf_core_read, such as:
> BPF_CORE_READ(vma,vm_start)
>
> Much appreciated to confirm this is right/wrong.
>

Does not answer your question directly :) from my limited
understanding, could be incorrect, BTF is processed at compile time
and load time,  load time is processed  by libbpf

> Best Regards
> Jeff Xu
