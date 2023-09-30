Return-Path: <bpf+bounces-11151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3975C7B3E93
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 08:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8F98D281F00
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 06:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A40539A;
	Sat, 30 Sep 2023 06:07:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4171FA8
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 06:07:45 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0141A7
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 23:07:43 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E0F51C16B5AD
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696054062; bh=uZZ/iV5HsRBfmuhdjvoINiZyvKT29KRb3IBoFga5m2E=;
	h=From:In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=eUAPmSf5343Y6uYFBcbIRweV2yiQK5UkOKbZ74pJgVU/5RFHzplQbnnDvG4dFZZcU
	 m1RjRW45uIR0QwlxxYrJtq5J5cO4iKIx1u7wDLjJODaoyueAUWFBSyBQv6GkigtWpO
	 6QjOSX0wwrlFFSUtmH+AgSGNEF8oS0w4B1c7aWYA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Sep 29 23:07:42 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 60A71C15E3FC;
	Fri, 29 Sep 2023 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696054062; bh=uZZ/iV5HsRBfmuhdjvoINiZyvKT29KRb3IBoFga5m2E=;
	h=From:In-Reply-To:Date:Cc:References:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=eUAPmSf5343Y6uYFBcbIRweV2yiQK5UkOKbZ74pJgVU/5RFHzplQbnnDvG4dFZZcU
	 m1RjRW45uIR0QwlxxYrJtq5J5cO4iKIx1u7wDLjJODaoyueAUWFBSyBQv6GkigtWpO
	 6QjOSX0wwrlFFSUtmH+AgSGNEF8oS0w4B1c7aWYA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1A6E5C15DD44
 for <bpf@ietfa.amsl.com>; Fri, 29 Sep 2023 23:07:41 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.907
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ON3d5b5voCtM for <bpf@ietfa.amsl.com>;
 Fri, 29 Sep 2023 23:07:37 -0700 (PDT)
