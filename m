Return-Path: <bpf+bounces-60633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2F0AD9806
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 00:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774184A2BC4
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E128D8F5;
	Fri, 13 Jun 2025 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVEArvEz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440828BAAF;
	Fri, 13 Jun 2025 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852387; cv=none; b=NscmbkAfl1EWoMeR91Ph9Lxiw2Iuo+Go+NeM+YFyPiX3L7d5TsPH1oqGvP+RFHIDLorfgc4I0EiexZbVxGOtQAOUIhD4k6IBiPOws6vuxCCUcBPDU0Yh9VGD55smaZsdoEi5bE7jE0hNolvE9dbBty133LCRjzn07/phuvvkUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852387; c=relaxed/simple;
	bh=sXnQbNzsS+eVq9/kMPprNFgpItunamYmRKrz1o3X9IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baAYIhH3LLguzk63sEhxUU2NbykUumbO/1uD18Oj5O7HCUSGyO8C7NEDRp2HhaSUd1CUebDFVpvaFD/WvAp8Ez/U48sfy2Y/guto8FpyKJIXEz1XRMalD5MCAJw0hNA9ImFeevqa2WWas/Yzg3umbJHZoDMeYQFgL7QQ/dEV3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVEArvEz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1602378f8f.2;
        Fri, 13 Jun 2025 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749852384; x=1750457184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPyM26zxF7m6NElFrQVsOHv9j/rb7Pw26mq3IjRYYf4=;
        b=JVEArvEz7qofEtAIT2uAb7pfeQ7OIrRVT39H+tONxvdq5jcXUFCn44k+LcKztNrp+s
         HJd8WPUch1KbiZNNYjqYs8d+GY0SDxuKJedISCPEvs39tvkvBUQYo5Pl25M046yTEMs9
         RmU0ggqW8FQdva23tZw1p+vDC45rlCxCd22yA7jzU5vOeCOI8Gsgf6Ia76M8+STQbrj6
         3IME3raSeySVoXd05yNZL1PvJ6UlSYRyp8Lx0PpzOHsTbE9okObUR62oMzTLSd6SxM0M
         /DyzHk9CrR4/WrBNVFVlWJWH4pvYsA2mOuyRn8uskAeABeHge9WOEwkgSTqHQY10Dk6J
         292w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749852384; x=1750457184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPyM26zxF7m6NElFrQVsOHv9j/rb7Pw26mq3IjRYYf4=;
        b=MEMexhEn6kiSyLrkx4wkWpxlbR9YIHn8bDrQXD74TmaByfx3GpJYGya9R8b5RjlRAo
         A4NlmRD+0Vy6kZafMYBemmxcZDDNscLmCu+ZftYlnHwQN4j6o16MHe1nJIhcdeTIqsG0
         kBBW31PBICcf9n49RaHNpaZXNFwcH8Gh+NW3z5l8mBMEv09Do/2SKwVSSGtM0uZlm544
         vg0hAA6xUle1uMEpCKQ+uA1PW+DT/ZcGvAcQi6MI9lS64BhtAhwV1kxqsc4J4Qiljj/X
         1+ne+PF5VmhTMeqwJl22Gqkz/UC/jREjzJxOGz1QZyAh093/gGnPc7+NAlsN7/E7Z9Ox
         NjDA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Y0AUqDD9kQvIV/LGvEaePMOh8WWSTxZzzDKlR65c/SbOhUtQWzkARwIxLUz/thrBYB5wPqDKLCCTkXZS@vger.kernel.org, AJvYcCViqU92vJjHskDs0xImevCiUAn2p5USjUOH01ZWQ5VNfhjo4hBn/qAQ4qQJpdDd4ecs//U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5R2WCwa5xYikuSJAbnwGrX6+pZ7SqdKZyuIQqxhc7WEcg0+aR
	QxgsSFHoBNEPcsVSGL03IAKuJSc16kpp8Ios+Fn9WG78u2mkNWVMFOP1MOLcUd/hNfj/qEUY4+b
	RaBvHK8gPYDpGycmpy460Wi16CtrHqaOW35FJ
