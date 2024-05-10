Return-Path: <bpf+bounces-29576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256678C2D9B
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 01:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03041F220E4
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 23:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA517556E;
	Fri, 10 May 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWKRii4u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053F4F1F2
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383782; cv=none; b=S9Wag4TkMg6x6/sSihQgazZp/meqhzw37Fh0lZNhnm/Mw3xkvx0qkna8LkJ4wy58b3328NA0kGDxufi4RZATIRc+5ygn21buTEKfDEahN/lL6OJnV9JTj4rH1S+g0fHYVQ5nvHNe6Kxq00N4MIlnraF/J3+Dc4m2uMi1fbP0IZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383782; c=relaxed/simple;
	bh=IlHsAk6sdMcDldF1th0TAr9RSruQGgkuZEL2SgGL2b0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQZ5DgK8zy8OeEjef3Y654EfMwnAX4O5UtTLLB3yeAUcJRynBmHPIaSE5KCk4JrOrKmni5dNYi1uPzw+EMlUFYqiGzoNuaj+FuK0BmbnqW6/inq97U7bagbAl9jDUFx6OeNSOro/VMCfTwkYH8GifSoit8O5U5hKTb1czmjr/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWKRii4u; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0f07746a4so567579a34.2
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715383780; x=1715988580; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l9OaP3Uh2RzIwfLlLZP/UCLimSlr6Qk9d4FFs2PFYMA=;
        b=FWKRii4ufoArtuY3Zd/RUZSOy9dwef7DZZwHf8rkg8wNhXRY8pMOXzTKsVlD7ENVmj
         /xfyvjeLV0g/EF3KquJx6odQQKIVLZpOAIXBEMyBfq0tsw8NbxEZGCF2HYEXA3znrSz/
         BVUvfibFVnYqhyJjsVQDTQgPBBN67BNLzUMEQG6JZToS6kggwAPsSwwfa1KdkeuA6aSU
         tqwJk8fzSr7PteLwnQLJ22Yx5eInDphj+a6QYEoYm8vndWqZyB1e6sIhnpHzj3Te4l/6
         KQc5RkWJVTGS5NjTXEWnmmahZidgDcBAWKw4bOFur/WLg7ipVds6ecJaqGskBYyfDpeo
         MFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715383780; x=1715988580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9OaP3Uh2RzIwfLlLZP/UCLimSlr6Qk9d4FFs2PFYMA=;
        b=BIShqRGTRXDOhMM9lc1I/lBfbKWa9E+7+7gor0H2YxwI0z7HHUFQ5/lN3FXEiTlWuz
         PAx/XS8cIDQ97SJp+KyT6zJfcyb9DAUiY0GCnF0+CO0fLxrmjTfiIokvjy8Mtb3lOAAb
         MqWNUnq7GZ0entcdaHpBZ27KhHucoWjQQuVEB6gfDqLK7cx1NN/vA2E+O6Ama7g+rcdl
         HqAsDFfkGm8glkXtT/2cuqlp831BJ1cl07/R3NdM403LISrdfVuhBQoPaeHEVrCQVWSf
         GeBNkO3gv1hmyru2tUgjyS/bkcYriiQD7XcCCyumauuWWUm3C1m/6NaMirnI+2sM1v0L
         7N3g==
X-Forwarded-Encrypted: i=1; AJvYcCWXEeKnbekkOqEIObTLgcFEpQ+viTr90uEbERzyTKq+GX1VSx1U9xlZhfo9eqpeEvlXAKRtxiuaDQ0PomtjFWG+a5Ic
X-Gm-Message-State: AOJu0YzjG86joZ90CKMZGTXczOD2346Nfht/2mQHixHbmNP2aKaHSlTt
	olPzAdgoMf97SrSHh3y3wLivWyWr5BY9hMJgmM6xg9A54wGcobJm
X-Google-Smtp-Source: AGHT+IGGA78SnmNOyc9iz94Ljjvg0p2aL2rfrZ9L0fMrUu9JP19wtalVfOs9pGfi2kx1iVfcN/H+3g==
X-Received: by 2002:a9d:7d81:0:b0:6f0:e2ba:a91d with SMTP id 46e09a7af769-6f0e911e962mr4279704a34.12.1715383779831;
        Fri, 10 May 2024 16:29:39 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b767b36sm3619096a12.32.2024.05.10.16.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 16:29:39 -0700 (PDT)
Message-ID: <e3dcfcf4a40cb9ee2f5a7c84b1df59eec1992664.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and
 kptrs in nested struct fields.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 10 May 2024 16:29:38 -0700
In-Reply-To: <cfe0145e88727ccb23be8728671649eb0ffb61ae.camel@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
	 <20240510011312.1488046-8-thinker.li@gmail.com>
	 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
	 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
	 <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
	 <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
	 <a938837ff87adcdebaa58f612395dee06a0ea94a.camel@gmail.com>
	 <52912c4f-219a-45d4-bb61-aaeadaf880c5@gmail.com>
	 <e65e8c7d387312f4b13a1241376ad6b959f90bf7.camel@gmail.com>
	 <f2d480de-a598-4771-9c72-722dba941e83@gmail.com>
	 <cfe0145e88727ccb23be8728671649eb0ffb61ae.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 16:17 -0700, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 16:04 -0700, Kui-Feng Lee wrote:
>=20
> [...]
>=20
>=20
> > I am not sure if I read you question correctly.
> >=20
> > For example, we have 3 correct info.
> >=20
> >   [info(offset=3D0x8), info(offset=3D0x10), info(offset=3D0x18)]
> >=20
> > And We have program that includes 3 instructions to access the offset=
=20
> > 0x8, 0x10, and 0x18. (let's assume these load instructions would be=20
> > checked against infos)
> >=20
> >   load r1, [0x8]
> >   load r1, [0x10]
> >   load r1, [0x18]
> >=20
> > If everything works as expected, the verifier would accept the program.
> >=20
> > Otherwise, like you said, all 3 info are pointing to the same offset.
> >=20
> >   [info(0offset=3D0x8), info(offset=3D0x8), info(offset=3D0x8)]
> >=20
> > Then, the later two instructions should fail the check.

Ok, what you are saying is possible not with load but with some kfunc
that accepts a special pointer. E.g. when verifier.c:check_kfunc_args()
expects an argument of KF_ARG_PTR_TO_LIST_HEAD type it would report an
error if special field is not found.

So the structure of the test would be:
- define a nested data structure with list head at some leafs;
- in the BPF program call a kfunc accessing each of the list heads;
- if all offsets are computed correctly there would be no load time error;
- this is a load time test, no need to actually run the BPF program.

[...]

