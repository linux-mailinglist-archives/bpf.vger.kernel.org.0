Return-Path: <bpf+bounces-35466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F04F93AB83
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 05:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27B5B22A51
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615F18054;
	Wed, 24 Jul 2024 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH9wJA1H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4117E9
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721791036; cv=none; b=REoOSNbVFCme3wMtAJ3i1sjmyuuQyPX68EG1sRXkMvwo2jry5xqeU8Td7JUgqN43cDLyi0B0gadwhis+Rj+D3VIzvlnuYRZ8rwJrIrfjprsTxddv/TS1nR1zCjjE3LhBD4hErruCK8zmsl9D7+bnX2qfCrTDKXc4nrzzVWGgozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721791036; c=relaxed/simple;
	bh=mdXEMite0xAc9X63tvQKYg4Wm1bnbFfgRvTuJT+8Rvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSUM85RaXECUok04uTrfldq8yfwmoHG9KRRRj1qQlD5xBoIOGWK47/njgZXUVm6TDE8tDFGdwkbfy/+JDNdWJgOOoxgmbFVBQutlRyCrXHeawLBfX73trOW//M0S50VzW00RwUfiVjgYeGeP1L5e9A9K8AW9J+rDd0A2k5IQNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EH9wJA1H; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so41777405e9.0
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721791033; x=1722395833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hSRn9YWZK7V4GCzpwt84lbmcBAu+CQw+MXCmvVc6Fc=;
        b=EH9wJA1HJGbo9jsdhHa1OKVW+5vH6305uA63dapRx6QyExtX72QA3JW9wHRxVT/203
         3j4947XRT0kuskcxzmwfs1tvqVL1bbsbnV5YoaSBy13UN8EhB50E8j4LxJILcOU6mIMS
         k8oreuUdNgypj3XBJbbi6dA8BhsDoKnJ3bfj08WlkhZ9E6TnkEQbRV8Jy+lOzJ5vXvY3
         53ssA6EPPzP9A/F3zN2xv462KVEv9OQISJumMLUF5QuhPQ30W8xghRb66WMBChINCmMT
         7Ba6yZo5AcK7nlLHHGwGXO14XbBLuteBGfAVPGZh20Q99NHqqJgGyKf0ix61wEqGgJH7
         8ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721791033; x=1722395833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hSRn9YWZK7V4GCzpwt84lbmcBAu+CQw+MXCmvVc6Fc=;
        b=Tqorqm7AuxRyPdKuGidLbcgqYngZ6swgx8bI6rfMl5THH7/HdAgX9SUMaJC3KYRJT1
         jynIlq/lk6nD0y8vwJwIt9rTZoU32dwu+2SzroFSBf7Vcg+kwy1Ui96fNajTKk41PYXE
         ZTbKYZZkAPxO+g7XdxmOZXULHtXlqJq5UTmMTwYsqHB2tymGi8HWTEepNBSZ+QQme5m/
         367I9u1dFUwz6/H80336mE20AARRn06+xdS/Q1XwO9O8tceDxOqrinO8uVj9Bpmo3OPy
         Kui6DIGOqQ60rtPMYY6t4wT2tjmkVZAKRlEEFrW5wXnl9rcMlapNbNdCb/u0a7NytqQY
         UKeg==
X-Forwarded-Encrypted: i=1; AJvYcCVn0BMNA3NRsL+0gnBYfMqzKZu0LNKVQP20cn/OQ+1KrymDoAZGlPhHSR/aqSElCG1CH3cZU3keRjgAxnRiclHWxRNy
X-Gm-Message-State: AOJu0YxnO8KevaKkH0k4FLg63UbbfLhtq+fJa2SU525qWid/errhAWSw
	x3A/XOYqIfBVG+ylsdA2t6JVrLmoBLGVrvQVpO2hclUh0hhwbydjts1gfKJZ0a8GX1ZgGntNcTJ
	xu172le4XrU74rIPmDaD+TkaPkOs=
X-Google-Smtp-Source: AGHT+IHKYKKQhI4m6Ow9pmK79I+tKvG2sooCKTp69E5QLtQml+EgPvvQ8FKZXhed1XAmk9AYzLHEtM3C1f1xXBpci+s=
X-Received: by 2002:a05:600c:154e:b0:426:6f48:2dad with SMTP id
 5b1f17b1804b1-427f95b73a5mr3579645e9.35.1721791033238; Tue, 23 Jul 2024
 20:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com>
 <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com> <CAEf4BzbC0vORHOgKhrh6UAog227u+5x9Wpgp0D3aduka=gN4pg@mail.gmail.com>
In-Reply-To: <CAEf4BzbC0vORHOgKhrh6UAog227u+5x9Wpgp0D3aduka=gN4pg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jul 2024 20:17:01 -0700
Message-ID: <CAADnVQKXujv9+zf5fbL0cXkxRrFct=JAEjCsr3+FvpArTmcQTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 8:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > > We *need to support recursion* is my main point.
> >
> > Not quite.
> > It's not a recursion. The stack collapsed/gone/wiped out before tail_ca=
ll.
>
> Only of subprog(), not of handle_tp(). See all those "ENTRY - AFTER"
> messages. We do return to all the nested handle_tp() calls and
> continue just fine.
>
> I put the log into [0] for a bit easier visual inspection.
>
>   [0] https://gist.github.com/anakryiko/6ccdfc62188f8ad4991641fb637d954c

Argh. So the pathological prog can consume 512*33 of stack.
We have to reject it somehow in the verifier or tailor private stack
to support it. Then private stack will be a feature and a fix for this issu=
e.
But then it would need to preallocate 512*33 per cpu per program.
Which is too much.
Maybe we can preallocate _aligned_ 512 or 1k per cpu per prog,
then adjust r9 before call or tail_call and if r9 is about to cross
alignment before tail_call fail the tail call (like tail call cnt was
over limit).
Hopefully there are better ideas, since it's all quite messy.

