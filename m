Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34A55139AE
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349951AbiD1Q0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349952AbiD1Q0U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:26:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586016A43F;
        Thu, 28 Apr 2022 09:23:05 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b5so2314192ile.0;
        Thu, 28 Apr 2022 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFhJTeBHegUGtkoKbPnigoTiPCA3aoao0K+t84QabKg=;
        b=jfXKPvMzYUegjls0RnwX8rppG+Ce5wuHyePNtzxGVl+zXyb2acEES4JRq5s3Robr3W
         AY623UmGkEqjuPDd0mngHOQHxpCkAkAFd2aFU3589FRzNtpTicD6Hv6oeXRpa0weT3yg
         TlW5cMZ1ALl7VZHhvqWjvwEJLI4dqRtMZAOZWy/vy6R9w6RJ+3ALAjvmqjE1MkjK4gUk
         yY0SGHz5Cwn4Dr0swRqp7cwUAfDck1LUFA/KKe0tRD3A+hu09E4eU7Gx6wJ16K7DZsvY
         U0Kk3W6c7jGJuy4BdJsXNsiDgIt/Bbi7yvVLjPBwkQ8Z1ac6Uxb2DWlDCIc+tFJNlLhC
         s63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFhJTeBHegUGtkoKbPnigoTiPCA3aoao0K+t84QabKg=;
        b=Ctnm7JrB7ke6zXmNe6tMZPfChH17ByObLUj4rVaUuS2npUYx+hANZqdSh9mUJjm/0U
         0AQ9Z3hskl8+U1rKz58dpbwakXGuZVf58Lj4NIaNAZNNH0iqMcNNWw7SCEa8YhqxcyLS
         6t/EIyqvWoo/78T1ZyJmbAnGGlt3Y4OWTfUF89GpKQ92aOWHIstT+2uRmcbl1Alp9oqE
         NBJ1CrwHWE1E6k8sIlloalUsgy/mGHzqw9LMBT1ditDrOjl2J+9WJCNpYR8DZ0slkqRJ
         R33/IVtAH1OSJ+j2HVsaddS1nvKNDI0YaOAz0EZjRSe6CYqXYNo220yuCzrpHYgT4R2z
         PQng==
X-Gm-Message-State: AOAM530k7YGTLavmnuu1SPGXCDl33x1kslw/u9r2jCZC2JKTRiBmfXUf
        9jIb4RGFmQjuhkZfhet6WPewyBoIoOpDBS+4Ha0=
X-Google-Smtp-Source: ABdhPJzHur/icTYgIyTfK7H0clyD69BvncoOM31SARFGHRbB1eRkm4EmwY58j2ayT+Bf0E9S2cuGD1rcv1FWr/ye3oY=
X-Received: by 2002:a92:c247:0:b0:2cc:1798:74fe with SMTP id
 k7-20020a92c247000000b002cc179874femr13498199ilo.239.1651162984685; Thu, 28
 Apr 2022 09:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <202204271656.OTIj2QNJ-lkp@intel.com> <Ymj5AJtiBx0UjEdT@8276d8ba1d54>
 <CAADnVQLSfbc8rNQC+0rGxgJCbXYCENsAORZmiXqcXc+W0N8A0g@mail.gmail.com>
In-Reply-To: <CAADnVQLSfbc8rNQC+0rGxgJCbXYCENsAORZmiXqcXc+W0N8A0g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Apr 2022 09:22:53 -0700
Message-ID: <CAEf4BzZDmOWy+q_sqW7ziSjdqgZ9c7hGDkD4TKjAQ9dzN0_-ug@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix returnvar.cocci warnings
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Andrii Nakryiko <andrii@kernel.org>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Wed, Apr 27, 2022 at 9:07 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 27, 2022 at 1:04 AM kernel test robot <lkp@intel.com> wrote:
> >
> > From: kernel test robot <lkp@intel.com>
> >
> > tools/lib/bpf/relo_core.c:1064:8-11: Unneeded variable: "len". Return "0" on line 1086
> >
> >
> >  Remove unneeded variable used to store return value.
> >
> > Generated by: scripts/coccinelle/misc/returnvar.cocci
> >
> > Fixes: b58af63aab11 ("libbpf: Refactor CO-RE relo human description formatting routine")
> > CC: Andrii Nakryiko <andrii@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: kernel test robot <lkp@intel.com>
> > ---
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   f02ac5c95dfd45d2f50ecc68d79177de326c668c
> > commit: b58af63aab11e4ae00fe96de9505759cfdde8ee9 [6746/7265] libbpf: Refactor CO-RE relo human description formatting routine
> > :::::: branch date: 2 hours ago
> > :::::: commit date: 9 hours ago
> >
> >  tools/lib/bpf/relo_core.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > --- a/tools/lib/bpf/relo_core.c
> > +++ b/tools/lib/bpf/relo_core.c
> > @@ -1061,7 +1061,7 @@ static int bpf_core_format_spec(char *bu
> >         const struct btf_enum *e;
> >         const char *s;
> >         __u32 type_id;
> > -       int i, len = 0;
> > +       int i;
> >
> >  #define append_buf(fmt, args...)                               \
> >         ({                                                      \
> > @@ -1083,7 +1083,7 @@ static int bpf_core_format_spec(char *bu
> >                    type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
> >
> >         if (core_relo_is_type_based(spec->relo_kind))
> > -               return len;
> > +               return 0;
>
> cocci is wrong.
> It missed append_buf() macro.

Should be irrelevant once [0] lands. It makes use of that return value directly.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20220428041523.4089853-2-andrii@kernel.org/

>
> Please fix cocci so we don't have to manually deal with
> broken patches like this one.
