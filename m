Return-Path: <bpf+bounces-63343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25422B064F7
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2097D1AA686D
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1C5283121;
	Tue, 15 Jul 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUubxZDj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2027F183;
	Tue, 15 Jul 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599481; cv=none; b=HT4GQ0Vk81CF5PvSo0ExLYeR9RN+sxF8RQMPecvQZKM0+WLl8zQfYT5VIC1STwm1+Y0NvsvfngJqoJJK1qFZb5WgFY4cHKtoasnJYpWfyNVb9m5DloQlTBFv0Bsn1ACFF6X8NKmWjeT2bEMPHw3xU1uYgjlYbhH53FH32pMMpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599481; c=relaxed/simple;
	bh=tvZfyQ6Zm9YIdnxn/SThtCkqoA8UMOwHp4XiedauBNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj2Q/e5+csVCZPbj6q21G+Eq0Ldynzki6+jUuXqrJdqRM6WqdsECvGxXTK+byrXnaF7utpFI3X3aRc5lmMpB+E/o7Blx0NCqUxAW/YrVpjV/8zWN9W6US4NNpAfgHihEatkx91+EoLATSc5Gk6ujT3QzdoDvMHT+2TFtAWR8HoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUubxZDj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso5475993a91.3;
        Tue, 15 Jul 2025 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752599479; x=1753204279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xnnp0yw3tcyi84cFpHFeBILffvQYrdmJjcVjZf3ai7E=;
        b=QUubxZDjMT3RLeVvDoODU7uudMyVC5uFDaxbd6ot0Tj6oY3Vlj2WfdM5V67q5ku0fb
         y13jtsEcRyl0xTBBCVETn+ucsgqSifjoz+pxIPa2iUtaNuFpa7EnzXyGRRVCK2s3BM5p
         sVcKHGdtUIbXqpm2ylqpWlPV2k2F3632JBInXSAzddQU56ruo5qWBhq9bvIA2zv6O+V3
         2bjeT7Es9KnV3d6cMYdzxlerUY0EJupVvIL4dQYh5Qk+rmURVOvj3b4eEbXdPG01/pjN
         7Qyu9ilKypAMdp8is/sM7qtkXT2cyTpS+7GaNnd9i4PvcZFF4AkQwhSiCBzmS9UWWWCp
         x59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599479; x=1753204279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xnnp0yw3tcyi84cFpHFeBILffvQYrdmJjcVjZf3ai7E=;
        b=WV9n99MLbJmaetsn6N5Pee74rsvsQGNEYUZ1Y30sM9lfgmka7CNVdg2xPo1bDVnzvM
         Lqei624wFLhHPAjUU5Lc/PzZ3ZBiRU7Sq5eITZOieWhSKLRxJwcWQuPa/sVGspk8Zehk
         g4rxLgzND1UR7xR0QCuopkulgiTzyIXI/1Qpzdc7N+OnJYiuT1oedovB8X1M9B+1xqLf
         tl9z2T4YTW/eaRPwbZl6Ef6Z7QnnxbWF4nb8uM2aazo2c44dN7Pa8HnmZhGZjT3yqNmS
         2+N/bQA9Sc1SXoxeyOnICwdRksXyiAjHr1J0MlO1BJ36iRetsrUTczO0+/wsxUtdaexb
         T53w==
X-Forwarded-Encrypted: i=1; AJvYcCUdI4qo3EBDFhV2cqqYzCH9yu9U+GhK67LnAMnytX4UMfF4A2IZuvZ3GkEd0SIlHRSIZMc=@vger.kernel.org, AJvYcCVW7ytY/kLJaGtDeYBeFq79J2mgtWefdmn0lVNn+2u6woXM73y+Mmv+ExdprX/qU1smB/Uv/afVfwkBwCWr@vger.kernel.org, AJvYcCWOSE38tfnqrfDAMVPqh6jlAK7kxvqitAaFPsKzxDM7UeNDQqEV14YHfwIibY5ObcInx73jVtIm@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuzUKaxbLESuL7IP61Ed5FKn9psvA9ZQEG70WRj1TbM/xS4DC
	1JiYTlvz855yASERnFRmKG3nzX1KoU9nCFZ3gIRZ7GXYcm+HmyVECgVm0zrBCqh8uzTK/AeYBjh
	rOysQjIolIlq180CnWaF4FA/JF521LUo=
