Return-Path: <bpf+bounces-14589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED04A7E6D37
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A620A2810C5
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191F200C8;
	Thu,  9 Nov 2023 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do6NiylI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75E1A73B
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:20:35 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BA730DC
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:20:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-545ed16b137so808905a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 07:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699543233; x=1700148033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XH/GBGeZiKaxKx0b9v66jApRYQLoIjm/bR+TqFlyJoM=;
        b=Do6NiylIH+Sk1O11/OvvLpKeXnRozOJREpFztbFiPQB9Pnr23ZgDO+9XrjZRq47U5p
         m2Owo+6o/ec8r9xHFuV2pk84J3b+4r5pKKrCTjLkJkZOhz8miRHgILGZrWb6crjoPBdp
         C5l2n0aV6KC+rSIsR9RNwvob8+Z2863aUuY6NjjBGYh+6doRF+93CeryRYMQcrNpJVvu
         CiXnMkGK6YwXtfJNdlJhh9alpKIpUJQX3hlBJ+hKJpMkkUmOR0Tq+xBweMGMW6CDz5b7
         U/YdJaj++/5mfbcQJJEJbiQyQt2xhg6IhLMcNomxr9TCxjQbsFHGCV3pfhFIeVC1UKxc
         aYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543233; x=1700148033;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XH/GBGeZiKaxKx0b9v66jApRYQLoIjm/bR+TqFlyJoM=;
        b=Z8JZlaxCr43e6CXi11Qqdv5sAXoKnE8rZ99kv9bnkxO9P7Hp8f+3fh6gfv7ouEzZCZ
         VF03W+j4D++V/yZk0MTo3idZfmJM89jfvw+W0t2g+/1A8UB30cKoOILcClK30OsGruNd
         3iSp20JZIMcq+0O1Z6A08TT4fOiNiSUHe4suIw0tkuy9NNsycCUOOyRVPfu1vDURaPVA
         /VSyi2UMrpfniUU0h1Oln16Ri7HvRvR3xBZdI4rkNBmq8ZTKzq+bYv6g8BpwV5Xlc3pQ
         kvzl0pVN46pUOQyTqQqYZ2xwk2mqv4JEDQD0b3QG3bv9nEoIUEtV4Vy98qk2MTH2gao3
         tWZg==
X-Gm-Message-State: AOJu0YwzhYwmeIRuxyeoyPoQLpVnzkYpRSAKu1N4h3GFKsTNPYi/WOAY
	QdfQSO9vx4KXAMej329pCZ4=
X-Google-Smtp-Source: AGHT+IHfYrYRBs7BkFXvolVz6ne1FCsCAAEOWnxkc1KZgXLsS9ZkzI6Qxyz78ThOjaKEmgtMtcWSiw==
X-Received: by 2002:a17:907:c017:b0:9e4:125a:3630 with SMTP id ss23-20020a170907c01700b009e4125a3630mr4251123ejc.10.1699543233591;
        Thu, 09 Nov 2023 07:20:33 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q24-20020a1709066b1800b009b2ca104988sm2703123ejr.98.2023.11.09.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:20:33 -0800 (PST)
Message-ID: <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: enforce precision for r0 on callback
 return
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 09 Nov 2023 17:20:32 +0200
In-Reply-To: <20231031050324.1107444-4-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-4-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > Given verifier checks actual value, r0 has to be precise, so we need to
> > propagate precision properly.
> >=20
> > Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I don't follow why this is necessary, could you please conjure
an example showing that current behavior is not safe?
This example could be used as a test case, as this change
seems to not be covered by test cases.

> > ---
> >  kernel/bpf/verifier.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fbb779583d52..098ba0e1a6ff 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9739,6 +9739,12 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
> >  			verbose(env, "R0 not a scalar value\n");
> >  			return -EACCES;
> >  		}
> > +
> > +		/* we are going to enforce precise value, mark r0 precise */
> > +		err =3D mark_chain_precision(env, BPF_REG_0);
> > +		if (err)
> > +			return err;
> > +
> >  		if (!tnum_in(range, r0->var_off)) {
> >  			verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
> >  			return -EINVAL;


