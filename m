Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A889961579B
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 03:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKBCfN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 22:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKBCfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 22:35:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F5958E;
        Tue,  1 Nov 2022 19:35:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f27so41802692eje.1;
        Tue, 01 Nov 2022 19:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aznj2ZKmJdp+fSkwqbXJeWZ95eAYsYDg0L+lHXLDzis=;
        b=Pk2JOg3a7s7nAaP5dugWfjeBtrJ2fHvCRqXSnL2IUCWBgHyY2jnYO1x4eIjrx8dSZ0
         i6zUFARQNW0xY+Fo/o92mCLhdBSiW98n6MJGZZGw2g3OzcH9vJ+uPw0FGwG4LAshTmY1
         DDbbixclT3FNagANjyI9kssTuSMrfvxQf9eJGgXlFagcBhKb0JytTO9EGx1zGAh1ahyZ
         YEHnovwmB2GYOmJ7i02zJFy6SRwSwAh43lBYdAQ+PgKDGi7BCLCqIz2ij2feaiF08jPW
         sSmnLipyf6hOUCjnITehhHsj9Ti6ANoJak2IAyrZxP64+ctWRJ2sBp8JtImnKdTxUE74
         R4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aznj2ZKmJdp+fSkwqbXJeWZ95eAYsYDg0L+lHXLDzis=;
        b=MgTHVJIjFUHbgrzV/NTGAJc3QsfElHUCQjhLqmwjjhJxwPMrqAXo9Va+BNllBIgwVS
         RhQL0FeZkJuQnxXmwvSA+Z8uCP697D5sGkFd7Zb6+LzmYMNm2OG2hf9XeL0r5qA6D/Sv
         FX505uvm2fRDtFzXtBSslEClNTPZ3O1hdw3luJE2Dl3L2QtB/FlUdGQV/J6BLiByobYn
         qqU80ApL1UTn3ViTpdJtVZrwOrwkF4wYRTYkRbA9B9X2w5uIsADz4c6aOBCvPzziPGIe
         eHXbdpt5cBBlz7NhyD5N7z3hum93p46oi3e2kfNEgzWlHq0tIHEE09rg2i7BYutCpSaQ
         SnJg==
X-Gm-Message-State: ACrzQf0SGJ5INglNzeSA/Takmd8TRXHISagB2x7yzS4UIxIzKGv/ty3e
        SXpmKXEjc/e3ZV/m01DQKaoBSKpJELRAH5jEfBqLgxMYxSk=
X-Google-Smtp-Source: AMsMyM4RHGKYWPsPGTpxUn7s10t/Pa9r6dHhTAgqxqW8kAg6KrttIHCRcrnadfZazRxl+ROr2tr0Dvx/6b+YBFv9dEM=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr22169870ejc.676.1667356509367; Tue, 01
 Nov 2022 19:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221020222416.3415511-1-void@manifault.com> <20221020222416.3415511-2-void@manifault.com>
 <20221101000239.pbbmym4mbdbmnzjd@macbook-pro-4.dhcp.thefacebook.com>
 <Y2FhXC/s5GUkbr9P@maniforge.dhcp.thefacebook.com> <CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com>
 <Y2GRQhsyQMNCOZMT@maniforge.dhcp.thefacebook.com> <CAP01T75R+8WF7jAi5=9cvXfpKtKi9Dq6VxpuYyu7NbWjCtozNg@mail.gmail.com>
 <20221102003222.2isv2ewxxamoe6lw@macbook-pro-4.dhcp.thefacebook.com> <CAP01T75cXDoKxj4c7YYrv2YLCLpRdsuWc9fVbV0Qzxii9wneGQ@mail.gmail.com>
In-Reply-To: <CAP01T75cXDoKxj4c7YYrv2YLCLpRdsuWc9fVbV0Qzxii9wneGQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Nov 2022 19:34:57 -0700
Message-ID: <CAADnVQJfj9mrFZ+mBfwh8Xba333B6EyHRMdb6DE4s6te_5_V_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
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

