Return-Path: <bpf+bounces-50017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1DA21675
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 03:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACFF16707A
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB8188A0E;
	Wed, 29 Jan 2025 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="cemsClvi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="cemsClvi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AnTFkeq3"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1B18C31
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738116957; cv=none; b=r6vdv08VKZrZvq4k8XnAEs8LzhNX0A3bLj7GPFRTqQBCHBFvLJRBoszIHpDfR3gf8L/jQz1dsG1kdZmZhaysRX0nQctkJSRWVtQp/thXGCGNo/cwz7hpLUEcTiT0v+iUqKTTJdjQ6TFJkWiC5ob49MnfLIcNxBi1gSEx9o1m8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738116957; c=relaxed/simple;
	bh=JfjE4Nuzc0ERvp7gWZd4mPNRIZrTOOONHFk2jNBOekM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:To:In-Reply-To:
	 References:CC:Subject; b=t2Iukv5kLLc+j/A531lYJJVbjpZtwzF8VgT9YNxqKo55nIS6CWLks3yNXreJq4DjbwLq0A33BFdur5FCxCwhe+D16CL9+qJmSNmpKgsUy5eQA/KihoGcDugYHHrS1wbG5MQ8aGQXJO9CyIq/terif3BLTQiSsaDq6j+r7M/0aTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=cemsClvi; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=cemsClvi; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AnTFkeq3 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4C012C1D6FCC
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 18:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1738116592; bh=JfjE4Nuzc0ERvp7gWZd4mPNRIZrTOOONHFk2jNBOekM=;
	h=Date:From:To:In-Reply-To:References:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=cemsClviN7/kasX0i5XSI4zv5aZghXrkyJIX091vy1zH0u4RSL3V7pYIPgy1H1FJD
	 FoiBFh/ZtQI+9wmB3jvpZ/TgmdusmJXzKgQ4OjqDTVKX/hgDsNlYlcd4141XbZSQjB
	 F/oreOx1618On7C31pumReW+5t8Cjxp0r1TZig9k=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Tue Jan 28 18:09:52 2025
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 31C4EC1D6219
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 18:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1738116592; bh=JfjE4Nuzc0ERvp7gWZd4mPNRIZrTOOONHFk2jNBOekM=;
	h=Date:From:To:In-Reply-To:References:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=cemsClviN7/kasX0i5XSI4zv5aZghXrkyJIX091vy1zH0u4RSL3V7pYIPgy1H1FJD
	 FoiBFh/ZtQI+9wmB3jvpZ/TgmdusmJXzKgQ4OjqDTVKX/hgDsNlYlcd4141XbZSQjB
	 F/oreOx1618On7C31pumReW+5t8Cjxp0r1TZig9k=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1F76CC16940B
	for <bpf@ietfa.amsl.com>; Tue, 28 Jan 2025 18:07:59 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.104
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpeOWYJQOAJE for <bpf@ietfa.amsl.com>;
	Tue, 28 Jan 2025 18:07:54 -0800 (PST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id A401DC1840EA
	for <bpf@ietf.org>; Tue, 28 Jan 2025 18:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738116467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxFwu5R7sxps9teXeOqSJ8ZpqQ5AyDlKfsho2IFEN1o=;
	b=AnTFkeq3b6TXFV6Ogt+Be6Mxklk3mFNdKxoBTZMKGjv6z+kBP4niiHFyeIBStgFb7sVpbT
	oOwaxOX7a5wNxuuCCkE6tjzYZd1dMMsCcTK6c3H9dcSb7ufLnFXhrKmmT5fk/ewLKEaj5v
	1cVaY9C0o3MvHlI9WMsie9posK2fu+M=
Date: Wed, 29 Jan 2025 02:07:45 +0000
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <bda935ed074d3151d9afe02df06f026b8ea30690@linux.dev>
TLS-Required: No
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Peilin Ye"
 <yepeilin@google.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <131a817f7f2749e78e527a251ca7971588cf62f8.camel@gmail.com>
References: <cover.1737763916.git.yepeilin@google.com>
 <3f2de7c6e5d2def7bdfb091347c1dacea0915974.1737763916.git.yepeilin@google.com>
 <131a817f7f2749e78e527a251ca7971588cf62f8.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: K7OY6ONTQJFWARVQOA4HZL7FWQRQ2QCE
X-Message-ID-Hash: K7OY6ONTQJFWARVQOA4HZL7FWQRQ2QCE
X-MailFrom: ihor.solodrai@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
 David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai  Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP  Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will  Deacon <will@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>,
 Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next_v1_7/8=5D_selftests/bpf=3A_Add_s?=
 =?utf-8?q?elftests_for_load-acquire_and_store-release_instructions?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/Ni5Q5q6DoPYjd9xA2INKvc3H7wY>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Transfer-Encoding: base64

SmFudWFyeSAyOCwgMjAyNSBhdCA1OjA2IFBNLCAiRWR1YXJkIFppbmdlcm1hbiIgPGVkZHl6ODdA
Z21haWwuY29tPiB3cm90ZToNCg0KDQoNCj4gDQo+IE9uIFNhdCwgMjAyNS0wMS0yNSBhdCAwMjox
OSArMDAwMCwgUGVpbGluIFllIHdyb3RlOg0KPiANCj4gPiANCj4gPiBBZGQgc2V2ZXJhbCAuL3Rl
c3RfcHJvZ3MgdGVzdHM6DQo+ID4gDQo+ID4gIA0KPiA+IA0KPiA+ICAtIGF0b21pY3MvbG9hZF9h
Y3F1aXJlDQo+ID4gDQo+ID4gIC0gYXRvbWljcy9zdG9yZV9yZWxlYXNlDQo+ID4gDQo+ID4gIC0g
YXJlbmFfYXRvbWljcy9sb2FkX2FjcXVpcmUNCj4gPiANCj4gPiAgLSBhcmVuYV9hdG9taWNzL3N0
b3JlX3JlbGVhc2UNCj4gPiANCj4gPiAgLSB2ZXJpZmllcl9sb2FkX2FjcXVpcmUvKg0KPiA+IA0K
PiA+ICAtIHZlcmlmaWVyX3N0b3JlX3JlbGVhc2UvKg0KPiA+IA0KPiA+ICAtIHZlcmlmaWVyX3By
ZWNpc2lvbi9icGZfbG9hZF9hY3F1aXJlDQo+ID4gDQo+ID4gIC0gdmVyaWZpZXJfcHJlY2lzaW9u
L2JwZl9zdG9yZV9yZWxlYXNlDQo+ID4gDQo+ID4gIA0KPiA+IA0KPiA+ICBUaGUgbGFzdCB0d28g
dGVzdHMgYXJlIGFkZGVkIHRvIGNoZWNrIGlmIGJhY2t0cmFja19pbnNuKCkgaGFuZGxlcyB0aGUN
Cj4gPiANCj4gPiAgbmV3IGluc3RydWN0aW9ucyBjb3JyZWN0bHkuDQo+ID4gDQo+ID4gIA0KPiA+
IA0KPiA+ICBBZGRpdGlvbmFsbHksIHRoZSBsYXN0IHRlc3QgYWxzbyBtYWtlcyBzdXJlIHRoYXQg
dGhlIHZlcmlmaWVyDQo+ID4gDQo+ID4gICJyZW1lbWJlcnMiIHRoZSB2YWx1ZSAoaW4gc3JjX3Jl
Zykgd2Ugc3RvcmUtcmVsZWFzZSBpbnRvIGUuZy4gYSBzdGFjaw0KPiA+IA0KPiA+ICBzbG90LiBG
b3IgZXhhbXBsZSwgaWYgd2UgdGFrZSBhIGxvb2sgYXQgdGhlIHRlc3QgcHJvZ3JhbToNCj4gPiAN
Cj4gPiAgDQo+ID4gDQo+ID4gICMwOiAicjEgPSA4OyINCj4gPiANCj4gPiAgIzE6ICJzdG9yZV9y
ZWxlYXNlKCh1NjQgKikocjEwIC0gOCksIHIxKTsiDQo+ID4gDQo+ID4gICMyOiAicjEgPSAqKHU2
NCAqKShyMTAgLSA4KTsiDQo+ID4gDQo+ID4gICMzOiAicjIgPSByMTA7Ig0KPiA+IA0KPiA+ICAj
NDogInIyICs9IHIxOyIgLyogbWFya19wcmVjaXNlICovDQo+ID4gDQo+ID4gICM1OiAicjAgPSAw
OyINCj4gPiANCj4gPiAgIzY6ICJleGl0OyINCj4gPiANCj4gPiAgDQo+ID4gDQo+ID4gIEF0ICMx
LCBpZiB0aGUgdmVyaWZpZXIgZG9lc24ndCByZW1lbWJlciB0aGF0IHdlIHdyb3RlIDggdG8gdGhl
IHN0YWNrLA0KPiA+IA0KPiA+ICB0aGVuIGxhdGVyIGF0ICM0IHdlIHdvdWxkIGJlIGFkZGluZyBh
biB1bmJvdW5kZWQgc2NhbGFyIHZhbHVlIHRvIHRoZQ0KPiA+IA0KPiA+ICBzdGFjayBwb2ludGVy
LCB3aGljaCB3b3VsZCBjYXVzZSB0aGUgcHJvZ3JhbSB0byBiZSByZWplY3RlZDoNCj4gPiANCj4g
PiAgDQo+ID4gDQo+ID4gIFZFUklGSUVSIExPRzoNCj4gPiANCj4gPiAgPT09PT09PT09PT09PQ0K
PiA+IA0KPiA+ICAuLi4NCj4gPiANCj4gPiAgbWF0aCBiZXR3ZWVuIGZwIHBvaW50ZXIgYW5kIHJl
Z2lzdGVyIHdpdGggdW5ib3VuZGVkIG1pbiB2YWx1ZSBpcyBub3QgYWxsb3dlZA0KPiA+IA0KPiA+
ICANCj4gPiANCj4gPiAgQWxsIG5ldyB0ZXN0cyBkZXBlbmQgb24gdGhlIHByZS1kZWZpbmVkIF9f
QlBGX0ZFQVRVUkVfTE9BRF9BQ1FfU1RPUkVfUkVMDQo+ID4gDQo+ID4gIGZlYXR1cmUgbWFjcm8s
IHdoaWNoIGltcGxpZXMgLW1jcHU+PXY0Lg0KPiA+IA0KPiANCj4gVGhpcyByZXN0cmljdGlvbiB3
b3VsZCBtZWFuIHRoYXQgdGVzdHMgYXJlIHNraXBwZWQgb24gQlBGIENJLCBhcyBpdA0KPiANCj4g
Y3VycmVudGx5IHJ1bnMgdXNpbmcgbGx2bSAxNyBhbmQgMTguIEluc3RlYWQsIEkgc3VnZ2VzdCB1
c2luZyBzb21lDQoNCkVkdWFyZCwgaWYgdGhpcyBmZWF0dXJlIHJlcXVpcmVzIGEgcGFydGljdWxh
ciB2ZXJzaW9uIG9mIExMVk0sIGl0J3MNCm5vdCBkaWZmaWN1bHQgdG8gYWRkIGEgY29uZmlndXJh
dGlvbiBmb3IgaXQgdG8gQlBGIENJLg0KDQpXaGV0aGVyIHdlIHdhbnQgdG8gZG8gaXQgaXMgYW4g
b3BlbiBxdWVzdGlvbiB0aG91Z2guIElzc3VlcyBtYXkgY29tZQ0KdXAgd2l0aCBvdGhlciB0ZXN0
cyB3aGVuIG5ld2VyIExMVk0gaXMgdXNlZC4NCg0KPiANCj4gbWFjcm8gaGlkaW5nIGFuIGlubGlu
ZSBhc3NlbWJseSBhcyBiZWxvdzoNCj4gDQo+ICBhc20gdm9sYXRpbGUgKCIuOGJ5dGUgJVtpbnNu
XTsiDQo+IA0KPiAgOg0KPiANCj4gIDogW2luc25dImkiKCoobG9uZyAqKSYoQlBGX1JBV19JTlNO
KC4uLikpKQ0KPiANCj4gIDogLyogY29ycmVjdCBjbG9iYmVycyBoZXJlICovKTsNCj4gDQo+IFNl
ZSB0aGUgdXNhZ2Ugb2YgdGhlIF9faW1tX2luc24oKSBtYWNybyBpbiB0aGUgdGVzdCBzdWl0ZS4N
Cj4gDQo+IEFsc28sICJCUEZfQVRPTUlDIGxvYWRzIGZyb20gUiVkICVzIGlzIG5vdCBhbGxvd2Vk
XG4iIGFuZA0KPiANCj4gICJCUEZfQVRPTUlDIHN0b3JlcyBpbnRvIFIlZCAlcyBpcyBub3QgYWxs
b3dlZFxuIg0KPiANCj4gc2l0dWF0aW9ucyBhcmUgbm90IHRlc3RlZC4NCj4gDQo+IFsuLi5dDQo+
IA0KPiA+IA0KPiANCj4gWy4uLl0NCj4NCg0KLS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGll
dGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3Jn
Cg==

