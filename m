Return-Path: <bpf+bounces-4368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D7774A83B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497811C20ED8
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939F71112;
	Fri,  7 Jul 2023 00:48:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE977F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 00:48:55 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF51E1BDB
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:48:53 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BEE63C13738C
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688690933; bh=3KHzaQH7hsFXwzQmd6dxQAdPty7Ii9NdB9dYrEpPXY8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=QpLLuTgLuqGT+WO8gqmzsV1DcqsiIFeSPWJKzK1Nslap2FLNeqjiURp+CAErLVvBg
	 oY8h/S0mwEVSam7JdkGBP8inkQo4zFGdUQaQWmkaoC94Rf5YVvsvFVDyU6Ba+EAj1Q
	 JagtqhCdeONnGvFparj1MDIZBjh7aUFihy92DPD4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul  6 17:48:53 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 84EADC15199F;
	Thu,  6 Jul 2023 17:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688690933; bh=3KHzaQH7hsFXwzQmd6dxQAdPty7Ii9NdB9dYrEpPXY8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=QpLLuTgLuqGT+WO8gqmzsV1DcqsiIFeSPWJKzK1Nslap2FLNeqjiURp+CAErLVvBg
	 oY8h/S0mwEVSam7JdkGBP8inkQo4zFGdUQaQWmkaoC94Rf5YVvsvFVDyU6Ba+EAj1Q
	 JagtqhCdeONnGvFparj1MDIZBjh7aUFihy92DPD4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 38DA8C15199F
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 17:48:53 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.098
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0qwddPI9TnVI for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 17:48:51 -0700 (PDT)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1B646C151081
 for <bpf@ietf.org>; Thu,  6 Jul 2023 17:48:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b6b98ac328so19763271fa.0
 for <bpf@ietf.org>; Thu, 06 Jul 2023 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688690929; x=1691282929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55CZ8jW030gmBYq7IB4tSq/GczPU4PIduyi/2awZWcU=;
 b=T1xhbehZIrNTiWCUywcSBeW6j5JSfWTqadjZycH0fER0n4egwXUAzu7APBxH6vm8Mr
 ZgK1ag5LMezA1/vosDm0vWRCfSUazI0yACEuctV8+SISk1sk7whhaC4JRFN9MsHoupFc
 mP9AVkk/KLTRyfMNk6AqJt/G4zi+/X9m8DcVBYHRkpsvWvInGxPET5MlKojT/0oDliMl
 rZktgzrvtfd4xfwYaiMKogLPBwyJ7bBbBhpq1kPtIzT+oXhZChhtB6J1xNfqCyPikUQp
 hqpMArD0F3lRvGnIl1vyRr46BtWVQmtfArpmn5O7So/P/DVJPOz1L7E3aLwjaTuWRXT+
 x1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688690929; x=1691282929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55CZ8jW030gmBYq7IB4tSq/GczPU4PIduyi/2awZWcU=;
 b=jmIQd3TyK98xhT7OLzKaWcYI1hHkdXwXEaDfH4bp/GV8J+PaPM3FT6I912cwDPGVfR
 viONlRcEUQIvbhCV744b1viN79Kj/wGdlbzPeW7DGTarXYFZApzU1VhnZPRJBN/1nlHV
 lov1Cb2RaldsMyaG/8c8B0x6BJLRTZQN88Dk1OepuKCZ1Kp7GE+LymHE4Y/p7Xcb9PVC
 9Pw4IzZWPYKvWT+dPKQI60Mm6Co8B6ROcZ8VAxeIq8ahlacj0atccId6z7wroArTy4IQ
 VYsGnWBKoxAYopun7GWKzLe9gUBQRQU26PG1nzfOw1gG5YTvPpF3cTPqYRGTWNe+/8vn
 X8Cg==
X-Gm-Message-State: ABy/qLZocJ4EQRynnQ/0zWDnzB4Ls7NPgejoj6Nl3tjvh9psefXX3KSd
 E6ioFxMNApR+Kk7L5ICvPsYsmkAWA+PYeZzPI+KNkOjruQ0=
X-Google-Smtp-Source: APBJJlHGCEIjLuv9IRLGaUzuTY751nDylBVUY/SL7sxknpBJAIzYNbdW+kaNL9IousIKMc4LiczcyqBeZxRZE5jmTQ0=
X-Received: by 2002:a2e:8612:0:b0:2b6:a6a6:4a16 with SMTP id
 a18-20020a2e8612000000b002b6a6a64a16mr2430813lji.3.1688690929046; Thu, 06 Jul
 2023 17:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706222020.268136-1-hawkinsw@obs.cr>
 <20230706222020.268136-2-hawkinsw@obs.cr>
 <CAADnVQ+kfTPYE1kbUuxsaoEZBCHKG2SLDkcs62RXqEo8Jhi9+Q@mail.gmail.com>
 <CADx9qWjPir2wsRUNJopeT=daQz7rz=hhTJCM=FwCcLo96vY84A@mail.gmail.com>
