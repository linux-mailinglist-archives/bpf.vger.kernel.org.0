Return-Path: <bpf+bounces-14282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91D97E1C69
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F7C2813F8
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225D1320B;
	Mon,  6 Nov 2023 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HxNWGrzl";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="vKQVRisD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrc8syb8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C32104
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 08:38:27 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAA3DB
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 00:38:26 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 09B22C1FB893
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 00:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699259906; bh=CdaW4PRkXYzJpJ0DJZ1Vak5j7QHsJbwGAZCQV57Uksc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=HxNWGrzltpq4hOi51Z0gkKG17NAmZ0LzoCvVVY9lr4C2dOsmjKyxMYfSrEMr4DVB8
	 xqUYwBchJ4Z8z0vQg47XQj33SFAIHw4fJ1eWjTfyhEszgEBLSSyltgQ2fNtz3JPxiV
	 /8MUdDUjCaO2/9g5XNRL55/QWOPBrZb2A5vLiveM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Nov  6 00:38:25 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CE127C18770B;
	Mon,  6 Nov 2023 00:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699259905; bh=CdaW4PRkXYzJpJ0DJZ1Vak5j7QHsJbwGAZCQV57Uksc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=vKQVRisDIKGJ3MooWQorYv6mBYJMOufhISbrjQxiB6lFtgvYkmvbwq0tzQNVukY2M
	 NVK0Tbq1bhhPPQg9Ur0NAM1o5jqewLQQUyoLrbP1gAUm/RZcAKECtRosR7+E3DE2EF
	 ZxhEixivvS8EVdyw7oh3Pl/WTCpHjyQ1f1eMru6A=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6C956C18770B
 for <bpf@ietfa.amsl.com>; Mon,  6 Nov 2023 00:38:25 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q2i1Vco5dNDl for <bpf@ietfa.amsl.com>;
 Mon,  6 Nov 2023 00:38:25 -0800 (PST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id F1138C16F401
 for <bpf@ietf.org>; Mon,  6 Nov 2023 00:38:24 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso29555805e9.3
 for <bpf@ietf.org>; Mon, 06 Nov 2023 00:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699259903; x=1699864703; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1obyZVSBDJ9jwrMhcq9z3qKGElXG9y+4Qk9KA/x4aWA=;
 b=Yrc8syb8tzkTaj9sHEvKnZHHmJqy99oNndPX6dJcJ0bewzwxvqzy9FXfkFOXE5XJue
 0yz5xiFx1Bzcon0CJqMwqbVxy188LdHleT+sWUTJ9rZrA45XA3y6QTlY4UhgAK0M6e94
 Xj4UST5u6m/8vkZMzHEz4sG1zn8HRZRpE9jxj3nurdv/w3pY48Z+bHgLlxF977Bng/7K
 z0ubMhhmh3iU986H2P0BuUh71juzuu+l4DqJ5YPR22IEJTRfx0sswb5I+nDuTowyxQ3R
 AKTeQumkWZnT5TSEPZiglmebPKDLyul+TFgwQLf8XwaWH8hqWxgEADw/lddU5hRkXxRa
 B5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699259903; x=1699864703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1obyZVSBDJ9jwrMhcq9z3qKGElXG9y+4Qk9KA/x4aWA=;
 b=uhcFDWw2zF7vorJ3U4ixdA8PnQwJ0BJ/oTSbzf59r89KTBfYczlyW53CtymfkupJUf
 Tgk8OoL9sW/mv/DDxSYaKYXJX6dUtAOBRpglrF4XIGaUxv8ASukfMt0AAMKH+A8HI9Wf
 pfB7JKAAnoL51EMje9ZrhN6JaAJzOUrbJcbOATX9HsgqggKoFc3G9VyhlHYM1av9WZlE
 RH1BlVxDBRHzHoRoQT3cfN/Pkr6zgqPDsDPvAqV1TkMMCFA7uneimhLNcAy6fybCASDP
 9aV0GHP8Q0WgNQdj/P+J+17AIwxF7+6zMWY+lNwblC7nJrv98w1NC8oC1AL/old38Tuf
 NCDg==
X-Gm-Message-State: AOJu0Yzfv3l7fnxj1H+EakMg28pS/S9EinSMa2fMFDsGWYX2+RTDPBf5
 qiySvCwfhic8xWRzibDbmP8s/7q9/tY08XHpNqE=
X-Google-Smtp-Source: AGHT+IEjFD8KY/TOwk7PJSfy8vr5F6hRLiRmnwNyGlJHh7X3p/vU0TsTi6LVojM6dLUpjGSx+gm1MvPZzB3JiEP7RW4=
X-Received: by 2002:a05:600c:539b:b0:408:3cdf:32c with SMTP id
 hg27-20020a05600c539b00b004083cdf032cmr26538523wmb.41.1699259903021; Mon, 06
 Nov 2023 00:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr>
 <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
 <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
In-Reply-To: <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Nov 2023 00:38:11 -0800
Message-ID: <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/-s7I3Bx65zvEpo0GVuDIid_ASsg>
Subject: Re: [Bpf] [PATCH v3] bpf,
 docs: Add additional ABI working draft base text
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

T24gU3VuLCBOb3YgNSwgMjAyMyBhdCA0OjE34oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0Bv
YnMuY3I+IHdyb3RlOgo+Cj4gT24gU3VuLCBOb3YgNSwgMjAyMyBhdCA0OjUx4oCvQU0gQWxleGVp
IFN0YXJvdm9pdG92Cj4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4K
PiA+IE9uIEZyaSwgTm92IDMsIDIwMjMgYXQgMjoyMOKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2lu
c3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gKwo+ID4gPiArVGhlIEFCSSBpcyBzcGVjaWZpZWQgaW4g
dHdvIHBhcnRzOiBhIGdlbmVyaWMgcGFydCBhbmQgYSBwcm9jZXNzb3Itc3BlY2lmaWMgcGFydC4K
PiA+ID4gK0EgcGFpcmluZyBvZiBnZW5lcmljIEFCSSB3aXRoIHRoZSBwcm9jZXNzb3Itc3BlY2lm
aWMgQUJJIGZvciBhIGNlcnRhaW4KPiA+ID4gK2luc3RhbnRpYXRpb24gb2YgYSBCUEYgbWFjaGlu
ZSByZXByZXNlbnRzIGEgY29tcGxldGUgYmluYXJ5IGludGVyZmFjZSBmb3IgQlBGCj4gPiA+ICtw
cm9ncmFtcyBleGVjdXRpbmcgb24gdGhhdCBtYWNoaW5lLgo+ID4gPiArCj4gPiA+ICtUaGlzIGRv
Y3VtZW50IGlzIHRoZSBnZW5lcmljIEFCSSBhbmQgc3BlY2lmaWVzIHRoZSBwYXJhbWV0ZXJzIGFu
ZCBiZWhhdmlvcgo+ID4gPiArY29tbW9uIHRvIGFsbCBpbnN0YW50aWF0aW9ucyBvZiBCUEYgbWFj
aGluZXMuIEluIGFkZGl0aW9uLCBpdCBkZWZpbmVzIHRoZQo+ID4gPiArZGV0YWlscyB0aGF0IG11
c3QgYmUgc3BlY2lmaWVkIGJ5IGVhY2ggcHJvY2Vzc29yLXNwZWNpZmljIEFCSS4KPiA+ID4gKwo+
ID4gPiArVGhlc2UgcHNBQklzIGFyZSB0aGUgc2Vjb25kIHBhcnQgb2YgdGhlIEFCSS4gRWFjaCBp
bnN0YW50aWF0aW9uIG9mIGEgQlBGCj4gPiA+ICttYWNoaW5lIG11c3QgZGVzY3JpYmUgdGhlIG1l
Y2hhbmlzbSB0aHJvdWdoIHdoaWNoIGJpbmFyeSBpbnRlcmZhY2UKPiA+ID4gK2NvbXBhdGliaWxp
dHkgaXMgbWFpbnRhaW5lZCB3aXRoIHJlc3BlY3QgdG8gdGhlIGlzc3VlcyBoaWdobGlnaHRlZCBi
eSB0aGlzCj4gPiA+ICtkb2N1bWVudC4gSG93ZXZlciwgdGhlIGRldGFpbHMgdGhhdCBtdXN0IGJl
IGRlZmluZWQgYnkgYSBwc0FCSSBhcmUgYSBtaW5pbXVtIC0tCj4gPiA+ICthIHBzQUJJIG1heSBz
cGVjaWZ5IGFkZGl0aW9uYWwgcmVxdWlyZW1lbnRzIGZvciBiaW5hcnkgaW50ZXJmYWNlIGNvbXBh
dGliaWxpdHkKPiA+ID4gK29uIGEgcGxhdGZvcm0uCj4gPgo+ID4gSSBkb24ndCB1bmRlcnN0YW5k
IHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gc2F5IGluIHRoZSBhYm92ZS4KPiA+IEluIG15IG1pbmQg
dGhlcmUgaXMgb25seSBvbmUgQlBGIHBzQUJJIGFuZCBpdCBkb2Vzbid0IGhhdmUKPiA+IGdlbmVy
aWMgYW5kIHByb2Nlc3NvciBwYXJ0cy4gVGhlcmUgaXMgb25seSBvbmUgInByb2Nlc3NvciIuCj4g
PiBCUEYgaXMgc3VjaCBhIHByb2Nlc3Nvci4KPgo+IFdoYXQgSSB3YXMgdHJ5aW5nIHRvIHNheSB3
YXMgdGhhdCB0aGUgZG9jdW1lbnQgaGVyZSBkZXNjcmliZXMgYQo+IGdlbmVyaWMgQUJJLiBJbiB0
aGlzIGRvY3VtZW50IHRoZXJlIHdpbGwgYmUgYXJlYXMgdGhhdCBhcmUgc3BlY2lmaWMgdG8KPiBk
aWZmZXJlbnQgaW1wbGVtZW50YXRpb25zIGFuZCB0aG9zZSB3b3VsZCBiZSBjb25zaWRlcmVkIHBy
b2Nlc3Nvcgo+IHNwZWNpZmljLiBJbiBvdGhlciB3b3JkcywgdGhlIHVicGYgcnVudGltZSBjb3Vs
ZCBkZWZpbmUgdGhvc2UgdGhpbmdzCj4gZGlmZmVyZW50bHkgdGhhbiB0aGUgcmJwZiBydW50aW1l
IHdoaWNoLCBpbiB0dXJuLCBjb3VsZCBkZWZpbmUgdGhvc2UKPiB0aGluZ3MgZGlmZmVyZW50bHkg
dGhhbiB0aGUga2VybmVsJ3MgaW1wbGVtZW50YXRpb24uCgpJIHNlZSB3aGF0IHlvdSBtZWFuLiBU
aGVyZSBpcyBvbmx5IG9uZSBCUEYgcHNBQkkuIFRoZXJlIGNhbm5vdCBiZSB0d28uCnVicGYgY2Fu
IGRlY2lkZSBub3QgdG8gZm9sbG93IGl0LCBidXQgaXQgY291bGQgb25seSBtZWFuIHRoYXQKaXQn
cyBub24gY29uZm9ybWFudCBhbmQgbm90IGNvbXBhdGlibGUuCgotLSAKQnBmIG1haWxpbmcgbGlz
dApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

