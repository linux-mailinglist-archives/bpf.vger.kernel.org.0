Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF126AAD7A
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 00:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCDX2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 18:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCDX2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 18:28:13 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A771DBE2
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 15:28:11 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s11so24329842edy.8
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 15:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677972490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNu5GmaUjzPOvOFTD+z1EAkK0/UAwuv6Jq6Btj9xkWg=;
        b=NKld2PEzql35ZO0lroFuDUJero0Yt8GxYTDaCGRzuZ+PxdJYXe2rBjdN+z0luCzpTf
         Jonx3EndKsVhM0kgAq7wd3GbBJET27S1JwUReCN2w+RzhX9MQ50GDfvbQEmk7QVmv7jj
         r5RjXVqcEx4oUf2GJFqjVBXfLDzIWicokOChRqp/t2iwPmofigi81pPOCl7BdJU5lk2A
         GG2goSTDJegdylZgtMcViftcJGE7By91Kvu5XVJH25m65QXhPczUcD5wXowcg7AKYhJD
         V/2dSTYogI2r2vuSdsuks+5kl0wnH4aAm3wqX6TT7V6VnFcy55+I1TZmPnJzt1uZ3zpD
         PEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677972490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNu5GmaUjzPOvOFTD+z1EAkK0/UAwuv6Jq6Btj9xkWg=;
        b=JmI7/LK9bPBxql8nPCInkrVFIPSxxctXB7ySzhgkZO1dH1MtE93TXOe6/AfqucuPEA
         6rIsFR25aKrkirBNDpu/3bYFWEPFUsSSOMtjWrYOOPGvT5kUlJthNXGvEN2/P0CIepim
         Xj4UkVEtZo4VUsSzG/5OehRHjAhpyz/j0bY9xs5A3SGDfybkqQl7grmUujN5paJwnuvg
         FxqTWx0CJC85bXKFscv81yUXrdxYYM1+FTWilla6s784NV6acQyM3GVXZeXIMuiT7ZAW
         B2hH3gURAOK5EBLRvvXRZhnkLlCJd/qZ5PzbO9cjY7XTOnG/tjRHcAlxyp6UCstOmxCY
         VboQ==
X-Gm-Message-State: AO0yUKWKTR3gW9giHKJO30VD/vCfBKUu1A0G0p10HxyGLeIE2SkQVOR8
        7o/c/SYt1DT2/RarGeFUyHPDYRtWYQOk1ae7liQ=
X-Google-Smtp-Source: AK7set9UGvfdhg5JQ411Q7478m47FqX3MXvFRWfeEPD9C3+kaCb38kwPfCDCI8eE0jbXJGDKrI3idllLr7YZA8RP4Ho=
X-Received: by 2002:a17:907:33c1:b0:8b0:fbd5:2145 with SMTP id
 zk1-20020a17090733c100b008b0fbd52145mr2950880ejb.15.1677972489797; Sat, 04
 Mar 2023 15:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20230302235015.2044271-1-andrii@kernel.org> <20230302235015.2044271-15-andrii@kernel.org>
 <20230304202143.6d7dif64nhybxf6h@MacBook-Pro-6.local>
In-Reply-To: <20230304202143.6d7dif64nhybxf6h@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 4 Mar 2023 15:27:57 -0800
Message-ID: <CAEf4BzbNc24jVa5LG8Qag7wDWf-MCa+x4Gu6ecJw4tfRu-tyNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 14/17] bpf: implement number iterator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 4, 2023 at 12:21=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 02, 2023 at 03:50:12PM -0800, Andrii Nakryiko wrote:
> >
> >  static enum kfunc_ptr_arg_type
> > @@ -10278,7 +10288,17 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_kfunc_call_
> >                       if (is_kfunc_arg_uninit(btf, &args[i]))
> >                               iter_arg_type |=3D MEM_UNINIT;
> >
> > -                     ret =3D process_iter_arg(env, regno, insn_idx, it=
er_arg_type,  meta);
> > +                     if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_iter_num_new] ||
> > +                         meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_iter_num_next]) {
> > +                             iter_arg_type |=3D ITER_TYPE_NUM;
> > +                     } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_iter_num_destroy]) {
> > +                             iter_arg_type |=3D ITER_TYPE_NUM | OBJ_RE=
LEASE;
>
> Since OBJ_RELEASE is set pretty late here and kfuncs are not marked with =
KF_RELEASE,
> the arg_type_is_release() in check_func_arg_reg_off() won't trigger.

yeah, I had troubles with doing this release using existing scheme.
KF_RELEASE doesn't work, as it makes some extra assumptions about what
was acquired, it didn't fit iters. And I didn't have a precedent in
dynptr to learn from, as RINGBUF dynptr is "acquired" and "released"
using helper. Basically, we don't have dynptr release kfunc yet.

So I set the OBJ_RELEASE flag for process_iter_arg to do an explicit releas=
e.

I'd appreciate guidance on how to do this cleaner. Naive attempt to
set KF_ACQUIRE for bpf_iter_num_new() and KF_RELEASE for
bpf_iter_num_destroy() didn't work.


> So I'm confused why there is:
> +               if (arg_type_is_iter(arg_type))
> +                       return 0;
> in the previous patch.
> Will it ever trigger?

maybe not, just followed what dynptr is doing

>
> Separate question: What happens when the user does:
> bpf_iter_destroy(&it);
> bpf_iter_destroy(&it);

After the first destroy stack slots are marked STACK_INVALID, so next
bpf_iter_destroy(&it) will complain about not seeing the initialized
iterator.

>
> +               if (!is_iter_reg_valid_init(env, reg)) {
> +                       verbose(env, "expected an initialized iter as arg=
 #%d\n", regno);
> will trigger, right?
> I didn't find such selftest.

yep, that's the idea, I just checked, I do have such test, it's in
iters_state_safety.c:

__failure __msg("expected an initialized iter as arg #1")
int double_destroy_fail(void *ctx)

There is also next_after_destroy_fail, next_without_new_fail, and
other obvious error conditions. But it would be good for few people to
check that with a fresh eye. I added them a long time ago, and might
have missed something.
