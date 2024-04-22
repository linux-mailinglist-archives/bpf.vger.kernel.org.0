Return-Path: <bpf+bounces-27462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D88AD4A0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508E11F25441
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9DF15530A;
	Mon, 22 Apr 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aF6m1K3D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="dUfNU0r9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KQ/io276"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415A1552E8
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812767; cv=none; b=ZN9Hcx5RX0R0wL1dU0fLzjTFNr7o1h51J5059u0C1oOazfK6UzbL5oL/4/++xsh9srlQknRl/uWezY6VJznBG4stHInkfRCSwmb/eW8tBzZpB0lm6wD1PJUkESYZO5uMda6y9SqO8+t6F8adDyuSPZl2KB1UGNaoSU6sIbP9r58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812767; c=relaxed/simple;
	bh=xvuGGAYwVz2DyCXdYOdTXQSyLt3SDv0uX67YIeF5iiw=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=frTle/2zjv9iAfyUnP9xzxp+TGo1WdRdKaf2iMOlsrCwuLacNFPUCBtt/C4NtuZMtshhA6tpyOSt1V5TwhIUYiGcaOfTTs7mkzYKumxWbGbakidYtxsRRtpz2hyxfHyigaodwtSn7F0ndUfC+trauTYmYXGU3so5nsJFszjpHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aF6m1K3D; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=dUfNU0r9 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KQ/io276 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5356FC19ECB9
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713812765; bh=xvuGGAYwVz2DyCXdYOdTXQSyLt3SDv0uX67YIeF5iiw=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aF6m1K3DAsa7FXPA4LQATh8aZp0lJrm1VCL5NO+8YXeMgkz8q603Mh+DKpqpyC2zD
	 u5cM4Rkxu3jSulu6o7lV/W6CAxXZKkzymb/KtJOLyiJJ5VmYPMFlgUOA1+E5u3C9gH
	 YxuelRqGPDaKznb/XPcV3zdG6jOrrvoclqQHYgHc=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1F55BC169436;
 Mon, 22 Apr 2024 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713812765; bh=xvuGGAYwVz2DyCXdYOdTXQSyLt3SDv0uX67YIeF5iiw=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=dUfNU0r9idjIvxX0BFg85tfLnFbNSNuidNPNn8/4opJnPWyVGeMWO5UXBxGYnL+8s
 djGJTRTtp/CLUvlOAtI+P3xxnrU6n4dMKoOqqhDTNhkyYyASmbcgLLtWmXBgmc4dlO
 BDxQ2M+Mb6vE4mLq1/sc6YOLNe/rpdwASTUvTNwI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 68B89C169436
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 12:06:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I8AGy8RKIseO for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 12:06:00 -0700 (PDT)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4914CC14F5EA
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:06:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so4907933b3a.3
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713812759; x=1714417559; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yNds/3XriKnoMzKRIOjk4mym3GCRF/+b+SL9UQdmBcA=;
 b=KQ/io276nrIdbUEqQWT0oQhBqxm8FmkGqgtUxrssANyc2KUPKWrd2hRodpDAuBp3s4
 KIwK8qs9FjmhlP5ZqjOgxdDQzGXQwC1GkbO9DekCZPeWKDwOozNg8TXOvz3POIt04U3o
 SEvuqiHmgMt9bFkzE8co303s8c4PQxI92JE28jVbAM61SDHF9pAY8MvSZXBgd5D/3DVa
 GeEoVEuvZKCxxQqqIuxwGyQ++/FZf3Q2cPv1eJ2AdE+qwuX1qC7oDc62SjZzkTXJNdPg
 2Jq3otDT2Mgp6QHe58h1nmATDlpvbCGzKnaHsA7jTVxTiJe+ff3+HGV0ZTBjpbuc0oiU
 Vyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713812759; x=1714417559;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNds/3XriKnoMzKRIOjk4mym3GCRF/+b+SL9UQdmBcA=;
 b=r2HZpwYkIWLBHz75odtz+UCv1IOI+85S9yEmBBitoKbktNc38JPnn/GpOhrbFqBN8s
 vMyIjBZBj7FRP8RaWFf4fbN/MeO6dR/J8Y0CUEL9fned+SbuJpLUqlaDTkrbcd1PM5Nr
 qHJc1KyMRc7CkSGSiuRY6aAzAS9kADQo4+vtSrR0AnPDKXoWwtBPSGOWeScjjX7uRd5m
 vF3F3KE/DmcUqfZRjLI6D15Q5opqQYbx7mx3HMSkAmaKMtJI8zWuHOqAz6neMtlrv2Qs
 gxckoI/nwpqtc/sCGjr/TJmGR5e9mYFwu82eV3ZYqIdifHWtzQfmIgYdZYhBHNfaNTHx
 WY2g==
X-Gm-Message-State: AOJu0YwzylshY4elIcO1x3vTxN2iXp8PbDh2DuQXzCJXAk6/wejQIYkd
 zUW7rTt8tUGfuIjp72USUtvFf/0KUD2rOJHxumBorr5LN5Q6FaWvKzboyW0q
