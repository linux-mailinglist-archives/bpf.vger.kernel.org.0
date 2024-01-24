Return-Path: <bpf+bounces-20193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4B583A090
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 05:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401DE29007F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 04:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED839BE45;
	Wed, 24 Jan 2024 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgMl+VYr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2A17736;
	Wed, 24 Jan 2024 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070337; cv=none; b=bBIGYVI/0M3fGTfXRJr0zYYu7VEg80MNXj1Dbhhh1ankJYaqGPAnhozj6Gl4iyAoXlPsGPN0lJkKOwhylz4VKDNhR1uI5iPiyS8eVS5kUR+7kqcVcOw8YPLmgC9JLRUf4FFr9uw8fsDComjfd+CsPOj3IW/tCDtsJBWym55NBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070337; c=relaxed/simple;
	bh=Os+LjW32DNoAp84uFJujdZEAdr7jSUq6SR5OelqDce4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI4TOmb+WqzLpzzI6r1HWhikSWTnhjTafD2hYqM95dswb9zj5h+66ywrG5NivTtO1t9RBJ5wbHFShfwprhhXWTCXXyD0qqXATRMRIzp7qjsb/BBLAtVO+b0Cqx4oL9iXoTFmevcIlmYlLdf9sRjJuEa/FdwszChKoXmYJW1ITRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgMl+VYr; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e0e08c70f7so2476078a34.2;
        Tue, 23 Jan 2024 20:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706070335; x=1706675135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/4uC4ThCc6lr4x+9JZtlV6yhdWs1NTs0bqZsB9jdbg=;
        b=bgMl+VYrn+htOxpoKQHsIYxfs0NTNCqRrbqS/10x/M00Ra4AS2keA1SZRvyyYvbpmh
         4ysq0mN39GPhA2OMTmpYDAMA3BYspfyiZr8lIFCiTOYfDND12mnZJcNKjXTF3JpH99Ag
         9DhDQlB19SSu/r6Gq+t8u6Kln4f/18lApFJV4bdt+jqA4Kwm9IAjDO8rrurNj64fdwpL
         rQCY9ofF20veIZTZGz7KoziazHJIoh5zq1si056+aNtqJ87N6VooDfWEVvYteayK6QOJ
         kA0p0l0t0ejEIUp70lMI9DskdJtaNNgf03MuRJ6QoIjh9613DAB3jX8j/W4lCayS48sU
         scLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070335; x=1706675135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/4uC4ThCc6lr4x+9JZtlV6yhdWs1NTs0bqZsB9jdbg=;
        b=ADqa+i+hTQcScCCTBFLmzzdvOBjadPN1ZmT7bSZcCdnvSvwn5CXPkXc62LHatdUBe0
         2J5LSxpV5O6mP6dYcgnRrwDDSOhY7PZ0kfoVIMFjToMcq2TQtcg2dwy9bsW7rUvGP2Tj
         KGRroL4qFBrtT0/hEMh0loOKPTlCt5MH2zrPL8S9GoeeuyGePWa0JsSZtqOQwXzCldtd
         yBQxea2+6spUck9mC0ID7fERwW+u0t8AafI6NHutaabwv27E9jNaqAsfUOj3wlgwlB4o
         IW7QOvO4q0gr/skqkyvFba8epJornsX/gPxsqXN0Z2Ek1IyL5ADwxGl2+eoVZloIJ6TE
         siYQ==
X-Gm-Message-State: AOJu0Yw21FgBGz0ZzuQ8ESRWd4vZoqu/8mUysZzTO3i9YEyhmkgfU9ok
	vALCNRYpIpDdvW50rhL8xLCkUNGN+dGEzUtPplWOneES2TXx+tSLA0JbPNcJLES9IiPNJNTCfHp
	o2BgfuqBOAZQ7GdPp0KEZTm38EN8=
X-Google-Smtp-Source: AGHT+IEYiylJBYXfY49cWvNnLFhEHwCUuaq0khwyMFUen1BASnXDw/KkbiRwBecqao7tETU5i622l0W0+ynXIZ7ogCE=
X-Received: by 2002:a05:6830:22c1:b0:6dd:e9e2:de67 with SMTP id
 q1-20020a05683022c100b006dde9e2de67mr945773otc.20.1706070334462; Tue, 23 Jan
 2024 20:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123204437.1322700-1-irogers@google.com>
In-Reply-To: <20240123204437.1322700-1-irogers@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jan 2024 20:25:22 -0800
Message-ID: <CAEf4BzZY7qnnBJ+zFtdjRf0YuwSDWXQvYG7U-kY+7t0g_OTZZQ@mail.gmail.com>
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

On Tue, Jan 23, 2024 at 12:44=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
> valid kernel BTF" message makes diagnosing the kernel build issue some
> what cryptic. Add a little more detail with the hope of helping users.
>
> Before:
> ```
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -3
> libbpf: failed to load object 'lock_contention_bpf'
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> ```
>
> After no access /sys/kernel/btf/vmlinux:
> ```
> libbpf: Unable to access canonical vmlinux BTF from /sys/kernel/btf/vmlin=
ux
> libbpf: Error loading vmlinux BTF: -3
> libbpf: failed to load object 'lock_contention_bpf'
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> ```
>
> After no BTF /sys/kernel/btf/vmlinux:
> ```
> libbpf: Failed to load vmlinux BTF from /sys/kernel/btf/vmlinux, was CONF=
IG_DEBUG_INFO_BTF enabled?
> libbpf: Error loading vmlinux BTF: -3
> libbpf: failed to load object 'lock_contention_bpf'
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> ```
>
> Closes: https://lore.kernel.org/bpf/CAP-5=3DfU+DN_+Y=3DY4gtELUsJxKNDDCOvJ=
zPHvjUVaUoeFAzNnig@mail.gmail.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
>
> ---
> v2. Try to address review comments from Andrii Nakryiko.
> ---
>  tools/lib/bpf/btf.c | 49 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ee95fd379d4d..d8a05dda0836 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4920,16 +4920,25 @@ static int btf_dedup_remap_types(struct btf_dedup=
 *d)
