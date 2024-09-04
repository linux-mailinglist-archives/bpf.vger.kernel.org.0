Return-Path: <bpf+bounces-38902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A04E96C47E
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9141C24E39
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE71E0B8F;
	Wed,  4 Sep 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCNtP05A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6B1E0B7E
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468978; cv=none; b=feuWMJ+fTU9ES9/4365gZm4+neKzCmnBfETYAC749tPfQcSHvVvHasP4c1/jcvGle+BLplUf5H52rwPI7a3e1Z70STrUNkQE0rKU262ZZFOeZ3DSiUp6TCSRYf9a0kXeHbF/JkETwDxeT2W+be894I4l8wq/mg1r3Z9XN1Dq2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468978; c=relaxed/simple;
	bh=967baYhzWeo6ScNDPF5zgH+gJOx6miNI+6P8H9BbxG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuynaYtXvEwFh6Dio+4vJZysyfyZv7x52AdvKAHj+/5BoJvelszwEZJ0St49FzuYPMQWKSwhwh9iy2RAAZ6AgU9nsIk13B/uglF+Vjts0JGMGIDaAhQa5YYSKdrMJY+NkCVANBAxJvwmADuiI1me6rWAu2kQ2Pt5ZhwF+yq2H/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCNtP05A; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso1967938a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725468975; x=1726073775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYQgJRYZmjAf4zYXWp2kUda9gmTr/Q00wleq6ZjFTiY=;
        b=KCNtP05ABs1klVeDU3gI4zUi0AP1ZGLrrcXkZ4DufXfAEJIwZ6JYp98MxRL5Avohu1
         Yr0YsW8IIs8Q/artOGglJRClYdxBPNjssS0jzWhtqfMF9fTG586Fb3rNOAWFgChVvlBp
         QuCBbKbd8kTuTLrQ+Si1JgMkj0Nbos95ZMfD9H0gqHKDLBaYMecsnIgqBuyhS3gYbr5B
         6Vt0T9/SPhayWhdI2WIyprXRC/z/JJRcVXEfuZGM1pcC6DT2Rg4FeuZZ58/g6wVhAI8y
         4OGgQQWx8kWQKaWdH/bYMYO3Hoqxj6qr39OjEMQXEov9TAdal3NgWUwyduYwT4NCcuEU
         pbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468975; x=1726073775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYQgJRYZmjAf4zYXWp2kUda9gmTr/Q00wleq6ZjFTiY=;
        b=q1Kr+Viij5hYhahoqW/8Ku7cwvJVDznLlzxQbvRhNG1pDSbFVbV7usm/bveDuVgdiz
         kgDEWJYLhqjkjn1t2nrYBgZv5KV7vZ/WsCYYYKA4S0+ZUXd8Yi95/xEprP8YancASzN6
         yxu8tMJJfo0CNaMvDDd78UY2tEcoIbwZRKQb2sGw95fJIHSHgbHuvRAUvYDHzn6eIVCi
         Q2hEy/ZrSfopUeBsUGdxlmouFYChbREGXkcbi1+P7h7/1pWrJYWHlakdAiSN3fonJ1sE
         IEpje1gwctRCfmOXpVOfPCiJOCl7F7Qjmu0MedS7pXmKc/B06SdxcezbwDv1uoqZbOqB
         dW4A==
X-Gm-Message-State: AOJu0YznfavsnwJ+gIoh1fv50QxXuCXFhEVIIo0knTYqSNV9h/x3GXqJ
	8a7GUcF5DNY5Kvj2W5x9Tp3UfNUEpPT7FcNxFPvFiqbTFfTgwFnwmOWSmlKZfeQHpIVKwO3PraF
	DgrMPSIZ+OcMlaaz/Z7N4+W97ChE=
X-Google-Smtp-Source: AGHT+IGTu6qpcIO9Gu6SJ0J4MbFJ4QHGngrc0Peov6sU4pY6huXKjdo54y7gzCuk+rJzFyYWmfFGWkHcIJ/fs7kYgW4=
X-Received: by 2002:a17:906:4fce:b0:a7d:895b:fd with SMTP id
 a640c23a62f3a-a8a42f8ae77mr250071666b.6.1725468974640; Wed, 04 Sep 2024
 09:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903225949.2066234-1-yonghong.song@linux.dev>
In-Reply-To: <20240903225949.2066234-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Sep 2024 09:56:02 -0700
Message-ID: <CAADnVQ+iqrfTgvPieBz8cTpdUdU94tTrFW88xttwthqmtx2Qwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix a jit convergence issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:00=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 074b41fafbe3..63c4816ed4e7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -64,6 +64,57 @@ static bool is_imm8(int value)
>         return value <=3D 127 && value >=3D -128;
>  }
>
> +/*
> + * Let us limit the positive offset to be <=3D 124.

I think the comment will read better if the above says "<=3D 123",
since that's the final outcome.
124 above is a bit confusing.
I can tweak while applying if you agree.

> + * to mamximum 123 (0x7b). This way, the jit pass can eventually converg=
e.

Can fix this typo too.

