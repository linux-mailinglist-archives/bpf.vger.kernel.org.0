Return-Path: <bpf+bounces-30085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE98CA61F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 04:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8B6B21CE0
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DBAD51E;
	Tue, 21 May 2024 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nX3y13My";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nX3y13My";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FXERWRCD"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25921C15B
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258046; cv=none; b=WaUNplFz0bvd54bnugOOzw2wYd3iippTEPwlUjr5LhITpHjEzrbLVd8Pj3PTQJslo+5/JDAqPwuI3S3X7R0AqLP1NtU2S8O6CMb7U0tGqqrnPjIH+9DRSBgeWEWULm+k5P+lxpQsRsJLjKioxhxkEZ6IgwnjRhJk1aYvPjQfuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258046; c=relaxed/simple;
	bh=oGVUTghDb0n40j72Q+oe7k2Nsi48wFmLYIh+otDn9i0=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:CC:
	 Subject:Content-Type; b=MKoKgoLgcpsYO7ZMILdOhwV1tqM/xBePUVj1XkxQguAHwZkMkcSf96dUUaskc5WSddm7TVEjpmC0rnb2dGn0ZW6QYYibSVlh6D0gQDVleFHFQFQiqSZ/zUW2r4NqqeUBHddfbMHqNZDXYrp+a9xu/UyjYebd6dRbW+yLqW/aY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=nX3y13My; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=nX3y13My; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FXERWRCD reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 73C98C180B64
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 19:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716258044; bh=oGVUTghDb0n40j72Q+oe7k2Nsi48wFmLYIh+otDn9i0=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=nX3y13MyjMd/MERDMsZzv6HN/coyRdS0wgwDmjE9XYdx51h4lb8+Rp1bvflomRhA4
	 nYp3zk7TYmGUC7zxG6KnpU28nj/f80F8beyiPmAKZ8lO7M0zzI0/WMCP3huo0A7nQ/
	 Htf4yj1rSy2ZKF3mB0df7IsHo+EuUYsMnjh2oMuY=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Mon May 20 19:20:44 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 63A4EC169404
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 19:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716258044; bh=oGVUTghDb0n40j72Q+oe7k2Nsi48wFmLYIh+otDn9i0=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=nX3y13MyjMd/MERDMsZzv6HN/coyRdS0wgwDmjE9XYdx51h4lb8+Rp1bvflomRhA4
	 nYp3zk7TYmGUC7zxG6KnpU28nj/f80F8beyiPmAKZ8lO7M0zzI0/WMCP3huo0A7nQ/
	 Htf4yj1rSy2ZKF3mB0df7IsHo+EuUYsMnjh2oMuY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 17D7AC1516EB
	for <bpf@ietfa.amsl.com>; Mon, 20 May 2024 19:20:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.096
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id spG-xLdqs6s0 for <bpf@ietfa.amsl.com>;
	Mon, 20 May 2024 19:20:31 -0700 (PDT)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 167A7C14CE4D
	for <bpf@ietf.org>; Mon, 20 May 2024 19:20:30 -0700 (PDT)
X-Envelope-To: dthaler1968@googlemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716258027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfDpDl1wMdJJ6d7nOOuaBXPYvBfJ2aHMYt1CcXwdbTA=;
	b=FXERWRCDBahryJFKbcE+ZvI+AfYISFjtb0VobE97eGWkY9i3yozT40WFdAHfKbyDxymdWE
	NslOIJPfzfPAck32MwYdTgdIbs/k7mLqwbDAbQowP9/XS6P4pq3X4Q9iI0WuXvOOa5DztB
	+PPx0PmK9FPWNjsSsiOlhWw1fRZ3BsU=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: bpf@ietf.org
X-Envelope-To: dthaler1968@gmail.com
Message-ID: <c51d8c26-6b87-406d-a4a7-bedab6d0c9b0@linux.dev>
Date: Mon, 20 May 2024 19:20:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
References: <20240520215255.10595-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240520215255.10595-1-dthaler1968@gmail.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: RNMFYXJZU4B7VMRSUD4REUOEZ632ZFHS
X-Message-ID-Hash: RNMFYXJZU4B7VMRSUD4REUOEZ632ZFHS
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next_v2=5D_bpf=2C_docs=3A_clarify_sig?=
 =?utf-8?q?n_extension_of_64-bit_use_of_32-bit_imm?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/PC-RAUrN1xRjKvpAtvwh8SNxQao>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQpPbiA1LzIwLzI0IDM6NTIgUE0sIERhdmUgVGhhbGVyIHdyb3RlOg0KPiBpbW0gaXMgZGVmaW5l
ZCBhcyBhIDMyLWJpdCBzaWduZWQgaW50ZWdlci4NCj4NCj4ge01PViwgSywgQUxVNjR9IHNheXMg
aXQgZG9lcyAiZHN0ID0gc3JjIiAod2hlcmUgc3JjIGlzICdpbW0nKSBhbmQgaXQNCj4gZG9lcyBk
byBkc3QgPSAoczY0KWltbSwgd2hpY2ggaW4gdGhhdCBzZW5zZSBkb2VzIHNpZ24gZXh0ZW5kIGlt
bS4gVGhlIE1PVlNYDQo+IGluc3RydWN0aW9uIGlzIGV4cGxhaW5lZCBhcyBzaWduIGV4dGVuZGlu
Zywgc28gYWRkZWQgdGhlIGV4YW1wbGUgb2YNCj4ge01PViwgSywgQUxVNjR9IHRvIG1ha2UgdGhp
cyBtb3JlIGNsZWFyLg0KPg0KPiB7SkxFLCBLLCBKTVB9IHNheXMgaXQgZG9lcyAiUEMgKz0gb2Zm
c2V0IGlmIGRzdCA8PSBzcmMiICh3aGVyZSBzcmMgaXMgJ2ltbScsDQo+IGFuZCB0aGUgY29tcGFy
aXNvbiBpcyB1bnNpZ25lZCkuIFRoaXMgd2FzIGFwcGFyZW50bHkgYW1iaWd1b3VzIHRvIHNvbWUN
Cj4gcmVhZGVycyBhcyB0byB3aGV0aGVyIHRoZSBjb21wYXJpc29uIHdhcyAiZHN0IDw9ICh1NjQp
KHUzMilpbW0iIG9yDQo+ICJkc3QgPD0gKHU2NCkoczY0KWltbSIgc28gYWRkZWQgYW4gZXhhbXBs
ZSB0byBtYWtlIHRoaXMgbW9yZSBjbGVhci4NCj4NCj4gdjEgLT4gdjI6IEFkZHJlc3MgY29tbWVu
dHMgZnJvbSBZb25naG9uZw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFRoYWxlciA8ZHRoYWxl
cjE5NjhAZ29vZ2xlbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBZb25naG9uZyBTb25nIDx5b25naG9u
Zy5zb25nQGxpbnV4LmRldj4NCg0KLS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

