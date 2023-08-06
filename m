Return-Path: <bpf+bounces-7095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3F77134F
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 05:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418F7281470
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 03:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0917F6;
	Sun,  6 Aug 2023 03:02:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367CC17D1
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 03:02:14 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E73D1BD0
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 20:02:11 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0CC31C151719
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 20:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691290931; bh=oDPIAtaf/Iy4Wyq3e8tJz2qB4av55qgkGlhlaMz+bWE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Ja1OEUQM/PPS8K0CMZrcR25AX0njdSlZdO5JEwii+0hYdOTiAv5/2SovJSCPSnmiM
	 7J5rB/uJpDEP//a7F32HxulDkYTK5fJ+BYrNjPXx8SyO03B4i85k8tL5NgLeFiz93k
	 edKoZwDT2l7RcNNGrQh4yu2Y7QuhveNfEOOqETk4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Aug  5 20:02:10 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CFF11C14CF1D;
	Sat,  5 Aug 2023 20:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691290930; bh=oDPIAtaf/Iy4Wyq3e8tJz2qB4av55qgkGlhlaMz+bWE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=IMvfRNXebRoOncrY6cY5BMg1Fmptggy3g7Ten3F34rYgSU4OWdRIF6GMg/FHE2V9j
	 bMntW4zUBLKBSC3iKqF2FcK8x6ldM3fS/9Xthm1ap/07CItyHb2XH9bqCa+06fthgd
	 gg0h8K7NWUYz1/q66lB2UUBEMudSuiovItN7QfEg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A9F89C14CF1D
 for <bpf@ietfa.amsl.com>; Sat,  5 Aug 2023 20:02:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.907
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDNrbnTSCTaV for <bpf@ietfa.amsl.com>;
 Sat,  5 Aug 2023 20:02:09 -0700 (PDT)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0E77EC14CF13
 for <bpf@ietf.org>; Sat,  5 Aug 2023 20:02:08 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-63d23473ed5so19880266d6.1
 for <bpf@ietf.org>; Sat, 05 Aug 2023 20:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691290928; x=1691895728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwVtGyJoygHRbKK7G//JOBv2hhfyU7zcS7PGe4tdbw8=;
 b=Rchn3asYxI0E/Otv0nktwPUg6KWe8N3AWaHpfgPIksLt5ZhPshOwU4+ufBO877qv4G
 kjkYtLj67ZranxJ+dIKBxedQFOKjT4AvusVAoPJJDLMGD9YJE4KoLKD9RTixbZqHGCC2
 WD8wv8lx+b8o65lg5g6eWfOlI1NIsIX9GsSCgrxUDJ6TjS2NhCbG4VrloUlbkx0QD5G5
 70HChI4VKq3+mX+3mx4ZVrxIM77FAV96SpQ2mSPe8HqcHPrSUet4ie5RPp6nVzwrhi33
 d6OZVsUeqHLhcXyohTqZXgUKOjSIfS0ObXv8CC82X9CEay8wRFaQ2iscTMB+2EZLm69q
 G9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691290928; x=1691895728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwVtGyJoygHRbKK7G//JOBv2hhfyU7zcS7PGe4tdbw8=;
 b=VKEoLGCeJIlc8PQDYtqhVLwURLdJAkM0EN2QI+MmaeduLH7/5TNG4R7o1oJTlXD5O8
 mSgEd9193i/d6SWnpRau5EVmImclVMIhxPPUBDxqWGWFyZOikCQnX1Z7FABECQPjdlHH
 1SFGKgmYtxO9cc5yv8OsE5v2Tt5BQAAVX4JeXdg5XqqUL7wMMaI4PozFEEfk9j+PITN3
 IDIT3n3qJO6JJMhq3phc3hcSX/mF0OwVhYmi+yjmEmExOGubmd5P0C/yUtUP7KvmD8od
 BkeV3AZI4Gb06HxCN8RLvgrWwoNU3ZLUs4ypF+OV/pk45E/1bWZ7gqYvqqDzExB9v9tE
 XAmQ==
