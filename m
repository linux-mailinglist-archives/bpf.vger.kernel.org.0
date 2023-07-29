Return-Path: <bpf+bounces-6295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323327679A5
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5589F1C20C99
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296564F;
	Sat, 29 Jul 2023 00:35:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7EA7C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:35:26 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B39AC2
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:35:24 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 324E8C151544
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690590924; bh=2Z3qdViQJLRJoj6cSqsd+iIYTgeEwydIBJLDX2w1V3E=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qHsepp7J8v8Jthah34GjWFbjdeDAuCQiwiFH1ZV6Z1n52r5s6Pubx2wfIxjEAOsJj
	 ELeEPUwoL5Y0HdkidfNfODs9y4mUzQRIXup1SldUrToNzMfeDRrL6wINVAz9ieVo9Q
	 gFyPM/KmIaJJbkpTTxk5lnyy/R4WtLxQDsSZg0kY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 17:35:24 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0937DC15106D;
	Fri, 28 Jul 2023 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690590924; bh=2Z3qdViQJLRJoj6cSqsd+iIYTgeEwydIBJLDX2w1V3E=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qHsepp7J8v8Jthah34GjWFbjdeDAuCQiwiFH1ZV6Z1n52r5s6Pubx2wfIxjEAOsJj
	 ELeEPUwoL5Y0HdkidfNfODs9y4mUzQRIXup1SldUrToNzMfeDRrL6wINVAz9ieVo9Q
	 gFyPM/KmIaJJbkpTTxk5lnyy/R4WtLxQDsSZg0kY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E3032C151069
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 17:35:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.106
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
 with ESMTP id EDlM2QV-BgAx for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 17:35:18 -0700 (PDT)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A0EEFC15106D
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:35:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe1489ced6so4612881e87.0
 for <bpf@ietf.org>; Fri, 28 Jul 2023 17:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690590917; x=1691195717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2J5OLKk0rp35/fM5esXxHanqOsIxvOdR7Hjz0ZxQrCM=;
 b=bE15akDoUT0teKFoP1IGeCnx2MtUXjgIhzLN0FmxoISz4qkkVswIivSXthBAi9c//A
 CLwKEd49k9633zeuUZQ8weLOpN6o4dz2Set2uX7WXycgpzrW+94UhPDqj0YW+hZM2JnK
 fNv22ZWrS0R/fxGn+FOoefa9FVmMriVO5IR4GaUmrQ5P0hXRkqwE0xAua9fR85MygK5M
 LEaWqzomcHI8u0epofokhPkQOrr/3FlDAw7J0b8pwm03F+aVECaY8Nuw+4J5lMF/I6ay
 hl24dFb4hv6PscURpc86eislKXRPcV6n6PQqCx06jJi/fRJ5TGSnzrQxRZfINWUycBBO
 9meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690590917; x=1691195717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2J5OLKk0rp35/fM5esXxHanqOsIxvOdR7Hjz0ZxQrCM=;
 b=lJ7B6rAyezUogXcHBa/EfgL97Hsrpp5oXjbX26ZkIuclXSatRe/VWowcbLIkT4c4IX
 ilKzEuWdPQ7Ga0QYcn3d0KrJ/TSYK5r7MIGUYorB+DsJISGW33n5GX36aVX7poeSwaLD
 7gKZbNISxZr4s+OOJOfdNOIlCCDQ5Ykt59lGFRvyVhJxd5q1WkT11JYPlt0e/j4VX7ki
 oz3wt2+5YNF2e+7gF0MwXMmpqNt70TjrX1LLuk2gBmvxqneO+zZrWaeJXs5jMXHz9PI+
 HIKtM3tXIIRsbPiJVDXdn34JwagkSwChCUbNSmxi1uJXzhc6QqrqiTp/XausWKjAQVIF
 OHnA==