X-Gm-Gg: ASbGncs5UpIJ5bcKqBnJD5FjMkhQqfwZFLHiIkfB1XDw8f0zHUsK46LfFnX4NJjPXYQ
	RxuJqtLAdtegW10snZivTRnnpS+BMfPVBu/+qCT5WQOFhBepwDIYilPeljRi4KZq14DUgXVhEuI
	Jgf5f2WeynGahXrQvvF/2TiFysQNf/dF01t4gR+U65iapq4+GzuAX6xQlgLvSRpY+Pv6dWFiHO
X-Google-Smtp-Source: AGHT+IG5n5v+AjGzede3ra1+9Ys2ku5sScZRKs2ji0qJ0+np98EK2avrMv89kmpWx68lc1HuzLzxN/9DycHttQnIcPU=
X-Received: by 2002:a05:6000:4b03:b0:3a4:eac6:e320 with SMTP id
 ffacd0b85a97d-3a5723993bfmr1380044f8f.3.1749852383821; Fri, 13 Jun 2025
 15:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19f50af28e3a90cbd24b2325da8025e47f221739.camel@gmail.com>
 <20250613090157.568349-2-luis.gerhorst@fau.de> <a4fbe41d6f4c25c3d1edd42905eb556541857327.camel@gmail.com>
In-Reply-To: <a4fbe41d6f4c25c3d1edd42905eb556541857327.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Jun 2025 15:06:12 -0700
X-Gm-Features: AX0GCFt_qp8WRPpXxRVFY9J6VAyovzzrT2MnbqQVTN5ecf7AQb4-MmDfj-rtFQA
Message-ID: <CAADnVQKV3=S7Cs52QjiKY3ByOC08J9HxnN4wYUTmMX_ctrGVig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Remove redundant free_verifier_state()/pop_stack()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 2:17=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-06-13 at 11:01 +0200, Luis Gerhorst wrote:
> > This patch removes duplicated code.
> >
> > Eduard points out [1]:
> >
> >     Same cleanup cycles are done in push_stack() and push_async_cb(),
> >     both functions are only reachable from do_check_common() via
> >     do_check() -> do_check_insn().
> >
> >     Hence, I think that cur state should not be freed in push_*()
> >     functions and pop_stack() loop there is not needed.
> >
> > This would also fix the 'symptom' for [2], but the issue also has a
> > simpler fix which was sent separately. This fix also makes sure the
> > push_*() callers always return an error for which
> > error_recoverable_with_nospec(err) is false. This is required because
> > otherwise we try to recover and access the stale `state`.
> >
> > Moving free_verifier_state() and pop_stack(..., pop_log=3Dfalse) to hap=
pen
> > after the bpf_vlog_reset() call in do_check_common() is fine because th=
e
> > pop_stack() call that is moved does not call bpf_vlog_reset() with the
> > pop_log=3Dfalse parameter.
> >
> > [1] https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69=
a.camel@gmail.com/
> > [2] https://lore.kernel.org/all/68497853.050a0220.33aa0e.036a.GAE@googl=
e.com/
> >
> > Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> > Link: https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb=
69a.camel@gmail.com/
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> > ---
>
> Tried v2, all looks good.
>
> [...]
>
> > @@ -22934,6 +22922,11 @@ static void free_states(struct bpf_verifier_en=
v *env)
> >       struct bpf_scc_info *info;
> >       int i, j;
> >
> > +     WARN_ON_ONCE(!env->cur_state);
>
> Tbh I woudn't do this a warning, just an 'if (env->cur_state) ...',
> but that's immaterial. Given current way do_check_common() is written
> env->cur_state !=3D NULL at this point, so the patch is safe to land.

I removed it while applying, since it's useless.
If do_check_common() changes in the future and cur_state is NULL
here the warn will warn, but won't prevent the crash in the next line.

Also for tricky things we switched to verifier_bug() instead of WARN.
So no new WARNs allowed.

