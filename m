Return-Path: <bpf+bounces-9181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6976791639
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A061C20831
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D83D78;
	Mon,  4 Sep 2023 11:27:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A71FD6
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 11:27:12 +0000 (UTC)
X-Greylist: delayed 920 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 04:27:10 PDT
Received: from m1326.mail.163.com (m1326.mail.163.com [220.181.13.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52A3BE3;
	Mon,  4 Sep 2023 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=oOrvVEuXehCrhaRUsZ2VCWXmwU+bjnfYSuYNWyrf6qI=; b=a
	qGWbqkNYcFjwMjnHxKN2lK9U6fZkJldhS+2BgRMkx9nijw/KeHXrbyYpriiLjaEy
	ARPP84jxYEm9IU+OK0UJmzNhG0iyf2OavnM+ws/P3MM1/Y5nbipA3p15EDMw6bYd
	wE8GDLXhDVf6xmEWji3dpA9eMieLfsKJ1QTYq76S/Q=
Received: from 00107082$163.com ( [111.35.184.199] ) by ajax-webmail-wmsvr26
 (Coremail) ; Mon, 4 Sep 2023 19:10:23 +0800 (CST)
X-Originating-IP: [111.35.184.199]
Date: Mon, 4 Sep 2023 19:10:23 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Florian Westphal" <fw@strlen.de>
Cc: "Alexei Starovoitov" <ast@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Andrii Nakryiko" <andrii@kernel.org>, 
	"Martin KaFai Lau" <martin.lau@linux.dev>, 
	"Song Liu" <song@kernel.org>, 
	"Yonghong Song" <yonghong.song@linux.dev>, 
	"John Fastabend" <john.fastabend@gmail.com>, 
	"KP Singh" <kpsingh@kernel.org>, 
	"Stanislav Fomichev" <sdf@google.com>, "Hao Luo" <haoluo@google.com>, 
	"Jiri Olsa" <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re:Re: [PATCH] samples/bpf: Add sample usage for
 BPF_PROG_TYPE_NETFILTER
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230904104856.GE11802@breakpoint.cc>
References: <20230904102128.11476-1-00107082@163.com>
 <20230904104856.GE11802@breakpoint.cc>
X-NTES-SC: AL_QuySAfSZukAp5SGYYukXn0oTju85XMCzuv8j3YJeN500kynv+QIif0dkG0DQ78y/Cg+UiCCrYQlT+tRgQJJoYbozapZjFwUkO3JyF79fvtYH
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3bc1d9a3.5bb6.18a5fe2f185.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:GsGowABXtewgu_VkU9gTAA--.11573W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwTgqlXmGU34bgACsO
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CkF0IDIwMjMtMDktMDQgMTg6NDg6NTYsICJGbG9yaWFuIFdlc3RwaGFsIiA8ZndAc3RybGVuLmRl
PiB3cm90ZToKPkRhdmlkIFdhbmcgPDAwMTA3MDgyQDE2My5jb20+IHdyb3RlOgo+PiBUaGlzIHNh
bXBsZSBjb2RlIGltcGxlbWVudHMgYSBzaW1wbGUgaXB2NAo+PiBibGFja2xpc3QgdmlhIHRoZSBu
ZXcgYnBmIHR5cGUgQlBGX1BST0dfVFlQRV9ORVRGSUxURVIsCj4+IHdoaWNoIHdhcyBpbnRyb2R1
Y2VkIGluIDYuNC4KPj4gCj4+IFRoZSBicGYgcHJvZ3JhbSBkcm9wcyBwYWNrYWdlIGlmIGRlc3Rp
bmF0aW9uIGlwIGFkZHJlc3MKPj4gaGl0cyBhIG1hdGNoIGluIHRoZSBtYXAgb2YgdHlwZSBCUEZf
TUFQX1RZUEVfTFBNX1RSSUUsCj4+IAo+PiBUaGUgdXNlcnNwYWNlIGNvZGUgd291bGQgbG9hZCB0
aGUgYnBmIHByb2dyYW0sCj4+IGF0dGFjaCBpdCB0byBuZXRmaWx0ZXIncyBGT1JXQVJEL09VVFBV
VCBob29rLAo+PiBhbmQgdGhlbiB3cml0ZSBpcCBwYXR0ZXJucyBpbnRvIHRoZSBicGYgbWFwLgo+
Cj5UaGFua3MsIEkgdGhpbmsgaXRzIGdvb2QgdG8gaGF2ZSB0aGlzLgoKVGhhbmtzIGZvciB0aGUg
cXVpY2sgcmVzcG9uc2UuCj4KPj4gZGlmZiAtLWdpdCBhL3NhbXBsZXMvYnBmL25ldGZpbHRlcl9p
cDRfYmxhY2tsaXN0LmJwZi5jIGIvc2FtcGxlcy9icGYvbmV0ZmlsdGVyX2lwNF9ibGFja2xpc3Qu
YnBmLmMKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kMzE1
ZDY0ZmRhN2YKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9zYW1wbGVzL2JwZi9uZXRmaWx0ZXJf
aXA0X2JsYWNrbGlzdC5icGYuYwo+PiBAQCAtMCwwICsxLDYyIEBACj4+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMAo+PiArCj4+ICsjaW5jbHVkZSAidm1saW51eC5oIgo+PiAr
I2luY2x1ZGUgPGJwZi9icGZfaGVscGVycy5oPgo+PiArCj4+ICsKPj4gKyNkZWZpbmUgTkZfRFJP
UCAwCj4+ICsjZGVmaW5lIE5GX0FDQ0VQVCAxCj4KPklmIHlvdSBhcmUgaW50ZXJlc3RlZCwgeW91
IGNvdWxkIHNlbmQgYSBwYXRjaCBmb3IgbmYtbmV4dCB0aGF0Cj5tYWtlcyB0aGUgdWFwaSBoZWFk
ZXJzIGV4cG9zZSB0aGlzIGFzIGVudW0sIEFGQUlVIHRoYXQgd291bGQgbWFrZQo+dGhlIHZlcmRp
Y3QgbmFuZXMgYXZhaWxhYmxlIHZpYSB2bWxpbnV4LmguCj4KSSB0aGluayBJIGNhbiB3b3JrIG9u
IHRoaXMuCgoKCj4+ICsJLyogc2VhcmNoIHAtPmRhZGRyIGluIHRyaWUgKi8KPj4gKwlrZXkucHJl
Zml4bGVuID0gMzI7Cj4+ICsJa2V5LmRhdGEgPSBwLT5kYWRkcjsKPj4gKwlwdmFsdWUgPSBicGZf
bWFwX2xvb2t1cF9lbGVtKCZpcHY0X2xwbV9tYXAsICZrZXkpOwo+PiArCWlmIChwdmFsdWUpIHsK
Pj4gKwkJLyogY2F0IC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvdHJhY2VfcGlwZSAqLwo+PiAr
CQlicGZfcHJpbnRrKCJydWxlIG1hdGNoZWQgd2l0aCAlZC4uLlxuIiwgKnB2YWx1ZSk7Cj4KPklm
IHlvdSBhcmUgaW50ZXJlc3RlZCB5b3UgY291bGQgc2VuZCBhIHBhdGNoIHRoYXQgYWRkcyBhIGtm
dW5jIHRvCj5uZl9icGZfbGluayB0aGF0IGV4cG9zZXMgbmZfbG9nX3BhY2tldCgpIHRvIGJwZi4K
Pgo+bmZfbG9nX3BhY2tldCBoYXMgYSB0ZXJyaWJsZSBhcGksIEkgc3VnZ2VzdCB0byBoYXZlIHRo
ZSBrZnVuYyB0YWtlCj4nc3RydWN0IG5mX2hvb2tfc3RhdGUgKicgaW5zdGVhZCBvZiA2KyBtZW1i
ZXJzIG9mIHRoYXQgc3RydWN0IGFzCj5hcmd1bWVudC4KPgpMb2dnaW5nIHN0cmF0ZWd5IGlzIG91
dCBvZiBteSBsZWFndWUsIGJ1dCBJIHdpbGwga2VlcCBleWUgb24gdGhpcy4KCkdsYWQgdG8gY29u
dHJpYnV0ZS4KCgpEYXZpZAo=

