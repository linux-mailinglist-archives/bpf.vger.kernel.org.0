Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84396E0317
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 02:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDMASM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 20:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMASM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 20:18:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4A526C;
        Wed, 12 Apr 2023 17:18:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so1291970a12.3;
        Wed, 12 Apr 2023 17:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dmh+VIDeCcD/Q00JmxO2G3y2ob4RNcDcQ/2975pkRs=;
        b=Ep1+AY3ghglkutH09gm6EKmB2QobJXVJtWPW57gB+sWv4JOGd+Ne+HHbKA9IvN3GFY
         tfqivFQ7TS5K8O4xNESNs01YHF3SLaQEPTXd1J0GtFVtCSH9MpwN7gA2cIWLw1dfBl2e
         dzdGjGyoBpldr1fqvSZdOAo90vxUDvvdje6s5iKKzZs55gSdR/uUef2Y2RE/tFLnNIrd
         ZAUwOOn72s9uOyZBfK0u+2li00A00OuFXUyxk4+tOgsSSx5V1qfR+JZ6Zx6kN+CkTKkb
         szSHAJrOeyUeg2Jdjs7FitPca0RSCc59sVjHYYm/yxbrNgJALfdQHXKvnZPbiKlnw/Un
         mrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Dmh+VIDeCcD/Q00JmxO2G3y2ob4RNcDcQ/2975pkRs=;
        b=fo1TOwWIqn4cGHdPdudkcX3mKuYstbSRbtg7k4lyLlT+Fu6RrDlRbBHt0riY2d7GOi
         a8cgfjcDkdkZCg6mwLGn40kP/Ys1kur1FBWozyPw621foCnN9IQZQYwnJLJMeYwzWKdf
         12K3dgow30Wkml49DjecxBMCvwaxYH/KbavumcIaHtd5T7ecMBsNyKIZpX62GE3cfr5T
         SadleY9HimC8/TfmKQJTeQO4tqNRJ63xDKXaskQAQsTQjqB4wL7xydh2VbTl2b8ATKLr
         fjQlt3tiLTWqfk5E4JKnAWZkM0/ZumbzdtdTr/f5zQZOMipiJFnkzLngyxniDBOstHBR
         FMQA==
X-Gm-Message-State: AAQBX9c6hBDNMNPXj3LJl0FXaFKkPhmft2MwtPGzR3Fj+uvCklypRQGO
        jG7rMsXcqxmn8iyJqlRjYEURanFAqKXMSQdsYXvD0Pgy
X-Google-Smtp-Source: AKy350ZMpMj0J6KuSn03ULiovglYl3M5W6Mw1LStQW0XCE3KWMUseAQ99n1z8d6ERmrtUW53VanzxU0/SG/1V9Nj8Z8=
X-Received: by 2002:a50:d783:0:b0:504:e957:2926 with SMTP id
 w3-20020a50d783000000b00504e9572926mr257972edi.1.1681345089301; Wed, 12 Apr
 2023 17:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-7-andrii@kernel.org>
 <6436f765.a70a0220.1091d.f714@mx.google.com>
In-Reply-To: <6436f765.a70a0220.1091d.f714@mx.google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 17:17:57 -0700
Message-ID: <CAEf4BzYgPzJgu-uizPEvqiPL6Lb5Zx1dKMhgDE2h0r8-0+1AGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/8] bpf: drop unnecessary bpf_capable() check in
 BPF_MAP_FREEZE command
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
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

On Wed, Apr 12, 2023 at 11:24=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Apr 11, 2023 at 09:32:58PM -0700, Andrii Nakryiko wrote:
> > Seems like that extra bpf_capable() check in BPF_MAP_FREEZE handler was
> > unintentionally left when we switched to a model that all BPF map
> > operations should be allowed regardless of CAP_BPF (or any other
> > capabilities), as long as process got BPF map FD somehow.
> >
> > This patch replaces bpf_capable() check in BPF_MAP_FREEZE handler with
> > writeable access check, given conceptually freezing the map is modifyin=
g
> > it: map becomes unmodifiable for subsequent updates.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Is this patch stand-alone? It seems like this could be taken separately,
> or at least just be the first patch in the series?
>

yep, I'll send it separately, good point

> > ---
> >  kernel/bpf/syscall.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 7d1165814efc..42d8473237ab 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2001,6 +2001,11 @@ static int map_freeze(const union bpf_attr *attr=
)
> >               return -ENOTSUPP;
> >       }
> >
> > +     if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
> > +             err =3D -EPERM;
> > +             goto err_put;
> > +     }
> > +
> >       mutex_lock(&map->freeze_mutex);
> >       if (bpf_map_write_active(map)) {
> >               err =3D -EBUSY;
> > @@ -2010,10 +2015,6 @@ static int map_freeze(const union bpf_attr *attr=
)
> >               err =3D -EBUSY;
> >               goto err_put;
> >       }
> > -     if (!bpf_capable()) {
> > -             err =3D -EPERM;
> > -             goto err_put;
> > -     }
> >
> >       WRITE_ONCE(map->frozen, true);
> >  err_put:
> > --
> > 2.34.1
> >
>
> --
> Kees Cook
