Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733355873C9
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiHAWNN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiHAWNM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:13:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB1C03
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:13:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso6169831wmm.5
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=l4h6IYJmw3XDPeyziqMDG2MDV75JLUV7PdBDWZR8AQ8=;
        b=HK9PdieI4USDbMggMyDAhhvVhgDPV4mBYLEoXSuEFUl6fIk/A7tcD3d3HU6yt+U4qO
         9iYaH07lhJ7J1KL/TCsq6KQNtyDcqReUhjbMKXQf0afyamM/TKWRSPlmBZhQ8QRtIS98
         6qIVDzTHylxUu4rV/2JGXT3yEzbaQKRF9xfDTKuwSlGa3K2SVqFRPRTU+ia12xheh5sW
         Dbb1yLZft1SjUrArJ+dBxst6pcaTGN4HIrqUiD+52+CClly7bvjvKlHDGjXMB7yqraPV
         TgomzNKStEjnjgxcNK6qWMQiP/yzFQru9v44o6C2ArKRWL+icK07N2vR+92A6M+gNtzw
         ZS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=l4h6IYJmw3XDPeyziqMDG2MDV75JLUV7PdBDWZR8AQ8=;
        b=S32R7//Mfe39r9FYpGQFvV0Yh0NvunvKeIAmPs7mfBHZPCqO/mv9MLzH6LGglSudWW
         N3H4gWY00in4g0E2Q0biwYVLO1z7iq6BSALC7ERE1JhqZSgYmpb7b+tRGkMu+b+i7su/
         ej6+RiqaC2gt2X+uwZqc/Ck0utEjts7KwnHWJRllMbemIpUt3Vjd2Q4u6jxJdhpGeFiY
         Wli0nNrDemzhCtjubUI52a5pYFYHpKUFqZj2DDsDmBZ1uvtenGVN8JgLh042dmDkPysR
         02DjCyx/L2yGbLg+ilhF8eiy0V6w+8QGiCHaY37dkKR9BsKk59so/CCKfa/E1tRSVZua
         WfPQ==
X-Gm-Message-State: AJIora/pVzbBstYF2ftzgC0nVShefZ86hed6GskrUUp2jrtVweLm24bd
        s2FThfscP/VWEGf/EsQAido=
X-Google-Smtp-Source: AGRyM1s89w591YTsSnS2hLhpke6FXVQUf/yIDqzhVKXaG2R014FwSw1t27MjQ7tFLnwcsaoNY7ahuw==
X-Received: by 2002:a1c:27c4:0:b0:3a3:365d:10a2 with SMTP id n187-20020a1c27c4000000b003a3365d10a2mr12538174wmn.61.1659391989611;
        Mon, 01 Aug 2022 15:13:09 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0039db31f6372sm22536025wmq.2.2022.08.01.15.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 15:13:09 -0700 (PDT)
Message-ID: <c5462667-377a-1544-f255-e57b9823df6a@gmail.com>
Date:   Tue, 2 Aug 2022 00:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: bpf-helpers.7: .TH line is... meh (was: [PATCH] bpf_doc.py: Use
 SPDX-License-Identifier)
Content-Language: en-US
To:     daniel@iogearbox.net
Cc:     quentin@isovalent.com, bpf@vger.kernel.org
References: <20220721110821.8240-1-alx.manpages@gmail.com>
 <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2p2r0Gla2KEGZSNpESymApTn"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2p2r0Gla2KEGZSNpESymApTn
Content-Type: multipart/mixed; boundary="------------lHxy5uYaIspRwQYf7QGhR2H7";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: daniel@iogearbox.net
Cc: quentin@isovalent.com, bpf@vger.kernel.org
Message-ID: <c5462667-377a-1544-f255-e57b9823df6a@gmail.com>
Subject: bpf-helpers.7: .TH line is... meh (was: [PATCH] bpf_doc.py: Use
 SPDX-License-Identifier)
References: <20220721110821.8240-1-alx.manpages@gmail.com>
 <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>
In-Reply-To: <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>

