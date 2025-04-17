Return-Path: <bpf+bounces-56102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D38CA914CA
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7778189A890
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AEF218AD4;
	Thu, 17 Apr 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPa6NJiv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E41DE89B
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873927; cv=none; b=RSTo+xQL0Mhs/K2DIuoAnE8vuuLu3DrG5BvXiY2d03fZfdFGJirtPJdyAuA11B2QhYrbwagTM9+4puYW4tGvYQ9NqES1q7UN1nu6QxyRItZUWg7IQE/jZqw1Q/ULKOUuVkOZmXBZ0RwcCZY6WUR2ygbF3Mx7B46Ix1EQ0SKpp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873927; c=relaxed/simple;
	bh=50nDBr7HaO/nY8PAFZfWpFIIsI4FE6ZxFeiR9zseHMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oo3t6624rlzivdOwVviR9xPlanLblW2bSvWybcZFhriUeJW8xAijwsnTKWe3/+f8YnAqJtbGQ8prP1WUq+hpTdNrdiBdT8XFMzEPBVWwkSM81hKu+Ir56OrZARuSX05VqgnuBqauIr61odkoOf7XnCSw45mMUR3pIclUUC17Dz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPa6NJiv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so82511066b.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 00:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744873924; x=1745478724; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50nDBr7HaO/nY8PAFZfWpFIIsI4FE6ZxFeiR9zseHMo=;
        b=UPa6NJivp5trF1vpq4oFQA7aSDst/tIWTj9seLE9NbCrU3yRtVQjiTy1DKm7UuCRKm
         mCTL7qsDc8AMsWVOe9IhijfRZyEzijhIJ+L1meEcglJxh181FDBzJPsstfkuI89kbP3b
         p2sE4ty4oewryVMQpAzoCnC/LgkEOMqlwwWo+Z4m2hmSAlVTGOVlOeQYMrhJGZf9Ksdf
         Zf+vrLO68O+dFXLwSMdEasktJI7v6YRvgSL/05d6dwgzM87g3t5tkvwazTV23JPEbgIn
         HhEb60ftUOKacb053jCQD7dGpStpPU7iKhNzTEQ5SueKDhjR9XWH8rlI4v7I8i/KVEyt
         o1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744873924; x=1745478724;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50nDBr7HaO/nY8PAFZfWpFIIsI4FE6ZxFeiR9zseHMo=;
        b=BSAHES1iy1VNFLEj7ScRGk+Bo21FP2Hr4MKKWtKRnPAbbj9edCsJ/ZHpje7+aPvjoQ
         1cKiv92vZGY+nVTBX+6pg6rEIxiXmD/6IfukenuidhmpH/Pq6ryW4bzfFaOPJjo7KLft
         2+sukvUJYuGObx6to93MxZYA5fTGcuo7kezCn+WyiQne9dFBVfTdrj5VOwiw2g5ThyU/
         rXYsiKkrJpjNQ+6xAYaFAWFn/LW9JpNCJzSweYTiOtl2+51PukYb80bKLS/yyzAbn0Ah
         b5oTc45i1KtAM+CbMXrl8dSI2mUSxpmgJQ4P/gbbyNrMVzS/SMqdXWOVE0lrNlUuuJwn
         drdw==
X-Forwarded-Encrypted: i=1; AJvYcCUOX5KR4M+z+fxDU+KatY/RD2wkJixPv9ovtEPaWproEIiq3XogH6CpO14iBRznMU7+16Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJMddAQFmI+OXRBpRenQiBOEOMALtEz2B0IKzxOZbYt2htwYJ
	YMJ/ABC8df7PVRLMr4aexcD9abmDLOYQXNlxuENnH7Lz/02HOVq00JM61tmcB72pZwr/d/WnXjm
	5m5Q=
X-Gm-Gg: ASbGncsMmt+vkv58Z8Urayb9rlpOh0oUGmeXO0xkVMEpRoI5UHdYD6VkFN8/gs9OEsV
	19+XDyyQXIrffpM7gsbruWx7gL8Oamxce0aKBdUJCWeg5U8c7Tm8BqX6D+eCUnDjqqO2BXfNgxK
	qWLbjGhgk68Iwn6HD7rXKRMb0+hok1fK1XBgrjCSAwgi9WdsQDcNYawfefeg4RYIf99ewkZpFkE
	axh2XrtYsFMvNCS8y0dFRaP4nCpOCC7TskTu3+jIOf62YvRBxKGX3J5GNJMcw3UWvQZT6URgoyr
	72KqbXXFRobnQnrnvHnO7ebzvxcSaQ8qjkYZL1ElKMbSczrAmTdMSM+8t8yowP2lA1zOGBDsxwD
	/nKQKhNke3CJH5HtFqtaRnfOrBswO7GVGf7vtXsTtXPKZXLUYeJnwLDd2n0dO4QeYlnhDqfjm/t
	Jv
