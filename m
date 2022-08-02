Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2A587B2C
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 13:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiHBLAD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 07:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiHBK7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 06:59:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34304F1AA
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 03:59:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a11so7013109wmq.3
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=fq3tr6oDYBqWbi+qQaLXZxHEvyAejzEGDdpm+ENJzZw=;
        b=hBvrkj2ok9iNcpEiouY+OezwLtwICq07mrOpQGpXMojyPd0TlIEl9h6/IRGEUCq9cz
         qFy2DNJJPpPK3vE2OfHcJmEIVjXErbogGHObsf8gNRfqSaHM79tILZRH6WV01UKvGUVX
         e2bNWoRuCwzAK3+l7/1JKuwInISbOTonKstEyHmDnDPrTIldqMrX/lVrLYz25T4G0f+H
         cpCrr/eNoDKXcrTTFi/jSGSvnJy3HCXsT+rEFvXP2eXaENw+sJw4Y8AL7z4/hTCMzAQb
         qnbdXPzVP6bmfebDBngiN2mt3ytkqGOEYctgQbyXq+hydWdcvBTtrB/UZtkMwRRbLRvT
         S/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=fq3tr6oDYBqWbi+qQaLXZxHEvyAejzEGDdpm+ENJzZw=;
        b=hq1qkC+WPlf57d35HVAlKG203pr+SfR/zajsgeRBIV+JNj4qkjTqoorJGl1J/PnXPy
         I9tbCqCa9B4PcEKFO3Xv7T1SBkofY42NbQyEm+VtJ39MnOsUHVj9bVMubAB8qNbnZGcg
         jIdauKQxS4cLni4ce1Eo6Wj46RaUVgfoaioBY8PfWjZ90l4E6J3TkdewkZZvC4NeCw/5
         vnVEoQmHj7fyNYozfMDETxWPL8mslU3yluf7jNsIgpX7HG3+dUEH0/NNhnkyIHGGQrMg
         srSI8DgAPYHNZTVd9bHt/ZYThoKz/GEEtY0cAswN9PS0jI1yWHDkxlfUF1XAfaRRc7X8
         Zp3Q==
X-Gm-Message-State: AJIora+sYRvqYbYacOoHdiFYbvDoj9bXjWjSoSshmwYAHJ6OrhZEIVQT
        Ir6PG//62eu8Kk3PshJiE+WbEwFvz2s=
X-Google-Smtp-Source: AGRyM1sliIE8OFBH7FgUIsO5zA7hvUaZ7HuojubDLSMARWUzBZKwuPjrwoigX2BLC6Mfxtcjct8xlQ==
X-Received: by 2002:a05:600c:1d12:b0:3a3:297a:bb13 with SMTP id l18-20020a05600c1d1200b003a3297abb13mr14021915wms.136.1659437988894;
        Tue, 02 Aug 2022 03:59:48 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003a320e6f011sm18146664wmc.1.2022.08.02.03.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:59:48 -0700 (PDT)
Message-ID: <8f3cf769-4d95-9d16-dab1-bf58b0733af7@gmail.com>
Date:   Tue, 2 Aug 2022 12:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: bpf-helpers.7: .TH line is... meh (was: [PATCH] bpf_doc.py: Use
 SPDX-License-Identifier)
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net
References: <20220721110821.8240-1-alx.manpages@gmail.com>
 <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>
 <c5462667-377a-1544-f255-e57b9823df6a@gmail.com>
 <d7cd119b-fc34-8e14-6560-5d2cf5567e80@isovalent.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <d7cd119b-fc34-8e14-6560-5d2cf5567e80@isovalent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------p8602nCovnVpsftt4boqk97j"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------p8602nCovnVpsftt4boqk97j
Content-Type: multipart/mixed; boundary="------------vLkCk1pKOxmoDEtdSlGdcmo2";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Quentin Monnet <quentin@isovalent.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net
Message-ID: <8f3cf769-4d95-9d16-dab1-bf58b0733af7@gmail.com>
Subject: Re: bpf-helpers.7: .TH line is... meh (was: [PATCH] bpf_doc.py: Use
 SPDX-License-Identifier)