--------------lHxy5uYaIspRwQYf7QGhR2H7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRGFuaWVsLA0KDQpPbiA3LzIyLzIyIDAwOjUwLCBwYXRjaHdvcmstYm90K25ldGRldmJw
ZkBrZXJuZWwub3JnIHdyb3RlOg0KPiBIZWxsbzoNCj4gDQo+IFRoaXMgcGF0Y2ggd2FzIGFw
cGxpZWQgdG8gYnBmL2JwZi1uZXh0LmdpdCAobWFzdGVyKQ0KPiBieSBEYW5pZWwgQm9ya21h
bm4gPGRhbmllbEBpb2dlYXJib3gubmV0PjoNCj4gDQo+IE9uIFRodSwgMjEgSnVsIDIwMjIg
MTM6MDg6MjIgKzAyMDAgeW91IHdyb3RlOg0KPj4gVGhlIExpbnV4IG1hbi1wYWdlcyBwcm9q
ZWN0IG5vdyB1c2VzIFNQRFggdGFncywNCj4+IGluc3RlYWQgb2YgdGhlIGZ1bGwgbGljZW5z
ZSB0ZXh0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFsZWphbmRybyBDb2xvbWFyIDxhbHgu
bWFucGFnZXNAZ21haWwuY29tPg0KPj4gLS0tDQo+PiAgIHNjcmlwdHMvYnBmX2RvYy5weSB8
IDIyICstLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQo+IEhlcmUgaXMgdGhlIHN1bW1hcnkg
d2l0aCBsaW5rczoNCj4gICAgLSBicGZfZG9jLnB5OiBVc2UgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXINCj4gICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2JwZi9icGYtbmV4dC9jLzVj
YjYyYjc1OThmMg0KPiANCj4gWW91IGFyZSBhd2Vzb21lLCB0aGFuayB5b3UhDQoNCk9oLCB3
aGF0IGEgbmljZSBib3QgOikNCg0KDQpJJ3ZlIGJlZW4gcnVubmluZyBhIGxpbnRlciBvbiB0
aGUgbWFuLXBhZ2VzLCBhbmQgaGFkIHRoaXMgdHJpZ2dlcmVkIGZyb20gDQpicGYtaGVscGVy
cy43Og0KDQpbDQokIG1ha2UgbGludCBWPTENCkxJTlQgKGdyb2ZmKQl0bXAvbGludC9tYW43
L2JwZi1oZWxwZXJzLjcubGludC1tYW4uZ3JvZmYudG91Y2gNCmdyb2ZmIC1tYW4gLXQgLU0g
Li9ldGMvZ3JvZmYvdG1hYyAtbSBjaGVja3N0eWxlIC1yQ0hFQ0tTVFlMRT0zIC13dyAgLXog
DQptYW43L2JwZi1oZWxwZXJzLjcNCmFuLnRtYWM6bWFuNy9icGYtaGVscGVycy43OjM6IHN0
eWxlOiAuVEggbWlzc2luZyB0aGlyZCBhcmd1bWVudDsgc3VnZ2VzdCANCmRvY3VtZW50IG1v
ZGlmaWNhdGlvbiBkYXRlIGluIElTTyA4NjAxIGZvcm1hdCAoWVlZWS1NTS1ERCkNCmFuLnRt
YWM6bWFuNy9icGYtaGVscGVycy43OjM6IHN0eWxlOiAuVEggbWlzc2luZyBmb3VydGggYXJn
dW1lbnQ7IA0Kc3VnZ2VzdCBwYWNrYWdlL3Byb2plY3QgbmFtZSBhbmQgdmVyc2lvbiAoZS5n
LiwgImdyb2ZmIDEuMjMuMCIpDQphbi50bWFjOm1hbjcvYnBmLWhlbHBlcnMuNzozOiBzdHls
ZTogLlRIIG1pc3NpbmcgZmlmdGggYXJndW1lbnQgYW5kIA0Kc2Vjb25kIGFyZ3VtZW50ICc3
JyBub3QgYSByZWNvZ25pemVkIG1hbnVhbCBzZWN0aW9uOyBzcGVjaWZ5IHZvbHVtZSB0aXRs
ZQ0KZm91bmQgc3R5bGUgcHJvYmxlbXM7IGFib3J0aW5nDQptYWtlOiAqKiogW2xpYi9saW50
LW1hbi5tazo0OTogDQp0bXAvbGludC9tYW43L2JwZi1oZWxwZXJzLjcubGludC1tYW4uZ3Jv
ZmYudG91Y2hdIEVycm9yIDENCg0KXQ0KDQpTZWUgd2hhdCBhIG5vcm1hbCAuVEggbGluZSBs
b29rcyBsaWtlLCBhbmQgd2hhdCBicGYtaGVscGVycy43IGhhczoNCg0KWw0KJCBncmVwIF4u
VEggbWFuMi9icGYuMg0KLlRIIEJQRiAyIDIwMjEtMDgtMjcgIkxpbnV4IiAiTGludXggUHJv
Z3JhbW1lcidzIE1hbnVhbCINCiQgZ3JlcCBeLlRIIG1hbjcvYnBmLWhlbHBlcnMuNw0KLlRI
IEJQRi1IRUxQRVJTIDcgIiIgIiIgIiINCl0NCg0KDQpJIGRvbid0IGtub3cgaWYgeW91IGNh
biBmaXggdGhhdCwgb3IgaWYgaXQncyBhIGxpbWl0YXRpb24gb2YgdGhlIA0KZ2VuZXJhdG9y
PyAgSSBjYW4gbGl2ZSB3aXRoIGl0LCBidXQgaXQgd291bGQgYmUgbmljZSBpZiBpdCBjb3Vs
ZCBiZSANCmZpeGVkLiAgSXQgcHJvdmlkZXMgdGhlIGhlYWRlcnMgYW5kIGZvb3RlcnMgb2Yg
dGhlIG1hbnVhbCBwYWdlLg0KDQoNCkNoZWVycywNCg0KQWxleA0KDQotLSANCkFsZWphbmRy
byBDb2xvbWFyDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5lcy8+DQo=

