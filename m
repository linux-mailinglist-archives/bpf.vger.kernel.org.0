Return-Path: <bpf+bounces-57608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCBAAD32F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 04:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206E6981BD5
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E1183CCA;
	Wed,  7 May 2025 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYa9SUBC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AABA38;
	Wed,  7 May 2025 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584323; cv=none; b=Cx89EQRPDWCrCOTLsJNMT3891MaHO/pNimseymws31sRvvYs51QcNPWOTJnpy6MrHj5ki9nokgRNnI8osj7J3NxmYWAf7FLJFl2oVHIAMOL5oXg9JRxPWP0v7pqJcPSMMVccEAxv86q/cpOgiIdedZ/VUDJAK3k9cVS7RwXoJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584323; c=relaxed/simple;
	bh=+4wEaXY1Q2OpDK61tuib2GPcqsE/z8bw55i5VbDquoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3gxgkySzx++DVEmYSb+XuF1BlRJNY2d+jLfTB/tCNTY0FqG8KgPSV6nARpCJH3llN23sGiquOQrB9qT8sIjuiF9Iet+8A1V7MHqpHGqCcirT9rXy1wP4HlU0UQjeOHjPxqc5FscQTzAu0YeLZmkAqbWY60y8u+cDlJzcuUQp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYa9SUBC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f544014883so937486d6.0;
        Tue, 06 May 2025 19:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746584320; x=1747189120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yctemJmdsE3vWYVvWZtCXsrMclPy1lOHqA26FMsE2Q=;
        b=gYa9SUBChMrm/6sWdTk9MAb+3K6xn2EyWfP/5RKxd/GJo3r9rDBpnGJzfgsZ2i4qxZ
         zYan/ui7CkxVaEZmNBJTpvuHsBlGAvLIZ4sL0n8eACS3WuRn95FnGy9OwsD5yLhRUq74
         hGK+D6qFEvhQVa2xpQaY4LfhigxQXnr7YxHCfKOWuzmR6lfBPAxTKD4ykVTchnXl++ko
         sxx+NotkLyiZuW55ZJ/42g8OtL6po88PgOehVGewHfsDLOyNGG0cNkv7PYBD36H0NeXc
         rkiX6QWQJLcnUQ4YBRFXlxaQvGyexxrCB7hxtdCVNNbG6BkgYwT13w1kF1S6ABlmk+c0
         XVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746584320; x=1747189120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yctemJmdsE3vWYVvWZtCXsrMclPy1lOHqA26FMsE2Q=;
        b=MI6n0tQzctECa+FXqdwh791BjjLKr49OCMdYruhzUH+GkGrybNvHfRWsrqdQYicDj7
         JoCGWMu/W2dFQZbWZyYRTcxmyUFSH+W3BGS7vxlbRQk/hQ90XmGbFZlMRZKSP26qDMOl
         EFgTtH9QubXWJ3x7Z51YzMw/03LIbg7lr5aLlzmckjua6gazM9hrOsc0oBJO60Pt1Sva
         dX1jUEvYGRQFSS50XEsh5m9TACZ3Dmvw/EYlBjddTw+wFvwnQdW0pQfTmcK9hA/gzX7l
         a/zIG4EY7jnCP7bwTwXS7WZo79Fg9Z3auco4B0ZTiZdkeijlyBmV5OByDZtQCfCPAOHi
         oveQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSDTD0IyFJApaHmakgZLp6XgihZ2iLnBu/alwb6+BaixGakIK84sVdCSrutU08Ij6CQ3Y=@vger.kernel.org, AJvYcCW6PB/I+m3RT1VmfVUM/lIgy4BrWDcsgYI+UkKtO9hbN0xEf0+WCBzeJMr02svX0WnacWs0n+83Q8aBNC7En/NNLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvYjmqgES5tLLs+0rhEgp7/gQhfLJMGoAwOD1sVITflAAMsHR
	f2qSwnjeq8WGiCE5pX/hF/+z7N5lWESXbWyXzUqTdyxYqws06ESHL7DZmRWqRoj9MCPqZQQ+NxX
	7TjVfA0DioGIMMYWMvrpBi3btTzQobS2Z
X-Gm-Gg: ASbGncvd7oyk68GS7smx8Wv5/Q06XyUw/Lk8znoX6iymw+gAKMqJGXz/k/1cXfujjYQ
	BiowxNMPjV+KY4F97fPd2/PAnE+PJoy6qk9Dqd/TGworV9OkXdGtcK7WugHupBUy70vX8svaloW
	Dbs7ntBhYYl3utVqgHdkmrPfQ=
