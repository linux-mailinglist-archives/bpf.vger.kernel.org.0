Return-Path: <bpf+bounces-60183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A34AD3A13
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C209189C3E1
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA02980DF;
	Tue, 10 Jun 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEazfmQJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6A22D79B
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563923; cv=none; b=pow3HOX64K0TmXSJ1LaEWSusnZMXybPvVuwP7l3VNekChb0mAy3uTFLPT39XxHkWmGWcODHBOH1+FHHjgaHRUp7nZyUy89cUyPnyj2Un9KtSLUkcSLa+HHmxlzmJEuOAwEAGCrQWfCShDlChF40POvJGRZYFtovBfBb6SYt/WMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563923; c=relaxed/simple;
	bh=MxfaFRwuFLqE+9nI0ucrxjw0AN3wJ757KaU1D0R41hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vFYEKuTvcEh1dvxXZC/xRlw+tpQr9TKU02MOd4Ul4Yesyj384tVxERPAFJbc0naplxineyKsQ6b4pehItiveU8SgTb5Cd6Vg29MKc7haGMInI4yibgtjWfvq3iSHm7D5WeLea/DEbwbacSPy9gEuE+Dqp0rNW6aODyjUcwMN1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEazfmQJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so8778928a12.2
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749563920; x=1750168720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHZ3KCQEeV7k8dj98CEGeNCE2VNhiB6ZFy/X//FctNY=;
        b=PEazfmQJpEfX02Wh7KeuF1UT4fLojBP1Qgq45wdHElY1/nXKRrKMnXyCxevUs12QkL
         cx7xbc2q9//yJ6MgAxgerQIddrIUB8KhmSOteO+vO1/KFrhb70HS8vnA0c2bYQMmitjA
         CchE51byZ8u+7HiUa+eizyPVp4h8UGstmsJLHKi9d+Im4bCDJVTaosoprarQb9w12V0G
         z9pVsF1Ov1Hut82vP2Na2OyBqzNspQam2LvITimNs7FnJq0TaNOYvqUmKZNEThZntFuz
         0qqvPKFt1RDdlyVR7Lee8JTTi5yFZjLFrvplPgc4boImSEcyX3g+LbY9JVsSvRb10SYV
         yKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749563920; x=1750168720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHZ3KCQEeV7k8dj98CEGeNCE2VNhiB6ZFy/X//FctNY=;
        b=RYuUQhHauijEzjp+vc6Sfk2LycaDwhI9Vi7inFevRQfym1vEHQXveg4BoPBBeoVjI3
         t8s9C1JslEmcAC3eKqebsOHXINv7ECuS9+3e1i3uYjTot6+h09zw8/9AkF9mpyuIIVRW
         2cAhbvKdHWa1UMNxyjUpAnFkeRWJ48tlj5iZ5ls91nZ/i1T2xc1ppVg2PtdjMYdq22rH
         5/tl8G4o0zgAvd+ZynZo8Ql9FNafDqHtTYU/y30N/6eSc9i2hYOOOxdGuYPvDOnvYAhy
         kbQg4fki1N6oWWyjwOHjAl3zG0ygDl+P0jVrUilvKZ3CGAO2Rwdc+V8K9BYGKYhTqQ+x
         FvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwKyqEf3GI9TWfOjDCwr4PSathHO4fIs/5OrMhlVWtyRdFtVMKxSfm02KiK9kqhvDeH18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMMRGzIvtOkA0mJG6POQ4kmxHDO2rIKrPa+jqMAU6v4LOgnDr
	pZlXAgLWepfsK0HNmfKdNSZn78sjJhL67mXrJBAiPQw2vxl7snNoNzj3I6LDNjZeqMM=
X-Gm-Gg: ASbGncvaCYypE0EeLVySzCvcCWj44QajY5bz/FyrtIjO24wiuBjh451onRk7iwrQSLR
	pEFhfJWjUKsmRq2a8o9xqYwxCTI+sLNQnglJayFOdRomjZnkMO40P3kHivfemAInheuV4pQigOP
	Ag1cirlRRBaBL0LvgDoB9joo8wLbNnOl+k7xvpMOCfGsCQqOJuQmljmz/8/4v26y3M6ZAVZaCid
	T44mq1Zm8flh9jGAPln0Bp89R1rNZoNe9EF/sXYPdA+2/QNEIiBjun92fub7VEsgVQ3AhahBY9n
	jNf+GYde3BWcmVYFpwGGWh0tDGaJn9fX6j0cK/S2IVUZ7DSPHErfIZLPN7X+wHGvO1/hmyc07OK
	+bWC1BV5LrRicYo68rG/n500=
X-Google-Smtp-Source: AGHT+IH6MsIqQbYygEFMyFhykDAVly5ie2IFRKhNgpicopjfgnVPPBI+Ha5bnAKidWzrzY37DS5a5g==
X-Received: by 2002:a17:907:3e14:b0:ad8:a935:b90f with SMTP id a640c23a62f3a-ade1aa5c993mr1595136466b.7.1749563919935;
        Tue, 10 Jun 2025 06:58:39 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a583:5a70:b94e:b183? ([2620:10d:c092:500::5:1505])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c80dsm728401666b.102.2025.06.10.06.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 06:58:39 -0700 (PDT)
Message-ID: <6f08e564-2e06-4929-8ff5-4860cb749ace@gmail.com>
Date: Tue, 10 Jun 2025 14:58:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential negative index dereference in
 tools/bpf/bpf_jit_disasm.c due to unchecked readlink() return value
To: =?UTF-8?B?0KDRg9GB0LvQsNC9INCh0LXQvNGH0LXQvdC60L4=?=
 <uncleruc2075@gmail.com>, bpf@vger.kernel.org
References: <CAMxyDH0ewinM+H_+2msTMBF7zabk_WbGX3HDLpL88oL+jKN9=A@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAMxyDH0ewinM+H_+2msTMBF7zabk_WbGX3HDLpL88oL+jKN9=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/25 13:55, Руслан Семченко wrote:
> Subject: Potential negative index dereference in
> tools/bpf/bpf_jit_disasm.c due to unchecked readlink() return value
>
> In tools/bpf/bpf_jit_disasm.c, function get_exec_path uses the return
> value of readlink() as an array index without checking for negative
> values. According to the man page, readlink() returns -1 on error.
> Using this negative value as an array index (tpath[len] = 0;) causes
> out-of-bounds memory access, which can lead to undefined behavior or a
> crash.
>
> Relevant code (lines 46-48):
> len = readlink(path, tpath, size);
> tpath[len] = 0;
>
> If readlink() fails, len will be -1, resulting in tpath[-1] = 0;
> There is no check for (len < 0) before using len as an index.
>
> Proposed fix:
> Add a check for (len < 0) after readlink(), and handle the error case
> appropriately before using len as an index.
>
> Suggested patch:
> len = readlink(path, tpath, size);
> if (len < 0) {
>      tpath[0] = 0;
>      free(path);
>      return;
> }
> tpath[len] = 0;
Thanks for sending this report. Did you manage to trigger that behavior? 
How can I reproduce it?
The change looks ok, though, maybe we can simplify it to:
```
      len = readlink(path, tpath, size);
+    if (len < 0)
+        len = 0;
      tpath[len] = 0;

      free(path);
```
Do you mind sending a patch? You can find info on how to do it in 
multiple places, for example:
https://kernelnewbies.org/Outreachyfirstpatch


