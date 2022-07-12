Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7277F5711A5
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 07:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiGLFBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 01:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLFBA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 01:01:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6B08C74A
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 22:00:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dn9so12283006ejc.7
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 22:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ClKmRoVQoWjI5dm++xn0518dsabcZQwmRaoZym9hsM=;
        b=h58M/A90ZGIOEeEyHxKYtEGt2g4VaVp3xWARwZfEmajXKLXcgfuWqFvop1HZaBprUC
         vjf5NNIZ6zecNO0DBaV27qPh3cZM2LJ9hVxeh8gwSwTrxePs739NdXu3kspKtlNc3zR4
         pTD9qHdNxr9Dafmg6O0KTP9t5W3R5PtAtyF0Cz4HDh503aWiFMVOUdTb3wvpihUEK42C
         lSviOWymI0iRiKTulUmPRIz5zcdzanQt108FLbQqkZkQ0RRign811dcPpC0eq2bisYSc
         FR9lzgyX7KuHtt37Lk2szphiUdY+X8jEuHHA3WBfL27lWcW9uJTmS/KN9pJUV48+Lnjh
         e1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ClKmRoVQoWjI5dm++xn0518dsabcZQwmRaoZym9hsM=;
        b=P1zqA4ZyefW71KeX4VbAYyV0gk+8phb3jV0G2HbETQolypmjqO+3O0825cBs/+ET55
         A017U8pVg9UGJSnmVKL3XQw9lt9gQP/zhZj5/psLVUWAjb+EKK5Zo0p1MCSNX8x75uiu
         STu1qhwKjvf1hGkdC/GJyp8Xb3MyhlB2tHt/1dYYnmS0tp3bRR+sVAOVWh6grCXf7AeG
         /j+6CFcE2QvZ3RubkAqkp4XhjCY56XJM/smVseN5MQEN5bnxRXRk9avZMK22C5KMG6mT
         wq0dio7r04Z+uWD7z+kfgH6Q+VYiKau2WMT6NX/du4Iauo8wYHxnE9WLP1dyulMjyt7J
         gJ+Q==
X-Gm-Message-State: AJIora/9pyBNsCim/yOPe/yjbeKAONj908tXIOPZRbqJL6ZWYuS+N3IT
        5PmmeHwwKiGCpJhaFp2/OKVVrZF4o6hm1VidRsEEg7ujEANLOw==
X-Google-Smtp-Source: AGRyM1vIA/00uBxmJpbPrsIffQdezw2fMiwQG39vGPTUi0lynPGfZGG8Nptr5cBnfTzkkhDUS0z5mqEN2ihdUj56LLY=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr22062948ejc.745.1657602057356; Mon, 11
 Jul 2022 22:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <20220707004118.298323-3-andrii@kernel.org>
 <CAADnVQLxWDD3AAp73BcXW4ArWMgJ-fSUzSjw=-gzq=azBrXdqA@mail.gmail.com>
 <CAEf4BzaXBD86k8BYv7q4fFeyHALHcVUCbSpSG4=kfC0orydrCQ@mail.gmail.com>
 <YsgU1kjVndNjJhI8@krava> <CAEf4BzapNiTTV18guaXz_e1nY9jbybZVTWXUM7sPNqJd=Cau+w@mail.gmail.com>
 <CAADnVQLeEz8NLf9b4reOKdyrtneHcv4ExSGn7Z8ysk1nYSayYw@mail.gmail.com>
 <CAEf4BzYKkf0A1LqLqbjUqO6CMWDRVqg9OBizfwuZL-0p4ioRJg@mail.gmail.com> <20220712042025.ku6mxlhk3itthzvf@macbook-pro-3.dhcp.thefacebook.com>
In-Reply-To: <20220712042025.ku6mxlhk3itthzvf@macbook-pro-3.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jul 2022 22:00:46 -0700
Message-ID: <CAEf4BzZgA8R1Uv86XrqAuAvYg2uS+-_jJr_k2oQ_YXp2wDSM0Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
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