In-Reply-To: <CADx9qWjPir2wsRUNJopeT=daQz7rz=hhTJCM=FwCcLo96vY84A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 17:48:37 -0700
Message-ID: <CAADnVQKdV2A+-+PWpgt7_tUF-0uj-6MSsTSAppQDH=7VeXKFrA@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/c3Auwtxh2KCyFGdVM9m8wcX6C7A>
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCA1OjQ24oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0Bv
YnMuY3I+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdWwgNiwgMjAyMyBhdCA3OjMy4oCvUE0gQWxleGVp
IFN0YXJvdm9pdG92Cj4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4K
PiA+IE9uIFRodSwgSnVsIDYsIDIwMjMgYXQgMzoyMOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2lu
c3dAb2JzLmNyPiB3cm90ZToKPiA+ID4KPiA+ID4gVGhlIGV4ZWN1dGlvbiBvZiBldmVyeSBmdW5j
dGlvbiBwcm9jZWVkcyBhcyBpZiBpdCBoYXMgYWNjZXNzIHRvIGl0cyBvd24KPiA+ID4gc3RhY2sg
c3BhY2UuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPgo+ID4gPiAtLS0KPiA+ID4gIERvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNl
dC5yc3QgfCA1ICsrKysrCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4g
PiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQu
cnN0IGIvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gPiBpbmRleCA3
NTFlNjU3OTczZjAuLjcxNzI1OTc2N2E0MSAxMDA2NDQKPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdAo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9p
bnN0cnVjdGlvbi1zZXQucnN0Cj4gPiA+IEBAIC0zMCw2ICszMCwxMSBAQCBUaGUgZUJQRiBjYWxs
aW5nIGNvbnZlbnRpb24gaXMgZGVmaW5lZCBhczoKPiA+ID4gIFIwIC0gUjUgYXJlIHNjcmF0Y2gg
cmVnaXN0ZXJzIGFuZCBlQlBGIHByb2dyYW1zIG5lZWRzIHRvIHNwaWxsL2ZpbGwgdGhlbSBpZgo+
ID4gPiAgbmVjZXNzYXJ5IGFjcm9zcyBjYWxscy4KPiA+ID4KPiA+ID4gK0V2ZXJ5IGZ1bmN0aW9u
IGludm9jYXRpb24gcHJvY2VlZHMgYXMgaWYgaXQgaGFzIGV4Y2x1c2l2ZSBhY2Nlc3MgdG8gYW4K
PiA+ID4gK2ltcGxlbWVudGF0aW9uLWRlZmluZWQgYW1vdW50IG9mIHN0YWNrIHNwYWNlLiBSMTAg
aXMgYSBwb2ludGVyIHRvIHRoZSBieXRlIG9mCj4gPiA+ICttZW1vcnkgd2l0aCB0aGUgaGlnaGVz
dCBhZGRyZXNzIGluIHRoYXQgc3RhY2sgc3BhY2UuIFRoZSBjb250ZW50cwo+ID4gPiArb2YgYSBm
dW5jdGlvbiBpbnZvY2F0aW9uJ3Mgc3RhY2sgc3BhY2UgZG8gbm90IHBlcnNpc3QgYmV0d2VlbiBp
bnZvY2F0aW9ucy4KPiA+Cj4gPiBTdWNoIGRlc2NyaXB0aW9uIGJlbG9uZ3MgaW4gYSBmdXR1cmUg
cHNBQkkgZG9jLgo+ID4gaW5zdHJ1Y3Rpb24tc2V0LnJzdCBpcyBub3QgYSBwbGFjZSB0byBkZXNj
cmliZSBob3cgcmVnaXN0ZXJzIGFyZSB1c2VkLgo+Cj4gVGhhbmsgeW91IGZvciB0aGUgZmVlZGJh
Y2shCj4KPiBIb3cgZG9lcyB5b3VyIGNvbW1lbnQgc3F1YXJlIHdpdGggdGhlIGltbWVkaWF0ZWx5
IHByZWNlZGluZwo+IGRlc2NyaXB0aW9uIGluIHRoZSBkb2N1bWVudCB0aGF0IHNheXM6Cj4KPiBS
MTA6IHJlYWQtb25seSBmcmFtZSBwb2ludGVyIHRvIGFjY2VzcyBzdGFjawo+Cj4gKGFtb25nIHRo
ZSBkZXNjcmlwdGlvbiBvZiBob3cgb3RoZXIgcmVnaXN0ZXJzIGFyZSB1c2VkIGR1cmluZyBmdW5j
dGlvbiBjYWxscykuCgpTZWUKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmL0NBQURuVlErZ0xu
c09WajlzNHpwQVA2K1U2bkZIWW02R1ZaMUZ0ZVJhYz1aYUp2cGZEZ0BtYWlsLmdtYWlsLmNvbS8K
CnRsZHI6IGl0J3MgYSBtZXNzLgpXZSBzaG91bGQgcmVtb3ZlICdSZWdpc3RlcnMgYW5kIGNhbGxp
bmcgY29udmVudGlvbicgc2VjdGlvbiBmcm9tCmluc3RydWN0aW9uLXNldC5yc3QKCi0tIApCcGYg
bWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2JwZgo=

