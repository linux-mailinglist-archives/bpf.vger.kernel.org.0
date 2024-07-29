Return-Path: <bpf+bounces-35946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569493FFF6
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB371F226CE
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841518A934;
	Mon, 29 Jul 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="mMhBqfhD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="mMhBqfhD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHN5mDtk"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7F7F484
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286714; cv=none; b=jsvZs3JLI4oK2b/LvCXQpY7rCkMLNjj5jle9wKrB9zQKdw9sw9RpxLgsj0zf20Yf7P5ZxbOl1RbeJaVnnMM12cVigOgeKCIZavoyDwdvyr2+SGeU2INE2uXvWbPBBB4fNtD+FmiSGnqOa/KHhDO9EzreokOgk4y16Vm7OT5W1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286714; c=relaxed/simple;
	bh=jSqw57W1bxpJrVvmis+OYkjf9YHZ/pbiPMeEiLPMq1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=NrXpgxsqQkoqAl6ob3BoJfBF1smVpuBikOGgfQmyTP0eVzM07u2AJAGPh5aaB1cyNt4LjPZOKHre4y415krjUQ3tdVfWNKwDVtsLIRus6IqgaoiWJIvJ7w8EXNWoe5//gSZLUx2eFdLGhy1pmtjS6nes2Wigl63+IoFCS8OO6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=mMhBqfhD; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=mMhBqfhD; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHN5mDtk reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 66DE4C1840D3
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1722286707; bh=jSqw57W1bxpJrVvmis+OYkjf9YHZ/pbiPMeEiLPMq1o=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=mMhBqfhDJB+GU2SZkAQb1p3vLqXNXC8QI/tAAkzKBOFfaD01oVS0c1ay2VHqXGycQ
	 l378VKAb/Uo1DEUSTMkX7/12S/99RU9V3YwgwduOXGNGoESz0lBeddfuba2/uHa4IX
	 BmMTgAN9XKcFodGYobCGw6I0gtyDnTSHTyGmfT7o=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Mon Jul 29 13:58:27 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 47EF0C1840C8
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1722286707; bh=jSqw57W1bxpJrVvmis+OYkjf9YHZ/pbiPMeEiLPMq1o=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=mMhBqfhDJB+GU2SZkAQb1p3vLqXNXC8QI/tAAkzKBOFfaD01oVS0c1ay2VHqXGycQ
	 l378VKAb/Uo1DEUSTMkX7/12S/99RU9V3YwgwduOXGNGoESz0lBeddfuba2/uHa4IX
	 BmMTgAN9XKcFodGYobCGw6I0gtyDnTSHTyGmfT7o=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 44D2CC151097
	for <bpf@ietfa.amsl.com>; Mon, 29 Jul 2024 13:58:25 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 57j3R_1bXHD6 for <bpf@ietfa.amsl.com>;
	Mon, 29 Jul 2024 13:58:21 -0700 (PDT)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 769DBC14F705
	for <bpf@ietf.org>; Mon, 29 Jul 2024 13:58:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cf93dc11c6so1620250a91.1
        for <bpf@ietf.org>; Mon, 29 Jul 2024 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722286701; x=1722891501; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9uSNgkqboHdYWPSPQXHmNVFn+KcANAci377u7Br/xE=;
        b=BHN5mDtkO9au5nNvnwxmYPVh9Y8PJFtG+Yn5dtJBtX2ekdI1ZzQcnTv4WnDvk7lYq9
         E5MKkCroleQkGq0sZzQdMTaq4KpcxEwjr9cJ6LJFLJwFsC0OdCrWZ7zgmMsqjcWeMwFC
         mYYwW+MsTJVR9pWo2d/xZJj1KfmPfFtBKKWJ5eKMPw+8Xij5iAMNFp6aaLRMa199Lz4P
         UHu0UU1twi5XE3RN7JMRCSNiPX3jrHimBBu/kcRqjSqNjmzYamH9RZNXGIl8DgoAIyVq
         GNyqsKMEjBduuHGCZ+YnC3izc4ekwBDZEKqJ0/m8v0DIq7XCufDWohWJjHcM8G589kWc
         pLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286701; x=1722891501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9uSNgkqboHdYWPSPQXHmNVFn+KcANAci377u7Br/xE=;
        b=I6RnZUSOz+Zpu+Oqhlx9fJykVkNp1ug12B0CvTYjzcLxhojYHR/3YF+IVJaRqrYz5A
         ojL/8IcagfA5p33p/woaprZbS62R2P2x8fEc/mgSV4elbJP+bF5EoZM8E/yAy1DoztP9
         F8jPwigKh5eXcJ0sj+Qyroi5z4T/bk3qfDKsi5JnDaRNJ+BLCXpKvRE6FatpvKQmmLSh
         N/6kt1SKUzZa6SrTmjGtGOL9u7/cEnDxJqkvtJotfqLJVtZCESmYgGR7in5Y7YsOfi8O
         6+ggevXShbad7BpjttkADmXDMcXEi4zrXNzHX2gYPPYmCw3tjjOpRmtfhUMnWIxUOydI
         ocHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIkUhqHKOurzSky8/o58lV63QDMxCjT74PILLdMf9Hf7mUYqLATp2/YTp6jA3xHva9y2rXcNXgybdMuYg=
