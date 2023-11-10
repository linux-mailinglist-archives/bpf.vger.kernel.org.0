Return-Path: <bpf+bounces-14786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4687E7E18
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B76AB20E17
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677C21118;
	Fri, 10 Nov 2023 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFqrl9Kx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932711DFEC
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 17:24:17 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E307E446C5
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:24:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so3674176a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699637054; x=1700241854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSrgGggPA2RaBKzsv6WE+DyiV/Vog8QBB0lSKqXqJF4=;
        b=JFqrl9KxPB06mrCT9N7PEsUW7hL/kIp6jJfmmp+mYPPjE5hIvg4YRnV17UPFM0KnkX
         wFAmjcekYD/1Kdhl1ni/SEWHECutkamHu1r24IPDRRFxp6Z5SYm0R6p0PObU++G4XNm9
         S1SAa94c7jbAGPUCUnMv1UXGHK9iw7AY89glwnDk/2Syu49R+d/xJqsBEurRcAsvVMIx
         ins1mHo8vt7dpLBUzpzokMhzGlDS4E+TZo+qapC1YQvhvHpPVEOMaiN9X/69IsOs0iXZ
         BV/fljnp5SGPhLF9Uo2mgCpw8b3Y7/8jzKl+aQdnTPeOfHnTfASWbwBVlNzSSbB8dxLM
         PzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699637054; x=1700241854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSrgGggPA2RaBKzsv6WE+DyiV/Vog8QBB0lSKqXqJF4=;
        b=MseaCFoxK/gakzGOGPJDhJIoqRNPclPCDkdeboosvmKJ/onhSXQRFpKAJizC+j6JCB
         Ed8ryHV7u5gEWzVj7JJz0RAtpvJKx3mwmiBOae2Wo9e7CKjg8jQmjdf8MpGAfZpQV8l2
         Wp3uXMTflPzf9LqyFOF84F6KJ2yuqHl35hxL3JFpLxJ2nHDiAU9Zwp8loUdxXM5hKQ58
         IlPkdnuW5hgivScY5UUwNJmXpvkTNNJzZRVt5xTv1Zgv0ctvmPH2vChmVNQw+MlizcNQ
         F8MF6AEBEkvNWKtjCB1bVH81djClyt0qzX1PsOprMuGFwrO1e6g+a69tOGXv10mymxpO
         nuiw==
X-Gm-Message-State: AOJu0YyJxGF7SrG+Ah4a3TTZB+rVtSY/5aEcaV7JYRqb3eVpktruNBe6
	8OSPzqNsOVwpoJDoJlFEWOw30SDLoOx6Y6T0Xyc=
X-Google-Smtp-Source: AGHT+IEt7ymbirP0YRv1DTQ14RDFpgmZoz6BQs7adJF3NClboSN+zOsSgqe0eDQSgyLpHFu81uAb1rVQAogVwRE77GM=
X-Received: by 2002:a17:906:7392:b0:9e4:f7cb:ef18 with SMTP id
 f18-20020a170906739200b009e4f7cbef18mr3974448ejl.68.1699637053998; Fri, 10
 Nov 2023 09:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109092838.721233-1-jolsa@kernel.org> <20231109092838.721233-4-jolsa@kernel.org>
 <CAEf4BzZAh=aW_4bXSJdBZ-UcoCqa0CuejXBdb7+fB9bDP4q+eQ@mail.gmail.com> <ZU3xXQYLy27ywA3g@krava>
