Return-Path: <bpf+bounces-18845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C930282271B
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 03:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509701F22662
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 02:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB364A14;
	Wed,  3 Jan 2024 02:46:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390D469F;
	Wed,  3 Jan 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 10:45:35 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 10:45:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, brauner@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: capability checks in sk_setsockopt() and __sock_cmsg_send()
 inconsistent with the documentation
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5f96b80d.c739.18ccd3646b8.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowADHKupPypRlsBMDAA--.32349W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAcFE2WUwEQhAgABsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhIAoKV2UndmUgaWRlbnRpZmllZCByZWR1bmRhbnQgY2FwYWJpbGl0eSBjaGVja3Mgd2l0aGlu
IHRoZSBza19zZXRzb2Nrb3B0KCkgYW5kIF9fc29ja19jbXNnX3NlbmQoKSBmdW5jdGlvbnMsIHNw
ZWNpZmljYWxseSByZWxhdGVkIHRvIHRoZSBvcHRpb25zIFNPX01BUksgYW5kIFNPX1BSSU9SSVRZ
LgoKQ3VycmVudGx5LCBib3RoIENBUF9ORVRfQURNSU4gYW5kIENBUF9ORVRfUkFXIGFyZSB1c2Vk
IGZvciB0aGVzZSBjaGVja3MsIGFuZCB3ZSBwcm9wb3NlIHNpbXBsaWZ5aW5nIHRoaXMgYnkgZXhj
bHVzaXZlbHkgdXNpbmcgQ0FQX05FVF9BRE1JTi4gT3VyIHJhdGlvbmFsZSBpcyBiYXNlZCBvbiB0
aGUgZGVmaW5pdGlvbnMgcHJvdmlkZWQgaW4gdGhlIGNhcGFiaWxpdHkgbWFudWFsIHBhZ2UoaHR0
cHM6Ly93d3cubWFuNy5vcmcvbGludXgvbWFuLXBhZ2VzL21hbjcvY2FwYWJpbGl0aWVzLjcuaHRt
bCksIHdoaWNoIHNwZWNpZmllcyB0aGF0IG9ubHkgQ0FQX05FVF9BRE1JTiBpcyByZXF1aXJlZCBm
b3IgdXNpbmcgc2V0c29ja29wdCgyKSB0byBzZXQgU09fUFJJT1JJVFksIFNPX0RFQlVHLCBhbmQg
U09fTUFSSy4gQWRkaXRpb25hbGx5LCB3ZSd2ZSBvYnNlcnZlZCB0aGF0IFNPX0RFQlVHIGlzIGFs
cmVhZHkgcHJvdGVjdGVkIHNvbGVseSBieSBDQVBfTkVUX0FETUlOLgoKU2ltcGxpZnlpbmcgdGhl
IGNhcGFiaWxpdHkgY2hlY2tzIGluIHRoZXNlIGZ1bmN0aW9ucyB0byBvbmx5IHVzZSBDQVBfTkVU
X0FETUlOIHdvdWxkIG5vdCBvbmx5IGFsaWduIHdpdGggdGhlIGNhcGFiaWxpdHkgbWFudWFsIHBh
Z2UgYnV0IGFsc28gY29udHJpYnV0ZSB0byBhIG1vcmUgc3RyYWlnaHRmb3J3YXJkIGFuZCBjb25z
aXN0ZW50IGNvZGViYXNlLgoKVGhpcyBpc3N1ZSBleGlzdHMgaW4gc2V2ZXJhbCBrZXJuZWwgdmVy
c2lvbnMgYW5kIHdlIGhhdmUgY2hlY2tlZCBpdCBvbiB0aGUgbGF0ZXN0IHN0YWJsZSByZWxlYXNl
KExpbnV4IDYuNi45KS4KCllvdXIgaW5zaWdodHMgYW5kIGZlZWRiYWNrIG9uIHRoaXMgcHJvcG9z
ZWQgYWRqdXN0bWVudCB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLiBUaGFuayB5b3UgZm9y
IHlvdXIgdGltZSBhbmQgY29uc2lkZXJhdGlvbi4KCkJlc3QgcmVnYXJkcywKSmluZ3ppCg==

