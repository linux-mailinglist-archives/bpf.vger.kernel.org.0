Return-Path: <bpf+bounces-30759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5FB8D227B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4911C22D32
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613741BC4B;
	Tue, 28 May 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="PeSFhknS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="PeSFhknS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ultoer0K"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED42563
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917412; cv=none; b=dPzWGUsqt/DmaZoPzesI6m7JjgJiDLJLlP6gAuYNPuB2RrAxm+C5VvSJLJP7g+qq9S47MMPz3yi5MDtYfi08t94oOD3BhPu2zyKetuZ7h2OlIS3sxphkHo3H3wtxmGarrx18jTZGGtbiw8wIu96anNKXpVwnvqTwmqvYpLhraMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917412; c=relaxed/simple;
	bh=KX0CG7H6tkYzSBCDT9o+Q1CaM/Y52ycKzIJrJvhl+2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=MzVyLt/K5AxcXDly+fFkMIud44OFjhgD9P40gWi5nczhrLLoR0AyTWVNYdy6Hahb7HYn40sma9oGqwomUobVwaaHrGDY5DDEeRYKeq2RwbHxQPQhOhhrLgaYCjX4LjwMABMn/2myAkgyWiUVlOiqK+aMCILwe0JXq5P3cVsnrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=PeSFhknS; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=PeSFhknS; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ultoer0K reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 30C3CC14F6E3
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 10:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716917411; bh=KX0CG7H6tkYzSBCDT9o+Q1CaM/Y52ycKzIJrJvhl+2s=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=PeSFhknSmq6dUUAEfOpQt0APqqzzTQ5tlp9+jtz/Gc0JQZ6AUW7taojEk+DCBlrOk
	 mwMnup2J3XHHthUmoFMst5el7++WK6BtKeP2kGkOeiHfeNv0UpkCCQjFrDK5dDgpLt
	 hqsDoNupkRIOxamZBeTKFKI3YXn2SZpaQLTW7QiI=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Tue May 28 10:30:11 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 12293C18DBB4
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 10:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716917411; bh=KX0CG7H6tkYzSBCDT9o+Q1CaM/Y52ycKzIJrJvhl+2s=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=PeSFhknSmq6dUUAEfOpQt0APqqzzTQ5tlp9+jtz/Gc0JQZ6AUW7taojEk+DCBlrOk
	 mwMnup2J3XHHthUmoFMst5el7++WK6BtKeP2kGkOeiHfeNv0UpkCCQjFrDK5dDgpLt
	 hqsDoNupkRIOxamZBeTKFKI3YXn2SZpaQLTW7QiI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id AC21CC14F6E3
	for <bpf@ietfa.amsl.com>; Tue, 28 May 2024 10:30:05 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.097
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m6IW9xn0ndux for <bpf@ietfa.amsl.com>;
	Tue, 28 May 2024 10:30:04 -0700 (PDT)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id C83BBC14F6B2
	for <bpf@ietf.org>; Tue, 28 May 2024 10:30:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5295d509178so1453830e87.1
        for <bpf@ietf.org>; Tue, 28 May 2024 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716917402; x=1717522202; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7OeA641zFpMpjc2geYL3Cgq7EpWyJRiF2B77FMBQKk=;
        b=Ultoer0KibHZsHVRtPOjnJs/+hGfM1J3VSiQs8tsaQln/esNpyH4stN4QgfV6YCPQq
         3PO/vbfkvMhA/FC6tLfAaZ1qt+EAXAcd4qGJk3PK0AMLU0jZD+/kVvag+xF6sudh8f71
         rXRHaJFLTW/Js8rSwcNsCii1v/ZOFGmjGnR+yyfjrvSINS2mBqhF7WAq/mM4lGrPH2jw
         ut8ZreU1g6gTACV82yEfc4AvX8FQOjrZAcfsphhHuR11eI6BnV6gVfaHqGfJKV+6G4/i
         fg8D64OfqOqsiajvRtjtUIS/Go48rb3NyWGO0a9Xc1ql9JkGNnTY/iO48laBtKu0gdKm
         NeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917402; x=1717522202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7OeA641zFpMpjc2geYL3Cgq7EpWyJRiF2B77FMBQKk=;
        b=Cujyl9fdKeRd9lIKoeU6kW9euOKWMjnZGv5xTQ6nMZfK/vPmlffzUmhDdNGF+5pibB
         6DeauyK3kBhEuuRMh594ZP21Nt+jTl9A6In57fAsv2mj7MFJ/KBnRf+2D9dom4bIJf4X
         dB3M15ulQXeIcoam9WlCpTEilWP/XFQTrA6C+zt/wV3YtpdS3DhEtIwIQUftPYAlvNjr
         V57nEPdoCFySNmNXoTIlJuGvXqlsEVepI1s4ScxYtxQe3taERhh9xKD/uKaZh03m8fLG
         FZZ2bE3VO+H7vyhMVuFSwMfe1dFvCtyNDKiDMGfkDn2snJIrFWq+KEwHheKxrwJ3INvZ
         5+HA==
