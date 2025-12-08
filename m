Return-Path: <bpf+bounces-76319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE508CAE6BC
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 00:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 652E7304D0D1
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F82E03F2;
	Mon,  8 Dec 2025 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cER7GGus"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A7213AD26
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765237329; cv=none; b=Rb+90AWxSukackSH8PmbTzZJSvVckN1OUkN/LKx/XnL5nkjXHL4uhnLAYJMql5sPFEAgYbbSZRfrZ6mBSCzMw8VAIfVnYkHeF4a//kwmJfzUQn9Rq+25kuyKyR2NUa3pTlGpZzm3UFGFvV5mpaSfur/gAGjMQGrE+dVhDFNpUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765237329; c=relaxed/simple;
	bh=dablNZTSzUwDTRPC+XimuDEWEl1QWweiHAiRR9iFfDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBm185iqTUinMg43ltgiAHWWi4QIhCZvLcW9GIFrnFvJ/y5ccjRzoexOXdFUbtd3WKRCm2B4wfB9ddCRI1+YyLkyjqn1/zuvas7Yhl1n0ccO3t9DwnDzSTRWqL08GDDbeziCMBijuizRCt9Ow4QZJZgARVQtgr/fCer+AEa5ZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cER7GGus; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so13545e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 15:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765237326; x=1765842126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dablNZTSzUwDTRPC+XimuDEWEl1QWweiHAiRR9iFfDE=;
        b=cER7GGuspxF5xDxdsxAqFEHBNy6C0QT13Ucnv0XV9IqNid3G9e4+5HMiPygnbtKh1U
         fBIKylsfczGw9LcX43nKgzRHIHeFlA8rqesZ/kgdpXGimx4aYf7tCgisKGznzemUcCRW
         fekDX3mIwtH9Qxoc7ESwjmTM1jbFX1PNorewKq4pCI8T7DD4Z0+UZNgUPoA48OjHWaVG
         Ym99qK2rxQCLGYc7GuCyPqRMwF/6z+M1yfafv3ODinBQMcQubze3HgwXgLNe5G7GvcnY
         5gI6NF9/KlOYD+VjM6z/Zkcu+RJff4XXEf8hBzOUH1g8NDeAtUKJXE5TqDD9BmYZSYz1
         J1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765237326; x=1765842126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dablNZTSzUwDTRPC+XimuDEWEl1QWweiHAiRR9iFfDE=;
        b=QwCE0eRQM2kQ3iaFqy36pNjzUAZ4lgMheforXQNYISXMc2hCZ5phIUPmrd5ZTgk9Og
         Ev6jxlqhF4F6IQqUdGNZG//Qbt+IbhmqNRl2r65b2LP53yHXaScTZlrYJfxqZRprOLS0
         r+2YwcCYYKe04oU1Ij1OMpRFb2Ts+ozybbCDkWPf/sX8vMajCQndj8mEVtLMJF92G8uH
         DVeEEbug2neB0kmlbmGq5VhjptyFWX5fzlJjUDRNm8kUHPfkMybtXyVrQ1LIOl5sw3T9
         VUAjMXlMHADrU1DX4GLl89SvIhZZOOkPz0sWPv41z8f1mXYog/hYzri6Jt5jBv4XIpMJ
         gIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXKOzUFU3WFooQHlZuOAr66L1KgsYs61yCnbKZpmm4sDwqrxPHe4pSDogmHDIVQxecT3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/5itPx7KG9Ik4Vjw7aflOMexwTKcM2hq/lcFc7a0C1bPEfZh
	UrS0vMEjBkwNm9eTThzrIKB6tOu3TL2tlPBrCcK/08uaEvlp2/aFG6xRCCcFExLPwFpvyOcc5i2
	BYq7180JWdnx2FdJbBaPiW+JI7bIrNv1x74K0nlBj
X-Gm-Gg: ASbGnct01csm/6jf6jXn/0Efd2V4K5onVz1HecGtOI0gIDhzWSSjpTJSIV04PF16Cn+
	mTSD0ic9wjw2K0YH4+OmmxXhfGVcgop4NLkqY3M/5yxNXSpM+Z5YyqUBCUpc/xhJygGS44f1AI+
	COfOU/hI2UyYk0fgo7DGTfSzfiaTk8PmvMlAtuSb80pD+ruX/KEzrhv9l1xOCdR91WmRJ7q7mAy
	Py2o7VLOzZukjOzN9/sYKyB+QROcAIC/vSvALA378MOMdvopyxF4C61ZICvDKaNAlY4u21oNYFv
	fVy86HcCbqOj+gSq9Q3V0KWfnZw=
X-Google-Smtp-Source: AGHT+IEszUoohjcHClgmqNP4VXXPoX2rvtBRVEMX+0tgAXPPQeNPGAjIK9R1UtQF/0Hqv4mWEIZkxZhV0HwkXeynQ4U=
X-Received: by 2002:a05:600c:4394:b0:477:76ea:ba7a with SMTP id
 5b1f17b1804b1-47a7dafc85dmr86835e9.3.1765237325609; Mon, 08 Dec 2025 15:42:05
 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207091005.2829703-1-tjmercier@google.com> <327d78d8-8562-4865-a4de-9eeb4dd0ba03@linux.dev>
In-Reply-To: <327d78d8-8562-4865-a4de-9eeb4dd0ba03@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 9 Dec 2025 08:41:53 +0900
X-Gm-Features: AQt7F2p-Q5yDyFIWW5h3wZ6Pl7Ub7ls2ZdwRybN497AR_f9tZfeM-h-JWK_U38Q
Message-ID: <CABdmKX13YPStt88MotSUzcdRSu-aVQfuvnpXX9R_QrBQCfCzCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_seq_read docs for increased buffer size
To: Yonghong Song <yonghong.song@linux.dev>
Cc: menglong.dong@linux.dev, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 2:42=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 12/7/25 1:10 AM, T.J. Mercier wrote:
> > Commit af65320948b8 ("bpf: Bump iter seq size to support BTF
> > representation of large data structures") increased the fixed buffer
> > size from PAGE_SIZE to PAGE_SIZE << 3, but the docs for the function
> > didn't get updated at the same time. Update them.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thanks!

