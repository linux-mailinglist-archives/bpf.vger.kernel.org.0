Return-Path: <bpf+bounces-28203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E4D8B6615
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5001C21A65
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ECE126F07;
	Mon, 29 Apr 2024 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2HO6PqL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F477F10
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432581; cv=none; b=mnBNwjz31f6kuBrGF440XC3dgxKCnGYdfLANy0udvDXqkPSaGKUwvnufVmOXsyV8vKoDi2ZEem5qgJ7Z4SH1EsGsGoi3XS7L+yOHRNkIlluVG9nmNDj8zReO4fkEvrXQ6BkK15qrlrwFOXTGQ/qx6Jo0EfFZOR2c9KI4ohtcpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432581; c=relaxed/simple;
	bh=UQKuPdlcEh4mzc0AlCjS7Xe5vuWy0hk4iyvHd+736zg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hichOtZXqNbAGMCeGe7Fv9h2+0+OYjq3nPeZXghJ4+QmoKqWnyV9MynU6U4oAOKc7BjjF7sqpbu7PCx0rjKVmX1fZ0yWyBzljGqZETz4S9E/pF8CJpWvULWY0SHVnhCFsgwPIXzHkNEolEEeIYsjvH4ldW09YvY+GJJTmibLN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2HO6PqL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e65a1370b7so47240645ad.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714432579; x=1715037379; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cmndnruLHm02k0e6EzxsbB5vw5A9XTkrALA/8hULO5w=;
        b=T2HO6PqLNnp5izR2bWdc5WGkf9Ru4GIVeTUSzhavFlFs26+cOMi62TGVzbpw6GR2sP
         bQA6lhX8ReUfjjsIsaj/SrVKHuyaVB2DvyZVe5eDUZZBur8fznuBEoPTV/9rgMTN71RC
         xg1jaj51UlhQJOiYHPk2G5TLxUyj94u7iY4JJy9g0X8poJINt7SMOT+1IlOMQiRbhKge
         EXwOMPUgjn2TvcHK8MBV9vpA0oE6Z0czJRixUZAEG5949nQvNuLn95zLG6S4NVfix+xO
         pC8XLZfiASRpdiP4yGV1KuQW0ZH5q9sco0QiXTNW5vkqgXsIAASyZlQSxbo+kbiDlxo4
         FvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714432579; x=1715037379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmndnruLHm02k0e6EzxsbB5vw5A9XTkrALA/8hULO5w=;
        b=imfqOFVgYfzHfYSsfhM/F1NKTugrgooUS+jwqrS8ViLEvWX+zPF5XOkVg8zlozslZC
         fnPmO03evQV1vOqZaKtM0k+sdG/Gd7uopOVLlitTxkvptI7n620ioEjVXb3V22xn3aTP
         1EtHs4OXnUvYwQE+QWXGvD7JViySLUHgN5BPmtPMACoiS2a0yng/cqUdNGDZ1RSMokly
         mjJBy8NTZdaFigTi7SPsmSXmwwf/MkG1ARpJ1EPbMFcY7jK7qtV7+xEwIw9Vb5uqMU6H
         9ZBCJKub3vELKyP7H/2MQ6su4d7S9pVMRdcXGWP2WSXSftIZa8kUxLaRpEweicMZv1Xy
         F5CA==
X-Forwarded-Encrypted: i=1; AJvYcCWCgRz57WKT6a9Th42HgVPDX5HH8N8m6sfzsVPIPZQEQyYYMQJnbfa3hA8S4YWCsJJCLbhruJh6CmnO2rljzDHbkpbD
X-Gm-Message-State: AOJu0Yxe2npPFpYvQSDOKA1hh34djxxK7wucngieDc2HW85f5lBDJjA9
	VVBmPT/P9wvdQYv7u1Dr1GcXQa6s/o2nXwSkMCDUwe91KfU0srHO8GeAUiVC
X-Google-Smtp-Source: AGHT+IGpXewEZG8wZajU4dP7pLmrotZAO4yMpI3ra54aqrqA235fzkqSlLGSqLGFWtOoEKjnQte0ZA==
X-Received: by 2002:a17:903:2444:b0:1eb:60ec:32d0 with SMTP id l4-20020a170903244400b001eb60ec32d0mr10382413pls.5.1714432579150;
        Mon, 29 Apr 2024 16:16:19 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:a18e:a67:fdb6:1a18? ([2604:3d08:9880:5900:a18e:a67:fdb6:1a18])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e47bf10536sm20927608plb.69.2024.04.29.16.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:16:18 -0700 (PDT)
Message-ID: <e0aa743fd6044691d0b30e7b2761c8085a28bb0b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 7/7] bpf/verifier: improve code after range
 computation recent changes.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 16:16:17 -0700
In-Reply-To: <20240429212250.78420-8-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
	 <20240429212250.78420-8-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[...]


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b6344cead2e2..a6fd10b119ba 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13695,33 +13695,19 @@ static void scalar_min_max_arsh(struct bpf_reg_=
state *dst_reg,
>  	__update_reg_bounds(dst_reg);
>  }
> =20
> -static bool is_const_reg_and_valid(const struct bpf_reg_state *reg, bool=
 alu32,
> -				   bool *valid)
> -{
> -	s64 smin_val =3D reg->smin_value;
> -	s64 smax_val =3D reg->smax_value;
> -	u64 umin_val =3D reg->umin_value;
> -	u64 umax_val =3D reg->umax_value;
> -	s32 s32_min_val =3D reg->s32_min_value;
> -	s32 s32_max_val =3D reg->s32_max_value;
> -	u32 u32_min_val =3D reg->u32_min_value;
> -	u32 u32_max_val =3D reg->u32_max_value;
> -	bool is_const =3D alu32 ? tnum_subreg_is_const(reg->var_off) :
> -				tnum_is_const(reg->var_off);
> -
> +static bool is_valid_const_reg(const struct bpf_reg_state *reg, bool alu=
32)
> +{
>  	if (alu32) {
> -		if ((is_const &&
> -		     (s32_min_val !=3D s32_max_val || u32_min_val !=3D u32_max_val)) |=
|
> -		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
> -			*valid =3D false;

This check first originated in the following commit from 2018:

6f16101e6a8b ("bpf: mark dst unknown on inconsistent {s, u}bounds adjustmen=
ts")

Back then it was added to handle the following program:

  0: (b7) r0 =3D 0
  1: (d5) if r0 s<=3D 0x0 goto pc+0          <---- note pc+0 here
   R0=3Dinv0 R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  2: (1f) r0 -=3D r1
   R0=3Dinv0 R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  verifier internal error: known but bad sbounds

Apparently, verifier visited both conditional branches for this program
deducing impossible bounds for the 'false' branch.
Nowadays is_scalar_branch_taken() should handle such situations w/o issues.
Still, I'm not sure if we want to remove this safety check.

[...]

