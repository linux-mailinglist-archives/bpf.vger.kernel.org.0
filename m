Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B45A1BAA
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 23:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiHYVwG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiHYVvq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 17:51:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58421263D;
        Thu, 25 Aug 2022 14:51:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so3421560wmk.3;
        Thu, 25 Aug 2022 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=acSPEObLKZ1Ys2KtIxKytw09/sTFD8kD+7jBoojwB0M=;
        b=Y7InKfiw7z+81iXZD9FAxIJ5Og3/Q/IeGrj6VuhrJW2yzfDmfp230LIKtxANlEtt5z
         vk+TLCO8s+hd4CJDIkzgq+Yu28DZJAuBUrB7+2BjKCa+CJCjr4sP8tWDFBs2MhVoLMCb
         NeVd7WvNk79DevsXhsJF/wu+LgVsqTF3qRoysuuzJNh3W1MGx9nOFoIWIL/QKBB+ronY
         iualu0QpwhqcAKKn4+VPhuEsYUIW5GP2YAXy6NxTAJR//3xG0+TD2nbobxfzyIyM+NZ5
         xXn9WhSJUWe4Pn+kio6524mGdWGaH8mBeQ6rhyzj4XFod0TwyofL+1bxFBMKsI4fssTW
         Zj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=acSPEObLKZ1Ys2KtIxKytw09/sTFD8kD+7jBoojwB0M=;
        b=f30Zq5ZCLDNKnGwKHp1zU/P9f+QjaL+bOkz6WSeODYP+WIlDBRI/fnwb7VlkqxGdDP
         uouNL6R+PtgwSZA49Uuedh+R+Vu56JhqR1scA6omHECXCEsPLEiqklyQoGoN6xAaj6Xg
         S20JonXk1cI1jF/8PpjUdS00dnayomRiar8he+36uf8VNi4g4xnH1N6ozoQfQlZdtrvU
         9VSMM/rzCJupqII+5frXVeakA+kOV5l4GsiuWXuq1o6H/kUR7WLY4qwu/rd4g5nsVhH2
         6Rj+IbSybPbrzwWN9Gv3CP404dIpCLfDtSrtX7goS4b3AFxV9wlYECV7HjITfbXkXWBI
         SkSQ==
X-Gm-Message-State: ACgBeo113g+eXV9tfC7qYkrrwRttG08qJ6487sm85/P1bekljWdCpaec
        5Z9N5pEoTigoCerwUSFpTWE=
X-Google-Smtp-Source: AA6agR5N++smfVy8Nare136pCS6PxH6SxYoCokTah00B+6Q3NheeOuBrX5db9kfLtI+91xd0mqmnWQ==
X-Received: by 2002:a1c:7408:0:b0:3a5:c9c1:f226 with SMTP id p8-20020a1c7408000000b003a5c9c1f226mr3391433wmc.47.1661464303469;
        Thu, 25 Aug 2022 14:51:43 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id v64-20020a1cac43000000b003a5fcae64d4sm444912wme.29.2022.08.25.14.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:51:42 -0700 (PDT)
Message-ID: <403a8238-12e7-1092-a28b-a52f5d63df2c@gmail.com>
Date:   Thu, 25 Aug 2022 23:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] Fit line in 80 columns
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
 <CAEf4BzbCgHp0MtsSm_ExPO+EGhFWzLUOiFuh1jyrhWfbsDtL3A@mail.gmail.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <CAEf4BzbCgHp0MtsSm_ExPO+EGhFWzLUOiFuh1jyrhWfbsDtL3A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pGqPuejzvyayAlYdX5N3H0GW"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pGqPuejzvyayAlYdX5N3H0GW
Content-Type: multipart/mixed; boundary="------------wA8XioeQX7fQWtEh4AZDC58a";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>,
 linux-man <linux-man@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <403a8238-12e7-1092-a28b-a52f5d63df2c@gmail.com>
Subject: Re: [PATCH] Fit line in 80 columns
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
 <CAEf4BzbCgHp0MtsSm_ExPO+EGhFWzLUOiFuh1jyrhWfbsDtL3A@mail.gmail.com>
In-Reply-To: <CAEf4BzbCgHp0MtsSm_ExPO+EGhFWzLUOiFuh1jyrhWfbsDtL3A@mail.gmail.com>

--------------wA8XioeQX7fQWtEh4AZDC58a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW5kcmlpIGFuZCBBbGV4ZWksDQoNCk9uIDgvMjUvMjIgMjM6MzYsIEFuZHJpaSBOYWty
eWlrbyB3cm90ZToNCj4gT24gVGh1LCBBdWcgMjUsIDIwMjIgYXQgMTE6MDcgQU0gQWxleGVp
IFN0YXJvdm9pdG92DQo+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToN
Cj4+DQo+PiBPbiBUaHUsIEF1ZyAyNSwgMjAyMiBhdCAxMTowMiBBTSBBbGVqYW5kcm8gQ29s
b21hcg0KPj4gPGFseC5tYW5wYWdlc0BnbWFpbC5jb20+IHdyb3RlOg0KPj4+DQo+Pj4gVGhh
dCBsaW5lIGlzIHVzZWQgdG8gZ2VuZXJhdGUgdGhlIGJwZi1oZWxwZXJzKDcpIG1hbnVhbCBw
YWdlLiAgSXQNCj4+PiBpcyBhIG5vLWZpbGwgbGluZSwgc2luY2UgaXQgcmVwcmVzZW50cyBh
IGNvbW1hbmQsIHdoaWNoIG1lYW5zIHRoYXQNCj4+PiB0aGUgZm9ybWF0dGVyIGNhbid0IGJy
ZWFrIHRoZSBsaW5lLCBhbmQgaW5zdGVhZCBqdXN0IHJ1bnMgYWNyb3NzDQo+Pj4gdGhlIHJp
Z2h0IG1hcmdpbiAoaW4gbW9zdCBzZXQtdXBzIHRoaXMgbWVhbnMgdGhhdCB0aGUgcGFnZXIg
d2lsbA0KPj4+IGJyZWFrIHRoZSBsaW5lKS4NCj4+Pg0KPj4+IFVzaW5nIDxmbXQ+IG1ha2Vz
IGl0IGVuZCBleGFjdGx5IGF0IHRoZSA4MC1jb2wgcmlnaHQgbWFyZ2luLCBib3RoDQo+Pj4g
aW4gdGhlIGhlYWRlciBmaWxlLCBhbmQgYWxzbyBpbiB0aGUgbWFudWFsIHBhZ2UsIGFuZCBh
bHNvIHNlZW1zIHRvDQo+Pj4gYmUgYSBzZW5zaWJsZSBuYW1lLg0KPj4NCj4+IE5hY2suDQo+
Pg0KPj4gV2UgZG9uJ3QgZm9sbG93IDgwIGNoYXIgbGltaXQgYW5kIGFyZSBub3QgZ29pbmcg
dG8gYmVjYXVzZSBvZiBtYW4gcGFnZXMuDQo+IA0KPiBBbmQgaXQncyBxdWVzdGlvbmFibGUg
aW4gZ2VuZXJhbCB0byBlbmZvcmNlIGxpbmUgbGVuZ3RoIGZvciB2ZXJiYXRpbQ0KPiAoY29k
ZSkgYmxvY2suIEl0J3MgdmVyYmF0aW0gZm9yIGEgZ29vZCByZWFzb24sIGl0IGNhbid0IGJl
IHdyYXBwZWQuDQoNClRoYXQncyB3aHkgaW5zdGVhZCBvZiB3cmFwcGluZywgSSByZWR1Y2Vk
IHRoZSBsZW5ndGggb2Ygc29tZSANCiJpZGVudGlmaWVyIi4gIEl0J3Mgbm90IGVuZm9yY2Vk
LCBidXQgaXQncyBuaWNlciBpZiBpdCBmaXRzLiAgVGhlcmUgYXJlIA0Kc2V2ZXJhbCBvdGhl
ciBjYXNlcywgd2hlcmUgaXQgd2Fzbid0IGVhc3kgdG8gbWFrZSBpdCBzaG9ydGVyLCBhbmQg
SSBsZWZ0IA0KaXQgZXhjZWVkaW5nIHRoZSBtYXJnaW4uDQoNCkl0J3Mgbm90IHNvIGNydWNp
YWwgdG8gZml4IGl0LCBhbmQgaWYgeW91IHByZWZlciBpdCBsaWtlIGl0IGlzIA0KY3VycmVu
dGx5LCBpdCdzIHJlYXNvbmFibGUuICBUaGlzIGlzIGEgc3VnZ2VzdGlvbiwgdG8gbWFrZSBp
dCBlYXNpZXIgdG8gDQpyZWFkLg0KDQpDaGVlcnMsDQoNCkFsZXgNCg0KLS0gDQpBbGVqYW5k
cm8gQ29sb21hcg0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------wA8XioeQX7fQWtEh4AZDC58a--

--------------pGqPuejzvyayAlYdX5N3H0GW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMH7t4ACgkQnowa+77/
2zIp5Q//Yz5Avt9fe3ivLqmWvjxrcHfXd37Pl1e2L5EJW9OAhvbX7mNaf2ndtXAv
P1VCCq8+CX85AO+3FcCE1L/n3JqeYZAY2H7vct5D6A1UvMpBY6qy7042W31HuMPr
ZO2duNaWJrpNVyQ9il40l2QNBMaF5b/DvmQIlu3F2XqahJLkPwBRQAwm5nnZYyR3
8YfJUH+sYf/4YyVkv8/0eawDnYBgE22geLN+TUaDKJNwRdhDPVldi/jYGegoa1aP
HlH8rucpgALHITwvgIVqfWYTk1MAik9Mfo4YT+mgzaq28wnz7O2XQZAbjH2YBgHQ
E5rHRXmtLLSHM5jpe6b5PLVKzysanGQvgvQQvMqt2wVZQ+gAq65858FKxR7kczZ/
U19Bc6ARX7yUJGnGcEDoxAdy7GsxrYC5n4/lIzcs3qMRRVlc39ONr63Myey+s2l6
RNwcvCHhx6DAGEK15O8jEiIOlKnBO4LyAZWukrzXjsiPINIJG4/nrPyb0AbH95K0
w8tWxwYzEJlW9rlpkkUIEWv4Vks4yILQ3hT3WR6JPTOGCaPzQzxVVCGlEHMHffYf
VwXGVpJCMohef5tGdKXSZVvrBy1Sy9q6Wzoo9ckjIPpNQr1/a/nb7kd2YNExUjf7
2FAgRWVSmt7gsuq6igItb49VdN8p6BDvx6I4QHVYlGC2Ir2JoI8=
=CPn5
-----END PGP SIGNATURE-----

--------------pGqPuejzvyayAlYdX5N3H0GW--
