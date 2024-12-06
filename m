Return-Path: <bpf+bounces-46307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D46B9E780F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4FE2826D3
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08308203D51;
	Fri,  6 Dec 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VThnNnY6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7811FFC67
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509595; cv=none; b=YceVc98RrFs27bkicSyNoEriaHghhDOyeXMlaCBW10o07xF0tTb0X/+MNwG4+0iOC9l9Isbkn+RA0GTSv7hkzfVGkjN9jDnnJRhVDcUwZgEEZVFHV9FjLOSZ2A5vu/MNtsEC+hE+i6Fssd9amNUHlsibMEd74ful6q+aJTFeb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509595; c=relaxed/simple;
	bh=qQ7cpIqZyDbkZf/mDuwmoMVkbOipfpqXjJrFg8UsvVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv2ki7aLeaAgMHq/nK7ocsJB8sBAc3wzy8YQVfJEkZUU/yBqQeps4cTKKYxQTBN+GpsgH03Rg7r7we3Gw+L44nnDYeYNyTkNuAZgz0jjETJvzbnPfb4X+VnqY193xkGV991EYtMhhYq06WE4pFx0YxiYrzMHyef3AQjpdOGB/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VThnNnY6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso16120205e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509592; x=1734114392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ7cpIqZyDbkZf/mDuwmoMVkbOipfpqXjJrFg8UsvVU=;
        b=VThnNnY6t9bkvp7hUFlSaCjhze45vUcdmDwVp3EHMBA/Asw6SemKZDiGOA1SV4/ew7
         ZDw+g50IplLjBGEjxYpudzM2Gs8hbQEdF0j4/9Hco4pmKa/Tx+9juXPWapfnka2lDwbx
         dDDAAdmWv93R6Ip1EFejXn//25nyo0fjDrfT2i+nL64dqdOBTpJojgO9wXT578u7XRMG
         zewWeGswDJmOQMbPbi/AFKONsXdcW2AyjRXXJjYsIrR701Ez5tCBbPqJN2yzVEwdvRc8
         Uh2GCwMbqr6a0BSE31nbxrb7hS6NWlbc86oYg1DQkzoG5snH2CBZBJrK2qUuEdl12Ojg
         /6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509592; x=1734114392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ7cpIqZyDbkZf/mDuwmoMVkbOipfpqXjJrFg8UsvVU=;
        b=wbgk5v2pRlQcJoXT5QSPKT6Hh1oeqmCICGFYJPXt60z5MZEZtOhjkvwJLEJJx5pdP/
         i19ADXQgFmaqiUcksclFnVM4/vpckDYsKrttV3CD8A0y4QF17dQ0NJz1ba11ZR+GPSRY
         9LsYqAneIlOUtZ+zcKpfTaItKH1M3hDz8ksZqSGffW7vX2/i1FepT9XfcDGOCV2GLLrW
         oOuVEPxYn7gRUSG+ib3GquumduEIFEeOAw9Ey1iC1XcM6A2mZvfXvr34BjipqO5orVqR
         KQ/xp6zXAjueVi9Px+MifdRmPvJ/Depa4DhORCldsE224QInMSFjGfnJLp/4yeA8p7Ur
         W4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW5CFguHJvO5vGtQvPqTQp+yt2uT5ieP8AziSByCPVRoCWjKMf/kJhuek/KlLmZNdxiGo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5AbkV0FGT8T8A3WKTKHVEOgJiyWO8pyUdxs6bM7ZbLMss+YA
	lSz+JCmOdUy2RDxvY/rOIUnZWEu/AvmT0fTRXO6PG5ryCOKxuZDVPcrhTOlAVZh8nCnlmaPs5yf
	bc2y3ZXN6oBkSi4+bJvMfFZ871mo1TS3G
X-Gm-Gg: ASbGncuB1j3Ea11EyfoY9Rep3Uvt4iUr5nO6qJLArVFXwro/AJdUaW8KOo8UmYguJhq
	TT52MXdY0OmFDguGMHZQoqRxIOFyhNanwDD2BaLOHWZM4bOA=
X-Google-Smtp-Source: AGHT+IEQWvphcMoA5q8SumwYA/Er/7EXquvh3wa8Pg5tm+QxoV1VLOnfovV5X2IaLodgRfxAjClsmAExFPhEZgYeVb0=
X-Received: by 2002:a05:600c:19c7:b0:434:a781:f5d2 with SMTP id
 5b1f17b1804b1-434ddea7f36mr35671015e9.5.1733509591874; Fri, 06 Dec 2024
 10:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
 <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
 <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com> <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com>
In-Reply-To: <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 10:26:20 -0800
Message-ID: <CAADnVQJ-y4G9TH-3kgau56OdijFQ4ua+_JNqv5VYFE7AzL418Q@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, 
	Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:42=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> Or, *importantly*, if user anticipates that "freplace-ment" BPF
> program for such subprog might need to invalidate packet pointers, but
> the default subprog implementation doesn't actually call any of those
> special helpers, user can just explicitly say that "yes, this subprog
> should be treated as such that invalidates pkt pointers". With your
> approach there is no way to even express this, unless you hack default
> subprog implementation to intentionally have reachable
> pkt-invalidating helper, but not really call it at runtime.

Exactly.
This artificial issue can be easily solved without tags.
The nop subprog can have an empty call to bpf_skb_pull_data(skb, 0).
And it will be much more obvious to anyone reading the C code
instead of a magic tag.

> No, it's not. It's conceptually absolutely the same. Verifier can
> derive that global subprog arg has to be a trusted pointer. It's just
> that with pkt invalidation it's trivial enough to detect (crudely and
> eagerly, but still) in check_cfg(), while for trusted pointers you
> can't take this shortcut.

Not really. We only introduced the following tags:
__arg_ctx
__arg_trusted
__arg_arena
because the verifier cannot infer them.
We are _not_ going to introduce __arg_dynptr as we argued in the past.
Anything that can be expressed via normal C should stay in C.

