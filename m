Return-Path: <bpf+bounces-40916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D040798FD01
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 07:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC511F228ED
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 05:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C118175F;
	Fri,  4 Oct 2024 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YTqO+41d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YTqO+41d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KCCze5g4"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F579475
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019740; cv=none; b=RYTqIQJD5EvP2RD76TeP40INfGY4ZB753P/Z8EXa31kBpjfuWZV6Pd8AWtFnKg+QYiVIKKBxltozFdH4UIAQ+6VUbTp7cgVWoPabz0R89fhprXsRSKcD8NL/J/VqjF3JQZtnCRkc/jbdLvt6a1yhDZcGg2IWMcoXDSnkZhyGQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019740; c=relaxed/simple;
	bh=a99oQOG7HXP9DPVBC9NKwKphDg4e1c39EjHtCQ0H7I8=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:CC:
	 Subject:Content-Type; b=QtJ9OFsvuPvNmR8eDjXfj396/l1Gp3cv3dHlKIT6C9GglDPVv0Pq8TjMUxgNlBRNipIBiy/HkmXkOJHLKMG5G2lnk3vHMqD66IxBeBVLr8MSLR816WnAkCq/eQ6+tT5fDIUFA7jrMJFxaa+wZ37y/7Lz9e5BnMGCR+AE3jYZZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=YTqO+41d; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=YTqO+41d; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KCCze5g4 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EA322C1D875F
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1728019731; bh=a99oQOG7HXP9DPVBC9NKwKphDg4e1c39EjHtCQ0H7I8=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=YTqO+41dH6o4CQ+XzL6WIU1JE7jjlIn+o7T0aLcW5HfbDAPo+wXa3VwhDwFhHB/97
	 G+6GGd/bR+afg8t2MFHa+kddJMU9TILz9l1+lWxsktW0vjxahzez3oQwq3EYrE7vE9
	 oWryUPW76tYouTd8Py3HDGc8rLQpQA2r5GE0PB3Q=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Thu Oct  3 22:28:51 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D4018C1D8759
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1728019731; bh=a99oQOG7HXP9DPVBC9NKwKphDg4e1c39EjHtCQ0H7I8=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=YTqO+41dH6o4CQ+XzL6WIU1JE7jjlIn+o7T0aLcW5HfbDAPo+wXa3VwhDwFhHB/97
	 G+6GGd/bR+afg8t2MFHa+kddJMU9TILz9l1+lWxsktW0vjxahzez3oQwq3EYrE7vE9
	 oWryUPW76tYouTd8Py3HDGc8rLQpQA2r5GE0PB3Q=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 92686C151536
	for <bpf@ietfa.amsl.com>; Thu,  3 Oct 2024 22:28:42 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjrIfJXNPL4k for <bpf@ietfa.amsl.com>;
	Thu,  3 Oct 2024 22:28:38 -0700 (PDT)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id E7F58C14F70F
	for <bpf@ietf.org>; Thu,  3 Oct 2024 22:28:37 -0700 (PDT)
Message-ID: <cebd5c08-717f-4130-9f8c-1f5bd101d767@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728019715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+84r6u5hzBSXVMYDdK7c7QxyHOJyEwxN5wdWpftiNvs=;
	b=KCCze5g4miCILJ5IaM3oEC9j0zjM24FV2Y8ZkxqD2d8TknpXKptMvoUqvChfWzeNL5ltU/
	WWsBcJ4ElitVqJoseCd4NIX+ZGu8dsFArm933WgLwQezHdolhI6XVpOGFlFaNHoSgil+Zf
	S8kNYLuZ1fkDGEfWwYUXllwfayJbaKk=
