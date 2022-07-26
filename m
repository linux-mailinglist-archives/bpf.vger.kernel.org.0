Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C65808E1
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 03:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiGZBGP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 21:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiGZBGO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 21:06:14 -0400
Received: from m1364.mail.163.com (m1364.mail.163.com [220.181.13.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3F8426544;
        Mon, 25 Jul 2022 18:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=tMZKv
        nr2S+LpKBN6CdOAA5vEXQTONGrH6lqsAQ5uMb0=; b=buoXR/OwW8IiEHFyqxW9O
        ZeSuFtQOewz4Rcn6AEWCVmuHl8X6xC+5+vOXBw9uy05+AmaJHM0q5lCvl2ZeR8Iy
        zlEP+Hk3MpUXLUNCTEt/TILpDCKkHT6lb/gVj3r5gQLnEDK2phDYyVBczYdMiZgw
        MLyQhf4wXZi1010u33ujdY=
Received: from slark_xiao$163.com ( [223.104.68.106] ) by
 ajax-webmail-wmsvr64 (Coremail) ; Tue, 26 Jul 2022 09:04:41 +0800 (CST)
X-Originating-IP: [223.104.68.106]
Date:   Tue, 26 Jul 2022 09:04:41 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Baoquan He" <bhe@redhat.com>
Cc:     "David Howells" <dhowells@redhat.com>, corbet@lwn.net,
        vgoyal@redhat.com, dyoung@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, william.gray@linaro.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, bigeasy@linutronix.de,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re:Re: [PATCH v2] docs: Fix typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Yt6bVIoRa0nIvxei@MiWiFi-R3L-srv>
References: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
 <20220721015605.20651-1-slark_xiao@163.com>
 <2778505.1658746506@warthog.procyon.org.uk>
 <Yt6bVIoRa0nIvxei@MiWiFi-R3L-srv>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <55d366e4.486.1823808de32.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMGowAD3Ei+pPd9i1g8sAA--.42687W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdRZJZGBbEenN+gACs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMDctMjUgMjE6MzI6MDQsICJCYW9xdWFuIEhlIiA8Ymhl
QHJlZGhhdC5jb20+IHdyb3RlOgo+T24gMDcvMjUvMjIgYXQgMTE6NTVhbSwgRGF2aWQgSG93ZWxs
cyB3cm90ZToKPj4gQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+IHdyb3RlOgo+PiAKPj4gPiBz
ZWQgLWkgInMvdGhlIHRoZSAvdGhlIC9nIiBgZ2l0IGdyZXAgLWwgInRoZSB0aGUgImAKPj4gCj4+
IFlvdSBtaWdodCB3YW50IHRvIGNsYXJpZnkgdGhlIGZpcnN0ICJ0aGUiIHdpdGggYSBwcmVjZWRp
bmcgYm91bmRhcnkgbWFya2VyLgo+PiBUaGVyZSBhcmUgc29tZSBFbmdsaXNoIHdvcmRzIGVuZGlu
ZyBpbiAidGhlIiB0aGF0IGNhbiBiZSB1c2VkIGFzIHZlcmJzLCB0aG91Z2gKPj4gSSdtIG5vdCBz
dXJlIHlvdSdkIGZpbmQgYW55IG9mIHRoZW0gaGVyZSAtIGNsb3RoZSBmb3IgZXhhbXBsZS4KPgo+
UmlnaHQuIEkgcGxhbiB0byBzcGxpdCB0aGlzIGJpZyBvbmUgaW50byBwYXRjaGVzIGNvcnJlc3Bv
bmRpbmcgdG8KPmRpZmZlcmVudCBjb21wb25lbnQgYXMgSm9uYXRoYW4gc3VnZ2VzdGVkLCBhbmQg
d2lsbCBjb25zaWRlciBob3cgdG8gbWFyawo+dGhlIGZpcnN0ICd0aGUnIGFzIHlvdSBzdWdnZXN0
ZWQsIGFuZCB3cmFwIFNsYXJrJ3MgcGF0aGNlcyB3aGljaAo+aW5jbHVkZXMgdHlwbyBmaXggb2Yg
InRoZW4gdGhlIi4KPgo+VGhhbmtzCj5CYW9xdWFuCgpBY3R1YWxseSBJIGhhdmUgY29tbWl0dGVk
IGFsbCBjaGFuZ2VzIHdoaWNoIHdlcmUgbGlzdGVkIGluIHlvdXIgcHJldmlvdXMgbGlzdC4KSSBj
b21taXR0ZWQgaXQgb25lIGJ5IG9uZSBhbmQgY2hlY2tlZCBpZiBhbnkgb3RoZXIgdHlwbyBpcyBp
bmNsdWRlZC4KSWYgcG9zc2libGUsIHlvdSBjYW4gdHJ5IG90aGVyIGRvdWJsZSB0eXBvIGlzc3Vl
IGxpa2UgImFuZCBhbmQgIiBvciAib3Igb3IiIG9yIHNvbWV0aGluZyBlbHNlLgoKClRoYW5rcwo=

