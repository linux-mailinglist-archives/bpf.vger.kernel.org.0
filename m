Return-Path: <bpf+bounces-37770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94C95A697
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDFB2263A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDE175D27;
	Wed, 21 Aug 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="G6nODtNy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="G6nODtNy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NUh76mnU"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673214B96A
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275820; cv=none; b=iInGTsPRAB5jP1a97w+7Ac3o6LOLsqIjjanPYL74jFMe7QanamV46/r82pj4DoyMNPNln7xS5/e9IpjK7TVh3OlSC6DEkI1FkD9S7UwP8TPWd3joNYHOsdT7VGqjguDEUX2+Z9IQ4PmV4VGz/4NZAq12mODVKQ5j7kBvTvR0plw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275820; c=relaxed/simple;
	bh=/3Z3lpWvkTU/vnKDzgvEaD/e10AysgkJbgtHSL8XoD0=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:
	 Subject:Content-Type; b=mD9X5qmjbKvN1S+HWeygfhu2JhD6jcSVqf7s50eF/njO08DZVbmM0G9VldhUS/hdJua7Wa9S7YRFvYne6IV4sqe9Aw+M3nowWDK/Bbp50dTJIQExYt2Edbu0kA/0V1muxAprOLQRiqsIVpvZzxtUm3WjDBNi322slnj6ADSdEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=G6nODtNy; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=G6nODtNy; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NUh76mnU reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 60A57C180B53
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1724275812; bh=/3Z3lpWvkTU/vnKDzgvEaD/e10AysgkJbgtHSL8XoD0=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe;
	b=G6nODtNyoce4fmN/ktxGfv0ACcBDvQB+N506tTDqk43D36ur9EAODj9SVPPvSJq49
	 UmVH8woCiW565GC2NtkoRMBdsnBqZ8wsaambtrDduJxdVvIBUqf5Di3wjmA1VbFmJw
	 MoBxodMgYpKq7y3Zt385FlOZ0gbRakxJF4ft7T08=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Wed Aug 21 14:30:12 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3245CC169439
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1724275812; bh=/3Z3lpWvkTU/vnKDzgvEaD/e10AysgkJbgtHSL8XoD0=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe;
	b=G6nODtNyoce4fmN/ktxGfv0ACcBDvQB+N506tTDqk43D36ur9EAODj9SVPPvSJq49
	 UmVH8woCiW565GC2NtkoRMBdsnBqZ8wsaambtrDduJxdVvIBUqf5Di3wjmA1VbFmJw
	 MoBxodMgYpKq7y3Zt385FlOZ0gbRakxJF4ft7T08=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id B8005C169413
	for <bpf@ietfa.amsl.com>; Wed, 21 Aug 2024 14:30:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gaKwpzaHEuIa for <bpf@ietfa.amsl.com>;
	Wed, 21 Aug 2024 14:30:05 -0700 (PDT)
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com
 [91.218.175.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 4F13BC169439
	for <bpf@ietf.org>; Wed, 21 Aug 2024 14:30:04 -0700 (PDT)
Message-ID: <0de00576-e102-4586-8695-62f2bf37eb3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724275802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXFDf2XYk15cjs0a57QWQ1ZTImPa4JMJGtnDnTjx6w0=;
	b=NUh76mnUHVFWEi8IX61k9wM5iseE7jghrsmlhPJaOjKY2ttKB+L4ig+/8q/c1fvm1s3xMc
	yP3SRqaJJnvmvkJlFi3as5lGqiRwRUur3W82EtQkcsn6ssD4NtQmDoaDrafdnpjfbguvR6
	wh1Ft3y2mlM3hmRD/KDbMcYVGbZAqdg=
Date: Wed, 21 Aug 2024 14:29:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Will Hawkins <hawkinsw@obs.cr>, bpf@vger.kernel.org, bpf@ietf.org
References: <20240819223008.469271-1-hawkinsw@obs.cr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240819223008.469271-1-hawkinsw@obs.cr>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: 5GTWCIJDWPRUKRLUE7QJXYJV7ZBXESOZ
X-Message-ID-Hash: 5GTWCIJDWPRUKRLUE7QJXYJV7ZBXESOZ
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH=5D_docs/bpf=3A_Add_constant_values_for_li?=
	=?utf-8?q?nkages?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/yDf5GTE2W8h3Ika22SolJa48cNU>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQpPbiA4LzE5LzI0IDM6MzAgUE0sIFdpbGwgSGF3a2lucyB3cm90ZToNCj4gTWFrZSB0aGUgdmFs
dWVzIG9mIHRoZSBzeW1ib2xpYyBjb25zdGFudHMgdGhhdCBkZWZpbmUgdGhlIHZhbGlkIGxpbmth
Z2VzDQo+IGZvciBmdW5jdGlvbnMgYW5kIHZhcmlhYmxlcyBleHBsaWNpdC4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogV2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+DQo+IC0tLQ0KPiAgIERvY3Vt
ZW50YXRpb24vYnBmL2J0Zi5yc3QgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYnBmL2J0Zi5yc3QgYi9Eb2N1
bWVudGF0aW9uL2JwZi9idGYucnN0DQo+IGluZGV4IDI1N2E3ZTFjZGY1ZC4uY2NlMDNmMWU1NTJh
IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2JwZi9idGYucnN0DQo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vYnBmL2J0Zi5yc3QNCj4gQEAgLTM2OCw3ICszNjgsNyBAQCBObyBhZGRpdGlvbmFs
IHR5cGUgZGF0YSBmb2xsb3cgYGBidGZfdHlwZWBgLg0KPiAgICAgKiBgYGluZm8ua2luZF9mbGFn
YGA6IDANCj4gICAgICogYGBpbmZvLmtpbmRgYDogQlRGX0tJTkRfRlVOQw0KPiAgICAgKiBgYGlu
Zm8udmxlbmBgOiBsaW5rYWdlIGluZm9ybWF0aW9uIChCVEZfRlVOQ19TVEFUSUMsIEJURl9GVU5D
X0dMT0JBTA0KPiAtICAgICAgICAgICAgICAgICAgIG9yIEJURl9GVU5DX0VYVEVSTikNCj4gKyAg
ICAgICAgICAgICAgICAgICBvciBCVEZfRlVOQ19FWFRFUk4gLSBzZWUgOnJlZjpgQlRGX0Z1bmN0
aW9uX0xpbmthZ2VfQ29uc3RhbnRzYCkNCj4gICAgICogYGB0eXBlYGA6IGEgQlRGX0tJTkRfRlVO
Q19QUk9UTyB0eXBlDQo+ICAgDQo+ICAgTm8gYWRkaXRpb25hbCB0eXBlIGRhdGEgZm9sbG93IGBg
YnRmX3R5cGVgYC4NCj4gQEAgLTQyNCw5ICs0MjQsOSBAQCBmb2xsb3dpbmcgZGF0YTo6DQo+ICAg
ICAgICAgICBfX3UzMiAgIGxpbmthZ2U7DQo+ICAgICAgIH07DQo+ICAgDQo+IC1gYHN0cnVjdCBi
dGZfdmFyYGAgZW5jb2Rpbmc6DQo+IC0gICogYGBsaW5rYWdlYGA6IGN1cnJlbnRseSBvbmx5IHN0
YXRpYyB2YXJpYWJsZSAwLCBvciBnbG9iYWxseSBhbGxvY2F0ZWQNCj4gLSAgICAgICAgICAgICAg
ICAgdmFyaWFibGUgaW4gRUxGIHNlY3Rpb25zIDENCj4gK2BgYnRmX3Zhci5saW5rYWdlYGAgbWF5
IHRha2UgdGhlIHZhbHVlczogQlRGX1ZBUl9TVEFUSUMgKGZvciBhIHN0YXRpYyB2YXJpYWJsZSks
DQo+ICtvciBCVEZfVkFSX0dMT0JBTF9BTExPQ0FURUQgKGZvciBhIGdsb2JhbGx5IGFsbG9jYXRl
ZCB2YXJpYWJsZSBzdG9yZWQgaW4gRUxGIHNlY3Rpb25zIDEpIC0NCg0KTGV0IHVzIHJlbW92ZSB0
aGUgYWJvdmUgJzEnLCBqdXN0IHNheSAnKC4uLiBzdG9yZWQgaW4gZXhwbGljaXQgRUxGIHNlY3Rp
b25zKScuDQoNCkFjdHVhbGx5LCBmb3IgYnRmX3ZhciBsaW5rYWdlLCB3ZSBhY3R1YWxseSBoYXZl
IDMgdmFsdWVzLiBTZWUNCg0KZW51bSB7DQoJQlRGX1ZBUl9TVEFUSUMgPSAwLA0KCUJURl9WQVJf
R0xPQkFMX0FMTE9DQVRFRCA9IDEsDQoJQlRGX1ZBUl9HTE9CQUxfRVhURVJOID0gMiwNCn07DQoN
ClNlZSBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvaW5jbHVk
ZS91YXBpL2xpbnV4L2J0Zi5oI0wxNTAtTDE1NA0KDQpTaW1pbGFyIHRvIEJURl9WQVJfR0xPQkFM
X0FMTE9DQVRFRCwgQlRGX1ZBUl9HTE9CQUxfRVhURVJOIGlzIGVuY29kZWQgaW4gZGF0YXNlYyBv
bmx5DQppZiB0aGUgdmFyaWFibGUgaXMgc3RvcmVkIGluIGV4cGxpY2l0IEVMRiBzZWN0aW9ucy4N
Cg0KU2luY2UgeW91IGFyZSB0b3VjaGluZyB0aGlzIGRvYywgY291bGQgeW91IGFkZCBCVEZfVkFS
X0dMT0JBTF9FWFRFUk4gYXMgd2VsbD8NCg0KPiArc2VlIDpyZWY6YEJURl9WYXJfTGlua2FnZV9D
b25zdGFudHNgLg0KPiAgIA0KPiAgIE5vdCBhbGwgdHlwZSBvZiBnbG9iYWwgdmFyaWFibGVzIGFy
ZSBzdXBwb3J0ZWQgYnkgTExWTSBhdCB0aGlzIHBvaW50Lg0KPiAgIFRoZSBmb2xsb3dpbmcgaXMg
Y3VycmVudGx5IGF2YWlsYWJsZToNCj4gQEAgLTU0OSw2ICs1NDksNDIgQEAgVGhlIGBgYnRmX2Vu
dW02NGBgIGVuY29kaW5nOg0KPiAgIElmIHRoZSBvcmlnaW5hbCBlbnVtIHZhbHVlIGlzIHNpZ25l
ZCBhbmQgdGhlIHNpemUgaXMgbGVzcyB0aGFuIDgsDQo+ICAgdGhhdCB2YWx1ZSB3aWxsIGJlIHNp
Z24gZXh0ZW5kZWQgaW50byA4IGJ5dGVzLg0KPiAgIA0KPiArMi4zIENvbnN0YW50IFZhbHVlcw0K
PiArLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICsuLiBfQlRGX0Z1bmN0aW9uX0xpbmthZ2Vf
Q29uc3RhbnRzOg0KPiArDQo+ICsyLjMuMSBGdW5jdGlvbiBMaW5rYWdlIENvbnN0YW50IFZhbHVl
cw0KPiArfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gKy4uIGxpc3Qt
dGFibGU6Og0KPiArICAgOndpZHRoczogMSAxDQo+ICsgICA6aGVhZGVyLXJvd3M6IDENCj4gKw0K
PiArICAgKiAtIE5hbWUNCj4gKyAgICAgLSBWYWx1ZQ0KPiArICAgKiAtIGBgQlRGX0ZVTkNfU1RB
VElDYGANCj4gKyAgICAgLSBgYDBgYA0KPiArICAgKiAtIGBgQlRGX0ZVTkNfR0xPQkFMYGANCj4g
KyAgICAgLSBgYDFgYA0KPiArICAgKiAtIGBgQlRGX0ZVTkNfRVhURVJOYGANCj4gKyAgICAgLSBg
YDJgYA0KPiArDQo+ICsuLiBfQlRGX1Zhcl9MaW5rYWdlX0NvbnN0YW50czoNCj4gKw0KPiArMi4z
LjIgVmFyaWFibGUgTGlua2FnZSBDb25zdGFudCBWYWx1ZXMNCj4gK35+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICsuLiBsaXN0LXRhYmxlOjoNCj4gKyAgIDp3aWR0aHM6
IDEgMQ0KPiArICAgOmhlYWRlci1yb3dzOiAxDQo+ICsNCj4gKyAgICogLSBOYW1lDQo+ICsgICAg
IC0gVmFsdWUNCj4gKyAgICogLSBgYEJURl9WQVJfU1RBVElDYGANCj4gKyAgICAgLSBgYDBgYA0K
PiArICAgKiAtIGBgQlRGX1ZBUl9HTE9CQUxfQUxMT0NBVEVEYGANCj4gKyAgICAgLSBgYDFgYA0K
PiArDQo+ICsNCg0KRm9ybSB0aGUgYWJvdmUsIGNvdWxkIHlvdSB1c2Ugc2ltaWxhciBmb3JtYXQg
YXMgaW4gRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5y
c3Q/IEZvciBleGFtcGxlLA0KDQouLiB0YWJsZTo6IEluc3RydWN0aW9uIGNsYXNzDQoNCiAgID09
PT09ICA9PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSAgPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCiAgIGNsYXNzICB2YWx1ZSAgZGVzY3JpcHRpb24gICAg
ICAgICAgICAgICAgICAgICAgcmVmZXJlbmNlDQogICA9PT09PSAgPT09PT0gID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQogICBMRCAgICAgMHgwICAgIG5vbi1zdGFuZGFyZCBsb2FkIG9wZXJhdGlvbnMgICAgIGBMb2Fk
IGFuZCBzdG9yZSBpbnN0cnVjdGlvbnNgXw0KICAgTERYICAgIDB4MSAgICBsb2FkIGludG8gcmVn
aXN0ZXIgb3BlcmF0aW9ucyAgICBgTG9hZCBhbmQgc3RvcmUgaW5zdHJ1Y3Rpb25zYF8NCiAgIFNU
ICAgICAweDIgICAgc3RvcmUgZnJvbSBpbW1lZGlhdGUgb3BlcmF0aW9ucyAgYExvYWQgYW5kIHN0
b3JlIGluc3RydWN0aW9uc2BfDQogICBTVFggICAgMHgzICAgIHN0b3JlIGZyb20gcmVnaXN0ZXIg
b3BlcmF0aW9ucyAgIGBMb2FkIGFuZCBzdG9yZSBpbnN0cnVjdGlvbnNgXw0KICAgQUxVICAgIDB4
NCAgICAzMi1iaXQgYXJpdGhtZXRpYyBvcGVyYXRpb25zICAgICBgQXJpdGhtZXRpYyBhbmQganVt
cCBpbnN0cnVjdGlvbnNgXw0KICAgSk1QICAgIDB4NSAgICA2NC1iaXQganVtcCBvcGVyYXRpb25z
ICAgICAgICAgICBgQXJpdGhtZXRpYyBhbmQganVtcCBpbnN0cnVjdGlvbnNgXw0KICAgSk1QMzIg
IDB4NiAgICAzMi1iaXQganVtcCBvcGVyYXRpb25zICAgICAgICAgICBgQXJpdGhtZXRpYyBhbmQg
anVtcCBpbnN0cnVjdGlvbnNgXw0KICAgQUxVNjQgIDB4NyAgICA2NC1iaXQgYXJpdGhtZXRpYyBv
cGVyYXRpb25zICAgICBgQXJpdGhtZXRpYyBhbmQganVtcCBpbnN0cnVjdGlvbnNgXw0KICAgPT09
PT0gID09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ICA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KDQpJIHdvdWxkIGxpa2Ugd2UgaGF2ZSBjb25zaXN0YW50
IHRhYmxlIHByZXNlbnRhdGlvbiBiZXR3ZWVuIGluc3RydWN0aW9uIHNldCBhbmQgYnRmLg0KDQo+
ICAgMy4gQlRGIEtlcm5lbCBBUEkNCj4gICA9PT09PT09PT09PT09PT09PQ0KPiAgIA0KDQotLSAK
QnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBl
bWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

