Return-Path: <bpf+bounces-15262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D0C7EF798
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 19:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7C42811C8
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBBD43173;
	Fri, 17 Nov 2023 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AENdSaHR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95CBC5
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c603e2354fso441555866b.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 10:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700247215; x=1700852015; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cpbDwLpNiWFsMvbOYPI1FsSaL8yG3bUFRzto6tvMaQA=;
        b=AENdSaHRqDwdTNffYjfMl76OmyOI4cqdeqbNEkB4PQOXMSiQ/EHkscb4uFdvp1cW2B
         h4xmmLcsl6o5Aq7cC2VqMaEAhl+WgRFW5hliIyugaC7syuBnbaP75YhLv0ptG5zUOTkd
         ccFll/aK8lHAflsjgsC/IJYSFTTh1xb0GJb6CT6dukPoXlq6rEGjjLzEXKSTcq+hiQ3j
         CR9C8iBYWulVkIl5kA24oRdLxLRZO2P5FZuHgloz57cRjmdX7GAWVhtDw9SWvgU95oTW
         r3UiWMIsFoS+uqNo9ISF7uoeVdX4ObQ6n0PhPmSbKkMWqPVzenUsByvNcNk5FEXoGnAy
         pgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247215; x=1700852015;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpbDwLpNiWFsMvbOYPI1FsSaL8yG3bUFRzto6tvMaQA=;
        b=NwfSnXrZjzE8l3G6JaBBQy1TzSf2VJ72xzLuElln7V0HNr1ilXmp+UysP45AoUjuGa
         AwV7p/o2lelpBATBTAf6zgYZOu5pWcd04hT9yt+GfUdzFNenDCRkA3DxqjAoSqmsBknp
         5loDj2vxfBLZuROqjjEnVy/QJSdoZAtH3PnM0SAFC63ckernbs07UqrSnRU8MGemDHkk
         fH94PwiB31iPbFt84ZVOalX52Ol7Yoxkch5407skAd3joxWFwVINcjPJDgji3KRd1fK7
         Ydgp0+Vks+YKggvHXLVTgMBPZRd85+wpQxR1TFJpVdsF9czvS5KD+bBcnoAkflj+xycV
         bJjQ==
X-Gm-Message-State: AOJu0YzAsDZd77Qx/jljYNYOMFKspd4pU/oj14nkNmm5rkT6QOP9kF0t
	fBZUzjkbv/z+g9hJh5F+SZI=
X-Google-Smtp-Source: AGHT+IGEqlKsK5K5qpo0SpBUwvexDYWn7oPp+z2CfKX8CscXLIiCmKM1M0Dj4DLVAHmES4fy0F3PPA==
X-Received: by 2002:a17:906:a859:b0:9a9:f0e6:904e with SMTP id dx25-20020a170906a85900b009a9f0e6904emr6123213ejb.16.1700247215090;
        Fri, 17 Nov 2023 10:53:35 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ig11-20020a1709072e0b00b009adc5802d08sm1045329ejc.190.2023.11.17.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:53:34 -0800 (PST)
Message-ID: <6da7c6b9617663daa54ed27d2c1637cc71dfb7a3.camel@gmail.com>
Subject: Re: [PATCH bpf 12/12] selftests/bpf: check if max number of
 bpf_loop iterations is tracked
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 20:53:32 +0200
In-Reply-To: <CAEf4BzYd_Dv4fEoPe+n+sRXxHFmYrTs7w45jtYeQByNH521gzA@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-13-eddyz87@gmail.com>
	 <CAEf4BzYd_Dv4fEoPe+n+sRXxHFmYrTs7w45jtYeQByNH521gzA@mail.gmail.com>
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

On Fri, 2023-11-17 at 11:47 -0500, Andrii Nakryiko wrote:
[...]
> > +SEC("?raw_tp")
> > +__success __log_level(2)
> > +/* Check that last verified exit from the program visited each
> > + * callback expected number of times: one visit per callback for each
> > + * top level bpf_loop call.
> > + */
> > +__msg("r1 =3D *(u64 *)(r10 -16)       ; R1_w=3D111111 R10=3Dfp0 fp-16=
=3D111111")
> > +/* Ensure that read above is the last one by checking that there are
> > + * no more reads for ctx.i.
> > + */
> > +__not_msg("r1 =3D *(u64 *)(r10 -16)      ; R1_w=3D")
>=20
> can't you enforce that we don't go above 111111 just by making sure to
> use r1 - 111111 + 1 as an index into choice_arr()?
>=20
> We can then simplify the patch set by dropping __not_msg() parts (and
> can add them separately).

Well, r1 could be 0 as well, so idx would be out of bounds.
But I like the idea, it is possible to check that r1 is either 00000,
100000, ..., 111111 and do something unsafe otherwise.
Thank you. I'll drop __not_msg() then.



