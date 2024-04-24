Return-Path: <bpf+bounces-27599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5468AFD4C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87436B22A7C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955274C61;
	Wed, 24 Apr 2024 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ6Qx3mA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A584A1A
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918414; cv=none; b=IBhfkIVjoJ6KVwMwJpeNQXtKa6uuHeaeuZglM29ksvXV0veFZTmGSHHnkdOHpOGX2sDordtJUGG/qsKCDRsOi6WlaMgenVVAam5OMcTxfIg+mg4LBPWpzDAK65EqFZrso1qXLTtDTZRmv2npkG4lrTm1wI6zJI+dVhquglE+bPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918414; c=relaxed/simple;
	bh=V7UO0I173fj0tAlkHHq0Chp6no+hBWSdgDXJzvHXeok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcloxUhy9IvHeGXjESq96qXJwk8zuw8e7t7EkevwNGsQYGFGqvsrw3jOvPnltyuiFcu9I8hLxlRQOytUW+YlUiQ0Rr0RSeZxhFsVpOTbAeotRgXa+UVOcBjcciuvQpagcRI3teCfvfYotorGbTd0tPzZV+FcPaV3v1XVNpmU38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ6Qx3mA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3f6f03594so47474905ad.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713918412; x=1714523212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TQX/MJ9R8YSn1f8Ybmod8tw8BtmZJa+LvQNkKu8OdA=;
        b=eQ6Qx3mAHXZzy/Hphmy/tZPRJBUXs+1G4ocbETV+vKet/r0QHuxQ4B47ayTiUjujPO
         zjmo+E1XeLeiR0XULnF7kwd66Orb0K/A4xNto8gMerWVCf8Hs+NwS0H4WYdWpGCHCqo6
         Fa31YotZCvsgZoyn24IPeerXeMVdyuKuRKBBLXdCdoR6GUIOvpcdoztFMxaKpY9WcRvv
         eVj6R1TYQdnD6lfwT5/4pTZh7lDxIcFYMuqFGueNHRpRT7WIeV0TwHmVGjFJT7sJaz/z
         gBbod0nTWD9ENzAU83ptedXf4ewUeEQPUoLVHfzOA4oGxhEmroMPeUbiJ2xef6T/2PpS
         NueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918412; x=1714523212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TQX/MJ9R8YSn1f8Ybmod8tw8BtmZJa+LvQNkKu8OdA=;
        b=g/z7vZdaUIkhUQgYfwgHmv2Jeri+OBBlbLEqllE37IKNr2eQZ5KYlvXzxJi1Mc1GOn
         u46kxKDd6oLu1EmBAdNKy5HaczP2FWaP1drpxDTjBy+imbqJW7rEKBvA4gXlT9HjRtrz
         lI4DMJf2Hkdr6wzVG5rNZiLrLTT6eFdxgW53Ga2n9wvNM8yVGfTmW5oFhIJrvBbkEfcC
         Yoj9wiviJnHezd+gA6UJyoFZP++gSYdhokSevOe4EkVGqMvn1XX8nBLQTZwwRq9n62zO
         WaLXZgYvug9KDR19gm1SDr31OAh4qMag3xjhlZuyx1paSKEZsBfcrnlWnrGtHtjB78b2
         vDmg==
X-Forwarded-Encrypted: i=1; AJvYcCW+LhRb5zaxjG2M6wTVDx77kTpzadjbnzgQTDvLHR0u+36xDqNh4aQREuh9lopsiFnzUQupufn9SE2nMpbsCHAgRag1
X-Gm-Message-State: AOJu0Ywt7no5hZOQPTbnmTpisUtwKqIGaKZxM5ub7CDFj27I1XVlBSFz
	/lSzEY0iumK+TMwCyjqQ1kB+cNkcY4lO4ZREzEM6UZAgnl1zoyaxs0OC9e5MgmsW6loQk5PlsqK
	Z1hJmG6m3XdpY45zbcnLgtHOetvI=
X-Google-Smtp-Source: AGHT+IGimV/6WqXFRE6KZfArx7WG0RrXoyaaXpQjDEjTnXiaRZSIb3lFVH6uBBX7hCQGOi7cA+mHPIUV44+Yz040xtk=
X-Received: by 2002:a17:903:40cf:b0:1e0:b62a:c0a2 with SMTP id
 t15-20020a17090340cf00b001e0b62ac0a2mr1228147pld.51.1713918412149; Tue, 23
 Apr 2024 17:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org> <20240422121241.1307168-2-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Apr 2024 17:26:39 -0700
Message-ID: <CAEf4BzayRpyFu_UAR4aNvvpq8hzOWFgbcRSWTUgAM81OGcQGoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Add support for kprobe multi session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:12=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach bpf program for entry and return probe
> of the same function. This is common use case which at the moment
> requires to create two kprobe multi links.
>
> Adding new BPF_TRACE_KPROBE_MULTI_SESSION attach type that instructs
> kernel to attach single link program to both entry and exit probe.
>
> It's possible to control execution of the bpf program on return
> probe simply by returning zero or non zero from the entry bpf
> program execution to execute or not the bpf program on return
> probe respectively.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  7 ++++++-
>  kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++--------
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index cee0a7915c08..fb8ecb199273 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1115,6 +1115,7 @@ enum bpf_attach_type {
>         BPF_CGROUP_UNIX_GETSOCKNAME,
>         BPF_NETKIT_PRIMARY,
>         BPF_NETKIT_PEER,
> +       BPF_TRACE_KPROBE_MULTI_SESSION,

let's use a shorter BPF_TRACE_KPROBE_SESSION? we'll just know that
it's multi-variant (there is no point in adding non-multi kprobes
going forward anyways, it's a new default)

>         __MAX_BPF_ATTACH_TYPE
>  };
>

[...]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index afb232b1d7c2..3b15a40f425f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1631,6 +1631,17 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>         }
>  }
>
> +static bool is_kprobe_multi(const struct bpf_prog *prog)
> +{
> +       return prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MULTI |=
|
> +              prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MULTI_S=
ESSION;
> +}
> +
> +static inline bool is_kprobe_multi_session(const struct bpf_prog *prog)

ditto, this multi is just a distraction at this point, IMO

> +{
> +       return prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MULTI_S=
ESSION;
> +}
> +
>  static const struct bpf_func_proto *
>  kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
>  {

[...]

