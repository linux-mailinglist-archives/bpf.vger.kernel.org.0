Return-Path: <bpf+bounces-6712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD476CF38
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15751C212A7
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657BD79EC;
	Wed,  2 Aug 2023 13:52:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8F79CF
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 13:52:17 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DEB5132
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=BwYwS9IvLIQ1qLwiLMb8Y+Q91OkLS566wJ6kOfNUjI4=; b=lfNXV66eD7P8R
	TNYgjjeYOBFKfOU7tV0alyoHKfaHm5QVjr5JYLwQIc1XtYbdmyYPD0lX28xcOVZi
	sZ/J3JZTfpeeNNu+Fwq1bD0MU3BVRxGOLqpqcKAvRE4dFlZLBb+Z3JkoV0Vwe0QP
	P0026FghZ6MACqdqp77T6sFJOzGZNA=
Received: from chang-liu22$mails.tsinghua.edu.cn ( [46.101.12.37] ) by
 ajax-webmail-web2 (Coremail) ; Wed, 2 Aug 2023 21:52:05 +0800 (GMT+08:00)
X-Originating-IP: [46.101.12.37]
Date: Wed, 2 Aug 2023 21:52:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5YiY55WF?= <chang-liu22@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Subject: The performance of reading BPF_MAP_TYPE_ARRAY map in user space is
 bad
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d323010.38a19.189b6852245.Coremail.chang-liu22@mails.tsinghua.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yQQGZQCHibSGX8pkIWpICg--.22220W
X-CM-SenderInfo: xfkd0wonol3j2s6ptxtovo32xlqjx3vdohv3gofq/1tbiAgELAGTJ
	jT6JrgAAsx
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgYWxsLAoKSSBuZWVkIHRvIHNlbmQgdHJhY2UgZGF0YSBmcm9tIGluLWtlcm5lbCBlQlBGIHBy
b2dyYW1zIHRvIHVzZXIgc3BhY2UuIEkgaGF2ZSB0d28gY2hvaWNlcywgdGhlIGZpcnN0IGlzIHN0
b3JpbmcgdHJhY2VzIGluIGEgQlBGX01BUF9UWVBFX0FSUkFZIG1hcCwgYW5kIHRoZSB1c2VyIHNw
YWNlIGNvbnN1bWVyIHB1bGxzIHRyYWNlcyBmcm9tIGl0LiBUaGUgc2Vjb25kIGlzIHN0b3Jpbmcg
dHJhY2VzIGluIGEgQlBGX01BUF9UWVBFX1BST0dfQVJSQVkgbWFwIHVzaW5nIGJwZl9wZXJmX2V2
ZW50X291dHB1dCgpLCBhbmQgdGhlIHVzZXIgc3BhY2UgY29uc3VtZXIgcmVhZHMgdHJhY2VzIGlu
IHRoZSBjYWxsYmFjayBmdW5jdGlvbiBpbnZva2VkIGJ5IHBlcmZfYnVmZmVyX19wb2xsKCkuIEkg
ZGlkIHNpbXBsZSBwZXJmb3JtYW5jZSB0ZXN0cyBhbmQgZm91bmQgdGhlIHR3byBtZXRob2RzIGhh
dmUgc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UgZGlmZmVyZW5jZS4KCkZvciB0aGUgZmlyc3QgbWV0
aG9kIChwdWxsaW5nIGZyb20gYSBCUEZfTUFQX1RZUEVfQVJSQVkgbWFwKSwgSSBzZXQgdXAgYW4g
YXJyYXkgbWFwIG9mIDY1NTM2IGVudHJpZXMgYW5kIDQwIGJ5dGVzIHZhbHVlIHNpemUsIHRoZW4g
cHVsbCBlbnRyaWVzIGluIHVzZXIgc3BjYWUgZm9yIDEwTSB0aW1lcywgYW5kIGl0IGNvc3RzIDMu
N3MgaW4gYXZlcmFnZS4KCkZvciB0aGUgc2Vjb25kIG1ldGhvZCwgSSBhbGxvY2F0ZSAyTUIgbWVt
b3J5IGZvciB0aGUgcGVyZiBidWZmZXIgb2YgZWFjaCBDUFUuIFRoZSB1c2VyIHNwYWNlIGNvbnN1
bWVyIGNhbGxzIHBlcmZfYnVmZmVyX19wb2xsKCkgaW4gYW4gaW5maW5pdGUgbG9vcC4gVG8gZ2Vu
ZXJhdGUgZW5vdWdoIHRyYWNlcywgSSBhdHRhY2ggYW4gZWJwZiBwcm9ncmFtIGF0IHRoZSBzeXNf
ZW50ZXJfcmVhZCB0cmFjZXBvaW50IHdoaWNoIHdpbGwgZ2VuZXJhdGUgMTAwIHRyYWNlcyBpbiBh
biBleGVjdXRpb24sIGFuZCBydW4gYSB1c2VyIHNwYWNlIHByb2dyYW0gdG8gY2FsbCB0aGUgcmVh
ZCgpIHN5c3RlbSBjYWxsIGluIGFuIGluZmluaXRlIGxvb3AgdG8gdHJpZ2dlciB0aGUgZWJwZiBw
cm9ncmFtLiBUaGUgcmVzdWx0IGlzLCBpdCB0YWtlcyAxMCsgc2Vjb25kcyB0byBnZXQgMTBNIHRy
YWNlcyB1c2luZyBwZXJmX2J1ZmZlcl9fcG9sbCgpLCB3aGljaCBpcyBtdWNoIHNsb3dlciB0aGFu
IHBvbGxpbmcgdGhlIGFycmF5LgoKVGhpcyBibG9nIChodHRwczovL25ha3J5aWtvLmNvbS9wb3N0
cy9icGYtcmluZ2J1Zi8pIHNheXMgdGhhdCBicGYgcGVyZiBidWZmZXIgaGFzIHRoZSBhYmlsaXR5
IHRvIGVmZmljaWVudGx5IHJlYWQgZGF0YSBmcm9tIHVzZXItc3BhY2UgdGhyb3VnaCBtZW1vcnkt
bWFwcGVkIHJlZ2lvbiB3aXRob3V0IGV4dHJhIG1lbW9yeSBjb3B5aW5nIGFuZC9vciBzeXNjYWxs
cyBpbnRvIHRoZSBrZXJuZWwsIHNvIEkgdGhvdWdoIGl0IHdvdWxkIGJlIGZhc3RlciB0aGFuIHJl
YWRpbmcgdGhlIGFycmF5IG1hcCwgd2hpY2ggbmVlZHMgdG8gaW52b2tlIHRoZSBicGYoKSBzeXN0
ZW0gY2FsbC4gQnV0IG15IHRlc3QgZ2l2ZXMgdGhlIG9wcG9zaXRlIHJlc3VsdC4gSSBydW4gdGhp
cyB0ZXN0IG9uIGEgc2VydmVyIHdpdGggNDggQ1BVIGNvcmVzIGFuZCAxODhHQiBtZW1vcnkuIFRo
ZSBPUyBpcyBVYnVudHUgMjAuMDQgd2l0aCBrZXJuZWwgdmVyc2lvbiA1LjQuMC4gSSB3b25kZXIg
aXMgdGhpcyByZXN1bHQgYXMgZXhwZWN0ZWQsIG9yIGRpZCBJIG92ZXJsb29rIHNvbWV0aGluZz8K
ClRoYW5rIHlvdSBmb3IgeW91ciBoZWxwIQoKQ2hhbmcgTGl1ClRzaW5naHVhIFVuaXZlcnNpdHks
IENoaW5h

