Return-Path: <bpf+bounces-57574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C9FAAD104
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EF57A30BD
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF79A21A94F;
	Tue,  6 May 2025 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXapaie2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F2376;
	Tue,  6 May 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570829; cv=none; b=a9EF0zsMNV0TmZIlqUs26RnvPdip2ehUzQUgvtlOKB15WzY1eVSjzF5PDJjW3xa9SgsksrT0iC8VZsB3e0Wo4Sf5WcGm1NHXReVetA337ZkRuCTnJUQelZqddvvR+wfHqa6bLEFBJ6zj4SwKcmdfCjnEeK03mzJEABYYjuBaYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570829; c=relaxed/simple;
	bh=Z6Cu6uLDLqCjsTrHz4tZK/0V/DvOEPcQ9/3zXvM+WLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN5iwTTIG4p4Onz7LobWN0+k4/9GhR5wCg3PARncGhUBeyYy4sTdUMB7yO0zmzp17N4SxKQuPjE7CzJmmqp+u/t9DID1c93ti6sfB2f1FKpmSMMoy6bDLiI9IrBJqREOCkiL9WYbN179lwaUQ1zPAAlsINOHIvdU4qt3HjvAi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXapaie2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so5279981a12.3;
        Tue, 06 May 2025 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746570827; x=1747175627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ztsAI3tt7LcUXIIXknbAsi0ywBlmlwHCJZfAYlrtiA=;
        b=FXapaie2Vc+2r8Kd5mmLAzLZMFGul+qDjUK24h4rRqzHELApvu5DwkkoVRYJ+wKIa6
         p65kNwuH/jmisgIpMIxmbMsN2POF4/By5PlerFNIwOUqLfQIMc++/tEGhIUI0ZhnnOdI
         FmeJMD01RsgDs4Lse438HwfHim49wj0F3JbKaNuckFA/jmzfbsAii9hAcR/yK+Jkp3kc
         hGrmV8aO9kjbhGrj0pJ2ZdmVnnAtw8d1Qeg0NnQPUc4J+7CFx6g1Xg12mmxsSq1QycAO
         plESCvVHfkD8Je8DF4QXd1qO5w2+8lGDvdMxhXqYbeud+kg4xfXVi4DGjnioIxhq2NYc
         0tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570827; x=1747175627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ztsAI3tt7LcUXIIXknbAsi0ywBlmlwHCJZfAYlrtiA=;
        b=vNdRXD598ve4/JKNMYVf6vW7QBQPlUmRTkdwr4yQGaXQMapAey7aF2rIqQHuYMOhRZ
         MfDHnXcczClRr9+luWsUy3N/3eI++XPHHHZiThklRPS/1XooW0v8L2SA0QxNVRFxIWD/
         krlo9kSAKHta7CtnHTPjpTwTp3NhApzkv1quHLylBDz1uPZkMGRlE0tMt3UWdhnhPH+O
         QEZ0eu6ryuvAoJxoKq25FNlIfmt5pXVMSQ7NLq4lVKQs6M7OkkxdAQjPZt+eEwGpNYgT
         fPKOcNaLrWT4VP4fXlqwehAsf6v8xtjzlE/qAJWvGtqNCJXgiJ0+EIAPzFjtlinVn64K
         Wy3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsED64PUU8Z/IskAn7+VWkJEYfvYsSaUEKRTMjpzeGTU0iEeDqP4GTrpn3mnJgZxsTfNw=@vger.kernel.org, AJvYcCWes7R+1gAnrPIdFcTFeLmoInlPoOBa9V0uukDHB21E4VvQT2PGAtUkZ+gVqBihCFmYDghhr8p8uZ2uu+JO+vuS3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0qf7sqxN5C+DhyW4x+38i3pGZVrzjZ4e7HuH54UesrrnWtR9K
	6a7ZFKYtQXV+vLVz+vGbXfuRu0amQR2ECd4osdoNLC56GSsxptnlA3jMX4eIRDSqGBzlbTCvD0i
	Va0ECf/+yDXVvkRVZtVWgyf3YkJk=
X-Gm-Gg: ASbGnctLSGMcsi8mpa0BHDBI04kdUEZlF1Pz0id8TLzBzoovxpOWLDI42rpCm+yWKDc
	qDJs4VRvqSmZP6nP3/rqMbJ9CPRwU/MQioH2ptLrvPnm+4TeOkB8Qza8o5FUPiBY5W7xZfArwCw
	MUrqwL/v1f26Ebg4ctpV5Td9BTdBiAuVGqyDm+CQ==
X-Google-Smtp-Source: AGHT+IH46l0FIeRyH+MYoGlRN88I3II5+z0dX/Rr+XfLGINfG5d0VJB+T10DQzUXa2KL886Fv1+jNhJ2jPh+00VDvRM=
X-Received: by 2002:a17:90b:2d06:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-30aac160befmr1731900a91.4.1746570827116; Tue, 06 May 2025
 15:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506135727.3977467-1-jolsa@kernel.org> <20250506135727.3977467-4-jolsa@kernel.org>
In-Reply-To: <20250506135727.3977467-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 15:33:33 -0700
X-Gm-Features: ATxdqUFQxJiSboYf4ST_YuQwx0r_j09hJFyA_TWeI3gHv8AFDz7xUUpR7RHhtn0
Message-ID: <CAEf4Bzbpn8kQV8ORoBv7iDR1VxT0uUf=qqjanFQFtFx1fSjrQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe
 link info
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 6:58=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to display ref_ctr_offset in link output, like:
>
>   # bpftool link
>   ...
>   42: perf_event  prog 174
>           uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_offs=
et 50500538

let's use hex for ref_ctr_offset?

and also, why do we have bpf_cookie and cookie emitted? Are they different?

>           bpf_cookie 3735928559
>           pids test_progs(1820)
>
>   # bpftool link -j | jq
>   [
>     ...
>     {
>       "id": 42,
>        ...
>       "ref_ctr_offset": 50500538,
>     }
>   ]
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 52fd2c9fac56..b09aae3a191e 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -380,6 +380,7 @@ show_perf_event_uprobe_json(struct bpf_link_info *inf=
o, json_writer_t *wtr)
>                            u64_to_ptr(info->perf_event.uprobe.file_name))=
;
>         jsonw_uint_field(wtr, "offset", info->perf_event.uprobe.offset);
>         jsonw_uint_field(wtr, "cookie", info->perf_event.uprobe.cookie);
> +       jsonw_uint_field(wtr, "ref_ctr_offset", info->perf_event.uprobe.r=
ef_ctr_offset);
>  }
>
>  static void
> @@ -823,6 +824,8 @@ static void show_perf_event_uprobe_plain(struct bpf_l=
ink_info *info)
>         printf("%s+%#x  ", buf, info->perf_event.uprobe.offset);
>         if (info->perf_event.uprobe.cookie)
>                 printf("cookie %llu  ", info->perf_event.uprobe.cookie);
> +       if (info->perf_event.uprobe.ref_ctr_offset)
> +               printf("ref_ctr_offset %llu  ", info->perf_event.uprobe.r=
ef_ctr_offset);
>  }
>
>  static void show_perf_event_tracepoint_plain(struct bpf_link_info *info)
> --
> 2.49.0
>

