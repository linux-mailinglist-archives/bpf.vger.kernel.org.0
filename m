Return-Path: <bpf+bounces-10427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D687A704F
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 04:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F19280EC3
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384717FF;
	Wed, 20 Sep 2023 02:24:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C4A49
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 02:24:42 +0000 (UTC)
X-Greylist: delayed 44972 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 19:24:37 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74E72AB
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 19:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=kIXH3/7NDskCK0kzvZ4ApHycjyRu76e+YxuH
	cfkbnIg=; b=KoStbYYPPDkakQOmsy6lACg1JoREtMwa8pT+PGntP/dnmav0CxNg
	Nu1/bc2S78WbSotpXouKBEn3p9KAU44HXf+NsT7eXLl7cWhvLO6orGb/uwCn58wT
	Ciz1uQKL/JXPVlj6zkt8BxLLEIGgon/Xp+rKtbrEUb7+CU6t0vKOhq8=
Received: from chang-liu22$mails.tsinghua.edu.cn ( [101.5.9.34] ) by
 ajax-webmail-web5 (Coremail) ; Wed, 20 Sep 2023 10:24:30 +0800 (GMT+08:00)
X-Originating-IP: [101.5.9.34]
Date: Wed, 20 Sep 2023 10:24:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5YiY55WF?= <chang-liu22@mails.tsinghua.edu.cn>
To: "Kui-Feng Lee" <sinquersw@gmail.com>, alan.maguire@oracle.com, 
	bpf@vger.kernel.org
Subject: Re: Re: Is is possible to get the function calling stack in an
 fentry bpf program?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <be0d14e6-072c-83a5-b21b-2ab33e97e3fa@gmail.com>
References: <49b9b6f.1279.18aadb90e05.Coremail.chang-liu22@mails.tsinghua.edu.cn>
 <be0d14e6-072c-83a5-b21b-2ab33e97e3fa@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <61f95da4.189e.18ab0673eda.Coremail.chang-liu22@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:zAQGZQB3kRHeVwplgS7GAA--.17194W
X-CM-SenderInfo: xfkd0wonol3j2s6ptxtovo32xlqjx3vdohv3gofq/1tbiAQMAAGUK
	FfctwwABsg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VGhhbmsgeW91IEt1aS1GZW5nIGFuZCBBbGFuLiBJIG1pc3VuZGVyc3Rvb2QgdGhlIHVzYWdlIG9m