On Tue, Nov 1, 2022 at 6:01 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 2 Nov 2022 at 06:02, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 02, 2022 at 04:01:11AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Wed, 2 Nov 2022 at 03:06, David Vernet <void@manifault.com> wrote:
> > > >
> > > > On Tue, Nov 01, 2022 at 01:22:39PM -0700, Alexei Starovoitov wrote:
> > > > > On Tue, Nov 1, 2022 at 11:11 AM David Vernet <void@manifault.com> wrote:
> > > > > >
> > > > > > > What kind of bpf prog will be able to pass 'struct nf_conn___init *' into these bpf_ct_* ?
> > > > > > > We've introduced / vs nf_conf specifically to express the relationship
> > > > > > > between allocated nf_conn and other nf_conn-s via different types.
> > > > > > > Why is this not enough?
> > > > > >
> > > > > > Kumar should have more context here (he originally suggested this in
> > > > > > [0]),
> > > > >
> > > > > Quoting:
> > > > > "
> > > > > Unfortunately a side effect of this change is that now since
> > > > > PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> > > > > functions would begin working with tp_btf args.
> > > > > "
> > > > > I couldn't find any tracepoint that has nf_conn___init as an argument.
> > > > > The whole point of that new type was to return it to bpf prog,
> > > > > so the verifier type matches it when it's passed into bpf_ct_*
> > > > > in turn.
> > > > > So I don't see a need for a new OWNED flag still.
> > > > > If nf_conn___init is passed into tracepoint it's a bug and
> > > > > we gotta fix it.
> > > >
> > > > Yep, this is what I'm seeing as well. I think you're right that
> > > > KF_OWNED_ARGS is just strictly unnecessary and that creating wrapper
> > > > types is the way to enable an ownership model like this.
> > > >
> > >
> > > It's not just nf_conn___init. Some CT helpers also take nf_conn.
> > > e.g. bpf_ct_change_timeout, bpf_ct_change_status.
> > > Right now they are only allowed in XDP and TC programs, so the tracing
> > > args part is not a problem _right now_.
> >
> > ... and it will be fine to use bpf_ct_change_timeout from tp_btf as well.
> >
> > > So currently it may not be possible to pass such a trusted but
> > > ref_obj_id == 0 nf_conn to those helpers.
> > > But based on changes unrelated to this, it may become possible in the
> > > future to obtain such a trusted nf_conn pointer.
> >
> > From kfunc's pov trusted pointer means valid pointer.
> > It doesn't need to be ref_obj_id refcounted from the verifier pov.
> > It can be refcounted on the kernel side and it will be trusted.
> > The code that calls trace_*() passes only trusted pointers into tp-s.
> > If there is a tracepoint somewhere in the kernel that uses a volatile
> > pointer to potentially uaf kernel object it's a bug that should be fixed.
> >
>
> This is all fine. I'm asking you to distinguish between
> trusted-not-refcounted and trusted-and-refcounted.

That's not what you're asking :)

> It is necessary for nf_conn, since the object can be reused if the
> refcount is not held.

of course. No one argues the opposite.

> Some other CPU could be reusing the same memory and allocating a new
> nf_conn on it while we change its status.
> So it's not ok to call bpf_ct_change_timeout/status on trusted
> nf_conn, but only on trusted+refcounted nf_conn.

and here we start to disagree.

> Trusted doesn't capture the difference between 'valid' vs 'valid and
> owned by prog' anymore with the new definition
> for PTR_TO_BTF_ID.

and here we disagree completely.
You're asking to distinguish refcnt++ done by the program
and recognized by the verifier as ref_obj_id > 0 vs
refcnt++ done by the kernel code before it calls into tracepoint.
That's odd, right?
I don't think people adding kfuncs should care what piece
of code before kfunc did refcnt++.

> Yes, in most cases the tracepoints/tracing functions whitelisted will
> have the caller ensure that,
> but we should then allow trusted nf_conn in those hooks explicitly,
> not implicitly by default everywhere.
> Until then it should be restricted to ref_obj_id > 0 IMO as it is right now.
>
> > > It is a requirement of those kfuncs that the nf_conn has its refcount
> > > held while they are called.
> >
> > and it will be. Just not by the verifier.
> >
> > > KF_TRUSTED_ARGS was encoding this requirement before, but it wouldn't anymore.
> > > It seems better to me to keep that restriction instead of relaxing it,
> > > if it is part of the contract.
> >
> > Disagree as explained above.
> >
> > > It is fine to not require people to dive into these details and just
> > > use KF_TRUSTED_ARGS in general, but we need something to cover special
> > > cases like these where the object is only stable while we hold an
> > > active refcount, RCU protection is not enough against reuse.
> >
> > This is not related to RCU. Let's not mix RCU concerns in here.
> > It's a different topic.
> >
>
> What I meant is that in the normal case, usually objects aren't reused
> while the RCU read lock is held.
> In case of nf_conn, the refcount needs to be held to ensure that,
> since it uses SLAB_TYPESAFE_BY_RCU.
> This is why bpf_ct_lookup needs to bump the refcount and match the key
> after that again, and cannot just return the looked up ct directly.

bpf_ct_lookup needs to bump a refcnt?!
bpf_skb_ct_lookup calls __bpf_nf_ct_lookup
that calls nf_conntrack_find_get() that does
the search and incs the refcnt in a generic kernel code.
There is nothing bpf specific stuff here. bpf kfunc didn't
add any special refcnt incs.

There are no tracepoints in netfilter, so this discussion
is all theoretical, but if there was then the code
should have made sure that refcnt is held before
passing nf_conn into tracepoint.

> > > It could be 'expert only' __ref suffix on the nf_conn arg, or
> > > KF_OWNED_ARGS, or something else.
> >
> > I'm still against that.
> >
>
> I understand (and agree) that you don't want to complicate things further.
> It's fine if you want to deal with this later when the above concern
> materializes. But it will be yet another thing to keep in mind for the
> future.

I don't share the concern.
With nf_conn there is none, right?
But imagine there is only RCU protected pointer that
is passed into tracepoint somewhere.
The verifier doesn't recognize refcnt++ on it and ref_obj_id == 0
the kernel code doesn't do refcnt++ either.
But it's still safe and this arg should still be
PTR_TO_BTF_ID | PTR_TRUSTED.
The bpf prog can pass it further into kfunc that has KF_TRUSTED_ARGS.
Since RCU is held before calling into tracepoint the bpf prog
has to be non sleepable. Additional rcu_read_lock done by
the prog is redundant, but doesn't hurt.
When prog is calling kfunc the pointer is still valid and
kfunc can safely operate on it assuming that object is not going away.
That is the definition of KF_TRUSTED_ARGS from pov of kfunc.
You documented it yourself :)
"
The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
indicates that the all pointer arguments will always have a guaranteed lifetime,
"
