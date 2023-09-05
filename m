Return-Path: <bpf+bounces-9282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B22793051
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 22:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB892811E7
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 20:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7AFC0A;
	Tue,  5 Sep 2023 20:49:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F3FC08
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 20:49:15 +0000 (UTC)
X-Greylist: delayed 4504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:49:13 PDT
Received: from m1380.mail.163.com (m1380.mail.163.com [220.181.13.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25E5D132;
	Tue,  5 Sep 2023 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zjkgSPNyl1Ii404LUexGjZzuKpWa/hMD4sGafVzau7U=; b=G
	Uiq09ZwFyhXfIc2jdeEybvbTXTMdXx9rzcKSR0DjYXudSuI+hUdcuF8ZE+B/WgBG
	EtbTLmrtxt3JNZ9jHetdxmLQFd9I0dpCWlyD3NJJlmagAm4Tqz7S/Ib26xS35m33
	Jirflak85ferl2Ph35AANT5yyIvhFpqDSIFGrWrHRM=
Received: from 00107082$163.com ( [111.35.184.199] ) by ajax-webmail-wmsvr80
 (Coremail) ; Wed, 6 Sep 2023 00:57:56 +0800 (CST)
X-Originating-IP: [111.35.184.199]
Date: Wed, 6 Sep 2023 00:57:56 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Daniel Xu" <dxu@dxuuu.xyz>
Cc: "Pablo Neira Ayuso" <pablo@netfilter.org>, 
	"Jozsef Kadlecsik" <kadlec@netfilter.org>, 
	"Florian Westphal" <fw@strlen.de>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH] uapi/netfilter: Change netfilter hook verdict code
 definition from macro to enum
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <cc6e3tukgqhi5y4uhepntrpf272o652pytuynj4nijsf5bkgjq@rgnbhckr3p4w>
References: <20230904130201.14632-1-00107082@163.com>
 <cc6e3tukgqhi5y4uhepntrpf272o652pytuynj4nijsf5bkgjq@rgnbhckr3p4w>
X-NTES-SC: AL_QuySAfWYvEgs4CidY+kXn0oTju85XMCzuv8j3YJeN500hyrP/yMcQEJqGmPq1seOICGMjSWMdBNC08teX6N9bbgB1OIaCTbjAwa1Sq2dLQrf
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <19d2362f.5c85.18a6647817b.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:UMGowAD3H88VXvdkUwIAAA--.195W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiOxThqmC5nJKIeQAEsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CgpBdCAyMDIzLTA5LTA2IDAwOjM4OjAyLCAiRGFuaWVsIFh1IiA8ZHh1QGR4dXV1Lnh5ej4gd3Jv
dGU6Cj5IaSBEYXZpZCwKPgo+T24gTW9uLCBTZXAgMDQsIDIwMjMgYXQgMDk6MDI6MDJQTSArMDgw
MCwgRGF2aWQgV2FuZyB3cm90ZToKCj4+ICAjaW5jbHVkZSA8bGludXgvaW42Lmg+Cj4+ICAKPj4g
IC8qIFJlc3BvbnNlcyBmcm9tIGhvb2sgZnVuY3Rpb25zLiAqLwo+PiAtI2RlZmluZSBORl9EUk9Q
IDAKPj4gLSNkZWZpbmUgTkZfQUNDRVBUIDEKPj4gLSNkZWZpbmUgTkZfU1RPTEVOIDIKPj4gLSNk
ZWZpbmUgTkZfUVVFVUUgMwo+PiAtI2RlZmluZSBORl9SRVBFQVQgNAo+PiAtI2RlZmluZSBORl9T
VE9QIDUJLyogRGVwcmVjYXRlZCwgZm9yIHVzZXJzcGFjZSBuZl9xdWV1ZSBjb21wYXRpYmlsaXR5
LiAqLwo+PiAtI2RlZmluZSBORl9NQVhfVkVSRElDVCBORl9TVE9QCj4+ICtlbnVtIHsKPj4gKwlO
Rl9EUk9QICAgICAgICA9IDAsCj4+ICsJTkZfQUNDRVBUICAgICAgPSAxLAo+PiArCU5GX1NUT0xF
TiAgICAgID0gMiwKPj4gKwlORl9RVUVVRSAgICAgICA9IDMsCj4+ICsJTkZfUkVQRUFUICAgICAg
PSA0LAo+PiArCU5GX1NUT1AgICAgICAgID0gNSwJLyogRGVwcmVjYXRlZCwgZm9yIHVzZXJzcGFj
ZSBuZl9xdWV1ZSBjb21wYXRpYmlsaXR5LiAqLwo+PiArCU5GX01BWF9WRVJESUNUID0gTkZfU1RP
UCwKPj4gK307Cj4KPlN3aXRjaGluZyBmcm9tIG1hY3JvIHRvIGVudW0gd29ya3MgZm9yIGFsbW9z
dCBhbGwgdXNlIGNhc2VzLCBidXQgbm90Cj5hbGwuIElmIHNvbWVvbmUgaWYgI2lmZGVmaW5nIHRo
ZSBzeW1ib2xzICh3aGljaCBpcyBwbGF1c2libGUpIHRoaXMKPmNoYW5nZSB3b3VsZCBicmVhayB0
aGVtLgo+Cj5JIHRoaW5rIEkndmUgc2VlbiBzb21lIG90aGVyIG5ldHdvcmtpbmcgY29kZSBkZWZp
bmUgYm90aCBlbnVtcyBhbmQKPm1hY3Jvcy4gQnV0IGl0IHdhcyBhIGxpdHRsZSB1Z2x5LiBOb3Qg
c3VyZSBpZiB0aGF0IGlzIGFjY2VwdGFibGUgaGVyZSBvcgo+bm90Lgo+Cj5bLi4uXQo+Cj5UaGFu
a3MsCj5EYW5pZWwKCgpUaGFua3MgZm9yIHRoZSByZXZpZXd+CkkgZG8gbm90IGhhdmUgYSBzdHJv
bmcgcmVhc29uaW5nIHRvIGRlbnkgdGhlIHBvc3NpYmlsaXR5IG9mIGJyZWFraW5nIHVuZXhwZWN0
ZWQgdXNhZ2Ugb2YgdGhpcyBtYWNyb3MsCgpidXQgSSBhbHNvIGFncmVlIHRoYXQgaXQgaXMgdWds
eSB0byB1c2UgYm90aCBlbnVtIGFuZCBtYWNybyBhdCB0aGUgc2FtZSB0aW1lLgoKS2luZCBvZiBk
b24ndCBrbm93IGhvdyB0byBwcm9jZWVkIGZyb20gaGVyZSBub3cuLi4=

