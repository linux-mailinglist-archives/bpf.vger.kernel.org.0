Return-Path: <bpf+bounces-67200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8FB40A4F
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A363AE92D
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441D337687;
	Tue,  2 Sep 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLINJj2C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CF3314CC;
	Tue,  2 Sep 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829614; cv=none; b=blM53Tl8Cb/FRBFr/rrIgNf9vAEuv4TpA2ALzml4nDhzDGRN+hY7d2LzOKkOx6CUsrFD2HxLzAhgmj2DcmcnYx16JMPX80YuxoXA75ziwADcYZI2xdHXrcuFCdieSmsXAh4FQW5MS7ZHRjEYvMKOTE3QfnH4XvikOg4pSRFOE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829614; c=relaxed/simple;
	bh=S0zosQa4/NMvz1DLetHiXkl5TQA1iR3ntwhDWgrYnKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQdkqr4ICDONRM1xzTdxmZwaPgqkuep+ojPd4q6pDh9vANx2j7N04REs7cqRqCwUHMqjyEvqnd6hH6C/pnxr2/tmPynzi9JoH3thBd5IoOGvZ2sUcsFZGYtf+Co4n0C+/TrAchLabthhs0i7Ag1G4c1DEtojiVWYkeybXorNGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLINJj2C; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b042cc3953cso286592766b.2;
        Tue, 02 Sep 2025 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756829610; x=1757434410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Joapr1Aa7FenfR5+N/FmjIKBMs7dVHM+J40TQ44Yp9o=;
        b=PLINJj2C/bBg2wV+RqxqoL8B9y4agODqzcJ3ex00Fb6qmVP5xe8rRsvJX+xViv29Z8
         zMUD8CUQnXC1H861YoE87/l+Q1Js8OFqhQE83S/Kfravru70JFat1Ey6vd9AsiH22BbO
         VbyCs2N9abOHKczwAPP9H1LDYu0+y2TbgO6X9aIQPiFnHyilD8QF+RkrCA5vee40slPo
         k4oiAvPSoQSFOJogZkGVTakCwzBgx4SQb+yyN5GdI/Z+O39cEozRxY+NdXWNxfC3ZkXq
         ov4sJ3Tpkt7LCF65T/smLkj46xVEx2zfmVuGhJ7Vwfe9CdSUQD7Vtd091YurCXsKH/vq
         wEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829610; x=1757434410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Joapr1Aa7FenfR5+N/FmjIKBMs7dVHM+J40TQ44Yp9o=;
        b=klrdjFm04MAHWugv82CLSLhi2aZn294JJyc3vdiZI3gLd87ysEhMouVZQgG2Wd6G1T
         cGGX2u8I3bUtQOpg6vDEsc1ic58qKUMV1uyP2lmgB5kUZMXYBgyidaF6F8ZblDCKIB/P
         R+fmGX9Ku4glGZz5NTZ9CHmK6EcDptE7bagCVxMcc4XciGqYrCMQcp+QhLZsHa2VeDEu
         LB6k3rYksjvALkFNy+9RlPsfMmMEvn3obgDi19AxBj6+1Q1MgJN+AizYyloBsaQlv/MU
         GfgkbyK6EO2DjaGUItWGxbgfI/HxsL5eH61SPt9VrmK5qiMGl1KE5DXLXPeC20dDzkYO
         O7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYPGFMuaNVVONyN+uwtHp/S50k71HGoh1/+ROahxpo/6bYFQU1cfrL+C36jjP6Qll19/zyqo5Xvt1jTdw9@vger.kernel.org, AJvYcCV5e3/L+hKBi5FwnVu1ln8R7ljiCA3q4asI9tPF+ebd5jyYpbzgErdoOxDu35cef/yb2U8=@vger.kernel.org, AJvYcCVMcAM4pOjUe0CeViikiBdbADtRDATLRpNmunvAsSXYMsfGPNYcKIst9JwZ1Ca2n5wDoRPcl92wUXCPvdbqWL7T+NxA@vger.kernel.org
X-Gm-Message-State: AOJu0YwtzkkIiiV4C3ZaozoJQfoY5sGhCMksw0zosCcgWDNuMF88EoF1
	48PAvwUdPzchhuipOTvaMubkUUQC77kYkvSSfZ2KPETaA4iiWmo6Qr35ZYNwmEZcTTcBo3ODrlK
	6x8rhgPNe7vFnDDOHO4Lgj3ulpnX9ypE=
X-Gm-Gg: ASbGncuB9F/6LYYFvzRXirxWAAUfHuPvRCq6mYgw8warpjgEAOll/NbdD6xDOLMwJgE
	D26zi4ypZ631PD7FG045mMCFqz/kvUjUJtmoCEPyCwSLXtTV9Qf3Q9uQpEmyf4A1wyYmYNjMT82
	rD9qo3eiM9HNzRKVh4VylC2quUTtDZklM6kDXu8CkFvrvfntwSsjgKsNV7qnlGkvD6p6DgvWxuw
	2TRyCuWTWtZaQlrSuTNnFCbAfPqHqYzHw==
X-Google-Smtp-Source: AGHT+IG0Q9/53SZqmp+IL8CEeUBkWC3hE+oCwZO+XihOLd3cjRr1Kwcl8wYw3RC0m9f+j8qEQJGoJ4FDVma1j+eJtaM=
X-Received: by 2002:a17:907:1ca4:b0:aec:65d1:cc30 with SMTP id
 a640c23a62f3a-b01d979f4b3mr1168438866b.44.1756829609734; Tue, 02 Sep 2025
 09:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902143504.1224726-1-jolsa@kernel.org> <20250902143504.1224726-4-jolsa@kernel.org>
In-Reply-To: <20250902143504.1224726-4-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Sep 2025 09:13:17 -0700
X-Gm-Features: Ac12FXwAAZRxCYlJ8lLv2WZML2TqdAs_HcXd5Q6Bmrvfk9PRDvm8wFFtE-N0LoM
Message-ID: <CAADnVQLw3xcBcxRhjBeiPikfnnr+Cox1wJ_6AcSUqaduuHs02g@mail.gmail.com>
Subject: Re: [PATCH perf/core 03/11] perf: Add support to attach standard
 unique uprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach unique probe through perf uprobe pmu.
>
> Adding new 'unique' format attribute that allows to pass the
> request to create unique uprobe the uprobe consumer.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/trace_events.h    | 2 +-
>  kernel/events/core.c            | 8 ++++++--
>  kernel/trace/trace_event_perf.c | 4 ++--
>  kernel/trace/trace_probe.h      | 2 +-
>  kernel/trace/trace_uprobe.c     | 9 +++++----
>  5 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 04307a19cde3..1d35727fda27 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -877,7 +877,7 @@ extern int bpf_get_kprobe_info(const struct perf_even=
t *event,
>  #endif
>  #ifdef CONFIG_UPROBE_EVENTS
>  extern int  perf_uprobe_init(struct perf_event *event,
> -                            unsigned long ref_ctr_offset, bool is_retpro=
be);
> +                            unsigned long ref_ctr_offset, bool is_retpro=
be, bool is_unique);

In bpf land we don't allow multiple bool arguments any more.
It makes callsites hard to read/review/maintain.
Here I recommend to use enum flags as well.

