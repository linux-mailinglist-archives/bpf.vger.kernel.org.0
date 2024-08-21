Return-Path: <bpf+bounces-37665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A0959238
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 03:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855B61F22C44
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 01:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B964D112;
	Wed, 21 Aug 2024 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEBd/c/e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578D4503C;
	Wed, 21 Aug 2024 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203999; cv=none; b=qvfR7Wx2ZkVH9URcpTG3tvcmHqiRNy4c1cCFMrOOFfg/OXpGEh3j3pVr73kY2Vz08Byr05SSGbt0UhwOM4Z6pyVis3EEJsghYNiNvoDFzWH6Nu6obAEu9brfSyMo9jcyb5vqSXZC3l+zvFrKKI+KCEctwf5dNvuSokIpVVKL0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203999; c=relaxed/simple;
	bh=TVozaWtR1PMKJJ2DJx8WYtFk8+BhPIloZFUmV+h063U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lMaLfI8lcebVA2i7d5TYWFIR/X3iHl23K1B6PQC8EDjuHmbxqHtnz89foNUxTqJ9REXmPj5vwodvzHu1XJ1BczjNDNXkgk+Md4lwk9yZKr8AkUJcMcy2hBfdzTfe6pIFSRn1Y0EeVtSITq4OGGVMCRt56p7avyNlVz4CZQ4jRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEBd/c/e; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5d077c60aso3338874eaf.1;
        Tue, 20 Aug 2024 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724203997; x=1724808797; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TVozaWtR1PMKJJ2DJx8WYtFk8+BhPIloZFUmV+h063U=;
        b=KEBd/c/es2mY8nFm6aMknqStupG+7sb5EtSyKosUTkSrkGvFEcPivbIjVqfDqQjejR
         6s70fSpdZqetVC/6mzJ76wRqPm7czxKLOUKEjhkf+nJjkal6NQacn2yPSmSejyflX0Q8
         dNJYaRRcN3O4pz8X8visKnX2nU9RxDEE+1BtpH4iIkHu68Q8JIcnaiVpPTkqBkqeCE5e
         kdO+0EwLaYXR6JgNElVTWrwTWu89RjwF/Yso1tevn66YgVMRZ1D5kNGnl0xupp/wWzKU
         M81Y5lx/INmp5HXSTUgMlwKGe0aXkkMBDOYMNKebrhC7z1W+xRdY1yWSBCej77zntd2H
         wvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724203997; x=1724808797;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVozaWtR1PMKJJ2DJx8WYtFk8+BhPIloZFUmV+h063U=;
        b=pYNQ8g183FCsHKRl3giLfpRlqNtCRTsZP8sVJnIWCMYSH67b45tHNYWnX85kbn4k6s
         Eh8ch2U4a0DjwKm8WziUGVUPWT8F4x5cf5Wqk3NT/Nh1HPYwlwzLybJygYyxph6CuC3u
         XCO/iUOky9ue4ry+0ony0Urp3WrY0i2g8bXvAeI7yQCfqRMEY0bKXSzY2Jw86BSWYKKo
         UTz52QYrybSNbAAY6cT/V6QhIuoXPjPjmjopKsJwMbQ+2KtZEAIlHnatt68KRuh0+3on
         Rckw5lYrHDyHkaljwzjP4K/9FmUJe2hQbUFivKZ0S4oZ3zGizoEq02pgVHGgt/6T4iAR
         qn4A==
X-Forwarded-Encrypted: i=1; AJvYcCWB1dD6AJn1bL3dly35WvEaGeabU7xHlkCoXq2KcyBPiMTf1cNNpQNs4I1ET9oZDYq0laAt5z83@vger.kernel.org, AJvYcCX2pmV2V/2RdR4PZ9RNP7wJRutbfWCcjLJAfo5d7ctIbALnNCWjSltcvb6M7erFGQlloic=@vger.kernel.org, AJvYcCXeWKvKhucF9qDRFuxMKmtrhAhd9DRrO8+QbEou5Yb158nlkGTrfPoET9l4prxaNEfrJ8+20Nm0dq1y2QXB@vger.kernel.org
X-Gm-Message-State: AOJu0YypHKDH4wu3Gq+GEIYphhU7CROkjOoJSxL4UAd7JnxpQbTSQowK
	cdmDzB7EK6cD5kp/zCxNAFdTT7eQlHwhm9bkW8o/FraX4bEUMkIVsrzlOOJX
