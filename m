Return-Path: <bpf+bounces-32639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FEC9112AC
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76EAB226C0
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8EB1BA065;
	Thu, 20 Jun 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YMbk9imI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="IRDVprAi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b1BIYaDx"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052004778C
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913592; cv=none; b=I4xHn0+i7ieCHk1RUnuZ2Sw1BdTLQtlz8I5dBricBl3KnzufMJjCjASTmEylfUMKDkBmGAe5GAs8yZMiLzKIN5YSAAcNubF07IzzqyFcwwJIejjXdS0PqwAWDJrj3YFu0ZsgMGTnjma/qIJ1OsXRgaNXwho2zzgY/Lw170okyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913592; c=relaxed/simple;
	bh=oksPWW9CKatm0Uz/QCIWCWwccyyEqkRuZpHTQBYs/pw=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=u4TaO9yEgxHO/FVPrK1ZxZnlrqWBsEDOP0mqW2TtrncPsyvda0ro7/BfkiGBui9tAfFooP3EaPlC/lipN1238Afy/4+rtuwOZZBPRo0wtIaxELad1c+ZQfdg1fPj4QionNJcYGFA/+zz0kkgS4STtjSetVue3TRBBSH2CwxvNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=YMbk9imI; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=IRDVprAi reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=b1BIYaDx reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6641FC169421
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1718913590; bh=oksPWW9CKatm0Uz/QCIWCWwccyyEqkRuZpHTQBYs/pw=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YMbk9imIEDn387OclQf/sqWxOxBj0sadFpzlekSp9yT/7DxApr79TWvgFmUMmWmRL
	 j7RaSTjITEdBL6SrEwOPOFNQktnLhGKYtr8M1x8cQzLlCcScIxcDG5CDAUItp+0rBB
	 Sg4AtVtonMs97R67DM5ay9QKyqZZWYDzygi03I/s=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4590DC16941E
 for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1718913590; bh=oksPWW9CKatm0Uz/QCIWCWwccyyEqkRuZpHTQBYs/pw=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=IRDVprAitdB/S3inLSE7mJWdJRZup0AUxDO6lp6XkuDn/EHCElBLQOvKwNKxYOFFP
 kH1RZJTw5yORo0TKfevoYcBqK6PX39tS+7hKJEIwx0HXoxZf58QGg+B7tgfQjs9eLa
 fK49UayK50phpLoOORQr3rZGDFLZA1oJr5voSbKs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 85AEAC14F6F4;
 Thu, 20 Jun 2024 12:59:47 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.857
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pgRl0aQJXLSR; Thu, 20 Jun 2024 12:59:43 -0700 (PDT)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9ED00C14F6AA;
 Thu, 20 Jun 2024 12:59:43 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-63bca6db118so12759427b3.3;
 Thu, 20 Jun 2024 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1718913582; x=1719518382;
 darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s1gm4mrkLYYNsR1aNVEW8CLMsBv5dgCHIpVEZYhiuGs=;
 b=b1BIYaDxXgPsIUfsy/FoQ32GJ+aQCfUwT51pBHbRwvt7AqIx062RFbN4OG/CD/Ddqk
 tKbK4VCuiL2tW1H+pEjtM8F0UdmQ3+ytU3amzsVxuj2ao85wIUbMFkrcfB2HyWcZonnR
 qXnYK7jBRQVCmaarrSdXJuzpXJiDAluKOrc/F7OyQwy2gUviFKGsJZyXwRuh0GMl/Lbg
 hHt8tyQRBXZuzu/52dXCoiQmEHBF3h4Zym4lZ1xLOp2DXFo0MG/FGCkpbpft+glCwlEa
 sif38nheAK7E7HkeUes6EZblmLZJSJ545+Wvrry6oHf8T/i7nyxkbZSVET0XiqBIUpIG
 LWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913582; x=1719518382;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1gm4mrkLYYNsR1aNVEW8CLMsBv5dgCHIpVEZYhiuGs=;
 b=u0OJkwUzpHHG0i8qBjtzuwLiljK9ngW8rIGLeofFbeiX9ZHtAkMRiQn78ykIMMUPVu
 9CccTOUyBhm1ehqrl2rrfyJS8djm69zhNJu0opKWHDkBzrRcz9ZITHccgKXjqZowgdR1
 IqkTXKLpLGHsjGHyYGYWgizsKByq0eatgHkh2c/9Ra97hsFPA9/RVcp5QGlGygSdM20O
 Kcvnkq1HMpdEjA8A5rrYwW9P3eAtwFj6xvWRiMip+5Qbqg7JAtYzhOoy92U19XCi5iRk
 AJW3nSvK1NbYiNQW7gEf3H1kBhrGO/1xEHc4XEbkrdw6skOFmDwkJBeZp52lfR0SolDv
 g/Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTaZDBlHYSaiNKe4vNR2HEflMifXEzx6LsB9hO1UTRSryAz2m2irIWQMBgS1tjFuay+G7IL1vPLrhwEnEK95Vm4QmsHcoMgxMrr0m0LTCVsY8=
