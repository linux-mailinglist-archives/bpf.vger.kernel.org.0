Return-Path: <bpf+bounces-6283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64823767917
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 01:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215B22822B9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6516220FB4;
	Fri, 28 Jul 2023 23:33:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA1525C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 23:33:06 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0684222
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:33:04 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6F1A1C1516E3
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690587184; bh=0Li9lTOWVzUbM5ZQRzFFJAEsft09LwTpjn/43HtOYnY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=NXVeJe046dyLnoCL46Xg1xvwXlyL+aFonvRBeDUA+AThke0s6xwG79CQyrF6Y6vkB
	 ZdYU8NuDsaqndyJENvhijixVdhK1O2Qj17ak71yACpzqCieCDr3LbvEBtVkEB4/G+P
	 gJpMFU7tBsiMslBfjbmkLxwawxypW1Rc0TjAdiSs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 16:33:04 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 44350C14CE42;
	Fri, 28 Jul 2023 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690587184; bh=0Li9lTOWVzUbM5ZQRzFFJAEsft09LwTpjn/43HtOYnY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=NXVeJe046dyLnoCL46Xg1xvwXlyL+aFonvRBeDUA+AThke0s6xwG79CQyrF6Y6vkB
	 ZdYU8NuDsaqndyJENvhijixVdhK1O2Qj17ak71yACpzqCieCDr3LbvEBtVkEB4/G+P
	 gJpMFU7tBsiMslBfjbmkLxwawxypW1Rc0TjAdiSs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id BB57EC14CE42
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 16:33:02 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.904
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fg-pU9YfDft1 for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 16:32:58 -0700 (PDT)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 719B9C14CE40
 for <bpf@ietf.org>; Fri, 28 Jul 2023 16:32:58 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-63d3583d0efso16369846d6.1
 for <bpf@ietf.org>; Fri, 28 Jul 2023 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690587177; x=1691191977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxCTFaHrTVESGNYLRZvUe6lEIyuB/4+fv2YbMx/txfo=;
 b=tQtVLDq+kn+5hyaQZfNyV7++oK/YuKSIPWq9JIXwMFpbtUYCDBT2y7lhl6ecKVhXGw
 ocZhTmhU/QNPcnn8uobWaDU99FGN1wN44SBbVbGZy+0wLxGScXEEMJoSJtSRZ7s3DN66
 Bs3IzWZf3W0jXLPm/7Of4LkQlD/XKD83D351rTrpXBnJ3bmexfYhC29ioPgBTcq72pqA
 2MZzDtspuLxacRACb+G2k4ayRerosVDdtqqzQVGa5lmgtA/cUYB88JenuEn2NH6z4eSs
 DKOtCPV1HeAZ0EEy35vMeaw+pbQdfwEd2amjDpWgtt+dTuod2MxClmMNMuSe2aDS+ZOd
 FHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690587177; x=1691191977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxCTFaHrTVESGNYLRZvUe6lEIyuB/4+fv2YbMx/txfo=;
 b=Rbt+kLLuzw++VMNl0UBdB+KCmvcFNVW2psCeOGv3o3LlQIdAuAgqct6VvnXmwKFYhy
 cA2IX5zeFnlgEfNHhWYtqfkhBg10lYGJpjCOhDU4BR++p082MgvyoCGqfT4dg0TMstIA
 PyRvi5RqvRb8kZVRKvHeLR2SSjHheuMhYJ2DsZjYuKFxUgYBGE//nqgwlTvW9X2D/m2H
 KnAHs+0qPvMoV2Yz09C5m9THpasrZmuPoGVjDfXL8vtueS/Qy3oeediFiyDPFSq9SuZG
 a5JXtGIf0PN8at+b7a7dfR2/GS0w2rrCk9oPWcv71M3tYy8oVaMBbub1X+pHBKSLw1Kp
 vihg==
X-Gm-Message-State: ABy/qLa3zX9z5DQrlTVQ3yCUfkPdq2Gk14HS+6qIGJLsnQV2flmQ9PjE
 DaCnOMxjpTl16FKUPo+ZjzKcR/gbFZ9GTDMUm+A+gQ==
X-Google-Smtp-Source: APBJJlG/UEmQb5AeCTAQMFHj1XH7vGtnuyHr1Tk+quU5votGceS8nN2xWPHUihBJ3jLdUlSUSSFXz+jOOn0lPBlTRuI=
X-Received: by 2002:a05:6214:57c8:b0:63d:311f:c901 with SMTP id
 lw8-20020a05621457c800b0063d311fc901mr4002385qvb.34.1690587177470; Fri, 28
 Jul 2023 16:32:57 -0700 (PDT)
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
In-Reply-To: <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 19:32:46 -0400
Message-ID: <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/yzWnOIpUpes3vMVZy-zPqnSVAhc>
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

T24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgOTowNeKAr1BNIEFsZXhlaSBTdGFyb3ZvaXRvdgo8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1bCAyNiwgMjAy
MyBhdCAxMjoxNuKAr1BNIFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPiB3cm90ZToKPiA+
Cj4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAyOjM34oCvUE0gV2F0c29uIExhZGQgPHdhdHNv
bmJsYWRkQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgSnVsIDI1LCAyMDIz
IGF0IDk6MTXigK9BTSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRv
dkBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gVHVlLCBKdWwgMjUsIDIwMjMg
YXQgNzowM+KAr0FNIERhdmUgVGhhbGVyIDxkdGhhbGVyQG1pY3Jvc29mdC5jb20+IHdyb3RlOgo+
ID4gPiA+ID4KPiA+ID4gPiA+IEkgYW0gZm9yd2FyZGluZyB0aGUgZW1haWwgYmVsb3cgKGFmdGVy
IGNvbnZlcnRpbmcgSFRNTCB0byBwbGFpbiB0ZXh0KQo+ID4gPiA+ID4gdG8gdGhlIG1haWx0bzpi
cGZAdmdlci5rZXJuZWwub3JnIGxpc3Qgc28gcmVwbGllcyBjYW4gZ28gdG8gYm90aCBsaXN0cy4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBQbGVhc2UgdXNlIHRoaXMgb25lIGZvciBhbnkgcmVwbGllcy4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MsCj4gPiA+ID4gPiBEYXZlCj4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBGcm9tOiBCcGYgPGJwZi1ib3VuY2VzQGlldGYub3JnPiBPbiBCZWhhbGYgT2YgV2F0
c29uIExhZGQKPiA+ID4gPiA+ID4gU2VudDogTW9uZGF5LCBKdWx5IDI0LCAyMDIzIDEwOjA1IFBN
Cj4gPiA+ID4gPiA+IFRvOiBicGZAaWV0Zi5vcmcKPiA+ID4gPiA+ID4gU3ViamVjdDogW0JwZl0g
UmV2aWV3IG9mIGRyYWZ0LXRoYWxlci1icGYtaXNhLTAxCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
IERlYXIgQlBGIHdnLAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJIHRvb2sgYSBsb29rIGF0IHRo
ZSBkcmFmdCBhbmQgdGhpbmsgaXQgaGFzIHNvbWUgaXNzdWVzLCB1bnN1cnByaXNpbmdseSBhdCB0
aGlzIHN0YWdlLiBPbmUgaXMKPiA+ID4gPiA+ID4gdGhlIHNwZWNpZmljYXRpb24gc2VlbXMgdG8g
dXNlIGFuIHVuZGVyc3BlY2lmaWVkIEMgcHNldWRvIGNvZGUgZm9yIG9wZXJhdGlvbnMgdnMKPiA+
ID4gPiA+ID4gZGVmaW5pbmcgdGhlbSBtYXRoZW1hdGljYWxseS4KPiA+ID4gPgo+ID4gPiA+IEhp
IFdhdHNvbiwKPiA+ID4gPgo+ID4gPiA+IFRoaXMgaXMgbm90ICJ1bmRlcnNwZWNpZmllZCBDIiBw
c2V1ZG8gY29kZS4KPiA+ID4gPiBUaGlzIGlzIGFzc2VtYmx5IHN5bnRheCBwYXJzZWQgYW5kIGVt
aXR0ZWQgYnkgR0NDLCBMTFZNLCBnYXMsIExpbnV4IEtlcm5lbCwgZXRjLgo+ID4gPgo+ID4gPiBJ
IGRvbid0IHNlZSBhIHJlZmVyZW5jZSB0byBhbnkgZGVzY3JpcHRpb24gb2YgdGhhdCBpbiBzZWN0
aW9uIDQuMS4KPiA+ID4gSXQncyBwb3NzaWJsZSBJJ3ZlIG92ZXJsb29rZWQgdGhpcywgYW5kIGlm
IHBlb3BsZSB0aGluayB0aGlzIHN0eWxlIG9mCj4gPiA+IGRlZmluaXRpb24gaXMgZ29vZCBlbm91
Z2ggdGhhdCB3b3JrcyBmb3IgbWUuIEJ1dCBJIGZvdW5kIHRhYmxlIDQKPiA+ID4gcHJldHR5IHNj
YW50eSBvbiB3aGF0IGV4YWN0bHkgaGFwcGVucy4KPiA+Cj4gPiBIZWxsbyEgQmFzZWQgb24gV2F0
c29uJ3MgcG9zdCwgSSBoYXZlIGRvbmUgc29tZSByZXNlYXJjaCBhbmQgd291bGQKPiA+IHBvdGVu
dGlhbGx5IGxpa2UgdG8gb2ZmZXIgYSBwYXRoIGZvcndhcmQuIFRoZXJlIGFyZSBzZXZlcmFsIGRp
ZmZlcmVudAo+ID4gd2F5cyB0aGF0IElTQXMgc3BlY2lmeSB0aGUgc2VtYW50aWNzIG9mIHRoZWly
IG9wZXJhdGlvbnM6Cj4gPgo+ID4gMS4gSW50ZWwgaGFzIGEgc2VjdGlvbiBpbiB0aGVpciBtYW51
YWwgdGhhdCBkZXNjcmliZXMgdGhlIHBzZXVkb2NvZGUKPiA+IHRoZXkgdXNlIHRvIHNwZWNpZnkg
dGhlaXIgSVNBOiBTZWN0aW9uIDMuMS4xLjkgb2YgVGhlIEludGVswq4gNjQgYW5kCj4gPiBJQS0z
MiBBcmNoaXRlY3R1cmVzIFNvZnR3YXJlIERldmVsb3BlcuKAmXMgTWFudWFsIGF0Cj4gPiBodHRw
czovL2NkcmR2Mi5pbnRlbC5jb20vdjEvZGwvZ2V0Q29udGVudC82NzExOTkKPiA+IDIuIEFSTSBo
YXMgYW4gZXF1aXZhbGVudCBmb3IgdGhlaXIgdmFyaWV0eSBvZiBwc2V1ZG9jb2RlOiBDaGFwdGVy
IEoxCj4gPiBvZiBBcm0gQXJjaGl0ZWN0dXJlIFJlZmVyZW5jZSBNYW51YWwgZm9yIEEtcHJvZmls
ZSBhcmNoaXRlY3R1cmUgYXQKPiA+IGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRh
dGlvbi9kZGkwNDg3L2xhdGVzdC8KPiA+IDMuIFNhaWwgImlzIGEgbGFuZ3VhZ2UgZm9yIGRlc2Ny
aWJpbmcgdGhlIGluc3RydWN0aW9uLXNldCBhcmNoaXRlY3R1cmUKPiA+IChJU0EpIHNlbWFudGlj
cyBvZiBwcm9jZXNzb3JzLiIKPiA+IChodHRwczovL3d3dy5jbC5jYW0uYWMudWsvfnBlczIwL3Nh
aWwvKQo+ID4KPiA+IEdpdmVuIHRoZSBjb21tZXJjaWFsIG5hdHVyZSBvZiAoMSkgYW5kICgyKSwg
cGVyaGFwcyBTYWlsIGlzIGEgd2F5IHRvCj4gPiBwcm9jZWVkLiBJZiBwZW9wbGUgYXJlIGludGVy
ZXN0ZWQsIEkgd291bGQgYmUgaGFwcHkgdG8gbGVhZCBhbiBlZmZvcnQKPiA+IHRvIGVuY29kZSB0
aGUgZUJQRiBJU0Egc2VtYW50aWNzIGluIFNhaWwgKG9yIGZpbmQgc29tZW9uZSB3aG8gYWxyZWFk
eQo+ID4gaGFzKSBhbmQgaW5jb3Jwb3JhdGUgdGhlbSBpbiB0aGUgZHJhZnQuCj4KPiBpbW8gU2Fp
bCBpcyB0b28gcmVzZWFyY2h5IHRvIGhhdmUgcHJhY3RpY2FsIHVzZS4KPiBMb29raW5nIGF0IGFy
bTY0IG9yIHg4NiBTYWlsIGRlc2NyaXB0aW9uIEkgcmVhbGx5IGRvbid0IHNlZSBob3cKPiBpdCB3
b3VsZCBtYXAgdG8gYW4gSUVURiBzdGFuZGFyZC4KPiBJdCdzIGRvbmUgaW4gYSAic2FpbCIgbGFu
Z3VhZ2UgdGhhdCBwZW9wbGUgbmVlZCB0byBsZWFybiBmaXJzdCB0byBiZQo+IGFibGUgdG8gcmVh
ZCBpdC4KPiBTYXkgd2UgaGFkIGJwZi5zYWlsIHNvbWV3aGVyZSBvbiBnaXRodWIuIFdoYXQgdmFs
dWUgZG9lcyBpdCBicmluZyB0bwo+IEJQRiBJU0Egc3RhbmRhcmQ/IEkgZG9uJ3Qgc2VlIGFuIGlt
bWVkaWF0ZSBiZW5lZml0IHRvIHN0YW5kYXJkaXphdGlvbi4KPiBUaGVyZSBjb3VsZCBiZSBvdGhl
ciB1c2UgY2FzZXMsIG5vIGRvdWJ0LCBidXQgc3RhbmRhcmRpemF0aW9uIGlzIG91ciBnb2FsLgo+
Cj4gQXMgZmFyIGFzIDEgYW5kIDIuIEludGVsIGFuZCBBcm0gdXNlIHRoZWlyIG93biBwc2V1ZG9j
b2RlLCBzbyB0aGV5IGhhZAo+IHRvIGFkZCBhIHBhcmFncmFwaCB0byBkZXNjcmliZSBpdC4gV2Ug
YXJlIHVzaW5nIEMgdG8gZGVzY3JpYmUgQlBGIElTQQoKCkkgY2Fubm90IGZpbmQgYSByZWZlcmVu
Y2UgaW4gdGhlIGN1cnJlbnQgdmVyc2lvbiB0aGF0IHNwZWNpZmllcyB3aGF0CndlIGFyZSB1c2lu
ZyB0byBkZXNjcmliZSB0aGUgb3BlcmF0aW9ucy4gSSdkIGxpa2UgdG8gYWRkIHRoYXQsIGJ1dAp3
YW50IHRvIG1ha2Ugc3VyZSB0aGF0IEkgY2xhcmlmeSB0d28gc3RhdGVtZW50cyB0aGF0IHNlZW0g
dG8gYmUgYXQKb2Rkcy4KCkltbWVkaWF0ZWx5IGFib3ZlIHlvdSBzYXkgdGhhdCB3ZSBhcmUgdXNp
bmcgIkMgdG8gZGVzY3JpYmUgdGhlIEJQRgpJU0EiIGFuZCBmdXJ0aGVyIGFib3ZlIHlvdSBzYXkg
IlRoaXMgaXMgYXNzZW1ibHkgc3ludGF4IHBhcnNlZCBhbmQKZW1pdHRlZCBieSBHQ0MsIExMVk0s
IGdhcywgTGludXggS2VybmVsLCBldGMuIgoKTXkgb3duIHJlYWRpbmcgaXMgdGhhdCBpdCBpcyB0
aGUgZm9ybWVyLCBhbmQgbm90IHRoZSBsYXR0ZXIuIEJ1dCwgSQp3YW50IHRvIGRvdWJsZSBjaGVj
ayBiZWZvcmUgYWRkaW5nIHRoZSBhcHByb3ByaWF0ZSBzdGF0ZW1lbnRzIHRvIHRoZQpDb252ZW50
aW9uIHNlY3Rpb24uCgpXaWxsCgo+IHNlbWFudGljcy4gSSBkb24ndCB0aGluayB3ZSBuZWVkIHRv
IGV4cGxhaW4gQyBpbiB0aGUgQlBGIElTQSBkb2MuCj4gVGhlIG9ubHkgZXhjZXB0aW9uIGlzICJz
Pj0iLCBidXQgaXQgaXMgZXhwbGFpbmVkIGluIHRoZSBkb2MgYWxyZWFkeS4KCi0tIApCcGYgbWFp
bGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2JwZgo=

