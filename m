Return-Path: <bpf+bounces-3472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D9B73E668
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5204E1C2074E
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA5125B7;
	Mon, 26 Jun 2023 17:28:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3C1107
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 17:28:44 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7A410C9
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 10:28:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7f92b764dso7071215ad.2
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687800523; x=1690392523;
        h=in-reply-to:subject:autocrypt:from:references:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iZYetYG15n8vJREZnVvd9gb2qSCIYrIskEJPGSQSAc=;
        b=YSC/1xfgTYG7oHesYbd9nAA81sx1i2iB2awlSszXE7QnnUiRo6jSjpkWKp6jRdN40F
         AJ2UVtVd0W2DvLTAOYbvDNWPg03efbasqHxH2cs6RxzIog1S7KcpyoQYRluHDagfEVpE
         yvghHmiFE0bdLAc53X4Aus1PopRrH+T45HxQAXem8QiBCFGNdHOwM7HyhNkST2Ygt4t2
         tu/J0FPFXfaVKDGYHe6Wasy9vOeURrSVdERuI7beEWE8wuGcBNRYzHn6rYdviZsTv3BT
         K6u5sC90WiFKBbFRUmyrOjCv+e/741u8uRkr/NOFJVF5x8VG+nZzj9OuRwHu7UjNyFK6
         Hkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800523; x=1690392523;
        h=in-reply-to:subject:autocrypt:from:references:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3iZYetYG15n8vJREZnVvd9gb2qSCIYrIskEJPGSQSAc=;
        b=W3oCiCrSIZtRPVbKdv5B3PtcxxEOk7Mv/Iv/TLftFAaLoZMLP6ofVCyl4JpYkvwOQ/
         CURW7MbudkazGEK7NAZIWPjF6JLCXMmDMuOOlZmQg5xWHxNfbJ2srWGfw1DYNtkNx20F
         vtMvuDkVztF9wdwFAKs10Ko7y7lv7fNWfoyZVE93V0xMoqqEKMyBFGFQD6ddPDZaYcyy
         9Oej9jZhFhtMN51tIDuWdGrIO6grNuaW8MCTiKcSRAD/vahq0d6vp7N6Wb4VhbR0n3HO
         k+u4beIWnT57/cUP23a/IqlY/AER2X10Rd+YTFex0waf89PN/wpLX5e/RhQlrCK/vHk1
         wp8Q==
X-Gm-Message-State: AC+VfDzkI5gfLG33ECapDHkqRF7SAJgic9UgrI4hzd7yjQ16Ka05HyE5
	bqDULbzt6kj0xTYww+1ymQgYgLQKMpw=
X-Google-Smtp-Source: ACHHUZ4lqj73DA2eLa82J0sAP+WblBcCqCx2zCcaw+0m8IuEZmRwhWFQ0VYinriabT6HjVo6zosvLg==
X-Received: by 2002:a17:903:24d:b0:1ac:859a:5b5a with SMTP id j13-20020a170903024d00b001ac859a5b5amr5008380plh.0.1687800522756;
        Mon, 26 Jun 2023 10:28:42 -0700 (PDT)
Received: from ?IPV6:2600:8800:7280:a54d::813? ([2600:8800:7280:a54d::813])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001b02162c86bsm4470113plg.80.2023.06.26.10.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 10:28:42 -0700 (PDT)
Message-ID: <a4c4a323-4f66-2ccf-53a9-ef0f411cddd0@gmail.com>
Date: Mon, 26 Jun 2023 10:28:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
References: <20230626023731.115783-1-carlosrodrifernandez@gmail.com>
 <9a949539-8eb8-35b3-3d3f-f84e2f11da81@meta.com>
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
Autocrypt: addr=carlosrodrifernandez@gmail.com; keydata=
 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
Subject: Re: [PATCH] libbpf: provide num present cpus
In-Reply-To: <9a949539-8eb8-35b3-3d3f-f84e2f11da81@meta.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cTloWT2402yoPOinQ1uKeqB6"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cTloWT2402yoPOinQ1uKeqB6
Content-Type: multipart/mixed; boundary="------------UiR9J8XsRX9mtrY0zAEJ63AS";
 protected-headers="v1"
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
To: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Message-ID: <a4c4a323-4f66-2ccf-53a9-ef0f411cddd0@gmail.com>
Subject: Re: [PATCH] libbpf: provide num present cpus
References: <20230626023731.115783-1-carlosrodrifernandez@gmail.com>
 <9a949539-8eb8-35b3-3d3f-f84e2f11da81@meta.com>
