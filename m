Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995915A2D3C
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiHZRSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiHZRR6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 13:17:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C70EDFB7F;
        Fri, 26 Aug 2022 10:17:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u5so2526510wrt.11;
        Fri, 26 Aug 2022 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=Ka9MFQxCPa3boCvexoTm1hMno6nNE4dkf87Rf/h60HU=;
        b=XvRHMimkxLs4l2e7h72+dJUfYu6kNtimgMceLfKIPm7T6bKuNMarYSN3MWz7ZyUCck
         oY/sD8yOQXt145+QqdSDtlfxOp5DosnVyoGWGMvW+ASB8ZHzjQwuH2sWG2zxtk4fbG3O
         SPGu2y08jo9AuselxIC15UpN1Q2nPf0KP1THTD7RnaDNn33B8AYrVywu1KL7V9xCEo/2
         yCjBjQbxKwDwvUM9M+5XGf02Tn9cFRwntOitXwmvxbOr13IHr5IW8AAiB5XZDWlbO7Cy
         4An4d791DuQOr5eoiagTrBoo6SrmP5WjUWMaPQkwG5jma2bP1+6w+KP8MrhZ88pi4Op0
         R7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=Ka9MFQxCPa3boCvexoTm1hMno6nNE4dkf87Rf/h60HU=;
        b=wozQLNEDXZD1SRrDmHfLsdJqK09NfCyo0POsClQZEXssZuKP7Z6ilgH9UVwli9XNiH
         oav1LUiGaT6o6FmkBCX4KFw3rDJmEpA86cT4gVcJohVSrB3VFJ4z+Ln36JAAkgvHt6ZL
         wmF+AB+EVVox2YeEPbW31bmO083MTuhnOAvfU0Cg3BbtboXrLPuLeSB5DzKEOraRvISq
         zjCOyfAv4azYmOgPL5YYznDLO4iaimvMuDeFGC99/8XMdYn/bTLjvitMDGsqQVfczH2g
         VwruZFciXjq6+qq3nzBKLyPHwzWIb4UQtMfmVthKYS9o3GLiudVi4zpNM1FPThqpL1uM
         QcVA==
X-Gm-Message-State: ACgBeo3zxJR2jTjtS1G3PwUHJjFaS7xYAFeYpr1+C4Pq7+visDL7EVwi
        AO4fUAE1BHyrfY1vW9bgHaA=
X-Google-Smtp-Source: AA6agR4ijIQeZNxPRBLulms8XntO5lTf9WdjS7PGHtnPolPLLEQmQn43MWYAWTTRN8V7PHsyz7e2Jw==
X-Received: by 2002:adf:d1e4:0:b0:221:6c37:277e with SMTP id g4-20020adfd1e4000000b002216c37277emr380673wrd.498.1661534273185;
        Fri, 26 Aug 2022 10:17:53 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id i12-20020a1c540c000000b003a2f2bb72d5sm186388wmb.45.2022.08.26.10.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:17:52 -0700 (PDT)
Message-ID: <67989b1b-712a-6110-b0a4-7d855179e17c@gmail.com>
Date:   Fri, 26 Aug 2022 19:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next v3] bpf: Fix a few typos in BPF helpers
 documentation
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
        bpf@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linux-man@vger.kernel.org
References: <20220825220806.107143-1-quentin@isovalent.com>
 <ebbae976-b452-c359-fd67-5b0511c3ef10@gmail.com>
 <c94959da-67f6-da66-1d46-ae9dfdc0e674@isovalent.com>
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <c94959da-67f6-da66-1d46-ae9dfdc0e674@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mZNAThT0tH0c4ZVKlFpEt0u2"
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
--------------mZNAThT0tH0c4ZVKlFpEt0u2
Content-Type: multipart/mixed; boundary="------------Td10TF0aG2n0O4U37KtzdKkQ";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Quentin Monnet <quentin@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>,
 Jesper Dangaard Brouer <brouer@redhat.com>, linux-man@vger.kernel.org
Message-ID: <67989b1b-712a-6110-b0a4-7d855179e17c@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Fix a few typos in BPF helpers
 documentation