In-Reply-To: <ZU3xXQYLy27ywA3g@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 09:24:02 -0800
Message-ID: <CAEf4BzazZivN-w_bn+17fTwcvpyzLXQFuSVAARX1_8vQi=8dbA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 1:01=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Nov 09, 2023 at 09:57:03PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 52c1ec3a0467..1ea54f3b3f73 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -3046,6 +3046,7 @@ struct bpf_uprobe_multi_link {
> > >         u32 cnt;
> > >         struct bpf_uprobe *uprobes;
> > >         struct task_struct *task;
> > > +       u32 flags;
> > >  };
> > >
> > >  struct bpf_uprobe_multi_run_ctx {
> > > @@ -3085,9 +3086,76 @@ static void bpf_uprobe_multi_link_dealloc(stru=
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
> > > +       u32 upath_size =3D info->uprobe_multi.path_size;
> > > +       struct bpf_uprobe_multi_link *umulti_link;
> > > +       u32 ucount =3D info->uprobe_multi.count;
> > > +       int err =3D 0, i;
> > > +       long left;
> > > +
> > > +       if (!upath ^ !upath_size)
> > > +               return -EINVAL;
> > > +
> > > +       if (!uoffsets ^ !ucount)
> >
> > uoffsets is not the only one that requires ucount, right?
>
> yep, cookies as well

so I think all those arrays should be treated as completely
independent and optional. So if any of ref_ctr_offsets, cookies, or
offsets are requested, then count should be non-zero.

>
> >
> > > +               return -EINVAL;
> > > +
> > > +       umulti_link =3D container_of(link, struct bpf_uprobe_multi_li=
nk, link);
> > > +       info->uprobe_multi.count =3D umulti_link->cnt;
> > > +       info->uprobe_multi.flags =3D umulti_link->flags;
> > > +       info->uprobe_multi.pid =3D umulti_link->task ?
> > > +                                task_pid_nr_ns(umulti_link->task, ta=
sk_active_pid_ns(current)) : 0;
> > > +
> > > +       if (upath) {
> > > +               char *p, *buf;
> > > +
> > > +               upath_size =3D min_t(u32, upath_size, PATH_MAX);
> > > +
> > > +               buf =3D kmalloc(upath_size, GFP_KERNEL);
> > > +               if (!buf)
> > > +                       return -ENOMEM;
> > > +               p =3D d_path(&umulti_link->path, buf, upath_size);
> > > +               if (IS_ERR(p)) {
> > > +                       kfree(buf);
> > > +                       return -ENOSPC;
> > > +               }
> > > +               left =3D copy_to_user(upath, p, buf + upath_size - p)=
;
> > > +               kfree(buf);
> > > +               if (left)
> > > +                       return -EFAULT;
> >
> > hmm.. I expected the actual path_size to be reported back to the
> > user?.. Is there a problem with doing that?
>
> we return back the string, if the string fits in provided buffer it's
> terminated with 0 and user space can do strlen on it if needed

sure, but we can also specify the exact size. We know if, what's the
problem with that? It's just basically saying that path_size is in/out
parameter, just like count

>
> >
> > > +       }
> > > +
> > > +       if (!uoffsets)
> > > +               return 0;
> >
> > why guard by uoffsets? what if users only wanted cookies? I think each
> > array should do its own checking and be independent, no?
>
> I did not think of the use case to get just the cookies (at least not the
> one in bpftool), I saw it as optional to offsets, which is mandatory..
> but that should be an easy change I think

yeah, let's not bake in any assumptions. Each array is optional, user
should be able to request any or all of them. Having this dependency
on offsets is confusing from user POV.

>
> jirka
>
> >
> > > +
> > > +       if (ucount < umulti_link->cnt)
> > > +               err =3D -ENOSPC;
> > > +       else
> > > +               ucount =3D umulti_link->cnt;
> > > +
> > > +       for (i =3D 0; i < ucount; i++) {
> > > +               if (put_user(umulti_link->uprobes[i].offset, uoffsets=
 + i))
> > > +                       return -EFAULT;
> > > +               if (uref_ctr_offsets &&
> > > +                   put_user(umulti_link->uprobes[i].ref_ctr_offset, =
uref_ctr_offsets + i))
> > > +                       return -EFAULT;
> > > +               if (ucookies &&
> > > +                   put_user(umulti_link->uprobes[i].cookie, ucookies=
 + i))
> > > +                       return -EFAULT;
> > > +       }
> > > +
> > > +       return err;
> > > +}
> > > +
> > >  static const struct bpf_link_ops bpf_uprobe_multi_link_lops =3D {
> > >         .release =3D bpf_uprobe_multi_link_release,
> > >         .dealloc =3D bpf_uprobe_multi_link_dealloc,
> > > +       .fill_link_info =3D bpf_uprobe_multi_link_fill_link_info,
> > >  };
> > >
> > >  static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > > @@ -3276,6 +3344,7 @@ int bpf_uprobe_multi_link_attach(const union bp=
f_attr *attr, struct bpf_prog *pr
> > >         link->uprobes =3D uprobes;
> > >         link->path =3D path;
> > >         link->task =3D task;
> > > +       link->flags =3D flags;
> > >
> > >         bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> > >                       &bpf_uprobe_multi_link_lops, prog);
> > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linu=
x/bpf.h
> > > index 0f6cdf52b1da..05b355da4508 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -6556,6 +6556,16 @@ struct bpf_link_info {
> > >                         __u32 flags;
> > >                         __u64 missed;
> > >                 } kprobe_multi;
> > > +               struct {
> > > +                       __aligned_u64 path;
> > > +                       __aligned_u64 offsets;
> > > +                       __aligned_u64 ref_ctr_offsets;
> > > +                       __aligned_u64 cookies;
> > > +                       __u32 path_size;
> > > +                       __u32 count; /* in/out: uprobe_multi offsets/=
ref_ctr_offsets/cookies count */
> > > +                       __u32 flags;
> > > +                       __u32 pid;
> > > +               } uprobe_multi;
> > >                 struct {
> > >                         __u32 type; /* enum bpf_perf_event_type */
> > >                         __u32 :32;
> > > --
> > > 2.41.0
> > >

