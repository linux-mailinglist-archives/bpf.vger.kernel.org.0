Return-Path: <bpf+bounces-56120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD0A9193A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11867444D04
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BB22CBE5;
	Thu, 17 Apr 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JJKz4Gxb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03E6229B15
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885442; cv=none; b=oq+VyU9cMyfYWKGqztjevUnTRQAwdqUWU4o2TW3uAKKJD9UIQb3aOpLVI6q+Yg0Q+SzXFx8O3E284OzMzIQGs0jH2IyLobsCZCPgOmfx+lDTCVc5uKYADF0hzfppuub7zGBJAb0ocm/wnBy9wz7mhCUSu0QKV4O62q4fU/yEVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885442; c=relaxed/simple;
	bh=VOZVNhVxO35FaeFKJPov8ukkJ2SijtrRjbND3uyzMKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zypr6B8qxY2c5L89XVhtwW6Mjil9Rp4phnuc6fQ0p4/QnKYy2HOzeut9PwysCW67dCBxZ5QCuy+cc/aCh6tCmMbyWeNohKnoamcO4I7SeHcUTHOUTwuMQ5G6v9U2Jt3em8hE2mGHubr19TebGNZbw3blRkMtQEufbSzIiOHN140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JJKz4Gxb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso86945866b.2
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744885438; x=1745490238; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VOZVNhVxO35FaeFKJPov8ukkJ2SijtrRjbND3uyzMKU=;
        b=JJKz4GxbF4bz1tEDbhDiLCjLBFC/TwAmN3/EonRme8MULRTwNjXjsJIGPMR4xrm9ch
         TrsLrXhQ50oqrWlwS6jfHf+MZ9ijkyLQX+SL2lieDNERbn89K/mkuRWBn+ovJ6ka1cnm
         ax113fnZhRynUUiFty6D0qeREHywEVHK31CG3kUpTIxuYDjzVn4VezrJtaKMjfextWnV
         cawDR9prtYCT9u/PRcs5RB44qZJVW9rMal0EJS077jDi8g/85HuEnG2EoGCbKXyvhma+
         5m0rsiUCeXvrQe9t7g38DmG9xrNW4Xp5DA4k7lCVfuJ17K8gczJ232hsYDfnV/q4u9aA
         3row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744885438; x=1745490238;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOZVNhVxO35FaeFKJPov8ukkJ2SijtrRjbND3uyzMKU=;
        b=AEdIjx1qDY6VDPRSGM4eKisy8WpwkapFlNi46Ykqp3+86X4f517kkVS9FJhOykiE4S
         wnlyUCiU91VQhX5BSgG8dYPRMvuG8tWNNFM4ydrqGir/b9N+xfBRjwUFNsWBACRkMTVx
         LSr56jXw1LJNz90gCxR77C1hpZ8ajr3F2sCpn9rYl4bkFroCVUY5gLAH8okzqrcyG2bu
         d9h8p5mNwO0fRPUR6GCBRUls7rEp9HD1VJbdQ+3/9Qzgs4e/Iw3IPE01AvEbIpAic0QB
         H2O9qI6unuXj3YovmoskYJe+Khvi8D46sWDyuSox+ee2xsY4ib9XR4Xi29sr19Zw0QJO
         2WlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjgP7sszxxoHAYhIWmoW6yqjglVDW48MCzETZFjFdMZj9P710hQ9UBcot6/0N0jShkQpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2NfAaMcqfUPqmkSCESHiIjaXQNbRnjYLqy7BH+xt5REKdJgz
	eHUatcPsk7X6Z2sJ1EMH4V5x1suhlX27NLuf+xJ1Wb0qGzYGxZ9TIV63/I67418=
X-Gm-Gg: ASbGncu/+bgiUMC4fUB9c9eck0z09t5RBGuUyag4b3KZghzsXZEex76mXIAwVyHfMFV
	RFnbbthAccYFED2b3puS6t4bl2KzUAGAQppepp7yVe91uGktjepLtko5lcgtCoUgbafUt2oUuDP
	o9GVie0IkEtasmQnmOLnWHnrZs/jH1+snias/HFe56pQPZw+PI19DcpDcpmMWiOES30trSRo+l9
	jYfxf4SK4ZYOVMibH6IoOaxrs+zwC+1+jiGTTon5gtJrrOS1d+M74TqWRWXwP57+7EmJURp1sVY
	ogvkzI0KTNdXU6foNWUCFcuF3L3h19RuAGnqlv1FBrmDS9Sw4L/sqhUT5JHOJw3x+h/ZIMNB/Kh
	bz3rC/DDK5Au4mWA568mqBEZp21VuGAryjC/H96kN5GTKyL1pd9I/AxnJb75YynPPuQ==
