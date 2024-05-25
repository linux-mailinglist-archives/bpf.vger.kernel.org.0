Return-Path: <bpf+bounces-30594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194D98CF088
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C572B281EB3
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F51272A0;
	Sat, 25 May 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="LEFGPWj2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="LEFGPWj2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7XEzBtR"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A4126F1F
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659069; cv=none; b=sH2d4QaPoYIN34se09w0XI88dlr5T0rU7OQ1Lc5rwwopPccgIk39Vaz8sfqVG4MCCAgAYFO+dMvU7V1qDWqPB7v73YoDYc6/8Yt2VdwqIA4I0XCXUrSy4AwuUZpTCpTgApVAlrk3B2Bh27X+P4j6vKODZO6tbC0KgFfic68UUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659069; c=relaxed/simple;
	bh=C6v/zMMZ21kBfQGHVF1F+lmH7u7FUdYIhPxveSlvFrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=My082zG+ajDDVbsLRxzUmns0k1V0cTOrqzCIQDs+jky13oJY0S43GAb4CagqbLVSCkUhuqNQpN1biMhnSrhAEn3iqPcWdkJnyuZyMRfIkOVPAUjVAW8ORqF1OBmnEqnkQwQdco4R7H0pvCOrBogWpaYHG1eCmlCsc4F0f9tZBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=LEFGPWj2; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=LEFGPWj2; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7XEzBtR reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6F0B8C14F68D
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716659067; bh=C6v/zMMZ21kBfQGHVF1F+lmH7u7FUdYIhPxveSlvFrs=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=LEFGPWj24aWXioY9o6Z5A+9gfpZ69Wh3cmFe22v9w2N5Bs94oAqa/fdaoy/U1uoDV
	 HjbwJjXkDTCB5zefWxDvYYgdWmIUPSH9v+84OkH4bGGfHgAJTDWhjLaGUrKItyvqFd
	 aIWnrpx1lBAGX4/Jq0UmS0j3dDOY3sWf6x0zBCAc=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Sat May 25 10:44:27 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 539F6C14F6F4
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716659067; bh=C6v/zMMZ21kBfQGHVF1F+lmH7u7FUdYIhPxveSlvFrs=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=LEFGPWj24aWXioY9o6Z5A+9gfpZ69Wh3cmFe22v9w2N5Bs94oAqa/fdaoy/U1uoDV
	 HjbwJjXkDTCB5zefWxDvYYgdWmIUPSH9v+84OkH4bGGfHgAJTDWhjLaGUrKItyvqFd
	 aIWnrpx1lBAGX4/Jq0UmS0j3dDOY3sWf6x0zBCAc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2BDD3C14F5F1
	for <bpf@ietfa.amsl.com>; Sat, 25 May 2024 10:44:21 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8OPzk61Iae6b for <bpf@ietfa.amsl.com>;
	Sat, 25 May 2024 10:44:20 -0700 (PDT)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 3F6E1C14F5EE
	for <bpf@ietf.org>; Sat, 25 May 2024 10:44:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354de3c5c61so3368083f8f.0
        for <bpf@ietf.org>; Sat, 25 May 2024 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716659058; x=1717263858; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y/6C/E6yC7jwML4/leNnl/R6IKBwOgYlfjScoft7K0=;
        b=X7XEzBtRWxkW87NhMj0AnKYoeIl673q8UPsdUKH7SiOHYwIl8pcyrPWWLAO21TQDRP
         6GZryPwkkc9YwPZSTkT2rkWmkeZS/OQHX1uG1fvpPORcBUlWGJXYbbcs13WN5Msg9c4L
         apWjfNrErhURorQTR8k7kXnBn3a5NoWrR/3tioMO7c95XEK1rlaN4cI9GIeUAM811mQX
         TLS7zw/xXuJ3jsY2zh0x+DFx1xdfPbopE1kJkHkLEvE1iVYfxgCx24roWC8cgn9sbPAb
         9pcpvzPsoxKEsXG33Gyo5dC2J/qSMjtaZAJDicQLPyJ3u9f3f767qEvLfwDdo+i/QopL
         VPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716659058; x=1717263858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y/6C/E6yC7jwML4/leNnl/R6IKBwOgYlfjScoft7K0=;
        b=gO2qiSOLvXZUMBFpOuk6ACZe7Mib72duXJYmS6bqnU1bQ3tc7dyQWjfITMEnbjn7BV
         KHRq08K2B/e6QesK0uw6UMqol8n0m1XynH+8XNfclhMRcutz1EfLKYPOc05bX75CyqVc
         CfBByUU5tCs7R+Q9lj5TPD/br9VHMP4Q4KFdtBJKTKcy0hLgqVfz6pszFhRQ99gj9fOr
         llV4l/DfbJ7mtYTK6JYNJGoswV486ztQA41I9YcVpTB6qZYYTARg/tWFPyM+iSwCtqeU
         xaR54XiSKdpsye18fZnbp7ygFVERt6N+lfvx5Oen/30dQEPmP4jMTqjde7vX1/Mo9wVc
         ZWtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ODVfLyMC78CAkkQ6nnsqGEsRs67ZSG3sD9VF2OV19jXb4Jid3I5Y8Y5DagVywXzwPU8+51GPtyOwojA=