On Mon, Jul 11, 2022 at 9:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 09:28:29AM -0700, Andrii Nakryiko wrote:
> > On Sat, Jul 9, 2022 at 5:38 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 8, 2022 at 3:05 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 8, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jul 07, 2022 at 12:10:30PM -0700, Andrii Nakryiko wrote:
> > > > >
> > > > > SNIP
> > > > >
> > > > > > > Maybe we should do the other way around ?
> > > > > > > cat /proc/kallsyms |grep sys_bpf
> > > > > > >
> > > > > > > and figure out the prefix from there?
> > > > > > > Then we won't need to do giant
> > > > > > > #if defined(__x86_64__)
> > > > > > > ...
> > > > > > >
> > > > > >
> > > > > > Unfortunately this won't work well due to compat and 32-bit APIs (and
> > > > > > bpf() syscall is particularly bad with also bpf_sys_bpf):
> > > > > >
> > > > > > $ sudo cat /proc/kallsyms| rg '_sys_bpf$'
> > > > > > ffffffff811cb100 t __sys_bpf
> > > > > > ffffffff811cd380 T bpf_sys_bpf
> > > > > > ffffffff811cd520 T __x64_sys_bpf
> > > > > > ffffffff811cd540 T __ia32_sys_bpf
> > > > > > ffffffff8256fce0 r __ksymtab_bpf_sys_bpf
> > > > > > ffffffff8259b5a2 r __kstrtabns_bpf_sys_bpf
> > > > > > ffffffff8259bab9 r __kstrtab_bpf_sys_bpf
> > > > > > ffffffff83abc400 t _eil_addr___ia32_sys_bpf
> > > > > > ffffffff83abc410 t _eil_addr___x64_sys_bpf
> > > > > >
> > > > > > $ sudo cat /proc/kallsyms| rg '_sys_mmap$'
> > > > > > ffffffff81024480 T __x64_sys_mmap
> > > > > > ffffffff810244c0 T __ia32_sys_mmap
> > > > > > ffffffff83abae30 t _eil_addr___ia32_sys_mmap
> > > > > > ffffffff83abae40 t _eil_addr___x64_sys_mmap
> > > > > >
> > > > > > We have similar arch-specific switches in few other places (USDT and
> > > > > > lib path detection, for example), so it's not a new precedent (for
> > > > > > better or worse).
> > > > > >
> > > > > >
> > > > > > > /proc/kallsyms has world read permissions:
> > > > > > > proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > > > > > > unlike available_filter_functions.
> > > > > > >
> > > > > > > Also tracefs might be mounted in a different dir than
> > > > > > > /sys/kernel/tracing/
> > > > > > > like
> > > > > > > /sys/kernel/debug/tracing/
> > > > > >
> > > > > > Yeah, good point, was trying to avoid parsing more expensive kallsyms,
> > > > > > but given it's done once, it might not be a big deal.
> > > > >
> > > > > we could get that also from BTF?
> > > >
> > > > I'd rather not add dependency on BTF for this.
> > >
> > > A weird and non technical reason.
> > > Care to explain this odd excuse?
> >
> > Quite technical reason: minimizing unrelated dependencies. It's not
> > necessary to have vmlinux BTF to use kprobes (especially for kprobing
> > syscalls), so adding dependency on vmlinux BTF just to use
> > SEC("ksyscall") seems completely unnecessary, given we have other
> > alternatives.
>
> If BTF and kallsyms were alternatives then it indeed would make
> sense to avoid implement different schemes for old kernels and recent.
> But libbpf already loads vmlinux BTF for other reasons.

Not necessarily, only if bpf_object requires vmlinux BTF, see
obj_needs_vmlinux_btf().

> It caches it and search in it is fast.
> While libbpf also parses kallsyms it doesn't cache it.
> Yet another search through kallsyms will slow down libbpf loading,
> while another search in cached BTF is close to be free.
> Also we have bpf_btf_find_by_name_kind() in-kernel helper.
> We can prog_run it and optimize libbpf's BTF search to be even faster.

I'm starting to actually lean towards just trying to create perf_event
for __<arch>_sys_<syscall> as a feature detection. It will be fast and
simple, and no need to parse kallsyms or available_filter_functions,
take unnecessary dependency on vmlinux BTF, etc. And I have all that
code written already.
