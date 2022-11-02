Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27161568A
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 01:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKBAc2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 20:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBAc1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 20:32:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4605512D1B;
        Tue,  1 Nov 2022 17:32:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k7so5372063pll.6;
        Tue, 01 Nov 2022 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6e2BzX1jHzLivLWj9zc+05vgd5vFLCoKSjZAasWVfw=;
        b=Ma8Zu/fYfwFZHhnayaZUTHM2+fEowpNOKP75HATGuGqwwpp/23TfqqWBBWN9rFAvGf
         bNDTlUTSSzc8E1EXTKhIcmH9WK62DsdW6mhaXRFvAgh9REc+YM8ij+weI/iK0+otEQTQ
         P5f6c5kNzFhOADq0/lPCbrR0sA12WU2Fk86tVWTdpUZV/a7kbIcQa93P4dGdj3x3FrbI
         SkRe2IoVHI5BvQcbi+qSy78UAs8CkuRfZMFh42IuI+Te8EOQ3ixeTqhPSsXDUsHy7sjm
         cSoZaTMu+opbaKi3OdOSgqgdzWDOwv0Yyfsw7rG0lvmDchqgiQ+gyxTFNp5aNZFw+y6K
         aPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6e2BzX1jHzLivLWj9zc+05vgd5vFLCoKSjZAasWVfw=;
        b=rO9g5bRPIxNCedoggH5zNekPKxH6sYiPIHOXAKQJwFMBTdwDZPhWJ0mGHLn9dER4GO
         ee/iTcH+qQ/1maCpQ7ucawtciJmF/lNUsIBgJ3y0amkcwbz+MdrHq6kCP8iYHNWG8yHy
         eBkq1oB7LtN40YZN2jiUj5Huon/q1ZH4x4czK4X3vA+WDAoXYxeuwKqIkkOuFQ8JjhZu
         i3WRexi9YipuZHst0UVPT5fJtwCh/ZWRxMNSyPTtiUmi6CxkaXy9zijUosmiK1VpLiKe
         /qe/t1gTITI+Plfzv6bbJD0J5FAqyUyLvZWAYgjPMH7ILmHjWxnPg1SK3m+lNNrxp1fk
         2eKg==
X-Gm-Message-State: ACrzQf31FsoXw88G0x6fEf2IBuH9IKD3Lc/U4XNpR6rrOqu7c/91gmsI
        8cyNxmR0tpuiYHfdFa1UwGQ=
X-Google-Smtp-Source: AMsMyM5UfByUbWDesnNytcJ1CDf2a3O3DNcA2rkAkwJWOw+7XKjnDiqn7P4wT1uvUTbMwnEkOnzFpQ==
X-Received: by 2002:a17:902:be03:b0:17b:80c1:78c2 with SMTP id r3-20020a170902be0300b0017b80c178c2mr22181766pls.34.1667349145434;
        Tue, 01 Nov 2022 17:32:25 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:500::5:338f])
        by smtp.gmail.com with ESMTPSA id l20-20020a170902e2d400b0018689e2c9dfsm6891122plc.153.2022.11.01.17.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 17:32:24 -0700 (PDT)
Date:   Tue, 1 Nov 2022 17:32:22 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <20221102003222.2isv2ewxxamoe6lw@macbook-pro-4.dhcp.thefacebook.com>
References: <20221020222416.3415511-1-void@manifault.com>
 <20221020222416.3415511-2-void@manifault.com>
 <20221101000239.pbbmym4mbdbmnzjd@macbook-pro-4.dhcp.thefacebook.com>
 <Y2FhXC/s5GUkbr9P@maniforge.dhcp.thefacebook.com>
 <CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com>
 <Y2GRQhsyQMNCOZMT@maniforge.dhcp.thefacebook.com>
 <CAP01T75R+8WF7jAi5=9cvXfpKtKi9Dq6VxpuYyu7NbWjCtozNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75R+8WF7jAi5=9cvXfpKtKi9Dq6VxpuYyu7NbWjCtozNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 02, 2022 at 04:01:11AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Wed, 2 Nov 2022 at 03:06, David Vernet <void@manifault.com> wrote:
