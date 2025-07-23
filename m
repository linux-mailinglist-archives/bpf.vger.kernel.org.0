Return-Path: <bpf+bounces-64134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C184B0E854
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 03:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B67B72E5
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 01:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094219CC3D;
	Wed, 23 Jul 2025 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="XTOnnvBA"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686661898E9;
	Wed, 23 Jul 2025 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235588; cv=none; b=f22TpASCi94ZPZ7HuNyYpvjw7XStY635ZBCJS6Cp07gt2qtZTz5QYOIQrdTse0YfEQQ0DYy7MXt3wgpNLynBNBb7shdNS3AcDO332fWLXCMAEZwHJ2xJS+eAlEseSmObMz02hjx1Pu4+Mqoi7OYmpNkhoKjj1NsbWVUqSKeUpss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235588; c=relaxed/simple;
	bh=575xlmXu6BMz6h7W0vj37LpwoiMTj/o5pE9dbDg6y5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=HQBANYCym6tNdDSbv5VW8MDKqOb+RHV9kDK3TI1qoEyeaq45qAXmDzxakWSKNSJjOjLlwo6XDT6JLQmA6rXUr5DYIrAVlMqjX5pVAbrIbLcWe7apbePjtco9mzYVJa7dj6XhiANm5TAAo35mBO97eg5AZDVATJqE3KyWL/USTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=XTOnnvBA reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=rOz3imwQUY752y24gZfigSSIsJtxNfEPhjewJ80SVfA=; b=X
	TOnnvBAk78IsqCYuF3Ms95kMER7q+AqVzLoNa4etMvIuUpiieZsN2FJ4kOl04iGp
	8i4EF1k/Fb7nrDHmUiJ3Jsjg1ntL9fpTuE92f+zgdhNCzBSsQ3XNyk9d+FPmj/9A
	6pITdnzUbmhBU0EBLyqeOAA1pQRBrJr57O4wUqPqx0=
Received: from chenyuan_fl$163.com ( [116.128.244.171] ) by
 ajax-webmail-wmsvr-40-128 (Coremail) ; Wed, 23 Jul 2025 09:52:26 +0800
 (CST)
Date: Wed, 23 Jul 2025 09:52:26 +0800 (CST)
From: chenyuan  <chenyuan_fl@163.com>
To: "Quentin Monnet" <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Yuan Chen" <chenyuan@kylinos.cn>
Subject: Re:Re: [PATCH v4] bpftool: Add CET-aware symbol matching for
 x86/x86_64 architectures
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org>
References: <9f233a20-6649-4796-9ef4-a499382b0006@linux.dev>
 <20250722020000.20037-1-chenyuan_fl@163.com>
 <aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org>
X-NTES-SC: AL_Qu2eAf6Yuk0v4CGfYukfmUoRhOY5UcK1s/kl1YBUOpp+jA7p4QEmem9OEVDPzsyIDxyHnBWaWhNSyeRlfoh1VKcbKcg4D+80e3u4sWg29jSctw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1883d8ac.17ec.19834fb6048.Coremail.chenyuan_fl@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gCgvCgD3nzlbQIBoE5wJAA--.60292W
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNxWSvWh-mIdtxwAEsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

