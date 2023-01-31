Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6194682BDA
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 12:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjAaLvv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 06:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjAaLvu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 06:51:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E335B7;
        Tue, 31 Jan 2023 03:51:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o36so4108896wms.1;
        Tue, 31 Jan 2023 03:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWdh5UvZcVxtIm80ThYuPtHP7qhAnJ2H1eadj4u+UBg=;
        b=mvgitxAzqniNP038xVCRN/Au5CLzRudU3EqSsTUKPmF7i7Wx/Nt4zsQHfMdqmcmRjH
         ER3U7wLJhAjEgRk2FgQwi+KuxcmloTF4xEAMfIQMuIMgmCzu3TXMCPzk1Y4sr+IlBg6I
         1KwJw1mwY6Z4cd4wdQ11C7N3B9XhXSXzvI7eajEF6YQ2M20YMVk79UVBy9SHduXKmZ/G
         cvOWMbkfEmgC9RqZjMcQ/N4lBqjRsRpk6a31FlM0GmUlb5gksIRwqflj0doVWR4O2QHb
         KMUNc3OcXSkGTk1OO7NW/4refJ/dV/ZYw3nkixBqdumHE4vaorQHtRVwlIGAx0lA6Pd/
         919A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DWdh5UvZcVxtIm80ThYuPtHP7qhAnJ2H1eadj4u+UBg=;
        b=4XqK9K4Pqy6Tluc5md7nM5SaQG45br+Cs8TdTmczO+a4a8VKPuH/eV0VdwBJC81jdN
         pbHbdNDudUhkwH0cMC7t3wfKbVTA+MomsH2sOBTLHDNvfu77sKYP8HJsdQSyaahInr6S
         WzcUJT7TFx+ZojLUo1lY7nUDZH+GApC/W545V+70Vdd6L6xPmXER/zQiSoOFZBeVX6YD
         dTfxxj/Epp7mWa/QSzXFvTv1LMkoE9hF02EyJG6kGeHaCPKqLXiAAodtGqn3rCR7Aets
         xWDQGu1iJ6KYvlinLcCAoDPteqjnFjvgYkTKto8xCMUWS+KxuEm/H47aVHtTjeT6pZ1J
         9Z+g==
X-Gm-Message-State: AFqh2kosmnhGTEUjMuCEuY0pJBXgzAYTZV1oDfXPx8vFgS71YRLG9WzA
        +l7cx1EkCy6MMKJDiuWhqczR8OWHdww=
X-Google-Smtp-Source: AMrXdXtQzkp2MlmQ10xOgHzSX9Sd+kQczDOLQQhZw7zRKSC3QH1yS6TG+XKZP6cWkbRYIB1nuw98Yg==
X-Received: by 2002:a7b:c5d6:0:b0:3d9:fb89:4e3d with SMTP id n22-20020a7bc5d6000000b003d9fb894e3dmr55745004wmk.28.1675165907837;
        Tue, 31 Jan 2023 03:51:47 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id n17-20020a1c7211000000b003dc3f07c876sm13011354wmc.46.2023.01.31.03.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 03:51:47 -0800 (PST)
Message-ID: <e27489a9-6ae5-0f31-0289-fe6344c58bd3@gmail.com>
Date:   Tue, 31 Jan 2023 12:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Typo in the man7 bpf-helpers page
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     bpf <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>
Cc:     linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
        Zexuan Luo <spacewanderlzx@gmail.com>
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
 <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>
 <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
In-Reply-To: <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------freB6iPF8stZK51eVD1TFyPb"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------freB6iPF8stZK51eVD1TFyPb
Content-Type: multipart/mixed; boundary="------------mh0wOKIANCQKO10rSOFT0Qsb";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: bpf <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>
Cc: linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
 Zexuan Luo <spacewanderlzx@gmail.com>
Message-ID: <e27489a9-6ae5-0f31-0289-fe6344c58bd3@gmail.com>
Subject: Re: Typo in the man7 bpf-helpers page
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
 <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>
 <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
In-Reply-To: <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>

