Return-Path: <bpf+bounces-20194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B683A0A6
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 05:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282AE1C2547B
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 04:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2CC8EA;
	Wed, 24 Jan 2024 04:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+oau75T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38FE541
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071036; cv=none; b=gyd92TqKxV2NxKf11+tvsOKwEcEi4QWyG52EdgKxcERkHEJyvoOD0RyTtJkj3rMs9Z9NVyuY8RSXQOluLwTgyuCT099WnG72e9hMfHUGqSVgWsoAxuhHmgmw6KLu3tX4HWBCPw5Xl8xWdfFeJ7tnhrNiXhZLQY60HhLV6GNqgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071036; c=relaxed/simple;
	bh=0+7QEnrtEA0ThnqoDJsGvCABoGBmYULuTyuQ7ehrnKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0hVfl9PoP9yqTHg7Th4rJ1cfu8UHNLz6lMKUomNM51ORECXkVl7Oajxd23lZS3jrGBf3m0IDQr2BAFzA7AnvPOcjNfllVcgUZLwBCXgZrmZTOK5QjjhP37Vvc4PSe1udtmWbkjffmaOieJroTqRcMmBhLsnnvZSU9u95GqoiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+oau75T; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d5ce88b51cso110535ad.0
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 20:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706071033; x=1706675833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLmj7MysHRx2l1EP+DjhWCBE3phDUFYCOnPwerSOkKk=;
        b=d+oau75TqWqnYt4vAl3ZPK/fO6yD4W3l+BHJpiyITSw6GEFdlADnt4Mb/h2qooic5q
         tuU8MkVpUbXmvJEV4qGuTZ5BiXa7wnr1885YUiN88DyWFKqX4r2EQ62jE+tsjs8LiZkx
         Cydbfcyh19Zl/7ag+aZcLciOOlSg9ow/gYe3k64eMToTsySXZytjTYdIoZGUuQOpeyQ+
         NKh9STky56kjOCPbrWWw1IKPKbP+evq1W39gpa9Dosydu3DNEGnMzjfOntfO1b8EaZmz
         8gMtipm+1hRrA6SHBMCKtjgdY7BrhoSHN6hgRcw9SRkX0wa0NjVG05t1+Y515pNc+60d
         ftqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706071033; x=1706675833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLmj7MysHRx2l1EP+DjhWCBE3phDUFYCOnPwerSOkKk=;
        b=xKuQUUfEaq1LHodVKmxVUVzwlmDq5HyueRx9zUy4D9iIBTAR0Skr9oKMkkdlNqs437
         MicXNw/Zn8ZDjwjafPrSLJXkWhyrvBpa/7a9w9Y2rFoL65MGsWyc45cJaBsD/Gd29Npw
         9leVmOUBeYqce7HO+xvGFUvz92G3FsmVDQGqvVB9OCXHuHf77glePUHiWiKsilKV7QzD
         IdhuquGHJ5OQMHRDyaDxLU1P+ikjJ1OyrdYS8ZulMlop2XKBSuf10MHEvSBZtqGnOnha
         rZxJ+BMdayK5Nj8B2cHvpWKlvN+J7UrUOB7e84qJSEZQwpcth3DfTQ05jOnA5CLH2Bom
         Mz+Q==
X-Gm-Message-State: AOJu0YxOOrxp+/hG0UuUBKjIAv8rgyTVHtpdbUQey2CUB9jGBzZYfGqc
	66aBiBe21r18loEHCqiKYEtTAc2dcVKdPz4eH1ik3ebp2OkX0NWdXAAgPJUtFi6BQ9Ju4Q+aC4z
	vXFJkqyW86USup9Z28DQp4F9sSi9M1tlGXHR+SzgrpJEaiehrPKqF
