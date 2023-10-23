Return-Path: <bpf+bounces-13061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ECD7D429D
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7661C20A43
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2569E241E0;
	Mon, 23 Oct 2023 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="m5uXmOwj";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ezhIUmgM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB523770
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:16:33 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431DBC
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:16:32 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0085DC17C516
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1698099359; bh=YO+2Zc6zGlxsBZdE7gI/ZbmfP6pqydgVO7Xltrg+2So=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=m5uXmOwjPyguvZXm+4E0kGjCuk1nqgzfdNn7FT0XO2y4uXvSyjwUzcbFN+dFwbZBJ
	 yCkL3qycB1ZfiONCW0TG8eYejicCa4j2O/eAIZDlMatahxaS53/pwGvO7Wkr2/AEZh
	 hWjKmE68HhQTkN5mpW1ly0ewLzBr4jICkia5v+YY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Oct 23 15:15:58 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BA7CDC1705EB;
	Mon, 23 Oct 2023 15:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1698099358; bh=YO+2Zc6zGlxsBZdE7gI/ZbmfP6pqydgVO7Xltrg+2So=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ezhIUmgMVMAwFgSUX3MD+tb/t6FUtoRMM7ZQ5OOf2kRJsfKuN+vu6ll+VrYOay5RV
	 Q7N+W0+ju5bhD1cpMeks36U5c23pbP2JxU28P0qKW3yt/lNwQ2kRaToQ8kjjfyOQFG
	 GuOR0HjRZmRiNg18idlC1pDIBGNXShmMX86ecc10=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D76BEC1705EB
 for <bpf@ietfa.amsl.com>; Mon, 23 Oct 2023 15:15:56 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMovYIL5KKel for <bpf@ietfa.amsl.com>;
 Mon, 23 Oct 2023 15:15:52 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 66927C16F3EC
 for <bpf@ietf.org>; Mon, 23 Oct 2023 15:15:46 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-66d122f6294so27702296d6.0
 for <bpf@ietf.org>; Mon, 23 Oct 2023 15:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698099345; x=1698704145;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E6B+Zv4N2u3nsJJpruO+pOD6moI9VuvybD1oyXiZQvo=;
 b=Eu8FLVa6A9X5CYYQn3cZUmWGpW1lpPXBHBAd7XaaeTolcbs3zXhqeAndsu9e+wolYP
 M5loC5QOsU1yG1FZ4BAylpqnf0qyCqjWBP56OHrLCugMeJCIqYkBN0J5vcO6cEOlwiuq
 etVkrD5uwJqrJG+Rxinhku3HSq+Yyzgf5K4U5md4IfPvLT54GDGURy6HcHijWIhncocz
 5MHz5hQHbPjWx+1j83yAbPJOVWcwR7fm6gsOe2bfnqF+fGN0+zbfHq9vGdE2Z4LLurYS
 Ab92cKKZ62Xmgt8QiDXpaDt2FZozhictrON8kCRDaBbOHls5HRjfOUQzMgSVbQo7MtXK
 wn+w==
X-Gm-Message-State: AOJu0YxhaQjctLBxMA1kLJbHJJdXe+SSrThJzULKZo3nqyVOacb0Zx5X
 2IdhSjOaNEM27/PZ0MGzprQfAO6Tm13RuOs1
X-Google-Smtp-Source: AGHT+IEMqmqUkf3DruAD4pL/wDt/xxAkQFOdHqJJMsoC82d3fXH1DyFDHBCyVPd48H48s/AoAUf7Rg==
X-Received: by 2002:a05:6214:2427:b0:66d:a4d:84f7 with SMTP id
 gy7-20020a056214242700b0066d0a4d84f7mr11772722qvb.28.1698099345303; 
 Mon, 23 Oct 2023 15:15:45 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 cu7-20020a05621417c700b0066cfd398ab5sm3118706qvb.146.2023.10.23.15.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 15:15:43 -0700 (PDT)
Date: Mon, 23 Oct 2023 17:15:40 -0500
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>,
 bpf <bpf@vger.kernel.org>
Message-ID: <20231023221540.GE32029@maniforge>
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQL69iqzxsNRDLKW22B=3sJpO0Yy2yHzioWZmhtQvUwtTQ@mail.gmail.com>
 <PH7PR21MB3878A25F817337EF14FE039FA3CAA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQ+BOdrU4x3qKHJVbpZCJwTWe6HXWhuMqOk-x5UK22yPDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAADnVQ+BOdrU4x3qKHJVbpZCJwTWe6HXWhuMqOk-x5UK22yPDQ@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/buG_W74esqo1cr2bxhfVt5qJcnI>
