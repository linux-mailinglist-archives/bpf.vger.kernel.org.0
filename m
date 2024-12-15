Return-Path: <bpf+bounces-46997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029329F2397
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 13:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366021885617
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549E176242;
	Sun, 15 Dec 2024 12:07:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72814A617
	for <bpf@vger.kernel.org>; Sun, 15 Dec 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264452; cv=none; b=r4bgc8/E9hITB90clKgsWNAu+fpUxxuV9rh/yD9tm55QnKI1oKlq4keScSp93+PiL++vs6PDGKO1yXEWYvG8jCTTmS0WlNuJCUMunm9JzxIZ5jVufir9rm2CmQ/xgqhmkzPXRDJ6I02BqqKd4d2YQVN1nhs+MXKyI+01hTbirO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264452; c=relaxed/simple;
	bh=dPFPe2LWxppPuf31HNvD4X7T3AwcO+hBkc6QWS0r3fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hKLLcQsW0SGFIQGCB5ZNBujxjeKM1H8XAksREf2opF1igyzZHAxjfQN9TFYJiinPDazrnl12Xa9+NF/a11OcmsykjtBHoXSK1yQJ3mLz3RkE1I/xOch9xt5jW5HkYJ0k3rZ8+aUOe+RExL4lBrzr+mT56n3Ba3iig5OjbQy5uXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-37-1MfDWgBDOpGubv76-twiag-1; Sun, 15 Dec 2024 12:07:27 +0000
X-MC-Unique: 1MfDWgBDOpGubv76-twiag-1
X-Mimecast-MFC-AGG-ID: 1MfDWgBDOpGubv76-twiag
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 15 Dec
 2024 12:06:27 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 15 Dec 2024 12:06:27 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiri Olsa' <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Song Liu
	<songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire
	<alan.maguire@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: RE: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Thread-Topic: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Thread-Index: AQHbS9GTSF5rwnXysUaDsufIVqYKlLLnNYvQ
