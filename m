Return-Path: <bpf+bounces-13850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A17DE806
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBE281603
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E211C291;
	Wed,  1 Nov 2023 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhGXaZgd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA66130
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:21:57 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F3D10F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 15:21:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5094727fa67so261765e87.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698877314; x=1699482114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/b+fvFyq5b4KJN1nLxXRnZvrkm4wXEbi4kWqdA6J//k=;
        b=RhGXaZgd7276YEWHQgz1pXS81v6Jje9Ub1TBwsLwQ802+ukMvqymxHKBLCrk2i+TxP
         TKBYqFfWBsRBUIvzR6Qqnv2yn6W3r5jfUyKinGZtrU3QKKjiVIB31lCwG/wMQ9+KYtc3
         6O3nBSKgXAqYrnISqXIGrDXvgZN6JH9uFa/AxUf5dkyrmwD6j+EY+forgb8cgxasojXU
         RiPWkwrn9UOR02d6BFiIBW/UIgsgE0lBK7gXQlMTrRBQrRD+E6n4etQYA74zaArwn23q
         q/biW+VtPLqw8VVL80OW1mjrSBzICn8JzeZFsO8nKUh/GJ5+koCsR5ymGaRzmqpfEJr0
         cIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877314; x=1699482114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/b+fvFyq5b4KJN1nLxXRnZvrkm4wXEbi4kWqdA6J//k=;
        b=aY48SpKsdilzVXf1RH77rZx2NFG8JSwj3+Pj42dfhhiPihopJiq3M7+5vYJg4/XlTv
         OtWA1xJ5bMPB/bSD2QniS4kjt7A7ESrLpVgDW5XKhgY/VMbjqUuPQBudNtKTuNiSxaBk
         s/P3lvJ7Ela0U+FHOCzNYbXzrdBKZUAkMdhnQXHIDqnw2o5hlFs6ecMeBNbR1X2eppbj
         rqnNgYXQbvd3quBHuT2b+t+a8cVGJqsGBpJnSntCCbpk+o0ryGaeYoPAhqnY2Hp0JmkI
         Y2yzl4zaVPKJtTSCeUWZIn8sGbYsvMJEWc7anj5bH8fY0vVG3kxs7zvi70FfacbqHwhK
         mxFg==
X-Gm-Message-State: AOJu0Yy5Odm8abQa2o+ti+t+ZJvWZEvWKptNg4FdaY755ZJXnHDb126N
	ob+bwdJ+UUqKb2ibeBU0ia+KN/KbGtORErGpkz4=
X-Google-Smtp-Source: AGHT+IFUrezdPUmJ5P80jJtaA3z7JJOlcoEtiAtfDZYVl+q2h5eKqGLutU5IAt+EnggdKmuVXJXTEffZiWRZT8lfqoU=
X-Received: by 2002:ac2:4c82:0:b0:507:9a33:f105 with SMTP id
 d2-20020ac24c82000000b005079a33f105mr11046340lfl.69.1698877313449; Wed, 01
 Nov 2023 15:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-4-jolsa@kernel.org>
 <CAPhsuW6xTHt3PcFEJxjAuWp-8EMgtaUHUp1KTV07OOY-FYeS4A@mail.gmail.com> <ZTvJY2n1bZ8KtS/X@krava>
In-Reply-To: <ZTvJY2n1bZ8KtS/X@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 15:21:42 -0700
Message-ID: <CAEf4BzZETCTyAqbBkfL2KvPo8T3ATXsRyj37f9kfVB2d7kj=sg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Add link_info support for uprobe multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 7:30=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Oct 26, 2023 at 10:55:35AM -0700, Song Liu wrote:
> > On Wed, Oct 25, 2023 at 1:24=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > [...]

[...]

> >
> > > +               if (upath_max > PATH_MAX)
> > > +                       return -E2BIG;
> >
> > I don't think we need to fail here. How about we simply do
> >
> >    upath_max =3D min_ut(u32, upath_max, PATH_MAX);
>
> ok

+1, was going to say the same

>
> >
> > > +               buf =3D kmalloc(upath_max, GFP_KERNEL);
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
> >
> > It feels expensive to put_user() 3x in a loop. Maybe we need a new stru=
ct
> > with offset, ref_ctr_offset, and cookie?
>
> good idea, I think we could store offsets/uref_ctr_offsets/cookies
> together both in kernel and user sapce and use just single put_user
> call... will check
>

hm... only offset is mandatory, and then we can have either cookie or
ref_ctr_offset or both, so co-locating them in the same struct seems
inconvenient and unnecessary


> thanks,
> jirka
>
> >
> > Thanks,
> > Song
> >
> > > +       }
> > > +
> > > +       return err;
> > > +}
> > > +
>