X-Google-Smtp-Source: AGHT+IGN17Jla2vA+Rc2I0KCBT5Gabe2J463zV01EJ+NRwJL4xDEPQ+kEyFWGVBbFKYG3sPp/od4mw==
X-Received: by 2002:a17:907:608f:b0:ac3:8516:9cf2 with SMTP id a640c23a62f3a-acb42c2fcacmr391294266b.55.1744873923529;
        Thu, 17 Apr 2025 00:12:03 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b? (p200300e5873d1a008e99ce06aa4a2e7b.dip0.t-ipconnect.de. [2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54d8fsm9692478a12.12.2025.04.17.00.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:12:03 -0700 (PDT)
Message-ID: <0c29a3f9-9e22-4e44-892d-431f06555600@suse.com>
Date: Thu, 17 Apr 2025 09:12:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
To: Alexey <sdl@nppct.ru>, Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
 <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------d0C2m0JpY0HKG0p0HCAJyozK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------d0C2m0JpY0HKG0p0HCAJyozK
Content-Type: multipart/mixed; boundary="------------RSZrBREXB0vBHBFnA0obN3v4";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Alexey <sdl@nppct.ru>, Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Message-ID: <0c29a3f9-9e22-4e44-892d-431f06555600@suse.com>
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
 <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
In-Reply-To: <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>

--------------RSZrBREXB0vBHBFnA0obN3v4
Content-Type: multipart/mixed; boundary="------------WPzaECcOaD250uqrDoIyhJN6"

--------------WPzaECcOaD250uqrDoIyhJN6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDQuMjUgMDk6MDAsIEFsZXhleSB3cm90ZToNCj4gDQo+IE9uIDE3LjA0LjIwMjUg
MDM6NTgsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPj4gT24gTW9uLCAxNCBBcHIgMjAyNSAx
ODozNDowMSArMDAwMCBBbGV4ZXkgTmVwb21ueWFzaGloIHdyb3RlOg0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBnZXRfcGFnZShwZGF0YSk7DQo+PiBQbGVhc2Ugbm90aWNlIHRoaXMgZ2V0
X3BhZ2UoKSBoZXJlLg0KPj4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgeGRwZiA9IHhkcF9j
b252ZXJ0X2J1ZmZfdG9fZnJhbWUoeGRwKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHVu
bGlrZWx5KCF4ZHBmKSkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYWNlX3hk
cF9leGNlcHRpb24ocXVldWUtPmluZm8tPm5ldGRldiwgcHJvZywgYWN0KTsNCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPiBE
byB5b3UgbWVhbiB0aGF0IGl0IHdvdWxkIGJlIGJldHRlciB0byBtb3ZlIHRoZSBnZXRfcGFn
ZShwZGF0YSkgY2FsbCBsb3dlciwNCj4gYWZ0ZXIgY2hlY2tpbmcgZm9yIE5VTEwgaW4geGRw
Ziwgc28gdGhhdCB0aGUgcmVmZXJlbmNlIGNvdW50IGlzIG9ubHkgaW5jcmVhc2VkDQo+IGFm
dGVyIGEgc3VjY2Vzc2Z1bCBjb252ZXJzaW9uPw0KDQpJIHRoaW5rIHRoZSBlcnJvciBoYW5k
bGluZyBoZXJlIGlzIGdlbmVyYWxseSBicm9rZW4gKG9yIGF0IGxlYXN0IHZlcnkNCnF1ZXN0
aW9uYWJsZSkuDQoNCkkgc3VzcGVjdCB0aGF0IGluIGNhc2Ugb2YgYXQgbGVhc3Qgc29tZSBl
cnJvcnMgdGhlIGdldF9wYWdlKCkgaXMgbGVha2luZw0KZXZlbiB3aXRob3V0IHRoaXMgbmV3
IHBhdGNoLg0KDQpJbiBjYXNlIEknbSB3cm9uZyBhIGNvbW1lbnQgcmVhc29uaW5nIHdoeSB0
aGVyZSBpcyBubyBsZWFrIHNob3VsZCBiZQ0KYWRkZWQuDQoNCg0KSnVlcmdlbg0K
--------------WPzaECcOaD250uqrDoIyhJN6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------WPzaECcOaD250uqrDoIyhJN6--

--------------RSZrBREXB0vBHBFnA0obN3v4--

--------------d0C2m0JpY0HKG0p0HCAJyozK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgAqcIFAwAAAAAACgkQsN6d1ii/Ey9s
zgf+LywK5tRw1pt3A75AZkpDPjXyAy+HTSV/CVvkluaNPsqNM5Yg2+iYZZZKp+C2omR4jCFUNDUn
EU5EnIclpZzA3Ox0JZrqjlrjknY4cD8QKits78CTlfr5aHrB7qPj3yRgvh/XxXS3Vz5v97yc/2YW
e4p+YULttX7frz3a9ygzgz6TbtLLLw19HxCgTGvA2upI43v+abbnowNz/NOagJQ6WD4WmPpUBCRS
4Yu1Z/NjKO+IbvAuX01hVdNedc+pN2lztOrK6GkjDE6HUAgyNqdQTEZrhOl9N/tysDDOEdkUxexg
XsVZt0ZcfKPyAIhgRW3SVID/G2LiUiH7KO5QEmr2/w==
=uCI0
-----END PGP SIGNATURE-----

--------------d0C2m0JpY0HKG0p0HCAJyozK--

