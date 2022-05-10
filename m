Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB4E522450
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiEJSqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349131AbiEJSqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 14:46:04 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D8F2BE9EF
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:45:05 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y11so11954895ilp.4
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVNhRiWKBNvdZSwQYih85AvoxdXpTeET9gWG+4pSft8=;
        b=EZJsfROjoYZMHVIdj86AL5aXHZzRZ6zSe9KWQDSXYgHLToGTTbCZq7txlhqQIB/Lng
         gRES2K5GDaka1CdPn8dlKynccZEkwgHdfxrQWHSYsDA+sKBhnwEblnuByYc1G+GdwLCn
         8m2VcBxR9YyoD472bmJcmOONEMb7CYxvYvrndWIYfXw4UxTf01srKCJw89bgjL7HoxNr
         TmFkCnDLsBLWw2hn+xYrk/1joMzmGttTFnsW+LKPyKNUAAFGwPMqhpMr+uXmDKsZKLLy
         bUqBMGyANRb4Xj6yxtTsJbEFSmMxvElzH9JMTqlZIWtebsK0Ms5j3WfPlV3ojbWwBUUD
         ktLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVNhRiWKBNvdZSwQYih85AvoxdXpTeET9gWG+4pSft8=;
        b=O8WIYGbrcmRkS5kMw6ReQYrl4WH1yWo0mkFJFEJh2CMAZCXsu+08oz0ioPQN7ypfym
         59y50ZATnSzJjP6nQSG/arOWNh61F/uNGmdKWrH1KF6SkHwms2Rts41qQLX08nsiuNgD
         iDxS0yZxyVr3TM+/AVPnlTDMyJZ/1swaeWtBnUraFsqSzY0LWs07mHH8l4vOkFlzF8Fc
         bZItEV1tDf1FjpNX7Yfx8twvzqnuvIhZvz0unP1lnRlhkx67Zk+/pcR6NrJHu8Cl1wJ+
         UFkJ38djFccK+FwwPWspRvbQAsLSGWkcefiF6UKEcV1AX9Sej3EHxviGKy4qpR08HGDt
         uGkg==
X-Gm-Message-State: AOAM530G5lPAEiGGG8AROQw+58mBglaYWt7wWGZynVp1amQ5NnfKRptK
        hDEO4rKlYkuRrQMmmUwPiQkgwA8Qnd0XZWnPQiM=
X-Google-Smtp-Source: ABdhPJzwg6XBS7NhfAKFX1GGkWRVfVlf3YyYo+ltODfOZ7Z0cw66Nnayxvj2yCv3xRlII0NuLHTSwfzMiNVhY7mJD8k=
X-Received: by 2002:a05:6e02:11a3:b0:2cf:90f9:30e0 with SMTP id
 3-20020a056e0211a300b002cf90f930e0mr6385962ilj.252.1652208304796; Tue, 10 May
 2022 11:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220508032117.2783209-1-kuifeng@fb.com> <20220508032117.2783209-4-kuifeng@fb.com>
 <CAEf4BzYitV038g5SW1DexVuxH1YNgdgfKs_yV+ExbRPuy++N3w@mail.gmail.com> <e3be9e432ba6ce95543977b542ee1a2a91e978e7.camel@fb.com>
In-Reply-To: <e3be9e432ba6ce95543977b542ee1a2a91e978e7.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 May 2022 11:44:53 -0700
Message-ID: <CAEf4Bzb-9a=4bDxqAH5Rdoz3F_LJ9ks8DAm_SyEDKZqwVAjGkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf, x86: Attach a cookie to fentry/fexit/fmod_ret/lsm.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
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

On Tue, May 10, 2022 at 9:44 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Mon, 2022-05-09 at 11:58 -0700, Andrii Nakryiko wrote:
> > On Sat, May 7, 2022 at 8:21 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > Pass a cookie along with BPF_LINK_CREATE requests.
> > >
> > > Add a bpf_cookie field to struct bpf_tracing_link to attach a
> > > cookie.
> > > The cookie of a bpf_tracing_link is available by calling
> > > bpf_get_attach_cookie when running the BPF program of the attached
> > > link.
> > >
> > > The value of a cookie will be set at bpf_tramp_run_ctx by the
> > > trampoline of the link.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c    | 12 ++++++++++--
> > >  include/linux/bpf.h            |  1 +
> > >  include/uapi/linux/bpf.h       |  9 +++++++++
> > >  kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
> > >  kernel/bpf/syscall.c           | 12 ++++++++----
> > >  kernel/bpf/trampoline.c        |  7 +++++--
> > >  kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h |  9 +++++++++
> > >  8 files changed, 76 insertions(+), 8 deletions(-)
> > >
> >
> > LGTM with a suggestion for some follow up clean up.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c
> > > b/arch/x86/net/bpf_jit_comp.c
> > > index bf4576a6938c..52a5eba2d5e8 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -1764,13 +1764,21 @@ static int invoke_bpf_prog(const struct
> > > btf_func_model *m, u8 **pprog,
> > >                            struct bpf_tramp_link *l, int
> > > stack_size,
> > >                            bool save_ret)
> > >  {
> > > +       u64 cookie = 0;
> > >         u8 *prog = *pprog;
> > >         u8 *jmp_insn;
> > >         int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx,
> > > bpf_cookie);
> > >         struct bpf_prog *p = l->link.prog;
> > >
> > > -       /* mov rdi, 0 */
> > > -       emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> > > +       if (l->link.type == BPF_LINK_TYPE_TRACING) {
> >
> > It would probably be nicer to put cookie field into struct
> > bpf_tramp_link instead so that the JIT compiler doesn't have to do
> > this special handling. It also makes sense that struct bpf_trampoline
> > *trampoline is moved into struct bpf_tramp_link itself (given
> > trampoline is always there for bpf_tramp_link).
>
> It will increase the size of bpf_tramp_link a little bit, but they are
> not used by bpf_struct_ops.
>

It feels like the right tradeoff to keep architecture-specific
trampoline code oblivious to these details. Some day structs_ops might
support cookies as well. And either way 8 bytes for struct_ops link
isn't a big deal.

> >
> > > +               struct bpf_tracing_link *tr_link =
> > > +                       container_of(l, struct bpf_tracing_link,
> > > link);
> > > +
> > > +               cookie = tr_link->cookie;
> > > +       }
> > > +
> > > +       /* mov rdi, cookie */
> > > +       emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32)
> > > (long) cookie);
> > >
> > >         /* Prepare struct bpf_tramp_run_ctx.
> > >          *
> >
> > [...]
>
