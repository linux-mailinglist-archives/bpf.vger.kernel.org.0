Return-Path: <bpf+bounces-75289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68816C7C2ED
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 03:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256733A64F3
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973052BEFE1;
	Sat, 22 Nov 2025 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Pq4NQr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A411B3925
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763779037; cv=none; b=rVqfYrEFPQEvd/mpJDbNE8CbwmixcNqpvVynK3C+FQj8hEO596szqn/AMZBcJm0CjBc2VKUabSE68E4P0jq7ODCI8YjDK55gmT/nIWDIcsp+9odW95p7AXnvDju4s3cBy0Dnx7cBshw1Q4wGdndossFVbWborG/BWRImk7dFELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763779037; c=relaxed/simple;
	bh=gXDFNB+nvhMJPJ7JFkOig3C4y6ENG3TW27PZQhNVdLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1D2tgdGmAbgJABRiNa3BWx75sLh8ucaDh5opgDFiHYXJUYcwv57uNq1vnb5yVx6+RQa6HP/4hkDzPADRkG/PD6NiH7gmaI4aqEZQUNUlBFl5e9wtIbGD3cJZFO/ky+8v6jEFXx1vrcCvf/ESvONmAgwXPwc52rCCX+4b5Y07DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Pq4NQr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a219db05so16743405e9.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 18:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763779034; x=1764383834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXDFNB+nvhMJPJ7JFkOig3C4y6ENG3TW27PZQhNVdLg=;
        b=d0Pq4NQrfC4QsnAsR3HWJ/NOiky86J3ywJROHLunncbUOtJbqrUNhyTx6tFdBW8cEI
         TshyXnlcZOEx8IEPEIHHGyS8QALsgHjE1C96gioDk3kIUmIsRd4bbJcbAYOM6UrORVNz
         Z3gIyi/QvHOKvKrVR96ebd1RKzBYK+CLT8gvSNpNjF0nfSwltQWaAlzqxMaCRckQcllM
         n9qdXGzsVATLVM/JGB3a26puJ253xFa2pjhpRrogKeo3Rg/C+WirbewCjwnMla9+Be8k
         vAmFVQ22GrDrFgR+cyggDTQ4UfKLGlFgzZFTgHfdX10Lr+U4WbOekD1BqfRrJU9WtPO3
         qlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763779034; x=1764383834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXDFNB+nvhMJPJ7JFkOig3C4y6ENG3TW27PZQhNVdLg=;
        b=qynppe/7Uk9BWH9NRyw6P/cMGz1NLO9S4w9GKnvNEBld4JljaUvHzrK+qv1vOX8ESu
         ZH38xPqdc+dSjLOStt0UkKnitTvOLfOr0AnAltoYcyDE+jwH4xkCJ6hE0qEtnUlpiwR8
         lXSHfzE2k8RWkmlkXdaca+meX+L+Hbs9VALMSiHe/0KhgEuxm/c455J2dOVundcTRY/a
         tNw+J6guLGzrWDg/157JJIbqdLFN1WAi4LvlkSGbyKQeVl07pBVF9ztWDK80HAhCGMPd
         +U1gH3ac1aD0+cPby4SG2+xRy1vFgX9bb8rTK5uyFKdl7Tf75lUfnZH3NEubTJrB5ZzV
         qyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmj5Gezik+tBn9MYoO8k/TLZiRn16vaUxZ8Sklz3+9xGBzcadnpm07QveQHfb6ioYUiXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfR8FgnyhDT+1XdRlC730RLpBJ7YCVcQ9qFBr1k4ZirNhYdnX7
	VPuCOILv6vmbzjN5TX7c+UsZ9ITlt04LdeqeOdDrIS6Vhuq/W8ypUQE75b4snDKiQFchY2TmnnK
	8dKk0gLfk4nJUKoakY/8aLQn/0PllLMI=
X-Gm-Gg: ASbGncvmzYzrwajvAxKivlfGrQ2Q+I2Q19C/i/PhKvTe5PeMMBRChC2VsX8ki6xHtMV
	bHdJ7dItkycFh2Frn89KHCy3Tibx9u1ktYj/Wnr3QZurS9UfDEW+vSOUWXDVh/Xr5t3x+0BKFSE
	rspinD2Ii9bBGp3ja8GME3k07HrojqPGj3NMqqMBF8nrT0c+Ahfgv9mMcCZAtVlXJUzw/qnInyM
	aVJJnQOEa6rA8w3vFW8vV5jS5lV3MT9OIegs7bwl9x47UcZBqvPdk1xR1CnTUtc2S37O7ibW+0o
	pLcv2ecwmDrPJPlw9r3778055FKW
X-Google-Smtp-Source: AGHT+IHq8TQLttx02HzTcghCCmnEoW2jl5V2xikX6J5I/xeRJaTuYAWoFRPo7RLtazD/sqSeAZIHBDfxSir7BUeY6Q8=
X-Received: by 2002:a05:600c:3511:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-477c112f7b1mr39494665e9.29.1763779033832; Fri, 21 Nov 2025
 18:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <20251118123639.688444-7-dongml2@chinatelecom.cn> <CAADnVQ+mHb0AZe=J+yswjMiXLToG3-_3cfMxnNJJM-KAukbxBw@mail.gmail.com>
 <20251118200304.29f2bd7a@gandalf.local.home>
In-Reply-To: <20251118200304.29f2bd7a@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 18:37:02 -0800
X-Gm-Features: AWmQ_bk-1n4MtV7kB_iJKRoAsqrOjg4sGeLazyNB_E3dmOLPDW9GuTNA0HSP2oI
Message-ID: <CAADnVQLs-kBMi7VCizH5be8q8Nyzx=KYNPcnF-EDNx7OPs4Aiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] bpf: implement "jmp" mode for trampoline
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 5:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 18 Nov 2025 16:59:59 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Steven,
> > are you happy with patch 1?
> > Can you pls Ack?
>
> Let me run patch 1 and 2 through my tests.

gentle ping.