Date: Sun, 15 Dec 2024 12:06:27 +0000
Message-ID: <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-9-jolsa@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 0XgOIJDxCLM7JQu9QDZpKOwspvsn9QoXTWflVFytP_0_1734264446
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSmlyaSBPbHNhDQo+IFNlbnQ6IDExIERlY2VtYmVyIDIwMjQgMTM6MzQNCj4gDQo+IFB1
dHRpbmcgdG9nZXRoZXIgYWxsIHRoZSBwcmV2aW91c2x5IGFkZGVkIHBpZWNlcyB0byBzdXBwb3J0
IG9wdGltaXplZA0KPiB1cHJvYmVzIG9uIHRvcCBvZiA1LWJ5dGUgbm9wIGluc3RydWN0aW9uLg0K
PiANCj4gVGhlIGN1cnJlbnQgdXByb2JlIGV4ZWN1dGlvbiBnb2VzIHRocm91Z2ggZm9sbG93aW5n
Og0KPiAgIC0gaW5zdGFsbHMgYnJlYWtwb2ludCBpbnN0cnVjdGlvbiBvdmVyIG9yaWdpbmFsIGlu
c3RydWN0aW9uDQo+ICAgLSBleGNlcHRpb24gaGFuZGxlciBoaXQgYW5kIGNhbGxzIHJlbGF0ZWQg
dXByb2JlIGNvbnN1bWVycw0KPiAgIC0gYW5kIGVpdGhlciBzaW11bGF0ZXMgb3JpZ2luYWwgaW5z
dHJ1Y3Rpb24gb3IgZG9lcyBvdXQgb2YgbGluZSBzaW5nbGUgc3RlcA0KPiAgICAgZXhlY3V0aW9u
IG9mIGl0DQo+ICAgLSByZXR1cm5zIHRvIHVzZXIgc3BhY2UNCj4gDQo+IFRoZSBvcHRpbWl6ZWQg
dXByb2JlIHBhdGgNCj4gDQo+ICAgLSBjaGVja3MgdGhlIG9yaWdpbmFsIGluc3RydWN0aW9uIGlz
IDUtYnl0ZSBub3AgKHBsdXMgb3RoZXIgY2hlY2tzKQ0KPiAgIC0gYWRkcyAob3IgdXNlcyBleGlz
dGluZykgdXNlciBzcGFjZSB0cmFtcG9saW5lIGFuZCBvdmVyd3JpdGVzIG9yaWdpbmFsDQo+ICAg
ICBpbnN0cnVjdGlvbiAoNS1ieXRlIG5vcCkgd2l0aCBjYWxsIHRvIHVzZXIgc3BhY2UgdHJhbXBv
bGluZQ0KPiAgIC0gdGhlIHVzZXIgc3BhY2UgdHJhbXBvbGluZSBleGVjdXRlcyB1cHJvYmUgc3lz
Y2FsbCB0aGF0IGNhbGxzIHJlbGF0ZWQgdXByb2JlDQo+ICAgICBjb25zdW1lcnMNCj4gICAtIHRy
YW1wb2xpbmUgcmV0dXJucyBiYWNrIHRvIG5leHQgaW5zdHJ1Y3Rpb24NCi4uLg0KDQpIb3cgb24g
ZWFydGggY2FuIHlvdSBzYWZlbHkgb3ZlcndyaXRlIGEgcmFuZG9tbHkgYWxpZ25lZCA1IGJ5dGUg
aW5zdHJ1Y3Rpb24NCnRoYXQgbWlnaHQgYmUgYmVpbmcgcHJlZmV0Y2hlZCBhbmQgZXhlY3V0ZWQg
YnkgYW5vdGhlciB0aHJlYWQgb2YgdGhlDQpzYW1lIHByb2Nlc3MuDQoNCklmIHRoZSBpbnN0cnVj
dGlvbiBkb2Vzbid0IGNyb3NzIGEgY2FjaGUgbGluZSBib3VuZGFyeSB0aGVuIHlvdSBtaWdodA0K
bWFuYWdlIHRvIGNvbnZpbmNlIHBlb3BsZSB0aGF0IGFuIDgtYnl0ZSB3cml0ZSB3aWxsIGFsd2F5
cyBiZSBhdG9taWMNCndydCBvdGhlciBjcHUgcmVhZGluZyBpbnN0cnVjdGlvbnMuDQpCdXQgeW91
IGNhbid0IGd1YXJhbnRlZSB0aGUgYWxpZ25tZW50Lg0KDQpZb3UgbWlnaHQgbWFuYWdlIHdpdGgg
dGhlIDcgYnl0ZSBzZXF1ZW5jZToNCgliciAuKzc7IGNhbGwgYWRkcg0KYW5kIHRoZW4gdXBkYXRl
ICdhZGRyJyBiZWZvcmUgY2hhbmdpbmcgdGhlIGJyYW5jaCBvZmZzZXQgZnJvbSAwNSB0byAwMC4N
CkJ1dCBldmVuIHRoYXQgbWF5IG5vdCBiZSBzYWZlIGlmICdhZGRyJyBjcm9zc2VzIGEgY2FjaGUg
bGluZSBib3VuZGFyeS4NCg0KWW91IGNvdWxkIHJlcGxhY2UgYSBvbmUgYnl0ZSBub3AgKDB4OTAp
IHdpdGggYSBicmVha3BvaW50ICgweGNjKSBhbmQNCnRoZW4gcmV0dXJuIHRvIHRoZSBpbnN0cnVj
dGlvbiBhZnRlciB0aGUgYnJlYWtwb2ludC4NClRoYXQgd291bGQgc2F2ZSBoYXZpbmcgdG8gZW11
bGF0ZSBvciBzaW5nbGUgc3RhcCB0aGUgb3ZlcndyaXR0ZW4NCmluc3RydWN0aW9uLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K