X-Gm-Message-State: AOJu0Yzd1CD2SkuYObAB8SlimRf6/RXwRnXT1ZVxL2foQyMYoWTxNCFT
 TgC1+ZgM/73+EAhGlAG41gm6901Mej4M7Y6x/fuF1KmO0DBkiush
X-Google-Smtp-Source: AGHT+IGhCG+dAlFjfneKh06y7MKelhVSPsyZc2CNCl6A9NgfIJVlNJPPyBpTwo0Xr9cGorweHfmSVDXTit1F3n/sgmY=
X-Received: by 2002:a0c:f249:0:b0:63d:6330:b53a with SMTP id
 z9-20020a0cf249000000b0063d6330b53amr5609882qvl.52.1691290927602; Sat, 05 Aug
 2023 20:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230805030921.52035-1-hawkinsw@obs.cr>
 <20230805141427.GC519395@maniforge>
In-Reply-To: <20230805141427.GC519395@maniforge>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 5 Aug 2023 23:01:57 -0400
Message-ID: <CADx9qWh5Z6epKSMA=nN+D7r6Q5O3t-6mdSjyx6SquZhAPHb5DA@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/QQxBTSl3AxYI2NTO_nNdp5MiZxI>
Subject: Re: [Bpf] [PATCH v3 1/2] bpf,
 docs: Formalize type notation and function semantics in ISA standard
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