X-Google-Smtp-Source: AGHT+IF5UON05abLTAAbAQNK8RFOtuHoX93xAO4TpEBG0WikCVlleKBSDulNclfcv7ahwMKbU8NO6w==
X-Received: by 2002:a05:6a00:2181:b0:6e8:f66f:6b33 with SMTP id
 h1-20020a056a00218100b006e8f66f6b33mr13880081pfi.4.1713812759355; 
 Mon, 22 Apr 2024 12:05:59 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 b1-20020aa78ec1000000b006ece7bb5636sm8152692pfr.134.2024.04.22.12.05.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Apr 2024 12:05:59 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Watson Ladd'" <watsonbladd@gmail.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <CACsn0ckPptm05-G6tXPaJJSvKmP3e-nCKPJJCdkmzZOYkQX-Tw@mail.gmail.com>
In-Reply-To: <CACsn0ckPptm05-G6tXPaJJSvKmP3e-nCKPJJCdkmzZOYkQX-Tw@mail.gmail.com>
Date: Mon, 22 Apr 2024 12:05:57 -0700
Message-ID: <151e01da94e8$1c391f00$54ab5d00$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQGJMFTgsMFkZeA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/fEqCWlwLjpCMEm9HWS87OoIQ4Xo>
Subject: Re: [Bpf] BPF ISA Security Considerations section
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IFdhdHNvbiBMYWRkIDx3YXRzb25i
bGFkZEBnbWFpbC5jb20+Cj4gU2VudDogTW9uZGF5LCBBcHJpbCAyMiwgMjAyNCAxMjowMiBQTQo+
IFRvOiBkdGhhbGVyMTk2OD00MGdvb2dsZW1haWwuY29tQGRtYXJjLmlldGYub3JnCj4gQ2M6IGJw
ZkBpZXRmLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZwo+IFN1YmplY3Q6IFJlOiBbQnBmXSBCUEYg
SVNBIFNlY3VyaXR5IENvbnNpZGVyYXRpb25zIHNlY3Rpb24KPiAKPiBPbiBTYXQsIEFwciAyMCwg
MjAyNCBhdCA5OjA54oCvQU0KPiA8ZHRoYWxlcjE5Njg9NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5p
ZXRmLm9yZz4gd3JvdGU6Cj4gPgo+ID4gUGVyCj4gPiBodHRwczovL2F1dGhvcnMuaWV0Zi5vcmcv
ZW4vcmVxdWlyZWQtY29udGVudCNzZWN1cml0eS1jb25zaWRlcmF0aW9ucywKPiA+IHRoZSBCUEYg
SVNBIGRyYWZ0IGlzIHJlcXVpcmVkIHRvIGhhdmUgYSBTZWN1cml0eSBDb25zaWRlcmF0aW9ucwo+
ID4gc2VjdGlvbiBiZWZvcmUgaXQgY2FuIGJlY29tZSBhbiBSRkMuCj4gPgo+ID4gQmVsb3cgaXMg
c3RyYXdtYW4gdGV4dCB0aGF0IHRyaWVzIHRvIHN0cmlrZSBhIGJhbGFuY2UgYmV0d2Vlbgo+ID4g
ZGlzY3Vzc2luZyBzZWN1cml0eSBpc3N1ZXMgYW5kIHNvbHV0aW9ucyB2cyBrZWVwaW5nIGRldGFp
bHMgb3V0IG9mCj4gPiBzY29wZSB0aGF0IGJlbG9uZyBpbiBvdGhlciBkb2N1bWVudHMgbGlrZSB0
aGUgInZlcmlmaWVyIGV4cGVjdGF0aW9ucwo+ID4gYW5kIGJ1aWxkaW5nIGJsb2NrcyBmb3IgYWxs
b3dpbmcgc2FmZSBleGVjdXRpb24gb2YgdW50cnVzdGVkIEJQRgo+ID4gcHJvZ3JhbXMiIGRvY3Vt
ZW50IHRoYXQgaXMgYSBzZXBhcmF0ZSBpdGVtIG9uIHRoZSBJRVRGIFdHIGNoYXJ0ZXIuCj4gPgo+
ID4gUHJvcG9zZWQgdGV4dDoKPiA+Cj4gPiA+IFNlY3VyaXR5IENvbnNpZGVyYXRpb25zCj4gPiA+
Cj4gPiA+IEJQRiBwcm9ncmFtcyBjb3VsZCB1c2UgQlBGIGluc3RydWN0aW9ucyB0byBkbyBtYWxp
Y2lvdXMgdGhpbmdzIHdpdGgKPiA+IG1lbW9yeSwKPiA+ID4gQ1BVLCBuZXR3b3JraW5nLCBvciBv
dGhlciBzeXN0ZW0gcmVzb3VyY2VzLiBUaGlzIGlzIG5vdAo+ID4gPiBmdW5kYW1lbnRhbGx5Cj4g
PiBkaWZmZXJlbnQKPiA+ID4gZnJvbSBhbnkgb3RoZXIgdHlwZSBvZiBzb2Z0d2FyZSB0aGF0IG1h
eSBydW4gb24gYSBkZXZpY2UuIEV4ZWN1dGlvbgo+ID4gZW52aXJvbm1lbnRzCj4gPiA+IHNob3Vs
ZCBiZSBjYXJlZnVsbHkgZGVzaWduZWQgdG8gb25seSBydW4gQlBGIHByb2dyYW1zIHRoYXQgYXJl
Cj4gPiA+IHRydXN0ZWQgb3IKPiA+IHZlcmlmaWVkLAo+ID4gPiBhbmQgc2FuZGJveGluZyBhbmQg
cHJpdmlsZWdlIGxldmVsIHNlcGFyYXRpb24gYXJlIGtleSBzdHJhdGVnaWVzIGZvcgo+ID4gbGlt
aXRpbmcKPiA+ID4gc2VjdXJpdHkgYW5kIGFidXNlIGltcGFjdC4gRm9yIGV4YW1wbGUsIEJQRiB2
ZXJpZmllcnMgYXJlIHdlbGwta25vd24KPiA+ID4gYW5kCj4gPiB3aWRlbHkKPiA+ID4gZGVwbG95
ZWQgYW5kIGFyZSByZXNwb25zaWJsZSBmb3IgZW5zdXJpbmcgdGhhdCBCUEYgcHJvZ3JhbXMgd2ls
bAo+ID4gPiB0ZXJtaW5hdGUgd2l0aGluIGEgcmVhc29uYWJsZSB0aW1lLCBvbmx5IGludGVyYWN0
IHdpdGggbWVtb3J5IGluCj4gPiA+IHNhZmUgd2F5cywgYW5kCj4gPiBhZGhlcmUgdG8KPiA+ID4g
cGxhdGZvcm0tc3BlY2lmaWVkIEFQSSBjb250cmFjdHMuIFRoZSBkZXRhaWxzIGFyZSBvdXQgb2Yg
c2NvcGUgb2YKPiA+ID4gdGhpcwo+ID4gZG9jdW1lbnQKPiA+ID4gKGJ1dCBzZWUgW0xJTlVYXSBh
bmQgW1BSRVZBSUxdKSwgYnV0IHRoaXMgbGV2ZWwgb2YgdmVyaWZpY2F0aW9uIGNhbgo+ID4gPiBv
ZnRlbgo+ID4gcHJvdmlkZSBhCj4gPiA+IHN0cm9uZ2VyIGxldmVsIG9mIHNlY3VyaXR5IGFzc3Vy
YW5jZSB0aGFuIGZvciBvdGhlciBzb2Z0d2FyZSBhbmQKPiA+ID4gb3BlcmF0aW5nCj4gPiBzeXN0
ZW0KPiA+ID4gY29kZS4KPiAKPiBJIHdvdWxkIHB1dCBhIHJlZmVyZW5jZSB0byB0aGUgb3RoZXIg
ZGVsaXZlcmFibGUgdG8gc2F5IG1vcmUuIElmIHdlIHRoaW5rIHRoYXQncwo+IHN1Ym9wdGltYWwg
Zm9yIHB1YmxpY2F0aW9uIHN0cmF0ZWd5LCBtYXliZSB3ZSBjYW4gYmUgbW9yZSBnZW5lcmljIGFi
b3V0IGl0LgoKVGhlcmUncyBub3RoaW5nIHRoYXQgY2FuIGJlIHJlZmVyZW5jZWQgeWV0LiAgT25l
IGNhbiBvbmx5IHNheSBpdCdzIGxlZnQgZm9yIGZ1dHVyZSB3b3JrLAp3b3VsZCB5b3UgcHJlZmVy
IHRoYXQ/Cgo+IE9mdGVuIEJQRiBwcm9ncmFtcyBhcmUgZXhlY3V0ZWQgb24gdGhlIG90aGVyIHNp
ZGUgb2YgYSByZWxpYWJpbGl0eSBib3VuZGFyeSwgZS5nLiBpZgo+IHlvdSBleGVjdXRlIGEgQlBG
IGZpbHRlciBzYXlpbmcgZHJvcCBhbGwgb24geW91ciBuZXR3b3JrIGNhcmQsIGhhdmUgZnVuLiBU
aGlzIGlzbid0Cj4gZGlmZmVyZW50IGZyb20gZmlyZXdhbGxzIGFuZCB0aGUgbGlrZSwgYnV0IGl0
J3MgYSBuZXcgcmlzayB0aGF0IHBlb3BsZSBhcmVuJ3QgZXhwZWN0aW5nLiBJCj4gdGhpbmsgd2Ug
bWlnaHQgYWxzbyBuZWVkIHRvIGNhbGwgb3V0IHRoYXQgQlBGIHNlY3VyaXR5IGFzc3VyYW5jZSBy
ZXF1aXJlcyBjYXJlZnVsCj4gZGVzaWduIGFuZCB0aG91Z2h0IGFib3V0IHdoYXQgaXMgZXhwb3Nl
ZCB2aWEgQlBGLgo+IAo+IFNpbmNlcmVseSwKPiBXYXRzb24KCkRvIHlvdSBoYXZlIHByb3Bvc2Vk
IHRleHQ/CgpEYXZlCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93
d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

