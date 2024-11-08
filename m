Return-Path: <bpf+bounces-44382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8759C2548
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B5B2848B8
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE91AA1C7;
	Fri,  8 Nov 2024 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="i/1uxg+x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="i/1uxg+x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VdgJVHgx"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486541A9B33
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092495; cv=none; b=i4hT+IayJrdwxMz/Tq0pMgs8TQlVcsBuNKdBoux8CbFpEu7CDoQWPHDH40IE9eldh5I3aT3/RWm7/T1v91O2XZDsmGjpXxP/p09mCbrKd1vfhWv7GRR3sZPT49zpsjmMWQxYL7ETVwVgYeqMc/Yvu53IW4GrEwNOZYyUK4ivMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092495; c=relaxed/simple;
	bh=a9wAjsX7Vl2yNSamZUo1rO325CQ1FFJRUBHkmLbLguA=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:CC:
	 Subject:Content-Type; b=usSTG2/SWsQrflnbTR++pEfFk/vKz3rdUWPZHNyjnxeEbMn0F3+Lsw36QAgm188SW/0uebcxF67ak6zSnEn4wnM0nWt5Nq9wTCtgsS0fJdILIrnSuVaMd9xTZJgl8mTMqMgd93IIiJvTCukwfzEFNIHMNRhF8hHENxlAPgJrnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=i/1uxg+x; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=i/1uxg+x; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VdgJVHgx reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A38B9C1E0D8A
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 11:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731092482; bh=a9wAjsX7Vl2yNSamZUo1rO325CQ1FFJRUBHkmLbLguA=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=i/1uxg+xgRZ2KkjPXkMHPgLveJEWUzJwmKDz/L9B9rhqOjUZsAChr4omSUab8yAKh
	 IE4Wci9Xj6j2HCG0GexH9i9M9/vB4SDlB36VyIgudBsgyMDYYFpkXNIfPIvJVYmm8i
	 DxN4blCRv3ShIO0GQOXSE3e4cJixOhQnJtvnyfB0=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Fri Nov  8 11:01:22 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 81C9DC15793B
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 11:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731092482; bh=a9wAjsX7Vl2yNSamZUo1rO325CQ1FFJRUBHkmLbLguA=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=i/1uxg+xgRZ2KkjPXkMHPgLveJEWUzJwmKDz/L9B9rhqOjUZsAChr4omSUab8yAKh
	 IE4Wci9Xj6j2HCG0GexH9i9M9/vB4SDlB36VyIgudBsgyMDYYFpkXNIfPIvJVYmm8i
	 DxN4blCRv3ShIO0GQOXSE3e4cJixOhQnJtvnyfB0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id A231CC14F70D
	for <bpf@ietfa.amsl.com>; Fri,  8 Nov 2024 11:01:11 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S41Xtq_3Orqz for <bpf@ietfa.amsl.com>;
	Fri,  8 Nov 2024 11:01:06 -0800 (PST)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id C9C13C14F6B7
	for <bpf@ietf.org>; Fri,  8 Nov 2024 11:01:06 -0800 (PST)
Message-ID: <ae954e1c-46c0-4ee6-90b4-5b17880dba22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731092463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VoGK5QITX3hxcu+xCYFruci6yig+fA5PNRRZt9qp3EI=;
	b=VdgJVHgxpUb5RzU0utX/2nSQE0ysgYDDaFQVvih9glcnumhZb5g9oYmxFd1v+qZWxDd7DH
	/yHNcYc/OSISwDJjXbdC+j8t9GPXT9pr72q1oCeefISQrYyvmjeF2zB1X/zohLtT6loRW5
	ubrEQnLZ0lnes0EpoEH8eLccvcShq8c=
Date: Fri, 8 Nov 2024 11:00:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>,
 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
 <000c01db3186$1dd30930$59791b90$@gmail.com>
 <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
 <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: FOK2EEFDFN7VSIY332PGWCM25353L7PF
X-Message-ID-Hash: FOK2EEFDFN7VSIY332PGWCM25353L7PF
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, 'bpf' <bpf@vger.kernel.org>,
 'Alexei Starovoitov' <ast@kernel.org>, 'Andrii Nakryiko' <andrii@kernel.org>,
 'Daniel Borkmann' <daniel@iogearbox.net>,
 'Martin KaFai Lau' <martin.lau@kernel.org>
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_docs/bpf=3A_Document_some_spe?=
 =?utf-8?q?cial_sdiv/smod_operations?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/Al9de8_5PfvpLjjEao69cZV_ZNo>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCg0KT24gMTEvOC8yNCAxMDo1MyBBTSwgRGF2ZSBUaGFsZXIgd3JvdGU6DQo+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogQWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWku
c3Rhcm92b2l0b3ZAZ21haWwuY29tPg0KPj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA4LCAyMDI0
IDEwOjM4IEFNDQo+PiBUbzogRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29t
Pg0KPj4gQ2M6IFlvbmdob25nIFNvbmcgPHlvbmdob25nLnNvbmdAbGludXguZGV2PjsgYnBmQGll
dGYub3JnOyBicGYNCj4+IDxicGZAdmdlci5rZXJuZWwub3JnPjsgQWxleGVpIFN0YXJvdm9pdG92
IDxhc3RAa2VybmVsLm9yZz47IEFuZHJpaSBOYWtyeWlrbw0KPj4gPGFuZHJpaUBrZXJuZWwub3Jn
PjsgRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47IE1hcnRpbiBLYUZhaSBM
YXUNCj4+IDxtYXJ0aW4ubGF1QGtlcm5lbC5vcmc+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIGJw
Zi1uZXh0XSBkb2NzL2JwZjogRG9jdW1lbnQgc29tZSBzcGVjaWFsIHNkaXYvc21vZA0KPj4gb3Bl
cmF0aW9ucw0KPj4NCj4+IE9uIFRodSwgTm92IDcsIDIwMjQgYXQgNjozMOKAr1BNIERhdmUgVGhh
bGVyIDxkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbT4NCj4+IHdyb3RlOg0KPj4+DQo+Pj4gQWxl
eGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4+
Pj4gT24gVHVlLCBPY3QgMSwgMjAyNCBhdCAxMjo1NOKAr1BNIERhdmUgVGhhbGVyDQo+Pj4+IDxk
dGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbT4NCj4+Pj4gd3JvdGU6DQo+Pj4gWy4uLl0NCj4+Pj4+
IEknbSBhZGRpbmcgYnBmQGlldGYub3JnIHRvIHRoZSBUbyBsaW5lIHNpbmNlIGFsbCBjaGFuZ2Vz
IGluIHRoZQ0KPj4+Pj4gc3RhbmRhcmRpemF0aW9uIGRpcmVjdG9yeSBzaG91bGQgaW5jbHVkZSB0
aGF0IG1haWxpbmcgbGlzdC4NCj4+Pj4+DQo+Pj4+PiBUaGUgV0cgc2hvdWxkIGRpc2N1c3Mgd2hl
dGhlciBhbnkgY2hhbmdlcyBzaG91bGQgYmUgZG9uZSB2aWEgYSBuZXcNCj4+Pj4+IFJGQyB0aGF0
IG9ic29sZXRlcyB0aGUgZmlyc3Qgb25lLCBvciBhcyBSRkNzIHRoYXQgVXBkYXRlIGFuZCBqdXN0
DQo+Pj4+PiBkZXNjcmliZSBkZWx0YXMgKGFkZGl0aW9ucywgZXRjLikuDQo+Pj4+Pg0KPj4+Pj4g
VGhlcmUgYXJlIHByZWNlZGVudHMgYm90aCB3YXlzIGFuZCBJIGRvbid0IGhhdmUgYSBzdHJvbmcN
Cj4+Pj4+IHByZWZlcmVuY2UsIGJ1dCBJIGhhdmUgYSB3ZWFrIHByZWZlcmVuY2UgZm9yIGRlbHRh
LWJhc2VkIG9uZXMNCj4+Pj4+IHNpbmNlIHRoZXkncmUgc2hvcnRlciBhbmQgYXJlIGxlc3MgbGlr
ZWx5IHRvIHJlLW9wZW4gZGlzY3Vzc2lvbiBvbg0KPj4+Pj4gcHJldmlvdXNseSByZXNvbHZlZCBp
c3N1ZXMsIHRodXMgb2Z0ZW4gc2F2aW5nIHRoZSBXRyB0aW1lLg0KPj4+PiBEZWx0YS1iYXNlZCBh
ZGRpdGlvbnMgbWFrZSBzZW5zZSB0byBtZS4NCj4+Pj4NCj4+Pj4+IEFsc28gRllJIHRvIExpbnV4
IGtlcm5lbCBmb2xrczoNCj4+Pj4+IFdpdGggV0cgYW5kIEFEIGFwcHJvdmFsLCBpdCdzIGFsc28g
cG9zc2libGUgKGJ1dCBub3QgaWRlYWwpIHRvDQo+Pj4+PiB0YWtlIGNoYW5nZXMgYXQgQVVUSDQ4
LiAgVGhhdCdkIGJlIHVwIHRvIHRoZSBjaGFpcnMgYW5kIEFEIHRvDQo+Pj4+PiBkZWNpZGUgdGhv
dWdoLCBhbmQgbm9ybWFsbHkgdGhhdCdzIGp1c3QgZm9yIHB1cmVseSBlZGl0b3JpYWwNCj4+Pj4+
IGNsYXJpZmljYXRpb25zLCBlLmcuLCB0byBjb25mdXNpb24gY2FsbGVkIG91dCBieSB0aGUgUkZD
IGVkaXRvciBwYXNzLg0KPj4+PiBBbHNvIGFncmVlLiBXZSBzaG91bGQga2VlcCBBVVRIIGdvaW5n
IGl0cyBjb3Vyc2UgYXMtaXMuDQo+Pj4+IEFsbCBJU0EgYWRkaXRpb25zIGNhbiBiZSBpbiB0aGUg
ZnV0dXJlIGRlbHRhIFJGQy4NCj4+Pj4NCj4+Pj4gQXMgZmFyIGFzIGZpbGUgbG9naXN0aWNzLi4u
IG15IHByZWZlcmVuY2UgaXMgdG8ga2VlcA0KPj4+PiBEb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFy
ZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPj4+PiB1cCB0byBkYXRlLg0KPj4+PiBSaWdo
dCBub3cgaXQncyBlZmZlY3RpdmVseSBmcm96ZW4gd2hpbGUgYXdhaXRpbmcgY2hhbmdlcyAoaWYg
YW55KSBuZWNlc3NhcnkgZm9yDQo+PiBBVVRILg0KPj4+PiBBZnRlciBvZmZpY2lhbCBSRkMgaXMg
aXNzdWVkIHdlIGNhbiBzdGFydCBsYW5kaW5nIHBhdGNoZXMgaW50bw0KPj4+PiBpbnN0cnVjdGlv
bi1zZXQucnN0IGFuZCBnaXQgZGlmZiAwNGVmYWViZDcyZDEuLndoYXRldmVyX2Z1dHVyZV9zaGEN
Cj4+Pj4gaW5zdHJ1Y3Rpb24tc2V0LnJzdCB3aWxsIGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGUgdGhl
IGZ1dHVyZSBkZWx0YSBSRkMuDQo+Pj4+IE9uY2UgUkZDIG51bWJlciBpcyBpc3N1ZWQgd2UgY2Fu
IGFkZCBhIGdpdCB0YWcgZm9yIHRoZSBwYXJ0aWN1bGFyDQo+Pj4+IHNoYSB0aGF0IHdhcyB0aGUg
YmFzZSBmb3IgUkZDIGFzIGEgZG9jdW1lbnRhdGlvbiBzdGVwIGFuZCB0byBzaW1wbGlmeSBmdXR1
cmUgJ2dpdA0KPj4gZGlmZicuDQo+Pj4gTXkgY29uY2VybiBpcyB0aGF0IGluZGV4LnJzdCBzYXlz
Og0KPj4+PiBUaGlzIGRpcmVjdG9yeSBjb250YWlucyBkb2N1bWVudHMgdGhhdCBhcmUgYmVpbmcg
aXRlcmF0ZWQgb24gYXMgcGFydA0KPj4+PiBvZiB0aGUgQlBGIHN0YW5kYXJkaXphdGlvbiBlZmZv
cnQgd2l0aCB0aGUgSUVURi4gU2VlIHRoZSBgSUVURiBCUEYNCj4+Pj4gV29ya2luZyBHcm91cGBf
IHBhZ2UgZm9yIHRoZSB3b3JraW5nIGdyb3VwIGNoYXJ0ZXIsIGRvY3VtZW50cywgYW5kIG1vcmUu
DQo+Pj4gU28gaGF2aW5nIGEgZG9jdW1lbnQgdGhhdCBpcyBOT1QgcGFydCBvZiB0aGUgSUVURiBC
UEYgV29ya2luZyBHcm91cA0KPj4+IHdvdWxkIHNlZW0gb3V0IG9mIHBsYWNlIGFuZCwgaW4gbXkg
dmlldywgYmV0dGVyIGxvY2F0ZWQgdXAgYSBsZXZlbCAob3V0c2lkZQ0KPj4gc3RhbmRhcmRpemF0
aW9uKS4NCj4+DQo+PiBJdCdzIGEgcGFydCBvZiBicGYgd2cuIEl0J3Mgbm90IGEgbmV3IGRvY3Vt
ZW50Lg0KPiBSRkMgOTY2OSBpcyBpbW11dGFibGUuICBBbnkgYWRkaXRpb25zIHJlcXVpcmUgYSBu
ZXcgZG9jdW1lbnQsIGluDQo+IElFVEYgdGVybWlub2xvZ3ksIHNpbmNlIHdvdWxkIHJlc3VsdCBp
biBhIG5ldyBSRkMgbnVtYmVyLg0KPg0KPj4+IEhlcmXigJlzIHNvbWUgZXhhbXBsZXMgb2YgZGVs
dGEtYmFzZWQgUkZDcyB3aGljaCBleHBsYWluIHRoZSBnYXAgYW5kDQo+Pj4gcHJvdmlkZSB0aGUg
YWRkaXRpb24gb3IgY2xhcmlmaWNhdGlvbiwgYW5kIGZvcm1hbGx5IFVwZGF0ZSAobm90DQo+Pj4g
cmVwbGFjZS9vYnNvbGV0ZSkgdGhlIG9yaWdpbmFsDQo+Pj4gUkZDOg0KPj4+ICogaHR0cHM6Ly93
d3cucmZjLWVkaXRvci5vcmcvcmZjL3JmYzY1ODUuaHRtbDogQWRkaXRpb25hbCBIVFRQIFN0YXR1
cw0KPj4+IENvZGVzDQo+Pj4gKiBodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjNjg0
MC5odG1sOiBDbGFyaWZpY2F0aW9ucyBhbmQgSW1wbGVtZW50YXRpb24NCj4+IE5vdGVzDQo+Pj4g
ICAgIGZvciBETlMgU2VjdXJpdHkgKEROU1NFQykNCj4+PiAqIGh0dHBzOi8vd3d3LnJmYy1lZGl0
b3Iub3JnL3JmYy9yZmM5Mjk1Lmh0bWw6IENsYXJpZmljYXRpb25zIGZvciBFZDI1NTE5LCBFZDQ0
OCwNCj4+PiAgICAgWDI1NTE5LCBhbmQgWDQ0OCBBbGdvcml0aG0gSWRlbnRpZmllcnMNCj4+PiAq
IGh0dHBzOi8vd3d3LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmM1NzU2Lmh0bWw6IFVwZGF0ZXMgZm9y
IFJTQUVTLU9BRVAgYW5kDQo+Pj4gICAgIFJTQVNTQS1QU1MgQWxnb3JpdGhtIFBhcmFtZXRlcnMN
Cj4+Pg0KPj4+IEhhdmluZyBhIGZ1bGwgZG9jdW1lbnQgdG9vIGlzIHZhbHVhYmxlIGJ1dCB1bmxl
c3MgdGhlIElFVEYgQlBGIFdHDQo+Pj4gZGVjaWRlcyB0byB0YWtlIG9uIGEgLWJpcyBkb2N1bWVu
dCwgSSdkIHN1Z2dlc3Qga2VlcGluZyBpdCBvdXQgb2YgdGhlDQo+PiAic3RhbmRhcmRpemF0aW9u
Ig0KPj4+IChzYXkgdXAgMSBsZXZlbCkgdG8gYXZvaWQgY29uZnVzaW9uLCBhbmQganVzdCBoYXZl
IG9uZSBvciBtb3JlDQo+Pj4gZGVsdGEtYmFzZWQgcnN0IGZpbGVzIGluIHRoZSBzdGFuZGFyZGl6
YXRpb24gZGlyZWN0b3J5Lg0KPj4gVGhpcyBwYXRjaCBpcyBlZmZlY3RpdmVseSBhIGZpeCB0byB0
aGUgc3RhbmRhcmQuDQo+IFR3byBvZiB0aGUgZXhhbXBsZXMgSSBwcm92aWRlZCBhYm92ZSBmaXQg
aW50byB0aGF0IGNhdGVnb3J5Lg0KPiBUd28gYXJlIGV4YW1wbGVzIG9mIGFkZGluZyBuZXcgY29k
ZXBvaW50cy4NCj4NCj4+IEl0J3MgYSBzdGFuZGFyZCBnaXQgZGV2ZWxvcG1lbnQgcHJvY2VzcyB3
aGVuIGZpeGVzIGFyZSBhcHBsaWVkIHRvIHRoZSBleGlzdGluZw0KPj4gZG9jdW1lbnQuDQo+PiBG
b3JraW5nIHRoZSB3aG9sZSBkb2MgaW50byBhIGRpZmZlcmVudCBmaWxlIGp1c3QgdG8gYXBwbHkg
Zml4ZXMgbWFrZXMgbm8gc2Vuc2UgdG8gbWUuDQo+IFdlbGNvbWUgdG8gdGhlIElFVEYgYW5kIGlt
bXV0YWJsZSBSRkNzIPCfmIoNCj4NCj4+IFRoZSBmb3JtYWwgZGVsdGEtcyBmb3IgSUVURiBjYW4g
YmUgY3JlYXRlZCBvdXQgb2YgZ2l0Lg0KPiBOb3QgaW4gdGhlIElFVEYgcGVyIHNlLCBzaW5jZSBh
IG5ldyBkb2N1bWVudCBuZWVkcyBuZXcgYm9pbGVycGxhdGUsIHdpdGgNCj4gYSBuZXcgYWJzdHJh
Y3QsIGludHJvZHVjdGlvbiwgZXRjLiAgQXQgbW9zdCwgcGFydCBvZiB0aGUgZG9jdW1lbnQgY291
bGQgYmUgY3JlYXRlZA0KPiBvdXQgb2YgZ2l0LCBidXQgSSdtIG5vdCBjb252aW5jZWQgdGhhdCBn
aXQgZGlmZnMgYWxvbmUgKGFzIG9wcG9zZWQgdG8gc29tZSBFbmdsaXNoDQo+IHByb3NlIHRvbyBm
b3IgZWFjaCwgYXMgaW4gdGhlIGV4YW1wbGVzIEkgY2l0ZWQpIG1ha2UgZm9yIGdvb2QgY29udGVu
dCBpbiBhbiBJRVRGIGRvY3VtZW50Lg0KPg0KPj4gV2Ugb25seSBuZWVkIHRvIHRhZyB0aGUgY3Vy
cmVudCB2ZXJzaW9uIGFuZCB0aGVuIGdpdCBkaWZmIHJmYzk2NjlfdGFnLi5IRUFEIHdpbGwgZ2l2
ZQ0KPj4gdXMgdGhhdCBkZWx0YS4NCj4+IFRoYXQgd2lsbCBzYXRpc2Z5IElFVEYgcHJvY2VzcyBh
bmQgd29uJ3QgbWVzcyB1cCBub3JtYWwgZ2l0IHN0eWxlIGtlcm5lbA0KPj4gZGV2ZWxvcG1lbnQu
DQo+IEkgYW0gbm90IGNvbnZpbmNlZCBpdCBpcyBzdWZmaWNpZW50LiAgQ2FuIHlvdSBwb2ludCB0
byBhbnkgcHJlY2VkZW50cyBpbiB0aGUgSUVURiBmb3INCj4gc3VjaCBhbiBhcHByb2FjaD8gIEkg
Y2FuJ3Qgb2ZmaGFuZC4uLiBTZWUgdGhlIFJGQyA1NzU2IHJlZmVyZW5jZSBhYm92ZSBmb3Igd2hh
dA0KPiBJIG1lYW4gYnkgRW5nbGlzaCBwcm9zZSBmb3IgZWFjaCBkaWZmLg0KDQpJIHRoaW5rIHdl
IGNhbiBhZGQgc3VmZmljaWVudCBkZXRhaWxzIGluIHRoZSBjb21taXQgbWVzc2FnZS4gV2hhdCB0
aGluZ3Mgd2UgbmVlZCB0bw0KcHV0IGluIHRoZSBjb21taXQgbWVzc2FnZSB0byBzYXRpc2Z5IHRo
ZSBySUVURiBlcXVpcmVtZW50Pw0KDQo+PiBidHcgZG8gd2Ugc3RpbGwgbmVlZCB0byBkbyBhbnkg
bWlub3IgZWRpdC9maXhlcyB0byBpbnN0cnVjdGlvbi1zZXQucnN0IGJlZm9yZSB0YWdnaW5nIGl0
DQo+PiBhcyBSRkM5NjY5ID8NCj4gWWVzLCB3ZSBuZWVkIHRvIGJhY2twb3J0IHRoZSBmb3JtYXR0
aW5nL25pdHMgZnJvbSB0aGUgUkZDIGVkaXRvciBwYXNzLg0KPg0KPiBEYXZlDQo+DQoNCi0tIApC
cGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVt
YWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

