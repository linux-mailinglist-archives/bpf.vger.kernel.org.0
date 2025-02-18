Return-Path: <bpf+bounces-51837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A92A39F4A
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B219176892
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6726A0BE;
	Tue, 18 Feb 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwF/y+Dy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150DA269D1B;
	Tue, 18 Feb 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888678; cv=none; b=pUO5rK3Vz7dHT5Kr8QblwnWWWMu/kdGrRYta10qJXEgZrH6FuzbeB/9MfMtlwjZVJW+UzAgiizdrKxsyfskwVLnELRhbZ7FQICgZQW3mkMdZeYha/vJ2ecj5i1WETE+g88NN53CsaSAJM9d0az5Bvb7xDljBagGW5gwjtvjJjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888678; c=relaxed/simple;
	bh=YeJipFhnjPvdmFYYiHM3c3wMbeQjj18FvySZXqAVHNw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZCLcyyh+2u3F61WAl7Y8/m6KJXlrypFBgDzGXGFWHGdc5VvhjXzdzSQwphJ8rH93UQ+eoeXI27PtUCL3YwEo/cvdSRnQYk8HdrYWBSnJTD9i+CL2/wrm3n2H+HjuJM/DeNlRn83nlCDpOme9jRJztSVO2W2qA7Jh9zuWjxhoZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwF/y+Dy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso98893676d6.2;
        Tue, 18 Feb 2025 06:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888676; x=1740493476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vWkl2BhkgpFMhRsLcmKMf5jp3jrsmJ/ovnUGJaweqY=;
        b=GwF/y+DyJ/ME2IV4SQE2dum5wZXCDJrfZQufM0r1yfxM32Z45kgD+IMlnQpNY9zBmW
         U5jy9X99cW/i66bJ6V2LrKhb4nZ01CtEMJc9jj7R3ZKGOBoLC9w1aDExFsZXWoqxXwN+
         LnZpdM07LN/yKBIGtDr9Aw5H7YG96ayUZvI9zzHpjhMgin46n2XxcCa1wL0Z2sH3kit+
         FePhgdU+9IHPcBUhfQEfjeY393e3pc348ZCPG818Y1tL5Zj0nlQQn7kVdF253wHv9neU
         1P/mX1y8TSgC+iKO82LLQQjG3OR2EpJX5siijqJufRoPBBJ3Q2ETQLiXSugYJb3clxWj
         InHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888676; x=1740493476;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3vWkl2BhkgpFMhRsLcmKMf5jp3jrsmJ/ovnUGJaweqY=;
        b=wgfPdOEAhNCIfLlPlveloda9dy6dZgFwIz3Cl3WjT5f0QpjHP1CgrIkJq0mizksGl0
         VMu+WvDRfwMPRQd3IA8CxLgZ5ip/IFeEvGmsncftQz30Kwl4b180Or3brkkVF68sqTtS
         SAlfA6C4KuPs64KXacWJA4USScTxY+hErelOP0VKjX1Ot0rNCV2QZkiLrfpdANF9pd6T
         Js7M1qQv1f9NJjY16rLKkW2qvuIy2j9Ay7zclmezOxFqsM2tHKNIN9Fnb2NMHB7klpS+
         fjBKubkZH/8eWqwAfcot6m7T98W1eflSykKfVRt3oUzN2YrP3UM6gIeP9H2H4Mvb5xAa
         2NKw==
X-Forwarded-Encrypted: i=1; AJvYcCWCcTYeC/Y7YGz0er0w+JI/fQQe7iN6r+Q1nHIX5RO6PQtBIN6THKUhIzb6zxzo/6eNH02z4V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpT34AyVOTijypEr0u2G7jowcb4+XB5ggWclaI2jyoHhAXZNl9
	+0x2eD1jmMn3GfswJ/O2zN5jnkzaaKINaprbtW0N5aQmYrqS60LK
X-Gm-Gg: ASbGnctl7GTY8IKU3LuK2jOzc0HbcmU7zCV2NClcT06DN20/swZAuCflZIqK5Hk94o+
	dqSiF5jhXQoKPh+z17Yycr3KwBv+tW6wihEQjeItlMRQu9UydilEDse7hQSnD6G7Uc7l22qqtm2
	EEnvS9wpL6OQy0kB90TYTrGyYJnCzlAXxFZynClSmu6tFFfEYC3AaSwL22vHj8SWXuDEXM9QOmQ
	rFLUOu07SzfzmGkCJFjUCYKXheGv4lJuPB6OvghBTy97A+V79dhLpB6kdArKQ7nZC9SK0Kbq3A1
	g2eDCq10J2HzSzk4AC9ZD6P2unAu/TFJGk+qIiAz7kYFFVfl+zkaIh7wQ3e68ak=
X-Google-Smtp-Source: AGHT+IGHISzOyCvRn2/LNkTv3seoFIXUTLYyDmkHEtsHHp6sALdoPHQTN/t8Ii4k93FkmKsW5bDWNg==
X-Received: by 2002:a05:6214:194b:b0:6e4:3fa5:468 with SMTP id 6a1803df08f44-6e66ccdf337mr177751186d6.24.1739888675949;
        Tue, 18 Feb 2025 06:24:35 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77936dsm64386516d6.4.2025.02.18.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:24:35 -0800 (PST)
Date: Tue, 18 Feb 2025 09:24:35 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b49823437e5_10d6a329419@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-11-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-11-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v12 10/12] bpf: add BPF_SOCK_OPS_TS_SND_CB
 callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> This patch introduces a new callback in tcp_tx_timestamp() to correlate
> tcp_sendmsg timestamp with timestamps from other tx timestamping
> callbacks (e.g., SND/SW/ACK).
> 
> Without this patch, BPF program wouldn't know which timestamps belong
> to which flow because of no socket lock protection. This new callback
> is inserted in tcp_tx_timestamp() to address this issue because
> tcp_tx_timestamp() still owns the same socket lock with
> tcp_sendmsg_locked() in the meanwhile tcp_tx_timestamp() initializes
> the timestamping related fields for the skb, especially tskey. The
> tskey is the bridge to do the correlation.
> 
> For TCP, BPF program hooks the beginning of tcp_sendmsg_locked() and
> then stores the sendmsg timestamp at the bpf_sk_storage, correlating
> this timestamp with its tskey that are later used in other sending
> timestamping callbacks.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

