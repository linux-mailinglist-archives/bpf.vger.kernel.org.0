Return-Path: <bpf+bounces-33588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C191EC06
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531442832A3
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9E6FCB;
	Tue,  2 Jul 2024 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jG3Kg+qK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jG3Kg+qK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLTK+7Zp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BD6FC3
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881709; cv=none; b=HWtf4SAtLt2LhTAko/9sIisGn9fAnJE+o6Kdt5mpi8OG2n4XPB4a9WhdsphQz4SZBcAInU1PU63C5ac85QLDPxd14PBtFglRDeJE2NIQxyZ7XfpJqQ+9t9hX5b7QXH+7/HoPjbynkKPjNWMJpk9q+NAcKZIFKA/1dAgmwX2KLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881709; c=relaxed/simple;
	bh=K4S/vqouz67tJmft0bweItxW97e71QcUH7ZafO6Xlb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=H5+Jg/Xe8OZ+WPOWn+ugcTDzE0cBCWU/xxqrTD2lf+6oHZnmL+kNWqXIhvyDfZE70SpAmsP5z1U54vlBzY8pfFfc4sTu1MHT76quXABjbjru85UjDAfitFJsjxHpFlU5MReaiF0kJI5htgvsERnBFw4tTC2ffSl8lksNOHJO6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jG3Kg+qK; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jG3Kg+qK; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLTK+7Zp reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4B7E1C18DB96
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 17:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1719881700; bh=K4S/vqouz67tJmft0bweItxW97e71QcUH7ZafO6Xlb4=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=jG3Kg+qKwfNJBaWOqMqY5G8bZZJLDsOuYgX47Ae4HYMXXwQg3958xa5OxYUiSdMvY
	 4dT4TQwgXnSX6S/6Uw7cdRp5wXS7gVugWpfUdR/8kWdxTcs+KevE+GHNdKSTq2YKCR
	 RxzvizScZFCyO69V+tg+I7NurXnbGUyk/mDDoSbQ=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Mon Jul  1 17:55:00 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3A642C151095
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 17:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1719881700; bh=K4S/vqouz67tJmft0bweItxW97e71QcUH7ZafO6Xlb4=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=jG3Kg+qKwfNJBaWOqMqY5G8bZZJLDsOuYgX47Ae4HYMXXwQg3958xa5OxYUiSdMvY
	 4dT4TQwgXnSX6S/6Uw7cdRp5wXS7gVugWpfUdR/8kWdxTcs+KevE+GHNdKSTq2YKCR
	 RxzvizScZFCyO69V+tg+I7NurXnbGUyk/mDDoSbQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id C4C5BC14F697
	for <bpf@ietfa.amsl.com>; Mon,  1 Jul 2024 17:54:56 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Tvm-NUcREhn for <bpf@ietfa.amsl.com>;
	Mon,  1 Jul 2024 17:54:51 -0700 (PDT)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id C283FC151095
	for <bpf@ietf.org>; Mon,  1 Jul 2024 17:54:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70673c32118so2287291b3a.3
        for <bpf@ietf.org>; Mon, 01 Jul 2024 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719881691; x=1720486491; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+bbiGQXYWSfjKaagQ1RMDcmnR1qbId2FnkYofjhekU=;
        b=SLTK+7ZpjmyeilcMcZlpywLICruP+hWoaIIw3LCeSkOyjbU0U6yjbgZ96tf6mDU8SI
         Z2XqQKxCqmQuOP+rMzgCi1S0C8yxTvtBkl/cLs7SBqxsZAK7DaaLBTpCw543nK/h1gst
         mzfaDHPjIaeK2M9b5zC4JPj0JRjiJyu2RdZwN4F4RTFwek7QHvrV3F4Ps21vHzvr+6in
         LZW7Xvgv6CRx30QbdNKRNI5930gxvI6Uih8ib8sPDWuS5OvPmWjA32UlY/tlIbA6WprY
         e/vTq9Q2IaoJ+24WlXIW2IW3/3x685PEkQVK+iiGbXsvv1/QFmu5i78gF6fRykDmXc+p
         ZCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719881691; x=1720486491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+bbiGQXYWSfjKaagQ1RMDcmnR1qbId2FnkYofjhekU=;
        b=KrCf+NyU0oj+HJiHs15NTFPsq6plt7no/3PRdQB081NrpkEHVAVIuV0WIfS9/iOUrm
         QXEnwflSa8m6ERb6sJQ+0YYYuEs0tqvyHveGUye7OGG9Eem4y5SPe+QAmWYG1+wsTfCB
         Ydb3+WEqep4kyDWBd0Hgk+BOFAPJ3jfEolKz4ZSgJ2hnUagB2j3cBSg2c9U6CfWaHk8W
         Ker1lMIphDgyQdrXM3YUbj6WcRpB0AFBr8ZPTFlYo+K2Wih5iuF0vtaYdkjsh6aHahvk
         A0TUi4hY3VzMF6CURa+raaTSdFwowUWim4AAiSQUEUiV0XVrGrg90SE8o4rCdbjyvf1S
         l7/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSgVDd3FO6EmCDjnDCwKmgg92ez2+wSabFTtN2GRXmoeid+sRirTIDVmwYF4VjhOQB5hioryeN1189Mtw=
