Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51EC48F7C6
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 17:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiAOQ1X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Jan 2022 11:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiAOQ1W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Jan 2022 11:27:22 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09131C061574
        for <bpf@vger.kernel.org>; Sat, 15 Jan 2022 08:27:22 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id b77so7687789vka.11
        for <bpf@vger.kernel.org>; Sat, 15 Jan 2022 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLqTxGPNrdM0GkhGN4pNoNHhFJ25kVJNaFi/jnCk1OA=;
        b=gMITlJB0MfzuPajFWeauMcWTFypJ/wa2uzcdqHDQujVNy0Z791b4ltCg1vHPJdPQAO
         4Blq6Mp5gyZId1tiVOCKLb2SZRMKCbaKL1ot3hYze/0jJ/7zdHQhTyUdir6BwypSw1JQ
         scBC9eOR7qzipC3fxH1YgDbtkfFYj8RXD+Y61Zr6r0rrZ2WASk9ja9iCM4CmYH3bNYn5
         DKRYoDLov5yar4Uvf5Yf74AzcHnAFJ1hUAh9wVjK8+5Vq8kyuxovrE6Me2LiPxcQ+FhH
         TwBuFC0mXSFWRCN9pFxE8nqeESsjQlqzdo9CSwRgZ2lINOIQFfeLji/IR8JnajFh7brc
         Dw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLqTxGPNrdM0GkhGN4pNoNHhFJ25kVJNaFi/jnCk1OA=;
        b=4o2udLdioKHZakf8qL9GrR8LZ++uWP7U+bqmH/jvRfaBNiUn2WQH5SKZQz8QCnHGmp
         Q+qeFnHwgyTmyGx+3qzhwhPaTrt0hZOT344xEz+o7EnPRBaFiJ5vkwmFwmJzehxhBu4X
         0gxpVyaEsHc19ZTsaDyOei5Na9UEbLN9Q8ZXRgaETAgbgKiFgiBQb0mtgb2jyyGcLqcO
         qg8b/VmkpGk0yrEaKN5u/0vMCPxvAz6tr0BzPEsf6Blu9NpLX5akIrtmM/V0F1+FSZcK
         IoVsmV/IY55/ndhdSJIa68qpr4Rd3RjOKAt+RG1UTIpSva/9/EVpbanDQp0Wg/Os3aRr
         MqCQ==
X-Gm-Message-State: AOAM532P7zB0ofjfxaoDh55SXT1hYnouOfyjYI9K93AVmY48ed+GbhzF
        toSC6lhm4gh5T3nSgUH92o8YaOxQG7LKYMUlezs=
X-Google-Smtp-Source: ABdhPJw6o8UYWChXystjf/WPHGtw6uUVGXgoXUyqlevHYY9jji/h/SLaleZc4a3f4bAdI117n5tu1D6Hupm/x7vlj4w=
X-Received: by 2002:a05:6122:219e:: with SMTP id j30mr2898255vkd.34.1642264041019;
 Sat, 15 Jan 2022 08:27:21 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+nS1++7NwcAPuwO26CcuvNnPVMQgtwi4FDNcmHQEBm8g@mail.gmail.com>
 <20220114231426.426052-1-kennyyu@fb.com> <CAEf4BzY9s1ngF_ja_rrpY=1cNX=byVSjptNT-LaEKTsUJEfP6Q@mail.gmail.com>
In-Reply-To: <CAEf4BzY9s1ngF_ja_rrpY=1cNX=byVSjptNT-LaEKTsUJEfP6Q@mail.gmail.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Sat, 15 Jan 2022 16:27:10 +0000
Message-ID: <CAGnuNNv0TVQ3ZSYjJgJh1Dxasc9pX-QTwVApYyW7Q0xEy0Bgng@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Add test for sleepable bpf
 iterator programs
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     Kenny Yu <kennyyu@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 15 Jan 2022 at 15:48, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 14, 2022 at 3:14 PM Kenny Yu <kennyyu@fb.com> wrote:
> >
> > Hi Alexei,
> >
> > > > +// New helper added
> > > > +static long (*bpf_access_process_vm)(
> > > > +       struct task_struct *tsk,
> > > > +       unsigned long addr,
> > > > +       void *buf,
> > > > +       int len,
> > > > +       unsigned int gup_flags) = (void *)186;
> > >
> > > This shouldn't be needed.
> > > Since patch 1 updates tools/include/uapi/linux/bpf.h
> > > it will be in bpf_helper_defs.h automatically.
> >
> > I will fix. This is my first time writing selftests, so I am not too familiar
> > with how these are built and run. For my understanding, are these tests
> > meant to be built and run after booting the new kernel?
>
> Look at vmtest.sh under tools/testing/selftests/bpf, it handles
> building kernel, selftests and spinning up qemu instance for running
> selftests inside it.
>
> >
> > > > +
> > > > +// Copied from include/linux/mm.h
> > > > +#define FOLL_REMOTE 0x2000 /* we are working on non-current tsk/mm */
> > >
> > > Please use C style comments only.
> >
> > I will fix.
> >
> > > > +       numread = bpf_access_process_vm(task,
> > > > +                                       (unsigned long)ptr,
> > > > +                                       (void *)&user_data,
> > > > +                                       sizeof(uint32_t),
> > > > +                                       FOLL_REMOTE);
> > >
> > > We probably would need to hide flags like FOLL_REMOTE
> > > inside the helper otherwise prog might confuse the kernel.
> > > In this case I'm not even sure that FOLL_REMOTE is needed.
> > > I suspect gup_flags=0 in all cases will work fine.
> > > We're not doing write here and not pining anything.
> > > fast_gup is not necessary either.
> >
> > Thanks for the suggestion! I'll remove the flag argument from the helper
> > to simplify the API for bpf programs. This means that the helper will have
> > the following signature:
> >
> >   bpf_access_process_vm(struct task_struct *tsk,
> >                         unsigned long addr,
> >                         void *buf,
> >                         int len);
>
> keeping generic u64 flags makes sense for the future, so I'd keep it.
>
> But I also wanted to point out that this helper is logically in the
> same family as bpf_probe_read_kernel/user and bpf_copy_from_user, etc,
> where we have consistent pattern that first two arguments specify
> destination buffer (so buf + len) and the remaining ones specify
> source (in probe_read it's just an address, here it's tsk_addr). So I
> wonder if it would be less surprising and more consistent to reorder
> and have:
>
> buf, len, tsk, addr, flags
>
> ?
>

I would personally find it more intuitive to have process information
passed as either the first argument (like process_vm_readv does), or
as "last", just before the flags (as extra information required w.r.t.
to local versions, e.g. bpf_copy_from_user).
