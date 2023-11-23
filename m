Return-Path: <bpf+bounces-15759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A677F62CA
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F80A1C21157
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48838DD7;
	Thu, 23 Nov 2023 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMl5TrSa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8241DD69
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 07:26:58 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so11443141fa.0
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700753217; x=1701358017; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lLaDSavh8dpgg0Z4OCpKIsOI1BqQU0xJJiVd2ymkYWo=;
        b=EMl5TrSa0p4JO2kpBfD2njzDL3IcRv9VGWUJUHA93C7Qv82HFAnKXGFYRRymdzi19j
         ld+zq8flb2H9VL33qfFwR1nTtMfgiw5L0WpL+X9bVdVQEAHxWD26rHRAEjFaYrByh2/l
         jQKh93l6ADO0deZT1AYJgNtM6gs1OZFwl16k+xAf20FtRdxZzi9w/DQ+gaq15fDJKm0Y
         rxlLLriLBXQhfWWHrKTRk6/j6gQ5HaASXwMk8rbkYEbr15Ct8eeLGVBVT9/NhTIOumWC
         WFaVOxnOcigVQES1brYAyLsGZ0PnAEcdc9FuIa+Lve4imOa/iTSW9wdBOdG2KEMuX+Yy
         GVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753217; x=1701358017;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLaDSavh8dpgg0Z4OCpKIsOI1BqQU0xJJiVd2ymkYWo=;
        b=ZcXJrGru8HKh7hhDYKbJcX+iA2r1CMgdC1v/upyjLEF2lYufRJcH29dKZyfWb39Tex
         lcOZzPh9a5AUk7SIuct9vAu5XmmcnsNMoM4F4shrxSl1sOrQhHdFvCyJPvbKWq+mB/CZ
         +dZv8lk5ocFTBbsgkTUnnLEpauz7srArdFCCta61R8VfYQ/9x2idF/9uYk7Mjrf9CcKb
         sG2QeTCJbc9PUV1ftmTaVcssHiKazeqrMUgmFwid2Muvfm5W5+4X1kXAJ2Wshc+Xcgd9
         CfwPbQflSDDD3fLTJdwrXA7aSfUJMxLsBvgXpl1XBVwvy7+hc4/xpAegSRF3nmV7Kexw
         /dag==
X-Gm-Message-State: AOJu0YzFRRIPTH8u3MXWUPCnk0HWyL1d9Xej4w3wgX/NtETWvL+XIRP4
	Fda0jKpyYqGTxtANXLy5emY=
X-Google-Smtp-Source: AGHT+IHEf4t+6NHYVnObCwKxnT59UFyv8tveqD03I937xAHXWll6ZnQq84XYNZx//2guFe2sE8Nucg==
X-Received: by 2002:a2e:b746:0:b0:2c8:714f:53a with SMTP id k6-20020a2eb746000000b002c8714f053amr2511632ljo.3.1700753216499;
        Thu, 23 Nov 2023 07:26:56 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 16-20020a2e1450000000b002c8872c9d53sm244881lju.8.2023.11.23.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:26:56 -0800 (PST)
Message-ID: <e1f42067ede02cf159ab8cd0172e8810ec733cf2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: validate global subprogs lazily
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 23 Nov 2023 17:26:55 +0200
In-Reply-To: <20231122213112.3596548-3-andrii@kernel.org>
References: <20231122213112.3596548-1-andrii@kernel.org>
	 <20231122213112.3596548-3-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 13:31 -0800, Andrii Nakryiko wrote:
> Slightly change BPF verifier logic around eagerness and order of global
> subprog validation. Instead of going over every global subprog eagerly
> and validating it before main (entry) BPF program is verified, turn it
> around. Validate main program first, mark subprogs that were called from
> main program for later verification, but otherwise assume it is valid.
> Afterwards, go over marked global subprogs and validate those,
> potentially marking some more global functions as being called. Continue
> this process until all (transitively) callable global subprogs are
> validated. It's a BFS traversal at its heart and will always converge.
>=20
> This is an important change because it allows to feature-gate some
> subprograms that might not be verifiable on some older kernel, depending
> on supported set of features.
>
[...]
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmai.com>

[...]

> @@ -19761,14 +19772,26 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog, bool is_ex
>  static int do_check_subprogs(struct bpf_verifier_env *env)
>  {
>  	struct bpf_prog_aux *aux =3D env->prog->aux;
> -	int i, ret;
> +	struct bpf_func_info_aux *sub_aux;
> +	int i, ret, new_cnt;
> =20
>  	if (!aux->func_info)
>  		return 0;
> =20
> +	/* exception callback is presumed to be always called */
> +	if (env->exception_callback_subprog)
> +		subprog_aux(env, env->exception_callback_subprog)->called =3D true;
> +
> +again:

Nit: I'd use an explicit loop and a separate function here,
     but kernel people like their gotos...

[...]