X-Gm-Message-State: ABy/qLYjf1Y57ixOIR4bJGOeG/aSOCgwGGVa7o0HbiL3uNrnGNAzR1jR
 PHGD2hhpUljH7XOcbUW7MGm6c7wjUMxTA1Yp4Hg=
X-Google-Smtp-Source: APBJJlFX+eC0JecotlgRhQKPzJGxNjQ7a6KY6BB3JEguPEtrLw/M7GNDAJi4gqPtY+ECernyWSngzuhD0hg+tEwxKY4=
X-Received: by 2002:a05:651c:c3:b0:2b4:75f0:b9e9 with SMTP id
 3-20020a05651c00c300b002b475f0b9e9mr3047009ljr.10.1690590916713; Fri, 28 Jul
 2023 17:35:16 -0700 (PDT)
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
In-Reply-To: <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 17:35:05 -0700
Message-ID: <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/vqFwKvGYY--Drd4nZ0xTp6JYUIQ>
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgNToxOeKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dA
b2JzLmNyPiB3cm90ZToKPgo+IE9uIEZyaSwgSnVsIDI4LCAyMDIzIGF0IDg6MDXigK9QTSBBbGV4
ZWkgU3Rhcm92b2l0b3YKPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4g
Pgo+ID4gT24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgNDozMuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3
a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQg
OTowNeKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo+ID4gPiA8YWxleGVpLnN0YXJvdm9pdG92QGdt
YWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAx
MjoxNuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+ID4gPiA+
Cj4gPiA+ID4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAyOjM34oCvUE0gV2F0c29uIExhZGQg
PHdhdHNvbmJsYWRkQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9u
IFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDk6MTXigK9BTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+ID4g
PiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgNzowM+KAr0FNIERhdmUgVGhh
bGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+IEkgYW0gZm9yd2FyZGluZyB0aGUgZW1haWwgYmVsb3cgKGFmdGVyIGNvbnZlcnRp
bmcgSFRNTCB0byBwbGFpbiB0ZXh0KQo+ID4gPiA+ID4gPiA+ID4gdG8gdGhlIG1haWx0bzpicGZA
dmdlci5rZXJuZWwub3JnIGxpc3Qgc28gcmVwbGllcyBjYW4gZ28gdG8gYm90aCBsaXN0cy4KPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBQbGVhc2UgdXNlIHRoaXMgb25lIGZvciBhbnkg
cmVwbGllcy4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGFua3MsCj4gPiA+ID4g
PiA+ID4gPiBEYXZlCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBGcm9tOiBCcGYg
PGJwZi1ib3VuY2VzQGlldGYub3JnPiBPbiBCZWhhbGYgT2YgV2F0c29uIExhZGQKPiA+ID4gPiA+
ID4gPiA+ID4gU2VudDogTW9uZGF5LCBKdWx5IDI0LCAyMDIzIDEwOjA1IFBNCj4gPiA+ID4gPiA+
ID4gPiA+IFRvOiBicGZAaWV0Zi5vcmcKPiA+ID4gPiA+ID4gPiA+ID4gU3ViamVjdDogW0JwZl0g
UmV2aWV3IG9mIGRyYWZ0LXRoYWxlci1icGYtaXNhLTAxCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+IERlYXIgQlBGIHdnLAo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiBJIHRvb2sgYSBsb29rIGF0IHRoZSBkcmFmdCBhbmQgdGhpbmsgaXQgaGFzIHNvbWUgaXNz
dWVzLCB1bnN1cnByaXNpbmdseSBhdCB0aGlzIHN0YWdlLiBPbmUgaXMKPiA+ID4gPiA+ID4gPiA+
ID4gdGhlIHNwZWNpZmljYXRpb24gc2VlbXMgdG8gdXNlIGFuIHVuZGVyc3BlY2lmaWVkIEMgcHNl
dWRvIGNvZGUgZm9yIG9wZXJhdGlvbnMgdnMKPiA+ID4gPiA+ID4gPiA+ID4gZGVmaW5pbmcgdGhl
bSBtYXRoZW1hdGljYWxseS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEhpIFdhdHNvbiwK
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoaXMgaXMgbm90ICJ1bmRlcnNwZWNpZmllZCBD
IiBwc2V1ZG8gY29kZS4KPiA+ID4gPiA+ID4gPiBUaGlzIGlzIGFzc2VtYmx5IHN5bnRheCBwYXJz
ZWQgYW5kIGVtaXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4IEtlcm5lbCwgZXRjLgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiBJIGRvbid0IHNlZSBhIHJlZmVyZW5jZSB0byBhbnkgZGVzY3Jp
cHRpb24gb2YgdGhhdCBpbiBzZWN0aW9uIDQuMS4KPiA+ID4gPiA+ID4gSXQncyBwb3NzaWJsZSBJ
J3ZlIG92ZXJsb29rZWQgdGhpcywgYW5kIGlmIHBlb3BsZSB0aGluayB0aGlzIHN0eWxlIG9mCj4g
PiA+ID4gPiA+IGRlZmluaXRpb24gaXMgZ29vZCBlbm91Z2ggdGhhdCB3b3JrcyBmb3IgbWUuIEJ1
dCBJIGZvdW5kIHRhYmxlIDQKPiA+ID4gPiA+ID4gcHJldHR5IHNjYW50eSBvbiB3aGF0IGV4YWN0
bHkgaGFwcGVucy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBIZWxsbyEgQmFzZWQgb24gV2F0c29uJ3Mg
cG9zdCwgSSBoYXZlIGRvbmUgc29tZSByZXNlYXJjaCBhbmQgd291bGQKPiA+ID4gPiA+IHBvdGVu
dGlhbGx5IGxpa2UgdG8gb2ZmZXIgYSBwYXRoIGZvcndhcmQuIFRoZXJlIGFyZSBzZXZlcmFsIGRp
ZmZlcmVudAo+ID4gPiA+ID4gd2F5cyB0aGF0IElTQXMgc3BlY2lmeSB0aGUgc2VtYW50aWNzIG9m
IHRoZWlyIG9wZXJhdGlvbnM6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gMS4gSW50ZWwgaGFzIGEgc2Vj
dGlvbiBpbiB0aGVpciBtYW51YWwgdGhhdCBkZXNjcmliZXMgdGhlIHBzZXVkb2NvZGUKPiA+ID4g
PiA+IHRoZXkgdXNlIHRvIHNwZWNpZnkgdGhlaXIgSVNBOiBTZWN0aW9uIDMuMS4xLjkgb2YgVGhl
IEludGVswq4gNjQgYW5kCj4gPiA+ID4gPiBJQS0zMiBBcmNoaXRlY3R1cmVzIFNvZnR3YXJlIERl
dmVsb3BlcuKAmXMgTWFudWFsIGF0Cj4gPiA+ID4gPiBodHRwczovL2NkcmR2Mi5pbnRlbC5jb20v
djEvZGwvZ2V0Q29udGVudC82NzExOTkKPiA+ID4gPiA+IDIuIEFSTSBoYXMgYW4gZXF1aXZhbGVu
dCBmb3IgdGhlaXIgdmFyaWV0eSBvZiBwc2V1ZG9jb2RlOiBDaGFwdGVyIEoxCj4gPiA+ID4gPiBv
ZiBBcm0gQXJjaGl0ZWN0dXJlIFJlZmVyZW5jZSBNYW51YWwgZm9yIEEtcHJvZmlsZSBhcmNoaXRl
Y3R1cmUgYXQKPiA+ID4gPiA+IGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlv
bi9kZGkwNDg3L2xhdGVzdC8KPiA+ID4gPiA+IDMuIFNhaWwgImlzIGEgbGFuZ3VhZ2UgZm9yIGRl
c2NyaWJpbmcgdGhlIGluc3RydWN0aW9uLXNldCBhcmNoaXRlY3R1cmUKPiA+ID4gPiA+IChJU0Ep
IHNlbWFudGljcyBvZiBwcm9jZXNzb3JzLiIKPiA+ID4gPiA+IChodHRwczovL3d3dy5jbC5jYW0u
YWMudWsvfnBlczIwL3NhaWwvKQo+ID4gPiA+ID4KPiA+ID4gPiA+IEdpdmVuIHRoZSBjb21tZXJj
aWFsIG5hdHVyZSBvZiAoMSkgYW5kICgyKSwgcGVyaGFwcyBTYWlsIGlzIGEgd2F5IHRvCj4gPiA+
ID4gPiBwcm9jZWVkLiBJZiBwZW9wbGUgYXJlIGludGVyZXN0ZWQsIEkgd291bGQgYmUgaGFwcHkg
dG8gbGVhZCBhbiBlZmZvcnQKPiA+ID4gPiA+IHRvIGVuY29kZSB0aGUgZUJQRiBJU0Egc2VtYW50
aWNzIGluIFNhaWwgKG9yIGZpbmQgc29tZW9uZSB3aG8gYWxyZWFkeQo+ID4gPiA+ID4gaGFzKSBh
bmQgaW5jb3Jwb3JhdGUgdGhlbSBpbiB0aGUgZHJhZnQuCj4gPiA+ID4KPiA+ID4gPiBpbW8gU2Fp
bCBpcyB0b28gcmVzZWFyY2h5IHRvIGhhdmUgcHJhY3RpY2FsIHVzZS4KPiA+ID4gPiBMb29raW5n
IGF0IGFybTY0IG9yIHg4NiBTYWlsIGRlc2NyaXB0aW9uIEkgcmVhbGx5IGRvbid0IHNlZSBob3cK
PiA+ID4gPiBpdCB3b3VsZCBtYXAgdG8gYW4gSUVURiBzdGFuZGFyZC4KPiA+ID4gPiBJdCdzIGRv
bmUgaW4gYSAic2FpbCIgbGFuZ3VhZ2UgdGhhdCBwZW9wbGUgbmVlZCB0byBsZWFybiBmaXJzdCB0
byBiZQo+ID4gPiA+IGFibGUgdG8gcmVhZCBpdC4KPiA+ID4gPiBTYXkgd2UgaGFkIGJwZi5zYWls
IHNvbWV3aGVyZSBvbiBnaXRodWIuIFdoYXQgdmFsdWUgZG9lcyBpdCBicmluZyB0bwo+ID4gPiA+
IEJQRiBJU0Egc3RhbmRhcmQ/IEkgZG9uJ3Qgc2VlIGFuIGltbWVkaWF0ZSBiZW5lZml0IHRvIHN0
YW5kYXJkaXphdGlvbi4KPiA+ID4gPiBUaGVyZSBjb3VsZCBiZSBvdGhlciB1c2UgY2FzZXMsIG5v
IGRvdWJ0LCBidXQgc3RhbmRhcmRpemF0aW9uIGlzIG91ciBnb2FsLgo+ID4gPiA+Cj4gPiA+ID4g
QXMgZmFyIGFzIDEgYW5kIDIuIEludGVsIGFuZCBBcm0gdXNlIHRoZWlyIG93biBwc2V1ZG9jb2Rl
LCBzbyB0aGV5IGhhZAo+ID4gPiA+IHRvIGFkZCBhIHBhcmFncmFwaCB0byBkZXNjcmliZSBpdC4g
V2UgYXJlIHVzaW5nIEMgdG8gZGVzY3JpYmUgQlBGIElTQQo+ID4gPgo+ID4gPgo+ID4gPiBJIGNh
bm5vdCBmaW5kIGEgcmVmZXJlbmNlIGluIHRoZSBjdXJyZW50IHZlcnNpb24gdGhhdCBzcGVjaWZp
ZXMgd2hhdAo+ID4gPiB3ZSBhcmUgdXNpbmcgdG8gZGVzY3JpYmUgdGhlIG9wZXJhdGlvbnMuIEkn
ZCBsaWtlIHRvIGFkZCB0aGF0LCBidXQKPiA+ID4gd2FudCB0byBtYWtlIHN1cmUgdGhhdCBJIGNs
YXJpZnkgdHdvIHN0YXRlbWVudHMgdGhhdCBzZWVtIHRvIGJlIGF0Cj4gPiA+IG9kZHMuCj4gPiA+
Cj4gPiA+IEltbWVkaWF0ZWx5IGFib3ZlIHlvdSBzYXkgdGhhdCB3ZSBhcmUgdXNpbmcgIkMgdG8g
ZGVzY3JpYmUgdGhlIEJQRgo+ID4gPiBJU0EiIGFuZCBmdXJ0aGVyIGFib3ZlIHlvdSBzYXkgIlRo
aXMgaXMgYXNzZW1ibHkgc3ludGF4IHBhcnNlZCBhbmQKPiA+ID4gZW1pdHRlZCBieSBHQ0MsIExM
Vk0sIGdhcywgTGludXggS2VybmVsLCBldGMuIgo+ID4gPgo+ID4gPiBNeSBvd24gcmVhZGluZyBp
cyB0aGF0IGl0IGlzIHRoZSBmb3JtZXIsIGFuZCBub3QgdGhlIGxhdHRlci4gQnV0LCBJCj4gPiA+
IHdhbnQgdG8gZG91YmxlIGNoZWNrIGJlZm9yZSBhZGRpbmcgdGhlIGFwcHJvcHJpYXRlIHN0YXRl
bWVudHMgdG8gdGhlCj4gPiA+IENvbnZlbnRpb24gc2VjdGlvbi4KPiA+Cj4gPiBJdCdzIGJvdGgu
IEknbSBub3Qgc3VyZSB3aGVyZSB5b3Ugc2VlIGEgY29udHJhZGljdGlvbi4KPiA+IEl0J3MgYSBu
b3JtYWwgQyBzeW50YXggYW5kIGl0J3MgZW1pdHRlZCBieSB0aGUga2VybmVsIHZlcmlmaWVyLAo+
ID4gcGFyc2VkIGJ5IGNsYW5nL2djYyBhc3NlbWJsZXJzIGFuZCBlbWl0dGVkIGJ5IGNvbXBpbGVy
cy4KPgo+Cj4gT2theS4gSSBhcG9sb2dpemUuIEkgYW0gc2luY2VyZWx5IGNvbmZ1c2VkLiBGb3Ig
aW5zdGFuY2UsCj4KPiBpZiAodTMyKWRzdCA+PSAodTMyKXNyYyBnb3RvICtvZmZzZXQKPgo+IExv
b2tzIGxpa2Ugbm90aGluZyB0aGF0IEkgaGF2ZSBldmVyIHNlZW4gaW4gIm5vcm1hbCBDIHN5bnRh
eCIuCgpJIHRob3VnaHQgd2UncmUgdGFsa2luZyBhYm91dCB0YWJsZSA0IGFuZCBBTFUgb3BzLgpB
Ym92ZSBpcyBub3QgYSBwdXJlIEMsIGJ1dCBpdCdzIG9idmlvdXMgZW5vdWdoIHdpdGhvdXQgZXhw
bGFuYXRpb24sIG5vPwpBbHNvIEkgZG9uJ3Qgc2VlIGFib3ZlIGFueXdoZXJlIGluIHRoZSBkb2Mu
CldlIGRlc2NyaWJlIGNvbmRpdGlvbmFscyBsaWtlOgpCUEZfSkdFICAgMHgzICAgIGFueSAgUEMg
Kz0gb2Zmc2V0IGlmIGRzdCA+PSBzcmMKCj4gVGhlcmUgYWxzbyBhcHBlYXIgdG8gYmUgYSBmZXcg
b3RoZXIgcGxhY2VzIHdoZXJlIHRoaW5ncyBtaWdodCBiZSBhIGJpdCB3b25reToKPgo+IDEuIEFk
ZHJlc3MgYXJpdGhtZXRpYyBpbiB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIGxvYWQvc3RvcmUKPiBp
bnN0cnVjdGlvbnMgd2lsbCBkZXBlbmQgb24gdGhlIHR5cGUgb2YgdGhlIHRhcmdldDogRS5nLiwK
Pgo+ICoodTY0ICopKGRzdCArIG9mZnNldCkgPSBpbW0KPgo+IFRoZSBhZGRyZXNzIHRvIHdoaWNo
IHRoZSBzdG9yZSBpcyBkb25lIHdpbGwgYmUgb2Zmc2V0KnNpemVvZihYKSBieXRlcwo+IGZyb20g
ZHN0IHdoZXJlIFggaXMgdGhlIHR5cGUgb2YgdGhlIHRhcmdldCBvZiBkc3QuIElmIHdlIGFyZSBh
c3N1bWluZwo+IHRoYXQgZHN0IChvciBpdHMgZXF1aXZhbGVudCBpbiBzaW1pbGFyIGluc3RydWN0
aW9ucykgaXMgYmVpbmcgdHJlYXRlZAo+IHNpbXBseSBhcyBhbiB1bnNpZ25lZCBpbnRlZ2VyLCBJ
IGJlbGlldmUgdGhhdCB3ZSB3aWxsIGhhdmUgdG8gc2F5IHRoYXQKPiBleHBsaWNpdGx5LCBlc3Bl
Y2lhbGx5IGdpdmVuIHRoYXQgd2UgZGVzY3JpYmUgb2Zmc2V0IGFzICJzaWduZWQKPiBpbnRlZ2Vy
IG9mZnNldCB1c2VkIHdpdGggcG9pbnRlciBhcml0aG1ldGljIiBpbiB0aGUgSW5zdHJ1Y3Rpb24K
PiBlbmNvZGluZyBzZWN0aW9uLgoKSXQncyBub3Q6CiooKHU2NCAqKShkc3QpICsgb2Zmc2V0KSA9
IGltbQoKVGhlIGRvYyBkb2Vzbid0IHNheSB0aGF0ICdkc3QnIGlzIGEgcG9pbnRlciAndTY0ICpk
c3QnIHR5cGUuCkluc3RlYWQgaXQgc2F5czoKLS0KVGhlICdjb2RlJyBmaWVsZCBlbmNvZGVzIHRo
ZSBvcGVyYXRpb24gYXMgYmVsb3csIHdoZXJlICdzcmMnIGFuZCAnZHN0JyByZWZlcgp0byB0aGUg
dmFsdWVzIG9mIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIHJlZ2lzdGVycywgcmVzcGVjdGl2
ZWx5LgotLQoKc28gZHN0ICsgb2Zmc2V0IGlzIGEgcGxhaW4gYWRkaXRpb24gb2YgdHdvIHZhbHVl
cyBhbmQgdGhlbiB0eXBlIGNhc3QuCgo+Cj4gMi4gaHRvW2JsXWVOIGZ1bmN0aW9ucyBhcmUgbm90
IHNwZWNpZmllZCBieSBzdGFuZGFyZCBDIGFuZCwgd2hpbGUKPiAib2J2aW91cyIgd2hhdCB0aGV5
IGRvLCBhcmUgbm90IGRlZmluZWQgaW4gdGhlIGRvY3VtZW50IGFueXdoZXJlLgoKeWVhaC4gd2Ug
Y2FuIGFkZCBhIHNob3J0IHNlbnRlbmNlIGFib3V0IGh0b2xuLgoKLS0gCkJwZiBtYWlsaW5nIGxp
c3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBm
Cg==

