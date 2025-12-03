Return-Path: <bpf+bounces-75934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F4027C9D77B
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 02:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4742B34849D
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 01:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F05212542;
	Wed,  3 Dec 2025 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc2hiE6b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED718A6AD
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724128; cv=none; b=twcvrrvDlxZJGtCIa7tSm21qThtMByGpHiBpFXr6x2WlmSfBjl7O+bUktIYOguETay7JUTbBXX+mFdDOo9GW4L0NuqMaNfdvK1/J39EAl7ZYnbdptCmCkUa368EMiqb57pvSqTtj3O8ira/3F6IWosb3IS84eZDZM8AusxqA4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724128; c=relaxed/simple;
	bh=rQBTAgJOiuh0kbrtjtVKx9aAufMuNrbTiT6AgBHP0Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3R3qqmp00NfqiYmMHF1JiEP2v2Hs6ByWaqEzE7c2lZVRXNAfcxGN/+KOFMfKCdAC4ZLOCeoxPKxOkNiBb1QssxKe657IGEZgQ/lfxaFv6zy2Qlvfp77OYS4GdrLCfILUnaiGfdhBderKqKPr7bE3WX6SXNOgW7JHjQNiNvJZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc2hiE6b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso45631395e9.3
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 17:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764724125; x=1765328925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIi6UIN9E/Isqx0YiTULoC3prR4kNRXtnKzNbGPgQoE=;
        b=fc2hiE6bICgGFujg6FlqH3aopkV+gv+sRNjmX1097pnjzsxGSLGYHplduD8M76sVGT
         gsU5yKRTeZN62nOaS115mVFQ01plKucvQEc7yD0oy0m9ekg/P6FKTN8RcqKmov/43JWQ
         osxQRkbBe0jSh0QmX4wIcMhzWmt/v6OjhpVIOU2BXawUBh/TWvDVPKbAyPy6bU3nPcHl
         0Rl4mEHk7hpj+N9Z3B7eOXLMg246mPKmQBcQGWRkalPDO0RPaK5jsJc/ByPH3vqDmc8M
         im24TbeATX32Kv3gW9LTWESk3m218Z7T4PWJ2sKPoa6DvlgvZbLWHgrNr768wUuiJL0O
         3CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724125; x=1765328925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIi6UIN9E/Isqx0YiTULoC3prR4kNRXtnKzNbGPgQoE=;
        b=ded4r+bmLKVJW15oAJTjdl5WltT9pxVvpMqU3wpyDXKoxOJ4qxvppriiXjl5IkbMhD
         e3ALfORxwDf29f/qfUu45kwiM7CnREnT9h3K+GS4uTfK7gmZOr+OVANvPmooQ8EzA5Lz
         IdQFhQQDzyELjMiEGNf4t83UM5crJGePbkA3Slj/SxreEgtcyMUyBK/JeGxEA9HaC3gL
         xO9hvOVAHm+cvyyLDGp4shY/24yGiIytShTQ0wDDXfmVqngrbWnwKgNPmDQli/oO+leE
         ckO8MqzGbDsv/Ir8QuTyDIK8LM4XWRiWTgX/3tFLQ8n05+76iB7v4U/vHGQgdLXYaB8e
         uCSg==
X-Forwarded-Encrypted: i=1; AJvYcCXGWVvHlq/3SgU0qhQeRs+lIXPGYT/3QyQ0T/RJs/GNFBAmzA10TlEINaF01a4s7bJImgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSu26uQasRzC/CIhi6st3REacHjJs1jhYD3B2uK/OZRVRCr1Z
	SY4+hjeBtWdLfiw+kBX2L9O7tqEbeKiVGYCLw84TzWd4IuPgCNFiyjsFlPGkyvNIp268OkTU0FD
	EqKvAOk0hIYjghbIau+lUvowDBaz5NgA=
X-Gm-Gg: ASbGncvSjPmZV2wrPPZS2xw9IWzuUoXXe0Xxb3mQ4nm701RXlf22P9J8+vgVcvqXwrK
	/YfqDXk58YcjmJQ140lkZJAaEf7j17M365mysNrv8xvwOZuOIDGzsRwaM/t3i2uCgkV4ksoPG03
	9NjUVdJC8q9zHrMbYBEWYpV/UMAND9vx3XEdJ4UQ052NjbOCtmd3MAYIbAgK4AlHMmrDTuTVc1r
	3Q0XY6MFVwuEIMX2nfW1G1IpatFG0YkdyhLBh/TwE8As+UtZspTx3w5ZKrr8osq6XJ5wONu+UE0
	aQHw/BeJ218sty/xUe1hND5pKnme
X-Google-Smtp-Source: AGHT+IFndPLQVWBUqAW30QfS8nMWTQ4Ktc7AzLZ8be9oL4PguH/Rq3CbkaD4lvJMzSdMkqHaSQcTfWTomd5mEdWBNvo=
X-Received: by 2002:a05:6000:613:b0:42b:5448:7b11 with SMTP id
 ffacd0b85a97d-42f731e92f9mr230436f8f.33.1764724124719; Tue, 02 Dec 2025
 17:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128160504.57844-1-enjuk@amazon.com> <20251128160504.57844-2-enjuk@amazon.com>
In-Reply-To: <20251128160504.57844-2-enjuk@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 17:08:32 -0800
X-Gm-Features: AWmQ_bns2SAo6GhwUZ9QnewKZ_mMKAN-b__gi9s_jqQeY9pFkzYBhc8BDM32WQ0
Message-ID: <CAADnVQLjw=iv3tDb8UadT_ahm_xuAFSQ6soG-W=eVPEjO_jGZw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
To: Kohei Enju <enjuk@amazon.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Shuah Khan <shuah@kernel.org>, kohei.enju@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 8:05=E2=80=AFAM Kohei Enju <enjuk@amazon.com> wrote=
:
>
> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>
> However, __cpu_map_entry_alloc() returns NULL on all failures, and
> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
> As a result, user space always receives -ENOMEM regardless of the actual
> underlying error.
>
> Examples of unexpected behavior:
>   - Nonexistent fd  : -ENOMEM (should be -EBADF)
>   - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>   - Bad attach type : -ENOMEM (should be -EINVAL)
>
> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
> and have cpu_map_update_elem() propagate this error.
>
> Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF =
program to cpumap")

The current behavior is what it is. It's not a bug and
this patch is not a fix. It's probably an ok improvement,
but since it changes user visible behavior we have to be careful.

I'd like Jesper and/or other cpumap experts to confirm that it's ok.

