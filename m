Return-Path: <bpf+bounces-31388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BBD8FBE19
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 23:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C878B216B0
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542B14BF91;
	Tue,  4 Jun 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4jpq3r9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869914B941
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536931; cv=none; b=MY5Y0gRSIDTGp0czkaw/rV0uSdrIBIhpKx6/VFavZ9rOB8g7HRbP7sKxnNU+IBY0TW26S/yzA/o5vybCpPWt3ydYX8YCmax8UCcLRUVLFDIflEKU5JxPK4QjXn9ziF06ssBzPXeXhcsYfTzhHTO/yDLVzz7BFnwaMPXAaz0Ee50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536931; c=relaxed/simple;
	bh=2VYgGO6W/05pQhWDLsiL0TQBeYEYWZg2QeWtsu4Z8Lg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p63ole/2skfp35R/Ie2CiWxfzbSmOePI/kHmDwgNkYixAMOTbCz/P/fcOHgyWm5pyMD8jaCSX4b4C0ABJvwnOo5dfWr8D7QUWE7MeGiTSf+4+b3IGsQDx99ccK4Mcz6XV4r2wH53qL4rGD226LZCq1yPCzOEm+8c93FLZYUGvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4jpq3r9; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ba33b08550so1772101eaf.2
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717536929; x=1718141729; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKlhx+0MVT8QGAYWO252hOTNwpL7qqMHuw9d5GfSQM4=;
        b=I4jpq3r9iDMro5hXjb14Rhvq+JK/FCjMgz5yWFeQtPtFyP212spPAZk3YszyWo7Jpe
         EpfLaY2w5EA8N3rI7USV9bhPxMZbUb/p5ZT9608i8tvOFErktdIY0p6eRDLXI7QUif7v
         BKzeB2OtLDvVA1PIzOVpt3xdSDE0FdsWK3uyEO6GHekMAjRVcPagZUjdImOMrfUxJ3cu
         wyTGsyBXGh4i9fIVwKORiGDI69bWsSKM18fw/0iV9mk+S2OglwD8Oj03raCc+V5WX/fL
         bKlLAq/Zl4inpcr2BgwpGNK2IJl2GhzF1+AE40NUwZRINd/yK/QbXheW/j5KTXltcGGF
         A1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717536929; x=1718141729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKlhx+0MVT8QGAYWO252hOTNwpL7qqMHuw9d5GfSQM4=;
        b=fpT+72+Yc9N2Uf9fw2eO5q7Kx8s0aaTdwrNOuFli+PoTFYGSD2CyNFO4cZcjs28h33
         x0oMUQfCCY6F1iV95Q8DkQJeaXZyVQMtRvaUdFysC/ZLU4tRnwm4JtV5xQhXJvshsF/E
         C3733ZVCS2e520n3LrYw6mXuUX4rLmXnSJyCgtaDiJ0O1z66D7953jQfHVoVvy5wdjXE
         Bt5HLtx5YcTb0gBJLlH7LkUB67GGd0ph509SgRbFK0ej4Fp+AYLMK3AlvwaEvLjxUYpb
         8TEbzjwTXTcm/FrPWSeFEgSIatb77md2nXvfOSSYFDk52+52KI4r1zvMoHcBt7t6NBM4
         rb6w==
X-Forwarded-Encrypted: i=1; AJvYcCVRmAtQKK1J4clHIoFn/6b+FI05coNpiwzEZ3j5FoKqDEy1erfvWnGfRy3ixHWgOZhU5JJq0gjkAGpYhfBe7dGLT8Ko
X-Gm-Message-State: AOJu0YyP9GxxApFepILgawFZ2DUbU+hbUu2THXLAIMkGwM3zptPgT1Mx
	1Me4HCEPy3w7FJ0BgX9p3g2wZ0pc5SVmnalpv3XQF1TxsoJ3Q/ks
