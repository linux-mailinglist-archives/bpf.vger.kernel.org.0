Return-Path: <bpf+bounces-57573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A67AAD100
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFA3982D38
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB121A94F;
	Tue,  6 May 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jelULrxF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443A4B1E7D;
	Tue,  6 May 2025 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570655; cv=none; b=leWWxq7v3FoKUOIg94O1y0wFi7ZUEjgoVDVgzgIlBd3aBcCn3/U0k1A+390mVuKRmReIZB7e324XAmVFVElLq6eL3j4sv/DysjwSk7DSdmL6UDna+vYRa3MDaTlEQOZHWsSE0VK9ijH307pPZ3LavaqU3U9gAs2/zjcdjF+9hos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570655; c=relaxed/simple;
	bh=M6LPnQq+WZYUyd/hIR9a4L+W+SEAzNA+KptcRWHRs2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRvebPRNrX5eK8zruHm+oyvJIrWgSo2LrmkDiZuFjS4wC73R4ipT31gBnNDp2wBqip1jNECYGmyNUVcmHveROKM+G79c/gOTJIo3DmMLoVrkNVMZzNwTi4kn9pWAsy7HEzBRdShbdteelYt2NBI9CtxCot+yoJXRtRDF9JPVGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jelULrxF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b350a22cso5192137b3a.1;
        Tue, 06 May 2025 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746570652; x=1747175452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGwmKF5kjz2CGDdNgVyzlfucliVOYpgZZQ98I4N81Zs=;
        b=jelULrxFiOwsgHIvuMbYc4HwMJMbjQVbDkURwqCYfSL6lsgEb7B8JXxZzT+SDgIskM
         POzmUR+WyFC88WBQ9M3xK1+Rn2eq9LbPKtbVnTozk2Dbtr/8HHEf6UZjhAeyaT9n76XM
         Hsp0S6sgEZjFTf/jUSEfTX9Ni95WTEPEfb/gFzk0d//ezJJrpQvUzz99I57CUSHaU85o
         V/Z7fz3C7TToX0pMiT2vNS46XKOzktj+BVrgxgMeG6k0Yzds2njCX+ZxnWlxPrBYd1bV
         QDKL714X8sp89ec3sQ4bPAqpeZ7mubYNwKHlrVHtpsuMtemC/friNXLJw/dUxMK1kfbg
         3QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570652; x=1747175452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGwmKF5kjz2CGDdNgVyzlfucliVOYpgZZQ98I4N81Zs=;
        b=uqwB0jACQatIoj1V7O4UtytMQ9tk4K5m/I2bmmoKZWgAomwfc8mZcFDp9pZ5Pia+GU
         5LXt5w2xnCLAF2ZrzBWP/K/j5d24hCk9ZHWQ/i/MP9XgglhSJ5rlbN+kLguaGRNrmrgo
         JJP5jos/hljkRayaxRgQ5X4n47ylKU4Qqt7kb5nvmCqHrYpdhzjxhuUfUpS2RM23OZfD
         xHc2DbVeTUwyXIT2YrjzDYWPV3M5drTdweIgFIteS2dQEwLyPbQWdPpm6QqCgerxyvzx
         p1v+R004+7sjO4jNDRDWxJ5ovVBYxSHmtlf8ScRCI+yqhQPLC/kDUuJ0Cd87L/Ls0MCr
         uZew==
X-Forwarded-Encrypted: i=1; AJvYcCUIwLYuhm7wCSjuIlnmNUCARWvpL7RUlWn/x2xSCLA2Nmg2xBpINI/jhu8Fm+oFLPApBgn8jZDUKpLh2+SkOzBoPaFT@vger.kernel.org, AJvYcCVlwXGeWtCB6pDuvSGGFvXdt1smin3GcvctCc4ulFJP7iL8RXetsRHf6wojawQ0t3lTZ2VXuwGYKcmZu3rn@vger.kernel.org, AJvYcCW7Zy22mL/d3BhEoPAKq8QgBkt6HuzhD2zqnEACgX/lCYVYpmmgprMWkz/X+2+T6zgWyMQ3Tf/i@vger.kernel.org, AJvYcCXUoz0Q4JbMrOJHTRFY5THFhKw4KA9IcZ7J1LebRI76WaRFXJlYlk43Mn59AOPrZ738slY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ihxq7NkGNWufX6OxEM+oIvZjjz9jjd9G1/q/MrdN+QBVLUv5
	a6OIy3F18K9UYf+eGbYWBe4KqBllgJmTxjcGtJxl27Z5KwY/Y96fHEgNfOICtvyFowgLex7LVJ9
	PQncs78MfzRKSD1T+D4JEO4JGP8U=
X-Gm-Gg: ASbGncsIzE4Elqr3GUKXtt0BRVX+YRwQnkrk0UyktH2aAVR52s/7OEo3DlsLIoNwTuC
	iOHp32fgi6cpfHPOTbIAb/uZ0O+n2MUSYaM5YNmFdlyTVOQUG1pauHNvAToAdC3FINL8nxCpZuW
	8lVvyf0mbGxAqq7E8ECVD/z35AU6OkqUChUJ8PBQ==
X-Google-Smtp-Source: AGHT+IFRT4bPAgK8JDFFq+i2BzaYK8yMh7nBwFrls+mABRH23bU5PRPSRFhkLVlyskG4/ta/vyXqg25SsaMHZwnf+KI=
X-Received: by 2002:a05:6a20:6f87:b0:203:c461:dd36 with SMTP id
 adf61e73a8af0-2148b113868mr1327166637.6.1746570652156; Tue, 06 May 2025
 15:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506061434.94277-1-yangfeng59949@163.com> <20250506061434.94277-3-yangfeng59949@163.com>
In-Reply-To: <20250506061434.94277-3-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 15:30:39 -0700
X-Gm-Features: ATxdqUETSD4zY0Brjmdir8LRxVrgW6L6sBojvZaIC7oDoprK2jltvmYBmRuBIeI
Message-ID: <CAEf4BzbqrvgD11M5nTwP=oJeNph6n63qAZfW8Qu=MB9k3h_-ow@mail.gmail.com>
Subject: Re: [PATCH v3 sched_ext 2/2] sched_ext: Remove bpf_scx_get_func_proto
To: Feng Yang <yangfeng59949@163.com>, tj@kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, davem@davemloft.net, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:15=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> task_storage_{get,delete} has been moved to bpf_base_func_proto.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  kernel/sched/ext.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>

Given this has dependency on patch #1, we should either route this
patch through bpf-next, or we'll have to delay and resend it after
merge window.

Tejun, any preferences?

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fdbf249d1c68..cc628b009e11 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5586,21 +5586,8 @@ static int bpf_scx_btf_struct_access(struct bpf_ve=
rifier_log *log,
>         return -EACCES;
>  }
>
> -static const struct bpf_func_proto *
> -bpf_scx_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
> -{
> -       switch (func_id) {
> -       case BPF_FUNC_task_storage_get:
> -               return &bpf_task_storage_get_proto;
> -       case BPF_FUNC_task_storage_delete:
> -               return &bpf_task_storage_delete_proto;
> -       default:
> -               return bpf_base_func_proto(func_id, prog);
> -       }
> -}
> -
>  static const struct bpf_verifier_ops bpf_scx_verifier_ops =3D {
> -       .get_func_proto =3D bpf_scx_get_func_proto,
> +       .get_func_proto =3D bpf_base_func_proto,
>         .is_valid_access =3D bpf_scx_is_valid_access,
>         .btf_struct_access =3D bpf_scx_btf_struct_access,
>  };
> --
> 2.43.0
>

