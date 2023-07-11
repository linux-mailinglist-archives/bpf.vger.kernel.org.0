Return-Path: <bpf+bounces-4799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0B74F893
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 21:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6E6280D90
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 19:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F511EA7E;
	Tue, 11 Jul 2023 19:57:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A417FE0
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 19:57:03 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A44210F0
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 12:57:02 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 248FFC17D672
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689105422; bh=6UVVyBTx+vLLaCO1jJD+0uzzWjNueJmnE/8Nkua7JeA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ni6IA0pH7Im3vDMXdbTh7IUZmpeUNJg4EI6x9nXvG/pL5ZbS5XM40GGCAOi7I7o08
	 YDnCLl5/M8mcan6YvfzlmUbsT/s7Xz/XViB9ylGkkzLTUE+Ouu+XWdhay9agdSZqq4
	 cGxfgHZSorUtI4isDk8o4amIMJXTjr5VYAoX/bF4=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jul 11 12:57:02 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E834AC151539;
	Tue, 11 Jul 2023 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689105421; bh=6UVVyBTx+vLLaCO1jJD+0uzzWjNueJmnE/8Nkua7JeA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Wux6kRjlShCQbz3wC8vyx+cwNw9/DZpdDS5zn+pfd4aDOFQWlwQVUfUt/xBmNxPZ/
	 Vbkzsq0guxT/Epj1669Xt2NndwWYjfcmnF5YErl3mepI5GPJeZGuGL84nuAP8G2ILe
	 vqWsSIIg37aIOEnBrBvupPUkrB9KzjVUUDzW9Gm4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 337E3C151076
 for <bpf@ietfa.amsl.com>; Tue, 11 Jul 2023 12:57:01 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.098
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsUEROKczstj for <bpf@ietfa.amsl.com>;
 Tue, 11 Jul 2023 12:57:00 -0700 (PDT)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D257CC151539
 for <bpf@ietf.org>; Tue, 11 Jul 2023 12:57:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b71ae5fa2fso46659661fa.0
 for <bpf@ietf.org>; Tue, 11 Jul 2023 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689105419; x=1691697419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dgVVgRCbp3N90EUgvjH0IL9CKe/cQvLsChcZk/ROlM=;
 b=IJwyyEyRgwb+8Rz3FzMBGTY5fgNU8zRNuG32L9INHEhKsxoxu1ZiMaOE/tQAdLe6g7
 KgHv9QQPjzcqn0CZlWQWMX+Vljs9nLe5GUvyTke6PxYcHG8YV34c5J7e2vHh440H6cKf
 mLTggsSFMAS8uSS2x7WYGsQ+3BXSrvSiVQvBnWRH8wsUbG8UnrVk6mcYZmsFvaBPtINB
 cKSQF95bhHgPxks3fG3KKrlJ+/ReedvXdEbDWOkNzmsHSrExrXp1i18wtz+eYqYNF4O4
 Z2uNeJrBQl6Va/2H2RkXQzxcdKTbNPxP+yXzzN+DW/8Xn1xVaywMr74pdCb92YIWYTCF
 c/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689105419; x=1691697419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dgVVgRCbp3N90EUgvjH0IL9CKe/cQvLsChcZk/ROlM=;
 b=UOiFJvCRE6Lfczmzb/ZWWpvoshX5J2TmLsbIUVrzOgKdedOrSCf5Uc+KexP/FlVDMT
 3ylk4eFpIKxUXQc9qHDIdRDQG/V0EdoIh7T7c6B70Z5GqxT3bLOwVOSWM2dTqv8ImYlH
 NvepDoci7OOsLN5cdTTlbcMw/vj2/AIqWyUZ82yjhWLBgLB6Tgpj5+YBUQjh86a3mwSm
 PSmptS0GI7xBBl0sCZi/yefIu3av4qy1ValMq6f9fWZXstU5WAXWQOngPvX4p0dRyv40
 jACzhed21CblbKFHUHdeT3CsOPDGcyKNmZ8nQd0JqmuMporDZ3dSPLrw1MDMq3AK3X5m
 nRQg==
X-Gm-Message-State: ABy/qLZq13xes4hp8vokH7B5xHQYmXIdM6JI6BL4A9Z6Ex5pIFWGgPxP
 ujACGUJ6l9nNgL1hbeQ2Nd0gF2j2TfNjphD1SN8=
X-Google-Smtp-Source: APBJJlEcBX8p0B4sno3gnhYxRNx8D6R+qr843GO9SsEFAo4iMpAe9WHgvCcT9O19mF8VptTM5ADm0KqqjI9p2rSC5LU=
X-Received: by 2002:a2e:888a:0:b0:2b6:9871:21b0 with SMTP id
 k10-20020a2e888a000000b002b6987121b0mr2155685lji.36.1689105418676; Tue, 11
 Jul 2023 12:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710215819.723550-1-hawkinsw@obs.cr>
 <20230710215819.723550-2-hawkinsw@obs.cr>
 <CAADnVQ+F5VT72LzONEo79ksqaRj=c7mJDd_Ebb87767v01Nosw@mail.gmail.com>
 <871qhe7des.fsf@gnu.org>
