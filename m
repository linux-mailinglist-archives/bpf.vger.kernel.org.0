Return-Path: <bpf+bounces-21564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042D384EE0B
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F0F1C22BB0
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0AB50271;
	Thu,  8 Feb 2024 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJMtb5Mx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4063233
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436218; cv=none; b=RF3fjUMO8HMLfV3Arn4NNKMxuQ40FQQy/gg52195yT8SgARhOkRPuQ09Z9yDFqRAdkb/4XRJQVZ2jHklk55DFyO0wB0yZBFZrEhOARSaMSILL6jhAbcmnz0MHRXB2zIka52ZMGRP5FmkvK2d9TNyidu9genDg/v8E/vmz3CaYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436218; c=relaxed/simple;
	bh=LVXcmrG4GimbA1v5i+2uyDmSSouqKlEqGUxy5hGp7lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/R6jf9gs9ROAV0hFoIQ00FUP37aAST0HIzEpxCmRiMrlk2MyDCoQ4KaMiduUjeIMlbe69WVP+LBhYBmOIrDwlzmdeQ3vWc429/sKw4L8PugSwvaym3oIiOfzWU6gK2Wr4G8dg+GQmrzQu+4KrEr7ULZ/Deo6KPqsVaZFfxKS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJMtb5Mx; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6861538916cso1988806d6.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 15:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707436215; x=1708041015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDa7AEoj173aQ+0nqq1TchEGoZbLfCamhjoFW8Psx6M=;
        b=zJMtb5MxwD/evgdnTTqAUKIbZ2wPN2VIikhIznbFJnXQqBCPM5dRl3A2iuwn2m5TDT
         C1V/TPRjefRlgy3JNlSSHWFa9TB5YLW71NplYqe8PRL7MNYa5HfFQRQRb2ZH9pA2TBkx
         oW6GN8ugCFvwIOOhdDFodbCCgSmZUtL8vE2ZO60wy2p9AUy9E+cRO2xAV8GLnQ57Uf40
         ekvces66jzqdnBPHhXXO9qjh4ZpHKEZMV6Nf+NrFNSOoxTTaiZUamPyLTmBaZSwNk9is
         0y8gCYjO5MJwJoqP8hkfFcdDPEZzKXTg44DScbO5v1CiJtgt8+YkDBexpXkVg1jQJLp2
         Zu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707436215; x=1708041015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDa7AEoj173aQ+0nqq1TchEGoZbLfCamhjoFW8Psx6M=;
        b=W5mwE/RhmCKaVLEbpw+HQIxSAYucM2IliZ1imeWPfTPsVHlN2JTLQ4qWwTw8k+zqDd
         73yyoaVOHKGVjVhaKGUcOAKmYX4yVh7EzZalopaPS3NR2nt3n28J8S6p17OdkcBvLpzR
         /ZNRhlHUQGNVX0ajVgWHcUqXOk65FfA4ByARtNC6XnVP0of3HHWmSFP4/2+87jDTo+aa
         fEANmeBw1mqmOfX0YPcEbL4YTr5zNYc5TaK1YYGOxmfCDldVd715VvJnL2BoZwJGOjt1
         KltYKpUjRPP1FGrfJlKMimyO/vwDPxDg8uAaK80iu+EtfW3f3kEkhNCYxF8CHolG1yhe
         2nRw==
X-Gm-Message-State: AOJu0YxZtwBCfwYAbrUEcQNjewumFnHJC94s8MQ4/jB6eDG02LbIEM4Z
	W89xcqYr4MDGRAli1T08AncyL+rc47jUDI6Xc6426dXvVclNxf0dzokQaSzR+w==
X-Google-Smtp-Source: AGHT+IHDgPxLeyIYAShMAOKyTQmwrRns3XsDqJA84Sx1OsvfowKBKc5OFJIg+veVeOK915RvEjuNmw==
X-Received: by 2002:a05:6214:2aa6:b0:68c:c0bd:9bd1 with SMTP id js6-20020a0562142aa600b0068cc0bd9bd1mr817995qvb.16.1707436215507;
        Thu, 08 Feb 2024 15:50:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkh5eROPj/tMsxYKWDUZ4JNsq6FGB5eqjbpYTO5x77d3PM0Jl3gYxtuth7kHjBOIfVoGKWDcHrt+t802Tny4IsTDJb7AGfqUo8SvuoIkVrYnZerC6lT8RLWUNgYj1K+WHkNqr/bUadyPhI/4VeZOy5YURcfmTDnGWK3i+j6sUMUpqV0IMYfIWR+zIaRRxyOXrOt+CWBgXFK8OUf765ravKIu5O5rxUi+le7gduFx2HM/kUmNDT4+Hun0Yolt8bj7aQ0S0hPd0ASN4gAIegPfVU/O+VEJIGXVswXS+MSMU=
Received: from [192.168.1.31] (d-24-233-113-151.nh.cpe.atlanticbb.net. [24.233.113.151])
        by smtp.gmail.com with ESMTPSA id e19-20020ad44433000000b006848cc2817esm275036qvt.33.2024.02.08.15.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 15:50:15 -0800 (PST)
Message-ID: <90cbea27-8752-403f-9e0d-3aaa19100923@google.com>
Date: Thu, 8 Feb 2024 18:50:14 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/16] bpf: Introduce bpf_arena.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>,
 Kernel Team <kernel-team@fb.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-5-alexei.starovoitov@gmail.com>
 <c9001d70-a6ae-46b1-b20e-1aaf4a06ffd1@google.com>
 <CAADnVQJJ7M+OHnygbuN4qapCS8_r-mimM6CLw5oee8ixvmqg4Q@mail.gmail.com>
 <d4024acf-97c9-4a16-ac70-739d0bf81a45@google.com>
 <CAADnVQKejmHGDUAuRA+G2Ex0=+FcmTpVZ67DEZJHLjCMckx2xw@mail.gmail.com>
 <b1fe20c8-cd97-4ffc-8043-7fe42bf18c77@google.com>
 <CAADnVQJsbZeJCmyQbL-CAX7b4KgBtw_carPihOV_tG7nna=W4Q@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAADnVQJsbZeJCmyQbL-CAX7b4KgBtw_carPihOV_tG7nna=W4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 18:36, Alexei Starovoitov wrote:
> I'm inclined to tackle wrap32 issue differently and simply
> disallow [user_vm_start, user_vm_end] combination
> where lower 32-bit can wrap.
> 
> In other words it would mean that mmap() of len=4Gb will be
> aligned to 4Gb,
> while mmap() of len=1M will be offsetted in such a way
> that both addr and add+1M have the same upper 32-bit.
> (It's not the same as 1M aligned).
> 
> With that I will remove vmap_pages_range_wrap32() and
> do single normal vmap_pages_range() without extra tricks.
> 
> wdyt?

SGTM.

knowing that you can't wrap the lower 32 removes a lot of headaches. 
and the restriction of aligning a 4GB mapping to 4GB boundary is pretty 
sane.  TBH doing it elsewhere is just asking for heartache.  =)

barret



