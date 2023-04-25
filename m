Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60B16EE78D
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjDYSgE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjDYSgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 14:36:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65BCC160
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 11:36:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a6ebc66ca4so47348075ad.3
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682447761; x=1685039761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUeLHCUEjDjoRAFYl3qI7ze44YYtTRykJ17G6nBOCjw=;
        b=bsInFvKPKckJZyiTrpQiJUxm8nC4BKnUMgn2B+MOULpVp4rzEIMLb8R36qVlcA/BT3
         PT+81eoJ5zCh6gLS+jHIg5iZyadZvgsIzsVolN+d7zH94kPfJJeo7yn3mDosw+idlnmC
         FVqDj+yE40I3A9Ejx2Va2Mw8wQD+CriO9H+GJKOPou2s5kEwFDzowmjVKxcidVVxdPtt
         XQcTuwcua0git578Tf20SiSO8NRoYtZFikx3xhNxdYBqeA7iZ7E5yWE4EPzdtSeXips1
         iCmrBIi4HujYvZ7ZPGQdPEEB8n/izHlfAO18Xnl86MVykRWBMKFCvGSllbAkqXEWMfms
         gjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682447761; x=1685039761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUeLHCUEjDjoRAFYl3qI7ze44YYtTRykJ17G6nBOCjw=;
        b=ehbPDP3zLZOwFKi7O9+HEwaKROgqgEKD3zVgHUC3/RJ+G0pmNBnh9uK+yIscyn9g1A
         RPAFExIMpL8eSMAiXmKk7RiPhxri5JS/NNI2tGWBj/W6bnZg61xhcinqPQvVhM1iLD2j
         BmN0DjalxWgPDAlpjh6vouzyuL2ve58yP/X9f0HFs0D6ap57MPd0wIDlFuttYJ0nHuEy
         LGONo7Bg9jdJAHgWHVgIAwsBWmS2028nhLm7auO2i9L9AK7y165IbDyfY6IoH5jkPYP2
         OvOol5xNmpWz91cyLSHCmw01VuC1xblq8Gs88+jJgoGIBkcQkIJjXPEBDMoSgJCwg6eh
         QAUQ==
X-Gm-Message-State: AC+VfDxOWu006MDo6lnBJyxQ6TGTrcGled8krhHWOZoeub7r5/76yZgT
        BbcIWkhzpd3rodfEzVEq5P+zaUpW2OznYXnroJN7QA==
X-Google-Smtp-Source: ACHHUZ6VfoO4g2v5YPUH3AoL3ZbrTzpDDlkSSJgmHUi2nbwXkid6MsRfgJua7ng72Ykq6JMA5u8gk3HMNqDSvddJBsA=
X-Received: by 2002:a17:903:1109:b0:1a9:7b5e:14ba with SMTP id
 n9-20020a170903110900b001a97b5e14bamr7945955plh.29.1682447761191; Tue, 25 Apr
 2023 11:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230425000144.3125269-1-sdf@google.com> <fb24192d-b443-4e0b-df99-2a8f972cdf0a@meta.com>
 <CAKH8qBuCMk_Ct5+gwRjc3f_3Rq17D+WOV4LaSLJZpuOHU6a6kg@mail.gmail.com>
 <45aba643-7862-f615-6f6d-ff706e74a1b8@meta.com> <CAKH8qBtyTnb=N+hiHMntsRaxBYz=2KQD55gssXQfk2LFwdhLJQ@mail.gmail.com>
 <9488aafe-ce2b-0bf2-8e34-6cbf42328f58@meta.com>
In-Reply-To: <9488aafe-ce2b-0bf2-8e34-6cbf42328f58@meta.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 25 Apr 2023 11:35:50 -0700
Message-ID: <CAKH8qBt9eSq9JCRu8BqzUZ_9FLJhpMsgNf56DC6n97uOwg6Tww@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Make bpf_helper_defs.h c++ friendly
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Peng Wei <pengweiprc@google.com>
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

On Tue, Apr 25, 2023 at 11:29=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 4/25/23 11:22 AM, Stanislav Fomichev wrote:
> > On Tue, Apr 25, 2023 at 11:10=E2=80=AFAM Yonghong Song <yhs@meta.com> w=
rote:
> >>
> >>
> >>
> >> On 4/25/23 10:04 AM, Stanislav Fomichev wrote:
> >>> On Mon, Apr 24, 2023 at 6:56=E2=80=AFPM Yonghong Song <yhs@meta.com> =
wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/24/23 5:01 PM, Stanislav Fomichev wrote:
> >>>>> From: Peng Wei <pengweiprc@google.com>
> >>>>>
> >>>>> Compiling C++ BPF programs with existing bpf_helper_defs.h is not
> >>
> >> Just curious, why you want to compile BPF programs with C++?
> >> The patch looks good to me. But it would be great to know
> >> some reasoning since a lot of stuff, e.g., some CORE related
> >> intrinsics, not available for C++.
> >
> > Can you share more? What's not available? Any pointers to the docs mayb=
e?
>
> Sorry, it is an attribute, instead of instrinsics.
>
> The attribute preserve_access_index/btf_type_tag/btf_decl_tag are all C
> only.

