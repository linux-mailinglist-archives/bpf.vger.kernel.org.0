Return-Path: <bpf+bounces-47053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32579F3881
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6193416D1FC
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2A20D4F7;
	Mon, 16 Dec 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh2+O1fv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B020764E
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372220; cv=none; b=m9QIz+e1FqaipTtyoeMnod9CjHQepdt5lNNEsaXzjBDTOIEeQaNYWhstpurYc8waRb8S9mAVXNewJhyvE74NIvC3qNkxMddYmFS3sodNq23Sy7xfIWlKBn84rQWEpy0q4RGqObvxuYjlXHP3lhvH+KNAnb+XU+iU2kRE7KMUWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372220; c=relaxed/simple;
	bh=hTD30g8QIzDjBNexh+UasI444X0/ItBmu11bbfHLKV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2nZ9gcplQNEC3p7v4dVZCRcDTEJldrYqmyn4DQvIp/kC9Pszt9IGZMACrvuhLe/xbMtW2BNAi2zwQ0CrILynLzlCxEzmfgV8Udc/JqcCbN+wSiwQH55eZwyN5+5VaOSTn8ivzzG2El0tlbJr3//OsO2zj/FANrSuj6zMBCsoJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh2+O1fv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so2479294f8f.0
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 10:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372217; x=1734977017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTD30g8QIzDjBNexh+UasI444X0/ItBmu11bbfHLKV8=;
        b=jh2+O1fvte7pNY31Ug10kt3RBz2727btZaWof3Raybi2ZRq8W0fDcSJn5lcNC33cKN
         fd0qqcVmLsLb8BPSg8RDVQcah5pEbJkhHapeLz5t2m2HV4ymcblVWyJ6LkLfgEnZePRG
         s06SLpqAOn7H3x5OXb5htKPHUgYs9w69QmygFmDDNCKV7A1nxtrw90VnxTvGlKbOPd6q
         ueuv0cbWI5AE7E/mj7RHCQ5cZqpj2Qh+J5rHj2wJYjTmX5j+T9rvU7dt4TAqdTSiPu2M
         PVBXuoYZTIXdYgN3RlIoUKPJ8tkcIdUVbOIs4h2TFKCd6lGSENkajX6bokr3WTCvQG1X
         08RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372217; x=1734977017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTD30g8QIzDjBNexh+UasI444X0/ItBmu11bbfHLKV8=;
        b=b4nM7jizhq0DJwJX33Sy8dKleesXpUQWW6xMOusmOszDwkZhoOZHu97p0F/DuWZRJn
         E0gVJj7KeaKMzAbBsbaBabdNVjfexXl/VFoTFjT4FN7+Jk3LtAUORpt28GUNaykiuZ0j
         1f5SSQ3b58QDpIti7Jmt+DFwMoKdVh9Sh/9FCWLBF1xp8aPiYRAaIDeqzZ6lz/lSk0fT
         dQUucRUrr4kFjTLntT6Cp5/qYzTFIvunH8lR3qaiQOWMklw+1z84jT8oeye401/SVcIO
         vYnM/EBzNW3562eDTsMQkqHRW7nnk3JH46C3Wl79TFWFwkb5KQI6KnQ5zVqgQjpHLXIt
         YFlg==
X-Gm-Message-State: AOJu0Yydtp9QeUrxlB5kTYWLANtlkGQmAevsXHuZ7yO+LtptgiNenJud
	8NUwVQsoN78iRWdjxK0K8RG3D0peCpLMpISTtbtWxy4gjaH9Rpx6cpIiC5a4lL3ShWy/lBKby4m
	CXJAs+8+uGmuQrwvJ8z9hHoUBfwo=
X-Gm-Gg: ASbGncs0F0xzPE/OfjznBJdZlg6CH5Sdorpk9x9nKR1xU3Mm/pnU9sftDSul0mJxN1/
	WNnnxkTmzvn9JPqJzJypgrlFqlSTZ4otAGzsWK5LAimv3/q/VYikZ8A==
X-Google-Smtp-Source: AGHT+IErIwud/f8unT5F7klAp+4yPUrXb8cSpSAMf1xwf2aPfPRsfQZYYscM5ExUHW4OU+C1Kr8GfoEEcPKJGViAaZk=
X-Received: by 2002:a05:6000:1acf:b0:385:f47b:1501 with SMTP id
 ffacd0b85a97d-3888e0bd1f8mr10815573f8f.32.1734372216261; Mon, 16 Dec 2024
 10:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213212717.1830565-1-afabre@cloudflare.com> <D6DB9BMTYRIY.2GQMKAM0R1RPN@bobby>
In-Reply-To: <D6DB9BMTYRIY.2GQMKAM0R1RPN@bobby>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Dec 2024 10:03:25 -0800
Message-ID: <CAADnVQLjT7Ac8t-=tpW2ocGoq+h71hKuDENODKPEBuKU=ovwjA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/2] Don't trust r0 bounds after BPF to BPF calls
 with abnormal returns
To: Arthur Fabre <afabre@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 9:45=E2=80=AFAM Arthur Fabre <afabre@cloudflare.com=
> wrote:
>
> On Fri Dec 13, 2024 at 10:27 PM CET, Arthur Fabre wrote:
> > A BPF function can return before its exit instruction: LD_ABS, LD_IND,
> > and tail_call() can all cause it to return prematurely.
> >
> > When such a function is called by another BPF function, the verifier
> > doesn't take this into account when calculating the bounds of r0 in the
> > caller after the callee returns.
>
> I've just realized r0 isn't he only problem: a caller can pass a
> reference to its stack to a callee, and the verifier also tracks the
> value of this.
>
> If the callee writes to the caller's stack after the abnormal return
> (tail_call, ld_abs), the verifier will also incorrectly assume the
> write always happens.
>
> I think we need to treat these abnormal returns as a branch that can
> exit. That way the verifier will explore both possibilities, and the
> combined result will really reflect what can happen.
> I'll try that out for a v3.

Good idea. Makes sense to me.

