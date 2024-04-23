Return-Path: <bpf+bounces-27569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB48AF3C0
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F19A1C239C6
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2313D2B6;
	Tue, 23 Apr 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWkS4rmH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D33113D283
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889059; cv=none; b=YR8vKDPsK/SGKFh7yiLtElLN5X8l0idU4wasQ1YjvrUGXu9M9/2ecIDDPtgWwdPN8BHICRh+kmaC4aIi4hiqE8Jmf840mY3ddAApuEocsMMnY06SOKePwBS0tjUlsxQF/pXxRYZ8mukHu5ijRKzvjli1IztQRt8n2RVIYG+5bQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889059; c=relaxed/simple;
	bh=79ycZkVg68Aw93acDJnrWDmgasYxsPo6BkAbOZC44Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOWVSS51zldttjgH9xgr9vWEximDb124guiQXtMm6yqujbd+fSLoeNNlvZ1EljVPeEXDjmLhQHZYTZ5d+Jw4Cm9/fnfr5YrlsmZqbTf1St2QhD5blBtgs9p2cUBSZWJswL9p5cy4dDv20qjZplCtY4vg+UtAWvEoKsV5b2OMISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWkS4rmH; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5722601d2aeso36214a12.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713889056; x=1714493856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoX0JaqKrkWpxO3R6FYMk69itdJMheXU5QiiVQm8lYU=;
        b=IWkS4rmHfLOWC5SpIfqtPVv/qN8w5Q98EvP5kOcmgXTGoqjvjoipl/YzF6pRTWA/Q2
         n5utIVzoMyTssakgGBcr4bIonAbdVzrUoscbCJpBo61Uk9d1hVbcGiwqp/L6pDvhBOfQ
         NnR0RcwwbsaWtynq7GtzUzjaCdlvSvfDzotQ2r2bVR86KoGva3QNCiWt3Ncge7corOuK
         MBbm4pZ3VYlxodOX+P3N7JxoBwlfJq7k9TrCymqe0525E+sbjFPQS826DjvYfmerHsS9
         mFyiXLj/d8aNaWN/Geu4BVoEI4wPjkKLYFxY1/JpjiKttzFCwrbuhcHpLm+Tt0phRupq
         788Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889056; x=1714493856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoX0JaqKrkWpxO3R6FYMk69itdJMheXU5QiiVQm8lYU=;
        b=I40eWUW8/R71Q7E+lR+7H3aor2Qm+dO7GjGsLOPEbjCAlIO+i6kIbFgl5lZHbW6hPw
         0/1karGzPcqGjMG3WjQyoql3AwIVfcyoAuPeiMa4KjKe+XJ0CKEKq7vtiwpAzNHOWjR2
         T6fTxjVhG+2+MCu3VeT+Puqo/3KQFP+/y2u1Pq9PtqSkh+kGc8VfUKVVRTtfubQt+qMG
         kXvcJZWOGEBvk82VxdH7TJv1zcH4ac0D4hBi129euktWgtKc7rgymFmuHh8Koa+jWRU8
         uw5dKhU//NTNVys7kYsGr1MzkHNz59pdbKNqF63MdIsapJZqiDjPta1s+6Z0/d7aste4
         SUvw==
X-Forwarded-Encrypted: i=1; AJvYcCXKk0XWM+EqBIUDjIgKASDoSXdyKtV5zjjlHPQwoflksRKwIzQm3lKRZ4EMp/zy/qyJiyl5flZYKrjZNdStk9gotV5u
X-Gm-Message-State: AOJu0YycTlQKl34Frdh2aizEVeoe9u+bPlsczu1egOc/20YJWvQXkQOy
	KScBhSMnNH5W+7aHnmDUNqGtWs64wR4QO7xEFcYiH8/o4+UzPxwh94ZLmLKeLW7gffR97hcQa+8
	PDB1DejSSYUcSkF/RwuYH651818w=
X-Google-Smtp-Source: AGHT+IHuGXdvaX3kWEirww8VnMRW8oQ/AbHC/j7o3S2ZEmRiUij1J73SkL855iLFahXIiJJrldWJLVqa/xI3EGFBb00=
X-Received: by 2002:a50:ea8d:0:b0:572:d7e:59ed with SMTP id
 d13-20020a50ea8d000000b005720d7e59edmr3610132edo.12.1713889056548; Tue, 23
 Apr 2024 09:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423061922.2295517-1-memxor@gmail.com> <20240423061922.2295517-3-memxor@gmail.com>
 <ZieYvK0GXs4OkTy4@krava> <CAP01T74v0SCoCkg1gJnz4xPsBc5Q7bV0=-xXKfo00z1R5bz0Aw@mail.gmail.com>
 <CAADnVQKN=ABKTFmDvbmZK2RmYLA--Yn4KGqDU7ujZbuHgE311A@mail.gmail.com>
In-Reply-To: <CAADnVQKN=ABKTFmDvbmZK2RmYLA--Yn4KGqDU7ujZbuHgE311A@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Apr 2024 18:17:00 +0200
Message-ID: <CAP01T75SgwQ2jRfX9FCxo0RrJxv4q5wO+Sf5Dz0_9F5a-4s-aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for preempt kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 at 17:02, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 23, 2024 at 5:06=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, 23 Apr 2024 at 13:17, Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Tue, Apr 23, 2024 at 06:19:22AM +0000, Kumar Kartikeya Dwivedi wro=
te:
> > > > Add tests for nested cases, nested count preservation upon differen=
t
> > > > subprog calls that disable/enable preemption, and test sleepable he=
lper
> > > > call in non-preemptible regions.
> > > >
> > > > 181/1   preempt_lock/preempt_lock_missing_1:OK
> > > > 181/2   preempt_lock/preempt_lock_missing_2:OK
> > > > 181/3   preempt_lock/preempt_lock_missing_3:OK
> > > > 181/4   preempt_lock/preempt_lock_missing_3_minus_2:OK
> > > > 181/5   preempt_lock/preempt_lock_missing_1_subprog:OK
> > > > 181/6   preempt_lock/preempt_lock_missing_2_subprog:OK
> > > > 181/7   preempt_lock/preempt_lock_missing_2_minus_1_subprog:OK
> > > > 181/8   preempt_lock/preempt_balance:OK
> > > > 181/9   preempt_lock/preempt_balance_subprog_test:OK
> > > > 181/10  preempt_lock/preempt_sleepable_helper:OK
> > >
> > > should we also check that the global function call is not allowed?
> > >
> >
> > Good point, that is missing, I'll wait for more reviews and then
> > respin with a failure test for this.
>
> I couldn't find the check in patch 1 that does:
> "Global functions are disallowed from being called".

See this part=EF=BC=9A

+ /* Only global subprogs cannot be called with preemption disabled. */
+ if (env->cur_state->active_preempt_lock) {
+ verbose(env, "global function calls are not allowed with preemption
disabled,\n"
+     "use static function instead\n");
+ return -EINVAL;
+ }

>
> And I agree that we need to allow global funcs in preempt disabled region=
.
> Sounds like you're planning that in the follow up.

Yeah, but it's not very simple. I noticed a few more problems with
global functions before that can be done.
They need to be marked !sleepable before do_check and only verified
with !sleepable. Otherwise if that is done later in do_check the
global function will be seen in the non-preemptible section but may
have been already verified.
We need some summarization pass for both preempt and rcu_read_lock kfuncs.

