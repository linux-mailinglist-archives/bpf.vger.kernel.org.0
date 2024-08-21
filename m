Return-Path: <bpf+bounces-37774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773295A6BC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D6728177E
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F117994F;
	Wed, 21 Aug 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="zFYwYD3m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="zFYwYD3m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="BCV14B5c"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE11179652
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276153; cv=none; b=upATaQnbqqC6hBnLsUUczjceQt8wwKfTYvR1GCXsRWU6ycuBKytiJ6qQ5PzZdCXtAhoXFheet8P8DJAwjXIZgsdFyaz4FS5kckUlZIhuReZuKeil8wuBEpM0yq3DthJYRw32j3nIfWrhr3Tp2ZMfYuxOhnH3kFU2WmQYJW379OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276153; c=relaxed/simple;
	bh=a+4MfwlYzss2NfHPFdX59yxjEWicfs5xRgO3SZGRylQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=Mq2yXoYx2aWnkIkW2CbcNtok6Oky9xJZfITEN/Rl5imQGMtAzO9mtjNcc+7kfAnjwEVz9eXo3RxLefxQ5DG4cC1HrmTaNzwnxhb7WsC78Nb+CwPpR3I132FZmhKYTvteIk2ieQufDEjwSBJlZfc9XBxdb0tFKYd1foNK1EHHKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=zFYwYD3m; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=zFYwYD3m; dkim=fail (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=BCV14B5c reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7BF84C180B50
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1724276151; bh=a+4MfwlYzss2NfHPFdX59yxjEWicfs5xRgO3SZGRylQ=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=zFYwYD3mel/aoIp1WVJvcoE98AAHAZnbgn7NF+SDQkfgwt58ilT/l94uAgPo940RF
	 50bYXLIHgr7QmdR114iK37nzDB+JW/k3LoW0qAhdAggXlN6TsRYOMX4TsyGYp/Wo7W
	 nA5O0GCaeSUQQi0e3BWc5eDGXVE3MvSEWUWpvKKc=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Wed Aug 21 14:35:51 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4782DC151990
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1724276151; bh=a+4MfwlYzss2NfHPFdX59yxjEWicfs5xRgO3SZGRylQ=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=zFYwYD3mel/aoIp1WVJvcoE98AAHAZnbgn7NF+SDQkfgwt58ilT/l94uAgPo940RF
	 50bYXLIHgr7QmdR114iK37nzDB+JW/k3LoW0qAhdAggXlN6TsRYOMX4TsyGYp/Wo7W
	 nA5O0GCaeSUQQi0e3BWc5eDGXVE3MvSEWUWpvKKc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id C1CC3C151990
	for <bpf@ietfa.amsl.com>; Wed, 21 Aug 2024 14:35:48 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.908
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLTYdBn2iXh4 for <bpf@ietfa.amsl.com>;
	Wed, 21 Aug 2024 14:35:48 -0700 (PDT)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 0DAD5C14F615
	for <bpf@ietf.org>; Wed, 21 Aug 2024 14:35:47 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf8b41b34dso532316d6.0
        for <bpf@ietf.org>; Wed, 21 Aug 2024 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724276147;
 x=1724880947; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LuLScUXbCy7Fak1DCkUGU1maWwDf16GZc3pQB1Yli8=;
        b=BCV14B5csUfUyPhVbySzrMaGoaDsPGK0I2ZZ1yRTZ5UBBJyYQhnSa70VjN8rYn37Og
         I6n+Tn5ZzZWQWdF8gfc3chYK5W+DTx4fh/PYXLpzCE28lj3y3xTHV9jodjdcHHkj/WaF
         BshpAEuqy52ZWf9KD5Kgm6iSZBby9Mk98n4j6qhvtuwzsgzUveuO0aXtTpCoC3iSIJQm
         MbCYqDk0fqyKEMD23NZQNsRO3/ip4Tmvwy5JqDksWQRt4o3KAi6nRSTc1IY/DS/yp8nO
         fFgxch/HDWojHEMVM+MejwrM21c3aDTtOKKj64Jx3Uwy2Ffmj/53SRUc1eVmPh1FfjS4
         u/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276147; x=1724880947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LuLScUXbCy7Fak1DCkUGU1maWwDf16GZc3pQB1Yli8=;
        b=vulS1nFL/XQqKikPgw8rukzBa6DjtmpeGrO3k1+5sCeq5okhEW0/AI0JM+560/0qwe
         UKYY+y5GzyRvggDckIQIgg7C3x1DeWHXFPEFHTDtZ3QoH+Wkz7MCDZVqBBQjteQwKG+u
         EeCWnI6QK6vm8vj4CbK1hPN7vgJslAJgYlSfU/NrHcWd7WIXYnzpCqDTtT7uDVV9LU5H
         eKW3YGcHGmEHldQtwFVEhvbOm3d96F0I/GH6DXwcDFxb+LTSgwkOmMhUmw7eNS54eno4
         1xbHjzQSpXLSPfwdH248/GKytsUoh10h2ZSXWIP4lXyLbopneff7gNpRTb/uNfLskRSo
         V3Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdW75YfFumZLv/ctDfvAnakLs+YDJ1rfOuzU8jolWYEFKIyC8oGq3lcRN3BbaqfjnOWf4=@ietf.org
X-Gm-Message-State: AOJu0YycQ2F037nGmx+sAfRZFnC83kJIjTM4E3r7/glLa9g0mkjv4pPU
	uaZZcMHkwtyLYmw8/3DY84oIegY+8cP2j1Z/mXHr/3VDaIvYEFSR5F3UnZOrUHGU4jYeV8uslbz
	WZOTHnwc+4mGPE4CNQguWJzlPJOOBqsYEtFfHmg==
X-Google-Smtp-Source: 
 AGHT+IFuH0AIkuoNhZ5hEhd5NX9DiTdqzOM8ceNjyb86tyUxPfuYqgl/x4M4/CFcjEOjhzPIet2rid8Qfscwxttzq8Y=
X-Received: by 2002:a05:6214:3d01:b0:6bf:916a:66ac with SMTP id
 6a1803df08f44-6c155d725aamr42457876d6.17.1724276146746; Wed, 21 Aug 2024
 14:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819223008.469271-1-hawkinsw@obs.cr>
 <0de00576-e102-4586-8695-62f2bf37eb3f@linux.dev>
In-Reply-To: <0de00576-e102-4586-8695-62f2bf37eb3f@linux.dev>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 21 Aug 2024 17:35:34 -0400
Message-ID: 
 <CADx9qWh-JSVVP9Stu3gz4aLpwrB9cVnK-RO3TveqjpWuxWQJ_w@mail.gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Message-ID-Hash: OQL35SOIVC2LCAZG7SPJIA2SNDZZIM6E
X-Message-ID-Hash: OQL35SOIVC2LCAZG7SPJIA2SNDZZIM6E
X-MailFrom: hawkinsw@obs.cr
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@vger.kernel.org, bpf@ietf.org
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH=5D_docs/bpf=3A_Add_constant_values_for_li?=
	=?utf-8?q?nkages?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/ca2On5gQ0ABgczxH64vJByK0fiM>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBBdWcgMjEsIDIwMjQgYXQgNTozMOKAr1BNIFlvbmdob25nIFNvbmcgPHlvbmdob25n
LnNvbmdAbGludXguZGV2PiB3cm90ZToNCj4NCj4NCj4gT24gOC8xOS8yNCAzOjMwIFBNLCBXaWxs
IEhhd2tpbnMgd3JvdGU6DQo+ID4gTWFrZSB0aGUgdmFsdWVzIG9mIHRoZSBzeW1ib2xpYyBjb25z
dGFudHMgdGhhdCBkZWZpbmUgdGhlIHZhbGlkIGxpbmthZ2VzDQo+ID4gZm9yIGZ1bmN0aW9ucyBh
bmQgdmFyaWFibGVzIGV4cGxpY2l0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2lsbCBIYXdr
aW5zIDxoYXdraW5zd0BvYnMuY3I+DQo+ID4gLS0tDQo+ID4gICBEb2N1bWVudGF0aW9uL2JwZi9i
dGYucnN0IHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9idGYucnN0IGIvRG9jdW1lbnRhdGlv
bi9icGYvYnRmLnJzdA0KPiA+IGluZGV4IDI1N2E3ZTFjZGY1ZC4uY2NlMDNmMWU1NTJhIDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL2J0Zi5yc3QNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2JwZi9idGYucnN0DQo+ID4gQEAgLTM2OCw3ICszNjgsNyBAQCBObyBhZGRpdGlvbmFs
IHR5cGUgZGF0YSBmb2xsb3cgYGBidGZfdHlwZWBgLg0KPiA+ICAgICAqIGBgaW5mby5raW5kX2Zs
YWdgYDogMA0KPiA+ICAgICAqIGBgaW5mby5raW5kYGA6IEJURl9LSU5EX0ZVTkMNCj4gPiAgICAg
KiBgYGluZm8udmxlbmBgOiBsaW5rYWdlIGluZm9ybWF0aW9uIChCVEZfRlVOQ19TVEFUSUMsIEJU
Rl9GVU5DX0dMT0JBTA0KPiA+IC0gICAgICAgICAgICAgICAgICAgb3IgQlRGX0ZVTkNfRVhURVJO
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgb3IgQlRGX0ZVTkNfRVhURVJOIC0gc2VlIDpyZWY6
YEJURl9GdW5jdGlvbl9MaW5rYWdlX0NvbnN0YW50c2ApDQo+ID4gICAgICogYGB0eXBlYGA6IGEg
QlRGX0tJTkRfRlVOQ19QUk9UTyB0eXBlDQo+ID4NCj4gPiAgIE5vIGFkZGl0aW9uYWwgdHlwZSBk
YXRhIGZvbGxvdyBgYGJ0Zl90eXBlYGAuDQo+ID4gQEAgLTQyNCw5ICs0MjQsOSBAQCBmb2xsb3dp
bmcgZGF0YTo6DQo+ID4gICAgICAgICAgIF9fdTMyICAgbGlua2FnZTsNCj4gPiAgICAgICB9Ow0K
PiA+DQo+ID4gLWBgc3RydWN0IGJ0Zl92YXJgYCBlbmNvZGluZzoNCj4gPiAtICAqIGBgbGlua2Fn
ZWBgOiBjdXJyZW50bHkgb25seSBzdGF0aWMgdmFyaWFibGUgMCwgb3IgZ2xvYmFsbHkgYWxsb2Nh
dGVkDQo+ID4gLSAgICAgICAgICAgICAgICAgdmFyaWFibGUgaW4gRUxGIHNlY3Rpb25zIDENCj4g
PiArYGBidGZfdmFyLmxpbmthZ2VgYCBtYXkgdGFrZSB0aGUgdmFsdWVzOiBCVEZfVkFSX1NUQVRJ
QyAoZm9yIGEgc3RhdGljIHZhcmlhYmxlKSwNCj4gPiArb3IgQlRGX1ZBUl9HTE9CQUxfQUxMT0NB
VEVEIChmb3IgYSBnbG9iYWxseSBhbGxvY2F0ZWQgdmFyaWFibGUgc3RvcmVkIGluIEVMRiBzZWN0
aW9ucyAxKSAtDQo+DQo+IExldCB1cyByZW1vdmUgdGhlIGFib3ZlICcxJywganVzdCBzYXkgJygu
Li4gc3RvcmVkIGluIGV4cGxpY2l0IEVMRiBzZWN0aW9ucyknLg0KDQpHcmVhdCEgSSBvbmx5IGtl
cHQgdGhhdCBiZWNhdXNlIGl0IHdhcyB0aGVyZSBpbiB0aGUgZXhpc3RpbmcgZG9jdW1lbnRhdGlv
biENCg0KPg0KPiBBY3R1YWxseSwgZm9yIGJ0Zl92YXIgbGlua2FnZSwgd2UgYWN0dWFsbHkgaGF2
ZSAzIHZhbHVlcy4gU2VlDQo+DQo+IGVudW0gew0KPiAgICAgICAgIEJURl9WQVJfU1RBVElDID0g
MCwNCj4gICAgICAgICBCVEZfVkFSX0dMT0JBTF9BTExPQ0FURUQgPSAxLA0KPiAgICAgICAgIEJU
Rl9WQVJfR0xPQkFMX0VYVEVSTiA9IDIsDQo+IH07DQo+DQo+IFNlZSBodHRwczovL2dpdGh1Yi5j
b20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvaW5jbHVkZS91YXBpL2xpbnV4L2J0Zi5oI0wx
NTAtTDE1NA0KPg0KDQpHcmVhdCEgSSB3aWxsIG1ha2UgdGhhdCB1cGRhdGUhDQoNCj4gU2ltaWxh
ciB0byBCVEZfVkFSX0dMT0JBTF9BTExPQ0FURUQsIEJURl9WQVJfR0xPQkFMX0VYVEVSTiBpcyBl
bmNvZGVkIGluIGRhdGFzZWMgb25seQ0KPiBpZiB0aGUgdmFyaWFibGUgaXMgc3RvcmVkIGluIGV4
cGxpY2l0IEVMRiBzZWN0aW9ucy4NCj4NCj4gU2luY2UgeW91IGFyZSB0b3VjaGluZyB0aGlzIGRv
YywgY291bGQgeW91IGFkZCBCVEZfVkFSX0dMT0JBTF9FWFRFUk4gYXMgd2VsbD8NCj4NCg0KT2Yg
Y291cnNlIQ0KDQo+ID4gK3NlZSA6cmVmOmBCVEZfVmFyX0xpbmthZ2VfQ29uc3RhbnRzYC4NCj4g
Pg0KPiA+ICAgTm90IGFsbCB0eXBlIG9mIGdsb2JhbCB2YXJpYWJsZXMgYXJlIHN1cHBvcnRlZCBi
eSBMTFZNIGF0IHRoaXMgcG9pbnQuDQo+ID4gICBUaGUgZm9sbG93aW5nIGlzIGN1cnJlbnRseSBh
dmFpbGFibGU6DQo+ID4gQEAgLTU0OSw2ICs1NDksNDIgQEAgVGhlIGBgYnRmX2VudW02NGBgIGVu
Y29kaW5nOg0KPiA+ICAgSWYgdGhlIG9yaWdpbmFsIGVudW0gdmFsdWUgaXMgc2lnbmVkIGFuZCB0
aGUgc2l6ZSBpcyBsZXNzIHRoYW4gOCwNCj4gPiAgIHRoYXQgdmFsdWUgd2lsbCBiZSBzaWduIGV4
dGVuZGVkIGludG8gOCBieXRlcy4NCj4gPg0KPiA+ICsyLjMgQ29uc3RhbnQgVmFsdWVzDQo+ID4g
Ky0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gKy4uIF9CVEZfRnVuY3Rpb25fTGlua2Fn
ZV9Db25zdGFudHM6DQo+ID4gKw0KPiA+ICsyLjMuMSBGdW5jdGlvbiBMaW5rYWdlIENvbnN0YW50
IFZhbHVlcw0KPiA+ICt+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+
ICsuLiBsaXN0LXRhYmxlOjoNCj4gPiArICAgOndpZHRoczogMSAxDQo+ID4gKyAgIDpoZWFkZXIt
cm93czogMQ0KPiA+ICsNCj4gPiArICAgKiAtIE5hbWUNCj4gPiArICAgICAtIFZhbHVlDQo+ID4g
KyAgICogLSBgYEJURl9GVU5DX1NUQVRJQ2BgDQo+ID4gKyAgICAgLSBgYDBgYA0KPiA+ICsgICAq
IC0gYGBCVEZfRlVOQ19HTE9CQUxgYA0KPiA+ICsgICAgIC0gYGAxYGANCj4gPiArICAgKiAtIGBg
QlRGX0ZVTkNfRVhURVJOYGANCj4gPiArICAgICAtIGBgMmBgDQo+ID4gKw0KPiA+ICsuLiBfQlRG
X1Zhcl9MaW5rYWdlX0NvbnN0YW50czoNCj4gPiArDQo+ID4gKzIuMy4yIFZhcmlhYmxlIExpbmth
Z2UgQ29uc3RhbnQgVmFsdWVzDQo+ID4gK35+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+DQo+ID4gKy4uIGxpc3QtdGFibGU6Og0KPiA+ICsgICA6d2lkdGhzOiAxIDENCj4gPiAr
ICAgOmhlYWRlci1yb3dzOiAxDQo+ID4gKw0KPiA+ICsgICAqIC0gTmFtZQ0KPiA+ICsgICAgIC0g
VmFsdWUNCj4gPiArICAgKiAtIGBgQlRGX1ZBUl9TVEFUSUNgYA0KPiA+ICsgICAgIC0gYGAwYGAN
Cj4gPiArICAgKiAtIGBgQlRGX1ZBUl9HTE9CQUxfQUxMT0NBVEVEYGANCj4gPiArICAgICAtIGBg
MWBgDQo+ID4gKw0KPiA+ICsNCj4NCj4gRm9ybSB0aGUgYWJvdmUsIGNvdWxkIHlvdSB1c2Ugc2lt
aWxhciBmb3JtYXQgYXMgaW4gRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3Ry
dWN0aW9uLXNldC5yc3Q/IEZvciBleGFtcGxlLA0KPg0KPiAuLiB0YWJsZTo6IEluc3RydWN0aW9u
IGNsYXNzDQo+DQo+ICAgID09PT09ICA9PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gICAgY2xhc3MgIHZh
bHVlICBkZXNjcmlwdGlvbiAgICAgICAgICAgICAgICAgICAgICByZWZlcmVuY2UNCj4gICAgPT09
PT0gID09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ICA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiAgICBMRCAgICAgMHgwICAgIG5vbi1zdGFuZGFyZCBs
b2FkIG9wZXJhdGlvbnMgICAgIGBMb2FkIGFuZCBzdG9yZSBpbnN0cnVjdGlvbnNgXw0KPiAgICBM
RFggICAgMHgxICAgIGxvYWQgaW50byByZWdpc3RlciBvcGVyYXRpb25zICAgIGBMb2FkIGFuZCBz
dG9yZSBpbnN0cnVjdGlvbnNgXw0KPiAgICBTVCAgICAgMHgyICAgIHN0b3JlIGZyb20gaW1tZWRp
YXRlIG9wZXJhdGlvbnMgIGBMb2FkIGFuZCBzdG9yZSBpbnN0cnVjdGlvbnNgXw0KPiAgICBTVFgg
ICAgMHgzICAgIHN0b3JlIGZyb20gcmVnaXN0ZXIgb3BlcmF0aW9ucyAgIGBMb2FkIGFuZCBzdG9y
ZSBpbnN0cnVjdGlvbnNgXw0KPiAgICBBTFUgICAgMHg0ICAgIDMyLWJpdCBhcml0aG1ldGljIG9w
ZXJhdGlvbnMgICAgIGBBcml0aG1ldGljIGFuZCBqdW1wIGluc3RydWN0aW9uc2BfDQo+ICAgIEpN
UCAgICAweDUgICAgNjQtYml0IGp1bXAgb3BlcmF0aW9ucyAgICAgICAgICAgYEFyaXRobWV0aWMg
YW5kIGp1bXAgaW5zdHJ1Y3Rpb25zYF8NCj4gICAgSk1QMzIgIDB4NiAgICAzMi1iaXQganVtcCBv
cGVyYXRpb25zICAgICAgICAgICBgQXJpdGhtZXRpYyBhbmQganVtcCBpbnN0cnVjdGlvbnNgXw0K
PiAgICBBTFU2NCAgMHg3ICAgIDY0LWJpdCBhcml0aG1ldGljIG9wZXJhdGlvbnMgICAgIGBBcml0
aG1ldGljIGFuZCBqdW1wIGluc3RydWN0aW9uc2BfDQo+ICAgID09PT09ICA9PT09PSAgPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4NCj4gSSB3b3VsZCBsaWtlIHdlIGhhdmUgY29uc2lzdGFudCB0YWJsZSBwcmVzZW50
YXRpb24gYmV0d2VlbiBpbnN0cnVjdGlvbiBzZXQgYW5kIGJ0Zi4NCj4NCg0KQWJzb2x1dGVseS4g
SSB2b2x1bnRlZXJlZCB0byBlZGl0IHRoZSBkb2N1bWVudCB0aGF0IHdpbGwgdWx0aW1hdGVseQ0K
dHVybiBpbnRvIHRoZSBJRVRGIHNwZWMgZHJhZnQgZm9yIEJURiBhbmQgdGhpcyBpcyB0aGUgZmly
c3QgZml4IHRoYXQNCmp1bXBlZCBvdXQgdG8gbWUgd2hlbiBJIHdhcyBwcm9vZnJlYWRpbmcuDQoN
ClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyEgSSB3aWxsIGhhdmUgYSB2MiBvZiB0aGUgcGF0Y2gg
aW4ganVzdCBhIGZldyBtaW51dGVzIQ0KDQpUaGFuayB5b3UsIGFnYWluIQ0KV2lsbA0KDQoNCj4g
PiAgIDMuIEJURiBLZXJuZWwgQVBJDQo+ID4gICA9PT09PT09PT09PT09PT09PQ0KPiA+DQoNCi0t
IApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFu
IGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

