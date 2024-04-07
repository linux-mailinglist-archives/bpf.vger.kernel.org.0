Return-Path: <bpf+bounces-26125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1987989B2D5
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D38F2821EC
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4783A27B;
	Sun,  7 Apr 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="p8vw9x1m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UHl2lFs/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QMLYIk8f"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C614293
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507024; cv=none; b=a33t8Hfx3wxrpxU5u08OOoL2XSbuDua2sFAAn5eaHJyLHCXYsHUWzB1HzdJO/6gRsPBcbV3RSKMeU/U8EpRqf2ffIFLkdL6x3aE8E1G1w4I30aftmbSvOYvW76o8L9uLFjfhDaGX9wwf4FdofyCu9jLVODnyCsx5ZXAmDo4IPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507024; c=relaxed/simple;
	bh=YSq4/Fpd5MvThUCjBl2pQjQyUsheD6M/282Vv8K0E7s=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=tn1WvDm8DoX5gGPFnTDXxy4VCWhuieWAKDzxbcGYywliBXD8XEJYvUY0y+GSODLQWV3RHh9KDtgmF2NT4Jpn00jh1iAJ5VivfjAuRz+SUisOMQ30LO2V0dxLkjisG+fzSNC4b4baCJBE4aPxSpYI3Zuc09D+N4LrwjW76vZBA28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=p8vw9x1m; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=UHl2lFs/ reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QMLYIk8f reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B4B4CC14F6EE
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712507021; bh=YSq4/Fpd5MvThUCjBl2pQjQyUsheD6M/282Vv8K0E7s=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8vw9x1mmtXb+2oSyptODYKZ9c6S38vz3QuXxau4sBPWyxvgnVbayjivv1CFmbnfD
	 r2hT94BRCkndxxUXJOOifbHfKa2oY7RBYS8aNFKCUjGh6bmnjGE+mcq7sPRVUm9Eod
	 YyVQLIgVEAinG5Kos7pcIInQ4MQ4UrIh/hyhiHEk=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 909CBC14F6AD;
 Sun,  7 Apr 2024 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1712507021; bh=YSq4/Fpd5MvThUCjBl2pQjQyUsheD6M/282Vv8K0E7s=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=UHl2lFs/w5viHHdKbjeAnEhoqzTE5Y302VY4W7uAHUV68s+CQJTBTwHZvvloDl0PE
 3MB6yaBqkFDApRyimQiD90QMgJVdAes9aMKz98XSouJjtAExKdsPYumi1HFHtcSx6h
 WCQWhCkJeBBma/6Cqrv2UdWS2ZINz7Vi0N6TzAFk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8B42DC14F6AC
 for <bpf@ietfa.amsl.com>; Sun,  7 Apr 2024 09:23:40 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.846
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GrkosbaWXaMl for <bpf@ietfa.amsl.com>;
 Sun,  7 Apr 2024 09:23:36 -0700 (PDT)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B4FEFC14F6AD
 for <bpf@ietf.org>; Sun,  7 Apr 2024 09:23:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so14707455ad.3
 for <bpf@ietf.org>; Sun, 07 Apr 2024 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1712507016; x=1713111816; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MTGGnJPzdQoXIOBITh6rRey/linvjMemVCnik0SXFYo=;
 b=QMLYIk8fjRH/y7O1A/KSUGjm3swOeAiMy2qs0MkiX4aKfe4302tOfWbIyt5n2KHji5
 M8e0u9rI2rqCFRc3272G8ihak/3YqgqAm2ZuD5lftsS3We9ysXZdNLCpV5QGDHUKB4Fj
 42GLqhNrswZ8vC1aA2C2sw4LTa27Z/lRF5b+z7zUehdeOv189F0fUXmZPxQpnE3C1X/T
 DSGLaK37clx8IOWg1mIJ8qicn5XcxxUgWsbRiosAcN0X8NPp9jWc2fiMf24cecr92thd
 ki3tECVXHQf4qJ/FFjDowanIlX9dCExdeOcUi02QBz0GXZ7qf8vDJtpzZBZIjd5Nda9m
 Ew3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712507016; x=1713111816;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MTGGnJPzdQoXIOBITh6rRey/linvjMemVCnik0SXFYo=;
 b=RFOV9+TRBULvGlLnFEzWyU3lEBUstgw9m3EqAnxPleLvrCKKbUYBj7dE9B32X36HGX
 I7M/KvpobNTN7jNjNpLd6VX6tu57f4KKY4simtf3aS1+5SNJtkAmP2Qz1kMe9trGQiCL
 CAEfy+FbHRXfZHYNWXL5juzoimFZUnfRfqL44Bb38o8d9UawruazGeGmJ2TTwbZKIVSO
 aZ1VNnM6Ym0eip79sFVAybhpmLO6qLGnM38TIRkb5I5leEnxM7cnbMFukHi4bPe9kNDt
 zVn1oJFQCe2O30PU3ASqEW9XAUoDteojgrtAuHRysRD84ubV+c36DjCBODeXLPb4SgqM
 WfBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq9502k8UPY602Go8z71QhRY91JawwVEHjOfn0Q77CTpciWRGDCF3wqO3LzAEFkAv5QaouFqmQPT3dFSI=