X-Google-Smtp-Source: AGHT+IFn8aGBbtAOlIZMM+tyfys0cjgkE65JIlF0B5IUEOckc8aIJwCU7M0UvCUniNJTZFgWs5CPBtLsjZaeUEXtt24=
X-Received: by 2002:a17:902:ea06:b0:1d7:48ef:e239 with SMTP id
 s6-20020a170902ea0600b001d748efe239mr49166plg.18.1706071033047; Tue, 23 Jan
 2024 20:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123204437.1322700-1-irogers@google.com> <CAEf4BzZY7qnnBJ+zFtdjRf0YuwSDWXQvYG7U-kY+7t0g_OTZZQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZY7qnnBJ+zFtdjRf0YuwSDWXQvYG7U-kY+7t0g_OTZZQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jan 2024 20:37:01 -0800
Message-ID: <CAP-5=fWX8XJqrkbymZ0NbkktbH=iBUxvLuNfYYdmCpLqiVGHtg@mail.gmail.com>
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

On Tue, Jan 23, 2024 at 8:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 23, 2024 at 12:44=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
> > valid kernel BTF" message makes diagnosing the kernel build issue some
> > what cryptic. Add a little more detail with the hope of helping users.
> >
> > Before:
> > ```
> > libbpf: failed to find valid kernel BTF
> > libbpf: Error loading vmlinux BTF: -3
> > libbpf: failed to load object 'lock_contention_bpf'
> > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > ```
> >
> > After no access /sys/kernel/btf/vmlinux:
> > ```
> > libbpf: Unable to access canonical vmlinux BTF from /sys/kernel/btf/vml=
inux
> > libbpf: Error loading vmlinux BTF: -3
> > libbpf: failed to load object 'lock_contention_bpf'
> > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > ```
> >
> > After no BTF /sys/kernel/btf/vmlinux:
> > ```
> > libbpf: Failed to load vmlinux BTF from /sys/kernel/btf/vmlinux, was CO=
NFIG_DEBUG_INFO_BTF enabled?
> > libbpf: Error loading vmlinux BTF: -3
> > libbpf: failed to load object 'lock_contention_bpf'
> > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > ```
> >
> > Closes: https://lore.kernel.org/bpf/CAP-5=3DfU+DN_+Y=3DY4gtELUsJxKNDDCO=
vJzPHvjUVaUoeFAzNnig@mail.gmail.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > ---
> > v2. Try to address review comments from Andrii Nakryiko.
> > ---
> >  tools/lib/bpf/btf.c | 49 ++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 35 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index ee95fd379d4d..d8a05dda0836 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -4920,16 +4920,25 @@ static int btf_dedup_remap_types(struct btf_ded=
up *d)
> >         return 0;
> >  }
> >
> > +static struct btf *btf__load_vmlinux_btf_path(const char *path)
>
> I don't think we need this helper, you literally call btf__parse() and
> pr_debug(), that's all
>
> > +{
> > +       struct btf *btf;
> > +       int err;
> > +
> > +       btf =3D btf__parse(path, NULL);
> > +       err =3D libbpf_get_error(btf);
>
> we should stop using libbpf_get_error, in libbpf v1.0+ it's best to do ju=
st
>
> btf =3D btf__parse(path, NULL);
> if (!btf) {
>     err =3D -errno;
>     pr_debug(...);
>     return NULL;
> }
>
> > +       pr_debug("loading kernel BTF '%s': %d\n", path, err);
> > +       return err ? NULL : btf;
> > +}
> > +
> >  /*
> >   * Probe few well-known locations for vmlinux kernel image and try to =
load BTF
> >   * data out of it to use for target BTF.
> >   */
> >  struct btf *btf__load_vmlinux_btf(void)
> >  {
> > +       /* fall back locations, trying to find vmlinux on disk */
> >         const char *locations[] =3D {
> > -               /* try canonical vmlinux BTF through sysfs first */
> > -               "/sys/kernel/btf/vmlinux",
> > -               /* fall back to trying to find vmlinux on disk otherwis=
e */
> >                 "/boot/vmlinux-%1$s",
> >                 "/lib/modules/%1$s/vmlinux-%1$s",
> >                 "/lib/modules/%1$s/build/vmlinux",
> > @@ -4938,29 +4947,41 @@ struct btf *btf__load_vmlinux_btf(void)
> >                 "/usr/lib/debug/boot/vmlinux-%1$s.debug",
> >                 "/usr/lib/debug/lib/modules/%1$s/vmlinux",
> >         };
> > -       char path[PATH_MAX + 1];
> > +       const char *location;
> >         struct utsname buf;
> >         struct btf *btf;
> > -       int i, err;
> > +       int i;
> >
> > -       uname(&buf);
> > +       /* try canonical vmlinux BTF through sysfs first */
> > +       location =3D "/sys/kernel/btf/vmlinux";
> > +       if (faccessat(AT_FDCWD, location, R_OK, AT_EACCESS) =3D=3D 0) {
> > +               btf =3D btf__load_vmlinux_btf_path(location);
> > +               if (btf)
> > +                       return btf;
> > +
> > +               pr_warn("Failed to load vmlinux BTF from %s, was CONFIG=
_DEBUG_INFO_BTF enabled?\n",
> > +                       location);
>
> Mentioning CONFIG_DEBUG_INFO_BTF seems inappropriate here,
> /sys/kernel/btf/vmlinux exists, we just failed to parse its data,
> right? So it's not about CONFIG_DEBUG_INFO_BTF, we just don't support
> something in BTF data. Just pr_warn("Failed to load vmlinux BTF from
> %s: %d", location, err); should be good

I think that assumes a lot about a user, they understand what BTF
means, they know it is controlled by a kernel config option, and that
the config option needs to be overridden (as it is defaulted off) for
BTF to work. Given this escaped Raspberry Pi OS the potential for this
mistake seems high - hence wanting to highlight the config option.

> > +       } else
> > +               pr_warn("Unable to access canonical vmlinux BTF from %s=
\n", location);
>
> here the question of CONFIG_DEBUG_INFO_BTF is more appropriate, if
> /sys/kernel/btf/vmlinux (on modern enough kernels) is missing, then
> CONFIG_DEBUG_INFO_BTF is missing, probably. But I'd emit this only
> after trying all the fallback paths and not finding anything.
>
> also stylistical nit: if one side of if has {}, the other has to have
> {} as well, even if it's just one line
>
> >
> > +       uname(&buf);
> >         for (i =3D 0; i < ARRAY_SIZE(locations); i++) {
> > -               snprintf(path, PATH_MAX, locations[i], buf.release);
> > +               char path[PATH_MAX + 1];
> > +
> > +               snprintf(path, sizeof(path), locations[i], buf.release)=
;
> >
> > +               btf =3D btf__load_vmlinux_btf_path(path);
> >                 if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
> >                         continue;
> >
> > -               btf =3D btf__parse(path, NULL);
> > -               err =3D libbpf_get_error(btf);
> > -               pr_debug("loading kernel BTF '%s': %d\n", path, err);
> > -               if (err)
> > -                       continue;
> > +               btf =3D btf__load_vmlinux_btf_path(location);
> > +               if (btf)
> > +                       return btf;
> >
> > -               return btf;
> > +               pr_warn("Failed to load vmlinux BTF from %s, was CONFIG=
_DEBUG_INFO_BTF enabled?\n",
>
> we should do better here as well. We should distinguish between "there
> is vmlinux image, but it has no BTF" vs "there is no vmlinux image" vs
> "vmlinux image is there, there is BTF, but we can't parse it". See
> btf__parse(). We return -ENODATA if ELF doesn't have BTF, that's the
> first situation. We can probably use faccessat() check for second
> situation. Everything else can be reported as pr_debug() with location
> (but still no CONFIG_DEBUG_INFO_BTF, it's meaningless for fallback BTF
> locations)
>
> > +                       path);
> >         }
> >
> > -       pr_warn("failed to find valid kernel BTF\n");
>
> and then here we can probably warn that we failed to find any kernel
> BTF, and suggest CONFIG_DEBUG_INFO_BTF

Andrii, you've basically written this patch, can I pass this over to you?

Thanks,
Ian

> >         return libbpf_err_ptr(-ESRCH);
> >  }
> >
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >

