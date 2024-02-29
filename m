Return-Path: <bpf+bounces-22987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2692B86BE34
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450621C20F79
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8772C85D;
	Thu, 29 Feb 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf1isEur"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E26168B8
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169799; cv=none; b=QJ208DWjRFp4didXzdYGJPmMQlwkgmsPl8E+RzGn7gbXQH6F4Z4887V6DfLA6ipLw8tJ9ZHp1ykyHbHxYfxF1YEt/pczchFkyMJ5/SklWxGZ5s+LWWy1DJXvtGOU0wD+Xg0aTUHe1cAyvulXeih3tqTsk5PKTew/hMHs3eLqDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169799; c=relaxed/simple;
	bh=m/iGBnp5GAhV6rDLU5ZO5aJ5Y00W/w1p1Wf+FR8ppj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aobg1iXsfHj4lw8V9nNWbcdlWk+Jntiur1fJMcjRi6XBXvU04VJ2AhB+uvQ4JCxs/w4dKnsPPMzpU+Kp/tk+Xh/szAAKo1NARny3S2KqIAbKUS2ERaN7E9RJ5ABTKCeKuw+A9AB37mxEfC/jbmzYCcM48cX+EG8aBkr20sYwYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf1isEur; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so260852a12.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709169798; x=1709774598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuIn9isTipH450sLPsPPyAphnm16pJN8mRp5VOck7nk=;
        b=Qf1isEuritDqv9jnWcHrXickK+xClB1xAgJgIfKyq1wLli2sSfxCVhBhCbNowGrhQL
         q2bBlryIYqwC4j1RSwKq/J7KQaAePTyYei/r++3QFcXTgg/0e4plcwhvDdshF7pJykE7
         /PdwK/T7FzuEDFcL/8DEmcSbG8BDgTbOIQ0nor1BSwWmLdPqwjiCk7Cj9Yxaxr9/fVgZ
         6wExeFHvNGQD+z0U5ITHydBCz10M0R5geXQSqMMQk5fOTc2uuPq3Gl87znbuRSxIqQd0
         LtqeULZO4vg9BiOHXfKb7x7kEulAYlkZL8N8QdDTMpk9Q5ugIiKG/QbB+PiIEvkzyETu
         FjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169798; x=1709774598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuIn9isTipH450sLPsPPyAphnm16pJN8mRp5VOck7nk=;
        b=GPhjJ6Q3qoS+724s4bSvOTdT9/P77RH+CMAdILUIzio1zX4Uq2phFacAOujU9P6Y5V
         m839VYxmxNj/JRb+8AyJV2Lu6qLm2CltlUKiaIXfwcodWeMkod0wKLryBJrOAqjjKttb
         0xXAoWnw0n3Q3yS/qYfVoW+DT3qbluHSmxpsyqUbFFW9aeK+BNPdTgkKuVcmwPm4v5fH
         U+sFLazUcgtY5hU7YkXq+3MryskjBiiTJDeigOgiWiv/yfi+JCT9InG0+bfws9+VGwtz
         5ePgmCz0Tr78Qg6cnMZPnu6kJgJNfN+dvg5vORdre4KASi2HI/S/fmv+rIk/opL8Qi5i
         pC8w==
X-Forwarded-Encrypted: i=1; AJvYcCUuw2DV+Vc27T7FWBeV+IRdfeDjXjNHFbvf8Khqdt0mYDn2hevw6ttvQP8G0GeGnd+/xWjOS6iKx1wNg2IZ1MkvkInm
X-Gm-Message-State: AOJu0Yw72SyLxQHJWCG4aB9aAQD1yuIXpZyWjXR7oloENlv1ZeFeSQuW
	iPB7KVGGG8sVU8XZU5ky2q4ihS86dzzqenkl9x2HYnjpZcDr1LRpx6Thd2mtHNr3N7IBt2+Slo/
	NbXAFMwh5zzotL6qONgNFrBwzToA=
X-Google-Smtp-Source: AGHT+IH4hxWa6SwN5zTX70cUI/TJreUTMHaxXOAx6qy1vJBzUfkMG4aGBhtQwXTXi/SmfoA+LnNYk97vPhgeXZxsrik=
X-Received: by 2002:a05:6a21:3182:b0:1a0:dfc9:378c with SMTP id
 za2-20020a056a21318200b001a0dfc9378cmr1194867pzb.44.1709169797621; Wed, 28
 Feb 2024 17:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228090242.4040210-1-jolsa@kernel.org> <20240228090242.4040210-2-jolsa@kernel.org>
In-Reply-To: <20240228090242.4040210-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 17:23:05 -0800
Message-ID: <CAEf4BzYdSdk79CcwfUpWyvYYfiVWYDDTRFtL=oSCArZwOt-kew@mail.gmail.com>
Subject: Re: [PATCH RFCv2 bpf-next 1/4] bpf: Add support for kprobe multi
 wrapper attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:03=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach bpf program for entry and return probe
> of the same function. This is common usecase and at the moment
> it requires to create two kprobe multi links.
>
> Adding new attr.link_create.kprobe_multi.flags value that instructs
> kernel to attach link program to both entry and exit probe.
>
> It's possible to control execution of the bpf program on return
> probe simply by returning zero or non zero from the entry bpf
> program execution to execute or not respectively the bpf program
> on return probe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  3 ++-
>  kernel/trace/bpf_trace.c       | 24 ++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h |  3 ++-
>  3 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d2e6c5fcec01..a430855c5bcd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1247,7 +1247,8 @@ enum bpf_perf_event_type {
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */
>  enum {
> -       BPF_F_KPROBE_MULTI_RETURN =3D (1U << 0)
> +       BPF_F_KPROBE_MULTI_RETURN  =3D (1U << 0),
> +       BPF_F_KPROBE_MULTI_WRAPPER =3D (1U << 1),
>  };
>
>  /* link_create.uprobe_multi.flags used in LINK_CREATE command for
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 241ddf5e3895..726a8c71f0da 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2587,6 +2587,7 @@ struct bpf_kprobe_multi_link {
>         u32 mods_cnt;
>         struct module **mods;
>         u32 flags;
> +       bool is_wrapper;

flags should be sufficient for this, why storing redundant bool field?

>  };
>
>  struct bpf_kprobe_multi_run_ctx {
> @@ -2826,10 +2827,11 @@ kprobe_multi_link_handler(struct fprobe *fp, unsi=
gned long fentry_ip,
>                           void *data)
>  {
>         struct bpf_kprobe_multi_link *link;
> +       int err;
>
>         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> -       return 0;
> +       err =3D kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip),=
 regs);
> +       return link->is_wrapper ? err : 0;
>  }
>
>  static void
> @@ -2967,6 +2969,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         void __user *uaddrs;
>         u64 *cookies =3D NULL;
>         void __user *usyms;
> +       bool is_wrapper;
>         int err;
>
>         /* no support for 32bit archs yet */
> @@ -2977,9 +2980,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>                 return -EINVAL;
>
>         flags =3D attr->link_create.kprobe_multi.flags;
> -       if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
> +       if (flags & ~(BPF_F_KPROBE_MULTI_RETURN|
> +                     BPF_F_KPROBE_MULTI_WRAPPER))

nit: spaces around | are missing, also keep on a single line?

>                 return -EINVAL;
>
> +       is_wrapper =3D flags & BPF_F_KPROBE_MULTI_WRAPPER;
> +
>         uaddrs =3D u64_to_user_ptr(attr->link_create.kprobe_multi.addrs);
>         usyms =3D u64_to_user_ptr(attr->link_create.kprobe_multi.syms);
>         if (!!uaddrs =3D=3D !!usyms)
> @@ -3054,15 +3060,21 @@ int bpf_kprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>         if (err)
>                 goto error;
>
> -       if (flags & BPF_F_KPROBE_MULTI_RETURN)
> -               link->fp.exit_handler =3D kprobe_multi_link_exit_handler;
> -       else
> +       if (is_wrapper) {
>                 link->fp.entry_handler =3D kprobe_multi_link_handler;
> +               link->fp.exit_handler =3D kprobe_multi_link_exit_handler;
> +       } else {
> +               if (flags & BPF_F_KPROBE_MULTI_RETURN)
> +                       link->fp.exit_handler =3D kprobe_multi_link_exit_=
handler;
> +               else
> +                       link->fp.entry_handler =3D kprobe_multi_link_hand=
ler;
> +       }
>

how about:

if (!(flags & BPF_F_KPROBE_MULTI_RETURN))
    link->fp.entry_handler =3D kprobe_multi_link_handler;
if (flags & (BPF_F_KPROBE_MULTI_RETURN | BPF_F_KPROBE_MULTI_WRAPPER))
    link->fp.exit_handler =3D kprobe_multi_link_exit_handler;


>         link->addrs =3D addrs;
>         link->cookies =3D cookies;
>         link->cnt =3D cnt;
>         link->flags =3D flags;
> +       link->is_wrapper =3D is_wrapper;
>
>         if (cookies) {
>                 /*
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index d2e6c5fcec01..a430855c5bcd 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1247,7 +1247,8 @@ enum bpf_perf_event_type {
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */
>  enum {
> -       BPF_F_KPROBE_MULTI_RETURN =3D (1U << 0)
> +       BPF_F_KPROBE_MULTI_RETURN  =3D (1U << 0),
> +       BPF_F_KPROBE_MULTI_WRAPPER =3D (1U << 1),
>  };
>
>  /* link_create.uprobe_multi.flags used in LINK_CREATE command for
> --
> 2.43.2
>

