Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6B59E9ED
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiHWRjt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiHWRjK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 13:39:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141FCA571B
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:26:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u14so17424800wrq.9
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=LELg1Z7nPbwn0KZJ2PEQVdnqaL7jyRzEtX5e4Ufm4Bg=;
        b=jgZEK6gHa8tXXnM4o2Ma+l3L+vs2E3nLjHpPdDAOalb4dQHErJwQvtPa4Saq78mnWy
         faw0pKZlrf0OwrwXWY0b+wEPixLYXdhlA/RVUXL7RL5ynEzXpkYdZ54qxgHujzMEtWJt
         /kh8uTd+0Buw4QQbDr0BvNUdeSAaykD0tRP3UUJ95nKTI0MEhlpZCeTSpjyIHWC+xqvB
         CNRTk9/GMmhnntaGa0rK6duo9+S20vjnYgEu6P8HsTHAISFFoPUFhiXR2rAAy21JBD3v
         Pwk88PRU2OFTqPGqxyC5JKYNhu01crXMcfIzmOZCGKV80ki8myfWaNEVivfzlrdnrnVo
         AwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=LELg1Z7nPbwn0KZJ2PEQVdnqaL7jyRzEtX5e4Ufm4Bg=;
        b=NQ3H9kJwZlaCassZ8eLQxBwEa7cEJQJqwAuMpsU22cfxIIV9S21UH3adQFjk4PJqdM
         AXHcc4nPY4FxQsUXtX9IUAybqzJunzHDRhhkXXVUbuCDAwmHZkUDHZOjAXvCKn8YzTVT
         o7VAPXS6mOgn/YPoRuEZSXis5EGwxZvYNSL9JgFL/CuJoznUA5wHHTwIh7JXSMBvnHR8
         XqjWv7A5dBAv6DFDY7ZkavOaNT3Ues1cjLWbbdxgFV/C2XrZ60WWKewIzsa8fTfeGVw9
         iyEin/I+/2/PC3ZbimGibDnt8q+D1Xm+ESnHsZlGKPWojon0zNdrjA2g8s7gzZFR8QoG
         p1Qw==
X-Gm-Message-State: ACgBeo1kHBio1y0rCDQKwMiRRe8AuQ0Gr7MfhCyVtFMxS2132YDAEbVW
        6krpNEyqpc+34672rEGlyUY=
X-Google-Smtp-Source: AA6agR7/2SZwzgJeVq2qyOC4BZPH14Gfv6nfv2DUDkQ8HZvECSRBxIm1HE8bn1F87i/JHbP6zI7FAg==
X-Received: by 2002:a05:6000:1ac8:b0:220:6af3:935d with SMTP id i8-20020a0560001ac800b002206af3935dmr13830682wry.549.1661268416556;
        Tue, 23 Aug 2022 08:26:56 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id f10-20020adff8ca000000b002252cb35184sm14704352wrq.25.2022.08.23.08.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 08:26:56 -0700 (PDT)
Message-ID: <a94f8c66-f53c-bd60-4567-a06a3f77acbb@gmail.com>
Date:   Tue, 23 Aug 2022 17:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next] scripts/bpf: Fix attributes for bpf-helpers(7)
 man page
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
References: <20220823084719.13613-1-quentin@isovalent.com>
 <a9533d19-8266-8eed-63ec-82aa07ce83d0@gmail.com>
 <1c07206a-25c5-9621-afd5-d64913fece13@isovalent.com>
 <8af3984e-49f4-e94f-df87-6609a5330b9f@gmail.com>
 <593cfd34-9394-5f7c-e3b9-c4492533d030@isovalent.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <593cfd34-9394-5f7c-e3b9-c4492533d030@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6dDTgWtVn0C0G5NNKMp9I8iv"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6dDTgWtVn0C0G5NNKMp9I8iv