X-Gm-Gg: ASbGnctooMhv0tAwQOHfa2hjV3omtQQOwL9seN1JMe3IoBwdJDdSzo1eupjA8J8DaIS
	mW5wVzcokXCH8YtZs9NagnSqX3U+b+0NvCgaMo8LedI53R7WewzwKPE67/6JHRNUZiM0nehhsWl
	LgIyiydcvqeO5tlzXur5Ko8PngzSkgoYoEoUTtEIqFGS2pOjHPiJs8lM9rcW5+WkK7ClSbBdutg
	D4WawMt461ndq191KXRy60=
X-Google-Smtp-Source: AGHT+IEXerCPUTHKmu7BuEIf3rGENMTQOqjZXabkFZA/lukyFl6xgvEeT3ZruYKeZ+/hNzkuYe78Cc569VE7t2ckJEk=
X-Received: by 2002:a17:90b:2790:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-31c4cd04544mr24390058a91.23.1752599478513; Tue, 15 Jul 2025
 10:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-7-dongml2@chinatelecom.cn> <CAEf4BzYpfYJyFKj0Uvtj+h2mBe1AXDwa2pfFCF7E377JufSU3g@mail.gmail.com>
 <0027bec0-e10f-4c7d-9a56-1c9be7737f6a@linux.dev>
In-Reply-To: <0027bec0-e10f-4c7d-9a56-1c9be7737f6a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Jul 2025 10:11:05 -0700
X-Gm-Features: Ac12FXx9jrFf8HAsj0sAsJmGLLZbS41ghkM318uGCILS6txsUILT1kGXBqmXhxs
Message-ID: <CAEf4BzYXy7GOnFwPWA+-Vn9oOSJ7m--KMBBsZPw8-tx=0rbAdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/18] bpf: tracing: add support to record and
 check the accessed args
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 4:45=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> On 2025/7/15 06:07, Andrii Nakryiko wrote:
> > On Thu, Jul 3, 2025 at 5:20=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >> In this commit, we add the 'accessed_args' field to struct bpf_prog_au=
x,
> >> which is used to record the accessed index of the function args in
> >> btf_ctx_access().
> > Do we need to bother giving access to arguments through direct ctx[i]
> > access for these multi-fentry/fexit programs? We have
> > bpf_get_func_arg_cnt() and bpf_get_func_arg() which can be used to get
> > any given argument at runtime.
>
>
> Hi Andrii. This commit is not for that purpose. We remember all the acces=
sed
> args to bpf_prog_aux->accessed_args. And when we attach the tracing-multi
> prog to the kernel functions, we will check if the accessed arguments are
> consistent between all the target functions.
>
> The bpf_prog_aux->accessed_args will be used in
> https://lore.kernel.org/bpf/20250703121521.1874196-12-dongml2@chinateleco=
m.cn/
>
> in bpf_tracing_check_multi() to do such checking.
>
> With such checking, the target functions don't need to have
> the same prototype, which makes tracing-multi more flexible.

Yeah, and my point is why even track this at verifier level. If we
don't allow direct ctx[i] access and only access arguments through
bpf_get_func_arg(), we can check actual number of arguments at runtime
and if program is trying to access something that's not there, we'll
just return error code, so user can handle this generically.

I'm just not sure if there is a need to do anything more than that.

>
> Thanks!
> Menglong Dong
>
>
> >
> >> Meanwhile, we add the function btf_check_func_part_match() to compare =
the
> >> accessed function args of two function prototype. This function will b=
e
> >> used in the following commit.
> >>
> >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >> ---
> >>   include/linux/bpf.h   |   4 ++
> >>   include/linux/btf.h   |   3 +-
> >>   kernel/bpf/btf.c      | 108 ++++++++++++++++++++++++++++++++++++++++=
+-
> >>   net/sched/bpf_qdisc.c |   2 +-
> >>   4 files changed, 113 insertions(+), 4 deletions(-)
> >>
> > [...]
> >

