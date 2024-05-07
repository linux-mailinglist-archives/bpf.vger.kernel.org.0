Return-Path: <bpf+bounces-28748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1668BD8A1
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A461F248BB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F53D65C;
	Tue,  7 May 2024 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfj0lzen"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51828F1;
	Tue,  7 May 2024 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715041613; cv=none; b=LJVGWh44ztqGOH6MjxgZt+wKQHwOM9yZYYAaVsttCfBgl1PtGSQx+DoLfubRsU7Art7JurMwKgimMUlRBJ8/zFz0ZI0L3KnCIAC/QTN/eTzNnnRDilFMr78SQtpjKbY2Xys0GozuDYJaUiy2MibeJiKRWCBWL5wEngd29qt63S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715041613; c=relaxed/simple;
	bh=4NauqpMm0tV7vKEFnZFk1JYhRBUi68Bv+sS/I2VSX58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hd/SHZcXQFYHIrID8sZC4q7PmdgB8vuV+w6nY5BmZPfSkXtxmN8jCzu4790ZvlkOGQ7n95dqMo8FLab9QEDGJJCLrPtyI0Hp2Db7qVFuBQ3xvZtAY/8ZJGVl0D/7yZOpgMVxhOWiO2Qs8wwwNU5RVy/znxyFydgfZCU47h26FTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cfj0lzen; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b79450f78so17151665e9.2;
        Mon, 06 May 2024 17:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715041610; x=1715646410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vmtqOjRdDWAeYSRYS6X1pfJX7nQFvEEJNEhNJnhAZM=;
        b=Cfj0lzenSqmNM59YRPZ0FJqN9Iw/a+RK9SY70TXXlymuVk9gbOQThFuixEPxWrr52S
         Tg/NEfjx77P5yCBFjTFFy/hYg8UVakJ5MiPh62Zq0sGArjLnRVCTMyxOYwWhsxsynCZ/
         XmQoPjsB5aaKsH1iUjf7XK/EnBTmjzN7uNN3wgh5uwjIc/ENpdLhowHFS6mnWaaK3JXa
         NSfEBXE9QJ1lQddxC2XnlGrRJ2SUp6qUuDVqEztkNGD/w7R1YINx4mEdxeTggsgaTG2o
         IzJrWkDXBXiDeBApi0bD3XXO9TJqx3m9UaCZsVrLnPDqaNYJ5nsiDF+eUN3Jm4t9Eox6
         rVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715041610; x=1715646410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vmtqOjRdDWAeYSRYS6X1pfJX7nQFvEEJNEhNJnhAZM=;
        b=UcuDnuvfm65/JxtRlSDLx31Q784iobThykrrrG/EBeKTuY96bkvlv8UVa40dUD+jIK
         vMhso5zE8hV5mOpR/xkEBTeYKi4ptRH76/+uaizcY6GrgFStEBbnpij8pTQjOCVRcX4P
         GmBYpngfu5JawQU20akG8ZxZC2GVC/YTIvc4g+6+P7TlbvTyujrrqL7JF2JemLGyTWj3
         DLc2FiwI7vcsIH12Z5k7mfAhOdmeXXNHFJMyXtduaR+7I4l9VDmDFjA8+ij4R1qiWGue
         8lhbqxnlOpWzUIMveDmnN262y5HZHzyU403Rfnht+K6A1REVGNDmw2o3ER8pfAAKB7Xy
         wdxg==
X-Forwarded-Encrypted: i=1; AJvYcCUySgI0aKaeWRdccClEixayn2EjtPR2CmX1Xg3KSBue0W6UMCtwwQFW3m+OGnrspSE2onEZ4f6DcEfmPkCce1jfDpoY8r2DpBkYOwvVppFWgK7iJL8w1MRBBLvn7r65xK6/
X-Gm-Message-State: AOJu0Yz/1iWiJ2pmc97uGgsiMrHLI2Y8peTemlvss5RatHC84ief2qbJ
	ZcFb7w/HyMpFemUP2gtSQwgXjWvLlbgvU/cMj0gf/47HOmmJztbqgKG8eAU8eG7jeZPSdDOTvQa
	ezjDFk5HVx7YAxbOruFwJjci7F+I=