>         return 0;
>  }
>
> +static struct btf *btf__load_vmlinux_btf_path(const char *path)

I don't think we need this helper, you literally call btf__parse() and
pr_debug(), that's all

> +{
> +       struct btf *btf;
> +       int err;
> +
> +       btf =3D btf__parse(path, NULL);
> +       err =3D libbpf_get_error(btf);

we should stop using libbpf_get_error, in libbpf v1.0+ it's best to do just

btf =3D btf__parse(path, NULL);
if (!btf) {
    err =3D -errno;
    pr_debug(...);
    return NULL;
}

> +       pr_debug("loading kernel BTF '%s': %d\n", path, err);
> +       return err ? NULL : btf;
> +}
> +
>  /*
>   * Probe few well-known locations for vmlinux kernel image and try to lo=
ad BTF
>   * data out of it to use for target BTF.
>   */
>  struct btf *btf__load_vmlinux_btf(void)
>  {
> +       /* fall back locations, trying to find vmlinux on disk */
>         const char *locations[] =3D {
> -               /* try canonical vmlinux BTF through sysfs first */
> -               "/sys/kernel/btf/vmlinux",
> -               /* fall back to trying to find vmlinux on disk otherwise =
*/
>                 "/boot/vmlinux-%1$s",
>                 "/lib/modules/%1$s/vmlinux-%1$s",
>                 "/lib/modules/%1$s/build/vmlinux",
> @@ -4938,29 +4947,41 @@ struct btf *btf__load_vmlinux_btf(void)
>                 "/usr/lib/debug/boot/vmlinux-%1$s.debug",
>                 "/usr/lib/debug/lib/modules/%1$s/vmlinux",
>         };
> -       char path[PATH_MAX + 1];
> +       const char *location;
>         struct utsname buf;
>         struct btf *btf;
> -       int i, err;
> +       int i;
>
> -       uname(&buf);
> +       /* try canonical vmlinux BTF through sysfs first */
> +       location =3D "/sys/kernel/btf/vmlinux";
> +       if (faccessat(AT_FDCWD, location, R_OK, AT_EACCESS) =3D=3D 0) {
> +               btf =3D btf__load_vmlinux_btf_path(location);
> +               if (btf)
> +                       return btf;
> +
> +               pr_warn("Failed to load vmlinux BTF from %s, was CONFIG_D=
EBUG_INFO_BTF enabled?\n",
> +                       location);

Mentioning CONFIG_DEBUG_INFO_BTF seems inappropriate here,
/sys/kernel/btf/vmlinux exists, we just failed to parse its data,
right? So it's not about CONFIG_DEBUG_INFO_BTF, we just don't support
something in BTF data. Just pr_warn("Failed to load vmlinux BTF from
%s: %d", location, err); should be good

> +       } else
> +               pr_warn("Unable to access canonical vmlinux BTF from %s\n=
", location);

here the question of CONFIG_DEBUG_INFO_BTF is more appropriate, if
/sys/kernel/btf/vmlinux (on modern enough kernels) is missing, then
CONFIG_DEBUG_INFO_BTF is missing, probably. But I'd emit this only
after trying all the fallback paths and not finding anything.

also stylistical nit: if one side of if has {}, the other has to have
{} as well, even if it's just one line

>
> +       uname(&buf);
>         for (i =3D 0; i < ARRAY_SIZE(locations); i++) {
> -               snprintf(path, PATH_MAX, locations[i], buf.release);
> +               char path[PATH_MAX + 1];
> +
> +               snprintf(path, sizeof(path), locations[i], buf.release);
>
> +               btf =3D btf__load_vmlinux_btf_path(path);
>                 if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
>                         continue;
>
> -               btf =3D btf__parse(path, NULL);
> -               err =3D libbpf_get_error(btf);
> -               pr_debug("loading kernel BTF '%s': %d\n", path, err);
> -               if (err)
> -                       continue;
> +               btf =3D btf__load_vmlinux_btf_path(location);
> +               if (btf)
> +                       return btf;
>
> -               return btf;
> +               pr_warn("Failed to load vmlinux BTF from %s, was CONFIG_D=
EBUG_INFO_BTF enabled?\n",

we should do better here as well. We should distinguish between "there
is vmlinux image, but it has no BTF" vs "there is no vmlinux image" vs
"vmlinux image is there, there is BTF, but we can't parse it". See
btf__parse(). We return -ENODATA if ELF doesn't have BTF, that's the
first situation. We can probably use faccessat() check for second
situation. Everything else can be reported as pr_debug() with location
(but still no CONFIG_DEBUG_INFO_BTF, it's meaningless for fallback BTF
locations)

> +                       path);
>         }
>
> -       pr_warn("failed to find valid kernel BTF\n");

and then here we can probably warn that we failed to find any kernel
BTF, and suggest CONFIG_DEBUG_INFO_BTF

>         return libbpf_err_ptr(-ESRCH);
>  }
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

