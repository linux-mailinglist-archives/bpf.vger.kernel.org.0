Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B485A0E97
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 12:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiHYK6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiHYK6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 06:58:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C442ADCE1;
        Thu, 25 Aug 2022 03:58:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so2461126wmk.3;
        Thu, 25 Aug 2022 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=Wqidy/67CDrwdlkYr2JcaZoahZc3e4+hriN0Kurk2JI=;
        b=HUo09R0VNLiWE46LXvL7zkkjuIIgjH+lTC4LNupBFOmFZiX4IoH+sxIvPAoYQK5kkN
         CclUHwZqisXX72lWEpmSPi3B20E+ZyAi46AQkVIteyPvafy+Vylkl6ZGtbXz5OhGllOq
         koQ8eVUDQ95C9uxGZLUFHvKmmpBzvFjz8EbUmoXNDrB6GMeSi/ucMn5aykSKrsGiN1ch
         96gm8vqutAMNkPJlnvx4Ej0k+pJzr1adNBSzjsJY3TpRH9pLAi/uC8A2kzUxwfyTG4/C
         nBnzM0Z0hXWBJcyf6gb3KuMo1/uV5wW061nM0Cd+eF+xpZLYw53ipEf/Lq78ZI85Utk6
         ivVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=Wqidy/67CDrwdlkYr2JcaZoahZc3e4+hriN0Kurk2JI=;
        b=MFW/brzEabc/xHJILbAI9wqRgIkaryz2uU+8erNnf4jcksMlx9MeAlX4AZCBHym+Py
         yB9dN7ncGRy76t5QXKgLYAF8az4dsynBf89tcKK6tkFgB9VbY5ObzWwgNpoI16L3g9iI
         V6zLHr44uim+CbcDI0EEUqEVoO+czN7yrALhnz53A5BwQ2WaGrXpoFFkf28JdML+K/To
         rO35n373sh+SiU6HmiSfIPvK4qZuGFyI6/zALmydYAXdoIxquQfmjnOHNmeXkr0lUR9H
         DOLGNtAmeLI1B+uTQCz2czmcMzmjWeIM5AJZEmVOTsQSeNg4zH7ZD8pt3fd7u0q++TjZ
         HTWg==
X-Gm-Message-State: ACgBeo3CpZAcSdS8cSHDAZa3SWy7UQn61+mDjUxBmgqo3iTGC4zqkSiI
        Ph7W72hMw7YWzWQa+gtYfV8=
X-Google-Smtp-Source: AA6agR5AWwpTsv+DGHNn0jDWxrATAjGbfcTlFJPOjvT5YOO/rDxB2GGgS+hMXNnWwXgSlIwcxmni2w==
X-Received: by 2002:a05:600c:19c8:b0:3a5:ec6a:8d16 with SMTP id u8-20020a05600c19c800b003a5ec6a8d16mr7724792wmq.182.1661425097126;
        Thu, 25 Aug 2022 03:58:17 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b003a5f54e3bbbsm5472586wmq.38.2022.08.25.03.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 03:58:16 -0700 (PDT)
Message-ID: <ef43ff2d-f451-09ba-2047-0ef852b9add1@gmail.com>
Date:   Thu, 25 Aug 2022 12:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next] bpf: Fix a few typos in BPF helpers
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
References: <20220825092631.11605-1-quentin@isovalent.com>
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220825092631.11605-1-quentin@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hXSFHLZFNOSi7ylY10qq537Y"
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
--------------hXSFHLZFNOSi7ylY10qq537Y
Content-Type: multipart/mixed; boundary="------------GWw0V4Q8UjOPxM5OOuU09VP9";
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
Message-ID: <ef43ff2d-f451-09ba-2047-0ef852b9add1@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a few typos in BPF helpers
 documentation
References: <20220825092631.11605-1-quentin@isovalent.com>
In-Reply-To: <20220825092631.11605-1-quentin@isovalent.com>

