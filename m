Return-Path: <bpf+bounces-18848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E964E82277C
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 04:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BA01C22D2B
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99594A31;
	Wed,  3 Jan 2024 03:12:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373E1A59A;
	Wed,  3 Jan 2024 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 11:12:28 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 11:12:28 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: proposal to refine capability checks when _rlimit_overlimit() is
 true
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
Message-ID: <1a8ed7bd.c96e.18ccd4ee4d1.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowAB3Qumd0JRl5xYDAA--.26354W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAYFE2WUwEQ2dgAAsp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhCgpXZSBvYnNlcnZlZCBhIHBvdGVudGlhbCByZWZpbmVtZW50IGluIHRoZSBrZXJuZWwvZm9y
ay5jIGxpbmUgMjM2OC4gQ3VycmVudGx5LCBib3RoIENBUF9TWVNfQURNSU4gYW5kIENBUF9TWVNf
UkVTT1VSQ0UgYXJlIGNoZWNrZWQgd2hlbiB0aGUgbGltaXQgaXMgb3ZlciBzeXN0ZW0gbGltaXQu
IFdlIHN1Z2dlc3QgY29uc2lkZXJpbmcgYW4gYWRqdXN0bWVudCB0byB1dGlsaXplIENBUF9TWVNf
UkVTT1VSQ0UgZXhjbHVzaXZlbHkuIEhlcmUncyBvdXIgcmF0aW9uYWxlIGZvciB0aGlzIHN1Z2dl
c3Rpb246CgooMSkgRGVmaW5lZCBDYXBhYmlsaXR5IGZvciBSZXNvdXJjZSBBY2Nlc3M6IEFjY29y
ZGluZyB0byB0aGUgY2FwYWJpbGl0eSBtYW51YWwgcGFnZVsxXSwgdGhlIGNhcGFiaWxpdHkgZXhw
bGljaXRseSBkZWZpbmVkIGZvciBieXBhc3NpbmcgcmVzb3VyY2UgbGltaXRzIGlzIENBUF9TWVNf
UkVTT1VSQ0UuIFRoaXMgY2FwYWJpbGl0eSBpcyBkZXNpZ25lZCB0byBwcm92aWRlIHRoZSBuZWNl
c3NhcnkgcHJpdmlsZWdlcyBmb3IgYWNjZXNzaW5nIHN5c3RlbSByZXNvdXJjZXMgd2l0aG91dCBv
dmVyLXByaXZpbGVnaW5nIHdpdGggdGhlIGJyb2FkZXIgQ0FQX1NZU19BRE1JTi4KCigyKSBNYWlu
dGFpbmluZyBMZWFzdCBQcml2aWxlZ2U6IENBUF9TWVNfQVNNSU4gaXMgYWxyZWFkeSBvdmVybG9h
ZGVkIGFuZCBrbm93biBhcyB0aGUgbmV3ICJyb290IlsyXS4gVGhlIHVzZSBvZiBDQVBfU1lTX0FE
TUlOIGluIHRoaXMgY29udGV4dCBtaWdodCBpbmFkdmVydGVudGx5IG92ZXItcHJpdmlsZWdlIHRo
ZSBzeXN0ZW0gYnkgcHJvdmlkaW5nIG1vcmUgY2FwYWJpbGl0aWVzIHRoYW4gbmVjZXNzYXJ5LiBB
bmQgYWNjb3JkaW5nIHRvIGNhcGFiaWxpdHkgbWFudWFsIHBhZ2VbMV0sIOKAnERvbid0IGNob29z
ZSBDQVBfU1lTX0FETUlOIGlmIHlvdSBjYW4gcG9zc2libHkgYXZvaWQgaXQh4oCdLCBpdCdzIGJl
bmVmaWNpYWwgdG8gdXNlIHRoZSBtb3N0IHNwZWNpZmljIGNhcGFiaWxpdHkgcmVxdWlyZWQgZm9y
IGEgZ2l2ZW4gdGFzay4KClRoaXMgaXNzdWUgZXhpc3RzIGluIHNldmVyYWwga2VybmVsIHZlcnNp
b25zIGFuZCB3ZSBoYXZlIGNoZWNrZWQgaXQgb24gdGhlIGxhdGVzdCBzdGFibGUgcmVsZWFzZShM
aW51eCA2LjYuOSkuCgpZb3VyIGluc2lnaHRzIGFuZCBmZWVkYmFjayBvbiB0aGlzIHByb3Bvc2Vk
IG1vZGlmaWNhdGlvbiB3b3VsZCBiZSBoaWdobHkgYXBwcmVjaWF0ZWQuIFRoYW5rIHlvdSBmb3Ig
eW91ciB0aW1lIGFuZCBjb25zaWRlcmF0aW9uLgoKQmVzdCByZWdhcmRzLApKaW5nemkKCnJlZmVy
ZW5jZToKWzFdIGh0dHBzOi8vd3d3Lm1hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW43L2NhcGFi
aWxpdGllcy43Lmh0bWwKWzJdIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy80ODYzMDYv

