Return-Path: <bpf+bounces-55672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672F6A84B1B
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44626460D1C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6781F152E;
	Thu, 10 Apr 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBPa9Xbl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FDA1A5BA9;
	Thu, 10 Apr 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306598; cv=none; b=O+t0w/LRVLqRespFZLQVC5EPFLmHFm5ipSOOGG2wlFibFJNMT/wBz8YmVZ7mfpjG5ii9W6ja2RJyBs41AyjTI7lJ1egZPS7F/BZH+R+ARf6r//k5bmUX4Ml47b1CbXdBxA9dH+j/Lj26Rcihx9Pz+YKFMPcrJdmFK3mM6hq0Ppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306598; c=relaxed/simple;
	bh=sspiYzeLO/mCzmOWqn4px9VF2e+XISs2WJESvMIDqIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeqOoNB1/s2c9b9N8YugtCmSeKVaPypbnEh7mb2wLDGWyimG55iR0J+4GuLJH9wnA51vj6HmJB/ilqG3c3QtdjrYhwmaYBJjwQ34NClfhUJvQr8g96AgP57gAQTud24woY1qw/OQfTRQNke3PeF8qBPSRo9hut1L0ZnAGXlLV20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBPa9Xbl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1106597b3a.0;
        Thu, 10 Apr 2025 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744306595; x=1744911395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P06hbp3wkuws5Wen+dXOKesqGv8DEZD0E1WlHGL7ks8=;
        b=jBPa9Xbl4gB/RSV35fy26t+TEJmZyv9vUOj/bpR7Hp7bgur3hP5oZNGZ0hMHdy0Dgb
         3gG2NZqNrGPzocegZ6k+ffRjnUtPYobPYLV7+Gj3TtLAQZKTq7NwJFbJ6gX5+sO+BqbW
         x+57d3MiChhZw3y51049WIXLqHg1iTtHALekaJbtAB38aEQtPIMRTitkYjtbljNxLNYp
         uQkM4x8bl+21W/BrO5BK8+Aar3XE/OjCdvexGP+45/AzqrWfaxm/jcFARHBHcX7HPvmv
         YyJJWXyIqpYTYFRs1HobnbQOAzVmBGoyNAEH3pHfSCXNJr25LBFEMuDao40wydZ6cGWy
         8qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306595; x=1744911395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P06hbp3wkuws5Wen+dXOKesqGv8DEZD0E1WlHGL7ks8=;
        b=VNdZt+gWHq+cGgJxHZ6huKhiK85TOhcnQ56N64s1i+6RZQJ0VNoqQ4eA/e+OIJzd0K
         1MSiBYs4CfMZDiwx21wXoy4Q8FD2L3D2GLmWxyPaOpdM4KlADaxsb0UnESaBVj5s8GI0
         MuSL0rflhDFb3YYg080YhYEgCxNfPA3idNGmtz5Tk88DvLrkd/Yc9DxS3gK8pqBkmmIe
         mPwIN9W9DkmIyCdvGhsXynWjFqhkyFpnyEAyAKBsjIlqLDU/l/VSE5f3x948a4pSFVU6
         BlE+ckSMZtG5LVry9pt2+jdQrlqWsYF7i/esPmE+fEWmiPpqMoyuZtqQ9qBy9n14m4v6
         nDog==
X-Forwarded-Encrypted: i=1; AJvYcCWFPYcJEVBsBO0wvAcodQQoYluzbJdiAT+NyCruxkMZPfpAbyKfjalW0w9JnXAlEasGrN8uWVCxStHXQoVq@vger.kernel.org, AJvYcCX+U89VxiTZvM6xb5PJGULPX2BJqj1mYl0pf2ZGUH7pIjNUUMGa9v/PM7CHk3VUNJhNWxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbmE20Oq4/16ZwgSrb7hnFEzFgssgBHE8oxbZEt/MXkVZba7M8
	PImCaTDOJ2ErtE6flNEu/vi5zaEJWLgfa7zltwcQYyRfuQC56OcATDvG98l6iRjJRzHoBlcsz4g
	qT+uaJ1r0hD/sCBxt5hmvXHdZGeM=
X-Gm-Gg: ASbGnctbWcbZitL6tltSfTu7imCnNX393ze601LivtyD8FaJ5bEIN8LIhJdwQVyItKS
	kn+gbAMjkNvfGlJXOHSJRpg3DVWNesRQGP8mK3jTixURjPKJY1zIhf92OYEa521GrxfxPQTs0lb
	pSoWgNgNw4OyX/wrpf99oFq8MD2Egu2E4FPKxh
X-Google-Smtp-Source: AGHT+IHlSeaBqYB6X5ofMDbXVGCRJEznPDHkHap8QUfUuKQhQdKk5fDdc4RBLKXpOhtLX6AgDn9nHCW39Nu/xY8VRCc=
X-Received: by 2002:a05:6a00:1152:b0:736:a540:c9ad with SMTP id
 d2e1a72fcca58-73bbefad6camr5180449b3a.20.1744306594780; Thu, 10 Apr 2025
 10:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410052712.206785-1-yangfeng59949@163.com> <CAEyhmHRZWB-ba_mFhAHQbho9geMHMswiY---dMsGCuE1uDSkwA@mail.gmail.com>
