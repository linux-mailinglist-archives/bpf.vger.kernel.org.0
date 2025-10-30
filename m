Return-Path: <bpf+bounces-72945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB0C1DE0D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD073A9876
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574991ACEDE;
	Thu, 30 Oct 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzfc9pkO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548018A6CF
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783381; cv=none; b=S2LuJ/FeLY6YCw0FNxJDUGNZPG3XcjEVzy5bwk46pflFSU7UYaY1YS8atFYV2SyTGj03AntWaTQQyTewCNV8jsagM7qfd4lP5bnK01CDQERQCzqd5SyBQS1KTJuPosxMkNgfOhrF0T7MC+W1viG2hoS9/j/f7irAQYBPRwNi3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783381; c=relaxed/simple;
	bh=lkkYvAfGJyHErUCtLY2pHZe5NAqZZAtOb5uiVNeM6TE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJ8gafsoNCLBv4FpNgt8ItiJTttt/4yq1rr1iLaEk5nlFYbcm1rb3kifJ6wm/z+zbTWHZydL6hPFLd0cKb4WLY09ED8nl6976WGjsaIS/eCWehjFJEpd4pcBM4F1JkO7C6zmbmB7fHa97dastYgDKalvnl1JhZj6kEunu21TeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzfc9pkO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7810289cd4bso543935b3a.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783380; x=1762388180; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msuM7kcIsqN5uFPie9riIUGHCFzbf5VjirHQu/5O5dA=;
        b=Zzfc9pkO/MSLJn/tAbvAFdT+4SIAsjRLFKldRI33ISdo3jKT6919RNOxmoxjHDM3+S
         y2wxCdktGShMV3se+xdNBDXmbBmWC625dsk8aAqrc5/mLZAcmYbgsfKCwmGL7q59pdNh
         3WmfFx5nOqvu5tnDOuSmfyr+pfL5wDTec67/tEcCyDINWXCAA7JFPVrs/aENGlJo+8YK
         o/ltYt8G8z5HPfi3p1IkyW94zCSgQaaZYi1gh2zKnA0Mp0b5WuVs3EuVKfo6jKOXGrMX
         YfZ4B5OnzJDrRmIB1Oz8E4koMIxyvCPsF8nL/7TosD6xvk0v56uapEE657//gsQaMhOQ
         MgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783380; x=1762388180;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msuM7kcIsqN5uFPie9riIUGHCFzbf5VjirHQu/5O5dA=;
        b=L8RkW6X9BkJy6yvRNY8bpIWoYVTVcCprUhCOlpjpJC0VM+2WoLAoIMuHBLTHxCMvHg
         lYAzhUDh9xq1huGu2KqrCds7UTBp0FWWxCrgVyOoE1Ozwb76uuphf2+zoYaOpJEBQGuS
         FXKFihaKDVZHdRMpOLYlABs2ORsfidiTX+Ao2FcCRqMhrgc8cWRO0e856+2jRqNE7jfX
         ASRJgzT6H5fAHTzRgApvMGvbEoYUWIqcTjCu546RNJzQL5N/R8KRhJ01f/Yb5Zcs2xHw
         0Q52R9BOzPVpLJ+ChuYj/Pjd3t5I9B23tiijGfTRhEJOC/poEEpRnrfhmNRsTMri6yfb
         sLcg==
X-Forwarded-Encrypted: i=1; AJvYcCUZKgPyYeWyPa74hN7zWST8kKEHtDiIUYgne2CSpEGSSo2sWAsncBiV1R7sAP2+QGx9PIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWdkX+fOEFHBluEWTYio4UWohaRQnfR1A3g3VpePn6BbjYd08
	XuimkFO6MCvl8ubgZ2uerVWOXo/UHvwDYLARiQUhSzBx/4BW83wd8RhW
X-Gm-Gg: ASbGncvPw/jZVLpYHvRkAsbNcR6QDwSZLy9AIKNiZL2rh3j6w5eLGT5vCveRtq31tHt
	f9FKcQ5lL+QGArr7S3A5F0wNUclFQg4J8Lpfv1MgiA09F7RMD/R5vPdbevalKlowHRL/8GpjgsQ
	IxpuMqvZbQ74aYTiRcMix2QiBQKrGmoKeyLm2HqejE+aZ8xmMU1fYA6ttWN3A0sbM9Mo3h6ClCs
	pgxkCCk9Xd16FpisrkAjBAkhIeArzp9W5ag9Duz7aU4VH3AicT9b6jon+/UDtUBUb+WaXzXYGIB
	gnADTzsJMOmlXdPmdzZ9Ny4jRi9yv00m2KYXeL3gWVcKe6VxNYb/v92eLBcj6HJuA/XrPEyShdi
	8TpdJNaqd2BdmgCg0cbxFOH/SQLZiGy9pYrwbyFK2L2S/m4CxjiHeDgWwr+JCbG9I7i8P7rDIRf
	mufYHG4rKINxESp6ZLLV0Hcrt3kw==
X-Google-Smtp-Source: AGHT+IGYNCGnTE8vldzzzwfa8aWZAFdxGb9LI3wHfrcY6NJc1hj5Ms2gdLFdB5J+/1Q91lTKZZou9Q==
X-Received: by 2002:a05:6a20:3ca6:b0:2e5:c9ee:96fa with SMTP id adf61e73a8af0-34786a1ea4amr1488329637.34.1761783379640;
        Wed, 29 Oct 2025 17:16:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712ce3a6efsm14732052a12.24.2025.10.29.17.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:16:19 -0700 (PDT)
Message-ID: <c03a5ebfadf924be0ab0679a48d33d323d7ea7e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] bpf: Re-define bpf_wq_set_callback as
 magic kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 17:16:17 -0700
In-Reply-To: <20251029190113.3323406-6-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <20251029190113.3323406-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 67914464d503..3c9e963d879b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -12916,9 +12919,10 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *=
insn)
>  	       insn->imm =3D=3D special_kfunc_list[KF_bpf_throw];
>  }
> =20
> -static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id)
> +static bool is_bpf_wq_set_callback_kfunc(u32 btf_id)
>  {
> -	return btf_id =3D=3D special_kfunc_list[KF_bpf_wq_set_callback_impl];
> +	return btf_id =3D=3D special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
> +	       btf_id =3D=3D special_kfunc_list[KF_bpf_wq_set_callback];

If insn->imm is patched in add_kfunc_call() there will be no need to
handle two cases here.

>  }
> =20
>  static bool is_callback_calling_kfunc(u32 btf_id)
> @@ -14035,7 +14039,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  		meta.r0_rdonly =3D false;
>  	}
> =20
> -	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
> +	if (is_bpf_wq_set_callback_kfunc(meta.func_id)) {
>  		err =3D push_callback_call(env, insn, insn_idx, meta.subprogno,
>  					 set_timer_callback_state);
>  		if (err) {
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 2cd9165c7348..68a49b1f77ae 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h

Nit: The tests won't fail with the above changes, right?
     If so, we usually ship changes to selftests in separate patches.

> @@ -580,11 +580,6 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css=
 *it) __weak __ksym;
> =20
>  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int fla=
gs) __weak __ksym;
>  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __=
ksym;
> -extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> -		int (callback_fn)(void *map, int *key, void *value),
> -		unsigned int flags__k, void *aux__ign) __ksym;
> -#define bpf_wq_set_callback(timer, cb, flags) \
> -	bpf_wq_set_callback_impl(timer, cb, flags, NULL)

...

