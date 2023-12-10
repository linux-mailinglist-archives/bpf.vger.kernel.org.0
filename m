Return-Path: <bpf+bounces-17327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DF80B884
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 04:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA89F1F210A8
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799E815C3;
	Sun, 10 Dec 2023 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="OYGa8Xgc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="OYGa8Xgc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+43UDbv"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CC106
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 19:10:53 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 93B10C18FCC7
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 19:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702177852; bh=M48ugGmd+5kvNStB10wI12YTC5icYb5q+WMKXbGNOdo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=OYGa8Xgc0MGIJPoSnae1PM8QQMd2DuoP5e+BjAoqEtotE1gzNAcoQGvQUgdUV7E/Q
	 54BPqJfgbeth9P3yC/7lVLhM2tENrxNviW1eEMSkvNBDCzqx/b+AiHsbDe2X/gBme4
	 QBLkRoBMIxyeMaEE6gyrKcpXLK2FaF8BG8zGpwHc=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Dec  9 19:10:52 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 633EEC15152E;
	Sat,  9 Dec 2023 19:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702177852; bh=M48ugGmd+5kvNStB10wI12YTC5icYb5q+WMKXbGNOdo=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=OYGa8Xgc0MGIJPoSnae1PM8QQMd2DuoP5e+BjAoqEtotE1gzNAcoQGvQUgdUV7E/Q
	 54BPqJfgbeth9P3yC/7lVLhM2tENrxNviW1eEMSkvNBDCzqx/b+AiHsbDe2X/gBme4
	 QBLkRoBMIxyeMaEE6gyrKcpXLK2FaF8BG8zGpwHc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 774CCC15152E
 for <bpf@ietfa.amsl.com>; Sat,  9 Dec 2023 19:10:51 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id alE1t7K5EV4C for <bpf@ietfa.amsl.com>;
 Sat,  9 Dec 2023 19:10:47 -0800 (PST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E96A0C15109E
 for <bpf@ietf.org>; Sat,  9 Dec 2023 19:10:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b27726369so37189895e9.0
 for <bpf@ietf.org>; Sat, 09 Dec 2023 19:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702177845; x=1702782645; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIksy3SQTBUBARta9D9fpak30NF+hUQgyMPS+9iDm/8=;
 b=M+43UDbvzx3dNN2Z/GXXGjIwtbG8jT1cjObSD5zt89b2fAOxDJNLWH0cwpnJSPOC2i
 /M6/E/UJupxvuCw7eCrKeAAwQh2GQ93mj0IqMu1DUa/AFGMLqeRLyutOPkhbGWRGRk+f
 uLKuVSB7lKzU7x9LQr27MQdoOsqValJLnKs9CybQxyUHcpqNEGM6AtG5bJJw38SrOHaC
 VjCiX2M7tKgftyl78uP3NBkAkaU7JjRSPXovgINfpiF/bCdZtM7/5nQm/O7ZcDt/s8ye
 T5qZHSSjgkem0f+kvMy9ihZXDrrrE28Kk4mBpJkQ82ddIgMyG+o9dvhyc3HLsfBOtvgW
 D2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702177845; x=1702782645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIksy3SQTBUBARta9D9fpak30NF+hUQgyMPS+9iDm/8=;
 b=Amoikrv3En7kVOfpseoA4LRyjit8Bl32Uc+czYW0B5hzvPFQ30milyRCjB47S0c7x0
 SklpmePYJO7pOXHRQJRFbRlfZBW5YKh6L6q1TsriODqx5o2ETwZsv4ePcePkQ22mottW
 s3VG5QKfq9MMWua6+tNfTUNYwz7oJieaTbmUa9DAC2w8LKQOVfoLlVftQZv8ZoRclGBp
 aqbX1LoamaMHjdYFSYDBmPt2BhbkdYGsNVQoCdhvtqnr/rtHWCw8GSZ1TdkBDEThXWLl
 Z5ldMziL1rMSGmyMz4U9jLoO/g0SJfmJFO99IeraUNgXOBq0WJTxVpk20tinlNn21gQJ
 9s4A==
X-Gm-Message-State: AOJu0YzxvlFfq8SJmz3LkUjhFTrp6A0+YElJMUoOaKuNRAV1gCKnXr2u
 xLm3hKoWOgA4KQLU5pCGMbdljyDwzJfL/I17Y3WobFrX
X-Google-Smtp-Source: AGHT+IHG7+fwvr9GYUZJ4DPY02szyiNOUhDwcZzNYUye5guoD8UtqXxCrgnYb32ceF/YYe/ZxuY/PC+5zbP7xynHSA8=
X-Received: by 2002:a05:600c:3784:b0:40b:5e21:e27b with SMTP id
 o4-20020a05600c378400b0040b5e21e27bmr1234528wmr.104.1702177845234; Sat, 09
 Dec 2023 19:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
In-Reply-To: <20231207215152.GA168514@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Dec 2023 19:10:33 -0800
Message-ID: <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>, 
 Christoph Hellwig <hch@infradead.org>, bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/_CViBgpJOIQM0fvKcHWQCpCRFvg>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gVGh1LCBEZWMgNywgMjAyMyBhdCAxOjUx4oCvUE0gRGF2aWQgVmVybmV0IDx2b2lkQG1hbmlm
YXVsdC5jb20+IHdyb3RlOgo+Cj4gT24gU2F0LCBEZWMgMDIsIDIwMjMgYXQgMTE6NTE6NTBBTSAt
MDgwMCwgZHRoYWxlcjE5Njg9NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5pZXRmLm9yZyB3cm90ZToK
PiA+ID5Gcm9tIERhdmlkIFZlcm5ldCdzIFdHIHN1bW1hcnk6Cj4gPiA+IEFmdGVyIHRoaXMgdXBk
YXRlLCB0aGUgZGlzY3Vzc2lvbiBtb3ZlZCB0byBhIHRvcGljIGZvciB0aGUgQlBGIElTQQo+ID4g
ZG9jdW1lbnQgdGhhdCBoYXMgeWV0IHRvIGJlIHJlc29sdmVkOgo+ID4gPiBJU0EgUkZDIGNvbXBs
aWFuY2UuIERhdmUgcG9pbnRlZCBvdXQgdGhhdCB3ZSBzdGlsbCBuZWVkIHRvIHNwZWNpZnkgd2hp
Y2gKPiA+IGluc3RydWN0aW9ucyBpbiB0aGUgSVNBIGFyZQo+ID4gPiBNVVNULCBTSE9VTEQsIGV0
YywgdG8gZW5zdXJlIGludGVyb3BlcmFiaWxpdHkuICBTZXZlcmFsIGRpZmZlcmVudCBvcHRpb25z
Cj4gPiB3ZXJlIHByZXNlbnRlZCwgaW5jbHVkaW5nCj4gPiA+ICBoYXZpbmcgaW5kaXZpZHVhbC1p
bnN0cnVjdGlvbiBncmFudWxhcml0eSwgZm9sbG93aW5nIHRoZSBjbGFuZyBDUFUKPiA+IHZlcnNp
b25pbmcgY29udmVudGlvbiwgYW5kIGdyb3VwaW5nCj4gPiA+IGluc3RydWN0aW9ucyBieSBsb2dp
Y2FsIGZ1bmN0aW9uYWxpdHkuCj4gPiA+Cj4gPiA+IFdlIGRpZCBub3Qgb2J0YWluIGNvbnNlbnN1
cyBhdCB0aGUgY29uZmVyZW5jZSBvbiB3aGljaCB3YXMgdGhlIGJlc3Qgd2F5Cj4gPiBmb3J3YXJk
LiBTb21lIG9mIHRoZSBwb2ludHMgcmFpc2VkIGluY2x1ZGUgdGhlIGZvbGxvd2luZzoKPiA+ID4K
PiA+ID4gLSBGb2xsb3dpbmcgdGhlIGNsYW5nIENQVSB2ZXJzaW9uaW5nIGxhYmVscyBpcyBzb21l
d2hhdCBhcmJpdHJhcnkuIEl0Cj4gPiA+ICAgbWF5IG5vdCBiZSBhcHByb3ByaWF0ZSB0byBzdGFu
ZGFyZGl6ZSBhcm91bmQgZ3JvdXBpbmcgdGhhdCBpcyBhIHJlc3VsdAo+ID4gPiAgIG9mIGxhcmdl
bHkgb3JnYW5pYyBoaXN0b3JpY2FsIGFydGlmYWN0cy4KPiA+ID4gLSBJZiB3ZSBkZWNpZGUgdG8g
ZG8gbG9naWNhbCBncm91cGluZywgdGhlcmUgaXMgYSBkYW5nZXIgb2YKPiA+ID4gICBiaWtlc2hl
ZGRpbmcuIExvb2tpbmcgYXQgYW5lY2RvdGVzIGZyb20gaW5kdXN0cnksIHNvbWUgdmVuZG9ycyBz
dWNoIGFzCj4gPiA+ICAgTmV0cm9ub21lIGVsZWN0ZWQgdG8gbm90IHN1cHBvcnQgcGFydGljdWxh
ciBpbnN0cnVjdGlvbnMgZm9yCj4gPiA+ICAgcGVyZm9ybWFuY2UgcmVhc29ucy4KPiA+Cj4gPiBN
eSBzZW5zZSBvZiB0aGUgZmVlZGJhY2sgaW4gZ2VuZXJhbCB3YXMgdG8gZ3JvdXAgaW5zdHJ1Y3Rp
b25zIGJ5IGxvZ2ljYWwKPiA+IGZ1bmN0aW9uYWxpdHksIGFuZCBvbmx5IGNyZWF0ZSBzZXBhcmF0
ZQo+ID4gY29uZm9ybWFuY2UgZ3JvdXBzIHdoZXJlIHRoZXJlIGlzIHNvbWUgbGVnaXRpbWF0ZSB0
ZWNobmljYWwgcmVhc29uIHRoYXQgYQo+ID4gcnVudGltZSBtaWdodCBub3Qgd2FudCB0byBzdXBw
b3J0Cj4gPiBhIGdpdmVuIHNldCBvZiBpbnN0cnVjdGlvbnMuICBCYXNlZCBvbiBkaXNjdXNzaW9u
IGR1cmluZyB0aGUgbWVldGluZywgaGVyZSdzCj4gPiBhIHN0cmF3bWFuIHNldCBvZiBjb25mb3Jt
YW5jZQo+ID4gZ3JvdXBzIHRvIGtpY2sgb2ZmIGRpc2N1c3Npb24uICBJJ3ZlIHRyaWVkIHRvIHVz
ZSBzaG9ydCAobGlrZSA2IGNoYXJhY3RlcnMKPiA+IG9yIGZld2VyKSBuYW1lcyBmb3IgZWFzZSBv
ZiBkaXNwbGF5IGluCj4gPiBkb2N1bWVudCB0YWJsZXMsIGFuZCBwb3RlbnRpYWxseSBpbiBjb21t
YW5kIGxpbmUgb3B0aW9ucyB0byB0b29scyB0aGF0IG1pZ2h0Cj4gPiB3YW50IHRvIHVzZSB0aGVt
Lgo+ID4KPiA+IEEgZ2l2ZW4gcnVudGltZSBwbGF0Zm9ybSB3b3VsZCBiZSBjb21wbGlhbnQgdG8g
c29tZSBzZXQgb2YgdGhlIGZvbGxvd2luZwo+ID4gY29uZm9ybWFuY2UgZ3JvdXBzOgo+ID4KPiA+
IDEuICJiYXNpYyI6IGFsbCBpbnN0cnVjdGlvbnMgbm90IGNvdmVyZWQgYnkgYW5vdGhlciBncm91
cCBiZWxvdy4KPiA+IDIuICJhdG9taWMiOiBhbGwgQXRvbWljIG9wZXJhdGlvbnMuICBJIHRoaW5r
IENocmlzdG9waCBhcmd1ZWQgZm9yIHRoaXMgb25lCj4gPiBpbiB0aGUgbWVldGluZy4KPiA+IDMu
ICJkaXZpZGUiOiBhbGwgZGl2aXNpb24gYW5kIG1vZHVsbyBvcGVyYXRpb25zLiAgQWxleGVpIHNh
aWQgaW4gdGhlIG1lZXRpbmcKPiA+IHRoYXQgaGUnZCBoZWFyZCBkZW1hbmQgZm9yIHRoaXMgb25l
Lgo+ID4gNC4gImxlZ2FjeSI6IGFsbCBsZWdhY3kgcGFja2V0IGFjY2VzcyBpbnN0cnVjdGlvbnMg
KGRlcHJlY2F0ZWQpLgo+ID4gNS4gIm1hcCI6IDY0LWJpdCBpbW1lZGlhdGUgaW5zdHJ1Y3Rpb25z
IHRoYXQgZGVhbCB3aXRoIG1hcCBmZHMgb3IgbWFwCj4gPiBpbmRpY2VzLgo+ID4gNi4gImNvZGUi
OiA2NC1iaXQgaW1tZWRpYXRlIGluc3RydWN0aW9uIHRoYXQgaGFzIGEgImNvZGUgcG9pbnRlciIg
dHlwZS4KPiA+IDcuICJmdW5jIjogcHJvZ3JhbS1sb2NhbCBmdW5jdGlvbnMuCj4KPiBJIHRob3Vn
aHQgZm9yIGEgd2hpbGUgYWJvdXQgd2hldGhlciB0aGlzIHNob3VsZCBiZSBwYXJ0IG9mIHRoZSBi
YXNpYwo+IGNvbmZvcm1hbmNlIGdyb3VwLCBhbmQgdGFsa2VkIHRocm91Z2ggaXQgd2l0aCBKYWt1
YiBLaWNpbnNraS4gSSBkbyB0aGluawo+IGl0IG1ha2VzIHNlbnNlIHRvIGtlZXAgaXQgc2VwYXJh
dGUgbGlrZSB0aGlzLiBGb3IgZS5nLiBkZXZpY2VzIHdpdGgKPiBIYXJ2YXJkIGFyY2hpdGVjdHVy
ZXMsIGl0IGNvdWxkIGdldCBxdWl0ZSBub24tdHJpdmlhbCBmb3IgdGhlIHZlcmlmaWVyCj4gdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgYWNjZXNzZXMgdG8gYXJndW1lbnRzIHN0b3JlZCBpbiBzcGVjaWFs
IHJlZ2lzdGVyCj4gYXJlIHNhZmUuIERlZmluaXRlbHkgbm90IGltcG9zc2libGUsIGFuZCBvdmVy
YWxsIHZlcnkgdXNlZnVsIHRvIHN1cHBvcnQKPiB0aGlzLCBidXQgaW4gb3JkZXIgdG8gZWFzZSB2
ZW5kb3IgYWRvcHRpb24gaXQncyBwcm9iYWJseSBiZXN0IHRvIGtlZXAKPiB0aGlzIHNlcGFyYXRl
Lgo+Cj4gPiBUaGluZ3MgdGhhdCBJICp0aGluayogZG9uJ3QgbmVlZCBhIHNlcGFyYXRlIGNvbmZv
cm1hbmNlIGdyb3VwIChjYW4ganVzdCBiZQo+ID4gaW4gImJhc2ljIikgaW5jbHVkZToKPiA+IGEu
IENhbGwgaGVscGVyIGZ1bmN0aW9uIGJ5IGFkZHJlc3Mgb3IgQlRGIElELiAgQSBydW50aW1lIHRo
YXQgZG9lc24ndAo+ID4gc3VwcG9ydCB0aGVzZSBzaW1wbHkgd29uJ3QgZXhwb3NlIGFueQo+ID4g
ICAgIHN1Y2ggaGVscGVyIGZ1bmN0aW9ucyB0byBCUEYgcHJvZ3JhbXMuCj4gPiBiLiBQbGF0Zm9y
bSB2YXJpYWJsZSBpbnN0cnVjdGlvbnMgKGRzdCA9IHZhcl9hZGRyKGltbSkpLiAgQSBydW50aW1l
IHRoYXQKPiA+IGRvZXNuJ3Qgc3VwcG9ydCB0aGlzIHNpbXBseSB3b24ndAo+ID4gICAgIGV4cG9z
ZSBhbnkgcGxhdGZvcm0gdmFyaWFibGVzIHRvIEJQRiBwcm9ncmFtcy4KPiA+Cj4gPiBDb21tZW50
cz8gKExldCB0aGUgYmlrZXNoZWRkaW5nIGJlZ2luLi4uKQo+Cj4gVGhpcyBsaXN0IHNlZW1zIGxv
Z2ljYWwgdG8gbWUsCgpJIHRoaW5rIHdlIHNob3VsZCBkbyBqdXN0IHR3byBjYXRlZ29yaWVzOiBs
ZWdhY3kgYW5kIHRoZSByZXN0LApzaW5jZSBhbnkgc2NoZW1lIHdpbGwgYmUgZmxhd2VkIGFuZCBp
bmZpbml0ZSBiaWtlc2hlZGRpbmcgd2lsbCBlbnN1ZS4KRm9yIGV4YW1wbGUsIGxldCdzIHRha2Ug
YSBsb29rIGF0ICMyIGF0b21pYy4uLgpTaG91bGQgaXQgaW5jbHVkZSBvciBleGNsdWRlIGF0b21p
Y19hZGQgaW5zbiA/IEl0IHdhcyBhZGRlZAphdCB0aGUgdmVyeSBiZWdpbm5pbmcgb2YgQlBGIElT
QSBhbmQgd2FzIHVzZWQgZnJvbSBkYXkgb25lLgpXaXRob3V0IGl0IGl0J3MgaW1wb3NzaWJsZSB0
byBjb3VudCBzdGF0cy4gVGhlIHR5cGljYWwgbmV0d29yayBvcgp0cmFjaW5nIHVzZSBjYXNlIG5l
ZWRzIHRvIGNvdW50IGV2ZW50cyBhbmQgb25lIGNhbm5vdCBkbyBpdCB3aXRob3V0CmF0b21pYyBp
bmNyZW1lbnQuIEV2ZW50dWFsbHkgcGVyLWNwdSBtYXBzIHdlcmUgYWRkZWQgYXMgYW4gYWx0ZXJu
YXRpdmUuCkkgc3VzcGVjdCBhbnkgcGxhdGZvcm0gdGhhdCBzdXBwb3J0cyAjMSBiYXNpYyBpbnNu
IHdpdGhvdXQKYXRvbWljX2FkZCB3aWxsIG5vdCBiZSBwcmFjdGljYWxseSB1c2VmdWwuClNob3Vs
ZCBhdG9taWNfYWRkIGJlIGEgcGFydCBvZiAiYmFzaWMiIHRoZW4/IEJ1dCBpdCdzIGF0b21pYy4K
VGhlbiB3aGF0IGFib3V0IGF0b21pY19mZXRjaF9hZGQgaW5zbj8gSXQncyBwcmV0dHkgY2xvc2Ug
c2VtYW50aWNhbGx5LgpQYXJ0IG9mIGF0b21pYyBvciBwYXJ0IG9mIGJhc2ljPwoKQW5vdGhlciBl
eGFtcGxlLCAjMyBkaXZpZGUuIGJwZiBjcHU9djEgSVNBIG9ubHkgaGFzIHVuc2lnbmVkIGRpdi9t
b2QuCkV2ZW50dWFsbHkgd2UgYWRkZWQgYSBzaWduZWQgdmVyc2lvbi4gSW50ZWdlciBkaXZpc2lv
biBpcyBvbmUgb2YgdGhlCnNsb3dlc3Qgb3BlcmF0aW9ucyBpbiBhIEhXLiBEaWZmZXJlbnQgY3B1
cyBoYXZlIGRpZmZlcmVudCBmbGF2b3JzCm9mIHRoZW0gNjQvMzIgNjQvNjQgMzIvMzIsIGV0Yy4g
QWxsIHdpdGggZGlmZmVyZW50IHF1aXJrcy4KY3B1PXYxIGhhZCBtb2R1bG8gaW5zbiBiZWNhdXNl
IGluIHRyYWNpbmcgb25lIG9mdGVuIG5lZWRzIHRvIGRvIGl0CnRvIHNlbGVjdCBhIHNsb3QgaW4g
YSB0YWJsZSwgYnV0IGluIG5ldHdvcmtpbmcgdGhlcmUgaXMgcmFyZWx5IGEgbmVlZC4KU28gYnBm
IG9mZmxvYWQgaW50byBuZXRyb25vbWUgSFcgZG9lc24ndCBzdXBwb3J0IGl0IChpaXJjKS4KU2hv
dWxkIGRpdi9tb2Qgc2lnbmVkL3Vuc2lnbmVkIGJlIGEgcGFydCBvZiBiYXNpYz8gb3Igc2VwYXJh
dGU/Ck9ubHkgMzIgb3IgNjQgYml0PwoKSGVuY2UgbXkgcG9pbnQ6IGxlZ2FjeSBhbmQgdGhlIHJl
c3QgKGFzIG9mIGNwdT12NCkgYXJlIHRoZSBvbmx5IHR3byBjYXRlZ29yaWVzCndlIHNob3VsZCBo
YXZlIGluIF90aGlzXyB2ZXJzaW9uIG9mIHRoZSBzdGFuZGFyZC4KUmVzdCBhc3N1cmVkIHdlIHdp
bGwgYWRkIG5ldyBpbnNuIGluIHRoZSBjb21pbmcgbW9udGhzLgpJIHN1Z2dlc3Qgd2UgZmlndXJl
IG91dCBjb25mb3JtYW5jZSBncm91cHMgZm9yIGZ1dHVyZSBpbnNucyBhdCB0aGF0IHRpbWUuClRo
YXQgd291bGQgYmUgdGhlIHRpbWUgdG8gYXJndWUgYW5kIGFjdHVhbGx5IGV4dHJhY3QgdmFsdWUg
b3V0IG9mIGRpc2N1c3Npb24uClJldHJvYWN0aXZlIGJpa2Ugc2hlZGRpbmcgaXMgYSBiaWtlIHNo
ZWRkaW5nIGFuZCBub3RoaW5nIGVsc2UuCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5v
cmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

