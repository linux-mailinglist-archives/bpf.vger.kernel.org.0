Return-Path: <bpf+bounces-17605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B11EF80FA96
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17615B20E13
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B254649;
	Tue, 12 Dec 2023 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="k+w/R+2a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="k+w/R+2a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYLXmKGC"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4FAD
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:55:34 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9F5ACC14CF18
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702421734; bh=yIGkXVO1OrVViXgMBxBYu+otzoLmIcR5deGDLyRkzzY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=k+w/R+2a4KJirNHaA+vtUvIhD/7d/bFiLoDNbos+KjlZS5v701803aRG9HTb7qKvX
	 GtXOxFw4PKqR7oNgesejLqBnOg/mtxKKGf/18JPon7wjvra+brA75lWO33f7d4K9jK
	 FSLzKVvdBnL6ufXFa5LOQsxgFDZifSRWoPmHTTs4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Dec 12 14:55:34 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7B2ACC14F61A;
	Tue, 12 Dec 2023 14:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702421734; bh=yIGkXVO1OrVViXgMBxBYu+otzoLmIcR5deGDLyRkzzY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=k+w/R+2a4KJirNHaA+vtUvIhD/7d/bFiLoDNbos+KjlZS5v701803aRG9HTb7qKvX
	 GtXOxFw4PKqR7oNgesejLqBnOg/mtxKKGf/18JPon7wjvra+brA75lWO33f7d4K9jK
	 FSLzKVvdBnL6ufXFa5LOQsxgFDZifSRWoPmHTTs4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DC4B9C14F61A
 for <bpf@ietfa.amsl.com>; Tue, 12 Dec 2023 14:55:32 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8EJi3zwCfq1D for <bpf@ietfa.amsl.com>;
 Tue, 12 Dec 2023 14:55:32 -0800 (PST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 706A2C14F60E
 for <bpf@ietf.org>; Tue, 12 Dec 2023 14:55:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33635d11d92so537305f8f.1
 for <bpf@ietf.org>; Tue, 12 Dec 2023 14:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702421731; x=1703026531; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QrupQaeoS+38stqe0rx4IUeHo/JZH/ATfJZajGunkM=;
 b=SYLXmKGC0gaLQJxrC3z+t/Cv+Naf4+oQpb0kAUZQcKvv7f80uqtqLKAhTtMaU1TI1y
 ioqUCWFeKy7aaj4Z7M4rBhqtLavnbZRmD53sWRZ+fyeavTy/RmUJrSdu6Xa6yB5Rs8wm
 gaxaEJtsjwEkkVtVVk5fJhsBjOUwbSiMCg5rr3Uqfb/QeR6QcLF2eHwa2NlY4m0xTNwY
 9R1kNmF//XcouzHyf227LJdGuNiQG38s9IOWmfYsuRd+rDJJITdVfoYVp5xAqvTwsCXv
 rADHS1iM9gQZ5lejvV4YMqxfrseZ4r1lfPJOxfsoCwnV425wWZq3q9QQtXb30zNeM8QK
 3oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702421731; x=1703026531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+QrupQaeoS+38stqe0rx4IUeHo/JZH/ATfJZajGunkM=;
 b=TfhFw6fN7pdJfQJGHD7sxSwuHNZ7SI1WmwpuIemmmg6fK+M8c0bWTfhmSV2BHPzjxR
 HzUNmNzhUUH1KewReWixGJyJVNg+Cz1y9feQYYhjzu8l59taJvz90ktPRH+9nrCzq9Se
 OWgcEosecn1uf+kl/XEEC0LZgnD83vvs7KN2LflW090758+Q9Xm6gfmajEihrch0XNRg
 8XYfFpOXF6NXPdqMS9O1GcVcz6KGEVMtVg7hDYXuUguWEa4gRDMh8/kU/o5aZH8DZsRa
 zwdcJl4iY++L7yIXZFhBJU4U6ASOZWWnCNQf8q5RxH2EGUGnU9K/KgzZm3VifE2DxOkw
 bo3g==
X-Gm-Message-State: AOJu0YwEJvFwt5qc7/Ygfw9a4o9U0qzUIjyT/li9PCmuBt9oMTqUtDUU
 Hdy28+8vjPeQEJGfk1csmSqjBN+Qg4lMZ2yc680=
X-Google-Smtp-Source: AGHT+IFl7uVE8lfqRpvw/tVlmkOdwmiy5BKsVB9SxreXbHkbVDa3mjdqpYBW/MD5G7KzXwHuIkhSwJ+RbLDgkOazz7Q=
X-Received: by 2002:a5d:6310:0:b0:333:2fd2:8141 with SMTP id
 i16-20020a5d6310000000b003332fd28141mr4077635wru.94.1702421730563; Tue, 12
 Dec 2023 14:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
In-Reply-To: <157b01da2d46$b7453e20$25cfba60$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Dec 2023 14:55:19 -0800
Message-ID: <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: David Vernet <void@manifault.com>, bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/iErNXUA9tyikb_FeZ1uHz7s30vw>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gVHVlLCBEZWMgMTIsIDIwMjMgYXQgMjowMeKAr1BNIDxkdGhhbGVyMTk2OEBnb29nbGVtYWls
LmNvbT4gd3JvdGU6Cj4KPiA+ID4gRm9yIGV4YW1wbGUsIGxldCdzIHRha2UgYSBsb29rIGF0ICMy
IGF0b21pYy4uLgo+ID4gPiBTaG91bGQgaXQgaW5jbHVkZSBvciBleGNsdWRlIGF0b21pY19hZGQg
aW5zbiA/IEl0IHdhcyBhZGRlZCBhdCB0aGUKPiA+ID4gdmVyeSBiZWdpbm5pbmcgb2YgQlBGIElT
QSBhbmQgd2FzIHVzZWQgZnJvbSBkYXkgb25lLgo+ID4gPiBXaXRob3V0IGl0IGl0J3MgaW1wb3Nz
aWJsZSB0byBjb3VudCBzdGF0cy4gVGhlIHR5cGljYWwgbmV0d29yayBvcgo+ID4gPiB0cmFjaW5n
IHVzZSBjYXNlIG5lZWRzIHRvIGNvdW50IGV2ZW50cyBhbmQgb25lIGNhbm5vdCBkbyBpdCB3aXRo
b3V0Cj4gPiA+IGF0b21pYyBpbmNyZW1lbnQuIEV2ZW50dWFsbHkgcGVyLWNwdSBtYXBzIHdlcmUg
YWRkZWQgYXMgYW4gYWx0ZXJuYXRpdmUuCj4gPiA+IEkgc3VzcGVjdCBhbnkgcGxhdGZvcm0gdGhh
dCBzdXBwb3J0cyAjMSBiYXNpYyBpbnNuIHdpdGhvdXQgYXRvbWljX2FkZAo+ID4gPiB3aWxsIG5v
dCBiZSBwcmFjdGljYWxseSB1c2VmdWwuCj4gPiA+IFNob3VsZCBhdG9taWNfYWRkIGJlIGEgcGFy
dCBvZiAiYmFzaWMiIHRoZW4/IEJ1dCBpdCdzIGF0b21pYy4KPiA+ID4gVGhlbiB3aGF0IGFib3V0
IGF0b21pY19mZXRjaF9hZGQgaW5zbj8gSXQncyBwcmV0dHkgY2xvc2Ugc2VtYW50aWNhbGx5Lgo+
ID4gPiBQYXJ0IG9mIGF0b21pYyBvciBwYXJ0IG9mIGJhc2ljPwo+ID4KPiA+IEkgdGhpbmsgaXQn
cyByZWFzb25hYmxlIHRvIGV4cGVjdCB0aGF0IGlmIHlvdSByZXF1aXJlIGFuIGF0b21pYyBhZGQs
IHRoYXQgeW91Cj4gPiBtYXkgYWxzbyByZXF1aXJlIHRoZSBvdGhlciBhdG9taWMgaW5zdHJ1Y3Rp
b25zIGFzIHdlbGwgYW5kIHRoYXQgaXQgd291bGQgYmUKPiA+IGxvZ2ljYWwgdG8gZ3JvdXAgdGhl
bSB0b2dldGhlciwgeWVzLiBJIGJlbGlldmUgdGhhdCBOZXRyb25vbWUgc3VwcG9ydHMgYWxsIG9m
Cj4gPiB0aGUgYXRvbWljIGluc3RydWN0aW9ucywgYXMgb25lIGV4YW1wbGUuIElmIHlvdSdyZSBw
cm92aWRpbmcgYSBCUEYgcnVudGltZSBpbgo+ID4gYW4gZW52aXJvbm1lbnQgd2hlcmUgYXRvbWlj
IGFkZHMgYXJlIHJlcXVpcmVkLCBJIHRoaW5rIGl0IHN0YW5kcyB0byByZWFzb24KPiA+IHRoYXQg
eW91IHNob3VsZCBwcm9iYWJseSBzdXBwb3J0IHRoZSBvdGhlciBhdG9taWNzIGFzIHdlbGwsIG5v
Pwo+Cj4gSSBhZ3JlZS4KCllvdXIgbG9naWNhbCByZWFzb25pbmcgaXMgaW5kZWVkIGNvcnJlY3Qg
YW5kCkkgYWdyZWUgd2l0aCBpdCwKYnV0IHJlYWxpdHkgaXMgZGlmZmVyZW50IDopCgpkcml2ZXJz
L25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL2JwZi9qaXQuYzoKc3RhdGljIGludCBtZW1fYXRv
bWljOChzdHJ1Y3QgbmZwX3Byb2cgKm5mcF9wcm9nLCBzdHJ1Y3QgbmZwX2luc25fbWV0YSAqbWV0
YSkKewogICAgICAgIGlmIChtZXRhLT5pbnNuLmltbSAhPSBCUEZfQUREKQogICAgICAgICAgICAg
ICAgcmV0dXJuIC1FT1BOT1RTVVBQOwoKICAgICAgICByZXR1cm4gbWVtX3hhZGQobmZwX3Byb2cs
IG1ldGEsIHRydWUpOwp9CgpJdCBvbmx5IHN1cHBvcnRzIGF0b21pY19hZGQgYW5kIG5vIG90aGVy
IGF0b21pY3MuCgo+ID4gPiBBbm90aGVyIGV4YW1wbGUsICMzIGRpdmlkZS4gYnBmIGNwdT12MSBJ
U0Egb25seSBoYXMgdW5zaWduZWQgZGl2L21vZC4KPiA+ID4gRXZlbnR1YWxseSB3ZSBhZGRlZCBh
IHNpZ25lZCB2ZXJzaW9uLiBJbnRlZ2VyIGRpdmlzaW9uIGlzIG9uZSBvZiB0aGUKPiA+ID4gc2xv
d2VzdCBvcGVyYXRpb25zIGluIGEgSFcuIERpZmZlcmVudCBjcHVzIGhhdmUgZGlmZmVyZW50IGZs
YXZvcnMgb2YKPiA+ID4gdGhlbSA2NC8zMiA2NC82NCAzMi8zMiwgZXRjLiBBbGwgd2l0aCBkaWZm
ZXJlbnQgcXVpcmtzLgo+ID4gPiBjcHU9djEgaGFkIG1vZHVsbyBpbnNuIGJlY2F1c2UgaW4gdHJh
Y2luZyBvbmUgb2Z0ZW4gbmVlZHMgdG8gZG8gaXQgdG8KPiA+ID4gc2VsZWN0IGEgc2xvdCBpbiBh
IHRhYmxlLCBidXQgaW4gbmV0d29ya2luZyB0aGVyZSBpcyByYXJlbHkgYSBuZWVkLgo+ID4gPiBT
byBicGYgb2ZmbG9hZCBpbnRvIG5ldHJvbm9tZSBIVyBkb2Vzbid0IHN1cHBvcnQgaXQgKGlpcmMp
Lgo+ID4KPiA+IENvcnJlY3QsIG15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBCUEYgb2ZmbG9hZCBp
biBuZXRyb25vbWUgc3VwcG9ydHMgbmVpdGhlcgo+ID4gZGl2aXNpb24gbm9yIG1vZHVsby4KPgo+
IEluIG15IG9waW5pb24sIHRoaXMgaXMgYSB2YWxpZCB0ZWNobmljYWwgcmVhc29uIHRvIHB1dCB0
aGVtIGludG8gYSBzZXBhcmF0ZQo+IGNvbmZvcm1hbmNlIGdyb3VwLCB0byBhbGxvdyBoYXJkd2Fy
ZSBvZmZsb2FkIGNhcmRzIHRvIHN1cHBvcnQgQlBGIHdpdGhvdXQKPiByZXF1aXJpbmcgZGl2aXNp
b24vbW9kdWxvIHdoaWNoIHRoZXkgbWlnaHQgbm90IGhhdmUgc3BhY2Ugb3Igb3RoZXIgYnVkZ2V0
IGZvci4KCkFsc28gbG9naWNhbGx5IGNvcnJlY3QgYW5kIEkgYWdyZWUgd2l0aCwgYnV0IHJlYWxp
dHkgcHJvdmVzIGFsbCBvZiB1cyB3cm9uZy4KbmV0cm9ub21lIGRvZXNuJ3Qgc3VwcG9ydCBtb2R1
bG8sCmJ1dCBpdCBzdXBwb3J0cyBpbnRlZ2VyIGRpdmlzaW9uIHdoZW4gdGhlIHZlcmlmaWVyIGNh
biBkZXRlcm1pbmUKcHJvcGVydHkgb2YgdGhlIGNvbnN0YW50LgpCUEZfQUxVNjQgfCBCUEZfRElW
IHwgQlBGX0sgd29ya3MgZm9yIHBvc2l0aXZlIGltbTMyLApidXQgQlBGX1ggd29ya3Mgd2hlbiB0
aGUgdmVyaWZpZXIgaXMgc21hcnQgd2l0aCBwbGVudHkgb2YgcXVpcmtzCmFuZCBzdWJ0bGUgY29u
ZGl0aW9ucy4KSXQgd29ya3Mgd2l0aCB0aGUgaGVscCBvZiBjb29sIG1hdGggcmVjaXByb2NhbF92
YWx1ZV9hZHYoKQppbiBpbmNsdWRlL2xpbnV4L3JlY2lwcm9jYWxfZGl2LmgKd2hpY2ggY29udmVy
dHMgZGl2IHRvIHNoaWZ0cyBhbmQgbXVscy4KClNvIHNob3VsZCBkaXZfSyBhbmQgZGl2X1ggYmUg
aW4gc2VwYXJhdGUgZ3JvdXBzID8KU2hvdWxkIG1vZF9bS3xYXSBiZSB0aGVyZSBhcyB3ZWxsIG9y
IG5vdD8KClRvIGRldGVybWluZSB0aGUgZ3JvdXBpbmcgc2hvdWxkIHdlIHVzZSBsb2dpYyBvciBy
ZWFsaXR5PwoKSSdtIGFyZ3VpbmcgdGhhdCB3aGF0ZXZlciBjbGVhbiBhbmQgbG9naWNhbCBncm91
cGluZyB3ZSBjYW4gY29tZSB1cCB3aXRoCml0IHdvbid0IHN0YW5kIGEgdGVzdCBvZiByZWFsIHVz
ZS4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