References: <20220721110821.8240-1-alx.manpages@gmail.com>
 <165844381278.13656.3004635809924499624.git-patchwork-notify@kernel.org>
 <c5462667-377a-1544-f255-e57b9823df6a@gmail.com>
 <d7cd119b-fc34-8e14-6560-5d2cf5567e80@isovalent.com>
In-Reply-To: <d7cd119b-fc34-8e14-6560-5d2cf5567e80@isovalent.com>

--------------vLkCk1pKOxmoDEtdSlGdcmo2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUXVlbnRpbiwNCg0KT24gOC8yLzIyIDEyOjI4LCBRdWVudGluIE1vbm5ldCB3cm90ZToN
Cj4+IEkndmUgYmVlbiBydW5uaW5nIGEgbGludGVyIG9uIHRoZSBtYW4tcGFnZXMsIGFuZCBo
YWQgdGhpcyB0cmlnZ2VyZWQgZnJvbQ0KPj4gYnBmLWhlbHBlcnMuNzoNCj4+DQo+PiBbDQo+
PiAkIG1ha2UgbGludCBWPTENCj4+IExJTlQgKGdyb2ZmKcKgwqDCoCB0bXAvbGludC9tYW43
L2JwZi1oZWxwZXJzLjcubGludC1tYW4uZ3JvZmYudG91Y2gNCj4+IGdyb2ZmIC1tYW4gLXQg
LU0gLi9ldGMvZ3JvZmYvdG1hYyAtbSBjaGVja3N0eWxlIC1yQ0hFQ0tTVFlMRT0zIC13d8Kg
IC16DQo+PiBtYW43L2JwZi1oZWxwZXJzLjcNCj4+IGFuLnRtYWM6bWFuNy9icGYtaGVscGVy
cy43OjM6IHN0eWxlOiAuVEggbWlzc2luZyB0aGlyZCBhcmd1bWVudDsgc3VnZ2VzdA0KPj4g
ZG9jdW1lbnQgbW9kaWZpY2F0aW9uIGRhdGUgaW4gSVNPIDg2MDEgZm9ybWF0IChZWVlZLU1N
LUREKQ0KPj4gYW4udG1hYzptYW43L2JwZi1oZWxwZXJzLjc6Mzogc3R5bGU6IC5USCBtaXNz
aW5nIGZvdXJ0aCBhcmd1bWVudDsNCj4+IHN1Z2dlc3QgcGFja2FnZS9wcm9qZWN0IG5hbWUg
YW5kIHZlcnNpb24gKGUuZy4sICJncm9mZiAxLjIzLjAiKQ0KPj4gYW4udG1hYzptYW43L2Jw
Zi1oZWxwZXJzLjc6Mzogc3R5bGU6IC5USCBtaXNzaW5nIGZpZnRoIGFyZ3VtZW50IGFuZA0K
Pj4gc2Vjb25kIGFyZ3VtZW50ICc3JyBub3QgYSByZWNvZ25pemVkIG1hbnVhbCBzZWN0aW9u
OyBzcGVjaWZ5IHZvbHVtZSB0aXRsZQ0KPj4gZm91bmQgc3R5bGUgcHJvYmxlbXM7IGFib3J0
aW5nDQo+IA0KPiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhpcyBsYXN0IG9uZS4gSXNuJ3Qg
IjciIGEgdmFsaWQgbWFuIHNlY3Rpb24/DQoNCkl0IGlzIGEgdmFsaWQgc2VjdGlvbi4gIEkg
ZG9uJ3QgdW5kZXJzdGFuZCBpdCBlaXRoZXIuICBNYXliZSBncm9mZigxKSANCmhhcyBnb25l
IGNyYXp5IGFmdGVyIHNvIG1hbnkgZXJyb3JzLiAgSSdsbCByZXBvcnQgYSBidWcgdG8gZ3Jv
ZmYuDQoNCj4gDQo+PiBtYWtlOiAqKiogW2xpYi9saW50LW1hbi5tazo0OToNCj4+IHRtcC9s
aW50L21hbjcvYnBmLWhlbHBlcnMuNy5saW50LW1hbi5ncm9mZi50b3VjaF0gRXJyb3IgMQ0K
Pj4NCj4+IF0NCj4+DQo+PiBTZWUgd2hhdCBhIG5vcm1hbCAuVEggbGluZSBsb29rcyBsaWtl
LCBhbmQgd2hhdCBicGYtaGVscGVycy43IGhhczoNCj4+DQo+PiBbDQo+PiAkIGdyZXAgXi5U
SCBtYW4yL2JwZi4yDQo+PiAuVEggQlBGIDIgMjAyMS0wOC0yNyAiTGludXgiICJMaW51eCBQ
cm9ncmFtbWVyJ3MgTWFudWFsIg0KPj4gJCBncmVwIF4uVEggbWFuNy9icGYtaGVscGVycy43
DQo+PiAuVEggQlBGLUhFTFBFUlMgNyAiIiAiIiAiIg0KPj4gXQ0KPj4NCj4+DQo+PiBJIGRv
bid0IGtub3cgaWYgeW91IGNhbiBmaXggdGhhdCwgb3IgaWYgaXQncyBhIGxpbWl0YXRpb24g
b2YgdGhlDQo+PiBnZW5lcmF0b3I/wqAgSSBjYW4gbGl2ZSB3aXRoIGl0LCBidXQgaXQgd291
bGQgYmUgbmljZSBpZiBpdCBjb3VsZCBiZQ0KPj4gZml4ZWQuwqAgSXQgcHJvdmlkZXMgdGhl
IGhlYWRlcnMgYW5kIGZvb3RlcnMgb2YgdGhlIG1hbnVhbCBwYWdlLg0KPiANCj4gSSBoYWQg
bmV2ZXIgcmVhbGx5IGxvb2tlZCBpbnRvIGNvbXBsZXRpbmcgdGhpcyBsaW5lIGJlZm9yZSwg
YnV0IGl0IHNlZW1zDQo+IHRoYXQgRG9jdXRpbHMvcnN0Mm1hbiBoYXMgYSBmZXcgKGFsYmVp
dCBub3QgbXVjaCBkb2N1bWVudGVkKSBkb2NpbmZvDQo+IGVsZW1lbnRzIGF2YWlsYWJsZSB0
byBjb21wbGV0ZSBfc29tZV8gb2YgdGhlc2UgZmllbGRzLiBXZSBjdXJyZW50bHkgaGF2ZQ0K
PiAiOk1hbnVhbCBzZWN0aW9uOiA3IiBpbiB0aGUgZ2VuZXJhdGVkIHBhZ2UuIEkgY2FuIGdl
bmVyYXRlIGEgcGFnZSBjbG9zZQ0KPiB0byB0aGUgcmVzdWx0IGFib3ZlIHdpdGg6DQo+IA0K
PiAgICAgIDpNYW51YWwgc2VjdGlvbjogNw0KPiAgICAgIDpNYW51YWwgZ3JvdXA6IExpbnV4
IFByb2dyYW1tZXIncyBNYW51YWwNCj4gICAgICA6VmVyc2lvbjogTGludXgNCj4gICAgICA6
RGF0ZTogMjAyMi0wOC0wMg0KPiANCj4gV2l0aCB0aGVzZSBmaWVsZHMsIEkgZ2V0Og0KPiAN
Cj4gICAgICAuVEggQlBGLUhFTFBFUlMgNyAiMjAyMi0wOC0wMyIgIkxpbnV4IiAiTGludXgg
UHJvZ3JhbW1lcidzIE1hbnVhbCINCj4gDQo+IENhdmVhdHM6IEZpcnN0LCB3ZSBnZXQgYWRk
aXRpb25hbCBkb3VibGUgcXVvdGVzIGFyb3VuZCB0aGUgZGF0ZSwgbm90DQo+IHN1cmUgaWYg
dGhpcyBtYXR0ZXJzLg0KDQpOYWgsIHF1b3RlcyBhcmUgb25seSBmb3Igc3BhY2VzICh0aGV5
IGFyZSBpZ25vcmVkIGluIHRoaXMgY2FzZSkuICBZb3UncmUgDQpmaW5lIHdpdGggb3Igd2l0
aG91dCB0aGVtLg0KDQo+IA0KPiBTZWNvbmQ6IOKAnFZlcnNpb27igJ0gZG9lcyBub3Qgc2Vl
bSBhIHJlbGV2YW50IGZpZWxkIG5hbWUgaW4gdGhhdCBjYXNlLCBidXQNCj4gdGhpcyBpcyBh
cHBhcmVudGx5IHRoZSBvbmx5IG9wdGlvbiB0aGF0IHdlIGhhdmUgdG8gaW5zZXJ0IGEgdmFs
dWUgYXQNCj4gdGhpcyBsb2NhdGlvbiBbMF0uIEFwcGFyZW50bHkgdGhlIG1hbnBhZ2Ugd3Jp
dGVyIGZvciBEb2N1dGlscyBhc3N1bWVzDQo+IHRoYXQgdGhpcyBsaW5lIGNvbnRhaW5zIGEg
dmVyc2lvbiBudW1iZXIgWzFdLg0KDQpUaGF0IGZpZWxkIHNlZW1zIHRvIGJlIGRpZmZlcmVu
dCwgZGVwZW5kaW5nIG9uIHdobyB5b3UgYXNrLg0KDQpJbiBtb3N0IGNhc2VzLCBpdCdzIGEg
InByb2plY3QgYW5kIHZlcnNpb24iIChzZWUgZm9yIGV4YW1wbGUgdGhlIGdyb2ZmIA0Kd2Fy
bmluZyB0ZXh0KS4NCg0KQnV0IGluIHRoZSBsaW51eCBtYW4tcGFnZXMsIHNpbmNlIHdlIGNv
dmVyIG1hbnkgcHJvamVjdHMgYW5kIHZlcnNpb25zLCANCndlIGp1c3Qgc2F5IHdoaWNoIHBy
b2plY3Qgd2UncmUgZG9jdW1lbnRpbmcgKHRvIGF2b2lkIGhhdmluZyB0byB1cGRhdGUgDQp0
aGUgdmVyc2lvbiBldmVyeSB0aW1lLCBJIGd1ZXNzKS4NCg0KU2VlIG1hbi1wYWdlcyg3KToN
ClsNCiAgICBUaXRsZSBsaW5lDQogICAgICAgIFRoZSBmaXJzdCBjb21tYW5kIGluIGEgbWFu
IHBhZ2Ugc2hvdWxkIGJlIGEgVEggY29tbWFuZDoNCg0KICAgICAgICAgICAgICAgLlRIIHRp
dGxlIHNlY3Rpb24gZGF0ZSBzb3VyY2UgbWFudWFsDQoNCiAgICAgICAgVGhlIGFyZ3VtZW50
cyBvZiB0aGUgY29tbWFuZCBhcmUgYXMgZm9sbG93czoNCg0KICAgICAgICBbLi4uXQ0KDQog
ICAgICAgIHNvdXJjZSBUaGUgc291cmNlIG9mIHRoZSAgY29tbWFuZCwgIGZ1bmN0aW9uLCAg
b3IgIHN5c3RlbQ0KICAgICAgICAgICAgICAgY2FsbC4NCg0KICAgICAgICAgICAgICAgRm9y
IHRob3NlIGZldyBtYW7igJBwYWdlcyBwYWdlcyBpbiBTZWN0aW9ucyAxIGFuZCA4LA0KICAg
ICAgICAgICAgICAgcHJvYmFibHkgeW91IGp1c3Qgd2FudCB0byB3cml0ZSBHTlUuDQoNCiAg
ICAgICAgICAgICAgIEZvciAgc3lzdGVtICBjYWxscywganVzdCB3cml0ZSBMaW51eC4gIChB
biBlYXJsaWVyDQogICAgICAgICAgICAgICBwcmFjdGljZSB3YXMgdG8gd3JpdGUgdGhlIHZl
cnNpb24gIG51bWJlciAgb2YgIHRoZQ0KICAgICAgICAgICAgICAga2VybmVsICBmcm9tIHdo
aWNoIHRoZSBtYW51YWwgcGFnZSB3YXMgYmVpbmcgd3JpdOKAkA0KICAgICAgICAgICAgICAg
dGVuL2NoZWNrZWQuICBIb3dldmVyLCB0aGlzIHdhcyBuZXZlciBkb25lIGNvbnNpc+KAkA0K
ICAgICAgICAgICAgICAgdGVudGx5LCBhbmQgc28gd2FzIHByb2JhYmx5IHdvcnNlICB0aGFu
ICBpbmNsdWRpbmcNCiAgICAgICAgICAgICAgIG5vICB2ZXJzaW9uIG51bWJlci4gIEhlbmNl
Zm9ydGgsIGF2b2lkIGluY2x1ZGluZyBhDQogICAgICAgICAgICAgICB2ZXJzaW9uIG51bWJl
ci4pDQoNCiAgICAgICAgICAgICAgIEZvciBsaWJyYXJ5IGNhbGxzIHRoYXQgYXJlIHBhcnQg
b2YgZ2xpYmMgb3Igb25lIG9mDQogICAgICAgICAgICAgICB0aGUgb3RoZXIgY29tbW9uIEdO
VSBsaWJyYXJpZXMsIGp1c3QgdXNlIEdOVSBDIExp4oCQDQogICAgICAgICAgICAgICBicmFy
eSwgR05VLCBvciBhbiBlbXB0eSBzdHJpbmcuDQoNCiAgICAgICAgICAgICAgIEZvciBTZWN0
aW9uIDQgcGFnZXMsIHVzZSBMaW51eC4NCg0KICAgICAgICAgICAgICAgSW4gY2FzZXMgb2Yg
ZG91YnQsIGp1c3Qgd3JpdGUgTGludXgsIG9yIEdOVS4NCg0KICAgICAgICBbLi4uXQ0KXQ0K
DQpTbywganVzdCBzYXlpbmcgJzpWZXJzaW9uOiBMaW51eCcgd291bGQgYmUgZmluZS4NCg0K
PiANCj4gVGhpcmQ6IFRoZSBkYXRlIHNob3VsZCBvZiBjb3Vyc2UgYmUgdXBkYXRlZCB3aGVu
IGdlbmVyYXRpbmcgdGhlIHBhZ2UuIEkNCj4gZm91bmQgdGhhdCByc3QybWFuIGhhcyBhICIt
LWRhdGUiIG9wdGlvbiwgYnV0IGl0IGRvZXMgbm90IGluc2VydCBpdCBhdA0KPiB0aGUgbG9j
YXRpb24gd2Ugd2FudC4gSW5zdGVhZCwgaXQgd291bGQgcHJvYmFibHkgYmUgYSBtYXR0ZXIg
b2YgYWRkaW5nIGENCj4gc2VkIGNvbW1hbmQgdG8gdGhlIHBpcGVsaW5lLCBzb21ldGhpbmcg
YWxvbmc6DQo+IA0KPiAgICAgICQgLi9zY3JpcHRzL2JwZl9kb2NzLnB5IGhlbHBlcnMgfCBc
DQo+ICAgICAgICAgIHNlZCAtZSAicy9fX0RBVEVfXy8kKGRhdGUgLUkpLyIgfCBcDQo+ICAg
ICAgICAgIHJzdDJtYW4gfCBtYW4gLWwgLQ0KDQpUaGUgZGF0ZSwgeWVhaCwgSSBjYW4gYWRk
IGl0IHRvIHRoZSBwaXBlbGluZS4NCkJUVywgSSByZXBvcnRlZCBhIGJ1ZyB0byByc3QybWFu
IChJIENDZCB5b3UsIHNvIHlvdSBwcm9iYWJseSBhbHJlYWR5IA0Ka25vdyA6KSkuDQoNCj4g
DQo+IElmIGl0IGxvb2tzIGJldHRlciBmb3IgdGhlIG1hbi1wYWdlcyByZXBvLCBJIGNhbiBz
ZW5kIGEgcGF0Y2ggZm9yIHRoZQ0KPiBtYW4tcGFnZSB0ZW1wbGF0ZSBpbiBicGZfZG9jcy5w
eSB0byBzZXQgIjpNYW51YWwgZ3JvdXA6IiBhbmQNCj4gIjpWZXJzaW9uOiIuIEkgY2FuIGFs
c28gYXNrIG9uIHRoZSBkb2N1dGlscyBtYWlsaW5nIGxpc3QgaWYgdGhlcmUgaXMgYQ0KPiBj
bGVhbmVyIHdheSB0byBwcm9jZWVkLCB3aXRob3V0IGZhbGxpbmcgYmFjayB0byB0aGlzICI6
VmVyc2lvbjoiIGZpZWxkLg0KDQpZZWFoLCBwbGVhc2UgcGF0Y2ggOk1hbnVhbCBncm91cDou
ICBBbHNvIHBhdGNoIDpWZXJzaW9uOiAoSSB0aGluayB3ZSBjYW4gDQpsaXZlIHdpdGggaXQp
LCBhbHRob3VnaCBvZiBjb3Vyc2UgZmVlbCBmcmVlIHRvIGFzayBhYm91dCBiZXR0ZXIgDQph
bHRlcm5hdGl2ZXMgdG8gaXQuDQoNCkJ1dCBkb24ndCBwYXRjaCA6RGF0ZTogeWV0LiAgTGV0
J3Mgc2VlIHdoYXQgdGhleSBhbnN3ZXIgdG8gdGhlIGJ1ZyANCnJlcG9ydC4gIChBbmQgaWYg
eW91IHdhbnQsIHlvdSBjYW4gd2FpdCBmb3IgdGhlIGJ1ZyByZXBvcnQgdG8gcmVzb2x2ZSB0
byANCnBhdGNoIGV2ZXJ5dGhpbmcgYXQgb25jZSwgb2YgY291cnNlLikNCg0KQ2hlZXJzLA0K
DQpBbGV4DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IFF1ZW50aW4NCj4gDQo+IFswXQ0KPiBodHRw
czovL3JlcG8ub3IuY3ovZG9jdXRpbHMuZ2l0L2Jsb2IvZjAzMTE2NzU3OWJkYmUzMDc4MWVh
NTFkNTE2ZDE0ZGIyY2I1ZjYwZTovZG9jdXRpbHMvd3JpdGVycy9tYW5wYWdlLnB5I2wzNzcN
Cj4gWzFdIGh0dHBzOi8vZG9jdXRpbHMuc291cmNlZm9yZ2UuaW8vZG9jcy91c2VyL21hbnBh
Z2UuaHRtbA0KDQotLSANCkFsZWphbmRybyBDb2xvbWFyDQo8aHR0cDovL3d3dy5hbGVqYW5k
cm8tY29sb21hci5lcy8+DQo=