--------------mh0wOKIANCQKO10rSOFT0Qsb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gMS8zMS8yMyAxMjo0MCwgQWxlamFuZHJvIENvbG9tYXIgd3Jv
dGU6DQo+IFtSZXNlbmQgd2l0aCBRdWVudGluJ3MgcmlnaHQgYWRkcmVzcywgSSBob3BlXQ0K
PiANCj4gSGkgWmV4dWFuLCBRdWVudGluLA0KPiANCj4gT24gMS8zMS8yMyAxMTowMywgWmV4
dWFuIEx1byB3cm90ZToNCj4gID4gSGVsbG8gQ29sb21hciwNCj4gID4NCj4gID4gSSBqdXN0
IGZvdW5kIGEgcG90ZW50aWFsIGJ1ZyBpbiB0aGUgYnBmLWhlbHBlcnMgcGFnZS4NCj4gDQo+
IFRoYW5rcyBmb3IgcmVwb3J0aW5nIGJ1Z3MgOikNCj4gDQo+ICA+DQo+ICA+IFVuZGVyIHRo
ZSBodHRwczovL3d3dy5tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuNy9icGYtaGVscGVy
cy43Lmh0bWw6DQo+IA0KPiBUaGlzIHBhZ2UgaXMgZ2VuZXJhdGVkIGZyb20gdGhlIExpbnV4
IGtlcm5lbCBzb3VyY2VzLsKgIEkndmUgQ0NlZCBRdWVudGluIGFuZCB0aGUgDQo+IEJQRiBs
aXN0IHNvIHRoZXkgY2FuIGNoZWNrIGl0IHRoZXJlLg0KPiANCj4gQlRXLCBJJ20gcmVmcmVz
aGluZyB0aGUgcGFnZSBub3cuDQo+IA0KPiBRdWVudGluLCBJIHJlYWxpemVkIGluIHRoZSBk
aWZmIHRoYXQgdGhlcmUgaXMgc29tZSBpbmNvbnNpc3RlbmN5IGluIHRoZSBudW1iZXIgDQo+
IG9mIHNwYWNlcyBhZnRlciBhIHNlbnRlbmNlLWVuZGluZyBwZXJpb2QuwqAgQ291bGQgeW91
IHBsZWFzZSB1c2UgdHdvIHNwYWNlcyBmb3IgDQo+IHRoYXQ/wqAgSXQncyBlc3BlY2lhbGx5
IGltcG9ydGFudCBmb3IgZ3JvZmYoMSksIHdoaWNoIHdpbGwgcmVuZGVyIGl0IGRpZmZlcmVu
dGx5LiANCj4gIMKgIEhvd2V2ZXIsIGl0J3Mgbm90IGEgYmlnIGlzc3VlLCBzbyBkb24ndCBm
ZWVsIHVyZ2VkIHRvIGRvIHRoYXQuDQoNCkkgYWxzbyBmb3VuZCBzb21lIHRyYWlsaW5nIHdo
aXRlc3BhY2UuICBJJ20gbm90IHN1cmUgaWYgaXQncyBuZWNlc3NhcnkgZm9yIHJzdCwgDQpi
dXQgaW4gbWFuKDcpIGl0IGNhdXNlcyB0cmFpbGluZyB3aGl0ZXNwYWNlLiAgZ3JlcCBmb3Ig
J15cLlwuICQnICAoYW5kIG1heWJlIA0KdGhlcmUgYXJlIG90aGVycyB0aGF0IEkgZGlkbid0
IG5vdGljZS4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCj4gDQo+IENoZWVycywNCj4gDQo+IEFs
ZXgNCj4gDQo+ICA+DQo+ICA+IGBgYA0KPiAgPsKgwqDCoMKgwqDCoMKgwqAgdTY0IGJwZl9n
ZXRfc29ja2V0X2Nvb2tpZShzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiAgPg0KPiAgPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEZXNjcmlwdGlvbg0KPiAgPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElmIHRoZSBzdHJ1Y3Qgc2tfYnVm
ZiBwb2ludGVkIGJ5IHNrYiBoYXMgYSBrbm93bg0KPiAgPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNvY2tldCwgcmV0cmlldmUgdGhlIGNvb2tpZSAo
Z2VuZXJhdGVkIGJ5IHRoZQ0KPiAgPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGtlcm5lbCkgb2YgdGhpcyBzb2NrZXQuwqAgSWYgbm8gY29va2llIGhh
cyBiZWVuIHNldA0KPiAgPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHlldCwgZ2VuZXJhdGUgYSBuZXcgY29va2llLiBPbmNlIGdlbmVyYXRlZCwgdGhl
DQo+ICA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc29j
a2V0IGNvb2tpZSByZW1haW5zIHN0YWJsZSBmb3IgdGhlIGxpZmUgb2YgdGhlDQo+ICA+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc29ja2V0LiBUaGlz
IGhlbHBlciBjYW4gYmUgdXNlZnVsIGZvciBtb25pdG9yaW5nDQo+ICA+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGVyIHNvY2tldCBuZXR3b3JraW5n
IHRyYWZmaWMgc3RhdGlzdGljcyBhcyBpdA0KPiAgPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByb3ZpZGVzIGEgZ2xvYmFsIHNvY2tldCBpZGVudGlm
aWVyIHRoYXQgY2FuIGJlDQo+ICA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYXNzdW1lZCB1bmlxdWUuDQo+ICA+DQo+ICA+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFJldHVybiBBIDgtYnl0ZSBsb25nIG5vbi1kZWNyZWFzaW5nIG51
bWJlciBvbiBzdWNjZXNzLCBvcg0KPiAgPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDAgaWYgdGhlIHNvY2tldCBmaWVsZCBpcyBtaXNzaW5nIGluc2lk
ZSBza2IuDQo+ICA+DQo+ICA+wqDCoMKgwqDCoMKgwqDCoCB1NjQgYnBmX2dldF9zb2NrZXRf
Y29va2llKHN0cnVjdCBicGZfc29ja19hZGRyICpjdHgpDQo+ICA+DQo+ICA+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIERlc2NyaXB0aW9uDQo+ICA+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRXF1aXZhbGVudCB0byBicGZfZ2V0X3Nv
Y2tldF9jb29raWUoKSBoZWxwZXIgdGhhdA0KPiAgPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjY2VwdHMgc2tiLCBidXQgZ2V0cyBzb2NrZXQgZnJv
bSBzdHJ1Y3QNCj4gID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBicGZfc29ja19hZGRyIGNvbnRleHQuDQo+ICA+DQo+ICA+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFJldHVybiBBIDgtYnl0ZSBsb25nIG5vbi1kZWNyZWFzaW5nIG51
bWJlci4NCj4gID4NCj4gID7CoMKgwqDCoMKgwqDCoMKgIHU2NCBicGZfZ2V0X3NvY2tldF9j
b29raWUoc3RydWN0IGJwZl9zb2NrX29wcyAqY3R4KQ0KPiAgPg0KPiAgPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBEZXNjcmlwdGlvbg0KPiAgPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVxdWl2YWxlbnQgdG8gYnBmX2dldF9zb2Nr
ZXRfY29va2llKCkgaGVscGVyIHRoYXQNCj4gID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBhY2NlcHRzIHNrYiwgYnV0IGdldHMgc29ja2V0IGZyb20g
c3RydWN0DQo+ICA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYnBmX3NvY2tfb3BzIGNvbnRleHQuDQo+ICA+DQo+ICA+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFJldHVybiBBIDgtYnl0ZSBsb25nIG5vbi1kZWNyZWFzaW5nIG51bWJl
ci4NCj4gID4gYGBgDQo+ICA+DQo+ICA+IFRoZSBmdW5jdGlvbiBicGZfZ2V0X3NvY2tldF9j
b29raWUgcmVwZWF0cyB0aHJlZSB0aW1lcy4gVGhlIHNlY29uZCBvbmUNCj4gID4gc2hvdWxk
IGJlIGJwZl9nZXRfc29ja2V0X2Nvb2tpZV9hZGRyIGFuZCB0aGUgdGhpcmQgb25lIHNob3Vs
ZCBiZQ0KPiAgPiBicGZfZ2V0X3NvY2tldF9jb29raWVfb3BzLg0KPiANCg0KLS0gDQo8aHR0
cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5lcy8+DQo=

