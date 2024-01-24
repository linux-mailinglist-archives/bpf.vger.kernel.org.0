Return-Path: <bpf+bounces-20252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BDE83B0D4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBCA1F24FCA
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60B12A170;
	Wed, 24 Jan 2024 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhFzUqsf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943247F7F2
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120310; cv=none; b=W3U9IODv2tG+SBNtcFNU5k98tqtj5yJuClK3XUV253QzEZCcrqufojjqDMksM48bCPNcHUB7oTKUefFTR/2NXvjEX/DgIWazWWPJ3zCXOO90cNd6h1BBPHQ0XiyTyf1DKvezsmqDPQ7N9aqs+lUWHdCzdxt/xhZJ1bZXnmsv/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120310; c=relaxed/simple;
	bh=NI5XBFOKfugI/xLCs7kqRno/JslQKhkEl/+GzifGBuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4JuYBdyK5inRp93rmZY7YWLkrLD0afXLv+fTU5uqTBVkCuzuEnpUztzX1oqiXqlMP3pNfaEH89DKjdGdOpryLPM47lT/F3xFtvC+gt65gXwm0SUB0S3oQ3Jxsxj4E/LyQcpgpkY7Zjl0xeefaYwk6xeBaReAcsVtrEu5T5ENQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhFzUqsf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d72d240c69so6465ad.1
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 10:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706120308; x=1706725108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUH9EJF482lFzbYZU/u33C+9zo+ebi//3wmOi6+KsBk=;
        b=vhFzUqsfgqizqBGZxw3286KUV64quijn+g8Bps8LP6rXllREx1MYRg8AWYx2Pyhe/e
         VzwzlYogI/NB8v4y/GrQ0HXJo6dT/SRe8m4r3/kEPyM9Oa0KXLr7r8AuCwLsEfGYIGc1
         OjJKrwUvFCAYJL+QCykSlmrkNnv736JMCT1IpzSeADOwzCaEudww4ilRvo3Ss1+4di+u
         1r/GTKkZut2TvfB/KKTyQkJoCzHIY7JhSOfTmnosF5S+nskit7GIwPwKVxSj+UEgACTB
         rpwu4Hc7CoJCVjO5Yucb7PL0FOrFYzOLMSAITUgbKJ5rO3B3wlzLiVIEobUnrFmVfct1
         Y9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120308; x=1706725108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUH9EJF482lFzbYZU/u33C+9zo+ebi//3wmOi6+KsBk=;
        b=pqJEvTSBPMnK/EboYw1ZvnDPPdsqfL6AThvXk27QQnaiRF8cRKLHm7GxHhT0A/S8kR
         0KKLrigFhF83PHEmXrnvKxTpYGHNJmu4V/RVbblJ65EgwK92KMDtczRMMtiQadAvVPQq
         1QQlBbeXaasSJ8NNBFYOGeCPnY89z5i87Q2vLMqZ+G8m080vXfxuUWYt4eYvmEmq6ziW
         2Jelyd0zBNHF0WwnHvyhyZ7+Dj6sGFkDfU2chzPf7mHjQoZrYDch2C1N4R63YK9jMk/U
         HaFVNBqPWTeTC5va2hVc+pP31e9gqc47ZQ2zotJjvAU4i1WIHNlXgQ5sUbjGoWqa9pxk
         Gn3Q==
X-Gm-Message-State: AOJu0Ywl7Y/5DetaQnHNAORf6QHy7+g/uLCliCWewcHGANDaKVSI9bYB
	AGAHIUAhDXQO0al8k0veZmC8OLD4AYy+T7Rcr+M4G6/L8d6KDMU880tn3VqOTvuH36jq4mI8bEk
	uVoWsnjT0aA30YurfDmx3sB38ru5bcfYEOl4C
X-Google-Smtp-Source: AGHT+IH4RJnS5dBCxK8t0UOO0InMxVQZJNiv8DsTUNMac7TeTMkJt1XivA6EwoYDgsL1uNHzHwFuy3k6lvPcRWGTd3Q=
X-Received: by 2002:a17:902:d2c2:b0:1d7:692e:3c8b with SMTP id
 n2-20020a170902d2c200b001d7692e3c8bmr183200plc.13.1706120307547; Wed, 24 Jan
 2024 10:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123204437.1322700-1-irogers@google.com> <CAEf4BzZY7qnnBJ+zFtdjRf0YuwSDWXQvYG7U-kY+7t0g_OTZZQ@mail.gmail.com>
 <CAP-5=fWX8XJqrkbymZ0NbkktbH=iBUxvLuNfYYdmCpLqiVGHtg@mail.gmail.com> <CAEf4BzYwqwdPK17vpiUGLBVZpcWshCezbO_jy8kj2mEnxKW0YA@mail.gmail.com>
