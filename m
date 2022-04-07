Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C804F72CA
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 05:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiDGDR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiDGDR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 23:17:57 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 945BE56209
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 20:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=jr2Gc4lQGC3o6bDsODsszGVRcYBK8WjtHXZd
        shI4myg=; b=PwsumTp4KgyE/CWkCt8rW+dJInNHAILMaacPJw1oHLOkue4XUd5I
        Prjra0qg6FpIWjAPvLyJYvC1uKDhqhsoy2YsslJKxKK3KYciHpJizoNL+2/HLapf
        3TnM/8vK+R5dZWrzZtaxDsGCkOkOtW2kbTf1ChBfTPzsD8v0eSLSAN8=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Thu, 7 Apr
 2022 11:15:52 +0800 (GMT+08:00)
X-Originating-IP: [47.88.5.130]
Date:   Thu, 7 Apr 2022 11:15:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzongyo@mail.ustc.edu.cn
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc:     bpf@vger.kernel.org
Subject: Re: Re: [Question] Failed to load ebpf program with BTF-defined map
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20210401(c5ff3689) Copyright (c) 2002-2022 www.mailtech.cn ustccn
In-Reply-To: <87czhtc3ef.fsf@toke.dk>
References: <50b0dbb.2936.17fff506075.Coremail.wuzongyo@mail.ustc.edu.cn>
 <87czhtc3ef.fsf@toke.dk>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6dd42c62.3713.180020571c3.Coremail.wuzongyo@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygD3MnxpV05iKVgHAA--.7W
