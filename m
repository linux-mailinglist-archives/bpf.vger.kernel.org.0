Return-Path: <bpf+bounces-30762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A798D22B8
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CC4B24A06
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2924383B1;
	Tue, 28 May 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="lreeeGEQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="b33z26mS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mTmbO7en"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999947A6B
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918194; cv=none; b=k+u94j45q3wDyaTr6+QV6sgrtEGmHIhTGLYG1hAFN+oxabBT1+lnSksaqPfXJUMCdi1tONdZpFytAmZIXUsthUK0ETdyU7bf9ZJjz+3AVRTf0x/B8u7T8zS+DyNGHww7/LtbKovOyGAeewJXFnnSsJ7oSfxZBuMeOApZQ8j/8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918194; c=relaxed/simple;
	bh=1cKP2d7d1Q21wjiD4c/MYO/ZyyIN6pIWX8DvDxIbJSw=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=UucVB2cUFG9zIUP/51d4cixjEZqU5NnYYJdU7+Zhq6QWXas2hJN62I/xsxOJ/JhYgJhu+B8wVoqD5TyBWONB/CReYuwrxe4dCgOXjaZvuiJwkbAquEXjUdYjBwEMHVTBGS5Jmn9ZQYwFcDAWrzXHMhPJPbirlE5Qf6lZQCXceu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=lreeeGEQ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=b33z26mS reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mTmbO7en reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DCF20C1D8760
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716918190; bh=1cKP2d7d1Q21wjiD4c/MYO/ZyyIN6pIWX8DvDxIbJSw=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lreeeGEQ0FBmRIK+3uiQ51cXxBzCbj7Xf6P1Imq1zGiFERAojoxflpwAebfYnX0y+
	 wBklQjpo2FoGvqHHKIoIyDVb5wvhRRCab3nD6hM8J4oGRns8su3p0i4KtT3u7jr7Cq
	 hq9in7iimgNRQFige8pHvu9dNiWFGZkm4yY3djnc=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id C13CBC1D61FB
 for <bpf@vger.kernel.org>; Tue, 28 May 2024 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1716918190; bh=1cKP2d7d1Q21wjiD4c/MYO/ZyyIN6pIWX8DvDxIbJSw=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=b33z26mSBYJP+RvlgAiPJgnqFq8ABri8o+ShE8Bp/XSFRBd3+zIBRUvxsJs/39Bex
 2diIuII4pShhKbvjzTkFRvlvNHn0dAhkJF/udokVuhsGIOrJgPcfy70ChS5srAyZpt
 MGugVLrrYVdIOIHYhdznNEd1MCRt1FOPSJ4OoFwk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8DE1CC1CAF52
 for <bpf@ietfa.amsl.com>; Tue, 28 May 2024 10:43:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dac_M1L0Fq-8 for <bpf@ietfa.amsl.com>;
 Tue, 28 May 2024 10:43:00 -0700 (PDT)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 69078C1CAF41
 for <bpf@ietf.org>; Tue, 28 May 2024 10:43:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-681907af4e7so879111a12.1
 for <bpf@ietf.org>; Tue, 28 May 2024 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1716918180; x=1717522980;
 darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gMPlZrZg855cDMa8KIrlF2/+VDUcW37pXNgD5SWIQ4Y=;
 b=mTmbO7en/lRimWdGwGNcmxZALwBApNluG7yZOZMBu1+981IDosLNyiHNkC7GU0Styb
 0sL22586jIt41urEyxKlZm+VD2tDjh9tetyS7xfl7nHq+Bxycbwodhc90ZaM2zVouNWu
 D10uZ4dhaMJRA1D7qRPjLDBLtjxGQ6VJyUfGi0uNeEFymiPytd6KwSAtQJWxphN+ul3F
 sr4+0AioYZgD5bAUp+18ejFgZjClg6MCz70R7L92kMCg4r+bJZMZsaqxkpp7yWQE8noj
 4wr+jTFPALj7PqFAbndOBHkGS3cvDx6CfjqpwRQV0AwXoAdImF9b4AUOV43StgPJdn9v
 vNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716918180; x=1717522980;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gMPlZrZg855cDMa8KIrlF2/+VDUcW37pXNgD5SWIQ4Y=;
 b=CrOQiOtOmXICfjEyzvb0DkerwyBOKWekydzkjPFoG1k2GW0sfvNNo4VCY7rrl7aJ7X
 j9uGP4ISX5izeKLJhN063NET8FYSTKG9zcfDt/KZh1Sn/7AE3iGZCvTmlDqDMz4eoc6C
 AmqvvfMVaHs0B/O3snK0AKyZM9MmwHd+fG10RXybnqN1dMxjo9/QHUhQm+rivOHjOuJN
 i8ItpbHVVNQNNG9quN/lF/Nvo31/cgXWdtelMt93gkFpKKaT2Pm3zlJuj8PDRuOU8irg
 rEw92hwRfZIMwkOHACXQmr3dOlxGqVdiwEmEtxhWY6Mr/9dCm55IYH6EXH2jbc6BzyJE
 vr3A==
X-Gm-Message-State: AOJu0Yx4EHvjjZ6QQ2gORCn8VRtxXieuynExDjZTk0UyDzbpvaS1uFyL
 nf24sFOSKBKOF9vK/DdwVLA+vAq5xgS6Ppo3njaZv1p9iY6Mo7iL/CoLtY78
