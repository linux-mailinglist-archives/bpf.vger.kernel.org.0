Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6111F6EE64E
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 19:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjDYREn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbjDYREj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 13:04:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44613A9E
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 10:04:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b73203e0aso36941361b3a.1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682442278; x=1685034278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2xYQePwwUN+qar6PIA4VppKekY05ftGrMMzzmUDRLw=;
        b=HO5U7PZswF4DQDJzaMZRm+xfPt1oPWe4nciqgUWUx+5AYJdjjzin0LdFzfQ1KxVudY
         8u7AU72uR8xbtzYs7d6q4bIzWsqZPkY1in9GPTzDUUMpsKoK3SXfEphoVKJLKgLcdPg2
         zHA0Ru/wJEFAoYWWshScFEFrgQqXJ73YsENvfA74vc0XuOliT8W6gaP1gSRs2puqC0Rk
         +nESgkYlN9Arr+/EDCXxZBl/gMIlB8npBqxHqGPS9THfZ/fo8flGKgSEk97kUrUMu0mm
         QXO5fAA2h5dvgCn9JWU/bOJJtRpuhoGOctYtkK9wWAPR1atIY9LiSCxpjpMD2JWt+w0H
         5yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682442278; x=1685034278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2xYQePwwUN+qar6PIA4VppKekY05ftGrMMzzmUDRLw=;
        b=CyjXleL2Mfn5i+OCJ4I1sjvN1787UAChJLhT2PuKYQ3NiSurj4y6gunVjgT6vwlZe8
         7fhqXxhP99y1Bh+PxinCfe69/ymvGmKb0T0CSlSZa7ns0NPCr3fL/7A9+Chri1EOAYsZ
         03YH8j8QNTJxoTA12Z2u1fujedmv5DpfM/zoBqeT3kFJrsOGoqwmm1GYKzWzCy8eNWES
         rYjJ92875s+3by+ZoggdPVAXLi7yrrr/9VQoLSJgYO7AQaFn6WpHwSUmdPj9iZFUP7qY
         iSzb0KHGf+vmHJm2fGZ8vO1JGeGLo5SBhZniCsiV9L2eubwG6YaqT1M/2nIpV3PbusMh
         r4qQ==
X-Gm-Message-State: AAQBX9fMiYFi/byLPcMzAgf6v3gvjp1nRk1KBe0K7Pk7bvbc+WXKJm2C
        u5GCeDOmjeAD0ei0pKaJZX2HRnawZ+AvrCUcYJT1uA==
X-Google-Smtp-Source: AKy350ahXY+doDtZSBg/IFvZxllKR/XxynH2mJkLawRuln3bCi93jFjPCmDN6/8QRfhIb0b5Dlwpys/PSiFpfT0bSSg=
X-Received: by 2002:a17:90b:1b4e:b0:247:4fe5:f09c with SMTP id
 nv14-20020a17090b1b4e00b002474fe5f09cmr20449079pjb.15.1682442278085; Tue, 25
 Apr 2023 10:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230425000144.3125269-1-sdf@google.com> <fb24192d-b443-4e0b-df99-2a8f972cdf0a@meta.com>
In-Reply-To: <fb24192d-b443-4e0b-df99-2a8f972cdf0a@meta.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 25 Apr 2023 10:04:25 -0700
Message-ID: <CAKH8qBuCMk_Ct5+gwRjc3f_3Rq17D+WOV4LaSLJZpuOHU6a6kg@mail.gmail.com>
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

On Mon, Apr 24, 2023 at 6:56=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 4/24/23 5:01 PM, Stanislav Fomichev wrote:
> > From: Peng Wei <pengweiprc@google.com>
> >
> > Compiling C++ BPF programs with existing bpf_helper_defs.h is not
> > possible due to stricter C++ type conversions. C++ complains
> > about (void *) type conversions:
> >
> > bpf_helper_defs.h:57:67: error: invalid conversion from =E2=80=98void*=
=E2=80=99 to =E2=80=98void* (*)(void*, const void*)=E2=80=99 [-fpermissive]
> >     57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key=
) =3D (void *) 1;
> >        |                                                               =
    ^~~~~~~~~~
> >        |                                                               =
    |
> >        |                                                               =
    void*
> >
> > Extend bpf_doc.py to use proper function type instead of void.
>
> Could you specify what exactly the compilation command triggering the
> above error?

The following does it for me:
clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h


> >
> > Before:
> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (vo=
id *) 1;
> >
> > After:
> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (vo=
id *(*)(void *map, const void *key)) 1;
> >
> > Signed-off-by: Peng Wei <pengweiprc@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   scripts/bpf_doc.py | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> > index eaae2ce78381..fa21137a90e7 100755
> > --- a/scripts/bpf_doc.py
> > +++ b/scripts/bpf_doc.py
> > @@ -827,6 +827,9 @@ COMMANDS
> >                   print(' *{}{}'.format(' \t' if line else '', line))
> >
> >           print(' */')
> > +        fptr_type =3D '%s%s(*)(' % (
> > +            self.map_type(proto['ret_type']),
> > +            ((' ' + proto['ret_star']) if proto['ret_star'] else ''))
> >           print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']=
),
> >                                         proto['ret_star'], proto['name'=
]), end=3D'')
> >           comma =3D ''
> > @@ -845,8 +848,10 @@ COMMANDS
> >                   one_arg +=3D '{}'.format(n)
> >               comma =3D ', '
> >               print(one_arg, end=3D'')
> > +            fptr_type +=3D one_arg
> >
> > -        print(') =3D (void *) %d;' % helper.enum_val)
> > +        fptr_type +=3D ')'
> > +        print(') =3D (%s) %d;' % (fptr_type, helper.enum_val))
> >           print('')
> >
> >   #####################################################################=
##########
