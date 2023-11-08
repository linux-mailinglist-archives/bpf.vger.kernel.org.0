Return-Path: <bpf+bounces-14453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 137907E4E86
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 02:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3446B1C20DB6
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 01:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71E67FD;
	Wed,  8 Nov 2023 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="b+z3O8Ll";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="b+z3O8Ll";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxGQ5tFX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FE65E
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 01:17:33 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4BF93
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 17:17:32 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3A65DC1D471A
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699406252; bh=SwRLRoAN28DJknd28WRGTtrquxRvz9bJn27TF0+9QyQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=b+z3O8Ll8Wv5Xkk48fmsFIpxH6CzGCtN4UcbxQTZlSsWHhGZcDBzaimZTx208cbM3
	 N/NLVKOQuujUZ+v5zOXXLE5AgMeZcN8Bed5R76uWsnA1YP1L/gjxZl8G5VHKNCniUp
	 C37E19R00vVan7VH6xeuJwFSzPYJT3769uF4H6JI=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Nov  7 17:17:32 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0BD97C18E52E;
	Tue,  7 Nov 2023 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699406252; bh=SwRLRoAN28DJknd28WRGTtrquxRvz9bJn27TF0+9QyQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=b+z3O8Ll8Wv5Xkk48fmsFIpxH6CzGCtN4UcbxQTZlSsWHhGZcDBzaimZTx208cbM3
	 N/NLVKOQuujUZ+v5zOXXLE5AgMeZcN8Bed5R76uWsnA1YP1L/gjxZl8G5VHKNCniUp
	 C37E19R00vVan7VH6xeuJwFSzPYJT3769uF4H6JI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E28F8C18E52D
 for <bpf@ietfa.amsl.com>; Tue,  7 Nov 2023 17:17:30 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2zg_D-pQEQif for <bpf@ietfa.amsl.com>;
 Tue,  7 Nov 2023 17:17:30 -0800 (PST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7C787C18E1A2
 for <bpf@ietf.org>; Tue,  7 Nov 2023 17:17:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso1456575e9.0
 for <bpf@ietf.org>; Tue, 07 Nov 2023 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699406248; x=1700011048; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9YPgxuoMwLg76ioqZ3IgWHBoV61odditqzhqJ1hENs=;
 b=bxGQ5tFXer5tFK3cJ7McvAn3VZWomx+Zyi71+7NlFSRD08P7jLAgbVLf9CXU7CJJNC
 glHcD5EIbYShlnbXdah50s1Tjb6AHWWFqnduZzEj2W6hhrlfRKw574ZTeLma5C7Mxv1+
 BfdJsedOzwkz7d556VO1MlXDX45ADMa5ajRbL6huYUWpeb+7odW9FEOUbOv3/6AYcPpk
 1tkvNoUYhTtSyndrj7frLTTbDlSaYm39/d1x+Ju18yVxD3ZYJVpdbtlT9UaX1afllLs4
 t5VY7LF68rKT106BNQB6ikJcfe7/yhgmY4kyK19VwF1aoXaSZEmgvn9vvrYRwaQvF+63
 Jffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699406248; x=1700011048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9YPgxuoMwLg76ioqZ3IgWHBoV61odditqzhqJ1hENs=;
 b=tvhuSSrqW/Ss/Rxw8CwcsE2GCFPZiEoNFbvHMwqAlNsC/2xMZB8vaTuYPF+k2v0741
 xofagwFbYO7KJLU+/jEkgy8C1FIFEOTRCUj5Qbf7o0/zziWyM9SoPKIERfL760b0kuyq
 oB57YEgzvxvp/wwzNzIihxy+XOqBNUeM0Bv2coBXyn+js6CB1rsycANN7MLv3ih9MTWr
 0vh7cqF2KFEiLs8D/s91lI0Oy24wBxjUx8ALkvswwqC5EyU5owD3TRwq9OdXulQgxyMI
 /RS1VRtaZ13oPvwrI0efv1AlxxXwCYO/pd0/U1FaMBKkWs7FxNmYPe1dRjjVL3p4hM8j
 yg0g==
X-Gm-Message-State: AOJu0YwCHatM5SW61S90QclQMUSrHiBWFzwE3TkrRJTN1Q/e4iQGhW7N
 uJPBuX6iszGD60VG7NTwWjqbf5wDdp5KkkbYrMI=
X-Google-Smtp-Source: AGHT+IGhxgguE4IuvkgTaiWIiGJF1oidEjPSW8RiSFLlRciJgT1GG2l/my+me8cw94xtnsn9ZFLwSSIx8ppUtjARxaw=
X-Received: by 2002:a05:600c:3ba7:b0:408:33ba:569a with SMTP id
 n39-20020a05600c3ba700b0040833ba569amr5231776wms.8.1699406248071; Tue, 07 Nov
 2023 17:17:28 -0800 (PST)
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
In-Reply-To: <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Nov 2023 17:17:16 -0800
Message-ID: <CAADnVQ+w5C_MgPh2FVK=YOXrJ2LuqHzn88jFiR+yeHzB=MBoLw@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/7eSkU8CRJkNuiIEIT3IczmPKQQQ>
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

T24gVHVlLCBOb3YgNywgMjAyMyBhdCAxMTo1NuKAr0FNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IE9uIE1vbiwgTm92IDYsIDIwMjMgYXQgMzozOOKAr0FNIEFsZXhl
aSBTdGFyb3ZvaXRvdgo+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+
Cj4gPiBPbiBTdW4sIE5vdiA1LCAyMDIzIGF0IDQ6MTfigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tp
bnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFN1biwgTm92IDUsIDIwMjMgYXQgNDo1
MeKAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWls
LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBGcmksIE5vdiAzLCAyMDIzIGF0IDI6MjDi
gK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiArCj4g
PiA+ID4gPiArVGhlIEFCSSBpcyBzcGVjaWZpZWQgaW4gdHdvIHBhcnRzOiBhIGdlbmVyaWMgcGFy
dCBhbmQgYSBwcm9jZXNzb3Itc3BlY2lmaWMgcGFydC4KPiA+ID4gPiA+ICtBIHBhaXJpbmcgb2Yg
Z2VuZXJpYyBBQkkgd2l0aCB0aGUgcHJvY2Vzc29yLXNwZWNpZmljIEFCSSBmb3IgYSBjZXJ0YWlu
Cj4gPiA+ID4gPiAraW5zdGFudGlhdGlvbiBvZiBhIEJQRiBtYWNoaW5lIHJlcHJlc2VudHMgYSBj
b21wbGV0ZSBiaW5hcnkgaW50ZXJmYWNlIGZvciBCUEYKPiA+ID4gPiA+ICtwcm9ncmFtcyBleGVj
dXRpbmcgb24gdGhhdCBtYWNoaW5lLgo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gK1RoaXMgZG9jdW1l
bnQgaXMgdGhlIGdlbmVyaWMgQUJJIGFuZCBzcGVjaWZpZXMgdGhlIHBhcmFtZXRlcnMgYW5kIGJl
aGF2aW9yCj4gPiA+ID4gPiArY29tbW9uIHRvIGFsbCBpbnN0YW50aWF0aW9ucyBvZiBCUEYgbWFj
aGluZXMuIEluIGFkZGl0aW9uLCBpdCBkZWZpbmVzIHRoZQo+ID4gPiA+ID4gK2RldGFpbHMgdGhh
dCBtdXN0IGJlIHNwZWNpZmllZCBieSBlYWNoIHByb2Nlc3Nvci1zcGVjaWZpYyBBQkkuCj4gPiA+
ID4gPiArCj4gPiA+ID4gPiArVGhlc2UgcHNBQklzIGFyZSB0aGUgc2Vjb25kIHBhcnQgb2YgdGhl
IEFCSS4gRWFjaCBpbnN0YW50aWF0aW9uIG9mIGEgQlBGCj4gPiA+ID4gPiArbWFjaGluZSBtdXN0
IGRlc2NyaWJlIHRoZSBtZWNoYW5pc20gdGhyb3VnaCB3aGljaCBiaW5hcnkgaW50ZXJmYWNlCj4g
PiA+ID4gPiArY29tcGF0aWJpbGl0eSBpcyBtYWludGFpbmVkIHdpdGggcmVzcGVjdCB0byB0aGUg
aXNzdWVzIGhpZ2hsaWdodGVkIGJ5IHRoaXMKPiA+ID4gPiA+ICtkb2N1bWVudC4gSG93ZXZlciwg
dGhlIGRldGFpbHMgdGhhdCBtdXN0IGJlIGRlZmluZWQgYnkgYSBwc0FCSSBhcmUgYSBtaW5pbXVt
IC0tCj4gPiA+ID4gPiArYSBwc0FCSSBtYXkgc3BlY2lmeSBhZGRpdGlvbmFsIHJlcXVpcmVtZW50
cyBmb3IgYmluYXJ5IGludGVyZmFjZSBjb21wYXRpYmlsaXR5Cj4gPiA+ID4gPiArb24gYSBwbGF0
Zm9ybS4KPiA+ID4gPgo+ID4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBhcmUgdHJ5
aW5nIHRvIHNheSBpbiB0aGUgYWJvdmUuCj4gPiA+ID4gSW4gbXkgbWluZCB0aGVyZSBpcyBvbmx5
IG9uZSBCUEYgcHNBQkkgYW5kIGl0IGRvZXNuJ3QgaGF2ZQo+ID4gPiA+IGdlbmVyaWMgYW5kIHBy
b2Nlc3NvciBwYXJ0cy4gVGhlcmUgaXMgb25seSBvbmUgInByb2Nlc3NvciIuCj4gPiA+ID4gQlBG
IGlzIHN1Y2ggYSBwcm9jZXNzb3IuCj4gPiA+Cj4gPiA+IFdoYXQgSSB3YXMgdHJ5aW5nIHRvIHNh
eSB3YXMgdGhhdCB0aGUgZG9jdW1lbnQgaGVyZSBkZXNjcmliZXMgYQo+ID4gPiBnZW5lcmljIEFC
SS4gSW4gdGhpcyBkb2N1bWVudCB0aGVyZSB3aWxsIGJlIGFyZWFzIHRoYXQgYXJlIHNwZWNpZmlj
IHRvCj4gPiA+IGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbnMgYW5kIHRob3NlIHdvdWxkIGJlIGNv
bnNpZGVyZWQgcHJvY2Vzc29yCj4gPiA+IHNwZWNpZmljLiBJbiBvdGhlciB3b3JkcywgdGhlIHVi
cGYgcnVudGltZSBjb3VsZCBkZWZpbmUgdGhvc2UgdGhpbmdzCj4gPiA+IGRpZmZlcmVudGx5IHRo
YW4gdGhlIHJicGYgcnVudGltZSB3aGljaCwgaW4gdHVybiwgY291bGQgZGVmaW5lIHRob3NlCj4g
PiA+IHRoaW5ncyBkaWZmZXJlbnRseSB0aGFuIHRoZSBrZXJuZWwncyBpbXBsZW1lbnRhdGlvbi4K
PiA+Cj4gPiBJIHNlZSB3aGF0IHlvdSBtZWFuLiBUaGVyZSBpcyBvbmx5IG9uZSBCUEYgcHNBQkku
IFRoZXJlIGNhbm5vdCBiZSB0d28uCj4gPiB1YnBmIGNhbiBkZWNpZGUgbm90IHRvIGZvbGxvdyBp
dCwgYnV0IGl0IGNvdWxkIG9ubHkgbWVhbiB0aGF0Cj4gPiBpdCdzIG5vbiBjb25mb3JtYW50IGFu
ZCBub3QgY29tcGF0aWJsZS4KPgo+IE9rYXkuIFRoYXQgd2FzIG5vdCBob3cgSSB3YXMgc3RydWN0
dXJpbmcgdGhlIEFCSS4gSSB0aG91Z2h0IHdlIGhhZAo+IGRlY2lkZWQgdGhhdCwgYXMgdGhlIGRv
Y3VtZW50IHNhaWQsIGFuIGluc3RhbnRpYXRpb24gb2YgYSBtYWNoaW5lIGhhZAo+IHRvCj4KPiAx
LiBtZWV0IHRoZSBnQUJJCj4gMi4gc3BlY2lmeSBpdHMgcmVxdWlyZW1lbnRzIHZpcyBhIHZpcyB0
aGUgcHNBQkkKPiAzLiAob3B0aW9uYWxseSkgZGVzY3JpYmUgb3RoZXIgcmVxdWlyZW1lbnRzLgo+
Cj4gSWYgdGhhdCBpcyBub3Qgd2hhdCB3ZSBkZWNpZGVkIHRoZW4gd2Ugd2lsbCBoYXZlIHRvIHJl
c3RydWN0dXJlIHRoZSBkb2N1bWVudC4KClRoaXMgYWJpLnJzdCBmaWxlIGlzIHRoZSBiZWdpbm5p
bmcgb2YgIkJQRiBwc0FCSSIgZG9jdW1lbnQuCldlIHByb2JhYmx5IHNob3VsZCByZW5hbWUgaXQg
dG8gcHNhYmkucnN0IHRvIGF2b2lkIGNvbmZ1c2lvbi4KU2VlIG15IHNsaWRlcyBmcm9tIElFVEYg
MTE4LiBJIGhvcGUgdGhleSBleHBsYWluIHdoYXQgIkJQRiBwc0FCSSIgaXMgZm9yLgoKLS0gCkJw
ZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4v
bGlzdGluZm8vYnBmCg==

