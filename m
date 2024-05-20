Return-Path: <bpf+bounces-30062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33E8CA52E
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA23B21935
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3993751C2A;
	Mon, 20 May 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aNleFvPY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VpzCKH9o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WKVDSGvZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB313F9FB
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248657; cv=none; b=cmNxsyxf2eJnX/AlXnUl0u5Gojnd1p1hwkJtoQGMOuv9tS16SEkehCpYMum1zLQjcAB/aRY1DpCg+939X7s1Jzx+OHk1IXbDkTqRfIMA7BTcDZyJCDWjgeYhdCbNeNDA+QnaeOPo9MxgFGpB37fU1Pi0xO81Q9FWQzAChx5QAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248657; c=relaxed/simple;
	bh=uaItzoT4KzilVh3hkAshdtx9mCvViEww+6AFwvXT8gE=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=HsVyrJ4M0Zl3c5cKRHjyrkwf8N1Z+Tl+Tp57Le9lZUa7JD0dR4S45uA97qwgk3lkhDZrHDtnvUobBMkS174Z+u9gYwxPzo5J3V3NucJG8BGiGbd15qgNRUHD5qk8YwokBt8pNZtS0IaYcQLn9t7/N+dvu1vAK5sUyQmdgWg7Dy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aNleFvPY; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=VpzCKH9o reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WKVDSGvZ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 901EDC1C3D7A
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716248655; bh=uaItzoT4KzilVh3hkAshdtx9mCvViEww+6AFwvXT8gE=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aNleFvPY8pOlzg0jOgRkIOUvpoN8Pm7zqL8f43yZKknTWOCmDXbnII04Y5QSry/JN
	 GJI3CCjdpxkx86UK4unOSJSWS7rFZgaXkR4TigJogtqLU8tx5vWTfd0GnWaPdVejZg
	 4R5LamnONPZfr36504fItxfFbfZAod46MAFrie9o=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6CEA0C1CAF42
 for <bpf@vger.kernel.org>; Mon, 20 May 2024 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1716248655; bh=uaItzoT4KzilVh3hkAshdtx9mCvViEww+6AFwvXT8gE=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=VpzCKH9o30dhkaffqnBfgOeusuYvsrJzmXJx6owaQUMygscHFIW5M9rcV6g+a68U1
 11HxHfevDfxxh3ADDKcfIjQZrj5HCX0XRLkc5Sggw+HEr+V8IiYVlnCHszVsp5jx5V
 0ggEoNOhBoke4NyVK2oHNjVqJmysmEj0VCoeprm8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 97D44C1C3D69
 for <bpf@ietfa.amsl.com>; Mon, 20 May 2024 16:44:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BaZ5f-ZFjd-F for <bpf@ietfa.amsl.com>;
 Mon, 20 May 2024 16:44:00 -0700 (PDT)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B973EC1C3D68
 for <bpf@ietf.org>; Mon, 20 May 2024 16:44:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ec486198b6so84595785ad.1
 for <bpf@ietf.org>; Mon, 20 May 2024 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1716248639; x=1716853439;
 darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CiGU66ticLbjDoYRbCThnU9FDJrB3guBcEjgVyBFEvA=;
 b=WKVDSGvZiG0mT8pN2Un9i26R/Bkgjcsxrld6U2EIHmCIh/QAN11zRolU5oWSs15cXt
 UWouF4v2KNrdZu1GsfDyu7XszbJATINNEjf8WrRv0FiNIlL8gD3ljRvJY2YaK5obUOwK
 wNrejiZm9AUtAzXHRPuXMR9t1FV4Vw5VIaxsLVRfWo6SuSew3Wj539d5Umihirc7iE7V
 ME6yhuij7i7lWacoFSSaDzd1+c60RHsBaPLt8aWZFkSqBfxVCDsLJPMhyiqVBQlZIfIb
 H7CMBHwAQNlQHx5rHYBzNZqMb3shYYUoPd4INvNPhjH9JcxJ/kl1tidFnp+6PbBhTfIG
 5Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716248639; x=1716853439;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CiGU66ticLbjDoYRbCThnU9FDJrB3guBcEjgVyBFEvA=;
 b=xHB7MNGDAWnRpMy4abXyVVG1Yzq8M1X+ajg9so6I4SE/mFySPrthARFRx9TdgaiClo
 3Fhv+kg1nMuT5h9buk23ftp8DXP34P78dohLqdW/Ue4SzQ0+BKG4UYGLFxSEBNyJ/hQD
 EHer7OarrcgJB2QN32sN9owR1q1BLKj2cwVCXJDpfFNCgqXEeQGeSqrYzbdW4MGuXj7U
 PmjpFBb37SnuhzeHze/6dutkk1StGCKM4iLGgMIqCqgN8mPuV/gjkJrcjCpp38NO4Dcv
 w1nzS1kdkgccnPd/YBv+uRJRP75OXgJkbQclguTLAhJeAMgwn+0ldetyVu4jv/gHNIzK
 1DAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmfEA6YawpN5fFSks5xgV8Gr2YfJO2A1jjIUhBl7fo8oTmrVzU8YkELGwGlESv/7VUO+jOiHj7xB7zH2c=
