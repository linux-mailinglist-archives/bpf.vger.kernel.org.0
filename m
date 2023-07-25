Return-Path: <bpf+bounces-5840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470AF761E3A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 18:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1ECB28109A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B52417B;
	Tue, 25 Jul 2023 16:16:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411221D5D
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 16:16:22 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BD213B
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:16:04 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EC303C15C524
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690301737; bh=Lu/DvHwrXqzKtt97kolflQ+ybTsH3gLM8Kk+s58HWgU=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=DvkMQTPtVb8tzO3yHCjm1D2rbE/SBIGwm7bntQIe38/AWWNXkD53xLtc5gEQLO4sg
	 AqL4n7j6rRiA799ALKQg+ZvQHeUOVAGz69eibJuUZecRTn6PMbXXhFR8G+TVlbx4M7
	 lc0nvenLZBEOUhb4h2TPiAwEny/+k3yceCg2kuEU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jul 25 09:15:37 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BE6EBC151AE5;
	Tue, 25 Jul 2023 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690301737; bh=Lu/DvHwrXqzKtt97kolflQ+ybTsH3gLM8Kk+s58HWgU=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=DvkMQTPtVb8tzO3yHCjm1D2rbE/SBIGwm7bntQIe38/AWWNXkD53xLtc5gEQLO4sg
	 AqL4n7j6rRiA799ALKQg+ZvQHeUOVAGz69eibJuUZecRTn6PMbXXhFR8G+TVlbx4M7
	 lc0nvenLZBEOUhb4h2TPiAwEny/+k3yceCg2kuEU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D7EDEC1526F4
 for <bpf@ietfa.amsl.com>; Tue, 25 Jul 2023 09:15:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.098
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Ls55E_l0mXg for <bpf@ietfa.amsl.com>;
 Tue, 25 Jul 2023 09:15:36 -0700 (PDT)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8461AC151AE5
 for <bpf@ietf.org>; Tue, 25 Jul 2023 09:15:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b7441bfa9eso245761fa.0
 for <bpf@ietf.org>; Tue, 25 Jul 2023 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690301734; x=1690906534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=952/tqDCHq+lq2SmoX7TIsxaFEfjApJfJTF5tci0Ky8=;
 b=qVy+2guYcjVPiCqP994Q8btqOeLyhCg/KzahnroWYY4Dnk7DZZ8Akzoi57LGvVfwqL
 Ee+Pzad+6cd1o/G9UZDuMh/+mWgTXyKtZoY46YEDtfXQ2lRCkigS0lNSUxN5Weyn3yyi
 z90I0FTcpSkie6YaZv+qadKufbBhGAaoC7OM8dYyqhfoERpc/tQh3RtBdUjpoqjwD0Mb
 I8rg83jyZSd+Ao5yJ1An+4egEamz7qR5O5o6sZdOSlLBc7m9hyN1Kxcdqiom92xSwzUo
 Sq9WONyND2lJznUinhp4YzGaTCyxCbjuCSCl441qJ0EkG03tnTj3Y2dzyRDQ+1kjAQzJ
 yWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690301734; x=1690906534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=952/tqDCHq+lq2SmoX7TIsxaFEfjApJfJTF5tci0Ky8=;
 b=dwjtHnZK2p/KVUb0Jshta+QFr98ll/CSa/wzxfFkiM4w7eZMcN3uq/kghLchkKV48O
 KXZ/fkIkzWbSIhYkQLvipFQWun2S4+NOtRwX0/gHbW+3C82MGYpCFykZ2ZuPJZb2AzwU
 KlpU3MEVp1WnIbQadN3IJxgWYTCwXw8lokhJH5hd6u7zJj/uiIxp4X6nyMLQJJpFtYQZ
 RY/ECqeFMR8l4hPWp5GtRYEnzC/vWr/OMgqC5XuoTjpNnPsNXMz94xSF+xpAQhoc7oSb
 OLp2EShD2oDKmlPznNbEgC68O7YiAmXmqF0zP0KxGJSWNUug2ZbZoDc9noO29wXO0BvB
 DFpQ==
X-Gm-Message-State: ABy/qLZ0JnKDePXBOS9sU0I55MmQOmg5HVmsmChOj+8jCFi7hxurTY84
 SMZfoMkuc+Ox1xK29cXm+x5o/guUWrqcztpq3XU=
