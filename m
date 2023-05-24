Return-Path: <bpf+bounces-1242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0B7112BC
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAC028156A
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3EC1F172;
	Thu, 25 May 2023 17:44:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9501DDC0
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:44:52 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944AC10C1
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:44:23 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D6564C16B5BD
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685036619; bh=4i8qnzb50aqMT6pHEDC5KJcn/VKPs/VVdq3LOISfHgA=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=tz3nNhJBe+LD8gTr4GT7Zdjewy5fLfKAFQDjxuMU6/sRDr9c34ybOtuzHycKXfcY0
	 n9uiMJEYlOOIuSAsU0ktmRb89L9EapcGwLqDUErvwhE8lo07ByWp45eQMZr8hjths/
	 dGO2GGRaPFHDSA0N8JNz6S79C7PWuyiRUtUp9tMQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu May 25 10:43:39 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8CDEAC13739E;
	Thu, 25 May 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685036619; bh=4i8qnzb50aqMT6pHEDC5KJcn/VKPs/VVdq3LOISfHgA=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=tz3nNhJBe+LD8gTr4GT7Zdjewy5fLfKAFQDjxuMU6/sRDr9c34ybOtuzHycKXfcY0
	 n9uiMJEYlOOIuSAsU0ktmRb89L9EapcGwLqDUErvwhE8lo07ByWp45eQMZr8hjths/
	 dGO2GGRaPFHDSA0N8JNz6S79C7PWuyiRUtUp9tMQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D81ECC1519B8
 for <bpf@ietfa.amsl.com>; Wed, 24 May 2023 14:06:37 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gnu.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALfTHleBxUpf for <bpf@ietfa.amsl.com>;
 Wed, 24 May 2023 14:06:33 -0700 (PDT)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D84F7C15199B
 for <bpf@ietf.org>; Wed, 24 May 2023 14:06:33 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemarch@gnu.org>)
 id 1q1vgk-0000Tf-3O; Wed, 24 May 2023 17:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=KckZTmo9Gc7wmnUqu5f/ww3uf3YmM1kpN4TCRRyqEOY=; b=Gcb3/Hc5igTEL+rpd29U
 Xbs6MS002bwiHmoIl/95jpHSlySpcbkjGn33002bm1DpZYwMbXD+CI4Q3/FGhLtLANkB2AmR4chjo
 JurOkdCIKnhBDIca7Y6jJmGVwUBBILD8TeL7POlXHDRjk2rBaYz3FAslJZIS+NmVrF1OjMprNLo9y
 2HZAf17leaPlcJ8S7YJ7PYuNUmHufogR6urZw3e/w9knyJwfxUbzOT2qe0dAh5+1G5fF9VV+AfQje
 /92XC8FuqKPPfoTnhh91uTghtVX9/3ybqBsJKh3dzugYW5C510T4N13czx95LC2Vrn/NZ4uGi+TfK
 Wn/BmGmU5CXe+w==;
Received: from dynamic-077-015-107-011.77.15.pool.telefonica.de
 ([77.15.107.11] helo=termi)
 by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemarch@gnu.org>)
 id 1q1vgj-0000lh-KZ; Wed, 24 May 2023 17:06:29 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Suresh Krishnan <suresh.krishnan@gmail.com>
Cc: David Vernet <void@manifault.com>,  Michael Richardson
 <mcr+ietf@sandelman.ca>,  "bpf@ietf.org" <bpf@ietf.org>,  bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Erik Kline
 <ek.ietf@gmail.com>,  "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
 Christoph Hellwig <hch@infradead.org>,  Dave Thaler <dthaler@microsoft.com>
In-Reply-To: <8FA12EFB-DB5A-4C6B-83BC-A3CBBE44F80B@gmail.com> (Suresh
 Krishnan's message of "Wed, 24 May 2023 16:38:12 -0400")
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge>
 <8FA12EFB-DB5A-4C6B-83BC-A3CBBE44F80B@gmail.com>
Date: Wed, 24 May 2023 23:06:23 +0200
Message-ID: <87a5xto2wg.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/d8b7yYlWlh_ownv02j7DabTBW00>
X-Mailman-Approved-At: Thu, 25 May 2023 10:43:38 -0700
Subject: Re: [Bpf] IETF BPF working group draft charter
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

Cj4gSGkgRGF2aWQsCj4gICBJIGp1c3Qgd2FudCB0byBwcm92aWRlIGEgcXVpY2sgY2xhcmlmaWNh
dGlvbiBmcm9tIHRoZSBJRVRGIHNpZGUKPiByZWdhcmRpbmcgY2F0ZWdvcmllcyBvZiBSRkNzLiBO
b3QgYWxsIHRoZSBSRkNzIHdlIHByb2R1Y2UgYXJlCj4gc3RhbmRhcmRzLiBPbiBhIGJyb2FkIGxl
dmVsIHdlIGhhdmUgc3RhbmRhcmRzIHRyYWNrIGFuZCBpbmZvcm1hdGlvbmFsCj4gZG9jdW1lbnRz
IChhbW9uZyBvdGhlcnM7IG1vcmUgZGV0YWlscyBpbiBSRkMyMDI2KS4gSSBkbyBiZWxpZXZlIHRo
ZXJlCj4gaXMgdmFsdWUgaW4gKmRvY3VtZW50aW5nKiBzb21lIG9mIHRoZSBpdGVtcyB0aGF0IGJl
bG9uZyBpbiBhbiBBQkkgc3VjaAo+IGFzIHRoZSBjYWxsaW5nIGNvbnZlbnRpb24gKHNpbWlsYXIg
dG8gd2hhdCBpcyBpbiBTZWN0aW9uIDIgb2YgdGhlIElTQQo+IGRyYWZ0KS4gU2ltaWxhcmx5LCB0
aGVyZSBpcyB2YWx1ZSBpbiBkb2N1bWVudGluZyBjb252ZW50aW9ucyBhbmQKPiBndWlkZWxpbmVz
IGZvciBjcmVhdGluZyBwb3J0YWJsZSBiaW5hcmllcyBpZiB3ZSBiZWxpZXZlIHRoYXQgaXMgYQo+
IHVzZWZ1bCBnb2FsLCBldmVuIHRob3VnaCB0aGVyZSB3aWxsIGJlIGEgbG90IG9mIHByb2dyYW1z
IHRoYXQgd2lsbCBub3QKPiBiZSBwb3J0YWJsZSAoZS5nLiB1c2luZyBjZ3JvdXBzKS4gSSB3b3Vs
ZCBub3QgZXhwZWN0IHRoZXNlIHRvIGJlCj4gU3RhbmRhcmRzIHRyYWNrIGRvY3VtZW50cyBidXQg
cmF0aGVyIEluZm9ybWF0aW9uYWwgc3BlY2lmaWNhdGlvbnMgdG8KPiBoZWxwIGltcGxlbWVudGVy
cy4gSWYgdGhhdCBzb3VuZHMgcmVhc29uYWJsZSB3ZSBjYW4ga2VlcCB0aGUgdGV4dCBpbgo+IHRo
ZSBjaGFydGVyICh3aXRoIHNvbWUgbWlub3IgcmV3b3JkaW5nKSBhbmQgd29yayBvbiBjYXRlZ29y
aXppbmcKPiBwb3RlbnRpYWwgZGVsaXZlcmFibGVzIGJ5IERvY3VtZW50IFN0YXR1cyAoYXMgd291
bGQgYW55d2F5IGJlCj4gbmVjZXNzaXRhdGVkIGJ5IMOJcmljIFZ5bmNrZeKAmXMgQkxPQ0spLgoK
SSB3b25kZXIuICBMZXRzIHN1cHBvc2UgdGhlIEFCSSBhbmQgRUxGIGV4dGVuc2lvbnMgYXJlIG1h
aW50YWluZWQgYW5kCmV2b2x2ZWQgaW4gdGhlIHVzdWFsIHdheSBpdCBpcyBkb25lIGZvciBhbGwg
b3RoZXIgYXJjaGl0ZWN0dXJlcywgaS5lLgppbiB0aGUga2VybmVsIGdpdCByZXBvc2l0b3J5IG9y
IGEgZGVkaWNhdGQgcHVibGljIG9uZSwgaW4gdGV4dHVhbCBmb3JtLAp1bmRlciBhIGZyZWUgc29m
dHdhcmUgbGljZW5zZSwgbm90IHJlcXVpcmluZyBjb3B5cmlnaHQgYXNzaWdubWVudHMgbm9yCmJ1
cmVvY3JhdGljIHByb2Nlc3NlcyB0byBiZSB1cGRhdGVkLCBldGMuICBDb3VsZCB0aGVuIHRoZSBX
RyBlZGl0IGFuZApwdWJsaXNoICJzbmFwc2hvdHMiIHdoZW5ldmVyIGNvbnNpZGVyZWQgYXBwcm9w
cmlhdGUsIGFuZCByZWxlYXNlIHRoZW0gYXMKc3Vic2VxdWVudCB2ZXJzaW9ucyBvZiBhbiBJRVRG
IEluZm9ybWF0aW9uYWwgc3BlY2lmaWNhdGlvbiwgb3Igc29tZQpvdGhlciBzdWl0YWJsZSBraW5k
IG9mIElFVEYgZG9jdW1lbnQ/CgpJZiBzb21ldGhpbmcgbGlrZSB0aGF0IHdvdWxkIGJlIGRvYWJs
ZSwgbWF5YmUgd2UgY291bGQgY29uY2lsZSB0aGUKcHJhY3RpY2FsaXR5IG9mIHRoZSB1c3VhbCBh
cHByb2FjaCB3aXRoIHRoZSBtb3JlIGZvcm1hbCBjaGFyYWN0ZXIgb2YgYW4KSUVURiBkb2N1bWVu
dD8KCj4gUmVnYXJkcwo+IFN1cmVzaAo+Cj4+IE9uIE1heSAyMywgMjAyMywgYXQgNDoyOCBQTSwg
RGF2aWQgVmVybmV0IDx2b2lkQG1hbmlmYXVsdC5jb20+IHdyb3RlOgo+PiAKPj4gT24gVHVlLCBN
YXkgMjMsIDIwMjMgYXQgMDE6NTg6MThQTSAtMDQwMCwgTWljaGFlbCBSaWNoYXJkc29uIHdyb3Rl
Ogo+Pj4gCj4+PiBEYXZpZCBWZXJuZXQgPHZvaWRAbWFuaWZhdWx0LmNvbSA8bWFpbHRvOnZvaWRA
bWFuaWZhdWx0LmNvbT4+IHdyb3RlOgo+Pj4+IEFzIGZhciBhcyBJIGtub3cgKHBsZWFzZSBjb3Jy
ZWN0IG1lIGlmIEknbSB3cm9uZyksIHRoZXJlIGlzbid0IHJlYWxseSBhCj4+Pj4gcHJlY2VkZW5j
ZSBmb3Igc3RhbmRhcmRpemluZyBBQklzIGxpa2UgdGhpcy4gRm9yIGV4YW1wbGUsIHg4NiBjYWxs
aW5nCj4+PiAKPj4+IEFsbCBvZiB0aGUgZUJQRiB3b3JrIHNlZW1zIHVucHJlY2VkZW50ZWQuCj4+
PiBJIGRvbid0IHNlZSBoYXZpbmcgdGhpcyBpbiB0aGUgY2hhcnRlciBpcyBhIHByb2JsZW0uCj4+
PiAKPj4+IFdlIG1heSBmYWlsIHRvIGdldCBjb25zZW5zdXMgb24gaXQsIGFuZCBub3QgbWFrZSBh
IG1pbGVzdG9uZSwgYnV0IEkgZG9uJ3Qgc2VlCj4+PiBhIHJlYXNvbiBub3QgdG8gYmUgYWxsb3dl
ZCB0byB0YWxrIGFib3V0IHRoaXMuCj4+PiAoYW5kIG1heWJlIGluIHRoZSBlbmQsIGl0J3MgYSBu
by1vcCkKPj4gCj4+IEhpIE1pY2hhZWwsCj4+IAo+PiBTbyBhcG9sb2dpZXMgaW4gYWR2YW5jZSBp
ZiBteSBsYWNrIG9mIGV4cGVyaWVuY2Ugd2l0aCBJRVRGIHByb2NlZWRpbmdzCj4+IGlzIGdsYXJp
bmdseSBvYnZpb3VzLCBhbmQgSSdkIGFwcHJlY2lhdGUgY2xhcmlmaWNhdGlvbiBpbiBhbnkgc2l0
dWF0aW9uCj4+IGluIHdoaWNoIEknbSBtaXN0YWtlbi4KPj4gCj4+IE15IHVuZGVyc3RhbmRpbmcg
YmFzZWQgb24gdGhlIGNvbnZlcnNhdGlvbnMgdGhhdCBJJ3ZlIGhhZCB0aHVzIGZhciBpcwo+PiB0
aGF0IHBhcnQgb2YgdGhlIGdvYWwgb2YgYXJyaXZpbmcgYXQgdGhlIGZpbmFsaXplZCBXRyBjaGFy
dGVyIGlzIHRvCj4+IGRldGVybWluZSB3aGF0J3MgaW4gc2NvcGUgYW5kIG91dCBvZiBzY29wZS4g
SXQncyBhIGJpdCBvZiBhIG11cmt5Cj4+IHByb3Bvc2l0aW9uIGJlY2F1c2Ugc29tZSB0aGluZ3Mg
dGhhdCB3ZSB0aGluayBfY291bGRfIGJlIGluIHNjb3BlLCBzdWNoCj4+IGFzIGluIHRoaXMgY2Fz
ZSB0b3BpY3MgcmVsYXRlZCB0byBwc0FCSSwgbWF5IG5vdCBlbmQgdXAgaGF2aW5nIGEKPj4gZG9j
dW1lbnQgaWYgd2UgY2FuJ3QgZ2V0IGNvbnNlbnN1cy4gSW4gb3RoZXIgd29yZHMsIGJlaW5nIGlu
IHRoZSBXRwo+PiBjaGFydGVyIGRvZXNuJ3QgaW1wbHkgdGhhdCBzb21ldGhpbmcgaXMgaW4tc2Nv
cGUgYW5kIHdpbGwgaGF2ZSBhCj4+IGRvY3VtZW50IHdyaXR0ZW4sIGJ1dCBfbm90XyBiZWluZyBp
biB0aGUgY2hhcnRlciBkb2VzIHByZWNsdWRlIGl0IGZyb20KPj4gYmVpbmcgZGlzY3Vzc2VkIGlu
IHRoaXMgaXRlcmF0aW9uIG9mIHRoZSBXRyBiZWNhdXNlIG9mIHRoaXMgbGluZToKPj4gCj4+PiBU
aGUgd29ya2luZyBncm91cCBzaGFsbCBub3QgYWRvcHQgbmV3IHdvcmsgdW50aWwgdGhlc2UKPj4+
IGRvY3VtZW50cyBoYXZlIHByb2dyZXNzZWQgdG8gd29ya2luZyBncm91cCBsYXN0IGNhbGwuCj4+
IAo+PiBUaGUgaW1wbGljYXRpb24gb2YgdGhpcyBpcyB0aGF0IGl0J3Mgbm90IG5lY2Vzc2FyaWx5
IGEgcHJvYmxlbSB0byBoYXZlCj4+IHNvbWUgZmFsc2UtcG9zaXRpdmVzIGluIHRlcm1zIG9mIHdo
YXQgd2UgY292ZXIsIGJ1dCBpdCBjYW4gYmUKPj4gcHJvYmxlbWF0aWMgaWYgd2UgbGVhdmUgb3V0
IHNvbWV0aGluZyBpbXBvcnRhbnQgYmVjYXVzZSB3ZSdsbCBoYXZlIHRvCj4+IGNvdmVyIGFsbCBv
ZiB0aGUgb3RoZXIgdG9waWNzIGZpcnN0LiBJJ2QgaW1hZ2luZSB0aGlzIHdvdWxkIHRlbmQgdG8g
bWFrZQo+PiB0aGUgZGVmYXVsdCBiZWhhdmlvciBmb3IgZGVjaWRpbmcgc2NvcGUgaW4gV0cgY2hh
cnRlcnMgdG8gYmUgcGVybWlzc2l2ZQo+PiByYXRoZXIgdGhhbiBkaXNzbWl2ZSwgd2hpY2ggbWFr
ZXMgc2Vuc2UgdG8gbWUuCj4+IAo+PiBBc3N1bWluZyBJIGhhdmVuJ3QgYWxyZWFkeSBnb25lIG9m
ZiB0aGUgcmFpbHMgaW4gdGVybXMgb2YgbXkKPj4gdW5kZXJzdGFuZGluZywgbGV0IG1lIHRyeSB0
byBjbGFyaWZ5IHdoeSBkZXNwaXRlIGFsbCB0aGF0LCBJIHN0aWxsIHRoaW5rCj4+IGl0J3Mgd2Fy
cmFudGVkIGZvciB1cyB0byByZW1vdmUgcHNBQkkgYXMgcGFydCBvZiB0aGUgc2NvcGUgb2YgdGhl
IFdHLgo+PiBUaGVyZSBhcmUgcmVhbGx5IHR3byBtYWluIHJlYXNvbnM6Cj4+IAo+PiAxLiBBcyBp
cyBob3BlZnVsbHkgY2xlYXIgYXQgdGhpcyBwb2ludCwgdGhlcmUgaXMgYSB3aWRlIGFuZCBoaXN0
b3JpY2FsCj4+ICAgaW5kdXN0cnkgcHJlY2VkZW5jZSBmb3Igbm90IHN0YW5kYXJkaXppbmcgb24g
cHNBQkkuIEZvciBleGFtcGxlLCB0bwo+PiAgIG15IGtub3dsZWRnZSwgUklTQy1WIFswXSBkZXZl
bG9wcyBhbmQgcmF0aWZpZXMgdGhlIFJJU0MtViBJU0EgdGhyb3VnaAo+PiAgIHRoZSBSSVNDLVYg
SW50ZXJuYXRpb25hbCBUZWNobmljYWwgV29ya2luZyBHcm91cHMsIGJ1dCB0aGVyZSBpcyBubwo+
PiAgIHN1Y2ggcmF0aWZpZWQgc3RhbmRhcmQgb3Igc3BlY2lmaWNhdGlvbiBmb3IgUklTQy1WIGNh
bGxpbmcKPj4gICBjb252ZW50aW9ucyAodGhlIG9wZXJhdGl2ZSB3b3JkIG9mIGNvdXJzZSBiZWlu
ZyAiY29udmVudGlvbiIpLiBUaGUKPj4gICBzYW1lIGlzIHRydWUgKHRvIG15IGtub3dsZWRnZSkg
b2YgX2FsbF8gcHNBQkkgRUxGIGV4dGVuc2lvbnMsIGFzIEpvc2UKPj4gICBwb2ludGVkIG91dCBl
YXJsaWVyIGluIHRoZSBjb252ZXJzYXRpb24uCj4+IAo+PiBbMF06IGh0dHBzOi8vcmlzY3Yub3Jn
L3RlY2huaWNhbC9zcGVjaWZpY2F0aW9ucy8gPGh0dHBzOi8vcmlzY3Yub3JnL3RlY2huaWNhbC9z
cGVjaWZpY2F0aW9ucy8+Cj4+IAo+PiAgIFdpdGggYWxsIHRoYXQgc2FpZCwgdW5sZXNzIHRoZXJl
J3MgbW9yZSBjb250ZXh0IGJlaGluZCB3aHkgd2UgdGhpbmsgd2UKPj4gICBuZWVkIHRvIHN0YW5k
YXJkaXplIHBzQUJJIHdoaWNoIGhhc24ndCB5ZXQgYmVlbiBicm91Z2h0IGZvcndhcmQsIEkKPj4g
ICBkb24ndCBzZWUgYW55IHdheSB3ZSdkIGFjaGlldmUgY29uc2Vuc3VzIHdoZW4gd2UgZGlzY3Vz
cyBpdCBpbiB0aGUKPj4gICBXRy4gQW5kIHRoZSByZWFzb24gSSBzcGVjaWZpY2FsbHkgdGhpbmsg
dGhhdCdzIHRoZSBjYXNlIGZvciBBQkkgKEVMRgo+PiAgIG9yIG90aGVyd2lzZSkgaXMgdGhhdCB0
aGVyZSdzIHN1Y2ggYSB3ZWxsLWVzdGFibGlzaGVkIHByZWNlZGVuY2UKPj4gICBhbHJlYWR5IGZv
ciBub3Qgc3RhbmRhcmRpemluZyBpdC4gSSBndWVzcyBpdCdzIHRydWUgdGhhdCB0aGVyZSdzIG5v
Cj4+ICAgaGFybSBpbiBpbmNsdWRpbmcgaXQgYW5kIGRpc2N1c3NpbmcgaXQsIGJ1dCBhcyB0aGlu
Z3MgY3VycmVudGx5Cj4+ICAgc3RhbmQsIGl0IGFsc28gZG9lc24ndCBzZWVtIHZlcnkgcHJvZHVj
dGl2ZSB0byBpbmNsdWRlIGl0IGlmIHRoZXJlJ3MKPj4gICBhbHJlYWR5IChJTUhPKSByZWFzb25h
Ymx5IGNsZWFyIGV2aWRlbmNlIHRoYXQgaXQncyBvdXQgb2Ygc2NvcGUuIFRvCj4+ICAgZ28gYmFj
ayB0byBteSBjbGFpbSBtYWRlIGluIGFub3RoZXIgZW1haWwsIEkgdGhpbmsgdGhlIG9udXMgaXMg
b24gdGhlCj4+ICAgZm9sa3Mgd2hvIHRoaW5rIGl0J3MgaW4gc2NvcGUgdG8gZXhwbGFpbiB3aHks
IHJhdGhlciB0aGFuIHRoZSBmb2xrcwo+PiAgIHdobyB0aGluayB3ZSBzaG91bGQgZm9sbG93IGlu
ZHVzdHJ5IHByZWNlZGVuY2UgdG8ganVzdGlmeSB0aGF0Lgo+PiAKPj4gMi4gQXNzdW1pbmcgdGhh
dCBJJ20gd3JvbmcsIGFuZCBBQkkgLyBFTEYgYXJlIGluIHNjb3BlIGZvcgo+PiAgIHN0YW5kYXJk
aXphdGlvbiwgd2Ugd291bGQgc3RpbGwgaGF2ZSB0byBkbyBhIGxvdCBvZiBwcmVtbGltaW5hcnkK
Pj4gICB3b3JrIHRvIGRldGVybWluZSB0aGF0LiBGb3IgZXhhbXBsZSwgd2UgbWF5IGVuZCB1cCB3
YW50aW5nIHRvCj4+ICAgc3RhbmRhcmRpemUgdGhhdCBtYXBzIGFyZSBwdXQgaW50byAubWFwcyBz
ZWN0aW9ucyBpbiBhbiBFTEYgZmlsZSwgYnV0Cj4+ICAgdGhhdCB3b3VsZCBvbmx5IG1ha2Ugc2Vu
c2UgaWYgd2UgY3JlYXRlZCBhIGRvY3VtZW50IHN0YW5kYXJkaXppbmcKPj4gICBjcm9zcy1wbGF0
Zm9ybSBtYXAgdHlwZXMuIFRoZSBzYW1lIGhvbGRzIHRydWUgZm9yIGNyb3NzLXBsYXRmb3JtCj4+
ICAgcHJvZ3JhbSB0eXBlcywgZXRjLiBUaGUgZGVwZW5kZW5jeSBEQUcgZm9yIGRpc2N1c3Npbmcg
RUxGIGhhcyBhIGRlcHRoCj4+ICAgb2YgYXQgbGVhc3QgMiwgYW5kIGdpdmVuIHRoYXQgaXQncyBh
cy15ZXQgdW5jbGVhciB3aGV0aGVyIEVMRiAvIHBzQUJJCj4+ICAgaXMgYW4gYXBwcm9wcmlhdGUg
dG9waWMgZm9yIHN0YW5kYXJkaXphdGlvbiBpbiB0aGUgZmlyc3QgcGxhY2UsIGl0Cj4+ICAgcmVh
bGx5IGZlZWxzIHRvIG1lIGxpa2UgbGVhdmluZyBpdCBvdXQgb2YgdGhlIFdHIGlzIHRoZSByaWdo
dCBtb3ZlLgo+PiAKPj4gVGhhbmtzLAo+PiBEYXZpZAo+PiAKPj4+IAo+Pj4gLS0KPj4+IE1pY2hh
ZWwgUmljaGFyZHNvbiA8bWNyK0lFVEZAc2FuZGVsbWFuLmNhPiAgIC4gbyBPICggSVB2NiBJw7hU
IGNvbnN1bHRpbmcgKQo+Pj4gICAgICAgICAgIFNhbmRlbG1hbiBTb2Z0d2FyZSBXb3JrcyBJbmMs
IE90dGF3YSBhbmQgV29ybGR3aWRlCj4+PiAKPj4+IAo+Pj4gCj4+PiAKPj4gCj4+IAo+PiAKPj4+
IC0tIAo+Pj4gQnBmIG1haWxpbmcgbGlzdAo+Pj4gQnBmQGlldGYub3JnCj4+PiBodHRwczovL3d3
dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo+PiAKPj4gLS0gCj4+IEJwZiBtYWlsaW5n
IGxpc3QKPj4gQnBmQGlldGYub3JnIDxtYWlsdG86QnBmQGlldGYub3JnPgo+PiBodHRwczovL3d3
dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZiA8aHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFp
bG1hbi9saXN0aW5mby9icGY+CgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0
cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

