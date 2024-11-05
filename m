Return-Path: <bpf+bounces-44055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C29BD2A2
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA1B22208
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D001DD0FC;
	Tue,  5 Nov 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6qUg2cy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D71DA2F1
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824753; cv=none; b=Xfu6EnyT1frSlpLTXvOMraO1ZFHZEKdfx9VKYuanKC3j0imx3Oha6YhsLdqWDqpY2OI9RsxyTl+4fgZC9WCAXYMsqw6HR6QpnNDajyU06M6ckUGXYOpRLltHaQs7tOPULiPbnU2e/CshzCHbN0FfYyPQqgJUuVLPOAyjZnE4aXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824753; c=relaxed/simple;
	bh=s3tb9sqZhSIMYWSrs9vmYMXa6KpOubWZiuvObudUnTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7sWYyC4+zio2+ykTANOjKBS9EtKRaMx/bq817gN1DaSPhqEVUorh3F9Tdl3ozAGxUzwnGvuaapcDuQgjRPpY/D9GcjOU86CIrCn2jbSvmFzmUZwA1L8iwQmUwZrjEE5O1zqsjZ7wUjkbmUbM2B2bySTELqswfDpivt+j3zMpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6qUg2cy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315baec69eso50259775e9.2
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 08:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730824750; x=1731429550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OFls2hBJQB6nX3PhExYAZ9dVdfiVwuqkQe4PP1lXiQ=;
        b=d6qUg2cyH1QmEQk/AAiudcbf1RVKQ2m2M2fk68KRRaFke7ayVoclKOMjbLjCHYqvRY
         wTSQ6asdV8pmkf1++3voqTT30DxlWXRL2IjqEhLxc0dltOS/ImDDyuW7oBfYDJcfqDeF
         8MGFEfLtJazAzH2/vRIZ8ZXGoFD5YUOqP9LCI3b21byr0+s56EWGiO444Lf9EXmU61uC
         ZziAvU7ERcI9/mrmTnQOI1ewqA6ieygarhdjq7AnLThnTHQYwiKdSv9X7GwZ7mrqqEEn
         TcfwS7oCp6clhp6BjIKkUkWEKeFgJ8dcfGP7qf4TYT8SkY8469L1KZk5Y9Op5H08EoAz
         MZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730824750; x=1731429550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OFls2hBJQB6nX3PhExYAZ9dVdfiVwuqkQe4PP1lXiQ=;
        b=kMsy/C0GC/LM+TcLzmc7tBRmiFJv11K3F5ccxfuht8dJZsPu3Kb2BL5AJ7Wvq4Jffv
         lG9Vvyx/dQFzF/9TcWF51yaiR9rlrLT7w3asDBy7+BKY2VGqgT/qaQKUbjjzvNfBVzJg
         xncql0sxN2KLWMlPFDwhyGzX0VMErNsgEMVqRZbZJj6tf6bSvQz31CuNigjFhjQJjVVy
         v/4hGNPhKaWJmG9xImdRPz57mK3jKV+H5RUW2xopK6JUPa8wjVuGpSGWk3aB+oGN621a
         Eow4nFq/iNOePqb3zrIQeN6pA4DjsPnvokPM8FrYSnpNWmRc9xdQFRoVQTWgsgj6EMAv
         z5IQ==
X-Gm-Message-State: AOJu0YxotNAQV+XgWAfTQjZXgGGQxIFaNsKMo6iR9gX1pI4DEnWA7q2G
	yEdzflxPsvQcBZVE7ehu62lJaxauSmpBTMDwCIu6RDM3seaDyhTCz/komd0o2aAkmQQPMJ6UYaT
	9W/2+duFm84s53UlcbTXcAeU4J6Q=
X-Google-Smtp-Source: AGHT+IF4b3QUry/nRplqM3f5BuXuHN+oWTLplljAdHL6I8rAzof/r7D1YBk8+7NdNwW8LogyPBsmC8Mv60D8SMaall4=
X-Received: by 2002:a05:600c:3054:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-4328327ec3cmr121698615e9.23.1730824749921; Tue, 05 Nov 2024
 08:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev> <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
 <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev> <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
 <6c78f973-341e-4260-aed4-a5cb8e873acc@linux.dev> <29e2658c-02c9-4ef1-a633-ee5017e72bc3@linux.dev>
 <CAADnVQL54BFUpzAWx-4B6_UFyHp4O88=+x8zeWJupiyjNarRfg@mail.gmail.com>
 <97ea8f52-96c3-4109-92b7-cf2631a34e2d@linux.dev> <CAADnVQK-AXqxEhDwWK=RKx-dA0PZ=N1j6vSshBWS4bGNfv=a7g@mail.gmail.com>
 <43dc0d7d-ca6e-4ba1-a831-e2a1e43f6311@linux.dev>
