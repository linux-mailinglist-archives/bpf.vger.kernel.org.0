Return-Path: <bpf+bounces-22216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7785900F
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA992B21A6C
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 14:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75707B3D0;
	Sat, 17 Feb 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhIDizGi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A07AE57
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708179974; cv=none; b=olYNlPhZI9qlMumB7WwyOy29EvGNxK0EFRTg2jzAOijuPcdfi+UYJRlaBUjxVkWfzZVZYeLSGHtd9J9QS3+NZNo1Rezy/KcIHevVMkRm9PKNzJyhdJrDdahBtv5cXbY8knDdwFvlCZRpD1AegBjXtAafDP/14jSxOVJkaAgTA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708179974; c=relaxed/simple;
	bh=NY/79E9FNcFHuzWVmHkK20H5Hl5TP45Mk4565JPZUTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mk2nZO/mMfRlm60GJeW64LdhzOy0tE+rXIh9Rvms0JWizIadZhWFatcqGGfiEqFGPSCeiS+c0yl9sPcFr5Zs8zUDjoPJSW7ePqUemP07K3TVEnp2mgxwjfeqZ+vWdaK0qHIKrdixgNN1uQnruCg/XQhIDoIYqAdvUXp+MKpHKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhIDizGi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e46cb8ba0so13425666b.3
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 06:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708179971; x=1708784771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Ab9Hh1dr5lKnpo4PBc23OaW6VR4ULAUJdfiCFtP9LQ=;
        b=KhIDizGiVHu5xcoxJs4LU9fyZpNCHRQG7V0wJD2AFaX4TUaStuCdMpYexSbxN1CUH8
         7o/MeTmMloanTcdBieLZJCo4x3U1FAfL3PsGE/KvcjLjhIE4LSpWAJRpjvZD6Rq43s6N
         HITFvsUss+Bbgo/7n73XpdmI1WxJ8AQjFbrvIc9haUoNArK+md2l+uALwIvP6I5K7RoX
         lFoUaGR81Ll2tt81due32SM3+PscWQzPj0mza7i6OKheTn0yac1pTIa8vUl+sychdTav
         bS7w2cRM9BVySdUiCD9kpVXQPZ0NtOwBhN6adLRwfP8Qu7JOs31AD8cmvM9ymPmRX6vQ
         cbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708179971; x=1708784771;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ab9Hh1dr5lKnpo4PBc23OaW6VR4ULAUJdfiCFtP9LQ=;
        b=pLA7xx4BcZuNyw0PdCW9K6/32YWSOY9kCXnf99nm6h8h10QmJ2bywPHdOlwWBs9JC0
         05/v3suQ6d2YNEjDPyZr0NArOsO3FwEsAgRk6NdWv2oHVtikfum9aEt5eFboamOzq/iC
         3/E4RpvM4l5qGaOkyM3JieTR5gL1SCcZ9kTKv+x4CupovmCB3eb+RRTNRMj+CcOqgeap
         tLwgNvIgfhTPFBuMUChlKwVTPgsZ9BsAT00LYsihDpt8xrIl2UsBcEOw4fE594Fb+Nx0
         gMXkz7noO5gbsNoDVpm+NbJMddJac4sH2bI/l6WrnrbzRt5iXGpil7MFMY9wC8LYYqKj
         QzZg==
X-Gm-Message-State: AOJu0Yyo8Vv6wgS9f1CcaID8I2p4sbGhfpUpQKedjd6nMIyhpQc6igdC
	p0tETSLiIq+x5urgJZwGLvGfSTxeBO/dpWJv6TenRPcz7FQUpHPz/9kS0diZCdE=
X-Google-Smtp-Source: AGHT+IGEZ3HYErc3m8vQsOHIw+eR235MyEZRhgXOm6Tfc8G+AjmztAaKRVwj17aCSY8X4pibQ+y5jw==
X-Received: by 2002:a17:906:ae48:b0:a3c:de7:f59a with SMTP id lf8-20020a170906ae4800b00a3c0de7f59amr5596217ejb.60.1708179970775;
        Sat, 17 Feb 2024 06:26:10 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906e00200b00a3e1939b24csm740435ejb.208.2024.02.17.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 06:26:10 -0800 (PST)
Message-ID: <87a081a5ef0d49c637dd2fffafd6135c94278e61.camel@gmail.com>
Subject: Re: [RFC PATCH v1 08/14] bpf: Compute used callee saved registers
 for subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, David Vernet
 <void@manifault.com>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>,
 Dan Williams <djwillia@vt.edu>,  Rishabh Iyer <rishabh.iyer@epfl.ch>,
 Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Sat, 17 Feb 2024 16:26:09 +0200
In-Reply-To: <CAP01T74yVyxLcW13+gEUs4A7qe4YCz84x7jnw78o9P5Xjtt12A@mail.gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-9-memxor@gmail.com>
	 <a99c123671efdf4e795d883cb3b0c67ced3884c1.camel@gmail.com>
	 <CAP01T74yVyxLcW13+gEUs4A7qe4YCz84x7jnw78o9P5Xjtt12A@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 23:02 +0100, Kumar Kartikeya Dwivedi wrote:
[...]

> > Nit: Maybe move bpf_jit_comp.c:detect_reg_usage() to some place availab=
le to
> >      both verifier and jit? Just to keep all related code in one place.
> >      E.g. technically nothing prevents x86 jit to do this detection in =
a more
> >      precise manner as a "fixed point" computation.
> >=20
>=20
> Hm, I remember I did this and then decided against it for some reason,
> but I can't remember now.
> I will make this change though, if I remember why I didn't go ahead
> with it, I will reply again.
>=20
> Also, what did you mean by the final sentence?

Tried to give some reasoning on why x86 jit implementation might change.
On a second thought, not the best reasoning, so please ignore it.
My main point here was about duplication of the coupled code:
if one would be changed, the other would have to be changed too.

