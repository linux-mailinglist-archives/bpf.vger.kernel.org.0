Return-Path: <bpf+bounces-14540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59117E613D
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8657B20A1C
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2838DF4;
	Wed,  8 Nov 2023 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xSWmLY5F";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xSWmLY5F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="OZGCiInh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F538DE9
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:57:29 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8A82684
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:57:29 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D30B3C15C297
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699487848; bh=9fVAmeB0FzXA3hu4f2EjY97pZ/orehMbPNnW6SP1TyQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xSWmLY5Fahnf3wY0JqNEVJttMuEV7YZ63yCQlgAl8m9yL7w8ryarlyA4LSYzZAnXA
	 V/X1uoUOrqfPe4Pt8PpLRGLFcAISo8W5hLxTIfdHn02xTkWM40H3eblo+AXU8KD/9v
	 HMXuD2wSWfQrQRqFn1IqqSRwH6b5zXJRBguDIMTA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Nov  8 15:57:28 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A35E8C15155C;
	Wed,  8 Nov 2023 15:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699487848; bh=9fVAmeB0FzXA3hu4f2EjY97pZ/orehMbPNnW6SP1TyQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xSWmLY5Fahnf3wY0JqNEVJttMuEV7YZ63yCQlgAl8m9yL7w8ryarlyA4LSYzZAnXA
	 V/X1uoUOrqfPe4Pt8PpLRGLFcAISo8W5hLxTIfdHn02xTkWM40H3eblo+AXU8KD/9v
	 HMXuD2wSWfQrQRqFn1IqqSRwH6b5zXJRBguDIMTA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2A056C15155C
 for <bpf@ietfa.amsl.com>; Wed,  8 Nov 2023 15:57:28 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.907
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F5SpAxmMRgVq for <bpf@ietfa.amsl.com>;
 Wed,  8 Nov 2023 15:57:27 -0800 (PST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 547A1C151551
 for <bpf@ietf.org>; Wed,  8 Nov 2023 15:57:27 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4ac0d137835so122826e0c.2
 for <bpf@ietf.org>; Wed, 08 Nov 2023 15:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699487845; x=1700092645;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ix611TUXuArUlzKgKZYbknlCpFFZo4IhUcEHvZIY0xk=;
 b=OZGCiInh5kWo9JwPNg8D2eSot+hqhR4F+uY9rw1ETWRSHixoGwlJqGUVyg67l8Syg2
 KYLUmlrzVqnO5WUsJyk2gRCumKDeud53sWXJNt5geObo7CeY+OAGwuqnz+8nC3BDOSt4
 2EDImOnapwEzVMI7mG9ONuDLNuYKUV+QstswbRSs/vWcxx+M5ODbwITbNx2Je7/zKNop
 UKHuHQEh8/0hcUoOpjxE0LUxNEM81RQO0YkIuh0IlFhqkFXROn1+fb+Ax7wXwWXRR0gM
 cpKXkPQTSiHY/NFBNTqgCJqaHaGeZyWLOB36pAF7Dt3+FL1Kj+Fe61Vhi3AkooCp/Fuw
 usjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699487845; x=1700092645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ix611TUXuArUlzKgKZYbknlCpFFZo4IhUcEHvZIY0xk=;
 b=txdahnrLAdwbV7p0hCwUkFK9wUqotCL+EQz4ufOcRD9YJZKPhsrvAVUaYGtEdiNU6v
 Ac6sfXZ+qtw0PaMpgDTRIW9oSEFLaZN6Tq62lnsRHaKd9GRVmDxp65AAOAEjdTWZ81Ap
 X1NMpARkb/aHMoNM0sZT/infMlmaNp8dKmRJ+9x7d//3U3MHmQ/SSxmlocWkdxdGPZ0K
 LRDNTBZuM57Wotq2QSyTOn0VHgfk49XSgoS/QuiU6ellGZgOuhIWxymQRNKBKMhl7M4v
 Tm2HzEtuVt8l3G7/CxNImqmGvY3yMIFPEOdQDjULrRBW9EL5aYTE9ufq9csSIwTKtd/U
 /ccQ==
X-Gm-Message-State: AOJu0YwfoASfnCx1n/DZkCrN0Oy1jRrUHsJBXVh6MC4AV+geNUwDqSzN
 r2gSwKid5dQuxQmEs95lIfvrDbE050Utu13p3Dw2xxBP8XSmbah/5po=
X-Google-Smtp-Source: AGHT+IGkLPLOTIbwV1ItrgYhlchV5MeUyiDUvSTq5fK/Kq5e0JahjKflNRuQKncGxS6j8XBHciKpeDMu/lab0BwmDCs=
X-Received: by 2002:a05:6122:311f:b0:4ac:49ea:9156 with SMTP id
 cg31-20020a056122311f00b004ac49ea9156mr139356vkb.2.1699487845636; Wed, 08 Nov
 2023 15:57:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr>
 <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
 <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
 <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com>
 <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com>
 <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com>
 <CADx9qWgps=T8COiFYTFPKObSUkMo9kaOKMRVub8quN_MkFM_LA@mail.gmail.com>
 <CAADnVQLhJh+qSc=xg5WDCfFzD-SO7KtoBz5MyQZUxEY0foY6aw@mail.gmail.com>
In-Reply-To: <CAADnVQLhJh+qSc=xg5WDCfFzD-SO7KtoBz5MyQZUxEY0foY6aw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 8 Nov 2023 18:57:14 -0500
Message-ID: <CADx9qWh2Q8fxR51UmE7AiWoRykA1VK70jHaNiry5KpNHUbQYhg@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/BAr5qx-zNOzM5XLxuqe8fUvOd7I>
Subject: Re: [Bpf] [PATCH v3] bpf,
 docs: Add additional ABI working draft base text
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

T24gV2VkLCBOb3YgOCwgMjAyMyBhdCAyOjUx4oCvUE0gQWxleGVpIFN0YXJvdm9pdG92CjxhbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgTm92IDgsIDIwMjMg
YXQgMjoxM+KAr0FNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+Cj4g
PiBPbiBUdWUsIE5vdiA3LCAyMDIzIGF0IDg6MTfigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVHVl
LCBOb3YgNywgMjAyMyBhdCAxMTo1NuKAr0FNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNy
PiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgTm92IDYsIDIwMjMgYXQgMzozOOKAr0FN
IEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29t
PiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBTdW4sIE5vdiA1LCAyMDIzIGF0IDQ6MTfi
gK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+IE9uIFN1biwgTm92IDUsIDIwMjMgYXQgNDo1MeKAr0FNIEFsZXhlaSBTdGFyb3Zv
aXRvdgo+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbiBGcmksIE5vdiAzLCAyMDIzIGF0IDI6MjDigK9Q
TSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiA+ID4gPiArVGhlIEFCSSBpcyBzcGVjaWZpZWQgaW4gdHdvIHBhcnRzOiBhIGdl
bmVyaWMgcGFydCBhbmQgYSBwcm9jZXNzb3Itc3BlY2lmaWMgcGFydC4KPiA+ID4gPiA+ID4gPiA+
ICtBIHBhaXJpbmcgb2YgZ2VuZXJpYyBBQkkgd2l0aCB0aGUgcHJvY2Vzc29yLXNwZWNpZmljIEFC
SSBmb3IgYSBjZXJ0YWluCj4gPiA+ID4gPiA+ID4gPiAraW5zdGFudGlhdGlvbiBvZiBhIEJQRiBt
YWNoaW5lIHJlcHJlc2VudHMgYSBjb21wbGV0ZSBiaW5hcnkgaW50ZXJmYWNlIGZvciBCUEYKPiA+
ID4gPiA+ID4gPiA+ICtwcm9ncmFtcyBleGVjdXRpbmcgb24gdGhhdCBtYWNoaW5lLgo+ID4gPiA+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gK1RoaXMgZG9jdW1lbnQgaXMgdGhlIGdlbmVyaWMg
QUJJIGFuZCBzcGVjaWZpZXMgdGhlIHBhcmFtZXRlcnMgYW5kIGJlaGF2aW9yCj4gPiA+ID4gPiA+
ID4gPiArY29tbW9uIHRvIGFsbCBpbnN0YW50aWF0aW9ucyBvZiBCUEYgbWFjaGluZXMuIEluIGFk
ZGl0aW9uLCBpdCBkZWZpbmVzIHRoZQo+ID4gPiA+ID4gPiA+ID4gK2RldGFpbHMgdGhhdCBtdXN0
IGJlIHNwZWNpZmllZCBieSBlYWNoIHByb2Nlc3Nvci1zcGVjaWZpYyBBQkkuCj4gPiA+ID4gPiA+
ID4gPiArCj4gPiA+ID4gPiA+ID4gPiArVGhlc2UgcHNBQklzIGFyZSB0aGUgc2Vjb25kIHBhcnQg
b2YgdGhlIEFCSS4gRWFjaCBpbnN0YW50aWF0aW9uIG9mIGEgQlBGCj4gPiA+ID4gPiA+ID4gPiAr
bWFjaGluZSBtdXN0IGRlc2NyaWJlIHRoZSBtZWNoYW5pc20gdGhyb3VnaCB3aGljaCBiaW5hcnkg
aW50ZXJmYWNlCj4gPiA+ID4gPiA+ID4gPiArY29tcGF0aWJpbGl0eSBpcyBtYWludGFpbmVkIHdp
dGggcmVzcGVjdCB0byB0aGUgaXNzdWVzIGhpZ2hsaWdodGVkIGJ5IHRoaXMKPiA+ID4gPiA+ID4g
PiA+ICtkb2N1bWVudC4gSG93ZXZlciwgdGhlIGRldGFpbHMgdGhhdCBtdXN0IGJlIGRlZmluZWQg
YnkgYSBwc0FCSSBhcmUgYSBtaW5pbXVtIC0tCj4gPiA+ID4gPiA+ID4gPiArYSBwc0FCSSBtYXkg
c3BlY2lmeSBhZGRpdGlvbmFsIHJlcXVpcmVtZW50cyBmb3IgYmluYXJ5IGludGVyZmFjZSBjb21w
YXRpYmlsaXR5Cj4gPiA+ID4gPiA+ID4gPiArb24gYSBwbGF0Zm9ybS4KPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNh
eSBpbiB0aGUgYWJvdmUuCj4gPiA+ID4gPiA+ID4gSW4gbXkgbWluZCB0aGVyZSBpcyBvbmx5IG9u
ZSBCUEYgcHNBQkkgYW5kIGl0IGRvZXNuJ3QgaGF2ZQo+ID4gPiA+ID4gPiA+IGdlbmVyaWMgYW5k
IHByb2Nlc3NvciBwYXJ0cy4gVGhlcmUgaXMgb25seSBvbmUgInByb2Nlc3NvciIuCj4gPiA+ID4g
PiA+ID4gQlBGIGlzIHN1Y2ggYSBwcm9jZXNzb3IuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFdo
YXQgSSB3YXMgdHJ5aW5nIHRvIHNheSB3YXMgdGhhdCB0aGUgZG9jdW1lbnQgaGVyZSBkZXNjcmli
ZXMgYQo+ID4gPiA+ID4gPiBnZW5lcmljIEFCSS4gSW4gdGhpcyBkb2N1bWVudCB0aGVyZSB3aWxs
IGJlIGFyZWFzIHRoYXQgYXJlIHNwZWNpZmljIHRvCj4gPiA+ID4gPiA+IGRpZmZlcmVudCBpbXBs
ZW1lbnRhdGlvbnMgYW5kIHRob3NlIHdvdWxkIGJlIGNvbnNpZGVyZWQgcHJvY2Vzc29yCj4gPiA+
ID4gPiA+IHNwZWNpZmljLiBJbiBvdGhlciB3b3JkcywgdGhlIHVicGYgcnVudGltZSBjb3VsZCBk
ZWZpbmUgdGhvc2UgdGhpbmdzCj4gPiA+ID4gPiA+IGRpZmZlcmVudGx5IHRoYW4gdGhlIHJicGYg
cnVudGltZSB3aGljaCwgaW4gdHVybiwgY291bGQgZGVmaW5lIHRob3NlCj4gPiA+ID4gPiA+IHRo
aW5ncyBkaWZmZXJlbnRseSB0aGFuIHRoZSBrZXJuZWwncyBpbXBsZW1lbnRhdGlvbi4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBJIHNlZSB3aGF0IHlvdSBtZWFuLiBUaGVyZSBpcyBvbmx5IG9uZSBCUEYg
cHNBQkkuIFRoZXJlIGNhbm5vdCBiZSB0d28uCj4gPiA+ID4gPiB1YnBmIGNhbiBkZWNpZGUgbm90
IHRvIGZvbGxvdyBpdCwgYnV0IGl0IGNvdWxkIG9ubHkgbWVhbiB0aGF0Cj4gPiA+ID4gPiBpdCdz
IG5vbiBjb25mb3JtYW50IGFuZCBub3QgY29tcGF0aWJsZS4KPiA+ID4gPgo+ID4gPiA+IE9rYXku
IFRoYXQgd2FzIG5vdCBob3cgSSB3YXMgc3RydWN0dXJpbmcgdGhlIEFCSS4gSSB0aG91Z2h0IHdl
IGhhZAo+ID4gPiA+IGRlY2lkZWQgdGhhdCwgYXMgdGhlIGRvY3VtZW50IHNhaWQsIGFuIGluc3Rh
bnRpYXRpb24gb2YgYSBtYWNoaW5lIGhhZAo+ID4gPiA+IHRvCj4gPiA+ID4KPiA+ID4gPiAxLiBt
ZWV0IHRoZSBnQUJJCj4gPiA+ID4gMi4gc3BlY2lmeSBpdHMgcmVxdWlyZW1lbnRzIHZpcyBhIHZp
cyB0aGUgcHNBQkkKPiA+ID4gPiAzLiAob3B0aW9uYWxseSkgZGVzY3JpYmUgb3RoZXIgcmVxdWly
ZW1lbnRzLgo+ID4gPiA+Cj4gPiA+ID4gSWYgdGhhdCBpcyBub3Qgd2hhdCB3ZSBkZWNpZGVkIHRo
ZW4gd2Ugd2lsbCBoYXZlIHRvIHJlc3RydWN0dXJlIHRoZSBkb2N1bWVudC4KPiA+ID4KPiA+ID4g
VGhpcyBhYmkucnN0IGZpbGUgaXMgdGhlIGJlZ2lubmluZyBvZiAiQlBGIHBzQUJJIiBkb2N1bWVu
dC4KPiA+ID4gV2UgcHJvYmFibHkgc2hvdWxkIHJlbmFtZSBpdCB0byBwc2FiaS5yc3QgdG8gYXZv
aWQgY29uZnVzaW9uLgo+ID4gPiBTZWUgbXkgc2xpZGVzIGZyb20gSUVURiAxMTguIEkgaG9wZSB0
aGV5IGV4cGxhaW4gd2hhdCAiQlBGIHBzQUJJIiBpcyBmb3IuCj4gPgo+ID4gT2YgY291cnNlIHRo
ZXkgZG8hIFRoYW5rIHlvdSEgTXkgb25seSBxdWVzdGlvbjogSW4gdGhlIGxhbmd1YWdlIEkgd2Fz
Cj4gPiB1c2luZywgSSB3YXMgdGFraW5nIGEgY3VlIGZyb20gdGhlIFN5c3RlbSBWIHdvcmxkIHdo
ZXJlIHRoZXJlIGlzIGEKPiA+IEdlbmVyaWMgQUJJIGFuZCBhIHBzQUJJLiBUaGUgR2VuZXJpYyBB
QkkgYXBwbGllcyB0byBhbGwgU3lzdGVtIFYKPiA+IGNvbXBhdGlibGUgc3lzdGVtcyBhbmQgZGVm
aW5lcyBjZXJ0YWluIHByb2Nlc3Nvci1zcGVjaWZpYyBkZXRhaWxzIHRoYXQKPiA+IGVhY2ggcGxh
dGZvcm0gbXVzdCBzcGVjaWZ5IHRvIGRlZmluZSBhIGNvbXBsZXRlIEFCSS4gSW4gcGFydGljdWxh
ciwgSQo+ID4gdG9vayB0aGlzIGxhbmd1YWdlIGFzIGluc3BpcmF0aW9uCj4gPgo+ID4gIiIiCj4g
PiBUaGUgU3lzdGVtIFYgQUJJIGlzIGNvbXBvc2VkIG9mIHR3byBiYXNpYyBwYXJ0czogQSBnZW5l
cmljIHBhcnQgb2YgdGhlCj4gPiBzcGVjaWZpY2F0aW9uIGRlc2NyaWJlcyB0aG9zZSBwYXJ0cyBv
ZiB0aGUgaW50ZXJmYWNlIHRoYXQgcmVtYWluCj4gPiBjb25zdGFudCBhY3Jvc3MgYWxsIGhhcmR3
YXJlIGltcGxlbWVudGF0aW9ucyBvZiBTeXN0ZW0gViwgYW5kIGEKPiA+IHByb2Nlc3Nvci1zcGVj
aWZpYyBwYXJ0IG9mIHRoZSBzcGVjaWZpY2F0aW9uIGRlc2NyaWJlcyB0aGUgcGFydHMgb2YKPiA+
IHRoZSBzcGVjaWZpY2F0aW9uIHRoYXQgYXJlIHNwZWNpZmljIHRvIGEgcGFydGljdWxhciBwcm9j
ZXNzb3IKPiA+IGFyY2hpdGVjdHVyZS4gVG9nZXRoZXIsIHRoZSBnZW5lcmljIEFCSSAob3IgZ0FC
SSkgYW5kIHRoZSBwcm9jZXNzb3IKPiA+IHNwZWNpZmljIHN1cHBsZW1lbnQgKG9yIHBzQUJJKSBw
cm92aWRlIGEgY29tcGxldGUgaW50ZXJmYWNlCj4gPiBzcGVjaWZpY2F0aW9uIGZvciBjb21waWxl
ZCBhcHBsaWNhdGlvbiBwcm9ncmFtcyBvbiBzeXN0ZW1zIHRoYXQgc2hhcmUKPiA+IGEgY29tbW9u
IGhhcmR3YXJlIGFyY2hpdGVjdHVyZS4KPiA+ICIiIgo+Cj4gSSBzZWUgd2hlcmUgeW91IGdvdCB0
aGUgaW5zcGlyYXRpb24gZnJvbSwgYnV0IGl0J3Mgbm90IGFwcGxpY2FibGUKPiBpbiB0aGUgQlBG
IGNhc2UuIEJQRiBpcyBzdWNoIG9uZSBhbmQgb25seSBwcm9jZXNzb3IuCj4gV2UncmUgbm90IGNo
YW5naW5nIG5vciBhZGRpbmcgYW55dGhpbmcgdG8gU3lzIFYgZ2VuZXJpYyBwYXJ0cy4KClRoYXQg
d2FzIG5vdCBxdWl0ZSB3aGF0IEkgd2FzIHNheWluZy4gV2hhdCBJIHN0YXJ0ZWQgdG8gZHJhZnQg
aXMKc29tZXRoaW5nICh5ZXMsIG1vZGVsZWQgYWZ0ZXIgdGhlIFN5cyBWIChnL3BzKUFCSSkgYnV0
IF9icmFuZCBuZXdfIGZvcgpCUEYuIEkgdGhpbmsgdGhhdCBpcyB3aGVyZSBJIGhhdmUgYmVlbiBm
YWlsaW5nIHRvIGNvbW11bmljYXRlCmNvcnJlY3RseS4gV2hhdCBJIHdhcyBwcm9wb3Npbmcgd2Fz
IGluc3BpcmVkIGJ5IG90aGVyIEFCSXMgYnV0CmNvbXBsZXRlbHkgc2VwYXJhdGUgYW5kIG9ydGhv
Z29uYWwuIFRoYXQgaXMgdGhlIHJlYXNvbiBmb3IgdGhlCmRvY3VtZW50IHNwZWFraW5nIG9mIGEg
QlBGIE1hY2hpbmUgbGlrZToKCkFCSS1jb25mb3JtaW5nIEJQRiBNYWNoaW5lIEluc3RhbnRpYXRp
b246IEEgcGh5c2ljYWwgb3IgbG9naWNhbCByZWFsaXphdGlvbgogICBvZiBhIGNvbXB1dGVyIHN5
c3RlbSBjYXBhYmxlIG9mIGV4ZWN1dGluZyBCUEYgcHJvZ3JhbXMgY29uc2lzdGVudGx5IHdpdGgg
dGhlCiAgIHNwZWNpZmljYXRpb25zIG91dGxpbmVkIGluIHRoaXMgZG9jdW1lbnQuCgpiZWNhdXNl
IGl0IGlzIGEgKG5vdCBuZWNlc3NhcmlseSBwaHlzaWNhbCkgZW50aXR5IHRoYXQgZXhlY3V0ZXMg
QlBGCnByb2dyYW1zIChpLmUuIGEgIkJQRiBDUFUiKSBmb3Igd2hpY2ggd2UgYXJlIHNwZWNpZnlp
bmcgdGhlIGJpbmFyeQpjb21wYXRpYmlsaXR5LiBJbiBvdGhlciB3b3JkcywgdGhlIGRvY3VtZW50
IGFzIGl0IHN0YW5kcyBpcyBwcm9wb3NpbmcKYSBnQUJJIHdoZXJlCgp0aGUga2VybmVsJ3MgIkJQ
RiBDUFUiIHdvdWxkIGhhdmUgaXRzIG93biBwc0FCSQp1YnBmJ3MgIkJQRiBDUFUiIHdvdWxkIGhh
dmUgaXRzIG93biBwc0FCSQoKYW5kIG90aGVycyBjb3VsZCBkbyB0aGUgc2FtZSBpbnRvIHRoZSBm
dXR1cmUgc28gbG9uZyBhcyB0aGV5IG1ldCB0aGUKZ0FCSSBndWlkZWxpbmVzIGFuZCBwcm9wZXJs
eSBvdXRsaW5lZCB0aGUgd2F5IHRoYXQgdGhleSBoYW5kbGUgdGhlCnByb2Nlc3Nvci1zcGVjaWZp
YyBkZXRhaWxzLgoKTXkgZ29hbCB3aXRoIHdyaXRpbmcgd2FzIHRvIGdpdmUgdXMgdGhlIGNoYW5j
ZSB0byBidWlsZCBhIHdob2xlCnNlcGFyYXRlIHN0cnVjdHVyZSBmcmVlIGFuZCBjbGVhciBmcm9t
IFN5cyBWIHNvIHdlIGNvdWxkIGRlZmluZSBvdXIKb3duIHJ1bGVzIGlmL3doZXJlIHRoZXJlIGlz
IG1pc2FsaWdubWVudCBiZXR3ZWVuIEJQRiBwcm9ncmFtcyBhbmQKcHJvZ3JhbXMgdGhhdCBleGVj
dXRlIG9uIGEgdHJhZGl0aW9uYWwgQ1BVLgoKSWYgeW91IGJlbGlldmUgdGhhdCB3ZSBzaG91bGQg
anVzdCBkZWZpbmUgYSBwc0FCSSBmb3IgQlBGIGFuZCBzbG90IGluCnRvIHRoZSBTeXNWIEFCSSB0
aGF0IGlzIHBlcmZlY3RseSBva2F5IHdpdGggbWUgKGFnYWluLCB5b3UgYXJlIHRoZQpleHBlcnQp
IGJ1dCB0aGF0IGlzIHZlcnkgZGlmZmVyZW50IHRoYW4gdGhlIHdheSB0aGUgY3VycmVudGx5IHBy
b3Bvc2VkCmRvY3VtZW50IGlzIHdyaXR0ZW4uCgpXaWxsCgotLSAKQnBmIG1haWxpbmcgbGlzdApC
cGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

