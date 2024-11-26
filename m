Return-Path: <bpf+bounces-45660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B99D9F0E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F62166116
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033231DFDB4;
	Tue, 26 Nov 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN+iYs5P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAD160884;
	Tue, 26 Nov 2024 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732658261; cv=none; b=DYFh0eUcQsRv7jcdwiAy2VV1Yv8crnRH4l5ExLXiktEWw/bnnakZ0rv7Mo/YfgAnJyQXWfbE0O8Y8mHYgKFfeKxY7TJv8WgLcroFCyTF05q178ldrbRjP/jwlQ8UX71N0QYfhN+9k4CNdOKB+MqntA2+P3KSZdankdGe+vJPuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732658261; c=relaxed/simple;
	bh=Dp5qgVwH2Wn4DlYsogcy6crwO7UfleNlMb2CxQX4kws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeeP0Gs0zzE0K1aT9IVow/JAORelV6Sg+c9ZJxQWVB0CNNkkfvHiHhtRXEjgeiGrZVDxlwoq18t8/Ji0l4sjch8erDip1jInjFCCRf6j9jT6lIUS1osCBVy8TY8soOuzdPqQ8CPi0y00sr+cC3BAGrQVU0kqDlf/unHKfDm8dF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN+iYs5P; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e59746062fso5157448a91.2;
        Tue, 26 Nov 2024 13:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732658259; x=1733263059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ufDCCX3o1NSN5Ox0hb1sfs+jmvb8aR7jXtagn20Bjg=;
        b=KN+iYs5PvtXw7Jbay7tfk289A+yDHVeKEhRZ/bufUoDuYDkfPKU6ox93+QrLZnvQuS
         bRD1tk6zAW1Kl9Zhug6+cJCInLIzebvjD24ZSTOneg6DyAVG04820zeQkhY7Genv6sgU
         82y4B5Uuvd8JLkHeTJuy7O7Q+njxRUQMv94fKqpQq8Oap92IqHwRUKAV9a8koO50ggiB
         Rq9wWODhKTtsuSg7T4BRDu7Sjd4xYnCsM1UxyqpT7ulcUaAFh0yYWU1WY5rnUD248EIn
         hRKNPEVfG4V7DfQyV5vWNuU8ngjhIN4AsIrXeOOfxhR6J4HL+dZyY20PyQCRTfzvIU/x
         RquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732658259; x=1733263059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ufDCCX3o1NSN5Ox0hb1sfs+jmvb8aR7jXtagn20Bjg=;
        b=WBuZ9SYoYjkp4U8iZ9PFuktAxTCh6sMY5qiMfBy2nMEAU3dCsGXtXCmG/0uzRgRy/m
         h02+cZutoQugtAnmFtnWjF37QxGbueC24D7WYzvVvHXnqz9PW82a3AfD08hjMK+Jakna
         Qu9DgjJ7tS3iE2wWowpfFhwln5G/gVPCk0CJE4hcx7rUwJIYtzZL/HyoEqKWbeu9R9Dk
         4ri866dzqbeKd1tNvdleJovgwTfsxm1RvBrAXngAsZPBa3VpX2FRB4zccMmZnQDAlRU0
         LpEvMH7yhgosJp96BenhqdSKN0bJBudASGjXV7s8+XIdOWlIgc+Hi/SEWVJ8qfeH7yE9
         MlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCViAKsVlE4LPhOCTTnY05C72r8H9Qez1s+C8ArCLIP45F16c9JE0ZcPcavy/sbzqJ4LQXM=@vger.kernel.org, AJvYcCWBn60MKjvLrg10aAhLitCWlX2eetP93s/TTVcYxkjRQpfRuBo8skcwCxONMmt+MxKsm0o4YqWPsSw+C60k@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWHVSOU6lTP9OL7JlIB9wWvZM+ABPqPj/thyy/UUpwn4hMrpB
	dXD0M8az6qWQaM+i8dgj92RcVLAPZy3SQwIajG7dZMezfsHO6Vmys78TB2Q4t8uywSaVCmrDmYK
	oe9ejkgYAk8Q7JTOXNe6dt/fhUm5MPA==
X-Gm-Gg: ASbGncvEjYZQ4kFElxFX16ur1OFwDbyl4iWz5pTpTpytT+6HdSZC3oHDtcTxmHTN9ZU
	K+cwnphKoozWoRkL5+gNyBldwWvu68hIPTwToBYOlDa7BaxA=