IGJwZl9zdGFja19nZXQoKS4gSSB0aG91Z2h0IGl0IHdvdWxkIHJldHJpZXZlIGFsbCBkYXRhIGZy
b20gdGhlIHN0YWNrLCBpbmNsdWRpbmcgbG9jYWwgdmFyaWFibGVzLiBOb3csIEkgY2FuIGdldCB0
aGUgZm9sbG93aW5nIGNhbGxpbmcgc3RhY2sgaW4gbXkgZmVudHJ5IGJwZiBwcm9ncmFtOgoKZmZm
ZmZmZmZjMDdjOTA5MCAoYnBmX3Byb2dfMTJkYzI3OTY4NjE4OTBkMF9icGZfZmVudHJ5X19fdGNw
X3RyYW5zbWl0X3NrYikKICAgICAgIHwKZmZmZmZmZmZjMDdjOTA5MCAoYnBmX3Byb2dfMTJkYzI3
OTY4NjE4OTBkMF9icGZfZmVudHJ5X19fdGNwX3RyYW5zbWl0X3NrYikKICAgICAgIHwKZmZmZmZm
ZmZjNDY1YzAwMCAoYnBmX3RyYW1wb2xpbmVfNjQ0MjU2NDQ5NF8wKQogICAgICAgfApmZmZmZmZm
Zjg1ZGQxNWE1IChfX3RjcF90cmFuc21pdF9za2IpCiAgICAgICB8CmZmZmZmZmZmODVkZDE1YTUg
KF9fdGNwX3B1c2hfcGVuZGluZ19mcmFtZXMpCiAgICAgICB8CmZmZmZmZmZmODVkYmE4YzkgKHRj
cF9wdXNoKQogICAgICAgfAogICAgLi4uLi4uCgpCdXQgdGhlIGZpcnN0IHR3byBhZGRyZXNzZXMg
bG9vayBxdWl0ZSBzdHJhbmdlIChicGZfZmVudHJ5X19fdGNwX3RyYW5zbWl0X3NrYiBpcyB0aGUg
bmFtZSBvZiBteSBmZW50cnkgYnBmIHByb2dyYW0pLCB0aGV5IGFyZSB0aGUgc2FtZSBhbmQgbG9v
ayBsaWtlIHRoZXkgYmVsb25nIHRvIHRoZSBhdHRhY2hlZCBmZW50cnkgYnBmIHByb2dyYW0uIEkg
ZG9uJ3Qga25vdyB3aHkgdGhpcyBoYXBwZW5zLiBSZWdhcmRsZXNzLCBJIGNhbiBnZXQgdGhlIGZ1
bmN0aW9uIHRoYXQgY2FsbHMgX190Y3BfdHJhbnNtaXRfc2tiKCkgbm93LgoKPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiS3VpLUZlbmcgTGVlIiA8c2lucXVlcnN3QGdtYWls
LmNvbT4KPiBTZW50IFRpbWU6IDIwMjMtMDktMjAgMDA6MjI6MTEgKFdlZG5lc2RheSkKPiBUbzog
IuWImOeVhSIgPGNoYW5nLWxpdTIyQG1haWxzLnRzaW5naHVhLmVkdS5jbj4sIGJwZkB2Z2VyLmtl
cm5lbC5vcmcKPiBDYzogCj4gU3ViamVjdDogUmU6IElzIGlzIHBvc3NpYmxlIHRvIGdldCB0aGUg
ZnVuY3Rpb24gY2FsbGluZyBzdGFjayBpbiBhbiBmZW50cnkgYnBmIHByb2dyYW0/Cj4gCj4gCj4g
Cj4gT24gOS8xOS8yMyAwNjo1NSwg5YiY55WFIHdyb3RlOgo+ID4gSGkgYWxsCj4gPiAKPiA+IEkg
YXR0YWNoZWQgYW4gZmVudHJ5IGVCUEYgcHJvZ3JhbSB0byBhIGtlcm5lbCBmdW5jdGlvbiwgaS5l
LiwgdGNwX3RyYW5zbWl0X3NrYigpLiBJIHdhbnQgdG8gaW1wbGVtZW50IGRpZmZlcmVudCBsb2dp
YyBpbiB0aGUgYnBmIHByb2dyYW0gZm9yIGRpZmZlcmVudCBjYWxsaW5nIHN0YWNrIGNhc2VzLCBl
LmcuLCBfX3RjcF9yZXRyYW5zbWl0X3NrYigpLT50Y3BfdHJhbnNtaXRfc2tiKCkgYW5kIHRjcF93
cml0ZV94bWl0KCktPnRjcF90cmFuc21pdF9za2IoKS4gSSBrbm93IHRoYXQgSSBjYW4gYWNjZXNz
IHN0YWNrIHRyYWNlcyB1c2luZyB0aGUgYnBmX2dldF9zdGFjaygpIGhlbHBlciBmdW5jdGlvbi4g
SG93ZXZlciwgaW4gdGhlIGZlbnRyeSBlQlBGIHByb2dyYW0sIEkgZG9uJ3Qga25vdyB0aGUgdmFs
dWUgb2YgdGhlIFJTUCBhbmQgUkJQIHJlZ2lzdGVyLCB3aGljaCBtZWFucyBJIGNhbiBub3QgbG9j
YXRlIHRoZSByZXR1cm4gYWRkcmVzcyBldmVuIGlmIEkgY2FuIGdldCB0aGUgc3RhY2sgdHJhY2Vz
LiBJIHdhbnQgdG8ga25vdyBpZiB0aGVyZSdzIGFueSB3YXkgdGhhdCBJIGNhbiBnZXQgdGhlIHJl
dHVybiBhZGRyZXNzIGFuZCB0aHVzIGdldCB0aGUgZnVuY3Rpb24gY2FsbGluZyBzdGFjayBpbiBh
biBmZW50cnkgYnBmIHByb2dyYW0uCj4gPiAKPiA+IEknZCBiZSBhcHByZWNpYXRlIGlmIHlvdSBj
YW4gaGVscCBtZS4KPiA+IAo+ID4gQ2hhbmcgTGl1Cj4gPiBUc2luZ2h1YSBVbml2ZXJzaXR5LCBD
aGluYQo+IAo+IE9uY2UgeW91IGdldCBzdGFjayByZXR1cm5lZCBieSBicGZfZ2V0X3N0YWNrKCks
IGl0IGlzIGFuIGFycmF5IG9mCj4gYWRkcmVzc2VzLiBGb3IgZXhhbXBsZSwKPiAKPiAgIF9fdTY0
IGJ1ZlsyNTZdOwo+ICAgYnBmX2dldF9zdGFjayhjdHgsIGJ1ZiwgMjU2LCAwKTsKPiAKPiBidWZb
MF0sIGJ1ZlsxXSwgLi4uIHdpbGwgYmUgYWRkcmVzc2VzIG9mIGNhbGxlciBzaXRlcyBmcm9tIG1v
c3QgaW5uZXIuCg==