Received: from smtp.zfn.uni-bremen.de (smtp.zfn.uni-bremen.de
 [IPv6:2001:638:708:32::21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 239EEC15E3FC
 for <bpf@ietf.org>; Fri, 29 Sep 2023 23:07:36 -0700 (PDT)
Received: from smtpclient.apple (eduroam-pool10-224.wlan.uni-bremen.de
 [134.102.90.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp.zfn.uni-bremen.de (Postfix) with ESMTPSA id 4RyGw24ZCTzDCcm;
 Sat, 30 Sep 2023 08:07:30 +0200 (CEST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
From: Carsten Bormann <cabo@tzi.org>
In-Reply-To: <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
Date: Sat, 30 Sep 2023 08:07:20 +0200
Cc: "bpf@ietf.org" <bpf@ietf.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Message-Id: <2E2AEB25-CD5D-4F1F-80D5-42715BC69ACF@tzi.org>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Mailer: Apple Mail (2.3731.700.6)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/iZXn5mrzwOQWAbxYEVBBb2DLHjE>
Subject: Re: [Bpf] Signed modulo operations
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SSBkaWRu4oCZdCBmb2xsb3cgdGhlIHdob2xlIGRpc2N1c3Npb24sIGJ1dCBpdCBtYXliZSBpdCdz
IHdvcnRoIHBvaW50aW5nIG91dCB0aGF0IEPigJlzICUgaXMgbm90IGEgbW9kdWxvIG9wZXJhdG9y
LCBidXQgYSByZW1haW5kZXIgb3BlcmF0b3IuCgpHcsO8w59lLCBDYXJzdGVuCgoKPiBPbiAyOS4g
U2VwIDIwMjMsIGF0IDIzOjAzLCBEYXZlIFRoYWxlciA8ZHRoYWxlcj00MG1pY3Jvc29mdC5jb21A
ZG1hcmMuaWV0Zi5vcmc+IHdyb3RlOgo+IAo+IEluIHRoZSBlbWFpbCBkaXNjdXNzaW9uIGJlbG93
LCB3ZSBjb25jbHVkZWQgaXQgd2Fzbid0IHJlbGV2YW50IGF0IHRoZSB0aW1lIGJlY2F1c2UKPiB0
aGVyZSB3ZXJlIG5vIHNpZ25lZCBtb2R1bG8gaW5zdHJ1Y3Rpb25zLiAgSG93ZXZlciwgbm93IHRo
ZXJlIGlzIGFuZCBJIGJlbGlldmUgdGhlCj4gYW1iaWd1aXR5IGluIHRoZSBjdXJyZW50IHNwZWMg
bmVlZHMgdG8gYmUgYWRkcmVzc2VkLgo+IAo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+
PiBGcm9tOiBEYXZlIFRoYWxlcgo+PiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAzMCwgMjAyMiAz
OjQyIFBNCj4+IFRvOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFp
bC5jb20+Cj4+IENjOiBkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbTsgYnBmQHZnZXIua2VybmVs
Lm9yZwo+PiBTdWJqZWN0OiBSRTogW1BBVENIIDA3LzE1XSBlYnBmLWRvY3M6IEZpeCBtb2R1bG8g
emVybywgZGl2aXNpb24gYnkgemVybywKPj4gb3ZlcmZsb3csIGFuZCB1bmRlcmZsb3cKPj4gCj4+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4gRnJvbTogQWxleGVpIFN0YXJvdm9pdG92
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPgo+Pj4gU2VudDogRnJpZGF5LCBTZXB0ZW1i
ZXIgMzAsIDIwMjIgMjo1OSBQTQo+Pj4gVG86IERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29m
dC5jb20+Cj4+PiBDYzogZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb207IGJwZkB2Z2VyLmtlcm5l
bC5vcmcKPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDcvMTVdIGVicGYtZG9jczogRml4IG1vZHVs
byB6ZXJvLCBkaXZpc2lvbiBieQo+Pj4gemVybywgb3ZlcmZsb3csIGFuZCB1bmRlcmZsb3cKPj4+
IAo+Pj4gT24gRnJpLCBTZXAgMzAsIDIwMjIgYXQgMDk6NTQ6MTdQTSArMDAwMCwgRGF2ZSBUaGFs
ZXIgd3JvdGU6Cj4+Pj4gWy4uLl0KPj4+Pj4+ICtBbHNvIG5vdGUgdGhhdCB0aGUgbW9kdWxvIG9w
ZXJhdGlvbiBvZnRlbiB2YXJpZXMgYnkgbGFuZ3VhZ2UKPj4+Pj4+ICt3aGVuIHRoZSBkaXZpZGVu
ZCBvciBkaXZpc29yIGFyZSBuZWdhdGl2ZSwgd2hlcmUgUHl0aG9uLCBSdWJ5LCBldGMuCj4+Pj4+
PiArZGlmZmVyIGZyb20gQywgR28sIEphdmEsIGV0Yy4gVGhpcyBzcGVjaWZpY2F0aW9uIHJlcXVp
cmVzIHRoYXQKPj4+Pj4+ICttb2R1bG8gdXNlIHRydW5jYXRlZCBkaXZpc2lvbiAod2hlcmUgLTEz
ICUgMyA9PSAtMSkgYXMKPj4+Pj4+ICtpbXBsZW1lbnRlZCBpbiBDLCBHbywKPj4+Pj4+ICtldGMu
Ogo+Pj4+Pj4gKwo+Pj4+Pj4gKyAgIGEgJSBuID0gYSAtIG4gKiB0cnVuYyhhIC8gbikKPj4+Pj4+
ICsKPj4+Pj4gCj4+Pj4+IEludGVyZXN0aW5nIGJpdCBvZiBpbmZvLCBidXQgSSdtIG5vdCBzdXJl
IGhvdyBpdCByZWxhdGVzIHRvIHRoZSBJU0EgZG9jLgo+Pj4+IAo+Pj4+IEl0J3MgYmVjYXVzZSB0
aGVyZSdzIG11bHRpcGxlIGRlZmluaXRpb25zIG9mIG1vZHVsbyBvdXQgdGhlcmUgYXMgdGhlCj4+
Pj4gcGFyYWdyYXBoIG5vdGVzLCB3aGljaCBkaWZmZXIgaW4gd2hhdCB0aGV5IGRvIHdpdGggbmVn
YXRpdmUgbnVtYmVycy4KPj4+PiBUaGUgSVNBIGRlZmluZXMgdGhlIG1vZHVsbyBvcGVyYXRpb24g
YXMgYmVpbmcgdGhlIHNwZWNpZmljIHZlcnNpb24gYWJvdmUuCj4+Pj4gSWYgeW91IHRyaWVkIHRv
IGltcGxlbWVudCB0aGUgSVNBIGluIHNheSBQeXRob24gYW5kIGRpZG4ndCBrbm93Cj4+Pj4gdGhh
dCwgeW91J2QgaGF2ZSBhIG5vbi1jb21wbGlhbnQgaW1wbGVtZW50YXRpb24uCj4+PiAKPj4+IElz
IGl0IGJlY2F1c2UgdGhlIGxhbmd1YWdlcyBoYXZlIHdlaXJkIHJ1bGVzIHRvIHBpY2sgYmV0d2Vl
biBzaWduZWQgdnMKPj4+IHVuc2lnbmVkIG1vZD8KPj4+IEF0IGxlYXN0IGZyb20gbGx2bSBwb3Yg
dGhlIHNtb2QgYW5kIHVtb2QgaGF2ZSBmaXhlZCBiZWhhdmlvci4KPj4gCj4+IEl0J3MgYmVjYXVz
ZSB0aGVyZSdzIGRpZmZlcmVudCBtYXRoZW1hdGljYWwgZGVmaW5pdGlvbnMgYW5kIGRpZmZlcmVu
dCBsYW5ndWFnZXMKPj4gaGF2ZSBjaG9zZW4gZGlmZmVyZW50IGRlZmluaXRpb25zLiAgRS5nLiwg
bGFuZ3VhZ2VzL2xpYnJhcmllcyB0aGF0IGZvbGxvdyBLbnV0aAo+PiB1c2UgYSBkaWZmZXJlbnQg
bWF0aGVtYXRpY2FsIGRlZmluaXRpb24gdGhhbiBDIHVzZXMuICBGb3IgZGV0YWlscyBzZWU6Cj4+
IAo+PiBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9Nb2R1bG9fb3BlcmF0aW9uI1Zhcmlh
bnRzX29mX3RoZV9kZWZpbml0aW9uCj4+IAo+PiBodHRwczovL3RvcnN0ZW5jdXJkdC5jb20vdGVj
aC9wb3N0cy9tb2R1bG8tb2YtbmVnYXRpdmUtbnVtYmVycy8KPj4gCj4+IERhdmUKPiAKPiBQZXJo
YXBzIHRleHQgbGlrZSB0aGUgcHJvcG9zZWQgc25pcHBldCBxdW90ZWQgaW4gdGhlIGV4Y2hhbmdl
IGFib3ZlIHNob3VsZCBiZQo+IGFkZGVkIGFyb3VuZCB0aGUgbmV3IHRleHQgdGhhdCBub3cgYXBw
ZWFycyBpbiB0aGUgZG9jLCBpLmUuIHRoZSBhbWJpZ3VvdXMgdGV4dAo+IGlzIGN1cnJlbnRseToK
Pj4gRm9yIHNpZ25lZCBvcGVyYXRpb25zIChgYEJQRl9TRElWYGAgYW5kIGBgQlBGX1NNT0RgYCks
IGZvciBgYEJQRl9BTFVgYCwKPj4gJ2ltbScgaXMgaW50ZXJwcmV0ZWQgYXMgYSAzMi1iaXQgc2ln
bmVkIHZhbHVlLiBGb3IgYGBCUEZfQUxVNjRgYCwgJ2ltbScKPj4gaXMgZmlyc3QgOnRlcm06YHNp
Z24gZXh0ZW5kZWQ8U2lnbiBFeHRlbmQ+YCBmcm9tIDMyIHRvIDY0IGJpdHMsIGFuZCB0aGVuCj4+
IGludGVycHJldGVkIGFzIGEgNjQtYml0IHNpZ25lZCB2YWx1ZS4gIAo+IAo+IERhdmUKPiAKPiAt
LSAKPiBCcGYgbWFpbGluZyBsaXN0Cj4gQnBmQGlldGYub3JnCj4gaHR0cHM6Ly93d3cuaWV0Zi5v
cmcvbWFpbG1hbi9saXN0aW5mby9icGYKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9y
ZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