X-Google-Smtp-Source: AGHT+IHqBHvhrwhDzjoMr8Ep35e894mqrFqRZigAjbv82pVtqugZXkbRyOR6aP+kQL2M/7AR9LFgeQ==
X-Received: by 2002:a05:6a20:8404:b0:1a8:4254:5cdf with SMTP id
 adf61e73a8af0-1b212d2a5e3mr13444931637.22.1716918179565;
 Tue, 28 May 2024 10:42:59 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6822092f45fsm6652362a12.9.2024.05.28.10.42.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 May 2024 10:42:59 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Andrii Nakryiko'" <andrii.nakryiko@gmail.com>,
 "'Shankar Seal'" <Shankar.Seal=40microsoft.com@dmarc.ietf.org>
References: <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
 <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
In-Reply-To: <CAEf4BzZf=7Sb9Zf7Bt_oJh=Pq6b=03wspmr8iJSY-KRyJVZ3nw@mail.gmail.com>
Date: Tue, 28 May 2024 10:42:56 -0700
Message-ID: <0c4801dab126$7a502fc0$6ef08f40$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHl5GiPScCT4J9LZ8tQH7TdFBakVgIm+6NAAnaUIquxcZcd0A==
Content-Language: en-us
Message-ID-Hash: H3GHK6OH4NRNG5V4RASKQULV5O6TLBEF
X-Message-ID-Hash: H3GHK6OH4NRNG5V4RASKQULV5O6TLBEF
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, bpf@vger.kernel.org
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_Writing_into_a_ring_buffer_map_from_user_space?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/WTjYL7GhMTSEga3zjkLTFrYbrgQ>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

QW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToNCg0KPiBP
biBUdWUsIE1heSAyOCwgMjAyNCBhdCA5OjMy4oCvQU0gU2hhbmthciBTZWFsDQo+IDxTaGFua2Fy
LlNlYWw9NDBtaWNyb3NvZnQuY29tQGRtYXJjLmlldGYub3JnPiB3cm90ZToNCj4gPg0KPiA+IEFk
ZGluZyBicGZAdmdlci5rZXJuZWwub3JnDQo+ID4NCj4gPiBBIGNvbW1vbiB1c2UgY2FzZSBvZiBh
biBCUEYgcmluZyBidWZmZXIgbWFwIHRvIHVzZSBhcyBhIHF1ZXVlIG9mDQo+ID4gZXZlbnRzIGdl
bmVyYXRlZCBieSBCUEYgcHJvZ3JhbXMgdGhhdCBjYW4gYmUgcmVhZCBpbi1vcmRlciBieSB1c2Vy
DQo+ID4gc3BhY2UgYXBwbGljYXRpb25zLiBJIGhhdmUgYSBzY2VuYXJpbyByZXF1aXJlbWVudCBm
b3IgYSB1c2VyIHNwYWNlDQo+ID4gYXBwbGljYXRpb24gdG8gd3JpdGUgaW50byBhIHJpbmcgYnVm
ZmVyIChvciBzaW1pbGFyKSBtYXAsIHN1Y2ggdGhhdA0KPiA+IGV2ZW50cyBieSBCUEYgcHJvZ3Jh
bXMgaW4ga2VybmVsIGFuZCB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucyBhcmUNCj4gPiBpbnRlcmxl
YXZlZCBpbiB0aGUgb3JkZXIgdGhleSB3ZXJlIGdlbmVyYXRlZCwgdGhhdCBjYW4gYmUgY29uc3Vt
ZWQgYnkNCj4gPiBhbm90aGVyIHVzZXIgc3BhY2UgYXBwbGljYXRpb24NCj4gPg0KPiA+IEkgd291
bGQgbGlrZSB0byBpbXBsZW1lbnQgdGhpcyBuZXcgZmVhdHVyZSBpbiB0aGUNCj4gaHR0cHM6Ly9n
aXRodWIuY29tL21pY3Jvc29mdC9lYnBmLWZvci13aW5kb3dzIHByb2plY3QuIEJ1dCBiZWZvcmUg
SSBnbyBhaGVhZCB3aXRoDQo+IHRoZSBpbXBsZW1lbnRhdGlvbiwgSSB3YW50ZWQgdG8gY2hlY2sg
aWYgdGhlcmUgaXMgYW55IHdheSB0byBhY2NvbXBsaXNoIHRoaXMgaW4NCj4gTGludXggdG9kYXk/
IElmIG5vdCwgaXMgdGhlcmUgYW55IHJlYXNvbiB3aHkgdGhpcyBzaG91bGQgbm90IGJlIGRvbmU/
DQo+IA0KPiBZZXMsIHRoZXJlIGlzLiBTZWUgdXNlcl9yaW5nX2J1ZmZlciAoWzBdLCBbMV0pLg0K
PiANCj4gICBbMF0NCj4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFz
dGVyL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzLw0KPiB1c2VyX3Jpbmdi
dWYuYw0KPiAgIFsxXQ0KPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9t
YXN0ZXIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3VzZXJfDQo+IHJpbmdidWZf
c3VjY2Vzcy5jDQoNCkJvdGggb2YgdGhvc2UgbGlua3MgZ28gdG8gR1BMIGNvZGUgc28gSSBzdXNw
ZWN0IFNoYW5rYXIgY2Fubm90IHVzZSB0aG9zZSBsaW5rcy4NCkkgdGhpbmsgdGhlIGFuc3dlciBp
cyB0aGF0IEJQRl9NQVBfVFlQRV9VU0VSX1JJTkdCVUYgaXMgZGVmaW5lZCBmb3IgdGhpcw0KcHVy
cG9zZSBhbmQgU2hhbmthciBjYW4gcmVhZCBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvOTA3MDU2
Lw0KDQpUaGFua3MsDQpEYXZlDQoNCg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0
Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

