Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBDD59EB1A
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiHWSd7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiHWSdi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 14:33:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A783079
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 09:55:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq11so11162075wrb.12
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=BHHVjcMtIOwGrUJK560v1zNbcoFZ/mFC3fPSrYyoaUQ=;
        b=bWQUvj/cHt5081k1NzWvNoxr/eF9eI+iN11/KqeOpaxDh4FkwU1FywjY1cJS7Auayt
         Mc6msdeUORZSsweJQ8QqYyDz/BiGRRy0jv7wLMBEiqsY/VjByVxE1d9x57zdC9Iwzx6E
         4YS6/jj8TgW57RerOF5QBVqqAJWxj+jyn8q5kjCD3aoLsjK1RjnOXfkIFPwf5msC44vX
         MfEmgtuwoB/Uz7FZo+izbHg45s6wAAV2Hjj3jwyxWdSQgXv4nLfUQAUF4+3ZTQWHSJ9s
         /pDjXtIXNJEvrXN/ASMhOfIu9HxcxGTl9Fz4pDRznYjCIU69mKCJS5E5CxHPEcrA0FMg
         uRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=BHHVjcMtIOwGrUJK560v1zNbcoFZ/mFC3fPSrYyoaUQ=;
        b=SVEHdOqOUhgcAOhYZak3QAUPOEjhxYu+xMhXXvloGjgkBtV7N8O5O+S5Xt1KhPiVwo
         aihiPdSPCEubcmpzHmNvsewwL9U+3ugL5GVNT5C3F73EfjqLA1xpXC10Y7Gl3FzmtKHq
         6Gvn0OlO8DROzdFjWknLh8N2+DMdkDuU2Uo8OH/HXQ3Pxya8WTfdf06G45dQq5nE3Ld9
         jKQ/QE9Vzqc/dRJ/JZ6329vuR4cSzs3DTvceFH9S3QYALNrL3spK5KWPfmIPfQOgIotb
         q1N0dzK6E70iHoAUVPjs1XRoXPBMqcdULO+qJueMyucN1h+AM5mOq8BLnaF3KQoX3CS+
         Sr5w==
X-Gm-Message-State: ACgBeo1E22D8qcWetiVoh7DjA73wmHv/HXlhE3Cg59VzJFl78uUspjGD
        Zx8yFjXmg83XjeBoSa7oE+A=
X-Google-Smtp-Source: AA6agR4I4d2kaNhbFiS+Ce/N2U8i58/FtyhuXHeq4DRqD6n5iWCHfE0u9vels7ROy76/VPvu+OaldQ==
X-Received: by 2002:adf:f8c9:0:b0:225:50da:d43 with SMTP id f9-20020adff8c9000000b0022550da0d43mr7043616wrq.28.1661273726245;
        Tue, 23 Aug 2022 09:55:26 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d5387000000b002235eb9d200sm15167544wrv.10.2022.08.23.09.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 09:55:25 -0700 (PDT)
Message-ID: <046858e2-91b9-3703-92a3-89ddc620d445@gmail.com>
Date:   Tue, 23 Aug 2022 18:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next v2 1/2] scripts/bpf: Set version attribute for
 bpf-helpers(7) man page
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
References: <20220823155327.98888-1-quentin@isovalent.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220823155327.98888-1-quentin@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0RIgft0zFeZJWiG8DKV5H0fk"
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
--------------0RIgft0zFeZJWiG8DKV5H0fk
Content-Type: multipart/mixed; boundary="------------cJwSK1tPk71iq0z1dvJb0D1X";
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
Message-ID: <046858e2-91b9-3703-92a3-89ddc620d445@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] scripts/bpf: Set version attribute for
 bpf-helpers(7) man page
References: <20220823155327.98888-1-quentin@isovalent.com>
In-Reply-To: <20220823155327.98888-1-quentin@isovalent.com>

--------------cJwSK1tPk71iq0z1dvJb0D1X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOC8yMy8yMiAxNzo1MywgUXVlbnRpbiBNb25uZXQgd3JvdGU6DQo+IFRoZSBicGYtaGVs
cGVycyg3KSBtYW51YWwgcGFnZSBzaGlwcGVkIGluIHRoZSBtYW4tcGFnZXMgcHJvamVjdCBp
cw0KPiBnZW5lcmF0ZWQgZnJvbSB0aGUgZG9jdW1lbnRhdGlvbiBjb250YWluZWQgaW4gdGhl
IEJQRiBVQVBJIGhlYWRlciwgaW4NCj4gdGhlIExpbnV4IHJlcG9zaXRvcnksIHBhcnNlZCBi
eSBzY3JpcHQvYnBmX2RvYy5weSBhbmQgdGhlbiBmZWQgdG8NCj4gcnN0Mm1hbi4NCj4gDQo+
IEFmdGVyIGEgcmVjZW50IHVwZGF0ZSBvZiB0aGF0IHBhZ2UgWzBdLCBBbGVqYW5kcm8gcmVw
b3J0ZWQgdGhhdCB0aGUNCj4gbGludGVyIHVzZWQgdG8gdmFsaWRhdGUgdGhlIG1hbiBwYWdl
cyBjb21wbGFpbnMgYWJvdXQgdGhlIGdlbmVyYXRlZA0KPiBkb2N1bWVudCBbMV0uIFRoZSBo
ZWFkZXIgZm9yIHRoZSBwYWdlIGlzIHN1cHBvc2VkIHRvIGNvbnRhaW4gc29tZQ0KPiBhdHRy
aWJ1dGVzIHRoYXQgd2UgZG8gbm90IHNldCBjb3JyZWN0bHkgd2l0aCB0aGUgc2NyaXB0LiBU
aGlzIGNvbW1pdA0KPiB1cGRhdGVzIHRoZSAicHJvamVjdCBhbmQgdmVyc2lvbiIgZmllbGQu
IFdlIGRpc2N1c3NlZCB0aGUgZm9ybWF0IG9mDQo+IHRob3NlIGZpZWxkcyBpbiBbMV0gYW5k
IFsyXS4NCj4gDQo+IEJlZm9yZToNCj4gDQo+ICAgICAgJCAuL3NjcmlwdHMvYnBmX2RvYy5w
eSBoZWxwZXJzIHwgcnN0Mm1hbiB8IGdyZXAgJ1wuVEgnDQo+ICAgICAgLlRIIEJQRi1IRUxQ
RVJTIDcgIiIgIiIgIiINCj4gDQo+IEFmdGVyOg0KPiANCj4gICAgICAkIC4vc2NyaXB0cy9i
cGZfZG9jLnB5IGhlbHBlcnMgfCByc3QybWFuIHwgZ3JlcCAnXC5USCcNCj4gICAgICAuVEgg
QlBGLUhFTFBFUlMgNyAiIiAiTGludXggdjUuMTktMTQwMjItZzMwZDJhNGQ3NGUxMSIgIiIN
Cj4gDQo+IFdlIGdldCB0aGUgdmVyc2lvbiBmcm9tICJnaXQgZGVzY3JpYmUiLCBidXQgaWYg
dW5hdmFpbGFibGUsIHdlIGZhbGwgYmFjaw0KPiBvbiAibWFrZSBrZXJuZWx2ZXJzaW9uIi4g
SWYgbm9uZSB3b3JrcywgZm9yIGV4YW1wbGUgYmVjYXVzZSBuZWl0aGVyIGdpdA0KPiBub3Jl
IG1ha2UgYXJlIGluc3RhbGxlZCwgd2UganVzdCBzZXQgdGhlIGZpZWxkIHRvICJMaW51eCIg
YW5kIGtlZXANCj4gZ2VuZXJhdGluZyB0aGUgcGFnZS4NCj4gDQo+IFswXSBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vZG9jcy9tYW4tcGFnZXMvbWFuLXBhZ2VzLmdpdC9jb21t
aXQvbWFuNy9icGYtaGVscGVycy43P2lkPTE5YzdmNzgzOTNmMmIwMzhlNzYwOTlmODczMzVk
ZGY0M2E4N2YwMzkNCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDgy
MzA4NDcxOS4xMzYxMy0xLXF1ZW50aW5AaXNvdmFsZW50LmNvbS90LyNtNThhNDE4YTMxODY0
MmM2NDI4ZTE0Y2U5YmI4NGViYTUxODNiMDZlOA0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjIwNzIxMTEwODIxLjgyNDAtMS1hbHgubWFucGFnZXNAZ21haWwuY29t
L3QvI204ZTY4OWE4MjJlMDNmNmUyNTMwYTBkNmRlOWQxMjg0MDE5MTZjNWRlDQo+IA0KPiBD
YzogQWxlamFuZHJvIENvbG9tYXIgPGFseC5tYW5wYWdlc0BnbWFpbC5jb20+DQo+IFJlcG9y
dGVkLWJ5OiBBbGVqYW5kcm8gQ29sb21hciA8YWx4Lm1hbnBhZ2VzQGdtYWlsLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogUXVlbnRpbiBNb25uZXQgPHF1ZW50aW5AaXNvdmFsZW50LmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IEFsZWphbmRybyBDb2xvbWFyIDxhbHgubWFucGFnZXNAZ21haWwu
Y29tPg0KDQo+IC0tLQ0KPiAgIHNjcmlwdHMvYnBmX2RvYy5weSB8IDIxICsrKysrKysrKysr
KysrKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9icGZfZG9jLnB5IGIvc2Ny
aXB0cy9icGZfZG9jLnB5DQo+IGluZGV4IGRmYjI2MGRlMTdhOC4uMDYxYWQxZGMzMjEyIDEw
MDc1NQ0KPiAtLS0gYS9zY3JpcHRzL2JwZl9kb2MucHkNCj4gKysrIGIvc2NyaXB0cy9icGZf
ZG9jLnB5DQo+IEBAIC0xMCw2ICsxMCw4IEBAIGZyb20gX19mdXR1cmVfXyBpbXBvcnQgcHJp
bnRfZnVuY3Rpb24NCj4gICBpbXBvcnQgYXJncGFyc2UNCj4gICBpbXBvcnQgcmUNCj4gICBp
bXBvcnQgc3lzLCBvcw0KPiAraW1wb3J0IHN1YnByb2Nlc3MNCj4gKw0KPiAgIA0KPiAgIGNs
YXNzIE5vSGVscGVyRm91bmQoQmFzZUV4Y2VwdGlvbik6DQo+ICAgICAgIHBhc3MNCj4gQEAg
LTM1Nyw2ICszNTksMjAgQEAgY2xhc3MgUHJpbnRlclJTVChQcmludGVyKToNCj4gICANCj4g
ICAgICAgICAgIHByaW50KCcnKQ0KPiAgIA0KPiArICAgIGRlZiBnZXRfa2VybmVsX3ZlcnNp
b24oc2VsZik6DQo+ICsgICAgICAgIHRyeToNCj4gKyAgICAgICAgICAgIHZlcnNpb24gPSBz
dWJwcm9jZXNzLnJ1bihbJ2dpdCcsICdkZXNjcmliZSddLCBjd2Q9bGludXhSb290LA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNhcHR1cmVfb3V0cHV0PVRy
dWUsIGNoZWNrPVRydWUpDQo+ICsgICAgICAgICAgICB2ZXJzaW9uID0gdmVyc2lvbi5zdGRv
dXQuZGVjb2RlKCkucnN0cmlwKCkNCj4gKyAgICAgICAgZXhjZXB0Og0KPiArICAgICAgICAg
ICAgdHJ5Og0KPiArICAgICAgICAgICAgICAgIHZlcnNpb24gPSBzdWJwcm9jZXNzLnJ1bihb
J21ha2UnLCAna2VybmVsdmVyc2lvbiddLCBjd2Q9bGludXhSb290LA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjYXB0dXJlX291dHB1dD1UcnVlLCBj
aGVjaz1UcnVlKQ0KPiArICAgICAgICAgICAgICAgIHZlcnNpb24gPSB2ZXJzaW9uLnN0ZG91
dC5kZWNvZGUoKS5yc3RyaXAoKQ0KPiArICAgICAgICAgICAgZXhjZXB0Og0KPiArICAgICAg
ICAgICAgICAgIHJldHVybiAnTGludXgnDQo+ICsgICAgICAgIHJldHVybiAnTGludXgge3Zl
cnNpb259Jy5mb3JtYXQodmVyc2lvbj12ZXJzaW9uKQ0KPiArDQo+ICAgY2xhc3MgUHJpbnRl
ckhlbHBlcnNSU1QoUHJpbnRlclJTVCk6DQo+ICAgICAgICIiIg0KPiAgICAgICBBIHByaW50
ZXIgZm9yIGR1bXBpbmcgY29sbGVjdGVkIGluZm9ybWF0aW9uIGFib3V0IGhlbHBlcnMgYXMg
YSBSZVN0cnVjdHVyZWQNCj4gQEAgLTM3OCw2ICszOTQsNyBAQCBsaXN0IG9mIGVCUEYgaGVs
cGVyIGZ1bmN0aW9ucw0KPiAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICANCj4g
ICA6TWFudWFsIHNlY3Rpb246IDcNCj4gKzpWZXJzaW9uOiB7dmVyc2lvbn0NCj4gICANCj4g
ICBERVNDUklQVElPTg0KPiAgID09PT09PT09PT09DQo+IEBAIC00MTAsOCArNDI3LDEwIEBA
IGtlcm5lbCBhdCB0aGUgdG9wKS4NCj4gICBIRUxQRVJTDQo+ICAgPT09PT09PQ0KPiAgICcn
Jw0KPiArICAgICAgICBrZXJuZWxWZXJzaW9uID0gc2VsZi5nZXRfa2VybmVsX3ZlcnNpb24o
KQ0KPiArDQo+ICAgICAgICAgICBQcmludGVyUlNULnByaW50X2xpY2Vuc2Uoc2VsZikNCj4g
LSAgICAgICAgcHJpbnQoaGVhZGVyKQ0KPiArICAgICAgICBwcmludChoZWFkZXIuZm9ybWF0
KHZlcnNpb249a2VybmVsVmVyc2lvbikpDQo+ICAgDQo+ICAgICAgIGRlZiBwcmludF9mb290
ZXIoc2VsZik6DQo+ICAgICAgICAgICBmb290ZXIgPSAnJycNCg0KLS0gDQpBbGVqYW5kcm8g
Q29sb21hcg0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------cJwSK1tPk71iq0z1dvJb0D1X--