X-Gm-Message-State: AOJu0YycvYNorc0+JobWNOyHlEL6s2HbH8+F2sMK1U8PPu0iiZFx4kzc
 p+jLXhC02Pwc7pktBbWFI2MKyB08Pdyn8aUXYp+9mvsYgyjWDUBI2mAVR1nzjK0=
X-Google-Smtp-Source: AGHT+IEDAfDGgDBhUewbndGCHe+R5C4MKmmM6dEey9/fFAJ2NqlIMPDksCbIuWlWuMkxOoKeROeHJQ==
X-Received: by 2002:a17:902:f544:b0:1dd:c7fc:2b16 with SMTP id
 h4-20020a170902f54400b001ddc7fc2b16mr7085653plf.68.1712507015791; 
 Sun, 07 Apr 2024 09:23:35 -0700 (PDT)
Received: from ArmidaleLaptop (64-119-15-44.fiber.ric.network. [64.119.15.44])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902d04b00b001e2c1e56f3bsm5118607pll.104.2024.04.07.09.23.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Apr 2024 09:23:34 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Watson Ladd'" <watsonbladd@gmail.com>,
 "'David Vernet'" <void@manifault.com>
Cc: <dthaler1968=40googlemail.com@dmarc.ietf.org>, <bpf@vger.kernel.org>,
 <bpf@ietf.org>
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
 <20240405215044.GC19691@maniforge>
 <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com>
In-Reply-To: <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com>
Date: Sun, 7 Apr 2024 09:23:33 -0700
Message-ID: <003001da8907$efd41140$cf7c33c0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGym9lSVor9R6wjkVDgbvdbCMHIbgJp4F1KApIu0eGxhPS+kA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/DK3LyzmVeKKc2kluhr3JkRT_gAI>
Subject: Re: [Bpf] Follow up on "call helper function by address" terminology
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
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

