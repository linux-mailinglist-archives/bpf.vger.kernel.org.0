Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7826D6CC8EF
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjC1RPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC1RPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 13:15:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7107AA6
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:15:19 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id a9-20020a170902b58900b0019e2eafafddso7915831pls.7
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680023719;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pBQEV4YUH7Haj6IRDt7ZXQzFb/Lwzc+HNbZTIhASOk=;
        b=RcYuUcC6lut4RRlIzo3rrGz/yJqD4FUFCr4JZDX7ZzMLzNs99zljDyOtY6Fo/E4nOB
         cGNLmHnbnV33/umimB+XRTpYkgxQ/u03JsNpkGH4d9II/EtUjo6166MMY+owRzD4qF8e
         TySR5P4G2NCew7SXkPOkxSSt7MeAk+HKTYdI9XMoW8q4ylW0kl2/SLJdSSsxeAJxn4D6
         IW8kHHKaH4bT9ev3PBxAt/pOkSyUbnM0oqpws8PdbcFuA0xeB1zahn4XMlYHVr3Q3ZY9
         N+LHaKUMOKhCetuFVSvbxhYDJpOgSMnNf29dtYY2Hqym5c6dqndn5858GS8spLsBCoBO
         1NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680023719;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+pBQEV4YUH7Haj6IRDt7ZXQzFb/Lwzc+HNbZTIhASOk=;
        b=uuYhSBbOHqHo+J+0JTEqrnv2eC5LVXXx+zhNOaLyoW8v8QJyAquajVK9J+yofDp9pW
         t95XL+8s7DGtDSL/Qo+qKf37CNezC1a+lgCD6wnGjMkkNBjZ55o6F4L1hHd1pkCQXyEx
         /drgfQMyzVPvp5T4EJxeRi1mBHe+S4Qs9WCB+y6M/GZqqWM5+iTBhuXD3z3BikbgJw/u
         FFF7TySnOe85wv53q1xR2WndT1IvXWdom0qHeiq04D1VtFXjILIrR5yIJz91pisy56TN
         tFGqRwY6bfOXW2nAB8tJZpr57dlHZ/FwxgUG+02sO6Mghn8cryPV06pB6W/6bWKd3J27
         ps6g==
X-Gm-Message-State: AAQBX9f5gfYqIto3hnKrgZrk1PmA9omWabcQOKYE1u6/c1R7J28n6P7p
        A7JO+b0IxVFWbGoIMuWvnbiMjH0=
X-Google-Smtp-Source: AKy350bsqZyZ/Y3M0YYrPdaZCB2hLdoq2PVv5WxgY3qaWkTzVah1qrIHjC5M20WVfRtDq8vEE6+/UHM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:bb8e:b0:23b:3d0b:f165 with SMTP id
 v14-20020a17090abb8e00b0023b3d0bf165mr5156482pjr.5.1680023719200; Tue, 28 Mar
 2023 10:15:19 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:15:17 -0700
In-Reply-To: <CALOAHbBJEXdR4Myk1zrgFDf9UJYu2-3tbjz0ETNvK3WamD5sFg@mail.gmail.com>
Mime-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <ZCHSOxto9DlEzVy9@google.com>
 <CALOAHbBJEXdR4Myk1zrgFDf9UJYu2-3tbjz0ETNvK3WamD5sFg@mail.gmail.com>
