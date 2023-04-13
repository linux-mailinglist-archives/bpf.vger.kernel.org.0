Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110DB6E03D4
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 03:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDMBn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 21:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDMBn3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 21:43:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A57526C;
        Wed, 12 Apr 2023 18:43:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sg7so44919090ejc.9;
        Wed, 12 Apr 2023 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681350206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhV7be06sxXCikS7GMO/UFm9TkGHvcPSaUTFgB3qTww=;
        b=Ayv/5ytUqtN7uhD/Jk5gE27yJ6rkiH10AhK7QmJ8v/9GKuDtwMFkzumOI5jnzCZqnY
         C4HBGuUcg8Uos5qZOaBPgZCS3lFFg5HoiJNNBp7TAAPdDBJs06YMi8E/NBE0NOASL010
         RjGgqgcvqNjDEpxbhInwleJdfxK9xKLhm0dLV1hG0K124dmvzHacDtBTICqsKY2IGt1E
         rZbq6xTm7pL0LBJr25RIHslwQ3Pd4k1I2EWc2zQjPyJAXtPTH6e5vu3QYa9wYW3OYVj/
         Uv1ppd39EQsBgZXfPDOhsbPb/0ldwnJSrEKJfePAc3UIWspGvYsgW3/I8XkFn9+Q3LIp
         LDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681350206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhV7be06sxXCikS7GMO/UFm9TkGHvcPSaUTFgB3qTww=;
        b=FdU5zAj862wEB5PcxNADIxAm4oNAH1QNarr4MQrKB3DI9jFThVqah3jLBgRx6zWcc9
         QKhxJvidnlce/e0TEfbxFj4xIWb53i4Eh9mlPsl1SsBG+LMhz55obO08gthtyjtCJUBh
         tqvXcJ0OHhJ8WetTBzLcUFmQVRYZ57y+X4OdAp5Bl7Z22I30d8PitJBr/zGql5TM0C7P
         pSrQ92c8bYIgkar5ZJBtEWI2pvVxieAWk1nAITWxvVOpb+8OmElkKnFhBnb8cmkj0cgh
         I8Uf7fDxP64uesmB/8vlWSUkpa9+u6Y7OMYQFDaelUWPMnaRr1FbzfUYmvC6ehQekq9r
         fuww==
X-Gm-Message-State: AAQBX9cUw1xFnYMGU8CI4MvLQQYnUkoJ2X2N5mbdNXl7rv34Qlcpto/A
        K0iS1ElrLZfY4fFM4vFFKDfNa/Cvb67oB0i6W0HV/zzi
X-Google-Smtp-Source: AKy350aR6tw1nbHmjT4gK7hhRvsZpGqo7QtmFDZHEs52j5e+jFRdKSJW16OOqf5ZyC74AKti9Ku98ySxh5TzVJ0mmZU=
X-Received: by 2002:a17:906:8403:b0:931:fb3c:f88d with SMTP id
 n3-20020a170906840300b00931fb3cf88dmr443007ejx.5.1681350206027; Wed, 12 Apr
 2023 18:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-8-andrii@kernel.org>
 <CAHC9VhSNeAATRtKj4Gptxgv4wW-L7_5=RisY3yw5JMDtUH=43A@mail.gmail.com>
In-Reply-To: <CAHC9VhSNeAATRtKj4Gptxgv4wW-L7_5=RisY3yw5JMDtUH=43A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 18:43:14 -0700
Message-ID: <CAEf4BzbYK2379c1fbYAwHFBW8UznoozbUA8NhB_uGGtu-3CheA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] bpf, lsm: implement bpf_btf_load_security
 LSM hook
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        keescook@chromium.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 9:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Add new LSM hook, bpf_btf_load_security, that allows custom LSM securit=
y
> > policies controlling BTF data loading permissions (BPF_BTF_LOAD command
> > of bpf() syscall) granularly and precisely.
> >
> > This complements bpf_map_create_security LSM hook added earlier and
> > follow the same semantics: 0 means perform standard kernel capabilities=
-based
> > checks, negative error rejects BTF object load, while positive one skip=
s
> > CAP_BPF check and allows BTF data object creation.
> >
> > With this hook, together with bpf_map_create_security, we now can also =
allow
> > trusted unprivileged process to create BPF maps that require BTF, which
> > we take advantaged in the next patch to improve the coverage of added
> > BPF selftest.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/lsm_hooks.h     | 13 +++++++++++++
> >  include/linux/security.h      |  6 ++++++
> >  kernel/bpf/bpf_lsm.c          |  1 +
> >  kernel/bpf/syscall.c          | 10 ++++++++++
> >  security/security.c           |  4 ++++
> >  6 files changed, 35 insertions(+)
>
> ...
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 42d8473237ab..bbf70bddc770 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4449,12 +4449,22 @@ static int bpf_obj_get_info_by_fd(const union b=
pf_attr *attr,
> >
> >  static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __=
u32 uattr_size)
> >  {
> > +       int err;
> > +
> >         if (CHECK_ATTR(BPF_BTF_LOAD))
> >                 return -EINVAL;
> >
> > +       /* security checks */
> > +       err =3D security_bpf_btf_load(attr);
> > +       if (err < 0)
> > +               return err;
> > +       if (err > 0)
> > +               goto skip_priv_checks;
> > +
> >         if (!bpf_capable())
> >                 return -EPERM;
> >
> > +skip_priv_checks:
> >         return btf_new_fd(attr, uattr, uattr_size);
> >  }
>
> Beyond the objection I brought up in the patchset cover letter, I
> believe the work of the security_bpf_btf_load() hook presented here
> could be done by the existing security_bpf() LSM hook.  If you believe
> that not to be the case, please let me know.

security_bpf() could prevent BTF object loading only, but
security_bpf_btf_load() can *also* allow *trusted* (according to LSM
policy) unprivileged process to proceed. So it doesn't seem like they
are interchangeable.


>
> --
> paul-moore.com
