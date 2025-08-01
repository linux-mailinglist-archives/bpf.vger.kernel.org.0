Return-Path: <bpf+bounces-64889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFDAB18276
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37B3583C1A
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F40D256C71;
	Fri,  1 Aug 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHlJsQ0B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09E24887E;
	Fri,  1 Aug 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054970; cv=none; b=S/wLuzw7uoI1mWAebUMuFsH8pgiFYURyVMfZPpfj2f6UwCnUIGCcvMGXGpUvfEgsX71H4StlRmFYbXLPJMnVyhlHL0gQT7VPtomAfpb5jIflzFaNBmWAEHMK8cyKlOoAuDr3Kc2hdBflo6QjNClXXlA3Reuwydc0JPimY6wVLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054970; c=relaxed/simple;
	bh=gZ8kuYKTYACXHUZs9LSa2j03XSmCJCxV9dSiw18e0hw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cLK3fWhK061h3yVM01Tup0hzwVnGajj+HQmdyYTtM6r970o2rUtFdguX/TPWkHSxlt4qbpVd2UgmYMdPKPWNtddDJ8jg+fQBou6I2XqPDEmzwtiM2bwyVspHgVIzuDUHWUHtDoyask5kMeE7FPSv90MZKJR3/j9n7cUI+5QFAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHlJsQ0B; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76b77a97a04so743541b3a.1;
        Fri, 01 Aug 2025 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754054969; x=1754659769; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ8kuYKTYACXHUZs9LSa2j03XSmCJCxV9dSiw18e0hw=;
        b=RHlJsQ0BGEVAqCV8fs8EIiibdsb1VlmLQ9tRPRbuhpnBPWFy0DTOVWh6kaWxRFy7rn
         3F0tP6E+ifihE+AeCb5KSqu91s7D5ytxvoOVHGuVwCovcp8ZxiDqTTezakUQ8HS5nxfE
         h62fYl6Nv5xxlM0rTrgowiXew5RLyEv6TNJolmSdxkTXFEsTIw9wZuRbYxqoPf6STuMn
         XQM37PkmBbjMoC8ExUFznxkP2/+mGJ9JDUuEtKudLfWEvwSGhjMFCEEZ+YWLiVeP9fqT
         HD47k5RVGClo81L0eqxZrBFQJx28OJUBwPdbakx6/TWCJaC5bA3ttwVJZnDKjEmF1Daq
         M1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054969; x=1754659769;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ8kuYKTYACXHUZs9LSa2j03XSmCJCxV9dSiw18e0hw=;
        b=SVSvysLo39H+sR0YBY0MeDhnUIKyXRWlcg7rsB9GestWSXRB+iWC8s00lKWfxcCLmX
         ixdR+wE8+i3Iau1BivA61e+W80F1nTO0cOiM5QcJMvLbHz6PWyBzdPZbvaKjfzBpg/S8
         qB5JAEv6SeF7CgcxOQt25rSHo2G9bYY4otMKwR8IwgUBiCZm3lMgqnT4CNsPcNkE/26y
         wIbmYTHqEjBckmkCzLMu5CsuNs/sl+6LGXWWEmUbhpdKIfXI2hC1P5Byw2eccr2NUNZu
         UgaXdibKhV2y1jENiU4yncP/MUi+V8Dqu1ok/Vi0UBV6acW1k52dZJu42InJT7GVNXUA
         bfJw==
X-Forwarded-Encrypted: i=1; AJvYcCWM0aeQJJBk4HkOUagk02kKHTBmBSJeUDkqrnM06taD7vHjDRC424mou4hryaoe4L4QZp4vXRsQNMkdv78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+S8fHIX/nxR1nNm0Y/Dlpni15dqMsRCBpr84KJUVHhNb6nQ9
	fwFXZw/5tXgjq8qYGPvU7f34g8G6djNbdxu6ULHmMy9OI4zQpHYBFKQh
X-Gm-Gg: ASbGnctlTsDhouQStVP+LT6I60AZfgRPY7shKs7tsju49JgYc4I74aTutgxDRuGf07B
	5JoCQruOf5DIq1cQhKZqY+nccqBscmqE9MBt4a2hr4Ig3ZB6Wnpdt2SvhqugTvsEVgIbIMiqJlj
	/dFg7z3UEcfleRWAqta+3mMhslc5eH7ESPVY4JuQ90YP/1KH2pK75s7TaP04h9iC86kVse102m/
	f1WX91MZCuJzf++451ki4nbB9R4mMD/0gNDdrlQ4GshUPuG8d64RtRGRm/IqxUdhKHpJR1xpJzA
	8clEOVNdp3O6WfK6aw+7fio/rCuK6RVpo7oLNdjRdoog8BxkriI0vRNOIHBHO6OwAlrlc7BDOYq
	mjnt0wYd1/6eeVAukULWOosWck0RXsJoGuhRUanZebJrJDDvmRjhv7queTz4jJfpMo6SUyfZm
