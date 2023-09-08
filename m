Return-Path: <bpf+bounces-9579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE607992EA
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991F5281CD0
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664F87480;
	Fri,  8 Sep 2023 23:51:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05F7466
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:51:08 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B8718E;
	Fri,  8 Sep 2023 16:51:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so316525666b.3;
        Fri, 08 Sep 2023 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694217066; x=1694821866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz46q7yCO0bfK6/28GIiUTUVIGvYKbXoVgA69/2My4U=;
        b=M6tojbXU891Pt3cck1bc5V18F1d63AJDu1FC5z0t5TlIUeju9PncCvbW0MkFNEllTt
         VWXUWGbVp6Hy6le6HiqEVkbdRh0KnUll+8ncAbQR5XcudIvRmcapagnI4ImLuxshIN95
         fVqGSCkuzyZJCCAZg6DNELAp3cmjR+LR4oZY4iNFGCSDZRlIaUHKvL+n7D7rJX8iy+zt
         290QELRFuhhq/KSccezzvL7v/0R+Ig3w+ywSBJds3y8GC6qRb3wbp9ngfO9pcNefKq1r
         khCF7CherbA8t3Vp9JxhYJj491lTOAmiD59rmAYtQbilfeWIxAWHGy2XSGNzg9p92Fk/
         JT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694217066; x=1694821866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz46q7yCO0bfK6/28GIiUTUVIGvYKbXoVgA69/2My4U=;
        b=gzYlNoBKKqqZ9cao5kUe0Sc540S05fCi/qDdtOD+9d2Eughnbw56F7htLyd+6IkxFP
         S9N3yju79ASqk0rl2jJlrJ33b5iwzKJLLA0/fp4QnHYPyH8gwpTt2rBVGKapxteV4lwX
         HM9wAbEkYxYa6EFXTEzdWC2xckWSHBnPAYIxQemiarwmFkiTdQaK5+cekzt/V0V+p0RY
         SHG/2Cpz0ih8A0+B8O/2YESvtNuRjyTZvYVchL5VP0mQy3++Jx+k+5agwP+Dr2zfn2jZ
         4w86pp1Sr+04RnKm9nJIGUHIkMOj1mdjWr2JBAtxo9jyGztfw5gyXdVaItdTgb5fhOhU
         nTAA==
X-Gm-Message-State: AOJu0Yyo2S4aak2ENhvbcqClOqcGGmqQSgpMav1kvBwenXjrFudfuq9W
	5KcKl7Vz6xI49TZfna8qYDgIPRWM1oWGvi0sN/A=
X-Google-Smtp-Source: AGHT+IGCXV2gz7eM22d1Agkbwn85ii7m8IM9fsCyxitt2Q0YhhrjjYiebZxm8haHgEf2GRFyi5W3lRSLnQJURjobkZk=
X-Received: by 2002:a17:907:7612:b0:9a9:efa0:fccf with SMTP id
 jx18-20020a170907761200b009a9efa0fccfmr3053087ejc.0.1694217065631; Fri, 08
 Sep 2023 16:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907200652.926951-1-jolsa@kernel.org> <2deafa8c-94cb-247a-2a8f-97f756f28898@oracle.com>
In-Reply-To: <2deafa8c-94cb-247a-2a8f-97f756f28898@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 16:50:54 -0700
Message-ID: <CAEf4BzZ_=AQ2rt1z=FUE6QoHq44Y_fCmh+xjbn-39NhLw5-VNg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Add override check to kprobe multi link attach
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, 
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Djalal Harouni <tixxdz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 6:49=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 07/09/2023 21:06, Jiri Olsa wrote:
> > Currently the multi_kprobe link attach does not check error
> > injection list for programs with bpf_override_return helper
> > and allows them to attach anywhere. Adding the missing check.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> For the series,
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> ...with one small question below...
>
> > ---
> >  kernel/trace/bpf_trace.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a7264b2c17ad..c1c1af63ced2 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2853,6 +2853,17 @@ static int get_modules_for_addrs(struct module *=
**mods, unsigned long *addrs, u3
> >       return arr.mods_cnt;
> >  }
> >
> > +static int addrs_check_error_injection_list(unsigned long *addrs, u32 =
cnt)
> > +{
> > +     u32 i;
> > +
> > +     for (i =3D 0; i < cnt; i++) {
> > +             if (!within_error_injection_list(addrs[i]))
> > +                     return -EINVAL;
>
> do we need a check like trace_kprobe_on_func_entry() to verify that
> it's a combination of function entry+kprobe override, or is that
> handled elsewhere/not needed? perf_event_attach_bpf_prog() does

multi-kprobe programs are always attached at function entry, so I
believe it's not necessary?

>
> /*
>  * Kprobe override only works if they are on the function entry,
>  * and only if they are on the opt-in list.
>  */
>         if (prog->kprobe_override &&
>             (!trace_kprobe_on_func_entry(event->tp_event) ||
>              !trace_kprobe_error_injectable(event->tp_event)))
>                 return -EINVAL;
>
>
> if this is needed, it might be good to augment the selftest to
> cover the case of specifying non-entry+kprobe override. thanks!
>
> Alan
>
>
> > +     return 0;
> > +}
> > +
> >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bp=
f_prog *prog)
> >  {
> >       struct bpf_kprobe_multi_link *link =3D NULL;
> > @@ -2930,6 +2941,11 @@ int bpf_kprobe_multi_link_attach(const union bpf=
_attr *attr, struct bpf_prog *pr
> >                       goto error;
> >       }
> >
> > +     if (prog->kprobe_override && addrs_check_error_injection_list(add=
rs, cnt)) {
> > +             err =3D -EINVAL;
> > +             goto error;
> > +     }
> > +
> >       link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> >       if (!link) {
> >               err =3D -ENOMEM;