In-Reply-To: <43dc0d7d-ca6e-4ba1-a831-e2a1e43f6311@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Nov 2024 08:38:58 -0800
Message-ID: <CAADnVQJpm2JreS2peqcEZ07FvY5jb+t2xPjpZm4N1UE3_hjxTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:33=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
>
> On 11/5/24 7:50 AM, Alexei Starovoitov wrote:
> > On Mon, Nov 4, 2024 at 10:02=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>> I also don't understand the point of this patch 2.
> >>> The patch 3 can still do:
> >>>
> >>> + switch (prog->type) {
> >>> + case BPF_PROG_TYPE_KPROBE:
> >>> + case BPF_PROG_TYPE_TRACEPOINT:
> >>> + case BPF_PROG_TYPE_PERF_EVENT:
> >>> + case BPF_PROG_TYPE_RAW_TRACEPOINT:
> >>> +   return PRIV_STACK_ADAPTIVE;
> >>> + default:
> >>> +   break;
> >>> + }
> >>> +
> >>> + if (!bpf_prog_check_recur(prog))
> >>> +   return NO_PRIV_STACK;
> >>>
> >>> which would mean that iter, lsm, struct_ops will not be allowed
> >>> to use priv stack.
> >> One example is e.g. a TC prog. Since bpf_prog_check_recur(prog)
> >> will return true (means supporting recursion), and private stack
> >> does not really support TC prog, the logic will become more
> >> complicated.
> >>
> >> I am totally okay with removing patch 2 and go back to my
> >> previous approach to explicitly list prog types supporting
> >> private stack.
> > The point of reusing bpf_prog_check_recur() is that we don't
> > need to duplicate the logic.
> > We can still do something like:
> > switch (prog->type) {
> >   case BPF_PROG_TYPE_KPROBE:
> >   case BPF_PROG_TYPE_TRACEPOINT:
> >   case BPF_PROG_TYPE_PERF_EVENT:
> >   case BPF_PROG_TYPE_RAW_TRACEPOINT:
> >      return PRIV_STACK_ADAPTIVE;
> >   case BPF_PROG_TYPE_TRACING:
> >   case BPF_PROG_TYPE_LSM:
> >   case BPF_PROG_TYPE_STRUCT_OPS:
> >      if (bpf_prog_check_recur())
> >        return PRIV_STACK_ADAPTIVE;
> >      /* fallthrough */
> >    default:
> >      return NO_PRIV_STACK;
> > }
>
> Right. Listing trampoline related prog types explicitly
> and using bpf_prog_check_recur() will be safe.
>
> One thing is for BPF_PROG_TYPE_STRUCT_OPS, PRIV_STACK_ALWAYS
> will be returned. I will make adjustment like
>
> switch (prog->type) {
>   case BPF_PROG_TYPE_KPROBE:
>   case BPF_PROG_TYPE_TRACEPOINT:
>   case BPF_PROG_TYPE_PERF_EVENT:
>   case BPF_PROG_TYPE_RAW_TRACEPOINT:
>      return PRIV_STACK_ADAPTIVE;
>   case BPF_PROG_TYPE_TRACING:
>   case BPF_PROG_TYPE_LSM:
>   case BPF_PROG_TYPE_STRUCT_OPS:
>      if (bpf_prog_check_recur()) {
>        if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
>            return PRIV_STACK_ALWAYS;

hmm. definitely not unconditionally.
Only when explicitly requested in callback.

Something like this:
   case BPF_PROG_TYPE_TRACING:
   case BPF_PROG_TYPE_LSM:
      if (bpf_prog_check_recur())
         return PRIV_STACK_ADAPTIVE;
   case BPF_PROG_TYPE_STRUCT_OPS:
      if (prog->aux->priv_stack_requested)
         return PRIV_STACK_ALWAYS;
   default:
      return NO_PRIV_STACK;

and then we also change bpf_prog_check_recur()
 to return true when prog->aux->priv_stack_requested