X-Gm-Message-State: AOJu0YxJvFX5jQSmq+zcX3LExPv6/foglVmRnr5xFlyN9iGT7XoEpefl
	OAnPTqqPhKwYPl6uVZPnjsmyw9ComEeuYn3CHvfqK5gW0N744j67PQGbOLn2Ecsfg700Pob+Cd2
	U7yQHIB+c3cAnuVWNzuUDl+UNSDw=
X-Google-Smtp-Source: 
 AGHT+IFEfncZWHRf1w7k8NMYB6QVq1XuTPYqOadRpRIb9X8iBTbxdkAi+qDhz9TD7/ofZFvW3eam27XICfzgSQext1A=
X-Received: by 2002:a05:6a00:cd3:b0:706:8ce7:d582 with SMTP id
 d2e1a72fcca58-70aaad620fbmr6691962b3a.17.1719881691049; Mon, 01 Jul 2024
 17:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
 <0c4801dab126$7a502fc0$6ef08f40$@gmail.com>
 <PH0PR21MB191000EA2B7A038CE99C5B5398FA2@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB19108A5EF85F75C9F273D14798C92@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzaJbjVY-qnjS0=8U_TEwpQTigvbGnBpou+mA6P8DOiuzA@mail.gmail.com>
 <PH0PR21MB19108C4E51658567D704114898D52@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzZjiqarLN9w=9AzQrEvSS+EYF-SAXwajaotsFuJ7PAp8A@mail.gmail.com>
 <PH0PR21MB191080B6BA61E887EE47B9DC98D12@PH0PR21MB1910.namprd21.prod.outlook.com>
In-Reply-To: 
 <PH0PR21MB191080B6BA61E887EE47B9DC98D12@PH0PR21MB1910.namprd21.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:54:38 -0700
Message-ID: 
 <CAEf4BzYYu0HxkJpBEKEnGxAkn+iOnvOQbt_coQjhRLkZQQvSLg@mail.gmail.com>
To: Shankar Seal <Shankar.Seal@microsoft.com>
Message-ID-Hash: DY6O4UKIS43PCPD3SEBFXGSPJSJANSXA
X-Message-ID-Hash: DY6O4UKIS43PCPD3SEBFXGSPJSJANSXA
X-MailFrom: andrii.nakryiko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Shankar Seal <Shankar.Seal=40microsoft.com@dmarc.ietf.org>,
 "dthaler1968=40googlemail.com@dmarc.ietf.org"
 <dthaler1968=40googlemail.com@dmarc.ietf.org>, "bpf@ietf.org" <bpf@ietf.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BEXTERNAL=5D_RE=3A_Re=3A_Writing_into_a_ring_buf?=
 =?utf-8?q?fer_map_from_user_space?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/F0kULcgqMqaWTXJu9GgCHtO02DE>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBKdW4gMjgsIDIwMjQgYXQgMTE6NDTigK9QTSBTaGFua2FyIFNlYWwNCjxTaGFua2Fy
LlNlYWxAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+DQo+IFRoYW5rcyBBbmRyaWkuDQo+DQo+IEkg
YW0gY2hhbmdpbmcgdGhlIGVtYWlsIGZvcm1hdCB0byBwbGFpbiB0ZXh0LiBIb3BlZnVsbHkgdGhp
cyB3aWxsIHdvcmsgd2l0aCB0aGUgdmdlciBtYWlsaW5nIGxpc3QuDQo+DQo+ID4+IEkgZG9uJ3Qg
dGhpbmsgdGhlIExpbnV4IHNpZGUgY2FuL3Nob3VsZCB3b3JrIGxpa2UgdGhhdC4NCj4NCj4gTm90
ZSB0aGF0IHRoZSBwcm9wb3NhbCBJIG1hZGUgZm9yIFdpbmRvd3MgaW4gcHJldmlvdXMgZW1haWwg
aXMgKmVmZmVjdGl2ZWx5KiB0aGUgc2FtZSBhcyB0aGUgZm9sbG93aW5nOg0KPiAxLiBMb2FkIGEg
YnBmIHByb2dyYW0gdGhhdCByZWFkcyBkYXRhIGZyb20gYSB1c2VyIHN1cHBsaWVkIG1hcCBhbmQg
dGhlbiB3cml0ZXMgdGhlIGRhdGEgaW50byBhIHJpbmcgYnVmZmVyLg0KPiAyLiBVc2VyIHNwYWNl
IGFwcCBwb3B1bGF0ZXMgdGhlIGRhdGEgbWFwIGFuZCB0aGVuIGludm9rZSB0aGUgcHJvZ3JhbSB1
c2luZyBicGZfcHJvZ190ZXN0Lg0KPg0KPiBBc3N1bWluZyB0aGlzIGFwcHJvYWNoIHdvdWxkIGJl
IGNvbnNpZGVyZWQgYSB2YWxpZCB1c2Ugb2YgZUJQRiwgSSB0aGluayB3ZSBjYW4gaW1wbGVtZW50
IHRoZSBBUEkgb24gV2luZG93cyBhcyBwcm9wb3NlZCBiZWxvdy4gSSB3aWxsIGJlIGhhcHB5IHRv
IHdvcmsgd2l0aCB5b3UgdG8gYnVpbGQgYSBzb2x1dGlvbiBvbiBMaW51eCB0aGF0IGlzIGFjY2Vw
dGFibGUgdG8geW91Lg0KPg0KDQpJJ20gc29ycnksIEkgZG9uJ3QgdGhpbmsgSSdsbCBoYXZlIHRp
bWUgdG8gd29yayBvbiB0aGlzLiBCdXQgd2hhdCB5b3UNCmRlc2NyaWJlIGFib3ZlIGFib3V0IHRy
aWdnZXJpbmcgYSBzcGVjaWFsIEJQRiBwcm9ncmFtIHRvIHN1Ym1pdCBkYXRhDQp0byByaW5nYnVm
IGEpIGRvZXNuJ3QgbmVlZCBhbnkgbmV3IEFQSXMgKHdlIGNhbiBkbyB0aGF0IHRvZGF5KSBidXQN
CmFsc28gYikgaXQncyBnb2luZyB0byBiZSBzbG93IGFuZCBhIGJpdCBjdW1iZXJzb21lIHRvIHVz
ZSwgcHJvYmFibHkuDQoNCg0KPiBUaGFua3MsDQo+IFNoYW5rYXINCj4g4Ka24KaC4KaV4KawIOCm
tuCngOCmsg0KPg0KPiBGcm9tOiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaS5uYWtyeWlrb0BnbWFp
bC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyNiwgMjAyNCA0OjQ0IFBNDQo+IFRvOiBT
aGFua2FyIFNlYWwgPFNoYW5rYXIuU2VhbEBtaWNyb3NvZnQuY29tPg0KPiBDYzogU2hhbmthciBT
ZWFsIDxTaGFua2FyLlNlYWw9NDBtaWNyb3NvZnQuY29tQGRtYXJjLmlldGYub3JnPjsgZHRoYWxl
cjE5Njg9NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5pZXRmLm9yZzsgYnBmQGlldGYub3JnOyBicGZA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbQnBmXSBSZTogW0VYVEVSTkFMXSBSRTog
UmU6IFdyaXRpbmcgaW50byBhIHJpbmcgYnVmZmVyIG1hcCBmcm9tIHVzZXIgc3BhY2UNCj4NCj4N
Cj4gPj4gT24gTW9uLCBKdW4gMjQsIDIwMjQgYXQgODo1MOKAr1BNIFNoYW5rYXIgU2VhbCA8bWFp
bHRvOlNoYW5rYXIuU2VhbEBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4NCj4gPj4gSGVyZSBpcyBh
IGJyaWVmIG92ZXJ2aWV3IG9mIHdoYXQgd2UgaW50ZW5kIHRvIGRvIGluIHRoZSBlQlBGIGZvciBX
aW5kb3dzIGNvZGU6DQo+DQo+ID4+ICBUaGUgdXNlciBzcGFjZSBhcHAgd2lsbCBub3QgZGlyZWN0
bHkgd3JpdGUgaW50byB0aGUgdW5kZXJseWluZyByaW5nIGJ1ZmZlciBvZiB0aGUgZUJQRiBtYXAu
IEluc3RlYWQsIHRoZSB1c2VyIGFwcCAodmlhIHRoZSBsaWJicGYgQVBJKSB3aWxsIHNlbmQgdGhl
IGRhdGEgdmlhIGFuIElPQ1RMWzFdIHRvIHRoZSBlQlBGIGNvcmUgKGEgV2luZG93cyBLZXJuZWwg
IERyaXZlclsyXSkgIHRoYXQgbWFuYWdlcyB0aGUgcmluZyBidWZmZXIgbWFwLiBUaGUgZHJpdmVy
IHdpbGwgaW50ZXJuYWxseSBpbnZva2UgdGhlIHNhbWUgY29kZSB0aGF0IGltcGxlbWVudHMgdGhl
IGJwZl9yaW5nYnVmX291dHB1dCBoZWxwZXIgZnVuY3Rpb24gdG8gd3JpdGUgdGhlIHVzZXIgcHJv
dmlkZWQgZGF0YSBidWZmZXIgaW50byB0aGUgcmluZyBidWZmZXIgbWFwLg0KPg0KPiA+PkkgYW0g
bm90IGF3YXJlIG9mIGhvdyB0aGUgcmluZyBidWZmZXIgbWFwIGlzIGltcGxlbWVudGVkIGluIHRo
ZSBMaW51eCBrZXJuZWwuIEJ1dCBwcmVzdW1hYmx5IGEgc2ltaWxhciBhcHByb2FjaCBjb3VsZCBi
ZSB0YWtlbiBpbiBMaW51eCBhcyB3ZWxsPw0KPg0KPiA+PiBbMV0gaHR0cHM6Ly9sZWFybi5taWNy
b3NvZnQuY29tL2VuLXVzL3dpbmRvd3Mvd2luMzIvZGV2aW8vZGV2aWNlLWlucHV0LWFuZC1vdXRw
dXQtY29udHJvbC1pb2N0bC0NCj4NCj4gPj4gWzJdIGh0dHBzOi8vbGVhcm4ubWljcm9zb2Z0LmNv
bS9lbi11cy93aW5kb3dzL3dpbjMyL2RldmlvL2RldmljZS1pbnB1dC1hbmQtb3V0cHV0LWNvbnRy
b2wtaW9jdGwtDQo+DQo+IEkgZG9uJ3QgdGhpbmsgdGhlIExpbnV4IHNpZGUgY2FuL3Nob3VsZCB3
b3JrIGxpa2UgdGhhdC4NCj4NCj4gQWxzbywga2VlcCBpbiBtaW5kIHRoYXQgeW91ciBIVE1MLWJh
c2VkIG1lc3NhZ2VzIGFyZSBub3QgcmVhY2hpbmcgbWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmcu
IFNvIHBsZWFzZSBmaXggeW91ciBIVE1MIHNldCB1cCBhbmQgY29udGludWUgY29udmVyc2F0aW9u
IG92ZXIgbWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmcuDQo+DQo+IFRoYW5rcywNCj4gU2hhbmth
cg0KPiDgprbgpoLgppXgprAg4Ka24KeA4KayDQo+DQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gRnJvbTogQW5kcmlpIE5ha3J5aWtvIDxtYWlsdG86YW5kcmlp
Lm5ha3J5aWtvQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDI0LCAyMDI0IDg6MzYg
UE0NCj4gVG86IFNoYW5rYXIgU2VhbCA8bWFpbHRvOlNoYW5rYXIuU2VhbEBtaWNyb3NvZnQuY29t
Pg0KPiBDYzogU2hhbmthciBTZWFsIDxTaGFua2FyLlNlYWw9bWFpbHRvOjQwbWljcm9zb2Z0LmNv
bUBkbWFyYy5pZXRmLm9yZz47IGR0aGFsZXIxOTY4PW1haWx0bzo0MGdvb2dsZW1haWwuY29tQGRt
YXJjLmlldGYub3JnIDxkdGhhbGVyMTk2OD1tYWlsdG86NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5p
ZXRmLm9yZz47IG1haWx0bzpicGZAaWV0Zi5vcmcgPG1haWx0bzpicGZAaWV0Zi5vcmc+OyBtYWls
dG86YnBmQHZnZXIua2VybmVsLm9yZyA8bWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbQnBmXSBSZTogW0VYVEVSTkFMXSBSRTogUmU6IFdyaXRpbmcgaW50byBhIHJp
bmcgYnVmZmVyIG1hcCBmcm9tIHVzZXIgc3BhY2UNCj4NCj4NCj4NCj4gT24gVGh1LCBKdW4gMjAs
IDIwMjQgYXQgMTE6NDnigK9QTSBTaGFua2FyIFNlYWwgPG1haWx0bzpTaGFua2FyLlNlYWxAbWlj
cm9zb2Z0LmNvbT4gd3JvdGU6DQo+IFNpbmNlIEkgaGF2ZSBub3QgaGVhcmQgYmFjayBvbiB0aGlz
IHRvcGljLCBJIGFtIGFzc3VtaW5nIHRoYXQgdGhlcmUgYXJlIG5vIHN0cm9uZyBvcHBvc2l0aW9u
cyB0byB0aGlzIGlkZWEuDQo+DQo+IFNvIEkgYW0gc2hhcmluZyB0aGUgc2lnbmF0dXJlIG9mIHRo
ZSBwcm9wb3NlZCB1c2VyIEFQSS4NCj4NCj4gICAgICAvKioNCj4gICAgICogQGJyaWVmIFdyaXRl
IGRhdGEgaW50byB0aGUgcmluZyBidWZmZXIgbWFwIGZyb20gdXNlciBzcGFjZS4NCj4gICAgICoN
Cj4gICAgICogQHBhcmFtIHJpbmdfYnVmZmVyX21hcF9mZCByaW5nIGJ1ZmZlciBtYXAgZmlsZSBk
ZXNjcmlwdG9yLg0KPiAgICAgKiBAcGFyYW0gZGF0YSBQb2ludGVyIHRvIGRhdGEgdG8gYmUgd3Jp
dHRlbi4NCj4gICAgICogQHBhcmFtIGRhdGFfbGVuZ3RoIExlbmd0aCBvZiBkYXRhIHRvIGJlIHdy
aXR0ZW4uDQo+ICAgKiBAcmV0dmFsIDAgVGhlIG9wZXJhdGlvbiB3YXMgc3VjY2Vzc2Z1bC4NCj4g
ICAqIEByZXR2YWwgPDAgQW4gZXJyb3Igb2NjdXJlZCwgYW5kIGVycm5vIHdhcyBzZXQuDQo+ICAg
ICAqLw0KPiAgICBpbnQNCj4gICAgcmluZ19idWZmZXJfdXNlcl9fd3JpdGUoDQo+ICAgICAgICBm
ZF90IHJpbmdfYnVmZmVyX21hcF9mZCwgY29uc3Qgdm9pZCogZGF0YSwgc2l6ZV90IGRhdGFfbGVu
Z3RoKTsNCj4NCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMg
YWJvdXQgdGhpcyBBUEkuDQo+DQo+IEkgdGhpbmsgdGhlIGRldmlsIHdpbGwgYmUgaW4gdGhlIGRl
dGFpbHMuIEFQSSBpdHNlbGYgbWFrZXMgc2Vuc2UgKHlvdSBjYW4ndCBzaW1wbGlmeSBpdCBmdXJ0
aGVyIG9yIG1ha2UgaXQgbXVjaCBkaWZmZXJlbnQpLCBpbiB0aGUgZW5kLCB5b3UgYXJlIGp1c3Qg
c2VuZGluZyBhbiBhcnJheSBvZiBieXRlcyBpbnRvIHJpbmdidWYuDQo+DQo+IEJ1dCB0aGUgaW1w
bGVtZW50YXRpb24gZGV0YWlscyBhcmUgd2hhdCBtYXR0ZXJzLiBIb3cgdGhlIG5vdGlmaWNhdGlv
biB3b3Jrcy4gSG93IHVzZXIgc3BhY2Ugd29uJ3QgYnJlYWsga2VybmVsIGV2ZW4gaWYgaW50ZW50
aW9uYWxseSB0cnlpbmcsIGV0Yy4gSXQncyBub3QgY2xlYXIgd2hlcmUgeW91IGludGVuZCB0byBp
bXBsZW1lbnQgdGhpcywgZXRjLg0KPg0KPg0KPiBUaGFua3MsDQo+IFNoYW5rYXINCj4g4Ka24KaC
4KaV4KawIOCmtuCngOCmsg0KPg0KPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQo+IEZyb206IFNoYW5rYXIgU2VhbCA8U2hhbmthci5TZWFsPW1haWx0bzo0MG1p
Y3Jvc29mdC5jb21AZG1hcmMuaWV0Zi5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSA1LCAy
MDI0IDEwOjAxIFBNDQo+IFRvOiBkdGhhbGVyMTk2OD1tYWlsdG86NDBnb29nbGVtYWlsLmNvbUBk
bWFyYy5pZXRmLm9yZyA8ZHRoYWxlcjE5Njg9bWFpbHRvOjQwZ29vZ2xlbWFpbC5jb21AZG1hcmMu
aWV0Zi5vcmc+OyAnQW5kcmlpIE5ha3J5aWtvJyA8bWFpbHRvOmFuZHJpaS5uYWtyeWlrb0BnbWFp
bC5jb20+DQo+IENjOiBtYWlsdG86YnBmQGlldGYub3JnIDxtYWlsdG86YnBmQGlldGYub3JnPjsg
bWFpbHRvOmJwZkB2Z2VyLmtlcm5lbC5vcmcgPG1haWx0bzpicGZAdmdlci5rZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBbQnBmXSBSZTogW0VYVEVSTkFMXSBSRTogUmU6IFdyaXRpbmcgaW50byBhIHJp
bmcgYnVmZmVyIG1hcCBmcm9tIHVzZXIgc3BhY2UNCj4NCj4NCj4gWW91IGRvbid0IG9mdGVuIGdl
dCBlbWFpbCBmcm9tIHNoYW5rYXIuc2VhbD1tYWlsdG86NDBtaWNyb3NvZnQuY29tQGRtYXJjLmll
dGYub3JnLiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24NCj4N
Cj4gVGhhbmtzIERhdmUgYW5kIEFuZHJpaS4NCj4gUGVyIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xl
cy85MDcwNTYvLCB0aGUgQVBJIHRoYXQgeW91IG1lbnRpb25lZA0KPiAicHJvdmlkZXMgc2luZ2xl
LXVzZXItc3BhY2UtcHJvZHVjZXIgLyBzaW5nbGUta2VybmVsLWNvbnN1bWVyIHNlbWFudGljcyBv
dmVyIGEgcmluZyBidWZmZXIuIg0KPg0KPiBCdXQgdGhpcyBpcyBub3QgdGhlIGRlc2lyZWQgYmVo
YXZpb3IgZm9yIG91ciBjYXNlLiBXZSB3YW50IGJvdGggYnBmIHByb2dyYW1zIGluIGtlcm5lbCBt
b2RlIGFuZCB1c2VyIGFwcGxpY2F0aW9uIHRvIGJlIGFibGUgdG8gd3JpdGUgdG8gdGhlIHNhbWUg
cmluZyBidWZmZXIsIHdoaWNoIGNhbiBiZSBjb25zdW1lZCBieSBhIChwb3RlbnRpYWxseSBkaWZm
ZXJlbnQpIHVzZXIgYXBwbGljYXRpb24uDQo+IEFzc3VtaW5nIG5vIHN1Y2ggQVBJIGV4aXN0cywg
ZG8geW91IHNlZSBhbnkgc3Ryb25nIHJlYXNvbiBhZ2FpbnN0IHdyaXRpbmcgc3VjaCBhbiBBUEk/
IElmIG5vdCwgd2Ugd291bGQgbGlrZSB0byBpbXBsZW1lbnQgb25lIGluIGh0dHBzOi8vZ2l0aHVi
LmNvbS9taWNyb3NvZnQvZWJwZi1mb3Itd2luZG93cyBhbmQgZXZlbnR1YWxseSBwcm92aWRlIGEg
TGludXggaW1wbGVtZW50YXRpb24gYXMgd2VsbC4NCj4NCj4gVGhhbmtzLA0KPiBTaGFua2FyDQo+
IOCmtuCmguCmleCmsCDgprbgp4DgprINCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBGcm9tOiBkdGhhbGVyMTk2OD1tYWlsdG86NDBnb29nbGVtYWlsLmNv
bUBkbWFyYy5pZXRmLm9yZyA8ZHRoYWxlcjE5Njg9bWFpbHRvOjQwZ29vZ2xlbWFpbC5jb21AZG1h
cmMuaWV0Zi5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyOCwgMjAyNCAxMDo0MiBBTQ0KPiBU
bzogJ0FuZHJpaSBOYWtyeWlrbycgPG1haWx0bzphbmRyaWkubmFrcnlpa29AZ21haWwuY29tPjsg
U2hhbmthciBTZWFsIDxtYWlsdG86U2hhbmthci5TZWFsQG1pY3Jvc29mdC5jb20+DQo+IENjOiBt
YWlsdG86YnBmQGlldGYub3JnIDxtYWlsdG86YnBmQGlldGYub3JnPjsgbWFpbHRvOmJwZkB2Z2Vy
Lmtlcm5lbC5vcmcgPG1haWx0bzpicGZAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbRVhU
RVJOQUxdIFJFOiBbQnBmXSBSZTogV3JpdGluZyBpbnRvIGEgcmluZyBidWZmZXIgbWFwIGZyb20g
dXNlciBzcGFjZQ0KPg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGR0aGFsZXIx
OTY4PW1haWx0bzo0MGdvb2dsZW1haWwuY29tQGRtYXJjLmlldGYub3JnLiBMZWFybiB3aHkgdGhp
cyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZp
Y2F0aW9uIF0NCj4NCj4gQW5kcmlpIE5ha3J5aWtvIDxtYWlsdG86YW5kcmlpLm5ha3J5aWtvQGdt
YWlsLmNvbT4gd3JvdGU6DQo+DQo+ID4gT24gVHVlLCBNYXkgMjgsIDIwMjQgYXQgOTozMuKAr0FN
IFNoYW5rYXIgU2VhbA0KPiA+IDxTaGFua2FyLlNlYWw9bWFpbHRvOjQwbWljcm9zb2Z0LmNvbUBk
bWFyYy5pZXRmLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gQWRkaW5nIG1haWx0bzpicGZAdmdl
ci5rZXJuZWwub3JnDQo+ID4gPg0KPiA+ID4gQSBjb21tb24gdXNlIGNhc2Ugb2YgYW4gQlBGIHJp
bmcgYnVmZmVyIG1hcCB0byB1c2UgYXMgYSBxdWV1ZSBvZg0KPiA+ID4gZXZlbnRzIGdlbmVyYXRl
ZCBieSBCUEYgcHJvZ3JhbXMgdGhhdCBjYW4gYmUgcmVhZCBpbi1vcmRlciBieSB1c2VyDQo+ID4g
PiBzcGFjZSBhcHBsaWNhdGlvbnMuIEkgaGF2ZSBhIHNjZW5hcmlvIHJlcXVpcmVtZW50IGZvciBh
IHVzZXIgc3BhY2UNCj4gPiA+IGFwcGxpY2F0aW9uIHRvIHdyaXRlIGludG8gYSByaW5nIGJ1ZmZl
ciAob3Igc2ltaWxhcikgbWFwLCBzdWNoIHRoYXQNCj4gPiA+IGV2ZW50cyBieSBCUEYgcHJvZ3Jh
bXMgaW4ga2VybmVsIGFuZCB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucyBhcmUNCj4gPiA+IGludGVy
bGVhdmVkIGluIHRoZSBvcmRlciB0aGV5IHdlcmUgZ2VuZXJhdGVkLCB0aGF0IGNhbiBiZSBjb25z
dW1lZCBieQ0KPiA+ID4gYW5vdGhlciB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uDQo+ID4gPg0KPiA+
ID4gSSB3b3VsZCBsaWtlIHRvIGltcGxlbWVudCB0aGlzIG5ldyBmZWF0dXJlIGluIHRoZQ0KPiA+
IGh0dHBzOi8vZ2l0aHViLmNvbS9taWNyb3NvZnQvZWJwZi1mb3Itd2luZG93cyBwcm9qZWN0LiBC
dXQgYmVmb3JlIEkgZ28gYWhlYWQgd2l0aA0KPiA+IHRoZSBpbXBsZW1lbnRhdGlvbiwgSSB3YW50
ZWQgdG8gY2hlY2sgaWYgdGhlcmUgaXMgYW55IHdheSB0byBhY2NvbXBsaXNoIHRoaXMgaW4NCj4g
PiBMaW51eCB0b2RheT8gSWYgbm90LCBpcyB0aGVyZSBhbnkgcmVhc29uIHdoeSB0aGlzIHNob3Vs
ZCBub3QgYmUgZG9uZT8NCj4gPg0KPiA+IFllcywgdGhlcmUgaXMuIFNlZSB1c2VyX3JpbmdfYnVm
ZmVyIChbMF0sIFsxXSkuDQo+ID4NCj4gPiAgIFswXQ0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90
b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z190ZXN0cy8NCj4gPiB1c2VyX3JpbmdidWYuYw0KPiA+ICAgWzFdDQo+ID4gaHR0cHM6Ly9naXRo
dWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9ncy91c2VyXw0KPiA+IHJpbmdidWZfc3VjY2Vzcy5jDQo+DQo+IEJvdGggb2YgdGhv
c2UgbGlua3MgZ28gdG8gR1BMIGNvZGUgc28gSSBzdXNwZWN0IFNoYW5rYXIgY2Fubm90IHVzZSB0
aG9zZSBsaW5rcy4NCj4gSSB0aGluayB0aGUgYW5zd2VyIGlzIHRoYXQgQlBGX01BUF9UWVBFX1VT
RVJfUklOR0JVRiBpcyBkZWZpbmVkIGZvciB0aGlzDQo+IHB1cnBvc2UgYW5kIFNoYW5rYXIgY2Fu
IHJlYWQgaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzkwNzA1Ni8NCj4NCj4gVGhhbmtzLA0KPiBE
YXZlDQo+DQo+DQoNCi0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1
YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

