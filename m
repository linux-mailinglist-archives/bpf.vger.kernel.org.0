Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3758DCCF
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbiHIRIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiHIRIJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:08:09 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E644813E26;
        Tue,  9 Aug 2022 10:08:06 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 5E20D100006;
        Tue,  9 Aug 2022 17:08:01 +0000 (UTC)
Message-ID: <67583452598f7ceacf5f7f5cee0f53373ea76689.camel@hadess.net>
Subject: Re: [PATCH 1/2] USB: core: add a way to revoke access to open USB
 devices
From:   Bastien Nocera <hadess@hadess.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Date:   Tue, 09 Aug 2022 19:08:01 +0200
In-Reply-To: <87y1vx2wmk.fsf@email.froward.int.ebiederm.org>
References: <20220809094300.83116-1-hadess@hadess.net>
         <20220809094300.83116-2-hadess@hadess.net>
         <87y1vx2wmk.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTA5IGF0IDExOjQ2IC0wNTAwLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90
ZToKPiBCYXN0aWVuIE5vY2VyYSA8aGFkZXNzQGhhZGVzcy5uZXQ+IHdyaXRlczoKPiAKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga3VpZF90IGt1aWQ7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmICghcHMgfHwgIXBzLT5jcmVkKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGt1aWQgPSBwcy0+Y3JlZC0+ZXVp
ZDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KGt1aWQudmFsICE9IGV1aWQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBeXl5eXl5eXl5eXl5eXl5eXl5eXl4KPiBUaGF0IHRlc3Qgc2hvdWxkIGJlIGlm
ICghdWlkX2VxKHBzLT5jcmVkLT5ldWlkLCBldWlkKSkKPiAKPiAKPiBUaGUgcG9pbnQgaXMgdGhh
dCBpbnNpZGUgdGhlIGtlcm5lbCBhbGwgdWlkIGRhdGEgc2hvdWxkIGJlIGRlYWx0IHdpdGgKPiBp
biB0aGUga3VpZF90IGRhdGEgdHlwZS7CoCBTbyBhcyB0byBhdm9pZCBjb25mdXNpbmcgdWlkcyB3
aXRoIHNvbWUKPiBvdGhlcgo+IGtpbmQgb2YgaW50ZWdlciBkYXRhLgoKVGhhdCB1aWQgY29tZXMg
ZnJvbSB1c2VyLXNwYWNlLCBzZWUgcGF0Y2ggMi8yLgoKRG8geW91IGhhdmUgZXhhbXBsZXMgb2Yg
YWNjZXB0aW5nIGV1aWRzIGZyb20gdXNlci1zcGFjZSBhbmQgc3Rhc2hpbmcKdGhlbSBpbnRvIGt1
aWRfdD8KCklmIHlvdSBhbHNvIGhhdmUgYW55IGlkZWEgYWJvdXQgdXNlciBuYW1lc3BhY2VzIGFz
IG1lbnRpb25lZCBpbiB0aGUKY292ZXIgbGV0dGVyIGZvciB0aGlzIHBhdGNoIHNldCwgSSB3b3Vs
ZCBhcHByZWNpYXRlLgo=