X-Gm-Message-State: AOJu0Yx/QKsRTg5AZH00w7j+OdR8KM216olv4JMeh4uC0z6aGQAk9+iD
	1lzrvx94MAZmNN5H7RR/72Vei9l+swV9kSXfUXNOyscvY8UAAFWbU8sAVhTDeaXGPR09EEcd71s
	MPsMnokQpoMWUYLyeRHfNLL2Je8w=
X-Google-Smtp-Source: 
 AGHT+IH6mKa5yx1rre9qKe1AnXrjVEsskOmjedKaCWbuzXB+Ac4qx4PbU12UxZl9XoSi73QdzN2IVw0UBCgUm7mEDDg=
X-Received: by 2002:a05:6512:b10:b0:516:c5c2:cba8 with SMTP id
 2adb3069b0e04-52964eac446mr14770807e87.12.1716917402228; Tue, 28 May 2024
 10:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
In-Reply-To: 
 <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 May 2024 10:29:47 -0700
Message-ID: 
 <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
To: Shankar Seal <Shankar.Seal=40microsoft.com@dmarc.ietf.org>
Message-ID-Hash: OKXJPKSU6TTWN3C4MGMBMK2HVI24BAJD
X-Message-ID-Hash: OKXJPKSU6TTWN3C4MGMBMK2HVI24BAJD
X-MailFrom: andrii.nakryiko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: "bpf@ietf.org" <bpf@ietf.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_Writing_into_a_ring_buffer_map_from_user_space?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/UxJgJlKQvnNBtYvlGK0kUQEOwl0>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBNYXkgMjgsIDIwMjQgYXQgOTozMuKAr0FNIFNoYW5rYXIgU2VhbA0KPFNoYW5rYXIu
U2VhbD00MG1pY3Jvc29mdC5jb21AZG1hcmMuaWV0Zi5vcmc+IHdyb3RlOg0KPg0KPiBBZGRpbmcg
YnBmQHZnZXIua2VybmVsLm9yZw0KPg0KPiBBIGNvbW1vbiB1c2UgY2FzZSBvZiBhbiBCUEYgcmlu
ZyBidWZmZXIgbWFwIHRvIHVzZSBhcyBhIHF1ZXVlIG9mIGV2ZW50cyBnZW5lcmF0ZWQgYnkgQlBG
IHByb2dyYW1zIHRoYXQgY2FuIGJlIHJlYWQgaW4tb3JkZXIgYnkgdXNlciBzcGFjZSBhcHBsaWNh
dGlvbnMuIEkgaGF2ZSBhIHNjZW5hcmlvIHJlcXVpcmVtZW50IGZvciBhIHVzZXIgc3BhY2UgYXBw
bGljYXRpb24gdG8gd3JpdGUgaW50byBhIHJpbmcgYnVmZmVyIChvciBzaW1pbGFyKSBtYXAsIHN1
Y2ggdGhhdCBldmVudHMgYnkgQlBGIHByb2dyYW1zIGluIGtlcm5lbCBhbmQgdXNlciBzcGFjZSBh
cHBsaWNhdGlvbnMgYXJlIGludGVybGVhdmVkIGluIHRoZSBvcmRlciB0aGV5IHdlcmUgZ2VuZXJh
dGVkLCB0aGF0IGNhbiBiZSBjb25zdW1lZCBieSBhbm90aGVyIHVzZXIgc3BhY2UgYXBwbGljYXRp
b24NCj4NCj4gSSB3b3VsZCBsaWtlIHRvIGltcGxlbWVudCB0aGlzIG5ldyBmZWF0dXJlIGluIHRo
ZSBodHRwczovL2dpdGh1Yi5jb20vbWljcm9zb2Z0L2VicGYtZm9yLXdpbmRvd3MgcHJvamVjdC4g
QnV0IGJlZm9yZSBJIGdvIGFoZWFkIHdpdGggdGhlIGltcGxlbWVudGF0aW9uLCBJIHdhbnRlZCB0
byBjaGVjayBpZiB0aGVyZSBpcyBhbnkgd2F5IHRvIGFjY29tcGxpc2ggdGhpcyBpbiBMaW51eCB0
b2RheT8gSWYgbm90LCBpcyB0aGVyZSBhbnkgcmVhc29uIHdoeSB0aGlzIHNob3VsZCBub3QgYmUg
ZG9uZT8NCg0KWWVzLCB0aGVyZSBpcy4gU2VlIHVzZXJfcmluZ19idWZmZXIgKFswXSwgWzFdKS4N
Cg0KICBbMF0gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3VzZXJfcmluZ2J1Zi5jDQogIFsx
XSBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3VzZXJfcmluZ2J1Zl9zdWNjZXNzLmMNCg0KPg0KPiBU
aGFua3MsDQo+IFNoYW5rYXINCj4g4Ka24KaC4KaV4KawIOCmtuCngOCmsg0KPg0KPg0KPg0KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBGcm9tOiBTaGFua2FyIFNlYWwNCj4g
U2VudDogVHVlc2RheSwgTWF5IDI4LCAyMDI0IDEyOjQwIEFNDQo+IFRvOiBicGZAaWV0Zi5vcmcg
PGJwZkBpZXRmLm9yZz4NCj4gU3ViamVjdDogV3JpdGluZyBpbnRvIGEgcmluZyBidWZmZXIgbWFw
IGZyb20gdXNlciBzcGFjZQ0KPg0KPg0KPiBJIGhhdmUgYSBzY2VuYXJpbyByZXF1aXJlbWVudCBm
b3IgYSB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIHRvIHdyaXRlIGludG8gYSByaW5nIGJ1ZmZlciBl
QlBGIG1hcCB0aGF0IEkgd291bGQgbGlrZSB0byBpbXBsZW1lbnQgaW4gdGhlIGh0dHBzOi8vZ2l0
aHViLmNvbS9taWNyb3NvZnQvZWJwZi1mb3Itd2luZG93cyBwcm9qZWN0LiBJcyB0aGVyZSBhbnkg
d2F5IHRvIGFjY29tcGxpc2ggdGhpcyBpbiBMaW51eCB0b2RheT8gSWYgbm90LCBpcyB0aGVyZSBh
bnkgcmVhc29uIHdoeSB0aGlzIHNob3VsZCBub3QgYmUgZG9uZT8NCj4NCj4NCj4gVGhhbmtzLA0K
PiBTaGFua2FyDQo+IOCmtuCmguCmleCmsCDgprbgp4DgprINCj4NCj4NCj4NCj4gLS0NCj4gQnBm
IG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcNCj4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBl
bWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcNCg0KLS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBm
QGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYu
b3JnCg==