WW91IGFyZSBhYnNvbHV0ZWx5IHJpZ2h0LiBNeSBpbml0aWFsIGFzc3VtcHRpb24gd2FzIGluY29y
cmVjdCAtIHdoaWxlIGVuZGJyMzIgY2FuIHRlY2huaWNhbGx5IGJlCmNvbXBpbGVkIGZvciBpMzg2
LCBJJ3ZlIHZlcmlmaWVkIGluIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbiB0aGF0IFg4Nl9LRVJO
RUxfSUJUIGV4cGxpY2l0bHkKZGVwZW5kcyBvbiBYODZfNjQ6CgouY29uZmlnIC0gTGludXgvaTM4
NiA2LjE2LjAtcmMzIEtlcm5lbCBDb25maWd1cmF0aW9uCj4gU2VhcmNoIChYODZfS0VSTkVMX0lC
VCkgPiBQcm9jZXNzb3IgdHlwZSBhbmQgZmVhdHVyZXMgPiBTZWFyY2ggKFg4Nl9LRVJORUxfSUJU
KQpTeW1ib2w6IFg4Nl9LRVJORUxfSUJUIFs9bl0KVHlwZSAgOiBib29sCkRlZmluZWQgYXQgYXJj
aC94ODYvS2NvbmZpZzoxNzcxClByb21wdDogSW5kaXJlY3QgQnJhbmNoIFRyYWNraW5nCkRlcGVu
ZHMgb246IFg4Nl82NCBbPW5dICYmIENDX0hBU19JQlQgWz15XSAmJiBIQVZFX09CSlRPT0wgWz1u
XSAmJiAoIUxEX0lTX0xMRCBbPW5dIHx8IExMRF9WRVJTSU9OIFs9MF0+PTE0MDAwMCkKClRoaXMg
Y29uZmlybXMgQ0VUIGlzIGluZGVlZCA2NC1iaXQgZXhjbHVzaXZlIGluIHRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uLiBJJ2xsIHJldmlzZSB0aGUgcGF0Y2gKaW1tZWRpYXRlbHkgdG8gcmVtb3Zl
IGkzODYgc3VwcG9ydC4KClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcyEKQmVzdCByZWdhcmRzLApZ
dWFuIENoZW4KCgoKQXQgMjAyNS0wNy0yMiAyMjoyMzoyMywgIlF1ZW50aW4gTW9ubmV0IiA8cW1v
QGtlcm5lbC5vcmc+IHdyb3RlOgo+MjAyNS0wNy0yMiAxMDowMCBVVEMrMDgwMCB+IGNoZW55dWFu
X2ZsQDE2My5jb20KPj4gRnJvbTogWXVhbiBDaGVuIDxjaGVueXVhbkBreWxpbm9zLmNuPgo+PiAK
Pj4gQWRqdXN0IHN5bWJvbCBtYXRjaGluZyBsb2dpYyB0byBhY2NvdW50IGZvciBDb250cm9sLWZs
b3cgRW5mb3JjZW1lbnQKPj4gVGVjaG5vbG9neSAoQ0VUKSBvbiB4ODYveDg2XzY0IHN5c3RlbXMu
IENFVCBwcmVmaXhlcyBmdW5jdGlvbnMgd2l0aAo+PiBhIDQtYnl0ZSAnZW5kYnInIGluc3RydWN0
aW9uLCBzaGlmdGluZyB0aGUgYWN0dWFsIGhvb2sgZW50cnkgcG9pbnQgdG8KPj4gc3ltYm9sICsg
NC4KPj4gCj4+IENoYW5nZWQgaW4gUEFUQ0ggdjQ6Cj4+ICogUmVmYWN0b3IgcmVwZWF0ZWQgY29k
ZSBpbnRvIGEgZnVuY3Rpb24uCj4+ICogQWRkIGRldGVjdGlvbiBmb3IgdGhlIHg4NiBhcmNoaXRl
Y3R1cmUuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBZdWFuIENoZW4gPGNoZW55dWFuQGt5bGlub3Mu
Y24+Cj4+IC0tLQo+PiAgdG9vbHMvYnBmL2JwZnRvb2wvbGluay5jIHwgMjYgKysrKysrKysrKysr
KysrKysrKysrKysrLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2JwZi9icGZ0b29sL2xpbmsuYyBi
L3Rvb2xzL2JwZi9icGZ0b29sL2xpbmsuYwo+PiBpbmRleCBhNzczZTA1ZDVhZGUuLjcxN2NhOGM1
ZmY4MyAxMDA2NDQKPj4gLS0tIGEvdG9vbHMvYnBmL2JwZnRvb2wvbGluay5jCj4+ICsrKyBiL3Rv
b2xzL2JwZi9icGZ0b29sL2xpbmsuYwo+PiBAQCAtMjgyLDYgKzI4MiwyOCBAQCBnZXRfYWRkcl9j
b29raWVfYXJyYXkoX191NjQgKmFkZHJzLCBfX3U2NCAqY29va2llcywgX191MzIgY291bnQpCj4+
ICAJcmV0dXJuIGRhdGE7Cj4+ICB9Cj4+ICAKPj4gK3N0YXRpYyBib29sCj4+ICtzeW1ib2xfbWF0
Y2hlc190YXJnZXQoX191NjQgc3ltX2FkZHIsIF9fdTY0IHRhcmdldF9hZGRyKQo+PiArewo+PiAr
CWlmIChzeW1fYWRkciA9PSB0YXJnZXRfYWRkcikKPj4gKwkJcmV0dXJuIHRydWU7Cj4+ICsKPj4g
KyNpZiBkZWZpbmVkKF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9feDg2XzY0X18pCj4KPgo+RG8geW91
IHJlYWxseSBuZWVkIGl0IGZvciBfX2kzODZfXyBhcyB3ZWxsPyBNeSB1bmRlcnN0YW5kaW5nIHdh
cyB0aGF0Cj5DRVQgd291bGQgYXBwbHkgb25seSB0byA2NC1iaXQ/Cj4KPlRoYW5rcywKPlF1ZW50
aW4K

