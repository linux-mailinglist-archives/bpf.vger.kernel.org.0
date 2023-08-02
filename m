Return-Path: <bpf+bounces-6659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7576C2E6
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47932281149
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116F1EA5;
	Wed,  2 Aug 2023 02:29:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26FB7E
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:29:53 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3794213E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:29:52 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 66558C151B09
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690943392; bh=n7freF13mCm2sdt6LWEGcUpxhCZu6m4R3JiQ+e2ioNc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=QwCaudmBZ4ne4ahFAuUuMw9nytw8JSkIEaPtVS7+pZCxrC9gjq86KYrYVZN83DjIb
	 B6oTEJm5I9qZaRvet4eFb/rCtatacGUtJgOFhLLJUqeYE5+rufZmFzg2dLjyFgKgz6
	 SfTdjYJ9mt2RfkDxZdRTRVT42kqTTtDUJOBJcjuE=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Aug  1 19:29:52 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 46138C151AF2;
	Tue,  1 Aug 2023 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690943392; bh=n7freF13mCm2sdt6LWEGcUpxhCZu6m4R3JiQ+e2ioNc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=QwCaudmBZ4ne4ahFAuUuMw9nytw8JSkIEaPtVS7+pZCxrC9gjq86KYrYVZN83DjIb
	 B6oTEJm5I9qZaRvet4eFb/rCtatacGUtJgOFhLLJUqeYE5+rufZmFzg2dLjyFgKgz6
	 SfTdjYJ9mt2RfkDxZdRTRVT42kqTTtDUJOBJcjuE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 10365C151089
 for <bpf@ietfa.amsl.com>; Tue,  1 Aug 2023 19:29:51 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.108
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8VjPQmfGYSh0 for <bpf@ietfa.amsl.com>;
 Tue,  1 Aug 2023 19:29:49 -0700 (PDT)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 47C86C151AF7
 for <bpf@ietf.org>; Tue,  1 Aug 2023 19:29:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b9f0b7af65so38255041fa.1
 for <bpf@ietf.org>; Tue, 01 Aug 2023 19:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690943387; x=1691548187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOJuZZFFX2LE/w7s6LGZvLuvbn7OkI/88EWjdCuwZJg=;
 b=Wj41toKy1kjY3DImM43ktBBieBpJRHbaEvWXzPOOhQIgsBlpBPvikdu+/BuZ85Rdvk
 y09uYWI9WJlaPtCXoRyjZmmyakhSk0n9tRlvtScCe4K8QblSkQYSnhHYuaJIXFn62ct0
 O0QLh8eDzsniLdFYfxqxJQMwl5eDtlABhSAl9kAQ2cJdL4RbwV2rtq9kIlvpvgfrQsIN
 mJFRqQPm1RekG1XPpTZrtTH7lvyad3ndyUlaL3HYq5AV0qXk39FHUxdLKkbMICGMcMs9
 9Jbixxvr401MOVhIXvxiNzhMnFl/d5WFFjoG8AsZ8GwdKZdUvpCuJqb8nNP+dcrLNKkf
 JRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690943387; x=1691548187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UOJuZZFFX2LE/w7s6LGZvLuvbn7OkI/88EWjdCuwZJg=;
 b=AvUfGH8lAbduf219DNKTV9t9GKGxO5SC3t/REFVzZBQ1Mjgx5iZAXYYhKVr6TqvR1x
 FIeFQuVnBSXdR/5pdAIeghw8gm6D/eLB57jvQNTGF8l9zg5MIJb3lcKuSQ1fVwh2BnYd
 djMqX0pfsXPCYYr3x1jipFKyuWo4Mh92VIOWGlmVdvCPgGp0hO80EBSQHxAE94sY7m9+
 cueFIrtrxXYj9YVM96Oub3Xa57B407ErKjTeRrB2jWMds9vdvlVoMGCGBLJaL1fSR7Ll
 I4R/ubOARB9h0rkQA+ctjDlpHhbgvP4luI7eH52rQpfR4ZbYsDAFp6wz4UrV7G1he2b0
 dEMA==
