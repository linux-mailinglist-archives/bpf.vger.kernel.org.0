Return-Path: <bpf+bounces-18325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E436818F7E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB41F27836
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501A3DBB2;
	Tue, 19 Dec 2023 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Ie62YhTB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="DS46kd9F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IOZXh9LJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3FE39854
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 22D83C0900B8
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1703009417; bh=dcVferCkA9mQnh8F9HwiGtfSarpNqrHN5HC4EVS89zE=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ie62YhTB1Qxec7vSzcXFnu5C90vd3l2GO5XzrLUvXZ6ss5Sg7D5EdytNVo8THSWfp
	 VwzP8BbiqXIp+DiMLNFHUIyEAwsOekte23H7tj7cT6bJOq0IgSxUWB+NPsIL1SQqzn
	 E9WqA1YZwn+z/Dd+RaoA3Rn++um0tVyNEwctk9o8=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 03E9EC090387;
 Tue, 19 Dec 2023 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1703009417; bh=dcVferCkA9mQnh8F9HwiGtfSarpNqrHN5HC4EVS89zE=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=DS46kd9FqNo+LpMewetRiCgERnFURuYQ3MGx+fJhCfvNTJXsahmYAFXFdHMkduaz2
 pG0UIiLD6RxdtFqJdY2MdiV7BTVaQSzDsxF0+8NFyxY9d/pzwJbzfAd6nvI7EvUq8a
 mdiY4RNaj1FWnWCwhcGNmdqEGhdbbcuXjvVWAfSU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 37D8CC09037C
 for <bpf@ietfa.amsl.com>; Tue, 19 Dec 2023 10:10:15 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Loj4q0WUmx_7 for <bpf@ietfa.amsl.com>;
 Tue, 19 Dec 2023 10:10:11 -0800 (PST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1ADBFC1AE97F
 for <bpf@ietf.org>; Tue, 19 Dec 2023 10:10:11 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7b71d65021dso115574239f.1
 for <bpf@ietf.org>; Tue, 19 Dec 2023 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1703009410; x=1703614210; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lMm17hdBABlvAAX+Jp30S5DFYwbSvzQKlSkr+nKcGZk=;
 b=IOZXh9LJwzxt1qeiubSao2hLa83Xz/cPhVS9gGUwu7D5FoqjV1engij1VhITdX/Ope
 ZYkz4TRA5EeNPTQ2ObCUVo4/kdPY3WKPwMYjW6ADeintSs2ZZXyOf0VpMh5cMNU3zXep
 6Az9Mg0hUkI9u+LVGt+jYORYhUfc8OU+BuDM2ErMAoD4bE1Shrdbk74xTZljYhOdAJFF
 XADq7bsqJAraGv/qIeSZmhx8LvyC9QjEzKk/ucOXv2dyebgu2d3JSZLym2ojSQlyFpTP
 bT+QNQ4Xg7kAQ4jD+U5U6xq4E7wmWrg/Uwhfi3NwjR9IxBCx004SU3kUjdvBQ9Kc4xDR
 Ogxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703009410; x=1703614210;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMm17hdBABlvAAX+Jp30S5DFYwbSvzQKlSkr+nKcGZk=;
 b=UBKFd8eea/FDHS2aV9RhY9XuEzE9bNACc+wkO05psJAZdg7dEH545d2TSG4L+eLqJi
 FiGF+KQqXUSCxMZaT75RUlf/EivbnKWhuC6qLVSkZcPHmxJu4jhwH6A42bswKmyt5dbe
 1ivnXrzo16azqsbqM7L36+z4FXeKggi2AjLIIxpYlIWUD7ceq3TvxhhNO7rzxoBtq7t/
 bqu2nhhZxvrceKtglgcT1UdVDkkwvZN5vYfz+2enXgMtuWprL9CzXcsfjAbuhkYRAfxM
 DXpKYKzfoGBxsOj+WF42Lj0wPRq18cGC5gTqUdlQOdCYbrsuK/Q4uuEHYPQJnVkDdLlD
 p9Yg==
X-Gm-Message-State: AOJu0YyBzAgNYL9SvrnfPfI7JxZZ8AFxvxahdPpcVeWNY+1EqQFnyAKf
 S8R7BrA0PKDR8ZWCkQ3eWmc=
X-Google-Smtp-Source: AGHT+IEhQqJUfiNDfm9kkCk4z2PTctMDc+zGKUmjHSgfspNLWEtaSnc0LKSN7fA9oImITrwb0j5S2Q==
X-Received: by 2002:a5e:df06:0:b0:7b4:37db:9fe1 with SMTP id
 f6-20020a5edf06000000b007b437db9fe1mr1406301ioq.10.1703009409844; 
 Tue, 19 Dec 2023 10:10:09 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 f9-20020a05660215c900b007b34b18c31esm6671939iow.50.2023.12.19.10.10.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Dec 2023 10:10:09 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
 "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'David Vernet'" <void@manifault.com>, <bpf@ietf.org>,
 "'bpf'" <bpf@vger.kernel.org>, "'Jakub Kicinski'" <kuba@kernel.org>
References: <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
In-Reply-To: <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
Date: Tue, 19 Dec 2023 10:10:07 -0800
Message-ID: <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKoHfZj5uHVGAGiwHvRzOg12FLYygKw8KxkAzczMysBTloCHQIk6QWGAWJPEj4BybpNsgH6K/FdAa4N7FEApYq+pQJboihlAe8iqfCubA4ykA==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/gAncazeBhcUxHHf_o5l3Hu3niJ4>
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
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEFsZXhlaSBTdGFyb3ZvaXRvdiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDE4
LCAyMDIzIDU6MTUgUE0KPiBUbzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3Jn
Pgo+IENjOiBEYXZpZCBWZXJuZXQgPHZvaWRAbWFuaWZhdWx0LmNvbT47IERhdmUgVGhhbGVyCj4g
PGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tPjsgYnBmQGlldGYub3JnOyBicGYgPGJwZkB2Z2Vy
Lmtlcm5lbC5vcmc+Owo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Cj4gU3ViamVj
dDogUmU6IFtCcGZdIEJQRiBJU0EgY29uZm9ybWFuY2UgZ3JvdXBzCj4gCj4gT24gVGh1LCBEZWMg
MTQsIDIwMjMgYXQgOToyOeKAr1BNIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9y
Zz4KPiB3cm90ZToKPiA+Cj4gPiBXZSBuZWVkIHRoZSBjb25jZXB0IGluIHRoZSBzcGVjIGp1c3Qg
dG8gYWxsb3cgZnV0dXJlIGV4dGVuc2FiaWxpdHkuCj4gCj4gQ29tcGxldGVseSBhZ3JlZSB0aGF0
IHRoZSBjb25jZXB0IG9mIHRoZSBncm91cHMgaXMgbmVjZXNzYXJ5Lgo+IAo+IEknbSBhcmd1aW5n
IHRoYXQgd2hhdCB3YXMgcHJvcG9zZWQ6Cj4gMS4gImJhc2ljIjogYWxsIGluc3RydWN0aW9ucyBu
b3QgY292ZXJlZCBieSBhbm90aGVyIGdyb3VwIGJlbG93Lgo+IDIuICJhdG9taWMiOiBhbGwgQXRv
bWljIG9wZXJhdGlvbnMuCj4gMy4gImRpdmlkZSI6IGFsbCBkaXZpc2lvbiBhbmQgbW9kdWxvIG9w
ZXJhdGlvbnMuCj4gNC4gImxlZ2FjeSI6IGFsbCBsZWdhY3kgcGFja2V0IGFjY2VzcyBpbnN0cnVj
dGlvbnMgKGRlcHJlY2F0ZWQpLgo+IDUuICJtYXAiOiA2NC1iaXQgaW1tZWRpYXRlIGluc3RydWN0
aW9ucyB0aGF0IGRlYWwgd2l0aCBtYXAgZmRzIG9yIG1hcAo+IGluZGljZXMuCj4gNi4gImNvZGUi
OiA2NC1iaXQgaW1tZWRpYXRlIGluc3RydWN0aW9uIHRoYXQgaGFzIGEgImNvZGUgcG9pbnRlciIg
dHlwZS4KPiA3LiAiZnVuYyI6IHByb2dyYW0tbG9jYWwgZnVuY3Rpb25zLgo+IAo+IGxvZ2ljYWxs
eSBtYWtlcyBzZW5zZSwgYnV0IG1pZ2h0IG5vdCB3b3JrIGZvciBIVyAoYmFzZWQgb24gdGhlIGhp
c3Rvcnkgb2YgbmZwCj4gb2ZmbG9hZCkuCj4gaW1vICJiYXNpYyIgYW5kICJsZWdhY3kiIHdvbid0
IHdvcmsgZWl0aGVyLgo+IFNvIGl0J3MgYSBsZXNzZXIgZXZpbC4KPiAKPiBBbnl3YXksIGxldCdz
IGxvb2sgYXQ6Cj4gCj4gICAgfCBCUEZfQ0FMTCB8IDB4OCAgIHwgMHgwIHwgY2FsbCBoZWxwZXIg
ICAgICAgICB8IHNlZSBIZWxwZXIgICAgICAgIHwKPiAgICB8ICAgICAgICAgIHwgICAgICAgfCAg
ICAgfCBmdW5jdGlvbiBieSBhZGRyZXNzIHwgZnVuY3Rpb25zICAgICAgICAgfAo+ICAgIHwgICAg
ICAgICAgfCAgICAgICB8ICAgICB8ICAgICAgICAgICAgICAgICAgICAgfCAoU2VjdGlvbiAzLjMu
MSkgICB8Cj4gICAgKy0tLS0tLS0tLS0rLS0tLS0tLSstLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiAgICB8IEJQRl9DQUxMIHwgMHg4ICAgfCAweDEgfCBj
YWxsIFBDICs9IGltbSAgICAgIHwgc2VlIFByb2dyYW0tbG9jYWwgfAo+ICAgIHwgICAgICAgICAg
fCAgICAgICB8ICAgICB8ICAgICAgICAgICAgICAgICAgICAgfCBmdW5jdGlvbnMgICAgICAgICB8
Cj4gICAgfCAgICAgICAgICB8ICAgICAgIHwgICAgIHwgICAgICAgICAgICAgICAgICAgICB8IChT
ZWN0aW9uIDMuMy4yKSAgIHwKPiAgICArLS0tLS0tLS0tLSstLS0tLS0tKy0tLS0tKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tKwo+ICAgIHwgQlBGX0NBTEwgfCAweDgg
ICB8IDB4MiB8IGNhbGwgaGVscGVyICAgICAgICAgfCBzZWUgSGVscGVyICAgICAgICB8Cj4gICAg
fCAgICAgICAgICB8ICAgICAgIHwgICAgIHwgZnVuY3Rpb24gYnkgQlRGIElEICB8IGZ1bmN0aW9u
cyAgICAgICAgIHwKPiAgICB8ICAgICAgICAgIHwgICAgICAgfCAgICAgfCAgICAgICAgICAgICAg
ICAgICAgIHwgKFNlY3Rpb24gMy4zLgo+IAo+IEhhdmluZyBzZXBhcmF0ZSBjYXRlZ29yeSA3IGZv
ciBzaW5nbGUgaW5zbiBCUEZfQ0FMTCAweDggMHgxIHdoaWxlIGtlZXBpbmcgMHg4Cj4gMHgwIGFu
ZCAweDggMHgyIGluICJiYXNpYyIgc2VlbXMganVzdCBhcyBsb2dpY2FsIGFzIGhhdmluZyBhdG9t
aWNfYWRkIGluc24gaW4KPiAiYmFzaWMiIGluc3RlYWQgb2YgImF0b21pYyIuCgpJZiBhIHBsYXRm
b3JtIGV4cG9zZXMgbm8gaGVscGVyIGZ1bmN0aW9ucywgdGhlbiAweDggMHgwIGFuZCAweDggMHgy
IGhhdmUgbm8KbWVhbmluZyBhbmQgaW4gbXkgdmlldyBkb24ndCBuZWVkIGEgc2VwYXJhdGUgY29u
Zm9ybWFuY2UgZ3JvdXAgc2luY2UgYQpwcm9ncmFtIHVzaW5nIHRoZW0gd291bGQgZmFpbCB0aGUg
dmVyaWZpZXIgYW55d2F5LgoKMHg4IDB4MSBvbiB0aGUgb3RoZXIgaGFuZCB3b3VsZG4ndCBiZSBp
bnZhbGlkIGp1c3QgZHVlIHRvIHRoZSBpbW0gdmFsdWUsCmFuZCBzbyB0b29scyAoY29tcGlsZXIs
IHZlcmlmaWVyLCB3aGF0ZXZlcikgbmVlZCBzb21lIG90aGVyIHdheSB0byBrbm93IHdoZXRoZXIK
aXQncyBzdXBwb3J0ZWQsIGhlbmNlIHRoZSBjb25mb3JtYW5jZSBncm91cC4KCj4gVGhlbiB3ZSBo
YXZlIHNldmVyYWwga2luZHMgb2YgbGRfaW1tNjQuIFNvdW5kcyBsaWtlIHRoZSBpZGVhIGlzIHRv
IHNwbGl0IDB4MTgKPiAweDQgaW50byAiY29kZSIgYW5kIHRoZSByZXN0IGludG8gIm1hcCIgZ3Jv
dXA/Cj4gSXMgaXQgbG9naWNhbCBvciBub3Q/CgpJIGRvbid0IGtub3cgb2YgYW5vdGhlciBlYXN5
IHdheSBmb3IgYSB0b29sIGxpa2UgYSBjb21waWxlciAoTExWTSwgZ2NjLCBydXN0IGNvbXBpbGVy
LApldGMuKSB0byBrbm93IHdoZXRoZXIgbWFwIGluc3RydWN0aW9ucyBhcmUgbGVnYWwgb3Igbm90
LiAgCgpUaGF0IHNhaWQsIEkgdGhpbmsgbWFwX3ZhbCgpIGlzIHByb2JsZW1hdGljIGZvciBhIGNy
b3NzLXBsYXRmb3JtIGNvbXBpbGVyLi4uCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L2xhdGVzdC9zb3VyY2UvRG9jdW1lbnRhdGlvbi9icGYvbGludXgtbm90ZXMucnN0IHNheXMKIkxp
bnV4IG9ubHkgc3VwcG9ydHMgdGhlICdtYXBfdmFsKG1hcCknIG9wZXJhdGlvbiBvbiBhcnJheSBt
YXBzIHdpdGggYSBzaW5nbGUgZWxlbWVudC4iCk5vdyBpZiBvbmUgcGxhdGZvcm0gc3VwcG9ydHMg
aXQgb24gb25lIHR5cGUgb2YgbWFwIGFuZCBhbm90aGVyIHBsYXRmb3JtIGRvZXNuJ3QsIHRoZW4K
dGhlIGNvbXBpbGVyIGhhcyB0byBtYWdpY2FsbHkga25vdyB3aGV0aGVyIHRvIGFsbG93IHRoaXMg
b3B0aW1pemF0aW9uIChjb21wYXJlZCB0bwpyZXF1aXJpbmcgdXNpbmcgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gYWNjZXNzIHRoZSBtYXAgdmFsdWUpIG9yIG5vdC4KCj4gTWF5YmUgd2Ugc2hvdWxkIGRv
IHJpc2MtdiBsaWtlIGdyb3VwIGluc3RlYWQ/Cj4gSnVzdCB0aGVzZSA0Ogo+IC0gQmFzZSBJbnRl
Z2VyIEluc3RydWN0aW9uIFNldCwgMzItYml0Cj4gLSBCYXNlIEludGVnZXIgSW5zdHJ1Y3Rpb24g
U2V0LCA2NC1iaXQKCklmIHRoZXJlJ3MgcGxhdGZvcm1zIHRoYXQgd291bGQgc3VwcG9ydCBvbmUg
b2YgdGhlIGFib3ZlIGFuZCBub3QgdGhlIG90aGVyCihhcmUgdGhlcmU/KSB0aGVuIEkgYWdyZWUg
c3BsaXR0aW5nIHRoZW0gd291bGQgbWFrZSBzZW5zZS4KCj4gLSBJbnRlZ2VyIE11bHRpcGxpY2F0
aW9uIGFuZCBEaXZpc2lvbgo+IC0gQXRvbWljIEluc3RydWN0aW9ucwo+IAo+IEFuZCB0aGF0J3Mg
aXQuIFRoZSByZXN0IG9mIHJpc2MtdiBncm91cHMgaGF2ZSBubyBlcXVpdmFsZW50IGluIGJwZiBp
c2EuCgpEYXZlCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cu
aWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