In-Reply-To: <9a949539-8eb8-35b3-3d3f-f84e2f11da81@meta.com>

--------------UiR9J8XsRX9mtrY0zAEJ63AS
Content-Type: multipart/mixed; boundary="------------k0i8GuA4dkDx02rUV2Uc7q0O"

--------------k0i8GuA4dkDx02rUV2Uc7q0O
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgWW9uZ2hvbmcsDQpUaGFuayB5b3UgZm9yIGxvb2tpbmcgaW50byB0aGlzLiBJIHJlcGxp
ZWQgb24gdGhlIGJjYyBpc3N1ZS4gSSB0aGluayANCnlvdXIgYXBwcm9hY2ggb2YgbW9kaWZ5
aW5nIHRoZSB0b29sIGl0c2VsZiBzaG91bGQgd29yay4NCg0KRXZlbiB0aG91Z2ggdGhlcmUg
Y291bGQgYmUgc29tZSB2YWx1ZSBhZGRpbmcgYSBoZWxwZXIgZnVuY3Rpb24gZm9yIA0KInBy
ZXNlbnQiLCBpdCBpcyBub3QgZW5vdWdoIGJlY2F1c2UgaXQgZG9lc24ndCBnaXZlIHlvdSB0
aGUgb25saW5lIENQVXMgDQphcyB5b3Ugc2FpZCBpbiB0aGUgYmNjIGlzc3VlLiBBIGZ1bmN0
aW9uIHJldHVybmluZyB0aGUgb25saW5lIENQVXMgbGlzdCANCmluIGEgYml0IGFycmF5IG9y
IGVxdWl2YWxlbnQgY291bGQgYmUgYSB2YWx1YWJsZSBmdW5jdGlvbiB0byBhdm9pZCANCmRl
cGVuZGluZyBvbiBhdm9pZGFibGUgZXJyb3JzLg0KDQpJIGFwb2xvZ2l6ZSBub3QgZ2l2aW5n
IGVub3VnaCBjb250ZXh0IGluIHRoZXNlIGVtYWlscy4gSSBzZW50IGFuIGVtYWlsIA0KZWFy
bGllciBleHBsYWluaW5nIHRoZSBjb250ZXh0IChzZWUgdGhlIGVtYWlsICJQb3NzaWJsZSB2
cyBwcmVzZW50IA0KbnVtYmVyIG9mIGNwdXMgYW5kIHByb3Bvc2UgZm9yIGEgbmV3IEFQSSBm
dW5jdGlvbiIpLCBidXQgdGhlbiBJIHJlYWxpemVkIA0KSSB3YXMgc2VuZGluZyB0aGUgcGF0
Y2ggd3JvbmcsIHNvIEkgdXNlZCB0aGUgZ2l0IHNlbmQtZW1haWwgb3B0aW9uLiANClNvcnJ5
IGZvciB0aGUgY29uZnVzaW9uLg0KDQpSZWdhcmRzLA0KQ2FybG9zLg0KDQpPbiA2LzI2LzIz
IDEwOjAyLCBZb25naG9uZyBTb25nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDYvMjUvMjMgNzoz
NCBQTSwgQ2FybG9zIFJvZHJpZ3Vlei1GZXJuYW5kZXogd3JvdGU6DQo+PiBJdCBhbGxvd3Mg
dG9vbHMgdG8gaXRlcmF0ZSBvdmVyIENQVXMgcHJlc2VudA0KPj4gaW4gdGhlIHN5c3RlbSB0
aGF0IGFyZSBhY3R1YWxseSBydW5uaW5nIHByb2Nlc3NlcywNCj4+IHdoaWNoIGNhbiBiZSBs
ZXNzIHRoYW4gdGhlIG51bWJlciBvZiBwb3NzaWJsZSBDUFVzLg0KPiANCj4gUGxlYXNlIGFk
ZCBtb3JlIGNvbnRleHQgaGVyZS4gVGhlcmUgZXhpc3RzIGEgYmNjIGlzc3VlDQo+ICDCoMKg
IGh0dHBzOi8vZ2l0aHViLmNvbS9pb3Zpc29yL2JjYy9pc3N1ZXMvNDY1MQ0KPiB3aGljaCBz
aG93cyB0aGUgY29udGV4dCBmb3IgdGhpcyBwYXRjaCBzZXQuDQo+IEJhc2ljYWxseSBpdCBp
cyB0byBhZGRyZXNzIGJjYy9saWJicGYtdG9vbHMvY3B1ZnJlcQ0KPiBmYWlsdXJlIGluIGNh
c2UgdGhhdCBzb21lIGNwdXMgYXJlIG5vdCBwcmVzZW50Lg0KPiANCj4gQ2FybG9zLCB5b3Ug
bmVlZCB0byBzaG93IHdoYXQgY2FuIGJlIGRvbmUNCj4gaW4gdG9vbCBpdHNlbGYgdG8gcmVz
b2x2ZSB0aGUgaXNzdWUgdnMuDQo+IHRvIHVzZSB0aGUgQVBJIGZyb20gd2hhdCBpcyBwcm9w
b3NlZCBoZXJlDQo+IHRvIHJlc29sdmUgdGhlIGlzc3VlLiBTbyBpdCB3b3VsZCBiZWNvbWUN
Cj4gY2xlYXIgaG93IHRoZSBuZXcgQVBJIG1pZ2h0IGhlbHAgb3Igbm90Lg0KPiANCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBDYXJsb3MgUm9kcmlndWV6LUZlcm5hbmRleiANCj4+IDxjYXJs
b3Nyb2RyaWZlcm5hbmRlekBnbWFpbC5jb20+DQo+PiAtLS0NCj4+IMKgIHNyYy9saWJicGYu
YyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+PiDCoCBzcmMvbGli
YnBmLmggfMKgIDggKysrKystLS0NCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvc3JjL2xpYmJw
Zi5jIGIvc3JjL2xpYmJwZi5jDQo+PiBpbmRleCAyMTRmODI4Li5lNDJkMjUyIDEwMDY0NA0K
Pj4gLS0tIGEvc3JjL2xpYmJwZi5jDQo+PiArKysgYi9zcmMvbGliYnBmLmMNCj4+IEBAIC0x
MjYxNSwxNCArMTI2MTUsMjYgQEAgaW50IHBhcnNlX2NwdV9tYXNrX2ZpbGUoY29uc3QgY2hh
ciAqZmNwdSwgDQo+PiBib29sICoqbWFzaywgaW50ICptYXNrX3N6KQ0KPj4gwqDCoMKgwqDC
oCByZXR1cm4gcGFyc2VfY3B1X21hc2tfc3RyKGJ1ZiwgbWFzaywgbWFza19zeik7DQo+PiDC
oCB9DQo+PiAtaW50IGxpYmJwZl9udW1fcG9zc2libGVfY3B1cyh2b2lkKQ0KPj4gK3R5cGVk
ZWYgZW51bSB7UE9TU0lCTEU9MCwgUFJFU0VOVCwgTlVNX1RZUEVTIH0gQ1BVX1RPUE9MT0dZ
X1NZU0ZTX1RZUEU7DQo+PiArDQo+PiArc3RhdGljIGNvbnN0IGNoYXIgKmNwdV90b3BvbG9n
eV9zeXNmc19wYXRoX2J5X3R5cGUoY29uc3QgDQo+PiBDUFVfVE9QT0xPR1lfU1lTRlNfVFlQ
RSB0eXBlKSB7DQo+PiArwqDCoMKgIGNvbnN0IHN0YXRpYyBjaGFyICpwb3NzaWJsZV9zeXNm
c19wYXRoID0gDQo+PiAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvcG9zc2libGUiOw0KPj4g
K8KgwqDCoCBjb25zdCBzdGF0aWMgY2hhciAqcHJlc2VudF9zeXNmc19wYXRoID0gDQo+PiAi
L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvcHJlc2VudCI7DQo+PiArwqDCoMKgIHN3aXRjaCh0
eXBlKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBQT1NTSUJMRTogcmV0dXJuIHBvc3Np
YmxlX3N5c2ZzX3BhdGg7DQo+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBQUkVTRU5UOiByZXR1
cm4gcHJlc2VudF9zeXNmc19wYXRoOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6IHJl
dHVybiBwb3NzaWJsZV9zeXNmc19wYXRoOw0KPj4gK8KgwqDCoCB9DQo+PiArfQ0KPj4gKw0K
Pj4gK2ludCBsaWJicGZfbnVtX2NwdXNfYnlfdG9wb2xvZ3lfc3lzZnNfdHlwZShjb25zdCAN
Cj4+IENQVV9UT1BPTE9HWV9TWVNGU19UWVBFIHR5cGUpDQo+PiDCoCB7DQo+PiAtwqDCoMKg
IHN0YXRpYyBjb25zdCBjaGFyICpmY3B1ID0gIi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L3Bv
c3NpYmxlIjsNCj4+IC3CoMKgwqAgc3RhdGljIGludCBjcHVzOw0KPj4gK8KgwqDCoCBjb25z
dCBjaGFyICpmY3B1ID0gY3B1X3RvcG9sb2d5X3N5c2ZzX3BhdGhfYnlfdHlwZSh0eXBlKTsN
Cj4+ICvCoMKgwqAgc3RhdGljIGludCBjcHVzW05VTV9UWVBFU107DQo+PiDCoMKgwqDCoMKg
IGludCBlcnIsIG4sIGksIHRtcF9jcHVzOw0KPj4gwqDCoMKgwqDCoCBib29sICptYXNrOw0K
Pj4gLcKgwqDCoCB0bXBfY3B1cyA9IFJFQURfT05DRShjcHVzKTsNCj4+ICvCoMKgwqAgdG1w
X2NwdXMgPSBSRUFEX09OQ0UoY3B1c1t0eXBlXSk7DQo+PiDCoMKgwqDCoMKgIGlmICh0bXBf
Y3B1cyA+IDApDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRtcF9jcHVzOw0KPj4g
QEAgLTEyNjM3LDEwICsxMjY0OSwyMCBAQCBpbnQgbGliYnBmX251bV9wb3NzaWJsZV9jcHVz
KHZvaWQpDQo+PiDCoMKgwqDCoMKgIH0NCj4+IMKgwqDCoMKgwqAgZnJlZShtYXNrKTsNCj4+
IC3CoMKgwqAgV1JJVEVfT05DRShjcHVzLCB0bXBfY3B1cyk7DQo+PiArwqDCoMKgIFdSSVRF
X09OQ0UoY3B1c1t0eXBlXSwgdG1wX2NwdXMpOw0KPj4gwqDCoMKgwqDCoCByZXR1cm4gdG1w
X2NwdXM7DQo+PiDCoCB9DQo+PiAraW50IGxpYmJwZl9udW1fcG9zc2libGVfY3B1cyh2b2lk
KQ0KPj4gK3sNCj4+ICvCoMKgwqAgcmV0dXJuIGxpYmJwZl9udW1fY3B1c19ieV90b3BvbG9n
eV9zeXNmc190eXBlKFBPU1NJQkxFKTsNCj4+ICt9DQo+PiArDQo+PiAraW50IGxpYmJwZl9u
dW1fcHJlc2VudF9jcHVzKHZvaWQpDQo+PiArew0KPj4gK8KgwqDCoCByZXR1cm4gbGliYnBm
X251bV9jcHVzX2J5X3RvcG9sb2d5X3N5c2ZzX3R5cGUoUFJFU0VOVCk7DQo+PiArfQ0KPj4g
Kw0KPj4gwqAgc3RhdGljIGludCBwb3B1bGF0ZV9za2VsZXRvbl9tYXBzKGNvbnN0IHN0cnVj
dCBicGZfb2JqZWN0ICpvYmosDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgYnBmX21hcF9za2VsZXRvbiAqbWFwcywNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVfdCBtYXBfY250KQ0KPj4gZGlmZiAt
LWdpdCBhL3NyYy9saWJicGYuaCBiL3NyYy9saWJicGYuaA0KPj4gaW5kZXggNzU0ZGE3My4u
YTM0MTUyYyAxMDA2NDQNCj4+IC0tLSBhL3NyYy9saWJicGYuaA0KPj4gKysrIGIvc3JjL2xp
YmJwZi5oDQo+PiBAQCAtMTQzMyw5ICsxNDMzLDEwIEBAIExJQkJQRl9BUEkgaW50IGxpYmJw
Zl9wcm9iZV9icGZfaGVscGVyKGVudW0gDQo+PiBicGZfcHJvZ190eXBlIHByb2dfdHlwZSwN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBl
bnVtIGJwZl9mdW5jX2lkIGhlbHBlcl9pZCwgY29uc3Qgdm9pZCAqb3B0cyk7DQo+PiDCoCAv
KioNCj4+IC0gKiBAYnJpZWYgKipsaWJicGZfbnVtX3Bvc3NpYmxlX2NwdXMoKSoqIGlzIGEg
aGVscGVyIGZ1bmN0aW9uIHRvIGdldCB0aGUNCj4+IC0gKiBudW1iZXIgb2YgcG9zc2libGUg
Q1BVcyB0aGF0IHRoZSBob3N0IGtlcm5lbCBzdXBwb3J0cyBhbmQgZXhwZWN0cy4NCj4+IC0g
KiBAcmV0dXJuIG51bWJlciBvZiBwb3NzaWJsZSBDUFVzOyBvciBlcnJvciBjb2RlIG9uIGZh
aWx1cmUNCj4+ICsgKiBAYnJpZWYgKipsaWJicGZfbnVtX3Bvc3NpYmxlX2NwdXMoKSoqLCBh
bmQgDQo+PiAqKmxpYmJwZl9udW1fcHJlc2VudF9jcHVzKCkqKg0KPj4gKyAqIGFyZSBoZWxw
ZXIgZnVuY3Rpb25zIHRvIGdldCB0aGUgbnVtYmVyIG9mIHBvc3NpYmxlLCBhbmQgcHJlc2Vu
dCANCj4+IENQVXMgcmVzcGVjdGl2ZWxseS4NCj4+ICsgKiBTZWUgZm9yIG1vcmUgaW5mb3Jt
YXRpb246IA0KPj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvYWRt
aW4tZ3VpZGUvY3B1dG9wb2xvZ3kuaHRtbA0KPj4gKyAqIEByZXR1cm4gbnVtYmVyIG9mIENQ
VXM7IG9yIGVycm9yIGNvZGUgb24gZmFpbHVyZQ0KPj4gwqDCoCAqDQo+PiDCoMKgICogRXhh
bXBsZSB1c2FnZToNCj4+IMKgwqAgKg0KPj4gQEAgLTE0NDcsNiArMTQ0OCw3IEBAIExJQkJQ
Rl9BUEkgaW50IGxpYmJwZl9wcm9iZV9icGZfaGVscGVyKGVudW0gDQo+PiBicGZfcHJvZ190
eXBlIHByb2dfdHlwZSwNCj4+IMKgwqAgKsKgwqDCoMKgIGJwZl9tYXBfbG9va3VwX2VsZW0o
cGVyX2NwdV9tYXBfZmQsIGtleSwgdmFsdWVzKTsNCj4+IMKgwqAgKi8NCj4+IMKgIExJQkJQ
Rl9BUEkgaW50IGxpYmJwZl9udW1fcG9zc2libGVfY3B1cyh2b2lkKTsNCj4+ICtMSUJCUEZf
QVBJIGludCBsaWJicGZfbnVtX3ByZXNlbnRfY3B1cyh2b2lkKTsNCj4+IMKgIHN0cnVjdCBi
cGZfbWFwX3NrZWxldG9uIHsNCj4+IMKgwqDCoMKgwqAgY29uc3QgY2hhciAqbmFtZTsNCg==

