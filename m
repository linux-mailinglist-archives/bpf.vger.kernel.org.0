Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C81653E0B
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 11:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiLVKKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbiLVKKH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 05:10:07 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834D27CE3
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 02:10:05 -0800 (PST)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p8IWY-000HAp-HK; Thu, 22 Dec 2022 11:10:02 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p8IWY-000Kla-6r; Thu, 22 Dec 2022 11:10:02 +0100
Subject: Re: [PATCH 1/2] bpf: Add socket destroy capability
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     sdf@google.com, edumazet@google.com, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
 <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
 <3d8066d4-b293-ec13-2437-1ee9b1ed4cc4@linux.dev>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ab84dddd-5217-6034-f114-78a56a177c5d@iogearbox.net>
Date:   Thu, 22 Dec 2022 11:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3d8066d4-b293-ec13-2437-1ee9b1ed4cc4@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26758/Thu Dec 22 09:27:27 2022)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gMTIvMjIvMjIgNjowOCBBTSwgTWFydGluIEthRmFpIExhdSB3cm90ZToNCj4gT24gMTIv
MTYvMjIgNTo1NyBQTSwgQWRpdGkgR2hhZyB3cm90ZToNCj4+IFRoZSBzb2NrZXQgZGVzdHJv
eSBoZWxwZXIgaXMgdXNlZCB0bw0KPj4gZm9yY2VmdWxseSB0ZXJtaW5hdGUgc29ja2V0cyBm
cm9tIGNlcnRhaW4NCj4+IEJQRiBjb250ZXh0cy4gV2UgcGxhbiB0byB1c2UgdGhlIGNhcGFi
aWxpdHkNCj4+IGluIENpbGl1bSB0byBmb3JjZSBjbGllbnQgc29ja2V0cyB0byByZWNvbm5l
Y3QNCj4+IHdoZW4gdGhlaXIgcmVtb3RlIGxvYWQtYmFsYW5jaW5nIGJhY2tlbmRzIGFyZQ0K
Pj4gZGVsZXRlZC4gVGhlIG90aGVyIHVzZSBjYXNlIGlzIG9uLXRoZS1mbHkNCj4+IHBvbGlj
eSBlbmZvcmNlbWVudCB3aGVyZSBleGlzdGluZyBzb2NrZXQNCj4+IGNvbm5lY3Rpb25zIHBy
ZXZlbnRlZCBieSBwb2xpY2llcyBuZWVkIHRvDQo+PiBiZSB0ZXJtaW5hdGVkLg0KPj4NCj4+
IFRoZSBoZWxwZXIgaXMgY3VycmVudGx5IGV4cG9zZWQgdG8gaXRlcmF0b3INCj4+IHR5cGUg
QlBGIHByb2dyYW1zIHdoZXJlIHVzZXJzIGNhbiBmaWx0ZXIsDQo+PiBhbmQgdGVybWluYXRl
IGEgc2V0IG9mIHNvY2tldHMuDQo+Pg0KPj4gU29ja2V0cyBhcmUgZGVzdHJveWVkIGFzeW5j
aHJvbm91c2x5IHVzaW5nDQo+PiB0aGUgd29yayBxdWV1ZSBpbmZyYXN0cnVjdHVyZS4gVGhp
cyBhbGxvd3MNCj4+IGZvciBjdXJyZW50IHRoZSBsb2NraW5nIHNlbWFudGljcyB3aXRoaW4N
Cj4+IHNvY2tldCBkZXN0cm95IGhhbmRsZXJzLCBhcyBCUEYgaXRlcmF0b3JzDQo+PiBpbnZv
a2luZyB0aGUgaGVscGVyIGFjcXVpcmUgKnNvY2sqIGxvY2tzLg0KPj4gVGhpcyBhbHNvIGFs
bG93cyB0aGUgaGVscGVyIHRvIGJlIGludm9rZWQNCj4+IGZyb20gbm9uLXNsZWVwYWJsZSBj
b250ZXh0cy4NCj4+IFRoZSBvdGhlciBhcHByb2FjaCB0byBza2lwIGFjcXVpcmluZyBsb2Nr
cw0KPj4gYnkgcGFzc2luZyBhbiBhcmd1bWVudCB0byB0aGUgYGRpYWdfZGVzdHJveWANCj4+
IGhhbmRsZXIgZGlkbid0IHdvcmsgb3V0IHdlbGwgZm9yIFVEUCwgYXMNCj4+IHRoZSBVRFAg
YWJvcnQgZnVuY3Rpb24gaW50ZXJuYWxseSBpbnZva2VzDQo+PiBhbm90aGVyIGZ1bmN0aW9u
IHRoYXQgZW5kcyB1cCBhY3F1aXJpbmcNCj4+ICpzb2NrKiBsb2NrLg0KPj4gV2hpbGUgdGhl
cmUgYXJlIHNsZWVwYWJsZSBCUEYgaXRlcmF0b3JzLA0KPj4gdGhlc2UgYXJlIGxpbWl0ZWQg
dG8gb25seSBjZXJ0YWluIG1hcCB0eXBlcy4NCj4gDQo+IGJwZi1pdGVyIHByb2dyYW0gY2Fu
IGJlIHNsZWVwYWJsZSBhbmQgbm9uIHNsZWVwYWJsZS4gQm90aCBzbGVlcGFibGUgYW5kIG5v
biBzbGVlcGFibGUgdGNwL3VuaXggYnBmLWl0ZXIgcHJvZ3JhbXMgaGF2ZSBiZWVuIGFibGUg
dG8gY2FsbCBicGZfc2V0c29ja29wdCgpIHN5bmNocm9ub3VzbHkuIGJwZl9zZXRzb2Nrb3B0
KCkgYWxzbyByZXF1aXJlcyB0aGUgc29jayBsb2NrIHRvIGJlIGhlbGQgZmlyc3QuIFRoZSBz
aXR1YXRpb24gb24gY2FsbGluZyAnLmRpYWdfZGVzdHJveScgZnJvbSBicGYtaXRlciBzaG91
bGQgbm90IGJlIG11Y2ggZGlmZmVyZW50IGZyb20gY2FsbGluZyBicGZfc2V0c29ja29wdCgp
LiBGcm9tIGEgcXVpY2sgbG9vayBhdCB0Y3BfYWJvcnQgYW5kIHVkcF9hYm9ydCwgSSBkb24n
dCBzZWUgdGhleSBtaWdodCBzbGVlcCBhbHNvIGFuZCB5b3UgbWF5IHdhbnQgdG8gZG91Ymxl
IGNoZWNrLiBFdmVuICcuZGlhZ19kZXN0cm95JyB3YXMgb25seSB1c2FibGUgaW4gc2xlZXBh
YmxlICdicGYtaXRlcicgYmVjYXVzZSBpdCBtaWdodCBzbGVlcCwgdGhlIGNvbW1vbiBicGYg
bWFwIHR5cGVzIGFyZSBhbHJlYWR5IGF2YWlsYWJsZSB0byB0aGUgc2xlZXBhYmxlIHByb2dy
YW1zLg0KPiANCj4gQXQgdGhlIGtlcm5lbCBzaWRlLCB0aGUgdGNwIGFuZCB1bml4IGl0ZXIg
YWNxdWlyZSB0aGUgbG9ja19zb2NrKCkgZmlyc3QgKGVnLiBpbiBicGZfaXRlcl90Y3Bfc2Vx
X3Nob3coKSkgYmVmb3JlIGNhbGxpbmcgdGhlIGJwZi1pdGVyIHByb2cgLiBBdCB0aGUga2Vy
bmVsIHNldHNvY2tvcHQgY29kZSAoZWcuIGRvX2lwX3NldHNvY2tvcHQoKSksIGl0IHVzZXMg
c29ja29wdF9sb2NrX3NvY2soKSBhbmQgYXZvaWRzIGRvaW5nIHRoZSBsb2NrIGlmIGl0IGhh
cyBhbHJlYWR5IGJlZW4gZ3VhcmFudGVlZCBieSB0aGUgYnBmIHJ1bm5pbmcgY29udGV4dC4N
Cj4gDQo+IEZvciB1ZHAsIEkgZG9uJ3Qgc2VlIGhvdyB0aGUgdWRwX2Fib3J0IGFjcXVpcmVz
IHRoZSBzb2NrIGxvY2sgZGlmZmVyZW50bHkgZnJvbSB0Y3BfYWJvcnQuwqAgSSBhc3N1bWUg
dGhlIGFjdHVhbCBwcm9ibGVtIHNlZW4gaW4gdWRwX2Fib3J0IGlzIHJlbGF0ZWQgdG8gdGhl
ICctPnVuaGFzaCgpJyBwYXJ0IHdoaWNoIGFjcXVpcmVzIHRoZSB1ZHBfdGFibGUncyBidWNr
ZXQgbG9jay7CoCBUaGlzIGlzIGEgcHJvYmxlbSBmb3IgdWRwIGJwZi1pdGVyIG9ubHkgYmVj
YXVzZSB0aGUgdWRwIGJwZi1pdGVyIGRpZCBub3QgcmVsZWFzZSB0aGUgdWRwX3RhYmxlJ3Mg
YnVja2V0IGxvY2sgYmVmb3JlIGNhbGxpbmcgdGhlIGJwZiBwcm9nLsKgIFRoZSB0Y3AgKGFu
ZCB1bml4KSBicGYtaXRlciByZWxlYXNlcyB0aGUgYnVja2V0IGxvY2sgZmlyc3QgYmVmb3Jl
IGNhbGxpbmcgdGhlIGJwZiBwcm9nLiBUaGlzIHdhcyBkb25lIGV4cGxpY2l0bHkgdG8gYWxs
b3cgYWNxdWlyaW5nIHRoZSBzb2NrIGxvY2sgYmVmb3JlIGNhbGxpbmcgdGhlIGJwZiBwcm9n
IGJlY2F1c2Ugb3RoZXJ3aXNlIGl0IHdpbGwgaGF2ZSBhIGxvY2sgb3JkZXJpbmcgaXNzdWUu
IEhlbmNlLCBmb3IgdGhpcyByZWFzb24sIGJwZl9zZXRzb2Nrb3B0KCkgaXMgb25seSBhdmFp
bGFibGUgdG8gdGNwIGFuZCB1bml4IGJwZi1pdGVyIGJ1dCBub3QgdWRwIGJwZi1pdGVyLiBU
aGUgdWRwLWl0ZXIgbmVlZHMgdG8gZG8gc2ltaWxhciBjaGFuZ2UgbGlrZSB0aGUgdGNwIGFu
ZCB1bml4IGl0ZXIgKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDIxMDcwMTIwMDUz
NS4xMDMzNTEzLTEta2FmYWlAZmIuY29tLyk6IGJhdGNoLCByZWxlYXNlIHRoZSBidWNrZXQn
cyBsb2NrLCBsb2NrIHRoZSBzb2NrLCBhbmQgdGhlbiBjYWxsIGJwZiBwcm9nLsKgIFRoaXMg
d2lsbCBhbGxvdyB1ZHAtaXRlciB0byBjYWxsIGJwZl9zZXRzb2Nrb3B0KCkgbGlrZSBpdHMg
dGNwIGFuZCB1bml4IGNvdW50ZXJwYXJ0LiAgDQo+IFRoYXQgd2lsbCBhbHNvIGFsbG93IHVk
cCBicGYtaXRlciBwcm9nIHRvIGRpcmVjdGx5IGRvICcuZGlhZ19kZXN0cm95Jy4NCg0KQWdy
ZWUsIHRoYXQgc291bmRzIHZlcnkgcmVhc29uYWJsZSB3YXkgZm9yd2FyZCBhbmQgd291bGQg
YWxzbyBlbmFibGUgYnBmX3NldHNvY2tvcHQoKSBzdXBwb3J0DQpmb3IgVURQIHNrcy4gV3J0
IHRoZSB3b3JrcXVldWUgSSBkb24ndCByZWFsbHkgbGlrZSB0aGF0IHRoZXJlJ3MgYSBsb29w
aG9sZSB3aXRoIHRoZSAtRUJVU1kgaWYNCnRoZSBjYWxsYmFjayBkaWRuJ3QgdHJpZ2dlciB5
ZXQsIHdoaWxlIHdlIG5lZWQgdG8gYmUgYWJsZSB0byBkZXN0cm95IG11bHRpcGxlIHNrcyBp
biBvbmUgaXRlcmF0aW9uDQp3aGVuIHRoZXkgbWF0Y2ggdGhlIHNrIGNvb2tpZSBwcmV2aW91
c2x5IHJlY29yZGVkIGluIHRoZSBtYXAuLiBzbyBhZ3JlZSwgdGhpcyBuZWVkcyB0byBoYXBw
ZW4gaW4NCmEgc3luY2hyb25vdXMgbWFubmVyLg0KDQpUaGFua3MsDQpEYW5pZWwNCg==
