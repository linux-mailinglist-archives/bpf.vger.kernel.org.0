Return-Path: <bpf+bounces-12382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37C7CBA4A
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 07:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB51281824
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F090C150;
	Tue, 17 Oct 2023 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E0C8C2;
	Tue, 17 Oct 2023 05:45:24 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79247EA;
	Mon, 16 Oct 2023 22:45:20 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39H5iEadD3730461, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39H5iEadD3730461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 13:44:15 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 17 Oct 2023 13:44:13 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 17 Oct 2023 13:44:13 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Tue, 17 Oct 2023 13:44:13 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner
	<lukas@wunner.de>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Tony Luck
	<tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on PCIe Link Down
Thread-Topic: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on
 PCIe Link Down
Thread-Index: AQHZ/+WX29Sx+yjN7keHtkFSV38Z/LBLoV4AgAE/YwCAAJeMcA==
Date: Tue, 17 Oct 2023 05:44:13 +0000
Message-ID: <24f72eea9fba45c4b1cd85836b17f251@realtek.com>
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
 <20231016093210.GA22952@wunner.de>
 <CAAd53p7gbWSkRbng205z2U0_kU42JeFw8qThcBuXuVwCC+Y_VQ@mail.gmail.com>
In-Reply-To: <CAAd53p7gbWSkRbng205z2U0_kU42JeFw8qThcBuXuVwCC+Y_VQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FpLUhlbmcgRmVuZyA8
a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gT24gTW9uLCBPY3QgMTYsIDIwMjMg
YXQgNTozMuKAr1BNIEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPiB3cm90ZToNCj4gPg0K
PiA+IE9uIE1vbiwgT2N0IDE2LCAyMDIzIGF0IDEyOjAxOjMxUE0gKzA4MDAsIEthaS1IZW5nIEZl
bmcgd3JvdGU6DQo+ID4gPiBXaGVuIGluc2VydGluZyBhbiBTRDcuMCBjYXJkIHRvIFJlYWx0ZWsg
Y2FyZCByZWFkZXIsIGl0IGNhbiB0cmlnZ2VyDQo+ID4gPiBQQ0kgc2xvdCBMaW5rIGRvd24gYW5k
IGNhdXNlcyB0aGUgZm9sbG93aW5nIGVycm9yOg0KPiA+DQo+ID4gV2h5IGRvZXMgKmluc2VydGlu
ZyogYSBjYXJkIGNhdXNlIGEgTGluayBEb3duPw0KPiANCj4gUmlja3ksIGRvIHlvdSBrbm93IHRo
ZSByZWFzb24gd2h5IExpbmsgRG93biBoYXBwZW5zPw0KPiANCg0KQmVjYXVzZSBTRDcuMCBjYXJk
IGlzIHVzZSBwY2llLW52bWUgZHJpdmVyLCByZWFkZXIgbmVlZCB0byByZS1saW5rIHRoZW4ganVz
dCBkbyB0aGUgcGNpZSBjaGFubmVsIA0KDQo+ID4NCj4gPg0KPiA+ID4gWyAgIDYzLjg5ODg2MV0g
cGNpZXBvcnQgMDAwMDowMDoxYy4wOiBwY2llaHA6IFNsb3QoOCk6IExpbmsgRG93bg0KPiA+ID4g
WyAgIDYzLjkxMjExOF0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJl
c3M6DQo+IGZmZmZiMjRkNDAzZTUwMTANCj4gPiBbLi4uXQ0KPiA+ID4gWyAgIDYzLjkxMjE5OF0g
ID8gYXNtX2V4Y19wYWdlX2ZhdWx0KzB4MjcvMHgzMA0KPiA+ID4gWyAgIDYzLjkxMjIwM10gID8g
aW9yZWFkMzIrMHgyZS8weDcwDQo+ID4gPiBbICAgNjMuOTEyMjA2XSAgPyBydHN4X3BjaV93cml0
ZV9yZWdpc3RlcisweDViLzB4OTAgW3J0c3hfcGNpXQ0KPiA+ID4gWyAgIDYzLjkxMjIxN10gIHJ0
c3hfc2V0X2wxb2ZmX3N1YisweDFjLzB4MzAgW3J0c3hfcGNpXQ0KPiA+ID4gWyAgIDYzLjkxMjIy
Nl0gIHJ0czUyNjFfc2V0X2wxb2ZmX2NmZ19zdWJfZDArMHgzNi8weDQwIFtydHN4X3BjaV0NCj4g
PiA+IFsgICA2My45MTIyMzRdICBydHN4X3BjaV9ydW50aW1lX2lkbGUrMHhjNy8weDE2MCBbcnRz
eF9wY2ldDQo+ID4gPiBbICAgNjMuOTEyMjQzXSAgPyBfX3BmeF9wY2lfcG1fcnVudGltZV9pZGxl
KzB4MTAvMHgxMA0KPiA+ID4gWyAgIDYzLjkxMjI0Nl0gIHBjaV9wbV9ydW50aW1lX2lkbGUrMHgz
NC8weDcwDQo+ID4gPiBbICAgNjMuOTEyMjQ4XSAgcnBtX2lkbGUrMHhjNC8weDJiMA0KPiA+ID4g
WyAgIDYzLjkxMjI1MV0gIHBtX3J1bnRpbWVfd29yaysweDkzLzB4YzANCj4gPiA+IFsgICA2My45
MTIyNTRdICBwcm9jZXNzX29uZV93b3JrKzB4MjFhLzB4NDMwDQo+ID4gPiBbICAgNjMuOTEyMjU4
XSAgd29ya2VyX3RocmVhZCsweDRhLzB4M2MwDQo+ID4NCj4gPiBUaGlzIGxvb2tzIGxpa2UgcGNy
LT5yZW1hcF9hZGRyIGlzIGFjY2Vzc2VkIGFmdGVyIGl0IGhhcyBiZWVuDQo+ID4gaW91bm1hcCdl
ZCBpbiBydHN4X3BjaV9yZW1vdmUoKSBvciBiZWZvcmUgaXQgaGFzIGJlZW4gaW9tYXAnZWQgaW4N
Cj4gcnRzeF9wY2lfcHJvYmUoKS4NCj4gPg0KPiA+IElzIHRoZSBjYXJkIHJlYWRlciBpdHNlbGYg
bG9jYXRlZCBiZWxvdyBhIGhvdHBsdWcgcG9ydCBhbmQgdW5wbHVnZ2VkIGhlcmU/DQo+ID4gT3Ig
aXMgdGhpcyBhYm91dCB0aGUgY2FyZCBiZWluZyByZW1vdmVkIGZyb20gdGhlIGNhcmQgcmVhZGVy
Pw0KPiA+DQo+ID4gSGF2aW5nIGZ1bGwgZG1lc2cgb3V0cHV0IGFuZCBsc3BjaSAtdnZ2IG91dHB1
dCBhdHRhY2hlZCB0byBhIGJ1Z3ppbGxhDQo+ID4gd291bGQgaGVscCB0byB1bmRlcnN0YW5kIHdo
YXQgaXMgZ29pbmcgb24uDQo+IA0KPiBJIGRvbid0IGhhdmUgdGhlIGhhcmR3YXJlIHNvIHdlIG5l
ZWQgUmlja3kgdG8gcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGhlcmUuDQo+IA0KPiBSZWdhcmRs
ZXNzIG9mIHRoZSBjYXJkcmVhZGVyIGlzc3VlLCBkbyB5b3UgaGF2ZSBhbnkgY29uY2VybiBvbiB0
aGUgcGF0Y2gNCj4gaXRzZWxmPw0KPiANCj4gS2FpLUhlbmcNCj4gDQo+ID4NCj4gPiBUaGFua3Ms
DQo+ID4NCj4gPiBMdWthcw0K

