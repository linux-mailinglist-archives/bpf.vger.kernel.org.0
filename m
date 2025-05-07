Return-Path: <bpf+bounces-57696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F0AAAE8EF
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E049316FD8F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DED28DF49;
	Wed,  7 May 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT2v+bUp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955A28D846
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642022; cv=none; b=c5RD/LGD1vvdYH5KsTai/64MCWdR+Jb9BjY1i+VY94FB2N1SF6KQ7MdzLuDetjQa4RWQtZi85JGuA0TGZZksboUJFygTXWhYtL4afuIoe0RrCPiTT+GBsz7RXeQpx1Z2qyzBmR9iXY8ZMj0eT9AMYtWwj0VPSyoi/Y8Y5rsvbs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642022; c=relaxed/simple;
	bh=5+9L/PRFMx8tcNNQyRcGn+nzROlZRaiVkytJAMs+ihc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcURGrqRCaZIT0zxfwxJSVYcsUGieAdt2VDT0FpYqVQ/7ZARt+fcW9pGY8v6zgiQr4TQma6VhMBn4fz4SUaEXfje5crNdJcheVa4bgyP3eAqaYIOtFgyDZwVYkTztURB2WAQxFzXtagZyzlEJgfamJFOAoj3GnsElQtrnEjj5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BT2v+bUp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b0c68092so241421b3a.0
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746642021; x=1747246821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+9L/PRFMx8tcNNQyRcGn+nzROlZRaiVkytJAMs+ihc=;
        b=BT2v+bUpPcq2+JDn26Bvk2jTgJ++XWo71ygWzOR9/97C0Htl4ANNVEWc4gcqT9tRU5
         2vIuTIbv1yCYnQqNYFsR58pSA5M1zPMZWMasfe0tqVjHJX9Iv9KEkcHxCi9Lz7kJ6fC/
         2zxpjtH649QRYbH8OZl7Uk45wNr/Du/SB6seMhznNQNrSrFpAGsQ90g//ctA/f97AylC
         O9OY0HDxkCkBjIwIHKEroKDmA1PLt/+MXFJxhjfK/K75+eb7OR7D50UdMWDTrRHTM7u2
         G+zlMazwGQKhn25HbpqAQ+XLwIErKtPcq3kzqjozppSnkiUJWLoFZDNcW8gaTr54HYgc
         fFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746642021; x=1747246821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+9L/PRFMx8tcNNQyRcGn+nzROlZRaiVkytJAMs+ihc=;
        b=DqcfJWoO399cmfCf5Wv+brvGkxxqEwbT2aSXESeskVRv7IYdXqf87QW3NCnkpHh/Eo
         7cyV3iO6agwPop7WKDSj7uc69WASMUKS/V4txkJsyApYp0jFuNGlW6UiZSqmy3yi1Mus
         0Zut60aDfk3C4bdhNH8mhkiOuTLz2ZAXeFcSi1K21l9+BRxFncKIn79A/83vHX1ImT8X
         /fWXdozGMj96dmnTeymti2pC3i3N/cnYnab88GMACHFeD84AS2youvBwCicW//jo7wVI
         wR9DJkWkSGKsNfIUSgJdeduXs3TrH94Mgi2FmAAxvr9cWp3YBXPn9isdbLeeuCcavSMG
         Tpkw==
X-Forwarded-Encrypted: i=1; AJvYcCV2hBOFcgW4ebPtVpbau0Y5pkhVABW5zjXQb/q98eoIid9lvVEQCR/1dGt0aQRNJYHsomU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XT3WA+avDMQdCR1W4Te2MziQjlLJIVmFb51V5+/NzC/dBbKg
	VLcEFR7MtaUBKDVba5MlzVLxV8CbCsXNAzUzA0KXDbUkMqLeDuFcmra/t5/PMFeHauy7oxLNdPb
	quxRinE5tNTcfwqfUhctwq8sgm+Y=
X-Gm-Gg: ASbGncv9QHbb9PAHW0gSku4qMIzQ7M9K25dsgpbu42ZvMwIY4PIxGh/GAYcZBO79LJR
	G5cWMQ7gO0sydoFzqpExndPQBNniSjFBlH9v6n60d0LF+fPbqGft+V6Tmynj+lZxzr0jiaD9AyX
	1WlrFQNLtU9ilOEyiAqkxQT36IFbT4JjnMO94vnQ==
X-Google-Smtp-Source: AGHT+IFAirqhUWWiR/VnKY7HxBs9FnMyNbVeMQBtv3ugyrqutkwR8uJk4DTiMuAm2B0QEfV8y4y9JaWk4Ss3cgtUCVE=
X-Received: by 2002:a05:6a00:410c:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-7409cfda210mr6897500b3a.24.1746642020701; Wed, 07 May 2025
 11:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506232313.1752842-1-andrii@kernel.org> <CAADnVQKTeZ_M+9fXNuLpXmukaV4e7qwQQAySax7S9j1=29+66w@mail.gmail.com>
In-Reply-To: <CAADnVQKTeZ_M+9fXNuLpXmukaV4e7qwQQAySax7S9j1=29+66w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 May 2025 11:20:08 -0700
X-Gm-Features: ATxdqUEpzcBQs-80LhZtGoLqFALzK7_ZkRjBQXKryacFLxg6AIW0hUl_aREGW0Y
Message-ID: <CAEf4BzYgRGbxvP5KHXYoJzuiirYcSta8Db3DT+QxqBSU2zPJMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: document open-coded BPF iterators
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 6, 2025 at 4:23=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > +be fine with just one stack slot (8 bytes), like numbers iterator is, =
while
> > +some other more complicated iterators might need way more to keep thei=
r
> > +iterator state. Either way, such design allows to avoid runtime memory
> > +allocations, which otherwise would be necessary if we fixed on-the-sta=
ck size
> > +and it turned out to be too small for a given iterator implementation.
>
> This part is a bit unclear.
> I think in "if we fixed on-the-stack size" you meant that
> "if all iterator types had fixed on stack size ..." ?

yep

>
> I think it's too much information. The doc can just say that
> sizeof(struct bpf_iter_<type>) should be small enough to fit
> in the bpf prog stack.
> It probably can also recommend that _new() should avoid memory
> allocation when possible and use the stack, but it can allocate
> if there is no other option and the state is big.

yep, makes sense, will adjust

