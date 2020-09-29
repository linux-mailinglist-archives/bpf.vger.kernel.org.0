Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6827DD19
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 01:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgI2XxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 19:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgI2XxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 19:53:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40CC0613D0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 16:53:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so76938ejo.9
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 16:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zkNZ3rHDtIXpRMfemrb4Rnw6S05cCl4Cwqw5YJtKgE=;
        b=St8FUH5ZkpD514Lc1ACTepBhIVInJ2OFFojurFuFNigfD0qEhWUZYz5uGi9mEEldWV
         cYinhyzT2ciGRMh7BVJ3zSiVRlwxCEB65TUcwghJm+p6kVSQ+iNqnh6SFBQSeLLjfZWG
         pW9eOx01yFqdSx+ngBIq6Iuyu1EKZI5JxUsqzVhYLeNaUBRB+dwmjfTk+Z8hH/uM6Mq5
         x63nxX9LDHliN7Oppxeln0tnvfYs5k5qZXt3j+6n8zKMAfUA67a9qFZMr5bgN0wV+Ndw
         aB74tWJ5/ahZJfsmk1EfNNj4vzz7sKpGeNdLyxl6RBlROY/MP46drqS98vl+8ajG81Kr
         V79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zkNZ3rHDtIXpRMfemrb4Rnw6S05cCl4Cwqw5YJtKgE=;
        b=I/Qz4RgeeFhQNF3b112FQrxwo9y9Vj1RT9DKIaKAnBWWiXwW+484WMmO/o+KMTDdy3
         f/O/Nq8WI6CBZhy2J0+53Nh6p0riMSENQX9fUyDKJjXgn1PSSfPaa66szFguCQUic5PO
         AD7p1/epbzmg/+exoSodNgu2yjuyUcUiG4S+RWI89XyMA7RSvOqKsRlFB8huZ6HIU1/l
         VQw5l1iqbmwG6LdC4HI/0I8VGCS8LZkH8iR8pAiazxik8zN0ujUstVJ9RJN2ssxXdWI8
         iCLXZYQGZE6my8ePh84jAA5K2uEeTu8KTsyA8sVeeXtod9TIh8Ll5g+3TRY4AanQJO2h
         gwiw==
X-Gm-Message-State: AOAM531GGKehGwLiTF+oPTfw9Tyh3q8dpXdQUb4nbkORlflzgMPzcV4N
        L+KWnB5phnI3x9z+tmjrbqajZfzfMxVMeYH6fUYO1A==
X-Google-Smtp-Source: ABdhPJwykJ2TBuIhAw1k5+bwvnp7SG868xuuOD6eKYx67r9ek9EorQK1sczyBF4wXcpaiattQ7jEqHrYerczcuTM62w=
X-Received: by 2002:a17:906:7d52:: with SMTP id l18mr119950ejp.220.1601423582833;
 Tue, 29 Sep 2020 16:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200916223512.2885524-1-haoluo@google.com> <20200916223512.2885524-5-haoluo@google.com>
 <CAEf4BzbJFE+Yxsy+VEwr-2_JcACh+jbn4WyiS+ECnVVNjC=bnA@mail.gmail.com>
In-Reply-To: <CAEf4BzbJFE+Yxsy+VEwr-2_JcACh+jbn4WyiS+ECnVVNjC=bnA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 29 Sep 2020 16:52:51 -0700
Message-ID: <CA+khW7hw6n1t3PjRNt0HCyO=7kbJTNwQ8moZLpuPiVi5SeouSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Introduce bpf_per_cpu_ptr()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii,

Thanks for taking a look. Sorry for the late reply. Spent some time on
rebasing and fixing a build issue in my development environment that
started happening in v5.9.

On Mon, Sep 21, 2020 at 11:09 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 16, 2020 at 3:39 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Add bpf_per_cpu_ptr() to help bpf programs access percpu vars.
> > bpf_per_cpu_ptr() has the same semantic as per_cpu_ptr() in the kernel
> > except that it may return NULL. This happens when the cpu parameter is
> > out of range. So the caller must check the returned value.
> >
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  include/linux/bpf.h            |  4 +++
> >  include/linux/btf.h            | 11 ++++++
> >  include/uapi/linux/bpf.h       | 18 ++++++++++
> >  kernel/bpf/btf.c               | 10 ------
> >  kernel/bpf/helpers.c           | 18 ++++++++++
> >  kernel/bpf/verifier.c          | 64 ++++++++++++++++++++++++++++++++--
> >  kernel/trace/bpf_trace.c       |  2 ++
> >  tools/include/uapi/linux/bpf.h | 18 ++++++++++
> >  8 files changed, 132 insertions(+), 13 deletions(-)
> >
>
> I already acked this, but see my concern about O(N) look up for
> .data..percpu. Feel free to follow up on this with a separate patch.
> Thanks!
>
> [...]
>
> > @@ -4003,6 +4008,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         if (type != expected_type)
> >                                 goto err_type;
> >                 }
> > +       } else if (arg_type == ARG_PTR_TO_PERCPU_BTF_ID) {
> > +               expected_type = PTR_TO_PERCPU_BTF_ID;
> > +               if (type != expected_type)
> > +                       goto err_type;
> > +               if (!reg->btf_id) {
> > +                       verbose(env, "Helper has invalid btf_id in R%d\n", regno);
> > +                       return -EACCES;
> > +               }
> > +               meta->ret_btf_id = reg->btf_id;
>
> FYI, this will conflict with Lorenz's refactoring, so you might need
> to rebase and solve the conflicts if his patch set lands first.
>

Indeed. Do hit this while rebasing but managed to resolve it. Please
take a look and let me know if you have comments there in v4

> > @@ -7413,6 +7451,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >                         dst_reg->mem_size = aux->btf_var.mem_size;
> >                         break;
> >                 case PTR_TO_BTF_ID:
> > +               case PTR_TO_PERCPU_BTF_ID:
> >                         dst_reg->btf_id = aux->btf_var.btf_id;
> >                         break;
> >                 default:
> > @@ -9313,10 +9352,14 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
> >                                struct bpf_insn *insn,
> >                                struct bpf_insn_aux_data *aux)
> >  {
> > -       u32 type, id = insn->imm;
> > +       u32 datasec_id, type, id = insn->imm;
> > +       const struct btf_var_secinfo *vsi;
> > +       const struct btf_type *datasec;
> >         const struct btf_type *t;
> >         const char *sym_name;
> > +       bool percpu = false;
> >         u64 addr;
> > +       int i;
> >
> >         if (!btf_vmlinux) {
> >                 verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
> > @@ -9348,12 +9391,27 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
> >                 return -ENOENT;
> >         }
> >
> > +       datasec_id = btf_find_by_name_kind(btf_vmlinux, ".data..percpu",
> > +                                          BTF_KIND_DATASEC);
>
> this is a relatively expensive O(N) operation, it probably makes sense
> to cache it (there are about 80'000 types now in BTF for my typical
> kernel config, so iterating that much for every single ldimm64 for
> ksym is kind of expensive.
>

ACK. This currently works. I can do it in another patch.



Hao
