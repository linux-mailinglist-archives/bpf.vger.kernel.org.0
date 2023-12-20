Return-Path: <bpf+bounces-18361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C61C819727
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 04:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80182870DD
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 03:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026B8C09;
	Wed, 20 Dec 2023 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="T3j2ZFDM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="T3j2ZFDM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzSb0rxy"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D48BEB
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CC949C151536
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1703042908; bh=8k6zYoYER9SwtVYjQQ5o2Ud6vZj4QC8Kdx7KmkazQuk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=T3j2ZFDMBwNymnMypeh+VAFBQC6r+RcfmihGMvu5MlRd7bSrVl8pmYM9ElsouxlLE
	 f95qcekZEhwybhmYvOQtHX2k49Quc2SOAmZIzy5vpY2GAArIbyoVZAWZP/kYH1OzjE
	 v7ehFTOwktb3ZkH1d7V8DxSFlSM4KxoRXcZtahb4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Dec 19 19:28:28 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 936D8C14CEFD;
	Tue, 19 Dec 2023 19:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1703042908; bh=8k6zYoYER9SwtVYjQQ5o2Ud6vZj4QC8Kdx7KmkazQuk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=T3j2ZFDMBwNymnMypeh+VAFBQC6r+RcfmihGMvu5MlRd7bSrVl8pmYM9ElsouxlLE
	 f95qcekZEhwybhmYvOQtHX2k49Quc2SOAmZIzy5vpY2GAArIbyoVZAWZP/kYH1OzjE
	 v7ehFTOwktb3ZkH1d7V8DxSFlSM4KxoRXcZtahb4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5EB2BC14EB17
 for <bpf@ietfa.amsl.com>; Tue, 19 Dec 2023 19:28:27 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YbdYvFO4Tvsc for <bpf@ietfa.amsl.com>;
 Tue, 19 Dec 2023 19:28:23 -0800 (PST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 76C5DC14CEFD
 for <bpf@ietf.org>; Tue, 19 Dec 2023 19:28:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3365d38dce2so4105888f8f.1
 for <bpf@ietf.org>; Tue, 19 Dec 2023 19:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703042902; x=1703647702; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9POoxbdNum3UVcHqKRpm9QHWYivjj/110SpNeUmOkA=;
 b=EzSb0rxyMoxj/Vam6fki3beW3H07H+qmsGxD05eCnkCIFtasJdaKaNXE1d7/0O1fSQ
 /GD4Dqbn0fIuqYr91ABA4IMblqXS9XJm4iUohngfKWIv6LqRUjEkDtKAV1tTjXBEnYoS
 8Kwpzksbxn73F/n5ucX+x00+UD85hoI1DYaK9DEbzcwh2Zdf0pwb/eVCxJSCLqDAgdma
 xwnhhVabkU2TrcwQ57GocS2t9/xh8eKN3+vGd5fpNYRyt/PKFUnbAAR3ZMdXcgw0kdkN
 4KMfZRRZFPZFL3h+I8cF5sv9BMrdpYRNIDkcCaPkZCfPqwFyTbb2wSSpEcd4olglY6m9
 hdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703042902; x=1703647702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9POoxbdNum3UVcHqKRpm9QHWYivjj/110SpNeUmOkA=;
 b=IvPfIcPg430x79eJJnkBhjByNC+IAZnPs0NwAKzyCutKVlIboqWZSeu0NJa6101FsR
 7yyj1LWs2mBMiZchwO8LHZZLoWnLldFDLOgeXw1PJDuBJDUF4zJNCHdDpm6bPZQuL8VC
 M6FtYra8I171gYMA7K/ahe4I2tSeFIDunvrcuZX6EOvqi+NUjlQuy2yR/oJVZGe6uS7F
 kE2CZs2W+dmdpTCTWU3P7mOPeqtKlbir9WWuk55GOoLUUbgV/GByR3WsxYn6V9hrN14y
 mEKTokx/ButHawYQd57qMqr468LlDLl/qUxXU1ZbAeJrJ9cKt7tflkA2WDG7T+d+iqfn
 qX+g==
X-Gm-Message-State: AOJu0Yx1dL92Sdph2s0D3J5ZimersOnl4hEDbnYaa8TjjvOlQnseX4hR
 PV/v/cxNB8LBIvpLVPndAprvNEbGuFwgoTx3vqBjIILK
X-Google-Smtp-Source: AGHT+IEePuYmZLehmROlU5HnWN74KQqvOsRUHfYU7b7m+KYIHIwiAoxXQeQqIpcVQVMc0XTFAKATuyiGPoVnQdmKqAk=
X-Received: by 2002:a5d:50c7:0:b0:336:7050:a4d1 with SMTP id
 f7-20020a5d50c7000000b003367050a4d1mr965616wrt.194.1703042901602; Tue, 19 Dec
 2023 19:28:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
In-Reply-To: <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 19:28:10 -0800
Message-ID: <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Vernet <void@manifault.com>,
 bpf@ietf.org, bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/VSD0nq_BBulbAm0zPba8NIeO4pU>
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

T24gVHVlLCBEZWMgMTksIDIwMjMgYXQgMTA6MTDigK9BTSA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFp
bC5jb20+IHdyb3RlOgo+Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gRnJvbTog
QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPgo+ID4gU2Vu
dDogTW9uZGF5LCBEZWNlbWJlciAxOCwgMjAyMyA1OjE1IFBNCj4gPiBUbzogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPgo+ID4gQ2M6IERhdmlkIFZlcm5ldCA8dm9pZEBtYW5p
ZmF1bHQuY29tPjsgRGF2ZSBUaGFsZXIKPiA+IDxkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbT47
IGJwZkBpZXRmLm9yZzsgYnBmIDxicGZAdmdlci5rZXJuZWwub3JnPjsKPiA+IEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+Cj4gPiBTdWJqZWN0OiBSZTogW0JwZl0gQlBGIElTQSBjb25m
b3JtYW5jZSBncm91cHMKPiA+Cj4gPiBPbiBUaHUsIERlYyAxNCwgMjAyMyBhdCA5OjI54oCvUE0g
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPgo+ID4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IFdlIG5lZWQgdGhlIGNvbmNlcHQgaW4gdGhlIHNwZWMganVzdCB0byBhbGxvdyBmdXR1cmUg
ZXh0ZW5zYWJpbGl0eS4KPiA+Cj4gPiBDb21wbGV0ZWx5IGFncmVlIHRoYXQgdGhlIGNvbmNlcHQg
b2YgdGhlIGdyb3VwcyBpcyBuZWNlc3NhcnkuCj4gPgo+ID4gSSdtIGFyZ3VpbmcgdGhhdCB3aGF0
IHdhcyBwcm9wb3NlZDoKPiA+IDEuICJiYXNpYyI6IGFsbCBpbnN0cnVjdGlvbnMgbm90IGNvdmVy
ZWQgYnkgYW5vdGhlciBncm91cCBiZWxvdy4KPiA+IDIuICJhdG9taWMiOiBhbGwgQXRvbWljIG9w
ZXJhdGlvbnMuCj4gPiAzLiAiZGl2aWRlIjogYWxsIGRpdmlzaW9uIGFuZCBtb2R1bG8gb3BlcmF0
aW9ucy4KPiA+IDQuICJsZWdhY3kiOiBhbGwgbGVnYWN5IHBhY2tldCBhY2Nlc3MgaW5zdHJ1Y3Rp
b25zIChkZXByZWNhdGVkKS4KPiA+IDUuICJtYXAiOiA2NC1iaXQgaW1tZWRpYXRlIGluc3RydWN0
aW9ucyB0aGF0IGRlYWwgd2l0aCBtYXAgZmRzIG9yIG1hcAo+ID4gaW5kaWNlcy4KPiA+IDYuICJj
b2RlIjogNjQtYml0IGltbWVkaWF0ZSBpbnN0cnVjdGlvbiB0aGF0IGhhcyBhICJjb2RlIHBvaW50
ZXIiIHR5cGUuCj4gPiA3LiAiZnVuYyI6IHByb2dyYW0tbG9jYWwgZnVuY3Rpb25zLgo+ID4KPiA+
IGxvZ2ljYWxseSBtYWtlcyBzZW5zZSwgYnV0IG1pZ2h0IG5vdCB3b3JrIGZvciBIVyAoYmFzZWQg
b24gdGhlIGhpc3Rvcnkgb2YgbmZwCj4gPiBvZmZsb2FkKS4KPiA+IGltbyAiYmFzaWMiIGFuZCAi
bGVnYWN5IiB3b24ndCB3b3JrIGVpdGhlci4KPiA+IFNvIGl0J3MgYSBsZXNzZXIgZXZpbC4KPiA+
Cj4gPiBBbnl3YXksIGxldCdzIGxvb2sgYXQ6Cj4gPgo+ID4gICAgfCBCUEZfQ0FMTCB8IDB4OCAg
IHwgMHgwIHwgY2FsbCBoZWxwZXIgICAgICAgICB8IHNlZSBIZWxwZXIgICAgICAgIHwKPiA+ICAg
IHwgICAgICAgICAgfCAgICAgICB8ICAgICB8IGZ1bmN0aW9uIGJ5IGFkZHJlc3MgfCBmdW5jdGlv
bnMgICAgICAgICB8Cj4gPiAgICB8ICAgICAgICAgIHwgICAgICAgfCAgICAgfCAgICAgICAgICAg
ICAgICAgICAgIHwgKFNlY3Rpb24gMy4zLjEpICAgfAo+ID4gICAgKy0tLS0tLS0tLS0rLS0tLS0t
LSstLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiA+ICAg
IHwgQlBGX0NBTEwgfCAweDggICB8IDB4MSB8IGNhbGwgUEMgKz0gaW1tICAgICAgfCBzZWUgUHJv
Z3JhbS1sb2NhbCB8Cj4gPiAgICB8ICAgICAgICAgIHwgICAgICAgfCAgICAgfCAgICAgICAgICAg
ICAgICAgICAgIHwgZnVuY3Rpb25zICAgICAgICAgfAo+ID4gICAgfCAgICAgICAgICB8ICAgICAg
IHwgICAgIHwgICAgICAgICAgICAgICAgICAgICB8IChTZWN0aW9uIDMuMy4yKSAgIHwKPiA+ICAg
ICstLS0tLS0tLS0tKy0tLS0tLS0rLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tLS0tLS0rCj4gPiAgICB8IEJQRl9DQUxMIHwgMHg4ICAgfCAweDIgfCBjYWxsIGhlbHBl
ciAgICAgICAgIHwgc2VlIEhlbHBlciAgICAgICAgfAo+ID4gICAgfCAgICAgICAgICB8ICAgICAg
IHwgICAgIHwgZnVuY3Rpb24gYnkgQlRGIElEICB8IGZ1bmN0aW9ucyAgICAgICAgIHwKPiA+ICAg
IHwgICAgICAgICAgfCAgICAgICB8ICAgICB8ICAgICAgICAgICAgICAgICAgICAgfCAoU2VjdGlv
biAzLjMuCj4gPgo+ID4gSGF2aW5nIHNlcGFyYXRlIGNhdGVnb3J5IDcgZm9yIHNpbmdsZSBpbnNu
IEJQRl9DQUxMIDB4OCAweDEgd2hpbGUga2VlcGluZyAweDgKPiA+IDB4MCBhbmQgMHg4IDB4MiBp
biAiYmFzaWMiIHNlZW1zIGp1c3QgYXMgbG9naWNhbCBhcyBoYXZpbmcgYXRvbWljX2FkZCBpbnNu
IGluCj4gPiAiYmFzaWMiIGluc3RlYWQgb2YgImF0b21pYyIuCj4KPiBJZiBhIHBsYXRmb3JtIGV4
cG9zZXMgbm8gaGVscGVyIGZ1bmN0aW9ucywgdGhlbiAweDggMHgwIGFuZCAweDggMHgyIGhhdmUg
bm8KPiBtZWFuaW5nIGFuZCBpbiBteSB2aWV3IGRvbid0IG5lZWQgYSBzZXBhcmF0ZSBjb25mb3Jt
YW5jZSBncm91cCBzaW5jZSBhCj4gcHJvZ3JhbSB1c2luZyB0aGVtIHdvdWxkIGZhaWwgdGhlIHZl
cmlmaWVyIGFueXdheS4KClJpZ2h0LCBidXQgYnJpbmdpbmcgdGhlIHZlcmlmaWVyIGludG8gdGhl
ICJjb21wbGlhbmNlIHBpY3R1cmUiCm1ha2VzIHRoZSBJU0Egc3RhbmRhcmQgaW5jb21wbGV0ZS4K
U2FtZSBjYW4gYmUgc2FpZCBhYm91dCBuZnAgY29tcGxpYW5jZS4gSXQncyBjb21wbGlhbnQgd2l0
aCBhbiBJU0EsCmJ1dCB0aGUgdmVyaWZpZXIgd2lsbCByZWplY3QgdGhpbmdzIGl0IGRvZXNuJ3Qg
c3VwcG9ydC4KVGhlIGluc3RydWN0aW9uIGdyb3VwcyBuZWVkIHRvIGJlIGJpbmFyeSBmcm9tIGNv
bXBsaWFuY2UgcG92CndpdGhvdXQgZXh0ZXJuYWwgaW5wdXQuCgpJIHRoaW5rIGlmIHdlIG1vdmUg
b25lIGNhbGwgOCAxIGludG8gYSBzZXBhcmF0ZSBncm91cCB3ZQpiZXR0ZXIgbW92ZSBhbGwgY2Fs
bCBmbGF2b3JzIGludG8gdGhlIHNhbWUgZ3JvdXAgb3IgaGF2ZSAzIGdyb3Vwcwpmb3IgMyBkaWZm
ZXJlbnQgZmxhdm9ycyBvZiBjYWxscy4KCj4gMHg4IDB4MSBvbiB0aGUgb3RoZXIgaGFuZCB3b3Vs
ZG4ndCBiZSBpbnZhbGlkIGp1c3QgZHVlIHRvIHRoZSBpbW0gdmFsdWUsCj4gYW5kIHNvIHRvb2xz
IChjb21waWxlciwgdmVyaWZpZXIsIHdoYXRldmVyKSBuZWVkIHNvbWUgb3RoZXIgd2F5IHRvIGtu
b3cgd2hldGhlcgo+IGl0J3Mgc3VwcG9ydGVkLCBoZW5jZSB0aGUgY29uZm9ybWFuY2UgZ3JvdXAu
Cj4KPiA+IFRoZW4gd2UgaGF2ZSBzZXZlcmFsIGtpbmRzIG9mIGxkX2ltbTY0LiBTb3VuZHMgbGlr
ZSB0aGUgaWRlYSBpcyB0byBzcGxpdCAweDE4Cj4gPiAweDQgaW50byAiY29kZSIgYW5kIHRoZSBy
ZXN0IGludG8gIm1hcCIgZ3JvdXA/Cj4gPiBJcyBpdCBsb2dpY2FsIG9yIG5vdD8KPgo+IEkgZG9u
J3Qga25vdyBvZiBhbm90aGVyIGVhc3kgd2F5IGZvciBhIHRvb2wgbGlrZSBhIGNvbXBpbGVyIChM
TFZNLCBnY2MsIHJ1c3QgY29tcGlsZXIsCj4gZXRjLikgdG8ga25vdyB3aGV0aGVyIG1hcCBpbnN0
cnVjdGlvbnMgYXJlIGxlZ2FsIG9yIG5vdC4KPgo+IFRoYXQgc2FpZCwgSSB0aGluayBtYXBfdmFs
KCkgaXMgcHJvYmxlbWF0aWMgZm9yIGEgY3Jvc3MtcGxhdGZvcm0gY29tcGlsZXIuLi4KPiBodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL0RvY3VtZW50YXRpb24v
YnBmL2xpbnV4LW5vdGVzLnJzdCBzYXlzCj4gIkxpbnV4IG9ubHkgc3VwcG9ydHMgdGhlICdtYXBf
dmFsKG1hcCknIG9wZXJhdGlvbiBvbiBhcnJheSBtYXBzIHdpdGggYSBzaW5nbGUgZWxlbWVudC4i
Cj4gTm93IGlmIG9uZSBwbGF0Zm9ybSBzdXBwb3J0cyBpdCBvbiBvbmUgdHlwZSBvZiBtYXAgYW5k
IGFub3RoZXIgcGxhdGZvcm0gZG9lc24ndCwgdGhlbgo+IHRoZSBjb21waWxlciBoYXMgdG8gbWFn
aWNhbGx5IGtub3cgd2hldGhlciB0byBhbGxvdyB0aGlzIG9wdGltaXphdGlvbiAoY29tcGFyZWQg
dG8KPiByZXF1aXJpbmcgdXNpbmcgYSBoZWxwZXIgZnVuY3Rpb24gdG8gYWNjZXNzIHRoZSBtYXAg
dmFsdWUpIG9yIG5vdC4KCkNvbXBpbGVyIGhhcyBubyBpZGVhLgpBbGwgbGRfaW1tNjQgYW5kIGNh
bGwgaW5zbnMgbG9vayB0aGUgc2FtZS4gVGhlIGNvbXBpbGVyIGVtaXRzCnRoZW0gdGhlIHNhbWUg
d2F5LgpUaGUgc3JjX3JlZyBlbmNvZGluZyBpcyB3aGF0IGxpYmJwZiBkb2VzIGJhc2VkIG9uIGNv
bXBpbGVyIHJlbG9jYXRpb25zLgoKVGhlbiB0aGUgdmVyaWZpZXIgY2hlY2tzIHRoZW0gZGlmZmVy
ZW50bHkgYW5kIGxhdGVyIEpJVCBzZWVzCl9hbGxfIGxkX2ltbTY0IGFzIG9uZSB0eXBlIG9mIGlu
c3RydWN0aW9uLgpTYW1lIHdpdGggY2FsbCBpbnNuLiBUbyB4ODYvYXJtNjQvcmlzY3YgSklUcyB0
aGVyZSBpcyBvbmx5IG9uZSBCUEYgQ0FMTCBpbnNuLgoKPgo+ID4gTWF5YmUgd2Ugc2hvdWxkIGRv
IHJpc2MtdiBsaWtlIGdyb3VwIGluc3RlYWQ/Cj4gPiBKdXN0IHRoZXNlIDQ6Cj4gPiAtIEJhc2Ug
SW50ZWdlciBJbnN0cnVjdGlvbiBTZXQsIDMyLWJpdAo+ID4gLSBCYXNlIEludGVnZXIgSW5zdHJ1
Y3Rpb24gU2V0LCA2NC1iaXQKPgo+IElmIHRoZXJlJ3MgcGxhdGZvcm1zIHRoYXQgd291bGQgc3Vw
cG9ydCBvbmUgb2YgdGhlIGFib3ZlIGFuZCBub3QgdGhlIG90aGVyCj4gKGFyZSB0aGVyZT8pIHRo
ZW4gSSBhZ3JlZSBzcGxpdHRpbmcgdGhlbSB3b3VsZCBtYWtlIHNlbnNlLgoKbmZwIGlzIGFuIGV4
YW1wbGUuIEl0IGtpbmRhIHNvcnRhIHN1cHBvcnRzIDY0LWJpdCwgYnV0IHZlcnkgbXVjaApwcmVm
ZXJzIDMyLgpBbGwgMzItYml0IGFyY2hpdGVjdHVyZXMgaXMgYW5vdGhlciBleGFtcGxlLgpUaGV5
IEpJVCBuaWNlbHkgYWxsIDMyLWJpdCBvcHMgYW5kIHN0cnVnZ2xlIHdpdGggNjQuCgotLSAKQnBm
IG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9icGYK

