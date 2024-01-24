Return-Path: <bpf+bounces-20260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D282F83B1D5
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536661F21813
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDDB131754;
	Wed, 24 Jan 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA7dhOie"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DEE132C09;
	Wed, 24 Jan 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123244; cv=none; b=BqHwsf26JRkBhIO9dk+J3yDOyUKyFWBsH4aVQntqHpJV01Ggr/gerf8sRC76zGTWH/CGk8gV4/ZAtw8p6Y+p/KTshmPhGP+fGZyGihzxA/SbuAPyYTxni79kbWzUCdeBVdLNZldkUPP4AOH6fFKpu5eAydSQcwbkId4XqVCu4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123244; c=relaxed/simple;
	bh=/QKzwQLC8zQ7jQXQ4Ez95EJETaAAZ5qu0WeTKAY4XuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqv6hbWCpoLnkSWl/2u8aIuOIeh99hLJwt+yRSI4XJE+PUGq110va1ECJA6jOpCZzwGWS0v8Ozq2sqofdFaoGTm76QWKWDu1wmo751IraFqVEC9ICqsW7kPuJ8hoDCj4kWnaPz8HzCkVD4zGuw/lGCRoqbenzNYnBNoGtsyVCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA7dhOie; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf765355ecso3074335a12.0;
        Wed, 24 Jan 2024 11:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706123242; x=1706728042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lsnM1c4TaTBAN/VyLhT9AJhVSJr2hSvsgWhyfJs6Ys=;
        b=fA7dhOiegOqD0Ur5mrZ6fCiVj4CSVjXYU1DYdiRNpMCMrM63e+/igIC3Aam/kvTF2u
         OAdzSIeP93XhrHnwA61mXQ7N5aI01ESmbV8LPImLIhcovsInGQp8FiiesLddhCHkJ4X9
         pmSNJHH7LRFt9LNNWanXfWQaD0BkCJ171mtnGKzyvyvdGwYp9fNrOl3oAM9ksY2Z/QqR
         6oy1h2RTeL7odCKdLtaZ9tf/32WPAkEDoNpiXw4iBQblOnRW2919J4mB790k8tQKmnPG
         sfOoBgzT6ZPBrWuxVfROfFpdirLRWGVyu55q1F19YuPmeOh2qlgnqaOo22IH2rGjIT9l
         7n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706123242; x=1706728042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lsnM1c4TaTBAN/VyLhT9AJhVSJr2hSvsgWhyfJs6Ys=;
        b=PI9QbNpnHNpjsF6Y+55sUY9itmEKYoAS9eNZj+G8K03ViljrmAmP0ZGsKqos031Dt1
         pYCB2K948Of3PyaxNjSw6xiZoQF5F3QDAqbf/aeqmAVkugLqAL1LscWOUHwCsuZSC4e9
         Yjfsf6nuPNl+6/pXQl8pUafJBobxJPKbk22bWLr0HI74e/noGHzgUfVygBt0f6/Xa7lw
         cWXkEcAavKObBmDW0ksk8yRzQ9xS8jtI1eg2LOt4jk/WvXKxM1XZMrHneTqnSZEF+qrZ
         oQR6jb+7Nt42NBb2gWKaIgYpEwPyAjg7LUgSN2Hab5/zuRkc8/+tZiHV8fLJbfL/iaUp
         hp8Q==
X-Gm-Message-State: AOJu0Yz1fwYodabW4vGJkSczOMI3CO+U68Qou1f9O2QUhbCsisz5CPeE
	3GNz8mDC0mQpi0SwTr46Pq3bcDqB7IxEv2wDTQeenNH9J3CeE+sOoV25koIlNKSzFuHIdCAonhb
	c9inGiG/LO3TehQWGDgY3HLBqvJY=
X-Google-Smtp-Source: AGHT+IFqQealLtITq0LGm5Gk4/JdHaehTMhwT/fUSWBut+DKEJ/2wMgcmlZDnirwj9u+I9d9TOfMHbY88kM6gZ4Wius=
X-Received: by 2002:a05:6a20:5484:b0:19b:8963:2aa8 with SMTP id
 i4-20020a056a20548400b0019b89632aa8mr1172516pzk.24.1706123242010; Wed, 24 Jan
 2024 11:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123204437.1322700-1-irogers@google.com> <CAEf4BzZY7qnnBJ+zFtdjRf0YuwSDWXQvYG7U-kY+7t0g_OTZZQ@mail.gmail.com>
 <CAP-5=fWX8XJqrkbymZ0NbkktbH=iBUxvLuNfYYdmCpLqiVGHtg@mail.gmail.com>
 <CAEf4BzYwqwdPK17vpiUGLBVZpcWshCezbO_jy8kj2mEnxKW0YA@mail.gmail.com> <CAP-5=fV+x09L1_H28J6RWhTCvm2dQ1bQfGqF2fGU603Y2rv-sQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV+x09L1_H28J6RWhTCvm2dQ1bQfGqF2fGU603Y2rv-sQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jan 2024 11:07:09 -0800
