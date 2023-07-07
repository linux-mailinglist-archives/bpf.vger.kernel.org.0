Return-Path: <bpf+bounces-4366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120274A839
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0337281425
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ECB110F;
	Fri,  7 Jul 2023 00:46:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4F7F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 00:46:22 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496AA19BD
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:46:21 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1197BC1526F7
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688690781; bh=MRDCgyZetjqJJ3NbTGhYscTIoushhj5kU1U/jPOmGhA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=tQj/R+1J+LvdIFi67fc1mLLY6XPUCFn/TcOw2HyR+EhlLqS349vxOmPVlXoDRE9f+
	 Qjro46/Fk3gP7BPJffxgVdjwVI3PKOPUZ6Dbwe//tR/YPkTwEZyArW4BeQAQ57w8IH
	 zQURcBGVtfnbX3putu9mxKepKzOYM6P1BwLd8ZlQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul  6 17:46:21 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DE717C15199F;
	Thu,  6 Jul 2023 17:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688690780; bh=MRDCgyZetjqJJ3NbTGhYscTIoushhj5kU1U/jPOmGhA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=HwlwdWu7ZP3YfR1bKi66yP5plUz1e3mBPEflDBYOy0ThFhiL0/6iL80fttB9cLv6p
	 ul2ViQYcCJMXmlPaaXwk6FWzZwput97lO7zzX8Cjl3XLf+7hEinijCy+Re679d3v/c
	 W8dGH7iLufFm1Yv7AiUAQdayhm7873Hz9j0a75Zk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 87616C15199F
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 17:46:19 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.897
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xY5mAhvL1IY for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 17:46:18 -0700 (PDT)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id DCC95C151081
 for <bpf@ietf.org>; Thu,  6 Jul 2023 17:46:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7653bd3ff2fso134397985a.3
 for <bpf@ietf.org>; Thu, 06 Jul 2023 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688690777; x=1691282777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYVwt83WbqMvn4f2pxzshe+36GeTFxuSw4Vys39lq2Y=;
 b=gA9v5HwyNsM6qpNxgT0sqFmBJJdk+LqfBb7wdfi4Wh5Z6kjy1KgndtIUTQEjl1EN8/
 8hR787z4rHFdIHFntCeK0lwk4dF1iJrOVZ3G9b91AtrKWIlAviNyAqXiBEkwtwL6KteY
 PmoXO9UstLU8w5rJleqc/np+c/iGpNbNj+yydqSodetc/rDEZMhSJ2M25t7kOwtUjBm1
 jgoY4xETYP4KMVxQvQ8j2lts49hzFqaSM+oKzDoFCcqduq6tnmVQHIqfMPnqi6zhUSex
 yCAO/j/Qcc+HZF9g21YM0fzw59SUyONMUDtcnLCsu4CpfDSCSnXJhNhcAmTh6yEInAX0
 vd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688690777; x=1691282777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYVwt83WbqMvn4f2pxzshe+36GeTFxuSw4Vys39lq2Y=;
 b=Xz7WAm+I+/Bp521z8ivRfCyvO9g3rl8phAGwlKeJObTCv8Z9GvraEoZIP7uefRxyQR
 tnPZdfiDiWf8fHpYTXYjAKlEvn5gL5ORv6QxfJohgh64EpMJrrcU/nBAhmT7RSOq2/Xx
 K/fuLuUO6iXNDgXOuQ+u7d+eshnsVFqTCwnJPBCIiH/CsN1EeGfxWamtMP/98GVzqzeF
 L49FvmkkUo3m+672G32DKGtiRqGTeeuEsLplW7C+K7uhR+QMXVYYVLxF8uip/q6/EXn8
 PzFqA7UJ2l9/RYkQnLRvzbBCIIVuRSprInRTUtEDQZ8XiZryo38uUF2So2xl//XpQem8
 KOPA==
X-Gm-Message-State: ABy/qLbAWDegi5oOxMomIoIsb8pGMJjKpCpIw0xJ0qJzXpAN9M1WajZN
 jWCEV8ZH/fuRZLdpqFnnr0TmC0x0bM897GiOYH4XTw==
X-Google-Smtp-Source: APBJJlHF9SDSuxVzrP+u2/S10pfwf9cQ1t7T+f3WID3qleaW9iqAVJ+mADSmggSfzPI6zhFGugP4B1tnRhpL7d6vccE=
X-Received: by 2002:a05:620a:2450:b0:767:4cb2:3145 with SMTP id
 h16-20020a05620a245000b007674cb23145mr5172885qkn.41.1688690777396; Thu, 06
 Jul 2023 17:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706222020.268136-1-hawkinsw@obs.cr>
 <20230706222020.268136-2-hawkinsw@obs.cr>
 <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 6 Jul 2023 20:46:06 -0400
