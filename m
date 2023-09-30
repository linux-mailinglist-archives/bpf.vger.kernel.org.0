Return-Path: <bpf+bounces-11149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A1B7B3D59
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 02:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9642E1C20985
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 00:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438311115;
	Sat, 30 Sep 2023 00:47:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F9ECC
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 00:47:02 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD4E94
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 17:47:00 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7D0BBC16950D
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696034820; bh=VQfJB6OpNbpP8kSX3ovnsna3icwpeJmPCXZwHGsArgM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=e+IR0y2bHvHJxJ4vMkN8/hF+/vjvCDaxU11F0LPtVYZCMAFuV54YwrvDgeAc9YBXt
	 YRI52LZYoW7aWwLLdqcft1Zxuoy31+lDSgyEYskVpweBIKp29q3Ej5mLK/+xc9nW5F
	 +iB5Pt+7SGO0jhArZZhlDfVuxtZaAY9rK75yrZsY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Sep 29 17:47:00 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 54A16C135DE2;
	Fri, 29 Sep 2023 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696034820; bh=VQfJB6OpNbpP8kSX3ovnsna3icwpeJmPCXZwHGsArgM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=e+IR0y2bHvHJxJ4vMkN8/hF+/vjvCDaxU11F0LPtVYZCMAFuV54YwrvDgeAc9YBXt
	 YRI52LZYoW7aWwLLdqcft1Zxuoy31+lDSgyEYskVpweBIKp29q3Ej5mLK/+xc9nW5F
	 +iB5Pt+7SGO0jhArZZhlDfVuxtZaAY9rK75yrZsY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AC736C135DE2
 for <bpf@ietfa.amsl.com>; Fri, 29 Sep 2023 17:46:58 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.108
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z8AWLmKS8XxO for <bpf@ietfa.amsl.com>;
 Fri, 29 Sep 2023 17:46:56 -0700 (PDT)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 918BBC136147
 for <bpf@ietf.org>; Fri, 29 Sep 2023 17:46:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3231df68584so10514864f8f.1
 for <bpf@ietf.org>; Fri, 29 Sep 2023 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696034815; x=1696639615; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTdhIwSsz/a8w2ifkRuW3ixhiP6zM2k4XZTaLkMo6mw=;
 b=cUINn74vpXsIX+d/yifw1xxh1kp+5qxaIp1quh17/cyCQOthaNDphxZ/J0wdBX4LkV
 Sp6lJj1afe7fx/F7U5c7VKOhbp/nxNfUiYRFxwYcFuty/7FoYPNmu/xpJnujQTSEQbYO
 FRABOUtGoKC49evq4pxZdaKiZKSw/CbAT2og77ItNki3xiWKdnMl0U6JSxUZRVR8+3+n
 dDeOBvY1L1Z45TWnFcXjDFpT6uQtAe0iB/Q2hSsd7N2+TcZtigmrSaZvWkfOyS8pgds9
 oZ1cxPDEP9NVUrsOI/Qf/FMJvax+w9GZ39UE6wUlmwsqvid+aNz34HWBhG5gBuhPOP6z
 mAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696034815; x=1696639615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTdhIwSsz/a8w2ifkRuW3ixhiP6zM2k4XZTaLkMo6mw=;
 b=QfgGPnALEmwoeeBdsTmX05bgDRzJWEoOAlHQKnf3s9cowLadcAd7YfnYyD7p0p2nrx
 CxMeYxKA+A5Ek/1YlAThoP41LTQ6lm/9L+daeNZ65+YAm0IV4rBq7BKsZZgAICGGMJJG
 HKDP6M0oau/jktt2daz9kGuwxURXjBkqf7VClungx4lNb6H00INuif3vWhzy7BYTqvVL
 xlcZcSlu2jJW/eXOm5fs0LBAbXFba0tj+J2JAUfvJWPlwnMyWO4sVh79QH0rk9dluRi6
 bTjzgpjVNIzOHwswBRaNaiq2NXTCYbY4tyGvcWkMosvbrScxcbWJqGyMDPF+VCndanvi
 dSxA==
X-Gm-Message-State: AOJu0YwvP2hRCWxjqhQC/+lm3eREiL5+n0SBiuMsVh0bjUNbAXcDvoR/
 rz43dAN6qGeJxVla27d1iXdjPdkK9bpvDKCckHE=
