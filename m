Return-Path: <bpf+bounces-20748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B4842903
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99991C2592C
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD086AF7;
	Tue, 30 Jan 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZQOdO44f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZQOdO44f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkXeAOv9"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACB86AEC
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631750; cv=none; b=qq4EaTThJmTTy36mXmx7dUj/p/AaoHEfCZNKhpIAq175AqG4XnwNXhnGS2NpQoqz/JHmZlXDzQyrwqZWmOX4TmJ0FESMLH7qJPcC9Lo5OTKzxEi0hAm9uSPWS4xHHxTe2CI7rkcKsC+r65FNsvMoDxFW2EZgqybAbB6kXRsd5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631750; c=relaxed/simple;
	bh=O6zHrC0swHElAc+jFjVxh7Bfk3Kpoqj7dnwfAjVf5Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=cp3Bn8AKc1daI2zKXNTD5/u8arbW+n3lcySw79yEBDPEFaFmCBMDarQhRQzxLo9zHUt4RjW00hz7NOxt/QRntRFMZNOYTlCiDWrNcAcY+WWyCMDprGRt+p1xS/MDD58ijo5kwpcgxULysyfHlresRZ13gnHadhNabkndFVMqGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ZQOdO44f; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ZQOdO44f; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkXeAOv9 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A6753C1CAF70
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706631748; bh=O6zHrC0swHElAc+jFjVxh7Bfk3Kpoqj7dnwfAjVf5Mg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ZQOdO44f8liPMt3AQSLKaVXBXklXZlV7hbBBYeCDzMKBjIxAVAwvTnCYJgG88/Zse
	 7SX2Aj+NYI7CRBeTn0GFon2QgppSIm9+dVKWxadxrXyHl+TjXgCyFfpikBVvtiA9Vj
	 tGOxjqMoudTs2YSF2r9kfW8ap3bfugsRAzENF0EU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 30 08:22:28 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7BBF0C19ECBC;
	Tue, 30 Jan 2024 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706631748; bh=O6zHrC0swHElAc+jFjVxh7Bfk3Kpoqj7dnwfAjVf5Mg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ZQOdO44f8liPMt3AQSLKaVXBXklXZlV7hbBBYeCDzMKBjIxAVAwvTnCYJgG88/Zse
	 7SX2Aj+NYI7CRBeTn0GFon2QgppSIm9+dVKWxadxrXyHl+TjXgCyFfpikBVvtiA9Vj
	 tGOxjqMoudTs2YSF2r9kfW8ap3bfugsRAzENF0EU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5402CC18DB86
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 08:22:27 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mKWo-RGtZkxN for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 08:22:25 -0800 (PST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 5E6E0C18DBBF
 for <bpf@ietf.org>; Tue, 30 Jan 2024 08:22:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ef6f10b56so17542495e9.2
 for <bpf@ietf.org>; Tue, 30 Jan 2024 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706631737; x=1707236537; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sG4mQLc6f/8+mAWJSd6JdKnldDAb2P3Pm18yHZMJ52s=;
 b=EkXeAOv9kx1CCqnTE6b7YzvgYC5RQDO9v443fFe7K7bkj38qfhvmpHWtOd23zp9MG+
 GwUISqwAI3nM7GoiYhHDOisQ7IZcL2TK5Qt5+EMM1Z3pp1ffzeFiTcnYgECge6MLHbng
 zsGceMYVBAbgTyYnIulzmXy1h9IENMDG63EehFQ+eZxepPcHs+WF4xdj4vCGCkB27rSn
 Ji7ToQRF2Re3nfY//TsHCvKmcs424KDdGst4i7k+oqzdeFx6Gk/r1+Vdz9wtyw9NrXo1
 IU3/ZrjJWAxZAYt1ULOX35kuTNJFZxoaPCZc1dmVZ5mSlcpQh/XoUU7h9Yp0DlsLh4xw
 xDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706631737; x=1707236537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sG4mQLc6f/8+mAWJSd6JdKnldDAb2P3Pm18yHZMJ52s=;
 b=UX8hKHwGFlvMIwGVHh8X90ZfEj9UfhsFUSP381oD+m02jLFAOjbtDOu6yNrmq/HoXE
 4et6pW3JU9fvoikXZcv8ru9bb0NokuyGoxGGxBW7YHpQXedWsqiSYaa2qTYImTNcY0o0
 4mYtiKv2tCvCFQ0qJUotpUKRopxMumMWBjzW42eSooYtF6qfTka8YsrhD4jRWG5m23zG
 EZoG6nB0aJF8E4nrQHC3770OaxkfCLnufKPHy455Kp6mmdl0qAYoCh3BcDQBEs/WmIcC
 1naU9Dvwe5N8+b8doweUxhnOAc3TBakvo1gCl3L/bMCUByhmvOVz+JSEWHMRct7sOzjr
 Il5g==
X-Gm-Message-State: AOJu0YxkfH5OuS+isVCJZa/DGCjwZlYH79q8O0NA9pFgcI47HnlIrOAV
 gJXidG5d+xx+Ef3g+sXChQzn05uyCg2XYChXDUyLU8Eq8zNdqt6QUWshBSVDb2q1+xiESIG7jZ0
 aKjPCOndqiYPo47hy23YCftBmgC8=
X-Google-Smtp-Source: AGHT+IHycfZPEd6USAxYZ097JGFwdRiwjKnglAJOx/HGYPK+RkiSm1Z6adzuYl/HPM/IallhUtQu7Gm1oBn8nTyqtCU=
X-Received: by 2002:a05:600c:3547:b0:40e:f681:b7b6 with SMTP id
 i7-20020a05600c354700b0040ef681b7b6mr4741737wmq.37.1706631736878; Tue, 30 Jan
 2024 08:22:16 -0800 (PST)
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
In-Reply-To: <071b01da5394$260dba30$72292e90$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Jan 2024 08:22:05 -0800
Message-ID: <CAADnVQJ7Phg_89MCVNtjh1EJTxEk5S++rFhpcnukMvn6sL351A@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, 
 bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/nFuc5PWebfKXkP0vI8LaGIsd690>
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

T24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgNzo1MeKAr0FNIDxkdGhhbGVyMTk2OEBnb29nbGVtYWls
LmNvbT4gd3JvdGU6Cj4KPiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBn
bWFpbC5jb20+IHdyb3RlOgo+IFsuLi5dCj4gPiA+IEFsdGhvdWdoIHRoZSBMaW51eCB2ZXJpZmll
ciBkb2Vzbid0IHN1cHBvcnQgdGhlbSwgdGhlIGZhY3QgdGhhdCBnY2MKPiA+ID4gZG9lcyBzdXBw
b3J0IHRoZW0gdGVsbHMgbWUgdGhhdCBpdCdzIHByb2JhYmx5IHNhZmVzdCB0byBsaXN0IHRoZSBE
Vwo+ID4gPiBhbmQgTERYIHZhcmlhbnRzIGFzIGRlcHJlY2F0ZWQgYXMgd2VsbCwgd2hpY2ggaXMg
d2hhdCB0aGUgZHJhZnQKPiA+ID4gYWxyZWFkeSBkaWQgaW4gdGhlIGFwcGVuZGl4IHNvIHRoYXQn
cyBnb29kIChub3RoaW5nIHRvIGNoYW5nZSB0aGVyZSwgSQo+ID4gPiB0aGluaykuCj4gPgo+ID4g
RFcgbmV2ZXIgZXhpc3RlZCBpbiBjbGFzc2ljIGJwZiwgc28gYWJzL2luZCBuZXZlciBoYWQgRFcg
Zmxhdm9yLgo+ID4gSWYgc29tZSBhc3NlbWJsZXIvY29tcGlsZXIgZGVjaWRlZCB0byAic3VwcG9y
dCIgdGhlbSBpdCdzIG9uIHRoZW0uCj4gPiBUaGUgc3RhbmRhcmQgbXVzdCBub3QgbGlzdCBzdWNo
IHRoaW5ncyBhcyBkZXByZWNhdGVkLiBUaGV5IG5ldmVyIGV4aXN0ZWQuIFNvCj4gPiBub3RoaW5n
IGlzIGRlcHJlY2F0ZWQuCj4KPiBBY2ssIEkgd2lsbCByZW1vdmUgdGhlIEFCUy9JTkQgKyBEVyBs
aW5lcyBmcm9tIHRoZSBhcHBlbmRpeC4KPgo+ID4gU2FtZSB3aXRoIE1TSC4gQlBGX0xEWCB8IEJQ
Rl9NU0ggfCBCUEZfQiBpcyB0aGUgb25seSBpbnNuIGV2ZXIgZXhpc3RlZC4KPiA+IEl0J3MgYSBs
ZWdhY3kgaW5zbi4gSnVzdCBsaWtlIGFicy9pbmQuCj4KPiBTaG91bGQgaXQgYmUgbGlzdGVkIGlu
IHRoZSBsZWdhY3kgY29uZm9ybWFuY2UgZ3JvdXAgdGhlbj8KPgo+IEN1cnJlbnRseSBpdCdzIG5v
dCBtZW50aW9uZWQgaW4gaW5zdHJ1Y3Rpb24tc2V0LnJzdCBhdCBhbGwsIHNvIHRoZSBvcGNvZGUK
PiBpcyBhdmFpbGFibGUgdG8gdXNlIGJ5IGFueSBuZXcgaW5zdHJ1Y3Rpb24uICBJZiB3ZSBkbyBs
aXN0IGl0IGluIGluc3RydWN0aW9uLXNldC5yc3QKPiB0aGVuLCBsaWtlIGFicy9pbmQsIGl0IHdp
bGwgYmUgYXZvaWRlZCBieSBhbnlvbmUgcHJvcG9zaW5nIG5ldyBpbnN0cnVjdGlvbnMuCgpZZWFo
LiBUaGUgc3RhbmRhcmQgbmVlZHMgdG8gbWVudGlvbiBpdCBhcyBsZWdhY3kgaW5zbi4KSXQncyBz
dWNoIGEgd2VpcmQgdWx0cmEgc3BlY2lhbGl6ZWQgaW5zbiBpbnRyb2R1Y2VkIGZvciBvbmUgc3Bl
Y2lmaWMKcHVycG9zZSBwYXJzaW5nIElQIGhlYWRlci4gdGNwZHVtcCBvbmx5LiBFZmZlY3RpdmVs
eS4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

