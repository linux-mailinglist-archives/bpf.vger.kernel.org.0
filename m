Return-Path: <bpf+bounces-70616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68FBC6723
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 21:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B9CF4F37FF
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C92222D0;
	Wed,  8 Oct 2025 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG7n61JH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27E2472AE
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950928; cv=none; b=askI+lrWhaQ/8Alus3LX2tAsjmWKuveJ/QMYwsbsXUu7weJNkdU9k8DZLcF5UT7jhKXYt7mAvBEfhUbhcQXGk/tdCY5zEmYjB5ahFhejY3rYmNgZcTk8E7guCvFAFlpcXtpzZiPPmaiMME5064ioy6mv9uReiPJ4BTUap/6+FNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950928; c=relaxed/simple;
	bh=6s8oYLwsy2ZaU6IjKrdtRbYlWbeHD065ZtHqK672cqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OlRZSlQJhqDJdCtkQ215MpBTUCf1hN9b0DDWX3lWKihnbKJIOq54HDPom3vCzfMJPO8Ooy5YkbEYnb/fawdD0SqpAkZ5jSZT0RVAZEiacsef4JJ493t2rnOiuIJ6E4SrKcJkwrchQLNet8HXXPHSeiLXP2o0zB6JBM3m4BSHPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG7n61JH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso111002a12.1
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759950926; x=1760555726; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Wzfisa4XLXRZuJyWfEJ+5dKCjwFquOi0/Od7HtO+IM=;
        b=SG7n61JHo6aeX/t0NFybxME4LOM7B7jPX0wGwk+mWcE9s+x0cA5mh3QIDCi5AOuiyu
         KG4d0Mc+MJPJBCtVgSu0R7NftpUwDf5EvFvHoeeABD/QdrclGCPpQCznBVQr2QNz6cTi
         /MKALSy2Up4of3De1rUupYvu8X12nM0WZZhAJEC0+RktAepOCpjCPWDrFURw267uyIRS
         8OMxejWNgdze4zQIvElcgFEdLvKmmX9U+d3ACAa7fnGVa+8qLB2HAm0zrhiXwc1VlVck
         dE+WBcCM3ljbcQfendcf5AMeQi+jmCqFyKA0uTqd39H5IP5AJ0344jj/U/eO1y22hIfI
         XFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759950926; x=1760555726;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Wzfisa4XLXRZuJyWfEJ+5dKCjwFquOi0/Od7HtO+IM=;
        b=QOzatUqj0gPT5PFvfaico9ZK0T8+RwMpzA06KpfTjEUX8y0l6Ef5PXIS47FLLhqlgK
         9qVyUh0MINUTGA32gf+GNQhUarBM2G/z5pkG/SdG0Wwm44rxM/orZlRPVnTPuK5/Ol9I
         rXfLWI5Ui8U5Az9wifGsUv5iO5xlj2UkMcm1HF47W0dYAig653ZP1FIikHSF1GJoYLeM
         6k9VIAhwdfutHiik6meOyre0G5w3qouoIScv4n5/Rn0KreyQLxWn8ha++Tl3uLZAOeFx
         GnTWCMonExwxPpujD3Gbz11nPC3YoNF+mSRH7rxiTI4qAL4C6BGjX6m/3DHXiSxY2WeU
         keSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHXs+c6pAiwYDglqlHRVgjbEOX3yZG/GfopTUVMek/XUJwwaKHoBSJbfUqKA9Nh1+0dW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyleFvuhAHr6L1GvhUfgz2JRu87Z4mBjT6pnaKjEFmjzxLUSyE1
	JklVjs13GZFSqnUkPAMsivQDAfi58aVk/vKmftE6dkO69FeVm4bLZhnJ
X-Gm-Gg: ASbGncuIzFf7n3RA3SwFmRtk1oyPQFWDl8HaAgwRm8yIsTI7pW4Di6f3A/ZzjqEGa+N
	BKgpEym0N6YCfS8cLvyi9EXPKD4oSk8uqtgc7c4eRT89BUoY4gzuON+Us120yhxIV4Vg50OKo4m
	21G3Hm5dOPK6PAuIb1mnCnA08H/6nPMnJMiN76bOFo6riRO1p+JbOgSwNtW4JlZTuaKrqhuOlDx
	dQ+OFZwYvw3UPPk1gXUuq/YJHvjPG5Vz6cIrLM17jgEG9z+oo3KCXgp/LP1fA4ro+tHCCVnQlN2
	5M1bVlHEAMxlysfzHzMfPsnno7w13DI7103dB49mkpcWpeVzHUE+pecguG7e28dnoqbcU4m6Ud/
	RoRBtM6PeBiP2vBOO01a/ppr2sgNR2THcn5RAIk50IreZWvatjfnlzN08KuHG0H3IWqE4zj45
X-Google-Smtp-Source: AGHT+IHWuW+TcvR+R1mJM9beWccwJTllb8md57PqqeqxrgUlwmIWNUYDRSEgCth4v0dTYKmrpr2gzw==
X-Received: by 2002:a17:902:ec83:b0:267:d2f9:2327 with SMTP id d9443c01a7336-2902739b36dmr61263455ad.27.1759950926279;
        Wed, 08 Oct 2025 12:15:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f51f:bb9e:9f33:c390? ([2620:10d:c090:500::7:e1e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cc10sm4991105ad.31.2025.10.08.12.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:15:25 -0700 (PDT)
Message-ID: <620ae41b2160575020d035c6f2232d4b7ab87c16.camel@gmail.com>
Subject: Re: [RFC PATCH v1 08/10] bpf: verifier: refactor kfunc
 specialization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 08 Oct 2025 12:15:24 -0700
In-Reply-To: <bb2eac7d-fe07-4e44-bd21-74115fed02bb@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-9-mykyta.yatsenko5@gmail.com>
	 <bf0c87d7c378f033dd2efc193c86789cfd2604f3.camel@gmail.com>
	 <bb2eac7d-fe07-4e44-bd21-74115fed02bb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 19:27 +0100, Mykyta Yatsenko wrote:
> On 10/3/25 23:08, Eduard Zingerman wrote:
> > On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
> >=20
> > [...]
> >=20
> > > @@ -3354,18 +3344,29 @@ static int add_kfunc_call(struct bpf_verifier=
_env *env, u32 func_id, s16 offset)
> > >   			return err;
> > >   	}
> > >  =20
> > > +	err =3D btf_distill_func_proto(&env->log, desc_btf,
> > > +				     func_proto, func_name,
> > > +				     &func_model);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	call_imm =3D kfunc_call_imm(addr, func_id);
> > > +	/* Check whether the relative offset overflows desc->imm */
> > > +	if ((unsigned long)(s32)call_imm !=3D call_imm) {
> >
> > This error was previously reported only when !bpf_jit_supports_far_kfun=
c_call().
>
> Sorry for the delayed response.
> This condition can only be true if call_imm is a 64 bit address. But if
> bpf_jit_supports_far_kfunc_call() is true, call_imm holds func_id which=
=20
> is u32, anyway, so we can't hit this error.

Oh, fair enough.
Would be a bit more obvious, of this check was pushed into
kfunc_call_imm(), but that would change code structure for error
return, so I don't insist.

> > > +		verbose(env, "address of kernel function %s is out of range\n",
> > > +			func_name);
> > > +		return -EINVAL;
> > > +	}
> > > +

[...]

