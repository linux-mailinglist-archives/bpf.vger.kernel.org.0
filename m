Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A06154FF
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 23:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiKAWb7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKAWbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 18:31:53 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F61D661;
        Tue,  1 Nov 2022 15:31:50 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-13c569e5ff5so18053156fac.6;
        Tue, 01 Nov 2022 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ENLdlMGrxYOQQ6+/iiPdY/yb1WVFSPiKyQyKcHEemIA=;
        b=qt6Qdhy9m2XP52Q5OCaNwefkUSHW71CWMeIAZM7D/5OKOrpbJxAP+q5FS4purW/BLn
         ufzOgd4b4Z4EIk6w11GFi/7fgT1CiFPTRDDi9cLLTSi+6HayCOPPeSAvGnMTp5Mf2n1j
         KSOSSOtnhUwokBwIMWk+kK1d59Ast4HsH8O/3CW3nNs4YNaVwELG5ikZKkNI/wVoibiZ
         YO+9IC2fKKfCpqcpNcqgbaFgg7lufrYdM8dwZupR5xkwlGjGgrP8KDC6it/CVUqZJ0PW
         fEonsRT/LLCrkHbzXTsrNyey4KhhhSODehvbdiq116SlH5gtdBrGMna2EdPw+jwe5ffs
         KLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENLdlMGrxYOQQ6+/iiPdY/yb1WVFSPiKyQyKcHEemIA=;
        b=BpMEjbwM/w1a47lDX0xUt5iQFDgRjarVn96r3Rfyv4uJRRmiUCGSx5qfM/8k2NHc7O
         iKhBUeJ9JUZ5s8dKLbS5Exn8jr8YmN4ZH0PZ7uNiSMXFZDgEOSwb7vKwqzOM50WDs0aN
         9OcB/7QmvTQWjNQI5DFUzJ5RSL2ZhHi4HzOQsZqECX+30fKfrQDIHiGSZvJYNEW5St+b
         qWsKGn1tFQui1eDe9cbCSrwzW72yYRMgJyI3gAV/ajJnYntEcb5DfmZTIsQcVB/pcrFD
         bLXdJucecF0yH4gGlE8zKXq0LeK4vqJUwa14HxdF1KbGcOc2uZKkhcbzD5a+lLLmTVKk
         cMLw==
X-Gm-Message-State: ACrzQf13bVJxAJQdMC8wqZ4jd4i6ECdAldM4pignWwFVZaBSaR2SIKbN
        MQfkwBskO8QITojcbvWRFC6obyCs77QvXT8MoVc=
X-Google-Smtp-Source: AMsMyM7x9Zc6JHNlinkLfS0MGi5KbVE0pM6sDB0okwOH+cFSUHXpCg4Oj39hdTVcGqcVbntvgEa0V2CB9X0mgIzamek=
X-Received: by 2002:a05:6870:3516:b0:13b:8bc3:1140 with SMTP id
 k22-20020a056870351600b0013b8bc31140mr21957069oah.293.1667341909476; Tue, 01
 Nov 2022 15:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221020222416.3415511-1-void@manifault.com> <20221020222416.3415511-2-void@manifault.com>
 <20221101000239.pbbmym4mbdbmnzjd@macbook-pro-4.dhcp.thefacebook.com>
 <Y2FhXC/s5GUkbr9P@maniforge.dhcp.thefacebook.com> <CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com>
 <Y2GRQhsyQMNCOZMT@maniforge.dhcp.thefacebook.com>
In-Reply-To: <Y2GRQhsyQMNCOZMT@maniforge.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 2 Nov 2022 04:01:11 +0530
Message-ID: <CAP01T75R+8WF7jAi5=9cvXfpKtKi9Dq6VxpuYyu7NbWjCtozNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
To:     David Vernet <void@manifault.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Wed, 2 Nov 2022 at 03:06, David Vernet <void@manifault.com> wrote:
>
> On Tue, Nov 01, 2022 at 01:22:39PM -0700, Alexei Starovoitov wrote:
> > On Tue, Nov 1, 2022 at 11:11 AM David Vernet <void@manifault.com> wrote:
> > >
> > > > What kind of bpf prog will be able to pass 'struct nf_conn___init *' into these bpf_ct_* ?
> > > > We've introduced / vs nf_conf specifically to express the relationship
> > > > between allocated nf_conn and other nf_conn-s via different types.
> > > > Why is this not enough?
> > >
> > > Kumar should have more context here (he originally suggested this in
> > > [0]),
> >
> > Quoting:
> > "
> > Unfortunately a side effect of this change is that now since
> > PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> > functions would begin working with tp_btf args.
> > "
> > I couldn't find any tracepoint that has nf_conn___init as an argument.
> > The whole point of that new type was to return it to bpf prog,
> > so the verifier type matches it when it's passed into bpf_ct_*
> > in turn.
> > So I don't see a need for a new OWNED flag still.
> > If nf_conn___init is passed into tracepoint it's a bug and
> > we gotta fix it.
>
> Yep, this is what I'm seeing as well. I think you're right that
> KF_OWNED_ARGS is just strictly unnecessary and that creating wrapper
> types is the way to enable an ownership model like this.
>