Message-ID: <CAEf4BzbXOs=Gpxxou=oYsYB8oT4hJi4=+pUmwm1tWxU68KzMpw@mail.gmail.com>
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

On Wed, Jan 24, 2024 at 10:18=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Jan 24, 2024 at 9:40=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jan 23, 2024 at 8:37=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Tue, Jan 23, 2024 at 8:25=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Jan 23, 2024 at 12:44=E2=80=AFPM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to f=
ind
> > > > > valid kernel BTF" message makes diagnosing the kernel build issue=
 some
> > > > > what cryptic. Add a little more detail with the hope of helping u=
sers.
> > > > >
> > > > > Before:
> > > > > ```
> > > > > libbpf: failed to find valid kernel BTF
> > > > > libbpf: Error loading vmlinux BTF: -3
> > > > > libbpf: failed to load object 'lock_contention_bpf'
> > > > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > > > ```
> > > > >
> > > > > After no access /sys/kernel/btf/vmlinux:
> > > > > ```
> > > > > libbpf: Unable to access canonical vmlinux BTF from /sys/kernel/b=
tf/vmlinux
> > > > > libbpf: Error loading vmlinux BTF: -3
> > > > > libbpf: failed to load object 'lock_contention_bpf'
> > > > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > > > ```
> > > > >
> > > > > After no BTF /sys/kernel/btf/vmlinux:
> > > > > ```
> > > > > libbpf: Failed to load vmlinux BTF from /sys/kernel/btf/vmlinux, =
was CONFIG_DEBUG_INFO_BTF enabled?
> > > > > libbpf: Error loading vmlinux BTF: -3
> > > > > libbpf: failed to load object 'lock_contention_bpf'
> > > > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> > > > > ```
> > > > >
> > > > > Closes: https://lore.kernel.org/bpf/CAP-5=3DfU+DN_+Y=3DY4gtELUsJx=
KNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com/
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > ---
> > > > > v2. Try to address review comments from Andrii Nakryiko.
> > > > > ---
> > > > >  tools/lib/bpf/btf.c | 49 ++++++++++++++++++++++++++++++++-------=
------
> > > > >  1 file changed, 35 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > > index ee95fd379d4d..d8a05dda0836 100644
> > > > > --- a/tools/lib/bpf/btf.c
> > > > > +++ b/tools/lib/bpf/btf.c
> > > > > @@ -4920,16 +4920,25 @@ static int btf_dedup_remap_types(struct b=
tf_dedup *d)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static struct btf *btf__load_vmlinux_btf_path(const char *path)
> > > >
> > > > I don't think we need this helper, you literally call btf__parse() =
and
> > > > pr_debug(), that's all
> > > >
> > > > > +{
> > > > > +       struct btf *btf;
> > > > > +       int err;
> > > > > +
> > > > > +       btf =3D btf__parse(path, NULL);
> > > > > +       err =3D libbpf_get_error(btf);
> > > >
> > > > we should stop using libbpf_get_error, in libbpf v1.0+ it's best to=
 do just
> > > >
> > > > btf =3D btf__parse(path, NULL);
> > > > if (!btf) {
> > > >     err =3D -errno;
> > > >     pr_debug(...);
> > > >     return NULL;
> > > > }
> > > >
> > > > > +       pr_debug("loading kernel BTF '%s': %d\n", path, err);
> > > > > +       return err ? NULL : btf;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Probe few well-known locations for vmlinux kernel image and t=
ry to load BTF
> > > > >   * data out of it to use for target BTF.
> > > > >   */
> > > > >  struct btf *btf__load_vmlinux_btf(void)
> > > > >  {
> > > > > +       /* fall back locations, trying to find vmlinux on disk */
> > > > >         const char *locations[] =3D {
> > > > > -               /* try canonical vmlinux BTF through sysfs first =
*/
> > > > > -               "/sys/kernel/btf/vmlinux",
> > > > > -               /* fall back to trying to find vmlinux on disk ot=
herwise */
> > > > >                 "/boot/vmlinux-%1$s",
> > > > >                 "/lib/modules/%1$s/vmlinux-%1$s",
> > > > >                 "/lib/modules/%1$s/build/vmlinux",
> > > > > @@ -4938,29 +4947,41 @@ struct btf *btf__load_vmlinux_btf(void)
> > > > >                 "/usr/lib/debug/boot/vmlinux-%1$s.debug",
> > > > >                 "/usr/lib/debug/lib/modules/%1$s/vmlinux",
> > > > >         };
> > > > > -       char path[PATH_MAX + 1];
> > > > > +       const char *location;
> > > > >         struct utsname buf;
> > > > >         struct btf *btf;
> > > > > -       int i, err;
> > > > > +       int i;
> > > > >
> > > > > -       uname(&buf);
> > > > > +       /* try canonical vmlinux BTF through sysfs first */
> > > > > +       location =3D "/sys/kernel/btf/vmlinux";
> > > > > +       if (faccessat(AT_FDCWD, location, R_OK, AT_EACCESS) =3D=
=3D 0) {
> > > > > +               btf =3D btf__load_vmlinux_btf_path(location);
> > > > > +               if (btf)
> > > > > +                       return btf;
> > > > > +
> > > > > +               pr_warn("Failed to load vmlinux BTF from %s, was =
CONFIG_DEBUG_INFO_BTF enabled?\n",
> > > > > +                       location);
> > > >
> > > > Mentioning CONFIG_DEBUG_INFO_BTF seems inappropriate here,
> > > > /sys/kernel/btf/vmlinux exists, we just failed to parse its data,
> > > > right? So it's not about CONFIG_DEBUG_INFO_BTF, we just don't suppo=
rt
> > > > something in BTF data. Just pr_warn("Failed to load vmlinux BTF fro=
m
> > > > %s: %d", location, err); should be good
> > >
> > > I think that assumes a lot about a user, they understand what BTF
> > > means, they know it is controlled by a kernel config option, and that
> > > the config option needs to be overridden (as it is defaulted off) for
> > > BTF to work. Given this escaped Raspberry Pi OS the potential for thi=
s
> > > mistake seems high - hence wanting to highlight the config option.
> >
> > But there is nothing wrong with CONFIG_DEBUG_INFO_BTF, it is enabled,
> > and hence there is /sys/kernel/btf/vmlinux on the system. With
> > CONFIG_DEBUG_INFO_BTF suggestion you'll just lead users astray. What
> > am I missing?
>
> Okay, so can we warn about CONFIG_DEBUG_INFO_BTF if
> /sys/kernel/btf/vmlinux isn't accessible? I'd like to clear up
> confusion over permissions, generally not an issue as these tools tend
> to get run as root, and a missing kernel configuration - the issue
> with Raspberry Pi OS.

Why not do two checks. One faccessat(F_OK) (whether file exists), and
if not, report CONFIG_DEBUG_INFO_BTF. And then separately R_OK access,
and report permissions problems. Everything else will be a failure to
parse BTF.

>
> Thanks,
> Ian
>
> > >
> > > > > +       } else
> > > > > +               pr_warn("Unable to access canonical vmlinux BTF f=
rom %s\n", location);
> > > >
> > > > here the question of CONFIG_DEBUG_INFO_BTF is more appropriate, if
> > > > /sys/kernel/btf/vmlinux (on modern enough kernels) is missing, then
> > > > CONFIG_DEBUG_INFO_BTF is missing, probably. But I'd emit this only
> > > > after trying all the fallback paths and not finding anything.
> > > >
> > > > also stylistical nit: if one side of if has {}, the other has to ha=
ve
> > > > {} as well, even if it's just one line
> > > >
> > > > >
> > > > > +       uname(&buf);
> > > > >         for (i =3D 0; i < ARRAY_SIZE(locations); i++) {
> > > > > -               snprintf(path, PATH_MAX, locations[i], buf.releas=
e);
> > > > > +               char path[PATH_MAX + 1];
> > > > > +
> > > > > +               snprintf(path, sizeof(path), locations[i], buf.re=
lease);
> > > > >
> > > > > +               btf =3D btf__load_vmlinux_btf_path(path);
> > > > >                 if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
> > > > >                         continue;
> > > > >
> > > > > -               btf =3D btf__parse(path, NULL);
> > > > > -               err =3D libbpf_get_error(btf);
> > > > > -               pr_debug("loading kernel BTF '%s': %d\n", path, e=
rr);
> > > > > -               if (err)
> > > > > -                       continue;
> > > > > +               btf =3D btf__load_vmlinux_btf_path(location);
> > > > > +               if (btf)
> > > > > +                       return btf;
> > > > >
> > > > > -               return btf;
> > > > > +               pr_warn("Failed to load vmlinux BTF from %s, was =
CONFIG_DEBUG_INFO_BTF enabled?\n",
> > > >
> > > > we should do better here as well. We should distinguish between "th=
ere
> > > > is vmlinux image, but it has no BTF" vs "there is no vmlinux image"=
 vs
> > > > "vmlinux image is there, there is BTF, but we can't parse it". See
> > > > btf__parse(). We return -ENODATA if ELF doesn't have BTF, that's th=
e
> > > > first situation. We can probably use faccessat() check for second
> > > > situation. Everything else can be reported as pr_debug() with locat=
ion
> > > > (but still no CONFIG_DEBUG_INFO_BTF, it's meaningless for fallback =
BTF
> > > > locations)
> > > >
> > > > > +                       path);
> > > > >         }
> > > > >
> > > > > -       pr_warn("failed to find valid kernel BTF\n");
> > > >
> > > > and then here we can probably warn that we failed to find any kerne=
l
> > > > BTF, and suggest CONFIG_DEBUG_INFO_BTF
> > >
> > > Andrii, you've basically written this patch, can I pass this over to =
you?
> >
> > I think it would be great if you can finish thi, thanks.
> >
> > >
> > > Thanks,
> > > Ian
> > >
> > > > >         return libbpf_err_ptr(-ESRCH);
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.43.0.429.g432eaa2c6b-goog
> > > > >

