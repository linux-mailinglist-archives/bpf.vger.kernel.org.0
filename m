Return-Path: <bpf+bounces-14672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309AF7E769B
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AB028148F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7C7FE;
	Fri, 10 Nov 2023 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="rGgHAAGP";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="rGgHAAGP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="gEfOjJd7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFEA46
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:35:37 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCB25B8
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:35:37 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 44BCAC0A8592
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699580137; bh=fTqzADhD1Cn8TfZlvssMeRldyBjK7yu04fHm33wBq6s=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=rGgHAAGPPzTNGw4JkkHA8Ht/Wkm8rgMJL+e2g6ePS+hAqn7yeWrrIXSYRCOm4PXB9
	 C7TBZIUVTd7jI/0eVfvzarCXFRsZ668ppHKfEyNhQr5CTyNVpym83asn0ZbLh9Xmt0
	 GPFylqayWJY8zMVGruaUvOvH6/CSNDfpOCxbFTV0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Nov  9 17:35:37 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0F024C17C898;
	Thu,  9 Nov 2023 17:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699580137; bh=fTqzADhD1Cn8TfZlvssMeRldyBjK7yu04fHm33wBq6s=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=rGgHAAGPPzTNGw4JkkHA8Ht/Wkm8rgMJL+e2g6ePS+hAqn7yeWrrIXSYRCOm4PXB9
	 C7TBZIUVTd7jI/0eVfvzarCXFRsZ668ppHKfEyNhQr5CTyNVpym83asn0ZbLh9Xmt0
	 GPFylqayWJY8zMVGruaUvOvH6/CSNDfpOCxbFTV0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6EE58C17C898
 for <bpf@ietfa.amsl.com>; Thu,  9 Nov 2023 17:35:36 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.907
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g5XhC2hxEtUK for <bpf@ietfa.amsl.com>;
 Thu,  9 Nov 2023 17:35:34 -0800 (PST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8A51EC151545
 for <bpf@ietf.org>; Thu,  9 Nov 2023 17:35:29 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6705379b835so9759466d6.1
 for <bpf@ietf.org>; Thu, 09 Nov 2023 17:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699580128; x=1700184928;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKFqgZ3KBs91haoWW2+0vg1f3e+VyCZ835ybZkTa0Xg=;
 b=gEfOjJd7dsr1R1jWOO85EfW4say2WpxNFMlmiSQHiBcYjO+UNWWSGfrP6W7/UyYukX
 23MPO3As37NRzjAeZMAWs8djS1U89XcmtuIqY/nN4YtNAxYTK/c5b35/QtpKjGhUWV73
 +TcnYJtcjFFRmPe4/ufoeC5TagXWuexprsZgQxnOcPZiaf3GtHKsVLfzdZ5qZqghg0mg
 skvIx4+24d1w8Uy9wJuXS/Uw/y4ci0eKX/n1ykPZY9WC0p6h+9oZ7bzNnRXdEK71B6x9
 lB0/tyMh1WNWAC57EK4TYhEMAMK7s5NDMn3VtUD5ycdGpzK6AzJv01pLGdB74xMJxSs1
 44Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699580128; x=1700184928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKFqgZ3KBs91haoWW2+0vg1f3e+VyCZ835ybZkTa0Xg=;
 b=b67xP4NekGH8ZZ4TTGIqM9TmdHOFa+Hou6TGe2a8SKGOh0epOHzICzFbEctjfT36AS
 TwMvOnUI429L4b9zJmH9y9JY+GbWPg6jGWyV4ToujPuX7YqnQwpp8Wn+vjW545ruZhVG
 M0QIa3H7z1NZVqEOB2y4CQgOaQY5tDBOLo2f0nngA47cQIklYAl3aB+XIzaah0Qexyjq
 HdbNb4j5D+y8WMc6EN3u/Jvs+BtLbOKv4CD4ty51D/9hbPolUjp3ihl0D65z5EhMR0uD
 bGusJOxLWzc/G4kmOSTnxEggGN84+gMjjxPL65v+W6Pgvvpttm5r+fFb9YqgCDDxUsMR
 0I1A==
X-Gm-Message-State: AOJu0Yxrolq9auAU8Zm6wR9ijSpEBA8rsktqniLFvadk7/6VJWeK729I
 srgjXluAE+839PKplpGOn+QsHY6WFTLC1j4EnWbHX+aLgyAC+V70at8=
X-Google-Smtp-Source: AGHT+IHIcwgm6Co+I0tKa//NhjyERQyrqVpD+xC3bHCdWnQD4mjEsWPadfGZduKVWVnnY6j5NE7aDQWM7uJMGPIQRvw=
X-Received: by 2002:ad4:5dc9:0:b0:66f:afb8:bcc5 with SMTP id
 m9-20020ad45dc9000000b0066fafb8bcc5mr7628839qvh.8.1699580128275; Thu, 09 Nov
 2023 17:35:28 -0800 (PST)
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
 <CAADnVQKY+B3n3CXPwg+9PbyyNvfR0DNiSsGDMh-uNA-obK6yiw@mail.gmail.com>
 <CADx9qWj48yftWY3mP3Df3TxC2uk7Fa4b_y=uhv=QQQS4sMtAGQ@mail.gmail.com>
In-Reply-To: <CADx9qWj48yftWY3mP3Df3TxC2uk7Fa4b_y=uhv=QQQS4sMtAGQ@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 9 Nov 2023 20:35:17 -0500
Message-ID: <CADx9qWh7oPxNY3GjvSgQscgXhkGTNszwbrfkMG8Rj9Li3Se7WQ@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/GCxRbMUhz-9oZkAmJnXEGtM_rQA>
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

T24gVGh1LCBOb3YgOSwgMjAyMyBhdCA3OjU24oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0Bv
YnMuY3I+IHdyb3RlOgo+Cj4gT24gVGh1LCBOb3YgOSwgMjAyMyBhdCAxOjMx4oCvUE0gQWxleGVp
IFN0YXJvdm9pdG92Cj4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4K
PiA+IE9uIFdlZCwgTm92IDgsIDIwMjMgYXQgMzo1N+KAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2lu
c3dAb2JzLmNyPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gV2VkLCBOb3YgOCwgMjAyMyBhdCAyOjUx
4oCvUE0gQWxleGVpIFN0YXJvdm9pdG92Cj4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwu
Y29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFdlZCwgTm92IDgsIDIwMjMgYXQgMjoxM+KA
r0FNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+
ID4gPiBPbiBUdWUsIE5vdiA3LCAyMDIzIGF0IDg6MTfigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YK
PiA+ID4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gVHVlLCBOb3YgNywgMjAyMyBhdCAxMTo1NuKAr0FNIFdpbGwgSGF3
a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
IE9uIE1vbiwgTm92IDYsIDIwMjMgYXQgMzozOOKAr0FNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4g
PiA+ID4gPiA+IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBTdW4sIE5vdiA1LCAyMDIzIGF0IDQ6MTfigK9QTSBX
aWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+IE9uIFN1biwgTm92IDUsIDIwMjMgYXQgNDo1MeKAr0FNIEFsZXhlaSBT
dGFyb3ZvaXRvdgo+ID4gPiA+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNv
bT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBGcmks
IE5vdiAzLCAyMDIzIGF0IDI6MjDigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArVGhl
IEFCSSBpcyBzcGVjaWZpZWQgaW4gdHdvIHBhcnRzOiBhIGdlbmVyaWMgcGFydCBhbmQgYSBwcm9j
ZXNzb3Itc3BlY2lmaWMgcGFydC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICtBIHBhaXJpbmcgb2Yg
Z2VuZXJpYyBBQkkgd2l0aCB0aGUgcHJvY2Vzc29yLXNwZWNpZmljIEFCSSBmb3IgYSBjZXJ0YWlu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAraW5zdGFudGlhdGlvbiBvZiBhIEJQRiBtYWNoaW5lIHJl
cHJlc2VudHMgYSBjb21wbGV0ZSBiaW5hcnkgaW50ZXJmYWNlIGZvciBCUEYKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ICtwcm9ncmFtcyBleGVjdXRpbmcgb24gdGhhdCBtYWNoaW5lLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK1RoaXMgZG9jdW1lbnQgaXMgdGhl
IGdlbmVyaWMgQUJJIGFuZCBzcGVjaWZpZXMgdGhlIHBhcmFtZXRlcnMgYW5kIGJlaGF2aW9yCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiArY29tbW9uIHRvIGFsbCBpbnN0YW50aWF0aW9ucyBvZiBCUEYg
bWFjaGluZXMuIEluIGFkZGl0aW9uLCBpdCBkZWZpbmVzIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gK2RldGFpbHMgdGhhdCBtdXN0IGJlIHNwZWNpZmllZCBieSBlYWNoIHByb2Nlc3Nvci1zcGVj
aWZpYyBBQkkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAr
VGhlc2UgcHNBQklzIGFyZSB0aGUgc2Vjb25kIHBhcnQgb2YgdGhlIEFCSS4gRWFjaCBpbnN0YW50
aWF0aW9uIG9mIGEgQlBGCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArbWFjaGluZSBtdXN0IGRlc2Ny
aWJlIHRoZSBtZWNoYW5pc20gdGhyb3VnaCB3aGljaCBiaW5hcnkgaW50ZXJmYWNlCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiArY29tcGF0aWJpbGl0eSBpcyBtYWludGFpbmVkIHdpdGggcmVzcGVjdCB0
byB0aGUgaXNzdWVzIGhpZ2hsaWdodGVkIGJ5IHRoaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICtk
b2N1bWVudC4gSG93ZXZlciwgdGhlIGRldGFpbHMgdGhhdCBtdXN0IGJlIGRlZmluZWQgYnkgYSBw
c0FCSSBhcmUgYSBtaW5pbXVtIC0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArYSBwc0FCSSBtYXkg
c3BlY2lmeSBhZGRpdGlvbmFsIHJlcXVpcmVtZW50cyBmb3IgYmluYXJ5IGludGVyZmFjZSBjb21w
YXRpYmlsaXR5Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArb24gYSBwbGF0Zm9ybS4KPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlv
dSBhcmUgdHJ5aW5nIHRvIHNheSBpbiB0aGUgYWJvdmUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gSW4g
bXkgbWluZCB0aGVyZSBpcyBvbmx5IG9uZSBCUEYgcHNBQkkgYW5kIGl0IGRvZXNuJ3QgaGF2ZQo+
ID4gPiA+ID4gPiA+ID4gPiA+IGdlbmVyaWMgYW5kIHByb2Nlc3NvciBwYXJ0cy4gVGhlcmUgaXMg
b25seSBvbmUgInByb2Nlc3NvciIuCj4gPiA+ID4gPiA+ID4gPiA+ID4gQlBGIGlzIHN1Y2ggYSBw
cm9jZXNzb3IuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFdoYXQgSSB3YXMg
dHJ5aW5nIHRvIHNheSB3YXMgdGhhdCB0aGUgZG9jdW1lbnQgaGVyZSBkZXNjcmliZXMgYQo+ID4g
PiA+ID4gPiA+ID4gPiBnZW5lcmljIEFCSS4gSW4gdGhpcyBkb2N1bWVudCB0aGVyZSB3aWxsIGJl
IGFyZWFzIHRoYXQgYXJlIHNwZWNpZmljIHRvCj4gPiA+ID4gPiA+ID4gPiA+IGRpZmZlcmVudCBp
bXBsZW1lbnRhdGlvbnMgYW5kIHRob3NlIHdvdWxkIGJlIGNvbnNpZGVyZWQgcHJvY2Vzc29yCj4g
PiA+ID4gPiA+ID4gPiA+IHNwZWNpZmljLiBJbiBvdGhlciB3b3JkcywgdGhlIHVicGYgcnVudGlt
ZSBjb3VsZCBkZWZpbmUgdGhvc2UgdGhpbmdzCj4gPiA+ID4gPiA+ID4gPiA+IGRpZmZlcmVudGx5
IHRoYW4gdGhlIHJicGYgcnVudGltZSB3aGljaCwgaW4gdHVybiwgY291bGQgZGVmaW5lIHRob3Nl
Cj4gPiA+ID4gPiA+ID4gPiA+IHRoaW5ncyBkaWZmZXJlbnRseSB0aGFuIHRoZSBrZXJuZWwncyBp
bXBsZW1lbnRhdGlvbi4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBJIHNlZSB3aGF0
IHlvdSBtZWFuLiBUaGVyZSBpcyBvbmx5IG9uZSBCUEYgcHNBQkkuIFRoZXJlIGNhbm5vdCBiZSB0
d28uCj4gPiA+ID4gPiA+ID4gPiB1YnBmIGNhbiBkZWNpZGUgbm90IHRvIGZvbGxvdyBpdCwgYnV0
IGl0IGNvdWxkIG9ubHkgbWVhbiB0aGF0Cj4gPiA+ID4gPiA+ID4gPiBpdCdzIG5vbiBjb25mb3Jt
YW50IGFuZCBub3QgY29tcGF0aWJsZS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9rYXku
IFRoYXQgd2FzIG5vdCBob3cgSSB3YXMgc3RydWN0dXJpbmcgdGhlIEFCSS4gSSB0aG91Z2h0IHdl
IGhhZAo+ID4gPiA+ID4gPiA+IGRlY2lkZWQgdGhhdCwgYXMgdGhlIGRvY3VtZW50IHNhaWQsIGFu
IGluc3RhbnRpYXRpb24gb2YgYSBtYWNoaW5lIGhhZAo+ID4gPiA+ID4gPiA+IHRvCj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiAxLiBtZWV0IHRoZSBnQUJJCj4gPiA+ID4gPiA+ID4gMi4gc3Bl
Y2lmeSBpdHMgcmVxdWlyZW1lbnRzIHZpcyBhIHZpcyB0aGUgcHNBQkkKPiA+ID4gPiA+ID4gPiAz
LiAob3B0aW9uYWxseSkgZGVzY3JpYmUgb3RoZXIgcmVxdWlyZW1lbnRzLgo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gSWYgdGhhdCBpcyBub3Qgd2hhdCB3ZSBkZWNpZGVkIHRoZW4gd2Ugd2ls
bCBoYXZlIHRvIHJlc3RydWN0dXJlIHRoZSBkb2N1bWVudC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gVGhpcyBhYmkucnN0IGZpbGUgaXMgdGhlIGJlZ2lubmluZyBvZiAiQlBGIHBzQUJJIiBkb2N1
bWVudC4KPiA+ID4gPiA+ID4gV2UgcHJvYmFibHkgc2hvdWxkIHJlbmFtZSBpdCB0byBwc2FiaS5y
c3QgdG8gYXZvaWQgY29uZnVzaW9uLgo+ID4gPiA+ID4gPiBTZWUgbXkgc2xpZGVzIGZyb20gSUVU
RiAxMTguIEkgaG9wZSB0aGV5IGV4cGxhaW4gd2hhdCAiQlBGIHBzQUJJIiBpcyBmb3IuCj4gPiA+
ID4gPgo+ID4gPiA+ID4gT2YgY291cnNlIHRoZXkgZG8hIFRoYW5rIHlvdSEgTXkgb25seSBxdWVz
dGlvbjogSW4gdGhlIGxhbmd1YWdlIEkgd2FzCj4gPiA+ID4gPiB1c2luZywgSSB3YXMgdGFraW5n
IGEgY3VlIGZyb20gdGhlIFN5c3RlbSBWIHdvcmxkIHdoZXJlIHRoZXJlIGlzIGEKPiA+ID4gPiA+
IEdlbmVyaWMgQUJJIGFuZCBhIHBzQUJJLiBUaGUgR2VuZXJpYyBBQkkgYXBwbGllcyB0byBhbGwg
U3lzdGVtIFYKPiA+ID4gPiA+IGNvbXBhdGlibGUgc3lzdGVtcyBhbmQgZGVmaW5lcyBjZXJ0YWlu
IHByb2Nlc3Nvci1zcGVjaWZpYyBkZXRhaWxzIHRoYXQKPiA+ID4gPiA+IGVhY2ggcGxhdGZvcm0g
bXVzdCBzcGVjaWZ5IHRvIGRlZmluZSBhIGNvbXBsZXRlIEFCSS4gSW4gcGFydGljdWxhciwgSQo+
ID4gPiA+ID4gdG9vayB0aGlzIGxhbmd1YWdlIGFzIGluc3BpcmF0aW9uCj4gPiA+ID4gPgo+ID4g
PiA+ID4gIiIiCj4gPiA+ID4gPiBUaGUgU3lzdGVtIFYgQUJJIGlzIGNvbXBvc2VkIG9mIHR3byBi
YXNpYyBwYXJ0czogQSBnZW5lcmljIHBhcnQgb2YgdGhlCj4gPiA+ID4gPiBzcGVjaWZpY2F0aW9u
IGRlc2NyaWJlcyB0aG9zZSBwYXJ0cyBvZiB0aGUgaW50ZXJmYWNlIHRoYXQgcmVtYWluCj4gPiA+
ID4gPiBjb25zdGFudCBhY3Jvc3MgYWxsIGhhcmR3YXJlIGltcGxlbWVudGF0aW9ucyBvZiBTeXN0
ZW0gViwgYW5kIGEKPiA+ID4gPiA+IHByb2Nlc3Nvci1zcGVjaWZpYyBwYXJ0IG9mIHRoZSBzcGVj
aWZpY2F0aW9uIGRlc2NyaWJlcyB0aGUgcGFydHMgb2YKPiA+ID4gPiA+IHRoZSBzcGVjaWZpY2F0
aW9uIHRoYXQgYXJlIHNwZWNpZmljIHRvIGEgcGFydGljdWxhciBwcm9jZXNzb3IKPiA+ID4gPiA+
IGFyY2hpdGVjdHVyZS4gVG9nZXRoZXIsIHRoZSBnZW5lcmljIEFCSSAob3IgZ0FCSSkgYW5kIHRo
ZSBwcm9jZXNzb3IKPiA+ID4gPiA+IHNwZWNpZmljIHN1cHBsZW1lbnQgKG9yIHBzQUJJKSBwcm92
aWRlIGEgY29tcGxldGUgaW50ZXJmYWNlCj4gPiA+ID4gPiBzcGVjaWZpY2F0aW9uIGZvciBjb21w
aWxlZCBhcHBsaWNhdGlvbiBwcm9ncmFtcyBvbiBzeXN0ZW1zIHRoYXQgc2hhcmUKPiA+ID4gPiA+
IGEgY29tbW9uIGhhcmR3YXJlIGFyY2hpdGVjdHVyZS4KPiA+ID4gPiA+ICIiIgo+ID4gPiA+Cj4g
PiA+ID4gSSBzZWUgd2hlcmUgeW91IGdvdCB0aGUgaW5zcGlyYXRpb24gZnJvbSwgYnV0IGl0J3Mg
bm90IGFwcGxpY2FibGUKPiA+ID4gPiBpbiB0aGUgQlBGIGNhc2UuIEJQRiBpcyBzdWNoIG9uZSBh
bmQgb25seSBwcm9jZXNzb3IuCj4gPiA+ID4gV2UncmUgbm90IGNoYW5naW5nIG5vciBhZGRpbmcg
YW55dGhpbmcgdG8gU3lzIFYgZ2VuZXJpYyBwYXJ0cy4KPiA+ID4KPiA+ID4gVGhhdCB3YXMgbm90
IHF1aXRlIHdoYXQgSSB3YXMgc2F5aW5nLiBXaGF0IEkgc3RhcnRlZCB0byBkcmFmdCBpcwo+ID4g
PiBzb21ldGhpbmcgKHllcywgbW9kZWxlZCBhZnRlciB0aGUgU3lzIFYgKGcvcHMpQUJJKSBidXQg
X2JyYW5kIG5ld18gZm9yCj4gPiA+IEJQRi4gSSB0aGluayB0aGF0IGlzIHdoZXJlIEkgaGF2ZSBi
ZWVuIGZhaWxpbmcgdG8gY29tbXVuaWNhdGUKPiA+ID4gY29ycmVjdGx5LiBXaGF0IEkgd2FzIHBy
b3Bvc2luZyB3YXMgaW5zcGlyZWQgYnkgb3RoZXIgQUJJcyBidXQKPiA+ID4gY29tcGxldGVseSBz
ZXBhcmF0ZSBhbmQgb3J0aG9nb25hbC4gVGhhdCBpcyB0aGUgcmVhc29uIGZvciB0aGUKPiA+ID4g
ZG9jdW1lbnQgc3BlYWtpbmcgb2YgYSBCUEYgTWFjaGluZSBsaWtlOgo+ID4gPgo+ID4gPiBBQkkt
Y29uZm9ybWluZyBCUEYgTWFjaGluZSBJbnN0YW50aWF0aW9uOiBBIHBoeXNpY2FsIG9yIGxvZ2lj
YWwgcmVhbGl6YXRpb24KPiA+ID4gICAgb2YgYSBjb21wdXRlciBzeXN0ZW0gY2FwYWJsZSBvZiBl
eGVjdXRpbmcgQlBGIHByb2dyYW1zIGNvbnNpc3RlbnRseSB3aXRoIHRoZQo+ID4gPiAgICBzcGVj
aWZpY2F0aW9ucyBvdXRsaW5lZCBpbiB0aGlzIGRvY3VtZW50Lgo+ID4gPgo+ID4gPiBiZWNhdXNl
IGl0IGlzIGEgKG5vdCBuZWNlc3NhcmlseSBwaHlzaWNhbCkgZW50aXR5IHRoYXQgZXhlY3V0ZXMg
QlBGCj4gPiA+IHByb2dyYW1zIChpLmUuIGEgIkJQRiBDUFUiKSBmb3Igd2hpY2ggd2UgYXJlIHNw
ZWNpZnlpbmcgdGhlIGJpbmFyeQo+ID4gPiBjb21wYXRpYmlsaXR5LiBJbiBvdGhlciB3b3Jkcywg
dGhlIGRvY3VtZW50IGFzIGl0IHN0YW5kcyBpcyBwcm9wb3NpbmcKPiA+ID4gYSBnQUJJIHdoZXJl
Cj4gPiA+Cj4gPiA+IHRoZSBrZXJuZWwncyAiQlBGIENQVSIgd291bGQgaGF2ZSBpdHMgb3duIHBz
QUJJCj4gPiA+IHVicGYncyAiQlBGIENQVSIgd291bGQgaGF2ZSBpdHMgb3duIHBzQUJJCj4gPgo+
ID4gYW5kIGhvdyB3b3VsZCB5b3UgZXhwZWN0IHRoYXQgdG8gd29yaz8KPiA+IHBzQUJJIGlzIGEg
Y29tcGlsZXIgc3BlYyBpbiB0aGUgZmlyc3QgcGxhY2UuCj4gPiBUaGUgdXNlciB3b3VsZCB1c2Ug
Y2xhbmcgLU8yIC10YXJnZXQgYnBmX2tlcm5lbCB2cyAtdGFyZ2V0IGJwZl91YnBmID8KPgo+IFRo
ZXkgY291bGQgdXNlIHNvbWUgb3RoZXIgY29tcGlsZXIsIHRvby4KCkkgaGl0IHNlbmQgdG9vIHNv
b24uIFNvcnJ5LgoKVG8gZWxhYm9yYXRlLCBpdCBpcyBteSBvcGluaW9uIHRoYXQgYSAoZy9wcylB
QkkgZG9lcyBtb3JlIHRoYW4ganVzdApzcGVjaWZ5IGEgY29tcGlsZXIuIFRoZXJlIGFyZSBhbHNv
IGFzcGVjdHMgdGhhdCBoYXZlIGFuIGltcGFjdCBvbiB0aGUKbGlua2VyIGFuZCB0aGUgbG9hZGVy
LCBhbW9uZyBvdGhlcnMuIFNlZSwgZS5nLiwgQ2hhcHRlciAzIFNlY3Rpb24gNCBvZgp0aGUgeDg2
LTY0IHBzQUJJIGRlc2NyaWJpbmcgcHJvY2VzcyBpbml0aWFsaXphdGlvbi4gT3IsIDMuNyBvZiB0
aGUKc2FtZSBkb2N1bWVudCBkZXNjcmliaW5nIGEgc3RhY2sgdW53aW5kaW5nIGFsZ29yaXRobS4K
CkkgdGhpbmsgdGhhdCB3ZSBzaG91bGQgd3JpdGUgb3VyIGRvY3VtZW50cyB3aXRoIHRoZSAqZXhw
ZWN0YXRpb24qIHRoYXQKYW4gZWNvc3lzdGVtIG9mIHRvb2xzIHdpbGwgZXhpc3QgYmV5b25kIHRo
ZSBvbmVzIHRoYXQgZXhpc3Qgbm93LiBUaGF0CndheSB3ZSB3b24ndCBlbmQgdXAgaW4gdGhlICJQ
ZXJsIGlzIHRoZSBvbmx5IHRoaW5nIHRoYXQgY2FuIHBhcnNlClBlcmwiIGNvbnVuZHJ1bS4gV2hh
dCdzIG1vcmUsIGNsYW5nIGlzIGV2ZW4gdG9kYXkgbm90IHRoZSBvbmx5IHRoaW5nCnRoYXQgZ2Vu
ZXJhdGVzIEJQRiBtYWNoaW5lIGNvZGUgKFsxXSwgYW1vbmcgb3RoZXJzLCBJJ20gc3VyZSEpLgoK
WzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9BbGFuLUpvd2V0dC9icGZfY29uZm9ybWFuY2UvCgotLSAK
QnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1h
bi9saXN0aW5mby9icGYK

