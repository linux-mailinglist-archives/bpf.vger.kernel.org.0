Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B536EF7FD
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbjDZPwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbjDZPwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 11:52:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D236A65
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 08:52:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-247296def99so5115090a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682524357; x=1685116357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxPVtgdaZRZShlRnK5AyFRm6hvPrBVlnqOIxoJf2T08=;
        b=APiwUK5Tr3CHsLl/3Fzvf/oZh0BHHUyEJQrasw5lfK/C/aj9QT2Cm9BhAgFa+ZCtJG
         sSBY++BA3k5h278Wsu5EWiecaWyv1ig9MG4W4em4M+QwDMe1kIdHyB5qHApV5BGwp8tf
         4dUuayJAUJuYDCi6aHqOSwFsX8PbyxEnva5c+QR0cqp4JnuZLTKe7j2B8B7wDMnuLHy9
         kO6BT69WGyGhvpnc6GSo5hc8WUN4v5bRFgmRNp4aeEz51KSTWObV7wfSjmNXl9cOEkFt
         m80gKhkyANu9HmW8aDqGHhhFWaHJLymy8lfr1a1nd0RPaDP7pC8d86YrGgrrIRgg+8kH
         AJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682524357; x=1685116357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxPVtgdaZRZShlRnK5AyFRm6hvPrBVlnqOIxoJf2T08=;
        b=Ynb5scd4Te1YI0W+8yqr3NEnQI1pW0Idu5bVgwsITpxctbEX4Om4PxTW7jCqER6DRs
         U60NIEUnu2pOThpgTm9vahFRSzUqzgc5pBWDd7i2ke55zSD6SRCcdlU99BKormMd/nyS
         h+NtTun2GW78zdeig3RfnbHIV1nftrjckF8CSXvDppt6mumHzlbAy500XrZxfiCezVWF
         i9QjagTScJhWGXYkxYpZMXSBBaCMUheeh1lIX9ZkZ5uBMUpjSYqspKO9qbDL9kTgBIg0
         j+pfLuML9JPELhr65g4hnKx9rahdEVIBbrdYmkJK/DF6PV8fWhu7puCz46gHK7QY9CDN
         OUcg==
X-Gm-Message-State: AAQBX9c6u5BMzpEFEz9BQSwx0qXNOJM/Gly6BuQX4t5LK5im1FesEhaM
        PhLGMwkNI6jAMYzcGuprP6VCxVUyA9AfKWYSwcGNhA==
X-Google-Smtp-Source: AKy350b0WLlnYynpfKdseZ3DUA0f5nUk+xvGN6rnnSi3L+i9ZO/rCnYDg5gI1S08xoO99Fe179AVu1uB+aV4bQcClkE=
X-Received: by 2002:a17:90b:143:b0:247:ad6d:7250 with SMTP id
 em3-20020a17090b014300b00247ad6d7250mr21975429pjb.12.1682524357060; Wed, 26
 Apr 2023 08:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230425000144.3125269-1-sdf@google.com> <fb24192d-b443-4e0b-df99-2a8f972cdf0a@meta.com>
 <CAKH8qBuCMk_Ct5+gwRjc3f_3Rq17D+WOV4LaSLJZpuOHU6a6kg@mail.gmail.com>
 <45aba643-7862-f615-6f6d-ff706e74a1b8@meta.com> <CAKH8qBtyTnb=N+hiHMntsRaxBYz=2KQD55gssXQfk2LFwdhLJQ@mail.gmail.com>
 <9488aafe-ce2b-0bf2-8e34-6cbf42328f58@meta.com> <CAKH8qBt9eSq9JCRu8BqzUZ_9FLJhpMsgNf56DC6n97uOwg6Tww@mail.gmail.com>
 <d20f40ba-36af-5060-d4e0-c467d59203ef@meta.com>
In-Reply-To: <d20f40ba-36af-5060-d4e0-c467d59203ef@meta.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 26 Apr 2023 08:52:25 -0700
Message-ID: <CAKH8qBtxZizNBWP0gXcPWj6YUCppbxhahi872K7m_7gJoBQEYQ@mail.gmail.com>
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

On Tue, Apr 25, 2023 at 12:43=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 4/25/23 11:35 AM, Stanislav Fomichev wrote:
> > On Tue, Apr 25, 2023 at 11:29=E2=80=AFAM Yonghong Song <yhs@meta.com> w=
rote:
> >>
> >>
> >>
> >> On 4/25/23 11:22 AM, Stanislav Fomichev wrote:
> >>> On Tue, Apr 25, 2023 at 11:10=E2=80=AFAM Yonghong Song <yhs@meta.com>=
 wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/25/23 10:04 AM, Stanislav Fomichev wrote:
> >>>>> On Mon, Apr 24, 2023 at 6:56=E2=80=AFPM Yonghong Song <yhs@meta.com=
> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 4/24/23 5:01 PM, Stanislav Fomichev wrote:
> >>>>>>> From: Peng Wei <pengweiprc@google.com>
> >>>>>>>
> >>>>>>> Compiling C++ BPF programs with existing bpf_helper_defs.h is not
> >>>>
> >>>> Just curious, why you want to compile BPF programs with C++?
> >>>> The patch looks good to me. But it would be great to know
> >>>> some reasoning since a lot of stuff, e.g., some CORE related
> >>>> intrinsics, not available for C++.
> >>>
> >>> Can you share more? What's not available? Any pointers to the docs ma=
ybe?
> >>
> >> Sorry, it is an attribute, instead of instrinsics.
> >>
> >> The attribute preserve_access_index/btf_type_tag/btf_decl_tag are all =
C
> >> only.
> >
> > Interesting, thanks! I don't think we use btf_type_tag/btf_decl_tag in
> > the program we want to try c++, but losing preserve_access_index might
> > be unfortunate :-( But we'll see..
> > Btw, any reason these are explicitly opted out from c++? Doesn't seem
> > like there is anything c-specific in them?
>
> Initial use case is C only. If we say to support C++, we will
> need to add attribute processing codes in various other places
> (member functions, templates, other c++ constructs, etc.)
> to convert these attributes to proper debuginfo. There are no use
> cases for this, so we didn't do it in the first place.

I see. In this case, let me respin the patch as is with the clang++
command to reproduce.
We'll experiment with our program internally to see whether these are
the showstoppers.

> > The c++ we are talking about here is mostly "c with classes +
> > templates"; no polymorphism / inheritance.
> >
> >> In llvm-project/clang/include/clang/Basic/Attr.td:
> >>
> >> def BPFPreserveAccessIndex : InheritableAttr,
> >>                                TargetSpecificAttr<TargetBPF>  {
> >>     let Spellings =3D [Clang<"preserve_access_index">];
> >>     let Subjects =3D SubjectList<[Record], ErrorDiag>;
> >>     let Documentation =3D [BPFPreserveAccessIndexDocs];
> >>     let LangOpts =3D [COnly];
> >> }
> >>
> >> def BTFDeclTag : InheritableAttr {
> >>     let Spellings =3D [Clang<"btf_decl_tag">];
> >>     let Args =3D [StringArgument<"BTFDeclTag">];
> >>     let Subjects =3D SubjectList<[Var, Function, Record, Field, Typede=
fName],
> >>                                ErrorDiag>;
> >>     let Documentation =3D [BTFDeclTagDocs];
> >>     let LangOpts =3D [COnly];
> >> }
> >>
> >> def BTFTypeTag : TypeAttr {
> >>     let Spellings =3D [Clang<"btf_type_tag">];
> >>     let Args =3D [StringArgument<"BTFTypeTag">];
> >>     let Documentation =3D [BTFTypeTagDocs];
> >>     let LangOpts =3D [COnly];
> >> }
> >>
> >>
> >>
> >>>
> >>> People here want to try to use c++ to see if templating helps with v4
> >>> vs v6 handling.
> >>> We have a bunch of copy-paste around this place and would like to see
> >>> whether c++ could make it a bit more readable.
> >>>
> >>>>>>> possible due to stricter C++ type conversions. C++ complains
> >>>>>>> about (void *) type conversions:
> >>>>>>>
> >>>>>>> bpf_helper_defs.h:57:67: error: invalid conversion from =E2=80=98=
void*=E2=80=99 to =E2=80=98void* (*)(void*, const void*)=E2=80=99 [-fpermis=
sive]
> >>>>>>>        57 | static void *(*bpf_map_lookup_elem)(void *map, const =
void *key) =3D (void *) 1;
> >>>>>>>           |                                                      =
             ^~~~~~~~~~
> >>>>>>>           |                                                      =
             |
> >>>>>>>           |                                                      =
             void*
> >>>>>>>
> >>>>>>> Extend bpf_doc.py to use proper function type instead of void.
> >>>>>>
> >>>>>> Could you specify what exactly the compilation command triggering =
the
> >>>>>> above error?
> >>>>>
> >>>>> The following does it for me:
> >>>>> clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h
> >>>>
> >>>> Thanks. It would be good if you add the above compilation command
> >>>> in the commit message.
> >>>
> >>> Sure, will add.
> >>>
> >>>>>
> >>>>>
> >>>>>>>
> >>>>>>> Before:
> >>>>>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
=3D (void *) 1;
> >>>>>>>
> >>>>>>> After:
> >>>>>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
=3D (void *(*)(void *map, const void *key)) 1;
> >>>>>>>
> >>>>>>> Signed-off-by: Peng Wei <pengweiprc@google.com>
> >>>>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>>>>>> ---
> >>>>>>>      scripts/bpf_doc.py | 7 ++++++-
> >>>>>>>      1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> >>>>>>> index eaae2ce78381..fa21137a90e7 100755
> >>>>>>> --- a/scripts/bpf_doc.py
> >>>>>>> +++ b/scripts/bpf_doc.py
> >>>>>>> @@ -827,6 +827,9 @@ COMMANDS
> >>>>>>>                      print(' *{}{}'.format(' \t' if line else '',=
 line))
> >>>>>>>
> >>>>>>>              print(' */')
> >>>>>>> +        fptr_type =3D '%s%s(*)(' % (
> >>>>>>> +            self.map_type(proto['ret_type']),
> >>>>>>> +            ((' ' + proto['ret_star']) if proto['ret_star'] else=
 ''))
> >>>>>>>              print('static %s %s(*%s)(' % (self.map_type(proto['r=
et_type']),
> >>>>>>>                                            proto['ret_star'], pro=
to['name']), end=3D'')
> >>>>>>>              comma =3D ''
> >>>>>>> @@ -845,8 +848,10 @@ COMMANDS
> >>>>>>>                      one_arg +=3D '{}'.format(n)
> >>>>>>>                  comma =3D ', '
> >>>>>>>                  print(one_arg, end=3D'')
> >>>>>>> +            fptr_type +=3D one_arg
> >>>>>>>
> >>>>>>> -        print(') =3D (void *) %d;' % helper.enum_val)
> >>>>>>> +        fptr_type +=3D ')'
> >>>>>>> +        print(') =3D (%s) %d;' % (fptr_type, helper.enum_val))
> >>>>>>>              print('')
> >>>>>>>
> >>>>>>>      ############################################################=
###################