V2F0c29uIExhZGQgd3JvdGU6IAo+IE9uIEZyaSwgQXByIDUsIDIwMjQgYXQgMjo1MOKAr1BNIERh
dmlkIFZlcm5ldCA8dm9pZEBtYW5pZmF1bHQuY29tPiB3cm90ZToKPiA+IE9uIEZyaSwgQXByIDA1
LCAyMDI0IGF0IDAxOjEwOjM4UE0gLTA3MDAsCj4gZHRoYWxlcjE5Njg9NDBnb29nbGVtYWlsLmNv
bUBkbWFyYy5pZXRmLm9yZyB3cm90ZToKPiA+ID4gQXQgSUVURiAxMTksIHdlIGFncmVlZCB0aGF0
ICJieSBhZGRyZXNzIiBzaG91bGQgYmUgY2hhbmdlZCB0bwo+ID4gPiBzb21ldGhpbmcgZWxzZSBp
biB0aGUgSVNBLiAgVGhlIHRlcm0gImxlZ2FjeSBJRCIgd2FzIHVzZWQgZHVyaW5nIHRoZQo+ID4g
PiBkaXNjdXNzaW9uIGJ1dCBDaHJpc3RvcGggKGlmIEkgcmVtZW1iZXIgcmlnaHQpIHBvaW50ZWQg
b3V0IHRoYXQgc3VjaAo+ID4gPiBJRHMgYXJlIG5vdCBkZXByZWNhdGVkIHBlciBzZS4gIEhlbmNl
ICJsZWdhY3kiIG1heSBub3QgYmUgdGhlIHJpZ2h0Cj4gPiA+IHdvcmQgc2luY2Ugd2UgdXNlIHRo
YXQgd29yZCB3aXRoIGxlZ2FjeSBwYWNrZXQgYWNjZXNzIGluc3RydWN0aW9ucwo+ID4gPiB0aGF0
IGFyZSBkZXByZWNhdGVkLiBXZSBkZWNpZGVkIHRvIHRha2UgZnVydGhlciBkaXNjdXNzaW9uIHRv
IHRoZQo+ID4gPiBsaXN0LCBoZW5jZSB0aGlzIGVtYWlsLgo+ID4gPgo+ID4gPiBXZSBuZWVkIHNv
bWUgdGVybSB0byBkaXN0aW5ndWlzaCB0aGVtIGZyb20gQlRGIElEcywgc28gYW5vdGhlcgo+ID4g
PiBhbHRlcm5hdGl2ZSBtaWdodCBiZSAibm9uLUJURiBJRCIuCj4gPgo+ID4gTm9uLUJURiBJRCBp
cyBmaW5lIHdpdGggbWUuIEFueSBvYmplY3Rpb25zPwo+IAo+IElmIHNvbWV0aGluZyBsYXRlciBj
b21lcyBhbG9uZyBzdXBwbGFudGluZyBCVEYgaXQgd2lsbCBiZSB0aGUgbm90LUJURiBub3Qtbm9u
LQo+IEJURiB0aGluZy4gVGhpcyBpcyBiYWQuIEhvdyBhYm91dCB1bnR5cGVkIGlkZW50aWZpZXJz
PwoKRm9yIHJ1bnRpbWVzIHRoYXQgaGF2ZSBhIHdheSB0byBsb29rIHVwIHR5cGUgaW5mbyBmcm9t
IGEgbm9uLUJURiBJRCwgdGhlIApJRCBpcyBub3QgInVudHlwZWQiIHBlciBzZS4KCk90aGVyIHBv
c3NpYmlsaXRpZXM6CiogQ2xhc3NpYyBJRCwgYnV0ICJjbGFzc2ljIiB3b3VsZCBpbXBseSBjbGFz
c2ljIEJQRgoqIEluZGV4LCBidXQgdGhhdCB3b3VsZCBpbXBseSB0aGUgcnVudGltZSBhY3R1YWxs
eSBoYXMgdG8gaW1wbGVtZW50IGl0IGFzIGFuIGluZGV4IAoKQXMgc3VjaCwgSSB0aGluayAibm9u
LUJURiBJRCIgaXMgYmV0dGVyIHRoYW4gdGhlIG90aGVyIHBvc3NpYmlsaXRpZXMgYWJvdmUsIGFu
ZCBhCmZ1dHVyZSBJU0EgdmVyc2lvbiBjb3VsZCBhbHdheXMgcmVuYW1lIGl0IGlmIG90aGVyIHRo
aW5ncyBjb21lIHVwIGluIHRoZSBmdXR1cmUKdGhhdCBuZWNlc3NpdGF0ZSBhIHRlcm1pbm9sb2d5
IGNoYW5nZS4KCkRhdmUKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczov
L3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