Content-Type: multipart/mixed; boundary="------------gm1yrThJpxER00YvCfKJvYpc";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Quentin Monnet <quentin@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org
Message-ID: <a94f8c66-f53c-bd60-4567-a06a3f77acbb@gmail.com>
Subject: Re: [PATCH bpf-next] scripts/bpf: Fix attributes for bpf-helpers(7)
 man page
References: <20220823084719.13613-1-quentin@isovalent.com>
 <a9533d19-8266-8eed-63ec-82aa07ce83d0@gmail.com>
 <1c07206a-25c5-9621-afd5-d64913fece13@isovalent.com>
 <8af3984e-49f4-e94f-df87-6609a5330b9f@gmail.com>
 <593cfd34-9394-5f7c-e3b9-c4492533d030@isovalent.com>
In-Reply-To: <593cfd34-9394-5f7c-e3b9-c4492533d030@isovalent.com>

--------------gm1yrThJpxER00YvCfKJvYpc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gOC8yMy8yMiAxNzoxOCwgUXVlbnRpbiBNb25uZXQgd3JvdGU6
DQo+PiBUaGUgdmVyc2lvbmluZyBzaG91bGQgYWx3YXlzIGJlIGNvcnJlY3QuwqAgZ2l0LWRl
c2NyaWJlKDEpIHNob3VsZCBiZQ0KPj4gcHJlZmVycmVkLCBvciBpbiBhYnNlbmNlIG9mIHRo
YXQsIGEgZ2VuZXJpYyAodW5yZWxlYXNlZCkgc3RyaW5nIHNob3VsZA0KPj4gYmUgdXNlZC7C
oCBEZXNjcmliaW5nIGFueSBjb21taXQgYWZ0ZXIgdjUuMTggYW5kIGJlZm9yZSB2NS4xOS1y
YzEgdG8gYmUNCj4+ICc1LjE4LjAnIGlzIHBsYWluIHdyb25nL21pc2xlYWRpbmcuwqAgVGhl
IE1ha2VmaWxlIHNob3VsZCBwcm9iYWJseQ0KPj4gYXV0b2dlbmVyYXRlIHRoYXQgaW5mbyBm
cm9tIGdpdC1kZXNjcmliZSgxKS7CoCBTZWUgaG93IHRoZSBMaW51eA0KPj4gbWFuLXBhZ2Vz
IGRvIGl0IChpbiB0aGUgbGlua3MgYWJvdmUgeW91IGNhbiBzZWUgaXQpIGZvciBleGFtcGxl
Lg0KPiANCj4gSXQncyBub3QgcmVhbGx5IGFib3V0IGhvdyB0byBkbyBpdCwgbW9yZSB0aGF0
IEkgZG9uJ3Qgd2FudCB0byBoYXZlIGENCj4gaGFyZCBkZXBlbmRlbmN5IG9uIGdpdCBmb3Ig
dGhlIHNjcmlwdC4gSSB3YW50IGl0IHRvIHJ1biBqdXN0IGFzIHdlbGwNCj4gd2hlbiB0aGVy
ZSdzIG5vIEdpdCByZXBvIGFyb3VuZC4gQnV0IEkgY2FuIHRyeSB0byBydW4gImdpdCBkZXNj
cmliZSIgYW5kDQo+IGZhbGwgYmFjayBvbiB0aGUgTWFrZWZpbGUgKG9yIG9uIGFuIGVtcHR5
IHZlcnNpb24pIGlmIHRoZSBjb21tYW5kIGZhaWxzLg0KDQpZZWFoLCBJIGRpZG4ndCBtZWFu
IGl0J3MgYSBidWcgaW4gdGhlIHNjcmlwdCwgYnV0IHNlZW1zIHRvIG1lIGxpa2UgYSBidWcg
DQppbiB0aGUga2VybmVsIE1ha2VmaWxlLiAgSWYgZ2l0IGZhaWxzIGJlY2F1c2UgaXQncyBu
b3QgcHJlc2VudCwgdGhlcmUgDQpjb3VsZCBiZSBhIGZhbGxiYWNrIGxpa2UgInVua25vd24t
dmVyc2lvbiIuICBJbiB0aGUgbWFuLXBhZ2VzLCB3aGVuIEkgDQpwcmVwYXJlIHRoZSB0YXJi
YWxsLCB3aXRoIGBtYWtlIGRpc3RgLCBJIGhhcmRjb2RlIHRoZSB2ZXJzaW9uIGluIHRoZSAN
CnBhZ2VzLiAgTWF5YmUgdGhlIGtlcm5lbCBNYWtlZmlsZSBzaG91bGQgaGF2ZSB1bnJlbGVh
c2VkIGFzIHRoZSB2ZXJzaW9uIA0KaW4gdGhlIGdpdCByZXBvLCBhbmQgd2hlbiBhIHRhcmJh
bGwgaXMgZ2VuZXJhdGVkIHRoZSBNYWtlZmlsZSBzaG91bGQgDQpyZXBsYWNlIHRoYXQgdW5y
ZWxlYXNlZCB2ZXJzaW9uIGJ5IHRoZSBhcHByb3ByaWF0ZSBnaXQgdmVyc2lvbi4gIFNpbmNl
IA0KZ2l0IHdpbGwgbm90IGJlIGZvdW5kIGluIHRoZSB0YXJiYWxscywgdGhhdCB2ZXJzaW9u
IHdpbGwgYmUgdXNlZCBpbiB0aGF0IA0KY2FzZS4gIEJ1dCB3aGVuIHJ1bm5pbmcgZnJvbSBn
aXQsIGdpdC1kZXNjcmliZSgxKSBzaG91bGQgYmUgcHJlZmVycmVkLg0KDQo+IA0KPiBPSyBJ
J2xsIHByZXBhcmUgYSBuZXcgdmVyc2lvbiwgdGhhbmtzIGZvciB5b3VyIGhlbHAuDQoNCkl0
J3MgYSBwbGVhc3VyZSENCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCj4gUXVlbnRpbg0KDQotLSAN
CkFsZWphbmRybyBDb2xvbWFyDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5lcy8+
DQo=

