Return-Path: <bpf+bounces-20245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28A783B031
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725302821EA
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B375F811F9;
	Wed, 24 Jan 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX/B281V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816386128;
	Wed, 24 Jan 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118033; cv=none; b=jTyxrg2yONgD+18Wviv54Qy7som/d7qXqHPg4uwSCWotv9ePmy84ZEvieli65BKn8dPV7M64xiNUvaMF8h7IIHr4T4KCXMl56MF+mi3kqtO0YvK18eZRvQrxfMWPCg8dNWbxl6Ac4y7qL7PIf+Ik1HuxcFNUy8BejSGtuv3aRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118033; c=relaxed/simple;
	bh=oiL59PKtIuKSxT+2AXCI2xNYKv9ytkBUPHO51PfZedI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs+MmjSFwtkbo0nKww80ohOL3ZqOu5yyJSULERSMYGj75frMqZZMwDcWZ9cfuwN334ALG7G3GPyQHSVDsOue/2DpfiEyFUt0ZU4nPfQ5c22rP66PqeSBMtnhb96IHCqKse26rZArfCNOckLUyQCMVvJ71XRIuojVXNWVTd8nEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX/B281V; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so390669b3a.3;
        Wed, 24 Jan 2024 09:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118031; x=1706722831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgfFSdtZ4BnmOTt2gcIZrv/r5XfBLYy1BOEk6GVFZKM=;
        b=LX/B281V8+zMrIDd1tdBU7vWj7ZdXG5OdxvIRhx8IXk4brzM3NGxzrBGcGtQmS4Tn1
         GWKxbpKx5Bm7oa2XnwxocSA4NCnvhh/xM//1WcoyMjc9a+6HCv0SWTLaSuFXl3Mj7Zih
         skr6gy118rii36kumPGxmZ1Dmr6gtCwK1WLS37mtM+rElUzsZskrpV3kyr14i9ZFpol+
         ltd0nhR7FAioMDvpSOE25apSjCIyo0RoWMyqwSh22M7ywGi5G7SdWF5ErnoGViPTxjHw
         qv1hxUUgIlFAOtUgFBOX/PfH0UsOedwYgJAUwv3EtEQNxxnrSNlzlNkqEIHw9hmYQ5am
         l4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118031; x=1706722831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgfFSdtZ4BnmOTt2gcIZrv/r5XfBLYy1BOEk6GVFZKM=;
        b=Hq5QUI16ACVI06qpWSBaoK/XKSGxpUIErOVvf1CyePzZQdsov/1ukfY73c3SK+pKmh
         23pyiGE4ojxg13d9ONIqU8XPjLPLTmj4QnfboKWPsGnSod66Ef63WXwmXnBOJ1PILTe3
         polmivI/x3VfWfbtUa+ju8LhTqc2Ge7SjiQ0oW0e8KRG2guPVZMSGgUtTNx30MQifKCC
         y3QTvLtjZ7D7XZC1AagmtOXaMAdnfLBZ4i8syk1vYplKThSRElo/CFexEPvJLxaSTEn4
         W5ho1HjeoK0REvVl2SSVrw/tco0ZkeJbTjqYUExfo72+3diTDj0qehPpMnt9cuJj92A9
         OcEQ==
X-Gm-Message-State: AOJu0Yw1gg/H/5lddywNIBbYPTY7bqK0iuAQYqAOQV9erzJ96wGFzRWo
	GG9+rRNkCzeu8yymoDKgmnDPXNzsucEpGek7/FF602KDjNuR7arxMY1KQb9AkmbzndWp+m4xVeA
	SU/tw65LHJsgC1G4P//PxqCloi7c=
X-Google-Smtp-Source: AGHT+IFM9WaghcJZmV/e696A3Xe+cxEaKykyXA7UjVO4lJ/RqNnc2DRFWQ98fPy7B/ZxTr3UX6xtZa1+KPTsqxodZo8=
X-Received: by 2002:a62:61c7:0:b0:6da:c208:7044 with SMTP id
 v190-20020a6261c7000000b006dac2087044mr3970269pfb.40.1706118030946; Wed, 24
 Jan 2024 09:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123204437.1322700-1-irogers@google.com> <CAEf4BzZY7qnnBJ+zFtdjRf0YuwSDWXQvYG7U-kY+7t0g_OTZZQ@mail.gmail.com>
 <CAP-5=fWX8XJqrkbymZ0NbkktbH=iBUxvLuNfYYdmCpLqiVGHtg@mail.gmail.com>