References: <20220825220806.107143-1-quentin@isovalent.com>
 <ebbae976-b452-c359-fd67-5b0511c3ef10@gmail.com>
 <c94959da-67f6-da66-1d46-ae9dfdc0e674@isovalent.com>
In-Reply-To: <c94959da-67f6-da66-1d46-ae9dfdc0e674@isovalent.com>

--------------Td10TF0aG2n0O4U37KtzdKkQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gOC8yNi8yMiAxMTo0NCwgUXVlbnRpbiBNb25uZXQgd3JvdGU6
DQo+IE9uIDI1LzA4LzIwMjIgMjM6MTIsIEFsZWphbmRybyBDb2xvbWFyIHdyb3RlOg0KPj4g
SGkgUXVlbnRpbiwNCj4+DQo+IA0KPj4+IC0gKsKgwqDCoMKgwqDCoMKgIGN0eC4gUHJvdmlk
aW5nIGFuICpsZW5fZGlmZiogYWRqdXN0bWVudCB0aGF0IGlzIGxhcmdlciB0aGFuDQo+Pj4g
dGhlDQo+Pg0KPj4gSSBqdXN0IG5vdGljZWQ6wqAgZ3JvZmYoMSkgdXNlcyBkb3VibGUgc3Bh
Y2VzIGFmdGVyIGFuIGVuZC1vZi1zZW50ZW5jZQ0KPj4gcGVyaW9kLsKgIE90aGVyd2lzZSwg
aXQgaXMgdW5kZXJzdG9vZCBhcyBzb21ldGhpbmcgbGlrZSBpbml0aWFscywgb3IgYW4NCj4+
IGFiYnJldmlhdHVyZSwgYW5kIGl0IGNhdXNlcyBzb21lIGlzc3Vlcy7CoCBQbGVhc2UgY2hl
Y2sgdGhlIHdob2xlDQo+PiBkb2N1bWVudCwgYXMgSSd2ZSBzZWVuIGEgbWl4IG9mIHN0eWxl
cy4NCj4+DQo+PiBTZWFyY2ggZm9yIHNvbWV0aGluZyBsaWtlICcuXC4gW14gXScNCj4gDQo+
IFRoaXMgaXMgYSBzdHJhbmdlIHJlc3RyaWN0aW9uIGluIG15IG9waW5pb24sIGJ1dCBJIGNh
biBsb29rIGludG8gdGhpcyBhcw0KPiBhIGZvbGxvdy11cC4gSSd2ZSBub3Qgbm90aWNlZCBp
c3N1ZXMgd2l0aCB0aGUgcmVuZGVyZWQgcGFnZSBzbyBmYXIsIG91dA0KPiBvZiBjdXJpb3Np
dHkgd2hhdCBpc3N1ZXMgYXJlIHdlIHRhbGtpbmcgYWJvdXQ/DQoNCkl0J3Mgbm90IHNvIHZp
c2libGUsIGFuZCBJJ20gbm90IGEgZ3JvZmYoMSkgZXhwZXJ0LCBzbyBtYXliZSB0aGVyZSBh
cmUgDQptb3JlIGlzc3VlcyB0aGFuIHRoZSBvbmVzIEkga25vdywgYnV0IEknbGwgZXhwbGFp
biBpdCBhcyBJIHVuZGVyc3RhbmQgaXQ6DQoNCkZvciBncm9mZidzIG91dHB1dCwgdGhlcmUg
YXJlIHR3byBraW5kcyBvZiBzcGFjZXM6IGludGVyd29yZCBhbmQgDQppbnRlcnNlbnRlbmNl
IHNwYWNlcy4gIEludGVyd29yZCBzcGFjZSBpcyBub3JtYWxseSBhIHNpbmdsZSBjaGFyYWN0
ZXIgaW4gDQptb25vc3BhY2VkIGZvbnRzLiAgSW50ZXJzZW50ZW5jZSBpcyBhbHNvIGEgc2lu
Z2xlIHNwYWNlIGJ5IGRlZmF1bHQgaW4gDQptb25vc3BhY2UgZm9udHMsIGJ1dCBpdCBpcyBu
b3Qgc3Vic3RpdHV0aW5nIGludGVyd29yZCBzcGFjZSwgYnV0IHJhdGhlciANCmFkZGluZyB0
byBpdCwgc28gZWZmZWN0aXZlbHkgdGhlIGludGVyc2VudGVuY2Ugc2VwYXJhdGlvbiBpcyB0
d28gc3BhY2VzIA0KaW4gYSBtb25vc3BhY2VkIGZvbnQuICBUaGF0IGNhbiBiZSBjb25maWd1
cmVkLCBhbmQgb25lIGNhbiBmb3IgZXhhbXBsZSANCmFzayB0aGVpciBpbnRlcnNlbnRlbmNl
IHNwYWNlIHRvIGJlIDIgY2hhcnMsIGFuZCB0aGVyZWZvcmUgaGF2ZSBhbiANCmludGVyc2Vu
dGVuY2UgZWZmZWN0aXZlIHNlcHBhcmF0aW9uIG9mIDMgY2hhcnMuDQoNCkluIFBERiBvdXRw
dXQsIHRoZSBkaWZmZXJlbmNlIG1heSBiZSBhbHNvIG5vdGljZWFibGUgc2xpZ2h0bHkgZGlm
ZmVyZW50bHkuDQoNCkkgcHJlcGFyZWQgYSBzaW1wbGUgZmlsZSB0aGF0IHdpbGwgc2hvdyB5
b3UgaG93IGl0IGNhbiBtYWtlIHNlbnRlbmNlcyANCm11Y2ggbW9yZSByZWFkYWJsZSwgZXZl
biBpZiB0aGUgdGhlb3JldGljYWwgZGlmZmVyZW5jZSBtaWdodCBub3QgYmUgDQpub3RpY2Vh
YmxlIGF0IGZpcnN0IGdsYW5jZSB0byB0aGUgdW50cmFpbmVkIGV5ZToNCg0KJCBjYXQgc3Au
bWFuDQouVEggc3BhY2VzIDcgdG9kYXkgZXhwZXJpbWVudHMNCi5TSCBjb3JyZWN0IHNwYWNp
bmcNCkhlbGxvIHdvcmxkISAgVG9kYXkgaXMgRnJpZGF5LiAgVGhpcyBhcmUgZXh0cmEgd29y
ZHMgdG8gZmlsbC4NCkFuZCBldmVuIG1vcmUgd29yZHMuDQouU0ggaW5jb3JyZWN0IHNwYWNp
bmcNCkhlbGxvIHdvcmxkISBUb2RheSBpcyBNb25kYXkuIFRoaXMgYXJlIGV4dHJhIHdvcmRz
IHRvIGZpbGwuIEFuZCBldmVuIA0KbW9yZSB3b3Jkcy4NCiQgbWFuIC1QIGNhdCAuL3NwLm1h
bg0Kc3BhY2VzKDcpICAgICAgICAgIE1pc2NlbGxhbmVvdXMgSW5mb3JtYXRpb24gTWFudWFs
ICAgICAgICAgIHNwYWNlcyg3KQ0KDQpjb3JyZWN0IHNwYWNpbmcNCiAgICAgICAgSGVsbG8g
IHdvcmxkISAgIFRvZGF5IGlzIEZyaWRheS4gIFRoaXMgYXJlIGV4dHJhIHdvcmRzIHRvIGZp
bGwuDQogICAgICAgIEFuZCBldmVuIG1vcmUgd29yZHMuDQoNCmluY29ycmVjdCBzcGFjaW5n
DQogICAgICAgIEhlbGxvIHdvcmxkISBUb2RheSBpcyBNb25kYXkuIFRoaXMgYXJlIGV4dHJh
IHdvcmRzIHRvIGZpbGwuIEFuZA0KICAgICAgICBldmVuIG1vcmUgd29yZHMuDQoNCmV4cGVy
aW1lbnRzICAgICAgICAgICAgICAgICAgICAgIHRvZGF5ICAgICAgICAgICAgICAgICAgICAg
ICBzcGFjZXMoNykNCg0KDQoNCk5vdGljZSBob3cgdGhlIGZpcnN0IG9uZSBpcyBtdWNoIG1v
cmUgbmljZWx5IHJlbmRlcmVkLiAgSSByZW5kZXJlZCBpdCBpbiANCmEgNzItY29sIHRlcm1p
bmFsIGJlY2F1c2UgbXkgbWFpbGVyIHdvdWxkIHdyYXAgYXQgdGhhdCBib3VuZGFyeSBhbnl3
YXkuIA0KWW91IGNhbiByZW5kZXIgdGhlIGZpbGUgYXQgODAgY29sdW1ucyBhbmQgc2VlIGEg
ZGlmZmVyZW50IHJlbmRlcmluZywgDQp3aGVyZSBpdCBpcyBldmVuIGJpZ2dlciB0aGUgZGlm
ZmVyZW5jZSBpbiBmYXZvciBvZiB0aGUgY29ycmVjdGx5IHdyaXR0ZW4gDQpvbmUuDQoNCg0K
PiANCj4gQWxzbyBiZWZvcmUgdGhhdCwgaXQgd291bGQgYmUgZ29vZCB0byBzeW5jIGFuZCBz
ZWUgd2hhdCBvdGhlciBmb3JtYXR0aW5nDQo+IGVsZW1lbnRzIG5lZWQgYmUgYWRkcmVzc2Vk
IG9uIHRoZSBwYWdlLCBzbyB3ZSBjYW4gZml4IHRoZW0gaW4gYSBiYXRjaA0KPiByYXRoZXIg
dGhhbiBzdWJtaXR0aW5nIHRoZW0gb25lIGFmdGVyIHRoZSBvdGhlciBsaWtlIHdlJ3JlIGRv
aW5nLg0KDQpTdXJlISAgSXQnbGwgdGFrZSBzb21lIHRpbWUgZnJvbSBteSBzaWRlLCBidXQg
SSdsbCB0cnkgdG8gY29tZSB1cCB3aXRoIGEgDQpsaXN0IG9mIGlzc3VlcyBpbiB0aGF0IHBh
Z2UuDQoNCj4gDQo+IFF1ZW50aW4NCg0KDQpDaGVlcnMsDQoNCkFsZXgNCg0KLS0gDQpBbGVq
YW5kcm8gQ29sb21hcg0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------Td10TF0aG2n0O4U37KtzdKkQ--

