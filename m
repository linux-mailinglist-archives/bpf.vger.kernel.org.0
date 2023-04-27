Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9B96F0A61
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbjD0Q7z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244132AbjD0Q7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 12:59:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7142735
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 09:59:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517c01edaaaso6463424a12.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682614785; x=1685206785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyJCAkFGXPNfBFwV2DX8IKSylQGp7YbLC7bXNF8MyVo=;
        b=ej+WblSIcexGQv0WrfwS7+A3yCdE5OvtPo4+HR809gqPf+6ptbMZKwIAISAMe/m6vC
         v38jWOr0DjeSiGFpxtjqTe5/qZQrHkdY2ww5AQSWsQmp31i1ya43WH6zEMu3uHvuUTXX
         itMAdtiNxekSXHyJDCC6qgVarAslbQ7anh66suXvYAn9WwaSvTJur9BNK4b+mPckeG5T
         HHfreANP66N1BfQyZnrAki//LIuz9eYTBMwVEdM6boksNwKHn52ybbiMYAnsZdjTZ4ZY
         h3wr5evRwy3omoIC/9rqLulCBqin3V4Bxjag2U+Q9S9dTzySNcZtNkAYaQcgCYqg/X8m
         5mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614785; x=1685206785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyJCAkFGXPNfBFwV2DX8IKSylQGp7YbLC7bXNF8MyVo=;
        b=gxu3aZRIFmcmIWxkn+VJ8/eEg7tktmy9K866IbLCde1EH96sICpeIlYAue8FDPqVTe
         Z8RJRLdMBC5M+FPGQ2cmmubNsbwUCeI+McsEra2uyccOgT7cflFRRQfIqnfb4iq9s4D+
         qFwhhfg0I0Sf+zqocuo9Vk2iKcVVNxnXMYBy3JvVkaXRDmCn8spLdgnRixkG1M5xne92
         ifAuI4MMMPJOhYewX0jd4V8UD5mDVHS5GPQbsuaMQ7qpqEhLY5OcG6iBu+jsIfgLUNcD
         EOF+WNK66nCX6W2RkaKmX4wH2QEzL0ABQEhg6kLxi9sqofdtemsTxWxX8oUjQFF8uvZE
         ivZw==
X-Gm-Message-State: AC+VfDzMDR6MTOHYR5gkhJ9Lu0wp/VvJ7Pp4Ccp6QBW6yj9BCwi3zCB5
        ZWvcrNQEXR6n7Hb5ETVJLIMf5hg5MC//YvebLQsci6F/yiFBTLlrr8dHcg==
X-Google-Smtp-Source: ACHHUZ49lzKoAzo/wmtElMHBzc5z3O/pZSKby2eyYVpf+Q/mrnKYkcKTPP0VfQS9cFaqAaoUmA4WqEjUFqepxXO3pa0=
X-Received: by 2002:a17:90a:4dc5:b0:246:b4b4:5540 with SMTP id
 r5-20020a17090a4dc500b00246b4b45540mr2555095pjl.1.1682614784943; Thu, 27 Apr
 2023 09:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230426155357.4158846-1-sdf@google.com> <CAEf4BzatobESuMtP=ndHuf+imtX1ovM-4+cnV9c=UdsC=teZBQ@mail.gmail.com>
In-Reply-To: <CAEf4BzatobESuMtP=ndHuf+imtX1ovM-4+cnV9c=UdsC=teZBQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 27 Apr 2023 09:59:33 -0700
Message-ID: <CAKH8qBt4xqBUpXefqPk5AyU1Rr0-h-vCJzS_0Bu-987gL4wi4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Make bpf_helper_defs.h c++ friendly
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Peng Wei <pengweiprc@google.com>, Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 6:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 26, 2023 at 8:54=E2=80=AFAM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > From: Peng Wei <pengweiprc@google.com>
> >
> > Compiling C++ BPF programs with existing bpf_helper_defs.h is not
> > possible due to stricter C++ type conversions. C++ complains
> > about (void *) type conversions:
> >
> > $ clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h
> >
> > bpf_helper_defs.h:57:67: error: invalid conversion from =E2=80=98void*=
=E2=80=99 to =E2=80=98void* (*)(void*, const void*)=E2=80=99 [-fpermissive]
>
> Can you use -fpermissive instead? As Yonghong said, C++ is not really
> supported, so pretending we do will just cause more confusion and
> issues down the line.

I get the same errors with -fpermissive :-(

RE unsupported C++: we are not really subscribing to support it here, right=
?
Just making it easier for the folks who want to experiment with it to
try it out.

Maybe I should stick something like this into the header?
#ifdef __cplusplus
#warning "C++ is not supported, use at your own risk!"
#endif

But we should be able to carry this patch internally if you see no value.
I wanted to share it in case somebody else is gonna try the same eventually=
..

> BTW, can you elaborate more on v4 vs v6 code reuse (or what was it)? I
> wonder if there is something that would stay within C domain that
> could be done?

We have a program which handles both v4 and v6 packets. The logic is
mostly the same for v4 and v6: parse out the addresses, ports, lookup
some maps and do some action on match. Right now, both cases are
handled explicitly with a bunch of copy-paste. The idea of this c++
experiment is to leverage templates to write this logic once and
parametrize on the address sizes, packet field offsets, etc. I'm
pretty certain we can do similar things in C, but it feels like it
will be less expressive and a bit more ugly (assuming we'd use a
preprocessor to do it).

> >    57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key)=
 =3D (void *) 1;
> >       |                                                                =
   ^~~~~~~~~~
> >       |                                                                =
   |
> >       |                                                                =
   void*
> >
> > Extend bpf_doc.py to use proper function type instead of void.
> >
> > Before:
> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (vo=
id *) 1;
> >
> > After:
> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (vo=
id *(*)(void *map, const void *key)) 1;
> >
> > v2:
> > - add clang++ invocation example (Yonghong)
> >
> > Cc: Yonghong Song <yhs@meta.com>
> > Signed-off-by: Peng Wei <pengweiprc@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  scripts/bpf_doc.py | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> > index eaae2ce78381..fa21137a90e7 100755
> > --- a/scripts/bpf_doc.py
> > +++ b/scripts/bpf_doc.py
> > @@ -827,6 +827,9 @@ COMMANDS
> >                  print(' *{}{}'.format(' \t' if line else '', line))
> >
> >          print(' */')
> > +        fptr_type =3D '%s%s(*)(' % (
> > +            self.map_type(proto['ret_type']),
> > +            ((' ' + proto['ret_star']) if proto['ret_star'] else ''))
> >          print('static %s %s(*%s)(' % (self.map_type(proto['ret_type'])=
,
> >                                        proto['ret_star'], proto['name']=
), end=3D'')
> >          comma =3D ''
> > @@ -845,8 +848,10 @@ COMMANDS
> >                  one_arg +=3D '{}'.format(n)
> >              comma =3D ', '
> >              print(one_arg, end=3D'')
> > +            fptr_type +=3D one_arg
> >
> > -        print(') =3D (void *) %d;' % helper.enum_val)
> > +        fptr_type +=3D ')'
> > +        print(') =3D (%s) %d;' % (fptr_type, helper.enum_val))
> >          print('')
> >
> >  ######################################################################=
#########
> > --
> > 2.40.1.495.gc816e09b53d-goog
> >