In-Reply-To: <CAP-5=fWX8XJqrkbymZ0NbkktbH=iBUxvLuNfYYdmCpLqiVGHtg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jan 2024 09:40:19 -0800
Message-ID: <CAEf4BzYwqwdPK17vpiUGLBVZpcWshCezbO_jy8kj2mEnxKW0YA@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Add some details for BTF parsing failures
To: Ian Rogers <irogers@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:37=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Jan 23, 2024 at 8:25=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jan 23, 2024 at 12:44=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
> > > valid kernel BTF" message makes diagnosing the kernel build issue som=
e
> > > what cryptic. Add a little more detail with the hope of helping users=
.
> > >
> > > Before:
> > > ```
> > > libbpf: failed to find valid kernel BTF
> > > libbpf: Error loading vmlinux BTF: -3
> > > libbpf: failed to load object 'lock_contention_bpf'
> > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > ```
> > >
> > > After no access /sys/kernel/btf/vmlinux:
> > > ```
> > > libbpf: Unable to access canonical vmlinux BTF from /sys/kernel/btf/v=
mlinux
> > > libbpf: Error loading vmlinux BTF: -3
> > > libbpf: failed to load object 'lock_contention_bpf'
> > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > ```
> > >
> > > After no BTF /sys/kernel/btf/vmlinux:
> > > ```
> > > libbpf: Failed to load vmlinux BTF from /sys/kernel/btf/vmlinux, was =
CONFIG_DEBUG_INFO_BTF enabled?
> > > libbpf: Error loading vmlinux BTF: -3
> > > libbpf: failed to load object 'lock_contention_bpf'
> > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > ```
> > >
> > > Closes: https://lore.kernel.org/bpf/CAP-5=3DfU+DN_+Y=3DY4gtELUsJxKNDD=
COvJzPHvjUVaUoeFAzNnig@mail.gmail.com/
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > ---
> > > v2. Try to address review comments from Andrii Nakryiko.
> > > ---
> > >  tools/lib/bpf/btf.c | 49 ++++++++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 35 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index ee95fd379d4d..d8a05dda0836 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -4920,16 +4920,25 @@ static int btf_dedup_remap_types(struct btf_d=
edup *d)
> > >         return 0;
> > >  }
> > >
> > > +static struct btf *btf__load_vmlinux_btf_path(const char *path)
> >
> > I don't think we need this helper, you literally call btf__parse() and
> > pr_debug(), that's all
> >
> > > +{
> > > +       struct btf *btf;
> > > +       int err;
> > > +
> > > +       btf =3D btf__parse(path, NULL);
> > > +       err =3D libbpf_get_error(btf);
> >
> > we should stop using libbpf_get_error, in libbpf v1.0+ it's best to do =
just
> >
> > btf =3D btf__parse(path, NULL);
> > if (!btf) {
> >     err =3D -errno;
> >     pr_debug(...);
> >     return NULL;
> > }
> >
> > > +       pr_debug("loading kernel BTF '%s': %d\n", path, err);
> > > +       return err ? NULL : btf;
> > > +}
> > > +
> > >  /*
> > >   * Probe few well-known locations for vmlinux kernel image and try t=
o load BTF
> > >   * data out of it to use for target BTF.
> > >   */
> > >  struct btf *btf__load_vmlinux_btf(void)
> > >  {
> > > +       /* fall back locations, trying to find vmlinux on disk */
> > >         const char *locations[] =3D {
> > > -               /* try canonical vmlinux BTF through sysfs first */
> > > -               "/sys/kernel/btf/vmlinux",
> > > -               /* fall back to trying to find vmlinux on disk otherw=
ise */
> > >                 "/boot/vmlinux-%1$s",
> > >                 "/lib/modules/%1$s/vmlinux-%1$s",
> > >                 "/lib/modules/%1$s/build/vmlinux",
> > > @@ -4938,29 +4947,41 @@ struct btf *btf__load_vmlinux_btf(void)
> > >                 "/usr/lib/debug/boot/vmlinux-%1$s.debug",
> > >                 "/usr/lib/debug/lib/modules/%1$s/vmlinux",
> > >         };
> > > -       char path[PATH_MAX + 1];
> > > +       const char *location;
> > >         struct utsname buf;
> > >         struct btf *btf;
> > > -       int i, err;
> > > +       int i;
> > >
> > > -       uname(&buf);
> > > +       /* try canonical vmlinux BTF through sysfs first */
> > > +       location =3D "/sys/kernel/btf/vmlinux";
> > > +       if (faccessat(AT_FDCWD, location, R_OK, AT_EACCESS) =3D=3D 0)=
 {
> > > +               btf =3D btf__load_vmlinux_btf_path(location);
> > > +               if (btf)
> > > +                       return btf;
> > > +
> > > +               pr_warn("Failed to load vmlinux BTF from %s, was CONF=
IG_DEBUG_INFO_BTF enabled?\n",
> > > +                       location);
> >
> > Mentioning CONFIG_DEBUG_INFO_BTF seems inappropriate here,
> > /sys/kernel/btf/vmlinux exists, we just failed to parse its data,
> > right? So it's not about CONFIG_DEBUG_INFO_BTF, we just don't support
> > something in BTF data. Just pr_warn("Failed to load vmlinux BTF from
> > %s: %d", location, err); should be good
>
> I think that assumes a lot about a user, they understand what BTF
> means, they know it is controlled by a kernel config option, and that
> the config option needs to be overridden (as it is defaulted off) for
> BTF to work. Given this escaped Raspberry Pi OS the potential for this
> mistake seems high - hence wanting to highlight the config option.

But there is nothing wrong with CONFIG_DEBUG_INFO_BTF, it is enabled,
and hence there is /sys/kernel/btf/vmlinux on the system. With
CONFIG_DEBUG_INFO_BTF suggestion you'll just lead users astray. What
am I missing?

>
> > > +       } else
> > > +               pr_warn("Unable to access canonical vmlinux BTF from =
%s\n", location);
> >
> > here the question of CONFIG_DEBUG_INFO_BTF is more appropriate, if
> > /sys/kernel/btf/vmlinux (on modern enough kernels) is missing, then
> > CONFIG_DEBUG_INFO_BTF is missing, probably. But I'd emit this only
> > after trying all the fallback paths and not finding anything.
> >
> > also stylistical nit: if one side of if has {}, the other has to have
> > {} as well, even if it's just one line
> >
> > >
> > > +       uname(&buf);
> > >         for (i =3D 0; i < ARRAY_SIZE(locations); i++) {
> > > -               snprintf(path, PATH_MAX, locations[i], buf.release);
> > > +               char path[PATH_MAX + 1];
> > > +
> > > +               snprintf(path, sizeof(path), locations[i], buf.releas=
e);
> > >
> > > +               btf =3D btf__load_vmlinux_btf_path(path);
> > >                 if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
> > >                         continue;
> > >
> > > -               btf =3D btf__parse(path, NULL);
> > > -               err =3D libbpf_get_error(btf);
> > > -               pr_debug("loading kernel BTF '%s': %d\n", path, err);
> > > -               if (err)
> > > -                       continue;
> > > +               btf =3D btf__load_vmlinux_btf_path(location);
> > > +               if (btf)
> > > +                       return btf;
> > >
> > > -               return btf;
> > > +               pr_warn("Failed to load vmlinux BTF from %s, was CONF=
IG_DEBUG_INFO_BTF enabled?\n",
> >
> > we should do better here as well. We should distinguish between "there
> > is vmlinux image, but it has no BTF" vs "there is no vmlinux image" vs
> > "vmlinux image is there, there is BTF, but we can't parse it". See
> > btf__parse(). We return -ENODATA if ELF doesn't have BTF, that's the
> > first situation. We can probably use faccessat() check for second
> > situation. Everything else can be reported as pr_debug() with location
> > (but still no CONFIG_DEBUG_INFO_BTF, it's meaningless for fallback BTF
> > locations)
> >
> > > +                       path);
> > >         }
> > >
> > > -       pr_warn("failed to find valid kernel BTF\n");
> >
> > and then here we can probably warn that we failed to find any kernel
> > BTF, and suggest CONFIG_DEBUG_INFO_BTF
>
> Andrii, you've basically written this patch, can I pass this over to you?

I think it would be great if you can finish thi, thanks.

>
> Thanks,
> Ian
>
> > >         return libbpf_err_ptr(-ESRCH);
> > >  }
> > >
> > > --
> > > 2.43.0.429.g432eaa2c6b-goog
> > >