X-Gm-Message-State: ABy/qLZ9GHDjL5RnoPVPAjhtAk6OWpRR/HgixhZ2evPQyiDz2sC90IBA
 A0qvwdaYb4JuhTEBBEA+rEkM+BCnCOvKKkf82cc=
X-Google-Smtp-Source: APBJJlE7h0loH5xufMUfLk3jZdlR6YCOHu2533xHWPKaNUwPiDdEPDeT/ewW8lwqthCgxdJ1ZKZ2RHldXwIkYHb6fms=
X-Received: by 2002:a2e:3e07:0:b0:2b8:3ac9:e201 with SMTP id
 l7-20020a2e3e07000000b002b83ac9e201mr3697535lja.40.1690943386859; Tue, 01 Aug
 2023 19:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
 <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
 <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
 <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
 <CAADnVQLWKnGbG6XTVEKSto0kEiqHwFaDTp+UkCYipKpov_btRA@mail.gmail.com>
 <PH7PR21MB38789504BF4250E37467C484A30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB38789504BF4250E37467C484A30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 19:29:35 -0700
Message-ID: <CAADnVQLt7S9uwMxB3JaLMYACs5xTVwZ+en9pLYUguZ3gOf=33g@mail.gmail.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: Will Hawkins <hawkinsw@obs.cr>, Watson Ladd <watsonbladd@gmail.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/HhzIS-i3TVJ89gD0oM4myaM9e80>
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

T24gVHVlLCBBdWcgMSwgMjAyMyBhdCA2OjU14oCvUE0gRGF2ZSBUaGFsZXIgPGR0aGFsZXJAbWlj
cm9zb2Z0LmNvbT4gd3JvdGU6Cj4KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBG
cm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+Cj4g
PiBTZW50OiBGcmlkYXksIEp1bHkgMjgsIDIwMjMgOTo1MiBQTQo+ID4gVG86IFdpbGwgSGF3a2lu
cyA8aGF3a2luc3dAb2JzLmNyPgo+ID4gQ2M6IFdhdHNvbiBMYWRkIDx3YXRzb25ibGFkZEBnbWFp
bC5jb20+OyBEYXZlIFRoYWxlcgo+ID4gPGR0aGFsZXJAbWljcm9zb2Z0LmNvbT47IGJwZkBpZXRm
Lm9yZzsgYnBmIDxicGZAdmdlci5rZXJuZWwub3JnPgo+ID4gU3ViamVjdDogUmU6IFtCcGZdIFJl
dmlldyBvZiBkcmFmdC10aGFsZXItYnBmLWlzYS0wMQo+ID4KPiA+IE9uIEZyaSwgSnVsIDI4LCAy
MDIzIGF0IDg6MTTigK9QTSBXaWxsIEhhd2tpbnMgPGhhd2tpbnN3QG9icy5jcj4gd3JvdGU6Cj4g
PiA+Cj4gPiA+IFRoZSBBcHBlbmRpeCAodGhlIG9wY29kZSB0YWJsZSkgaXMgbm90IGluIHRoZSBr
ZXJuZWwgcmVwbyBub3cgYW5kCj4gPiA+IHN0aWxsIGhhcyB0aGUgaXNzdWVzIHRoYXQgSSBvdXRs
aW5lZCBhYm92ZS4KPgo+IFN1Z2dlc3Rpb25zIChlc3BlY2lhbGx5IGNvbmNyZXRlIGNoYW5nZXMp
IHdlbGNvbWUgOikKPgo+ID4gV2lsbCB0aGF0IG1ha2UgaXQgaW4gdG8KPiA+ID4gdGhlIGtlcm5l
bD8KPiBbLi4uXQo+ID4gSSB0aG91Z2h0IGl0J3MgYXV0byBnZW5lcmF0ZWQsIHNvIGl0IHNob3Vs
ZCBiZSBlYXN5IHRvIHVwZGF0ZS4KPgo+IEl0J3Mgbm90IHlldCBhdXRvIGdlbmVyYXRlZCwgYW5k
IHNvbWUgcGFydHMgYXJlIGhhcmQgdG8gYXV0by1nZW5lcmF0ZWQKPiBiZWNhdXNlIHRoZSBjb21i
aW5hdGlvbnMgYXJlIGp1c3QgaW4gRW5nbGlzaCB0ZXh0Lgo+Cj4gPiBJZiBub3QsIGxldCdzIGNl
cnRhaW5seSBicmluZyBpdCBpbi4KPgo+IEF0IHRoZSBJRVRGIEJQRiBXRyBtZWV0aW5nLCBmb2xr
cyBzZWVtZWQgYWdub3N0aWMgYXMgdG8gd2hldGhlciBpdAo+IHdhcyBicm91Z2h0IGludG8gdGhl
IExpbnV4IHJlcG8gb3Igbm90LiAgU2VlIHJlY29yZGluZyBhdAo+IGh0dHBzOi8vd3d3LnlvdXR1
YmUuY29tL3dhdGNoP3Y9alR0UGJKcWZZd0kgYXQgMToxNTozMCAtIDE6MTc6MzAsCj4gYW5kIENo
cmlzdG9waCB3YXMgdGhlIG9ubHkgb25lIHdobyBzcG9rZSB1cCwgcHJlZmVycmluZyB0byBqdXN0
IGtlZXAKPiBhIHN0YXRpYyBjb3B5IG9mIHRoZSBJbnRlcm5ldCBEcmFmdCBpbiB0aGUga2VybmVs
IHJlcG9zaXRvcnkuICBJIGludGVycHJldGVkCj4gdGhpcyBhcyBzYXlpbmcgbm8gb25lIGNhcmVk
IGFib3V0IGhhdmluZyB0aGUgSUFOQSBjb25zaWRlcmF0aW9ucyBzZWN0aW9uCj4gaW4gYSBzZXBh
cmF0ZSBmaWxlIHRoZXJlLiAgQnV0IHdlIGNvbmZpcm0gY29uc2Vuc3VzIG9uIHRoZSBsaXN0LCBz
byBpdCdzIGZpbmUKPiB0byByZXZpc2l0IG5vdyBpZiB0aGVyZSBhcmUgZ29vZCByZWFzb25zIHRv
IGRvIHNvLgoKSSB0aGluayBJQU5BIGNvbnNpZGVyYXRpb24gc2VjdGlvbiBpcyBvcnRob2dvbmFs
IHRvIGdpYW50IG9wY29kZSB0YWJsZS4KVGhleSdyZSByZWxhdGVkLCBidXQgZG9uJ3QgaGF2ZSB0
byBiZSB0b2dldGhlciBpbiBvbmUgLnJzdCBmaWxlLgpJIHRoaW5rIGl0J3MgY2xlYW5lciB0byBo
YXZlIHNlcGFyYXRlIGluc3RydWN0aW9uLXNldC1vcGNvZGUucnN0CgpXZSBhbHNvIHdlbnQgYmFj
ayBhbmQgZm9ydGggZHVyaW5nIHRoZSBtZWV0aW5nIHdoZXRoZXIgaGllcmFyY2h5Cm9mIHRhYmxl
cyBpcyBwcmVmZXJlZCBvciBvbmUgdGFibGUuIEN1cnJlbnRseSB5b3UgaGF2ZSBvbmUgdGFibGUg
YW5kCml0IGFjdHVhbGx5IGxvb2tzIHZlcnkgcmVhZGFibGUuIE15IHByZWZlcmVuY2Ugd291bGQg
YmUgdG8ga2VlcCBpdCB0aGlzCndheSBhbmQgY2Fycnkgb3ZlciB0byBJQU5BIGV2ZW50dWFsbHkg
YXMgb25lIHRhYmxlLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8v
d3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

