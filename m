Return-Path: <bpf+bounces-60337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA7EAD5B51
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C628189298D
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9371A8F82;
	Wed, 11 Jun 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldm6CpJ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F5A92E
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657582; cv=none; b=qmh5dgNo0j6wSLtwuZuajY5N+dtD0ExTP1u8jeNw0blKGrrj7LR+AP9LkX0wD3Lfoi6HGTP66AL0+B8nJVdtbAcJdn1GmJg1Ohq3jcpkOGJ2KbJx57SWiYVgWYFaT5sp3bG9ZnRrUKfLMDUU5WGx5UQX5QjfyaP6qS0n/Vnwkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657582; c=relaxed/simple;
	bh=dH7XBgPYH39O6w+3ANk9pZ4bO4zC8SkrUYvpzBBmM2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBzycVfap6wHj7d9H5wAb4oNiD6mqvutyxHhVy5gf+BWlJXcriOv3988efBt9BUJiilNYPX4qtXO80AIUdRIvASP3DRMCjzn6+w5VK1/o6pLw6k+/ZLZ9n3w4wLT78Qkwuu2Ok9GI+Al0L4EO4TiN4bln8IrR390ukrcXzIA15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldm6CpJ3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so42881f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749657579; x=1750262379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH7XBgPYH39O6w+3ANk9pZ4bO4zC8SkrUYvpzBBmM2w=;
        b=ldm6CpJ3tCeCPyVNPM/WUbkUs1iqYj2Lg1zpTPuvZyd8gJlEV1pUAYYtFLl0KbZDSm
         2idEccTFitujxz6gDEpy4Gx6QWewum+86QdOWenL3X32Px+6bVYWaoFNYq4zZXVY+NDW
         GpiUGaCoYfHAI6sXbH5vkKdDxpNiTwM4OskjTAq8zOVWdZyUzkMmFSSCuxLG/cuzcHIb
         Gzo0BjtrKZm2IeaMPA88ukfgkGMUQP9N1sgfMV/YtgTi5/3HWLF+KEVA6t8my68OBHEt
         fWxnnGBXr1QcXMa7/6U+4X0AiD1orQVjyDlO6boBnLmTP6OAPcmUTX9j5bWLm1dGnzpz
         4nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657579; x=1750262379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH7XBgPYH39O6w+3ANk9pZ4bO4zC8SkrUYvpzBBmM2w=;
        b=lTfINeLOqkIwFMzgO+CLWQN+fvMpvZd7ZfZxcNalVeEa6nLsApUuiOvdMcHZAz0GS3
         41deWjhIuDLO4aa4AOwsLUHmu70JxDsRtRBTTxdajVnVNUYf4eMfT/qHJUC1jxEUUznu
         GAj9eGJqWLZDrWICP0XvtL2XVoMggDpBXXIJhVT9PhXCtX82Np8t36wpDGeEmFoBkVMk
         /HSz1lVLYldBO8qDB9yUpDvprTlpOpc3MPZKCbCmH1GjTiCHZbmgxA8KUZYq7jGjjYEL
         H9gtykLhLvfb9ZAsvZe2VzqYzERh7pOq3HF/5PX0Ljzs7lLGFqTyy2cu2QmyHLByDa55
         l6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2VW3EN3SvALXHz4qA6++Vtcswj2rX50CAJ4g5x5dFNju+gUDR7h9CJzxUvT6Jisp799c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20bcwDnLYtufmHS3cnZpwWhxmldjl3ZEqbzi8JQH30CzHZg+a
	08p8voyGzFQ7127V4BX14YjBbthbrPTxsor1aMgpUNULhWH3CYh2KymyqRUspNOcI0r5K4GDD1J
	yN1kN8/zLxC75r5DmfjW5UUBndIofeaMelQ==
X-Gm-Gg: ASbGncsEpSbr2dpJFhITbng81yba6xppzTTcCb0CXUUFbaDK2jCDvl/5djm2MnzXJFQ
	RkjX9yukSI/WPoxNFvKvLAxHUfj7FanQ3xGDYqdslSgeJzMN2grHLkYmhYFPkd4TJmr+fsSIpia
	gck/LdjX1C5lJ9ZW5njEOQskH8AbXFnBfqqkN5qmv1XSP0z4/K+vu2vqP1Jzu5XFDUgQhf20Uz
X-Google-Smtp-Source: AGHT+IHCaXUAQp5iGJUiBCeCLolYWdTwdRyOz0/OM8TZjkcRtq499PND20fOwh9BM33NgDMEGbhCSw3kJhOrQk3mqmM=
X-Received: by 2002:a05:6000:18a5:b0:3a4:f41d:696e with SMTP id
 ffacd0b85a97d-3a558a2774emr3248146f8f.27.1749657578578; Wed, 11 Jun 2025
 08:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
 <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com>
 <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
 <CAM6KYssQwOnOqQT6TxHuu1_vDmmuw+OtFB=FwPLqbFcv+QdVrg@mail.gmail.com>
 <CAADnVQLFM9s_Ss7eqyx47tiY8i2b2dt=RMPHMC_s67Ang1rNBw@mail.gmail.com>
 <CAM6KYsuVe10f39kfaJaQEUGGA7xjmkALxjRSQxJRcGKAw4KtGQ@mail.gmail.com>
 <CAADnVQ+qS2V4j8ADCK+6GoUXcDnS+6+t3yLiTQY-GQ=Kmj0ymQ@mail.gmail.com> <CAE5sdEgmDBkQYnv2qReOW8fYBpK09VpZigLkAe_GObRXOpgZAw@mail.gmail.com>
In-Reply-To: <CAE5sdEgmDBkQYnv2qReOW8fYBpK09VpZigLkAe_GObRXOpgZAw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 08:59:27 -0700
X-Gm-Features: AX0GCFur8OG5gwx-WXZ3wFhvLRMdm9IMNjJSydenoqf1SLMPiI4-Hd6eJMN_eGU
Message-ID: <CAADnVQJ3yXo1BVwB31rymfJyY_HL2VW4_QFipOgmKxrMaOKZyA@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 3:07=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> <SNIP>
>
> > > > text_poke_bp() takes care of that.
> > > > That's what the "_bp" suffix signifies. It's modifying live text
> > > > via 'bp' (breakpoint). It has a multistep process to make it safe.
> > >
>
> We are almost there with our next iteration, but we are stuck with a
> WARNING that is getting triggered when calling
> smp_text_poke_batch_patch which internally call
>
>
> smp_call_function_many_cond during a watchdog callback trigger.
> https://elixir.bootlin.com/linux/v6.15.1/source/kernel/smp.c#L815
>
> Please let us know if you have any suggestions around this?

That warn is correct. You're doing something wrong, but it's
impossible to suggest the fix without seeing patches.