Date: Thu, 3 Oct 2024 22:28:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>,
 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>, bpf@ietf.org
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: HTMQKHVLXQ6UWBDM6EUNIKJ22SUEW5HH
X-Message-ID-Hash: HTMQKHVLXQ6UWBDM6EUNIKJ22SUEW5HH
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: 'bpf' <bpf@vger.kernel.org>, 'Alexei Starovoitov' <ast@kernel.org>,
 'Andrii Nakryiko' <andrii@kernel.org>,
 'Daniel Borkmann' <daniel@iogearbox.net>,
 'Martin KaFai Lau' <martin.lau@kernel.org>
X-Mailman-Version: 3.3.9rc5
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_docs/bpf=3A_Document_some_spe?=
 =?utf-8?q?cial_sdiv/smod_operations?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/nvaEmn-ydpHd0_0CvEzELp092FU>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQpPbiAxMC8xLzI0IDEyOjU0IFBNLCBEYXZlIFRoYWxlciB3cm90ZToNCj4gWW9uZ2hvbmcgU29u
ZyA8eW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY+IHdyb3RlOg0KPj4gT24gOS8zMC8yNCA2OjUwIFBN
LCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6DQo+Pj4gT24gVGh1LCBTZXAgMjYsIDIwMjQgYXQg
ODozOeKAr1BNIFlvbmdob25nIFNvbmcgPHlvbmdob25nLnNvbmdAbGludXguZGV2Pg0KPj4gd3Jv
dGU6DQo+Pj4+IFBhdGNoIFsxXSBmaXhlZCBwb3NzaWJsZSBrZXJuZWwgY3Jhc2ggZHVlIHRvIHNw
ZWNpZmljIHNkaXYvc21vZA0KPj4+PiBvcGVyYXRpb25zIGluIGJwZiBwcm9ncmFtLiBUaGUgZm9s
bG93aW5nIGFyZSByZWxhdGVkIG9wZXJhdGlvbnMgYW5kDQo+Pj4+IHRoZSBleHBlY3RlZCByZXN1
bHRzIG9mIHRob3NlIG9wZXJhdGlvbnM6DQo+Pj4+ICAgICAtIExMT05HX01JTi8tMSA9IExMT05H
X01JTg0KPj4+PiAgICAgLSBJTlRfTUlOLy0xID0gSU5UX01JTg0KPj4+PiAgICAgLSBMTE9OR19N
SU4lLTEgPSAwDQo+Pj4+ICAgICAtIElOVF9NSU4lLTEgPSAwDQo+Pj4+DQo+Pj4+IFRob3NlIG9w
ZXJhdGlvbnMgYXJlIHJlcGxhY2VkIHdpdGggY29kZXMgd2hpY2ggd29uJ3QgY2F1c2Uga2VybmVs
DQo+Pj4+IGNyYXNoLiBUaGlzIHBhdGNoIGRvY3VtZW50cyB3aGF0IG9wZXJhdGlvbnMgbWF5IGNh
dXNlIGV4Y2VwdGlvbiBhbmQNCj4+Pj4gd2hhdCByZXBsYWNlbWVudCBvcGVyYXRpb25zIGFyZS4N
Cj4+Pj4NCj4+Pj4gICAgIFsxXQ0KPj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NDA5MTMxNTAzMjYuMTE4Nzc4OC0xLXlvbmdob25nLnNvbmdAbGkNCj4+Pj4gbnV4LmRldi8NCj4+
Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWW9uZ2hvbmcgU29uZyA8eW9uZ2hvbmcuc29uZ0BsaW51
eC5kZXY+DQo+Pj4+IC0tLQ0KPj4+PiAgICAuLi4vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVj
dGlvbi1zZXQucnN0ICAgfCAyNSArKysrKysrKysrKysrKystLS0tDQo+Pj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNl
dC5yc3QNCj4+Pj4gYi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rp
b24tc2V0LnJzdA0KPj4+PiBpbmRleCBhYjgyMGQ1NjUwNTIuLmQxNTBjMWQ3YWQzYiAxMDA2NDQN
Cj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9u
LXNldC5yc3QNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2lu
c3RydWN0aW9uLXNldC5yc3QNCj4+Pj4gQEAgLTM0NywxMSArMzQ3LDI2IEBAIHJlZ2lzdGVyLg0K
Pj4+PiAgICAgID09PT09ICA9PT09PSAgPT09PT09PQ0KPj4+PiA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+Pj4+DQo+Pj4+ICAgIFVu
ZGVyZmxvdyBhbmQgb3ZlcmZsb3cgYXJlIGFsbG93ZWQgZHVyaW5nIGFyaXRobWV0aWMgb3BlcmF0
aW9ucywNCj4+Pj4gbWVhbmluZyAtdGhlIDY0LWJpdCBvciAzMi1iaXQgdmFsdWUgd2lsbCB3cmFw
LiBJZiBCUEYgcHJvZ3JhbQ0KPj4+PiBleGVjdXRpb24gd291bGQgLXJlc3VsdCBpbiBkaXZpc2lv
biBieSB6ZXJvLCB0aGUgZGVzdGluYXRpb24gcmVnaXN0ZXIgaXMgaW5zdGVhZCBzZXQNCj4+IHRv
IHplcm8uDQo+Pj4+IC1JZiBleGVjdXRpb24gd291bGQgcmVzdWx0IGluIG1vZHVsbyBieSB6ZXJv
LCBmb3IgYGBBTFU2NGBgIHRoZSB2YWx1ZSBvZg0KPj4+PiAtdGhlIGRlc3RpbmF0aW9uIHJlZ2lz
dGVyIGlzIHVuY2hhbmdlZCB3aGVyZWFzIGZvciBgYEFMVWBgIHRoZSB1cHBlcg0KPj4+PiAtMzIg
Yml0cyBvZiB0aGUgZGVzdGluYXRpb24gcmVnaXN0ZXIgYXJlIHplcm9lZC4NCj4+Pj4gK3RoZSA2
NC1iaXQgb3IgMzItYml0IHZhbHVlIHdpbGwgd3JhcC4gVGhlcmUgYXJlIGFsc28gYSBmZXcNCj4+
Pj4gK2FyaXRobWV0aWMgb3BlcmF0aW9ucyB3aGljaCBtYXkgY2F1c2UgZXhjZXB0aW9uIGZvciBj
ZXJ0YWluDQo+Pj4+ICthcmNoaXRlY3R1cmVzLiBTaW5jZSBjcmFzaGluZyB0aGUga2VybmVsIGlz
IG5vdCBhbiBvcHRpb24sIHRob3NlIG9wZXJhdGlvbnMgYXJlDQo+PiByZXBsYWNlZCB3aXRoIGFs
dGVybmF0aXZlIG9wZXJhdGlvbnMuDQo+Pj4+ICsNCj4+Pj4gKy4uIHRhYmxlOjogQXJpdGhtZXRp
YyBvcGVyYXRpb25zIHdpdGggcG9zc2libGUgZXhjZXB0aW9ucw0KPj4+PiArDQo+Pj4+ICsgID09
PT09ICA9PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4gPT09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4+Pj4gKyAgbmFtZSAgIGNsYXNzICAgICAgIG9yaWdpbmFs
ICAgICAgICAgICAgICAgICAgICAgICByZXBsYWNlbWVudA0KPj4+PiArICA9PT09PSAgPT09PT09
PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+ID09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+Pj4+ICsgIERJViAgICBBTFU2NC9BTFUgICBkc3QgLz0gMCAgICAgICAgICAg
ICAgICAgICAgICAgZHN0ID0gMA0KPj4+PiArICBTRElWICAgQUxVNjQvQUxVICAgZHN0IHMvPSAw
ICAgICAgICAgICAgICAgICAgICAgIGRzdCA9IDANCj4+Pj4gKyAgTU9EICAgIEFMVTY0ICAgICAg
IGRzdCAlPSAwICAgICAgICAgICAgICAgICAgICAgICBkc3QgPSBkc3QgKG5vIHJlcGxhY2VtZW50
KQ0KPj4+PiArICBNT0QgICAgQUxVICAgICAgICAgZHN0ICU9IDAgICAgICAgICAgICAgICAgICAg
ICAgIGRzdCA9ICh1MzIpZHN0DQo+Pj4+ICsgIFNNT0QgICBBTFU2NCAgICAgICBkc3QgcyU9IDAg
ICAgICAgICAgICAgICAgICAgICAgZHN0ID0gZHN0IChubyByZXBsYWNlbWVudCkNCj4+Pj4gKyAg
U01PRCAgIEFMVSAgICAgICAgIGRzdCBzJT0gMCAgICAgICAgICAgICAgICAgICAgICBkc3QgPSAo
dTMyKWRzdA0KPiBBbGwgb2YgdGhlIGFib3ZlIGFyZSBhbHJlYWR5IGNvdmVyZWQgaW4gZXhpc3Rp
bmcgVGFibGUgNSBhbmQgaW4gbXkgb3Bpbmlvbg0KPiBkb24ndCBuZWVkIHRvIGJlIHJlcGVhdGVk
Lg0KDQpUaGlzIHRyaWVzIHRvIHNlcGFyYXRlIGNhc2VzIGJldHdlZW4gQUxVIGFuZCBBTFU2NC4g
QnV0IEkgYWdyZWUgdGhhdCB0aGUgdGFibGUNCjUgc2hvdWxkIGJlIGdvb2QgZW5vdWdoLg0KDQo+
DQo+IFRoYXQgaXMsIHRoZSAib3JpZ2luYWwiIGlzIG5vdCB3aGF0IFRhYmxlIDUgaGFzLCBzbyBq
dXN0IGludHJvZHVjZXMgY29uZnVzaW9uDQo+IGluIHRoZSBkb2N1bWVudCBpbiBteSBvcGluaW9u
Lg0KPg0KPj4+PiArICBTRElWICAgQUxVNjQgICAgICAgZHN0IHMvPSAtMSAoZHN0ID0gTExPTkdf
TUlOKSAgIGRzdCA9IExMT05HX01JTg0KPj4+PiArICBTRElWICAgQUxVICAgICAgICAgZHN0IHMv
PSAtMSAoZHN0ID0gSU5UX01JTikgICAgIGRzdCA9ICh1MzIpSU5UX01JTg0KPj4+PiArICBTTU9E
ICAgQUxVNjQgICAgICAgZHN0IHMlPSAtMSAoZHN0ID0gTExPTkdfTUlOKSAgIGRzdCA9IDANCj4+
Pj4gKyAgU01PRCAgIEFMVSAgICAgICAgIGRzdCBzJT0gLTEgKGRzdCA9IElOVF9NSU4pICAgICBk
c3QgPSAwDQo+IFRoZSBhYm92ZSBmb3VyIGFyZSB0aGUgbmV3IG9uZXMgYW5kIEknZCBwcmVmZXIg
YSBzb2x1dGlvbiB0aGF0IG1vZGlmaWVzDQo+IGV4aXN0aW5nIHRhYmxlIDUuICBFLmcuIHRhYmxl
IDUgaGFzIG5vdyBmb3IgU01PRDoNCj4NCj4gZHN0ID0gKHNyYyAhPSAwKSA/IChkc3QgcyUgc3Jj
KSA6IGRzdA0KPg0KPiBhbmQgY291bGQgaGF2ZSBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPg0KPiBk
c3QgPSAoc3JjID09IDApID8gZHN0IDogKChzcmMgPT0gLTEgJiYgZHN0ID09IElOVF9NSU4pID8g
MCA6IChkc3QgcyUgc3JjKSkNCg0KVGhhbmtzLiBUaGlzIGluZGVlZCBzaW1wbGVyLiBJIGNhbiBk
byB0aGlzLg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