Subject: Re: [Bpf] ISA RFC compliance question
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gRnJpLCBPY3QgMDYsIDIwMjMgYXQgMDQ6MDY6NTNQTSAtMDcwMCwgQWxleGVpIFN0YXJvdm9p
dG92IHdyb3RlOgo+IE9uIFRodSwgT2N0IDUsIDIwMjMgYXQgMToxNOKAr1BNIERhdmUgVGhhbGVy
IDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+IHdyb3RlOgo+ID4KPiA+ID4gQWxleGVpIFN0YXJvdm9p
dG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gT24gRnJpLCBT
ZXAgMjksIDIwMjMgYXQgMToxN+KAr1BNIERhdmUgVGhhbGVyCj4gPiA+IDxkdGhhbGVyPTQwbWlj
cm9zb2Z0LmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6Cj4gPiA+ID4gTm93IHRoYXQgd2UgaGF2
ZSBzb21lIG5ldyAidjQiIGluc3RydWN0aW9ucywgaXQgc2VlbXMgYSBnb29kIHRpbWUgdG8KPiA+
ID4gPiBhc2sgYWJvdXQgd2hhdCBpdCBtZWFucyB0byBzdXBwb3J0IChvciBjb21wbHkgd2l0aCkg
dGhlIElTQSBSRkMgb25jZQo+ID4gPiA+IHB1Ymxpc2hlZC4gIERvZXMgaXQgbWVhbiB0aGF0IGEg
dmVyaWZpZXIvZGlzYXNzZW1ibGVyL0pJVCBjb21waWxlci9ldGMuIE1VU1QKPiA+ID4gc3VwcG9y
dCAqYWxsKiB0aGUKPiA+ID4gPiBub24tZGVwcmVjYXRlZCBpbnN0cnVjdGlvbnMgaW4gdGhlIGRv
Y3VtZW50PyAgIFRoYXQgaXMgYW55IHJ1bnRpbWUgb3IgdG9vbCB0aGF0Cj4gPiA+ID4gZG9lc24n
dCBzdXBwb3J0IHRoZSBuZXcgaW5zdHJ1Y3Rpb25zIGlzIGNvbnNpZGVyZWQgbm9uLWNvbXBsaWFu
dCB3aXRoIHRoZSBCUEYKPiA+ID4gSVNBPwo+ID4gWy4uLl0KPiA+ID4gPiBPciBzaG91bGQgd2Ug
Y3JlYXRlIHNvbWUgdGhpbmdzIHRoYXQgYXJlIFNIT1VMRHMsIG9yIGZpbmVyIGdyYWluZWQKPiA+
ID4gPiB1bml0cyBvZiBjb21wbGlhbmNlIHNvIGFzIHRvIG5vdCBkZWNsYXJlIGV4aXN0aW5nIGRl
cGxveW1lbnRzIG5vbi1jb21wbGlhbnQ/Cj4gPiA+Cj4gPiA+IEkgc3VzcGVjdCAnbm9uLWNvbXBs
aWFuY2UnIGxhYmVsIHdpbGwgY2F1c2UgYW4gdW5uZWNlc3NhcnkgYmFja2xhc2gsIHNvIEkgd291
bGQKPiA+ID4gZ28gd2l0aCBTSE9VTEQgd29yZGluZy4KPiA+Cj4gPiBZZWFoLCBidXQgaWYgZWFj
aCBpbnN0cnVjdGlvbiBpcyBhIHNlcGFyYXRlIFNIT1VMRCwgdGhlbiBhIHJ1bnRpbWUgY291bGQg
KHNheSkKPiA+IHN1cHBvcnQgb25lIGF0b21pYyBpbnN0cnVjdGlvbiBhbmQgbm90IG90aGVycy4g
IEhhdmluZyB0aGF0IGxldmVsIG9mIGdyYW51bGFyaXR5Cj4gPiB3b3VsZCByZWFsbHkgY29tcGxp
Y2F0ZSBpbnRlcm9wZXJhYmlsaXR5IGFuZCBjcm9zcy1wbGF0Zm9ybSB0b29saW5nIGluIG15IG9w
aW5pb24uCj4gPiBTbyBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gbGlzdCBncm91cHMgb2YgaW5zdHJ1
Y3Rpb25zIGFuZCBoYXZlIHRoZSBTSE9VTEQgYmUgYXQgdGhlCj4gPiBncmFudWxhcml0eSBvZiBh
IGdyb3VwPwo+IAo+IEkgZ3Vlc3Mgd2UgY2FuIGdyb3VwIHRoZW0gYmFzZWQgb24gTExWTSBldm9s
dXRpb24gb2YgdGhlIGluc3RydWN0aW9uIHNldDoKPiAtbWNwdT12MSx2Mix2Myx2NAo+IGJ1dCBp
dCB3b3VsZCBoYXZlIG1haW5seSBoaXN0b3JpY2FsIGJlbmVmaXRzIGFuZCBub3QgcHJhY3RpY2Fs
LgoKV2Ugd2lsbCBkaXNjdXNzIG1vcmUgYXQgSUVURiAxMTgsIGJ1dCBJIGFncmVlIHRoYXQgZ3Jv
dXBpbmcgYmFzZWQgb24KTExWTSBpbnN0cnVjdGlvbiBzZXQgcmVsZWFzZXMgaXMgbm90IGEgZ29v
ZCBpZGVhLiBJdCdzIHRoZSBzYW1lCnNlbnRpbWVudCBmb3Igd2h5IHdlIGRvbid0IHdhbnQgdG8g
c3RhbmRhcmRpemUgdGhlIC5tYXBzIEVMRiBzZWN0aW9uCmp1c3QgYmVjYXVzZSBpdCdzIHdoYXQg
bGliYnBmIGV4cGVjdHMuCgo+IEdyb3VwaW5nIGF0b21pYyB2cyBub3QgaXMgbm90IHJlYWxpc3Rp
YyBlaXRoZXIsIHNpbmNlIGF0b21pY194YWRkCj4gd2FzIHRoZXJlIHNpbmNlIHRoZSB2ZXJ5IGJl
Z2lubmluZy4KClRoaXMgbWlnaHQgYmUgYSBkdW1iIHF1ZXN0aW9uLCBidXQgSSdtIG5vdCBzdXJl
IEknbSBmb2xsb3dpbmcgd2h5IGl0CmJlaW5nIGludHJvZHVjZWQgc2luY2UgdGhlIGJlZ2lubmlu
ZyB3b3VsZCBwcmVjbHVkZSBpdCBmcm9tIGJlaW5nClNIT1VMRD8KCj4gSSBzdXNwZWN0IGFueSBr
aW5kIG9mIGdyb3VwaW5nIHNjaGVtZSB3aWxsIGVuZCB1cCBpbiBiaWtlIHNoZWRkaW5nLgo+IE15
IHByZWZlcmVuY2Ugd291bGQgYmUgdG8gYWdyZWUgb24gZWl0aGVyIFNIT1VMRCBvciBNVVNUIGZv
cgo+IGFsbCBpbnNucyBjdXJyZW50bHkgZGVzY3JpYmVkIGluIElTQSBkb2MuCgpTSE9VTEQgZm9y
IGFsbCBpbnN0cnVjdGlvbnMgc2VlbXMgdmVyeSByaXNreSBmb3IgY29tcGxpYW5jZS4gV291bGRu
J3QKdGhhdCBmdW5jdGlvbmFsbHkgbWFrZSB0aGUgc3RhbmRhcmQgZW50aXJlbHkgb3B0aW9uYWw/
Cgo+IFdlIGNhbiBnbyB3aXRoIE1VU1QgdG8gZm9yY2UgY29tcGxpYW5jZS4KPiBTb21lIGFyY2hz
LCBPU2VzLCBKSVRzIHdvbid0IGJlIGNvbXBsaWFudCBpbiB0aGUgc2hvcnQgdGVybSwKPiBidXQg
TVVTVCB3b3JkaW5nIHdpbGwgYmUgYSBnb29kIG1vdGl2YXRpb24gdG8gZG8gdGhlIHdvcmsgbm93
IGluc3RlYWQgb2YgbGF0ZXIuCgpUaGlzIHNlZW1zIGxpa2UgdGhlIG92ZXJhbGwgbG93ZXN0IHJp
c2sgdG8gbWUsIHRob3VnaCB0aGVyZSBhcmUgc29tZQpudWFuY2VzIHdlJ2xsIGhhdmUgdG8gY29u
c2lkZXIuIEZvciBleGFtcGxlLCBpdCB3b3VsZCByZXF1aXJlIHRoYXQgYWxsCnBsYXRmb3JtcyBz
dXBwb3J0IEJURiBpbiBvcmRlciB0byBiZSBjb21wbGlhbnQgd2l0aCBCUEZfQ0FMTCBieSBCVEYg
SUQuClJlYWxpc3RpY2FsbHkgdGhhdCBzZWVtcyBkZXNpcmFibGUuIFVubGVzcyB0aGVyZSBhcmUg
Z3JvdXBzIG9mCmluc3RydWN0aW9ucyB0aGF0IGNvdWxkIGJlIHN1Ym1pdHRlZCBsb2dpY2FsbHkg
YXMgdGhlaXIgb3duIHNlcGFyYXRlCmV4dGVuc2lvbnMsIGJlaW5nIGNvbnNpc3RlbnQgd2l0aCBN
VVNUIHNlZW1zIGxpa2UgdGhlIGxlYXN0IGVycm9yIHByb25lCmFwcHJvYWNoLgoKVGhhbmtzLApE
YXZpZAoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYu
b3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

