Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E445B205B
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 16:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIHOSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIHOSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 10:18:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A9A7212
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 07:18:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b16so24623245edd.4
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XvtRRIGxtUVWplgca4/AxYWwz+j8cS7opUpKb34QRuM=;
        b=fhwvnQjR3Gd/AIJjqK4OWCyXHB2ogIT5DxZy/w/hrUVYoAQW1J4mqs8gdmkoDGA43H
         xSH/q3kJvTVYH0nYrEiFr9cGL5d8XoDXKd+zvrfrq6i89pjO18Nv4etkx2Awidf8lrhw
         GpDdtlJIryseC0nDctSEcMBqQ/0aRDUOge2b2UnmC+YJ9i6GQ3+Qo6G1JYf7YxIsG8g+
         uKb1fbDnw/1Zt684hqHXZboJw2rU3CtolZf/DlpuoyyDKnCTG/d5oGdF8MKEzGoq7Q+s
         AstV25mItDQVeIfhGom0FcxhpDfyUsK4mTpvMIIcXnA9WAxndUrJZ/aeeL8NiD8neGGg
         bW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XvtRRIGxtUVWplgca4/AxYWwz+j8cS7opUpKb34QRuM=;
        b=02fzfIEwQToLeVX1nNkgeTyKR4m3eQBOFkZ+fZl0WdoPaaMMumsHR2B2qlDJFbvm+m
         cbC/NpxRLsCkgshS6nC2cRYuzFA3TZUmDWpcl568bTVtL+hOAbPtE9qVPdRQSCVgmOzu
         DHliTnFUrdwhwKvFtmSlNdKyJzPUNi8IoMLa9i5TWqHIel3zsOFEolRcrOnWuVDyA7lL
         eMxQXVKvA6v2qjymDXrP/G+VBm6Y2yEFXyyvzRe5P3MFRrUGPMzou6Rc/tZvlgN4uFUS
         3pc0FzUrfXyFUSTZVWl0QUO752r+/Fm/UeCjgyblZtvRbCH3bBnCy6K2Hq2fuQCEyvGm
         HTfw==
X-Gm-Message-State: ACgBeo0fkLnVjNcY2QQHy/WUCL5SvF9nH+26XlMW3IlTZGK2fkGI79gu
        WUfxh4H07z7pnU431Ql4pOpLZoDS7VXhMWeS9rE=
X-Google-Smtp-Source: AA6agR7ksRcvKuHgZLdRNcyTaUmPWnr1W1pHvjhZSjFIlfIUef5Sdrpl/6TB0xdAxPXB/V8ViBlJkD6+4HFnrYUkYyY=
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id
 et15-20020a056402378f00b0043ad3f579f2mr7482040edb.338.1662646700661; Thu, 08
 Sep 2022 07:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-17-memxor@gmail.com>
 <20220908003429.wsucvsdcxnkipcja@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T77-ygt+MvvwzRwo+3kDrk_8sCv-ASGT8qL2PvPjL_11jw@mail.gmail.com>
 <20220908033741.l6zhopfhnfrpi72y@macbook-pro-4.dhcp.thefacebook.com> <CAP01T76YqSKUMFCVz-WqQQL29SFFn4DG6wqwm0HVpN2-DqJuFA@mail.gmail.com>
In-Reply-To: <CAP01T76YqSKUMFCVz-WqQQL29SFFn4DG6wqwm0HVpN2-DqJuFA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Sep 2022 07:18:09 -0700
Message-ID: <CAADnVQ+hgprNMCSk0bjZnRveEzv=t8zoZXH44Gy8tVPJKoPt_A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 16/32] bpf: Introduce BPF memory object model
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
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

On Thu, Sep 8, 2022 at 4:50 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> I slept over this. I think I can get behind this idea of implicit
> ctor/dtor. We might have open coded construction/destruction later if
> we want.
>
> I am however thinking of naming these helpers:
> bpf_kptr_new
> bpf_kptr_delete
> to make it clear it does a little more than just allocating the type.
> The open coded cases can later derive their allocation from the more
> bare bones bpf_kptr_alloc instead in the future.

New names make complete sense. Good idea.

> The main reason to have open coded-ness was being able to 'manage'
> resources once visibility reduces to current CPU (bpf_refcount_put,
> single ownership after xchg, etc.). Even with RCU, we won't allow
> touching the BPF special fields without refcount. bpf_spin_lock is
> different, as it protects more than just bpf special fields.
>
> But one can still splice or kptr_xchg before passing to bpf_kptr_free
> to do that. bpf_kptr_free is basically cleaning up whatever is left by
> then, forcefully. In the future, we might even be able to do elision
> of implicit dtors based on the seen data flow (splicing in single
> ownership implies list is empty, any other op will undo that, etc.) if
> there are big structs with too many fields. Can also support that in
> open coded cases.

Right.

>
> What I want to think about more is whether we should still force
> calling bpf_refcount_set vs always setting it to 1.
>
> I know we don't agree about whether list_add in shared mode should
> take ref vs transfer ref. I'm leaning towards transfer since that will
> be most intuitive. It then works the same way in both cases, single
> ownership only transfers the sole reference you have, so you lose
> access, but in shared you may have more than one. If you have just one
> you will still lose access.
>
> It will be odd for list_add to consume it in one case and not the
> other. People should already be fully conscious of how they are
> managing the lifetime of their object.
>
> It then seems better to require users to set the initial refcount
> themselves. When doing the initial linking it can be very cheap.
> Later get/put/inc are always available.
>
> But forcing it to be called is going to be much simpler than this patch.

I'm not convinced yet :)
Pls hold on implementing one way or another.
Let's land the single ownership case for locks, lists,
rbtrees, allocators. That's plenty of patches.
Then we can start a deeper discussion into the shared case.
Whether it will be different in terms of 'lose access after list_add'
is not critical to decide now. It can change in the future too.

The other reason to do implicit inits and ref count sets is to
avoid fighting llvm.
obj = bpf_kptr_new();
obj->var1 = 1;
some_func(&obj->var2);
In many cases the compiler is allowed to sink stores.
If there are two calls that "init" two different fields
the compiler is allowed to change the order as well
even if it doesn't see the body of the function and the function is
marked as __pure. Technically initializers as pure functions.
The verifier and llvm already "fight" a lot.
We gotta be very careful in the verifier and not assume
that the code stays as written in C.
