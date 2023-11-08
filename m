Return-Path: <bpf+bounces-14521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D78F7E5EDA
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385C6281445
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BCC37165;
	Wed,  8 Nov 2023 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="EluqD1ka";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="iKLiWs7i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUeXwJLR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71633715A
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 19:51:57 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A611FC3
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 11:51:57 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 011E3C16F3F3
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699473117; bh=BLmfSXaPEzfLAk257en6Ycd46BFT1UB8B+PRJxMjy0I=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=EluqD1kajQLy8Vraoiy4CHonNcbWaVtBYUDUJSd9D5DwJQwtS0HlyJ9iuX6nzApiD
	 rdzk61YdYyknSDRAIFczO5BJiJcXoYEvHdbe8CQMCWpbj9zHpq1Y1vDUJCp2C2Q0t8
	 BMKhwLnLHKDr5Mi6c1lZ5tzdkkn3BuDTWE03piFE=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Nov  8 11:51:56 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B7FD1C15106F;
	Wed,  8 Nov 2023 11:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699473116; bh=BLmfSXaPEzfLAk257en6Ycd46BFT1UB8B+PRJxMjy0I=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=iKLiWs7iuRzM6IOMSwpUbJdxcrmjWKVU9AJaFPnrgQNl6+wM3bHoCMcqFg4dsUtCK
	 D5tMx1WpmJF0mWKEXD5XVxXlxwR6Mbg9qFtm0na/Yw4QVFJBG00KzZmoyyec6P5W7P
	 DwSkhRQOiJ3aVntS9GBrci6qm65BGyAhEdYGEDRE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 729C4C15106F
 for <bpf@ietfa.amsl.com>; Wed,  8 Nov 2023 11:51:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M18l4dyA4Tal for <bpf@ietfa.amsl.com>;
 Wed,  8 Nov 2023 11:51:54 -0800 (PST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 75A2CC14CEFD
 for <bpf@ietf.org>; Wed,  8 Nov 2023 11:51:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso29304f8f.3
 for <bpf@ietf.org>; Wed, 08 Nov 2023 11:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699473113; x=1700077913; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJ6MrX10L+eqVpMhnTztqFuS/silJbeJQywy4Iq139k=;
 b=OUeXwJLRfIsVxjw2zJJ0wJJT5G7J7aNlgJlxCgJGnQMgMD/d+lheaWI/ljNmgji8cs
 GcjrIuu9z1MEXtNXYCtXBi1slvkG3EZXC0lUNShmMLbLXZ7eDk004XBDkMNkiL13n/++
 c3k3DQQJ7D54jbQi8zEFUpFlVHsuLX5OWbS9udENrwrXlLLghllA+1KaU1uPPnBQglvK
 4eZnxDbVQXnMLIJf5KL+XFwgVw1ZY5e34WhReglR2jDzL5oGuR5OLzFaf0ped9PTWSso
 e3bubca+SQ2toqokA7IsOxHrkmmXHF7Zmzwj81l6umVER3YkiWwU7rQxpBV4A+YfCuDc
 Z4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699473113; x=1700077913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJ6MrX10L+eqVpMhnTztqFuS/silJbeJQywy4Iq139k=;
 b=mq8KSMG+ijC7q6lsXBU5tLhp0mUsFFcW6ePSb5v7NUC9Nnw49I3A90x3xsYsELVFnK
 h6zQD9BeBeYEYl4UCDtDWkLi1ICDNtFwbIEs5jruz4JiLHLU6U0td7Z9GwgYOERc8b4w
 0La12BOEYeLduwN2a2NMPKCRcxLbwpoC2fLht4EM8MhBlCliio3W5hiryTE9nx4cS7Ka
 pA4LyeJlpR4s5l7Jtpg6W66uctp3CeHdcQV156zPnEChlABLWiG6KlIjhxYSrw3z6z5o
 qIrsoB4DVSTiXNGnegelj6jvrQEDWe1BL0tzrnhsF2KHl+MxvFNICtGiqJkBgXt/gdDX
 xocA==
X-Gm-Message-State: AOJu0YwUjV3AhsC+m0dZUAyWa+SOv4q9tf8pzjyhAA1GZPgAQoYoYgAL
 0RSth9hqeMmjbdFQcEDIcig2aIyReDp1krxGGVhbz8nV
X-Google-Smtp-Source: AGHT+IE5lx+H7UoCE0axLzFtUPZtpqfVSX09Pjmw4hK0G3wM0mN7wlTHbxz3cv/6HwOpfEf+Oabeq62pNEnIcShJOyA=
X-Received: by 2002:a05:6000:1364:b0:32f:7e4e:535d with SMTP id
 q4-20020a056000136400b0032f7e4e535dmr2522737wrz.15.1699473112588; Wed, 08 Nov
 2023 11:51:52 -0800 (PST)
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
In-Reply-To: <CADx9qWgps=T8COiFYTFPKObSUkMo9kaOKMRVub8quN_MkFM_LA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Nov 2023 11:51:41 -0800
Message-ID: <CAADnVQLhJh+qSc=xg5WDCfFzD-SO7KtoBz5MyQZUxEY0foY6aw@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/xVy4YMPgmao9AUVIyrtd9qGxOHc>
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

T24gV2VkLCBOb3YgOCwgMjAyMyBhdCAyOjEz4oCvQU0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0Bv
YnMuY3I+IHdyb3RlOgo+Cj4gT24gVHVlLCBOb3YgNywgMjAyMyBhdCA4OjE34oCvUE0gQWxleGVp
IFN0YXJvdm9pdG92Cj4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4K
PiA+IE9uIFR1ZSwgTm92IDcsIDIwMjMgYXQgMTE6NTbigK9BTSBXaWxsIEhhd2tpbnMgPGhhd2tp
bnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIE1vbiwgTm92IDYsIDIwMjMgYXQgMzoz
OOKAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWls
LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBTdW4sIE5vdiA1LCAyMDIzIGF0IDQ6MTfi
gK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gT24gU3VuLCBOb3YgNSwgMjAyMyBhdCA0OjUx4oCvQU0gQWxleGVpIFN0YXJvdm9pdG92
Cj4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IE9uIEZyaSwgTm92IDMsIDIwMjMgYXQgMjoyMOKAr1BNIFdpbGwgSGF3
a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+
ID4gK1RoZSBBQkkgaXMgc3BlY2lmaWVkIGluIHR3byBwYXJ0czogYSBnZW5lcmljIHBhcnQgYW5k
IGEgcHJvY2Vzc29yLXNwZWNpZmljIHBhcnQuCj4gPiA+ID4gPiA+ID4gK0EgcGFpcmluZyBvZiBn
ZW5lcmljIEFCSSB3aXRoIHRoZSBwcm9jZXNzb3Itc3BlY2lmaWMgQUJJIGZvciBhIGNlcnRhaW4K
PiA+ID4gPiA+ID4gPiAraW5zdGFudGlhdGlvbiBvZiBhIEJQRiBtYWNoaW5lIHJlcHJlc2VudHMg
YSBjb21wbGV0ZSBiaW5hcnkgaW50ZXJmYWNlIGZvciBCUEYKPiA+ID4gPiA+ID4gPiArcHJvZ3Jh
bXMgZXhlY3V0aW5nIG9uIHRoYXQgbWFjaGluZS4KPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+
ID4gK1RoaXMgZG9jdW1lbnQgaXMgdGhlIGdlbmVyaWMgQUJJIGFuZCBzcGVjaWZpZXMgdGhlIHBh
cmFtZXRlcnMgYW5kIGJlaGF2aW9yCj4gPiA+ID4gPiA+ID4gK2NvbW1vbiB0byBhbGwgaW5zdGFu
dGlhdGlvbnMgb2YgQlBGIG1hY2hpbmVzLiBJbiBhZGRpdGlvbiwgaXQgZGVmaW5lcyB0aGUKPiA+
ID4gPiA+ID4gPiArZGV0YWlscyB0aGF0IG11c3QgYmUgc3BlY2lmaWVkIGJ5IGVhY2ggcHJvY2Vz
c29yLXNwZWNpZmljIEFCSS4KPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gK1RoZXNlIHBz
QUJJcyBhcmUgdGhlIHNlY29uZCBwYXJ0IG9mIHRoZSBBQkkuIEVhY2ggaW5zdGFudGlhdGlvbiBv
ZiBhIEJQRgo+ID4gPiA+ID4gPiA+ICttYWNoaW5lIG11c3QgZGVzY3JpYmUgdGhlIG1lY2hhbmlz
bSB0aHJvdWdoIHdoaWNoIGJpbmFyeSBpbnRlcmZhY2UKPiA+ID4gPiA+ID4gPiArY29tcGF0aWJp
bGl0eSBpcyBtYWludGFpbmVkIHdpdGggcmVzcGVjdCB0byB0aGUgaXNzdWVzIGhpZ2hsaWdodGVk
IGJ5IHRoaXMKPiA+ID4gPiA+ID4gPiArZG9jdW1lbnQuIEhvd2V2ZXIsIHRoZSBkZXRhaWxzIHRo
YXQgbXVzdCBiZSBkZWZpbmVkIGJ5IGEgcHNBQkkgYXJlIGEgbWluaW11bSAtLQo+ID4gPiA+ID4g
PiA+ICthIHBzQUJJIG1heSBzcGVjaWZ5IGFkZGl0aW9uYWwgcmVxdWlyZW1lbnRzIGZvciBiaW5h
cnkgaW50ZXJmYWNlIGNvbXBhdGliaWxpdHkKPiA+ID4gPiA+ID4gPiArb24gYSBwbGF0Zm9ybS4K
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IGFyZSB0
cnlpbmcgdG8gc2F5IGluIHRoZSBhYm92ZS4KPiA+ID4gPiA+ID4gSW4gbXkgbWluZCB0aGVyZSBp
cyBvbmx5IG9uZSBCUEYgcHNBQkkgYW5kIGl0IGRvZXNuJ3QgaGF2ZQo+ID4gPiA+ID4gPiBnZW5l
cmljIGFuZCBwcm9jZXNzb3IgcGFydHMuIFRoZXJlIGlzIG9ubHkgb25lICJwcm9jZXNzb3IiLgo+
ID4gPiA+ID4gPiBCUEYgaXMgc3VjaCBhIHByb2Nlc3Nvci4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBX
aGF0IEkgd2FzIHRyeWluZyB0byBzYXkgd2FzIHRoYXQgdGhlIGRvY3VtZW50IGhlcmUgZGVzY3Jp
YmVzIGEKPiA+ID4gPiA+IGdlbmVyaWMgQUJJLiBJbiB0aGlzIGRvY3VtZW50IHRoZXJlIHdpbGwg
YmUgYXJlYXMgdGhhdCBhcmUgc3BlY2lmaWMgdG8KPiA+ID4gPiA+IGRpZmZlcmVudCBpbXBsZW1l
bnRhdGlvbnMgYW5kIHRob3NlIHdvdWxkIGJlIGNvbnNpZGVyZWQgcHJvY2Vzc29yCj4gPiA+ID4g
PiBzcGVjaWZpYy4gSW4gb3RoZXIgd29yZHMsIHRoZSB1YnBmIHJ1bnRpbWUgY291bGQgZGVmaW5l
IHRob3NlIHRoaW5ncwo+ID4gPiA+ID4gZGlmZmVyZW50bHkgdGhhbiB0aGUgcmJwZiBydW50aW1l
IHdoaWNoLCBpbiB0dXJuLCBjb3VsZCBkZWZpbmUgdGhvc2UKPiA+ID4gPiA+IHRoaW5ncyBkaWZm
ZXJlbnRseSB0aGFuIHRoZSBrZXJuZWwncyBpbXBsZW1lbnRhdGlvbi4KPiA+ID4gPgo+ID4gPiA+
IEkgc2VlIHdoYXQgeW91IG1lYW4uIFRoZXJlIGlzIG9ubHkgb25lIEJQRiBwc0FCSS4gVGhlcmUg
Y2Fubm90IGJlIHR3by4KPiA+ID4gPiB1YnBmIGNhbiBkZWNpZGUgbm90IHRvIGZvbGxvdyBpdCwg
YnV0IGl0IGNvdWxkIG9ubHkgbWVhbiB0aGF0Cj4gPiA+ID4gaXQncyBub24gY29uZm9ybWFudCBh
bmQgbm90IGNvbXBhdGlibGUuCj4gPiA+Cj4gPiA+IE9rYXkuIFRoYXQgd2FzIG5vdCBob3cgSSB3
YXMgc3RydWN0dXJpbmcgdGhlIEFCSS4gSSB0aG91Z2h0IHdlIGhhZAo+ID4gPiBkZWNpZGVkIHRo
YXQsIGFzIHRoZSBkb2N1bWVudCBzYWlkLCBhbiBpbnN0YW50aWF0aW9uIG9mIGEgbWFjaGluZSBo
YWQKPiA+ID4gdG8KPiA+ID4KPiA+ID4gMS4gbWVldCB0aGUgZ0FCSQo+ID4gPiAyLiBzcGVjaWZ5
IGl0cyByZXF1aXJlbWVudHMgdmlzIGEgdmlzIHRoZSBwc0FCSQo+ID4gPiAzLiAob3B0aW9uYWxs
eSkgZGVzY3JpYmUgb3RoZXIgcmVxdWlyZW1lbnRzLgo+ID4gPgo+ID4gPiBJZiB0aGF0IGlzIG5v
dCB3aGF0IHdlIGRlY2lkZWQgdGhlbiB3ZSB3aWxsIGhhdmUgdG8gcmVzdHJ1Y3R1cmUgdGhlIGRv
Y3VtZW50Lgo+ID4KPiA+IFRoaXMgYWJpLnJzdCBmaWxlIGlzIHRoZSBiZWdpbm5pbmcgb2YgIkJQ
RiBwc0FCSSIgZG9jdW1lbnQuCj4gPiBXZSBwcm9iYWJseSBzaG91bGQgcmVuYW1lIGl0IHRvIHBz
YWJpLnJzdCB0byBhdm9pZCBjb25mdXNpb24uCj4gPiBTZWUgbXkgc2xpZGVzIGZyb20gSUVURiAx
MTguIEkgaG9wZSB0aGV5IGV4cGxhaW4gd2hhdCAiQlBGIHBzQUJJIiBpcyBmb3IuCj4KPiBPZiBj
b3Vyc2UgdGhleSBkbyEgVGhhbmsgeW91ISBNeSBvbmx5IHF1ZXN0aW9uOiBJbiB0aGUgbGFuZ3Vh
Z2UgSSB3YXMKPiB1c2luZywgSSB3YXMgdGFraW5nIGEgY3VlIGZyb20gdGhlIFN5c3RlbSBWIHdv
cmxkIHdoZXJlIHRoZXJlIGlzIGEKPiBHZW5lcmljIEFCSSBhbmQgYSBwc0FCSS4gVGhlIEdlbmVy
aWMgQUJJIGFwcGxpZXMgdG8gYWxsIFN5c3RlbSBWCj4gY29tcGF0aWJsZSBzeXN0ZW1zIGFuZCBk
ZWZpbmVzIGNlcnRhaW4gcHJvY2Vzc29yLXNwZWNpZmljIGRldGFpbHMgdGhhdAo+IGVhY2ggcGxh
dGZvcm0gbXVzdCBzcGVjaWZ5IHRvIGRlZmluZSBhIGNvbXBsZXRlIEFCSS4gSW4gcGFydGljdWxh
ciwgSQo+IHRvb2sgdGhpcyBsYW5ndWFnZSBhcyBpbnNwaXJhdGlvbgo+Cj4gIiIiCj4gVGhlIFN5
c3RlbSBWIEFCSSBpcyBjb21wb3NlZCBvZiB0d28gYmFzaWMgcGFydHM6IEEgZ2VuZXJpYyBwYXJ0
IG9mIHRoZQo+IHNwZWNpZmljYXRpb24gZGVzY3JpYmVzIHRob3NlIHBhcnRzIG9mIHRoZSBpbnRl
cmZhY2UgdGhhdCByZW1haW4KPiBjb25zdGFudCBhY3Jvc3MgYWxsIGhhcmR3YXJlIGltcGxlbWVu
dGF0aW9ucyBvZiBTeXN0ZW0gViwgYW5kIGEKPiBwcm9jZXNzb3Itc3BlY2lmaWMgcGFydCBvZiB0
aGUgc3BlY2lmaWNhdGlvbiBkZXNjcmliZXMgdGhlIHBhcnRzIG9mCj4gdGhlIHNwZWNpZmljYXRp
b24gdGhhdCBhcmUgc3BlY2lmaWMgdG8gYSBwYXJ0aWN1bGFyIHByb2Nlc3Nvcgo+IGFyY2hpdGVj
dHVyZS4gVG9nZXRoZXIsIHRoZSBnZW5lcmljIEFCSSAob3IgZ0FCSSkgYW5kIHRoZSBwcm9jZXNz
b3IKPiBzcGVjaWZpYyBzdXBwbGVtZW50IChvciBwc0FCSSkgcHJvdmlkZSBhIGNvbXBsZXRlIGlu
dGVyZmFjZQo+IHNwZWNpZmljYXRpb24gZm9yIGNvbXBpbGVkIGFwcGxpY2F0aW9uIHByb2dyYW1z
IG9uIHN5c3RlbXMgdGhhdCBzaGFyZQo+IGEgY29tbW9uIGhhcmR3YXJlIGFyY2hpdGVjdHVyZS4K
PiAiIiIKCkkgc2VlIHdoZXJlIHlvdSBnb3QgdGhlIGluc3BpcmF0aW9uIGZyb20sIGJ1dCBpdCdz
IG5vdCBhcHBsaWNhYmxlCmluIHRoZSBCUEYgY2FzZS4gQlBGIGlzIHN1Y2ggb25lIGFuZCBvbmx5
IHByb2Nlc3Nvci4KV2UncmUgbm90IGNoYW5naW5nIG5vciBhZGRpbmcgYW55dGhpbmcgdG8gU3lz
IFYgZ2VuZXJpYyBwYXJ0cy4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRw
czovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

