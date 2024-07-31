Return-Path: <bpf+bounces-36170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0094378A
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3E2B22AE0
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DD168C26;
	Wed, 31 Jul 2024 21:07:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91D1BC40
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460076; cv=none; b=pRaoqVydBujdxAZlTOsdtZi80Vv4S3UTbvq0uo+GsQBP6H5InMdoLtzLpXV6JfLTY9lv7J6sXN5V2BJa9fDN9PckXGEDHCt21yCAcS7CfgvKmoRGJHtAWl2Bf9i5JFirGpusMXb98vYnlRgW+xAuIAcZezLZUr2CsOnOWAUWFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460076; c=relaxed/simple;
	bh=Vg7BX4I15Ebz+qU55mYf2oPaSEc7xsvzEDpW9GBo5No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKNW/N/DHGo2zv2JB/XNDnmqefQL5VVzdd9pOYPj2dVTFJEJySjwfU8N+zqdCe/kxrxOBdg84E73ZV7DucBgR5y38+Il3IrhrQg51zIoyXKHu0WDpUMhTGB/IXLqzKcKGcF1rYwMwC7CPYwv0+dhKnrmonvqlixG7rs2LRcnCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d19c525b5so4384117b3a.2
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 14:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722460074; x=1723064874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is/+YRrPLa7tW5pB4h7rtXr1x+OEUFhN4fNon6238qQ=;
        b=bMtXzgOVGuc5OxYLSXfkpoJnwjTs0vbUEZasQfKVn/aWl04TCb2xU/Iq016jitSGsH
         qCrlQPse99ozf82AYqDFDL1l6jcPx+zwA/pxOdvHdMyy2lTbNLIEHM7HliRy3bWcvkGX
         9FcEcn8hBQYGe6MJoFZU/+/NflBd4OSN7EjmEhSfFFtnKCLUVev/bQB1dcyswrTs/QS3
         qSgbb6LVUV7QI+4UxRxssyKuNCjl+ZJ1xYIdnDA+nyTja/pykLN/4Fx8HoAozWsM7X0Z
         LmHFw9wIpPvv9zWOLhUYeATsSBH0VmepYxsG7yT7zswVicUHr4xiBxuIz2Qgk4qybm8R
         uENw==
X-Gm-Message-State: AOJu0YzLwQ2gOMKeCCxszd7xCicEdDAIwgj9E1cfdldKRpej2Jxh40Ig
	b+nK3nM9DX1+zN40dur+bEtUk6xCQ6PdxCvTN8plsTaqL4CZS9c=
X-Google-Smtp-Source: AGHT+IGK4Ykup95HKC3YN2fCRB5bs4c1iqTsZvTk9nCVPPsbMlSRHWBvyDkX/nuNmV4t1+quKS23Ew==
X-Received: by 2002:a05:6a00:1805:b0:70e:8070:f9d0 with SMTP id d2e1a72fcca58-7105d6d5904mr592616b3a.9.1722460074218;
        Wed, 31 Jul 2024 14:07:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead88c19bsm10306350b3a.183.2024.07.31.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:07:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:07:53 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
Message-ID: <Zqqnqfh7uwpufMR_@mini-arch>
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731193140.758210-2-thinker.li@gmail.com>

On 07/31, Kui-Feng Lee wrote:
> Add functions that capture packets and print log in the background. They
> are supposed to be used for debugging flaky network test cases. A monitored
> test case should call traffic_monitor_start() to start a thread to capture
> packets in the background for a given namespace and call
> traffic_monitor_stop() to stop capturing. (Or, option '-m' implemented by
> the later patches.)
> 
>     IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
>     IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
>     IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
>     IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
>     IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
>     IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK
>     Packet file: packets-2172-86-select_reuseport:sockhash-test.log
>     #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK
> 
> The above is the output of an example. It shows the packets of a connection
> and the name of the file that contains captured packets in the directory
> /tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.
> 
> This feature only works if TRAFFIC_MONITOR variable has been passed to
> build BPF selftests. For example,
> 
>   make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf
> 
> This command will build BPF selftests with this feature enabled.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile     |   5 +
>  tools/testing/selftests/bpf/test_progs.c | 432 +++++++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h |  16 +
>  3 files changed, 453 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 774c6270e377..0a3108311be7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -41,6 +41,11 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
>  LDFLAGS += $(SAN_LDFLAGS)
>  LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>  
> +ifneq ($(TRAFFIC_MONITOR),)
> +LDLIBS += -lpcap
> +CFLAGS += -DTRAFFIC_MONITOR=1
> +endif

Optionally: can make this more automagical with the following:

LDLIBS += $(shell pkg-config --libs 2>/dev/null)
CFLAGS += $(shell pkg-config --cflags 2>/dev/null)
CFLAGS += $(shell pkg-config --exists libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")