T24gU2F0LCBBdWcgNSwgMjAyMyBhdCAxMDoxNOKAr0FNIERhdmlkIFZlcm5ldCA8dm9pZEBtYW5p
ZmF1bHQuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgQXVnIDA0LCAyMDIzIGF0IDExOjA5OjE4UE0g
LTA0MDAsIFdpbGwgSGF3a2lucyB3cm90ZToKPiA+IEdpdmUgYSBzaW5nbGUgcGxhY2Ugd2hlcmUg
dGhlIHNob3J0aGFuZCBmb3IgdHlwZXMgYXJlIGRlZmluZWQsIHRoZQo+ID4gc2VtYW50aWNzIG9m
IGhlbHBlciBmdW5jdGlvbnMgYXJlIGRlc2NyaWJlZCwgYW5kIGNlcnRhaW4gdGVybXMgY2FuCj4g
PiBiZSBkZWZpbmVkLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2lu
c3dAb2JzLmNyPgo+Cj4gSGkgV2lsbCwKPgo+IFRoaXMgaXMgbG9va2luZyBncmVhdC4gTGVmdCBh
IGNvdXBsZSBtb3JlIGNvbW1lbnRzIGJlbG93LCBsZXQgbWUga25vdwo+IHdoYXQgeW91IHRoaW5r
LgoKVGhhbmtzIGZvciB0aGUgZmVlZGJhY2shCgo+Cj4gPiAtLS0KPiA+ICAuLi4vYnBmL3N0YW5k
YXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0ICAgfCA3OSArKysrKysrKysrKysrKysrKy0t
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4g
Pgo+ID4gIENoYW5nZWxvZzoKPiA+ICAgIHYxIC0+IHYyOgo+ID4gICAgICAgICAgLSBSZW1vdmUg
Y2hhbmdlIHRvIFNwaGlueCB2ZXJzaW9uCj4gPiAgICAgICAgICAgICAgICAtIEFkZHJlc3MgRGF2
aWQncyBjb21tZW50cwo+ID4gICAgICAgICAgICAgICAgLSBBZGRyZXNzIERhdmUncyBjb21tZW50
cwo+ID4gICAgdjIgLT4gdjM6Cj4gPiAgICAgICAgICAtIEFkZCBpbmZvcm1hdGlvbiBhYm91dCBz
aWduIGV4dGVuZGluZwo+ID4KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9zdGFu
ZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5k
YXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiBpbmRleCA2NTU0OTRhYzdhZjYuLmZl
Mjk2ZjM1ZTVhNyAxMDA2NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXph
dGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFu
ZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gQEAgLTEwLDkgKzEwLDY4IEBAIFRo
aXMgZG9jdW1lbnQgc3BlY2lmaWVzIHZlcnNpb24gMS4wIG9mIHRoZSBlQlBGIGluc3RydWN0aW9u
IHNldC4KPiA+ICBEb2N1bWVudGF0aW9uIGNvbnZlbnRpb25zCj4gPiAgPT09PT09PT09PT09PT09
PT09PT09PT09PQo+ID4KPiA+IC1Gb3IgYnJldml0eSwgdGhpcyBkb2N1bWVudCB1c2VzIHRoZSB0
eXBlIG5vdGlvbiAidTY0IiwgInUzMiIsIGV0Yy4KPiA+IC10byBtZWFuIGFuIHVuc2lnbmVkIGlu
dGVnZXIgd2hvc2Ugd2lkdGggaXMgdGhlIHNwZWNpZmllZCBudW1iZXIgb2YgYml0cywKPiA+IC1h
bmQgInMzMiIsIGV0Yy4gdG8gbWVhbiBhIHNpZ25lZCBpbnRlZ2VyIG9mIHRoZSBzcGVjaWZpZWQg
bnVtYmVyIG9mIGJpdHMuCj4gPiArRm9yIGJyZXZpdHkgYW5kIGNvbnNpc3RlbmN5LCB0aGlzIGRv
Y3VtZW50IHJlZmVycyB0byBmYW1pbGllcwo+ID4gK29mIHR5cGVzIHVzaW5nIGEgc2hvcnRoYW5k
IHN5bnRheCBhbmQgcmVmZXJzIHRvIHNldmVyYWwgZXhwb3NpdG9yeSwKPiA+ICttbmVtb25pYyBm
dW5jdGlvbnMgd2hlbiBkZXNjcmliaW5nIHRoZSBzZW1hbnRpY3Mgb2Ygb3Bjb2Rlcy4gVGhlIHJh
bmdlCj4KPiBIbW0sIEkgd29uZGVyIGlmIGl0J3Mgc2xpZ2h0bHkgbW9yZSBhY2N1cmF0ZSB0byBz
YXkgdGhhdCB0aG9zZSBmdW5jdGlvbnMKPiBhcmUgZGVzY3JpYmluZyB0aGUgc2VtYW50aWNzIG9m
ICJpbnN0cnVjdGlvbnMiIHJhdGhlciB0aGFuICJvcGNvZGVzIiwKPiBnaXZlbiB0aGF0IHRoZSB2
YWx1ZSBpbiB0aGUgaW1tZWRpYXRlIGZvciB0aGUgYnl0ZSBzd2FwIGluc3RydWN0aW9ucwo+IGRp
Y3RhdGUgdGhlIHdpZHRoLiBXaGF0IGRvIHlvdSB0aGluaz8KCkdyZWF0IHBvaW50IQoKPgo+ID4g
K29mIHZhbGlkIHZhbHVlcyBmb3IgdGhvc2UgdHlwZXMgYW5kIHRoZSBzZW1hbnRpY3Mgb2YgdGhv
c2UgZnVuY3Rpb25zCj4gPiArYXJlIGRlZmluZWQgaW4gdGhlIGZvbGxvd2luZyBzdWJzZWN0aW9u
cy4KPiA+ICsKPiA+ICtUeXBlcwo+ID4gKy0tLS0tCj4gPiArVGhpcyBkb2N1bWVudCByZWZlcnMg
dG8gaW50ZWdlciB0eXBlcyB3aXRoIGEgbm90YXRpb24gb2YgdGhlIGZvcm0gYFNOYAo+ID4gK3Ro
YXQgc3VjY2luY3RseSBkZWZpbmVzIHdoZXRoZXIgdGhlaXIgdmFsdWVzIGFyZSBzaWduZWQgb3Ig
dW5zaWduZWQKPgo+IFN1Z2dlc3Rpb246IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0aGUgd29yZCAi
c3VjY2luY3RseSIgaGVyZS4gSSdtIGFsc28KPiBpbmNsaW5lZCB0byBzdWdnZXN0IHRoYXQgd2Ug
YXZvaWQgdXNpbmcgdGhlIHdvcmQgImRlZmluZSIgaGVyZSwgYXMgdGhlCj4gbm90YXRpb24gaXRz
ZWxmIGlzbid0IHJlYWxseSBkZWZpbmluZyB0aGUgdmFsdWVzIG9mIHRoZSB0eXBlcywgYnV0IGlz
Cj4gcmF0aGVyIGp1c3QgYSBzaG9ydGhhbmQuCgpZZXMhCgo+Cj4gPiArbnVtYmVycyBhbmQgdGhl
IGJpdCB3aWR0aHM6Cj4KPiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlzIHBocmFzaW5nOgo+
Cj4gVGhpcyBkb2N1bWVudCByZWZlcnMgdG8gaW50ZWdlciB0eXBlcyB3aXRoIHRoZSBub3RhdGlv
biBgU05gIHRvIHNwZWNpZnkKPiBhIHR5cGUncyBzaWduZWRuZXNzIGFuZCBiaXQgd2lkdGggcmVz
cGVjdGl2ZWx5Lgo+Cj4gRmVlbCBmcmVlIHRvIGRpc2FncmVlLiBNeSB0aGlua2luZyBoZXJlIGlz
IHRoYXQgaXQgbWlnaHQgbWFrZSBtb3JlIHNlbnNlCj4gdG8gZXhwbGFpbiB0aGUgbm90YXRpb24g
YXMgYW4gaW5mb3JtYWwgc2hvcnRoYW5kIHJhdGhlciB0aGFuIGFzIGEgZm9ybWFsCj4gZGVmbml0
aW9uLCBhcyBtYWtpbmcgaXQgYSBmb3JtYWwgZGVmaW5pdGlvbiBtaWdodCBvcGVuIGl0cyBvd24g
Y2FuIG9mCj4gd29ybXMgKGUuZy4gd2Ugd291bGQgcHJvYmFibHkgYWxzbyBoYXZlIHRvIGRlZmlu
ZSB3aGF0IHNpZ25lZG5lc3MgbWVhbnMsCj4gZXRjKS4KCkkgdGhpbmsgdGhhdCB5b3UgbWFrZSBh
biBleGNlbGxlbnQgcG9pbnQuIFdlIGhhdmUgYWxyZWFkeSBnb25lCmJhY2svZm9ydGggYWJvdXQg
d2hldGhlciB0aGVyZSBpcyBnb2luZyB0byBiZSBhIGRlZmluaXRpb24gZm9yIHRoZQoidHlwZSIg
b2Ygc2lnbmVkbmVzcyB0aGF0IHdlIHVzZSBpbiB0aGUgcmVwcmVzZW50YXRpb24gKGkuZS4sIHR3
bydzCmNvbXBsZW1lbnQsIG9uZSdzIGNvbXBsZW1lbnQsIHNpZ24gbWFnbml0dWRlLCBldGMpIGFu
ZCB3ZSBkZWZpbml0ZWx5CmRvbid0IHdhbnQgdG8gcnVzaCBpbiB0byB0aGF0IHJhYmJpdCBob2xl
IGFnYWluLiBJIHdpbGwgaW5jb3Jwb3JhdGUKeW91ciBzdWdnZXN0aW9uIGluIHRoZSBuZXh0IHJl
dmlzaW9uLgoKPgo+ID4gKwo+ID4gKz09PSA9PT09PT09Cj4gPiArYFNgIE1lYW5pbmcKPiA+ICs9
PT0gPT09PT09PQo+ID4gK2B1YCB1bnNpZ25lZAo+ID4gK2BzYCBzaWduZWQKPiA+ICs9PT0gPT09
PT09PQo+ID4gKwo+ID4gKz09PT09ID09PT09PT09PQo+ID4gK2BOYCAgIEJpdCB3aWR0aAo+ID4g
Kz09PT09ID09PT09PT09PQo+ID4gK2A4YCAgIDggYml0cwo+ID4gK2AxNmAgIDE2IGJpdHMKPiA+
ICtgMzJgICAzMiBiaXRzCj4gPiArYDY0YCAgNjQgYml0cwo+ID4gK2AxMjhgIDEyOCBiaXRzCj4g
PiArPT09PT0gPT09PT09PT09Cj4KPiBJcyBpdCBieSBhbnkgY2hhbmNlIHBvc3NpYmxlIHRvIHB1
dCB0aGVzZSB0d28gdGFibGVzIG9uIHRoZSBzYW1lIHJvdz8KPiBOb3Qgc3VyZSBpZiByc3QgaXMg
dXAgdG8gdGhhdCBjaGFsbGVuZ2UsIGFuZCBpZiBub3QgZmVlbCBmcmVlIHRvIGlnbm9yZS4KCkkg
d291bGQgbG92ZSB0byBtYWtlIHRoYXQgaGFwcGVuLiBNeSByc3Qgc2tpbGxzIGFyZSBkZXZlbG9w
aW5nIGFuZCBJCndpbGwgc2VlIHdoYXQgSSBjYW4gZG8hCgo+Cj4gPiArCj4gPiArRm9yIGV4YW1w
bGUsIGB1MzJgIGlzIGEgdHlwZSB3aG9zZSB2YWxpZCB2YWx1ZXMgYXJlIGFsbCB0aGUgMzItYml0
IHVuc2lnbmVkCj4gPiArbnVtYmVycyBhbmQgYHMxNmAgaXMgYSB0eXBlcyB3aG9zZSB2YWxpZCB2
YWx1ZXMgYXJlIGFsbCB0aGUgMTYtYml0IHNpZ25lZAo+ID4gK251bWJlcnMuCj4gPiArCj4gPiAr
RnVuY3Rpb25zCj4gPiArLS0tLS0tLS0tCj4gPiArKiBgaHRvYmUxNmA6IFRha2VzIGFuIHVuc2ln
bmVkIDE2LWJpdCBudW1iZXIgaW4gaG9zdC1lbmRpYW4gZm9ybWF0IGFuZAo+ID4gKyAgcmV0dXJu
cyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgMTYtYml0IG51bWJlciBpbiBi
aWctZW5kaWFuCj4gPiArICBmb3JtYXQuCj4gPiArKiBgaHRvYmUzMmA6IFRha2VzIGFuIHVuc2ln
bmVkIDMyLWJpdCBudW1iZXIgaW4gaG9zdC1lbmRpYW4gZm9ybWF0IGFuZAo+ID4gKyAgcmV0dXJu
cyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgMzItYml0IG51bWJlciBpbiBi
aWctZW5kaWFuCj4gPiArICBmb3JtYXQuCj4gPiArKiBgaHRvYmU2NGA6IFRha2VzIGFuIHVuc2ln
bmVkIDY0LWJpdCBudW1iZXIgaW4gaG9zdC1lbmRpYW4gZm9ybWF0IGFuZAo+ID4gKyAgcmV0dXJu
cyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgNjQtYml0IG51bWJlciBpbiBi
aWctZW5kaWFuCj4gPiArICBmb3JtYXQuCj4gPiArKiBgaHRvbGUxNmA6IFRha2VzIGFuIHVuc2ln
bmVkIDE2LWJpdCBudW1iZXIgaW4gaG9zdC1lbmRpYW4gZm9ybWF0IGFuZAo+ID4gKyAgcmV0dXJu
cyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgMTYtYml0IG51bWJlciBpbiBs
aXR0bGUtZW5kaWFuCj4gPiArICBmb3JtYXQuCj4gPiArKiBgaHRvbGUzMmA6IFRha2VzIGFuIHVu
c2lnbmVkIDMyLWJpdCBudW1iZXIgaW4gaG9zdC1lbmRpYW4gZm9ybWF0IGFuZAo+ID4gKyAgcmV0
dXJucyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgMzItYml0IG51bWJlciBp
biBsaXR0bGUtZW5kaWFuCj4gPiArICBmb3JtYXQuCj4gPiArKiBgaHRvbGU2NGA6IFRha2VzIGFu
IHVuc2lnbmVkIDY0LWJpdCBudW1iZXIgaW4gaG9zdC1lbmRpYW4gZm9ybWF0IGFuZAo+ID4gKyAg
cmV0dXJucyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgNjQtYml0IG51bWJl
ciBpbiBsaXR0bGUtZW5kaWFuCj4gPiArICBmb3JtYXQuCj4gPiArKiBgYnN3YXAxNmA6IFRha2Vz
IGFuIHVuc2lnbmVkIDE2LWJpdCBudW1iZXIgaW4gZWl0aGVyIGJpZy0gb3IgbGl0dGxlLWVuZGlh
bgo+ID4gKyAgZm9ybWF0IGFuZCByZXR1cm5zIHRoZSBlcXVpdmFsZW50IG51bWJlciB3aXRoIHRo
ZSBzYW1lIGJpdCB3aWR0aCBidXQKPiA+ICsgIG9wcG9zaXRlIGVuZGlhbm5lc3MuCj4gPiArKiBg
YnN3YXAzMmA6IFRha2VzIGFuIHVuc2lnbmVkIDMyLWJpdCBudW1iZXIgaW4gZWl0aGVyIGJpZy0g
b3IgbGl0dGxlLWVuZGlhbgo+ID4gKyAgZm9ybWF0IGFuZCByZXR1cm5zIHRoZSBlcXVpdmFsZW50
IG51bWJlciB3aXRoIHRoZSBzYW1lIGJpdCB3aWR0aCBidXQKPiA+ICsgIG9wcG9zaXRlIGVuZGlh
bm5lc3MuCj4gPiArKiBgYnN3YXA2NGA6IFRha2VzIGFuIHVuc2lnbmVkIDY0LWJpdCBudW1iZXIg
aW4gZWl0aGVyIGJpZy0gb3IgbGl0dGxlLWVuZGlhbgo+ID4gKyAgZm9ybWF0IGFuZCByZXR1cm5z
IHRoZSBlcXVpdmFsZW50IG51bWJlciB3aXRoIHRoZSBzYW1lIGJpdCB3aWR0aCBidXQKPiA+ICsg
IG9wcG9zaXRlIGVuZGlhbm5lc3MuCj4KPiBVcG9uIGZ1cnRoZXIgcmVmbGVjdGlvbiwgbWF5YmUg
dGhpcyBiZWxvbmdzIGluIHRoZSBCeXRlIHN3YXAKPiBpbnN0cnVjdGlvbnMgc2VjdGlvbiBvZiB0
aGUgZG9jdW1lbnQ/IFRoZSB0eXBlcyBtYWtlIHNlbnNlIHRvIGxpc3QgYWJvdmUKPiBiZWNhdXNl
IHRoZXkncmUgdWJpcXVpdG91cyB0aHJvdWdob3V0IHRoZSBkb2MsIGJ1dCB0aGVzZSBhcmUgcmVh
bGx5IDEwMCUKPiBzcGVjaWZpYyB0byBieXRlIHN3YXAuCgpJIGFtIG5vdCBvcHBvc2VkIHRvIHRo
YXQuIFRoZSBvbmx5IHJlYXNvbiB0aGF0IEkgcHV0IHRoZW0gaGVyZSB3YXMgdG8KbWFrZSBpdCBm
dWxseSBjZW50cmFsaXplZC4gVGhleSBhcmUgYWxzbyBnb2luZyB0byBiZSB1c2VkIGluIHRoZQpB
cHBlbmRpeCBhbmQgSSB3YXMgaG9waW5nIG5vdCB0byBoYXZlIHRvIHJlcHJvZHVjZSB0aGVtIHRo
ZXJlLiBJbiB2NApvZiB0aGUgcGF0Y2ggSSB3aWxsIGxlYXZlIHRoZW0gaGVyZSBhbmQgdGhlbiBp
ZiB3ZSBkbyBmZWVsIGxpa2Ugd2UKc2hvdWxkIG1vdmUgdGhlbSBJIHdpbGwgaGFwcGlseSBtYWtl
IGEgdjUhCgpUaGFuayB5b3UgYWdhaW4gZm9yIHRoZSBmZWVkYmFjayEgQSBuZXcgcmV2aXNpb24g
b2YgdGhlIHBhdGNoIHdpbGwgYmUKb3V0IHNob3J0bHkhCgpIYXZlIGEgZ3JlYXQgcmVzdCBvZiB0
aGUgd2Vla2VuZCEKV2lsbAoKPgo+ID4KPiA+ICBSZWdpc3RlcnMgYW5kIGNhbGxpbmcgY29udmVu
dGlvbgo+ID4gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiBAQCAtMjUyLDE5
ICszMTEsMjMgQEAgYXJlIHN1cHBvcnRlZDogMTYsIDMyIGFuZCA2NC4KPiA+Cj4gPiAgRXhhbXBs
ZXM6Cj4gPgo+ID4gLWBgQlBGX0FMVSB8IEJQRl9UT19MRSB8IEJQRl9FTkRgYCB3aXRoIGltbSA9
IDE2IG1lYW5zOjoKPiA+ICtgYEJQRl9BTFUgfCBCUEZfVE9fTEUgfCBCUEZfRU5EYGAgd2l0aCBp
bW0gPSAxNi8zMi82NCBtZWFuczo6Cj4gPgo+ID4gICAgZHN0ID0gaHRvbGUxNihkc3QpCj4gPiAr
ICBkc3QgPSBodG9sZTMyKGRzdCkKPiA+ICsgIGRzdCA9IGh0b2xlNjQoZHN0KQo+ID4KPiA+IC1g
YEJQRl9BTFUgfCBCUEZfVE9fQkUgfCBCUEZfRU5EYGAgd2l0aCBpbW0gPSA2NCBtZWFuczo6Cj4g
PiArYGBCUEZfQUxVIHwgQlBGX1RPX0JFIHwgQlBGX0VORGBgIHdpdGggaW1tID0gMTYvMzIvNjQg
bWVhbnM6Ogo+ID4KPiA+ICsgIGRzdCA9IGh0b2JlMTYoZHN0KQo+ID4gKyAgZHN0ID0gaHRvYmUz
Mihkc3QpCj4gPiAgICBkc3QgPSBodG9iZTY0KGRzdCkKPiA+Cj4gPiAgYGBCUEZfQUxVNjQgfCBC
UEZfVE9fTEUgfCBCUEZfRU5EYGAgd2l0aCBpbW0gPSAxNi8zMi82NCBtZWFuczo6Cj4gPgo+ID4g
LSAgZHN0ID0gYnN3YXAxNiBkc3QKPiA+IC0gIGRzdCA9IGJzd2FwMzIgZHN0Cj4gPiAtICBkc3Qg
PSBic3dhcDY0IGRzdAo+ID4gKyAgZHN0ID0gYnN3YXAxNihkc3QpCj4gPiArICBkc3QgPSBic3dh
cDMyKGRzdCkKPiA+ICsgIGRzdCA9IGJzd2FwNjQoZHN0KQo+ID4KPgo+IFsuLi5dCj4KPiAtIERh
dmlkCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5v
cmcvbWFpbG1hbi9saXN0aW5mby9icGYK

