Return-Path: <bpf+bounces-23207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76B86EBAB
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 23:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B556F1F22E91
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BB5B20E;
	Fri,  1 Mar 2024 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="mIG8eLWp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="m9WdDnaG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRSUQJG1"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC55A11D
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331467; cv=none; b=HkxBf6pJ3hAUyDiIH4oimjxCQ8CxBzYJBhb5mYrgFu+6EMhgPM6kom/nMRnSnzUJ88uGupTEHoFux2j6YnisJgzC2+VuunxoctprxrUoRoGaCDAvw+MKAS02vZyCD4XFNkXv1Hb7OvNyxHLkG6Htvf60oKPajuLybhmaABzT1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331467; c=relaxed/simple;
	bh=n1tzMwgZEj2QNFXsrKkWM0Gewk0AXbonq+jccbONk1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=iySFpK5bZIgvjsdI4guPv2UECLBHNTa3BFaQC9My6fKsxIUzHl0wT7bwxb04ScXqAcuiuyyj+5gKHufGHPpct7b40P+3NbVTSTOuj9R81hzL8K3KLD2hI81AsPxk3w5NnycL5AcHJeOrPTWZVQyUnVnKemt1X519n2eT4FgGH6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=mIG8eLWp; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=m9WdDnaG; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRSUQJG1 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 14955C1516EB
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709331465; bh=n1tzMwgZEj2QNFXsrKkWM0Gewk0AXbonq+jccbONk1k=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=mIG8eLWpUlA6jBB/L92seeYL+u1LdgOH2e0drMl37+gsdNnWgt4ey+QEDhcrwHTGD
	 FqUeJ4hfMKUYSXPvfjsf7gamBpv/Gk9+d4lGrnVrEkoBg9iIyXq/qsIprZt/NE3shP
	 U0B8gcSWB/cZGPuHm3hz2/9GhnHNp/7Eq4SdiQhc=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Mar  1 14:17:45 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C9147C14F6A9;
	Fri,  1 Mar 2024 14:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709331464; bh=n1tzMwgZEj2QNFXsrKkWM0Gewk0AXbonq+jccbONk1k=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=m9WdDnaGSgF+E1tW9eNoIy/zrLhdqz+/fZ3/ckwrBL+IAejqOm2HovHFiDEG/DGLi
	 qOBXOAXVKCNztwY9c+N8QIuDIe6OoS9bVxxls4d9BPWF6QpLtEE28n3D92AM2SekyK
	 BJC+iWcGAv9md+pAcF7WGN6gbzwrk+Vgx8UEbdkA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DD2B4C14F6A9
 for <bpf@ietfa.amsl.com>; Fri,  1 Mar 2024 14:17:42 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6wNZbfEcZJvY for <bpf@ietfa.amsl.com>;
 Fri,  1 Mar 2024 14:17:42 -0800 (PST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 797A2C14F6A3
 for <bpf@ietf.org>; Fri,  1 Mar 2024 14:17:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412c34a73aeso12046705e9.0
 for <bpf@ietf.org>; Fri, 01 Mar 2024 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709331461; x=1709936261; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bLrX0C4NYfgMm/vzth8DcvdgDLqdSxx/Ge1/CHMNV0=;
 b=IRSUQJG1TmJGZZLkulGqDXt2xNuqK2CPON06/pn8wqZ2SeYcE04qntsgONcJ3WRJcs
 fcFVzDOMUD9nFSVXh1HPgpkap6f2u5rxKneO6ptO1vgdCEBXeQgdSZJOdbsoi/SmjX1T
 PdrzdOivofiE/dF4nAPCG2WwRLbDCNdo1YQzBDe4xSbribUdjkyAe7OTJoEWOz2dip6f
 QJgXSwmv0LZPYgjs3LIywdKcv9/E7UQZdKcAgW5THsW/KShWzLiIjU+aeG0SknxOFanG
 9uQbOSRT3b3zRTHyA9bZm4h1vR4ORb82Fqxq5gxiKvEfjDF/XIOIORYPEOR5NRmcKWkU
 mtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709331461; x=1709936261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2bLrX0C4NYfgMm/vzth8DcvdgDLqdSxx/Ge1/CHMNV0=;
 b=dwg35BvACLoZoHeCy3IOJ7B3TUv78jCmh/48LRrOHdtn2GcAB4zGBRqfLxLk4mgmn4
 Wr6kkqeDARL4EacTuRUGkgtzQktyuo8iItrHv6tfsl6pq6Q6l5NClM4v3O57b5htbB7x
 ad+ehQRMQbneEMviRPnZyZHPnetq55aNL4OO/Q1vbUs76zgPyCVzAJ+G71zqvGYnXlNh
 xV0G2ZY5b4uKJOn0U2p0wSuF1s+0SaIJNsdwpLbeILM1YCtAJGbKK6W0tpaPXrbcxYx1
 mVz7P+VkYIZgb9HBnqhLStIaT4N+1WLKJKML6jtyf9WjNMyKUZb6wX1WLuHQY4+FURx5
 9lsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKyLkYp2rMK7jE/iSplBdBY2fxW2Hc1rO1NZBdIgDloahzfeYASY6A7MCXfhnBtBSKoVNNXuEzmDIHl2A=
X-Gm-Message-State: AOJu0YzBE1oWBihCoonn6Wf6y3E1hyCr7+tuSIc1tAabSZTB6q05SZmG
 Q9DDA9JFGm4W8kIKEtyH2h2aJ+Je0DGDA3ZULSZKnXjRONWSUrfjUYj6Iu7oKbNV3ARMHKQ06g9
 oxhYd9YdppzceE13x4VXSpjoiqExHE3Ru
X-Google-Smtp-Source: AGHT+IEBCF7Kwe00w+SLlTyahlNDeJXlD1fiMJiDB6HuE/JYPJXkK7JgqdRXGfnEafHMS0E+mGddsbvV7yY8x6/zLFA=
X-Received: by 2002:adf:ffd2:0:b0:33e:dd4:ca5c with SMTP id
 x18-20020adfffd2000000b0033e0dd4ca5cmr2310033wrs.45.1709331460534; Fri, 01
 Mar 2024 14:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301192020.15644-1-dthaler1968@gmail.com>
 <20240301214929.GB192865@maniforge>
 <236501da6c23$30b03380$92109a80$@gmail.com>
 <20240301220458.GC192865@maniforge>
In-Reply-To: <20240301220458.GC192865@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 14:17:29 -0800
Message-ID: <CAADnVQK0PFbLXujQzO3HJRPa2NAP8U82LjtqA6PjsPYdnWXHaA@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf <bpf@vger.kernel.org>,
 bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/JjyJuDRThZFAi6kQfAWO3-nou_M>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Use IETF format for field definitions in instruction-set.rst
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

T24gRnJpLCBNYXIgMSwgMjAyNCBhdCAyOjA14oCvUE0gRGF2aWQgVmVybmV0IDx2b2lkQG1hbmlm
YXVsdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXIgMDEsIDIwMjQgYXQgMDE6NTU6MzRQTSAt
MDgwMCwgZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20gd3JvdGU6Cj4gPiBEYXZpZCBWZXJuZXQg
PHZvaWRAbWFuaWZhdWx0LmNvbT4gd3JvdGU6Cj4gPiBbLi4uXQo+ID4gPiBWZXJ5IGdsYWQgdGhh
dCB3ZSB3ZXJlIGFibGUgdG8gZG8gdGhpcyBiZWZvcmUgc2VuZGluZyB0byBXRyBsYXN0IGNhbGwu
Cj4gPiBUaGFuawo+ID4gPiB5b3UsIERhdmUuIEkgbGVmdCBhIGNvdXBsZSBvZiBjb21tZW50cyBi
ZWxvdyBidXQgaGVyZSdzIG15IEFCOgo+ID4gPgo+ID4gPiBBY2tlZC1ieTogRGF2aWQgVmVybmV0
IDx2b2lkQG1hbmlmYXVsdC5jb20+Cj4gPiBbLi4uXQo+ID4gPiA+IC1gYEJQRl9BREQgfCBCUEZf
WCB8IEJQRl9BTFVgYCBtZWFuczo6Cj4gPiA+ID4gK2Bge0FERCwgWCwgQUxVfWBgLCB3aGVyZSAn
Y29kZSc9YGBBRERgYCwgJ3NvdXJjZSc9YGBYYGAsIGFuZAo+ID4gJ2NsYXNzJz1gYEFMVWBgLAo+
ID4gPiBtZWFuczo6Cj4gPiA+Cj4gPiA+IEZvciBzb21lIHJlYXNvbiBgYEFERGBgLCBgYFhgYCBh
bmQgYGBBTFVgYCBhcmVuJ3QgcmVuZGVyaW5nIGNvcnJlY3RseSB3aGVuCj4gPiA+IGJ1aWx0IHdp
dGggc3BoaW54LiBJdCBsb29rcyBsaWtlIHdlIG5lZWQgdG8gZG8gdGhpczoKPiA+IFsuLi5dCj4g
PiA+IC1gYHtBREQsIFgsIEFMVX1gYCwgd2hlcmUgJ2NvZGUnPWBgQUREYGAsICdzb3VyY2UnPWBg
WGBgLCBhbmQKPiA+ICdjbGFzcyc9YGBBTFVgYCwKPiA+ID4gbWVhbnM6Ogo+ID4gPiArYGB7QURE
LCBYLCBBTFV9YGAsIHdoZXJlICdjb2RlJyA9IGBgQUREYGAsICdzb3VyY2UnID0gYGBYYGAsIGFu
ZCAnY2xhc3MnCj4gPiA9Cj4gPiA+IGBgQUxVYGAsIG1lYW5zOjoKPiA+Cj4gPiBBY2suICBEbyB5
b3Ugd2FudCBtZSB0byBzdWJtaXQgYSB2MiBub3cgd2l0aCB0aGF0IGNoYW5nZSBvciBob2xkIG9m
ZiBmb3IgYQo+ID4gYml0PyAgS2VlcCBpbiBtaW5kIHRoZSBkZWFkbGluZSBmb3Igc3VibWl0dGlu
ZyBhIGRyYWZ0IGJlZm9yZSB0aGUgbWVldGluZyBpcwo+ID4gZW5kLW9mLWRheSBNb25kYXkuCj4K
PiBJIHRoaW5rIHdlIGNhbiBob2xkIG9mZiB1bnRpbCBvdGhlciBwZW9wbGUgcmV2aWV3LgoKUHJv
YmFibHkgYmV0dGVyIHRvIHJlc3BpbiBub3cgZml4aW5nIHNwaGlueCBpc3N1ZXMuCgpUaGUgZGlm
ZiBsZ3RtLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3Lmll
dGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

