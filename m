Return-Path: <bpf+bounces-34824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5322C931495
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C371C213C9
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819418C335;
	Mon, 15 Jul 2024 12:42:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37C18C320
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047379; cv=none; b=lUXP1jHhNqukbc5osP2ZyABIKtEN1kzdfCn39Pzj+Z/V4FENkdKuQFsF55tYFJfSePC9mx27sDda7pMkziPaRNmS4z78skqIVMTumikKx0dg7qpgOyE6/bNe3VRw42Xjk1D67qoOt3BK+vl49h7VISoFv7mwneKSp62lQw68G3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047379; c=relaxed/simple;
	bh=aPxbU1CRqN/ObjOco6L+kuqqgrjuH5Lv+0eg1N876o4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JnFMwAchJ1DGDvirkarQqxnpsyBm98y4eMlWwkBAgxYCL0r4EpIu1Ad1j+QfxJgMERzo4FSh6IWGA2Uj2KAashMUMfqV76rEd92JcZVjcaYKrQNdHor4H1WmrgjruLh/hYwEvWWIJluVwI1R1F5jbbmpD63VnmsTZNY0gAssmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-4-SUXMSojjO4CMOodAlWhuTQ-1; Mon, 15 Jul 2024 13:42:55 +0100
X-MC-Unique: SUXMSojjO4CMOodAlWhuTQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 15 Jul
 2024 13:42:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 15 Jul 2024 13:42:08 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicholas Piggin' <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Masahiro Yamada <masahiroy@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Vishal Chourasia <vishalc@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>, Hari Bathini
	<hbathini@linux.ibm.com>, "Masami Hiramatsu" <mhiramat@kernel.org>
Subject: RE: [RFC PATCH v4 12/17] powerpc64/ftrace: Move ftrace sequence out
 of line
Thread-Topic: [RFC PATCH v4 12/17] powerpc64/ftrace: Move ftrace sequence out
 of line
Thread-Index: AQHa1pCD4cP620l/NEOwGIoX3oyFIrH3uX7Q
Date: Mon, 15 Jul 2024 12:42:08 +0000
Message-ID: <e7e31eaa04234dddaac660a38adedee4@AcuMS.aculab.com>
References: <cover.1720942106.git.naveen@kernel.org>
 <9cf2cdddba74ec167ae1af5ec189bba8f704fb51.1720942106.git.naveen@kernel.org>
 <D2PYW90LRVAY.3PCE9P3NE2NEB@gmail.com>
In-Reply-To: <D2PYW90LRVAY.3PCE9P3NE2NEB@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
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

