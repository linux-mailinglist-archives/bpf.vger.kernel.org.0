Return-Path: <bpf+bounces-29182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A118C10F5
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CB81C227F3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6915ECD5;
	Thu,  9 May 2024 14:07:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABD15E7F2
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263646; cv=none; b=YeX/jg1ug+KhLUZdyd5VOVZ55FnziKQkf342zxyVD4+Y84tlCbLQwUpfzdGmrV3qA4hJ8uFABbWZ71042auT2tLKV3m8QC0Nphpy5KGeSAcnveZN/3wF+EHHlhkdvGAzeTE5nDtSPjJZxMF0sVriihiSLAlk3mjB4uxz6aKN57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263646; c=relaxed/simple;
	bh=jJ6COoDyboK6CudoW1aSw0s83iA4aIK2PD9q3QRyivM=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=Jsz2ereinbgr0jzWfZf6aQsgI0AnFPzQbz+hEhBM+as7UdWMlyheocZWH1lB6Q85S3Y53QHut+X9AETO/EjFUAFgBaUBUKeB50Hi7tnL/UwjAnzHZT9zg81joNU1TRVhWm1Oyivs/RRQfkwC7tm0kFm95mc7Uxda5VRSDbq3f8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.nwpu.edu.cn; spf=pass smtp.mailfrom=mail.nwpu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.nwpu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.nwpu.edu.cn
Received: from nwpu.edu.cn (unknown [123.125.94.243])
	by gateway (Coremail) with SMTP id _____wAn_n6R2DxmuVQDAA--.8999S3;
	Thu, 09 May 2024 22:07:14 +0800 (CST)
Received: from sekiro_meng$mail.nwpu.edu.cn ( [123.125.94.243] ) by
 ajax-webmail-app (Coremail) ; Thu, 9 May 2024 22:07:12 +0800 (GMT+08:00)
Date: Thu, 9 May 2024 22:07:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f56Wl5a6H?= <sekiro_meng@mail.nwpu.edu.cn>
To: bpf@vger.kernel.org
Subject: [BPF Security] what security properties does verifier guarantee?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220310(96b739b2)
 Copyright (c) 2002-2024 www.mailtech.cn nwpu.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2147ee76.10bf3.18f5dadf442.Coremail.sekiro_meng@mail.nwpu.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQGowADXkOWQ2DxmWa8cAQ--.37692W
X-CM-SenderInfo: pvhnx2prbpv03j6ptxnooq41vxohv3gofq/1tbiAQMMA2Y8vvkS0w
	ACsT
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF1rJrWrZF4fJr1xXw4fZwc_yoWkZFX_ua
	sYywn5Jws29r45GrZF9F4Ivr9rW3yDuF10q3s7WFZagF4DZr98X395Jr12qryxJw4aqrn8
	tF43Aw15Gryj9osvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACY4xI67k042
	43AVAKzVAKj4xxM4xvF2IEb7IF0Fy26I8I3I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMVCE
	FcxC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU1SoGPUUUUU==

U2luY2UgZUJQRiB2ZXJpZmllciBvZnRlbiBjaGFuZ2VzLCBpcyB0aGVyZSBhIGNvbmNsdXNpb24g
dGhhdCBsaXN0IGFsbCB0aGUgc2VjdXJpdHkgcHJvcGVydGllcyB2ZXJpZmllciBndWFyYW50ZWVz
PyBXaXRoIHRoZSBjb25jbHVzaW9uLCBkZXZlbG9wZXJzIHdvbuKAmXQgbWFrZSB0aGUgc2FtZSBt
aXN0YWtlcyBkdWUgdG8gbWlzc2luZyBzb21lIHNlY3VyaXR5IHByb3BlcnR5IGNoZWNrcy4KClNp
bmNlIHdlIGRpZG7igJl0IGZpbmQgYW55IHB1YmxpYyBkb2N1bWVudCB0byBkZXNjcmliZSB0aGUg
c2VjdXJpdHkgcHJpbmNpcGxlcyBvZiB0aGUgdmVyaWZpZXIsIHdlIGhhdmUgcmVhZCBtb3N0IG9m
IHRoZSBjaGVja3MgaW4gaXQsIGVzcGVjaWFsbHkgZm9yIHRoZSBmdWxsLXBhdGggYW5hbHlzaXMg
KGBkb19jaGVjaygpYCkgYW5kIHJlbGF0ZWQgZnVuY3Rpb24sIGFuZCB3ZSBzdW1tYXJpemVkIHRo
ZSBzZWN1cml0eSBwcm9wZXJ0aWVzIChmb3IgdGhlIHN0cmljdGVzdCBjYXNlKSBhcyBmb2xsb3dz
OgoKMS4gTWVtb3J5IFNhZmV0eToKMS4xIFByb2dyYW1zIGNhbiBvbmx5IGFjY2VzcyBCUEYgbWVt
b3J5IGFuZCBzcGVjaWZpYyBrZXJuZWwgb2JqZWN0cyBzdWNoIGFzIGNvbnRleHQuCgoyLiBJbmZv
cm1hdGlvbiBMZWFrYWdlIFByZXZlbnRpb246CjIuMSBQcm9ncmFtcyBjYW5ub3Qgd3JpdGUgcG9p
bnRlcnMgaW50byBtYXBzLCBhbmQgY2FsY3VsYXRpb24gYW1vbmcgcG9pbnRlcnMgaXMgbm90IGFs
bG93ZWQuCjIuMiBQcm9ncmFtcyBjYW5ub3QgcmVhZCB1bmluaXRpYWxpemVkIG1lbW9yeS4KMi4z
IFByb2dyYW1zIGNhbm5vdCBzcGVjdWxhdGl2ZWx5IGFjY2VzcyBhcmVhcyBvdXRzaWRlIHRoZSBC
UEYgcHJvZ3JhbeKAmXMgbWVtb3J5LgoKMy4gRG9TIFByZXZlbnRpb246CjMuMSBQcm9ncmFtcyBj
YW5ub3QgY3Jhc2ggd2hpbGUgZXhlY3V0aW5nLgozLjIgUHJvZ3JhbXMgY2Fubm90IGV4ZWN1dGUg
Zm9yIHRvbyBsb25nLgoKSXMgbXkgc3VtbWFyeSByaWdodCBhbmQgY29tcHJlaGVuc2l2ZT8gSSBo
b3BlIHdlIGNhbiBuZWdvdGlhdGUgYSBtYW51YWwgdG8gY29uY2x1ZGUgdGhlIHNlY3VyaXR5IHBy
b3BlcnRpZXMsIHNvIHRoYXQgZGV2ZWxvcGVycyBjYW4gaGF2ZSBhIHJlZmVyZW5jZS4=


