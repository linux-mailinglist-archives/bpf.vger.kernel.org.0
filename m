Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33751F1E7
	for <lists+bpf@lfdr.de>; Sun,  8 May 2022 23:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiEHWDQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 May 2022 18:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiEHWDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 18:03:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799C2634
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 14:59:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i17so12203333pla.10
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bapmjFe4m3fyOJt5RDfB7CtQ9OTOukK5tRFsesVWd4=;
        b=QLCglWSp/nUfQ+yYC6DDpWUvRL7MZqA52oCvWGbgdJZF6t9q2p3Jory0tNdps+t1mf
         rQGJQR2zObOnLr5QNYcxeT4pvz2buIp111YX7JHFurs2aM5TVkKWATlEeI5x4sjk4MuQ
         NDU2VrsDdBsZI4A6JVCVg5Yn4gJc5COC9eKN0Cbc8k7QN034L6G/HIxlHDtcxcV3FPHD
         j1yMbTQcsWYAKtkQ4HZB1HO2UY655u+7nxMMOQoRb0NOZhB9s09CJqP2JB2ZA32HpHRO
         6Da/lv8UiGDnDFUda4GJd5eZ4C8YgU0SCAMj8Gws1S7KDeG6y292UAuxwRveHUDhN8Cw
         2Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bapmjFe4m3fyOJt5RDfB7CtQ9OTOukK5tRFsesVWd4=;
        b=asBFyCsoJx/x8M9Tr5xa+OkA70nBRcOQjpw+lJDYeNDMSX4uTDI/chEk73D6m+q0Uf
         qEpxv602Us89V2MYPemLx5rw7nLfENWk3ZkE73ruggweFxbi6ny53LBTRZRiTMKUgcJJ
         Hdcd7786fEE4XIZ+aXhMmI8rCKS+UP5w3WwCm4hvWIyreivaEVKrqh163Dyoo6NNDzKN
         A1dWaYqP9mf+b1ziOGvlKHf6J2Biq6NqEsIMWJHUGsYAuxp0kjSZu+LwMj08FuJp0/mH
         ySBKluxALeAI9TBrOwezDOYQiTdXwo07K9hRmQRp06Hx3qVRW6ybILh3w426hEDecAG1
         2qfQ==
X-Gm-Message-State: AOAM532RN95bhnsZndzSSHGvc2V3+P/XFeTmS4lj1x0ddKT8VMlnJKbz
        7jmFVUbJ6tGwfJlsU6TXrJSse0XzTuS8kX32gJxd1SN/
X-Google-Smtp-Source: ABdhPJzKZhrgCSlMWOFMtpSe9Lcf2FfTS4GrXC8092FGw3qNfwObW4nMYxsOyhv1mfqto5ydUw/QImiGajn2GK8Yum8=
X-Received: by 2002:a17:903:2d1:b0:156:7ceb:b56f with SMTP id
 s17-20020a17090302d100b001567cebb56fmr13580909plk.11.1652047164833; Sun, 08
 May 2022 14:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220424214901.2743946-1-memxor@gmail.com> <20220424214901.2743946-14-memxor@gmail.com>
 <20220426033937.jjcua6zchnka5dco@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220426033937.jjcua6zchnka5dco@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 8 May 2022 14:59:13 -0700
Message-ID: <CAADnVQKdB13TUDUsKPUEtgMgKWDG9xUDa1WO3v7HSufqU-sE-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 13/13] selftests/bpf: Add test for strict BTF
 type check
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Mon, Apr 25, 2022 at 8:39 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 25, 2022 at 03:19:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> >
> > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > index 2e03decb11b6..743ed34c1238 100644
> > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > @@ -138,6 +138,26 @@
> >               { "bpf_kfunc_call_memb_release", 8 },
> >       },
> >  },
> > +{
> > +     "calls: invalid kfunc call: don't match first member type when passed to release kfunc",
> > +     .insns = {
> > +     BPF_MOV64_IMM(BPF_REG_0, 0),
> > +     BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> > +     BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> > +     BPF_EXIT_INSN(),
> > +     BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> > +     BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
> > +     BPF_MOV64_IMM(BPF_REG_0, 0),
> > +     BPF_EXIT_INSN(),
> > +     },
> > +     .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> > +     .result = REJECT,
> > +     .errstr = "kernel function bpf_kfunc_call_memb1_release args#0 expected pointer",
> > +     .fixup_kfunc_btf_id = {
> > +             { "bpf_kfunc_call_memb_acquire", 1 },
> > +             { "bpf_kfunc_call_memb1_release", 5 },
> > +     },
> > +},
>
> Please add negative C tests as well.
> Consider using SEC("?tc") logic added by commit 0d7fefebea552
> and put a bunch of bpf progs that should fail to load in one .c

Kumar,

ping?
Are you still working on the follow up?