--------------mZNAThT0tH0c4ZVKlFpEt0u2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMJADQACgkQnowa+77/
2zKSiw//aY8Msc7kKVb/vJsBUiTXtrJUGwWgGdD/YZFjiHimdpL412R7teJrR5ba
1fqpAGIGzUNDxwjqBTDXdLLJ+4P2/WmtVSbyv3un0EhiQ89URoahngV6X89qALP6
m16ebWfxDVJtmUJjQlUmEGf8k1b8AZaTv2qHzw1m5w1XkdxsFCC7UyG5vUQ9M6Qq
sSfSUSF7a8XpLHbFF1n2n83/4zl3QBYRUpugQpM56mpBLTD7vmqKK/aDPdMweTiL
otAbwTvLLBf1SSBSP3p/8v9jkzDVXX8pll2lU4vgqGHEeLMsGf77qbcC8hYIeUvj
u9FBK4iGbULYSr+MQscbTYr3cScZAfmLkXFLkZkgTsjH/pm4oZ1jONzZ6EGdqwJl
Tfb9Rtkv8BODBSHgs4jN/JRhTD5psxIae1hZHTaZvNFjnPibDl5XzXRTX3IZ//t8
Wa1qeWbEy+IjR5grj/DsBiBPZDjWRX0z79ZebbhknXsIJ/wfAyHPUPQSvqcvg1sA
yixZdsr9SqV7CmNy83JD1DbbtZFvz6oh/TbJtiIbdAyZT31wtT6qSrN4aeFdLA+e
kEbgAcD964G86MS5gznFUhDV0f0Ry8Dg/a7yuJB00UnbfrTpu+zAKM8v3GGQZTLh
89J4ZhW/aTOjs6Up8cohslkERd0/nVJRa9fPiHM3ECQiaUrOi20=
=qQQu
-----END PGP SIGNATURE-----

--------------mZNAThT0tH0c4ZVKlFpEt0u2--