X-Google-Smtp-Source: AGHT+IHqu3ORyAnXZo4ZZNXaCNvEiVJD2fgs1PqPMfJONl0rxeJaMlFqxp/Cve3ShusQT37MECY3ypBgItWXcL/UgoQ=
X-Received: by 2002:a05:6214:d47:b0:6e6:684f:7f78 with SMTP id
 6a1803df08f44-6f5429b4190mr30689716d6.3.1746584320477; Tue, 06 May 2025
 19:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506135727.3977467-1-jolsa@kernel.org> <20250506135727.3977467-2-jolsa@kernel.org>
In-Reply-To: <20250506135727.3977467-2-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 7 May 2025 10:18:04 +0800
X-Gm-Features: ATxdqUEIoqC70hSX0uHnGRk1LHHd81MZyM1n2t3Xby6Ul3NefJjtzWMd3mMo3Vg
Message-ID: <CALOAHbBL9oyxJah1+=VbhAXWtQe0Cmm2nLo=vhpJv1LNkGyLOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add support to retrieve ref_ctr_offset
 for uprobe perf link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:57=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to retrieve ref_ctr_offset for uprobe perf link,
> which got somehow omitted from the initial uprobe link info changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

LGTM
Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/uapi/linux/bpf.h       | 1 +
>  kernel/bpf/syscall.c           | 5 +++--
>  kernel/trace/trace_uprobe.c    | 2 +-
>  tools/include/uapi/linux/bpf.h | 1 +
>  4 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 71d5ac83cf5d..16e95398c91c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6724,6 +6724,7 @@ struct bpf_link_info {
>                                         __u32 name_len;
>                                         __u32 offset; /* offset from file=
_name */
>                                         __u64 cookie;
> +                                       __u64 ref_ctr_offset;
>                                 } uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_P=
ERF_EVENT_URETPROBE */
>                                 struct {
>                                         __aligned_u64 func_name; /* in/ou=
t */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index df33d19c5c3b..4b5f29168618 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3800,14 +3800,14 @@ static int bpf_perf_link_fill_kprobe(const struct=
 perf_event *event,
>  static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
>                                      struct bpf_link_info *info)
>  {
> +       u64 ref_ctr_offset, offset;
>         char __user *uname;
> -       u64 addr, offset;
>         u32 ulen, type;
>         int err;
>
>         uname =3D u64_to_user_ptr(info->perf_event.uprobe.file_name);
>         ulen =3D info->perf_event.uprobe.name_len;
> -       err =3D bpf_perf_link_fill_common(event, uname, &ulen, &offset, &=
addr,
> +       err =3D bpf_perf_link_fill_common(event, uname, &ulen, &offset, &=
ref_ctr_offset,
>                                         &type, NULL);
>         if (err)
>                 return err;
> @@ -3819,6 +3819,7 @@ static int bpf_perf_link_fill_uprobe(const struct p=
erf_event *event,
>         info->perf_event.uprobe.name_len =3D ulen;
>         info->perf_event.uprobe.offset =3D offset;
>         info->perf_event.uprobe.cookie =3D event->bpf_cookie;
> +       info->perf_event.uprobe.ref_ctr_offset =3D ref_ctr_offset;
>         return 0;
>  }
>  #endif
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 3386439ec9f6..d9cf6ed2c106 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1489,7 +1489,7 @@ int bpf_get_uprobe_info(const struct perf_event *ev=
ent, u32 *fd_type,
>                                     : BPF_FD_TYPE_UPROBE;
>         *filename =3D tu->filename;
>         *probe_offset =3D tu->offset;
> -       *probe_addr =3D 0;
> +       *probe_addr =3D tu->ref_ctr_offset;
>         return 0;
>  }
>  #endif /* CONFIG_PERF_EVENTS */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 71d5ac83cf5d..16e95398c91c 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6724,6 +6724,7 @@ struct bpf_link_info {
>                                         __u32 name_len;
>                                         __u32 offset; /* offset from file=
_name */
>                                         __u64 cookie;
> +                                       __u64 ref_ctr_offset;
>                                 } uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_P=
ERF_EVENT_URETPROBE */
>                                 struct {
>                                         __aligned_u64 func_name; /* in/ou=
t */
> --
> 2.49.0
>


--=20
Regards
Yafang