X-Gm-Message-State: AOJu0YxaNJzkjnyQY87yyhYBwimITEU9c5JkjNmjiIV3xjz9NAe4XmGQ
	ofy+HTT3HXioJulQl27dn0aeFcj+NUwE0jMV9XMBeVNQ8UUtyZiJp63DYvRs7Fv3kJfwI5asvE4
	tvpB8EmfcCY0RLlzzn9hC5THFw+A=
X-Google-Smtp-Source: 
 AGHT+IEeR8EHRpQXHrkAGqBMMvLFMsaOON/YjrJMVVHxP4+6gP4dg5VC6TvmrNjBEQG20nScLxHC9XugbGvt4sabVLA=
X-Received: by 2002:adf:fa49:0:b0:34d:b549:9465 with SMTP id
 ffacd0b85a97d-35526c5a5acmr3647801f8f.32.1716659058480; Sat, 25 May 2024
 10:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525153332.21355-1-dthaler1968@gmail.com>
In-Reply-To: <20240525153332.21355-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 25 May 2024 10:44:07 -0700
Message-ID: 
 <CAADnVQLr4BGA=CORgcHh0QxWjHhk6p_jHiUY-1iCuJdL1kj7+g@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Message-ID-Hash: REGAOAJ6UT6OI532SFSWH3JCFUO5INWA
X-Message-ID-Hash: REGAOAJ6UT6OI532SFSWH3JCFUO5INWA
X-MailFrom: alexei.starovoitov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf <bpf@vger.kernel.org>, bpf@ietf.org,
 Dave Thaler <dthaler1968@gmail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Clarify_call_l?=
	=?utf-8?q?ocal_offset?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/hxSXZdxdAhWQkGnrsBxhXl0D1_c>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU2F0LCBNYXkgMjUsIDIwMjQgYXQgODozM+KAr0FNIERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2
OEBnb29nbGVtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IEluIHRoZSBKdW1wIGluc3RydWN0aW9ucyBz
ZWN0aW9uIGl0IGV4cGxhaW5zIHRoYXQgdGhlIG9mZnNldCBpcw0KPiAicmVsYXRpdmUgdG8gdGhl
IGluc3RydWN0aW9uIGZvbGxvd2luZyB0aGUganVtcCBpbnN0cnVjdGlvbiIuDQo+IEJ1dCB0aGUg
cHJvZ3JhbS1sb2NhbCBzZWN0aW9uIGNvbmZ1c2luZ2x5IHNhaWQgInJlZmVyZW5jZWQgYnkNCj4g
b2Zmc2V0IGZyb20gdGhlIGNhbGwgaW5zdHJ1Y3Rpb24sIHNpbWlsYXIgdG8gSkEiLg0KPg0KPiBU
aGlzIHBhdGNoIHVwZGF0ZXMgdGhhdCBzZW50ZW5jZSB3aXRoIGNvbnNpc3RlbnQgd29yZGluZywg
c2F5aW5nDQo+IGl0J3MgcmVsYXRpdmUgdG8gdGhlIGluc3RydWN0aW9uIGZvbGxvd2luZyB0aGUg
Y2FsbCBpbnN0cnVjdGlvbi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGF2ZSBUaGFsZXIgPGR0aGFs
ZXIxOTY4QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6
YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgYi9Eb2N1bWVudGF0aW9u
L2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPiBpbmRleCAwMGM5M2Vi
NDIuLjZiYjVhZTdlNCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRp
emF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9icGYvc3Rh
bmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4gQEAgLTUyMCw3ICs1MjAsNyBAQCBp
ZGVudGlmaWVzIHRoZSBoZWxwZXIgbmFtZSBhbmQgdHlwZS4NCj4gIFByb2dyYW0tbG9jYWwgZnVu
Y3Rpb25zDQo+ICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgUHJvZ3JhbS1sb2NhbCBmdW5j
dGlvbnMgYXJlIGZ1bmN0aW9ucyBleHBvc2VkIGJ5IHRoZSBzYW1lIEJQRiBwcm9ncmFtIGFzIHRo
ZQ0KPiAtY2FsbGVyLCBhbmQgYXJlIHJlZmVyZW5jZWQgYnkgb2Zmc2V0IGZyb20gdGhlIGNhbGwg
aW5zdHJ1Y3Rpb24sIHNpbWlsYXIgdG8NCj4gK2NhbGxlciwgYW5kIGFyZSByZWZlcmVuY2VkIGJ5
IG9mZnNldCBmcm9tIHRoZSBpbnN0cnVjdGlvbiBmb2xsb3dpbmcgdGhlIGNhbGwgaW5zdHJ1Y3Rp
b24sIHNpbWlsYXIgdG8NCj4gIGBgSkFgYC4gIFRoZSBvZmZzZXQgaXMgZW5jb2RlZCBpbiB0aGUg
J2ltbScgZmllbGQgb2YgdGhlIGNhbGwgaW5zdHJ1Y3Rpb24uDQo+ICBBbiBgYEVYSVRgYCB3aXRo
aW4gdGhlIHByb2dyYW0tbG9jYWwgZnVuY3Rpb24gd2lsbCByZXR1cm4gdG8gdGhlIGNhbGxlci4N
Cg0KSSByZWZvcm1hdHRlZCBhIGZldyBmb2xsb3dpbmcgbGluZXMgdG8gbWFrZSBpdCBmaXQgaW50
byA4MCBjb2wgd2hpbGUNCmFwcGx5aW5nLiBUaGFua3MhDQoNCi0tIApCcGYgbWFpbGluZyBsaXN0
IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2
ZUBpZXRmLm9yZwo=