X-Google-Smtp-Source: AGHT+IGezzqY+M0nYoNYEjIMRNVxnNSAVB/MzTOoMeJaLxvCmlyGuAQoKxjakWOHZ4mFAhyFyqVdPQ==
X-Received: by 2002:a05:6870:d892:b0:24f:e53e:84e2 with SMTP id 586e51a60fabf-2512209cf8amr851596fac.54.1717536929006;
        Tue, 04 Jun 2024 14:35:29 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a83b354sm5282187b3a.33.2024.06.04.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:35:28 -0700 (PDT)
Message-ID: <592e19d427d20c2046eaf1478addb484419711f7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Support checks against a
 regular expression.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, Yonghong Song
	 <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 04 Jun 2024 14:35:23 -0700
In-Reply-To: <20240603155308.199254-2-cupertino.miranda@oracle.com>
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
	 <20240603155308.199254-2-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 16:53 +0100, Cupertino Miranda wrote:

I think this macro is a long overdue, thank you for working on this.
A few notes below.

[...]

> +static int push_regex(const char *regex_str, struct test_subspec *subspe=
c)
> +{
> +	void *tmp;
> +	int regcomp_res;
> +
> +	tmp =3D realloc(subspec->expect,
> +		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
> +	if (!tmp) {
> +		ASSERT_FAIL("failed to realloc memory for messages\n");
> +		return -ENOMEM;
> +	}
> +	subspec->expect =3D tmp;
> +
> +	subspec->expect[subspec->expect_msg_cnt].regex =3D (regex_t *) malloc(s=
izeof(regex_t));
> +	regcomp_res =3D regcomp (subspec->expect[subspec->expect_msg_cnt].regex=
,
> +			       regex_str, REG_EXTENDED|REG_NEWLINE);
> +	if (regcomp_res !=3D 0) {
> +		fprintf(stderr, "Regexp: '%s'\n", regex_str);
> +		ASSERT_FAIL("failed to compile regex\n");
> +		return -EINVAL;
> +	}

Maybe also use a regerror() function that could be used to print
what's wrong with the regex.
Also, there is a ctx_rewrite.c:compile_regex, it might be interesting
to extract in from ctx_rewrite.c to testing_helpers.c and use it here.

> +
> +	subspec->expect[subspec->expect_msg_cnt].msg =3D regex_str;
> +	subspec->expect_msg_cnt +=3D 1;
>  	return 0;
>  }

[...]

> @@ -403,26 +453,44 @@ static void validate_case(struct test_loader *teste=
r,
>  			  int load_err)
>  {
>  	int i, j;
> +	const char *match;
> =20
>  	for (i =3D 0; i < subspec->expect_msg_cnt; i++) {
> -		char *match;
>  		const char *expect_msg;
> +		regex_t *regex;
> +		regmatch_t reg_match[1];
> +
> +		expect_msg =3D subspec->expect[i].msg;
> +		regex =3D subspec->expect[i].regex;
> +
> +		if (regex =3D=3D NULL) {
> +			match =3D strstr(tester->log_buf + tester->next_match_pos, expect_msg=
);
> +			if (!ASSERT_OK_PTR (match, "expect_msg")) {
> +				/* if we are in verbose mode, we've already emitted log */
> +				if (env.verbosity =3D=3D VERBOSE_NONE)
> +					emit_verifier_log(tester->log_buf, true /*force*/);
> +				for (j =3D 0; j < i; j++)
> +					fprintf(stderr,
> +						"MATCHED  MSG: '%s'\n", subspec->expect[j].msg);
> +				fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
> +				return;
> +			}
> +			tester->next_match_pos =3D match - tester->log_buf + strlen(expect_ms=
g);
> +		} else {
> +			int match_size =3D regexec (regex, tester->log_buf + tester->next_mat=
ch_pos, 1, reg_match, 0);
                                                ^
Nit:                                            |
        I think scripts/checkpatch.pl complains about such spaces

[...]

There is no regfree() call in the patch-set,
could you please extend free_test_spec()?