X-CM-SenderInfo: pzx200xj1rqzxdloh3xvwfhvlgxou0/1tbiAQwICVQhoFZrBAAHsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQo+IHd1em9uZ3lvQG1haWwudXN0Yy5lZHUuY24gd3JpdGVzOg0KPiANCj4gPiBIaSwNCj4gPg0K
PiA+IEkgd3JvdGUgYSBzaW1wbGUgdGMtYnBmIHByb2dyYW0gbGlrZSB0aGF0Og0KPiA+DQo+ID4g
ICAgICNpbmNsdWRlIDxsaW51eC9icGYuaD4NCj4gPiAgICAgI2luY2x1ZGUgPGxpbnV4L3BrdF9j
bHMuaD4NCj4gPiAgICAgI2luY2x1ZGUgPGxpbngvdHlwZXMuaD4NCj4gPiAgICAgI2luY2x1ZGUg
PGJwZi9icGZfaGVscGVycy5oPg0KPiA+DQo+ID4gICAgIHN0cnVjdCB7DQo+ID4gICAgICAgICBf
X3VpbnQodHlwZSwgQlBGX01BUF9UWVBFX0hBU0gpOw0KPiA+ICAgICAgICAgX191aW50KG1heF9l
bnRyaWVzLCAxKTsNCj4gPiAgICAgICAgIF9fdHlwZShrZXksIGludCk7DQo+ID4gICAgICAgICBf
X3R5cGUodmFsdWUsIGludCk7DQo+ID4gICAgIH0gaG1hcCBTRUMoIi5tYXBzIik7DQo+ID4NCj4g
PiAgICAgU0VDKCJjbGFzc2lmaWVyIikNCj4gPiAgICAgaW50IF9jbGFzc2lmaWVyKHN0cnVjdCBf
X3NrX2J1ZmYgKnNrYikNCj4gPiAgICAgew0KPiA+ICAgICAgICAgaW50IGtleSA9IDA7DQo+ID4g
ICAgICAgICBpbnQgKnZhbDsNCj4gPg0KPiA+ICAgICAgICAgdmFsID0gYnBmX21hcF9sb29rdXBf
ZWxlbSgmaG1hcCwgJmtleSk7DQo+ID4gICAgICAgICBpZiAoIXZhbCkNCj4gPiAgICAgICAgICAg
ICByZXR1cm4gVENfQUNUX09LOw0KPiA+ICAgICAgICAgcmV0dXJuIFRDX0FDVF9PSzsNCj4gPiAg
ICAgfQ0KPiA+DQo+ID4gICAgIGNoYXIgX19saWNlbnNlW10gU0VDKCJsaWNlbnNlIikgPSAiR1BM
IjsNCj4gPg0KPiA+IFRoZW4gSSB0cmllZCB0byB1c2UgdGMgdG8gbG9hZCB0aGUgcHJvZ3JhbToN
Cj4gPiAgICAgDQo+ID4gICAgIHRjIHFkaXNjIGFkZCBkZXYgZXRoMCBjbHNhY3QNCj4gPiAgICAg
dGMgZmlsdGVyIGFkZCBkZXYgZXRoMCBlZ3Jlc3MgYnBmIGRhIG9iaiB0ZXN0X2JwZi5vDQo+ID4N
Cj4gPiBCdXQgdGhlIHByb2dyYW0gbG9hZGluZyBmYWlsZWQgd2l0aCBlcnJvciBtZXNzYWdlczoN
Cj4gPiAgICAgUHJvZyBzZWN0aW9uICdjbGFzc2lmaWVyJyByZWplY3RlZDogUGVybWlzc2lvbiBk
ZW5pZWQgKDEzKSENCj4gPiAgICAgLSBUeXBlOiAgICAgICAgICAzDQo+ID4gICAgIC0gSW5zdHJ1
Y3Rpb25zOiAgOSAoMCBvdmVyIGxpbWl0DQo+ID4gICAgIC0gTGljZW5zZTogICAgICAgR1BMDQo+
ID4NCj4gPiAgICAgVmVyaWZpZXIgYW5hbHlzaXM6DQo+ID4NCj4gPiAgICAgRXJyb3IgZmV0Y2hp
bmcgcHJvZ3JhbS9tYXAhDQo+ID4gICAgIFVuYWJsZSB0byBsb2FkIHByb2dyYW0NCj4gPg0KPiA+
IEkgdHJpZWQgdG8gcmVwbGFjZSB0aGUgbWFwIGRlZmluaXRpb24gd2l0aCB0aGUgZm9sbG93aW5n
IGNvZGUgYW5kIHRoZSBwcm9ncmFtIGlzIGxvYWRlZCBzdWNjZXNzZnVsbHkhDQo+ID4NCj4gPiAg
ICAgc3RydWN0IGJwZl9tYXBfZGVmIFNFQygibWFwcyIpIGhtYXAgPSB7DQo+ID4gICAgICAgICAu
dHlwZSA9IEJQRl9NQVBfVFlQRV9IQVNILA0KPiA+ICAgICAgICAgLmtleV9zaXplID0gc2l6ZW9m
KGludCksDQo+ID4gICAgICAgICAudmFsdWVfc2l6ZSA9IHNpemVvZihpbnQpLA0KPiA+ICAgICAg
ICAgLm1heF9lbnRyaWVzID0gMSwNCj4gPiAgICAgfTsNCj4gPg0KPiA+IFdpdGggYnBmdHJhY2Us
IEkgY2FuIGZpbmQgdGhhdCB0aGUgZXJybm8gLUVBQ0NFUyBpcyByZXR1cm5lZCBieSBmdW5jdGlv
biBkb19jaGVjaygpLiBCdXQgSSBhbSBzdGlsbCBjb25mdXNlZCB3aGF0J3Mgd3Jvbmcgd2l0aCBp
dC4NCj4gPg0KPiA+IExpbnV4IFZlcnNpb246IDUuMTcuMC1yYzMrIHdpdGggQ09ORklHX0RFQlVH
X0lORk9fQlRGPXkNCj4gPiBUQyBWZXJzaW9uOiA1LjE0LjANCj4gPg0KPiA+IEFueSBzdWdnZXN0
aW9uIHdpbGwgYmUgYXBwcmVjaWF0ZWQhDQo+IA0KPiBJZiB0aGUgbGF0dGVyIHdvcmtzIGJ1dCB0
aGUgZm9ybWVyIGRvZXNuJ3QsIG15IGd1ZXNzIHdvdWxkIGJlIHRoYXQNCj4gaXByb3V0ZTIgaXMg
Y29tcGlsZWQgd2l0aG91dCBsaWJicGYgc3VwcG9ydCAoaW4gd2hpY2ggY2FzZSBpdCB3b3VsZCBu
b3QNCj4gc3VwcG9ydCBCVEYtZGVmaW5lZCBtYXBzIGVpdGhlcikuIElmIGl0IGRvZXMgaGF2ZSBs
aWJicGYgc3VwcG9ydCwgdGhhdA0KPiAoYW5kIHRoZSB2ZXJzaW9uIG9mIGxpYmJwZiB1c2VkKSB3
aWxsIGJlIGluY2x1ZGVkIGluIHRoZSBvdXRwdXQgb2YgYHRjDQo+IC12YC4NCj4gDQo+IFlvdSBj
b3VsZCByZWNvbXBpbGUgaXByb3V0ZTIgd2l0aCBlbmFibGUgbGliYnBmIHN1cHBvcnQgZW5hYmxl
ZCwgb3IgYXMNCj4gQW5kcmlpIHN1Z2dlc3RzIHlvdSBjYW4gd3JpdGUgeW91ciBvd24gbG9hZGVy
IHVzaW5nIGxpYmJwZi4uLg0KPiANCg0KSXQgd29ya3Mgd2l0aCByZWNvbXBpbGVkLWlwcm91dGUy
LiBUaGFua3MgdmVyeSBtdWNoIQ0KDQo+IC1Ub2tlDQoNCg0KLS0NClBCMTIwMTEwODMg6YKs5a6X
5YuHDQo=