RnJvbTogTmljaG9sYXMgUGlnZ2luDQo+IFNlbnQ6IDE1IEp1bHkgMjAyNCAwOToyNQ0KPiANCj4g
T24gU3VuIEp1bCAxNCwgMjAyNCBhdCA2OjI3IFBNIEFFU1QsIE5hdmVlbiBOIFJhbyB3cm90ZToN
Cj4gPiBGdW5jdGlvbiBwcm9maWxlIHNlcXVlbmNlIG9uIHBvd2VycGMgaW5jbHVkZXMgdHdvIGlu
c3RydWN0aW9ucyBhdCB0aGUNCj4gPiBiZWdpbm5pbmcgb2YgZWFjaCBmdW5jdGlvbjoNCj4gPiAJ
bWZscglyMA0KPiA+IAlibAlmdHJhY2VfY2FsbGVyDQo+ID4NCj4gPiBUaGUgY2FsbCB0byBmdHJh
Y2VfY2FsbGVyKCkgZ2V0cyBub3AnZWQgb3V0IGR1cmluZyBrZXJuZWwgYm9vdCBhbmQgaXMNCj4g
PiBwYXRjaGVkIGluIHdoZW4gZnRyYWNlIGlzIGVuYWJsZWQuDQo+ID4NCj4gPiBHaXZlbiB0aGUg
c2VxdWVuY2UsIHdlIGNhbm5vdCByZXR1cm4gZnJvbSBmdHJhY2VfY2FsbGVyIHdpdGggJ2Jscicg
YXMgd2UNCj4gPiBuZWVkIHRvIGtlZXAgTFIgYW5kIHIwIGludGFjdC4gVGhpcyByZXN1bHRzIGlu
IGxpbmsgc3RhY2sgKHJldHVybg0KPiA+IGFkZHJlc3MgcHJlZGljdG9yKSBpbWJhbGFuY2Ugd2hl
biBmdHJhY2UgaXMgZW5hYmxlZC4gVG8gYWRkcmVzcyB0aGF0LCB3ZQ0KPiA+IHdvdWxkIGxpa2Ug
dG8gdXNlIGEgdGhyZWUgaW5zdHJ1Y3Rpb24gc2VxdWVuY2U6DQo+ID4gCW1mbHIJcjANCj4gPiAJ
YmwJZnRyYWNlX2NhbGxlcg0KPiA+IAltdGxyCXIwDQo+ID4NCj4gPiBGdXJ0aGVyIG1vcmUsIHRv
IHN1cHBvcnQgRFlOQU1JQ19GVFJBQ0VfV0lUSF9DQUxMX09QUywgd2UgbmVlZCB0bw0KPiA+IHJl
c2VydmUgdHdvIGluc3RydWN0aW9uIHNsb3RzIGJlZm9yZSB0aGUgZnVuY3Rpb24uIFRoaXMgcmVz
dWx0cyBpbiBhDQo+ID4gdG90YWwgb2YgZml2ZSBpbnN0cnVjdGlvbiBzbG90cyB0byBiZSByZXNl
cnZlZCBmb3IgZnRyYWNlIHVzZSBvbiBlYWNoDQo+ID4gZnVuY3Rpb24gdGhhdCBpcyB0cmFjZWQu
DQo+ID4NCj4gPiBNb3ZlIHRoZSBmdW5jdGlvbiBwcm9maWxlIHNlcXVlbmNlIG91dC1vZi1saW5l
IHRvIG1pbmltaXplIGl0cyBpbXBhY3QuDQo+ID4gVG8gZG8gdGhpcywgd2UgcmVzZXJ2ZSBhIHNp
bmdsZSBub3AgYXQgZnVuY3Rpb24gZW50cnkgdXNpbmcNCj4gPiAtZnBhdGNoYWJsZS1mdW5jdGlv
bi1lbnRyeT0xIGFuZCBhZGQgYSBwYXNzIG9uIHZtbGludXgubyB0byBkZXRlcm1pbmUNCj4gPiB0
aGUgdG90YWwgbnVtYmVyIG9mIGZ1bmN0aW9ucyB0aGF0IGNhbiBiZSB0cmFjZWQuIFRoaXMgaXMg
dGhlbiB1c2VkIHRvDQo+ID4gZ2VuZXJhdGUgYSAuUyBmaWxlIHJlc2VydmluZyB0aGUgYXBwcm9w
cmlhdGUgYW1vdW50IG9mIHNwYWNlIGZvciB1c2UgYXMNCj4gPiBmdHJhY2Ugc3R1YnMsIHdoaWNo
IGlzIGJ1aWx0IGFuZCBsaW5rZWQgaW50byB2bWxpbnV4Lg0KPiANCj4gVGhlc2UgYXJlIGFsbCBn
b2luZyBpbnRvIC50cmFtcC5mdHJhY2UudGV4dCBBRkFJS1M/IFNob3VsZCB0aGF0IGJlDQo+IG1v
dmVkIGFmdGVyIHNvbWUgb2YgdGhlIG90aGVyIHRleHQgaW4gdGhlIGxpbmtlciBzY3JpcHQgdGhl
biBpZiBpdA0KPiBjb3VsZCBnZXQgcXVpdGUgbGFyZ2U/IHNjaGVkIGFuZCBsb2NrIGFuZCBvdGhl
ciB0aGluZ3Mgc2hvdWxkIGJlDQo+IGNsb3NlciB0byB0aGUgcmVzdCBvZiB0ZXh0IGFuZCBob3Qg
Y29kZS4NCg0KQ2FuJ3QgeW91IGFsbG9jYXRlIHRoZSBzcGFjZSBmb3IgdGhlICdmdW5jdGlvbiBw
cm9maWxlIHNlcXVlbmNlJw0KYXQgcnVuLXRpbWUgd2hlbiAoaWYpIGZ0cmFjZSBpcyBlbmFibGVk
Pw0KV2hlbiBmdHJhY2UgZ2V0cyBkaXNhYmxlZCBpdCBpcyBsaWtlbHkgcG9zc2libGUgdG8gc2F2
ZSB0aGUgdHJhbXBvbGluZQ0KbnVtYmVyIGluIHRoZSBub3AgLSBzbyB0aGUgc2FtZSBtZW1vcnkg
Y2FuIGJlIHVzZWQgbmV4dCB0aW1lLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


