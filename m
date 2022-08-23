Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7F59E97D
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiHWR2c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiHWR0f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 13:26:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC175489
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:04:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s23so7352418wmj.4
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=vLKFOXZv2E7FK8SerR/2BCCJYlDk0bIfyPyW6QgkNdw=;
        b=GxPQSD1TcOdNXiJGuTJ21fmobvMQPj90+hSnPCCth9dPuJ3t1/2/OKSY0sNzI8/hNV
         64Bv9JEDEjQI+VLy47h2qNQxPvVwKdUo560I4LNM2R+CZGZ/s33SWLelO/7vdY6p0J/n
         9TpAFlLtvp17v6uEeXVJpcWtcfeTg6IMAXjH67TsOSYpMhdoTouMdpPOOFfsT+twF6wn
         MHDVsM0rX7QxESxYftS89bacthzjm6lAjBed07fRNZ0N8vefDKiPVP8ZhNFxko0J8w76
         CE9csrfBNb5xXm/JKnHO7NRsxd73xCo/XXA3U9DLop7vQFRT8kssYsC4oiW5w7AjrHI7
         4IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=vLKFOXZv2E7FK8SerR/2BCCJYlDk0bIfyPyW6QgkNdw=;
        b=vx588QVu7/USV22VvgTP4YgbJzHcuE7HmMH3Ye+GFDqiv9h2yhKeEE7gNy7yK8HGLp
         VyL/u7hVqXVuZqf2nvZTnXqDEGr0arYFG0AKnvpTs8rPXi889szrr0SDgaVRjsp3Ffse
         KNTTX3y/RHXcN1ildXJqRafCWpppH5pKhOZ4sG4GxNAZUS5saqkJKxaqtnjgp/51Sk17
         R4CLoRd6hBZC6zZEtnKpRoK40Sdw0WW7RHGF3AL+MlEeW/vaG9xA0XNq+FtawnmUrZYa
         Is38dfuowRo/5JU1kC1RTOMSN+hwjRpjJ2zStHJQCtKQ3gX5c6ter/5oB+rs+Aq+Ux9U
         1RWQ==
X-Gm-Message-State: ACgBeo3nfmioHADgv9iz8powxLKaZWgUi2g6HWBjupGHzv19SqiPcIZz
        gxx9AsH2HYdfI5hVA7KNC80=
X-Google-Smtp-Source: AA6agR4i//uVHEkLeYvOfv8iRSwOpmHolzUHtSYcf/V8SLE8d7hUzTVvBI7sE4JFFZZJmRqQWju6Jw==
X-Received: by 2002:a05:600c:89a:b0:3a5:4ea9:d5ee with SMTP id l26-20020a05600c089a00b003a54ea9d5eemr2535693wmp.8.1661267093171;
        Tue, 23 Aug 2022 08:04:53 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a4efb794d7sm19526264wmq.36.2022.08.23.08.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 08:04:52 -0700 (PDT)
Message-ID: <8af3984e-49f4-e94f-df87-6609a5330b9f@gmail.com>
Date:   Tue, 23 Aug 2022 17:04:43 +0200
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
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <1c07206a-25c5-9621-afd5-d64913fece13@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------z4UNuUOQEeNADr0iY80G6m8m"
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
--------------z4UNuUOQEeNADr0iY80G6m8m
Content-Type: multipart/mixed; boundary="------------KNfzzlEu54wVsgN3howAygPe";
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
Message-ID: <8af3984e-49f4-e94f-df87-6609a5330b9f@gmail.com>
Subject: Re: [PATCH bpf-next] scripts/bpf: Fix attributes for bpf-helpers(7)
 man page
References: <20220823084719.13613-1-quentin@isovalent.com>
 <a9533d19-8266-8eed-63ec-82aa07ce83d0@gmail.com>
 <1c07206a-25c5-9621-afd5-d64913fece13@isovalent.com>
In-Reply-To: <1c07206a-25c5-9621-afd5-d64913fece13@isovalent.com>

