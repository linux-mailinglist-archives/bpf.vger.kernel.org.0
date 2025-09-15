Return-Path: <bpf+bounces-68439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB08B586AC
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 23:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD603B39D6
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 21:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F68272E43;
	Mon, 15 Sep 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVa5gk88"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E042BD012
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971468; cv=none; b=tvtRYxnbOsSFiW6lg/D+Kifn+JNwsAX12WVMcSht1ujIUqZ+RGtUxTwV6TfvxLffiXkrHmbw7k/ymVaVI6NASFp2MqZwBPyHhMRaeJ0ZvUfWazhrq6FZCwFie8d8UVe2z8ziV5xlEijzQFXFCAAzcuH0q4IjWRqYSAuCSia6o+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971468; c=relaxed/simple;
	bh=wArJ6uG0eZsYxFJisOiyS02y/dfMrr8/VMNJX72c7T0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T2WXzkZFqjVOG5Au1Ehf7V4fAvsyqpBK0gDNg4dK4BuSkXLC49/M6gW+eZxHrxNb6D+NR9o25BtSZ3PTIq6yxNloW/yry78sDM4ZRSlQGGuYGZ1XRoFwFVr0eJ1Rj+2Se2a4xIpIoKFQmFJSU/8DvVF7lw6yFe2+Jt2vqCtuadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVa5gk88; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26763bb9a92so11476925ad.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757971466; x=1758576266; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gV1HI/cFGnjROgQwqtPnHKj59YbxrzwIwIP8ulyaF3A=;
        b=ZVa5gk88FeTZ3SS5LZKvDPRLbOS6itWm/sRpyOC9dRF3K6JCuDx8d0teH2o4irLEtL
         Et1AS0IOQgJalfI+xIoeU3U6SauBtlc28P2Lb1LMSKNyy7mYmjDhCoJZDsKWXfLs7Zj+
         /Y69/3zGEgGEB2bqkX2zM9ZvUjm/FusQp0+afm/o/ZO8J7CsfvMhFcN3QjZbmAMz34Zx
         IshdzJ7gG5M6mEILqYVHB5sitxy/NnVgQ+BkjOm39wYyrZfzVOQxpJcM3Ofo18f5c2qC
         DmPCMunXp2nBEZ2UKzOI59lQuVI2/n9dH6MHoFpDvgQq1C2ITU8X3Qrk3yTW9swchQgE
         5uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971466; x=1758576266;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gV1HI/cFGnjROgQwqtPnHKj59YbxrzwIwIP8ulyaF3A=;
        b=MAWItLhFz3GX8Y7zzqPydfRyvVs0m/bklxr26MCCxILLlZPmIW4fiWE2LZTFc8d5gk
         psur78PevMuGADUFH2Nhs2UV4Szyl+LQjgAeSxp5z89gVepL4rWfJ6Ria3Ytu57WBeHE
         mvyQ+EYlbS15xJFNl+6iZB3jBLiwJ53aF2i/q6Sx4bXtInJX+qwkegeb91UgvawpCU0y
         qdcI46oXo0aqZ0t8skMGyRGGMLfmQ+dnWUtrvKinXIT/EZBshLrgDNeaH5KpKagOC6eE
         6ympV4iAPbxSW0OlfuI5mGwDrV9GZ9DYx3xRtVBKRA3racJkdy/N/4wG6fNQWox74E5m
         VYpw==
X-Forwarded-Encrypted: i=1; AJvYcCVudhK98MpkHMeuwk6qh/uVKYga7MZ8Ps1G2fXxm+cSSeoQHWDXYU3p5qnBlzrCIJaxBuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI124JP/peNGvEw3zy8izcB2xM+6i73mtE/WrqDGCkys2fv0FS
	wXGJXOJ8rwU/w0pZ1R3eStCrzTYsXOBKkKne4iO9IjRRo7MjRPOyytAuBOLv0Ryy
X-Gm-Gg: ASbGncvqaaTkJx5TvBurgb1KlJ6/rNLMwNpt3LT9MbSbI/EHW/258CeJy1qDG75SvMw
	czUl9Igzmnxhlxnv8V3oXPDIm9L5hX9xxZljQJj9y8LrQruMhSC3D4v4Q5x57pGHprvDAIf06N3
	dqg9MUTzOQWgp0mTced0l5tZIxtRVvAy8A0NjZ3ME4uHSL1ZdaG+iuRp8Cj/aBpvl/lE2E7ora7
	MoFAmzKq8b7kDb6D5snKv89ZURuo9fryePg2kFYgUDllmN03vxmQU7lSGkcGL0FxfPKH4vaGm/2
	qiE0A1i5RT+M5lJ724Gv1fzx/1ndj1c0NTJChps8CzaMFONjgUQSskuV1XF5txlYCP/wtpMgLSo
	lZzp+1y6UFhDm6a5YkoGvJrZEEQqSjp+zDkYYIk+PA7Eg+TYX
X-Google-Smtp-Source: AGHT+IH7xq+slxNg2YRNoiFiOJFBqDA9eNWFKehtATpPYhDfAmMRK+vood5MxZsoBaS6t/pru40beA==
X-Received: by 2002:a17:903:908:b0:258:9d26:1860 with SMTP id d9443c01a7336-25d26d4cc26mr151785695ad.40.1757971465986;
        Mon, 15 Sep 2025 14:24:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-263f7d5698dsm60256545ad.88.2025.09.15.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:24:25 -0700 (PDT)
Message-ID: <86b6cedafb94f1663d963fed6ff13352f2bb02aa.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 4/8] bpf: verifier: permit non-zero returns
 from async callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 15 Sep 2025 14:24:24 -0700
In-Reply-To: <20250915201820.248977-5-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
	 <20250915201820.248977-5-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 21:18 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> The verifier currently enforces a zero return value for all async
> callbacks=E2=80=94a constraint originally introduced for bpf_timer. That
> restriction is too narrow for other async use cases.
>=20
> Relax the rule by allowing non-zero return codes from async callbacks in
> general, while preserving the zero-return requirement for bpf_timer to
> maintain its existing semantics.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ede511ac7908..102e72c8d070 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10863,7 +10863,7 @@ static int set_timer_callback_state(struct bpf_ve=
rifier_env *env,
>  	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
>  	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
>  	callee->in_async_callback_fn =3D true;
> -	callee->callback_ret_range =3D retval_range(0, 1);
> +	callee->callback_ret_range =3D retval_range(0, 0);

Discussed this with Mykyta off-list, note for reviewers:

  For function frame states with ->in_async_callback_fn set to true
  verifier ignores ->callback_ret_range. So the above hunk does not
  change verifier behavior.
  A change below is necessary to take ->callback_ret_range into account.

>  	return 0;
>  }
> =20
> @@ -17148,9 +17148,8 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
>  	}
> =20
>  	if (frame->in_async_callback_fn) {
> -		/* enforce return zero from async callbacks like timer */
>  		exit_ctx =3D "At async callback return";
> -		range =3D retval_range(0, 0);
> +		range =3D frame->callback_ret_range;
>  		goto enforce_retval;
>  	}
> =20

