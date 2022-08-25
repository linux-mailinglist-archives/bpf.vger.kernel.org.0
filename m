Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2135A1C03
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 00:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiHYWMn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiHYWMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 18:12:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB59C483B;
        Thu, 25 Aug 2022 15:12:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso3451415wmc.0;
        Thu, 25 Aug 2022 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=RJ5O0NdEkVoMpNlzglYe1PhHTk3SY/CwTYEtNxZUTBc=;
        b=oqwBDbO8rw4lGbJdW9PMtq5G3rhMkN7E5K9iCvBGi9dMQETrmKw7Wk3mONLDpVcbLk
         5I1zx1ifE/9WFzrna9VK2gckEBaj4IyuJ3s3taC6BD62DG+ApSiDWsfN7ki9cEXamofK
         fqATs/E8g5kWH20ag7Byq26KBiT6Ljny5heGAQnMf7RRkHlYoCUtHTL7OI75R+e3NoHE
         Oy2UGvVZgg49ZPW5RzFCCi1ukkBRcLW947vq8C52Bvqzc7EGF/6OnB263/tAgmFxGKMt
         z8+ZRBXle3IuGQZEIfCCpJc4tToOHM8fkc6/P1QmmoB2RX0oAPXCRs7OtzV+wGtAOqWx
         BLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=RJ5O0NdEkVoMpNlzglYe1PhHTk3SY/CwTYEtNxZUTBc=;
        b=jlrmMj8VemmUEBcGSvdBVcr1AhQuuxnhl6K76ACebFUzB/0GHx44lN0P+n4xSWyYpo
         0uq6+8WO1vdKRTXzr4T+Ql9hBbIviUwnxCga94uISJkh0I5sU+U0qIZoSn8ZaC0SlOPk
         63OftqZ1mma/gwE8PERmaOomy5G3ujJno1mBKFG+pKMWIaUj6MGg2LAjCZp2K//lT0gI
         C9TAnlmRmrk7O8FKT5MwFLv5Dxeep/hAsxy+jrCVsreb4MEytQ2nN077Yzebb+dnGndQ
         zmqu+YSoSS8nYeoKPFZR+rPI8YELDnr81GadusKi67RJL/T3soWWea1jVPn9odxgUSBG
         AGvg==
X-Gm-Message-State: ACgBeo2+S4+f5+AOT/g4pbU5ckG/fSHqKeAcfyHVJK+7+5RqjiOMsC2x
        x4OzxLiouXO3NjdM32vJFXo=
X-Google-Smtp-Source: AA6agR44OCUKjNBYQGJPGGUikVYD7slIECpky2FaZOoChRrAgK82bmWP8sXfdjjtrOFGGZFh7uUxkw==
X-Received: by 2002:a05:600c:4e12:b0:3a5:dac2:5cec with SMTP id b18-20020a05600c4e1200b003a5dac25cecmr9378809wmq.183.1661465553633;
        Thu, 25 Aug 2022 15:12:33 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b003a6077384ecsm6810148wms.31.2022.08.25.15.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 15:12:33 -0700 (PDT)
Message-ID: <ebbae976-b452-c359-fd67-5b0511c3ef10@gmail.com>
Date:   Fri, 26 Aug 2022 00:12:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next v3] bpf: Fix a few typos in BPF helpers
 documentation
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
        bpf@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linux-man@vger.kernel.org
References: <20220825220806.107143-1-quentin@isovalent.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220825220806.107143-1-quentin@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ijtOfcLG2eWCmfb0CpvRFmIs"
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
--------------ijtOfcLG2eWCmfb0CpvRFmIs
Content-Type: multipart/mixed; boundary="------------OF8aEg70cNDy8G6jKaXu53Z2";
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
Message-ID: <ebbae976-b452-c359-fd67-5b0511c3ef10@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Fix a few typos in BPF helpers
 documentation
References: <20220825220806.107143-1-quentin@isovalent.com>
In-Reply-To: <20220825220806.107143-1-quentin@isovalent.com>

--------------OF8aEg70cNDy8G6jKaXu53Z2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gOC8yNi8yMiAwMDowOCwgUXVlbnRpbiBNb25uZXQgd3JvdGU6
DQo+IEFkZHJlc3MgYSBmZXcgdHlwb3MgaW4gdGhlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBC
UEYgaGVscGVyIGZ1bmN0aW9ucy4NCj4gVGhleSB3ZXJlIHJlcG9ydGVkIGJ5IEpha3ViIFsw
XSwgd2hvIHJhbiBzcGVsbCBjaGVja2VycyBvbiB0aGUgZ2VuZXJhdGVkDQo+IG1hbiBwYWdl
IFsxXS4NCj4gDQo+IFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tYW4vZDIy
ZGNkNDctMDIzYy04ZjUyLWQzNjktN2I1MzA4ZTZjODQyQGdtYWlsLmNvbS9ULyNtYjAyZTdk
NGI3ZmI2MWQ5OGZhOTE0Yzc3YjU4MTE4NGU5YTk1MzdhZg0KPiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtbWFuL2ViNmExZTQxLWM0OGUtYWM0NS01MTU0LWFjNTdhMmM3
NjEwOEBnbWFpbC5jb20vVC8jbTRhOGQxYjAwMzYxNjkyODAxM2ZmY2QxNDUwNDM3MzA5YWI2
NTJmOWYNCj4gDQo+IHYzOiBEbyBub3QgY29weSB1bnJlbGF0ZWQgKGFuZCBicmVha2luZykg
ZWxlbWVudHMgdG8gdG9vbHMvIGhlYWRlcg0KPiB2MjogVHVybiBhICcsJyBpbnRvIGEgJzsn
DQo+IA0KPiBDYzogQWxlamFuZHJvIENvbG9tYXIgPGFseC5tYW5wYWdlc0BnbWFpbC5jb20+
DQo+IENjOiBKYWt1YiBXaWxrIDxqd2lsa0Bqd2lsay5uZXQ+DQo+IENjOiBKZXNwZXIgRGFu
Z2FhcmQgQnJvdWVyIDxicm91ZXJAcmVkaGF0LmNvbT4NCj4gQ2M6IGxpbnV4LW1hbkB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gUmVwb3J0ZWQtYnk6IEpha3ViIFdpbGsgPGp3aWxrQGp3aWxrLm5l
dD4NCj4gU2lnbmVkLW9mZi1ieTogUXVlbnRpbiBNb25uZXQgPHF1ZW50aW5AaXNvdmFsZW50
LmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oICAgICAgIHwgMTYg
KysrKysrKystLS0tLS0tLQ0KPiAgIHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaCB8
IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFw
aS9saW51eC9icGYuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiBpbmRleCAwZjYx
ZjA5ZjQ2N2EuLjAxYzU0YTQ2MjM1MiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91YXBpL2xp
bnV4L2JwZi5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiBAQCAtNDQ1
Niw3ICs0NDU2LDcgQEAgdW5pb24gYnBmX2F0dHIgew0KPiAgICAqDQo+ICAgICoJCSoqLUVF
WElTVCoqIGlmIHRoZSBvcHRpb24gYWxyZWFkeSBleGlzdHMuDQo+ICAgICoNCj4gLSAqCQkq
Ki1FRkFVTFQqKiBvbiBmYWlscnVlIHRvIHBhcnNlIHRoZSBleGlzdGluZyBoZWFkZXIgb3B0
aW9ucy4NCj4gKyAqCQkqKi1FRkFVTFQqKiBvbiBmYWlsdXJlIHRvIHBhcnNlIHRoZSBleGlz
dGluZyBoZWFkZXIgb3B0aW9ucy4NCj4gICAgKg0KPiAgICAqCQkqKi1FUEVSTSoqIGlmIHRo
ZSBoZWxwZXIgY2Fubm90IGJlIHVzZWQgdW5kZXIgdGhlIGN1cnJlbnQNCj4gICAgKgkJKnNr
b3BzKlwgKiotPm9wKiouDQo+IEBAIC00NjY1LDcgKzQ2NjUsNyBAQCB1bmlvbiBicGZfYXR0
ciB7DQo+ICAgICoJCWEgKm1hcCogd2l0aCAqdGFzayogYXMgdGhlICoqa2V5KiouICBGcm9t
IHRoaXMNCj4gICAgKgkJcGVyc3BlY3RpdmUsICB0aGUgdXNhZ2UgaXMgbm90IG11Y2ggZGlm
ZmVyZW50IGZyb20NCj4gICAgKgkJKipicGZfbWFwX2xvb2t1cF9lbGVtKipcICgqbWFwKiwg
KiomKipcICp0YXNrKikgZXhjZXB0IHRoaXMNCj4gLSAqCQloZWxwZXIgZW5mb3JjZXMgdGhl
IGtleSBtdXN0IGJlIGFuIHRhc2tfc3RydWN0IGFuZCB0aGUgbWFwIG11c3QgYWxzbw0KPiAr
ICoJCWhlbHBlciBlbmZvcmNlcyB0aGUga2V5IG11c3QgYmUgYSB0YXNrX3N0cnVjdCBhbmQg
dGhlIG1hcCBtdXN0IGFsc28NCj4gICAgKgkJYmUgYSAqKkJQRl9NQVBfVFlQRV9UQVNLX1NU
T1JBR0UqKi4NCj4gICAgKg0KPiAgICAqCQlVbmRlcm5lYXRoLCB0aGUgdmFsdWUgaXMgc3Rv
cmVkIGxvY2FsbHkgYXQgKnRhc2sqIGluc3RlYWQgb2YNCj4gQEAgLTQ3MjMsNyArNDcyMyw3
IEBAIHVuaW9uIGJwZl9hdHRyIHsNCj4gICAgKg0KPiAgICAqIGxvbmcgYnBmX2ltYV9pbm9k
ZV9oYXNoKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHZvaWQgKmRzdCwgdTMyIHNpemUpDQo+ICAg
ICoJRGVzY3JpcHRpb24NCj4gLSAqCQlSZXR1cm5zIHRoZSBzdG9yZWQgSU1BIGhhc2ggb2Yg
dGhlICppbm9kZSogKGlmIGl0J3MgYXZhaWFsYWJsZSkuDQo+ICsgKgkJUmV0dXJucyB0aGUg
c3RvcmVkIElNQSBoYXNoIG9mIHRoZSAqaW5vZGUqIChpZiBpdCdzIGF2YWlsYWJsZSkuDQo+
ICAgICoJCUlmIHRoZSBoYXNoIGlzIGxhcmdlciB0aGFuICpzaXplKiwgdGhlbiBvbmx5ICpz
aXplKg0KPiAgICAqCQlieXRlcyB3aWxsIGJlIGNvcGllZCB0byAqZHN0Kg0KPiAgICAqCVJl
dHVybg0KPiBAQCAtNDc0NywxMiArNDc0NywxMiBAQCB1bmlvbiBicGZfYXR0ciB7DQo+ICAg
ICoNCj4gICAgKgkJVGhlIGFyZ3VtZW50ICpsZW5fZGlmZiogY2FuIGJlIHVzZWQgZm9yIHF1
ZXJ5aW5nIHdpdGggYSBwbGFubmVkDQo+ICAgICoJCXNpemUgY2hhbmdlLiBUaGlzIGFsbG93
cyB0byBjaGVjayBNVFUgcHJpb3IgdG8gY2hhbmdpbmcgcGFja2V0DQo+IC0gKgkJY3R4LiBQ
cm92aWRpbmcgYW4gKmxlbl9kaWZmKiBhZGp1c3RtZW50IHRoYXQgaXMgbGFyZ2VyIHRoYW4g
dGhlDQoNCkkganVzdCBub3RpY2VkOiAgZ3JvZmYoMSkgdXNlcyBkb3VibGUgc3BhY2VzIGFm
dGVyIGFuIGVuZC1vZi1zZW50ZW5jZSANCnBlcmlvZC4gIE90aGVyd2lzZSwgaXQgaXMgdW5k
ZXJzdG9vZCBhcyBzb21ldGhpbmcgbGlrZSBpbml0aWFscywgb3IgYW4gDQphYmJyZXZpYXR1
cmUsIGFuZCBpdCBjYXVzZXMgc29tZSBpc3N1ZXMuICBQbGVhc2UgY2hlY2sgdGhlIHdob2xl
IA0KZG9jdW1lbnQsIGFzIEkndmUgc2VlbiBhIG1peCBvZiBzdHlsZXMuDQoNClNlYXJjaCBm
b3Igc29tZXRoaW5nIGxpa2UgJy5cLiBbXiBdJw0KDQpDaGVlcnMsDQoNCkFsZXgNCg0KPiAr
ICoJCWN0eC4gUHJvdmlkaW5nIGEgKmxlbl9kaWZmKiBhZGp1c3RtZW50IHRoYXQgaXMgbGFy
Z2VyIHRoYW4gdGhlDQo+ICAgICoJCWFjdHVhbCBwYWNrZXQgc2l6ZSAocmVzdWx0aW5nIGlu
IG5lZ2F0aXZlIHBhY2tldCBzaXplKSB3aWxsIGluDQo+IC0gKgkJcHJpbmNpcGxlIG5vdCBl
eGNlZWQgdGhlIE1UVSwgd2h5IGl0IGlzIG5vdCBjb25zaWRlcmVkIGENCj4gLSAqCQlmYWls
dXJlLiAgT3RoZXIgQlBGLWhlbHBlcnMgYXJlIG5lZWRlZCBmb3IgcGVyZm9ybWluZyB0aGUN
Cj4gLSAqCQlwbGFubmVkIHNpemUgY2hhbmdlLCB3aHkgdGhlIHJlc3BvbnNhYmlsaXR5IGZv
ciBjYXRjaCBhIG5lZ2F0aXZlDQo+IC0gKgkJcGFja2V0IHNpemUgYmVsb25nIGluIHRob3Nl
IGhlbHBlcnMuDQo+ICsgKgkJcHJpbmNpcGxlIG5vdCBleGNlZWQgdGhlIE1UVSwgd2hpY2gg
aXMgd2h5IGl0IGlzIG5vdCBjb25zaWRlcmVkDQo+ICsgKgkJYSBmYWlsdXJlLiAgT3RoZXIg
QlBGIGhlbHBlcnMgYXJlIG5lZWRlZCBmb3IgcGVyZm9ybWluZyB0aGUNCj4gKyAqCQlwbGFu
bmVkIHNpemUgY2hhbmdlOyB0aGVyZWZvcmUgdGhlIHJlc3BvbnNpYmlsaXR5IGZvciBjYXRj
aGluZw0KPiArICoJCWEgbmVnYXRpdmUgcGFja2V0IHNpemUgYmVsb25ncyBpbiB0aG9zZSBo
ZWxwZXJzLg0KPiAgICAqDQo+ICAgICoJCVNwZWNpZnlpbmcgKmlmaW5kZXgqIHplcm8gbWVh
bnMgdGhlIE1UVSBjaGVjayBpcyBwZXJmb3JtZWQNCj4gICAgKgkJYWdhaW5zdCB0aGUgY3Vy
cmVudCBuZXQgZGV2aWNlLiAgVGhpcyBpcyBwcmFjdGljYWwgaWYgdGhpcyBpc24ndA0KPiBk
aWZmIC0tZ2l0IGEvdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIGIvdG9vbHMvaW5j
bHVkZS91YXBpL2xpbnV4L2JwZi5oDQo+IGluZGV4IDUwNTZjZWYyMTEyZi4uZDQ1ZGRhNDZh
YTQyIDEwMDY0NA0KPiAtLS0gYS90b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4g
KysrIGIvdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oDQo+IEBAIC00NDU2LDcgKzQ0
NTYsNyBAQCB1bmlvbiBicGZfYXR0ciB7DQo+ICAgICoNCj4gICAgKgkJKiotRUVYSVNUKiog
aWYgdGhlIG9wdGlvbiBhbHJlYWR5IGV4aXN0cy4NCj4gICAgKg0KPiAtICoJCSoqLUVGQVVM
VCoqIG9uIGZhaWxydWUgdG8gcGFyc2UgdGhlIGV4aXN0aW5nIGhlYWRlciBvcHRpb25zLg0K
PiArICoJCSoqLUVGQVVMVCoqIG9uIGZhaWx1cmUgdG8gcGFyc2UgdGhlIGV4aXN0aW5nIGhl
YWRlciBvcHRpb25zLg0KPiAgICAqDQo+ICAgICoJCSoqLUVQRVJNKiogaWYgdGhlIGhlbHBl
ciBjYW5ub3QgYmUgdXNlZCB1bmRlciB0aGUgY3VycmVudA0KPiAgICAqCQkqc2tvcHMqXCAq
Ki0+b3AqKi4NCj4gQEAgLTQ2NjUsNyArNDY2NSw3IEBAIHVuaW9uIGJwZl9hdHRyIHsNCj4g
ICAgKgkJYSAqbWFwKiB3aXRoICp0YXNrKiBhcyB0aGUgKiprZXkqKi4gIEZyb20gdGhpcw0K
PiAgICAqCQlwZXJzcGVjdGl2ZSwgIHRoZSB1c2FnZSBpcyBub3QgbXVjaCBkaWZmZXJlbnQg
ZnJvbQ0KPiAgICAqCQkqKmJwZl9tYXBfbG9va3VwX2VsZW0qKlwgKCptYXAqLCAqKiYqKlwg
KnRhc2sqKSBleGNlcHQgdGhpcw0KPiAtICoJCWhlbHBlciBlbmZvcmNlcyB0aGUga2V5IG11
c3QgYmUgYW4gdGFza19zdHJ1Y3QgYW5kIHRoZSBtYXAgbXVzdCBhbHNvDQo+ICsgKgkJaGVs
cGVyIGVuZm9yY2VzIHRoZSBrZXkgbXVzdCBiZSBhIHRhc2tfc3RydWN0IGFuZCB0aGUgbWFw
IG11c3QgYWxzbw0KPiAgICAqCQliZSBhICoqQlBGX01BUF9UWVBFX1RBU0tfU1RPUkFHRSoq
Lg0KPiAgICAqDQo+ICAgICoJCVVuZGVybmVhdGgsIHRoZSB2YWx1ZSBpcyBzdG9yZWQgbG9j
YWxseSBhdCAqdGFzayogaW5zdGVhZCBvZg0KPiBAQCAtNDcyMyw3ICs0NzIzLDcgQEAgdW5p
b24gYnBmX2F0dHIgew0KPiAgICAqDQo+ICAgICogbG9uZyBicGZfaW1hX2lub2RlX2hhc2go
c3RydWN0IGlub2RlICppbm9kZSwgdm9pZCAqZHN0LCB1MzIgc2l6ZSkNCj4gICAgKglEZXNj
cmlwdGlvbg0KPiAtICoJCVJldHVybnMgdGhlIHN0b3JlZCBJTUEgaGFzaCBvZiB0aGUgKmlu
b2RlKiAoaWYgaXQncyBhdmFpYWxhYmxlKS4NCj4gKyAqCQlSZXR1cm5zIHRoZSBzdG9yZWQg
SU1BIGhhc2ggb2YgdGhlICppbm9kZSogKGlmIGl0J3MgYXZhaWxhYmxlKS4NCj4gICAgKgkJ
SWYgdGhlIGhhc2ggaXMgbGFyZ2VyIHRoYW4gKnNpemUqLCB0aGVuIG9ubHkgKnNpemUqDQo+
ICAgICoJCWJ5dGVzIHdpbGwgYmUgY29waWVkIHRvICpkc3QqDQo+ICAgICoJUmV0dXJuDQo+
IEBAIC00NzQ3LDEyICs0NzQ3LDEyIEBAIHVuaW9uIGJwZl9hdHRyIHsNCj4gICAgKg0KPiAg
ICAqCQlUaGUgYXJndW1lbnQgKmxlbl9kaWZmKiBjYW4gYmUgdXNlZCBmb3IgcXVlcnlpbmcg
d2l0aCBhIHBsYW5uZWQNCj4gICAgKgkJc2l6ZSBjaGFuZ2UuIFRoaXMgYWxsb3dzIHRvIGNo
ZWNrIE1UVSBwcmlvciB0byBjaGFuZ2luZyBwYWNrZXQNCj4gLSAqCQljdHguIFByb3ZpZGlu
ZyBhbiAqbGVuX2RpZmYqIGFkanVzdG1lbnQgdGhhdCBpcyBsYXJnZXIgdGhhbiB0aGUNCj4g
KyAqCQljdHguIFByb3ZpZGluZyBhICpsZW5fZGlmZiogYWRqdXN0bWVudCB0aGF0IGlzIGxh
cmdlciB0aGFuIHRoZQ0KPiAgICAqCQlhY3R1YWwgcGFja2V0IHNpemUgKHJlc3VsdGluZyBp
biBuZWdhdGl2ZSBwYWNrZXQgc2l6ZSkgd2lsbCBpbg0KPiAtICoJCXByaW5jaXBsZSBub3Qg
ZXhjZWVkIHRoZSBNVFUsIHdoeSBpdCBpcyBub3QgY29uc2lkZXJlZCBhDQo+IC0gKgkJZmFp
bHVyZS4gIE90aGVyIEJQRi1oZWxwZXJzIGFyZSBuZWVkZWQgZm9yIHBlcmZvcm1pbmcgdGhl
DQo+IC0gKgkJcGxhbm5lZCBzaXplIGNoYW5nZSwgd2h5IHRoZSByZXNwb25zYWJpbGl0eSBm
b3IgY2F0Y2ggYSBuZWdhdGl2ZQ0KPiAtICoJCXBhY2tldCBzaXplIGJlbG9uZyBpbiB0aG9z
ZSBoZWxwZXJzLg0KPiArICoJCXByaW5jaXBsZSBub3QgZXhjZWVkIHRoZSBNVFUsIHdoaWNo
IGlzIHdoeSBpdCBpcyBub3QgY29uc2lkZXJlZA0KPiArICoJCWEgZmFpbHVyZS4gIE90aGVy
IEJQRiBoZWxwZXJzIGFyZSBuZWVkZWQgZm9yIHBlcmZvcm1pbmcgdGhlDQo+ICsgKgkJcGxh
bm5lZCBzaXplIGNoYW5nZTsgdGhlcmVmb3JlIHRoZSByZXNwb25zaWJpbGl0eSBmb3IgY2F0
Y2hpbmcNCj4gKyAqCQlhIG5lZ2F0aXZlIHBhY2tldCBzaXplIGJlbG9uZ3MgaW4gdGhvc2Ug
aGVscGVycy4NCj4gICAgKg0KPiAgICAqCQlTcGVjaWZ5aW5nICppZmluZGV4KiB6ZXJvIG1l
YW5zIHRoZSBNVFUgY2hlY2sgaXMgcGVyZm9ybWVkDQo+ICAgICoJCWFnYWluc3QgdGhlIGN1
cnJlbnQgbmV0IGRldmljZS4gIFRoaXMgaXMgcHJhY3RpY2FsIGlmIHRoaXMgaXNuJ3QNCg0K
LS0gDQpBbGVqYW5kcm8gQ29sb21hcg0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIu
ZXMvPg0K