Message-ID: <CADx9qWjPir2wsRUNJopeT=daQz7rz=hhTJCM=FwCcLo96vY84A@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/jxEGTFvNyaqPHgy89BK8ccH5bDk>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
 docs: Describe stack contents of function calls
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCA3OjMy4oCvUE0gQWxleGVpIFN0YXJvdm9pdG92CjxhbGV4
ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgSnVsIDYsIDIwMjMg
YXQgMzoyMOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+Cj4g
PiBUaGUgZXhlY3V0aW9uIG9mIGV2ZXJ5IGZ1bmN0aW9uIHByb2NlZWRzIGFzIGlmIGl0IGhhcyBh
Y2Nlc3MgdG8gaXRzIG93bgo+ID4gc3RhY2sgc3BhY2UuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTog
V2lsbCBIYXdraW5zIDxoYXdraW5zd0BvYnMuY3I+Cj4gPiAtLS0KPiA+ICBEb2N1bWVudGF0aW9u
L2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0IHwgNSArKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvaW5z
dHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QK
PiA+IGluZGV4IDc1MWU2NTc5NzNmMC4uNzE3MjU5NzY3YTQxIDEwMDY0NAo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gQEAgLTMwLDYgKzMwLDExIEBAIFRoZSBlQlBG
IGNhbGxpbmcgY29udmVudGlvbiBpcyBkZWZpbmVkIGFzOgo+ID4gIFIwIC0gUjUgYXJlIHNjcmF0
Y2ggcmVnaXN0ZXJzIGFuZCBlQlBGIHByb2dyYW1zIG5lZWRzIHRvIHNwaWxsL2ZpbGwgdGhlbSBp
Zgo+ID4gIG5lY2Vzc2FyeSBhY3Jvc3MgY2FsbHMuCj4gPgo+ID4gK0V2ZXJ5IGZ1bmN0aW9uIGlu
dm9jYXRpb24gcHJvY2VlZHMgYXMgaWYgaXQgaGFzIGV4Y2x1c2l2ZSBhY2Nlc3MgdG8gYW4KPiA+
ICtpbXBsZW1lbnRhdGlvbi1kZWZpbmVkIGFtb3VudCBvZiBzdGFjayBzcGFjZS4gUjEwIGlzIGEg
cG9pbnRlciB0byB0aGUgYnl0ZSBvZgo+ID4gK21lbW9yeSB3aXRoIHRoZSBoaWdoZXN0IGFkZHJl
c3MgaW4gdGhhdCBzdGFjayBzcGFjZS4gVGhlIGNvbnRlbnRzCj4gPiArb2YgYSBmdW5jdGlvbiBp
bnZvY2F0aW9uJ3Mgc3RhY2sgc3BhY2UgZG8gbm90IHBlcnNpc3QgYmV0d2VlbiBpbnZvY2F0aW9u
cy4KPgo+IFN1Y2ggZGVzY3JpcHRpb24gYmVsb25ncyBpbiBhIGZ1dHVyZSBwc0FCSSBkb2MuCj4g
aW5zdHJ1Y3Rpb24tc2V0LnJzdCBpcyBub3QgYSBwbGFjZSB0byBkZXNjcmliZSBob3cgcmVnaXN0
ZXJzIGFyZSB1c2VkLgoKVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2shCgpIb3cgZG9lcyB5b3Vy
IGNvbW1lbnQgc3F1YXJlIHdpdGggdGhlIGltbWVkaWF0ZWx5IHByZWNlZGluZwpkZXNjcmlwdGlv
biBpbiB0aGUgZG9jdW1lbnQgdGhhdCBzYXlzOgoKUjEwOiByZWFkLW9ubHkgZnJhbWUgcG9pbnRl
ciB0byBhY2Nlc3Mgc3RhY2sKCihhbW9uZyB0aGUgZGVzY3JpcHRpb24gb2YgaG93IG90aGVyIHJl
Z2lzdGVycyBhcmUgdXNlZCBkdXJpbmcgZnVuY3Rpb24gY2FsbHMpLgoKU29ycnkgaWYgSSBhbSBi
ZWluZyBkZW5zZSBhbmQvb3IgbmFpdmUuCgpTaW5jZXJlbHksCldpbGwKCj4gRm9yIGV4YW1wbGUg
eDg2LTY0IEpJVCBtYXBzIEJQRiBSMTAgdG8gUkJQLgo+IFlldCB0aGVyZSBpcyAtZm9taXQtZnJh
bWUtcG9pbnRlci4KPiBTbyB3ZSBtaWdodCB2ZXJ5IHdlbGwgZG8gc29tZXRoaW5nIGxpa2UgdGhh
dCBpbiB0aGUgZnV0dXJlLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBz
Oi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

