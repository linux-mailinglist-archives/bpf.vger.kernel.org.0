Return-Path: <bpf+bounces-37765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B295A62A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 22:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419CE2873BC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02364170A2C;
	Wed, 21 Aug 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUbZ32N9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA51531C2;
	Wed, 21 Aug 2024 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273636; cv=none; b=KPbmgFsdJrIwH75aq4r6ad1g6BDRBfzo1WJ4uy1GXxk8414R2gwtJHROJ2HL7v7WqjX/sdzjM/RHqzSTeKKPiuMVJ6s6CyrwoApFJdBcKQEg0z7YFpNdHMy5TGKrhydu/kBp7KMV/s2v21hTPNkDZZf+SmEYz3J95IZUTEPiC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273636; c=relaxed/simple;
	bh=Y8x8mnP01sK1aai0J2Q7LfyNNNN2DKOUUe3Nf5uPSXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db6x+YdQ3BFEYfRVr/IFZkdrM9l6xALemRU0uwQO4NSyjpNuzZJdDWQeZH0eB9/gDEBrbD1874d2NrGYJFAtNVMXDKO2FRWtGG89/Dsvwk2UFJxwvPElEtKewVK+NO5+9WluBhKvemFDF3b479jsrAXun/Phqg36prHCHoGtBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUbZ32N9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371ba7e46easo32651f8f.0;
        Wed, 21 Aug 2024 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724273633; x=1724878433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pmNbOkLk6Vw7NaUfwNqOa4cILlublRrLXmKYRzAht0=;
        b=LUbZ32N93XTDhOP6niyxHufD0iDv6xlc6EA/4rgmA0Md5+muvkPxtnH3r3JKwD10ad
         TaZ0vthJuc8O+5RfaJz5eu8JQhS5d5h4Km5xnjo9sr1yyqLDM4J33DHnNSGnGycUhKqE
         7hu90oBdDm3tCxZSPL6teLxx1y0gPnO12XNX5NdXeRkR1irIynqa2tPutTuAkfx+wnK6
         /TnOXVsJyeAQH6C3CmZYQ24YOEn/OUbOroV6K4BL7Cg2Mcwu1WwI3KkPsvjoexkKiFbD
         xPGFL4u7dfBsDQa/P438ZYFAEj+9DD/b25f7Ric2wAIqepGIrUz+9SPRlgA6GxMnDgBi
         A7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724273633; x=1724878433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pmNbOkLk6Vw7NaUfwNqOa4cILlublRrLXmKYRzAht0=;
        b=MACWeB5DSb1Y1R8nMNGE63Q0v81LmZRLRSw3FwoGjJNLl7dNy9lx2znq+SFdOCK2ov
         M+k+9vsSTzLxg/w/uuEZ30K92RsKJ0+uky5NT4d+yGQfhw0V11BmuPUzCw6/R65ezUJ3
         oP5t1WzXnLxh/7olvY96eNwIQyJdVsMII9UItJk2RLZ7tpHTAny0AtgoVrfp6btAVyWH
         M0pxQI+syXiIMK/pL03sXQI4X9wiyJrQ5nZAFRbHbQeFHB5n/reWfE1Ibu7NDdnPCG2W
         /b8kd9rNziN9/PFBNymudqCeT+2uwgiKidVsA8PDBZIY9nJ0ZzI2ku3V/iW5Rp2lB7Q8
         aOCg==
X-Forwarded-Encrypted: i=1; AJvYcCXDHtPB0yug0K4VZc7HlVh7XZIiSSwzFJw7IwN2PuxO4hI4vXIGINFJxXrkholJSvBFhnU=@vger.kernel.org, AJvYcCXqsOLctnVwDCXH6uBLfbyM0TdiVr1tHwIVgcJ39LCMRtmelVW6+63uEUxSZCs8roaVlYp1N7JCy86dhW4e@vger.kernel.org
X-Gm-Message-State: AOJu0YwvziRlO7tjTk+GJniAsu7yFT5uEo5L88PxcMWNSge9lhis6RDo
	RW4EEIo5pQSqzwlpGcRInwuX2bfF/qFobNm7hDA+Z/y8TzxxEA9CyVqTZDKWvGMRinXw/9Ao4y7
	Jpvd2L1LKy5fo6QcYiVFdX6xAoSo=
X-Google-Smtp-Source: AGHT+IEM1Jl5hktBSSJwRVctIKm38kFDx+ccRKkDoDIfUI1mvwNHNdwoIPevrNAn37zIg5c+jX5YwbaZLdkzGAz0nEY=
X-Received: by 2002:a05:6000:2c7:b0:368:64e:a7dd with SMTP id
 ffacd0b85a97d-372fd7265ecmr2230681f8f.53.1724273632878; Wed, 21 Aug 2024
 13:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848FD2C06A4AEF4D142EE91998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848FD2C06A4AEF4D142EE91998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 13:53:41 -0700
Message-ID: <CAADnVQ+-yTEE6_B6+VOjv9uZ-sP3bUogcNPk7cZJBUqpuQVQfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make the pointer returned by iter
 next method valid
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:16=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> Currently we cannot pass the pointer returned by iter next method as
> argument to KF_TRUSTED_ARGS or KF_RCU kfuncs, because the pointer
> returned by iter next method is not "valid".
>
> This patch sets the pointer returned by iter next method to be valid.
>
> This is based on the fact that if the iterator is implemented correctly,
> then the pointer returned from the iter next method should be valid.
>
> This does not make NULL pointer valid. If the iter next method has
> KF_RET_NULL flag, then the verifier will ask the ebpf program to
> check NULL pointer.
>
> KF_RCU_PROTECTED iterator is a special case, the pointer returned by
> iter next method should only be valid within RCU critical section,
> so it should be with MEM_RCU, not PTR_TRUSTED.
>
> The pointer returned by iter next method of other types of iterators
> is with PTR_TRUSTED.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> v1 -> v2: Handle KF_RCU_PROTECTED case and add corresponding test cases
>
>  kernel/bpf/verifier.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ebec74c28ae3..d083925c2ba8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8233,6 +8233,12 @@ static int process_iter_next_call(struct bpf_verif=
ier_env *env, int insn_idx,
>                         verbose(env, "bug: bad parent state for iter next=
 call");
>                         return -EFAULT;
>                 }
> +
> +               if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
> +                       cur_fr->regs[BPF_REG_0].type |=3D MEM_RCU;
> +               else
> +                       cur_fr->regs[BPF_REG_0].type |=3D PTR_TRUSTED;
> +

That's an odd place to make such an adjustment.
check_kfunc_call() would fit much better.
That's where r0.type is typically set.

Also, the above is buggy for num iter.
check_kfunc_call() would set r0.type =3D PTR_TO_MEM for that iter,
since it's proto: int *bpf_iter_num_next(struct bpf_iter_num* it)
but above logic would slap PTR_TRUSTED on top.
PTR_TO_MEM | PTR_TRUSTED is invalid combination.
I'm surprised nothing crashed.

pw-bot: cr