In-Reply-To: <871qhe7des.fsf@gnu.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 12:56:47 -0700
Message-ID: <CAADnVQ+S6iOQ71dzYz-Fh5kbvyQAF4GgB18F-SW8NGgOaRgWZg@mail.gmail.com>
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Will Hawkins <hawkinsw@obs.cr>, bpf <bpf@vger.kernel.org>, bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/-vylkCzSmTTNgfqwcr-Vc1QAKD0>
Subject: Re: [Bpf] [PATCH 1/1] bpf,
 docs: Specify twos complement as format for signed integers
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

T24gVHVlLCBKdWwgMTEsIDIwMjMgYXQgNzowNOKAr0FNIEpvc2UgRS4gTWFyY2hlc2kgPGplbWFy
Y2hAZ251Lm9yZz4gd3JvdGU6Cj4KPgo+ID4gT24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMjo1OOKA
r1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+Pgo+ID4+IEluIHRo
ZSBkb2N1bWVudGF0aW9uIG9mIHRoZSBlQlBGIElTQSBpdCBpcyB1bnNwZWNpZmllZCBob3cgaW50
ZWdlcnMgYXJlCj4gPj4gcmVwcmVzZW50ZWQuIFNwZWNpZnkgdGhhdCB0d29zIGNvbXBsZW1lbnQg
aXMgdXNlZC4KPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPgo+ID4+IC0tLQo+ID4+ICBEb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQu
cnN0IHwgNSArKysrKwo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gPj4K
PiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rpb24tc2V0LnJzdCBi
L0RvY3VtZW50YXRpb24vYnBmL2luc3RydWN0aW9uLXNldC5yc3QKPiA+PiBpbmRleCA3NTFlNjU3
OTczZjAuLjYzZGZjYmE1ZWI5YSAxMDA2NDQKPiA+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2JwZi9p
bnN0cnVjdGlvbi1zZXQucnN0Cj4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9icGYvaW5zdHJ1Y3Rp
b24tc2V0LnJzdAo+ID4+IEBAIC0xNzMsNiArMTczLDExIEBAIEJQRl9BUlNIICAweGMwICAgc2ln
biBleHRlbmRpbmcgZHN0ID4+PSAoc3JjICYgbWFzaykKPiA+PiAgQlBGX0VORCAgIDB4ZDAgICBi
eXRlIHN3YXAgb3BlcmF0aW9ucyAoc2VlIGBCeXRlIHN3YXAgaW5zdHJ1Y3Rpb25zYF8gYmVsb3cp
Cj4gPj4gID09PT09PT09ICA9PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4+Cj4gPj4gK2VCUEYgc3VwcG9ydHMgMzItIGFu
ZCA2NC1iaXQgc2lnbmVkIGFuZCB1bnNpZ25lZCBpbnRlZ2Vycy4gSXQgZG9lcwo+ID4+ICtub3Qg
c3VwcG9ydCBmbG9hdGluZy1wb2ludCBkYXRhIHR5cGVzLiBBbGwgc2lnbmVkIGludGVnZXJzIGFy
ZSByZXByZXNlbnRlZCBpbgo+ID4+ICt0d29zLWNvbXBsZW1lbnQgZm9ybWF0IHdoZXJlIHRoZSBz
aWduIGJpdCBpcyBzdG9yZWQgaW4gdGhlIG1vc3Qtc2lnbmlmaWNhbnQKPiA+PiArYml0Lgo+ID4K
PiA+IENvdWxkIHlvdSBwb2ludCB0byBhbm90aGVyIElTQSBkb2N1bWVudCAobGlrZSB4ODYsIGFy
bSwgLi4uKSB0aGF0Cj4gPiB0YWxrcyBhYm91dCBzaWduZWQgYW5kIHVuc2lnbmVkIGludGVnZXJz
Pwo+Cj4gQUZBSUsgdGhlIG9ubHkgc2lnbmVkbmVzcyBlbmNvZGluZyBhc3BlY3QgdGhhdCBpcyBh
bHdheXMgZm91bmQgaW4gSVNBCj4gc3BlY2lmaWNhdGlvbnMgYW5kIHNob3VsZCBiZSBzcGVjaWZp
ZWQgaXMgaG93IG51bWVyaWNhbCBpbW1lZGlhdGVzIGFyZQo+IGVuY29kZWQgaW4gc3RvcmVkIGlu
c3RydWN0aW9ucy4KPgo+IEJ1dCB0aGF0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggImRhdGEgdHlw
ZXMiLgoKKzEgOikKCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3
dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