Message-ID: <ZCMgpRtT6ywmtALi@google.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
From:   Stanislav Fomichev <sdf@google.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMDMvMjgsIFlhZmFuZyBTaGFvIHdyb3RlOg0KPiBPbiBUdWUsIE1hciAyOCwgMjAyMyBhdCAx
OjI44oCvQU0gU3RhbmlzbGF2IEZvbWljaGV2IDxzZGZAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBPbiAwMy8yNiwgWWFmYW5nIFNoYW8gd3JvdGU6DQo+ID4gPiBDdXJyZW50bHkgb25seSBD
QVBfU1lTX0FETUlOIGNhbiBpdGVyYXRlIEJQRiBvYmplY3QgSURzIGFuZCBjb252ZXJ0ICANCj4g
SURzDQo+ID4gPiB0byBGRHMsIHRoYXQncyBpbnRlbmRlZCBmb3IgQlBGJ3Mgc2VjdXJpdHkgbW9k
ZWxbMV0uIE5vdCBvbmx5IGRvZXMgaXQNCj4gPiA+IHByZXZlbnQgbm9uLXByaXZpbGlkZ2VkIHVz
ZXJzIGZyb20gZ2V0dGluZyBvdGhlciB1c2VycycgYnBmIHByb2dyYW0sICANCj4gYnV0DQo+ID4g
PiBhbHNvIGl0IHByZXZlbnRzIHRoZSB1c2VyIGZyb20gaXRlcmF0aW5nIGhpcyBvd24gYnBmIG9i
amVjdHMuDQo+ID4NCj4gPiA+IEluIGNvbnRhaW5lciBlbnZpcm9ubWVudCwgc29tZSB1c2VycyB3
YW50IHRvIHJ1biBicGYgcHJvZ3JhbXMgaW4gdGhlaXINCj4gPiA+IGNvbnRhaW5lcnMuIFRoZXNl
IHVzZXJzIGNhbiBydW4gdGhlaXIgYnBmIHByb2dyYW1zIHVuZGVyIENBUF9CUEYgYW5kDQo+ID4g
PiBzb21lIG90aGVyIHNwZWNpZmljIENBUHMsIGJ1dCB0aGV5IGNhbid0IGluc3BlY3QgdGhlaXIg
YnBmIHByb2dyYW1zICANCj4gaW4gYQ0KPiA+ID4gZ2VuZXJpYyB3YXkuIEZvciBleGFtcGxlLCB0
aGUgYnBmdG9vbCBjYW4ndCBiZSB1c2VkIGFzIGl0IHJlcXVpcmVzDQo+ID4gPiBDQVBfU1lTX0FE
TUlOLiBUaGF0IGlzIHZlcnkgaW5jb252ZW5pZW50Lg0KPiA+DQo+ID4gPiBXaXRob3V0IENBUF9T
WVNfQURNSU4sIHRoZSBvbmx5IHdheSB0byBnZXQgdGhlIGluZm9ybWF0aW9uIG9mIGEgYnBmICAN
Cj4gb2JqZWN0DQo+ID4gPiB3aGljaCBpcyBub3QgY3JlYXRlZCBieSB0aGUgcHJvY2VzcyBpdHNl
bGYgaXMgd2l0aCBTQ01fUklHSFRTLCB0aGF0DQo+ID4gPiByZXF1aXJlcyBlYWNoIHByb2Nlc3Nl
cyB3aGljaCBjcmVhdGVkIGJwZiBvYmplY3QgaGFzIHRvIGltcGxlbWVudCBhICANCj4gdW5peA0K
PiA+ID4gZG9tYWluIHNvY2tldCB0byBzaGFyZSB0aGUgZmQgb2YgYSBicGYgb2JqZWN0IGJldHdl
ZW4gZGlmZmVyZW50DQo+ID4gPiBwcm9jZXNzZXMsIHRoYXQgaXMgcmVhbGx5IHRyaXZpYWwgYW5k
IHRyb3VibGVzb21lLg0KPiA+DQo+ID4gPiBIZW5jZSB3ZSBuZWVkIGEgYmV0dGVyIG1lY2hhbmlz
bSB0byBnZXQgYnBmIG9iamVjdCBpbmZvIHdpdGhvdXQNCj4gPiA+IENBUF9TWVNfQURNSU4uDQo+
ID4NCj4gPiBbLi5dDQo+ID4NCj4gPiA+IEJQRiBuYW1lc3BhY2UgaXMgaW50cm9kdWNlZCBpbiB0
aGlzIHBhdGNoc2V0IHdpdGggYW4gYXR0ZW1wdCB0byByZW1vdmUNCj4gPiA+IHRoZSBDQVBfU1lT
X0FETUlOIHJlcXVpcmVtZW50LiBUaGUgdXNlciBjYW4gY3JlYXRlIGJwZiBtYXAsIHByb2cgYW5k
DQo+ID4gPiBsaW5rIGluIGEgc3BlY2lmaWMgYnBmIG5hbWVzcGFjZSwgdGhlbiB0aGVzZSBicGYg
b2JqZWN0cyB3aWxsIG5vdCBiZQ0KPiA+ID4gdmlzaWJsZSB0byB0aGUgdXNlcnMgaW4gYSBkaWZm
ZXJlbnQgYnBmIG5hbWVzcGFjZS4gQnV0IHRoZXNlIGJwZg0KPiA+ID4gb2JqZWN0cyBhcmUgdmlz
aWJsZSB0byBpdHMgcGFyZW50IGJwZiBuYW1lc3BhY2UsIHNvIHRoZSBzeXMgYWRtaW4gY2FuDQo+
ID4gPiBzdGlsbCBpdGVyYXRlIGFuZCBpbnNwZWN0IHRoZW0uDQo+ID4NCj4gPiBEb2VzIGl0IGVz
c2VudGlhbGx5IG1lYW4gdW5wcml2IGJwZj8NCg0KPiBSaWdodC4gV2l0aCBDQVBfQlBGIGFuZCBz
b21lIG90aGVyIENBUHMgZW5hYmxlZC4NCg0KPiA+IENhbiBJLCBhcyBhIG5vbi1yb290LCBjcmVh
dGUNCj4gPiBhIG5ldyBicGYgbmFtZXNwYWNlIGFuZCBzdGFydCBsb2FkaW5nL2F0dGFjaGluZyBw
cm9ncz8NCg0KPiBObywgeW91IGNhbid0IGNyZWF0ZSBhIG5ldyBicGYgbmFtZXNwYWNlIGFzIGEg
bm9uLXJvb3QsIHNlZSBhbHNvDQo+IGNvcHlfbmFtZXNwYWNlcygpLg0KPiBJbiB0aGUgY29udGFp
bmVyIGVudmlyb25tZW50LCBuZXcgbmFtZXNwYWNlcyBhcmUgYWx3YXlzIGNyZWF0ZWQgYnkNCj4g
Y29udGFpbmVyZWQsIHdoaWNoIGlzIHN0YXJ0ZWQgYnkgcm9vdC4NCg0KQXJlIHlvdSB0YWxraW5n
IGFib3V0ICJpZiAoIW5zX2NhcGFibGUodXNlcl9ucywgQ0FQX1NZU19BRE1JTikpIiBwYXJ0DQpm
cm9tIGNvcHlfbmFtZXNwYWNlcz8gSXNuJ3QgaXQgdHJpdmlhbGx5IGJ5cGFzc2VkIHdpdGggYSBu
ZXcgdXNlcg0KbmFtZXNwYWNlPw0KDQpJSVVDLCBJIGNhbiBjcmVhdGUgYSBuZXcgdXNlciBuYW1l
c3BhY2Ugd2hpY2ggZ2l2ZXMgbWUgQ0FQX1NZU19BRE1JTg0KaW4gdGhpcyBwYXJ0aWN1bGFyIHVz
ZXItbnMuIFRoZW4gSSBjYW4gZ28gb24gYW5kIGNyZWF0ZSBhIG5ldyBicGYNCm5hbWVzcGFjZSAo
d2l0aCBDQVBfQlBGKSBhbmQgZ28gd2lsZD8gSSB3b24ndCBzZWUgYW55dGhpbmcgZnJvbSB0aGUN
Cm90aGVyIG5hbWVzcGFjZXMsIGJ1dCBJJ2xsIGJlIGFibGUgdG8gbG9hZC9hdHRhY2ggYnBmIHBy
b2dyYW1zPw0KDQo+ID4gTWF5YmUgYWRkIGEgcGFyYWdyYXBoIGFib3V0IG5vdyB2cyB3aGF0ZXZl
ciB5b3UncmUgcHJvcG9zaW5nLg0KDQo+IFdoYXQgSSdtIHByb3Bvc2luZyBpbiB0aGlzIHBhdGNo
c2V0IGlzIHRvIHB1dCBicGYgb2JqZWN0cyAobWFwLCBwcm9nLA0KPiBsaW5rLCBhbmQgYnRmKSBp
bnRvIHRoZSBicGYgbmFtZXNwYWNlLiBOZXh0IHN0ZXAgSSB3aWxsIHB1dCBicGZmcyBpbnRvDQo+
IHRoZSBicGYgbmFtZXNwYWNlIGFzIHdlbGwuDQo+IFRoYXQgc2FpZCwgSSdtIHRyeWluZyB0byBw
dXQgIGFsbCB0aGUgb2JqZWN0cyBjcmVhdGVkIGluIGJwZiBpbnRvIHRoZQ0KPiBicGYgbmFtZXNw
YWNlLiBCZWxvdyBpcyBhIHNpbXBsZSBwYXJhZ3JhcGggdG8gaWxsdXN0cmF0ZSBpdC4NCg0KPiBS
ZWdhcmRpbmcgdGhlIHVucHJpdiB1c2VyIHdpdGggQ0FQX0JQRiBlbmFibGVkLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5v
dyB8IEZ1dHVyZQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gSXRlcmF0ZSBoaXMgQlBGIElEcyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBOICAgfCAgWSAgfA0KPiBJdGVyYXRlIG90aGVy
cycgQlBGIElEcyAgICAgICAgICAgICAgICAgICAgICAgICAgfCBOICAgfCAgTiAgfA0KPiBDb252
ZXJ0IGhpcyBCUEYgSURzIHRvIEZEcyAgICAgICAgICAgICAgICAgIHwgTiAgIHwgIFkgIHwNCj4g
Q29udmVydCBvdGhlcnMnIEJQRiBJRHMgdG8gRkRzICAgICAgICAgICAgfCBOICAgfCAgTiAgfA0K
PiBHZXQgb3RoZXJzJyBvYmplY3QgaW5mbyBmcm9tIHBpbm5lZCBmaWxlICB8IFkoKikgfCBOICB8
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQo+ICgqKSBJdCBjYW4gYmUgaW1wcm92ZWQgYnksDQo+ICAg
ICAgIDEpLiBEaWZmZXJlbnQgY29udGFpbmVycyBoYXMgZGlmZmVyZW50IGJwZmZzDQo+ICAgICAg
IDIpLiBTZXR0aW5nIGZpbGUgcGVybWlzc2lvbg0KPiAgICAgICBUaGF0J3Mgbm90IHBlcmZlY3Qs
IGZvciBleGFtcGxlLCBpZiBvbmUgc2luZ2xlIHVzZXIgaGFzIHR3byBicGYNCj4gaW5zdGFuY2Vz
LCBidXQgd2UgZG9uJ3Qgd2FudCB0aGVtIHRvIGluc3BlY3QgZWFjaCBvdGhlci4NCg0KSSB0aGlu
ayB0aGUgcXVlc3Rpb24gaGVyZSBpcyB3aGF0IGhhcHBlbnMgdG8gdGhlIGV4aXN0aW5nDQpjYXBh
YmxlKENBUF9CUEYpIGNoZWNrcz8gRG8gdGhleSBiZWNvbWUgbnNfY2FwYWJsZShDQVBfQlBGKSBl
dmVudHVhbGx5Pw0KDQpBbmQgaWYgbm90LCBJIGRvbid0IHRoaW5rIGl0IGludGVncmF0ZXMgd2Vs
bCB3aXRoIHRoZSB1c2VyIG5hbWVzcGFjZXM/DQoNCj4gPiBPdGhlcndpc2UgaXQncyBub3QgdmVy
eSBjbGVhciB3aGF0J3MgdGhlIHNlY3VyaXR5IHN0b3J5Lg0KPiA+IChoYXZlbid0IGxvb2tlZCBh
dCB0aGUgd2hvbGUgc2VyaWVzLCBzbyBtYXliZSBpdCdzIGFuc3dlcmVkIHNvbWV3aGVyZSAgDQo+
IGVsc2U/KQ0KPiA+DQoNCg0KPiAtLQ0KPiBSZWdhcmRzDQo+IFlhZmFuZw0K
