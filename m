Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC356EE780
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjDYSXE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYSXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 14:23:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838D62102
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 11:23:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2472740a0dbso5362279a91.3
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682446982; x=1685038982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ok4x80UFWBapaG5DW7lt7dcdW+I/BaqmGjgNmkYHkg=;
        b=z1F76mXzfozpUp8Ts0ui/bfLdF4dhWlh6ORn6Uq13KOxEDig06ounbhvfXKx7FM+n6
         yqyZQNCKVkW0ffGyLeY0W7RfWiDtdK/zvJtqTrnW781elbZw5AMrME/X6tz2vO+w9OAB
         m14U7BaSENB3f2c0WYcffiw6hQ2QsvFakCbJGWfeQ7yZh9uCbn/saRKQxA7QxXUFZNMz
         MejYLq/iFqlRt86oPYKxPdF6ywT/zLbHaDLc/3b6M76GYikTRa8VyW31q6QUWYCwvXkA
         xvA7rnpR21LK8R/SGdlJm9aPjmEI6kc1qoBrNEcuMu78lNyCRUeA5Hdp2j4kvJ1IXdZX
         5E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682446982; x=1685038982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ok4x80UFWBapaG5DW7lt7dcdW+I/BaqmGjgNmkYHkg=;
        b=OsadxHq4qYnU9V0rhptzcKRN7bNe2OeuqYMqmytjJVWFBzm+0BQTKONsiRUit5hSaB
         Te2LhYbRGM9oS591CdXyOwD+sDVoRSMm+c1HT4oyI1KfsS/WWf0/R0tHypHcmOqn3S7T
         rWFfMOFBTPm272mT/gnQmhidSMaPiLIX7e5UNRt3A/Rq0WHt9K/T+/wv9regsy2PJZeh
         sSCvU9oAo/UTe+6VeXhI3eFiBbe6JDX1AzM2rSfAyZxIC3RKVInejmjBKDF0rBSwOBg2
         4wyw9cLmthHYkYWCxkrNUIdtIgLVdJua8Oc4jIOhpauCadA+XK2S6YFb464c/xv7xGzj
         r2/g==
X-Gm-Message-State: AAQBX9fALDCB5d2ng1/Qe0NwDC2z6Yk0KULcwGGwEHLARQwzXXqEi2e4
        NvUepDsUR7HRD0oXz+hGLTNXYl3WrdzL+5AZpq5dBA==
X-Google-Smtp-Source: AKy350YPH9PEi6oo0Q/CFUi1X5Ru4HFL1GH6d/uxaLm78gPKEkrI8ucvayJT6VEcd98pVJKXUqDUUi95I6pXsitmhvE=
X-Received: by 2002:a17:90b:196:b0:247:1997:6a1f with SMTP id
 t22-20020a17090b019600b0024719976a1fmr18833707pjs.12.1682446980071; Tue, 25
 Apr 2023 11:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230425000144.3125269-1-sdf@google.com> <fb24192d-b443-4e0b-df99-2a8f972cdf0a@meta.com>
 <CAKH8qBuCMk_Ct5+gwRjc3f_3Rq17D+WOV4LaSLJZpuOHU6a6kg@mail.gmail.com> <45aba643-7862-f615-6f6d-ff706e74a1b8@meta.com>
In-Reply-To: <45aba643-7862-f615-6f6d-ff706e74a1b8@meta.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 25 Apr 2023 11:22:48 -0700
Message-ID: <CAKH8qBtyTnb=N+hiHMntsRaxBYz=2KQD55gssXQfk2LFwdhLJQ@mail.gmail.com>
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

On Tue, Apr 25, 2023 at 11:10=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 4/25/23 10:04 AM, Stanislav Fomichev wrote:
> > On Mon, Apr 24, 2023 at 6:56=E2=80=AFPM Yonghong Song <yhs@meta.com> wr=
ote:
> >>
> >>
> >>
> >> On 4/24/23 5:01 PM, Stanislav Fomichev wrote:
> >>> From: Peng Wei <pengweiprc@google.com>
> >>>
> >>> Compiling C++ BPF programs with existing bpf_helper_defs.h is not
>
> Just curious, why you want to compile BPF programs with C++?
> The patch looks good to me. But it would be great to know
> some reasoning since a lot of stuff, e.g., some CORE related
> intrinsics, not available for C++.

Can you share more? What's not available? Any pointers to the docs maybe?

People here want to try to use c++ to see if templating helps with v4
vs v6 handling.
We have a bunch of copy-paste around this place and would like to see
whether c++ could make it a bit more readable.

> >>> possible due to stricter C++ type conversions. C++ complains
> >>> about (void *) type conversions:
> >>>
> >>> bpf_helper_defs.h:57:67: error: invalid conversion from =E2=80=98void=
*=E2=80=99 to =E2=80=98void* (*)(void*, const void*)=E2=80=99 [-fpermissive=
]
> >>>      57 | static void *(*bpf_map_lookup_elem)(void *map, const void *=
key) =3D (void *) 1;
> >>>         |                                                            =
       ^~~~~~~~~~
> >>>         |                                                            =
       |
> >>>         |                                                            =
       void*
> >>>
> >>> Extend bpf_doc.py to use proper function type instead of void.
> >>
> >> Could you specify what exactly the compilation command triggering the
> >> above error?
> >
> > The following does it for me:
> > clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h
>
> Thanks. It would be good if you add the above compilation command
> in the commit message.

Sure, will add.

> >
> >
> >>>
> >>> Before:
> >>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (=
void *) 1;
> >>>
> >>> After:
> >>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (=
void *(*)(void *map, const void *key)) 1;
> >>>
> >>> Signed-off-by: Peng Wei <pengweiprc@google.com>
> >>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>> ---
> >>>    scripts/bpf_doc.py | 7 ++++++-
> >>>    1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> >>> index eaae2ce78381..fa21137a90e7 100755
> >>> --- a/scripts/bpf_doc.py
> >>> +++ b/scripts/bpf_doc.py
> >>> @@ -827,6 +827,9 @@ COMMANDS
> >>>                    print(' *{}{}'.format(' \t' if line else '', line)=
)
> >>>
> >>>            print(' */')
> >>> +        fptr_type =3D '%s%s(*)(' % (
> >>> +            self.map_type(proto['ret_type']),
> >>> +            ((' ' + proto['ret_star']) if proto['ret_star'] else '')=
)
> >>>            print('static %s %s(*%s)(' % (self.map_type(proto['ret_typ=
e']),
> >>>                                          proto['ret_star'], proto['na=
me']), end=3D'')
> >>>            comma =3D ''
> >>> @@ -845,8 +848,10 @@ COMMANDS
> >>>                    one_arg +=3D '{}'.format(n)
> >>>                comma =3D ', '
> >>>                print(one_arg, end=3D'')
> >>> +            fptr_type +=3D one_arg
> >>>
> >>> -        print(') =3D (void *) %d;' % helper.enum_val)
> >>> +        fptr_type +=3D ')'
> >>> +        print(') =3D (%s) %d;' % (fptr_type, helper.enum_val))
> >>>            print('')
> >>>
> >>>    ##################################################################=
#############
