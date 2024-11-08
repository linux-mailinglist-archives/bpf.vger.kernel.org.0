Return-Path: <bpf+bounces-44314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F079C1414
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 03:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF52B24805
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BCE1BC3F;
	Fri,  8 Nov 2024 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="rPMrcKvq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="N1OU156l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aGB82qOl"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C31BD9D1
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033106; cv=none; b=g+5ISrXoF6pEBXhfhmNs+iihfwqfM4wLALhifl89A6UWZ1TN0WDZg8BqDrjmcTa13fyJV6W192vhD0AgvmI+mUZYqIbrHq3IHoiWTT4glOIYCECP9GKVa7ncwb59fQJGAs8kO0E7+A41W2LkhVKe2WxagBXOeHiPvwGCJyZPz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033106; c=relaxed/simple;
	bh=GDHOlpak/TT2QzeNdTepknV0Xg6uaUjv7NolVSwAyaI=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=CmfVsAYZ7ywAZ4vSvchQYpEg1oFaCLjx1mrpbUmnvTkp+uObsGC2AabzpYdcGG2lnWlFtmgORJ5K1xAytgby87qCuQmDBgMh/5/TidEa5g3TWgGKT3eCQNaPxoFdbpAq10WsIBXziE1LSjWiWsP4JPxEnhhhrCRhvEcYLB6C8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=rPMrcKvq; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=N1OU156l reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aGB82qOl reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4CBA5C217BC4
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 18:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731033088; bh=GDHOlpak/TT2QzeNdTepknV0Xg6uaUjv7NolVSwAyaI=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rPMrcKvqhd0wOvaRdodWV1rpU4gv9cJnryLriJ6vg74KZKjWza1UdZdK1UOyOT3uK
	 mPkQ1t+dghZz/q60IuSVzXFD15rAQrRNb99xHX70Mv27Q7NdYZ4twZeOkRYWRYcHmg
	 XtosIdg4oAwr+VwmAhnERRa67FVzDpvAsleEJXCE=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 332E1C217BC6
 for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 18:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1731033088; bh=GDHOlpak/TT2QzeNdTepknV0Xg6uaUjv7NolVSwAyaI=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=N1OU156lFyH6Lx3wvPfGtTkpFMAAUdc3lyohmkbsuzhjef0zto+QPk02Ro5V85m7b
 AFFUdqMjcWIPtr2S5obFgUZteDTIblZg7qweshbnzqZhpY1hLWdAY17pudzwq8pBCT
 wATzfsPCfDoR5gkPeFVyCUSm1kAi8i03yySy76uc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AA564C09E1D3
 for <bpf@ietfa.amsl.com>; Thu,  7 Nov 2024 18:30:10 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wUpC_SzXcE1S for <bpf@ietfa.amsl.com>;
 Thu,  7 Nov 2024 18:30:06 -0800 (PST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 85B3CC1D6FA0
 for <bpf@ietf.org>; Thu,  7 Nov 2024 18:30:06 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-72410cc7be9so782022b3a.0
 for <bpf@ietf.org>; Thu, 07 Nov 2024 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1731033006; x=1731637806;
 darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xhz/+s7HYtJld+Ohgk7s3Y+hFW8YWP51r5v5/v6WmiQ=;
 b=aGB82qOloCHgN6Oa4NfhMiMSB7Y80WriT2V7Cv5CXWT8/aeeqtqVnOpgizr8nMtIVD
 nmiw2Jq76WI4PlOBQXQPeRhH/fzVpsjxqicLe2cROgSouI3c4EqiKBo/gL2Q5YiguD80
 N+RVUq0EHcSNwMuOnP2eVaY+zLXZeESpoB87twJYLff6AK0TsCjOWqit0mAJzs51zcbA
 F8SiL5QSqmP/tj1otFJGHsnNFi7vC/05zdxqUeT6ojWINviy2Y3jzrkpOGOsMxPIlfvF
 Nkke+NPUJntJ1zBR1LHNLpUhp3izkMvpUVlRr37VKj+sN2B7jwcp9lUrTJmsaROJ852R
 4xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731033006; x=1731637806;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xhz/+s7HYtJld+Ohgk7s3Y+hFW8YWP51r5v5/v6WmiQ=;
 b=wxKDSyVGb0BYtY3GqzvzAi8PO3KowOVggxCcbUNFndHrpTWRWiBEv9sG3g0RkistSJ
 Qxm6IfYimHjEyKSwhg3syq0XERL65jxICo//R5PmUc6MbYBf5FplwoPB+5AFEH1jhxpb
 9uKbXLGv1CJB7+rtnWKS/snI7vmMfYGzh4cIPF2e9pqMxGXW5Swage8eWDImBaSA2SVn
 rLxqf1JNTneLqi0++Q9IFSC80U8lBizW57Ts43His+4CaP+oLzZTAozcwS42vW50FQRw
 bDYnJScfOurVH9BDlCsLYxgut56wAUaNKHe5cpbjc+2wWFbznEf4qE2tva7Fv1kypGQX
 v0dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzU1Fsj33lDud0LyavOZf5S6oeeVsCXOU4t6o+EHRBHT9A5iOq6klgQUk0/2SRycM7cAc=@ietf.org
X-Gm-Message-State: AOJu0YxHoZa782DdrYAj28b9UI3ucU6uIvwMBKMR1PFIWJlDlSEOASUa
 dedGa5pEYKjbtEHRJYZLE0BFFU5OtHde1s2zSn4krHcgunhB7125
X-Google-Smtp-Source: AGHT+IFw4wElaScxFYGSH2hirpJZsTiiw+Xs+JS9M8pPlhrIJkzu8dJhCGqFCu3QGdFMyevCmsbIVA==
X-Received: by 2002:a05:6a21:7881:b0:1d9:2408:aa4c with SMTP id
 adf61e73a8af0-1dc2299e40bmr1403146637.23.1731033005719;
 Thu, 07 Nov 2024 18:30:05 -0800 (PST)
Received: from ArmidaleLaptop (64-119-15-60.fiber.ric.network. [64.119.15.60])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9a5fd17e9sm2590748a91.39.2024.11.07.18.30.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2024 18:30:04 -0800 (PST)
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
In-Reply-To: <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
Date: Thu, 7 Nov 2024 18:30:00 -0800
Message-ID: <000c01db3186$1dd30930$59791b90$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKzqMffW8FFfWCd3ulEKsb+gfc3egGOkjXjAfqQ6mkCtID1/gMZ/eqXsLDVueA=
Content-Language: en-us
Message-ID-Hash: B5LSS6HO4OJVOKFIM4SQ3GOSLRVQTIRJ
X-Message-ID-Hash: B5LSS6HO4OJVOKFIM4SQ3GOSLRVQTIRJ
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
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ErY4L7cQByqrEFhSj87d4O3VlTM>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

DQpBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3Rl
Og0KPiBPbiBUdWUsIE9jdCAxLCAyMDI0IGF0IDEyOjU04oCvUE0gRGF2ZSBUaGFsZXIgPGR0aGFs
ZXIxOTY4QGdvb2dsZW1haWwuY29tPg0KPiB3cm90ZToNClsuLi5dDQo+ID4gSSdtIGFkZGluZyBi
cGZAaWV0Zi5vcmcgdG8gdGhlIFRvIGxpbmUgc2luY2UgYWxsIGNoYW5nZXMgaW4gdGhlDQo+ID4g
c3RhbmRhcmRpemF0aW9uIGRpcmVjdG9yeSBzaG91bGQgaW5jbHVkZSB0aGF0IG1haWxpbmcgbGlz
dC4NCj4gPg0KPiA+IFRoZSBXRyBzaG91bGQgZGlzY3VzcyB3aGV0aGVyIGFueSBjaGFuZ2VzIHNo
b3VsZCBiZSBkb25lIHZpYSBhIG5ldyBSRkMNCj4gPiB0aGF0IG9ic29sZXRlcyB0aGUgZmlyc3Qg
b25lLCBvciBhcyBSRkNzIHRoYXQgVXBkYXRlIGFuZCBqdXN0IGRlc2NyaWJlDQo+ID4gZGVsdGFz
IChhZGRpdGlvbnMsIGV0Yy4pLg0KPiA+DQo+ID4gVGhlcmUgYXJlIHByZWNlZGVudHMgYm90aCB3
YXlzIGFuZCBJIGRvbid0IGhhdmUgYSBzdHJvbmcgcHJlZmVyZW5jZSwNCj4gPiBidXQgSSBoYXZl
IGEgd2VhayBwcmVmZXJlbmNlIGZvciBkZWx0YS1iYXNlZCBvbmVzIHNpbmNlIHRoZXkncmUNCj4g
PiBzaG9ydGVyIGFuZCBhcmUgbGVzcyBsaWtlbHkgdG8gcmUtb3BlbiBkaXNjdXNzaW9uIG9uIHBy
ZXZpb3VzbHkNCj4gPiByZXNvbHZlZCBpc3N1ZXMsIHRodXMgb2Z0ZW4gc2F2aW5nIHRoZSBXRyB0
aW1lLg0KPiANCj4gRGVsdGEtYmFzZWQgYWRkaXRpb25zIG1ha2Ugc2Vuc2UgdG8gbWUuDQo+IA0K
PiA+IEFsc28gRllJIHRvIExpbnV4IGtlcm5lbCBmb2xrczoNCj4gPiBXaXRoIFdHIGFuZCBBRCBh
cHByb3ZhbCwgaXQncyBhbHNvIHBvc3NpYmxlIChidXQgbm90IGlkZWFsKSB0byB0YWtlDQo+ID4g
Y2hhbmdlcyBhdCBBVVRINDguICBUaGF0J2QgYmUgdXAgdG8gdGhlIGNoYWlycyBhbmQgQUQgdG8g
ZGVjaWRlDQo+ID4gdGhvdWdoLCBhbmQgbm9ybWFsbHkgdGhhdCdzIGp1c3QgZm9yIHB1cmVseSBl
ZGl0b3JpYWwgY2xhcmlmaWNhdGlvbnMsDQo+ID4gZS5nLiwgdG8gY29uZnVzaW9uIGNhbGxlZCBv
dXQgYnkgdGhlIFJGQyBlZGl0b3IgcGFzcy4NCj4gDQo+IEFsc28gYWdyZWUuIFdlIHNob3VsZCBr
ZWVwIEFVVEggZ29pbmcgaXRzIGNvdXJzZSBhcy1pcy4NCj4gQWxsIElTQSBhZGRpdGlvbnMgY2Fu
IGJlIGluIHRoZSBmdXR1cmUgZGVsdGEgUkZDLg0KPiANCj4gQXMgZmFyIGFzIGZpbGUgbG9naXN0
aWNzLi4uIG15IHByZWZlcmVuY2UgaXMgdG8ga2VlcA0KPiBEb2N1bWVudGF0aW9uL2JwZi9zdGFu
ZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPiB1cCB0byBkYXRlLg0KPiBSaWdodCBu
b3cgaXQncyBlZmZlY3RpdmVseSBmcm96ZW4gd2hpbGUgYXdhaXRpbmcgY2hhbmdlcyAoaWYgYW55
KSBuZWNlc3NhcnkgZm9yIEFVVEguDQo+IEFmdGVyIG9mZmljaWFsIFJGQyBpcyBpc3N1ZWQgd2Ug
Y2FuIHN0YXJ0IGxhbmRpbmcgcGF0Y2hlcyBpbnRvIGluc3RydWN0aW9uLXNldC5yc3QgYW5kDQo+
IGdpdCBkaWZmIDA0ZWZhZWJkNzJkMS4ud2hhdGV2ZXJfZnV0dXJlX3NoYSBpbnN0cnVjdGlvbi1z
ZXQucnN0IHdpbGwgYXV0b21hdGljYWxseQ0KPiBnZW5lcmF0ZSB0aGUgZnV0dXJlIGRlbHRhIFJG
Qy4NCj4gT25jZSBSRkMgbnVtYmVyIGlzIGlzc3VlZCB3ZSBjYW4gYWRkIGEgZ2l0IHRhZyBmb3Ig
dGhlIHBhcnRpY3VsYXIgc2hhIHRoYXQgd2FzIHRoZQ0KPiBiYXNlIGZvciBSRkMgYXMgYSBkb2N1
bWVudGF0aW9uIHN0ZXAgYW5kIHRvIHNpbXBsaWZ5IGZ1dHVyZSAnZ2l0IGRpZmYnLg0KDQpNeSBj
b25jZXJuIGlzIHRoYXQgaW5kZXgucnN0IHNheXM6DQo+IFRoaXMgZGlyZWN0b3J5IGNvbnRhaW5z
IGRvY3VtZW50cyB0aGF0IGFyZSBiZWluZyBpdGVyYXRlZCBvbiBhcyBwYXJ0IG9mIHRoZSBCUEYN
Cj4gc3RhbmRhcmRpemF0aW9uIGVmZm9ydCB3aXRoIHRoZSBJRVRGLiBTZWUgdGhlIGBJRVRGIEJQ
RiBXb3JraW5nIEdyb3VwYF8gcGFnZQ0KPiBmb3IgdGhlIHdvcmtpbmcgZ3JvdXAgY2hhcnRlciwg
ZG9jdW1lbnRzLCBhbmQgbW9yZS4NCg0KU28gaGF2aW5nIGEgZG9jdW1lbnQgdGhhdCBpcyBOT1Qg
cGFydCBvZiB0aGUgSUVURiBCUEYgV29ya2luZyBHcm91cCB3b3VsZCBzZWVtDQpvdXQgb2YgcGxh
Y2UgYW5kLCBpbiBteSB2aWV3LCBiZXR0ZXIgbG9jYXRlZCB1cCBhIGxldmVsIChvdXRzaWRlIHN0
YW5kYXJkaXphdGlvbikuDQoNCkhlcmXigJlzIHNvbWUgZXhhbXBsZXMgb2YgZGVsdGEtYmFzZWQg
UkZDcyB3aGljaCBleHBsYWluIHRoZSBnYXAgYW5kIHByb3ZpZGUNCnRoZSBhZGRpdGlvbiBvciBj
bGFyaWZpY2F0aW9uLCBhbmQgZm9ybWFsbHkgVXBkYXRlIChub3QgcmVwbGFjZS9vYnNvbGV0ZSkg
dGhlIG9yaWdpbmFsDQpSRkM6DQoqIGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmM2
NTg1Lmh0bWw6IEFkZGl0aW9uYWwgSFRUUCBTdGF0dXMgQ29kZXMNCiogaHR0cHM6Ly93d3cucmZj
LWVkaXRvci5vcmcvcmZjL3JmYzY4NDAuaHRtbDogQ2xhcmlmaWNhdGlvbnMgYW5kIEltcGxlbWVu
dGF0aW9uIE5vdGVzDQogICBmb3IgRE5TIFNlY3VyaXR5IChETlNTRUMpDQoqIGh0dHBzOi8vd3d3
LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmM5Mjk1Lmh0bWw6IENsYXJpZmljYXRpb25zIGZvciBFZDI1
NTE5LCBFZDQ0OCwNCiAgIFgyNTUxOSwgYW5kIFg0NDggQWxnb3JpdGhtIElkZW50aWZpZXJzDQoq
IGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmM1NzU2Lmh0bWw6IFVwZGF0ZXMgZm9y
IFJTQUVTLU9BRVAgYW5kIA0KICAgUlNBU1NBLVBTUyBBbGdvcml0aG0gUGFyYW1ldGVycw0KDQpI
YXZpbmcgYSBmdWxsIGRvY3VtZW50IHRvbyBpcyB2YWx1YWJsZSBidXQgdW5sZXNzIHRoZSBJRVRG
IEJQRiBXRw0KZGVjaWRlcyB0byB0YWtlIG9uIGEgLWJpcyBkb2N1bWVudCwgSSdkIHN1Z2dlc3Qg
a2VlcGluZyBpdCBvdXQgb2YgdGhlICJzdGFuZGFyZGl6YXRpb24iDQooc2F5IHVwIDEgbGV2ZWwp
IHRvIGF2b2lkIGNvbmZ1c2lvbiwgYW5kIGp1c3QgaGF2ZSBvbmUgb3IgbW9yZSBkZWx0YS1iYXNl
ZCByc3QgZmlsZXMNCmluIHRoZSBzdGFuZGFyZGl6YXRpb24gZGlyZWN0b3J5Lg0KDQpEYXZlDQoN
Cg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