--------------lHxy5uYaIspRwQYf7QGhR2H7--

--------------2p2r0Gla2KEGZSNpESymApTn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmLoT+0ACgkQnowa+77/
2zJnww/7BJsEqHCeEatI4F44dulN2m+3nfABGCviIxfeH1zVMbAX3qRYpPEEoNND
2+g4bAXwJ4J7xAFwFtY1C6J/803KqHyYGL+B+iDMOhoTGJCdPOVGR18a4DK1fNyb
RSTqc0NkDe2Fl/2K0ulf9m9L0fAF8vx6U7KJCGsLJyBvVoIEGqBhTqhno9wuAgJu
AEcwF0d75vXdMIuVTyVoPgvCJNBKAklhVtWSXy7Nr1WRUDOSdnEkU7QvXcFlPw1s
H0DR/fjaSvMHGrD4gbaOhrRai0eTbyqpC5202faLB3H4qiI7OoPP8MOC4OOH2JVU
RZBrZYjMyitDoX21GDkO4mV+Lt9tG1bqRUiZkaCNGXGZc8izepHEn9EtxyOrcjqk
2uFvp/h4EqkY2wIgApnJyMFR4Mw6ZzsfV9HE8aKQ11aFnT0jvMK1XSBuWJNIMCtY
t2ijR0adWlxTcvr3TP2dYs8u1V/IULyWY5uhJmOxT5jskljGoi8h6fCIneZDneEu
Jws0cHAyJf7VXhZkWzmcfKmYaDVs8AqeVx4z71wjdDVCDZrVZ0fNce76f3fnHm47
ue/V0cLSZ6DzyekRRoMCY263iBpuANP8xMw0+xfSGekG/0KuoE6XGailFaNvS47A
jOT64FttzHW0sOomUKE+95nZwAK5/JmHoXyjm4DFfoo32hLJg5U=
=EnR6
-----END PGP SIGNATURE-----

--------------2p2r0Gla2KEGZSNpESymApTn--