X-Google-Smtp-Source: AGHT+IFeM1/QlvnNRvH3y0h0cppzL52JmhsNGRmZD6rEzFz4TdCLy2pueZYPBAlYohY1sP6szQ2CqA==
X-Received: by 2002:a05:6a00:4b02:b0:748:2d1d:f7b3 with SMTP id d2e1a72fcca58-76ab30d04c2mr14920256b3a.22.1754054968568;
        Fri, 01 Aug 2025 06:29:28 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm4145195b3a.58.2025.08.01.06.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 06:29:28 -0700 (PDT)
Message-ID: <c08c2cb8-4760-4b21-9beb-2e9c204a62dc@gmail.com>
Date: Fri, 1 Aug 2025 18:59:23 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH] docs: bpf: fix minor typos in BTF comments
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 xsFNBGh86ToBEADO5CanwR3XsVLXKhPz04FG37/GvZj3gBoA3ezIB/M/wwGdx6ISqUzYDUsB
 Id5LM/QxLWYdeiYyACQoMDYTojfOpG6bdZrGZ2nqTO/PY9tmY31UyEXg5lwZNGnZgV+Fs6LW
 E5F1PrndB4fGw9SfyloUXOTiY9aVlbiTcnOpSiz+to4C6FYbCm4akLaD8I+O1WT3jR82M9SD
 xl+WidzpR+hLV11UQEik4A+WybRnmWc5dSxw4hLHnhaRv47ScV8+M9/Rb42wgmGUF0l/Is4j
 mcOAGqErKo5jvovJ4ztbbOc/3sFEC42+lQG8edUWbk3Mj5WW1l/4bWcMPKx3K07xBQKy9wkf
 oL7zeIMsFyTv9/tQHYmW7iBdx7s/puUjcWZ9AT3HkZNdALHkPvyeNn9XrmT8hdFQnN2X5+AN
 FztEsS5+FTdPgQhvA8jSH5klQjP7iKfFd6MSKJBgZYwEanhsUrJ646xiNYbkL8oSovwnZzrd
 ZtJVCK2IrdLU7rR5u1mKZn2LoannfFWKIpgWyC//mh62i88zKYxer6mg//mmlvSNnl+A/aiK
 xdVfBzMSOHp2T3XivtPF8MBP+lmkxeJJP3nlywzJ/V038q/SPZge8W0yaV+ihC7tX7j6b2D2
 c3EvJCLGh7D+QbLykZ+FkbNF0l+BdnpghOykB+GSfg7mU5TavwARAQABzTlBbmthbiBCaXN3
 YXMgKGVuY3lwdGVkIGxrbWwgbWFpbCkgPHNweWpldGZheWVkQGdtYWlsLmNvbT7CwZQEEwEK
 AD4WIQTKUU3t0nYTlFBmzE6tmR8C+LrwuQUCaHzpOgIbAwUJA8JnAAULCQgHAgYVCgkICwIE
 FgIDAQIeAQIXgAAKCRCtmR8C+LrwuVlkD/9oLaRXdTuYXcEaESvpzyF3NOGj6SJQZWBxbcIN
 1m6foBIK3Djqi872AIyzBll9o9iTsS7FMINgWyBqeXEel1HJCRA5zto8G9es8NhPXtpMVLdi
 qmkoSQQrUYkD2Kqcwc3FxbG1xjCQ4YWxALl08Bi7fNP8EO2+bWM3vYU52qlQ/PQDagibW5+W
 NnpUObsFTq1OqYJuUEyq3cQAB5c+2n59U77RJJrxIfPc1cl9l8jEuu1rZEZTQ0VlU2ZpuX6l
 QJTdX5ypUAuHj9UQdwoCaKSOKdr9XEXzUfr9bHIdsEtFEhrhK35IXpfPSU8Vj5DucDcEG95W
 Jiqd4l82YkIdvw7sRQOZh4hkzTewfiynbVd1R+IvMxASfqZj4u0E585z19wq0vbu7QT7TYni
 F01FsRThWy1EPlr0HFbyv16VYf//IqZ7Y0xQDyH/ai37jez2fAKBMYp3Y1Zo2cZtOU94yBY1
 veXb1g3fsZKyKC09S2Cqu8g8W7s0cL4Rdl/xwvxNq02Rgu9AFYxwaH0BqrzmbwB4XJTwlf92
 UF+nv91lkeYcLqn70xoI4L2w0XQlAPSpk8Htcr1d5X7lGjcSLi9eH5snh3LzOArzCMg0Irn9
 jrSUZIxkTiL5KI7O62v8Bv3hQIMPKVDESeAmkxRwnUzHt1nXOIn1ITI/7TvjQ57DLelYac7B
 TQRofOk6ARAAuhD+a41EULe8fDIMuHn9c4JLSuJSkQZWxiNTkX1da4VrrMqmlC5D0Fnq5vLt
 F93UWitTTEr32DJN/35ankfYDctDNaDG/9sV5qenC7a5cx9uoyOdlzpHHzktzgXRNZ1PYN5q
 92oRYY8hCsJLhMhF1nbeFinWM8x2mXMHoup/d4NhPDDNyPLkFv4+MgltLIww/DEmz8aiHDLh
 oymdh8/2CZtqbW6qR0LEnGXAkM3CNTyTYpa5C4bYb9AHQyLNWBhH5tZ5QjohWMVF4FMiOwKz
 IVRAcwvjPu7FgF2wNXTTQUhaBOiXf5FEpU0KGcf0oj1Qfp0GoBfLf8CtdH7EtLKKpQscLT3S
 om+uQXi/6UAUIUVBadLbvDqNIPLxbTq9c1bmOzOWpz3VH2WBn8JxAADYNAszPOrFA2o5eCcx
 fWb+Pk6CeLk0L9451psQgucIKhdZR8iDnlBoWSm4zj3DG/rWoELc1T6weRmJgVP2V9mY3Vw7
 k1c1dSqgDsMIcQRRh9RZrp0NuJN/NiL4DN+tXyyk35Dqc39Sq0DNOkmUevH3UI8oOr1kwzw5
 gKHdPiFQuRH06sM8tpGH8NMu0k2ipiTzySWTnsLmNpgmm/tE9I/Hd4Ni6c+pvzefPB4+z5Wm
 ilI0z2c3xYeqIpRllIhBMYfq4ikmXmI3BLE7nm9J6PXBAiUAEQEAAcLBfAQYAQoAJhYhBMpR
 Te3SdhOUUGbMTq2ZHwL4uvC5BQJofOk6AhsMBQkDwmcAAAoJEK2ZHwL4uvC51RoQAKd882H+
 QGtSlq0It1lzRJXrUvrIMQS4oN1htY6WY7KHR2Et8JjVnoCBL4fsI2+duLnqu7IRFhZZQju7
 BAloAVjdbSCVjugWfu27lzRCc9zlqAmhPYdYKma1oQkEHeqhmq/FL/0XLvEaPYt689HsJ/e4
 2OLt5TG8xFnhPAp7I/KaXV7WrUEvhP0a/pKcMKXzpmOwR0Cnn5Mlam+6yU3F4JPXovZEi0ge
 0J4k6IMvtTygVEzOgebDjDhFNpPkaX8SfgrpEjR5rXVLQZq3Pxd6XfBzIQC8Fx55DC+1V/w8
 IixGOVlLYC04f8ZfZ4hS5JDJJDIfi1HH5vMEEk8m0G11MC7KhSC0LoXCWV7cGWTzoL//0D1i
 h6WmBb2Is8SfvaZoSYzbTjDUoO7ZfyxNmpEbgOBuxYMH/LUkfJ1BGn0Pm2bARzaUXuS/GB2A
 nIFlsrNpHHpc0+PpxRe8D0/O3Q4mVHrF+ujzFinuF9qTrJJ74ITAnP4VPt5iLd72+WL3qreg
 zOgxRjMdaLwpmvzsN46V2yaAhccU52crVzB5ejy53pojylkCgwGqS+ri5lN71Z1spn+vPaNX
 OOgFpMpgUPBst3lkB2SaANTxzGJe1LUliUKi3IHJzu+W2lQnQ1i9JIvFj55qbiw44n2WNGDv
 TRpGew2ozniUMliyaLH9UH6/e9Us
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From 85f5a63a12a8544440c0af47214ba5f55c348c7c Mon Sep 17 00:00:00 2001
From: Ankan Biswas <spyjetfayed@gmail.com>
Date: Fri, 1 Aug 2025 18:25:21 +0530
Subject: [PATCH] docs: bpf: fix minor typos in BTF comments

Fix a couple of small typos in the BTF documentation comments:
* "focus" → "focuses"
* "F.e." → "For example,"

Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
  kernel/bpf/btf.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64739308902f..a0ecf162918c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -35,7 +35,7 @@
  #include "../tools/lib/bpf/relo_core.h"

  /* BTF (BPF Type Format) is the meta data format which describes
- * the data types of BPF program/map.  Hence, it basically focus
+ * the data types of BPF program/map. Hence, it basically focuses
   * on the C programming language which the modern BPF is primary
   * using.
   *
@@ -47,7 +47,7 @@
   * ~~~~~~~~~~~~~~~
   * Each 'struct btf_type' object describes a C data type.
   * Depending on the type it is describing, a 'struct btf_type'
- * object may be followed by more data.  F.e.
+ * object may be followed by more data. For example,
   * To describe an array, 'struct btf_type' is followed by
   * 'struct btf_array'.
   *
--
2.50.1


