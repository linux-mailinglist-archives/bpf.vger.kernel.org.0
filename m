Return-Path: <bpf+bounces-21872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850C6853A37
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A931C241A1
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03110A3F;
	Tue, 13 Feb 2024 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El3UY544"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817910A3A
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850099; cv=none; b=REWE23gdjQxJD5dLiGF1ccc5nK2rSM00IucQIZVAmVNZpftfLHtz1saOAYkdTQQyj1/OBzXwYd0qmGaU0SnPg1cKV3PNdF0yIaESRRb8SAdfz5dJkl0CoAn4F09M7Z+gLj5VXYjN0ynRDo0D8ne2/6N44Xh9zBY0G4+XjTjJXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850099; c=relaxed/simple;
	bh=k1TRVgq/HEVamd1Q3LeCAHc+T1nwGTn6EfVHsR4yr1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q8icVFVhRhL0uq2xVyON17WnkfQDi6bfN3MRmLFc7DrhVVH59xTQHnJXMcjMGtm0ITMdZkWtdbPfQh86EdqXNayFNl84mIcq2jId66cGpHBytLA9mLbWp5rnm7tSzsU14KFbCjXDFguVu2bzqKY6x9S/Hh9Mr76Xb0gfyP7bsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El3UY544; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-562092d8135so926518a12.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 10:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707850096; x=1708454896; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rT2pFVs9CKA0sARxvhpoZUWZNA/ZXuQtRIQojR5TqjI=;
        b=El3UY544jWKDPIcvE2eovq/HowvL0qmT20PRb9mfSEVMdTdgPylUmKo/k6/hygomrt
         YqZftFQ9gLPcDadLg0KDJ7bl7A6FhabHTLSz7MSw2Mmsar62nKF8O/z+os+qQHpTnAeR
         vd+V4dIvPYFcxLYfuXYwxj5fGxWgv1HPeDWAd+F/OHqdH5FP6ELnImTuNty3LV6N3mMP
         OvxvhV2FKEM8M8NDOj3NjrafgegywAuBGvnJLo6uCZGX2GCfrMgGmT+kaZINYR/cgshb
         LSMiFRAWOhcYIxBGS7gktXKgrtVDQ1x1mT93y7oTTtzY4NUbu3plpROH4gpZjv64fBcM
         TqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850096; x=1708454896;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rT2pFVs9CKA0sARxvhpoZUWZNA/ZXuQtRIQojR5TqjI=;
        b=VbriXdrubqm2oE3vsFAvnJ9zlTDwprWTNwtP+JF8ADMynlydEPXHJUd1cMj0KfRite
         vdE6+c4ETGbT+sTIKsMaeZJDLI7IXMv5H/wiyATb+C+aos9QqMoB4bktmu24vSN0514X
         df2asTYvTrRckJUoq9bblYOh13Qk1NIT9eBcFbIgoxmeejzxqXNTw0M5pD5zJAimGKUq
         WLX02sRQbFuHnLjV0ddYA15pU7BAQMBZ6VA+jkXLxIaomZrne7VvaUTnbgD/z7iA6V6x
         qSaV6/C2r7GUa2ppaqgOHyYxnbkys1pNJ0W1Wi6woCiJMulPZ/L3tqs727OWXmmwruts
         WtSw==
X-Forwarded-Encrypted: i=1; AJvYcCWe9ZLMhSRy4YELNdYzaX2d1+SnxrUG+9CZydrEaFtUrUjI4iGzs9DcIXVpONoREnT4f0GXzhtcmwpF79lhkWR6LBt/
X-Gm-Message-State: AOJu0YxQNt1rbicNYX+kRV9QxAHuyMMw+p+XT7PLYGbcLU5cQ3rI3+QT
	QeGwxfbMRsqpnr7E0DHuYOhsMUbVuqtbmAyMroX8V5XbOANoAhIY
X-Google-Smtp-Source: AGHT+IHGwROBo1buC0ZPFALXdvk6GT2t7MiurpLLJazzJpaPZJ3Cxhe5e7ZzwZGGyWzum1E9cG/DnQ==
X-Received: by 2002:a17:906:f6c3:b0:a3c:f71e:65dd with SMTP id jo3-20020a170906f6c300b00a3cf71e65ddmr145412ejb.59.1707850096005;
        Tue, 13 Feb 2024 10:48:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVWPB0N5+xFV3pt/zKYmlt86kOymjhe+/rvKcjLlwfbn2AIOy0FrUbl4fvIUtOZiBEJyQcR1QGHPOnscZooWkEQQBYbecqbDuwD+8MeXfqOxTCoKk01bjf9eLr8mpJJva6/NHL1IScWmbURfbUkRDktM/pkusDCGsXZ7sDEOyQ+0OFsfIJjcGbFDysoqIUGUx0oFXYipU=
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3d2d81daafsm160568ejc.172.2024.02.13.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:48:15 -0800 (PST)
Message-ID: <95c085046a12449df88f0f668634878289bc4f5f.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: handle bpf_user_pt_regs_t typedef
 explicitly for PTR_TO_CTX global arg
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Tue, 13 Feb 2024 20:48:09 +0200
In-Reply-To: <CAEf4Bzbs=1xJmJRinNPGG+Ug8k71060CnCp1psOWCqFdxOOKnA@mail.gmail.com>
References: <20240212233221.2575350-1-andrii@kernel.org>
	 <20240212233221.2575350-3-andrii@kernel.org>
	 <e3b68a899b8ade18addd198d6f33dcbbed473c3c.camel@gmail.com>
	 <CAEf4Bza5yWU0Tu18ZfPB_XJeAKx_iKyR=FCkSvWXE17vPa73DA@mail.gmail.com>
	 <4950b053549136fbf852160aa64676e2003c4255.camel@gmail.com>
	 <CAEf4Bzbs=1xJmJRinNPGG+Ug8k71060CnCp1psOWCqFdxOOKnA@mail.gmail.com>
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

On Tue, 2024-02-13 at 10:12 -0800, Andrii Nakryiko wrote:
[...]

> Yeah, and then special case, for KPROBE that `struct
> bpf_user_pt_regs_t` (not a typedef!) is also acceptable.

Hm, I missed the point that for kporbes there is a need to accept both
simultaneously (for the same running kernel):

    typedef __whatever__ bpf_user_pt_regs_t;
    struct bpf_user_pt_regs_t {};

If this is the only such case, then I agree that special case is
simplest to implement.

