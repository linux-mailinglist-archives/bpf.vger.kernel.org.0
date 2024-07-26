Return-Path: <bpf+bounces-35743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0234D93D748
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 19:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705721F24580
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798B17C7B2;
	Fri, 26 Jul 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="utHN6kLJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="utHN6kLJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V5i8zv2C"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10475684
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013739; cv=none; b=f8TXQx8+FJsOt2JeINVaE4xrMVSJWudLsVEzWe8HaOEW55FTbuRv83VaG0wQfDlASvLjlOzoFOhieQozpKg1uHaK2bbfnQvKY3pW+EZ94tKK7FLp5sQ7rU7RznlmpGJQPCbU1jPCD2hnKL5q9ytiZvL1K5eJczbp1zqH3te/+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013739; c=relaxed/simple;
	bh=JbNHstT+c9PvRl1pzP8pisYqqfdk4lO4wWGLheXvy8Y=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:
	 Subject:Content-Type; b=Od6ZJA4Sz4vlJgMvaKyI3scnKEmXU/Rof3SIgtWsUHN7dy9NRCxI4/03Sx58WUXJrBjF4ehRH/hom311UyQt7UY4QPggUbwuYloASCG94Hlkm8tYijiM+BW4KlQXkZjK3eypCYDv2ejFboocOumgD9OvUzyRQd9QrmlDB3RI6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=utHN6kLJ; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=utHN6kLJ; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V5i8zv2C reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3EFC6C14F749
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1722013148; bh=JbNHstT+c9PvRl1pzP8pisYqqfdk4lO4wWGLheXvy8Y=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe;
	b=utHN6kLJyCofcRAeZLJ4Pnd80yYh5jLsIETV/5/diTepULyjni+0JIhHFJV/X1n4h
	 3NR6oBcXxtq1lI72Cgyrxat87rkfB4Ub5cSi4h4kCix5eyJiCRtPLIxCJS1unNEP8J
	 C9Cp/utURAG0/a44sErCsSTQjDnE3lERl4KeQ/T0=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Fri Jul 26 09:59:08 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 13C57C14F699
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1722013148; bh=JbNHstT+c9PvRl1pzP8pisYqqfdk4lO4wWGLheXvy8Y=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe;
	b=utHN6kLJyCofcRAeZLJ4Pnd80yYh5jLsIETV/5/diTepULyjni+0JIhHFJV/X1n4h
	 3NR6oBcXxtq1lI72Cgyrxat87rkfB4Ub5cSi4h4kCix5eyJiCRtPLIxCJS1unNEP8J
	 C9Cp/utURAG0/a44sErCsSTQjDnE3lERl4KeQ/T0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4A7E4C14F6BC
	for <bpf@ietfa.amsl.com>; Fri, 26 Jul 2024 09:59:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.808
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NIAzy4fRk_h6 for <bpf@ietfa.amsl.com>;
	Fri, 26 Jul 2024 09:59:01 -0700 (PDT)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 4FC76C14F699
	for <bpf@ietf.org>; Fri, 26 Jul 2024 09:59:00 -0700 (PDT)
Message-ID: <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722013138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckFjhxBtKaQbq8JRIVByyXVebct9aJJ1dpU0RfTlqWU=;
	b=V5i8zv2CmuZ0/rB9t2ZcP4FQ9J50yEUpNzXIcgWO7yUBqyk3+AnWvIIQW8yZJlLctzN7s4
	Ku3Y5WepsoSoyfKNkvpwXl84AmhyPFWcdQt0dgPK3n1lXVdE8wDUoxI9Hwn+nrVbk/+FER
	5KzXg79KMbWDD0KvMV2A3yvi2xbZTbs=
Date: Fri, 26 Jul 2024 09:58:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Michael Agun <danielagun@microsoft.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
References: 
 <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: 
 <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: TPCM4XDZZ6GGOVP3Z5E27L6B2B34CN6A
