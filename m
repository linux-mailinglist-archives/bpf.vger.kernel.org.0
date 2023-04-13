Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D26E04D7
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 04:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjDMCss (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 22:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjDMCsg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 22:48:36 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8C93DE
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 19:48:03 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fbee98814so8628667b3.8
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681354035; x=1683946035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2RoII8+06QRj1KrNImDflKewnRU3eOkdDv7RUkwTvQ=;
        b=dqhaWIwwUCYUTW0bG7Sm46OOkOXwVETEwrukiNwgo+mHqSXYiApiNs5bzD2G1YoADr
         iNRFlITDebdiykKozoZVmNNZSQoL/we34yPq9D3bsnJBH9g63wFoSHgoxb3XNaJb64Xs
         A94x69GRUtTTwojtoimUsRxYWdvtf+CZ+qw0MT678Aw1VFyLPYnZVDuoTnXZRfTci+dP
         NXrbZPvdLtsT/mac/7X3e8iZWQPnHlwGipuDnZaActyxyvJxoaE9awn41JnkCXgOk6pU
         kyBlYLOd2TWRUwxp+1xT9tZMsYSa9Y0oZtaBbsmQem1PrhtiZWSDw76moyww4yfBFEAf
         yDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681354035; x=1683946035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2RoII8+06QRj1KrNImDflKewnRU3eOkdDv7RUkwTvQ=;
        b=Bk53CQ11kwYWa4lVVFadc89zXG7j66Vkzi3IwZPG4+0QZr4JESMt3Jgu59DMDiRLIm
         4xC5Vbo/UMQ1LjqR5HV9RsobmJmXB7KsXwYNZv+r3pkHvfG2YQPIv7hhzEAlnhUR8+lN
         0ztJHRlgWvmD6jtGLEO5VMF6HqiAtSK7WRky9liwhLSGR7WmO/t4Xsy+LPpkUdg5d5uF
         oG2vHj2I290XSkgptKgearR8lWmmnOxxtKzv7t8dk9n7ASzzj46XTHy2AIzwXtsLnjh9
         A0qIwvdXVXv2Ji+KaDmUAlAn+EqNNxaFgo61KKGOh+yWxhM1qDkNtq2lFC/zKlSmtVgd
         vi8Q==
X-Gm-Message-State: AAQBX9e7m69rQrc1drK8JX+4ACPIjJarfQe+hs5EyFMikQ8YIkoOLozn
        S61SmARHIEqjR/LAre0zjO4sMS0VCgFMsi209EyX
X-Google-Smtp-Source: AKy350Zr6ctXd3kklOuBkt9MDMvadnuhnfNJfHy3bifm8/DimJcWFMzD9EyxNPobnEGaDHge8+xR7YjLOBzWqW8CtU8=
X-Received: by 2002:a81:ac49:0:b0:54f:8824:8836 with SMTP id
 z9-20020a81ac49000000b0054f88248836mr422009ywj.8.1681354034889; Wed, 12 Apr
 2023 19:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-8-andrii@kernel.org>
 <CAHC9VhSNeAATRtKj4Gptxgv4wW-L7_5=RisY3yw5JMDtUH=43A@mail.gmail.com> <CAEf4BzbYK2379c1fbYAwHFBW8UznoozbUA8NhB_uGGtu-3CheA@mail.gmail.com>
In-Reply-To: <CAEf4BzbYK2379c1fbYAwHFBW8UznoozbUA8NhB_uGGtu-3CheA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 22:47:03 -0400
Message-ID: <CAHC9VhQ=eHb06g+VOzhfsTPpkoarqk4=LNZQNvh9kMUXjdhJgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] bpf, lsm: implement bpf_btf_load_security
 LSM hook
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        keescook@chromium.org, linux-security-module@vger.kernel.org
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

On Wed, Apr 12, 2023 at 9:43=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Apr 12, 2023 at 9:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > Add new LSM hook, bpf_btf_load_security, that allows custom LSM secur=
ity
> > > policies controlling BTF data loading permissions (BPF_BTF_LOAD comma=
nd
> > > of bpf() syscall) granularly and precisely.
> > >
> > > This complements bpf_map_create_security LSM hook added earlier and
> > > follow the same semantics: 0 means perform standard kernel capabiliti=
es-based
> > > checks, negative error rejects BTF object load, while positive one sk=
ips
> > > CAP_BPF check and allows BTF data object creation.
> > >
> > > With this hook, together with bpf_map_create_security, we now can als=
o allow
> > > trusted unprivileged process to create BPF maps that require BTF, whi=
ch
> > > we take advantaged in the next patch to improve the coverage of added
> > > BPF selftest.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/lsm_hooks.h     | 13 +++++++++++++
> > >  include/linux/security.h      |  6 ++++++
> > >  kernel/bpf/bpf_lsm.c          |  1 +
> > >  kernel/bpf/syscall.c          | 10 ++++++++++
> > >  security/security.c           |  4 ++++
> > >  6 files changed, 35 insertions(+)
> >
> > ...
> >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 42d8473237ab..bbf70bddc770 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -4449,12 +4449,22 @@ static int bpf_obj_get_info_by_fd(const union=
 bpf_attr *attr,
> > >
> > >  static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, =
__u32 uattr_size)
> > >  {
> > > +       int err;
> > > +
> > >         if (CHECK_ATTR(BPF_BTF_LOAD))
> > >                 return -EINVAL;
> > >
> > > +       /* security checks */
> > > +       err =3D security_bpf_btf_load(attr);
> > > +       if (err < 0)
> > > +               return err;
> > > +       if (err > 0)
> > > +               goto skip_priv_checks;
> > > +
> > >         if (!bpf_capable())
> > >                 return -EPERM;
> > >
> > > +skip_priv_checks:
> > >         return btf_new_fd(attr, uattr, uattr_size);
> > >  }
> >
> > Beyond the objection I brought up in the patchset cover letter, I
> > believe the work of the security_bpf_btf_load() hook presented here
> > could be done by the existing security_bpf() LSM hook.  If you believe
> > that not to be the case, please let me know.
>
> security_bpf() could prevent BTF object loading only, but
> security_bpf_btf_load() can *also* allow *trusted* (according to LSM
> policy) unprivileged process to proceed. So it doesn't seem like they
> are interchangeable.

As discussed in the cover letter thread, I'm opposed to using a LSM
hook to skip/bypass/circumvent/etc. existing capability checks.

--=20
paul-moore.com
