Return-Path: <bpf+bounces-44379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4DB9C252D
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D0EB21D60
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A21A9B4C;
	Fri,  8 Nov 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YWvpKGJt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="y1ztY7mI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EyzvhQ2r"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAD19924D
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092051; cv=none; b=rIwtCpU2bM0A6t4mPVFzgTJzU5Ce9LhKEXmyupo3BRLczCj7Jf+bD6N76KRzJeH+Lx9z4oKVN5Xe+2Tju7pTBOWn8IgaSjKQKN5W3rA2edgRUH51ke7KdrjD9XAAW3s+oDsuHAw/TbJvtHmnSk7Lg/uB2FPvN4SEH1+XjI4HYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092051; c=relaxed/simple;
	bh=aQ6qBwDTf/v/wu80rTrSoK7owXVyKuPzeJ1M/rc5MC4=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=NWL54z+YIhWeKes//tYxVjYVAVYi8qkbdBWXaPp13vylc4MvobXM9Dxy2fT5jKFJZLreLX/Xd9fNwy15RKablNmWXOazDG2AnUfWCtkCXAAyD46QyTm/K8KKI0Z4uTDG7oIM9/ecG1Obz4Xz1ErOJHYgFHpWMMI2AUIVDawZeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=YWvpKGJt; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=y1ztY7mI reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EyzvhQ2r reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5BCA2C18DB8A
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731092049; bh=aQ6qBwDTf/v/wu80rTrSoK7owXVyKuPzeJ1M/rc5MC4=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YWvpKGJtesmYpeY/GZY8wGzKoPH/5xiDTbMaRoB+sqqkmnWQZQ1tUaB/Gx3izTKR3
	 pbBgeaI+XRTuN9V3QkqfSid6GEFW8TpAlrLlWkIn0pLq/g0xrLzK2+/Hners2DZEIZ
	 mz+X4ILpUQ3GLx12AItfaLbnCD6xi/uPs3GA0DNk=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 38CE4C1CAF38
 for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1731092049; bh=aQ6qBwDTf/v/wu80rTrSoK7owXVyKuPzeJ1M/rc5MC4=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=y1ztY7mIjVw+jBM0C8Uyq/PDjXkHQPNghpb77G7CiT1ZVDwAoQ1lvrfcHC56j31Fq
 gWUUEoX3alAhknQ2SdVBlmvTgi8H/smyzGoDl9S/7glV/7BrjsKynsSg+XSlnX7D+H
 JL050RJE9wx/me5I71vSVPtV/wCnzP3TgajJ0cvg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A432EC15154A
 for <bpf@ietfa.amsl.com>; Fri,  8 Nov 2024 10:53:57 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWUVchsmFpjY for <bpf@ietfa.amsl.com>;
 Fri,  8 Nov 2024 10:53:53 -0800 (PST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8CBB3C15109C
 for <bpf@ietf.org>; Fri,  8 Nov 2024 10:53:53 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so1810187a12.2
 for <bpf@ietf.org>; Fri, 08 Nov 2024 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1731092033; x=1731696833;
 darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hoVx3IzbvzgGPPMK+ztcJErqY3DDxw1a4kxx2dSZOIs=;
 b=EyzvhQ2rJMPNbjsv6HoV4sFE6HrOG6u0fbjSjbMs/64yJaKQ0QxnbI4C4DaVjj3FT3
 hm6SdV/QrjzOWs6kOA9jG3JpCzyoGwNpnEiyCqSMG1EJbvZMUKciUy7PFSgvBOIZ4Rmo
 ja4zgsmm2Yqj2WBexmQlqE4MVZRmXd2sjH0BixzS7zDDCpH52TEjGaC6QLInZZYet7AI
 0K5zXLtkrTAgYybtAc3EF6FkDnszb0jukhlnuxe44LiXH1ztHv9qzJucA8lztaxpgDbf
 D7v9E60Tn2l0YI38w8jlL35ZS8AvD9igrKTSsQ9JuDYwcUYc5McwQbob4/G9OqpKnVMw
 g8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731092033; x=1731696833;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hoVx3IzbvzgGPPMK+ztcJErqY3DDxw1a4kxx2dSZOIs=;
 b=MKiCZDn05eIz2V/Ix9q0ruGuG7aSSVDe2eZMQRQOFANYgUSPKU4OkmLjYFggIUP/Rp
 a9IVPqIJKQInz8odb1FhxGIt8wvkaVgCEzSldF75/mUQkiCSjmijb80EQIAd2oyFTlYP
 aTduy2/ET79sxyJS/q0+GMC0H2leEZNsOZ+KS/EvtxbEDd1agLx8vFZN2zDlw88zkaoX
 9OyA0QNp7somQ+P1LGLiYxxhTDt8WW1M4jUT0vQ7kLCcaVa6DdBp4zm9mGYmI+1uunVX
 xU3lxIp+rIHjtOewzhzXsELYGBZBd/hr3f6aMAD26zg/Pvrpblch1uH/nZH1aLRiq5P8
 B1mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx4GAy+6kMKhEhUB2YlQeUwRamdvKLGGxRxDQStetBI0qBa/1EUtdgxvTodN5WlDFGm9Q=@ietf.org
X-Gm-Message-State: AOJu0YwF4pDAEFmqQp35YndPQ8d/Rwc/HNkHYHU2I8g14tDsoDRBUC7J
 qWoQpMYpkys6MoN2ZUKs2f2T5xniuGhbFd4yoqjI70noNkKcGdfU
X-Google-Smtp-Source: AGHT+IEJNzgS4D6XSuxlhvumNgnxU7Rx5rhzo/5zBwcEpyKpy5W+exuYFBh03DQbSyZj1mey6frm0w==
X-Received: by 2002:a05:6a21:2e81:b0:1db:e1b0:b679 with SMTP id
 adf61e73a8af0-1dc229cc1ccmr3685278637.18.1731092032962;
 Fri, 08 Nov 2024 10:53:52 -0800 (PST)
Received: from ArmidaleLaptop (64-119-15-60.fiber.ric.network. [64.119.15.60])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a7e09sm4099264b3a.50.2024.11.08.10.53.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Nov 2024 10:53:52 -0800 (PST)
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
 "'Dave Thaler'" <dthaler1968@googlemail.com>
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
 <000c01db3186$1dd30930$59791b90$@gmail.com>
 <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
In-Reply-To: <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
Date: Fri, 8 Nov 2024 10:53:50 -0800
Message-ID: <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKzqMffW8FFfWCd3ulEKsb+gfc3egGOkjXjAfqQ6mkCtID1/gMZ/eqXAhACfxMDWut5qbCGtxtg
Content-Language: en-us
Message-ID-Hash: 3PDLGDPRMA3NLMJLRZ74TSBJMMAHF6XI
X-Message-ID-Hash: 3PDLGDPRMA3NLMJLRZ74TSBJMMAHF6XI
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: 'Yonghong Song' <yonghong.song@linux.dev>, bpf@ietf.org,
 'bpf' <bpf@vger.kernel.org>, 'Alexei Starovoitov' <ast@kernel.org>,
 'Andrii Nakryiko' <andrii@kernel.org>,
 'Daniel Borkmann' <daniel@iogearbox.net>,
 'Martin KaFai Lau' <martin.lau@kernel.org>
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_docs/bpf=3A_Document_some_spe?=
 =?utf-8?q?cial_sdiv/smod_operations?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/dlN798LzZrfL2TNakKk_LSTmg64>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIg
OCwgMjAyNCAxMDozOCBBTQ0KPiBUbzogRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdvb2dsZW1h
aWwuY29tPg0KPiBDYzogWW9uZ2hvbmcgU29uZyA8eW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY+OyBi
cGZAaWV0Zi5vcmc7IGJwZg0KPiA8YnBmQHZnZXIua2VybmVsLm9yZz47IEFsZXhlaSBTdGFyb3Zv
aXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBBbmRyaWkgTmFrcnlpa28NCj4gPGFuZHJpaUBrZXJuZWwu
b3JnPjsgRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47IE1hcnRpbiBLYUZh
aSBMYXUNCj4gPG1hcnRpbi5sYXVAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBi
cGYtbmV4dF0gZG9jcy9icGY6IERvY3VtZW50IHNvbWUgc3BlY2lhbCBzZGl2L3Ntb2QNCj4gb3Bl
cmF0aW9ucw0KPiANCj4gT24gVGh1LCBOb3YgNywgMjAyNCBhdCA2OjMw4oCvUE0gRGF2ZSBUaGFs
ZXIgPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4g
QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToN
Cj4gPiA+IE9uIFR1ZSwgT2N0IDEsIDIwMjQgYXQgMTI6NTTigK9QTSBEYXZlIFRoYWxlcg0KPiA+
ID4gPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gWy4uLl0N
Cj4gPiA+ID4gSSdtIGFkZGluZyBicGZAaWV0Zi5vcmcgdG8gdGhlIFRvIGxpbmUgc2luY2UgYWxs
IGNoYW5nZXMgaW4gdGhlDQo+ID4gPiA+IHN0YW5kYXJkaXphdGlvbiBkaXJlY3Rvcnkgc2hvdWxk
IGluY2x1ZGUgdGhhdCBtYWlsaW5nIGxpc3QuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBXRyBzaG91
bGQgZGlzY3VzcyB3aGV0aGVyIGFueSBjaGFuZ2VzIHNob3VsZCBiZSBkb25lIHZpYSBhIG5ldw0K
PiA+ID4gPiBSRkMgdGhhdCBvYnNvbGV0ZXMgdGhlIGZpcnN0IG9uZSwgb3IgYXMgUkZDcyB0aGF0
IFVwZGF0ZSBhbmQganVzdA0KPiA+ID4gPiBkZXNjcmliZSBkZWx0YXMgKGFkZGl0aW9ucywgZXRj
LikuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZXJlIGFyZSBwcmVjZWRlbnRzIGJvdGggd2F5cyBhbmQg
SSBkb24ndCBoYXZlIGEgc3Ryb25nDQo+ID4gPiA+IHByZWZlcmVuY2UsIGJ1dCBJIGhhdmUgYSB3
ZWFrIHByZWZlcmVuY2UgZm9yIGRlbHRhLWJhc2VkIG9uZXMNCj4gPiA+ID4gc2luY2UgdGhleSdy
ZSBzaG9ydGVyIGFuZCBhcmUgbGVzcyBsaWtlbHkgdG8gcmUtb3BlbiBkaXNjdXNzaW9uIG9uDQo+
ID4gPiA+IHByZXZpb3VzbHkgcmVzb2x2ZWQgaXNzdWVzLCB0aHVzIG9mdGVuIHNhdmluZyB0aGUg
V0cgdGltZS4NCj4gPiA+DQo+ID4gPiBEZWx0YS1iYXNlZCBhZGRpdGlvbnMgbWFrZSBzZW5zZSB0
byBtZS4NCj4gPiA+DQo+ID4gPiA+IEFsc28gRllJIHRvIExpbnV4IGtlcm5lbCBmb2xrczoNCj4g
PiA+ID4gV2l0aCBXRyBhbmQgQUQgYXBwcm92YWwsIGl0J3MgYWxzbyBwb3NzaWJsZSAoYnV0IG5v
dCBpZGVhbCkgdG8NCj4gPiA+ID4gdGFrZSBjaGFuZ2VzIGF0IEFVVEg0OC4gIFRoYXQnZCBiZSB1
cCB0byB0aGUgY2hhaXJzIGFuZCBBRCB0bw0KPiA+ID4gPiBkZWNpZGUgdGhvdWdoLCBhbmQgbm9y
bWFsbHkgdGhhdCdzIGp1c3QgZm9yIHB1cmVseSBlZGl0b3JpYWwNCj4gPiA+ID4gY2xhcmlmaWNh
dGlvbnMsIGUuZy4sIHRvIGNvbmZ1c2lvbiBjYWxsZWQgb3V0IGJ5IHRoZSBSRkMgZWRpdG9yIHBh
c3MuDQo+ID4gPg0KPiA+ID4gQWxzbyBhZ3JlZS4gV2Ugc2hvdWxkIGtlZXAgQVVUSCBnb2luZyBp
dHMgY291cnNlIGFzLWlzLg0KPiA+ID4gQWxsIElTQSBhZGRpdGlvbnMgY2FuIGJlIGluIHRoZSBm
dXR1cmUgZGVsdGEgUkZDLg0KPiA+ID4NCj4gPiA+IEFzIGZhciBhcyBmaWxlIGxvZ2lzdGljcy4u
LiBteSBwcmVmZXJlbmNlIGlzIHRvIGtlZXANCj4gPiA+IERvY3VtZW50YXRpb24vYnBmL3N0YW5k
YXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQo+ID4gPiB1cCB0byBkYXRlLg0KPiA+ID4g
UmlnaHQgbm93IGl0J3MgZWZmZWN0aXZlbHkgZnJvemVuIHdoaWxlIGF3YWl0aW5nIGNoYW5nZXMg
KGlmIGFueSkgbmVjZXNzYXJ5IGZvcg0KPiBBVVRILg0KPiA+ID4gQWZ0ZXIgb2ZmaWNpYWwgUkZD
IGlzIGlzc3VlZCB3ZSBjYW4gc3RhcnQgbGFuZGluZyBwYXRjaGVzIGludG8NCj4gPiA+IGluc3Ry
dWN0aW9uLXNldC5yc3QgYW5kIGdpdCBkaWZmIDA0ZWZhZWJkNzJkMS4ud2hhdGV2ZXJfZnV0dXJl
X3NoYQ0KPiA+ID4gaW5zdHJ1Y3Rpb24tc2V0LnJzdCB3aWxsIGF1dG9tYXRpY2FsbHkgZ2VuZXJh
dGUgdGhlIGZ1dHVyZSBkZWx0YSBSRkMuDQo+ID4gPiBPbmNlIFJGQyBudW1iZXIgaXMgaXNzdWVk
IHdlIGNhbiBhZGQgYSBnaXQgdGFnIGZvciB0aGUgcGFydGljdWxhcg0KPiA+ID4gc2hhIHRoYXQg
d2FzIHRoZSBiYXNlIGZvciBSRkMgYXMgYSBkb2N1bWVudGF0aW9uIHN0ZXAgYW5kIHRvIHNpbXBs
aWZ5IGZ1dHVyZSAnZ2l0DQo+IGRpZmYnLg0KPiA+DQo+ID4gTXkgY29uY2VybiBpcyB0aGF0IGlu
ZGV4LnJzdCBzYXlzOg0KPiA+ID4gVGhpcyBkaXJlY3RvcnkgY29udGFpbnMgZG9jdW1lbnRzIHRo
YXQgYXJlIGJlaW5nIGl0ZXJhdGVkIG9uIGFzIHBhcnQNCj4gPiA+IG9mIHRoZSBCUEYgc3RhbmRh
cmRpemF0aW9uIGVmZm9ydCB3aXRoIHRoZSBJRVRGLiBTZWUgdGhlIGBJRVRGIEJQRg0KPiA+ID4g
V29ya2luZyBHcm91cGBfIHBhZ2UgZm9yIHRoZSB3b3JraW5nIGdyb3VwIGNoYXJ0ZXIsIGRvY3Vt
ZW50cywgYW5kIG1vcmUuDQo+ID4NCj4gPiBTbyBoYXZpbmcgYSBkb2N1bWVudCB0aGF0IGlzIE5P
VCBwYXJ0IG9mIHRoZSBJRVRGIEJQRiBXb3JraW5nIEdyb3VwDQo+ID4gd291bGQgc2VlbSBvdXQg
b2YgcGxhY2UgYW5kLCBpbiBteSB2aWV3LCBiZXR0ZXIgbG9jYXRlZCB1cCBhIGxldmVsIChvdXRz
aWRlDQo+IHN0YW5kYXJkaXphdGlvbikuDQo+IA0KPiBJdCdzIGEgcGFydCBvZiBicGYgd2cuIEl0
J3Mgbm90IGEgbmV3IGRvY3VtZW50Lg0KDQpSRkMgOTY2OSBpcyBpbW11dGFibGUuICBBbnkgYWRk
aXRpb25zIHJlcXVpcmUgYSBuZXcgZG9jdW1lbnQsIGluDQpJRVRGIHRlcm1pbm9sb2d5LCBzaW5j
ZSB3b3VsZCByZXN1bHQgaW4gYSBuZXcgUkZDIG51bWJlci4NCg0KPiA+IEhlcmXigJlzIHNvbWUg
ZXhhbXBsZXMgb2YgZGVsdGEtYmFzZWQgUkZDcyB3aGljaCBleHBsYWluIHRoZSBnYXAgYW5kDQo+
ID4gcHJvdmlkZSB0aGUgYWRkaXRpb24gb3IgY2xhcmlmaWNhdGlvbiwgYW5kIGZvcm1hbGx5IFVw
ZGF0ZSAobm90DQo+ID4gcmVwbGFjZS9vYnNvbGV0ZSkgdGhlIG9yaWdpbmFsDQo+ID4gUkZDOg0K
PiA+ICogaHR0cHM6Ly93d3cucmZjLWVkaXRvci5vcmcvcmZjL3JmYzY1ODUuaHRtbDogQWRkaXRp
b25hbCBIVFRQIFN0YXR1cw0KPiA+IENvZGVzDQo+ID4gKiBodHRwczovL3d3dy5yZmMtZWRpdG9y
Lm9yZy9yZmMvcmZjNjg0MC5odG1sOiBDbGFyaWZpY2F0aW9ucyBhbmQgSW1wbGVtZW50YXRpb24N
Cj4gTm90ZXMNCj4gPiAgICBmb3IgRE5TIFNlY3VyaXR5IChETlNTRUMpDQo+ID4gKiBodHRwczov
L3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjOTI5NS5odG1sOiBDbGFyaWZpY2F0aW9ucyBmb3Ig
RWQyNTUxOSwgRWQ0NDgsDQo+ID4gICAgWDI1NTE5LCBhbmQgWDQ0OCBBbGdvcml0aG0gSWRlbnRp
ZmllcnMNCj4gPiAqIGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmM1NzU2Lmh0bWw6
IFVwZGF0ZXMgZm9yIFJTQUVTLU9BRVAgYW5kDQo+ID4gICAgUlNBU1NBLVBTUyBBbGdvcml0aG0g
UGFyYW1ldGVycw0KPiA+DQo+ID4gSGF2aW5nIGEgZnVsbCBkb2N1bWVudCB0b28gaXMgdmFsdWFi
bGUgYnV0IHVubGVzcyB0aGUgSUVURiBCUEYgV0cNCj4gPiBkZWNpZGVzIHRvIHRha2Ugb24gYSAt
YmlzIGRvY3VtZW50LCBJJ2Qgc3VnZ2VzdCBrZWVwaW5nIGl0IG91dCBvZiB0aGUNCj4gInN0YW5k
YXJkaXphdGlvbiINCj4gPiAoc2F5IHVwIDEgbGV2ZWwpIHRvIGF2b2lkIGNvbmZ1c2lvbiwgYW5k
IGp1c3QgaGF2ZSBvbmUgb3IgbW9yZQ0KPiA+IGRlbHRhLWJhc2VkIHJzdCBmaWxlcyBpbiB0aGUg
c3RhbmRhcmRpemF0aW9uIGRpcmVjdG9yeS4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgZWZmZWN0aXZl
bHkgYSBmaXggdG8gdGhlIHN0YW5kYXJkLg0KDQpUd28gb2YgdGhlIGV4YW1wbGVzIEkgcHJvdmlk
ZWQgYWJvdmUgZml0IGludG8gdGhhdCBjYXRlZ29yeS4NClR3byBhcmUgZXhhbXBsZXMgb2YgYWRk
aW5nIG5ldyBjb2RlcG9pbnRzLg0KDQo+IEl0J3MgYSBzdGFuZGFyZCBnaXQgZGV2ZWxvcG1lbnQg
cHJvY2VzcyB3aGVuIGZpeGVzIGFyZSBhcHBsaWVkIHRvIHRoZSBleGlzdGluZw0KPiBkb2N1bWVu
dC4NCj4gRm9ya2luZyB0aGUgd2hvbGUgZG9jIGludG8gYSBkaWZmZXJlbnQgZmlsZSBqdXN0IHRv
IGFwcGx5IGZpeGVzIG1ha2VzIG5vIHNlbnNlIHRvIG1lLg0KDQpXZWxjb21lIHRvIHRoZSBJRVRG
IGFuZCBpbW11dGFibGUgUkZDcyDwn5iKDQoNCj4gVGhlIGZvcm1hbCBkZWx0YS1zIGZvciBJRVRG
IGNhbiBiZSBjcmVhdGVkIG91dCBvZiBnaXQuDQoNCk5vdCBpbiB0aGUgSUVURiBwZXIgc2UsIHNp
bmNlIGEgbmV3IGRvY3VtZW50IG5lZWRzIG5ldyBib2lsZXJwbGF0ZSwgd2l0aA0KYSBuZXcgYWJz
dHJhY3QsIGludHJvZHVjdGlvbiwgZXRjLiAgQXQgbW9zdCwgcGFydCBvZiB0aGUgZG9jdW1lbnQg
Y291bGQgYmUgY3JlYXRlZA0Kb3V0IG9mIGdpdCwgYnV0IEknbSBub3QgY29udmluY2VkIHRoYXQg
Z2l0IGRpZmZzIGFsb25lIChhcyBvcHBvc2VkIHRvIHNvbWUgRW5nbGlzaA0KcHJvc2UgdG9vIGZv
ciBlYWNoLCBhcyBpbiB0aGUgZXhhbXBsZXMgSSBjaXRlZCkgbWFrZSBmb3IgZ29vZCBjb250ZW50
IGluIGFuIElFVEYgZG9jdW1lbnQuDQoNCj4gV2Ugb25seSBuZWVkIHRvIHRhZyB0aGUgY3VycmVu
dCB2ZXJzaW9uIGFuZCB0aGVuIGdpdCBkaWZmIHJmYzk2NjlfdGFnLi5IRUFEIHdpbGwgZ2l2ZQ0K
PiB1cyB0aGF0IGRlbHRhLg0KPiBUaGF0IHdpbGwgc2F0aXNmeSBJRVRGIHByb2Nlc3MgYW5kIHdv
bid0IG1lc3MgdXAgbm9ybWFsIGdpdCBzdHlsZSBrZXJuZWwNCj4gZGV2ZWxvcG1lbnQuDQoNCkkg
YW0gbm90IGNvbnZpbmNlZCBpdCBpcyBzdWZmaWNpZW50LiAgQ2FuIHlvdSBwb2ludCB0byBhbnkg
cHJlY2VkZW50cyBpbiB0aGUgSUVURiBmb3INCnN1Y2ggYW4gYXBwcm9hY2g/ICBJIGNhbid0IG9m
ZmhhbmQuLi4gU2VlIHRoZSBSRkMgNTc1NiByZWZlcmVuY2UgYWJvdmUgZm9yIHdoYXQNCkkgbWVh
biBieSBFbmdsaXNoIHByb3NlIGZvciBlYWNoIGRpZmYuDQoNCj4gYnR3IGRvIHdlIHN0aWxsIG5l
ZWQgdG8gZG8gYW55IG1pbm9yIGVkaXQvZml4ZXMgdG8gaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiZWZv
cmUgdGFnZ2luZyBpdA0KPiBhcyBSRkM5NjY5ID8NCg0KWWVzLCB3ZSBuZWVkIHRvIGJhY2twb3J0
IHRoZSBmb3JtYXR0aW5nL25pdHMgZnJvbSB0aGUgUkZDIGVkaXRvciBwYXNzLg0KDQpEYXZlDQoN
Ci0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

