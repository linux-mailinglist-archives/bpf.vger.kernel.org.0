Return-Path: <bpf+bounces-30632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222F8CF870
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 06:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FC01F21835
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 04:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198DF79F6;
	Mon, 27 May 2024 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="H85thks/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GowJ33De";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fOmyqZV/"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9146D266
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784629; cv=none; b=C223JncwOGK/T0VCAWBMvvVD9VE7bbaVF5Gzt2i5S6vNdCAPyyWLdS4tWCaPvoLCmR393WsfhF8bvXuK8RI42ojA8JjccDq0HburPzkwIy3qlpMcWlUlpkbjMPqYDSGKUgzWhmPYWQN7b3/7u+hthKKtR5yQ9JzPP050OfN/Csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784629; c=relaxed/simple;
	bh=rvpDz8Ry6O0wXYUOpU7Ewyk2Z70MXJ/AAKofaz4/B54=;
	h=Date:To:Message-ID:References:MIME-Version:Content-Disposition:
	 In-Reply-To:CC:Subject:Content-Type:From; b=sDK7JWxbf3taM/rRgrZjzWmBCOFEiPdoJ0cvSgVz0DwWDy21heue53h/zYta+dni8xGrj8nBStKfCSPszGno/9nijUImTjhfHGzjJ9RkrKdrSfVpoi4JNKXgUgKVVhVlESC+7JWBbq8QHmNPrtT+OLsJzdeBQUlJQOAVY3lw+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=H85thks/; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GowJ33De reason="signature verification failed"; dkim=fail (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fOmyqZV/ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C0D4FC1519B3
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 21:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716784621; bh=rvpDz8Ry6O0wXYUOpU7Ewyk2Z70MXJ/AAKofaz4/B54=;
	h=Date:To:References:In-Reply-To:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=H85thks/bvCdN3njRJZUtptTpRnSYuaxMVP/UH29jc0BFINAnrKatVEUWZGFaxIWl
	 BB7Mix37ntaF9Zlos2p1z18/ebB7zimDP1HiOzcqnQMf4zLMN2U7i5+tJl5fczyAlN
	 Sn/XajAiInA7g9+B78CzwDbpZAdmOGjpbeyfvdN0=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id AF768C151986
 for <bpf@vger.kernel.org>; Sun, 26 May 2024 21:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1716784621; bh=rvpDz8Ry6O0wXYUOpU7Ewyk2Z70MXJ/AAKofaz4/B54=;
 h=Date:From:To:References:In-Reply-To:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=GowJ33De5UAFeqP8gVRjXtGDApI6YOZOls2/LHL+dBnzKgutUzvT27qvZeCFzWKq5
 DNkNY9qSVRL3/hR9XeLyXirKkMqPzcLW6wVrkoRflB+DIR0Ld6eIZPkracAgB54+oA
 pJ5BkHj5850sQriJSy/8uOsoCl02nZyJ11DxEJ64=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C7816C15109C
 for <bpf@ietfa.amsl.com>; Sun, 26 May 2024 21:36:56 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=suse.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nIguVTFcbH1J for <bpf@ietfa.amsl.com>;
 Sun, 26 May 2024 21:36:52 -0700 (PDT)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 78278C14F6BB
 for <bpf@ietf.org>; Sun, 26 May 2024 21:36:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e96f298fbdso16876001fa.1
 for <bpf@ietf.org>; Sun, 26 May 2024 21:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716784610; x=1717389410; darn=ietf.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=llk8LuZ9hrKrtnYl1E0Es8w0gMe+Gg2swe3Lwr5IB98=;
 b=fOmyqZV/w5WiYNuleEu4JzSw0zbsXMf2r+1e3EgNNfZf6etG/NeE4PWKMji44UbS4R
 rKpjTKr3MioJAqdgWTYXMMj55LJsHs6atN8CEZP2rq6E2S5aMaIOED25HYX9Pr89Fzga
 3GdDFpAfEfqlO2EHpmG2okgJyEydd+EAX/5fTo3QXg6XM0r4T4ruT2RZnbb9Ewyf5D+o
 1311Y0xmAPtdRN5ZpUZ3PQsoNAfkL5U93bjg5XefWTdB4Z/PZq6zsjFKUXAKAJkgbQ0d
 pxOaOJXfTgHI24893mBekfMkTbU2An6dDBY/bEc9bICjhpu2q8aGuFD24cb+FlzXhDcU
 ei3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716784610; x=1717389410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llk8LuZ9hrKrtnYl1E0Es8w0gMe+Gg2swe3Lwr5IB98=;
 b=h0xVoK1xnO/cIGCMku2rNhN0AZRZQKsgALh36OYZ1g72AcHqzp81RK7nZaajtAwRGt
 egBjHS513CXQJ4uj50ABvrzj3uIK9wDWR0O6Ix2PIk4wvRlt5tftm21IMDKo/A3uvdYo
 1eiZPgaIWDjB29wa1U8QM7otkV8+15bVYFGw4sm6J0S3qZ2bO19xxHDbDUcGiYabVw/q
 51LbH1VVdEAbmv/ds/IzouKjDRjW4yj+kjE7oyzcDs5uk60CxNBNzq7QdxB6QWlUEAXT
 zTt+8iNuUcndVfonvVFcod+bKEPqR1SAtXxjgSHrxxnEUgh/O9bm3c93pM15et03AfhK
 1hxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDENo5H5AWRd6HOqMp403teIPECZynrAbh8TVKWAenF6icZ0FyNItdDqvMrW7+iITAIQtfT1DBpzY7xSw=
X-Gm-Message-State: AOJu0YxwAuTmVl43tvX2KQohhCu705OEvOI5PCjPrH2WASNeR8QNKCr5
 eWpwdFs7BCNEJF2M8P66CA2mWCnmk7UaaoQPNN6HDgZRFC0hRLo0Nm238WCbUmk=
X-Google-Smtp-Source: AGHT+IHGrIZy3/KYewvki8KYVClJkZdPoZ0Zqe/hgfLYGvefGRlmAI1yAFh9lCU8w+WyS2OqzBx3uQ==
X-Received: by 2002:a2e:a289:0:b0:2e4:7996:f9f0 with SMTP id
 38308e7fff4ca-2e95b0c0f7dmr46267161fa.17.1716784609992;
 Sun, 26 May 2024 21:36:49 -0700 (PDT)
Received: from u94a (106-64-120-248.adsl.fetnet.net. [106.64.120.248])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7e9062a7ea1sm151112339f.47.2024.05.26.21.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 21:36:49 -0700 (PDT)
Date: Mon, 27 May 2024 12:36:43 +0800
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Message-ID: <ktzwr2mxzqcjg4wvxwenpwh5yq5brvbd2u3zhbopx67nes76k7@durfvo77a2ty>
References: <20240517153445.3914-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240517153445.3914-1-dthaler1968@gmail.com>
Message-ID-Hash: ZUZT5WYNVMEK2WFO3NMAQTBTQ7HQWP24
X-Message-ID-Hash: ZUZT5WYNVMEK2WFO3NMAQTBTQ7HQWP24
X-MailFrom: shung-hsi.yu@suse.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_Move_sentence_?=
 =?utf-8?q?about_returning_R0_to_abi=2Erst?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zq4CO2FMYumvwsQMqQCvtW1CIHU>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
From: Shung-Hsi Yu <shung-hsi.yu=40suse.com@dmarc.ietf.org>

T24gRnJpLCBNYXkgMTcsIDIwMjQgYXQgMDg6MzQ6NDVBTSBHTVQsIERhdmUgVGhhbGVyIHdyb3Rl
Og0KPiBBcyBkaXNjdXNzZWQgYXQgTFNGL01NL0JQRiwgdGhlIHNlbnRlbmNlIGFib3V0IHVzaW5n
IFIwIGZvciByZXR1cm5pbmcNCj4gdmFsdWVzIGZyb20gY2FsbHMgaXMgcGFydCBvZiB0aGUgY2Fs
bGluZyBjb252ZW50aW9uIGFuZCBiZWxvbmdzIGluDQo+IGFiaS5yc3QuICBBbnkgZnVydGhlciBh
ZGRpdGlvbnMgb3IgY2xhcmlmaWNhdGlvbnMgdG8gdGhpcyB0ZXh0IGFyZSBsZWZ0DQo+IGZvciBm
dXR1cmUgcGF0Y2hlcyBvbiBhYmkucnN0LiAgVGhlIGN1cnJlbnQgcGF0Y2ggaXMgc2ltcGx5IHRv
IHVuYmxvY2sNCj4gcHJvZ3Jlc3Npb24gb2YgaW5zdHJ1Y3Rpb24tc2V0LnJzdCB0byBhIHN0YW5k
YXJkLg0KPiANCj4gSW4gY29udHJhc3QsIHRoZSByZXN0cmljdGlvbiBvZiByZWdpc3RlciBudW1i
ZXJzIHRvIHRoZSByYW5nZSAwLTEwDQo+IGlzIHVudG91Y2hlZCwgbGVmdCBpbiB0aGUgaW5zdHJ1
Y3Rpb24tc2V0LnJzdCBkZWZpbml0aW9uIG9mIHRoZQ0KPiBzcmNfcmVnIGFuZCBkc3RfcmVnIGZp
ZWxkcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2OEBnb29n
bGVtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFNodW5nLUhzaSBZdSA8c2h1bmctaHNpLnl1QHN1c2Uu
Y29tPg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJzY3Jp
YmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

