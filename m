Return-Path: <bpf+bounces-20772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2590842D17
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020751C241D2
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C055B26AFC;
	Tue, 30 Jan 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ix8GXXWi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ix8GXXWi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DndqOCpl"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C37B3C3
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643646; cv=none; b=SevbeAmDzsvxkQjDTq6Fs+EPz6Hl6Q564gT1W91wspCzml35C+MtvRbEMwY2OkSiLdt7EjDLbFabp3/lBVlBlkn7DIT2EUQ6Rxn9r6RolPtV1txfEUOy7R7lYiyBWeguHErpw4pJSkI4pHQVbNNNr7BtqRn2/jS96MdSJi++yEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643646; c=relaxed/simple;
	bh=gJWU4wpOlL94FIXwOEovlPGr3KtHlOqd8c2+DvAtFpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=g/rODXCuVEmU108At8B6SpBAGMTukYqvwXHZ02c4BKitCuM7rSby61Sk1mscfdzvVwh2llZbdSGve3TiqgvsZwEWmfEafhCOlsj5D0DpQuNjJfEq0j8L4Q2Diz8hYkEGK8jZB+wjmYbLDSW+mDB0sPottr0h9fU9OMUXnwhcVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ix8GXXWi; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ix8GXXWi; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DndqOCpl reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EB3F5C151091
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 11:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706643643; bh=gJWU4wpOlL94FIXwOEovlPGr3KtHlOqd8c2+DvAtFpw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ix8GXXWinkvf9yRMBnu3G5bQKmCgNVldusoVT0M0Xb4qxv6sJKpkzR6fo347GRYLs
	 Y2zX6eQjVx0rZdMXOzT8S4vSSc5B+Rl1AdRwCahMKSudcaemaW05Q0fp4d7lVHLqWM
	 h9ICFUNCdtQIDoeXsYxHzGMH6/wvVtghZfjtdHso=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 30 11:40:43 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C7FB0C14CEED;
	Tue, 30 Jan 2024 11:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706643643; bh=gJWU4wpOlL94FIXwOEovlPGr3KtHlOqd8c2+DvAtFpw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ix8GXXWinkvf9yRMBnu3G5bQKmCgNVldusoVT0M0Xb4qxv6sJKpkzR6fo347GRYLs
	 Y2zX6eQjVx0rZdMXOzT8S4vSSc5B+Rl1AdRwCahMKSudcaemaW05Q0fp4d7lVHLqWM
	 h9ICFUNCdtQIDoeXsYxHzGMH6/wvVtghZfjtdHso=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 60496C14F726
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 11:40:42 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgmMG_xSarov for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 11:40:41 -0800 (PST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E02B7C14F71D
 for <bpf@ietf.org>; Tue, 30 Jan 2024 11:40:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5111e5e4e2bso1230327e87.3
 for <bpf@ietf.org>; Tue, 30 Jan 2024 11:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706643640; x=1707248440; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzRKimwqPjTIEeKQ1oM17JSZAsqV0NhKJRSyXCx6gfQ=;
 b=DndqOCplEirK9RL/xx4gOZF3Plsj8xjn8ZbcEC3zqSdF/4DgKhPFHujiAEflepmpAZ
 HLrJ+m2F+DYcdF4x0mJbHyhswj01OJwYUdDNcpJSY5cW0vJFwJEOCMNxugjr5fl5W1/t
 QHC03HeAoZJ11bkXBcvDr3zewbVeu9T9lAV38J1OLQsCxICn8w1TrT5Y9evICv7oWmAB
 juDixYa5dTeeIwHqB4yq8Q9wA0yHogtU4b3xMny2OIJCVHU90AsPVLudUVbfRv38zy7T
 P21siIAv9M/+UOuiQsWpg/r0m0GJ69X5EIpS6GEmrTB3UZY368Yu+OrWf/4SLc4XYfem
 6r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706643640; x=1707248440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzRKimwqPjTIEeKQ1oM17JSZAsqV0NhKJRSyXCx6gfQ=;
 b=sFFFbF8fr8pAzDzfCEnVeyfbN4I58MmEt938RRLDd987wA6rjL8OjK60gNyWaWBIF0
 vLBCD+UQVusNaoh3EzsZAqJdRAU90PkFhkv8H3Dd4Imt3ULDtxUuA2lp9aUYv+yiNZP6
 Adac+4QU/LAMoHflvSR6hVjYzzyYiDZtaY9Caq0AZrTdrylJHWfLlKeIY9N8E6tSlglU
 yTv9KMjGZZHnQoMlCG9dx8O4IXNkNhDmhU+IFZd8fIDpUrd73rsQzeg2juZT5T+5yBhz
 boljz+nLnS8pE4lHBsFpspasVyuUBMM//pX6/WAak8KBmD+rq1mIcVSHe+jt7xEORouc
 KEIQ==
X-Gm-Message-State: AOJu0YxvLHYu9NyCRRUZvxb8BU1RrTEwygK0d4pcLFK8CLjacOS76SAU
 irBH0wnVJXwphrMN5BVdhat3X+nQj2BM3vmZrJERh/E3wv/paKwS08I9yVLeyWIL89/9bjbCVIq
 I9ABG4GK2DnszqqVuI0gFEo2UEvI=
X-Google-Smtp-Source: AGHT+IEneaXalxZjImehz7khNHBL1BB2s5WCMP9vTzJSctoh6f7iYmbxoTEsifBGVdWIsxaYNuej9dROtc7FE8NC6FQ=
X-Received: by 2002:ac2:5ec8:0:b0:510:40a:4cb2 with SMTP id
 d8-20020ac25ec8000000b00510040a4cb2mr5988737lfq.38.1706643639703; Tue, 30 Jan
 2024 11:40:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com>
 <8734uitx3m.fsf@oracle.com> <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
 <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
 <071b01da5394$260dba30$72292e90$@gmail.com>
 <073001da539a$ec1e2b00$c45a8100$@gmail.com>
In-Reply-To: <073001da539a$ec1e2b00$c45a8100$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Jan 2024 11:40:28 -0800
Message-ID: <CAADnVQ+V33Cms=x6HHTCbpKN386NGNa5Z8KeiTujvrefqZod_A@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Yonghong Song <yonghong.song@linux.dev>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/5LnnKm093cGpOmDI9TnLQLBXyys>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
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

T24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgODozOeKAr0FNIDxkdGhhbGVyMTk2OEBnb29nbGVtYWls
LmNvbT4gd3JvdGU6Cj4KPiA+IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiBbLi4uXQo+ID4gPiA+IEFsdGhvdWdoIHRoZSBMaW51eCB2
ZXJpZmllciBkb2Vzbid0IHN1cHBvcnQgdGhlbSwgdGhlIGZhY3QgdGhhdCBnY2MKPiA+ID4gPiBk
b2VzIHN1cHBvcnQgdGhlbSB0ZWxscyBtZSB0aGF0IGl0J3MgcHJvYmFibHkgc2FmZXN0IHRvIGxp
c3QgdGhlIERXCj4gPiA+ID4gYW5kIExEWCB2YXJpYW50cyBhcyBkZXByZWNhdGVkIGFzIHdlbGws
IHdoaWNoIGlzIHdoYXQgdGhlIGRyYWZ0Cj4gPiA+ID4gYWxyZWFkeSBkaWQgaW4gdGhlIGFwcGVu
ZGl4IHNvIHRoYXQncyBnb29kIChub3RoaW5nIHRvIGNoYW5nZSB0aGVyZSwKPiA+ID4gPiBJIHRo
aW5rKS4KPiA+ID4KPiA+ID4gRFcgbmV2ZXIgZXhpc3RlZCBpbiBjbGFzc2ljIGJwZiwgc28gYWJz
L2luZCBuZXZlciBoYWQgRFcgZmxhdm9yLgo+ID4gPiBJZiBzb21lIGFzc2VtYmxlci9jb21waWxl
ciBkZWNpZGVkIHRvICJzdXBwb3J0IiB0aGVtIGl0J3Mgb24gdGhlbS4KPiA+ID4gVGhlIHN0YW5k
YXJkIG11c3Qgbm90IGxpc3Qgc3VjaCB0aGluZ3MgYXMgZGVwcmVjYXRlZC4gVGhleSBuZXZlcgo+
ID4gPiBleGlzdGVkLiBTbyBub3RoaW5nIGlzIGRlcHJlY2F0ZWQuCj4gPgo+ID4gQWNrLCBJIHdp
bGwgcmVtb3ZlIHRoZSBBQlMvSU5EICsgRFcgbGluZXMgZnJvbSB0aGUgYXBwZW5kaXguCj4gPgo+
ID4gPiBTYW1lIHdpdGggTVNILiBCUEZfTERYIHwgQlBGX01TSCB8IEJQRl9CIGlzIHRoZSBvbmx5
IGluc24gZXZlciBleGlzdGVkLgo+ID4gPiBJdCdzIGEgbGVnYWN5IGluc24uIEp1c3QgbGlrZSBh
YnMvaW5kLgo+ID4KPiA+IFNob3VsZCBpdCBiZSBsaXN0ZWQgaW4gdGhlIGxlZ2FjeSBjb25mb3Jt
YW5jZSBncm91cCB0aGVuPwo+ID4KPiA+IEN1cnJlbnRseSBpdCdzIG5vdCBtZW50aW9uZWQgaW4g
aW5zdHJ1Y3Rpb24tc2V0LnJzdCBhdCBhbGwsIHNvIHRoZSBvcGNvZGUgaXMKPiA+IGF2YWlsYWJs
ZSB0byB1c2UgYnkgYW55IG5ldyBpbnN0cnVjdGlvbi4gIElmIHdlIGRvIGxpc3QgaXQgaW4gaW5z
dHJ1Y3Rpb24tc2V0LnJzdAo+ID4gdGhlbiwgbGlrZSBhYnMvaW5kLCBpdCB3aWxsIGJlIGF2b2lk
ZWQgYnkgYW55b25lIHByb3Bvc2luZyBuZXcgaW5zdHJ1Y3Rpb25zLgo+Cj4gSGVyZSdzIG15IHVu
ZGVyc3RhbmRpbmcgb2YgdGhpcyB0aHJlYWQgc28gZmFyOgo+Cj4gKiAoSU5EL0FCUykgfCAoVy9I
L0IpIHwgTEQgOiB0aGVzZSBhcmUgYWNjZXB0ZWQgYnkgdGhlIExpbnV4IHZlcmlmaWVyIGFuZCBh
cmUgc3VwcG9ydGVkCj4gICAgYnkgY2xhbmcgYW5kIGdjYy4gIFRoZXkgc2hvdWxkIGJlIGluIHRo
ZSBsZWdhY3kgY29uZm9ybWFuY2UgZ3JvdXAgb2YgZGVwcmVjYXRlZAo+ICAgIGluc3RydWN0aW9u
cy4KCnllcwoKPiAqIChJTkQvQUJTKSB8IERXIHwgKExEL0xEWCkgOiB0aGVzZSBhcmUgbm90IGFj
Y2VwdGVkIGJ5IHRoZSBMaW51eCB2ZXJpZmllciBhbmQgd2VyZQo+ICAgIG5ldmVyIHVzZWQuICBD
bGFuZyBkb2Vzbid0IGdlbmVyYXRlIHRoZW0gYnV0IGdjYyBkaWQgd2hpY2ggaXMgbm93IHJlbW92
ZWQKPiAgICBiYXNlZCBvbiB0aGlzIGRpc2N1c3Npb24uICBUaGV5IHNob3VsZCBOT1QgYmUgaW4g
dGhlIGxlZ2FjeSBjb25mb3JtYW5jZSBncm91cCBvZgo+ICAgIGRlcHJlY2F0ZWQgaW5zdHJ1Y3Rp
b25zIGJlY2F1c2UgdGhleSB3ZXJlIG5ldmVyIGRlZmluZWQgaW4gdGhlIGZpcnN0IHBsYWNlLCBh
bmQKPiAgICBpbnN0cnVjdGlvbi1zZXQucnN0IHNob3VsZCBiZSB1cGRhdGVkIHRvIGNsYXJpZnkg
dGhpcy4KCnllcwoKPiAqIChJTkQvQUJTKSB8IChXL0gvQikgfCBMRFggOiB0aGVzZSBhcmUgbm90
IGFjY2VwdGVkIGJ5IHRoZSBMaW51eCB2ZXJpZmllciBhbmQgd2VyZQo+ICAgIG5ldmVyIHVzZWQu
ICBDbGFuZyBkb2Vzbid0IGdlbmVyYXRlIHRoZW0gYnV0IGdjYyBkb2VzLiBUaGV5IHNob3VsZCBO
T1QKPiAgICBiZSBpbiB0aGUgbGVnYWN5IGNvbmZvcm1hbmNlIGdyb3VwIG9mIGRlcHJlY2F0ZWQg
aW5zdHJ1Y3Rpb25zIGJlY2F1c2UgdGhleSB3ZXJlCj4gICAgbmV2ZXIgZGVmaW5lZCBpbiB0aGUg
Zmlyc3QgcGxhY2UsIGFuZCBpbnN0cnVjdGlvbi1zZXQucnN0IHNob3VsZCBiZSB1cGRhdGVkIHRv
IGNsYXJpZnkgdGhpcy4KCnllcy4KCj4gKiAoSU5EL0FCUykgfCAoVy9IL0IvRFcpIHwgKFNUL1NU
WCk6IHRoZXNlIGFyZSBub3QgYWNjZXB0ZWQgYnkgdGhlIExpbnV4IHZlcmlmaWVyIGFuZCB3ZXJl
Cj4gICAgbmV2ZXIgdXNlZC4gIEkgZG9uJ3Qga25vdyB3aGV0aGVyIGNsYW5nIG9yIGdjYyBnZW5l
cmF0ZXMgdGhlbS4gIFRoZXkgc2hvdWxkIE5PVAo+ICAgIGJlIGluIHRoZSBsZWdhY3kgY29uZm9y
bWFuY2UgZ3JvdXAgb2YgZGVwcmVjYXRlZCBpbnN0cnVjdGlvbnMgYmVjYXVzZSB0aGV5IHdlcmUK
PiAgICBuZXZlciBkZWZpbmVkIGluIHRoZSBmaXJzdCBwbGFjZSwgYW5kIGluc3RydWN0aW9uLXNl
dC5yc3Qgc2hvdWxkIGJlIHVwZGF0ZWQgdG8gY2xhcmlmeSB0aGlzLgoKeWVzCgo+ICogTVNIIHwg
QiB8IExEWDogdGhpcyBleGlzdGVkIGluIGNsYXNzaWMgQlBGIGJ1dCBkb2VzIG5vdCBleGlzdCBp
biAoZSlCUEYgc2luY2UgaXQgaXMgbm90IGFjY2VwdGVkCj4gICAgYnkgdGhlIExpbnV4IHZlcmlm
aWVyLiAgSSBkb24ndCBrbm93IHdoZXRoZXIgY2xhbmcgZXZlciBnZW5lcmF0ZWQgdGhlbSwgYnV0
IGdjYyBuZXZlciBkaWQuCj4gICAgVGhlICJMZWdhY3kgQlBGIFBhY2tldCBhY2Nlc3MgaW5zdHJ1
Y3Rpb25zIiBzZWN0aW9uIG9mIGluc3RydWN0aW9uLXNldC5yc3Qgc2F5cwo+ICAgID4gQlBGIHBy
ZXZpb3VzbHkgaW50cm9kdWNlZCBzcGVjaWFsIGluc3RydWN0aW9ucyBmb3IgYWNjZXNzIHRvIHBh
Y2tldCBkYXRhIHRoYXQgd2VyZSBjYXJyaWVkCj4gICAgPiBvdmVyIGZyb20gY2xhc3NpYyBCUEYu
IEhvd2V2ZXIsIHRoZXNlIGluc3RydWN0aW9ucyBhcmUgZGVwcmVjYXRlZCBhbmQgc2hvdWxkIG5v
IGxvbmdlciBiZSB1c2VkLgo+ICAgIEkgcmVhZCBBbGV4ZWkncyBjb21tZW50ICJJdCdzIGEgbGVn
YWN5IGluc24uIEp1c3QgbGlrZSBhYnMvaW5kIiBhcyBhIHBvc3NpYmxlIGFyZ3VtZW50IHRoYXQg
TVNIfEJ8TERYCj4gICAgc2hvdWxkIGJlIG1lbnRpb25lZCBpbiBpbnN0cnVjdGlvbi1zZXQucnN0
LCBwb2ludGluZyB0byB0aGUgYWJvdmUgc2VjdGlvbiwgbGlrZSBJTkQvQUJTIGRvLgo+ICAgIEJ1
dCBZb25naG9uZyBhcmd1ZWQgdGhhdCBpdCB3YXMgbmV2ZXIgYWNjZXB0ZWQgYnkgdGhlIHZlcmlm
aWVyLCBzbyBuZWVkIG5vdCBiZSBtZW50aW9uZWQuCgpZb25naG9uZyBpcyBhY3R1YWxseSBtb3Jl
IGNvcnJlY3QgaGVyZS4KCk1TSCB8IEIgfCBMRFggaXMgb25seSBhY2NlcHRlZCBieSBfY2xhc3Np
Y18gQlBGLgoKSXQgd2FzIG5ldmVyIGFjY2VwdGVkIGJ5IGVCUEYgdmVyaWZpZXIsCnNvIEkgaGF2
ZSB0byBiYWNrIHRyYWNrIG15IGVhcmxpZXIgc3VnZ2VzdGlvbi4KSSB0aGluayBpdCdzIHVuZGVm
aW5lZCBvcGNvZGUgZnJvbSAnZUJQRiBzdGFuZGFyZGl6YXRpb24nIHBvdi4KVGhlIHN0YW5kYXJk
IGRvZXNuJ3QgdGFsayBhYm91dCAnY2xhc3NpYyBCUEYnIGF0IGFsbC4KU28gaXQncyBmaW5lIHRv
IHVzZSBNU0ggfCBCIHwgTERYIGZvciBzb21ldGhpbmcgaW4gdGhlIGZ1dHVyZS4KCj4gKiBNU0gg
fCAoVy9IL0RXKSB8IChMRC9TVC9TVFgpOiBUaGVzZSBhcmUgbm90IGFjY2VwdGVkIGJ5IHRoZSBM
aW51eCB2ZXJpZmllciBhbmQgd2VyZQo+ICAgIG5ldmVyIHVzZWQuICBUaGV5IHNob3VsZCBOT1Qg
YmUgaW4gdGhlIGxlZ2FjeSBjb25mb3JtYW5jZSBncm91cCBvZiBkZXByZWNhdGVkIGluc3RydWN0
aW9ucwo+ICAgIGJlY2F1c2UgdGhleSB3ZXJlIG5ldmVyIGRlZmluZWQgaW4gdGhlIGZpcnN0IHBs
YWNlLgoKeWVzLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3
LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