X-Gm-Message-State: AOJu0YxJIgkhYs8APL0ix1hsX9CazKgGHZM4etH7kkTTuIGRGYFsR3qx
 OG2RiJ1A+xOehCPx5Y5DHtvwdka2YqRiKrUCjUtEwUosOB4mujjkJGwy5A==
X-Google-Smtp-Source: AGHT+IEnCM7sTEOQc+HgbTvVTkTKj6uv4J1Fa4tZj8SS4EfpHnkwa29SXrCl0TJ/Ps4Ui+I7GnXDUw==
X-Received: by 2002:a0d:eb08:0:b0:62c:c660:72af with SMTP id
 00721157ae682-63a8e0e3110mr65740137b3.24.1718913582421;
 Thu, 20 Jun 2024 12:59:42 -0700 (PDT)
Received: from ArmidaleLaptop ([2600:381:bf1c:7784:eca4:cc56:8003:c9fb])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-63f14a3cabfsm313327b3.88.2024.06.20.12.59.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:59:42 -0700 (PDT)
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: =?utf-8?Q?'=C3=89ric_Vyncke'?= <evyncke@cisco.com>
References: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
In-Reply-To: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
Date: Thu, 20 Jun 2024 12:59:37 -0700
Message-ID: <1b3701dac34c$6337e7f0$29a7b7d0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdrDTFRuaKtttYUtSxCgO66OsWwKwQ==
Content-Language: en-us
Message-ID-Hash: ESN6TVVVVMDGTZWLE7Y7S4VSPJXCNQ57
X-Message-ID-Hash: ESN6TVVVVMDGTZWLE7Y7S4VSPJXCNQ57
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: draft-ietf-bpf-isa@ietf.org, bpf-chairs@ietf.org, bpf@ietf.org,
 void@manifault.com, bpf@vger.kernel.org
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=C3=89ric_Vyncke=27s_feedback_on_byteswap_functions?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/KBWXbMeDcSrq4vsKR_KkBbV6hI4>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