In-Reply-To: <CAEyhmHRZWB-ba_mFhAHQbho9geMHMswiY---dMsGCuE1uDSkwA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Apr 2025 10:36:22 -0700
X-Gm-Features: ATxdqUFxxcqm3_aMJkwKw9RgKC9FCkZ0YjAwpHSBAB5NuHcuXuFeqpbzr0KdoJQ
Message-ID: <CAEf4BzY9kdZkTYxASWo+xoPTdEFzrjj3nsOOCXNmPMQEk=eNNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix event name too long error
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 4:27=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Hi Feng,
>
> On Thu, Apr 10, 2025 at 1:30=E2=80=AFPM Feng Yang <yangfeng59949@163.com>=
 wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > If the event name is too long, it will cause an EINVAL error.
> >
> > The kernel error path is
> > probes_write
> >     trace_parse_run_command
> >         create_or_delete_trace_uprobe
> >             trace_uprobe_create
> >                 trace_probe_create
> >                     __trace_uprobe_create
> >                         traceprobe_parse_event_name
> >                             else if (len >=3D MAX_EVENT_NAME_LEN)
> > Requires less than 64 bytes.
> >
>
> Please don't submit patch in a hurry.
> This patch does NOT fix the issue.

It would be good to also have a bit more human-readable explanation of
the issue.

pw-bot: cr

>
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> >  tools/lib/bpf/libbpf.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b2591f5cab65..8e48ba99f06c 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -12227,6 +12227,16 @@ bpf_program__attach_uprobe_multi(const struct =
bpf_program *prog,
> >         return libbpf_err_ptr(err);
> >  }
> >
> > +static const char *get_last_part(const char *path)
> > +{
> > +       const char *last_slash =3D strrchr(path, '/');
> > +
> > +       if (last_slash !=3D NULL)
> > +               return last_slash + 1;
> > +       else
> > +               return path;
> > +}
> > +
>
> Use basename(3) instead.
>
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t =
pid,
> >                                 const char *binary_path, size_t func_of=
fset,
> > @@ -12241,7 +12251,7 @@ bpf_program__attach_uprobe_opts(const struct bp=
f_program *prog, pid_t pid,
> >         size_t ref_ctr_off;
> >         int pfd, err;
> >         bool retprobe, legacy;
> > -       const char *func_name;
> > +       const char *func_name, *binary_name;
> >
> >         if (!OPTS_VALID(opts, bpf_uprobe_opts))
> >                 return libbpf_err_ptr(-EINVAL);
> > @@ -12254,6 +12264,7 @@ bpf_program__attach_uprobe_opts(const struct bp=
f_program *prog, pid_t pid,
> >         if (!binary_path)
> >                 return libbpf_err_ptr(-EINVAL);
> >
> > +       binary_name =3D get_last_part(binary_path);
>
> What if len(binary_name) >=3D MAX_EVENT_NAME_LEN ?
>
> >         /* Check if "binary_path" refers to an archive. */
> >         archive_sep =3D strstr(binary_path, "!/");
> >         if (archive_sep) {
> > @@ -12318,7 +12329,7 @@ bpf_program__attach_uprobe_opts(const struct bp=
f_program *prog, pid_t pid,
> >                         return libbpf_err_ptr(-EINVAL);
> >
> >                 gen_uprobe_legacy_event_name(probe_name, sizeof(probe_n=
ame),
> > -                                            binary_path, func_offset);
> > +                                            binary_name, func_offset);
> >
> >                 legacy_probe =3D strdup(probe_name);
> >                 if (!legacy_probe)
> > --
> > 2.43.0
> >
> >
>
> FYI, when I mentioned this issue in ([0]), I tested with the following di=
ff:
>   [0]: https://github.com/iovisor/bcc/pull/5271
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b2591f5cab65..4087fc3ae62f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11142,10 +11142,10 @@ static void
> gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>   static int index =3D 0;
>   int i;
>
> - snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, of=
fset,
> + snprintf(buf, buf_sz, "libbpf_%u_%.32s_0x%zx_%d", getpid(),
> kfunc_name, offset,
>   __sync_fetch_and_add(&index, 1));
>
> - /* sanitize binary_path in the probe name */
> + /* sanitize kfunc_name in the probe name */
>   for (i =3D 0; buf[i]; i++) {
>   if (!isalnum(buf[i]))
>   buf[i] =3D '_';
> @@ -11270,7 +11270,7 @@ int probe_kern_syscall_wrapper(int token_fd)
>
>   return pfd >=3D 0 ? 1 : 0;
>   } else { /* legacy mode */
> - char probe_name[128];
> + char probe_name[64];
>
>   gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_na=
me, 0);
>   if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
> @@ -11328,7 +11328,7 @@ bpf_program__attach_kprobe_opts(const struct
> bpf_program *prog,
>       func_name, offset,
>       -1 /* pid */, 0 /* ref_ctr_off */);
>   } else {
> - char probe_name[256];
> + char probe_name[64];
>
>   gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
>        func_name, offset);
> @@ -11880,7 +11880,8 @@ static void gen_uprobe_legacy_event_name(char
> *buf, size_t buf_sz,
>  {
>   int i;
>
> - snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path,
> (size_t)offset);
> + snprintf(buf, buf_sz, "libbpf_%u_%.32s_0x%zx",
> + getpid(), basename((void *)binary_path), (size_t)offset);
>
>   /* sanitize binary_path in the probe name */
>   for (i =3D 0; buf[i]; i++) {
> @@ -12312,7 +12313,7 @@ bpf_program__attach_uprobe_opts(const struct
> bpf_program *prog, pid_t pid,
>   pfd =3D perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
>       func_offset, pid, ref_ctr_off);
>   } else {
> - char probe_name[PATH_MAX + 64];
> + char probe_name[64];
>
>   if (ref_ctr_off)
>   return libbpf_err_ptr(-EINVAL);
> --
> 2.43.0
>
> Cheers,
> ---
> Hengqi

