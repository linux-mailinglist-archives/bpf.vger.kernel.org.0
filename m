Return-Path: <bpf+bounces-60532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE2AD7DAC
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FA07A78BF
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4042D1932;
	Thu, 12 Jun 2025 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXoFXJaN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183B1A3A80;
	Thu, 12 Jun 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764413; cv=none; b=g9zuGuLXag7AF8Zw+zfC9MtwDNsTiphmtC+OS1rQKd0vUO3QRoBx4Ir47ifpA8n/c6Ay/aAz7M9XQGT9mJCThXToJagfJBV5UxgF8xaoJhCcMeL1pmBYc2N1T8jVMpNiE9zn672gheaDZEvDGFJ6fRi13fqQ6XjY48Z4VsAwXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764413; c=relaxed/simple;
	bh=RPvF7yyUWcSy2PX6aAivYbB49HGUVy/mo5k0lxAWZ2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCXH3srJ3fPbDVfN2ouoOcIr5a3vfHIpUEEz3MtHPuOByxGGSChm1nVkr2RIxPOxO3z3UGoFTw5CSDBKEZnP1ZEEUn22QJckzCY/xEubAZVQIUjzPxv6aMwAdnNf9lHWE0YckXT1fTmVJGfalrxlrr3AdEO6m+FsY43IIHFwoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXoFXJaN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso942548f8f.2;
        Thu, 12 Jun 2025 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749764410; x=1750369210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPvF7yyUWcSy2PX6aAivYbB49HGUVy/mo5k0lxAWZ2Q=;
        b=VXoFXJaNxwi3TBWJc3wR/S7H+9PEx0qX+cXQH/HebyrEPXcgTT+SuljHCFR0f/6wl6
         kPmGsg3f1GKM588aRNDKP0/knMXKpucwVTXJwfSJmxptFd2u7Kp2WVoyewkJcxAqYUOl
         kzQDeo6Ky1vHJHgcK3Rwlv4MgHoLEKBfIwJPyEy3LukXj60ASOXS2Lf/I8MRozt4mdXy
         8jzl0LpPEqpzXdNJHxDIvS38gMRMBS8iuI6IYDm9LXexuc8jjCSEMdGg51mSNi5yFyq/
         hjhcVsv6FhXpeQ2OKwO87gTQGnKcYpXqPBBU3ACfCdgEy3pAKcvfLbzyBkaoUloyXCVy
         dr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764410; x=1750369210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPvF7yyUWcSy2PX6aAivYbB49HGUVy/mo5k0lxAWZ2Q=;
        b=Azu6sgH86Qh/pSMjPUSOWJ++ga4AvP8u23VW689ki0bcrsoFRdxd8tnXJylC2OZUYY
         onRv4zrjyAok+j23N4X28cA2nh79D86CxFzNCpx0Gy0vFuIXvw7646Nqg4AKXfLZBX/I
         +i+JMr7J2uSb1FxYffJzJ1T5r7G+X7JHL7gb1F+3Ijfx98EHx3IXGw1F/PZ1wvF1jTgS
         k/bmMWr4Gf08pGX64oOtcuWZN+973Quo+eMupA53Yg4V6YOg147jVAGyKTvYZT23YehO
         JOIIyYFQov3xaypaWUJTe24IXOYXLpB/arLx7lwBvQVHW4fQklqw+drTRl8KrwnKrT11
         xR0w==
X-Forwarded-Encrypted: i=1; AJvYcCVUVN+8AniNsXCPSRaQSaTSZS8HuGuGT+3PbC9BNXvmlyy2rFf4mzibY/bs0I6HbZDvuMiLeO/fUJGtbui4QMtEhdpw@vger.kernel.org, AJvYcCVV8Zacolv16RTqa6Eom2E+LBpnLO77zU0Vm+dIXzQIV6hbDSoH4QBoDVJNgmue3WTN5Sg=@vger.kernel.org, AJvYcCVk/WQnV53VKAapuTv+9SHEZsZ/XaVPHqUmkrUkWDuJzS0geyqE848Lu98A9dm55CvLVU+jZdbPwqZ0Qb9/@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpmpgfOdMYZns9k2uEzqPvFKIRgXFs6P4c3RmX/RVRA8vjpaM
	QYC4elmxkZQ4LjR4noXXiOU3Rvz4qN//Vvwcue1BLAQrmjg0wiFl/GelwHJciR2MC9I/x24/LXN
	Oh3hBtSAf8XZDuw7XteMPqzXf84vAwJY=
X-Gm-Gg: ASbGncteFCl7pGWXU83z74gFi231MmGZqCMsF/ohIaTn08/1TypBpitgKeCn09Cx264
	NafCqMbTjarcQqfMz6ZCN3i9uSMi7KH7tCVsF4beCs/teiHLIkLCk1jp4BU7USvgOOJOKwILqo3
	US4I0Vwp8pc6ugTKCEL3r8gh74we1T6SDotsCYiQBaJMGIwLJKiTJla0K9TyDUlZ7ZiZu4/Ymy
X-Google-Smtp-Source: AGHT+IFeYr6ctux/zy8hwjaabSEzMUj9d1MyId/RpAWfmzJWBK2rMfrirzJHHaDH38PFMbuabdFgusD5cVGmmO5u0JE=
X-Received: by 2002:a05:6000:3108:b0:3a5:52b2:fa65 with SMTP id
 ffacd0b85a97d-3a568655e36mr685844f8f.5.1749764410108; Thu, 12 Jun 2025
 14:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611154859.259682-1-chen.dylane@linux.dev> <CAEf4Bzbn=RVhMOR7RapYwi+s8gbVS=1msOuZ7MhPvgz8zHiE9w@mail.gmail.com>
In-Reply-To: <CAEf4Bzbn=RVhMOR7RapYwi+s8gbVS=1msOuZ7MhPvgz8zHiE9w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 14:39:58 -0700
X-Gm-Features: AX0GCFtP9Jmz1JjocGS_Azx6COZBhnw5DjFCQGuhbAiJJGtlvApnraG4ttP7qBU
Message-ID: <CAADnVQJ8cVi4KyJqWgEfyWYs+zSYQ73PevrNszPkisrdPSjYMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:29=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 8:49=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> =
wrote:
> >
> > The bpf_d_path() function may fail. If it does,
> > clear the user buf, like bpf_probe_read etc.
> >
>
> But that doesn't mean we *have to* do memset(0) for bpf_d_path(),
> though. Especially given that path buffer can be pretty large (4KB).
>
> Is there an issue you are trying to address with this, or is it more
> of a consistency clean up? Note, that more or less recently we made
> this zero filling behavior an option with an extra flag
> (BPF_F_PAD_ZEROS) for newer APIs. And if anything, bpf_d_path() is
> more akin to variable-sized string probing APIs rather than
> fixed-sized bpf_probe_read* family.

All old helpers had this BPF_F_PAD_ZEROS behavior
(or rather should have had).
So it makes sense to zero in this helper too for consistency.
I don't share performance concerns. This is an error path.