X-Gm-Message-State: AOJu0YyHI2MfSzy+Op5MipNgEX5/fYM6jngAEE184hO6OaQ+x7KLa75X
 F7AuBuDGduchnH00KLShMXxvb8+Joypr4HDx2rT7nJeYq56ez/qccr29UISu
X-Google-Smtp-Source: AGHT+IEGLoYUoVxx2IRUa5wVUIQlnERcuWSCfkZQspz8l2OdgRBy6qcrlqV3FUwzRaIvDb8T+ICPkQ==
X-Received: by 2002:a05:6a20:1591:b0:1b0:194a:830c with SMTP id
 adf61e73a8af0-1b0194a8502mr18892516637.56.1716248639554;
 Mon, 20 May 2024 16:43:59 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2aa01dasm20160764b3a.92.2024.05.20.16.43.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 May 2024 16:43:59 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
 "'Dave Thaler'" <dthaler1968@googlemail.com>
References: <20240517165855.4688-1-dthaler1968@gmail.com>
 <20240520231829.GC1116559@maniforge>
In-Reply-To: <20240520231829.GC1116559@maniforge>
Date: Mon, 20 May 2024 16:43:56 -0700
Message-ID: <089c01daab0f$959a2fa0$c0ce8ee0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMNxtSz5Xxdo4l4z3k03OfsZBHpawMKs2HjryI7ZiA=
Content-Language: en-us
Message-ID-Hash: VRTFACRMSBQRREJQMJEPSE6RQUCE6G2N
X-Message-ID-Hash: VRTFACRMSBQRREJQMJEPSE6RQUCE6G2N
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@vger.kernel.org, bpf@ietf.org
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Use_RFC_2119_l?=
 =?utf-8?q?anguage_for_ISA_requirements?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Q-KNs8QLOtsE3ImSz__eqVv2ops>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgVmVybmV0IDx2
