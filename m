Return-Path: <bpf+bounces-19812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4FF831917
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 13:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E283828977A
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37824A10;
	Thu, 18 Jan 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz6EEugb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD93249E9
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580737; cv=none; b=fohRuFprgsSDgPU4E/fMb6kK/qFS1oOYIWEYGIOSDlGyh0irsaOR34N2iWDE0iXx0NaWerPL5rO4gMczVVhzJhXUjGAzEeHVERWSqHOOx94EuGxWAezkadR7YJqGUS1IN30OVNMkYmBxH9EWFhNtNmDS4GS+ra+oTjhcBhG5PSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580737; c=relaxed/simple;
	bh=iGUMPTMEHBBTSup7NIwp6Ibd37ENkjQZxlIFpBJOIg4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Twr9/L1bCXqtp/62HavgmkaU6uh6cm2zDUNdoPc+ZMCnVdW39uEAIX0AhItZ4/lFG1fI/GWUVbDQKIsRs09eCfezMoxPuSKnkkvIVFr1JYnJbxxuR974Aw5j73sxJxzxavPDg/Crjc7wXPuSjy/qH4qMVxWbs7F1eg4J1fsP5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vz6EEugb; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc21ad8266fso2730844276.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705580734; x=1706185534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNLAkicIIqiT2EqfxHpvXov6xMSs6/wRflCz4OhUZhQ=;
        b=Vz6EEugbNCo2JW8nqpdToR8rfmfidYtsshZDWU9YAnzmmJq1wtkzhYCz6txmA5xKzJ
         yKBrS6gEmmxQttKVDKBOBiyZnmNyEqgFx7feE/rSsIC4+gVGOpbkeLeBUg/HwH9nx4X7
         tNbhC1zwfVVPpPfZKBPhVKyT3mcOFgsqvxkWrf3hBY4Mglipw7axGPSNldGH7e4OKqSJ
         Y5dk7nKF8M+kY9zpN2SWoKriT28MV62QcSaWeuM88/ujR2fFj1U2TYJhUy9egYNpRw9c
         oJbGUVVkqpwvzZs/0PmIbVYX/IAI2KwCGAqajDYX3ngF+CGeg7DoiC3aaDZSuLPoRMc4
         5s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705580734; x=1706185534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNLAkicIIqiT2EqfxHpvXov6xMSs6/wRflCz4OhUZhQ=;
        b=X3ZXTVpXIl7Up3cj8l2b8OR9uyWzyAFI6EXta1rGvbcHRZSaw7zuFbhBJl/kPHE1tQ
         V7KDKILk6bbw67S2b/w6A+vdZyBXGqoUuJxgoAdgysGVyBYmXJHEQ2g0lT4f+OQzxtD5
         vDQIYpZg3zBokH3H6D2VTK3d7OKx/0nqB7FnFCcgImrNDsXNV5TnpgxUTYpiGtccwUa3
         zcSBhkF5kolf7ZuM2ftrbOPsIggcXp/9oK2HMX0tcQaS2UFqqSECUA1ugqfV/Dht+IvJ
         Z+Sjo0wSuuRYlhp9jCWi49ZcWFBbVEfDPAl343hg8ht3z5XZLuTDoLUZugQStl9KD4Dn
         daUQ==
X-Gm-Message-State: AOJu0Yyol8ZSaMr0/8ecp0fbdQI4cMPnRK4Ic1CdeEB4yuMJpih4b7+Q
	X2dlv4YgZj5O5Na4sIGHZBV3CR3oWCTt895MtETANuXxghu1+s7FkZ+9whhn3a0Et2ZfV0AwFQN
	8lXwHzb++UcNJx2/gWwGnylQ2E9I=
X-Google-Smtp-Source: AGHT+IFbQcsfXYiVV9o0fvwzRgu2lPqS4Qq5J1Z9aYGyaLHB4SDPTRDTihzEdvVXextfxVhTPKCsjMRbaOTL0MpYF5s=
X-Received: by 2002:a25:3607:0:b0:dc2:41f8:f508 with SMTP id
 d7-20020a253607000000b00dc241f8f508mr512621yba.55.1705580734651; Thu, 18 Jan
 2024 04:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118095416.989152-1-jolsa@kernel.org> <20240118095416.989152-2-jolsa@kernel.org>
In-Reply-To: <20240118095416.989152-2-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 18 Jan 2024 20:24:58 +0800
Message-ID: <CALOAHbDnUaGtTAnrJthHV_U1Oz6c+2MeE7LQ6aqeW6y5cKt=OQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: Add cookie to perf_event bpf_link_info records
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:54=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> At the moment we don't store cookie for perf_event probes,
> while we do that for the rest of the probes.
>
> Adding cookie fields to struct bpf_link_info perf event
> probe records:
>
>   perf_event.uprobe
>   perf_event.kprobe
>   perf_event.tracepoint
>   perf_event.perf_event
>
> And the code to store that in bpf_link_info struct.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       | 4 ++++
>  kernel/bpf/syscall.c           | 4 ++++
>  tools/include/uapi/linux/bpf.h | 4 ++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a00f8a5623e1..b823d367a83c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6582,6 +6582,7 @@ struct bpf_link_info {
>                                         __aligned_u64 file_name; /* in/ou=
t */
>                                         __u32 name_len;
>                                         __u32 offset; /* offset from file=
_name */
> +                                       __u64 cookie;
>                                 } uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_P=
ERF_EVENT_URETPROBE */
>                                 struct {
>                                         __aligned_u64 func_name; /* in/ou=
t */
> @@ -6589,14 +6590,17 @@ struct bpf_link_info {
>                                         __u32 offset; /* offset from func=
_name */
>                                         __u64 addr;
>                                         __u64 missed;
> +                                       __u64 cookie;
>                                 } kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_P=
ERF_EVENT_KRETPROBE */
>                                 struct {
>                                         __aligned_u64 tp_name;   /* in/ou=
t */
>                                         __u32 name_len;

It might be beneficial to include an alignment pad '__u32 :32;' here,
following the pattern used in other instances within this file.

> +                                       __u64 cookie;
>                                 } tracepoint; /* BPF_PERF_EVENT_TRACEPOIN=
T */
>                                 struct {
>                                         __u64 config;
>                                         __u32 type;

Same here.

> +                                       __u64 cookie;
>                                 } event; /* BPF_PERF_EVENT_EVENT */
>                         };
>                 } perf_event;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a1f18681721c..13193aaafb64 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3501,6 +3501,7 @@ static int bpf_perf_link_fill_kprobe(const struct p=
erf_event *event,
>         if (!kallsyms_show_value(current_cred()))
>                 addr =3D 0;
>         info->perf_event.kprobe.addr =3D addr;
> +       info->perf_event.kprobe.cookie =3D event->bpf_cookie;
>         return 0;
>  }
>  #endif
> @@ -3526,6 +3527,7 @@ static int bpf_perf_link_fill_uprobe(const struct p=
erf_event *event,
>         else
>                 info->perf_event.type =3D BPF_PERF_EVENT_UPROBE;
>         info->perf_event.uprobe.offset =3D offset;
> +       info->perf_event.uprobe.cookie =3D event->bpf_cookie;
>         return 0;
>  }
>  #endif
> @@ -3553,6 +3555,7 @@ static int bpf_perf_link_fill_tracepoint(const stru=
ct perf_event *event,
>         uname =3D u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
>         ulen =3D info->perf_event.tracepoint.name_len;
>         info->perf_event.type =3D BPF_PERF_EVENT_TRACEPOINT;
> +       info->perf_event.tracepoint.cookie =3D event->bpf_cookie;
>         return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, =
NULL, NULL);
>  }
>
> @@ -3561,6 +3564,7 @@ static int bpf_perf_link_fill_perf_event(const stru=
ct perf_event *event,
>  {
>         info->perf_event.event.type =3D event->attr.type;
>         info->perf_event.event.config =3D event->attr.config;
> +       info->perf_event.event.cookie =3D event->bpf_cookie;
>         info->perf_event.type =3D BPF_PERF_EVENT_EVENT;
>         return 0;
>  }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index a00f8a5623e1..b823d367a83c 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6582,6 +6582,7 @@ struct bpf_link_info {
>                                         __aligned_u64 file_name; /* in/ou=
t */
>                                         __u32 name_len;
>                                         __u32 offset; /* offset from file=
_name */
> +                                       __u64 cookie;
>                                 } uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_P=
ERF_EVENT_URETPROBE */
>                                 struct {
>                                         __aligned_u64 func_name; /* in/ou=
t */
> @@ -6589,14 +6590,17 @@ struct bpf_link_info {
>                                         __u32 offset; /* offset from func=
_name */
>                                         __u64 addr;
>                                         __u64 missed;
> +                                       __u64 cookie;
>                                 } kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_P=
ERF_EVENT_KRETPROBE */
>                                 struct {
>                                         __aligned_u64 tp_name;   /* in/ou=
t */
>                                         __u32 name_len;
> +                                       __u64 cookie;
>                                 } tracepoint; /* BPF_PERF_EVENT_TRACEPOIN=
T */
>                                 struct {
>                                         __u64 config;
>                                         __u32 type;
> +                                       __u64 cookie;
>                                 } event; /* BPF_PERF_EVENT_EVENT */
>                         };
>                 } perf_event;
> --
> 2.43.0
>


--=20
Regards
Yafang

