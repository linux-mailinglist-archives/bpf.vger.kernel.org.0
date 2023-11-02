Return-Path: <bpf+bounces-13969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C375D7DF786
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7CB281C3F
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E471DA49;
	Thu,  2 Nov 2023 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYEeDHz9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8D1DA29
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:20:13 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3120F10E
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:20:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-540fb78363bso1942448a12.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698942009; x=1699546809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6ZsOtAjlZosxjwmDk5KVBfF+vVQoyMMpr8aiXFcn84=;
        b=GYEeDHz9qvDAUkXND76KUGdET1BYWSOtB2izObev3nefnBG7nvfiOaovWLEmrC5xsq
         Vw+QLU8KSo2yYt53l0922mBI3qCLt5wnOx/GlAU4eM4zn3MfCCpM7WW9l7XQuHR61CsS
         HVtNWvaaCA48tYPwHKOfdsXGOZQ+Ss4Dq8YKtqUIj/RFRDE/A/b38TanpV3jAh9q8IAX
         qAs1nc5rz7MP1F/iNOpLWCwnEZRXUsrNR/VpTb1vvzdBUTRfeIP0/LGLf7kY8WNxHfEr
         fIrU3CQugIavZfzd4NHIisCQynk0bG+kGbrCx8qoQkimCn9ulG4d5sXlL1LB7maJqq/O
         7K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698942009; x=1699546809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6ZsOtAjlZosxjwmDk5KVBfF+vVQoyMMpr8aiXFcn84=;
        b=qAZ6t/cYU8TJblTGEM/HikHu7u3DdbQWdkjIiJUNaizn3xIJQEA2U5l3JuZZCBluJv
         KNzTWeRjTJZ/inSDwHRvWM+HT18hMRlhKkkEjdqis6rAgvhpgSIJ4Ucxf7VJM+aGoLbe
         df3Y/yUd+YMw1/ioHMMvn8jg3bBBdJSKJhsZSBF+6u6qfc16U+CS6TILLf+Ndtr7GQG0
         87M5yKVcCIiNm41xTmUU1E9FJ4Pw2EXdvX7s4NKk+uGv/Cyxv0FzEIVC/bIVEM/YP+cY
         F9zNasFomXj+/Y0tGeEX3KF/8Y67Z9iH5FBB3JKSxWdedaNbWSrD8zbHcy6knjbcWzqG
         JaYQ==
X-Gm-Message-State: AOJu0YzYmFfL/qIlR/+4VMFSksC7Gf285zfJWhhoHmZuGoj2IhPTlUxH
	MlypycQCnpdDAMPQRSmwobcaFMnxuXk+UHrKstk=
X-Google-Smtp-Source: AGHT+IGqqFBXKLi115Lg0H18rSJyrdyvRToKQmH6Q7Yiyh8r1CZmefIhEK5W8eSdPKEodYEUy8OWr/TqFpXd2Gumqr0=
X-Received: by 2002:a17:907:25c6:b0:9d1:a628:3e4f with SMTP id
 ae6-20020a17090725c600b009d1a6283e4fmr4605607ejc.32.1698942009454; Thu, 02
 Nov 2023 09:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-4-jolsa@kernel.org>
 <CAEf4Bzbi8EgT-CC9jS69sV2whk1Dnr-WV5mRyCs=W3JxOMvtWg@mail.gmail.com> <ZUO1oTWcMKKbTLWI@krava>