--------------k0i8GuA4dkDx02rUV2Uc7q0O
Content-Type: application/pgp-keys; name="OpenPGP_0x47EBED05C3375B1F.asc"
Content-Disposition: attachment; filename="OpenPGP_0x47EBED05C3375B1F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D=3D
=3Dn5Jn
-----END PGP PUBLIC KEY BLOCK-----

--------------k0i8GuA4dkDx02rUV2Uc7q0O--

--------------UiR9J8XsRX9mtrY0zAEJ63AS--

--------------cTloWT2402yoPOinQ1uKeqB6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEELMV13GzPmqlwKY7rR+vtBcM3Wx8FAmSZyskFAwAAAAAACgkQR+vtBcM3Wx8y
DQv+OdOowyJfwAFsObkl/Lv4xQo43W6l9abX2Pk27xpNKAs9hi/Z61v2Hm5YSFSM5gWBNPjLBgVt
yGHsiTRGv9h3zFzwrDxkO3sECrzFth+uXhD2AT6In4k9Cz0pXlwnIUlFe/HN8TyywpKLHcXKFORE
6xLK+pO6orUH1VsQA4geBGi1XVB6D9Gs0c0xiGJJ4iTGB8i2Bsqs6UWQTgOD0Ai/nNwnS9IW1WMo
a431X9DAM2kjELAkjQStryYmYJJTrT5S34moyCSGyKooh1kaafQHvv2d7UdX2SLVu3iE+tZw4kae
BxcExQ7JLEGv6WHEcwS7LhAQgDrKM/2Ymys4xwovx56+NIkUsBgV4ZmFtqi0XoRg8vEs4g8ZnV51
A6Qfvlq6wEf/JGIXdByPyx+qiTzovviwjRM/y4EJrC2MTwRfE5RwgF6cyJVDuhjC99OQ5HK/dpPb
5fBEpG9G1rdU61pt0cvu2ivZoae25Lq9377/mWiSIkFbgCzP0ClUs7YNki9+
=clPZ
-----END PGP SIGNATURE-----

--------------cTloWT2402yoPOinQ1uKeqB6--

