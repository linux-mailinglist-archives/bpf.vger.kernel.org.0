Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EF761531F
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 21:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKAUWz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 16:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKAUWy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 16:22:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D141C93C;
        Tue,  1 Nov 2022 13:22:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d26so39915450eje.10;
        Tue, 01 Nov 2022 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rEC3cxo4FgQfyvz229nsXnlzkaW2KchFRD8VpXN5RqQ=;
        b=lWe15kr7Rp4A2m/pQ8BOiAfBflHHkKN8G4bjanedMAno3gnrIl9B0HDcU7woxijBuM
         TYRTJMWRrwyJqI9+hChtdVt1Tg9j89fJi4fPsk6ZyB7+jIR33PzVNwDbjwA2APPZ0XJ/
         Pdq7n30QEzYbvdHzxy0u3xmTS5NjUf+VpsyPEygQQ+L2D/90sY2DVYzQaWrDLiGo9Q1g
         sOGXk4f+ZnayABS5OKKj40T8oUyCvv5m7MPmx7traNKOYSsoFx0UR/3LEYq80vDfUHhs
         TkxEAKWF2bBQA2unSM9rj3dR1SCfFuPrzUxRdPoWq+8uH128uTWHNtmhbGBSOdWnfVGC
         YMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEC3cxo4FgQfyvz229nsXnlzkaW2KchFRD8VpXN5RqQ=;
        b=0uB5dIPHbM/3hMybWMXNs3cnCKPfIohA3L4Bsl+Y611VqF699X4w24bG0MLpYoHO1D
         VH/vp5rC0sFeuGTQHUchB0eTGaC0UF8yr7fE3rwIGa5dU8+utYAPavKv9i2hI/K4GD3O
         mmwjtsF1uR6cDwivBG1pNJspv/NQmxqZKCUiMTtZRvANnE8YUOQoTkRcfs/JJTqFAig5
         ErYVe1a3C7YW3QeG2+H8xWEEwo3+peZ0xyRn+Xv6nSbvQRE3Bh/88OBZS5tZ1L85eUra
         udll3WyQYRC3nY/idaeSjbfFW1WZ1UAJOwzf7z3CxkhaPBs7IoaRCwKrhvJRYmXWUiut
         dcLw==
X-Gm-Message-State: ACrzQf3t05rL9YxS2y0xOcYu23ev5/RiXXwU+0H2YAg0llD9Q/COK/9D
        z9xamByHVxhrBGhYyV83OVHlIhvXIfH3+WanVSU=
X-Google-Smtp-Source: AMsMyM4+hgyrpJODY2oIrLoUs7QnEMT0wLGK7O51Ng8WL+dLwNA6kFlJFwabBdS5dJmxiCahCcwNzF47cIqegy3RhZM=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr20210637ejb.633.1667334170925; Tue, 01
 Nov 2022 13:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221020222416.3415511-1-void@manifault.com> <20221020222416.3415511-2-void@manifault.com>
 <20221101000239.pbbmym4mbdbmnzjd@macbook-pro-4.dhcp.thefacebook.com> <Y2FhXC/s5GUkbr9P@maniforge.dhcp.thefacebook.com>
In-Reply-To: <Y2FhXC/s5GUkbr9P@maniforge.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Nov 2022 13:22:39 -0700
Message-ID: <CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 11:11 AM David Vernet <void@manifault.com> wrote:
>
> > What kind of bpf prog will be able to pass 'struct nf_conn___init *' into these bpf_ct_* ?
> > We've introduced / vs nf_conf specifically to express the relationship
> > between allocated nf_conn and other nf_conn-s via different types.
> > Why is this not enough?
>
> Kumar should have more context here (he originally suggested this in
> [0]),

