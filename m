Return-Path: <bpf+bounces-44048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A9B9BCF4C
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5891C22E2F
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7576F1D95A4;
	Tue,  5 Nov 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbPr7M5z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDE1D935E;
	Tue,  5 Nov 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816996; cv=none; b=UCllQ60hPH8TEPQIJjmIkFAaHBnKt1AvDbfjDGciwKxP0F9ehsuK1NEaw4+bhTPlYSjOdy6IcePICRO413EbOkuTNAsQbVlzqEXLelxTUPml70BK4TwuKgxbj3ohHjV1ouMmNfyPJypMvvxfV4stT0G/i5x9z/XJTQXuJzeUZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816996; c=relaxed/simple;
	bh=Pd+CekwTuj+J3Jg82v2n3aKHqhTdGblerjAu87sV7yM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oQteD9YQ3oDzFNauW5i7PZZHhSxSPcLlHmFD4zIFjCAucsFvVo4fSf5/jIDesPOi4xoFUEncf65Tw6ZPKMvcAGW5PrD/sB79hXlYQvM3lZRjuXREN0+dWrsCVA5woo+UuSKA+foFoKF+ANYqbkjKfrTHKtUP3zI90hLs+b39I+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbPr7M5z; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460b04e4b1cso39004501cf.2;
        Tue, 05 Nov 2024 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730816993; x=1731421793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyUuOVX8Ot1kkh170w0vhBlpeO5oc8Yi4ZvB5NtdXhs=;
        b=QbPr7M5zLXgQINgyW5Nr6wR+Sc2Gxa9/e0IBXuChitf4xvkUFYnkGpvvO72fxYUeVP
         /emgZ1K8S1y+I0n3nx6hqs8vFFJ8dJI0VzhQx3fLzOcoyufpFA/2zs63Bxzx2rfw4d8y
         n+iyGd8O9FJz21VzeOh5t+SvRHtBGA77SSqdR3H6GNdMyavyLYED/krefNmfYJ//h6lk
         QR/URvLxm0WMwL8XnpTAQvooS76WYCv/Yx3j7JQfWzALhbosfcLXzyuDHMjQDjMQycSO
         +Q3zz0uMKcM6rTR0Sw58b4tBEistYcs4u8fBxM5Na7rpbDpOi9XXUhg1fYTZM0rE9PbK
         nDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730816993; x=1731421793;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qyUuOVX8Ot1kkh170w0vhBlpeO5oc8Yi4ZvB5NtdXhs=;
        b=Iu7vvyXYnSSyi4Un+gNYxG4IUjmVgMgyWFQg+ma0F2EMcFxyfHryJvWpQ5KpuGcKmP
         jgJFKk233k/RgDyBhVy0hyI2x0gOO4I7KRns822crAQ4mPywCxRMpEyapLdMR4u6x32c
         1smKlJJa4BuAYBEd/WzbE+vc8UEeb63xPNEVPD7KHZX+C6s/NFa52a6EaAApsPjYTHcT
         i6J7nxyv36SyNat8+iTDieegrCahglYqYMjEREJP3frMSQ3qWU/t/3fUulTEcdGF7bV4
         pvfpbXiy9nPTrRQ+ofDYsEh1QN+BJcp6KTupWZEnvkHTD41HgUZCGmD5aMrKc1s58qx3
         roUw==
X-Forwarded-Encrypted: i=1; AJvYcCU7or+XsurNcUI+CmAoHOSKFa6F6sVMeGTsPXaUp1tMmP2SltCHvy6w5QcsDDNsWea+srifBXXw@vger.kernel.org, AJvYcCW6z965z1dlAISJmkWHG5KiT/5kueW5XC+20VMKjCdmSicrQJlFQrruWH+t17STDXLhUNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0naCUv8GQ1dhrb5nZaNM1uXYeG0xBci1uOq3qSKwo8nrUxNOT
	gsE0cIObLxUQu9LMWEKcXldTUx/8TStMawqwlbDKPDewBwxHdbdP
X-Google-Smtp-Source: AGHT+IEJxJ/9ANOn3xcs6S5Z538cTOHVDXNNSiPLZZKAXznPcJHPFJJL9AGjQpJMzK7/HMhAd4V4IA==
X-Received: by 2002:ac8:5913:0:b0:461:17e6:2650 with SMTP id d75a77b69052e-4613bfeaaa5mr472996391cf.14.1730816993161;
        Tue, 05 Nov 2024 06:29:53 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0c3c26sm59537401cf.46.2024.11.05.06.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:29:52 -0800 (PST)
Date: Tue, 05 Nov 2024 09:29:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: willemb@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <672a2bdff1896_791352942b@willemb.c.googlers.com.notmuch>
In-Reply-To: <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
 <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
 <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
 <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 11/1/24 6:32 AM, Willem de Bruijn wrote:
> >> In udp/raw/..., I don't know how likely is the user space having "cork->tx_flags
> >> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
> >> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
> > This is not something to rely on. OPT_ID was added relatively recently.
> > Older applications, or any that just use the most straightforward API,
> > will not set this.
> 
> Good point that the OPT_ID per cmsg is very new.
> 
> The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags had
> been there for quite some time now. Is it a safe assumption that
> most applications doing udp tx timestamping should have
> the SOF_TIMESTAMPING_OPT_ID set to be useful?

I don't think so.

The very first open source code I happen to look at, github.com/ptpd,
already sets SO_TIMESTAMPING without OPT_ID.