In-Reply-To: <CAEf4BzYwqwdPK17vpiUGLBVZpcWshCezbO_jy8kj2mEnxKW0YA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 10:18:16 -0800
Message-ID: <CAP-5=fV+x09L1_H28J6RWhTCvm2dQ1bQfGqF2fGU603Y2rv-sQ@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Add some details for BTF parsing failures
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 9:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 23, 2024 at 8:37=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, Jan 23, 2024 at 8:25=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Jan 23, 2024 at 12:44=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to fin=
d
> > > > valid kernel BTF" message makes diagnosing the kernel build issue s=
ome
> > > > what cryptic. Add a little more detail with the hope of helping use=
rs.
> > > >
> > > > Before:
> > > > ```
> > > > libbpf: failed to find valid kernel BTF
> > > > libbpf: Error loading vmlinux BTF: -3
> > > > libbpf: failed to load object 'lock_contention_bpf'
> > > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > > ```
> > > >
> > > > After no access /sys/kernel/btf/vmlinux:
> > > > ```
> > > > libbpf: Unable to access canonical vmlinux BTF from /sys/kernel/btf=
/vmlinux
> > > > libbpf: Error loading vmlinux BTF: -3
> > > > libbpf: failed to load object 'lock_contention_bpf'
> > > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > > ```
> > > >
> > > > After no BTF /sys/kernel/btf/vmlinux:
> > > > ```
> > > > libbpf: Failed to load vmlinux BTF from /sys/kernel/btf/vmlinux, wa=
s CONFIG_DEBUG_INFO_BTF enabled?
> > > > libbpf: Error loading vmlinux BTF: -3
> > > > libbpf: failed to load object 'lock_contention_bpf'
> > > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > > ```
> > > >
> > > > Closes: https://lore.kernel.org/bpf/CAP-5=3DfU+DN_+Y=3DY4gtELUsJxKN=
DDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com/
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > ---
> > > > v2. Try to address review comments from Andrii Nakryiko.
> > > > ---
> > > >  tools/lib/bpf/btf.c | 49 ++++++++++++++++++++++++++++++++---------=
----
> > > >  1 file changed, 35 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index ee95fd379d4d..d8a05dda0836 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -4920,16 +4920,25 @@ static int btf_dedup_remap_types(struct btf=
_dedup *d)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static struct btf *btf__load_vmlinux_btf_path(const char *path)
> > >
> > > I don't think we need this helper, you literally call btf__parse() an=
d
> > > pr_debug(), that's all
> > >
> > > > +{
> > > > +       struct btf *btf;
> > > > +       int err;
> > > > +
> > > > +       btf =3D btf__parse(path, NULL);
> > > > +       err =3D libbpf_get_error(btf);
> > >
> > > we should stop using libbpf_get_error, in libbpf v1.0+ it's best to d=
o just
> > >
> > > btf =3D btf__parse(path, NULL);
> > > if (!btf) {
> > >     err =3D -errno;
> > >     pr_debug(...);
> > >     return NULL;
> > > }
> > >
> > > > +       pr_debug("loading kernel BTF '%s': %d\n", path, err);
> > > > +       return err ? NULL : btf;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Probe few well-known locations for vmlinux kernel image and try=
 to load BTF
> > > >   * data out of it to use for target BTF.
> > > >   */
> > > >  struct btf *btf__load_vmlinux_btf(void)
> > > >  {
> > > > +       /* fall back locations, trying to find vmlinux on disk */
> > > >         const char *locations[] =3D {
> > > > -               /* try canonical vmlinux BTF through sysfs first */
> > > > -               "/sys/kernel/btf/vmlinux",
> > > > -               /* fall back to trying to find vmlinux on disk othe=
rwise */
> > > >                 "/boot/vmlinux-%1$s",
> > > >                 "/lib/modules/%1$s/vmlinux-%1$s",
> > > >                 "/lib/modules/%1$s/build/vmlinux",
> > > > @@ -4938,29 +4947,41 @@ struct btf *btf__load_vmlinux_btf(void)
> > > >                 "/usr/lib/debug/boot/vmlinux-%1$s.debug",
> > > >                 "/usr/lib/debug/lib/modules/%1$s/vmlinux",
> > > >         };
> > > > -       char path[PATH_MAX + 1];
> > > > +       const char *location;
> > > >         struct utsname buf;
> > > >         struct btf *btf;
> > > > -       int i, err;
> > > > +       int i;
> > > >
> > > > -       uname(&buf);
> > > > +       /* try canonical vmlinux BTF through sysfs first */
> > > > +       location =3D "/sys/kernel/btf/vmlinux";
> > > > +       if (faccessat(AT_FDCWD, location, R_OK, AT_EACCESS) =3D=3D =
0) {
> > > > +               btf =3D btf__load_vmlinux_btf_path(location);
> > > > +               if (btf)
> > > > +                       return btf;
> > > > +
> > > > +               pr_warn("Failed to load vmlinux BTF from %s, was CO=
NFIG_DEBUG_INFO_BTF enabled?\n",
> > > > +                       location);
> > >
> > > Mentioning CONFIG_DEBUG_INFO_BTF seems inappropriate here,
> > > /sys/kernel/btf/vmlinux exists, we just failed to parse its data,
> > > right? So it's not about CONFIG_DEBUG_INFO_BTF, we just don't support
> > > something in BTF data. Just pr_warn("Failed to load vmlinux BTF from
> > > %s: %d", location, err); should be good
> >
> > I think that assumes a lot about a user, they understand what BTF
> > means, they know it is controlled by a kernel config option, and that
> > the config option needs to be overridden (as it is defaulted off) for
> > BTF to work. Given this escaped Raspberry Pi OS the potential for this
> > mistake seems high - hence wanting to highlight the config option.
>
> But there is nothing wrong with CONFIG_DEBUG_INFO_BTF, it is enabled,
> and hence there is /sys/kernel/btf/vmlinux on the system. With
> CONFIG_DEBUG_INFO_BTF suggestion you'll just lead users astray. What
> am I missing?

Okay, so can we warn about CONFIG_DEBUG_INFO_BTF if
/sys/kernel/btf/vmlinux isn't accessible? I'd like to clear up
confusion over permissions, generally not an issue as these tools tend
to get run as root, and a missing kernel configuration - the issue
with Raspberry Pi OS.

Thanks,
Ian

> >
> > > > +       } else
> > > > +               pr_warn("Unable to access canonical vmlinux BTF fro=
m %s\n", location);
> > >
> > > here the question of CONFIG_DEBUG_INFO_BTF is more appropriate, if
> > > /sys/kernel/btf/vmlinux (on modern enough kernels) is missing, then
> > > CONFIG_DEBUG_INFO_BTF is missing, probably. But I'd emit this only
> > > after trying all the fallback paths and not finding anything.
> > >
> > > also stylistical nit: if one side of if has {}, the other has to have
> > > {} as well, even if it's just one line
> > >
> > > >
> > > > +       uname(&buf);
> > > >         for (i =3D 0; i < ARRAY_SIZE(locations); i++) {
> > > > -               snprintf(path, PATH_MAX, locations[i], buf.release)=
;
> > > > +               char path[PATH_MAX + 1];
> > > > +
> > > > +               snprintf(path, sizeof(path), locations[i], buf.rele=
ase);
> > > >
> > > > +               btf =3D btf__load_vmlinux_btf_path(path);
> > > >                 if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
> > > >                         continue;
> > > >
> > > > -               btf =3D btf__parse(path, NULL);
> > > > -               err =3D libbpf_get_error(btf);
> > > > -               pr_debug("loading kernel BTF '%s': %d\n", path, err=
);
> > > > -               if (err)
> > > > -                       continue;
> > > > +               btf =3D btf__load_vmlinux_btf_path(location);
> > > > +               if (btf)
> > > > +                       return btf;
> > > >
> > > > -               return btf;
> > > > +               pr_warn("Failed to load vmlinux BTF from %s, was CO=
NFIG_DEBUG_INFO_BTF enabled?\n",
> > >
> > > we should do better here as well. We should distinguish between "ther=
e
> > > is vmlinux image, but it has no BTF" vs "there is no vmlinux image" v=
s
> > > "vmlinux image is there, there is BTF, but we can't parse it". See
> > > btf__parse(). We return -ENODATA if ELF doesn't have BTF, that's the
> > > first situation. We can probably use faccessat() check for second
> > > situation. Everything else can be reported as pr_debug() with locatio=
n
> > > (but still no CONFIG_DEBUG_INFO_BTF, it's meaningless for fallback BT=
F
> > > locations)
> > >
> > > > +                       path);
> > > >         }
> > > >
> > > > -       pr_warn("failed to find valid kernel BTF\n");
> > >
> > > and then here we can probably warn that we failed to find any kernel
> > > BTF, and suggest CONFIG_DEBUG_INFO_BTF
> >
> > Andrii, you've basically written this patch, can I pass this over to yo=
u?
>
> I think it would be great if you can finish thi, thanks.
>
> >
> > Thanks,
> > Ian
> >
> > > >         return libbpf_err_ptr(-ESRCH);
> > > >  }
> > > >
> > > > --
> > > > 2.43.0.429.g432eaa2c6b-goog
> > > >