X-Message-ID-Hash: TPCM4XDZZ6GGOVP3Z5E27L6B2B34CN6A
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_perf=5Fevent=5Foutput_payload_capture_flags=3F?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/DZ2dC0iR_ZsabG31v1SnBE_sJuk>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQpPbiA3LzI1LzI0IDY6NDIgUE0sIE1pY2hhZWwgQWd1biB3cm90ZToNCj4gQXJlIHRoZSBwZXJm
X2V2ZW50X291dHB1dCBmbGFncyAoYW5kIHdoYXQgdGhlIGV2ZW50IGJsb2IgbG9va3MgbGlrZSkg
ZG9jdW1lbnRlZD8gRXNwZWNpYWxseSBmb3IgdGhlIHByb2dyYW0gdHlwZSBzcGVjaWZpYyBwZXJm
X2V2ZW50X291dHB1dCBmdW5jdGlvbnMuDQoNClRoZSBkb2N1bWVudGF0aW9uIGlzIGluIHVhcGkv
bGludXgvYnBmLmggaGVhZGVyLg0KDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgv
YmxvYi9tYXN0ZXIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oI0wyMzUzLUwyMzk3DQoNCiDCoCog
wqDCoMKgIMKgwqDCoCBUaGUgKmZsYWdzKiBhcmUgdXNlZCB0byBpbmRpY2F0ZSB0aGUgaW5kZXgg
aW4gKm1hcCogZm9yIHdoaWNoDQogwqAqIMKgwqDCoCDCoMKgwqAgdGhlIHZhbHVlIG11c3QgYmUg
cHV0LCBtYXNrZWQgd2l0aCAqKkJQRl9GX0lOREVYX01BU0sqKi4NCiDCoCogwqDCoMKgIMKgwqDC
oCBBbHRlcm5hdGl2ZWx5LCAqZmxhZ3MqIGNhbiBiZSBzZXQgdG8gKipCUEZfRl9DVVJSRU5UX0NQ
VSoqDQogwqAqIMKgwqDCoCDCoMKgwqAgdG8gaW5kaWNhdGUgdGhhdCB0aGUgaW5kZXggb2YgdGhl
IGN1cnJlbnQgQ1BVIGNvcmUgc2hvdWxkIGJlDQogwqAqIMKgwqDCoCDCoMKgwqAgdXNlZC4NCg0K
Pg0KPiBJJ3ZlIHNlZW4gbm90ZXMgaW4gKGNpbGl1bSkgY29kZSBwYXNzaW5nIHBheWxvYWQgbGVu
Z3RocyBpbiB0aGUgZmxhZ3MsIGFuZCBhbSBzcGVjaWZpY2FsbHkgaW50ZXJlc3RlZCBpbiBob3cg
dGhlIGV2ZW50IGJsb2IgaXMgY29uc3RydWN0ZWQgZm9yIHBlcmYgZXZlbnRzIHdpdGggcGF5bG9h
ZCBjYXB0dXJlLg0KDQpDb3VsZCB5b3Ugc2hhcmUgbW9yZSBkZXRhaWxzIGFib3V0ICdwYXNzaW5n
IHBheWxvYWQgbGVuZ3RocyBpbiB0aGUgZmxhZ3MnPw0KQUZBSUssIG5ldHdvcmtpbmcgYnBmX3Bl
cmZfZXZlbnRfb3V0cHV0KCkgYWN0dWFsbHkgdXRpbGl6ZXMgYnBmX2V2ZW50X291dHB1dF9kYXRh
KCksDQppbiB3aGljaCAnZmxhZ3MnIHNlbWFudGljcyBoYXMgdGhlIHNhbWUgbWVhbmluZyBhcyB0
aGUgYWJvdmUuDQoNCj4NCj4NCj4gVGhhbmtzLA0KPiBNaWNoYWVsDQoNCi0tIApCcGYgbWFpbGlu
ZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJw
Zi1sZWF2ZUBpZXRmLm9yZwo=

