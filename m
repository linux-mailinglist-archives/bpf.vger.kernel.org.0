Return-Path: <bpf+bounces-37700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD93959AF5
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47621C228CA
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F9161306;
	Wed, 21 Aug 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldGaU2gn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2291A4B8C;
	Wed, 21 Aug 2024 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240819; cv=none; b=cK4OaSBzSksXTTzaYco6i1PzAgvpDSDY5/ggi/l7KpxjJEDF+m3QCfy6E8HHKeG21mCBTJ852q/SCA0gNMdqJe7N87UCslZfIs691VIdpCbI8hKsA5ZmbU379OBAF9bVIqxvMU8C8yKw7Cuj/iMa+AlwRsAr0ooNvJSZUa6u7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240819; c=relaxed/simple;
	bh=w8JW7RgFM2LcfhRgWwJkywb8hu58oo2ghS5lLftriAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DS2a9QcBr1jh0PmTFOJcSqmKJtspvNoxx9DfXuwrWwJeXSZgq31gJSRPXVYwa8+04v7Hss3R3G0tWScxDcQvLxEh0J9T1gSNpGRw6eFcDM9Wr7XvJnUZuW+jmpQ7iAYwNteFW25qZeogKYFH8K6LOykZrWy5vAGMeqthYT4rUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldGaU2gn; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db23a608eeso4292940b6e.1;
        Wed, 21 Aug 2024 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724240817; x=1724845617; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w8JW7RgFM2LcfhRgWwJkywb8hu58oo2ghS5lLftriAM=;
        b=ldGaU2gnsJcCN94YrYP+ms9aHlU4gAjN8ADIDqqQ5KAQouzMA3B3LSFdnwQqGAXLMF
         94R/ulv5rjoPRXCVJALIMsoXaAXUF38dRmzIimez3mR4EZPg9CHhVPTZr+xkifDbPgAx
         SwOcL+eM+nCkAuydsCL/NDDnX3Wl1vlZMIyrmHL+58GKob3do3Nr4ZGnd8SNL3XndF+Y
         RCf//cNHl7hBfqTNmGuiVR52+KTedS79Jtnkb/M+8rnZrxEUoEzHlH+uYcp9K+SSZEhQ
         9O8g4c2aJXkm9uxXvsASgteXCGGqfFeMbFt5FPowKUKqvEIIjbq6UwLw3YyFsmAnIIjn
         Uh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724240817; x=1724845617;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8JW7RgFM2LcfhRgWwJkywb8hu58oo2ghS5lLftriAM=;
        b=kOSqr/OuAjLmuNVD2ls8Vb3VO1xSNxkRZosdH3KqIQ4HqYtevO7jP/giLePisKDIiA
         sII92HG71kMUew4ziuW41ltmk1ALYmTT11yypkYQMRHalafkpe89a1EZZIt/ztMv5pT4
         Z4o27xRVpATWYAafrhlz7Bt24BFllAwkM73yFI841XGkKZGqLXHOHjtyG2wFY7pcSXul
         iuR95JDsu/vxCU+inZbHtG0PbaU/aw2w5/XLO7xpZx7+5WZjZ0necPmEoos0WshZV8dF
         T+wtSpvPTeFOSteNdi17REnTp/nwiy+NHqulSzbp/zt8ANGe+3kpbWpMPDRF63vcbuEQ
         Yxzw==
X-Forwarded-Encrypted: i=1; AJvYcCU9CiCl204wEuUUU7ZvDsHPlXxA/3bFiIdXq2HYdpUYqqk9UATlJfUqp2EKbEhWa3zpq8mM1EM+h45uC6QI@vger.kernel.org, AJvYcCV4VRVuH1qoO7AOZSeVDPDK4Uv/8ZPshhzU/zMyeoUHph0SQaeXjUiUB8B9EIls2qO/DVefZLn7@vger.kernel.org, AJvYcCV8IdeDNBbkjXHsyK+T5YO/690NM9SuFeuJ+58iXYeKd7VN4XgTYbjO1UnpDEWisKbBKmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKzlnFAter2YgGE82r5xo73e07exMQcxstxX+hJPYFC0MsfqgK
	c0f4DzCfrOEQNYbs6NuRM3invB+yYy29Q2Y4J6mlvY/xlcaedrav
X-Google-Smtp-Source: AGHT+IEI4WgrTsjO4x752GtUfzL9Jil1Pr9C/IBfBIedbLEOZwPDn1q4udtViqrPvSdZtd6RNMEetQ==
X-Received: by 2002:a05:6808:2021:b0:3db:1aa4:a610 with SMTP id 5614622812f47-3de1958c01cmr2095429b6e.50.1724240816883;
        Wed, 21 Aug 2024 04:46:56 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6365afcsm10893377a12.87.2024.08.21.04.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:46:56 -0700 (PDT)
Message-ID: <188a0d1310609fddc29524a64fa3c470fc7c4c94.camel@gmail.com>
Subject: Re: KASAN: null-ptr-deref in bpf_core_calc_relo_insn
From: Eduard Zingerman <eddyz87@gmail.com>
To: Liu RuiTong <cnitlrt@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 21 Aug 2024 04:46:51 -0700
In-Reply-To: <badd583d09868ffdd48a97c727680ca6f5699727.camel@gmail.com>
References: 
	<CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com>
	 <badd583d09868ffdd48a97c727680ca6f5699727.camel@gmail.com>
Content-Type: multipart/mixed; boundary="=-RWJtxyd3SaW2szryCK8N"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-RWJtxyd3SaW2szryCK8N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE4OjMzIC0wNzAwLCBFZHVhcmQgWmluZ2VybWFuIHdyb3Rl
Ogo+IE9uIFR1ZSwgMjAyNC0wOC0yMCBhdCAxNzoyMSArMDgwMCwgTGl1IFJ1aVRvbmcgd3JvdGU6
Cj4gCj4gWy4uLl0KPiAKPiA+IGJwZl9jb3JlX2NhbGNfcmVsb19pbnNuKzMxMSAgICAgICAgICAg
IDxicGZfY29yZV9jYWxjX3JlbG9faW5zbiszMTE+Cj4gPiDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIBbCj4gPiBTT1VSQ0UgKENPREUpIF3ilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKPiA+IEluIGZp
bGU6IC9ob21lL3VidW50dS9mdXp6L2xpbnV4LTYuMTEtcmM0L3Rvb2xzL2xpYi9icGYvcmVsb19j
b3JlLmM6MTMwMAo+ID4gICAgMTI5NSAgICAgICAgIGNoYXIgc3BlY19idWZbMjU2XTsKPiA+ICAg
IDEyOTYgICAgICAgICBpbnQgaSwgaiwgZXJyOwo+ID4gICAgMTI5Nwo+ID4gICAgMTI5OCAgICAg
ICAgIGxvY2FsX2lkID0gcmVsby0+dHlwZV9pZDsKPiA+ICAgIDEyOTkgICAgICAgICBsb2NhbF90
eXBlID0gYnRmX3R5cGVfYnlfaWQobG9jYWxfYnRmLCBsb2NhbF9pZCk7Cj4gPiAg4pa6IDEzMDAg
ICAgICAgICBsb2NhbF9uYW1lID0gYnRmX19uYW1lX2J5X29mZnNldChsb2NhbF9idGYsCj4gPiBs
b2NhbF90eXBlLT5uYW1lX29mZik7Cj4gCj4gSGkgTGl1LAo+IAo+IFRoYW5rIHlvdSBmb3IgdGhl
IHJlcG9ydCwgSSBjYW4gcmVwcm9kdWNlIHRoZSBpc3N1ZS4KPiBXaWxsIGNvbW1lbnQgbGF0ZXIg
dG9kYXkuCgpIaSBMaXUsCgpZb3VyIGFuYWx5c2lzIGlzIGNvcnJlY3QsIHRoZSBpc3N1ZSBpcyBj
YXVzZWQgYnkgYSBtaXNzaW5nIG51bGwKcG9pbnRlciBjaGVjayBmb3IgJ2xvY2FsX3R5cGUnLgoK
SSB3YXMgY3VyaW91cyB3aHkgdGhlIGF0dGFjaGVkIHRlc3QgY2FzZSBkb2VzIG5vdCBjYXVzZSBu
dWxsIHBvaW50ZXIKZXhjZXB0aW9uIGV2ZXJ5IHRpbWUsIGJ1dCB0aGVuIEkgcmVhbGl6ZWQgdGhh
dCB0aGlzIGlzIGJlY2F1c2Ugb2YgdGhlCnNlcXVlbmNlIG9mIEJQRiBjb21tYW5kcyBpdCBpc3N1
ZXMgKGVhY2ggaW4gc2VwYXJhdGUgdGhyZWFkKToKMS4gQ3JlYXRlIEJURiwgd2FpdCBmb3IgY29t
cGxldGlvbjsKMi4gTG9hZCBCUEYgcHJvZ3JhbSwgZG8gbm90IHdhaXQgZm9yIGNvbXBsZXRpb247
CjMuIFJld3JpdGUgbWVtb3J5IHJlZ2lvbiBwYXNzZWQgdG8gbG9hZCBCUEYgY29tbWFuZCBhcyBi
cGZfYXR0ciB0bwogICByZXVzZSBpdCBmb3IgYW5vdGhlciBzeXN0ZW0gY2FsbCAoYWN0dWFsIGNh
bGwgaXMgbWFwIHVwZGF0ZSwgYnV0CiAgIHRoYXQgZG9lcyBub3QgbWF0dGVyKS4KCkZyb20gdGlt
ZSB0byB0aW1lIHN0ZXBzICgyKSBhbmQgKDMpIHdvdWxkIHJ1biBjb25jdXJyZW50bHkgYW5kIHVz
ZXIKc3BhY2UgbWVtb3J5IGNodW5rIHBhc3NlZCB0byBrZXJuZWwgaW4gKDIpIHdvdWxkIGJlIHVw
ZGF0ZWQgdG8gbWFrZQpyZWxvY2F0aW9uIGRhdGEgaW52YWxpZC4KCkkgYXR0YWNoIGEgc2ltcGxp
ZmllZCB0ZXN0IGNhc2UsIHdpbGwgcG9zdCBhIGZpeCB0byBicGYgbWFpbGluZyBsaXN0CnNob3J0
bHkuCgo=


--=-RWJtxyd3SaW2szryCK8N
Content-Disposition: attachment; filename="core_reloc_raw.c"
Content-Type: text/x-csrc; name="core_reloc_raw.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKCi8qIFRlc3QgY2FzZXMgdGhhdCBj
YW4ndCBsb2FkIHByb2dyYW1zIHVzaW5nIGxpYmJwZiBhbmQgbmVlZCBkaXJlY3QKICogQlBGIHN5
c2NhbGwgYWNjZXNzCiAqLwoKI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxicGYv
bGliYnBmLmg+CiNpbmNsdWRlIDxicGYvYnRmLmg+CgojaW5jbHVkZSAidGVzdF9wcm9ncy5oIgoj
aW5jbHVkZSAidGVzdF9idGYuaCIKI2luY2x1ZGUgImJwZi9saWJicGZfaW50ZXJuYWwuaCIKCnN0
YXRpYyBjaGFyIGxvZ1sxNiAqIDEwMjRdOwoKc3RhdGljIHZvaWQgdGVzdF9iYWRfbG9jYWxfaWQo
KQp7CglzdHJ1Y3QgdGVzdF9idGYgewoJCXN0cnVjdCBidGZfaGVhZGVyIGhkcjsKCQlfX3UzMiB0
eXBlc1sxNV07CgkJY2hhciBzdHJpbmdzWzEyOF07Cgl9IHJhd19idGYgPSB7CgkJLmhkciA9IHsK
CQkJLm1hZ2ljID0gQlRGX01BR0lDLAoJCQkudmVyc2lvbiA9IEJURl9WRVJTSU9OLAoJCQkuaGRy
X2xlbiA9IHNpemVvZihzdHJ1Y3QgYnRmX2hlYWRlciksCgkJCS50eXBlX29mZiA9IDAsCgkJCS50
eXBlX2xlbiA9IHNpemVvZihyYXdfYnRmLnR5cGVzKSwKCQkJLnN0cl9vZmYgPSBvZmZzZXRvZihz
dHJ1Y3QgdGVzdF9idGYsIHN0cmluZ3MpIC0gb2Zmc2V0b2Yoc3RydWN0IHRlc3RfYnRmLCB0eXBl
cyksCgkJCS5zdHJfbGVuID0gc2l6ZW9mKHJhd19idGYuc3RyaW5ncyksCgkJfSwKCQkudHlwZXMg
PSB7CgkJCUJURl9QVFJfRU5DKDApLAkJCQkJLyogWzFdIHZvaWQqICovCgkJCUJURl9UWVBFX0lO
VF9FTkMoMSwgQlRGX0lOVF9TSUdORUQsIDAsIDMyLCA0KSwJLyogWzJdIGludCAqLwoJCQlCVEZf
RlVOQ19QUk9UT19FTkMoMiwgMSksCQkJLyogWzNdIGludCAoKikodm9pZCopICovCgkJCUJURl9G
VU5DX1BST1RPX0FSR19FTkMoOCwgMSksCgkJCUJURl9GVU5DX0VOQyg4LCAzKQkJCQkvKiBbNF0g
RlVOQyAnZm9vJyB0eXBlX2lkPTIgKi8KCQl9LAoJCS5zdHJpbmdzID0gIlwwaW50XDAgMFwwZm9v
XDAiCgl9OwoJX191MzIgbG9nX2xldmVsID0gMSB8IDIgfCA0OwoJTElCQlBGX09QVFMoYnBmX2J0
Zl9sb2FkX29wdHMsIG9wdHMsCgkJICAgIC5sb2dfYnVmID0gbG9nLAoJCSAgICAubG9nX3NpemUg
PSBzaXplb2YobG9nKSwKCQkgICAgLmxvZ19sZXZlbCA9IGxvZ19sZXZlbCwKCSk7CglzdHJ1Y3Qg
YnBmX2luc24gaW5zbnNbXSA9IHsKCQlCUEZfQUxVNjRfSU1NKEJQRl9NT1YsIEJQRl9SRUdfMCwg
MCksCgkJQlBGX0VYSVRfSU5TTigpLAoJfTsKCXN0cnVjdCBicGZfZnVuY19pbmZvIGZ1bmNzW10g
PSB7CgkJewoJCQkuaW5zbl9vZmYgPSAwLAoJCQkudHlwZV9pZCA9IDQsCgkJfQoJfTsKCXN0cnVj
dCBicGZfY29yZV9yZWxvIHJlbG9zW10gPSB7CgkJewoJCQkuaW5zbl9vZmYgPSAwLAkJLyogcGF0
Y2ggZmlyc3QgaW5zdHJ1Y3Rpb24gKHIwID0gMCkgKi8KCQkJLnR5cGVfaWQgPSAxMDA1MDAsCS8q
ICEhISB0aGlzIHR5cGUgaWQgZG9lcyBub3QgZXhpc3QgKi8KCQkJLmFjY2Vzc19zdHJfb2ZmID0g
NiwJLyogb2Zmc2V0IG9mICIwIiAqLwoJCQkua2luZCA9IEJQRl9DT1JFX1RZUEVfSURfTE9DQUws
CgkJfQoJfTsKCXVuaW9uIGJwZl9hdHRyIGF0dHIgPSB7CgkJLnByb2dfbmFtZSA9ICJmb28iLAoJ
CS5wcm9nX3R5cGUgPSBCUEZfVFJBQ0VfUkFXX1RQLAoJCS5saWNlbnNlID0gKF9fdTY0KSJHUEwi
LAoJCS5pbnNucyA9IChfX3U2NCkmaW5zbnMsCgkJLmluc25fY250ID0gc2l6ZW9mKGluc25zKSAv
IHNpemVvZigqaW5zbnMpLAoJCS5sb2dfYnVmID0gKF9fdTY0KWxvZywKCQkubG9nX3NpemUgPSBz
aXplb2YobG9nKSwKCQkubG9nX2xldmVsID0gbG9nX2xldmVsLAoJCS5mdW5jX2luZm8gPSAoX191
NjQpZnVuY3MsCgkJLmZ1bmNfaW5mb19jbnQgPSBzaXplb2YoZnVuY3MpIC8gc2l6ZW9mKCpmdW5j
cyksCgkJLmZ1bmNfaW5mb19yZWNfc2l6ZSA9IHNpemVvZigqZnVuY3MpLAoJCS5jb3JlX3JlbG9z
ID0gKF9fdTY0KXJlbG9zLAoJCS5jb3JlX3JlbG9fY250ID0gc2l6ZW9mKHJlbG9zKSAvIHNpemVv
ZigqcmVsb3MpLAoJCS5jb3JlX3JlbG9fcmVjX3NpemUgPSBzaXplb2YoKnJlbG9zKSwKCX07Cglp
bnQgc2F2ZWRfZXJybm87CglpbnQgcHJvZ19mZCA9IC0xOwoJaW50IGJ0Zl9mZCA9IC0xOwoKCWJ0
Zl9mZCA9IGJwZl9idGZfbG9hZCgmcmF3X2J0Ziwgc2l6ZW9mKHJhd19idGYpLCAmb3B0cyk7Cglz
YXZlZF9lcnJubyA9IGVycm5vOwoJaWYgKGJ0Zl9mZCA8IDAgfHwgZW52LnZlcmJvc2l0eSA+IFZF
UkJPU0VfTk9STUFMKSB7CgkJcHJpbnRmKCItLS0tLS0tLSBCVEYgbG9hZCBsb2cgc3RhcnQgLS0t
LS0tLS1cbiIpOwoJCXByaW50ZigiJXMiLCBsb2cpOwoJCXByaW50ZigiLS0tLS0tLS0gQlRGIGxv
YWQgbG9nIGVuZCAtLS0tLS0tLS0tXG4iKTsKCX0KCWlmIChidGZfZmQgPCAwKSB7CgkJUFJJTlRf
RkFJTCgiYnBmX2J0Zl9sb2FkKCkgZmFpbGVkLCBlcnJubz0lZFxuIiwgc2F2ZWRfZXJybm8pOwoJ
CXJldHVybjsKCX0KCgltZW1zZXQobG9nLCAwLCBzaXplb2YobG9nKSk7CglhdHRyLnByb2dfYnRm
X2ZkID0gYnRmX2ZkOwoJcHJvZ19mZCA9IHN5c19icGZfcHJvZ19sb2FkKCZhdHRyLCBzaXplb2Yo
YXR0ciksIDEpOwoJc2F2ZWRfZXJybm8gPSBlcnJubzsKCWlmIChwcm9nX2ZkIDwgMCB8fCBlbnYu
dmVyYm9zaXR5ID4gVkVSQk9TRV9OT1JNQUwpIHsKCQlwcmludGYoIi0tLS0tLS0tIHByb2dyYW0g
bG9hZCBsb2cgc3RhcnQgLS0tLS0tLS1cbiIpOwoJCXByaW50ZigiJXMiLCBsb2cpOwoJCXByaW50
ZigiLS0tLS0tLS0gcHJvZ3JhbSBsb2FkIGxvZyBlbmQgLS0tLS0tLS0tLVxuIik7Cgl9CglpZiAo
cHJvZ19mZCA+IDApIHsKCQlQUklOVF9GQUlMKCJzeXNfYnBmX3Byb2dfbG9hZCgpIGV4cGVjdGVk
IHRvIGZhaWxcbiIpOwoJCWdvdG8gb3V0OwoJfQoJQVNTRVJUX0hBU19TVUJTVFIobG9nLCAicmVs
byAjMDogYmFkIHR5cGUgaWQgMTAwNTAwIiwgInByb2dyYW0gbG9hZCBsb2ciKTsKCm91dDoKCWNs
b3NlKHByb2dfZmQpOwoJY2xvc2UoYnRmX2ZkKTsKfQoKdm9pZCB0ZXN0X2NvcmVfcmVsb2NfcmF3
KHZvaWQpCnsKCWlmICh0ZXN0X19zdGFydF9zdWJ0ZXN0KCJiYWRfbG9jYWxfaWQiKSkKCQl0ZXN0
X2JhZF9sb2NhbF9pZCgpOwp9Cg==


--=-RWJtxyd3SaW2szryCK8N--

