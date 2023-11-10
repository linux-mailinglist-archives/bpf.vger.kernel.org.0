Return-Path: <bpf+bounces-14666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AF17E761D
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018041C20E07
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1770643;
	Fri, 10 Nov 2023 00:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="dhk1IpAD";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="dhk1IpAD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="fEts3j/G"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F82EA9
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 00:56:21 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24989385C
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 16:56:21 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A640DC1E4E46
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 16:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699577780; bh=lgC5xm2fApb5u/up58nXGrPY2YmX1khi39xL8HemHRQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dhk1IpADdR7dW8SgdLJGPv817x0BZ+EwdGY2j1J48RL0r8hcsHYJ+y/S3YmMDBckt
	 s85Bww9xqs9+a5fbvG9UaNSy8/BcQ8lDGxlpxRuylwR5JPO+BCIJiOZVptMuuLB8Ap
	 3eulgSNSKD/bmJQ3AS5EkHp14K4W5syJ6R7LpJY8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Nov  9 16:56:20 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 703EBC1C5F39;
	Thu,  9 Nov 2023 16:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699577780; bh=lgC5xm2fApb5u/up58nXGrPY2YmX1khi39xL8HemHRQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=dhk1IpADdR7dW8SgdLJGPv817x0BZ+EwdGY2j1J48RL0r8hcsHYJ+y/S3YmMDBckt
	 s85Bww9xqs9+a5fbvG9UaNSy8/BcQ8lDGxlpxRuylwR5JPO+BCIJiOZVptMuuLB8Ap
	 3eulgSNSKD/bmJQ3AS5EkHp14K4W5syJ6R7LpJY8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C31C2C1C5F39
 for <bpf@ietfa.amsl.com>; Thu,  9 Nov 2023 16:56:19 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.907
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LH4R8K4aVCgU for <bpf@ietfa.amsl.com>;
 Thu,  9 Nov 2023 16:56:18 -0800 (PST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id F0AABC1C02BA
 for <bpf@ietf.org>; Thu,  9 Nov 2023 16:56:18 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-672f5fb0b39so8887596d6.2
 for <bpf@ietf.org>; Thu, 09 Nov 2023 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699577778; x=1700182578;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dG/hRfNgimQHSL2EWxSgb1064gOdk/BgJkC+YiWFos=;
 b=fEts3j/GHcLJEB8bborM8hncn8bioJsiovv9mHhE3SgvE8+N8DeYDrKiu0IreKuCvu
 zi0vpH5CservlnuCQdj+AphZpnntkLfnwZeJeLh0sOPmbCDVVF12AEjR5+wxSC1ix6rR
 C7UXFUaJbFiOx2ed7UnpoYDxZ2TzjYlpBVAoHX95oTxKMTvcMkJm55MSymBSsVL74568
 tcAXCAlFUXbrrJWvSRxBzL7kcSoSXv6bifmpF0CEvj/3YnLlwQdNKBg2Y7P0/A/Wywks
 WNbFn1oHljeHn20MqfTS2RsYw2zjdBRWlSdYDfGkgldqry8rBpb+91gWEBMT0AmJv505
 R5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699577778; x=1700182578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dG/hRfNgimQHSL2EWxSgb1064gOdk/BgJkC+YiWFos=;
 b=ufSQMbpxRGG8Wk/wcwm+JobQNUKeBjlXK42gDWIDoGooi5oTfdL63FUkCCLeeBSVsw
 QSYo2nRa7sMj3JpUUIMf7JMpjKhmgi6YDtEan/N6KxM5iwKSsRH1u/BQ2oXkfRLF+BOk
 ZUTgb0mCUMrYw1SsIREpLxIeidIx6fAmoT3f6kSParH4EWa29xTEyJUkn6+Re3ZEFutT
 opg3X7TRx7XjkgBfBOB0rr9o+4zgfNmtHKHW7dp6aoj0JPBuuZisexCxBzGUw5AYulZU
 X0zA+uh/uJIZspGZIfk98bDDMeFsUpnN6r2j/H60zsdG5hWWzjwj07En6PDib8b9VKmf
 QrjA==
X-Gm-Message-State: AOJu0YyItgqGEvyURzFuw9MPjVAsErEv6LVt61iidXNTfRitT8VLX/jq
 43Myp7IlBHi4bSLEl9sJ3M3FRvylKLv105agpElh07Srzag4OEGR
X-Google-Smtp-Source: AGHT+IE6yoP7EoJEQZbJNmru7YZxS14UCc93dTurRKruh7wPnrooQYAGRTtVXXoUgqdzfrzeBpIGdj5tTIMXQz57+u8=
X-Received: by 2002:a05:6214:c81:b0:65b:2660:f577 with SMTP id
 r1-20020a0562140c8100b0065b2660f577mr5927736qvr.3.1699577777908; Thu, 09 Nov
 2023 16:56:17 -0800 (PST)
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
In-Reply-To: <CAADnVQKY+B3n3CXPwg+9PbyyNvfR0DNiSsGDMh-uNA-obK6yiw@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 9 Nov 2023 19:56:07 -0500
Message-ID: <CADx9qWj48yftWY3mP3Df3TxC2uk7Fa4b_y=uhv=QQQS4sMtAGQ@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ZJoKHLMewVGKHU6MNAv_YnaZzEo>
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

T24gVGh1LCBOb3YgOSwgMjAyMyBhdCAxOjMx4oCvUE0gQWxleGVpIFN0YXJvdm9pdG92CjxhbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgTm92IDgsIDIwMjMg
YXQgMzo1N+KAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+Cj4g
PiBPbiBXZWQsIE5vdiA4LCAyMDIzIGF0IDI6NTHigK9QTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gV2Vk
LCBOb3YgOCwgMjAyMyBhdCAyOjEz4oCvQU0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+
IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gVHVlLCBOb3YgNywgMjAyMyBhdCA4OjE34oCvUE0g
QWxleGVpIFN0YXJvdm9pdG92Cj4gPiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+
IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIFR1ZSwgTm92IDcsIDIwMjMgYXQgMTE6NTbi
gK9BTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+IE9uIE1vbiwgTm92IDYsIDIwMjMgYXQgMzozOOKAr0FNIEFsZXhlaSBTdGFyb3Zv
aXRvdgo+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPbiBTdW4sIE5vdiA1LCAyMDIzIGF0IDQ6MTfigK9Q
TSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gT24gU3VuLCBOb3YgNSwgMjAyMyBhdCA0OjUx4oCvQU0gQWxleGVpIFN0
YXJvdm9pdG92Cj4gPiA+ID4gPiA+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgTm92IDMs
IDIwMjMgYXQgMjoyMOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToK
PiA+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ID4gK1RoZSBBQkkgaXMgc3Bl
Y2lmaWVkIGluIHR3byBwYXJ0czogYSBnZW5lcmljIHBhcnQgYW5kIGEgcHJvY2Vzc29yLXNwZWNp
ZmljIHBhcnQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gK0EgcGFpcmluZyBvZiBnZW5lcmljIEFCSSB3
aXRoIHRoZSBwcm9jZXNzb3Itc3BlY2lmaWMgQUJJIGZvciBhIGNlcnRhaW4KPiA+ID4gPiA+ID4g
PiA+ID4gPiAraW5zdGFudGlhdGlvbiBvZiBhIEJQRiBtYWNoaW5lIHJlcHJlc2VudHMgYSBjb21w
bGV0ZSBiaW5hcnkgaW50ZXJmYWNlIGZvciBCUEYKPiA+ID4gPiA+ID4gPiA+ID4gPiArcHJvZ3Jh
bXMgZXhlY3V0aW5nIG9uIHRoYXQgbWFjaGluZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+
ID4gPiA+ID4gPiA+ID4gK1RoaXMgZG9jdW1lbnQgaXMgdGhlIGdlbmVyaWMgQUJJIGFuZCBzcGVj
aWZpZXMgdGhlIHBhcmFtZXRlcnMgYW5kIGJlaGF2aW9yCj4gPiA+ID4gPiA+ID4gPiA+ID4gK2Nv
bW1vbiB0byBhbGwgaW5zdGFudGlhdGlvbnMgb2YgQlBGIG1hY2hpbmVzLiBJbiBhZGRpdGlvbiwg
aXQgZGVmaW5lcyB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiArZGV0YWlscyB0aGF0IG11c3QgYmUg
c3BlY2lmaWVkIGJ5IGVhY2ggcHJvY2Vzc29yLXNwZWNpZmljIEFCSS4KPiA+ID4gPiA+ID4gPiA+
ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ID4gK1RoZXNlIHBzQUJJcyBhcmUgdGhlIHNlY29uZCBw
YXJ0IG9mIHRoZSBBQkkuIEVhY2ggaW5zdGFudGlhdGlvbiBvZiBhIEJQRgo+ID4gPiA+ID4gPiA+
ID4gPiA+ICttYWNoaW5lIG11c3QgZGVzY3JpYmUgdGhlIG1lY2hhbmlzbSB0aHJvdWdoIHdoaWNo
IGJpbmFyeSBpbnRlcmZhY2UKPiA+ID4gPiA+ID4gPiA+ID4gPiArY29tcGF0aWJpbGl0eSBpcyBt
YWludGFpbmVkIHdpdGggcmVzcGVjdCB0byB0aGUgaXNzdWVzIGhpZ2hsaWdodGVkIGJ5IHRoaXMK
PiA+ID4gPiA+ID4gPiA+ID4gPiArZG9jdW1lbnQuIEhvd2V2ZXIsIHRoZSBkZXRhaWxzIHRoYXQg
bXVzdCBiZSBkZWZpbmVkIGJ5IGEgcHNBQkkgYXJlIGEgbWluaW11bSAtLQo+ID4gPiA+ID4gPiA+
ID4gPiA+ICthIHBzQUJJIG1heSBzcGVjaWZ5IGFkZGl0aW9uYWwgcmVxdWlyZW1lbnRzIGZvciBi
aW5hcnkgaW50ZXJmYWNlIGNvbXBhdGliaWxpdHkKPiA+ID4gPiA+ID4gPiA+ID4gPiArb24gYSBw
bGF0Zm9ybS4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gSSBkb24ndCB1bmRl
cnN0YW5kIHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gc2F5IGluIHRoZSBhYm92ZS4KPiA+ID4gPiA+
ID4gPiA+ID4gSW4gbXkgbWluZCB0aGVyZSBpcyBvbmx5IG9uZSBCUEYgcHNBQkkgYW5kIGl0IGRv
ZXNuJ3QgaGF2ZQo+ID4gPiA+ID4gPiA+ID4gPiBnZW5lcmljIGFuZCBwcm9jZXNzb3IgcGFydHMu
IFRoZXJlIGlzIG9ubHkgb25lICJwcm9jZXNzb3IiLgo+ID4gPiA+ID4gPiA+ID4gPiBCUEYgaXMg
c3VjaCBhIHByb2Nlc3Nvci4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBXaGF0IEkg
d2FzIHRyeWluZyB0byBzYXkgd2FzIHRoYXQgdGhlIGRvY3VtZW50IGhlcmUgZGVzY3JpYmVzIGEK
PiA+ID4gPiA+ID4gPiA+IGdlbmVyaWMgQUJJLiBJbiB0aGlzIGRvY3VtZW50IHRoZXJlIHdpbGwg
YmUgYXJlYXMgdGhhdCBhcmUgc3BlY2lmaWMgdG8KPiA+ID4gPiA+ID4gPiA+IGRpZmZlcmVudCBp
bXBsZW1lbnRhdGlvbnMgYW5kIHRob3NlIHdvdWxkIGJlIGNvbnNpZGVyZWQgcHJvY2Vzc29yCj4g
PiA+ID4gPiA+ID4gPiBzcGVjaWZpYy4gSW4gb3RoZXIgd29yZHMsIHRoZSB1YnBmIHJ1bnRpbWUg
Y291bGQgZGVmaW5lIHRob3NlIHRoaW5ncwo+ID4gPiA+ID4gPiA+ID4gZGlmZmVyZW50bHkgdGhh
biB0aGUgcmJwZiBydW50aW1lIHdoaWNoLCBpbiB0dXJuLCBjb3VsZCBkZWZpbmUgdGhvc2UKPiA+
ID4gPiA+ID4gPiA+IHRoaW5ncyBkaWZmZXJlbnRseSB0aGFuIHRoZSBrZXJuZWwncyBpbXBsZW1l
bnRhdGlvbi4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEkgc2VlIHdoYXQgeW91IG1lYW4u
IFRoZXJlIGlzIG9ubHkgb25lIEJQRiBwc0FCSS4gVGhlcmUgY2Fubm90IGJlIHR3by4KPiA+ID4g
PiA+ID4gPiB1YnBmIGNhbiBkZWNpZGUgbm90IHRvIGZvbGxvdyBpdCwgYnV0IGl0IGNvdWxkIG9u
bHkgbWVhbiB0aGF0Cj4gPiA+ID4gPiA+ID4gaXQncyBub24gY29uZm9ybWFudCBhbmQgbm90IGNv
bXBhdGlibGUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9rYXkuIFRoYXQgd2FzIG5vdCBob3cg
SSB3YXMgc3RydWN0dXJpbmcgdGhlIEFCSS4gSSB0aG91Z2h0IHdlIGhhZAo+ID4gPiA+ID4gPiBk
ZWNpZGVkIHRoYXQsIGFzIHRoZSBkb2N1bWVudCBzYWlkLCBhbiBpbnN0YW50aWF0aW9uIG9mIGEg
bWFjaGluZSBoYWQKPiA+ID4gPiA+ID4gdG8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gMS4gbWVl
dCB0aGUgZ0FCSQo+ID4gPiA+ID4gPiAyLiBzcGVjaWZ5IGl0cyByZXF1aXJlbWVudHMgdmlzIGEg
dmlzIHRoZSBwc0FCSQo+ID4gPiA+ID4gPiAzLiAob3B0aW9uYWxseSkgZGVzY3JpYmUgb3RoZXIg
cmVxdWlyZW1lbnRzLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJZiB0aGF0IGlzIG5vdCB3aGF0
IHdlIGRlY2lkZWQgdGhlbiB3ZSB3aWxsIGhhdmUgdG8gcmVzdHJ1Y3R1cmUgdGhlIGRvY3VtZW50
Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoaXMgYWJpLnJzdCBmaWxlIGlzIHRoZSBiZWdpbm5pbmcg
b2YgIkJQRiBwc0FCSSIgZG9jdW1lbnQuCj4gPiA+ID4gPiBXZSBwcm9iYWJseSBzaG91bGQgcmVu
YW1lIGl0IHRvIHBzYWJpLnJzdCB0byBhdm9pZCBjb25mdXNpb24uCj4gPiA+ID4gPiBTZWUgbXkg
c2xpZGVzIGZyb20gSUVURiAxMTguIEkgaG9wZSB0aGV5IGV4cGxhaW4gd2hhdCAiQlBGIHBzQUJJ
IiBpcyBmb3IuCj4gPiA+ID4KPiA+ID4gPiBPZiBjb3Vyc2UgdGhleSBkbyEgVGhhbmsgeW91ISBN
eSBvbmx5IHF1ZXN0aW9uOiBJbiB0aGUgbGFuZ3VhZ2UgSSB3YXMKPiA+ID4gPiB1c2luZywgSSB3
YXMgdGFraW5nIGEgY3VlIGZyb20gdGhlIFN5c3RlbSBWIHdvcmxkIHdoZXJlIHRoZXJlIGlzIGEK
PiA+ID4gPiBHZW5lcmljIEFCSSBhbmQgYSBwc0FCSS4gVGhlIEdlbmVyaWMgQUJJIGFwcGxpZXMg
dG8gYWxsIFN5c3RlbSBWCj4gPiA+ID4gY29tcGF0aWJsZSBzeXN0ZW1zIGFuZCBkZWZpbmVzIGNl
cnRhaW4gcHJvY2Vzc29yLXNwZWNpZmljIGRldGFpbHMgdGhhdAo+ID4gPiA+IGVhY2ggcGxhdGZv
cm0gbXVzdCBzcGVjaWZ5IHRvIGRlZmluZSBhIGNvbXBsZXRlIEFCSS4gSW4gcGFydGljdWxhciwg
SQo+ID4gPiA+IHRvb2sgdGhpcyBsYW5ndWFnZSBhcyBpbnNwaXJhdGlvbgo+ID4gPiA+Cj4gPiA+
ID4gIiIiCj4gPiA+ID4gVGhlIFN5c3RlbSBWIEFCSSBpcyBjb21wb3NlZCBvZiB0d28gYmFzaWMg
cGFydHM6IEEgZ2VuZXJpYyBwYXJ0IG9mIHRoZQo+ID4gPiA+IHNwZWNpZmljYXRpb24gZGVzY3Jp
YmVzIHRob3NlIHBhcnRzIG9mIHRoZSBpbnRlcmZhY2UgdGhhdCByZW1haW4KPiA+ID4gPiBjb25z
dGFudCBhY3Jvc3MgYWxsIGhhcmR3YXJlIGltcGxlbWVudGF0aW9ucyBvZiBTeXN0ZW0gViwgYW5k
IGEKPiA+ID4gPiBwcm9jZXNzb3Itc3BlY2lmaWMgcGFydCBvZiB0aGUgc3BlY2lmaWNhdGlvbiBk
ZXNjcmliZXMgdGhlIHBhcnRzIG9mCj4gPiA+ID4gdGhlIHNwZWNpZmljYXRpb24gdGhhdCBhcmUg
c3BlY2lmaWMgdG8gYSBwYXJ0aWN1bGFyIHByb2Nlc3Nvcgo+ID4gPiA+IGFyY2hpdGVjdHVyZS4g
VG9nZXRoZXIsIHRoZSBnZW5lcmljIEFCSSAob3IgZ0FCSSkgYW5kIHRoZSBwcm9jZXNzb3IKPiA+
ID4gPiBzcGVjaWZpYyBzdXBwbGVtZW50IChvciBwc0FCSSkgcHJvdmlkZSBhIGNvbXBsZXRlIGlu
dGVyZmFjZQo+ID4gPiA+IHNwZWNpZmljYXRpb24gZm9yIGNvbXBpbGVkIGFwcGxpY2F0aW9uIHBy
b2dyYW1zIG9uIHN5c3RlbXMgdGhhdCBzaGFyZQo+ID4gPiA+IGEgY29tbW9uIGhhcmR3YXJlIGFy
Y2hpdGVjdHVyZS4KPiA+ID4gPiAiIiIKPiA+ID4KPiA+ID4gSSBzZWUgd2hlcmUgeW91IGdvdCB0
aGUgaW5zcGlyYXRpb24gZnJvbSwgYnV0IGl0J3Mgbm90IGFwcGxpY2FibGUKPiA+ID4gaW4gdGhl
IEJQRiBjYXNlLiBCUEYgaXMgc3VjaCBvbmUgYW5kIG9ubHkgcHJvY2Vzc29yLgo+ID4gPiBXZSdy
ZSBub3QgY2hhbmdpbmcgbm9yIGFkZGluZyBhbnl0aGluZyB0byBTeXMgViBnZW5lcmljIHBhcnRz
Lgo+ID4KPiA+IFRoYXQgd2FzIG5vdCBxdWl0ZSB3aGF0IEkgd2FzIHNheWluZy4gV2hhdCBJIHN0
YXJ0ZWQgdG8gZHJhZnQgaXMKPiA+IHNvbWV0aGluZyAoeWVzLCBtb2RlbGVkIGFmdGVyIHRoZSBT
eXMgViAoZy9wcylBQkkpIGJ1dCBfYnJhbmQgbmV3XyBmb3IKPiA+IEJQRi4gSSB0aGluayB0aGF0
IGlzIHdoZXJlIEkgaGF2ZSBiZWVuIGZhaWxpbmcgdG8gY29tbXVuaWNhdGUKPiA+IGNvcnJlY3Rs
eS4gV2hhdCBJIHdhcyBwcm9wb3Npbmcgd2FzIGluc3BpcmVkIGJ5IG90aGVyIEFCSXMgYnV0Cj4g
PiBjb21wbGV0ZWx5IHNlcGFyYXRlIGFuZCBvcnRob2dvbmFsLiBUaGF0IGlzIHRoZSByZWFzb24g
Zm9yIHRoZQo+ID4gZG9jdW1lbnQgc3BlYWtpbmcgb2YgYSBCUEYgTWFjaGluZSBsaWtlOgo+ID4K
PiA+IEFCSS1jb25mb3JtaW5nIEJQRiBNYWNoaW5lIEluc3RhbnRpYXRpb246IEEgcGh5c2ljYWwg
b3IgbG9naWNhbCByZWFsaXphdGlvbgo+ID4gICAgb2YgYSBjb21wdXRlciBzeXN0ZW0gY2FwYWJs
ZSBvZiBleGVjdXRpbmcgQlBGIHByb2dyYW1zIGNvbnNpc3RlbnRseSB3aXRoIHRoZQo+ID4gICAg
c3BlY2lmaWNhdGlvbnMgb3V0bGluZWQgaW4gdGhpcyBkb2N1bWVudC4KPiA+Cj4gPiBiZWNhdXNl
IGl0IGlzIGEgKG5vdCBuZWNlc3NhcmlseSBwaHlzaWNhbCkgZW50aXR5IHRoYXQgZXhlY3V0ZXMg
QlBGCj4gPiBwcm9ncmFtcyAoaS5lLiBhICJCUEYgQ1BVIikgZm9yIHdoaWNoIHdlIGFyZSBzcGVj
aWZ5aW5nIHRoZSBiaW5hcnkKPiA+IGNvbXBhdGliaWxpdHkuIEluIG90aGVyIHdvcmRzLCB0aGUg
ZG9jdW1lbnQgYXMgaXQgc3RhbmRzIGlzIHByb3Bvc2luZwo+ID4gYSBnQUJJIHdoZXJlCj4gPgo+
ID4gdGhlIGtlcm5lbCdzICJCUEYgQ1BVIiB3b3VsZCBoYXZlIGl0cyBvd24gcHNBQkkKPiA+IHVi
cGYncyAiQlBGIENQVSIgd291bGQgaGF2ZSBpdHMgb3duIHBzQUJJCj4KPiBhbmQgaG93IHdvdWxk
IHlvdSBleHBlY3QgdGhhdCB0byB3b3JrPwo+IHBzQUJJIGlzIGEgY29tcGlsZXIgc3BlYyBpbiB0
aGUgZmlyc3QgcGxhY2UuCj4gVGhlIHVzZXIgd291bGQgdXNlIGNsYW5nIC1PMiAtdGFyZ2V0IGJw
Zl9rZXJuZWwgdnMgLXRhcmdldCBicGZfdWJwZiA/CgpUaGV5IGNvdWxkIHVzZSBzb21lIG90aGVy
IGNvbXBpbGVyLCB0b28uCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6
Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