X-Google-Smtp-Source: APBJJlFwFr/5oSBdAWwa25/cm0LEOFI3VjAVGGF0SGRkvWLTgm5/KfKD4tODLO6AZwFEyNS/FNyC+v2emfsHEmRoGCE=
X-Received: by 2002:a05:651c:48c:b0:2b7:34c4:f98f with SMTP id
 s12-20020a05651c048c00b002b734c4f98fmr1055009ljc.11.1690301733790; Tue, 25
 Jul 2023 09:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jul 2023 09:15:22 -0700
Message-ID: <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, "bpf@ietf.org" <bpf@ietf.org>,
 bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/k_bu6vZlbfMAbKyUtCtLIunc9tM>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
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

T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgNzowM+KAr0FNIERhdmUgVGhhbGVyIDxkdGhhbGVyQG1p
Y3Jvc29mdC5jb20+IHdyb3RlOgo+Cj4gSSBhbSBmb3J3YXJkaW5nIHRoZSBlbWFpbCBiZWxvdyAo
YWZ0ZXIgY29udmVydGluZyBIVE1MIHRvIHBsYWluIHRleHQpCj4gdG8gdGhlIG1haWx0bzpicGZA
dmdlci5rZXJuZWwub3JnIGxpc3Qgc28gcmVwbGllcyBjYW4gZ28gdG8gYm90aCBsaXN0cy4KPgo+
IFBsZWFzZSB1c2UgdGhpcyBvbmUgZm9yIGFueSByZXBsaWVzLgo+Cj4gVGhhbmtzLAo+IERhdmUK
Pgo+ID4gRnJvbTogQnBmIDxicGYtYm91bmNlc0BpZXRmLm9yZz4gT24gQmVoYWxmIE9mIFdhdHNv
biBMYWRkCj4gPiBTZW50OiBNb25kYXksIEp1bHkgMjQsIDIwMjMgMTA6MDUgUE0KPiA+IFRvOiBi
cGZAaWV0Zi5vcmcKPiA+IFN1YmplY3Q6IFtCcGZdIFJldmlldyBvZiBkcmFmdC10aGFsZXItYnBm
LWlzYS0wMQo+ID4KPiA+IERlYXIgQlBGIHdnLAo+ID4KPiA+IEkgdG9vayBhIGxvb2sgYXQgdGhl
IGRyYWZ0IGFuZCB0aGluayBpdCBoYXMgc29tZSBpc3N1ZXMsIHVuc3VycHJpc2luZ2x5IGF0IHRo
aXMgc3RhZ2UuIE9uZSBpcwo+ID4gdGhlIHNwZWNpZmljYXRpb24gc2VlbXMgdG8gdXNlIGFuIHVu
ZGVyc3BlY2lmaWVkIEMgcHNldWRvIGNvZGUgZm9yIG9wZXJhdGlvbnMgdnMKPiA+IGRlZmluaW5n
IHRoZW0gbWF0aGVtYXRpY2FsbHkuCgpIaSBXYXRzb24sCgpUaGlzIGlzIG5vdCAidW5kZXJzcGVj
aWZpZWQgQyIgcHNldWRvIGNvZGUuClRoaXMgaXMgYXNzZW1ibHkgc3ludGF4IHBhcnNlZCBhbmQg
ZW1pdHRlZCBieSBHQ0MsIExMVk0sIGdhcywgTGludXggS2VybmVsLCBldGMuCgo+ID4gVGhlIGdv
b2QgbmV3cyBpcyBJIHRoaW5rIHRoaXMgaXMgdmVyeSBmaXhhYmxlIGFsdGhvdWdoIHRlZGlvdXMu
Cj4gPgo+ID4gVGhlIG90aGVyIHRob3JuaWVyIGlzc3VlcyBhcmUgbWVtb3J5IG1vZGVsIGV0Yy4g
QnV0IHRoZSBvdmVyYWxsIHN0cnVjdHVyZSBzZWVtcyBnb29kCj4gPiBhbmQgdGhlIGRvY3VtZW50
IG92ZXJhbGwgbWFrZXMgc2Vuc2UuCgpXaGF0IGRvIHlvdSBtZWFuIGJ5ICJtZW1vcnkgbW9kZWwi
ID8KRG8geW91IHNlZSBhIHJlZmVyZW5jZSB0byBpdCA/IFBsZWFzZSBiZSBzcGVjaWZpYy4KCi0t
IApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2JwZgo=

