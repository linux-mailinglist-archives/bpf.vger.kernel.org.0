Return-Path: <bpf+bounces-51477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37EA35247
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824073A6F6E
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AEC1C84C6;
	Thu, 13 Feb 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzJo5Y0M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193142753F0;
	Thu, 13 Feb 2025 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490098; cv=none; b=J5XbNbHlLm7KNdKtCRb7UEiimIJMmWXEqvCFKtxGU22QSSAPcqK9ajypf1iNvdsZBZ2h20C7JvZcBkvxlDJYiylFa7t1yCChul2IoUP6cs6/d88rK96J1mJSIJBGMiGqgDRMCxfyxlwILI93TI8LGYmLqncNPIXIbCaR3wMgrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490098; c=relaxed/simple;
	bh=69bgfL79EtYABnUOR+2B20GcFI3cjghO+ZPEpsrMEnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2Iaa1jby3z56e1hItkDKdYlg6CSB3eViQ7QJmEcBwbd8R19LxDqsLeVXLpLLoUNAuTZIV8yrjmestnEwK/n3WKh01DQEWvzN7ICHvVMNLdAP2Wk5QkATGnLE2J/WGnKkQIOMC+iTfcvBntuBdhFRo6P9IgEvFrWQ+QE4GBX4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzJo5Y0M; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa1fb3c445so2185227a91.2;
        Thu, 13 Feb 2025 15:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739490096; x=1740094896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1scvCVZwMwJn/9zZz7ks0bVGPap0HlXAYoHcfoYPGw=;
        b=HzJo5Y0MNAqyKckAWefnYE3tr/Ry9nINy1WYGJKek9g3K3JFXX5FJRDYv/+NZNt845
         CqYdIeKw9uoMAnqS8n0xanJMzZfTDoehzYBoxWouUCAyTILA4wPVoX1luoAhnteKLPKC
         BRUh9v+y6sOI8LZXvJugGg0/aB4umvJAVFkToI5sAcf9SELOmz5W3wJKMHSKx4N+/7Gv
         5pKW1ID4lqkK01XL3m5x6eBrW3fNWLRC+tS4iCBPxMHYOQ46dqHWum3vypFvWdXn7M2Q
         RCM+8e2BhDsR4uqApWtyVQO6TOErjuUTmS9seM4xb/ET6y4TznCidcAc8eRuLBVGc+48
         H27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739490096; x=1740094896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1scvCVZwMwJn/9zZz7ks0bVGPap0HlXAYoHcfoYPGw=;
        b=K+PnsWKLw6L72SKpkHxyw0wQVGrCycH/WC61um8a7NRi4sV/tgxsMXmwIPcsSB4Svy
         M2vD+aetSeRkAfQd3jDkRqVfQrQc6cOfieLXOW3Js97WsN0GVdiuLzV7U8XCAIGZeoko
         39+KBuGQZHUPpqZ/SIULuZdUsGvOR1gvHzgnx+I3QkkrubFPLADr6kOAgpSl2ih3gbZ1
         8ufq/uX2IIX4nu8tvxFdgXEbcjtSlLIYR42MBbhMBseiBQBsVGyOV7IKwxKihz94BAVI
         KKWFMgNB06FzNwkFA5BGk9mt/kTlyqVbM9/0JrqI0Sg7AUmnh1eG5EpoBf9g++je3QTX
         AYjg==
X-Forwarded-Encrypted: i=1; AJvYcCVcoD7o8CZWkeu30+markCsP6FKTQxvEn2NTQ8vA8sKwUEEmZpded/9hG/CvN8ytBdGy5me5XBd@vger.kernel.org, AJvYcCXkS/e6wdIfD5L/kpTeY/D07HNhcEzvOYARh4dPSFON6AwbpgGqshjkCn0TCqNB8sQDB5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyraniwBnSwo4VHv/ikvK0FEBYzzridd+IuDn7jDkQg/3hIp1m6
	z7zaXlmbJ/qErtDvxGd9EProTTCJx66KNi0YQivUcLj4fcp5Tsg=
X-Gm-Gg: ASbGncuA8uoclkc/RLb+MkHep8VNenG7qkgIN3BZT+03Jthc54FRqCeAR8IjXebpS52
	SwDHsAI7euJYY11Vb2RRdRBrGe8X59N8m06gGtYBWaCFWYNYN4V6CQbJzm0TqCh5xFnbGYPGWGN
	XKe9fWCH5wqfAdyx9SY/Yg1NOEStr7mmDSjX21Qy0X90KQ2HvbN8bsE9jL0lrt88u5jpd5XJ9pP
	5TkEXDOv7cXTfYYphWA3VnsrCvaK8rhEc4JImqVnf90WoSHPZDjF8I/tzenL70iomcJ6ob/7kNP
	LXSY2CEomLkYsgI=
X-Google-Smtp-Source: AGHT+IGFZakk5cXQKnHsgSVPG6KXD3Jt06z2moDU+ZJD7/lUCli3IpvVzLBZ4ViJSLMBbJ8lsuqaQA==
X-Received: by 2002:a17:90b:54d0:b0:2f4:47fc:7f18 with SMTP id 98e67ed59e1d1-2fbf8f32cddmr13191734a91.10.1739490096227;
        Thu, 13 Feb 2025 15:41:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98b3305sm3842610a91.6.2025.02.13.15.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:41:35 -0800 (PST)
Date: Thu, 13 Feb 2025 15:41:35 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
	ncardwell@google.com, kuniyu@amazon.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
Message-ID: <Z66DL7uda3fwNQfH@mini-arch>
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213004355.38918-3-kerneljasonxing@gmail.com>

On 02/13, Jason Xing wrote:
> Support bpf_setsockopt() to set the maximum value of RTO for
> BPF program.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 3 ++-
>  include/uapi/linux/bpf.h               | 2 ++
>  net/core/filter.c                      | 6 ++++++
>  tools/include/uapi/linux/bpf.h         | 2 ++
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 054561f8dcae..78eb0959438a 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
>  
>  tcp_rto_max_ms - INTEGER
>  	Maximal TCP retransmission timeout (in ms).
> -	Note that TCP_RTO_MAX_MS socket option has higher precedence.
> +	Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have the
> +	higher precedence for configuring this setting.
 
The cover letter needs more explanation about the motivation. And
the precedence as well.

WRT precedence, can you install setsockopt cgroup program and filter out
calls to TCP_RTO_MAX_MS?