--------------GWw0V4Q8UjOPxM5OOuU09VP9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gOC8yNS8yMiAxMToyNiwgUXVlbnRpbiBNb25uZXQgd3JvdGU6
DQo+IEFkZHJlc3MgYSBmZXcgdHlwb3MgaW4gdGhlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBC
UEYgaGVscGVyIGZ1bmN0aW9ucy4NCj4gVGhleSB3ZXJlIHJlcG9ydGVkIGJ5IEpha3ViIFsw
XSwgd2hvIHJhbiBzcGVsbCBjaGVja2VycyBvbiB0aGUgZ2VuZXJhdGVkDQo+IG1hbiBwYWdl
IFsxXS4NCj4gDQo+IFN5bmMtdXAgdGhlIFVBUEkgaGVhZGVyIHdpdGggaXRzIHZlcnNpb24g
aW4gdG9vbHMvLg0KPiANCj4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1h
bi9kMjJkY2Q0Ny0wMjNjLThmNTItZDM2OS03YjUzMDhlNmM4NDJAZ21haWwuY29tL1QvI21i
MDJlN2Q0YjdmYjYxZDk4ZmE5MTRjNzdiNTgxMTg0ZTlhOTUzN2FmDQo+IFsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1tYW4vZWI2YTFlNDEtYzQ4ZS1hYzQ1LTUxNTQtYWM1
N2EyYzc2MTA4QGdtYWlsLmNvbS9ULyNtNGE4ZDFiMDAzNjE2OTI4MDEzZmZjZDE0NTA0Mzcz
MDlhYjY1MmY5Zg0KPiANCj4gQ2M6IEFsZWphbmRybyBDb2xvbWFyIDxhbHgubWFucGFnZXNA
Z21haWwuY29tPg0KPiBDYzogSmFrdWIgV2lsayA8andpbGtAandpbGsubmV0Pg0KPiBDYzog
SmVzcGVyIERhbmdhYXJkIEJyb3VlciA8YnJvdWVyQHJlZGhhdC5jb20+DQo+IENjOiBsaW51
eC1tYW5Admdlci5rZXJuZWwub3JnDQo+IFJlcG9ydGVkLWJ5OiBKYWt1YiBXaWxrIDxqd2ls
a0Bqd2lsay5uZXQ+DQo+IFNpZ25lZC1vZmYtYnk6IFF1ZW50aW4gTW9ubmV0IDxxdWVudGlu
QGlzb3ZhbGVudC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvdWFwaS9saW51eC9icGYuaCAg
ICAgICB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gICB0b29scy9pbmNsdWRlL3VhcGkvbGlu
dXgvYnBmLmggfCAxOCArKysrKysrKystLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDE3IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdWFwaS9saW51eC9icGYuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0K
PiBpbmRleCA2NDQ2MDBkYmIxMTQuLmU0ZDM4MTA5OTBiZSAxMDA2NDQNCj4gLS0tIGEvaW5j
bHVkZS91YXBpL2xpbnV4L2JwZi5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYu
aA0KPiBAQCAtNDQzNyw3ICs0NDM3LDcgQEAgdW5pb24gYnBmX2F0dHIgew0KPiAgICAqDQo+
ICAgICoJCSoqLUVFWElTVCoqIGlmIHRoZSBvcHRpb24gYWxyZWFkeSBleGlzdHMuDQo+ICAg
ICoNCj4gLSAqCQkqKi1FRkFVTFQqKiBvbiBmYWlscnVlIHRvIHBhcnNlIHRoZSBleGlzdGlu
ZyBoZWFkZXIgb3B0aW9ucy4NCj4gKyAqCQkqKi1FRkFVTFQqKiBvbiBmYWlsdXJlIHRvIHBh
cnNlIHRoZSBleGlzdGluZyBoZWFkZXIgb3B0aW9ucy4NCj4gICAgKg0KPiAgICAqCQkqKi1F
UEVSTSoqIGlmIHRoZSBoZWxwZXIgY2Fubm90IGJlIHVzZWQgdW5kZXIgdGhlIGN1cnJlbnQN
Cj4gICAgKgkJKnNrb3BzKlwgKiotPm9wKiouDQo+IEBAIC00NjQ2LDcgKzQ2NDYsNyBAQCB1
bmlvbiBicGZfYXR0ciB7DQo+ICAgICoJCWEgKm1hcCogd2l0aCAqdGFzayogYXMgdGhlICoq
a2V5KiouICBGcm9tIHRoaXMNCj4gICAgKgkJcGVyc3BlY3RpdmUsICB0aGUgdXNhZ2UgaXMg
bm90IG11Y2ggZGlmZmVyZW50IGZyb20NCj4gICAgKgkJKipicGZfbWFwX2xvb2t1cF9lbGVt
KipcICgqbWFwKiwgKiomKipcICp0YXNrKikgZXhjZXB0IHRoaXMNCj4gLSAqCQloZWxwZXIg
ZW5mb3JjZXMgdGhlIGtleSBtdXN0IGJlIGFuIHRhc2tfc3RydWN0IGFuZCB0aGUgbWFwIG11
c3QgYWxzbw0KPiArICoJCWhlbHBlciBlbmZvcmNlcyB0aGUga2V5IG11c3QgYmUgYSB0YXNr
X3N0cnVjdCBhbmQgdGhlIG1hcCBtdXN0IGFsc28NCj4gICAgKgkJYmUgYSAqKkJQRl9NQVBf
VFlQRV9UQVNLX1NUT1JBR0UqKi4NCj4gICAgKg0KPiAgICAqCQlVbmRlcm5lYXRoLCB0aGUg
dmFsdWUgaXMgc3RvcmVkIGxvY2FsbHkgYXQgKnRhc2sqIGluc3RlYWQgb2YNCj4gQEAgLTQ3
MDQsNyArNDcwNCw3IEBAIHVuaW9uIGJwZl9hdHRyIHsNCj4gICAgKg0KPiAgICAqIGxvbmcg
YnBmX2ltYV9pbm9kZV9oYXNoKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHZvaWQgKmRzdCwgdTMy
IHNpemUpDQo+ICAgICoJRGVzY3JpcHRpb24NCj4gLSAqCQlSZXR1cm5zIHRoZSBzdG9yZWQg
SU1BIGhhc2ggb2YgdGhlICppbm9kZSogKGlmIGl0J3MgYXZhaWFsYWJsZSkuDQo+ICsgKgkJ
UmV0dXJucyB0aGUgc3RvcmVkIElNQSBoYXNoIG9mIHRoZSAqaW5vZGUqIChpZiBpdCdzIGF2
YWlsYWJsZSkuDQo+ICAgICoJCUlmIHRoZSBoYXNoIGlzIGxhcmdlciB0aGFuICpzaXplKiwg
dGhlbiBvbmx5ICpzaXplKg0KPiAgICAqCQlieXRlcyB3aWxsIGJlIGNvcGllZCB0byAqZHN0
Kg0KPiAgICAqCVJldHVybg0KPiBAQCAtNDcyOCwxMiArNDcyOCwxMiBAQCB1bmlvbiBicGZf
YXR0ciB7DQo+ICAgICoNCj4gICAgKgkJVGhlIGFyZ3VtZW50ICpsZW5fZGlmZiogY2FuIGJl
IHVzZWQgZm9yIHF1ZXJ5aW5nIHdpdGggYSBwbGFubmVkDQo+ICAgICoJCXNpemUgY2hhbmdl
LiBUaGlzIGFsbG93cyB0byBjaGVjayBNVFUgcHJpb3IgdG8gY2hhbmdpbmcgcGFja2V0DQo+
IC0gKgkJY3R4LiBQcm92aWRpbmcgYW4gKmxlbl9kaWZmKiBhZGp1c3RtZW50IHRoYXQgaXMg
bGFyZ2VyIHRoYW4gdGhlDQo+ICsgKgkJY3R4LiBQcm92aWRpbmcgYSAqbGVuX2RpZmYqIGFk
anVzdG1lbnQgdGhhdCBpcyBsYXJnZXIgdGhhbiB0aGUNCj4gICAgKgkJYWN0dWFsIHBhY2tl
dCBzaXplIChyZXN1bHRpbmcgaW4gbmVnYXRpdmUgcGFja2V0IHNpemUpIHdpbGwgaW4NCj4g
LSAqCQlwcmluY2lwbGUgbm90IGV4Y2VlZCB0aGUgTVRVLCB3aHkgaXQgaXMgbm90IGNvbnNp
ZGVyZWQgYQ0KPiAtICoJCWZhaWx1cmUuICBPdGhlciBCUEYtaGVscGVycyBhcmUgbmVlZGVk
IGZvciBwZXJmb3JtaW5nIHRoZQ0KPiAtICoJCXBsYW5uZWQgc2l6ZSBjaGFuZ2UsIHdoeSB0
aGUgcmVzcG9uc2FiaWxpdHkgZm9yIGNhdGNoIGEgbmVnYXRpdmUNCj4gLSAqCQlwYWNrZXQg
c2l6ZSBiZWxvbmcgaW4gdGhvc2UgaGVscGVycy4NCj4gKyAqCQlwcmluY2lwbGUgbm90IGV4
Y2VlZCB0aGUgTVRVLCB3aGljaCBpcyB3aHkgaXQgaXMgbm90IGNvbnNpZGVyZWQNCj4gKyAq
CQlhIGZhaWx1cmUuICBPdGhlciBCUEYgaGVscGVycyBhcmUgbmVlZGVkIGZvciBwZXJmb3Jt
aW5nIHRoZQ0KPiArICoJCXBsYW5uZWQgc2l6ZSBjaGFuZ2UsIHRoZXJlZm9yZSB0aGUgcmVz
cG9uc2liaWxpdHkgZm9yIGNhdGNoaW5nDQoNCk1heWJlIHMvLC87LyA/DQoNCk90aGVyIHRo
YW4gdGhhdCwgTEdUTS4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCi0tIA0KQWxlamFuZHJvIENv
bG9tYXINCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------GWw0V4Q8UjOPxM5OOuU09VP9--

