Return-Path: <bpf+bounces-40277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091EE98509D
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 03:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922B3B22458
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365313D2A9;
	Wed, 25 Sep 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lufmKVEr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AA13C683
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727227453; cv=none; b=XFI1tpL3CFxPl6w30jZD7AuS2LJ8L1FKI8Bw81OmPcfyOb2maCCbyZTprz9ZKoq6rq5cin09PufvjuMUigNIXhl4/TmEdHxSh5OXCPJvXVs3+Cv4GQsY4pnMyMplDKUoSU0KX75shpzh4xLrsukmzTt1Vv7Y9gkXXEpwUJM0xQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727227453; c=relaxed/simple;
	bh=cB5ICeRSFo3WGPxLr2kAEi2UnnnU1jorkH+YMoCEYSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XAcF92oS3gbIOtzDpUrZl1vmR2JJ/A3QcD/H287HhL7ehgFm2G+PaK4GO00aEnsnc1UpkiuEpgIM2il5wjgBMwnp+vWyBDAO7PhJAssvoXPyUsSGfGdCkym+D3Dl0EYKhLNIvw0Lwrk29W2sJnBd+Vdjlly3n4IdI5TuYIh9/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lufmKVEr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20aff65aa37so1328545ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727227451; x=1727832251; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iE9Hsfi93vPrhu2/JR5xnkIBhaGBfHAVoTeu0qf8mI8=;
        b=lufmKVErJxeoz1NqksoKTNluigYfN2gFvXQ8RC90m16/OJI/51S7Q+EtGGMOW8aUxn
         NnqWNu900ZqlBegq697qL3FWfxsbddVy0VwwifiHjTfnxOvo9sRBVfURw9n+PQhmS2r2
         RUkXStFaU5I7p4f2zOdGIcdgChv09C6E4B5VN2QoEhZ+g9d3VQrGSrdEvnNGA/uVoBWU
         GJK6D2VTvucwXsOy7aKWLwQPJfOIxVgOhkt/x4yPLB6MQwCPKjuJUUCq9SWa00WfJ5ZF
         dOHDwjTyw+kJXftN1SMOHOuI5hTPoS1bQfednYXxo8oib2lF5OkRdIZxs8I8OPy4/81i
         Hrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727227451; x=1727832251;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iE9Hsfi93vPrhu2/JR5xnkIBhaGBfHAVoTeu0qf8mI8=;
        b=elx8y3FLNh7qdw739pdKGa0Zbc/tUD6n09vLlLy2Op6yVY2L5QPSzPI64K4L6mNCID
         exMHEm844/Qo6X+LlgPJufr8btXlWI5Bk21X9YpbgDogJPK+t9Tqek3xAJ0Ayby0UJeS
         jhKQpK/QIfNKuo7o3KOAm2ECDngzeXUo5M7f6Af9wogmQBuolqDzChXQ0TrdQOWRhOc2
         vGKIncrzJfbNUiBZyYOoGxtvQzrAnlO/qZreb99Ck2DecSufvA7V+Zg9oA/bJse6wT7V
         6lPPN22D/mHxaY7vrwQIVJ2dWKtwNfxa54Urlw8am0fb6woEZSu3cM9v71rfy7bsaV7n
         +Bng==
X-Forwarded-Encrypted: i=1; AJvYcCVdegI2QrVXNoYK6wz3/VMGNmoN9j3wP1Dyi0VySJT94OvmwcGOwVlxtl9jzIqON3ZPxvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQLt4oJfgaYwr0+fslAMJDhb4uCfEj4/U4I7s5ag2MhO/Q7O1
	zXfaPGt+hd0Sy+w4xBSFvoGAIBp4lVVsaxwAkdAP1giGaem4g6Tx
X-Google-Smtp-Source: AGHT+IHsHiLsixe2qlEGvR0FmCoonHhHk8HWReJDNPN/POR8GEs5cJSoM1UMJNKYjc6Bd2X4//1Rfg==
X-Received: by 2002:a17:903:987:b0:207:8e11:6fb6 with SMTP id d9443c01a7336-20afc4948e1mr17875975ad.35.1727227451293;
        Tue, 24 Sep 2024 18:24:11 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1e09e2sm208162a91.32.2024.09.24.18.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 18:24:10 -0700 (PDT)
Message-ID: <b879d9cf7eebd1e38492c76d7878a767b0245923.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Prevent updating extended prog to
 prog_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
Date: Tue, 24 Sep 2024 18:24:05 -0700
In-Reply-To: <20240923134044.22388-2-leon.hwang@linux.dev>
References: <20240923134044.22388-1-leon.hwang@linux.dev>
	 <20240923134044.22388-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-23 at 21:40 +0800, Leon Hwang wrote:

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8a4117f6d7610..18b3f9216b050 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3292,8 +3292,11 @@ static void bpf_tracing_link_release(struct bpf_li=
nk *link)
>  	bpf_trampoline_put(tr_link->trampoline);
> =20
>  	/* tgt_prog is NULL if target is a kernel function */
> -	if (tr_link->tgt_prog)
> +	if (tr_link->tgt_prog) {
> +		if (link->prog->type =3D=3D BPF_PROG_TYPE_EXT)
> +			tr_link->tgt_prog->aux->is_extended =3D false;
>  		bpf_prog_put(tr_link->tgt_prog);
> +	}
>  }
> =20
>  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> @@ -3523,6 +3526,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
>  	if (prog->aux->dst_trampoline && tr !=3D prog->aux->dst_trampoline)
>  		/* we allocated a new trampoline, so free the old one */
>  		bpf_trampoline_put(prog->aux->dst_trampoline);
> +	if (prog->type =3D=3D BPF_PROG_TYPE_EXT)
> +		tgt_prog->aux->is_extended =3D true;
> =20
>  	prog->aux->dst_prog =3D NULL;
>  	prog->aux->dst_trampoline =3D NULL;

Sorry, this might be a silly question, I do not fully understand how
programs and trampolines are protected against concurrent update.

Sequence of actions in bpf_tracing_prog_attach():
a. call bpf_trampoline_link_prog(&link->link, tr)
   this returns success if `tr->extension_prog` is NULL,
   meaning trampoline is "free";
b. update tgt_prog->aux->is_extended =3D true.

Sequence of actions in bpf_tracing_link_release():
c. call bpf_trampoline_unlink_prog(&tr_link->link, tr_link->trampoline)
   this sets `tr->extension_prog` to NULL;
d. update tr_link->tgt_prog->aux->is_extended =3D false.

In a concurrent environment, is it possible to have actions ordered as:
- thread #1: does bpf_tracing_link_release(link pointing to tgt_prog)
- thread #2: does bpf_tracing_prog_attach(some_prog, tgt_prog)
- thread #1: (c) tr->extension_prog is set to NULL
- thread #2: (a) tr->extension_prog is set to some_prog
- thread #2: (b) tgt_prog->aux->is_extended =3D true
- thread #1: (d) tgt_prog->aux->is_extended =3D false

Thus, loosing the is_extended mark?

(As far as I understand bpf_trampoline_compute_key() call in
 bpf_tracing_prog_attach() it is possible for threads #1 and #2 to
 operate on a same trampoline object).


