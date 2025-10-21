Return-Path: <bpf+bounces-71610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7884DBF8042
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C7418908D9
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C434F26A;
	Tue, 21 Oct 2025 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QevF9a9l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F94336EE1
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070140; cv=none; b=D4DrmpxKMqBizbSLZoseRl95h59VW7p+ijczazxhcC3XFsYIdoN5zrlUAOnPufBcQBNZU0eTdp40j64hhVzTAVxqLqgB/HvV6Q6lhhNOjUsnGsGL/zm3C4z30IH3Zp+1duVK+ESYpz/83zR8JVZT8ulR8K+GbIdMhy1jQQ1kCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070140; c=relaxed/simple;
	bh=W4E8c/f9fzvOrCVFwdRXUuApmi4nuIIdmCannQyhdGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VicqHRaAZJsoztO41jvl3OLEdhFvwMHraOvt+N/6N2FNlY3dLXDyMOq8tjzVmc/pjS00M1wKdk9H8Zjiewd6BYcNh5sfnilWmrMPyd9kAoI2steZWeSGd8sIdwThxOB1n5VdrRmEXsnMq1HgTHawv+3MEXRkQtRrlqogjaFeY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QevF9a9l; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so832555e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761070137; x=1761674937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4E8c/f9fzvOrCVFwdRXUuApmi4nuIIdmCannQyhdGk=;
        b=QevF9a9lYxHn6/9sWvr+Q05NV03ewUz/68rAZvDjR9MWd9xTOUQFrVCGMHonVzKxy7
         YYkD0w5s9rRzpQ2o/JeJJsahlnjVvyt/KXOzE11HbfOEOiY2S6HN2A5Gb+mwxH3IPluY
         5CnzfsuTblPNA40HTb5crnKN6Wre4WeF45bcRBSW3FFW8sBhKfiI5r2dGRxamocm6Tmn
         bVENP72EdaXCp4yqzlCkqdwHcOAJ6fc00KmKX0NVeb8O47cvM9yFqDFRwl7v9X6gBM4S
         w0LPNwbiHv2Dke39d2QTPyYdjmSNInewI/xAHMK9se5NO8nB0WRX4O9i5ZfhEbDCqEId
         I8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070137; x=1761674937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4E8c/f9fzvOrCVFwdRXUuApmi4nuIIdmCannQyhdGk=;
        b=WEZTB8iqn3P9Pszf8htms7PIq+5rZ2j6tN9mdZAOpfVDG2rk+3iqsrTcfZNqXiCi6I
         i4Dt33ml/J9gNYFZX/IcN9sJyf6aHdYw0zvgqFPWrUxgvE3jYUIOxgtwHfEGNUL1pOnD
         DKX5VtAEodC7QXvxgr/bfvdhwYRpT5igKKV5ieJeU0DGOqkyN9bISqcU4hx3LrCwKRcB
         pf9Of8zZLmD8xfZf02Tos0AJCtaHlriwIBz+uacSA4qQ4dHSsc8VOHXyyTjSvS5+vh9U
         XOtAFL9atl92ALGMP3n2xR4l4fKyL3Q7dwxXMMuzDRcj/g7eZZc5+ZUIpah472M4LiGD
         aazw==
X-Forwarded-Encrypted: i=1; AJvYcCXgSprbDh3goMtSZxE+3g/FRKVzmx9m1qyPHk3aTYo9feGxGbQ+R+1gtgyPoVCogeMH0NI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2c5oYItG0r7mymWXb53o0oTWli0t9UFrojgRvPqxwfx6VBfRv
	Kw6svGLc9U9pS36nniqkCGlY6YCycV1xtpLQfdIMlcoPo8uisZYza6YJQpVbcRV8wovZhlt3xGr
	AJhSnA6FcxJuASz8Kk/EnS+Nf8MnBw0s=
X-Gm-Gg: ASbGnct5PYCGFJG516Vux0FsvPK3TDuyXaO0VKA5W5pIOogROkwfmoB9B9/nrd2UrzO
	gc3qDtN+SrlUdIXUyj3D0HHOWr09/hALpDnPLNQPUPlK88081aTqLrMC/4f8LZWyhtR4ds/g5+9
	G8YcEf1PKE220IKLh45R9/kPpvKjPcKgN256wovkJrGYyjUO6HY+veqYvlxSVVfna6qJKTMjc0u
	bIBURaUZL+pz4MiUZ5YydSVDLh+IzWo022RlGMMdtcbSNyXITGFvAkaSVOEsr/UojjQmVPWa/ne
	n/Wc4By+g5I=
X-Google-Smtp-Source: AGHT+IHdsn/rKFausGClaP4JClQSiprrYP//zyqt0N+xTtvCujVXSdZGv+ri1Dwh0KtrZC44wBhKo/xWFkiyeMXnNjA=
X-Received: by 2002:a05:6000:40ca:b0:426:dbed:28c1 with SMTP id
 ffacd0b85a97d-42853266fbdmr448629f8f.14.1761070137230; Tue, 21 Oct 2025
 11:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <636d45a8-cdc4-46ce-b1cb-6d2e4e3226ae@hust.edu.cn>
In-Reply-To: <636d45a8-cdc4-46ce-b1cb-6d2e4e3226ae@hust.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 11:08:44 -0700
X-Gm-Features: AS18NWA-eBAfgFZpRKaKiUhMLpVkZXdgOJuBKZX6DPSvKwvPHjsHG6hpMcS15_0
Message-ID: <CAADnVQLFuMAYHXXd_=2ebnhsE_tECKrVcLwuOt9b0dK4-Ww+gQ@mail.gmail.com>
Subject: Re: Information Leakage via Type Confusion in bpf_snprintf_btf()
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, dzm91@hust.edu.cn, 
	M202472210@hust.edu.cn, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 8:24=E2=80=AFPM Yinhao Hu <dddddd@hust.edu.cn> wrot=
e:
>
> Our fuzzer tool discovered a type confusion vulnerability in the
> `bpf_snprintf_btf()` helper function within the Linux kernel's BPF
> subsystem. This vulnerability allows BPF programs with `CAP_SYS_ADMIN`
> to leak kernel memory by constructing fake `btf_ptr` structures with
> user-controlled addresses.

Do you proofread what AI generates for you?
Please do. It's hard to take your reports seriously.