X-Gm-Message-State: AOJu0YxNlOJ+6uvjW0cO3T/lTZW6Sxjzob8vZbg5KKysO6vc64ImZcL5
	knAd+Am75FddVUrtRR2wUZMwIa6adjTcCtXGe5PuWZ8bCBfT0oNKXjyAcHVuprjYr40030HlcWQ
	w688R0anOcCB9KtloqT2djoK/CDg=
X-Google-Smtp-Source: 
 AGHT+IFNgxcYfmNm4/LshVlUWJcyZwD9RZ9iE+dRYmU4ESuvVF8+ld0CvY2shdTLiT1EGC9FVhAVzp/VN/pd7m1tnWQ=
X-Received: by 2002:a17:90b:fd0:b0:2cc:ff56:5be3 with SMTP id
 98e67ed59e1d1-2cf7e21687amr10067135a91.19.1722286700909; Mon, 29 Jul 2024
 13:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev>
 <CY5PR21MB3493D67300A4005628E8CB8DD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
In-Reply-To: 
 <CY5PR21MB3493D67300A4005628E8CB8DD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 13:58:09 -0700
Message-ID: 
 <CAEf4BzZvMOdL+mL9NxxesyXO-xRCwkJYqQ+GXQVBssF3_jid=w@mail.gmail.com>
To: Michael Agun <danielagun@microsoft.com>
Message-ID-Hash: GZTOSHKBYPICNS2MCNMC6AICV5CHUAUM
X-Message-ID-Hash: GZTOSHKBYPICNS2MCNMC6AICV5CHUAUM
X-MailFrom: andrii.nakryiko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Yonghong Song <yonghong.song@linux.dev>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>,
 "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BEXTERNAL=5D_Re=3A_perf=5Fevent=5Foutput_payload?=
	=?utf-8?q?_capture_flags=3F?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/TBJw-aF3-PNIqT1u2V9Rm-DMPWM>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBKdWwgMjYsIDIwMjQgYXQgNDo0NeKAr1BNIE1pY2hhZWwgQWd1biA8ZGFuaWVsYWd1
bkBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4NCj4gQ0MgRGF2ZQ0KPg0KPiBUaGFuayB5b3UuDQo+
DQo+IER1ZSB0byBNaWNyb3NvZnQgcG9saWNpZXMgd2UgYXZvaWQgcmVhZGluZyBjb2RlIHdpdGgg
c3Ryb25nIGxpY2Vuc2luZyAobGlrZSBHUEwgMi4wKS4NCg0KTGludXggVUFQSSBoZWFkZXJzIGFy
ZSBsaWNlbnNlZCBhcyBgR1BMLTIuMCBXSVRIIExpbnV4LXN5c2NhbGwtbm90ZWAsDQphbmQgc2Vl
IFswXS4gV2lsbCBjaXRlIGl0IGluIGZ1bGwgYmVsb3cuIERvZXNuJ3QgdGhpcyBtZWFuIHRoYXQg
aXQncw0KZmluZSB0byByZWFkIFVBUEkgZGVmaW5pdGlvbnM/DQoNClNQRFgtRXhjZXB0aW9uLUlk
ZW50aWZpZXI6IExpbnV4LXN5c2NhbGwtbm90ZQ0KU1BEWC1VUkw6IGh0dHBzOi8vc3BkeC5vcmcv
bGljZW5zZXMvTGludXgtc3lzY2FsbC1ub3RlLmh0bWwNClNQRFgtTGljZW5zZXM6IEdQTC0yLjAs
IEdQTC0yLjArLCBHUEwtMS4wKywgTEdQTC0yLjAsIExHUEwtMi4wKywNCkxHUEwtMi4xLCBMR1BM
LTIuMSssIEdQTC0yLjAtb25seSwgR1BMLTIuMC1vci1sYXRlcg0KVXNhZ2UtR3VpZGU6DQogIFRo
aXMgZXhjZXB0aW9uIGlzIHVzZWQgdG9nZXRoZXIgd2l0aCBvbmUgb2YgdGhlIGFib3ZlIFNQRFgt
TGljZW5zZXMNCiAgdG8gbWFyayB1c2VyIHNwYWNlIEFQSSAodWFwaSkgaGVhZGVyIGZpbGVzIHNv
IHRoZXkgY2FuIGJlIGluY2x1ZGVkDQogIGludG8gbm9uIEdQTCBjb21wbGlhbnQgdXNlciBzcGFj
ZSBhcHBsaWNhdGlvbiBjb2RlLg0KICBUbyB1c2UgdGhpcyBleGNlcHRpb24gYWRkIGl0IHdpdGgg
dGhlIGtleXdvcmQgV0lUSCB0byBvbmUgb2YgdGhlDQogIGlkZW50aWZpZXJzIGluIHRoZSBTUERY
LUxpY2Vuc2VzIHRhZzoNCiAgICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogPFNQRFgtTGljZW5z
ZT4gV0lUSCBMaW51eC1zeXNjYWxsLW5vdGUNCkxpY2Vuc2UtVGV4dDoNCg0KICAgTk9URSEgVGhp
cyBjb3B5cmlnaHQgZG9lcyAqbm90KiBjb3ZlciB1c2VyIHByb2dyYW1zIHRoYXQgdXNlIGtlcm5l
bA0KIHNlcnZpY2VzIGJ5IG5vcm1hbCBzeXN0ZW0gY2FsbHMgLSB0aGlzIGlzIG1lcmVseSBjb25z
aWRlcmVkIG5vcm1hbCB1c2UNCiBvZiB0aGUga2VybmVsLCBhbmQgZG9lcyAqbm90KiBmYWxsIHVu
ZGVyIHRoZSBoZWFkaW5nIG9mICJkZXJpdmVkIHdvcmsiLg0KIEFsc28gbm90ZSB0aGF0IHRoZSBH
UEwgYmVsb3cgaXMgY29weXJpZ2h0ZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUNCiBGb3VuZGF0aW9u
LCBidXQgdGhlIGluc3RhbmNlIG9mIGNvZGUgdGhhdCBpdCByZWZlcnMgdG8gKHRoZSBMaW51eA0K
IGtlcm5lbCkgaXMgY29weXJpZ2h0ZWQgYnkgbWUgYW5kIG90aGVycyB3aG8gYWN0dWFsbHkgd3Jv
dGUgaXQuDQoNCiBBbHNvIG5vdGUgdGhhdCB0aGUgb25seSB2YWxpZCB2ZXJzaW9uIG9mIHRoZSBH
UEwgYXMgZmFyIGFzIHRoZSBrZXJuZWwNCiBpcyBjb25jZXJuZWQgaXMgX3RoaXNfIHBhcnRpY3Vs
YXIgdmVyc2lvbiBvZiB0aGUgbGljZW5zZSAoaWUgdjIsIG5vdA0KIHYyLjIgb3IgdjMueCBvciB3
aGF0ZXZlciksIHVubGVzcyBleHBsaWNpdGx5IG90aGVyd2lzZSBzdGF0ZWQuDQoNCiAgICAgICAg
ICAgIExpbnVzIFRvcnZhbGRzDQoNCg0KICBbMF0gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRz
L2xpbnV4L2Jsb2IvbWFzdGVyL0xJQ0VOU0VTL2V4Y2VwdGlvbnMvTGludXgtc3lzY2FsbC1ub3Rl
DQoNCj4NCj4gSXMgdGhlcmUgc29tZSBvdGhlciBkb2N1bWVudGF0aW9uIG9mIHRoZSBmbGFncywg
b3IgY291bGQgeW91IGV4cGxhaW4gdGhlbSBpbiB3b3Jkcz8NCj4gT3IgaXMgdGhhdCB0aGUgY29t
cGxldGUgZmxhZ3MgZGVzY3JpcHRpb24gKHdoaWNoIGlzIGluIG90aGVyIGRvY3VtZW50YXRpb24p
IGFuZCBJIGFtIG1pc3VuZGVyc3RhbmRpbmcgdGhlIGNvZGUgYmVsb3c/DQo+DQo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9jaWxpdW0vY2lsaXVtL2Jsb2IvM2ZhNDRiNTllZWY3OTJlMjhmNzBiMWZkMjNl
M2UxN2U0MjY5MDlmNS9icGYvbGliL2RiZy5oI0wyMjkNCj4NCj4gSXQgbG9va3MgdG8gbWUgaGVy
ZSBsaWtlIHRoZSBjYXB0dXJlIGxlbmd0aCBpcyBiZWluZyBPUidkIGludG8gdGhlIGZsYWdzLg0K
Pg0KPiBBbnkgaW5zaWdodHMgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQo+DQo+IFRoYW5rcywNCj4g
TWljaGFlbA0KPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IEZyb206IFlvbmdob25nIFNvbmcgPHlvbmdob25nLnNvbmdAbGludXguZGV2Pg0KPiBTZW50OiBG
cmlkYXksIEp1bHkgMjYsIDIwMjQgOTo1OCBBTQ0KPiBUbzogTWljaGFlbCBBZ3VuIDxkYW5pZWxh
Z3VuQG1pY3Jvc29mdC5jb20+OyBicGZAdmdlci5rZXJuZWwub3JnIDxicGZAdmdlci5rZXJuZWwu
b3JnPjsgYnBmQGlldGYub3JnIDxicGZAaWV0Zi5vcmc+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IHBlcmZfZXZlbnRfb3V0cHV0IHBheWxvYWQgY2FwdHVyZSBmbGFncz8NCj4NCj4gW1lvdSBk
b24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSB5b25naG9uZy5zb25nQGxpbnV4LmRldi4gTGVhcm4g
d2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJ
ZGVudGlmaWNhdGlvbiBdDQo+DQo+IE9uIDcvMjUvMjQgNjo0MiBQTSwgTWljaGFlbCBBZ3VuIHdy
b3RlOg0KPiA+IEFyZSB0aGUgcGVyZl9ldmVudF9vdXRwdXQgZmxhZ3MgKGFuZCB3aGF0IHRoZSBl
dmVudCBibG9iIGxvb2tzIGxpa2UpIGRvY3VtZW50ZWQ/IEVzcGVjaWFsbHkgZm9yIHRoZSBwcm9n
cmFtIHR5cGUgc3BlY2lmaWMgcGVyZl9ldmVudF9vdXRwdXQgZnVuY3Rpb25zLg0KPg0KPiBUaGUg
ZG9jdW1lbnRhdGlvbiBpcyBpbiB1YXBpL2xpbnV4L2JwZi5oIGhlYWRlci4NCj4NCj4gaHR0cHM6
Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2luY2x1ZGUvdWFwaS9saW51
eC9icGYuaCNMMjM1My1MMjM5Nw0KPg0KPiAgICogICAgICAgICBUaGUgKmZsYWdzKiBhcmUgdXNl
ZCB0byBpbmRpY2F0ZSB0aGUgaW5kZXggaW4gKm1hcCogZm9yIHdoaWNoDQo+ICAgKiAgICAgICAg
IHRoZSB2YWx1ZSBtdXN0IGJlIHB1dCwgbWFza2VkIHdpdGggKipCUEZfRl9JTkRFWF9NQVNLKiou
DQo+ICAgKiAgICAgICAgIEFsdGVybmF0aXZlbHksICpmbGFncyogY2FuIGJlIHNldCB0byAqKkJQ
Rl9GX0NVUlJFTlRfQ1BVKioNCj4gICAqICAgICAgICAgdG8gaW5kaWNhdGUgdGhhdCB0aGUgaW5k
ZXggb2YgdGhlIGN1cnJlbnQgQ1BVIGNvcmUgc2hvdWxkIGJlDQo+ICAgKiAgICAgICAgIHVzZWQu
DQo+DQo+ID4NCj4gPiBJJ3ZlIHNlZW4gbm90ZXMgaW4gKGNpbGl1bSkgY29kZSBwYXNzaW5nIHBh
eWxvYWQgbGVuZ3RocyBpbiB0aGUgZmxhZ3MsIGFuZCBhbSBzcGVjaWZpY2FsbHkgaW50ZXJlc3Rl
ZCBpbiBob3cgdGhlIGV2ZW50IGJsb2IgaXMgY29uc3RydWN0ZWQgZm9yIHBlcmYgZXZlbnRzIHdp
dGggcGF5bG9hZCBjYXB0dXJlLg0KPg0KPiBDb3VsZCB5b3Ugc2hhcmUgbW9yZSBkZXRhaWxzIGFi
b3V0ICdwYXNzaW5nIHBheWxvYWQgbGVuZ3RocyBpbiB0aGUgZmxhZ3MnPw0KPiBBRkFJSywgbmV0
d29ya2luZyBicGZfcGVyZl9ldmVudF9vdXRwdXQoKSBhY3R1YWxseSB1dGlsaXplcyBicGZfZXZl
bnRfb3V0cHV0X2RhdGEoKSwNCj4gaW4gd2hpY2ggJ2ZsYWdzJyBzZW1hbnRpY3MgaGFzIHRoZSBz
YW1lIG1lYW5pbmcgYXMgdGhlIGFib3ZlLg0KPg0KPiA+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4g
TWljaGFlbA0KPg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