b2lkQG1hbmlmYXVsdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDIwLCAyMDI0IDQ6MTggUE0N
Cj4gVG86IERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbT4NCj4gQ2M6IGJw
ZkB2Z2VyLmtlcm5lbC5vcmc7IGJwZkBpZXRmLm9yZzsgRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4
QGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBicGYtbmV4dF0gYnBmLCBkb2NzOiBV
c2UgUkZDIDIxMTkgbGFuZ3VhZ2UgZm9yIElTQQ0KPiByZXF1aXJlbWVudHMNCj4gDQo+IE9uIEZy
aSwgTWF5IDE3LCAyMDI0IGF0IDA5OjU4OjU1QU0gLTA3MDAsIERhdmUgVGhhbGVyIHdyb3RlOg0K
PiA+IFBlciBJRVRGIGNvbnZlbnRpb24gYW5kIGRpc2N1c3Npb24gYXQgTFNGL01NL0JQRiwgdXNl
IE1VU1QgZXRjLg0KPiA+IGtleXdvcmRzIGFzIHJlcXVlc3RlZCBieSBJRVRGIEFyZWEgRGlyZWN0
b3IgcmV2aWV3LiAgQWxzbyBhcw0KPiA+IHJlcXVlc3RlZCwgaW5kaWNhdGUgdGhhdCBkb2N1bWVu
dGluZyBCVEYgaXMgb3V0IG9mIHNjb3BlIG9mIHRoaXMNCj4gPiBkb2N1bWVudCBhbmQgd2lsbCBi
ZSBjb3ZlcmVkIGJ5IGEgc2VwYXJhdGUgSUVURiBzcGVjaWZpY2F0aW9uLg0KPiA+DQo+ID4gQWRk
ZWQgcGFyYWdyYXBoIGFib3V0IHRoZSB0ZXJtaW5vbG9neSB0aGF0IGlzIHJlcXVpcmVkIElFVEYN
Cj4gPiBib2lsZXJwbGF0ZSBhbmQgbXVzdCBiZSB3b3JkZWQgZXhhY3RseSBhcyBzdWNoLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwu
Y29tPg0KPiANCj4gQWNrZWQtYnk6IERhdmlkIFZlcm5ldCA8dm9pZEBtYW5pZmF1bHQuY29tPg0K
PiANCj4gV2Ugc3RpbGwgaGF2ZSAibWF5IiBpbiBhIGNvdXBsZSBvZiBwbGFjZXMsIGFzIGluIGUu
Zy46DQo+IA0KPiBOb3RlIHRoYXQgdGhlcmUgYXJlIHR3byBmbGF2b3JzIG9mIGBgSkFgYCBpbnN0
cnVjdGlvbnMuIFRoZSBgYEpNUGBgIGNsYXNzDQpwZXJtaXRzIGENCj4gMTYtYml0IGp1bXAgb2Zm
c2V0IHNwZWNpZmllZCBieSB0aGUgJ29mZnNldCcgZmllbGQsIHdoZXJlYXMgdGhlIGBgSk1QMzJg
YA0KY2xhc3MNCj4gcGVybWl0cyBhIDMyLWJpdCBqdW1wIG9mZnNldCBzcGVjaWZpZWQgYnkgdGhl
ICdpbW0nIGZpZWxkLiBBID4gMTYtYml0DQpjb25kaXRpb25hbCBqdW1wDQo+IG1heSBiZSBjb252
ZXJ0ZWQgdG8gYSA8IDE2LWJpdCBjb25kaXRpb25hbCBqdW1wIHBsdXMgYSAzMi1iaXQNCnVuY29u
ZGl0aW9uYWwganVtcC4NCj4gDQo+IEFsc28gaW4gdGhlICJIZWxwZXIgZnVuY3Rpb25zIiBhbmQg
Ik1hcHMiIHNlY3Rpb25zLg0KPiANCj4gRG8gd2UgbmVlZCB0byBmaXggdGhvc2UgYXMgd2VsbD8g
T3IgYXJlIHRoZXkgY29uc2lkZXJlZCBzZW1hbnRpY2FsbHkNCmRpZmZlcmVudA0KPiB0aGFuIGhv
dyBSRkMgMjExOSB3b3VsZCBkZWZpbmUgdGhlIHRlcm1zPw0KDQpUaG9zZSBhcmUgc2VtYW50aWNh
bGx5IGRpZmZlcmVudCAoaS5lLiwgSSBsZWZ0IHRoZW0gaW50ZW50aW9uYWxseSkgYXMgdGhleQ0K
YXJlIG5vdA0Kbm9ybWF0aXZlIHN0YXRlbWVudHMgYWJvdXQgd2hhdCBhbiBJU0EgaW1wbGVtZW50
ZXIgd291bGQgY2hvb3NlIHRvIGRvIG9yIG5vdA0KZG8sIGJ1dCByYXRoZXIgaW5mb3JtYXRpdmUg
c3RhdGVtZW50cyB0byB0aGUgcmVhZGVyIHRoYXQgd291bGQgYmUgc3lub255bW91cw0Kd2l0aA0K
ImNhbiIgb3IgIm1pZ2h0IiBpbiBteSByZWFkaW5nLg0KDQpEYXZlDQo+IA0KPiBUaGFua3MsDQo+
IERhdmlkDQoNCi0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