X-Google-Smtp-Source: AGHT+IHDrJBjqNzW7VtwUP9YzLXLrQlOBiInCLaKw8WycCQs6BYkHJtdLj1AvTYDg9nF69SHomHayg==
X-Received: by 2002:a17:907:3cc6:b0:ac7:ec90:2ae5 with SMTP id a640c23a62f3a-acb42997607mr533236066b.25.1744885438055;
        Thu, 17 Apr 2025 03:23:58 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b? (p200300e5873d1a008e99ce06aa4a2e7b.dip0.t-ipconnect.de. [2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb63a14c5esm54541566b.19.2025.04.17.03.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 03:23:57 -0700 (PDT)
Message-ID: <4679ca25-572b-44aa-bc00-cb9dc1c0080c@suse.com>
Date: Thu, 17 Apr 2025 12:23:56 +0200
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
 <0c29a3f9-9e22-4e44-892d-431f06555600@suse.com>
 <452bac2e-2840-4db7-bbf4-c41e94d437a8@nppct.ru>
 <ed8dec2a-f507-49be-a6f3-fb8a91bfef01@suse.com>
 <8264519a-d58a-486e-b3c5-dba400658513@nppct.ru>
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
In-Reply-To: <8264519a-d58a-486e-b3c5-dba400658513@nppct.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------80XappD84HqnFoIoZ4BtBZ6n"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------80XappD84HqnFoIoZ4BtBZ6n
Content-Type: multipart/mixed; boundary="------------nhTMLOtnttMTIlWDi7qUzJUH";
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
Message-ID: <4679ca25-572b-44aa-bc00-cb9dc1c0080c@suse.com>
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
 <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
 <0c29a3f9-9e22-4e44-892d-431f06555600@suse.com>
 <452bac2e-2840-4db7-bbf4-c41e94d437a8@nppct.ru>
 <ed8dec2a-f507-49be-a6f3-fb8a91bfef01@suse.com>
 <8264519a-d58a-486e-b3c5-dba400658513@nppct.ru>
In-Reply-To: <8264519a-d58a-486e-b3c5-dba400658513@nppct.ru>

--------------nhTMLOtnttMTIlWDi7qUzJUH
Content-Type: multipart/mixed; boundary="------------0Ea0kxqx80BDEhzLETg0vGo6"

--------------0Ea0kxqx80BDEhzLETg0vGo6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDQuMjUgMTI6MDYsIEFsZXhleSB3cm90ZToNCj4gDQo+IE9uIDE3LjA0LjIwMjUg
MTE6NTEsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBPbiAxNy4wNC4yNSAxMDo0NSwgQWxl
eGV5IHdyb3RlOg0KPj4+DQo+Pj4gT24gMTcuMDQuMjAyNSAxMDoxMiwgSsO8cmdlbiBHcm/D
nyB3cm90ZToNCj4+Pj4gT24gMTcuMDQuMjUgMDk6MDAsIEFsZXhleSB3cm90ZToNCj4+Pj4+
DQo+Pj4+PiBPbiAxNy4wNC4yMDI1IDAzOjU4LCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4+
Pj4+PiBPbiBNb24sIDE0IEFwciAyMDI1IDE4OjM0OjAxICswMDAwIEFsZXhleSBOZXBvbW55
YXNoaWggd3JvdGU6DQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfcGFnZShwZGF0
YSk7DQo+Pj4+Pj4gUGxlYXNlIG5vdGljZSB0aGlzIGdldF9wYWdlKCkgaGVyZS4NCj4+Pj4+
Pg0KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgeGRwZiA9IHhkcF9jb252ZXJ0X2J1ZmZf
dG9fZnJhbWUoeGRwKTsNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseSgh
eGRwZikpIHsNCj4+Pj4+Pj4gKyB0cmFjZV94ZHBfZXhjZXB0aW9uKHF1ZXVlLT5pbmZvLT5u
ZXRkZXYsIHByb2csIGFjdCk7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJy
ZWFrOw0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPj4+Pj4gRG8geW91IG1lYW4gdGhh
dCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbW92ZSB0aGUgZ2V0X3BhZ2UocGRhdGEpIGNhbGwg
bG93ZXIsDQo+Pj4+PiBhZnRlciBjaGVja2luZyBmb3IgTlVMTCBpbiB4ZHBmLCBzbyB0aGF0
IHRoZSByZWZlcmVuY2UgY291bnQgaXMgb25seSBpbmNyZWFzZWQNCj4+Pj4+IGFmdGVyIGEg
c3VjY2Vzc2Z1bCBjb252ZXJzaW9uPw0KPj4+Pg0KPj4+PiBJIHRoaW5rIHRoZSBlcnJvciBo
YW5kbGluZyBoZXJlIGlzIGdlbmVyYWxseSBicm9rZW4gKG9yIGF0IGxlYXN0IHZlcnkNCj4+
Pj4gcXVlc3Rpb25hYmxlKS4NCj4+Pj4NCj4+Pj4gSSBzdXNwZWN0IHRoYXQgaW4gY2FzZSBv
ZiBhdCBsZWFzdCBzb21lIGVycm9ycyB0aGUgZ2V0X3BhZ2UoKSBpcyBsZWFraW5nDQo+Pj4+
IGV2ZW4gd2l0aG91dCB0aGlzIG5ldyBwYXRjaC4NCj4+Pj4NCj4+Pj4gSW4gY2FzZSBJJ20g
d3JvbmcgYSBjb21tZW50IHJlYXNvbmluZyB3aHkgdGhlcmUgaXMgbm8gbGVhayBzaG91bGQg
YmUNCj4+Pj4gYWRkZWQuDQo+Pj4+DQo+Pj4+DQo+Pj4+IEp1ZXJnZW4NCj4+Pg0KPj4+IEkg
dGhpbmsgcGRhdGEgaXMgZnJlZWQgaW4geGRwX3JldHVybl9mcmFtZV9yeF9uYXBpKCkgLT4g
X194ZHBfcmV0dXJuKCkNCj4+DQo+PiBBZ3JlZWQuIEJ1dCB3aGF0IGlmIHhlbm5ldF94ZHBf
eG1pdCgpIHJldHVybnMgYW4gZXJyb3IgPCAwPw0KPj4NCj4+IEluIHRoaXMgY2FzZSB4ZHBf
cmV0dXJuX2ZyYW1lX3J4X25hcGkoKSB3b24ndCBiZSBjYWxsZWQuDQo+Pg0KPj4NCj4+IEp1
ZXJnZW4NCj4gDQo+IEFncmVlZC4gVGhlcmUgaXMgbm8gZXhwbGljaXQgZnJlZWQgcGRhdGEg
aW4gdGhlIGNhbGxpbmcgZnVuY3Rpb24NCj4geGVubmV0X2dldF9yZXNwb25zZXMoKS4gV2l0
aG91dCB0aGlzLCB0aGUgcGFnZSByZWZlcmVuY2VkIGJ5IHBkYXRhDQo+IGNvdWxkIGJlIGxl
YWtlZC4NCj4gDQo+IEkgc3VnZ2VzdDoNCiA+DQogPiAgCWNhc2UgWERQX1RYOg0KID4gLQkJ
Z2V0X3BhZ2UocGRhdGEpOw0KID4gIAkJeGRwZiA9IHhkcF9jb252ZXJ0X2J1ZmZfdG9fZnJh
bWUoeGRwKTsNCiA+ICsJCWlmICh1bmxpa2VseSgheGRwZikpIHsNCiA+ICsJCQl0cmFjZV94
ZHBfZXhjZXB0aW9uKHF1ZXVlLT5pbmZvLT5uZXRkZXYsIHByb2csIGFjdCk7DQogPiArCQkJ
YnJlYWs7DQogPiArCQl9DQogPiArCQlnZXRfcGFnZShwZGF0YSk7DQogPiAgCQllcnIgPSB4
ZW5uZXRfeGRwX3htaXQocXVldWUtPmluZm8tPm5ldGRldiwgMSwgJnhkcGYsIDApOw0KID4g
IAkJaWYgKHVubGlrZWx5KCFlcnIpKQ0KID4gIAkJCXhkcF9yZXR1cm5fZnJhbWVfcnhfbmFw
aSh4ZHBmKTsNCiA+IC0JCWVsc2UgaWYgKHVubGlrZWx5KGVyciA8IDApKQ0KID4gKwkJZWxz
ZSBpZiAodW5saWtlbHkoZXJyIDwgMCkpIHsNCiA+ICAJCQl0cmFjZV94ZHBfZXhjZXB0aW9u
KHF1ZXVlLT5pbmZvLT5uZXRkZXYsIHByb2csIGFjdCk7DQogPiArCQkJeGRwX3JldHVybl9m
cmFtZV9yeF9uYXBpKHhkcGYpOw0KID4gKwkJfQ0KDQpDb3VsZCB5b3UgcGxlYXNlIG1lcmdl
IHRoZSB0d28gaWYgKCkgYmxvY2tzLCBhcyB0aGV5IHNoYXJlIHRoZQ0KY2FsbCBvZiB4ZHBf
cmV0dXJuX2ZyYW1lX3J4X25hcGkoKSBub3c/IFNvbWV0aGluZyBsaWtlOg0KDQppZiAodW5s
aWtlbHkoZXJyIDw9IDApKSB7DQoJaWYgKGVyciA8IDApDQoJCXRyYWNlX3hkcF9leGNlcHRp
b24ocXVldWUtPmluZm8tPm5ldGRldiwgcHJvZywgYWN0KTsNCgl4ZHBfcmV0dXJuX2ZyYW1l
X3J4X25hcGkoeGRwZik7DQp9DQoNCiA+ICAJCWJyZWFrOw0KID4gIAljYXNlIFhEUF9SRURJ
UkVDVDoNCiA+ICAJCWdldF9wYWdlKHBkYXRhKTsNCiA+ICAJCWVyciA9IHhkcF9kb19yZWRp
cmVjdChxdWV1ZS0+aW5mby0+bmV0ZGV2LCB4ZHAsIHByb2cpOw0KID4gIAkJKm5lZWRfeGRw
X2ZsdXNoID0gdHJ1ZTsNCiA+IC0JCWlmICh1bmxpa2VseShlcnIpKQ0KID4gKwkJaWYgKHVu
bGlrZWx5KGVycikpIHsNCiA+ICAJCQl0cmFjZV94ZHBfZXhjZXB0aW9uKHF1ZXVlLT5pbmZv
LT5uZXRkZXYsIHByb2csIGFjdCk7DQogPiArCQkJX194ZHBfcmV0dXJuKHBhZ2VfYWRkcmVz
cyhwZGF0YSksICZ4ZHAtPm1lbSwgdHJ1ZSwgeGRwKTsNCiA+ICsJCX0NCiA+ICAJCWJyZWFr
Ow0KDQoNCkp1ZXJnZW4NCg0KUC5TLjogcGxlYXNlIGRvbid0IHVzZSBIVE1MIGluIGVtYWls
cw0K
--------------0Ea0kxqx80BDEhzLETg0vGo6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------0Ea0kxqx80BDEhzLETg0vGo6--

--------------nhTMLOtnttMTIlWDi7qUzJUH--

--------------80XappD84HqnFoIoZ4BtBZ6n
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgA1r0FAwAAAAAACgkQsN6d1ii/Ey/B
Vwf+MIfL/B2+Fhj0Xj7nAVp/jeMZJYVCEW5yyzCeQPzfYoKDh5FlfWL03hHnsekhx3lz6R83h8P3
sIKR8juToker8YgsFZvQQaXpKCNBOzThTBCcQuDxVr2chNTS7ojljGFMDu6ENLkhOb8NqiZWO6KE
mS1PXQ3UQwYl+5mYwMaowZwAXEXBvbwvAccQC30XZ8PbKWk0AoRc1YlI/U7tFpQwxVtW0is5ewJ/
UFoHnwgbFhWQ+4S+LcvURFjBTnNdQEpq/ahhvQNhgyJ9Drzddej0yTpROQWiv4tgkxoRTA3/fkVR
E+OuYFP0aMLsSSJfzixGbBvvDO+8EvYvmTtZc0DdWA==
=5kvB
-----END PGP SIGNATURE-----

--------------80XappD84HqnFoIoZ4BtBZ6n--