It's not just nf_conn___init. Some CT helpers also take nf_conn.
e.g. bpf_ct_change_timeout, bpf_ct_change_status.
Right now they are only allowed in XDP and TC programs, so the tracing
args part is not a problem _right now_.

So currently it may not be possible to pass such a trusted but
ref_obj_id == 0 nf_conn to those helpers.
But based on changes unrelated to this, it may become possible in the
future to obtain such a trusted nf_conn pointer.
It is hard to then go and audit all possible cases where this can be
passed into helpers/kfuncs.

It is a requirement of those kfuncs that the nf_conn has its refcount
held while they are called.
KF_TRUSTED_ARGS was encoding this requirement before, but it wouldn't anymore.
It seems better to me to keep that restriction instead of relaxing it,
if it is part of the contract.

It is fine to not require people to dive into these details and just
use KF_TRUSTED_ARGS in general, but we need something to cover special
cases like these where the object is only stable while we hold an
active refcount, RCU protection is not enough against reuse.

It could be 'expert only' __ref suffix on the nf_conn arg, or
KF_OWNED_ARGS, or something else.

> > > [...]
> > >
> > > > This PTR_WALKED looks like new thing.
> > > > If we really need it PTR_TO_BTF_ID should be allowlisted instead of denylisted
> > > > as PTR_WALKED is doing.
> > > > I mean we can introduce PTR_TRUSTED and add this flag to return value
> > > > of bpf_get_current_task_btf() and arguments of tracepoints.
> > > > As soon as any ptr walking is done we can clear PTR_TRUSTED to keep
> > > > backward compat behavior of PTR_TO_BTF_ID.
> > > > PTR_WALKED is sort-of doing the same, but not conservative enough.
> > > > Too many things produce PTR_TO_BTF_ID. Auditing it all is challenging.
> > >
> > > I very much prefer the idea of allowlisting instead of denylisting,
> > > though I wish we'd taken that approach from the start rather than going
> > > with PTR_UNTRUSTED. It feels wrong to have both PTR_UNTRUSTED and
> > > PTR_TRUSTED as type modifiers, as the absence of PTR_UNTRUSTED should
> > > (and currently does) imply PTR_TRUSTED.
> >
> > I kind agree, but we gotta have both because of backward compat.
> > We cannot change PTR_TO_BTF_ID as a whole right now.
> >
> > Note PTR_TO_BTF_ID appears in kfuncs too.
> > I'm proposing to use PTR_TO_BTF_ID | PTR_TRUSTED
> > only in tracepoint args and as return value from
> > certain helpers like bpf_get_current_task_btf().
> > afaik it's all safe. There is no uaf here.
> > uaf is for kfunc. Especially fexit.
> > Those will stay PTR_TO_BTF_ID. Without PTR_TRUSTED.
>
> Ok, this feels like the right approach to me. Unless I'm missing
> something, modulo doing our due diligence and checking if there are any
> existing kfuncs that are relying on different behavior, once this lands
> I think we could maybe even make KF_TRUSTED_ARGS the default for all
> kfuncs? That should probably be done in a separate patch set though.
>

I do like the allowlist vs denylist point from Alexei. It was also
what I originally suggested in [0], but when I went looking, pointer
walking is really the only case that was problematic, which was being
marked by PTR_WALKED. The other case of handling fexit is unrelated to
both.
But it's always better to be safe than sorry.

[0]: https://lore.kernel.org/bpf/CAP01T76zg0kABh36ekC4FTxDsdiYBaP7agErO=YadfFmaJ1LKQ@mail.gmail.com
