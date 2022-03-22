Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9434E4810
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 22:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiCVVIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiCVVIH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 17:08:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E13D4B6
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:06:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j15so3156954ila.13
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8Nmw5knm/Z2i8V89DdtzFfCxtMKKOdHAmOLLK7L0rI=;
        b=I3uPyuf+e2nvgZgh6LS188CtMwqdjAlFkllnaZNrk6P6Zp0H9ztXHWPn8Qgi8OsswF
         CdIv/GUBmYfcSTfJ4Mwm5TFNsQpqqsu5Knlwaut29HVQyU6e1I6vgaeRSWoPrJ6XqXrS
         dgq5II/CAENnj5HEhwL/p+7b9yujAZE9VWji6c27+gqkkQ3G9P3+aem2eUVTEm5nrODf
         prMvrZIitNiBTQ55X2Chp48S3L7cScYKuQM1k5vu9PSNXL2JQ4nt+UFKN1Bz2nswhPVA
         81htYX/RBWJkpKfJuOAODDBw/uS+hOBDgqTP7zPcV7gCOqHjxxC6BZfMWq4G4LocoI7o
         jftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8Nmw5knm/Z2i8V89DdtzFfCxtMKKOdHAmOLLK7L0rI=;
        b=HRlh1MMlGnRyH4GN16F8XStd3GTP6ukg1Sz0O0IbK05YvhNvaUMkXEbs6EHzU1KL8n
         c/Yi6I4kmKKtfE5QyoIyKfZcLbz8yO7I9FFTNavdGvk7BSHQy5ERzbUVHbwShFA75ijR
         thH+nrG+7SSVLS34t0V2RMxZvNJzwJrkaM5i4Qe8WgxaIIn/794UIXx4ame3yHmReT+3
         wutT85mhAWf23RdsAvL9h4da6EOVTSgjFaLnTuCWjTJXLvQEeMtpN0LnNdYsnmv/ubVq
         JcvuvpRXcyDMhiJVxK1nGVc0PSmayigg3np136L+yP3gXkW4YRug60fh8wyAFNCR1SAE
         946Q==
X-Gm-Message-State: AOAM533vCF/HMsihhK98sUBqI6Drli/IKtadGcbqzd/qh/CkKawEqor+
        mcnMmuoDmP0MjNz/Q0Nxhl3vDMF+QPyWGXMaVAw=
X-Google-Smtp-Source: ABdhPJz7sUcMmPhRuN27vupKqT2+QnLNEimeOafrmMe2MrFIqEp/JLO3v1z0HJxZ4vTZkI1ZtpJrokWljkZ3bIvwKVk=
X-Received: by 2002:a05:6e02:16c7:b0:2c7:e458:d863 with SMTP id
 7-20020a056e0216c700b002c7e458d863mr12348576ilx.71.1647983198834; Tue, 22 Mar
 2022 14:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-4-kuifeng@fb.com>
 <CAEf4BzYmFUKF0BFnJ62-yayopcwvxGMUogf+Wduwoab3L9m8fg@mail.gmail.com> <6a14b18ab0d17cacf5dbaa7689eaaa7938cd998b.camel@fb.com>
In-Reply-To: <6a14b18ab0d17cacf5dbaa7689eaaa7938cd998b.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Mar 2022 14:06:27 -0700
Message-ID: <CAEf4BzZb2WLKfQEJR_o9M1CsrbT=jzfw9LHAJfWxALomX5eE2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for fentry/fexit/fmod_ret.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Mar 22, 2022 at 9:08 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Mon, 2022-03-21 at 16:18 -0700, Andrii Nakryiko wrote:
> > On Tue, Mar 15, 2022 at 5:44 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > Add a bpf_cookie field to attach a cookie to an instance of struct
> > > bpf_link.  The cookie of a bpf_link will be installed when calling
> > > the
> > > associated program to make it available to the program.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c    |  4 ++--
> > >  include/linux/bpf.h            |  1 +
> > >  include/uapi/linux/bpf.h       |  1 +
> > >  kernel/bpf/syscall.c           | 11 +++++++----
> > >  kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h |  1 +
> > >  tools/lib/bpf/bpf.c            | 14 ++++++++++++++
> > >  tools/lib/bpf/bpf.h            |  1 +
> > >  tools/lib/bpf/libbpf.map       |  1 +
> > >  9 files changed, 45 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c
> > > b/arch/x86/net/bpf_jit_comp.c
> > > index 29775a475513..5fab8530e909 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -1753,8 +1753,8 @@ static int invoke_bpf_prog(const struct
> > > btf_func_model *m, u8 **pprog,
> > >
> > >         EMIT1(0x52);             /* push rdx */
> > >
> > > -       /* mov rdi, 0 */
> > > -       emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> > > +       /* mov rdi, cookie */
> > > +       emit_mov_imm64(&prog, BPF_REG_1, (long) l->cookie >> 32,
> > > (u32) (long) l->cookie);
> >
> > why __u64 to long casting? I don't think you need to cast anything at
> > all, but if you want to make that more explicit than just casting to
> > (u32) should be fine, no?
> >
> > >
> > >         /* Prepare struct bpf_trace_run_ctx.
> > >          * sub rsp, sizeof(struct bpf_trace_run_ctx)
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index d20a23953696..9469f9264b4f 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1040,6 +1040,7 @@ struct bpf_link {
> > >         struct bpf_prog *prog;
> > >         struct work_struct work;
> > >         struct hlist_node tramp_hlist;
> > > +       u64 cookie;
> >
> > I was a bit hesitant about adding tramp_hlist into generic struct
> > bpf_link, but now with also cookie there I'm even more convinced that
> > it's not the right thing to do... Some BPF links won't have cookie,
> > some (like multi-kprobe) will have lots of them.
> >
> > Should we create struct bpf_tramp_link {} which will have tramp_hlist
> > and cookie? As for tramp_hlist, we can probably also keep it back in
> > bpf_prog_aux and just fetch it through link->prog->aux->tramp_hlist
> > in
> > trampoline code. This might reduce amount of code churn in patch 1.
>
> Do you mean a struct likes like?
>
> struct bpf_tramp_link {
>   struct bpf_link link;
>   struct hlist_node tramp_hlist;
>   u64 cookie;
> };

something like this, yes. Keep in mind that we already use struct
bpf_tracing_link which is used for all trampoline-based programs,
except for struct_ops. So we can either somehow make struct_ops just
result struct bpf_tracing_link (cc Martin for ideas, he was thinking
about doing proper bpf_link support for struct_ops anyways), or we'll
need this kind of struct inheritance to reuse the same layout between
struct_ops and struct bpf_tracing_link.

>
> I like this idea since we don't use cookie for every bpf_link.
> But, could you give me an example that we don't want a cookie?
>

For example, currently cgroup-based programs don't have cookie
support. So doesn't raw_tp, btw. But it's not only cases when we don't
support cookie, it's also cases like bpf_kprobe_multi_link which has a
separate array of cookies, so this u64 cookie is useless in such case.