X-Google-Smtp-Source: AGHT+IFQl0DZ/aiTAcdC6+dFd235npS3zZj+l5AobTAP+71QlNqWcv8dEDL+5B0bUKo8hj8sVOyFmOkG/I+CpWO9Ew8=
X-Received: by 2002:a05:6000:1379:b0:34a:7a97:caa1 with SMTP id
 q25-20020a056000137900b0034a7a97caa1mr11885263wrz.2.1715041609631; Mon, 06
 May 2024 17:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net> <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
 <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
 <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com> <mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx>
In-Reply-To: <mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 May 2024 17:26:38 -0700
Message-ID: <CAADnVQLJ=nxp3bZYYMJd0yrUtMNx2DcvYXXmbGKBQAiG85kSLQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 3:03=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
>
> Right now, what I am doing is (in simplified pseudo code):
> - in a bpf program, the user calls hid_bpf_attach_prog(hid_device, progra=
m_fd)
>   where program fd is a tracing program on a never executed function
>   but this allows to know the type of program to run
> - the kernel stores that program into a dedicated prog array bpf_map
>   pre-loaded at boot time
> - when a event comes in, the kernel walks through the list of attached
>   programs, calls __hid_bpf_tail_call() and there is a tracing program
>   attached to it that just do the bpf_tail_call.
>
> This works and is simple enough from the user point of view, but is
> rather inefficient and clunky from the kernel point of view IMO.
>
> The freplace mechnism would definitely work if I had a tracing-like
> function to call, where I need to run the program any time the function
> gets called. But given that I want per-device filtering, I'm not sure
> how I could make this work. But given that I need to enable or not the
> bpf_program, I'm not sure how I could make it work from the kernel point
> of view.
>
> I tried using a simple bpf_prog_run() (which is exactly what I need in
> the end) but I couldn't really convince the bpf verifier that the
> provided context is a struct hid_bpf_ctx kernel pointer, and it felt not
> quite right.
>
> So after seeing how the bpf_wq worked internally, and how simple it is
> now to call a bpf program from the kernel as a simple function call, I
> played around with allowing kfunc to declare async callback functions.
>
> I have a working prototype (probably not fully functional for all of the
> cases), but I would like to know if you think it would be interesting to
> have 3 new suffixes:
> - "__async" for declaring an static bpf program that can be stored in
>   the kernel and which would be non sleepable
> - "__s_async" same as before, but for sleepable operations
> - "__aux" (or "__prog_aux") for that extra parameter to
>   bpf_wq_set_callback_impl() which contains the struct bpf_prog*.

Sorry for the delay. I've been traveling.

I don't quite understand how these suffixes will work.
You mean arguments of kfuncs to tell kfunc that an argument
is a pointer to async callback?
Sort-of generalization of is_async_callback_calling_kfunc() ?
I cannot connect the dots.

Feels dangerous to open up bpf prog calling to arbitrary kfuncs.
wq/timer/others are calling progs with:
        callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0)=
;
I feel we'll struggle to code review kfuncs that do such things.
Plus all prog life time management concerns.
wq/timer do careful bpf_prog_put/get dance.

> (I still don't have the __aux yet FWIW)
>
> The way I'm doing it is looking at the btf information to fetch the
> signature of the parameters of the callback, this way we can declare any
> callback without having to teach the verifier of is arguments (5 max).
>
> Is this something you would be comfortable with or is there a simpler
> mechanism already in place to call the bpf programs from the kernel
> without the ctx limitations?

"ctx limitations" you mean 5 args?
Have you looked at struct_ops ?
It can have any number of args.
Maybe declare struct_ops in hid and let user space provide struct_ops progs=
?

> I can also easily switch the bpf_wq specific cases in the verifier with
> those suffixes. There are still one or two wq specifics I haven't
> implemented through __s_async, but that would still makes things more
> generic.
>
> Cheers,
> Benjamin

