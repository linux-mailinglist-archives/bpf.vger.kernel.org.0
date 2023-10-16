Return-Path: <bpf+bounces-12256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF57CA45F
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 11:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116211C20D43
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAFB1F612;
	Mon, 16 Oct 2023 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="F1dIr8+h"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21115ADD
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 09:38:26 +0000 (UTC)
X-Greylist: delayed 910 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 02:38:23 PDT
Received: from m1325.mail.163.com (m1325.mail.163.com [220.181.13.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FEB4AB;
	Mon, 16 Oct 2023 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=IHf1ZEy9uQ92Bpj/YslkjkDb4QSvVvjC97Qn/wYsbGk=; b=F
	1dIr8+hFx0Agv1LGde5HXT4efc4LstQhNHyvHeUC49yz46ij1iVruvi/C5ZNnX7J
	iDD1lpFwIj6Bq1/yuZH0P8t5/IWWk3d7ixEW0DkAse+65xh9Tf6VBX0o4qKv/J2V
	pZAYul7wp/XggzA8/MINweUIo50BryeNEhjOZ6Y1DM=
Received: from 00107082$163.com ( [111.35.185.232] ) by ajax-webmail-wmsvr25
 (Coremail) ; Mon, 16 Oct 2023 17:22:36 +0800 (CST)
X-Originating-IP: [111.35.185.232]
Date: Mon, 16 Oct 2023 17:22:36 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Florian Westphal" <fw@strlen.de>
Cc: "Daniel Xu" <dxu@dxuuu.xyz>, "Pablo Neira Ayuso" <pablo@netfilter.org>, 
	"Jozsef Kadlecsik" <kadlec@netfilter.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re:Re: [PATCH] uapi/netfilter: Change netfilter hook verdict code
 definition from macro to enum
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230928115359.GB27208@breakpoint.cc>
References: <20230904130201.14632-1-00107082@163.com>
 <cc6e3tukgqhi5y4uhepntrpf272o652pytuynj4nijsf5bkgjq@rgnbhckr3p4w>
 <19d2362f.5c85.18a6647817b.Coremail.00107082@163.com>
 <20230928115359.GB27208@breakpoint.cc>
X-NTES-SC: AL_QuySBfift0ku4CGRYukXn0oTju85XMCzuv8j3YJeN500kinOwzsydmZPLETk1v6PBB+iqQGLQBJK2utLW6NHVpsjqcGzyTwrHW7h1YZ4nFyx
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <269646ef.6122.18b37cb5c27.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:GcGowAD3_3biAC1lmbISAA--.6595W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiEBoLql8YLwmJiwACsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CgoKQXQgMjAyMy0wOS0yOCAxOTo1Mzo1OSwgIkZsb3JpYW4gV2VzdHBoYWwiIDxmd0BzdHJsZW4u
ZGU+IHdyb3RlOgoKPgo+SSB3YXMgYWJvdXQgdG8gYXBwbHkgdGhpcyBhcy1pcywgYnV0IFBhYmxv
IE5laXJhIHdvdWxkIHByZWZlciB0bwo+a2VlcCB0aGUgZGVmaW5lcyBhcyB3ZWxsLgo+Cj5Tbywg
YXMgYSBjb21wcm9taXNlLCBJIHdvdWxkIHN1Z2dlc3QgdG8ganVzdCAqYWRkKgo+Cj4vKiB2ZXJk
aWN0cyBhdmFpbGFibGUgdG8gQlBGIGFyZSBleHBvcnRlZCB2aWEgdm1saW51eC5oICovCj5lbnVt
IHsKPglORl9EUk9QID0gMCwKPglORl9BQ0NFUFQgPSAxLAo+fTsKPgo+I2RlZmluZSBORl9EUk9Q
IDAKPi4uLgo+Cj5UaGlzIHdheSBCVEYgd29uJ3QgaGF2ZSB0aGUgb3RoZXIgdmVyZGljdHMsIGJ1
dCBBVE0gdGhvc2UKPmNhbm5vdCBiZSB1c2VkIGluIEJQRiBwcm9ncmFtcyBhbnl3YXkuCj4KPldv
dWxkIHlvdSBtaW5kIG1ha2luZyBhIG5ldyB2ZXJzaW9uIG9mIHRoZSBwYXRjaD8KPk90aGVyd2lz
ZSBJIGNhbiBtYW5nbGUgaXQgbG9jYWxseSBoZXJlIGFzIG5lZWRlZC4KCgpTb3JyeSBmb3IgdGhp
cyBsYXRlIHJlc3BvbnNlLCBJIGdvdCBjYXVnaHQgdXAgYnkgYW4gdW5leHBlY3RlZCBwZXJzb25h
bCAiY3Jpc2lzIiBmb3IgcXVpdGUgYSBsb25nIHdoaWxlLi4KSG9wZSB5b3UgaGF2ZSBhbHJlYWR5
IG1hZGUgdGhlIGNoYW5nZSwgYW5kIGl0IGlzIE9LLgoKRGF2aWQK

