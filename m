Return-Path: <bpf+bounces-18773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA6821F9F
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FC280FDB
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28F14F89;
	Tue,  2 Jan 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIpKI8xb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B814F7C
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so16332872a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704213602; x=1704818402; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPX9+0Rd0BEN71Oi5tXu2086fK1YHGta6pZECOhxfJo=;
        b=jIpKI8xbYQKPf8yTO4Yv/zkwJcf5s14tVco0sCnIODln+AA9O0z7/l6tEfNmB1c2Vf
         LF0wyC5N5+JgGe5q3oMORppxG2Ncx6R4laEAB+MLZZ5e+HnIwE1biB+R6NM4la2gfUbD
         QML33TXQJ7iA9ZSjxbdKr6sx4It+3sA1Vzpk9cWYxPD6n2yFfjfV8kcM/l2bN6HKtKLQ
         jq3SZM8nHtvKhUp8oaccogtcj3e3O2Fq91zV+NdWS1oz/jht+yXRta8qn7Mjs4/2b/TB
         L3q4IviK6plbg/h8xN264ISecAfd5PGNnjodiFxhGHtb1R60XZ1cu2LT/BypV33K86va
         QssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704213602; x=1704818402;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPX9+0Rd0BEN71Oi5tXu2086fK1YHGta6pZECOhxfJo=;
        b=dc1vt/4hYnn11NqE/HAO4qXbB1sa6RKQ9PVv0BFQwFlI0Et0xyxvWg2Oglk7/e36e/
         BBdX5ipHw5Ydm5Q4/l3UnvLmJbBeyGFTsI1ZvrzibItvPZT8ft8PjThPbJeensWvaKZN
         mX42zjV74AjTztvzyecfbKZ0/R1p+NUZWgduaH8w0Dco/DIpqaR9+THU2w1P+iWtuDwL
         7x4cpY+UTX4kB901WTnaTzjeB7Yerh3P2tS1Zl+K9Faos+JRei72SHWmN/2kW7EaAgwd
         GWsh8OFHjNE4pDBArN7Uq3lXrlPYWgNrfiAGueXkKFF1PhmSXtUgNe5Z8D5AkXdP3DuA
         AG3A==
X-Gm-Message-State: AOJu0YzNVmKcHKMglB5bRmpu2u00J1Eo2XYjO37u34jl5ODLCBm87GWR
	bleodyUQKl1JaJgZKSsBGY7VGwyKHaE=
X-Google-Smtp-Source: AGHT+IFAGcmU/u8U667yqHcapgE///lgzopcES0/T83ljof8PzOi8I0NLbckkZtX0orezBUB9jCVoQ==
X-Received: by 2002:a05:6402:40cf:b0:554:8296:81d5 with SMTP id z15-20020a05640240cf00b00554829681d5mr16879129edb.3.1704213602142;
        Tue, 02 Jan 2024 08:40:02 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cq8-20020a056402220800b0055507ee70a4sm10058415edb.23.2024.01.02.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 08:40:01 -0800 (PST)
Message-ID: <1b75e54f235a7cb510768ca8142f15171024dd78.camel@gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>, BPF
	Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Date: Tue, 02 Jan 2024 18:39:55 +0200
In-Reply-To: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
References: 
	<CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-29 at 17:31 -0800, Maciej =C5=BBenczykowski wrote:
> I have a relatively complex program that fails to load on 6.5.6 with a
>=20
> if (data + 98 !=3D data_end) return TC_ACT_SHOT;
>=20
> check, that loads fine if I change the above !=3D to (a you would think
> weaker) > check.
>=20
> It's not important, hit this while debugging, and I don't know if the
> cause is the verifier treating !=3D differently than > or the compiler
> optimizing !=3D somehow... but my gut feeling is on the former: some
> verifier logic special cases > without doing something similar for the
> stronger !=3D comparison.

Please note the following comment in verifier.c:find_good_pkt_pointers():

    /* Examples for register markings:
     *
     * pkt_data in dst register:
     *
     *   r2 =3D r3;
     *   r2 +=3D 8;
     *   if (r2 > pkt_end) goto <handle exception>
     *   <access okay>
     *
     *   r2 =3D r3;
     *   r2 +=3D 8;
     *   if (r2 < pkt_end) goto <access okay>
     *   <handle exception>
     *
     *   Where:
     *     r2 =3D=3D dst_reg, pkt_end =3D=3D src_reg
     *     r2=3Dpkt(id=3Dn,off=3D8,r=3D0)
     *     r3=3Dpkt(id=3Dn,off=3D0,r=3D0)
     *
       ... a few lines skipped ...
     *
     * Find register r3 and mark its range as r3=3Dpkt(id=3Dn,off=3D0,r=3D8=
)
     * or r3=3Dpkt(id=3Dn,off=3D0,r=3D8-1), so that range of bytes [r3, r3 =
+ 8)
     * and [r3, r3 + 8-1) respectively is safe to access depending on
     * the check.
     */

In other words, from 'data + 98 > data_end' follows that 'data + 98 <=3D da=
ta_end',
which means that accessible range for 'data' pointer could be incremented b=
y 97 bytes.
However, the 'data + 98 !=3D data_end' is not sufficient to conclude that 9=
8 more bytes
are available, as e.g. the following: 'data + 42 =3D=3D data_end' could be =
true at the same time.
Does this makes sense?

Thanks,
Eduard

