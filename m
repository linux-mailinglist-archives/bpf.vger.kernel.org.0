Return-Path: <bpf+bounces-11140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D374C7B3BEA
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1D52E283371
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63467289;
	Fri, 29 Sep 2023 21:23:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204E6669B
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 21:23:34 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634A71AB
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:23:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-38-YCbo4tO4NIiBEgJiDZqbnA-1; Fri, 29 Sep 2023 22:23:23 +0100
X-MC-Unique: YCbo4tO4NIiBEgJiDZqbnA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 22:23:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Sep 2023 22:23:22 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'nicolas.dichtel@6wind.com'" <nicolas.dichtel@6wind.com>, "Christian
 Brauner" <brauner@kernel.org>
CC: =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "David
 Ahern" <dsahern@kernel.org>
Subject: RE: Persisting mounts between 'ip netns' invocations
Thread-Topic: Persisting mounts between 'ip netns' invocations
Thread-Index: AQHZ8rnDYrbz/BvJDkOManir+qyr6bAyTkJA
Date: Fri, 29 Sep 2023 21:23:21 +0000
Message-ID: <27868681bf2049a69a8d9a5f42015dc5@AcuMS.aculab.com>
References: <87a5t68zvw.fsf@toke.dk>
 <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>
 <20230928-geldbeschaffung-gekehrt-81ed7fba768d@brauner>
 <87il7ucg5z.fsf@toke.dk> <a68b135f-12ee-3c75-8b12-d039c9036d53@6wind.com>
 <20230929-paket-pechschwarz-a259da786431@brauner>
 <0a70d4fb-b790-cd7f-a0cd-ad38e978b0e9@6wind.com>
In-Reply-To: <0a70d4fb-b790-cd7f-a0cd-ad38e978b0e9@6wind.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogTmljb2xhcyBEaWNodGVsDQo+IFNlbnQ6IDI5IFNlcHRlbWJlciAyMDIzIDEwOjQ2DQo+
IA0KPiBMZSAyOS8wOS8yMDIzIMOgIDExOjI1LCBDaHJpc3RpYW4gQnJhdW5lciBhIMOpY3JpdMKg
Og0KPiA+PiBJIGZlYXIgdGhhdCBjcmVhdGluZyBhIG5ldyBtb3VudCBucyBmb3IgZWFjaCBuZXQg
bnMgd2lsbCBpbnRyb2R1Y2UgbW9yZSBwcm9ibGVtcy4NCj4gPg0KPiA+IE5vdCBzdXJlIGlmIHdl
J3JlIHRhbGtpbmcgcGFzdCBlYWNoIG90aGVyIGJ1dCB0aGF0IGlzIHdoYXQncyBoYXBwZW5pbmcN
Cj4gPiBub3cuIEVhY2ggbmV3IGlwIG5ldG5zIGV4ZWMgaW52b2NhdGlvbiB3aWxsIGFsbG9jYXRl
IGEgX25ld18gbW91bnQNCj4gPiBuYW1lc3BhY2UuIEluIG90aGVyIHdvcmRzLCBpZiB5b3UgaGF2
ZSAzMDAgaXAgbmV0bnMgZXhlYyBjb21tYW5kcw0KPiA+IHJ1bm5pbmcgdGhlbiB0aGVyZSB3aWxs
IGJlIDMwMCBpbmRpdmlkdWFsIG1vdW50IG5hbWVzcGFjZXMgYWN0aXZlLg0KPiA+DQo+ID4gV2hh
dCBJIHRyaWVkIHRvIHNheSBpcyB0aGF0IGlwIG5ldG5zIGV4ZWMgY291bGQgYmUgY2hhbmdlZCB0
bw0KPiA+IF9vcHRpb25hbGx5XyBhbGxvY2F0ZSBhIHByZXBhcmVkIG1vdW50IG5hbWVzcGFjZSB0
aGF0IGlzIHNoYXJlZCBiZXR3ZWVuDQo+ID4gaXAgbmV0bnMgZXhlYyBjb21tYW5kcy4gQW5kIHll
YWgsIHRoYXQgd291bGQgbmVlZCB0byBiZSBhIG5ldyBjb21tYW5kDQo+ID4gbGluZSBhZGRpdGlv
biB0byBpcCBuZXRucyBleGVjLg0KPiANCj4gT2ssIHlvdSB0YWxrZWQgYWJvdXQgY2hhbmdpbmcg
J2lwIG5ldG5zIGV4ZWMnLCBub3QgYWRkaW5nIGFuIG9wdGlvbiwgdGh1cyBJDQo+IHRob3VnaHQg
dGhhdCB5b3Ugc3VnZ2VzdGVkIGFkZGluZyB0aGlzIHVuY29uZGl0aW9uYWxseSA7LSkNCj4gDQo+
IEkgd2FzIGFza2luZyBteXNlbGYgaG93IHRvIHByb3BhZ2F0ZSBtb3VudCBwb2ludHMgYmV0d2Vl
biB0aGUgcGFyZW50IGFuZCAnaXANCj4gbmV0bnMgZXhlYycgKGJvdGggd2F5KSwgYnV0IHRoaXMg
bWF5IGJlIGFub3RoZXIgdXNlIGNhc2UgdGhhbiBUb2tlJ3MgdXNlIGNhc2UuDQoNCkkgaGFkIGEg
ZGlmZmVyZW50IHByb2JsZW0uDQpJIGhhdmUgYSBzeXN0ZW0gd2l0aCB0d28gbmV0d29yayBuYW1l
c3BhY2VzICh0byBzZXBhcmF0ZSBwdWJsaWMgYW5kDQpwcml2YXRlIG5ldHdvcmsgZGF0YSkgYW5k
IHNvbWUgcHJvZ3JhbXMgdGhhdCByZWFsbHkgd2FudCB0byByZWFkDQp0aGUgJy9zeXMvY2xhc3Mv
bmV0JyBub2RlcyBpbiBib3RoIG5hbWVzcGFjZXMgLSBzbyBJJ2QgbGlrZSB0bw0KaGF2ZSB0aGUg
J25hbWVzcGFjZScgY29weSBtb3VudGVkIGF0IHRoZSBzYW1lIHRpbWUgb24gYSBkaWZmZXJlbnQN
Cm1vdW50IHBvaW50Lg0KQnV0IEknbSBub3QgYXQgYWxsIHN1cmUgdGhhdCBpcyBwb3NzaWJsZS4N
CihJdCBpcyBwb3NzaWJsZSB0byBwYXNzIGFuIG9wZW4gZGlyZWN0b3J5IGZkIHRocm91Z2ggJ2lw
IG5ldG5zIGV4ZWMnDQpidXQgdGhhdCBpcyBhbGwgYSBiaXQgY2x1ZGd5LikNCg0KQ2xlYXJpbmcg
YWxsIHRoZSBtb3VudHMgYWxzbyAnbG9zdCcgdGhlIHJvb3Qgb2YgYSBjaHJvb3QgKGlmIG5vdA0K
YW4gYWN0dWFsIG1vdW50IHBvaW50KSBjYXVzaW5nICdwd2QgLVAnIChldGMpIHRvIGdlbmVyYXRl
IHRoZSBmdWxsDQpwYXRoIGluc3RlYWQgb2YgdGhlIGNocm9vdC1yZWxhdGl2ZSBvbmUuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=


