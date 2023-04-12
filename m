Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849A56DFBE2
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 18:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDLQyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLQyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 12:54:18 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0400010FE
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:53:44 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e127so12471032ybf.8
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681318378; x=1683910378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsLay53A6dLh3VLROEyKdp+6fRylKB2VxR2PtcHB4tw=;
        b=dsTP4wuyYXHH12dCwFgEpRzILS8/aFCMEVRe+89u8AFff5eCeCbkYVlh+TBT4e9CSN
         y402rfrg0dG2LzEQS+KDUUhwExeKVkE9EbHjF14s8MYYNsM/UxKp0elixR0U9xzrttX3
         WHL/Se4EsUYMRzJL8xJtmZ/DCxdq16oVMMTG7JY0WO7hTLycIAm4LWRfuuV8OaJzRQTg
         xp6qTTKqf1JxtlDTlBSYZJ6S8EJp3nOY0bPvJgNrwpme7mBEdrTBF56V06u/kKUOF2hx
         1VwQR7+6IbqVD5FulG0o5DDhJ9Ea0GZZiOpO2tXa8qzYqcrisSKhYBe3AYui7DQ17LmH
         sUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681318378; x=1683910378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsLay53A6dLh3VLROEyKdp+6fRylKB2VxR2PtcHB4tw=;
        b=kYikgotb/guvjkmJ3PwsdLrZq9EVOaG27wF7dLJX+AzJqhprdNLdjkYui3HX2SUqif
         sQuJQF5ymWUqOldrV3Zc0425BDnv8m+bEGxWzN4Nv3uZu0fQUMmJm6thNgMNjCveOVEd
         dvo0KpyvZMAcU8rNi3+0CSbpCvmU5QPYJOU0xVgs3ADII9QWHNxnXgk5tElNty4g/ohR
         PG8hARtrMu3HRXKVoE6UUwr3uvMS3dxj2bLUKzfjVrlutQ/IMzR3zL6hs5MbGWUNg+kh
         F6bnqYt9oWpzRNg5QIa0hNLExYlSMAuod7xLrjMHCjB7lkUJN/LBnDe/ODego08lJJDh
         U+Mw==
X-Gm-Message-State: AAQBX9cdW2rPq49nrzsMI/7s0no8GGV4OwB53BIzJjzVp1I8kGAC2Div
        PooHUYf9SdEx7uJWp3sCMjb+fq69GA0plPae1WEM
X-Google-Smtp-Source: AKy350YNGyjYtzGLnfpZaBqIYkE7zH3rANm1YyfmbwecN3fXiL1lkT1XT7dX/0+aQWqU5cdi4JsPGnfJnJMMwIC2zfU=
X-Received: by 2002:a25:d702:0:b0:b68:7a4a:5258 with SMTP id
 o2-20020a25d702000000b00b687a4a5258mr2135628ybg.3.1681318378235; Wed, 12 Apr
 2023 09:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-8-andrii@kernel.org>
In-Reply-To: <20230412043300.360803-8-andrii@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 12:52:47 -0400
Message-ID: <CAHC9VhSNeAATRtKj4Gptxgv4wW-L7_5=RisY3yw5JMDtUH=43A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] bpf, lsm: implement bpf_btf_load_security
 LSM hook
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Add new LSM hook, bpf_btf_load_security, that allows custom LSM security
> policies controlling BTF data loading permissions (BPF_BTF_LOAD command
> of bpf() syscall) granularly and precisely.
>
> This complements bpf_map_create_security LSM hook added earlier and
> follow the same semantics: 0 means perform standard kernel capabilities-b=
ased
> checks, negative error rejects BTF object load, while positive one skips
> CAP_BPF check and allows BTF data object creation.
>
> With this hook, together with bpf_map_create_security, we now can also al=
low
> trusted unprivileged process to create BPF maps that require BTF, which
> we take advantaged in the next patch to improve the coverage of added
> BPF selftest.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     | 13 +++++++++++++
>  include/linux/security.h      |  6 ++++++
>  kernel/bpf/bpf_lsm.c          |  1 +
>  kernel/bpf/syscall.c          | 10 ++++++++++
>  security/security.c           |  4 ++++
>  6 files changed, 35 insertions(+)

...

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 42d8473237ab..bbf70bddc770 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4449,12 +4449,22 @@ static int bpf_obj_get_info_by_fd(const union bpf=
_attr *attr,
>
>  static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u3=
2 uattr_size)
>  {
> +       int err;
> +
>         if (CHECK_ATTR(BPF_BTF_LOAD))
>                 return -EINVAL;
>
> +       /* security checks */
> +       err =3D security_bpf_btf_load(attr);
> +       if (err < 0)
> +               return err;
> +       if (err > 0)
> +               goto skip_priv_checks;
> +
>         if (!bpf_capable())
>                 return -EPERM;
>
> +skip_priv_checks:
>         return btf_new_fd(attr, uattr, uattr_size);
>  }

Beyond the objection I brought up in the patchset cover letter, I
believe the work of the security_bpf_btf_load() hook presented here
could be done by the existing security_bpf() LSM hook.  If you believe
that not to be the case, please let me know.

--=20
paul-moore.com
