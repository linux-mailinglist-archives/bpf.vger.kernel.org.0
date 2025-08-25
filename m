Return-Path: <bpf+bounces-66477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F94AB34FAF
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 01:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E43B5E5967
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6029D270;
	Mon, 25 Aug 2025 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ50Y0Ro"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828C277C8E
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164563; cv=none; b=ghZfY0uY+tOwwCJ9z42S5qEIbq9HOMx4nNAuqZrBjv9vBSgx/DQUW/ohbiECVgwmOEms0BMZ4CT/6bkZqWaqEyuKVRDalzxRJnpg+pzCyk8aXbSLEOp6R36OyGBrxH9q3jhEX2bSnbf2CqyP0NVK1Dbw4E7oeJMmGJ6cc2Oyk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164563; c=relaxed/simple;
	bh=79qznM1H/tMi8Hlav0B1pFzgUWTdKciqdFQaL2SPAKI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGZkqFFJlWv1sjBGX9yBv0MjepwqaCj6U2xxqgUhpMcd0RDdI5ZqymsBfX54xcXf+sRyOT13PjoSo2AUBl9y0D5tgW2wKZq4QaaRvovojvUMeiQ4N3JbpXa8B3oZK4XVYpw9OXGnbO0mAp1F3JUyA7iahnUABqwVYPKd1fcJIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ50Y0Ro; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so3248883a12.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756164561; x=1756769361; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k7FLfhss0OQ7b9wO0+lRJA7QH9ewA3hhcR8Fmrn8Zk=;
        b=ZZ50Y0RoFK3HrhWfIHlXRn332wyLhPykk7RzuZr0syQ5QvA4bW7R53YFeZ4KXUy1OB
         MdYz8aYDfPlOjDazNPuu4lC4qX0veA/Nn/g4gI6RIE1ctbm0HEUrL+cVfcGA8W3c11k/
         pBe5Psw/DxmlPrzfvzv8n6tP3VveS8y+RRW3RLbY7XWVBoKreCjab88FLrFa/BPiEymN
         IIuPVTBR1pBqvSkQEYf0VqsoTWvhg0yM08r6bc2azQ7f8s4FY2vR+LMwA4MXjSYY3pjT
         y0aQ4xweyNyvi40qHOrjXOW1nttzpFzSRQ939UxHHoYo0bRuBg9kMLjtzFYw26VtE7xw
         FeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756164561; x=1756769361;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7k7FLfhss0OQ7b9wO0+lRJA7QH9ewA3hhcR8Fmrn8Zk=;
        b=DWW6lQpTzfRQQkPQ9AkKbkcoxWrE0fDyQTjoSDcc0HrteXG1j2yKFcWGOIfSILADEq
         KkvUDvv7Kf5eBrBmxk9FNkipfFEI0mFkH2nXeS7gX9BF3ktSHJyXSSI8m8vXjwoi2LNm
         LrTTuIaMQaMsj7fEPW6GhN2V4kJ1H6TZ3WDY0+UClx+n/G6A1Flvp7mGshrhTmP9qR8P
         0iM7pydD1fX3nQqtqUhVZh4vdEJWgyKnqSET3/aWAHmlyDZmdAzaICrJyVLwY0+m207X
         Pm2UcHF2JHGnuZEV9YH2u5NkXaMrgV1ETVPF+s/b3mA4hfRpnICG05KchFws7HrPsJkL
         ZrNA==
X-Forwarded-Encrypted: i=1; AJvYcCVBqG9/EkqluLnwysfOtWI24Hfz3repbEy6U5L2K+n9b3Re6irXf3yBA2TDZb0f49pKIMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+ept10TsyxbDpYMATHU+PCTGvt19jqmhzrlC5h3PfypXXRxH
	MNetFfgMpyvs9cFZURHTq0GXO2DctQr7ftuaFNewZs/i9rgtQRzW0bvH
X-Gm-Gg: ASbGnctjiBTDAfRN+r3h0EvEgx2gqqDaXVRxQUMjddRrrLNppQLivyEmKdCA3nPoBg3
	FKF/V1WiU85UFLxI6PN1UWNlgi4iz38fNBair8/P0fr9fHKPDB6gEEs5cpuBFVsTU4Du3plfX2c
	WO5TUZOobuKw0gwM+aQKxuy8iaN+WAOjbuenDT3yT8pO7DL2VenovbkdfM+brpVvw0EyiXi3peU
	wxPCwkJVPG4xfOInmMRCjvWy/GulBxyyIKfJoyFEsOP7NsSBxq21sgT5rdMsEsjnVcYyfXSW2xo
	5Cwsbpgb9vnx0cumkkoFI3+bKaTHBToWQtbyJH10yqrDxx5CbuUcLegfCTvl4vIOWozF9YjICR7
	TRQkh64Pv7h5e7HI6N/MYDmEDG9XP
X-Google-Smtp-Source: AGHT+IHyWhykoYVWODW2wmWI3V2Vz/JmNIB+cG/SqWqWuyI3seerRiFD3IXVnMbr5U+mI+zJspnuyg==
X-Received: by 2002:a17:903:a8b:b0:246:c0ae:4836 with SMTP id d9443c01a7336-246c0ae632amr69611005ad.41.1756164560926;
        Mon, 25 Aug 2025 16:29:20 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:299c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687aeed4sm78646015ad.53.2025.08.25.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 16:29:20 -0700 (PDT)
Message-ID: <a46fd2898d1ece291d66703c656c38eced1a706c.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 05/11] bpf: support instructions arrays with
 constants blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 25 Aug 2025 16:29:18 -0700
In-Reply-To: <20250816180631.952085-6-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-6-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:

[...]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5d1650af899d..27e9c30ad6dc 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[...]

> @@ -1544,6 +1562,7 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf=
_prog *prog)
>  	}
> =20
>  	clone->blinded =3D 1;
> +	clone->len =3D insn_cnt;

Is this an old bug? Does it require a separate commit and a fixes tag?

>  	return clone;
>  }
>  #endif /* CONFIG_BPF_JIT */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e1f7744e132b..863b7114866b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -21665,7 +21666,15 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
>  		func[i]->aux->might_sleep =3D env->subprog_info[i].might_sleep;
>  		if (!i)
>  			func[i]->aux->exception_boundary =3D env->seen_exception;
> +
> +		/*
> +		 * To properly pass the absolute subprog start to jit
> +		 * all instruction adjustments should be accumulated
> +		 */
> +		instructions_added -=3D func[i]->len;
>  		func[i] =3D bpf_int_jit_compile(func[i]);
> +		instructions_added +=3D func[i]->len;
> +

Nit: This -=3D / +=3D pair is a bit hackish, maybe add a separate variable
     to compute current delta?

>  		if (!func[i]->jited) {
>  			err =3D -ENOTSUPP;
>  			goto out_free;

