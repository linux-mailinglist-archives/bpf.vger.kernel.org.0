Return-Path: <bpf+bounces-14442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14B7E4977
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 20:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B58281255
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 19:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB36336B11;
	Tue,  7 Nov 2023 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yFRjAL93";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yFRjAL93";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="aUJsk0Fv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2934CE7
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 19:56:24 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B906E7
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 11:56:23 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EF4C1C1CB007
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699386982; bh=3ireWC9J2zEsp5hzK6xM1aCvJfXwfADeNNqhCJiDNwk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yFRjAL93qGWioE6JZ9zazPsA3X4UYe+bsYsW8BwXjaJwnqbznBgAQkiCDiTxjUVyU
	 rRY9wn0d6R3UePLViwtzBJHrZEBUTAAY8AMNUcc4KbKJFEsrykwogwzWS21k18GYN6
	 4775JMLLIoyrbrXCL3zCIXkMzvX+xaCkukpiWD40=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Nov  7 11:56:22 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D988CC1CAFE3;
	Tue,  7 Nov 2023 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699386982; bh=3ireWC9J2zEsp5hzK6xM1aCvJfXwfADeNNqhCJiDNwk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yFRjAL93qGWioE6JZ9zazPsA3X4UYe+bsYsW8BwXjaJwnqbznBgAQkiCDiTxjUVyU
	 rRY9wn0d6R3UePLViwtzBJHrZEBUTAAY8AMNUcc4KbKJFEsrykwogwzWS21k18GYN6
	 4775JMLLIoyrbrXCL3zCIXkMzvX+xaCkukpiWD40=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E4D81C1CAFE3
 for <bpf@ietfa.amsl.com>; Tue,  7 Nov 2023 11:56:21 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.907
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WGOCZ1u5M-Wk for <bpf@ietfa.amsl.com>;
 Tue,  7 Nov 2023 11:56:19 -0800 (PST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 88B5EC151531
 for <bpf@ietf.org>; Tue,  7 Nov 2023 11:56:19 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7bb2e625165so1095141241.1
 for <bpf@ietf.org>; Tue, 07 Nov 2023 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699386978; x=1699991778;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjOaWaxhB0I1LfMyCOktuLSgP+foQf9G3E2ZX7OHvsY=;
 b=aUJsk0FvIpt13zhBDaD0x8u5aDJOU/POeY/ZxoRaj6KlWf+QcJxvEw2SBZGJ2jJaLb
 uRu6uvVlHJ1Ho4cIghUImMrmLoq8eF9JHIHErmKWe0Lm219xONxYKlp0CMqevEzYdDQP
 6vxqr19JrCCwxmY3DBD0FTPWFbwy2Sk3t8JGWlK2iL58CfF0CFjHWuyZCMXsyr3qknhl
 an8yMciVD7x4lgbnKanwjQJ699jGFPMzMCLC80edLh3GKX8HpwzWRlp5IxWP36HwqC44
 2q7+Beb6/LkMlmcYfanGvuEiRjxTAuso0uBEsO6qCipN4z0BMvVvHWl8ulJDAlZzHdEb
 zYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699386978; x=1699991778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjOaWaxhB0I1LfMyCOktuLSgP+foQf9G3E2ZX7OHvsY=;
 b=IppSfUbKus/KHlhSZEGBuCBwAzjZlzlz0SHiwctbL1oXPmhjACLNeGUhokgBe67mAA
 h6jAkUnsdooSv78zGWoXELc8jj+DDs4xPhNMKWpzGv/9zIHLA4yyIXS053MQYVR5U1bo
 bGmpYt3rwbYKZQuHpzIH95jFm7aXIVbE+WgIAJT37MOADUdjZvELJvfebHuy09GkxCnk
 77zQ6hwMKXIY+pppMJdhBe6MEhswe79KchBi+CrRPDrtOw92heFQMRK55osk783bztT9
 SDB3LYFnwKsVHisc6PnRQsqcJniz39jR69kQmFvp4Q/JIXJmEArJkHpjooisBZgGV6/E
 hlcg==
X-Gm-Message-State: AOJu0YyiPqxdO1AIKjL0IOKujuVv0Ii/4khO+EO/LRFOTTUW0ieMo35U
 Dkb4YO+mg37t0iuBu3fA5RpLPVvhRwl3gy/1uHEbwg==
X-Google-Smtp-Source: AGHT+IGR4J2p0Gc8io1ZhH7XE5wrcbH80Sc616yItZ7zPJr0mc3fF9JlJKaGh2rze/GRKN/n2C5Ml9nAgWEHUgWBLWA=
X-Received: by 2002:a05:6102:aca:b0:45f:4ba5:1c4e with SMTP id
 m10-20020a0561020aca00b0045f4ba51c4emr4303563vsh.35.1699386978430; Tue, 07
 Nov 2023 11:56:18 -0800 (PST)
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
In-Reply-To: <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 7 Nov 2023 14:56:04 -0500
Message-ID: <CADx9qWj0fWWhT4OBLqy9MJ=hSZwSfdWvsn+9AqxmvE_DuEGCTg@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/pwqEECoNbGCB5xt9EOcMr1TVIX4>
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

T24gTW9uLCBOb3YgNiwgMjAyMyBhdCAzOjM44oCvQU0gQWxleGVpIFN0YXJvdm9pdG92CjxhbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFN1biwgTm92IDUsIDIwMjMg
YXQgNDoxN+KAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+Cj4g
PiBPbiBTdW4sIE5vdiA1LCAyMDIzIGF0IDQ6NTHigK9BTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gRnJp
LCBOb3YgMywgMjAyMyBhdCAyOjIw4oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+
IHdyb3RlOgo+ID4gPiA+ICsKPiA+ID4gPiArVGhlIEFCSSBpcyBzcGVjaWZpZWQgaW4gdHdvIHBh
cnRzOiBhIGdlbmVyaWMgcGFydCBhbmQgYSBwcm9jZXNzb3Itc3BlY2lmaWMgcGFydC4KPiA+ID4g
PiArQSBwYWlyaW5nIG9mIGdlbmVyaWMgQUJJIHdpdGggdGhlIHByb2Nlc3Nvci1zcGVjaWZpYyBB
QkkgZm9yIGEgY2VydGFpbgo+ID4gPiA+ICtpbnN0YW50aWF0aW9uIG9mIGEgQlBGIG1hY2hpbmUg
cmVwcmVzZW50cyBhIGNvbXBsZXRlIGJpbmFyeSBpbnRlcmZhY2UgZm9yIEJQRgo+ID4gPiA+ICtw
cm9ncmFtcyBleGVjdXRpbmcgb24gdGhhdCBtYWNoaW5lLgo+ID4gPiA+ICsKPiA+ID4gPiArVGhp
cyBkb2N1bWVudCBpcyB0aGUgZ2VuZXJpYyBBQkkgYW5kIHNwZWNpZmllcyB0aGUgcGFyYW1ldGVy
cyBhbmQgYmVoYXZpb3IKPiA+ID4gPiArY29tbW9uIHRvIGFsbCBpbnN0YW50aWF0aW9ucyBvZiBC
UEYgbWFjaGluZXMuIEluIGFkZGl0aW9uLCBpdCBkZWZpbmVzIHRoZQo+ID4gPiA+ICtkZXRhaWxz
IHRoYXQgbXVzdCBiZSBzcGVjaWZpZWQgYnkgZWFjaCBwcm9jZXNzb3Itc3BlY2lmaWMgQUJJLgo+
ID4gPiA+ICsKPiA+ID4gPiArVGhlc2UgcHNBQklzIGFyZSB0aGUgc2Vjb25kIHBhcnQgb2YgdGhl
IEFCSS4gRWFjaCBpbnN0YW50aWF0aW9uIG9mIGEgQlBGCj4gPiA+ID4gK21hY2hpbmUgbXVzdCBk
ZXNjcmliZSB0aGUgbWVjaGFuaXNtIHRocm91Z2ggd2hpY2ggYmluYXJ5IGludGVyZmFjZQo+ID4g
PiA+ICtjb21wYXRpYmlsaXR5IGlzIG1haW50YWluZWQgd2l0aCByZXNwZWN0IHRvIHRoZSBpc3N1
ZXMgaGlnaGxpZ2h0ZWQgYnkgdGhpcwo+ID4gPiA+ICtkb2N1bWVudC4gSG93ZXZlciwgdGhlIGRl
dGFpbHMgdGhhdCBtdXN0IGJlIGRlZmluZWQgYnkgYSBwc0FCSSBhcmUgYSBtaW5pbXVtIC0tCj4g
PiA+ID4gK2EgcHNBQkkgbWF5IHNwZWNpZnkgYWRkaXRpb25hbCByZXF1aXJlbWVudHMgZm9yIGJp
bmFyeSBpbnRlcmZhY2UgY29tcGF0aWJpbGl0eQo+ID4gPiA+ICtvbiBhIHBsYXRmb3JtLgo+ID4g
Pgo+ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIHRyeWluZyB0byBzYXkgaW4g
dGhlIGFib3ZlLgo+ID4gPiBJbiBteSBtaW5kIHRoZXJlIGlzIG9ubHkgb25lIEJQRiBwc0FCSSBh
bmQgaXQgZG9lc24ndCBoYXZlCj4gPiA+IGdlbmVyaWMgYW5kIHByb2Nlc3NvciBwYXJ0cy4gVGhl
cmUgaXMgb25seSBvbmUgInByb2Nlc3NvciIuCj4gPiA+IEJQRiBpcyBzdWNoIGEgcHJvY2Vzc29y
Lgo+ID4KPiA+IFdoYXQgSSB3YXMgdHJ5aW5nIHRvIHNheSB3YXMgdGhhdCB0aGUgZG9jdW1lbnQg
aGVyZSBkZXNjcmliZXMgYQo+ID4gZ2VuZXJpYyBBQkkuIEluIHRoaXMgZG9jdW1lbnQgdGhlcmUg
d2lsbCBiZSBhcmVhcyB0aGF0IGFyZSBzcGVjaWZpYyB0bwo+ID4gZGlmZmVyZW50IGltcGxlbWVu
dGF0aW9ucyBhbmQgdGhvc2Ugd291bGQgYmUgY29uc2lkZXJlZCBwcm9jZXNzb3IKPiA+IHNwZWNp
ZmljLiBJbiBvdGhlciB3b3JkcywgdGhlIHVicGYgcnVudGltZSBjb3VsZCBkZWZpbmUgdGhvc2Ug
dGhpbmdzCj4gPiBkaWZmZXJlbnRseSB0aGFuIHRoZSByYnBmIHJ1bnRpbWUgd2hpY2gsIGluIHR1
cm4sIGNvdWxkIGRlZmluZSB0aG9zZQo+ID4gdGhpbmdzIGRpZmZlcmVudGx5IHRoYW4gdGhlIGtl
cm5lbCdzIGltcGxlbWVudGF0aW9uLgo+Cj4gSSBzZWUgd2hhdCB5b3UgbWVhbi4gVGhlcmUgaXMg
b25seSBvbmUgQlBGIHBzQUJJLiBUaGVyZSBjYW5ub3QgYmUgdHdvLgo+IHVicGYgY2FuIGRlY2lk
ZSBub3QgdG8gZm9sbG93IGl0LCBidXQgaXQgY291bGQgb25seSBtZWFuIHRoYXQKPiBpdCdzIG5v
biBjb25mb3JtYW50IGFuZCBub3QgY29tcGF0aWJsZS4KCk9rYXkuIFRoYXQgd2FzIG5vdCBob3cg
SSB3YXMgc3RydWN0dXJpbmcgdGhlIEFCSS4gSSB0aG91Z2h0IHdlIGhhZApkZWNpZGVkIHRoYXQs
IGFzIHRoZSBkb2N1bWVudCBzYWlkLCBhbiBpbnN0YW50aWF0aW9uIG9mIGEgbWFjaGluZSBoYWQK
dG8KCjEuIG1lZXQgdGhlIGdBQkkKMi4gc3BlY2lmeSBpdHMgcmVxdWlyZW1lbnRzIHZpcyBhIHZp
cyB0aGUgcHNBQkkKMy4gKG9wdGlvbmFsbHkpIGRlc2NyaWJlIG90aGVyIHJlcXVpcmVtZW50cy4K
CklmIHRoYXQgaXMgbm90IHdoYXQgd2UgZGVjaWRlZCB0aGVuIHdlIHdpbGwgaGF2ZSB0byByZXN0
cnVjdHVyZSB0aGUgZG9jdW1lbnQuCgpXaWxsCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0
Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