--------------0RIgft0zFeZJWiG8DKV5H0fk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMFBnwACgkQnowa+77/
2zKm4g/8DPiUGSEDMo7HGX4YMN9nx4xhvNB48gtN311HIMW6CpUm5bPSptuzfO8N
LfQQoW57SBdpPhX+414LPKuF72FPgB0V7wFJ60cA2eh8AFflD5nW6FTqaCveRh3N
wsW3kJJPd46EQ2I8taXvy+INnfSxeuh75IyWoRv4CApu9R2ysCVWEfKw8NzdYCHC
nV9nT0FnAeU4fmg1VkJ6X2aTC7d3vYXNXdXB4DrjfMTUIt/YazI7hmZhB+DlbRFh
clgEdlUh9fLPWNrjxZWqvE2u4nyLErKaAEj+AEwdmjGHLN2Rk4JdlctZcBb9YvE3
GUISmPrSqjqNIovAe1gLQgkSCbXPdEaEbR8HsO6Xwky+66Baq3cKxflHz9InEiwy
eSV4f0nstxgFfqpFuP8yqq951XEpkWdaCiH9cksWjqsy0FxMSoArzWIXNqtU+Jfo
ILai3jgzDbSdqGWWBIhAW/fiW07WwxLwgSTD04zIYqQu2MjVSZrFdWIpa0C3g/4J
vsd7K7U7HlgMypFcMSWLrXQX/4+P0sKWIfe4W+duU82xzKB2pmtUApJtSCmya16D
mgI0tOa0qwbPmYWYRqKcsmowDOnVTan/Vgthunyhk+jdPETCbL5YV+T+128o6cY2
ODyiHtMwz7oR5esYhOwzVjmkz9542wBXd6l8SiZJGRWwSdnWOSM=
=J1gG
-----END PGP SIGNATURE-----

--------------0RIgft0zFeZJWiG8DKV5H0fk--
