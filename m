Return-Path: <bpf+bounces-64338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6521B11B15
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E5E161129
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB162D3A6A;
	Fri, 25 Jul 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F/9668Vg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301392C326A
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436604; cv=none; b=KB/T1HbaK1IMB0MprFApQpUX4FdzxmBYgXFjF5CiIsnHgJZ3LK2tzTjlW/BH6Pf4M0iLgBjqGQkTF4d2OapbRi3ehr6miCD9efc1IPQ7eJPpgq3BPQGzT1ueZ0HC7sBwkOEENB5dEUebeWo/IF0uMUExTcc0pt+teCq0ulpu3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436604; c=relaxed/simple;
	bh=xJpDBQAy7HLW5uL3nYN8UbRVhylGAiTIhKGv7shEQ3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=neoDmaV6PpSw0d36V9jVCkDPinKfmJTpPqYLrE1EE7GZEpSsl+cMndlacPP9j1/JuHUgWYCmh2iTbITFGH9LA7GuXYYDCXN6WWmcp9ruakqCDFDsHhWaV2m6Ah9boEZpyQ3mecX17tO18yn7KrjzMEA5YADV/5IyLiLGveTq0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F/9668Vg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3b336e936so377230266b.3
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753436601; x=1754041401; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJpDBQAy7HLW5uL3nYN8UbRVhylGAiTIhKGv7shEQ3c=;
        b=F/9668VgwO7NfhgDk/rJHwm7jF7bCxga82OA6FdWeZx9yQdD17owqxllEMAqb/0ICO
         ihAl376vs9BuzfuNY6U4YlO+eLV1mVCH7v7jy71W9/eJIWgssQjRQ7ePvJZTB0UwA/Er
         FGaCowOLxVFRL95EwS9Sgym1UeszTcpAi8zRVOiiEdM3lQA2YSfRTOC6qRf6SRnkJue5
         09Z28o0iF72VtRyzHmW6Dj0+UF5Hp1fBCI+34+PRy6LQlFRUyGBFk6zHdw4NOYfhNG9a
         M6Q2Qd/NO+FKutLawKLBZJ9vR5jZJRCATN/5RzuXBjuKTgGWY0U+T0yGsyKBpwxW1E/L
         lf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753436601; x=1754041401;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJpDBQAy7HLW5uL3nYN8UbRVhylGAiTIhKGv7shEQ3c=;
        b=r+g9LWhwjA8wD3PkveL83PPdDJ1OcBq8R7/+zEfShMzn8r10/dIY50FxAfhh2mV+uX
         Ug1bw2Q4m4amHi/vB5y3Lyw2mPBJLLSKpwdXCNeyMukoEFeR2E0yUFUXTudedeycwIMc
         mQbZMRHuvfbbHAp4+22MsJqJPUEx2IL9DlvCgIpCc8EureOJ2nAPQmrYx8oC4BweeK5Y
         ywV9lcnrN4x69lp72AYE+F7Wm0j42ECziic6W2KKJnaPiNM9IkSTITh2bm18uiXf88A+
         StrDXGmAitnxRUoif6zlMSvUBGGbtrBpcxoqP/778gABd11WGE4yWJRjKHDs1s5D9Yub
         CqUg==
X-Gm-Message-State: AOJu0YwBIO79YuaXjg/HDblC5nMDQYeylpp+JwXNMdQb1vKVkqhlxD+X
	r8eA2iYez1Pi8fHQvNhLW+Zh+fr6hCfBCtXICWs/dlQsVuoWT6tjaXVdwqPCw0/JLfw=
X-Gm-Gg: ASbGnctPCnnIXd44lzCiNTZRiHgsACcq5etlgEDTlhYHZBexQNqdpJNDpH3DbklC6nS
	KGJhMq+PGiWH01aWQcA7wXD4IuUBsHGgbiXtV71NxEh0XTQUNti/39tE7NXYZTuP0x5OH2jEpjj
	0BrdK4IIS5X8J76OYO3RxMciRDOdWAChrzvRTzal2Od5Dfc05/O/b5gc4IG4lksk6ahtkMu7RCa
	rfNFMhEPf7h4nDrbomaH/liDEU19Oly3Xb7CdKZZ8jvlz1IKt2TSbUo0fza06dnuEe0UPrndl/4
	nxevqSAdqqHilC0sn+LfGa/jjOXlg1SxUYafgqDUu/Hb/mVO4ZtS1FX+ZKroP4qg17gncIChiTO
	eO05COeZOgqoy
X-Google-Smtp-Source: AGHT+IGkneH4QIXyNFolLUejPFD134e/mdDVrBvyxRO+sv6a2D5M62LnEE+ZbZl0J6vMwf05VMVaNg==
X-Received: by 2002:a17:907:8689:b0:ade:44f8:569 with SMTP id a640c23a62f3a-af61e533cdbmr151181866b.42.1753436601419;
        Fri, 25 Jul 2025 02:43:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:fe])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff42a34sm239364066b.136.2025.07.25.02.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 02:43:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,
  Daniel Borkmann <daniel@iogearbox.net>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Eric Dumazet <edumazet@google.com>,  Jesper Dangaard
 Brouer <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
In-Reply-To: <87tt31x0sb.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Thu, 24 Jul 2025 13:53:40 +0200")
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
	<20250723173038.45cbaf01@kernel.org> <87tt31x0sb.fsf@cloudflare.com>
Date: Fri, 25 Jul 2025 11:43:19 +0200
Message-ID: <87frekwqq0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24, 2025 at 01:53 PM +02, Jakub Sitnicki wrote:
> On Wed, Jul 23, 2025 at 05:30 PM -07, Jakub Kicinski wrote:
>> On Wed, 23 Jul 2025 19:36:47 +0200 Jakub Sitnicki wrote:
>>> Now that we can create a dynptr to skb metadata, make reads to the metadata
>>> area possible with bpf_dynptr_read() or through a bpf_dynptr_slice(), and
>>> make writes to the metadata area possible with bpf_dynptr_write() or
>>> through a bpf_dynptr_slice_rdwr().
>>
>> What are the expectations around the writes? Presumably we could have
>> two programs writing into the same metadata if the SKB is a clone, no?

[...]

> Taking about the next step, once skb metadata is preserved past the TC
> hook - here my impression from Netdev was that the least suprising thing
> to do will be to copy-on-clone or copy-on-write (if we can pull it off).

Now that Martin has enlightened me [1] how things work today for skb
payload dynptr's, I will first try to follow the same approach, that is:

Make a copy of skb metadata before the BPF program runs, if the program
may write to the metadata.

[1] https://lore.kernel.org/all/0190e181-c592-454a-a99b-5ec361ce84e9@linux.dev/

