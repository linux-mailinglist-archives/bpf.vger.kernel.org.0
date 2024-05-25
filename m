Return-Path: <bpf+bounces-30592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C88F8CF037
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 18:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA3D1C20FE6
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A286243;
	Sat, 25 May 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="s4hDSXkP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Z5kY808r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YsA6NCRJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5BF4FC
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655686; cv=none; b=Swxt+xm0dMoxN1GgJZbADRGn/5BaYV8t6UOc1O1HXQyyZdiSBpg/NTGEw/rf6AAQ4CGaJsNMsYa+40YbHfV2FZJAnIDOijigw81iTZA9jyTGfOzpRSeMEPr+HtfKL6lzJMN/ZNO5sm9EdVrDecYNsQhK9ykgYszusuqUsWdDwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655686; c=relaxed/simple;
	bh=09IhztS/ubl6fE+9o7764aAXrbVm3QzkPBfhychV77M=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:CC:
	 Subject:Content-Type; b=lO0SL2RQPUgCbgGzTxEzirk7vB5VL9ZN6N8HATj/bng78BdIGkbn4VN5DEyFQSLLzplmPRL4+AMJrQo55wnwfJ1aaLR9JmzKkaFifWKrJTHp0fCERKsVSior1kgWW62lffA7BmHcx2DyBzyakNyPVAMp56AuNwM/8AM5lMfXcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=s4hDSXkP; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Z5kY808r; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YsA6NCRJ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AAFCCC14CF18
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716655684; bh=09IhztS/ubl6fE+9o7764aAXrbVm3QzkPBfhychV77M=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=s4hDSXkPm8WoR+9zulqU3gNCY1/rwOyVqOd7ZQ+XWuMvsJEs7WyJNlmY3gR4aqeCq
	 ai1/6G/Vn5RxAMXnXrKx7ZWuZYxCTwu4wOq03d0qv1D6GxwacX3SEyk5+aPccffO0n
	 mAsyOjJCeT16+c0IyS3af26+cUvT9nOKyDTIzXq4=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Sat May 25 09:48:04 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DA286C14F6EC
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716655683; bh=09IhztS/ubl6fE+9o7764aAXrbVm3QzkPBfhychV77M=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=Z5kY808rZiJ7cpTuhW289EPRT/DCBMjT7g2GbiA1nRLQGnxHYYoi5qV3Ax0Sq4UMk
	 kbXIf3e0BRjz6U04Qm/gIVCeWli+NLC/tdNN1cG3CHM2ulJDi21s+gzmhgUkxsUIzZ
	 Y5oyZOqRsjdAR8cpa1wOO7xQb+QwMIASigtdRO4U=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4348FC14F5ED
	for <bpf@ietfa.amsl.com>; Sat, 25 May 2024 09:47:56 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.096
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6VDHGXtfn-Jp for <bpf@ietfa.amsl.com>;
	Sat, 25 May 2024 09:47:52 -0700 (PDT)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id D3AC1C14F603
	for <bpf@ietf.org>; Sat, 25 May 2024 09:47:50 -0700 (PDT)
X-Envelope-To: dthaler1968@googlemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716655668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OHeLUnmbZjbaUZnPFFJJgxuAYMZJl3JfL88n959kPA=;
	b=YsA6NCRJRGkxXhv82Mu4j3UzOod3SIQqEGyI266HZMo+KSpawxlahW+oHgJoEdskmRejXg
	NQjG39ut2gWxPX2YlKePOaxHL0ppDt+OoItTLRplsJY3WRhegP451TjXvNLBaQ8MgJdkX7
	G0ui/NgC1I3O1qoNgLzNriA4MeMOrso=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: bpf@ietf.org
X-Envelope-To: dthaler1968@gmail.com
Message-ID: <317b6459-43e9-44b5-a7ee-3af094a131a0@linux.dev>
Date: Sat, 25 May 2024 09:47:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
References: <20240525153332.21355-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240525153332.21355-1-dthaler1968@gmail.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: DKKD32U5LHPZEH7YOOFPH3WI273B5FB6
X-Message-ID-Hash: DKKD32U5LHPZEH7YOOFPH3WI273B5FB6
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Clarify_call_l?=
	=?utf-8?q?ocal_offset?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/Y5d7yWol8QDA6slu0oalk_hiIzw>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQpPbiA1LzI1LzI0IDk6MzMgQU0sIERhdmUgVGhhbGVyIHdyb3RlOg0KPiBJbiB0aGUgSnVtcCBp
bnN0cnVjdGlvbnMgc2VjdGlvbiBpdCBleHBsYWlucyB0aGF0IHRoZSBvZmZzZXQgaXMNCj4gInJl
bGF0aXZlIHRvIHRoZSBpbnN0cnVjdGlvbiBmb2xsb3dpbmcgdGhlIGp1bXAgaW5zdHJ1Y3Rpb24i
Lg0KPiBCdXQgdGhlIHByb2dyYW0tbG9jYWwgc2VjdGlvbiBjb25mdXNpbmdseSBzYWlkICJyZWZl
cmVuY2VkIGJ5DQo+IG9mZnNldCBmcm9tIHRoZSBjYWxsIGluc3RydWN0aW9uLCBzaW1pbGFyIHRv
IEpBIi4NCj4NCj4gVGhpcyBwYXRjaCB1cGRhdGVzIHRoYXQgc2VudGVuY2Ugd2l0aCBjb25zaXN0
ZW50IHdvcmRpbmcsIHNheWluZw0KPiBpdCdzIHJlbGF0aXZlIHRvIHRoZSBpbnN0cnVjdGlvbiBm
b2xsb3dpbmcgdGhlIGNhbGwgaW5zdHJ1Y3Rpb24uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhdmUg
VGhhbGVyIDxkdGhhbGVyMTk2OEBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBZb25naG9uZyBTb25n
IDx5b25naG9uZy5zb25nQGxpbnV4LmRldj4NCg0KLS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBm
QGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYu
b3JnCg==