--------------vLkCk1pKOxmoDEtdSlGdcmo2--

--------------p8602nCovnVpsftt4boqk97j
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmLpA5sACgkQnowa+77/
2zKXSQ//XdwDAQ6ud95Be8r1H45CtHf4ivoHYqtFhM+FoY8lSoNlLQ9ksDi/vLL8
ba9XPBNHprCKZpiLfz7a0WL3oKIh5znDr9aZ49c1JPf3ok7QEk4HP94aGNMoJFn+
e8v/mZGg/aEn8RZZhYsphpyXnAaqLs78SWZmL/EUhXaFfjFpnSMIsTsjgK1iSmL0
gVyIE2Zq23TeF+/dzKrhS7TfX/wbeRcs+Ga3b3G64NoZH5O1PSVLNe2IxZ39dqgZ
R57Y1kLt0I7vMBMsK2OF4v11CbPsjPwfO/LpiubNwReUC7frEKRS0UfdHVSsDq7r
XxlV8CZWLzPGEYXJS8DDMGWxIPeoNk+3GU27/MtfL0U/21bnyW+ZMYWEcApMK5dU
+afpeoWz9v3/vc0eZ+n5DXl8ai1XN2cIEc08gWtYglGpPPt242vQMY2O70oCW2jp
cfBhVZUMMFSAmvilHKXvyP4f8BCjgREe1guRYFlEzOHRmPp0RhheYDwjEFLXNYVw
ish4vYhczETQaVUz128VSMqG7kv5zZM9VXg/Jr8RaisGhsSH7fG2lrAQLlDzlj0m
0byEenPVVzCI+wJsyPd2aZTe9RT0guuAfK3VjcHUBGWwBtDOzEGtnBaUgU8/EZo/
lWLAxtBDeqdgCyE6fjC6k8fgGmst4dcN9ZeQmYW9eW/8KuhUWUI=
=nC8W
-----END PGP SIGNATURE-----

--------------p8602nCovnVpsftt4boqk97j--
