Return-Path: <bpf+bounces-21944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0824385419B
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B71C28E81
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3C4C9F;
	Wed, 14 Feb 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aq7Kmy0v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="aq7Kmy0v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myoTq2R9"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03AEBE6D
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878770; cv=none; b=nR+EXkxZStw1hsW1T2YxnmAkebe7j0fhZ/R+Ct9SiOdEXTsBZLPLxz+ISct62HD0fH/oAFDbVLRG1V0IPN1SKF8YeHz4zRfSD9DkDrGq0XQ0IA9o13hReiw5V3KaLqiXDtvXPxPgkTfNhRGcjAEX/QLor3l6IUSvqUVW7hWoHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878770; c=relaxed/simple;
	bh=SvwPUEt7V3Wphbc8ouW6ZaX8a5FMDZvK3Zz9WEjwkjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=qHD0OO/Id9Wvsuqt6DRyebVEOkSRIrRxrqaaWm59ENy5pGDw+u1NZ8xsi/7PbDaHJ8HjUdIlT2YugLCToyQOHEWH8c4jqPpZYsDL+XXNnDL63FSD5u9Cr2gRSd0vMza1Nh5dEM2uFX0D7zirgSbNbaMN3TLlH0Bvtx6cT+XmHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aq7Kmy0v; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=aq7Kmy0v; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myoTq2R9 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 92F31C1519A5
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707878761; bh=SvwPUEt7V3Wphbc8ouW6ZaX8a5FMDZvK3Zz9WEjwkjw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=aq7Kmy0vsWL1/9pIDFnrbEcol6VWUV5XV8lZkUN2LYkznopSBZVOOMhfIb+/kbt+t
	 FEO0+9EppNSdHECR51b1mlV6l9QR0VPxi1/NRAJ6URJDtIlxclFZRHr0XomD8o6QwS
	 UBbI21wTjWSsUnxv86V0geGc0lzUdVflkFFqFd+E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Feb 13 18:46:01 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 65497C14F5FD;
	Tue, 13 Feb 2024 18:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707878761; bh=SvwPUEt7V3Wphbc8ouW6ZaX8a5FMDZvK3Zz9WEjwkjw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=aq7Kmy0vsWL1/9pIDFnrbEcol6VWUV5XV8lZkUN2LYkznopSBZVOOMhfIb+/kbt+t
	 FEO0+9EppNSdHECR51b1mlV6l9QR0VPxi1/NRAJ6URJDtIlxclFZRHr0XomD8o6QwS
	 UBbI21wTjWSsUnxv86V0geGc0lzUdVflkFFqFd+E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0D5CEC14F5FD
 for <bpf@ietfa.amsl.com>; Tue, 13 Feb 2024 18:46:00 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nqrpMHO1BP9H for <bpf@ietfa.amsl.com>;
 Tue, 13 Feb 2024 18:45:59 -0800 (PST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7E856C14F5E8
 for <bpf@ietf.org>; Tue, 13 Feb 2024 18:45:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso165182f8f.0
 for <bpf@ietf.org>; Tue, 13 Feb 2024 18:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707878752; x=1708483552; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEluJz/8cGGKVFyjzYVeh7y3m5ULmKhtpErc8O50rz4=;
 b=myoTq2R9FwKvdc561cPbqIYHDJGlgABoVrGLRwhdDiD1DLVu9blNfrEgd50iW/1agx
 gTLp6lJYr1hjKd8L8QPbtTDAs2DqussqOYCiAbxXZzlbem/Yg9L9kLaKfRn4DetFW5nB
 bO1VD+jHRKYqCYIox49/7QSZrq0pmDnjWmPnfoUgaeHAWRNELi+Q0ggXsLQpZu/aUVfs
 NWj4JDY31nNLTS0LnO5TRsOJ7NnR7mt/9DdmeLyuLyYyGemjVEftH49UEl4BlFM6OuM8
 NPPCDhqPxHlOAwjpYVHL53JBNhmML4I2VNzPa3YSiAh+fAelYwgWRmcLOK7GisDOQrFv
 /RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707878752; x=1708483552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEluJz/8cGGKVFyjzYVeh7y3m5ULmKhtpErc8O50rz4=;
 b=fHdLNM80WQCbK/L2BdZHbnjrtpanJ6F5ho7FpyPDLZv8u0uVhkphyKaloAypCbzlta
 tDDXbkbFALkQiwxslDoUJBKdE1uJjUfz4Md59IIaqgu+zRukemfr18khLKBEVn4MKB6s
 7Pjn689s+JJOWw3f3mBl87NRBr3x+mvugE8qz4oucfeeVQ4v1A3Egt67DQgGK9/1hAFY
 D3myWtjJDigpAQgC6VteiGeYBj5vMKEEsQITyjqSUn/YEukQ6TS2dpPg6EK+go1r6hyE
 tpp5fusVyf2Y9LNfkMr02OxL6sBwGnEyfeiP2V/1zqTN+EabT8pgy9GeGSNHXn+ix7DK
 si9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbZGV+XB3a9t5X54yheu7TJqssIB9JwUbK0jO47T9jHtobTCd6jSHfA5fGajhb5OJmAvuN1sLcTsA9eMU=
X-Gm-Message-State: AOJu0Yzz1uKA0v3bnXECEJ/fOGCOsQNuAtFFMzgu4OpjUUIsJSVHKTFB
 io/bi0XTL650GgScP47AeuzOiuhTwjwyOoQu2l8BODnNBd+O14aenIfKMRZUjUvZO7vSqjam/lA
 /zf6WayJD8ZUod79di7/ET6BUerU=
X-Google-Smtp-Source: AGHT+IFtYnr6wIkD9xJta5yh9L78D2fPgCMgkIJXFHnj1cAZt31ldtE3+ToaNAy1cnD0sw9Tr/4VGsC4WeT7Kebobc4=
X-Received: by 2002:a5d:522d:0:b0:33a:f503:30b3 with SMTP id
 i13-20020a5d522d000000b0033af50330b3mr452513wra.24.1707878752045; Tue, 13 Feb
 2024 18:45:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213175141.10347-1-dthaler1968@gmail.com>
In-Reply-To: <20240213175141.10347-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 18:45:40 -0800
Message-ID: <CAADnVQLffY3C-qmuiQj=beiFM1Q0UAeVtKmc=e=8SO6t6H+9jA@mail.gmail.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org,
 Dave Thaler <dthaler1968@gmail.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/EKOpFHyT97frNlPL_X6JoYsJ-aQ>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf,
 docs: Add callx instructions in new conformance group
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

T24gVHVlLCBGZWIgMTMsIDIwMjQgYXQgOTo1MeKAr0FNIERhdmUgVGhhbGVyCjxkdGhhbGVyMTk2
OD00MGdvb2dsZW1haWwuY29tQGRtYXJjLmlldGYub3JnPiB3cm90ZToKPgo+ICogQWRkIGEgImNh
bGx4IiBjb25mb3JtYW5jZSBncm91cAo+ICogQWRkIGNhbGx4IHJvd3MgdG8gdGFibGUKPiAqIFVw
ZGF0ZSBoZWxwZXIgZnVuY3Rpb24gdG8gc2VjdGlvbiB0byBiZSBhZ25vc3RpYyBiZXR3ZWVuIEJQ
Rl9LIHZzCj4gICBCUEZfWAo+ICogUmVuYW1lICJsZWdhY3kiIGNvbmZvcm1hbmNlIGdyb3VwIHRv
ICJwYWNrZXQiCj4KPiBCYXNlZCBvbiBtYWlsaW5nIGxpc3QgZGlzY3Vzc2lvbiBhdAo+IGh0dHBz
Oi8vbWFpbGFyY2hpdmUuaWV0Zi5vcmcvYXJjaC9tc2cvYnBmL2w1dE5FZ0wtV283cVNFdWFHc3NP
bDVWQ2hLay8KPgo+IHYxLT52MjogSW5jb3Jwb3JhdGVkIGZlZWRiYWNrIGZyb20gV2lsbCBIYXdr
aW5zCj4KPiB2Mi0+djM6IFVzZSAiZHN0IiBub3QgImltbSIgZmllbGQKPgo+IFNpZ25lZC1vZmYt
Ynk6IERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2OEBnbWFpbC5jb20+Cj4gLS0tCj4gIC4uLi9icGYv
c3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgICB8IDMxICsrKysrKysrKysrKy0t
LS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0
cnVjdGlvbi1zZXQucnN0IGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3Ry
dWN0aW9uLXNldC5yc3QKPiBpbmRleCBiZGZlMGNkMGUuLjRiYmE2NTZiNiAxMDA2NDQKPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+
ICsrKyBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQu
cnN0Cj4gQEAgLTEyNyw3ICsxMjcsNyBAQCBUaGlzIGRvY3VtZW50IGRlZmluZXMgdGhlIGZvbGxv
d2luZyBjb25mb3JtYW5jZSBncm91cHM6Cj4gICogZGl2bXVsMzI6IGluY2x1ZGVzIDMyLWJpdCBk
aXZpc2lvbiwgbXVsdGlwbGljYXRpb24sIGFuZCBtb2R1bG8gaW5zdHJ1Y3Rpb25zLgo+ICAqIGRp
dm11bDY0OiBpbmNsdWRlcyBkaXZtdWwzMiwgcGx1cyA2NC1iaXQgZGl2aXNpb24sIG11bHRpcGxp
Y2F0aW9uLAo+ICAgIGFuZCBtb2R1bG8gaW5zdHJ1Y3Rpb25zLgo+IC0qIGxlZ2FjeTogZGVwcmVj
YXRlZCBwYWNrZXQgYWNjZXNzIGluc3RydWN0aW9ucy4KPiArKiBwYWNrZXQ6IGRlcHJlY2F0ZWQg
cGFja2V0IGFjY2VzcyBpbnN0cnVjdGlvbnMuCj4KPiAgSW5zdHJ1Y3Rpb24gZW5jb2RpbmcKPiAg
PT09PT09PT09PT09PT09PT09PT0KPiBAQCAtNDA0LDkgKzQwNCwxMiBAQCBCUEZfSlNFVCAgMHg0
ICAgIGFueSAgUEMgKz0gb2Zmc2V0IGlmIGRzdCAmIHNyYwo+ICBCUEZfSk5FICAgMHg1ICAgIGFu
eSAgUEMgKz0gb2Zmc2V0IGlmIGRzdCAhPSBzcmMKPiAgQlBGX0pTR1QgIDB4NiAgICBhbnkgIFBD
ICs9IG9mZnNldCBpZiBkc3QgPiBzcmMgICAgICAgIHNpZ25lZAo+ICBCUEZfSlNHRSAgMHg3ICAg
IGFueSAgUEMgKz0gb2Zmc2V0IGlmIGRzdCA+PSBzcmMgICAgICAgc2lnbmVkCj4gLUJQRl9DQUxM
ICAweDggICAgMHgwICBjYWxsIGhlbHBlciBmdW5jdGlvbiBieSBhZGRyZXNzICBCUEZfSk1QIHwg
QlBGX0sgb25seSwgc2VlIGBIZWxwZXIgZnVuY3Rpb25zYF8KPiArQlBGX0NBTEwgIDB4OCAgICAw
eDAgIGNhbGxfYnlfYWRkcmVzcyhpbW0pICAgICAgICAgICAgIEJQRl9KTVAgfCBCUEZfSyBvbmx5
Cj4gK0JQRl9DQUxMICAweDggICAgMHgwICBjYWxsX2J5X2FkZHJlc3MoZHN0KSAgICAgICAgICAg
ICBCUEZfSk1QIHwgQlBGX1ggb25seQo+ICBCUEZfQ0FMTCAgMHg4ICAgIDB4MSAgY2FsbCBQQyAr
PSBpbW0gICAgICAgICAgICAgICAgICAgQlBGX0pNUCB8IEJQRl9LIG9ubHksIHNlZSBgUHJvZ3Jh
bS1sb2NhbCBmdW5jdGlvbnNgXwo+IC1CUEZfQ0FMTCAgMHg4ICAgIDB4MiAgY2FsbCBoZWxwZXIg
ZnVuY3Rpb24gYnkgQlRGIElEICAgQlBGX0pNUCB8IEJQRl9LIG9ubHksIHNlZSBgSGVscGVyIGZ1
bmN0aW9uc2BfCj4gK0JQRl9DQUxMICAweDggICAgMHgxICBjYWxsIFBDICs9IGRzdCAgICAgICAg
ICAgICAgICAgICBCUEZfSk1QIHwgQlBGX1ggb25seSwgc2VlIGBQcm9ncmFtLWxvY2FsIGZ1bmN0
aW9uc2BfCj4gK0JQRl9DQUxMICAweDggICAgMHgyICBjYWxsX2J5X2J0ZmlkKGltbSkgICAgICAg
ICAgICAgICBCUEZfSk1QIHwgQlBGX0sgb25seQo+ICtCUEZfQ0FMTCAgMHg4ICAgIDB4MiAgY2Fs
bF9ieV9idGZpZChkc3QpICAgICAgICAgICAgICAgQlBGX0pNUCB8IEJQRl9YIG9ubHkKClNvcnJ5
LCBidXQgdGhpcyB0YWtlcyBpdCB0b28gZmFyLgpUaGlzIGlzIHdheSB0b28gZWFybHkgdG8gZGVm
aW5lIGV4YWN0bHkgd2hhdCBjYWxseCB3aWxsIGRvLgpFc3BlY2lhbGx5IHdpdGggYWxsIHRoZSBm
bGF2b3JzLgpnY2MvbGx2bSBnZW5lcmF0ZSBjYWxseCB3aGVuIGl0J3MgYW4gaW5kaXJlY3QgY2Fs
bC4KUEMgKz0gZHN0IGFuZCBvdGhlciBjb21iaW5hdGlvbnMgZG9uJ3QgbWF0Y2ggdG8gd2hhdCBy
ZWFsIENQVSB3b3VsZCBkby4KCmxldCdzIHJlc2VydmUgY2FsbHggQlBGX0NBTEx8QlBGX1ggd2l0
aCBhbnkgc3JjX3JlZyBhbmQgaW1tIGFzIHJlc2VydmVkCndpdGhvdXQgZGVmaW5pbmcgd2hhdCBp
dCBkb2VzLgoKcHctYm90OiBjcgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0
dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

