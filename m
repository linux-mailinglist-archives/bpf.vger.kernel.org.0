Return-Path: <bpf+bounces-41054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFD99170A
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F604283765
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0122B153814;
	Sat,  5 Oct 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gfBMZIdl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313F144304
	for <bpf@vger.kernel.org>; Sat,  5 Oct 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135551; cv=none; b=GXvdc6IxeHcFO+p9O9S58QIt9k3yBk6iTIorfr2D1nZJnXKPmHV5BZdYLuIxRBgf7UpQdD/IJkuG1kgmFN30gSCoxEs0Q0N2agELCNmnUbGFDMvs3kvYqCnb7ZqEatlbiOVrINE8/59o08j1D14yely/VadTlqZ9wlgw+LMPcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135551; c=relaxed/simple;
	bh=vx61nTUiy/bm/RymhFeeZJDBaHJiPhMhyBJD8nJZhRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0MzLGGclcuG2VLk7DmSo4UX63nh7efj+pVsrEVTsTk0H7fbatrMUABeNmMNvb9iyBDJpEy/6zFDeRwmuqy1hNg7V4Su7s/mPcSDmPuSvvLKOPFr4MjMTRAcA8DaeMENZCDWEPBxckzOF+fPWm+f9VYiP3tnjeV3TrRRkkiF6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gfBMZIdl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so2065020f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Oct 2024 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728135548; x=1728740348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/dF33eO2fPkKtvVNP+hncddn2BTTRkmXbCUnjM0ER8=;
        b=gfBMZIdluiPgRj7sPs4VT7CvACHTXo07Q5TrPgasSK3mPd5p8SjdG9PUd3yc3FQiV2
         5/3LSMMBiMyLdJBJC/m9+2l70NPngnzVQ4LoxT6q75ke8ZZzeD7VV5m1z0MvnCwsgQbd
         qKf+FF2tbBndDYkBC/Djje/RcyNP1T45bBRay4o7unso5trfPmmuuXVrHLBALKBfkjdP
         fRnoofN8s38RO5DiGfq0JlASAs5RQyld77FEPiLyjdHSdE5ruI28JZ39A/pdbv/WEfv8
         QFrlnj4J5KoNcHebIg3oCY1Znw4gql3lNBJVLB1/dTaWU7elmUAc7RxHdy9aQkWW0i7c
         WY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135548; x=1728740348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/dF33eO2fPkKtvVNP+hncddn2BTTRkmXbCUnjM0ER8=;
        b=j1FkmpdjfXM8YUD1z3TBRACe/T4l6NkgpbO9+cyiOZ0d9OZxL1GdsLFO8NA/iiu6PL
         vAea//n+J+8mcUQMSiQmwkDWtJO0Smu29D/qDZSswOpDpqwA8xIPUGOlhF/JNPRgr3rl
         QizOHHzS5USYKHwWZ4EbrLuHR3V+sVztJ+GVr19mt1opJSwpxRrUcfSyPknHtrZ9GvsN
         GTiAxw8LKqAyaZeumuzolqY6XLLSdB8GQT++5Mi5iiq8FLaAl4p5ApwBhFXSj5uJWN7e
         YPHr7kJshJgbUBRTbSTuSdLY4N7yW9Eq25HXU9FcESxD2Ibbj3+IsVdZWBvTepbScmRL
         3wMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsuIdgk0iIIBaql7aLx25Fi8REw7brG9hdZgJRjSGWrg8YMEXAVnVRU7UYvb5kCjk3ifA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClAlz/hAdheZcxKO19AreV+iiojNMHBZDi0lahnJnxgG+k5gv
	3+hAoGeBCybzC09yWxC5BoWz74oGBb5PmvDZS7WL7Sec/Su6+siLhEFBodQjKY/1Ljr7cOTQkLQ
	vPwEkUA==
X-Google-Smtp-Source: AGHT+IHAcND2zQZhwZgfqvFBFNQwW8yZADDKeTEwFcXg00awgC/UaNKSTY5pg5KolWmet1yhJnqieQ==
X-Received: by 2002:a5d:64e7:0:b0:374:c040:b00e with SMTP id ffacd0b85a97d-37d0e7d43c8mr4506894f8f.39.1728135548423;
        Sat, 05 Oct 2024 06:39:08 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1688a486sm1820098f8f.0.2024.10.05.06.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:39:07 -0700 (PDT)
Message-ID: <2339263b-4348-4b00-842f-bcd2ac89c136@blackwall.org>
Date: Sat, 5 Oct 2024 16:39:06 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Extend netkit tests to
 validate skb meta data
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: kuba@kernel.org, jrife@google.com, tangchen.1@bytedance.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241004101335.117711-1-daniel@iogearbox.net>
 <20241004101335.117711-5-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004101335.117711-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 13:13, Daniel Borkmann wrote:
> Add a small netkit test to validate skb mark and priority under the
> default scrubbing as well as with mark and priority scrubbing off.
> 
>   # ./vmtest.sh -- ./test_progs -t netkit
>   [...]
>   ./test_progs -t netkit
>   [    1.419662] tsc: Refined TSC clocksource calibration: 3407.993 MHz
>   [    1.420151] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcd52370, max_idle_ns: 440795242006 ns
>   [    1.420897] clocksource: Switched to clocksource tsc
>   [    1.447996] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.448447] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>   #357     tc_netkit_basic:OK
>   #358     tc_netkit_device:OK
>   #359     tc_netkit_multi_links:OK
>   #360     tc_netkit_multi_opts:OK
>   #361     tc_netkit_neigh_links:OK
>   #362     tc_netkit_pkt_type:OK
>   #363     tc_netkit_scrub:OK
>   Summary: 7/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  .../selftests/bpf/prog_tests/tc_netkit.c      | 94 +++++++++++++++++--
>  .../selftests/bpf/progs/test_tc_link.c        | 12 +++
>  2 files changed, 97 insertions(+), 9 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



