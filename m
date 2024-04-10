Return-Path: <bpf+bounces-26447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4D89FB96
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DF9280FDC
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED2216EC08;
	Wed, 10 Apr 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNyu4NcM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86415ADB0;
	Wed, 10 Apr 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763058; cv=none; b=EwdvePX0uAJj3J3orchARYHCp1JbDITB4kHnPaskUzdK8Zm+mZhH6JYQXWSUzosaVEAhkLXs+4Zj5mdqnWKxNCvgC8NaeYEArC6kBVAHkflTYrLO2ptjHDx0Rdztp1WhZj8Pvq/PsM8RkYRzfSYop/mXm21z7Rh11HgW5/lDSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763058; c=relaxed/simple;
	bh=OmeHXoy2ncpoQhQGyEMX/xcVd8Rz4jLJzk0iOK1XF+w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=isr25YgUk+Qw/CvrBkMT4rTRvop3twJsy99nL0y5Ohs+BLUDH2Q8riNR/Uj3S3Oruxq5DyZmf1nMv9wQyq4ax6qgt0xSeM2YwHW9/Z7u412bGeXaXTO92cw7IGHR7CgHeGa19bNDJWxpeXucC9LwnA6NYj5LEmiTTO67drz7a9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNyu4NcM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d70890182so147319085a.0;
        Wed, 10 Apr 2024 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763056; x=1713367856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xU1hy2U0mJLbOe7yjnAS91sF71BnTGdYJcXm1GozIKs=;
        b=eNyu4NcMjqU3NSgFAwmiRI+fIsLMWLpcHQ8/HOhC5ez5ZHCFXblARQmb9ADbtwM/V4
         utXpQsiyjg3khSonupaCbaiXXyVfT0xBs+7nyYBY8h+xO+DB5HV6UAVERYl1FrQNpfms
         MMK06NHSH39I8CI242QoK+nxa0yHzspLwHy2sqLI2oFG6oXiuaRYpKkJzXxbRPLbYXyT
         IWik5Jt0RnfJBySaC8mK/NK8J+F0XBKO22VltC1TEVLAUNSuyxp1hxkIr3ikWnW/n07Q
         o6f1slrMTuxqwrJJ3s/W9uhF2rhHAASdq3/1OYNuCxE9gzqEjI6/TMET3N9r+cRoXOOI
         9bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763056; x=1713367856;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xU1hy2U0mJLbOe7yjnAS91sF71BnTGdYJcXm1GozIKs=;
        b=XgNj3NhTsLVLsNOiK+93mLUU3ruI+qq7qw+s/nVXoWD13EsUFGgir5f03UohT5QJSC
         IQEw6gqg/YjgA4wBD2Rfy0cuDVNDipKs4cCnKr9PEpjq3IrI13JXAAEHWP6mp/4SWrVW
         ZGQ7RyCzQrYrsdQsASqPB7SOFQt/bvGJF4zdvfwoSKy2UUnnbPC+mNIpagmBy2M9AVAv
         dxhPeACu/VGevz4qut/+9HwCCIpFL+6xgzeTmdoNI2E0YKUMLiRK2iH29HxoiqBjiObA
         7YtTn6Vf8ghYfmzvji5RHdE9k/O1YgGdBWd8FksbdvGgiTi1BvFT1eyUr5KUsYpOOD2b
         Y+7w==
X-Forwarded-Encrypted: i=1; AJvYcCXyP9113+bTaSlJqd7uxzuDv/dwgRfT74ZhpTYNkT1e+BRoJ4Pfr5Zy5FAFNq0zNHzdzdQI3SV7EBV4H9Zat06kmJTkhUey+cbm6KgTjDFoT29vdUgPQmQeB9xnH6kH3zKhRl1E6z796f8mdK48DI9KGHMeNJc65rJO
X-Gm-Message-State: AOJu0YyNWzieJfS0Uo/J9aSV2GgThDgai75XZAv/64jwz/jFaQETxKWX
	V471waYkNrByXbJk/T+TfLsYH0ZZWYS/+35F61fc2zu0PCZPk0JhhKXZOdCO
X-Google-Smtp-Source: AGHT+IFB+pgD8hxrIKgTzP3YjtD2OHAGa1mQ96FRMdZOBBQ0cIFvN5fLEXa221tsnI1J0I6dPOl+cA==
X-Received: by 2002:a05:620a:e8b:b0:78b:d75c:f9f5 with SMTP id w11-20020a05620a0e8b00b0078bd75cf9f5mr4407896qkm.38.1712763055865;
        Wed, 10 Apr 2024 08:30:55 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a158700b0078d5f7b9a2dsm3952197qkk.15.2024.04.10.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:30:55 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:30:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <6616b0af63eed_2a98a52947e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240409210547.3815806-2-quic_abchauha@quicinc.com>
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
 <20240409210547.3815806-2-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v1 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> mono_delivery_time was added to check if skb->tstamp has delivery
> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> timestamp in ingress and delivery_time at egress.
> 
> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> extensibilty for other timestamps such as userspace timestamp
> (i.e. SO_TXTIME) set via sock opts.
> 
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> In future tstamp_type:1 can be extended to support userspace timestamp
> by increasing the bitfield.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
>  include/linux/skbuff.h                     | 18 +++++++++---------
>  include/net/inet_frag.h                    |  4 ++--
>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 +++---
>  net/core/dev.c                             |  2 +-
>  net/core/filter.c                          |  8 ++++----
>  net/ipv4/inet_fragment.c                   |  2 +-
>  net/ipv4/ip_fragment.c                     |  2 +-
>  net/ipv4/ip_output.c                       |  8 ++++----
>  net/ipv6/ip6_output.c                      |  6 +++---
>  net/ipv6/netfilter.c                       |  6 +++---
>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>  net/ipv6/reassembly.c                      |  2 +-
>  net/sched/act_bpf.c                        |  4 ++--
>  net/sched/cls_bpf.c                        |  4 ++--
>  14 files changed, 37 insertions(+), 37 deletions(-)

Since the next patch against touches many of the same lines, probably
can just squash the two.

