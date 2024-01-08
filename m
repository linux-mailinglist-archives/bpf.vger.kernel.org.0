Return-Path: <bpf+bounces-19230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E41827A70
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 22:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08291C22DEE
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08CB5645C;
	Mon,  8 Jan 2024 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UY3ozC8W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UY3ozC8W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II5LKTgZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C865645F
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 927B4C06F6B6
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704750696; bh=57f0v13w83daat0puDSsBxk5z9YXsnxBaxIyqAAFaDY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=UY3ozC8Wfd/iONXv/QvYw8EGf1jSnjUBuzxDOqosXhgzBcRCFeyAQYQ12SwbV0Gc2
	 xYZVrANLGeXE9esrrmm2ftppuISRquPunJuIyv0We+IF9V54xSiPzcxdZHU0433X3K
	 r64feA7ha8WSrhQOwKFpo+6DLz4v7s7fBvylkSGA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jan  8 13:51:36 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 712D4C06F690;
	Mon,  8 Jan 2024 13:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704750696; bh=57f0v13w83daat0puDSsBxk5z9YXsnxBaxIyqAAFaDY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=UY3ozC8Wfd/iONXv/QvYw8EGf1jSnjUBuzxDOqosXhgzBcRCFeyAQYQ12SwbV0Gc2
	 xYZVrANLGeXE9esrrmm2ftppuISRquPunJuIyv0We+IF9V54xSiPzcxdZHU0433X3K
	 r64feA7ha8WSrhQOwKFpo+6DLz4v7s7fBvylkSGA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 96C70C06F690
 for <bpf@ietfa.amsl.com>; Mon,  8 Jan 2024 13:51:34 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GtuZ2MfsS8WJ for <bpf@ietfa.amsl.com>;
 Mon,  8 Jan 2024 13:51:34 -0800 (PST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 2CD28C06F68E
 for <bpf@ietf.org>; Mon,  8 Jan 2024 13:51:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3376d424a79so908028f8f.1
 for <bpf@ietf.org>; Mon, 08 Jan 2024 13:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704750692; x=1705355492; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFjJvsEhqXup3j2qGLKp11lpSR0rG1msW9Lv0vUhXdE=;
 b=II5LKTgZ1t8r7jP+QNv6Y5IFi8yFV5TjF4TRPAeJK/hTQ4JSw04oyt7XBepdRkzf5j
 6H2IOYtLY5SPk8e8044+Z4pPioz3ptxDp6gAW6iTkMhezgo+jNwqYavy5WNgH+EoC6r+
 +sMvKqI0671s3f1f3yPam95Opgls+xPqyEIZ8J1lNc/e91jqSAYWgI1BA7rKcpTazKxg
 w+rQgNYQFi05eg2NlCRJkM/tIT5zrWrpFZdhXkOqfeI1qokfSurWo1ZrbWYy4zVPJQHI
 Z3lDc+ovS2RGnvGf9wPAbRfDA1cEFM5nc7UJRPzLqVocWYCAKqvYnk8JRmLyxj+BZXgQ
 VYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704750692; x=1705355492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFjJvsEhqXup3j2qGLKp11lpSR0rG1msW9Lv0vUhXdE=;
 b=O4a2ZPBEm1WrDwzQNz+7wmAz925ofImmHir7q6hulhwa4pIJoSkhJqMn5SrVfP+P85
 X/qNMYnmWZFsXZnvYuIIXrgtUipMU02jk7MhgiHP173shKeoCl3IVUYrtjQU5vrErGK9
 WbLhUe6LAFrjv3I6Dxjpy0UF4nV8DQA8fKewIxe8b1x5AXMHryMVt/817sxYcFgLZ3VT
 fRH/A18kS4LEyOXbqWT2NG52+Q3kabPfebZm9I5RmHau30eRZcKL/Al2qTe94Os7JubH
 ypGtcJXHhzV5EIOLrwddsv7UpZHa4hoH5+/qoVrK9J1sjtTvC9Rkb/ccD+AUZu7Fd1x1
 etjA==
X-Gm-Message-State: AOJu0YwfjeNkTM9wEgXtj4pEabVUtWYnPD9xuS8SZukjhzRSiYNroEFO
 Evz5MumW1hLGrFAbd6b+jIkvPbrYokAwhAgPrl4=
X-Google-Smtp-Source: AGHT+IGhzGzUQ3Fdqtiy5uPad4IAAQOBq0FCjLFVDQ2XzhO2DD4gChQhZ3xPSafIL4/5BKirDULPz62FAa3skByD0/Q=
X-Received: by 2002:a5d:598e:0:b0:337:5a1b:8212 with SMTP id
 n14-20020a5d598e000000b003375a1b8212mr46493wri.109.1704750692126; Mon, 08 Jan
 2024 13:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org> <20240105220711.GA1001999@maniforge>
 <ZZwcC7nZiZ+OV1ST@infradead.org>
In-Reply-To: <ZZwcC7nZiZ+OV1ST@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jan 2024 13:51:21 -0800
Message-ID: <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Vernet <void@manifault.com>, Dave Thaler <dthaler1968@googlemail.com>,
 bpf@ietf.org, bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/fGmjymAtB9ZEOkDRTyqhRjscjQw>
Subject: Re: [Bpf] BPF ISA conformance groups
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

T24gTW9uLCBKYW4gOCwgMjAyNCBhdCA4OjAw4oCvQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IE9uIEZyaSwgSmFuIDA1LCAyMDI0IGF0IDA0OjA3OjEx
UE0gLTA2MDAsIERhdmlkIFZlcm5ldCB3cm90ZToKPiA+Cj4gPiBTbyBob3cgZG8gd2Ugd2FudCB0
byBtb3ZlIGZvcndhcmQgaGVyZT8gSXQgc291bmRzIGxpa2Ugd2UncmUgbGVhbmluZwo+ID4gdG93
YXJkJ3MgQWxleGVpJ3MgcHJvcG9zYWwgb2YgaGF2aW5nOgo+ID4KPiA+IC0gQmFzZSBJbnRlZ2Vy
IEluc3RydWN0aW9uIFNldCwgMzItYml0Cj4gPiAtIEJhc2UgSW50ZWdlciBJbnN0cnVjdGlvbiBT
ZXQsIDY0LWJpdAo+ID4gLSBJbnRlZ2VyIE11bHRpcGxpY2F0aW9uIGFuZCBEaXZpc2lvbgo+ID4g
LSBBdG9taWMgSW5zdHJ1Y3Rpb25zCj4KPiBBcyBpbiB0aGUgNjQtYml0IGludGVnZXIgc2V0IHdv
dWxkIGJlIGFuIGFkZC1vbiB0byB0aGUgZmlyc3Qgb25lIHdoaWNoCj4gaXMgdGhlIGNvcmUgc2V0
PyAgSW4gdGhhdCBjYXNlIHRoYXQncyBmaW5lIHdpdGggbWUsIGJ1dCB0aGUgYWJvdmUKPiB3b3Jk
aW5nIGlzIGEgYml0IHN1Ym9wdGltYWwuCgp5ZXMuCkhlcmUgaXMgaG93IEkgd2FzIHRoaW5raW5n
IGFib3V0IHRoZSBncm91cGluZzoKMzItYml0IHNldDogYWxsIDMyLWJpdCBpbnN0cnVjdGlvbnMg
dGhvc2Ugd2l0aCBCUEZfQUxVIGFuZCBCUEZfSk1QMzIKYW5kIGxvYWQvc3RvcmUuCgo2NC1iaXQg
c2V0OiBhYm92ZSBwbHVzIEJQRl9BTFU2NCBhbmQgQlBGX0pNUC4KClRoZSBpZGVhIGlzIHRvIGFs
bG93IGZvciBjbGVhbiAzMi1iaXQgSFcgb2ZmbG9hZHMuCldlIGNhbiBpbnRyb2R1Y2UgYSBjb21w
aWxlciBmbGFnIHRoYXQgd2lsbCBvbmx5IHVzZSBzdWNoIGluc3RydWN0aW9ucwphbmQgd2lsbCBl
cnJvciB3aGVuIDY0LWJpdCBtYXRoIGlzIG5lZWRlZC4KRGV0YWlscyBuZWVkIHRvIGJlIHRob3Vn
aHQgdGhyb3VnaCwgb2YgY291cnNlLgpSaWdodCBub3cgSSdtIG5vdCBzdXJlIHdoZXRoZXIgd2Ug
bmVlZCB0byByZWR1Y2Ugc2l6ZW9mKHZvaWQqKSB0byA0CmluIHN1Y2ggYSBjYXNlIG9yIG5vcm1h
bCA4IHdpbGwgc3RpbGwgd29yaywgYnV0IGZyb20gSVNBIHBlcnNwZWN0aXZlCmV2ZXJ5dGhpbmcg
aXMgcmVhZHkuIDMyLWJpdCBzdWJyZWdpc3RlcnMgZml0IHdlbGwuClRoZSBjb21waWxlciB3b3Jr
IHBsdXMgYWRkaXRpb25hbCB2ZXJpZmllciBzbWFydG5lc3MgaXMgbmVlZGVkLApidXQgdGhlIGVu
ZCByZXN1bHQgc2hvdWxkIGJlIHZlcnkgbmljZS4KT2ZmbG9hZCBvZiBicGYgcHJvZ3JhbXMgaW50
byAzMi1iaXQgZW1iZWRkZWQgZGV2aWNlcyB3aWxsIGJlIHBvc3NpYmxlLgoKPiA+IEFuZCB0aGVu
IGVpdGhlciBoYXZpbmcgMyBzZXBhcmF0ZSBncm91cHMgZm9yIHRoZSBjYWxscywgb3IgcHV0dGlu
ZyBhbGwgMwo+ID4gaW4gdGhlIGJhc2ljIGdyb3VwPyBJJ2QgbGVhbiB0b3dhcmRzIHRoZSBsYXR0
ZXIgZ2l2ZW4gdGhhdCB3ZSdyZQo+ID4gZGVjb3VwbGluZyBJU0EgY29tcGxpYW5jZSBmcm9tIHRo
ZSB2ZXJpZmllciwgYnV0IGRvbid0IGZlZWwgc3Ryb25nbHkKPiA+IGVpdGhlciB3YXkuCj4KPiBX
aGF0IHdvdWxkIGJlIHRoZSB0aHJlZSBkaWZmZXJlbnQgZ3JvdXBzIGZvciB0aGUgY2FsbHM/ICBJ
IHRoaW5rIGp1c3QKPiBoYXZpbmcgdGhlIGNhbGwgaW5zdHJ1Y3Rpb24gaW4gdGhlIGJhc2UgZ3Jv
dXAgc2hvdWxkIGJlIGZpbmUuICBXZSdsbAo+IG5lZWQgdG8gcHV0IGluIHNvbWUgd29yZGluZyB0
aGF0IGhhdmluZyBzdXBwb3J0IGZvciBhbnkga2luZCBvZiBjYWxsCj4gZGVwZW5kcyBvbiB0aGUg
cHJvZ3JhbSB0eXBlLgoKKzEKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRw
czovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

