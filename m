Return-Path: <bpf+bounces-7168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78357726E2
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C231C20BA8
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5B10959;
	Mon,  7 Aug 2023 14:02:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D3443A
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 14:02:03 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC18F2715
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 07:01:59 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6813CC15C509
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691416919; bh=P/8T3bKtQb2WBWS4UY5z9DZGmVpHbQ3T5Ibk/m8Z5M4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=US9v8usej8fXIyRxn5GStd4kZXcVDrKnEudaN/nwoU2HIA4a43t9wDQPlzvISHrhJ
	 H3oQbPVG/Bd48Ffyzbr0lmvJUYnP9s7QUj80g+WiJDLfpu74luCm9J4CO0iROP5Zq0
	 ODLrboX/rtjOoH2dNvGs53P+OSql+Zyu6u0kZW84=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug  7 07:01:59 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2CABDC153CBB;
	Mon,  7 Aug 2023 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691416919; bh=P/8T3bKtQb2WBWS4UY5z9DZGmVpHbQ3T5Ibk/m8Z5M4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=US9v8usej8fXIyRxn5GStd4kZXcVDrKnEudaN/nwoU2HIA4a43t9wDQPlzvISHrhJ
	 H3oQbPVG/Bd48Ffyzbr0lmvJUYnP9s7QUj80g+WiJDLfpu74luCm9J4CO0iROP5Zq0
	 ODLrboX/rtjOoH2dNvGs53P+OSql+Zyu6u0kZW84=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7BBE5C153CBF
 for <bpf@ietfa.amsl.com>; Mon,  7 Aug 2023 07:01:57 -0700 (PDT)
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
 with ESMTP id gwreAgcYgiEt for <bpf@ietfa.amsl.com>;
 Mon,  7 Aug 2023 07:01:56 -0700 (PDT)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D2509C153CBB
 for <bpf@ietf.org>; Mon,  7 Aug 2023 07:01:56 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bca3311b4fso3585803a34.0
 for <bpf@ietf.org>; Mon, 07 Aug 2023 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691416916; x=1692021716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3p47eUi+34rCRXY22J4MldsiLN4h+zU8wuiEtA7A1LA=;
 b=Tpo4PSRSGSyj+3GwDRzncDaAOvJj2BcKs7Da3DRgSY0FekoFjQ7hkfYoi1a+gqExzM
 rmYggFCYKCHYvlUCoZas9gzYdLN7m8TuRoG1UYP8j2NL3+UUJDvUE1ctNwnV1lRJxwKA
 MUzMiz7PYUDNQqk8+YKJckqe8dBGhRg+4nWnytX9cHhJ6Lp/Lhz82d+y/lnXjMHpXTtJ
 CFh+SBSn8R6tgXnGrmqGp8ZDfA8HA4y2D2OdT9TM3kMdY1D/YruHsjhAqjGPwz+T3LcI
 EcMPwGUvUJ66TnZEr2LfRkVuusAuSwSoued4cN5EeVik5Z12Rl/aoW2IKWNNPkTaxFsT
 N5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691416916; x=1692021716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3p47eUi+34rCRXY22J4MldsiLN4h+zU8wuiEtA7A1LA=;
 b=SRoCO1eUBv2rje4BPpc00pKpPa8oGeV75cmVOCH9DoqTAecf7/MOvLDC6smHxmQdJw
 sPPg2gUFQoF3w+hikJveR0xproYrzKLzUp/h98UXVTD0x1+DDYva/xi2CzR0AR1z19YX
 o482hQKlUZYsdTj+kjMHvQgvW9MARYV+Q0Fg/b+rB0yyIjrGE+slsGiTkzXYymtR1WYx
 VsS942Psq7VhRKOmVW95O3Y8GAmW/pByDv2RbOb4iUN01VulEJjGFqER5RMAhLKV9/GM
 99fTrEsEE8p+R/c8igWw3PBKaJQLv0z5OiziWCo9lpIGucc/ni4HMDOKM88fOk9AePVL
 sSRg==
X-Gm-Message-State: AOJu0Yxn01xDSaohHj5Ai7Tbm6Ho0oVbl+3qRzX4AMD5Qye9wZzajhK4
 ToCZ7Y5j07WUzq170p319I8aijtq3MsxcrWLrilmZA==