X-Google-Smtp-Source: AGHT+IE1kzwvIGqsTUReVp+W70RugwByu2Io0zMFp8r1glHtNYXZClYMXgt3mQ/S3Og1YfGV/mOO4Q==
X-Received: by 2002:a05:6358:8096:b0:1ac:ed54:224d with SMTP id e5c5f4694b2df-1b5a287043fmr65787955d.11.1724203996707;
        Tue, 20 Aug 2024 18:33:16 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af18937sm8853894b3a.150.2024.08.20.18.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 18:33:16 -0700 (PDT)
Message-ID: <badd583d09868ffdd48a97c727680ca6f5699727.camel@gmail.com>
Subject: Re: KASAN: null-ptr-deref in bpf_core_calc_relo_insn
From: Eduard Zingerman <eddyz87@gmail.com>
To: Liu RuiTong <cnitlrt@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 20 Aug 2024 18:33:11 -0700
In-Reply-To: <CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com>
References: 
	<CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE3OjIxICswODAwLCBMaXUgUnVpVG9uZyB3cm90ZToKClsu
Li5dCgo+IGJwZl9jb3JlX2NhbGNfcmVsb19pbnNuKzMxMSAgICAgICAgICAgIDxicGZfY29yZV9j
YWxjX3JlbG9faW5zbiszMTE+Cj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSAWwo+IFNPVVJDRSAoQ09ERSkgXeKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAo+IEluIGZpbGU6IC9ob21lL3VidW50dS9m
dXp6L2xpbnV4LTYuMTEtcmM0L3Rvb2xzL2xpYi9icGYvcmVsb19jb3JlLmM6MTMwMAo+ICAgIDEy
OTUgICAgICAgICBjaGFyIHNwZWNfYnVmWzI1Nl07Cj4gICAgMTI5NiAgICAgICAgIGludCBpLCBq
LCBlcnI7Cj4gICAgMTI5Nwo+ICAgIDEyOTggICAgICAgICBsb2NhbF9pZCA9IHJlbG8tPnR5cGVf
aWQ7Cj4gICAgMTI5OSAgICAgICAgIGxvY2FsX3R5cGUgPSBidGZfdHlwZV9ieV9pZChsb2NhbF9i
dGYsIGxvY2FsX2lkKTsKPiAg4pa6IDEzMDAgICAgICAgICBsb2NhbF9uYW1lID0gYnRmX19uYW1l
X2J5X29mZnNldChsb2NhbF9idGYsCj4gbG9jYWxfdHlwZS0+bmFtZV9vZmYpOwoKSGkgTGl1LAoK
VGhhbmsgeW91IGZvciB0aGUgcmVwb3J0LCBJIGNhbiByZXByb2R1Y2UgdGhlIGlzc3VlLgpXaWxs
IGNvbW1lbnQgbGF0ZXIgdG9kYXkuCgo+ICAgIDEzMDEgICAgICAgICBpZiAoIWxvY2FsX25hbWUp
Cj4gICAgMTMwMiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gICAgMTMwMwo+ICAg
IDEzMDQgICAgICAgICBlcnIgPSBicGZfY29yZV9wYXJzZV9zcGVjKHByb2dfbmFtZSwgbG9jYWxf
YnRmLCByZWxvLAo+IGxvY2FsX3NwZWMpOwo+ICAgIDEzMDUgICAgICAgICBpZiAoZXJyKSB7Cj4g
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSAWwo+IFNUQUNLIF3ilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIAKPiBgYGAKCgo=


