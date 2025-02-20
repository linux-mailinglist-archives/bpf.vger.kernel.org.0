Return-Path: <bpf+bounces-52102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F1A3E67C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 22:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF77F42177D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 21:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CA1EB1AA;
	Thu, 20 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjnGh7+O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1E1B4247
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086457; cv=none; b=Eu/R8FVlxVzCC6nHtUSXkmdeGkbTx0d4vTfuAFtqIpPPV0GV4+TYKtbdCdOn9c4sMR+uAxBGEwOeJ6ChvHUfpTIP8KbV3GvND05ZIJhUwwrNoJCY0hQ2D1UelDgJbpkdwhSn8lR40uAzifn7BTcj1Pi2O5TQYFT6ySgKuXNPOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086457; c=relaxed/simple;
	bh=IR/0SQT6N2jBZfpGVxRUgysysr5LWUwuEE0/uWu45cU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g4Qu2O9kXaDJBM+ool0Jrvk/E38pgdA+/O4h5t84j98PLAQf6l6dSUbwslrVihU7kxnhnjKFGOGcn3dqtFTnehQL6j0IC6qnVNt29svs+ytm3MlpQVil+n0QwNxlt2nTkJpMCuObKXKySv0dLNdt4U+0w2Fi90m5nS/fcfXAoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjnGh7+O; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so2900876a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 13:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740086456; x=1740691256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR/0SQT6N2jBZfpGVxRUgysysr5LWUwuEE0/uWu45cU=;
        b=TjnGh7+Oulkpdn99a3jMPc8CdC7i+FMXDV/dc5eg5Dh6gKV/fHUkuAHb5N/rM4FwIV
         6+XQ+d8Kl7f5HL0ucOhgLD6XZW8XAM6IjJDJIfwzW1lop3z3MwUw0zwULmOIJqg1DMq/
         ZgcMoj2aCZiffpJMlG8GMCBgAUh1aNYZrj38MDh4HY1/iw9ZMJGMjfN2a4NS2TZ+fS6m
         0U3YTEODLwhJ4Nzx4z5jDPx6FQH/Sh+/SgvvTsFg6XSEbonVOnSwSQGo2BkHtl/yfot+
         98UASiLMQ4J96qUPUK5aBsKeB19lbOKitQboY+IH5LiNdqR01Ij4kiNLrujPC3o8HGrQ
         zurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086456; x=1740691256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IR/0SQT6N2jBZfpGVxRUgysysr5LWUwuEE0/uWu45cU=;
        b=MEiFomKuagLCQK+5C43ycupgOfOK232Lkpyx9Qt47iy9K2YTRDXwQT7xeVWYIio7eB
         8Siou5ZProodcGwTfV5IwGZaxJ9IrCytD6e52/WPeO488bZ0F1WqmKFGGY2kTGku9yQi
         iJi/pHm2uLArZj4sjIydl2XDOWdJVlUfDWHZlona4iUIKvEBljYD/YsUrU7g/Kmm0NHK
         LkaZpiZiEY7NPClFboP8TLL7kyqoz1F8bD4esct9Sa7dGyVXNYKFkMzyktSlnczQdd/m
         bURNaDPcpiGkiuu+crsk21cLgilGpEbO/I30/srbjxFXazKYkMc5RSkXzeAS3vS8q6HL
         B8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWRSjiyNk2pDw5IznRB6i+dSo03yy/JDE09KrZ0j5q1k63MLTFgeBM6sGz5o1xdB1OM5GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnoh7ZxbvKKy8XEuOHAmHLvlPlGUlUv/tmU6D/7cs3yySgfZmH
	Aw6lJf4KqFEbqry8IGmLHS/wbJgwcMnY9EgHNWBo36rV2SH8M1WRIEZpUys4
X-Gm-Gg: ASbGncv+4vYSWJNIMs0b9yoTBEPSxb4vgqoEulVzgM/5l06wEVZDcNQqcHXRhXxd/cy
	GX5PKWn58hLSgo9FImni1VLGeXlMAzJqQC4Pqhx9E0tCPuO//yH7WjHUJhurusOH6gqmJfSNeoG
	fzB5BAaTMFhLVH9Amu/ETAHY6pbT9m+J+ydJEGHFNT2PdYQhtIQmIiHUDoMEnwLNZwX3cyNzvWf
	3LQMkPxOdhqIYquWnHhcbtKcKwwP/2x5M9OpPH8E61rVT0dqum6wfQgMIxkhTVVgWNUg+AYtiZN
	sxa4Gmdy1kk5
X-Google-Smtp-Source: AGHT+IFHYZjgANRCZJzKRG8Hk3JXrC8xVobAxdYR1Azb6bX2hiVD87jrLoSVsHwsASOVdjtRiOVpfQ==
X-Received: by 2002:a05:6a00:1789:b0:732:5f41:eab with SMTP id d2e1a72fcca58-73426c935bdmr660220b3a.4.1740086455759;
        Thu, 20 Feb 2025 13:20:55 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568acesm14751714b3a.56.2025.02.20.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:20:55 -0800 (PST)
Message-ID: <eac572ada2fef3516cb1fb7977f721f738d76558.camel@gmail.com>
Subject: Re: Out-of-bound read suspected in libbpf.c
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>, bpf@vger.kernel.org
Date: Thu, 20 Feb 2025 13:20:51 -0800
In-Reply-To: <fd84552e-be67-4a01-9d08-903e9481b8d3@nandakumar.co.in>
References: <fd84552e-be67-4a01-9d08-903e9481b8d3@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDIwOjQzICswNTMwLCBOYW5kYWt1bWFyIEVkYW1hbmEgd3Jv
dGU6CgpbLi4uXQoKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9saWJicGYuYyBiL3Rvb2xz
L2xpYi9icGYvbGliYnBmLmMKPiBpbmRleCAxOTQ4MDlkYTUxNzIuLjFjYzg3ZGJkMDE1ZCAxMDA2
NDQKPiAtLS0gYS90b29scy9saWIvYnBmL2xpYmJwZi5jCj4gKysrIGIvdG9vbHMvbGliL2JwZi9s
aWJicGYuYwo+IEBAIC0yMTA2LDcgKzIxMDYsNyBAQCBzdGF0aWMgaW50IHNldF9rY2ZnX3ZhbHVl
X3N0cihzdHJ1Y3QgZXh0ZXJuX2Rlc2MgCj4gKmV4dCwgY2hhciAqZXh0X3ZhbCwKPiAgwqDCoMKg
wqDCoMKgwqAgfQo+IAo+ICDCoMKgwqDCoMKgwqDCoCBsZW4gPSBzdHJsZW4odmFsdWUpOwo+IC3C
oMKgwqDCoMKgwqAgaWYgKHZhbHVlW2xlbiAtIDFdICE9ICciJykgewo+ICvCoMKgwqDCoMKgwqAg
aWYgKGxlbiA8IDIgfHwgdmFsdWVbbGVuIC0gMV0gIT0gJyInKSB7CgpNYWtlcyBzZW5zZSB0byBt
ZSwgY291bGQgeW91IHBsZWFzZSBzZW5kIGEgZm9ybWFsIHBhdGNoPwoKPiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oImV4dGVybiAoa2NmZykgJyVzJzogaW52YWxpZCBz
dHJpbmcgY29uZmlnICclcydcbiIsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZXh0LT5uYW1lLCB2YWx1ZSk7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPiAKCgo=


