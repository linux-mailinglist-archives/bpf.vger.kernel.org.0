Return-Path: <bpf+bounces-57793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6FDAB02FE
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227FC3BAA40
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BF5286D61;
	Thu,  8 May 2025 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb1c9fzI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D949286D50
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729509; cv=none; b=EJOkczGNE4FQXbPJKwqhXpdTQsHIvwx5hr3j1yIdLy8d9bWg/YTPKx4lc1SC8x7fHjuTjnVI37FDipH0Ol2w7TnRcPV0W5DSCTMM5+n/3VBzYrSvc7IB1c8vq2IWdt3rGsV+Kb2lWhqtzAIBTo01PLZzyeqExh8aj21wja3tKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729509; c=relaxed/simple;
	bh=eLmGoDV5azfhVr/Ity8x+Ax3Rfb/Ellr5dsJoIV6Yak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npWi+x7CTv8TyWMpJWVZiD97+B0xvRnyFY2d6OfuKVTZePt/kQhsW/L/0JPBRg5WSQMAHvQ+zJgajvBysvjkT3RwqjNTLt/5f6IEv2rIReQqFZnAz/J2WXmCN7SJy3eW0l6fQNdng/pnYsumYsaWUrJc3q7sWR3ZeLie48sspYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb1c9fzI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0b9625662so871911f8f.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746729506; x=1747334306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7Vt6IAAlvqcJxjnO9zIry8jY7r1g7sVt4ggWZO+ol0=;
        b=Wb1c9fzILAEM5xnKyXwRgdsRq9rkcvKdSSKgwwQAe/KwYLtPHOv/xWuJ6LUcg3VydL
         YAcqunz+VbiMv7AkW57mi5afIb8dMmDslHfx8HPhLeGasnYy1Wfic7maHHSX7aV9EZAb
         dHBQQs212Jp/prE2U+0yVsQM7D9YpGQ7w/1knVK9ww0th9kCv+esDu1DeW37mSS4U3mm
         WXvbt1dZEOEB5l7TokEvcyUZzZOV/Gwbb6jvyDH98FLDgK3DtQ10s8RcVB0Uo4jW6Jn3
         Rs3tvV9eAWkdo75k44WUkl/3O2Qnt7C9qhz9kQfIjMHqm14la4CsQTc5q1n9r8LebvmQ
         jPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746729506; x=1747334306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7Vt6IAAlvqcJxjnO9zIry8jY7r1g7sVt4ggWZO+ol0=;
        b=ZUUgEi1qOOYsIA3uwhcm/URCvuuRns6kE0nj81oA8KfcVOIOagJffFiS15qS2GiAoa
         uEsaf6OfO1PXRchZY+aUQ/WhNvn8wGjpbH5h2VjAYCX3j4ytLV7lUdVDwCm+QHJdiJvH
         h7BkFZKoNYfMekGUbVU2bK0OKO7OsaNzrPQPngL4QBQE+H6gAaFsiT4TrrELpk7n735K
         G9vx7gbfzSmLR6YLRAywOg604IUBmPFfu8/5ehhKU6oYrKcLiicDmJSfw1HFWTjiBybP
         7SFbcnRH1OmisafgVCipZIVsb/KB/J7JKo5shfLYZnEgkHcJoXyi+TvwrX1qhh+hNIiJ
         3s6w==
X-Forwarded-Encrypted: i=1; AJvYcCXcDLQx/wVa3HXVKctelxQJVROpC3X0fLNNsJYhgJ43Xt+o7N1Qx5C6t/KE3bucpUtXAHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/HhBab7DAQc8OmoEdvp1rbhGt2U2kLrclbqXutfGuYV5n1N+
	1jxYZzbGLwYdP1AXnpnuGRmfLscW7fgyuPjtWjsAhiSvJjbgoM4F2O2UxWI428cAz6D9BA5BNcC
	486CpCPP/87DOTV9c2nxuxXzwxyHmJw==
X-Gm-Gg: ASbGncvyKy7XGg71sTkt/4QVcudLEiwMKrjey28IH3KAfD6ohTZdeIqs/TioqVO59ri
	qJWZTq2xwZViWXgqlfNw1VStTMukSzKwFW/EdQPYWNB2zVGHrBf9hkM4DnC2EgguXGL5In9nAKT
	e8cNN6/JZ8Zl/GuIWabwS64BTQHQ1n7v4oWn8xbQ==
X-Google-Smtp-Source: AGHT+IGYn38rMNTKrB1s0jj7olHZCrPfyGiFVEg/p+XytHwj5UwquxQehbT8u/LGBRUnRlbwY4x/QUM0qhuag6NLxVQ=
X-Received: by 2002:a05:6000:188c:b0:3a0:ad55:c9f2 with SMTP id
 ffacd0b85a97d-3a1f643a75dmr456796f8f.1.1746729506459; Thu, 08 May 2025
 11:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508113804.304665-1-iii@linux.ibm.com>
In-Reply-To: <20250508113804.304665-1-iii@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 May 2025 11:38:15 -0700
X-Gm-Features: ATxdqUF-K8cUCeXjKkiIN-gihq_yYzkqKa-p3ZkgMtkoyPHgYO6FZ0ojNAxTe7k
Message-ID: <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused" warnings
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> clang-21 complains about unused expressions in a few progs.
> Fix by explicitly casting the respective expressions to void.

...
>         if (val & _Q_LOCKED_MASK)
> -               smp_cond_load_acquire_label(&lock->locked, !VAL, release_=
err);
> +               (void)smp_cond_load_acquire_label(&lock->locked, !VAL, re=
lease_err);

Hmm. I'm on clang-21 too and I don't see them.
What warnings do you see ?