--------------KNfzzlEu54wVsgN3howAygPe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gOC8yMy8yMiAxNjoyMywgUXVlbnRpbiBNb25uZXQgd3JvdGU6
DQo+IFdvdywgSSdtIHR3byBkYXlzIGxhdGUhDQoNCjstKQ0KDQpbLi4uXQ0KPj4NCj4+IFlv
dSBjb3VsZCBhcHBlbmQgdGhlIHZlcnNpb24gaGVyZS7CoCBPciBtYXliZSBwdXQgYSBwbGFj
ZWhvbGRlciB0aGF0IHRoZQ0KPj4gc2NyaXB0IHNob3VsZCBmaWxsIHdpdGggaW5mb3JtYXRp
b24gZnJvbSB0aGUgbWFrZWZpbGUgb3IgZ2l0LWRlc2NyaWJlKDEpPw0KPiANCj4gU28gaWYg
SSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgcnVubmluZyBicGZfZG9jLnB5IHNob3VsZCBjdXJy
ZW50bHkNCj4gcHJvZHVjZSB0aGUgZm9sbG93aW5nIHN0cmluZzoNCj4gDQo+ICAgICAgLlRI
IEJQRi1IRUxQRVJTIDcgIiIgIkxpbnV4ICg1LjE5LjApIiAiIg0KPiANCj4gSXMgdGhpcyB3
aGF0IHlvdSBleHBlY3Q/DQoNCkFsbW9zdC4gIEkgZXhwZWN0Og0KDQouVEggQlBGLUhFTFBF
UlMgNyAiIiAiTGludXggNS4xOS4wIg0KDQpOb3RpY2UgdGhlIGRpZmZlcmVuY2VzOg0KLSBO
byA1dGggZW1wdHkgZmllbGQgIiIuDQotIE5vIHBhcmVudGhlc2VzIGluIHRoZSB2ZXJzaW9u
IHN0cmluZy4NCg0KQnV0IHNpbmNlIHlvdSdyZSBub3QgaW4gY29udHJvbCBvZiB0aGUgbGFz
dCBmaWVsZCwgYW5kIGl0J3MganVzdCBhIGJ1ZyANCmluIHJzdDJtYW4sIGFuIGVtcHR5IDV0
aCBhcmcgYXMgeW91IHN1Z2dlc3RlZCBpcyB0aGUgYmVzdCB5b3UgY2FuIA0KcHJvdmlkZS4g
IEknbGwgZmlsZSB0aGUgYnVnLg0KDQpBcyBmb3IgdGhlIHBhcmVudGhlc2VzIGluIHRoZSB2
ZXJzaW9uLCBJIHdvdWxkbid0IHB1dCB0aGVtOyBJIG9ubHkgcHV0IA0KdGhlbSBpbiB0aGUg
bWFuLXBhZ2VzIHVucmVsZWFzZWQgc3RyaW5nLCB0byBtYWtlIGl0IGNsZWFyIHRoYXQgaXQn
cyBhIA0KdmVyc2lvbiwgYnV0IGluIHRoZSBmaW5hbCB2ZXJzaW9uIEkgcmVtb3ZlIHRoZW0u
DQoNClNlZToNCg0KPGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9kb2NzL21hbi1w
YWdlcy9tYW4tcGFnZXMuZ2l0L3RyZWUvbGliL3ZlcnNpb24ubWs+DQphbmQNCjxodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZG9jcy9tYW4tcGFnZXMvbWFuLXBhZ2VzLmdpdC90
cmVlL2xpYi9kaXN0Lm1rI24zMz4NCg0KPiANCj4gSSBjYW4gbWFrZSB0aGUgc2NyaXB0IGNh
bGwgIm1ha2Uga2VybmVsdmVyc2lvbiIgdG8gcHJvZHVjZSB0aGUgYWJvdmUuDQo+IEknbSBu
b3QgMTAwJSBjb252aW5jZWQgaXQgc2hvdWxkIGJlIHRoZSByb2xlIG9mIHRoYXQgc2NyaXB0
IHZzLiB3aGVuDQo+IGNvcHlpbmcgaXQgKHdlIHJpc2sgaGF2aW5nIHNvbWUgaW5hY2N1cmFj
aWVzLCBmb3IgZXhhbXBsZSBJIGdlbmVyYXRlZA0KPiB0aGUgYWJvdmUgZnJvbSB0aGUgYnBm
LW5leHQsIHNvIGl0IGRvZXNuJ3QgcmVhbGx5IGNvcnJlc3BvbmQgdG8gNS4xOSksDQo+IGJ1
dCBtYXliZSBpdCdzIGVhc2llciB0aGF0IHdheSBhbmQgYXZvaWRzIGFkZGluZyBhbm90aGVy
IHNjcmlwdCBpbiB0aGUNCj4gbWlkZGxlIG9mIHRoZSBnZW5lcmF0aW9uIHNvIE9LLg0KDQpJ
IGxpa2UgaXQgdGhhdCB3YXkuICBNb3Jlb3ZlciwgSSdsbCBhbHdheXMgcnVuIHRoaXMgc2Ny
aXB0IGZyb20gYSANCnJlbGVhc2UgdGFnIGZyb20gTGludXMnIHJlcG8sIHNvIHRoZSB2ZXJz
aW9uIHNob3VsZCBtYXRjaCBleGFjdGx5IHRoZSBjb2RlLg0KDQpBbnl3YXksIGFuZCBJIHRo
aW5rIHRoaXMgYWZmZWN0cyBtYW55IHByb2plY3RzIG91dCB0aGVyZSBoYXZlIHRoZSBzYW1l
IA0KaXNzdWU6DQoNClRoZSB2ZXJzaW9uaW5nIHNob3VsZCBhbHdheXMgYmUgY29ycmVjdC4g
IGdpdC1kZXNjcmliZSgxKSBzaG91bGQgYmUgDQpwcmVmZXJyZWQsIG9yIGluIGFic2VuY2Ug
b2YgdGhhdCwgYSBnZW5lcmljICh1bnJlbGVhc2VkKSBzdHJpbmcgc2hvdWxkIA0KYmUgdXNl
ZC4gIERlc2NyaWJpbmcgYW55IGNvbW1pdCBhZnRlciB2NS4xOCBhbmQgYmVmb3JlIHY1LjE5
LXJjMSB0byBiZSANCic1LjE4LjAnIGlzIHBsYWluIHdyb25nL21pc2xlYWRpbmcuICBUaGUg
TWFrZWZpbGUgc2hvdWxkIHByb2JhYmx5IA0KYXV0b2dlbmVyYXRlIHRoYXQgaW5mbyBmcm9t
IGdpdC1kZXNjcmliZSgxKS4gIFNlZSBob3cgdGhlIExpbnV4IA0KbWFuLXBhZ2VzIGRvIGl0
IChpbiB0aGUgbGlua3MgYWJvdmUgeW91IGNhbiBzZWUgaXQpIGZvciBleGFtcGxlLg0KDQpD
aGVlcnMsDQoNCkFsZXgNCg0KDQotLSANCkFsZWphbmRybyBDb2xvbWFyDQo8aHR0cDovL3d3
dy5hbGVqYW5kcm8tY29sb21hci5lcy8+DQo=