In-Reply-To: <ZUO1oTWcMKKbTLWI@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 09:19:57 -0700
Message-ID: <CAEf4Bza-dhaBs1fXs_J64Z1ynRuRvNW41ORgVUngEzExNmNrhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 7:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Nov 01, 2023 at 03:21:36PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > > +               struct {
> > > +                       __aligned_u64 path;
> > > +                       __aligned_u64 offsets;
> > > +                       __aligned_u64 ref_ctr_offsets;
> > > +                       __aligned_u64 cookies;
> > > +                       __u32 path_max; /* in/out: uprobe_multi path =
size */
> >
> > people already called out that path_size makes for a better name, I agr=
ee
> >
> > > +                       __u32 count;    /* in/out: uprobe_multi offse=
ts/ref_ctr_offsets/cookies count */
> >
> > otherwise we'd have to call this count_max :)
>
> path_size is good ;-)
>
>
> >
> > > +                       __u32 flags;
> > > +                       __u32 pid;
> > > +               } uprobe_multi;
> > >                 struct {
> > >                         __u32 type; /* enum bpf_perf_event_type */
> > >                         __u32 :32;
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 843b3846d3f8..9f8ad19a1a93 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -3042,6 +3042,7 @@ struct bpf_uprobe_multi_link {
> > >         u32 cnt;
> > >         struct bpf_uprobe *uprobes;
> > >         struct task_struct *task;
> > > +       u32 flags;
> > >  };
> > >
> > >  struct bpf_uprobe_multi_run_ctx {
> > > @@ -3081,9 +3082,75 @@ static void bpf_uprobe_multi_link_dealloc(stru=
ct bpf_link *link)
> > >         kfree(umulti_link);
> > >  }
> > >
> > > +static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_lin=
k *link,
> > > +                                               struct bpf_link_info =
*info)
> > > +{
> > > +       u64 __user *uref_ctr_offsets =3D u64_to_user_ptr(info->uprobe=
_multi.ref_ctr_offsets);
> > > +       u64 __user *ucookies =3D u64_to_user_ptr(info->uprobe_multi.c=
ookies);
> > > +       u64 __user *uoffsets =3D u64_to_user_ptr(info->uprobe_multi.o=
ffsets);
> > > +       u64 __user *upath =3D u64_to_user_ptr(info->uprobe_multi.path=
);
> > > +       u32 upath_max =3D info->uprobe_multi.path_max;
> > > +       struct bpf_uprobe_multi_link *umulti_link;
> > > +       u32 ucount =3D info->uprobe_multi.count;
> > > +       int err =3D 0, i;
> > > +       char *p, *buf;
> > > +       long left;
> > > +
> > > +       if (!upath ^ !upath_max)
> > > +               return -EINVAL;
> > > +
> > > +       if (!uoffsets ^ !ucount)
> > > +               return -EINVAL;
> > > +
> > > +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_li=
nk, link);
> > > +       info->uprobe_multi.count =3D umulti_link->cnt;
> > > +       info->uprobe_multi.flags =3D umulti_link->flags;
> > > +       info->uprobe_multi.pid =3D umulti_link->task ?
> > > +                                task_pid_nr(umulti_link->task) : (u3=
2) -1;
> >
> > on attach we do
> >
> > task =3D get_pid_task(find_vpid(pid), PIDTYPE_PID);
> >
> > So on attachment we take pid in user's namespace, is that right? It's
> > kind of asymmetrical that we return the global PID back? Should we try
> > to convert PID to user's namespace instead?
>
> you're right, I think we should use this:
>
>   task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current))
>
> >
> > > +
> > > +       if (upath) {
> > > +               if (upath_max > PATH_MAX)
> > > +                       return -E2BIG;
> >
> > no need to fail here, as pointed out elsewhere
> >
> > > +               buf =3D kmalloc(upath_max, GFP_KERNEL);
> >
> > here we can allocate min(PATH_MAX, upath_max)
>
> yes, will do that
>
> >
> > > +               if (!buf)
> > > +                       return -ENOMEM;
> > > +               p =3D d_path(&umulti_link->path, buf, upath_max);
> > > +               if (IS_ERR(p)) {
> > > +                       kfree(buf);
> > > +                       return -ENOSPC;
> > > +               }
> > > +               left =3D copy_to_user(upath, p, buf + upath_max - p);
> > > +               kfree(buf);
> > > +               if (left)
> > > +                       return -EFAULT;
> > > +       }
> > > +
> > > +       if (!uoffsets)
> > > +               return 0;
> >
> > it would be good to still return actual counts for out parameters, no?
>
> hm, we do that few lines above with:
>
>         info->uprobe_multi.count =3D umulti_link->cnt;
>
> if that's what you mean
>

oh, yeah, my bad. I was for some reason expecting put_user() for this,
but it's a get_link_info operation, doh. Never mind.

> thanks,
> jirka

