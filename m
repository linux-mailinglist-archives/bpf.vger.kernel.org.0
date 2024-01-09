Return-Path: <bpf+bounces-19257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC30828560
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 12:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A831F21C6D
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DEC3716A;
	Tue,  9 Jan 2024 11:45:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cstnet.cn (smtp85.cstnet.cn [159.226.251.85])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08360374C4;
	Tue,  9 Jan 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [114.245.34.24] ) by
 ajax-webmail-APP-13 (Coremail) ; Tue, 9 Jan 2024 19:45:27 +0800 (GMT+08:00)
Date: Tue, 9 Jan 2024 19:45:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Greg KH" <gregkh@linuxfoundation.org>, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: proposal to refine capability checks when _rlimit_overlimit()
 is true
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
In-Reply-To: <20240103173002.GB136592@mit.edu>
References: <1a8ed7bd.c96e.18ccd4ee4d1.Coremail.mengjingzi@iie.ac.cn>
 <2024010353-legwarmer-flap-869d@gregkh> <20240103173002.GB136592@mit.edu>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7d2df0e7.174cd.18cee0ab373.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:twCowADX38_YMZ1lkGcFAA--.51763W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiCRELE2Wc6oLuzQABsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SSB1bmRlcnN0YW5kIGNoYW5nZSB0aGUgY29kZSBoZXJlIG1heSBhZmZlY3QgdGhlIHdvcmxkIG91
dHNpZGUgdGhlCmtlcm5lbC4gQW5kIHRoZXJlIG1pZ2h0IGJlIHVzZWFiaWxpdHkgaXNzdWVzIHdo
ZW4gYXBwbGljYXRpb25zIGluIAp1c2Vyc3BhY2UgYXJlIG5vdCB1cGRhdGVkLiBCdXQgdGhlIGdv
b2QgbmV3cyBpcyB0aGF0IHRoZSAKbW9kaWZpY2F0aW9uJ3MgaW1wYWN0IG9uIHVzZXJzcGFjZSBp
cyByZWxhdGl2ZWx5IGNvbnRhaW5lZC4gCkhlcmUncyBhIGJyZWFrZG93bjogCgoxLiBVc2FnZSBz
dGF0aXN0aWNzIGZvciB0aGUgbGF0ZXN0IHZlcnNpb24gb2YgVWJ1bnR1IHNob3cgdGhhdCAKICAg
YXBwbGljYXRpb25zIGhhdmUgbGltaXRlZCB1c2Ugb2YgY2FwYWJpbGl0eS4gCiAgICAgICAgKDEp
IFVuZGVyIHRoZSBkZWZhdWx0IGNvbmZpZ3VyYXRpb24sIG9ubHkgMjggcHJvY2Vzc2VzIGluIAog
ICAgICAgICAgICBVYnVudHUgMjIuMDQgTFRTIHdlcmUgZm91bmQgdG8gaGF2ZSBjYXBhYmlsaXR5
LCB3aXRoIDE1IAogICAgICAgICAgICBydW5uaW5nIGFzIHJvb3QgYW5kIHVuYWZmZWN0ZWQgYnkg
dGhlIHByb3Bvc2VkIGNoYW5nZS4gCiAgICAgICAgKDIpIEFtb25nIHRoZSA1OWsgcGFja2FnZXMg
b24gVWJ1bnR1IDIxLjEwLCBvbmx5IDI5IHByb2dyYW1zIAogICAgICAgICAgICB3ZXJlIGNvbmZp
Z3VyZWQgd2l0aCBjYXBhYmlsaXR5LlsxXQoKMi4gRm9yIHByb2dyYW1zIHRoYXQgdXNlIGNhcGFi
aWxpdHksIGl0IGlzIG5vdCBjb21wbGljYXRlZCBmb3IgZGV2ZWxvcGVycwogICBvciBzeXNhZG1p
biB0byByZWNvbmZpZ3VyZSBpdC4gUHJvZ3JhbXMgdXNpbmcgY2FwYWJpbGl0eSBjYW4gYmUgCiAg
IGNhdGVnb3JpemVkIGludG8gdHdvIHR5cGVzOiAKICAgICAgICAoMSkgdGhvc2Ugc3RhcnRlZCBi
eSByb290IGhhdmUgZnVsbCBjYXBhYmlsaXR5IGJ5IGRlZmF1bHQsIHdoaWNoIAogICAgICAgICAg
ICBjYW4gYmUgY2hhbmdlZCB3aXRoIHRoZSBwcmN0bCBzeXN0ZW0gY2FsbC4KICAgICAgICAoMikg
YW5kIHRob3NlIHdpdGggY2FwYWJpbGl0aWVzIGNvbmZpZ3VyZWQgZGlyZWN0bHkgb24gdGhlIAog
ICAgICAgICAgICBleGVjdXRhYmxlIGZpbGUgY2FuIGJlIG1vZGlmaWVkIGJ5IHNlY2FwIGNvbW1h
bmQgZGlyZWN0bHkuCgpTbyB0aGUga2V5IHRvIHVzaW5nIGNhcGFiaWxpdHkgaXMgdG8gY2hvb3Nl
IHRoZSBsZWFzdCBwcml2aWxlZ2UgdGhhdCAKd2lsbCBhY2NvbXBsaXNoIHRoZSBmdW5jdGlvbi4g
VGhpcyBjYW4ndCBiZSBkb25lIHdpdGhvdXQgdGhlIGtlcm5lbCdzIApjbGVhciBkZWxpbmVhdGlv
biBvZiBwcml2aWxlZ2VzLgoKVGhpcyBjaGFuZ2Ugd2lsbCBtYWtlIGl0IGNsZWFyIHRoYXQgaWYg
eW91IG9ubHkgbmVlZCB0byBjcm9zcyBzeXN0ZW0gCmxpbWl0cywgdGhlbiBzeXNfcmVzb3VyY2Ug
aXMgdGhlIGNhcGFiaWxpdHkgeW91IG5lZWQuIFRoaXMgbWF5IGNhdXNlIApzb21lIHByb2Nlc3Nl
cyB0aGF0IGFyZSB1c2luZyBzeXNfYWRtaW4gdG8gYnlwYXNzIGxpbWl0cyB0byBmYWlsLCBidXQg
CmZyb20gYSBsZWFzdCBwcml2aWxlZ2UgcG9pbnQgb2YgdmlldywgaXQgbWF5IGJlIGdvb2QgdG8g
cmVkdWNlIHRoZSAKdW5uZWNlc3NhcnkgdXNlIG9mIHN5c19hZG1pbi4KCkJlc3QgcmVnYXJkcywK
SmluZ3ppCgpbMV0gSGFzYW4sIE1kIE1laGVkaSwgU2V5ZWRoYW1lZCBHaGF2YW1uaWEsIGFuZCBN
aWNoYWxpcyBQb2x5Y2hyb25ha2lzLiAKICAgICJEZWNhcDogRGVwcml2aWxlZ2luZyBwcm9ncmFt
cyBieSByZWR1Y2luZyB0aGVpciBjYXBhYmlsaXRpZXMuIiAKICAgIFByb2NlZWRpbmdzIG9mIHRo
ZSAyNXRoIEludGVybmF0aW9uYWwgU3ltcG9zaXVtIG9uIFJlc2VhcmNoIGluIEF0dGFja3MsCiAg
ICBJbnRydXNpb25zIGFuZCBEZWZlbnNlcy4gMjAyMi4K