--------------mh0wOKIANCQKO10rSOFT0Qsb--

--------------freB6iPF8stZK51eVD1TFyPb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmPZAMwACgkQnowa+77/
2zIYFQ/+OaKiRxDVd7GpQz3jaIegjv3M4sbc9U5XqsWwndahuOph2dfzLlUvDcX+
3nHPrZVXOtxehlwRSc/YzdCSF9oBPbiSSVm0fConrBULiIP6ZKt54TIS4qTcauLX
X4bupc1mta5Xz4/M5guZ6Xs5SS7lqPQmqTR9iG3mODQCqaKJBtkjamSfpGk2X8zD
Ykk3nWWs1/Z9Trg3w2QRnLko/+FEqHufc1uP5+g7lzc14HPbx7m0MC6WVvlCl/Vf
Xx3uwNkbI69sUXGqedqrlyIPLyuytxJv10wanqZmoy3h4bczqywgv5rD0oMdbRmb
xoMHtkXMUj27DGUTwMEo6iPMnYnHkRwUlDpwMgYykUwZwxyh2VjbTdhHi1Rzlf6s
7r/dk4sVduOktCD9p+uwtpcjJpro/+TqEubIuNs5rgr5obj+WeGjyMutVKcX4ZUZ
qSKBlsbtiqJOBlF7lcVMJHmwSKti/aKSrEHz5hMaoqbmTbpJGLlv2mm3qHblGR4z
xQhCr316p3nMWunKtSkoL/eXmRI9t4z/johDLk3/B7VBEv5/15fyItdWHy5Sot0m
AQxgZ1IMYCFhyzF8rXoGp5YbsfXER8riWH7QxzWW7Eza6jCnstUMCvuQlwcniwbj
zSzsRlQtV2z146xBVSOP8MOUcL5WJgHr4AsFbiX049QuxWosnH8=
=3YPX
-----END PGP SIGNATURE-----

--------------freB6iPF8stZK51eVD1TFyPb--