--------------gm1yrThJpxER00YvCfKJvYpc--

--------------6dDTgWtVn0C0G5NNKMp9I8iv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmME8b4ACgkQnowa+77/
2zKk4A/9HlfLyh+XEvdKmCMrtP9d9fzZMqcTgr7rjBUqWh2mTVhQ/4Z/2mHbF9Rg
qm6hOu0CDqLE0EheHC/IZqWPTci7GyO3umnVH4qjI26T0JYl8us3AWmRIj0+916o
kw57xcfbWZupuQ9BbF4tt6rypTeptNtxcFh6ojDz8NJGZcpOZoZQYSRqXLQ6PRlA
AwG3+/127dWCKTJ1ARBz2yYFoe30sgMsTwWbw5+EeBqRYD8HSeIt0LfBjbVx8ONz
CpSNOXBqJlArIKOMsoOKOMg3rBldEuszIpC0NflUieA+JVvO1co1Hqo7TX/Blw9/
oWe93q8MpilUKpw862mpE0Y1UK93k7NNhqlg976lnlnIlunrwIEzHUQg0JmLTNaQ
sQgPxQwC3om8lVs0AaMgzVRZgqqCaXa8cUwS8jnaEKgm+0IjzcYTF3wZX2z8ZM6v
koCQxAmElDpZYgQ+IT1BlEr9gg5Qk+LltO8u3kASD6iJT3CDHdSBqtUkd2jnxMFr
one20VqElV1tigCGKDyT66KDiaaekpRpUdiHM0dlvMpnkh3TT4GFQbEHK9JQ9fw7
bUohgO/0WEqNSh5RW8O8XrEZscjeF19vm/ZD7kkz16YfaCTrc4cfxftGf8ALggNr
UvuCYclaxgKQe5dMIoi7gdbhFdVzOBZERq79a61cPUzQ2Da/xnU=
=3vuP
-----END PGP SIGNATURE-----

--------------6dDTgWtVn0C0G5NNKMp9I8iv--