X-Google-Smtp-Source: AGHT+IHC77WW6SFX8LyWQVfP44h4aM7G3pHLO18AwhTOaA3J37M4W1YrgCKJRmV3VMrew+W7HwUZA25iprp1bFYzFvY=
X-Received: by 2002:aca:1314:0:b0:3a3:76c6:a46f with SMTP id
 e20-20020aca1314000000b003a376c6a46fmr10496969oii.38.1691416915747; Mon, 07
 Aug 2023 07:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230805030921.52035-1-hawkinsw@obs.cr>
 <20230805141427.GC519395@maniforge>
 <CADx9qWh5Z6epKSMA=nN+D7r6Q5O3t-6mdSjyx6SquZhAPHb5DA@mail.gmail.com>
In-Reply-To: <CADx9qWh5Z6epKSMA=nN+D7r6Q5O3t-6mdSjyx6SquZhAPHb5DA@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 7 Aug 2023 10:01:44 -0400
Message-ID: <CADx9qWjNFTEutq+yaHUqcbVoEyT4QfTjoUCt2z5TYe-n7O_mjw@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/vl2GaYhUBYMC18i0NloNtok3Co0>
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

T24gU2F0LCBBdWcgNSwgMjAyMyBhdCAxMTowMeKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IE9uIFNhdCwgQXVnIDUsIDIwMjMgYXQgMTA6MTTigK9BTSBEYXZp
ZCBWZXJuZXQgPHZvaWRAbWFuaWZhdWx0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBBdWcg
MDQsIDIwMjMgYXQgMTE6MDk6MThQTSAtMDQwMCwgV2lsbCBIYXdraW5zIHdyb3RlOgo+ID4gPiBH
aXZlIGEgc2luZ2xlIHBsYWNlIHdoZXJlIHRoZSBzaG9ydGhhbmQgZm9yIHR5cGVzIGFyZSBkZWZp
bmVkLCB0aGUKPiA+ID4gc2VtYW50aWNzIG9mIGhlbHBlciBmdW5jdGlvbnMgYXJlIGRlc2NyaWJl
ZCwgYW5kIGNlcnRhaW4gdGVybXMgY2FuCj4gPiA+IGJlIGRlZmluZWQuCj4gPiA+Cj4gPiA+IFNp
Z25lZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPgo+ID4KPiA+IEhpIFdp
bGwsCj4gPgo+ID4gVGhpcyBpcyBsb29raW5nIGdyZWF0LiBMZWZ0IGEgY291cGxlIG1vcmUgY29t
bWVudHMgYmVsb3csIGxldCBtZSBrbm93Cj4gPiB3aGF0IHlvdSB0aGluay4KPgo+IFRoYW5rcyBm
b3IgdGhlIGZlZWRiYWNrIQo+Cj4gPgo+ID4gPiAtLS0KPiA+ID4gIC4uLi9icGYvc3RhbmRhcmRp
emF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgICB8IDc5ICsrKysrKysrKysrKysrKysrLS0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+ID4g
Pgo+ID4gPiAgQ2hhbmdlbG9nOgo+ID4gPiAgICB2MSAtPiB2MjoKPiA+ID4gICAgICAgICAgLSBS
ZW1vdmUgY2hhbmdlIHRvIFNwaGlueCB2ZXJzaW9uCj4gPiA+ICAgICAgICAgICAgICAgIC0gQWRk
cmVzcyBEYXZpZCdzIGNvbW1lbnRzCj4gPiA+ICAgICAgICAgICAgICAgIC0gQWRkcmVzcyBEYXZl
J3MgY29tbWVudHMKPiA+ID4gICAgdjIgLT4gdjM6Cj4gPiA+ICAgICAgICAgIC0gQWRkIGluZm9y
bWF0aW9uIGFib3V0IHNpZ24gZXh0ZW5kaW5nCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3Vt
ZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0Cj4gPiA+IGlu
ZGV4IDY1NTQ5NGFjN2FmNi4uZmUyOTZmMzVlNWE3IDEwMDY0NAo+ID4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+
ID4gPiBAQCAtMTAsOSArMTAsNjggQEAgVGhpcyBkb2N1bWVudCBzcGVjaWZpZXMgdmVyc2lvbiAx
LjAgb2YgdGhlIGVCUEYgaW5zdHJ1Y3Rpb24gc2V0Lgo+ID4gPiAgRG9jdW1lbnRhdGlvbiBjb252
ZW50aW9ucwo+ID4gPiAgPT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4gPgo+ID4gPiAtRm9y
IGJyZXZpdHksIHRoaXMgZG9jdW1lbnQgdXNlcyB0aGUgdHlwZSBub3Rpb24gInU2NCIsICJ1MzIi
LCBldGMuCj4gPiA+IC10byBtZWFuIGFuIHVuc2lnbmVkIGludGVnZXIgd2hvc2Ugd2lkdGggaXMg
dGhlIHNwZWNpZmllZCBudW1iZXIgb2YgYml0cywKPiA+ID4gLWFuZCAiczMyIiwgZXRjLiB0byBt
ZWFuIGEgc2lnbmVkIGludGVnZXIgb2YgdGhlIHNwZWNpZmllZCBudW1iZXIgb2YgYml0cy4KPiA+
ID4gK0ZvciBicmV2aXR5IGFuZCBjb25zaXN0ZW5jeSwgdGhpcyBkb2N1bWVudCByZWZlcnMgdG8g
ZmFtaWxpZXMKPiA+ID4gK29mIHR5cGVzIHVzaW5nIGEgc2hvcnRoYW5kIHN5bnRheCBhbmQgcmVm
ZXJzIHRvIHNldmVyYWwgZXhwb3NpdG9yeSwKPiA+ID4gK21uZW1vbmljIGZ1bmN0aW9ucyB3aGVu
IGRlc2NyaWJpbmcgdGhlIHNlbWFudGljcyBvZiBvcGNvZGVzLiBUaGUgcmFuZ2UKPiA+Cj4gPiBI
bW0sIEkgd29uZGVyIGlmIGl0J3Mgc2xpZ2h0bHkgbW9yZSBhY2N1cmF0ZSB0byBzYXkgdGhhdCB0
aG9zZSBmdW5jdGlvbnMKPiA+IGFyZSBkZXNjcmliaW5nIHRoZSBzZW1hbnRpY3Mgb2YgImluc3Ry
dWN0aW9ucyIgcmF0aGVyIHRoYW4gIm9wY29kZXMiLAo+ID4gZ2l2ZW4gdGhhdCB0aGUgdmFsdWUg
aW4gdGhlIGltbWVkaWF0ZSBmb3IgdGhlIGJ5dGUgc3dhcCBpbnN0cnVjdGlvbnMKPiA+IGRpY3Rh
dGUgdGhlIHdpZHRoLiBXaGF0IGRvIHlvdSB0aGluaz8KPgo+IEdyZWF0IHBvaW50IQo+Cj4gPgo+
ID4gPiArb2YgdmFsaWQgdmFsdWVzIGZvciB0aG9zZSB0eXBlcyBhbmQgdGhlIHNlbWFudGljcyBv
ZiB0aG9zZSBmdW5jdGlvbnMKPiA+ID4gK2FyZSBkZWZpbmVkIGluIHRoZSBmb2xsb3dpbmcgc3Vi
c2VjdGlvbnMuCj4gPiA+ICsKPiA+ID4gK1R5cGVzCj4gPiA+ICstLS0tLQo+ID4gPiArVGhpcyBk
b2N1bWVudCByZWZlcnMgdG8gaW50ZWdlciB0eXBlcyB3aXRoIGEgbm90YXRpb24gb2YgdGhlIGZv
cm0gYFNOYAo+ID4gPiArdGhhdCBzdWNjaW5jdGx5IGRlZmluZXMgd2hldGhlciB0aGVpciB2YWx1
ZXMgYXJlIHNpZ25lZCBvciB1bnNpZ25lZAo+ID4KPiA+IFN1Z2dlc3Rpb246IEkgZG9uJ3QgdGhp
bmsgd2UgbmVlZCB0aGUgd29yZCAic3VjY2luY3RseSIgaGVyZS4gSSdtIGFsc28KPiA+IGluY2xp
bmVkIHRvIHN1Z2dlc3QgdGhhdCB3ZSBhdm9pZCB1c2luZyB0aGUgd29yZCAiZGVmaW5lIiBoZXJl
LCBhcyB0aGUKPiA+IG5vdGF0aW9uIGl0c2VsZiBpc24ndCByZWFsbHkgZGVmaW5pbmcgdGhlIHZh
bHVlcyBvZiB0aGUgdHlwZXMsIGJ1dCBpcwo+ID4gcmF0aGVyIGp1c3QgYSBzaG9ydGhhbmQuCj4K
PiBZZXMhCj4KPiA+Cj4gPiA+ICtudW1iZXJzIGFuZCB0aGUgYml0IHdpZHRoczoKPiA+Cj4gPiBX
aGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlzIHBocmFzaW5nOgo+ID4KPiA+IFRoaXMgZG9jdW1l
bnQgcmVmZXJzIHRvIGludGVnZXIgdHlwZXMgd2l0aCB0aGUgbm90YXRpb24gYFNOYCB0byBzcGVj
aWZ5Cj4gPiBhIHR5cGUncyBzaWduZWRuZXNzIGFuZCBiaXQgd2lkdGggcmVzcGVjdGl2ZWx5Lgo+
ID4KPiA+IEZlZWwgZnJlZSB0byBkaXNhZ3JlZS4gTXkgdGhpbmtpbmcgaGVyZSBpcyB0aGF0IGl0
IG1pZ2h0IG1ha2UgbW9yZSBzZW5zZQo+ID4gdG8gZXhwbGFpbiB0aGUgbm90YXRpb24gYXMgYW4g
aW5mb3JtYWwgc2hvcnRoYW5kIHJhdGhlciB0aGFuIGFzIGEgZm9ybWFsCj4gPiBkZWZuaXRpb24s
IGFzIG1ha2luZyBpdCBhIGZvcm1hbCBkZWZpbml0aW9uIG1pZ2h0IG9wZW4gaXRzIG93biBjYW4g
b2YKPiA+IHdvcm1zIChlLmcuIHdlIHdvdWxkIHByb2JhYmx5IGFsc28gaGF2ZSB0byBkZWZpbmUg
d2hhdCBzaWduZWRuZXNzIG1lYW5zLAo+ID4gZXRjKS4KPgo+IEkgdGhpbmsgdGhhdCB5b3UgbWFr
ZSBhbiBleGNlbGxlbnQgcG9pbnQuIFdlIGhhdmUgYWxyZWFkeSBnb25lCj4gYmFjay9mb3J0aCBh
Ym91dCB3aGV0aGVyIHRoZXJlIGlzIGdvaW5nIHRvIGJlIGEgZGVmaW5pdGlvbiBmb3IgdGhlCj4g
InR5cGUiIG9mIHNpZ25lZG5lc3MgdGhhdCB3ZSB1c2UgaW4gdGhlIHJlcHJlc2VudGF0aW9uIChp
LmUuLCB0d28ncwo+IGNvbXBsZW1lbnQsIG9uZSdzIGNvbXBsZW1lbnQsIHNpZ24gbWFnbml0dWRl
LCBldGMpIGFuZCB3ZSBkZWZpbml0ZWx5Cj4gZG9uJ3Qgd2FudCB0byBydXNoIGluIHRvIHRoYXQg
cmFiYml0IGhvbGUgYWdhaW4uIEkgd2lsbCBpbmNvcnBvcmF0ZQo+IHlvdXIgc3VnZ2VzdGlvbiBp
biB0aGUgbmV4dCByZXZpc2lvbi4KPgo+ID4KPiA+ID4gKwo+ID4gPiArPT09ID09PT09PT0KPiA+
ID4gK2BTYCBNZWFuaW5nCj4gPiA+ICs9PT0gPT09PT09PQo+ID4gPiArYHVgIHVuc2lnbmVkCj4g
PiA+ICtgc2Agc2lnbmVkCj4gPiA+ICs9PT0gPT09PT09PQo+ID4gPiArCj4gPiA+ICs9PT09PSA9
PT09PT09PT0KPiA+ID4gK2BOYCAgIEJpdCB3aWR0aAo+ID4gPiArPT09PT0gPT09PT09PT09Cj4g
PiA+ICtgOGAgICA4IGJpdHMKPiA+ID4gK2AxNmAgIDE2IGJpdHMKPiA+ID4gK2AzMmAgIDMyIGJp
dHMKPiA+ID4gK2A2NGAgIDY0IGJpdHMKPiA+ID4gK2AxMjhgIDEyOCBiaXRzCj4gPiA+ICs9PT09
PSA9PT09PT09PT0KPiA+Cj4gPiBJcyBpdCBieSBhbnkgY2hhbmNlIHBvc3NpYmxlIHRvIHB1dCB0
aGVzZSB0d28gdGFibGVzIG9uIHRoZSBzYW1lIHJvdz8KPiA+IE5vdCBzdXJlIGlmIHJzdCBpcyB1
cCB0byB0aGF0IGNoYWxsZW5nZSwgYW5kIGlmIG5vdCBmZWVsIGZyZWUgdG8gaWdub3JlLgo+Cj4g
SSB3b3VsZCBsb3ZlIHRvIG1ha2UgdGhhdCBoYXBwZW4uIE15IHJzdCBza2lsbHMgYXJlIGRldmVs
b3BpbmcgYW5kIEkKPiB3aWxsIHNlZSB3aGF0IEkgY2FuIGRvIQoKRllJOiBJbiB0aGUgdXBjb21p
bmcgdmVyc2lvbiBvZiB0aGlzIHBhdGNoLCB5b3Ugd2lsbCBzZWUgdGhhdCBJIGRpZApub3QgZG8g
dGhlIHNpZGUtYnktc2lkZSB0YWJsZS4gSSB3YW50IHlvdSB0byBrbm93IHRoYXQgSSB0cmllZCB2
ZXJ5CmhhcmQgYW5kIHVsdGltYXRlbHkgZ290IGl0IHRvIHdvcmsuIEhvd2V2ZXIsIGl0IGxvb2tl
ZCB0ZXJyaWJsZSBhbmQKdGhlIHJlc3VsdCB3YXMgY29uZnVzaW5nIChJIHRob3VnaHQpLiBJZiB5
b3Ugd291bGQgc3Ryb25nbHkgcHJlZmVyIGEKc2lkZS1ieS1zaWRlIChpc2gpIHRhYmxlLCBwbGVh
c2UgbGV0IG1lIGtub3cgYW5kIEkgd2lsbCBzZW5kIGEgcGF0Y2gKdG8gc2hvdyB3aGF0IGl0IGxv
b2tlZCBsaWtlLgoKSSBqdXN0IHdhbnRlZCB0byBub3RlIHRoYXQgSSAqdHJpZWQqIHRvIGluY29y
cG9yYXRlIHlvdXIgc3VnZ2VzdGlvbiwKYnV0IGNvdWxkIG5vdCB1bHRpbWF0ZWx5IGJlbmQgUlNU
IHRvIG15IHdpbGwgKHllcywgcHVuIGludGVuZGVkKSEKCldpbGwKCj4KPiA+Cj4gPiA+ICsKPiA+
ID4gK0ZvciBleGFtcGxlLCBgdTMyYCBpcyBhIHR5cGUgd2hvc2UgdmFsaWQgdmFsdWVzIGFyZSBh
bGwgdGhlIDMyLWJpdCB1bnNpZ25lZAo+ID4gPiArbnVtYmVycyBhbmQgYHMxNmAgaXMgYSB0eXBl
cyB3aG9zZSB2YWxpZCB2YWx1ZXMgYXJlIGFsbCB0aGUgMTYtYml0IHNpZ25lZAo+ID4gPiArbnVt
YmVycy4KPiA+ID4gKwo+ID4gPiArRnVuY3Rpb25zCj4gPiA+ICstLS0tLS0tLS0KPiA+ID4gKyog
YGh0b2JlMTZgOiBUYWtlcyBhbiB1bnNpZ25lZCAxNi1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFu
IGZvcm1hdCBhbmQKPiA+ID4gKyAgcmV0dXJucyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4g
dW5zaWduZWQgMTYtYml0IG51bWJlciBpbiBiaWctZW5kaWFuCj4gPiA+ICsgIGZvcm1hdC4KPiA+
ID4gKyogYGh0b2JlMzJgOiBUYWtlcyBhbiB1bnNpZ25lZCAzMi1iaXQgbnVtYmVyIGluIGhvc3Qt
ZW5kaWFuIGZvcm1hdCBhbmQKPiA+ID4gKyAgcmV0dXJucyB0aGUgZXF1aXZhbGVudCBudW1iZXIg
YXMgYW4gdW5zaWduZWQgMzItYml0IG51bWJlciBpbiBiaWctZW5kaWFuCj4gPiA+ICsgIGZvcm1h
dC4KPiA+ID4gKyogYGh0b2JlNjRgOiBUYWtlcyBhbiB1bnNpZ25lZCA2NC1iaXQgbnVtYmVyIGlu
IGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+ID4gKyAgcmV0dXJucyB0aGUgZXF1aXZhbGVudCBu
dW1iZXIgYXMgYW4gdW5zaWduZWQgNjQtYml0IG51bWJlciBpbiBiaWctZW5kaWFuCj4gPiA+ICsg
IGZvcm1hdC4KPiA+ID4gKyogYGh0b2xlMTZgOiBUYWtlcyBhbiB1bnNpZ25lZCAxNi1iaXQgbnVt
YmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+ID4gKyAgcmV0dXJucyB0aGUgZXF1aXZh
bGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgMTYtYml0IG51bWJlciBpbiBsaXR0bGUtZW5kaWFu
Cj4gPiA+ICsgIGZvcm1hdC4KPiA+ID4gKyogYGh0b2xlMzJgOiBUYWtlcyBhbiB1bnNpZ25lZCAz
Mi1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+ID4gKyAgcmV0dXJucyB0
aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgMzItYml0IG51bWJlciBpbiBsaXR0
bGUtZW5kaWFuCj4gPiA+ICsgIGZvcm1hdC4KPiA+ID4gKyogYGh0b2xlNjRgOiBUYWtlcyBhbiB1
bnNpZ25lZCA2NC1iaXQgbnVtYmVyIGluIGhvc3QtZW5kaWFuIGZvcm1hdCBhbmQKPiA+ID4gKyAg
cmV0dXJucyB0aGUgZXF1aXZhbGVudCBudW1iZXIgYXMgYW4gdW5zaWduZWQgNjQtYml0IG51bWJl
ciBpbiBsaXR0bGUtZW5kaWFuCj4gPiA+ICsgIGZvcm1hdC4KPiA+ID4gKyogYGJzd2FwMTZgOiBU
YWtlcyBhbiB1bnNpZ25lZCAxNi1iaXQgbnVtYmVyIGluIGVpdGhlciBiaWctIG9yIGxpdHRsZS1l
bmRpYW4KPiA+ID4gKyAgZm9ybWF0IGFuZCByZXR1cm5zIHRoZSBlcXVpdmFsZW50IG51bWJlciB3
aXRoIHRoZSBzYW1lIGJpdCB3aWR0aCBidXQKPiA+ID4gKyAgb3Bwb3NpdGUgZW5kaWFubmVzcy4K
PiA+ID4gKyogYGJzd2FwMzJgOiBUYWtlcyBhbiB1bnNpZ25lZCAzMi1iaXQgbnVtYmVyIGluIGVp
dGhlciBiaWctIG9yIGxpdHRsZS1lbmRpYW4KPiA+ID4gKyAgZm9ybWF0IGFuZCByZXR1cm5zIHRo
ZSBlcXVpdmFsZW50IG51bWJlciB3aXRoIHRoZSBzYW1lIGJpdCB3aWR0aCBidXQKPiA+ID4gKyAg
b3Bwb3NpdGUgZW5kaWFubmVzcy4KPiA+ID4gKyogYGJzd2FwNjRgOiBUYWtlcyBhbiB1bnNpZ25l
ZCA2NC1iaXQgbnVtYmVyIGluIGVpdGhlciBiaWctIG9yIGxpdHRsZS1lbmRpYW4KPiA+ID4gKyAg
Zm9ybWF0IGFuZCByZXR1cm5zIHRoZSBlcXVpdmFsZW50IG51bWJlciB3aXRoIHRoZSBzYW1lIGJp
dCB3aWR0aCBidXQKPiA+ID4gKyAgb3Bwb3NpdGUgZW5kaWFubmVzcy4KPiA+Cj4gPiBVcG9uIGZ1
cnRoZXIgcmVmbGVjdGlvbiwgbWF5YmUgdGhpcyBiZWxvbmdzIGluIHRoZSBCeXRlIHN3YXAKPiA+
IGluc3RydWN0aW9ucyBzZWN0aW9uIG9mIHRoZSBkb2N1bWVudD8gVGhlIHR5cGVzIG1ha2Ugc2Vu
c2UgdG8gbGlzdCBhYm92ZQo+ID4gYmVjYXVzZSB0aGV5J3JlIHViaXF1aXRvdXMgdGhyb3VnaG91
dCB0aGUgZG9jLCBidXQgdGhlc2UgYXJlIHJlYWxseSAxMDAlCj4gPiBzcGVjaWZpYyB0byBieXRl
IHN3YXAuCj4KPiBJIGFtIG5vdCBvcHBvc2VkIHRvIHRoYXQuIFRoZSBvbmx5IHJlYXNvbiB0aGF0
IEkgcHV0IHRoZW0gaGVyZSB3YXMgdG8KPiBtYWtlIGl0IGZ1bGx5IGNlbnRyYWxpemVkLiBUaGV5
IGFyZSBhbHNvIGdvaW5nIHRvIGJlIHVzZWQgaW4gdGhlCj4gQXBwZW5kaXggYW5kIEkgd2FzIGhv
cGluZyBub3QgdG8gaGF2ZSB0byByZXByb2R1Y2UgdGhlbSB0aGVyZS4gSW4gdjQKPiBvZiB0aGUg
cGF0Y2ggSSB3aWxsIGxlYXZlIHRoZW0gaGVyZSBhbmQgdGhlbiBpZiB3ZSBkbyBmZWVsIGxpa2Ug
d2UKPiBzaG91bGQgbW92ZSB0aGVtIEkgd2lsbCBoYXBwaWx5IG1ha2UgYSB2NSEKPgo+IFRoYW5r
IHlvdSBhZ2FpbiBmb3IgdGhlIGZlZWRiYWNrISBBIG5ldyByZXZpc2lvbiBvZiB0aGUgcGF0Y2gg
d2lsbCBiZQo+IG91dCBzaG9ydGx5IQo+Cj4gSGF2ZSBhIGdyZWF0IHJlc3Qgb2YgdGhlIHdlZWtl
bmQhCj4gV2lsbAo+Cj4gPgo+ID4gPgo+ID4gPiAgUmVnaXN0ZXJzIGFuZCBjYWxsaW5nIGNvbnZl
bnRpb24KPiA+ID4gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiA+IEBAIC0y
NTIsMTkgKzMxMSwyMyBAQCBhcmUgc3VwcG9ydGVkOiAxNiwgMzIgYW5kIDY0Lgo+ID4gPgo+ID4g
PiAgRXhhbXBsZXM6Cj4gPiA+Cj4gPiA+IC1gYEJQRl9BTFUgfCBCUEZfVE9fTEUgfCBCUEZfRU5E
YGAgd2l0aCBpbW0gPSAxNiBtZWFuczo6Cj4gPiA+ICtgYEJQRl9BTFUgfCBCUEZfVE9fTEUgfCBC
UEZfRU5EYGAgd2l0aCBpbW0gPSAxNi8zMi82NCBtZWFuczo6Cj4gPiA+Cj4gPiA+ICAgIGRzdCA9
IGh0b2xlMTYoZHN0KQo+ID4gPiArICBkc3QgPSBodG9sZTMyKGRzdCkKPiA+ID4gKyAgZHN0ID0g
aHRvbGU2NChkc3QpCj4gPiA+Cj4gPiA+IC1gYEJQRl9BTFUgfCBCUEZfVE9fQkUgfCBCUEZfRU5E
YGAgd2l0aCBpbW0gPSA2NCBtZWFuczo6Cj4gPiA+ICtgYEJQRl9BTFUgfCBCUEZfVE9fQkUgfCBC
UEZfRU5EYGAgd2l0aCBpbW0gPSAxNi8zMi82NCBtZWFuczo6Cj4gPiA+Cj4gPiA+ICsgIGRzdCA9
IGh0b2JlMTYoZHN0KQo+ID4gPiArICBkc3QgPSBodG9iZTMyKGRzdCkKPiA+ID4gICAgZHN0ID0g
aHRvYmU2NChkc3QpCj4gPiA+Cj4gPiA+ICBgYEJQRl9BTFU2NCB8IEJQRl9UT19MRSB8IEJQRl9F
TkRgYCB3aXRoIGltbSA9IDE2LzMyLzY0IG1lYW5zOjoKPiA+ID4KPiA+ID4gLSAgZHN0ID0gYnN3
YXAxNiBkc3QKPiA+ID4gLSAgZHN0ID0gYnN3YXAzMiBkc3QKPiA+ID4gLSAgZHN0ID0gYnN3YXA2
NCBkc3QKPiA+ID4gKyAgZHN0ID0gYnN3YXAxNihkc3QpCj4gPiA+ICsgIGRzdCA9IGJzd2FwMzIo
ZHN0KQo+ID4gPiArICBkc3QgPSBic3dhcDY0KGRzdCkKPiA+ID4KPiA+Cj4gPiBbLi4uXQo+ID4K
PiA+IC0gRGF2aWQKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3
dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

