Return-Path: <bpf+bounces-14269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A04C7E181E
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 01:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C30B20D0E
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD03F396;
	Mon,  6 Nov 2023 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xf9KNPph";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xf9KNPph";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="GB0/1mAl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971637E
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 00:17:54 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D1B8
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 16:17:52 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 804F0C1E4E7E
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 16:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699229871; bh=llBgR4f8dWxflx4eAalsgwtA+H5FJqAxBXyNVOfFhTk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xf9KNPphJevrUNe3QrqRGa1Uhb0M2YBqACD9xSSnpE+GPI58SpW2Vah9nREaD15g1
	 efO7E8goDK71d97v5w6cEqgx1l3SKsWosADyOFhwfmv+S55D1sEmj9jA5wZrQB4GJK
	 +trljSC9y3POIec7e4BuiT9N8g9zZiSrjIwh+CwM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sun Nov  5 16:17:51 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 52F77C1CAB59;
	Sun,  5 Nov 2023 16:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699229871; bh=llBgR4f8dWxflx4eAalsgwtA+H5FJqAxBXyNVOfFhTk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=xf9KNPphJevrUNe3QrqRGa1Uhb0M2YBqACD9xSSnpE+GPI58SpW2Vah9nREaD15g1
	 efO7E8goDK71d97v5w6cEqgx1l3SKsWosADyOFhwfmv+S55D1sEmj9jA5wZrQB4GJK
	 +trljSC9y3POIec7e4BuiT9N8g9zZiSrjIwh+CwM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7DB20C1CAB59
 for <bpf@ietfa.amsl.com>; Sun,  5 Nov 2023 16:17:50 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.907
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uuQCkitXIG5m for <bpf@ietfa.amsl.com>;
 Sun,  5 Nov 2023 16:17:49 -0800 (PST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id ED63BC1705ED
 for <bpf@ietf.org>; Sun,  5 Nov 2023 16:17:49 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-66d0ceba445so21741436d6.0
 for <bpf@ietf.org>; Sun, 05 Nov 2023 16:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699229868; x=1699834668;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulsmunuNb8bz0pUFc21DYC/kQrN38pAwzjD0Cf6Sa9A=;
 b=GB0/1mAlwOZtkySCdzG200HqUu8kN25GtU0/Q2gfnnTBqeBOomNX7NskaESNSnmrGZ
 GcZKx0We+/WJ7xjnzUZdlzRZZzdTC1R0rM9muEhW0BeJVBmEVWVG4keQNSbAP2n2pT6X
 371cZI/hDIdaisbK/m2bRXdD0uFDPtHa4eHFAb3KWcEy653zyVyh7/hvWz57Uo3httg9
 Z5n0SmBI5PYL7OpDCvfrCG5OrSvf1mR7PvdPhLngvkECVeTKI9wsBGNjMY91ks5+ByoX
 GnNYcQt8DkBMJhjGIf8Oxo8svMxYE+/Azw8KKRp6tUUw+tRChdWyxAGmeNEj5LMWCf3n
 JVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699229868; x=1699834668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulsmunuNb8bz0pUFc21DYC/kQrN38pAwzjD0Cf6Sa9A=;
 b=sQls7rGp0TGGLyrbtdUmv2rLA071DLi0zzoLsW8FANZvFZ0TK6mCXFJsmTcbPz94aa
 +cFpMmeydXqaxlt7i1DIQ2bDvbC2ZC95UlPEF4rurkUeM3Rf8KSTmakSG8ebBZIhiyhQ
 ObRqM8K24ii1JOac180cUyJUBujokjrDz/8aAn4h9hf/6f9qnl8eu3DfVuNk57xWAeU6
 rlYzS9duTbfe0nxhE5aWxo08o+GhUodTf1L2Y+FFeeAu0JzuQrKQNNh3YbRwbyG4tRG0
 HJFeFfXGE5k8lSqzqhejCAnrYsDzuRssRJnirTXJW4gnvbeP1Hct2Bq2egaO5LTnEfn7
 7alA==
X-Gm-Message-State: AOJu0Yw2LUd/JVhIxE9jlcX1j48C7vCX5hv2L/8X6xpe9vKoeW25Cdrf
 XN/2tXzlJ6LJvvPTYd4ielSRZugXe9LrDLswIe0dyQ==
X-Google-Smtp-Source: AGHT+IEklZDO6gZsTi+kvNyqhsxeJHjtg3+uciDip8aP1B0ev6pt81FBmlxgTfbZZUXkMcz3qAutFsqGN7H8LRmTIpQ=
X-Received: by 2002:a05:6214:2488:b0:65d:afc:3a52 with SMTP id
 gi8-20020a056214248800b0065d0afc3a52mr30052300qvb.49.1699229868554; Sun, 05
 Nov 2023 16:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr>
 <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
In-Reply-To: <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sun, 5 Nov 2023 19:17:37 -0500
Message-ID: <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/WWXobvmTc2GOByEwyZQJuuV4S04>
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

T24gU3VuLCBOb3YgNSwgMjAyMyBhdCA0OjUx4oCvQU0gQWxleGVpIFN0YXJvdm9pdG92CjxhbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgTm92IDMsIDIwMjMg
YXQgMjoyMOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ICsK
PiA+ICtUaGUgQUJJIGlzIHNwZWNpZmllZCBpbiB0d28gcGFydHM6IGEgZ2VuZXJpYyBwYXJ0IGFu
ZCBhIHByb2Nlc3Nvci1zcGVjaWZpYyBwYXJ0Lgo+ID4gK0EgcGFpcmluZyBvZiBnZW5lcmljIEFC
SSB3aXRoIHRoZSBwcm9jZXNzb3Itc3BlY2lmaWMgQUJJIGZvciBhIGNlcnRhaW4KPiA+ICtpbnN0
YW50aWF0aW9uIG9mIGEgQlBGIG1hY2hpbmUgcmVwcmVzZW50cyBhIGNvbXBsZXRlIGJpbmFyeSBp
bnRlcmZhY2UgZm9yIEJQRgo+ID4gK3Byb2dyYW1zIGV4ZWN1dGluZyBvbiB0aGF0IG1hY2hpbmUu
Cj4gPiArCj4gPiArVGhpcyBkb2N1bWVudCBpcyB0aGUgZ2VuZXJpYyBBQkkgYW5kIHNwZWNpZmll
cyB0aGUgcGFyYW1ldGVycyBhbmQgYmVoYXZpb3IKPiA+ICtjb21tb24gdG8gYWxsIGluc3RhbnRp
YXRpb25zIG9mIEJQRiBtYWNoaW5lcy4gSW4gYWRkaXRpb24sIGl0IGRlZmluZXMgdGhlCj4gPiAr
ZGV0YWlscyB0aGF0IG11c3QgYmUgc3BlY2lmaWVkIGJ5IGVhY2ggcHJvY2Vzc29yLXNwZWNpZmlj
IEFCSS4KPiA+ICsKPiA+ICtUaGVzZSBwc0FCSXMgYXJlIHRoZSBzZWNvbmQgcGFydCBvZiB0aGUg
QUJJLiBFYWNoIGluc3RhbnRpYXRpb24gb2YgYSBCUEYKPiA+ICttYWNoaW5lIG11c3QgZGVzY3Jp
YmUgdGhlIG1lY2hhbmlzbSB0aHJvdWdoIHdoaWNoIGJpbmFyeSBpbnRlcmZhY2UKPiA+ICtjb21w
YXRpYmlsaXR5IGlzIG1haW50YWluZWQgd2l0aCByZXNwZWN0IHRvIHRoZSBpc3N1ZXMgaGlnaGxp
Z2h0ZWQgYnkgdGhpcwo+ID4gK2RvY3VtZW50LiBIb3dldmVyLCB0aGUgZGV0YWlscyB0aGF0IG11
c3QgYmUgZGVmaW5lZCBieSBhIHBzQUJJIGFyZSBhIG1pbmltdW0gLS0KPiA+ICthIHBzQUJJIG1h
eSBzcGVjaWZ5IGFkZGl0aW9uYWwgcmVxdWlyZW1lbnRzIGZvciBiaW5hcnkgaW50ZXJmYWNlIGNv
bXBhdGliaWxpdHkKPiA+ICtvbiBhIHBsYXRmb3JtLgo+Cj4gSSBkb24ndCB1bmRlcnN0YW5kIHdo
YXQgeW91IGFyZSB0cnlpbmcgdG8gc2F5IGluIHRoZSBhYm92ZS4KPiBJbiBteSBtaW5kIHRoZXJl
IGlzIG9ubHkgb25lIEJQRiBwc0FCSSBhbmQgaXQgZG9lc24ndCBoYXZlCj4gZ2VuZXJpYyBhbmQg
cHJvY2Vzc29yIHBhcnRzLiBUaGVyZSBpcyBvbmx5IG9uZSAicHJvY2Vzc29yIi4KPiBCUEYgaXMg
c3VjaCBhIHByb2Nlc3Nvci4KCldoYXQgSSB3YXMgdHJ5aW5nIHRvIHNheSB3YXMgdGhhdCB0aGUg
ZG9jdW1lbnQgaGVyZSBkZXNjcmliZXMgYQpnZW5lcmljIEFCSS4gSW4gdGhpcyBkb2N1bWVudCB0
aGVyZSB3aWxsIGJlIGFyZWFzIHRoYXQgYXJlIHNwZWNpZmljIHRvCmRpZmZlcmVudCBpbXBsZW1l
bnRhdGlvbnMgYW5kIHRob3NlIHdvdWxkIGJlIGNvbnNpZGVyZWQgcHJvY2Vzc29yCnNwZWNpZmlj
LiBJbiBvdGhlciB3b3JkcywgdGhlIHVicGYgcnVudGltZSBjb3VsZCBkZWZpbmUgdGhvc2UgdGhp
bmdzCmRpZmZlcmVudGx5IHRoYW4gdGhlIHJicGYgcnVudGltZSB3aGljaCwgaW4gdHVybiwgY291
bGQgZGVmaW5lIHRob3NlCnRoaW5ncyBkaWZmZXJlbnRseSB0aGFuIHRoZSBrZXJuZWwncyBpbXBs
ZW1lbnRhdGlvbi4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3
dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