--------------hXSFHLZFNOSi7ylY10qq537Y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMHVb8ACgkQnowa+77/
2zImEhAApfDPmMufdQGBQAUqZ/aLv4oEL7D1kLU8/OTpdIf6Dneg5tCZcucwk73+
bIqsNuiQP4D/Nz8yC8P4yZEy+MgfHxj18PQy2B03WSfAE2VBHHtDZZReRjZ5SgtK
krc3qO9PbOgTcHr1K3ItMG00bOAPoWXTGy3vulHffSghwp4StZ4JtQe6ZPFK20HZ
rFUuG+oIdETPaGw/70P/km4bgp2Hhlb755y4PuxJctVrf7J0DAzNTpisosX+44AP
+BZMOmhYMgJQbCRP48wFkMtrRDJ0c3sTj46trw19yKUzPtp07Soqipy1Z4PXQEoU
n8o+MHzsk0nYgVgNeCF0GS37NnfW298SYtd2kGDutQqK8CUXhYGONChZePmNOpYb
k1WQ6IlbHU0QgiTu3Isw2txca8WIz4ogDqrTZdx+Ky+Gze+ErlPaCrrAAZy3ne0r
ceLtZjf1AmZPdXlTlbFk2vQ7zCdmEtkpG9vv8WvvdR+cMpBhLGmgNDgnoNQssFZe
dz7DVCLHQT1pi3da163HSPtr9w37fyeac69v8iUtFjJe1rL00VrAzTxtItXDJqQE
8Q4rqqLBBXWoTwD2gg9Dd0bCc2f9+kVumjpx4kJyYA6Wwqe0TLNsrS8XnOo7djaN
UVSJXINfTreVxOnWGFsQIGvbX00zkqcwRSNY1S1A7AZaafs0DoU=
=wUVE
-----END PGP SIGNATURE-----

--------------hXSFHLZFNOSi7ylY10qq537Y--