Quoting:
"
Unfortunately a side effect of this change is that now since
PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
functions would begin working with tp_btf args.
"
I couldn't find any tracepoint that has nf_conn___init as an argument.
The whole point of that new type was to return it to bpf prog,
so the verifier type matches it when it's passed into bpf_ct_*
in turn.
So I don't see a need for a new OWNED flag still.
If nf_conn___init is passed into tracepoint it's a bug and
we gotta fix it.

> but AFAICT you're correct that this should be sufficient. I added
> a negative test case that correctly fails if a BPF program tries to call
> these helpers with a struct nf_conn* rather than a struct
> nf_conn__init*.
>
> [0]: https://lore.kernel.org/all/CAP01T77PTK+bD2mBrxJShKNPhEypT2+nSHcr3=uuJbrghv_wFg@mail.gmail.com/
>
> > I prefer to keep only one flag KF_TRUSTED_ARGS that kfunc-s need to use
> > and eventually make all kfuncs KF_TRUSTED_ARGS by default and remove that flag.
>
> Yes, KF_TRUSTED_ARGS really should be the default. As Kumar describes in
> [1], we'll have to figure out how to avoid trace progs with unsafe args
> from calling these kfuncs. Maybe the right thing to do is allow-listing
> rather than deny-listing, as you pointed out.
>
> [1]: https://lore.kernel.org/bpf/CAP01T77goGbF3GVithEuJ7yMQR9PxHNA9GXFODq_nfA66G=F9g@mail.gmail.com/

That is still the plan. more or less.

> > Separately...
> > I think there was a plan to strengthen PTR_TO_BTF_ID and apply PTR_UNTRUSTED.
>
> That would be nice if we could do it. I assume that the issue is we're
> breaking backwards compat if we do, so I'd be curious to hear what the
> plan was if you're aware. The only plan that I've seen so far is what
> Kumar spelled out above in [1] above.

Right. Backward compat with existing usage of PTR_TO_BTF_ID
is the main issue.

>
> > This PTR_WALKED looks like new thing.
> > If we really need it PTR_TO_BTF_ID should be allowlisted instead of denylisted
> > as PTR_WALKED is doing.
> > I mean we can introduce PTR_TRUSTED and add this flag to return value
> > of bpf_get_current_task_btf() and arguments of tracepoints.
> > As soon as any ptr walking is done we can clear PTR_TRUSTED to keep
> > backward compat behavior of PTR_TO_BTF_ID.
> > PTR_WALKED is sort-of doing the same, but not conservative enough.
> > Too many things produce PTR_TO_BTF_ID. Auditing it all is challenging.
>
> I very much prefer the idea of allowlisting instead of denylisting,
> though I wish we'd taken that approach from the start rather than going
> with PTR_UNTRUSTED. It feels wrong to have both PTR_UNTRUSTED and
> PTR_TRUSTED as type modifiers, as the absence of PTR_UNTRUSTED should
> (and currently does) imply PTR_TRUSTED.

I kind agree, but we gotta have both because of backward compat.
We cannot change PTR_TO_BTF_ID as a whole right now.

Note PTR_TO_BTF_ID appears in kfuncs too.
I'm proposing to use PTR_TO_BTF_ID | PTR_TRUSTED
only in tracepoint args and as return value from
certain helpers like bpf_get_current_task_btf().
afaik it's all safe. There is no uaf here.
uaf is for kfunc. Especially fexit.
Those will stay PTR_TO_BTF_ID. Without PTR_TRUSTED.

>
> If we're going to go with an allowlist approach, then I think we should
> just get rid of PTR_UNTRUSTED altogether. Is that what you're
> suggesting? Otherwise, if we don't get rid of PTR_UNTRUSTED, then
> PTR_WALKED seems like a more natural type modifier addition.

Eventually either PTR_TRUSTED or PTR_UNTRUSTED will be removed.

> > I might have missed earlier discussions on this patch set. Apologies if so.
>
> Just FYI, the main initial thread where this was all discussed was [2].
>
> [2]: https://lore.kernel.org/all/CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com/
