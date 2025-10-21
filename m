Return-Path: <bpf+bounces-71580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C2BF72FD
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA79819C14E7
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0880534029F;
	Tue, 21 Oct 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRWh79pn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62D33FE29
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058504; cv=none; b=LF0LICYsCYh7ScN2m6v6iH69kduNxs/FWeTmc//pLerKzWKgRIYOnHQZnJzh1OpC49bjCk+HBiGl8BZzx4HciGxp5rTVGfW/IUPxrXdodgf0FEQoOnEb/PtKCvWdEGR0DnqJpApvxHnrfc9j3Xt3K3KH+iagUjfn1SGOiPXslRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058504; c=relaxed/simple;
	bh=a2r4gbx5pftkJohfSudPXPqpZK+2aqBiLvHpHvB1CDM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pvi9S1zoKfbQlFS4pNvylvQB9XzNW7DroR9u1whkrNeM6z9+6T8jM8m2BxhYuoqH4DUcPJLlSA7OtQsSdUYJZhKidcj50hSkwP1fZ9xy14YAbW4PSediQRK5Tr220yqySdbTQJy1mDQRT4MvsHnkf5MJFEECzhpCtCxftmM1z7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRWh79pn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28a5b8b12a1so57454085ad.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761058502; x=1761663302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u8jKwwQTCYq7iHexXCekwfwrRuw8RhOd5w+D5wzskuo=;
        b=lRWh79pnHFWHDaxcERTeeJJ9Yz192uStf22Fot2jFv2oLb+RBA+FBL7gi0ReDYkVrH
         sIpZh0Rh4uWVe1R+F280PpUWUA2dkqKTd1CCSfsQdt5JVgoHZU2UdYvUNsB8+3h+HorF
         FdAPzx7vv6TvHGFSi/7bNUefFC9lb5a3Bza3vgMAXlEtPfv6qFYHcoTyV5GnglmUNNfR
         sGVixPnC+qnCXnmUsxI0aA6drNEZrZfs1vPwEf+eQMfoTwuTzHJTYy4TrKs/8KXxz52d
         wsSg3bB2r6GWvPdUzEzgMc26+rsZVCW6Mk6KHuBnlQTUOYXPUJWG7DFTl5/SY9mZMfdY
         9IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058502; x=1761663302;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8jKwwQTCYq7iHexXCekwfwrRuw8RhOd5w+D5wzskuo=;
        b=VHnKqzEFepzoqkj0wM/vVidM+RxaLHwWVt21IYdPPKR/6HF2eQG7bx9Do/uHZ7uT9p
         I9YB/656J+DN1tOwdIqZQDEVUBgzuu5lhQTt6mokAM9u5ur3PXiN1wwbYPknYGPw5Mks
         EfGKdyvpD6I4FnVYUFdOYtWvR6e62N0Is6t8PmYkTZg13HaAMJO947kJn9fDad6y+C99
         +esud6H8TgAY8CHP6xT+1SH7foD8S320kbgfOjjC7Ypqc6Yg/VSaN+IBlnLxvz4VICsu
         dfnX4DeM6qQndJA5c8oNswlXsS7yvwhZm72Hs58EDP8CBWut41OveaATJJyOO59LPFK3
         ElVA==
X-Forwarded-Encrypted: i=1; AJvYcCUcbIZVfSpeWsK+OmEg36DCD0AfoYNrwWr0cV/4Lk/jOpD0Qmi0AmnImnWj1YXZReL8VcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJF8E/IirszdbvN+1MOweQyhVn9QvoW+UybrNzphjUpMrd7Of
	QHZJPfnsVvwrDe4GwKSKsIqJfV6+bGFThMxN2xZAwsJ2jXJqvTp22m5OHQCE4SrG
X-Gm-Gg: ASbGncuK/AePmlb7X0gsnIXk1nQFZNX4CAiu6c/vF0g6edmRD+HYjNUcG8Q+zDuxtAK
	u4pdDW4TqC6pdS844fHb6BCiZiI098RPFD3wzis+tO0oDk5dlRkfogfTi2QxUhcz3OovXmNXwEb
	G9zXhLtVD0JEpbFHcq25iZhswjwMw6/KyEsarxho7WYNLJHttO/aObgxr5OCFDn6YPd9ZDvDc7s
	9urhwBrCNCdPLtdid2/8hXMw/v0bA0yf+jBhI4/BAfkVGWVkKfQc1vuspQJUPJ2y8s0wbRwxOEi
	RCi5h+gSa7wjOAR2SiYqlz9jEqU4wCaG4DJKamxEwrPrII4KMZP4G0GmpE/+LRT8U6sMMjJDjqz
	L4TDlA0QfGEFOZRoY5a1fECd0d4IrDroqvyvR4tuTR7JLQrdIMq1xdt+LiBl0746o90YlM6phYF
	5Zs7qrgN9ke1T4Zj7dxmDr012O3Qk=