> >
> > On Tue, Nov 01, 2022 at 01:22:39PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Nov 1, 2022 at 11:11 AM David Vernet <void@manifault.com> wrote:
> > > >
> > > > > What kind of bpf prog will be able to pass 'struct nf_conn___init *' into these bpf_ct_* ?
> > > > > We've introduced / vs nf_conf specifically to express the relationship
> > > > > between allocated nf_conn and other nf_conn-s via different types.
> > > > > Why is this not enough?
> > > >
> > > > Kumar should have more context here (he originally suggested this in
> > > > [0]),
> > >
> > > Quoting:
> > > "
> > > Unfortunately a side effect of this change is that now since
> > > PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> > > functions would begin working with tp_btf args.
> > > "
> > > I couldn't find any tracepoint that has nf_conn___init as an argument.
> > > The whole point of that new type was to return it to bpf prog,
> > > so the verifier type matches it when it's passed into bpf_ct_*
> > > in turn.
> > > So I don't see a need for a new OWNED flag still.
> > > If nf_conn___init is passed into tracepoint it's a bug and
> > > we gotta fix it.
> >
> > Yep, this is what I'm seeing as well. I think you're right that
> > KF_OWNED_ARGS is just strictly unnecessary and that creating wrapper
> > types is the way to enable an ownership model like this.
> >
> 
> It's not just nf_conn___init. Some CT helpers also take nf_conn.
> e.g. bpf_ct_change_timeout, bpf_ct_change_status.
> Right now they are only allowed in XDP and TC programs, so the tracing
> args part is not a problem _right now_.

... and it will be fine to use bpf_ct_change_timeout from tp_btf as well.

> So currently it may not be possible to pass such a trusted but
> ref_obj_id == 0 nf_conn to those helpers.
> But based on changes unrelated to this, it may become possible in the
> future to obtain such a trusted nf_conn pointer.

From kfunc's pov trusted pointer means valid pointer.
It doesn't need to be ref_obj_id refcounted from the verifier pov.
It can be refcounted on the kernel side and it will be trusted.
The code that calls trace_*() passes only trusted pointers into tp-s.
If there is a tracepoint somewhere in the kernel that uses a volatile
pointer to potentially uaf kernel object it's a bug that should be fixed.

> It is a requirement of those kfuncs that the nf_conn has its refcount
> held while they are called.

and it will be. Just not by the verifier.

> KF_TRUSTED_ARGS was encoding this requirement before, but it wouldn't anymore.
> It seems better to me to keep that restriction instead of relaxing it,
> if it is part of the contract.

Disagree as explained above.

> It is fine to not require people to dive into these details and just
> use KF_TRUSTED_ARGS in general, but we need something to cover special
> cases like these where the object is only stable while we hold an
> active refcount, RCU protection is not enough against reuse.

This is not related to RCU. Let's not mix RCU concerns in here.
It's a different topic.

> It could be 'expert only' __ref suffix on the nf_conn arg, or
> KF_OWNED_ARGS, or something else.

I'm still against that.

> > > > [...]
> > > >
> > > > > This PTR_WALKED looks like new thing.
> > > > > If we really need it PTR_TO_BTF_ID should be allowlisted instead of denylisted
> > > > > as PTR_WALKED is doing.
> > > > > I mean we can introduce PTR_TRUSTED and add this flag to return value
> > > > > of bpf_get_current_task_btf() and arguments of tracepoints.
> > > > > As soon as any ptr walking is done we can clear PTR_TRUSTED to keep
> > > > > backward compat behavior of PTR_TO_BTF_ID.
> > > > > PTR_WALKED is sort-of doing the same, but not conservative enough.
> > > > > Too many things produce PTR_TO_BTF_ID. Auditing it all is challenging.
> > > >
> > > > I very much prefer the idea of allowlisting instead of denylisting,
> > > > though I wish we'd taken that approach from the start rather than going
> > > > with PTR_UNTRUSTED. It feels wrong to have both PTR_UNTRUSTED and
> > > > PTR_TRUSTED as type modifiers, as the absence of PTR_UNTRUSTED should
> > > > (and currently does) imply PTR_TRUSTED.
> > >
> > > I kind agree, but we gotta have both because of backward compat.
> > > We cannot change PTR_TO_BTF_ID as a whole right now.
> > >
> > > Note PTR_TO_BTF_ID appears in kfuncs too.
> > > I'm proposing to use PTR_TO_BTF_ID | PTR_TRUSTED
> > > only in tracepoint args and as return value from
> > > certain helpers like bpf_get_current_task_btf().
> > > afaik it's all safe. There is no uaf here.
> > > uaf is for kfunc. Especially fexit.
> > > Those will stay PTR_TO_BTF_ID. Without PTR_TRUSTED.
> >
> > Ok, this feels like the right approach to me. Unless I'm missing
> > something, modulo doing our due diligence and checking if there are any
> > existing kfuncs that are relying on different behavior, once this lands
> > I think we could maybe even make KF_TRUSTED_ARGS the default for all
> > kfuncs? That should probably be done in a separate patch set though.
> >
> 
> I do like the allowlist vs denylist point from Alexei. It was also
> what I originally suggested in [0], but when I went looking, pointer
> walking is really the only case that was problematic, which was being
> marked by PTR_WALKED. The other case of handling fexit is unrelated to
> both.

Args of fentry and fexit will not have PTR_TO_BTF_ID | PTR_TRUSTED.
So not an issue.
We can allowlist certain hooks. Like all of bpf-lsm hooks and many others.
But not all of them.