Interesting, thanks! I don't think we use btf_type_tag/btf_decl_tag in
the program we want to try c++, but losing preserve_access_index might
be unfortunate :-( But we'll see..
Btw, any reason these are explicitly opted out from c++? Doesn't seem
like there is anything c-specific in them?
The c++ we are talking about here is mostly "c with classes +
templates"; no polymorphism / inheritance.

> In llvm-project/clang/include/clang/Basic/Attr.td:
>
> def BPFPreserveAccessIndex : InheritableAttr,
>                               TargetSpecificAttr<TargetBPF>  {
>    let Spellings =3D [Clang<"preserve_access_index">];
>    let Subjects =3D SubjectList<[Record], ErrorDiag>;
>    let Documentation =3D [BPFPreserveAccessIndexDocs];
>    let LangOpts =3D [COnly];
> }
>
> def BTFDeclTag : InheritableAttr {
>    let Spellings =3D [Clang<"btf_decl_tag">];
>    let Args =3D [StringArgument<"BTFDeclTag">];
>    let Subjects =3D SubjectList<[Var, Function, Record, Field, TypedefNam=
e],
>                               ErrorDiag>;
>    let Documentation =3D [BTFDeclTagDocs];
>    let LangOpts =3D [COnly];
> }
>
> def BTFTypeTag : TypeAttr {
>    let Spellings =3D [Clang<"btf_type_tag">];
>    let Args =3D [StringArgument<"BTFTypeTag">];
>    let Documentation =3D [BTFTypeTagDocs];
>    let LangOpts =3D [COnly];
> }
>
>
>
> >
> > People here want to try to use c++ to see if templating helps with v4
> > vs v6 handling.
> > We have a bunch of copy-paste around this place and would like to see
> > whether c++ could make it a bit more readable.
> >
> >>>>> possible due to stricter C++ type conversions. C++ complains
> >>>>> about (void *) type conversions:
> >>>>>
> >>>>> bpf_helper_defs.h:57:67: error: invalid conversion from =E2=80=98vo=
id*=E2=80=99 to =E2=80=98void* (*)(void*, const void*)=E2=80=99 [-fpermissi=
ve]
> >>>>>       57 | static void *(*bpf_map_lookup_elem)(void *map, const voi=
d *key) =3D (void *) 1;
> >>>>>          |                                                         =
          ^~~~~~~~~~
> >>>>>          |                                                         =
          |
> >>>>>          |                                                         =
          void*
> >>>>>
> >>>>> Extend bpf_doc.py to use proper function type instead of void.
> >>>>
> >>>> Could you specify what exactly the compilation command triggering th=
e
> >>>> above error?
> >>>
> >>> The following does it for me:
> >>> clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h
> >>
> >> Thanks. It would be good if you add the above compilation command
> >> in the commit message.
> >
> > Sure, will add.
> >
> >>>
> >>>
> >>>>>
> >>>>> Before:
> >>>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D=
 (void *) 1;
> >>>>>
> >>>>> After:
> >>>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D=
 (void *(*)(void *map, const void *key)) 1;
> >>>>>
> >>>>> Signed-off-by: Peng Wei <pengweiprc@google.com>
> >>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>>>> ---
> >>>>>     scripts/bpf_doc.py | 7 ++++++-
> >>>>>     1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> >>>>> index eaae2ce78381..fa21137a90e7 100755
> >>>>> --- a/scripts/bpf_doc.py
> >>>>> +++ b/scripts/bpf_doc.py
> >>>>> @@ -827,6 +827,9 @@ COMMANDS
> >>>>>                     print(' *{}{}'.format(' \t' if line else '', li=
ne))
> >>>>>
> >>>>>             print(' */')
> >>>>> +        fptr_type =3D '%s%s(*)(' % (
> >>>>> +            self.map_type(proto['ret_type']),
> >>>>> +            ((' ' + proto['ret_star']) if proto['ret_star'] else '=
'))
> >>>>>             print('static %s %s(*%s)(' % (self.map_type(proto['ret_=
type']),
> >>>>>                                           proto['ret_star'], proto[=
'name']), end=3D'')
> >>>>>             comma =3D ''
> >>>>> @@ -845,8 +848,10 @@ COMMANDS
> >>>>>                     one_arg +=3D '{}'.format(n)
> >>>>>                 comma =3D ', '
> >>>>>                 print(one_arg, end=3D'')
> >>>>> +            fptr_type +=3D one_arg
> >>>>>
> >>>>> -        print(') =3D (void *) %d;' % helper.enum_val)
> >>>>> +        fptr_type +=3D ')'
> >>>>> +        print(') =3D (%s) %d;' % (fptr_type, helper.enum_val))
> >>>>>             print('')
> >>>>>
> >>>>>     ###############################################################=
################