--------------KNfzzlEu54wVsgN3howAygPe--

--------------z4UNuUOQEeNADr0iY80G6m8m
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmME7IsACgkQnowa+77/
2zJDKg/+OvoNFHl9GlG8us30M45k1g1NASjPehjY7fpw9Y/wMtW7QBizmn+EZuUf
KZDYtGwNC623nq7g3yNxMt62qRuJK90VoFl6tnpnkNHrIdk4Jr5u/Y+bjmr2yqPo
3N/mU9S4amWP/xSqCCf5qY1IMGkD+MujNu5DhD5RP9eLd5dChyOBspidfudrm04s
Qt2CLrfZHGLB2OElMFTzQSuFUU/+HMyCgr7i44SRfCeehNcKkh+uUVADso/yWsvC
a6Z9lx6gJ85Oe85BGuRIhxoe6KALdWCHh9OvBKztLhvnG1OMn+wtoqucaa6sHSD7
8UgQp+ctS3X+7GyGA68H97wRQlKpIQpdLY5t9TklgWfhS8OgUrdWJa4gCIboCvKz
MVOhhmBpXB71L0tJSODfJjNjjA1FMBJeK63Dmsi9sSWQwa2vAlIxlQS1iFW2e29j
nvr5HZ2jKOyvENetbz+GA6u9rc5rz/0E9JEGEpUm7fL40JSrrg7kP26SIOdQu3Ug
2EVNmO/ba3kbW5XEYeFdzmh39fzQDcwuX6hUOT8A98r+aOQUOlYkJFT+tTkaOybD
nPQrHe/8uo5XeXYtffsx01hdLYPkkALNIMk5Nf4NrlSDStLgjQ0OmGJfP4zKEEPu
Y3Hp37KbryhwlK7vs36r2Jyv+xXKPW/PEx3OSFT7sjVF8dEHvPM=
=Be7X
-----END PGP SIGNATURE-----

--------------z4UNuUOQEeNADr0iY80G6m8m--