w4lyaWMgVnluY2tlIHdyb3RlOiANCj4gMikgSSBmaW5kIHB1enpsaW5nIHRoZSBhYnNlbmNlIG9m
IGJldG9oMTYoKSBpbiB0aGUgcHJlc2VuY2Ugb2YgaHRvYmUxNigpDQo+IGZ1bmN0aW9ucy4NCg0K
U2luY2UgdGhlIGltcGxlbWVudGF0aW9uIGlzIGlkZW50aWNhbCwgSSBiZWxpZXZlIGl0IHdvdWxk
bid0IG1ha2Ugc2Vuc2UgdG8NCnVzZSB1cCBhbm90aGVyIGluc3RydWN0aW9uIHdpdGggdGhlIHNh
bWUgaW1wbGVtZW50YXRpb24uICANCg0KVGFibGUgNiBpbiBzZWN0aW9uIDQuMiB1c2VzIHRoZSBk
aXJlY3Rpb24tYWdub3N0aWMgZGVzY3JpcHRpb24gZm9yIFRPX0JFIG9mDQoiY29udmVydCBiZXR3
ZWVuIGhvc3QgYnl0ZSBvcmRlciBhbmQgYmlnIGVuZGlhbiIgd2hpY2ggSSB0aGluayBpcyBnb29k
Lg0KQnV0IHRoZW4gaXQgc2F5czoNCg0KPiB7RU5ELCBUT19CRSwgQUxVfSB3aXRoICdpbW0nID0g
MTYvMzIvNjQgbWVhbnM6DQo+DQo+IGRzdCA9IGh0b2JlMTYoZHN0KQ0KPiBkc3QgPSBodG9iZTMy
KGRzdCkNCj4gZHN0ID0gaHRvYmU2NChkc3QpDQoNCldoZXJlIHNlY3Rpb24gMi4yIGNvbmZ1c2lu
Z2x5IGRlZmluZXMgaXQgYXMgZGlyZWN0aW9uLXNwZWNpZmljIGFzIHlvdSBub3RlZDoNCg0KPiBo
dG9iZTE2OiBUYWtlcyBhbiB1bnNpZ25lZCAxNi1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZv
cm1hdCBhbmQNCj4gcmV0dXJucyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQg
MTYtYml0IG51bWJlciBpbiBiaWctZW5kaWFuIGZvcm1hdC4NCg0KV2hlcmVhcyBic3dhcDE2IGlz
IGRpcmVjdGlvbiBhZ25vc3RpYzoNCj4gYnN3YXAxNjogVGFrZXMgYW4gdW5zaWduZWQgMTYtYml0
IG51bWJlciBpbiBlaXRoZXIgYmlnLSBvciBsaXR0bGUtZW5kaWFuIGZvcm1hdA0KPiBhbmQgcmV0
dXJucyB0aGUgZXF1aXZhbGVudCBudW1iZXIgd2l0aCB0aGUgc2FtZSBiaXQgd2lkdGggYnV0IG9w
cG9zaXRlIGVuZGlhbm5lc3MuDQoNCkkgdGhpbmsgdGhlIHJpZ2h0IHdheSB0byBhZGRyZXNzIHlv
dXIgY29tbWVudCBpcyB0byBjaGFuZ2UgMi4yIGFuZCBwZXJoYXBzDQp0aGUgZnVuY3Rpb24gbmFt
ZSB0byBiZSBkaXJlY3Rpb24gYWdub3N0aWMgYW5kIG1hdGNoIHRoZSBkZXNjcmlwdGlvbiBpbiB0
YWJsZSA2Lg0KRm9yIGV4YW1wbGU6DQoNCiogYmVic3dhcDE2OiBUYWtlcyBhbiB1bnNpZ25lZCAx
Ni1iaXQgbnVtYmVyIGFuZCBjb252ZXJ0cyBpdCBiZXR3ZWVuIGhvc3QgYnl0ZQ0Kb3JkZXIgYW5k
IGJpZyBlbmRpYW4uICBUaGF0IGlzLCBvbiBhIGJpZy1lbmRpYW4gcGxhdGZvcm0gdGhlIHZhbHVl
IGlzIGxlZnQgdW5jaGFuZ2VkDQphbmQgb24gYSBsaXR0bGUtZW5kaWFuIHBsYXRmb3JtIHRoZSBi
ZWhhdmlvciBpcyB0aGUgc2FtZSBhcyBic3dhcDE2Lg0KDQpEYXZlDQoNCi0tIApCcGYgbWFpbGlu
ZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJw
Zi1sZWF2ZUBpZXRmLm9yZwo=