X-Google-Smtp-Source: AGHT+IHvytC5vmWOY9Caqd219ycSRnCXAH0fSJkUbFvlrLu/mYdI7/4eePDur0SYwVrOT4FNSJMZ8go7XbDd7J7PSyo=
X-Received: by 2002:a5d:6950:0:b0:319:7656:3863 with SMTP id
 r16-20020a5d6950000000b0031976563863mr4457344wrw.47.1696034814654; Fri, 29
 Sep 2023 17:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB3878516D62B3AFA921A999F1A3C1A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <eb00a1e51d720a519d8ed1537e99e6c7996b6766.camel@gmail.com>
In-Reply-To: <eb00a1e51d720a519d8ed1537e99e6c7996b6766.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Sep 2023 17:46:43 -0700
Message-ID: <CAADnVQJam8GS1Q5yDjXroUV3k=4Btm_Guso1WxUFyhwETvgwFQ@mail.gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>,
 Yonghong Song <yonghong.song@linux.dev>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/R8u0dh4fby8_SciG9bZmUjkhxvA>
Subject: Re: [Bpf] BPF_ALU | BPF_MOVSX with offset = 32?
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

T24gRnJpLCBTZXAgMjksIDIwMjMgYXQgNTo1NOKAr0FNIEVkdWFyZCBaaW5nZXJtYW4gPGVkZHl6
ODdAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgMjAyMy0wOS0yOCBhdCAyMTozNSArMDAw
MCwgRGF2ZSBUaGFsZXIgd3JvdGU6Cj4gPiBJbiByZS1yZWFkaW5nIHRoZSBpbnN0cnVjdGlvbi1z
ZXQucnN0IGNoYW5nZXMgZm9yIHNpZ24gZXh0ZW5zaW9ucywgdGhlcmUgaXMgb25lIGFtYmlndWl0
eQo+ID4gcmVnYXJkaW5nIEJQRl9BTFUgfCBCUEZfTU9WU1ggd2l0aCBvZmZzZXQgPSAzMi4KPiA+
Cj4gPiBJcyBpdDoKPiA+IGEpIFVuZGVmaW5lZCAobm90IGEgcGVybWl0dGVkIGluc3RydWN0aW9u
KSwgb3IKPiA+IGIpIERlZmluZWQgYXMgYmVpbmcgc3lub255bW91cyB3aXRoIEJQRl9BTFUgfCBC
UEZfTU9WPwo+ID4KPiA+IFRoZSB0YWJsZSBpbXBsaWVzIChiKSB3aGVuIGl0IHNheXM6Cj4gPiA+
IEJQRl9NT1ZTWCAgMHhiMCAgIDgvMTYvMzIgIGRzdCA9IChzOCxzMTYsczMyKXNyYwo+ID4KPiA+
IEJ1dCB0aGUgZm9sbG93aW5nIHRleHQgY291bGQgYmUgaW50ZXJwcmV0ZWQgYXMgKCk6Cj4gPiA+
IGBgQlBGX0FMVSB8IEJQRl9NT1ZTWGBgIDp0ZXJtOmBzaWduIGV4dGVuZHM8U2lnbiBFeHRlbmQ+
YCA4LWJpdCBhbmQgMTYtYml0IG9wZXJhbmRzIGludG8gMzIKPiA+ID4gYml0IG9wZXJhbmRzLCBh
bmQgemVyb2VzIHRoZSByZW1haW5pbmcgdXBwZXIgMzIgYml0cy4KPgo+IEhpIERhdmUsCj4KPiBJ
IGNoZWNrZWQgY3VycmVudCB2ZXJpZmllciBpbXBsZW1lbnRhdGlvbiBhbmQgaXQgZ29lcyB3aXRo
IG9wdGlvbiAoYSk6Cgp0aGF0J3MgY29ycmVjdC4KSSB0aGluayB0aGF0IHNlbnRlbmNlIGlzIGNs
ZWFyIGVub3VnaDoKQlBGX0FMVSB8IEJQRl9NT1ZTWGBgIDp0ZXJtOmBzaWduIGV4dGVuZHM8U2ln
biBFeHRlbmQ+YCA4LWJpdCBhbmQKMTYtYml0IG9wZXJhbmRzIGludG8gMzIuCldoaWNoIG1lYW5z
IHRoYXQgMjQtYml0LCAzMi1iaXQgb3Igb3RoZXIgYml0IHdpZHRoIGlzIG5vdCBwZXJtaXR0ZWQu
CkkgZnJhbmtseSBkb24ndCBzZWUgYW55IGFtYmlndWl0eS4KCi0tIApCcGYgbWFpbGluZyBsaXN0
CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

