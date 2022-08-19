Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490B159A903
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiHSXBX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 19:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243320AbiHSXBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 19:01:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293ECD8E0F
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 16:01:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w19so11353988ejc.7
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DeLotKDnm1W9Sm/K3ySjCvSBY2vLq82CSDe7WjRLcqc=;
        b=kBdtes5N3UtjzjnhMZzG6liZ2+EvOCx/H94tnZSfqc13HQzzQskl1RPFfZyqWn156m
         ewHw8fHvh4MHGBpZGeAYKaCyxxAbk91IZsh57EXicYR1ZL2lf8EkQQUL9UbJucXiysgZ
         B1zPI1LuJnSeAHD0H6nvEM3xgfj0Kofe9/1rz5YSfeLVidChg/DRFT/zJ9XThjhbBfZ1
         elMmabizvGDpsVyz7NiYxCDMFEOMSPWMigi99NFwv5UKBtf7nL3RcW9tOdkDdsYFtE4X
         xsexwnRwSFvUsXDuKYMKrz5KD8sKdArxlPC17M02CErGPHFZXWURTjoYO3UH6lFWeP9Y
         dNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DeLotKDnm1W9Sm/K3ySjCvSBY2vLq82CSDe7WjRLcqc=;
        b=12cX3ecZmwT2h5HO1P+AzCzRHiTlIRCds+CLsREEPrCdN69F8JmLSDJsRxK3zWGy9s
         3cjxSR/561c2LzT2QuKKj5YKhVxor5t6jE813JYOnuMyJi9NKXKEq7roPD+87QO7RYrQ
         gbGlmeYm1o22FEn8u/rnmHdXQiJPga/dBpWt9RDAcfhUPHTZ8Z2aUg92o27Zs4X22cvU
         VBimOZdThD6UlI7ZDzcgQtr+C5H/kC/pVb7fPCEasnfvqgkr2Dss+0pXWc8XUirgaF2u
         lLMibtOT4i/kNj89tGeHz3kHoAraPfScJX5L5no630sy2kQJ6y4551rZIZ/xDbH5KkWe
         8lSQ==
X-Gm-Message-State: ACgBeo3EjH5X/1nI0F1TFsQq9n9D+oeCINeRferggWWmF72F043SgN/E
        D9lmwv4bzOXmgmaZwM1RY6zOtdozn+Ds72fTLpQ=
X-Google-Smtp-Source: AA6agR6OIk4Qer0KXPbkajEDbVSXNvTmhfgusw4vUtg1cRO8tKlkiWiNmRnvrh+mcyNnu3mENwyGeuPWEcBqexyp3ME=
X-Received: by 2002:a17:907:272a:b0:731:4699:b375 with SMTP id
 d10-20020a170907272a00b007314699b375mr6198595ejl.633.1660950079717; Fri, 19
 Aug 2022 16:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <20220819214232.18784-14-alexei.starovoitov@gmail.com> <CAP01T75MUMKzacdE+AcKqgXy1jA5FyMwKXxiibD0ML3OFSqvsw@mail.gmail.com>
 <20220819224317.i3mwmr5atdztudtt@MacBook-Pro-3.local.dhcp.thefacebook.com> <CAP01T77A1pqYQKeECDSCoxH1pQ1Vxcm84B8_D_r0xoZv_bbq_A@mail.gmail.com>
In-Reply-To: <CAP01T77A1pqYQKeECDSCoxH1pQ1Vxcm84B8_D_r0xoZv_bbq_A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 19 Aug 2022 16:01:08 -0700
Message-ID: <CAADnVQLXKaNsP7VuGBfnrsNwEZ2BYQYcQ=s3EGS-g6HhM9E1uA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used
 by sleepable bpf programs.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Aug 19, 2022 at 3:56 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 20 Aug 2022 at 00:43, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Aug 20, 2022 at 12:21:46AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> > > > Then use call_rcu() to wait for normal progs to finish
> > > > and finally do free_one() on each element when freeing objects
> > > > into global memory pool.
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > >
> > > I fear this can make OOM issues very easy to run into, because one
> > > sleepable prog that sleeps for a long period of time can hold the
> > > freeing of elements from another sleepable prog which either does not
> > > sleep often or sleeps for a very short period of time, and has a high
> > > update frequency. I'm mostly worried that unrelated sleepable programs
> > > not even using the same map will begin to affect each other.
> >
> > 'sleep for long time'? sleepable bpf prog doesn't mean that they can sleep.
> > sleepable progs can copy_from_user, but they're not allowed to waste time.
>
> It is certainly possible to waste time, but indirectly, not through
> the BPF program itself.
>
> If you have userfaultfd enabled (for unpriv users), an unprivileged
> user can trap a sleepable BPF prog (say LSM) using bpf_copy_from_user
> for as long as it wants. A similar case can be done using FUSE, IIRC.
>
> You can then say it's a problem about unprivileged users being able to
> use userfaultfd or FUSE, or we could think about fixing
> bpf_copy_from_user to return -EFAULT for this case, but it is totally
> possible right now for malicious userspace to extend the tasks trace
> gp like this for minutes (or even longer) on a system where sleepable
> BPF programs are using e.g. bpf_copy_from_user.

Well in that sense userfaultfd can keep all sorts of things
in the kernel from making progress.
But nothing to do with OOM.
There is still the max_entries limit.
The amount of objects in waiting_for_gp is guaranteed to be less
than full prealloc.