--------------OF8aEg70cNDy8G6jKaXu53Z2--

--------------ijtOfcLG2eWCmfb0CpvRFmIs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMH88kACgkQnowa+77/
2zLaHRAAor4S9nRijeqL2tHDfRMrBWOMvmAjZTkc5u6xXlfGbbCZlI0XXVzywudT
CNMQUAzWYFaolH3DAg5uqUOSWns2aY3ZEmyfKGNmdYI0K+NKQkj3csdICtgvqhlh
BpDWzJ31Xho9KMlpYeWQtZNxenp2EV/dy2WevQ7DDD4mWcJanpJdIVt68RPLBBaQ
dq696/O3xlX59nhus4FjUO2/Gyz5O4CzKU+5whttn85wsF8qqv22Px/3Z9kTRrTC
0WgHijAQlLSVeJd7VZVCaBcvMBo4m0KGwpHWwJMTygwd+c91Un6+Bcb45bsYjsHr
rFZPjw37kZ1oZ1HzfFSkWNCxVJM3WtFN9wjxKqhSn6Q6RDl65YQzCu0bDLowh5au
7rh/dsH9kKNM5FZbD1leVeTymEzNJol241BiBW2v3fQAKYjWZNA/uOw6JxodZ/qI
bZj9TLH08IQmigWjXNi1RzFKU5EMRcrXsxaLrINYtm5RXpNDU1aJnbdcT5oGC6ID
BUYvvIHmbF46BQWYq4KoW8ivW0hxvmBrS6YKx/xjMO6psSekz2FaygmPZ7sVsu7o
vi68ZxNCBreMxRJ0/8JE68kh6sIu4sGDuW2k/yJES8dYPVOaryZJD7P9bXJKlENQ
OWZhjnCT67eSKrcRsc/Gd+rM5uRtS8s0pbdvUz77YLJAAO6Uj4c=
=VWMN
-----END PGP SIGNATURE-----

--------------ijtOfcLG2eWCmfb0CpvRFmIs--