X-Google-Smtp-Source: AGHT+IFjO03QcnfyIpWHLHAda0KZSa+YkVCJf6maxj8PTZeoo6zzH3Apdbvph1b0zvQ8FeeSRi8Hp3v5cvzoEoPWmZE=
X-Received: by 2002:a17:90b:224b:b0:2ea:5054:6c48 with SMTP id
 98e67ed59e1d1-2ee097bd271mr816422a91.28.1732658259243; Tue, 26 Nov 2024
 13:57:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net>
 <CAEf4BzbNs=MVNDztRW_76f8aQkm44ykiibqGa2REThWM4dVa_g@mail.gmail.com> <5307ea3b-6720-4ca9-827e-7338f255908f@t-8ch.de>
In-Reply-To: <5307ea3b-6720-4ca9-827e-7338f255908f@t-8ch.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 13:57:26 -0800
Message-ID: <CAEf4BzYStc6gaPqHzuP4FhTi4gSCsX65Eq6Zd73p9wVjHisiuQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Use BIN_ATTR_SIMPLE_RO() to define vmlinux attribute
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:42=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-11-26 13:37:26-0800, Andrii Nakryiko wrote:
> > On Fri, Nov 22, 2024 at 4:57=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@we=
issschuh.net> wrote:
> > >
> > > The usage of the macro allows to remove the custom handler function,
> > > saving some memory. Additionally the code is easier to read.
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > ---
> > > Something similar can be done to btf_module_read() in kernel/bpf/btf.=
c.
> > > But doing it here and now would lead to some conflicts with some othe=
r
> > > sysfs refactorings I'm doing. It will be part of a future series.
> > > ---
> > >  kernel/bpf/sysfs_btf.c | 21 +++++----------------
> > >  1 file changed, 5 insertions(+), 16 deletions(-)
> > >
> >
> > Nice, let's simplify. But why change the name to generic "vmlinux" if
> > it's actually btf_vmlinux? Can we keep the original btf-specific name?
>
> The file in sysfs is named "vmlinux", /sys/kernel/btf/vmlinux.
> This is what needs to be passed to the macro, it will name both the
> variable and the file after it.
>
> One alternative would be to use __BIN_ATTR_SIMPLE_RO() which allows a
> custom name.
>

Probably not worth it, ok, I'm fine with the name change, it's a local
name anyways.

> >
> > pw-bot: cr
> >
> > > diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> > > index fedb54c94cdb830a4890d33677dcc5a6e236c13f..a24381f933d0b80b11116=
d05463c35e9fa66acb1 100644
> > > --- a/kernel/bpf/sysfs_btf.c
> > > +++ b/kernel/bpf/sysfs_btf.c
> > > @@ -12,34 +12,23 @@
> > >  extern char __start_BTF[];
> > >  extern char __stop_BTF[];
> > >
> > > -static ssize_t
> > > -btf_vmlinux_read(struct file *file, struct kobject *kobj,
> > > -                struct bin_attribute *bin_attr,
> > > -                char *buf, loff_t off, size_t len)
> > > -{
> > > -       memcpy(buf, __start_BTF + off, len);
> > > -       return len;
> > > -}
> > > -
> > > -static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init =3D=
 {
> > > -       .attr =3D { .name =3D "vmlinux", .mode =3D 0444, },
> > > -       .read =3D btf_vmlinux_read,
> > > -};
> > > +static __ro_after_init BIN_ATTR_SIMPLE_RO(vmlinux);
> > >
> > >  struct kobject *btf_kobj;
> > >
> > >  static int __init btf_vmlinux_init(void)
> > >  {
> > > -       bin_attr_btf_vmlinux.size =3D __stop_BTF - __start_BTF;
> > > +       bin_attr_vmlinux.private =3D __start_BTF;
> > > +       bin_attr_vmlinux.size =3D __stop_BTF - __start_BTF;
> > >
> > > -       if (bin_attr_btf_vmlinux.size =3D=3D 0)
> > > +       if (bin_attr_vmlinux.size =3D=3D 0)
> > >                 return 0;
> > >
> > >         btf_kobj =3D kobject_create_and_add("btf", kernel_kobj);
> > >         if (!btf_kobj)
> > >                 return -ENOMEM;
> > >
> > > -       return sysfs_create_bin_file(btf_kobj, &bin_attr_btf_vmlinux)=
;
> > > +       return sysfs_create_bin_file(btf_kobj, &bin_attr_vmlinux);
> > >  }
> > >
> > >  subsys_initcall(btf_vmlinux_init);
> > >
> > > ---
> > > base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
> > > change-id: 20241122-sysfs-const-bin_attr-bpf-737286bb9f27
> > >
> > > Best regards,
> > > --
> > > Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > >

