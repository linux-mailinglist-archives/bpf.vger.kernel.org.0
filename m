Return-Path: <bpf+bounces-33699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A54924B99
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA5D1C223D0
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8D6A342;
	Tue,  2 Jul 2024 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F71dG9aq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0F1DA331
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959422; cv=none; b=B5GsJfQSscb2Dp4a2JLKSW3Dguzx/iKNQmXF/Q0FpP7M9hH9qzMNe+t8u+1J5y4XMqaddeuiObnmek2x6NIkvxRNesA3pRJMXykA9PWZ559nnW2q7eSEbDmqqFPGbU1AKW3YhkfIPNWV+Aqy1yooNnXhVorrpUdlnSxKu2ty68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959422; c=relaxed/simple;
	bh=kpGTrLi97C+l2Znd8MRT+DXRMyE3ASREyrbCXjxtL8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCtTJUvCHBCfapASRrtr3ZNK+2lk4oerwf/FbN0EE/Zp2PP8ukPIgsEQSvD9HklU6OcDUyrzvLjsdzbBv3Pqp101zJDVuZrFSubijGLfiCvByTvzg36+5510LHrm4qlY8ZcrGGApqGaer4APl54YPnGMx2K0ROpTlyvlPKU9pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F71dG9aq; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b9776123a3so1970700eaf.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719959420; x=1720564220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3UJfKp7PWRLZr59p9HCS3UvCkWM+FJElxiF32htHvk=;
        b=F71dG9aqu4b3tNPaYJ8UV5yYUvLR3u4a9ZHJuzh+R8f7xXlVCl6FZvr1Z7bFNNoDWM
         XEI7sJDFD403n/KCxSjzIeG4ueNDKS9uYIWKBLh2lxJZeRE0T9Jdg5wadVAz44HjWVqX
         BsAokFXZIUfHedvltZqwCkDuAHtc5435wk/9Ah7uD+dkLw6iUXCn0uHRvz2hYzTxuog+
         v6ET20n3enJ0jnfOU8jsWepflftivxr1PkDhT9N5ebP97r75acQSsVMLXMXMt6tzDM5w
         4L45/7+PSgjCxJK8KxdjxwzJUaycFsfFCcmq+sbBfGmRHq2TO4eRbSAyoOYIdEGawRf7
         H3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719959420; x=1720564220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3UJfKp7PWRLZr59p9HCS3UvCkWM+FJElxiF32htHvk=;
        b=mx9T26AVfoWBABebqU8QqRz6h1w/5TFMJGd62YH0pPKuFwioZ8kVeQT5MCaKoeCgmm
         olZ5H65tMUggotfC+HBYgaD3DJeDDW8oDXge5iKDkHAlWB0VTU/gE6FIzQ3lKjiLKI9s
         cqedIi/3T3Pv3N3GUEnNocLcsUVTZPalSyo8P86j5DYpX4+KeeAIDvVx8azJAdc/j4fd
         x/s7YslleW54MOR8cqtcyLiCbex/rl97KgUfgm5dZJINsbs5oiCxgLvGuDVDs22u0CZr
         lxm6VwUcAOEvjeyD3bQszMeF+pN9xwF2SXV87xTDXd2nK0xUHRoxFF3ifbL1JwhZUukR
         j2pw==
X-Gm-Message-State: AOJu0YzEGcb+RtEf/5/WHyGf5RXqjKrDESr6x51NAz4q88+cMbuWm1Kf
	6nDlaXnSHhd56CEBQ4KolytC9ecQ506Ty93Pv5r8hSGTU8AHGfCHPeGGmYZ7Jj0FZ1NL8nr9ocu
	9+r7OXV7d/3Tc2dK6KODVmm6YVsnPMc62
X-Google-Smtp-Source: AGHT+IG5GuGUU0ttb6Dfgj7/h8ZT/RqjZlf8Sq3moxMWmxnaRT85Ci0YBeVT6dLIMPcC1jIGapqjFAoEkPkVtGj6VI4=
X-Received: by 2002:a05:6870:f151:b0:259:8cb3:db2e with SMTP id
 586e51a60fabf-25db35c0315mr9166431fac.39.1719959419685; Tue, 02 Jul 2024
 15:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702142542.179753-1-bigeasy@linutronix.de> <20240702142542.179753-3-bigeasy@linutronix.de>
In-Reply-To: <20240702142542.179753-3-bigeasy@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 15:30:07 -0700
Message-ID: <CAEf4Bza5snU5rxVjug+i7q_L-Oher94c6KZmWA9oVnFKmALFzA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Move a few bpf_func_proto declarations.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:25=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> sparse complains about missing declarations and a few of them are in
> another .c file. One has no other declaration because it is used localy
> and marked weak because it might be defined in another .c file.
>
> Move the declarations from bpf_trace.c to a common place and add one for
> bpf_sk_storage_get_cg_sock_proto.
>
> After this change there are only a few missing declartions within the
> __bpf_kfunc_start_defs() block which explictlty disables this kind of
> warning for the compiler. I am not aware of something similar for sparse
> so I guess are stuck with them unless we add them.
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/bpf.h      | 5 +++++
>  kernel/trace/bpf_trace.c | 4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f5c6bc9093a6b..d411bf52910cc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -840,6 +840,11 @@ struct bpf_func_proto {
>         bool (*allowed)(const struct bpf_prog *prog);
>  };
>
> +extern const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto;
> +extern const struct bpf_func_proto bpf_skb_output_proto;
> +extern const struct bpf_func_proto bpf_xdp_output_proto;
> +extern const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto;
> +

There is a whole block of extern const declarations for bpf_*_proto
functions, let's keep them together?

pw-bot: cr


>  /* bpf_context is intentionally undefined structure. Pointer to bpf_cont=
ext is
>   * the first argument to eBPF programs.
>   * For socket filters: 'struct bpf_context *' =3D=3D 'struct sk_buff *'
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d1daeab1bbc14..d8d7ee6b06a6f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1951,10 +1951,6 @@ static const struct bpf_func_proto bpf_perf_event_=
output_proto_raw_tp =3D {
>         .arg5_type      =3D ARG_CONST_SIZE_OR_ZERO,
>  };
>
> -extern const struct bpf_func_proto bpf_skb_output_proto;
> -extern const struct bpf_func_proto bpf_xdp_output_proto;
> -extern const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto;
> -
>  BPF_CALL_3(bpf_get_stackid_raw_tp, struct bpf_raw_tracepoint_args *, arg=
s,
>            struct bpf_map *, map, u64, flags)
>  {
> --
> 2.45.2
>

