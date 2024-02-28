Return-Path: <bpf+bounces-22913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3686B82A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898D61F25299
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BF74432;
	Wed, 28 Feb 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hibym8Z+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07374415
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148716; cv=none; b=nSJgF6+rDfhn0wgmp/nGHwPfxvvZs8K5vO+yeAav/KNy6+yjyFcOZ1F+ZzeGHpcHrUysTIFV2m+qMajlQJHZ149h9xgK00VKhXkmaX1YiMd7YeGi/PnsRVg2YqAybgZILawJFGr7xsy0LSEZufvni6UgCQppAkcH4oAZPXI11d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148716; c=relaxed/simple;
	bh=0iwDGUUMPAy1W3qW85y/edohYb/+zl+hRDFXRJU9ZkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YFEl38jBldV5au9PHHcxSIBD+tu1LxInZ3zF2VFYke7T2dhiLQK9dQvc3bDOe+QdaVD1pwyCZU8dCFCXEb8IJ8ZNfI6aXguRDNHlo4I8EiBvibt0a1M450VAQv8/rIAA0Riiv4zBJHcHKKYY5faRsla4+1pv703f1q2QTsiW0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hibym8Z+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512b700c8ebso41359e87.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 11:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709148713; x=1709753513; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AtR8suuqO7cMg2afwBP8yIdquuD8eUBXZkXdUGTYBfs=;
        b=hibym8Z+Y0GYbS51iWRsRMWhJ+Wy57zW0YVf/OxfOcmvxZXgeWv5oaFUBFQFJhlnc9
         UVwc2NgpN8GLrlQYQu3hjahVWOtrRBujXIIkXXI3wR/lWUi0eZhPzp8wPHxG6LcsItHI
         1gB8lmcBRatdAciCK4ThSO+skbtVq3Dw1XjJYyYf8mUx2WPce9pb67FNL7QfSt4wuY6A
         VaV6ZOS5CTgqvjKjVlyfTvHivqzPnlhnNf01Rp2sK2BjiG7V5nTQ0j+IKASsc+ScZ/oj
         /Vm0qdk+qscD/B3iaQnCSmt5SIAZtdutRwuwTW3Kjfnw/7V/Bm/+beM5FqsR6/qH/dTl
         MufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148713; x=1709753513;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtR8suuqO7cMg2afwBP8yIdquuD8eUBXZkXdUGTYBfs=;
        b=OnEEH1/ouN3+8rhLLZ48SHi4dqpTjvmqKAHL6ApiVXI/B45c6I0F6LmjbvPJzUHkku
         O0Ozi5TlVAHnMGH8ow7BWkcdsmWsZfp+Nzn231t/EJzJ5kHqvLmneumdBIgXbH8O8kko
         ksrBFYhMYb4LZ7HI2Ll4UKvOYIzuMniaNacfjcd8SI6YD2D7hLiw1JMhAMAop2Yjpt7m
         z1y8qPrDLmSj7JLwyIMauOG7r1yaajsI3UUHYrELNDOE48dJCj3h5XsTIHiZ20aXALK0
         AcAUZl5KXz2OSDrQSZNFu7oUIW1Fib3fmSSXTAq2kjW0Yvfkbol7KqlSmnrYMCfhn7CL
         k3Ag==
X-Gm-Message-State: AOJu0YxG/Yge2X3MNq9CFHmD4zEZhOf4gcSQy3cqKiKsIX2cCTu/f/Ar
	Xnu8/9BUPz88frx5i+5libi4vL1yyK8eL18zErBT9/fpqTt/xGl3
X-Google-Smtp-Source: AGHT+IHrgdF/LvBTPCW3Z+bxFRFefW8z+/AuK9UyCX3h745J1HulCHbI9JrynH2YsMuM6BXO/g65Uw==
X-Received: by 2002:a19:a408:0:b0:512:fc30:51e7 with SMTP id q8-20020a19a408000000b00512fc3051e7mr416154lfc.16.1709148712475;
        Wed, 28 Feb 2024 11:31:52 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q13-20020ac2514d000000b005131434454bsm14539lfd.228.2024.02.28.11.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 11:31:52 -0800 (PST)
Message-ID: <05b80dc30b672df1af75ce09f0c8cb7196a07193.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Wed, 28 Feb 2024 21:31:50 +0200
In-Reply-To: <20240228182949.GH148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-7-eddyz87@gmail.com>
	 <20240228182949.GH148327@maniforge>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 12:29 -0600, David Vernet wrote:

[...]

> > +static void cant_load_full_object(void)
> > +{
> > +	struct struct_ops_autocreate *skel;
> > +	int err;
> > +
> > +	old_print_cb =3D libbpf_set_print(print_cb);
> > +	skel =3D struct_ops_autocreate__open_and_load();
>=20
> Optional suggestion: It might be useful to add a comment here explaining
> exactly why we expect this to fail? Something like:
>=20
> 	/* The testmod_2 map BTF type (struct bpf_testmod_ops___v2) doesn't
> 	 * match the BTF of the actual struct bpf_testmod_ops defined in the
> 	 * kernel, so we should fail to load it if we don't disable autocreate
> 	 * for the map.
> 	 */
>=20
> Feel free to ignore -- I recognize that some might just consider that
> unnecessary noise.

I will add this comment, agree that it helps when tests explain what happen=
s.

[...]