X-Google-Smtp-Source: AGHT+IFD3ACZjLecX4pFX0ikhUD8ku4gWsoItiIAGHahNhewRSmWm38mI9KB9e/CDiUStUJdIm/msA==
X-Received: by 2002:a17:902:e544:b0:249:37ad:ad03 with SMTP id d9443c01a7336-290cba4ebdamr212152465ad.34.1761058502303;
        Tue, 21 Oct 2025 07:55:02 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:14d:128a:9455:6fde:1f5e:a99c:2ca0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdceesm110734285ad.81.2025.10.21.07.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 07:55:01 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:54:56 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Jakub Sitnicki <jakub@cloudflare.com>,
 Yonghong Song <yonghong.song@linux.dev>
CC: dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Matt Fleming <mfleming@cloudflare.com>, kernel-team@cloudflare.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_dwarves=5D_pahole=3A_Avoid_genera?=
 =?US-ASCII?Q?ting_artificial_inlined_functions_for_BTF?=
User-Agent: Thunderbird for Android
In-Reply-To: <caf3969f-658d-41f9-9de9-9ef3a3773ee8@oracle.com>
References: <20251003173620.2892942-1-yonghong.song@linux.dev> <874irswi4a.fsf@cloudflare.com> <caf3969f-658d-41f9-9de9-9ef3a3773ee8@oracle.com>
Message-ID: <54691577-8921-476D-B1BC-AFB9D258B7F5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 21, 2025 11:32:08 AM GMT-03:00, Alan Maguire <alan=2Emaguire@or=
acle=2Ecom> wrote:
>On 21/10/2025 13:32, Jakub Sitnicki wrote:
>> On Fri, Oct 03, 2025 at 10:36 AM -07, Yonghong Song wrote:
>>> But actually, one of function 'foo' is marked as DW_INL_inlined which =
means
>>> we should not treat it as an elf funciton=2E The patch fixed this issu=
e
>>> by filtering subprograms if the corresponding function__inlined() is t=
rue=2E
>>=20
>> I have a semi-related question: are there any plans for BTF to indicate
>> when a function has been inlined? Not necessarily where it has been
>> inlined, just that it has, somewhere, at least once=2E
>>=20
>> When tracing with bpftrace or perf without a vmlinux available, it's
>> easy to assume you're tracing all calls to a function, when in fact som=
e
>> calls may be inlined within the same compilation unit=2E
>>=20
>> A good example is tracing the rtnl_lock - there are multiple inlined
>> copies, but neither bpftrace nor perf can warn you about it when debug
>> info is absent=2E
>>=20
>
>hi Jakub, see the RFC series at [1]=2E The goal is to represent inline
>sites in BTF such that we can see when a function has been partially or
>fully inlined, or indeed when optimizations have been applied to its ,
>parameters which result in it being unsafe for fprobe()ing - in these
>cases we skip representing such functions in BTF today=2E

I wonder if at least telling the user that there are such optimized cases =
around line N on function F, etc it could help with workarounds while traci=
ng=2E

I=2Ee=2E represent it in BTF and let tools decide it's unsafe and use it j=
ust for these warnings=2E

>In the case of inlined/optimized functions the proposal is to represent
>them via BTF location data; not all of these locations will have all
>parameters available due to optimization etc=2E However even absent that
>it is still valuable to know such inlining has occurred as you say=2E

Oh well, that's what you propose 8-)

>
>[1]
>https://lore=2Ekernel=2Eorg/bpf/20251008173512=2E731801-1-alan=2Emaguire@=
oracle=2Ecom/
>
>> $ sudo perf probe -a rtnl_lock
>> Added new event:
>>   probe:rtnl_lock      (on rtnl_lock)
>> =20
>> You can now use it in all perf tools, such as:
>> =20
>>         perf record -e probe:rtnl_lock -aR sleep 1
>> =20
>> $ sudo apt install linux-image-`uname -r`-dbg
>> Installing:
>>   linux-image-6=2E12=2E53-cloudflare-2025=2E10=2E4-dbg
>> [=E2=80=A6]
>> $ sudo perf probe -d rtnl_lock
>> Removed event: probe:rtnl_lock
>> $ sudo perf probe -a rtnl_lock
>> Added new events:
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>>   probe:rtnl_lock      (on rtnl_lock)
>> =20
>> You can now use it in all perf tools, such as:
>> =20
>>         perf record -e probe:rtnl_lock -aR sleep 1
>> =20
>> $
>>=20
>> Thanks,
>> -jkbs
>

- Arnaldo 

