Return-Path: <bpf+bounces-15661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65E7F49FA
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F0CB211CA
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B94C62E;
	Wed, 22 Nov 2023 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhK31YwI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D500A9
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:13:09 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c876f1e44dso51397821fa.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700665987; x=1701270787; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xsb5xEtZcwnGgz4sf/a/rvQcUBFj4RoYQoiFqlRxAHQ=;
        b=NhK31YwIg/iE1eNCJQll8RdeTXQenPjr4V+9DILFB5Ip+7ht3eIcWJlD8cfFIUaXUA
         PUQciFN2NY9C/wqcjb0vjr4s8lWuuxnk3bwXRzhJIDzvn8ivykC7kgTxJCLYM+gVQCaX
         SvK6YgPhUuyij7vdHpZ3gs6UtHHDB7AggQH3v0nGWvXtKhmbIkxMAoHeFWg7ViGUYmDD
         nEm8ZTz9KZ9G+860YF8beL9qY9JGNfrqC5jNB4oBsvDJw3GykBWiu59myXHMi71b+Ygd
         jC+RkFBB9bURxALudqDpMxARsW5chQEnct7/5eOgaQ++0w11A7BLHdr93feDPfWA+Z+Z
         HfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665987; x=1701270787;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsb5xEtZcwnGgz4sf/a/rvQcUBFj4RoYQoiFqlRxAHQ=;
        b=S7a1A9Q5OgJlPx5AKqRja9E3kNS0UwNWGkh9qodEF5FqHv0mi02U+pHgpqzsFRsBOQ
         fKYBP+C2UZ3qu8bvS3mG9+CFq77FIfdgFkPYO4xuHVqYvmQR4J4TzEF/fbmQCTb2Pn+i
         UHXNz1aX2BJH+cetTXlTk4es32s9ZoJEqNrt3P5jssK/4PGIBZ6fF4MtXkkEmtP8i58+
         pXjSWuxoGmgvsfD2/o3fwhSsvcNf1fi86ygNqlC1XyXGqMWWxMUZSHHAappv6a1NN2C8
         DeazqvXfK/s8nlgRyWI6XlTp4Itb1VMjsn7E4ZAtTID56JXVO5mwye7N3O0DDNk/ogFE
         SF7Q==
X-Gm-Message-State: AOJu0Yz++/co02snlV3rpGyUInnmFXJ7q+JL0iW6WZh8km2Ve4kD/i1l
	IkHUCkcqmHQ/GSJ7/AjuUlgVbJNfOls=
X-Google-Smtp-Source: AGHT+IEekRqlrXeRkI8FYMC9x6nUCZ0yJ3U2+ehqR0uMxsK54+6VmsyVXhMd6Vhh5wBKYxkaZ/BVsA==
X-Received: by 2002:ac2:456a:0:b0:509:7915:a1d6 with SMTP id k10-20020ac2456a000000b005097915a1d6mr2141903lfm.58.1700665987244;
        Wed, 22 Nov 2023 07:13:07 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y22-20020a056512335600b0050ab696bfaasm503865lfd.3.2023.11.22.07.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:13:06 -0800 (PST)
Message-ID: <a6edebc8d7063836c7d031d86a3c43f2dd0f49bd.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/10] bpf: enforce exact retval range on
 subprog/callback exit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 22 Nov 2023 17:13:05 +0200
In-Reply-To: <20231122011656.1105943-5-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
	 <20231122011656.1105943-5-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> Instead of relying on potentially imprecise tnum representation of
> expected return value range for callbacks and subprogs, validate that
> both tnum and umin/umax range satisfy exact expected range of return
> values.
>=20
> E.g., if callback would need to return [0, 2] range, tnum can't
> represent this precisely and instead will allow [0, 3] range. By
> additionally checking umin/umax range, we can make sure that
> subprog/callback indeed returns only valid [0, 2] range.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
(but please see a question below)

[...]

> @@ -9464,6 +9477,16 @@ static bool in_rbtree_lock_required_cb(struct bpf_=
verifier_env *env)
>  	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
>  }
> =20
> +static bool retval_range_within(struct bpf_retval_range range, const str=
uct bpf_reg_state *reg)
> +{
> +	struct tnum trange =3D retval_range_as_tnum(range);
> +
> +	if (!tnum_in(trange, reg->var_off))
> +		return false;

Q: When is it necessary to do this check?
   I tried commenting it and test_{verifier,progs} still pass.
   Are there situations when umin/umax change is not sufficient?

> +
> +	return range.minval <=3D reg->umin_value && reg->umax_value <=3D range.=
maxval;
> +}
> +

[...]



