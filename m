Return-Path: <bpf+bounces-41378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102919965CE
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F508B225A7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0739C18DF65;
	Wed,  9 Oct 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fTMch+0M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434F18786C
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467211; cv=none; b=HFLmkjuYuwIQb5HKf+VC4T8ExJzD1/8IN5ueD4jDxNsZhnHj4uKbbkIQypKmZTkp6cXfluOWyP4RxcVFtQyrlkKPa75jmxfCDcq8MPP5avF10PZRWUYqzW15MTRcA68uAecZV4lzNcD92S9kO/An8GmgSXYdxG/h5ZMj8DXsdDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467211; c=relaxed/simple;
	bh=53Nh+bEplBVbs0zV/cyO8t024zexodrxGsQttn0GpW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A3xBIDBGEsWAiD2P35S0/DU6u3y8h/dsbg78NygR08rcCuLh9kJEPM51ea/f7kfHWCRQa1h5quZP8VHsZleBnFrjeFvmBj8ItkkkIC0mtl3pGNZ97LRViYKp+SgMSEGFFfWkTm1A/C2XxL3zKnhLyVyuRW15Xu/m7jsA1fo7LZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fTMch+0M; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c5b9bf9d8bso4612267a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728467208; x=1729072008; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhZgnFyuM8SgvpJoZRKyHqTXMMEi3TdG50jgPEoCE7E=;
        b=fTMch+0Mxr/Iag+OB66CkldSWj/syx+mnd0709yhzJcGZ74qbTodypwL1Mm+icOlBN
         nKEC3/TSGsiASBNNUdevC7vTkOkmmSCURItSkaWgYGc3W79No3thgV9fxGKZTg18RS/L
         Dt3mPobpCyJ5K2tISnTYc5A1X/KuFPul8jFrKLs2cGQcHNm3Tz0EB7ZaUQ/XJUskTv8A
         /zqlvt4gxTNyJFTdjv+pyIR/iWy2Co+DPBPVYaClCPIhgTckmtO2LdUz6PEJaF+H6RbY
         z4/PD846LS9ay2DBO+5mhn7gBDNNQ/SjSvTBOa1JgfkrJRXaDaPCpZqp6nV3VIcau4SM
         oaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728467208; x=1729072008;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhZgnFyuM8SgvpJoZRKyHqTXMMEi3TdG50jgPEoCE7E=;
        b=ScUPrP2TB5AJsbvEbLQXbF8Ejb6pbTmm/A8CTUXbmQMTjxgXhs9hFWYTofP/m/035/
         TPb5VL1XbHO1+RGuGcWLhSYRVF1hkrhov2ZEClt5nEs70q+/MQj11n79oEDjR65gI1yz
         wxGlvwih2KhEbCipKL/GodbGiaDNXDSh964ikyzuORCNblg7aNS1p9v3NpNLwfDESpkS
         S8gR/TU3WxgUjudnGi7APmHsqJE53qWwufxDbOZWElDCDSTa1noYK4vD6bhg/dx8th/7
         IgYjJcp0WWisHPLRXjjKra3aHn1T//aUeeBGIoS2rFRabNMUUN53D/TY2tnQy3A0n4gY
         tgtg==
X-Forwarded-Encrypted: i=1; AJvYcCV93P2u99oyRgni9ajverFPTFaxKYzZHYs5F0FuZtFvvRIJfnTe4x5PKrZts+KagJf8hMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/eAJDEEac9p5LeyK2R62tQFCS/l/EASendt5K9bEWqHslX6q
	B+iy0cgSfftGGlKLi6gIZWaBgFZ1jlNblKfHKNDPH6IXhZ4Q0TdCrAVl4FMFg5w=
X-Google-Smtp-Source: AGHT+IG4cNVjOEesVWSACXwwQY8hX5Stv0q/oZHMaAlspaJFSGno3IILGnC/kciYx9ypFzzo30mTsQ==
X-Received: by 2002:a05:6402:13c2:b0:5c9:1beb:b971 with SMTP id 4fb4d7f45d1cf-5c91d624472mr2200554a12.24.1728467208199;
        Wed, 09 Oct 2024 02:46:48 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:1d6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05940b1sm5282163a12.9.2024.10.09.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:46:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
In-Reply-To: <ab60e5c2-90a1-43c3-936b-10520c751dfb@rbox.co> (Michal Luczaj's
	message of "Wed, 2 Oct 2024 10:27:40 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	<87y159yi5m.fsf@cloudflare.com>
	<249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
	<87ttfxy28s.fsf@cloudflare.com>
	<42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
	<877cccqnvj.fsf@cloudflare.com>
	<e78254c5-8f2f-4dc5-bf81-401caefabdd1@rbox.co>
	<0d4edea2-f989-484f-88bc-d8fb6acd7572@rbox.co>
	<87ikuh78z5.fsf@cloudflare.com>
	<ab60e5c2-90a1-43c3-936b-10520c751dfb@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 09 Oct 2024 11:46:45 +0200
Message-ID: <87y12xy5fe.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I'm back after a short break. Sorry for delay.

On Wed, Oct 02, 2024 at 10:27 AM +02, Michal Luczaj wrote:
> On 9/27/24 11:15, Jakub Sitnicki wrote:
>> On Fri, Sep 27, 2024 at 12:54 AM +02, Michal Luczaj wrote:
>>> ...
>>> Here's a follow up: my guess is that some checks are missing. I'm not sure
>>> if it's the best approach, but this fixes things for me:
>> 
>> So you have already found a bug with a negative test. Nice.
>> 
>> Your patch makes sense to me.
>
> Great, I'll submit it properly.
>
> Another thing I've noticed is that unsupported (non-TCP) sk_msg redirects
> fail silently, i.e. send() is successful, then packet appears to be
> dropped, but because the BPF_SK_MSG_VERDICT program is never run, the
> verdict[SK_DROP] isn't updated. Is this by design?

That's curious. We don't override the proto::sendmsg callback for
protocols which don't support sk_msg redirects, like UDP:

https://elixir.bootlin.com/linux/v6.12-rc2/source/net/ipv4/udp_bpf.c#L114

The packet should get delivered to the peer socket as w/o sockmap.
I will have to double check that.

> Also, for unsupported af_vsock sk_skb-to-ingress we hit the warning:
>
> [  233.396654] rx_queue is empty, but rx_bytes is non-zero
> [  233.396702] WARNING: CPU: 11 PID: 40601 at net/vmw_vsock/virtio_transport_common.c:589 virtio_transport_stream_dequeue+0x2e5/0x2f0
>
> I'll try to fix that. Now, the series begin to grow long. Should the fixes
> come separately?

Thanks. And yes - if possible, better to push fixes separately. Because
they go through the bpf tree, and they will still land in the upcoming
-rc releases (and get backported).

While improvements go through bpf-next. Of course that sometimes makes
life more difficult if the improvements depend on some fixes...

Not sure if anything from bpf-next gets backported if it has a Fixes
tag. We can ask the stable kernel maintainers, if needed.

