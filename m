Return-Path: <bpf+bounces-14622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91D7E718C
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7B7B20C44
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518136AF5;
	Thu,  9 Nov 2023 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="wirYmklo";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="wirYmklo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqssVPts"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103C341BF
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:31:33 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E73C07
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 10:31:32 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 70656C1CB008
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699554692; bh=nC+E8w9NSicNW+1elvEOo3+dMxujgP+dUmcWzEyKjiw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=wirYmkloZJTPXgEXzTkDuw6KE0f1isW8qtxYNW7+Pt3Ax/2CevSx2seXUMbJ2wc7q
	 TfCV2OiUmIhgXoh6HDxlivAB3YW3wPLaWI0Y9q4c4FFYBsjwgl/+WnFnpjemK0zXMp
	 i4MgUH57oPvLOo0ThN20ZZ1NpwOg8TXz/+DXixO4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Nov  9 10:31:32 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4ECEEC1C5F53;
	Thu,  9 Nov 2023 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699554692; bh=nC+E8w9NSicNW+1elvEOo3+dMxujgP+dUmcWzEyKjiw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=wirYmkloZJTPXgEXzTkDuw6KE0f1isW8qtxYNW7+Pt3Ax/2CevSx2seXUMbJ2wc7q
	 TfCV2OiUmIhgXoh6HDxlivAB3YW3wPLaWI0Y9q4c4FFYBsjwgl/+WnFnpjemK0zXMp
	 i4MgUH57oPvLOo0ThN20ZZ1NpwOg8TXz/+DXixO4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 49D48C1C5F53
 for <bpf@ietfa.amsl.com>; Thu,  9 Nov 2023 10:31:31 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hpi3Kdbh3qLV for <bpf@ietfa.amsl.com>;
 Thu,  9 Nov 2023 10:31:30 -0800 (PST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id BC3AFC1C5F51
 for <bpf@ietf.org>; Thu,  9 Nov 2023 10:31:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso1600560e87.1
 for <bpf@ietf.org>; Thu, 09 Nov 2023 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699554688; x=1700159488; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MC6H09I3XmxyrD/4OQ6oF47d4gO3IQyjlYDr38dU+yc=;
 b=hqssVPtsjG1JaGrPiDugxdbDdH7aJyTjqq77O2ZCRj7cSVc850mlPGXHCKC+8tEaWz
 kNzpQKuyptfmljL97WjplJxNyPZKNOG5+2zo1Kgh4HTs9C94j3zOyv+STbY5HVuL3hmg
 DEuSF07lUEis7Y+giMFlIVH1IpEy1R5hNjB0hoCLPgote4h0LkL+bhvks4/L8l9RGXPe
 zyqz+qZi9KcELERI5Vc3K0VrnUGaI2Z1Xq2YZT1ONTqa7xS9pNrDEhbR2QWU1VXDp5gM
 rN43qyxcmRLJXtJIzIsQ0MQ5jrwz8MdcqkVdwMolxopyQxEpJTGAQmILAqL2uVSFcyOR
 TyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699554688; x=1700159488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MC6H09I3XmxyrD/4OQ6oF47d4gO3IQyjlYDr38dU+yc=;
 b=Z5ngkW/j5Olgncg/oKVVa4F7SrQua3UIrsDA8XQyFAclLsucliq4BHZUGBXY8CkO4a
 rUmMSMODpqZu4j33+cOAWoSqa5Mxi5a3CoiB4m4D2R7AtdUyBWNoMxz+BcdsTZB9Tp4h
 GrKSIglIqWOd/tucUySItuWL6sTXXcz0Mt4KN0PpwDr7KFtqjdtaN/h+cCh/JGlMNFRG
 KSqFw71RPc9JnQzVosZdbEyO8cLrYrb9de010fxeQi1ST1yDZnl2opUlNv9kjJ+HI3NI
 JyZzFOrcB5tO/a8qpRkX/0qu7pwt1r+2qCZ7SGn7epUovuc5DdkdS/oHOnFy/aX08Zjd
 4Q6A==
X-Gm-Message-State: AOJu0YwbDaMj0KNBDrbzGAXCv2FFQ4UWqLM3cUgsJORv/NH4fKcJE8DZ
 Dldo4JuKPERVuHxsPVVr+joIXX+YPxXGIlb8D4QYFwI2
X-Google-Smtp-Source: AGHT+IFd9F3PyLbwLkebT/Qo2uXTLXCITz78+ZLR34lJeC/jmTWrhBh+eb1j+B+PkCWjhgzBqyItz77/axzHf9yIS0Q=
X-Received: by 2002:a05:6512:5c2:b0:4ff:a8c6:d1aa with SMTP id
 o2-20020a05651205c200b004ffa8c6d1aamr2249108lfo.48.1699554688095; Thu, 09 Nov
 2023 10:31:28 -0800 (PST)
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
 <CADx9qWh2Q8fxR51UmE7AiWoRykA1VK70jHaNiry5KpNHUbQYhg@mail.gmail.com>
In-Reply-To: <CADx9qWh2Q8fxR51UmE7AiWoRykA1VK70jHaNiry5KpNHUbQYhg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 10:31:16 -0800
Message-ID: <CAADnVQKY+B3n3CXPwg+9PbyyNvfR0DNiSsGDMh-uNA-obK6yiw@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/NfiMLa0KvuotcL88q4KUzMVzhXU>
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

T24gV2VkLCBOb3YgOCwgMjAyMyBhdCAzOjU34oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0Bv
YnMuY3I+IHdyb3RlOgo+Cj4gT24gV2VkLCBOb3YgOCwgMjAyMyBhdCAyOjUx4oCvUE0gQWxleGVp
IFN0YXJvdm9pdG92Cj4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4K
PiA+IE9uIFdlZCwgTm92IDgsIDIwMjMgYXQgMjoxM+KAr0FNIFdpbGwgSGF3a2lucyA8aGF3a2lu
c3dAb2JzLmNyPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVHVlLCBOb3YgNywgMjAyMyBhdCA4OjE3
4oCvUE0gQWxleGVpIFN0YXJvdm9pdG92Cj4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwu
Y29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFR1ZSwgTm92IDcsIDIwMjMgYXQgMTE6NTbi
gK9BTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gT24gTW9uLCBOb3YgNiwgMjAyMyBhdCAzOjM44oCvQU0gQWxleGVpIFN0YXJvdm9pdG92
Cj4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IE9uIFN1biwgTm92IDUsIDIwMjMgYXQgNDoxN+KAr1BNIFdpbGwgSGF3
a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
IE9uIFN1biwgTm92IDUsIDIwMjMgYXQgNDo1MeKAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4g
PiA+ID4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBGcmksIE5vdiAzLCAyMDIzIGF0IDI6MjDigK9QTSBX
aWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ICsK
PiA+ID4gPiA+ID4gPiA+ID4gK1RoZSBBQkkgaXMgc3BlY2lmaWVkIGluIHR3byBwYXJ0czogYSBn
ZW5lcmljIHBhcnQgYW5kIGEgcHJvY2Vzc29yLXNwZWNpZmljIHBhcnQuCj4gPiA+ID4gPiA+ID4g
PiA+ICtBIHBhaXJpbmcgb2YgZ2VuZXJpYyBBQkkgd2l0aCB0aGUgcHJvY2Vzc29yLXNwZWNpZmlj
IEFCSSBmb3IgYSBjZXJ0YWluCj4gPiA+ID4gPiA+ID4gPiA+ICtpbnN0YW50aWF0aW9uIG9mIGEg
QlBGIG1hY2hpbmUgcmVwcmVzZW50cyBhIGNvbXBsZXRlIGJpbmFyeSBpbnRlcmZhY2UgZm9yIEJQ
Rgo+ID4gPiA+ID4gPiA+ID4gPiArcHJvZ3JhbXMgZXhlY3V0aW5nIG9uIHRoYXQgbWFjaGluZS4K
PiA+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiArVGhpcyBkb2N1bWVudCBpcyB0
aGUgZ2VuZXJpYyBBQkkgYW5kIHNwZWNpZmllcyB0aGUgcGFyYW1ldGVycyBhbmQgYmVoYXZpb3IK
PiA+ID4gPiA+ID4gPiA+ID4gK2NvbW1vbiB0byBhbGwgaW5zdGFudGlhdGlvbnMgb2YgQlBGIG1h
Y2hpbmVzLiBJbiBhZGRpdGlvbiwgaXQgZGVmaW5lcyB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gK2Rl
dGFpbHMgdGhhdCBtdXN0IGJlIHNwZWNpZmllZCBieSBlYWNoIHByb2Nlc3Nvci1zcGVjaWZpYyBB
QkkuCj4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gK1RoZXNlIHBzQUJJcyBh
cmUgdGhlIHNlY29uZCBwYXJ0IG9mIHRoZSBBQkkuIEVhY2ggaW5zdGFudGlhdGlvbiBvZiBhIEJQ
Rgo+ID4gPiA+ID4gPiA+ID4gPiArbWFjaGluZSBtdXN0IGRlc2NyaWJlIHRoZSBtZWNoYW5pc20g
dGhyb3VnaCB3aGljaCBiaW5hcnkgaW50ZXJmYWNlCj4gPiA+ID4gPiA+ID4gPiA+ICtjb21wYXRp
YmlsaXR5IGlzIG1haW50YWluZWQgd2l0aCByZXNwZWN0IHRvIHRoZSBpc3N1ZXMgaGlnaGxpZ2h0
ZWQgYnkgdGhpcwo+ID4gPiA+ID4gPiA+ID4gPiArZG9jdW1lbnQuIEhvd2V2ZXIsIHRoZSBkZXRh
aWxzIHRoYXQgbXVzdCBiZSBkZWZpbmVkIGJ5IGEgcHNBQkkgYXJlIGEgbWluaW11bSAtLQo+ID4g
PiA+ID4gPiA+ID4gPiArYSBwc0FCSSBtYXkgc3BlY2lmeSBhZGRpdGlvbmFsIHJlcXVpcmVtZW50
cyBmb3IgYmluYXJ5IGludGVyZmFjZSBjb21wYXRpYmlsaXR5Cj4gPiA+ID4gPiA+ID4gPiA+ICtv
biBhIHBsYXRmb3JtLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgdW5k
ZXJzdGFuZCB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNheSBpbiB0aGUgYWJvdmUuCj4gPiA+ID4g
PiA+ID4gPiBJbiBteSBtaW5kIHRoZXJlIGlzIG9ubHkgb25lIEJQRiBwc0FCSSBhbmQgaXQgZG9l
c24ndCBoYXZlCj4gPiA+ID4gPiA+ID4gPiBnZW5lcmljIGFuZCBwcm9jZXNzb3IgcGFydHMuIFRo
ZXJlIGlzIG9ubHkgb25lICJwcm9jZXNzb3IiLgo+ID4gPiA+ID4gPiA+ID4gQlBGIGlzIHN1Y2gg
YSBwcm9jZXNzb3IuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBXaGF0IEkgd2FzIHRyeWlu
ZyB0byBzYXkgd2FzIHRoYXQgdGhlIGRvY3VtZW50IGhlcmUgZGVzY3JpYmVzIGEKPiA+ID4gPiA+
ID4gPiBnZW5lcmljIEFCSS4gSW4gdGhpcyBkb2N1bWVudCB0aGVyZSB3aWxsIGJlIGFyZWFzIHRo
YXQgYXJlIHNwZWNpZmljIHRvCj4gPiA+ID4gPiA+ID4gZGlmZmVyZW50IGltcGxlbWVudGF0aW9u
cyBhbmQgdGhvc2Ugd291bGQgYmUgY29uc2lkZXJlZCBwcm9jZXNzb3IKPiA+ID4gPiA+ID4gPiBz
cGVjaWZpYy4gSW4gb3RoZXIgd29yZHMsIHRoZSB1YnBmIHJ1bnRpbWUgY291bGQgZGVmaW5lIHRo
b3NlIHRoaW5ncwo+ID4gPiA+ID4gPiA+IGRpZmZlcmVudGx5IHRoYW4gdGhlIHJicGYgcnVudGlt
ZSB3aGljaCwgaW4gdHVybiwgY291bGQgZGVmaW5lIHRob3NlCj4gPiA+ID4gPiA+ID4gdGhpbmdz
IGRpZmZlcmVudGx5IHRoYW4gdGhlIGtlcm5lbCdzIGltcGxlbWVudGF0aW9uLgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBJIHNlZSB3aGF0IHlvdSBtZWFuLiBUaGVyZSBpcyBvbmx5IG9uZSBCUEYg
cHNBQkkuIFRoZXJlIGNhbm5vdCBiZSB0d28uCj4gPiA+ID4gPiA+IHVicGYgY2FuIGRlY2lkZSBu
b3QgdG8gZm9sbG93IGl0LCBidXQgaXQgY291bGQgb25seSBtZWFuIHRoYXQKPiA+ID4gPiA+ID4g
aXQncyBub24gY29uZm9ybWFudCBhbmQgbm90IGNvbXBhdGlibGUuCj4gPiA+ID4gPgo+ID4gPiA+
ID4gT2theS4gVGhhdCB3YXMgbm90IGhvdyBJIHdhcyBzdHJ1Y3R1cmluZyB0aGUgQUJJLiBJIHRo
b3VnaHQgd2UgaGFkCj4gPiA+ID4gPiBkZWNpZGVkIHRoYXQsIGFzIHRoZSBkb2N1bWVudCBzYWlk
LCBhbiBpbnN0YW50aWF0aW9uIG9mIGEgbWFjaGluZSBoYWQKPiA+ID4gPiA+IHRvCj4gPiA+ID4g
Pgo+ID4gPiA+ID4gMS4gbWVldCB0aGUgZ0FCSQo+ID4gPiA+ID4gMi4gc3BlY2lmeSBpdHMgcmVx
dWlyZW1lbnRzIHZpcyBhIHZpcyB0aGUgcHNBQkkKPiA+ID4gPiA+IDMuIChvcHRpb25hbGx5KSBk
ZXNjcmliZSBvdGhlciByZXF1aXJlbWVudHMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gSWYgdGhhdCBp
cyBub3Qgd2hhdCB3ZSBkZWNpZGVkIHRoZW4gd2Ugd2lsbCBoYXZlIHRvIHJlc3RydWN0dXJlIHRo
ZSBkb2N1bWVudC4KPiA+ID4gPgo+ID4gPiA+IFRoaXMgYWJpLnJzdCBmaWxlIGlzIHRoZSBiZWdp
bm5pbmcgb2YgIkJQRiBwc0FCSSIgZG9jdW1lbnQuCj4gPiA+ID4gV2UgcHJvYmFibHkgc2hvdWxk
IHJlbmFtZSBpdCB0byBwc2FiaS5yc3QgdG8gYXZvaWQgY29uZnVzaW9uLgo+ID4gPiA+IFNlZSBt
eSBzbGlkZXMgZnJvbSBJRVRGIDExOC4gSSBob3BlIHRoZXkgZXhwbGFpbiB3aGF0ICJCUEYgcHNB
QkkiIGlzIGZvci4KPiA+ID4KPiA+ID4gT2YgY291cnNlIHRoZXkgZG8hIFRoYW5rIHlvdSEgTXkg
b25seSBxdWVzdGlvbjogSW4gdGhlIGxhbmd1YWdlIEkgd2FzCj4gPiA+IHVzaW5nLCBJIHdhcyB0
YWtpbmcgYSBjdWUgZnJvbSB0aGUgU3lzdGVtIFYgd29ybGQgd2hlcmUgdGhlcmUgaXMgYQo+ID4g
PiBHZW5lcmljIEFCSSBhbmQgYSBwc0FCSS4gVGhlIEdlbmVyaWMgQUJJIGFwcGxpZXMgdG8gYWxs
IFN5c3RlbSBWCj4gPiA+IGNvbXBhdGlibGUgc3lzdGVtcyBhbmQgZGVmaW5lcyBjZXJ0YWluIHBy
b2Nlc3Nvci1zcGVjaWZpYyBkZXRhaWxzIHRoYXQKPiA+ID4gZWFjaCBwbGF0Zm9ybSBtdXN0IHNw
ZWNpZnkgdG8gZGVmaW5lIGEgY29tcGxldGUgQUJJLiBJbiBwYXJ0aWN1bGFyLCBJCj4gPiA+IHRv
b2sgdGhpcyBsYW5ndWFnZSBhcyBpbnNwaXJhdGlvbgo+ID4gPgo+ID4gPiAiIiIKPiA+ID4gVGhl
IFN5c3RlbSBWIEFCSSBpcyBjb21wb3NlZCBvZiB0d28gYmFzaWMgcGFydHM6IEEgZ2VuZXJpYyBw
YXJ0IG9mIHRoZQo+ID4gPiBzcGVjaWZpY2F0aW9uIGRlc2NyaWJlcyB0aG9zZSBwYXJ0cyBvZiB0
aGUgaW50ZXJmYWNlIHRoYXQgcmVtYWluCj4gPiA+IGNvbnN0YW50IGFjcm9zcyBhbGwgaGFyZHdh
cmUgaW1wbGVtZW50YXRpb25zIG9mIFN5c3RlbSBWLCBhbmQgYQo+ID4gPiBwcm9jZXNzb3Itc3Bl
Y2lmaWMgcGFydCBvZiB0aGUgc3BlY2lmaWNhdGlvbiBkZXNjcmliZXMgdGhlIHBhcnRzIG9mCj4g
PiA+IHRoZSBzcGVjaWZpY2F0aW9uIHRoYXQgYXJlIHNwZWNpZmljIHRvIGEgcGFydGljdWxhciBw
cm9jZXNzb3IKPiA+ID4gYXJjaGl0ZWN0dXJlLiBUb2dldGhlciwgdGhlIGdlbmVyaWMgQUJJIChv
ciBnQUJJKSBhbmQgdGhlIHByb2Nlc3Nvcgo+ID4gPiBzcGVjaWZpYyBzdXBwbGVtZW50IChvciBw
c0FCSSkgcHJvdmlkZSBhIGNvbXBsZXRlIGludGVyZmFjZQo+ID4gPiBzcGVjaWZpY2F0aW9uIGZv
ciBjb21waWxlZCBhcHBsaWNhdGlvbiBwcm9ncmFtcyBvbiBzeXN0ZW1zIHRoYXQgc2hhcmUKPiA+
ID4gYSBjb21tb24gaGFyZHdhcmUgYXJjaGl0ZWN0dXJlLgo+ID4gPiAiIiIKPiA+Cj4gPiBJIHNl
ZSB3aGVyZSB5b3UgZ290IHRoZSBpbnNwaXJhdGlvbiBmcm9tLCBidXQgaXQncyBub3QgYXBwbGlj
YWJsZQo+ID4gaW4gdGhlIEJQRiBjYXNlLiBCUEYgaXMgc3VjaCBvbmUgYW5kIG9ubHkgcHJvY2Vz
c29yLgo+ID4gV2UncmUgbm90IGNoYW5naW5nIG5vciBhZGRpbmcgYW55dGhpbmcgdG8gU3lzIFYg
Z2VuZXJpYyBwYXJ0cy4KPgo+IFRoYXQgd2FzIG5vdCBxdWl0ZSB3aGF0IEkgd2FzIHNheWluZy4g
V2hhdCBJIHN0YXJ0ZWQgdG8gZHJhZnQgaXMKPiBzb21ldGhpbmcgKHllcywgbW9kZWxlZCBhZnRl
ciB0aGUgU3lzIFYgKGcvcHMpQUJJKSBidXQgX2JyYW5kIG5ld18gZm9yCj4gQlBGLiBJIHRoaW5r
IHRoYXQgaXMgd2hlcmUgSSBoYXZlIGJlZW4gZmFpbGluZyB0byBjb21tdW5pY2F0ZQo+IGNvcnJl
Y3RseS4gV2hhdCBJIHdhcyBwcm9wb3Npbmcgd2FzIGluc3BpcmVkIGJ5IG90aGVyIEFCSXMgYnV0
Cj4gY29tcGxldGVseSBzZXBhcmF0ZSBhbmQgb3J0aG9nb25hbC4gVGhhdCBpcyB0aGUgcmVhc29u
IGZvciB0aGUKPiBkb2N1bWVudCBzcGVha2luZyBvZiBhIEJQRiBNYWNoaW5lIGxpa2U6Cj4KPiBB
QkktY29uZm9ybWluZyBCUEYgTWFjaGluZSBJbnN0YW50aWF0aW9uOiBBIHBoeXNpY2FsIG9yIGxv
Z2ljYWwgcmVhbGl6YXRpb24KPiAgICBvZiBhIGNvbXB1dGVyIHN5c3RlbSBjYXBhYmxlIG9mIGV4
ZWN1dGluZyBCUEYgcHJvZ3JhbXMgY29uc2lzdGVudGx5IHdpdGggdGhlCj4gICAgc3BlY2lmaWNh
dGlvbnMgb3V0bGluZWQgaW4gdGhpcyBkb2N1bWVudC4KPgo+IGJlY2F1c2UgaXQgaXMgYSAobm90
IG5lY2Vzc2FyaWx5IHBoeXNpY2FsKSBlbnRpdHkgdGhhdCBleGVjdXRlcyBCUEYKPiBwcm9ncmFt
cyAoaS5lLiBhICJCUEYgQ1BVIikgZm9yIHdoaWNoIHdlIGFyZSBzcGVjaWZ5aW5nIHRoZSBiaW5h
cnkKPiBjb21wYXRpYmlsaXR5LiBJbiBvdGhlciB3b3JkcywgdGhlIGRvY3VtZW50IGFzIGl0IHN0
YW5kcyBpcyBwcm9wb3NpbmcKPiBhIGdBQkkgd2hlcmUKPgo+IHRoZSBrZXJuZWwncyAiQlBGIENQ
VSIgd291bGQgaGF2ZSBpdHMgb3duIHBzQUJJCj4gdWJwZidzICJCUEYgQ1BVIiB3b3VsZCBoYXZl
IGl0cyBvd24gcHNBQkkKCmFuZCBob3cgd291bGQgeW91IGV4cGVjdCB0aGF0IHRvIHdvcms/CnBz
QUJJIGlzIGEgY29tcGlsZXIgc3BlYyBpbiB0aGUgZmlyc3QgcGxhY2UuClRoZSB1c2VyIHdvdWxk
IHVzZSBjbGFuZyAtTzIgLXRhcmdldCBicGZfa2VybmVsIHZzIC10YXJnZXQgYnBmX3VicGYgPwoK
LS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21h
aWxtYW4vbGlzdGluZm8vYnBmCg==

