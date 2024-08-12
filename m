Return-Path: <bpf+bounces-36901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9C94F358
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE101C20E4F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF401862B4;
	Mon, 12 Aug 2024 16:16:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B12C1A5
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479394; cv=none; b=mNDq/kz609xjN9rhUpEMx8zz1r/yrX7oxSIbm1N0s7tIpviJm5gz5rvaxk+ckgzIf8i+7u671ErR+TtShup2lpP6tMsgFN55a0zC/ESsOiSuMtFjJ4kvFT8Dzb/w4qCAZDjgCTyX3aarlcxKuwuQosWb0kuBuDRLIeAYK4qimRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479394; c=relaxed/simple;
	bh=4EusQRT3Xsk9pM8PdBzXze4UviU78YC5m+pNjTDYMns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7aE5wTrxEh5I+6MuA8Q4oKBI+CXKUOSu+FdvEkaoa09IIvBCj9K/5cQoO18n5AubqH+XWEc7aghTxrA5n3dAZc02SW0+xd5vS+Gbu8M6vh3azCt4+huE10dvYguvPmlzMW+9TBdEAqwd3z9wx3+5D97IRmq63w3BMG3mTwmQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-710d0995e21so2840660b3a.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 09:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723479392; x=1724084192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIJRJ0EB0eBET0Bv/bTakmzu0knuTeyeGFzi6YIuog8=;
        b=QTBd1O7Zzi82Ck3xCgxxWCsuvvVzsr1SWVxsaW3j8w7w+XsHf5Kl/hCyEiFiws+yTT
         te6hzACDiRsJutWqm50V1wMgzwETpgdpaXG0+dsfqQEMhRUAQ+Y/ZCbra0IS5UNbU5yk
         t3hRrnpg1kQPal32hJvfwID0y8YgTig3ntCFf1mEUCb3JJeoMqWZof64p2Va8TuRtnLv
         /aapOGjg7E4K67e+n2pfrrm2u0asjEuJXxWJ9kLndL7qfzo/EBRZJIG4Zqa0ask1VGZO
         obO72JQ4DTQLJjYzbUAVtc7aNosAUvXw5ylXAnitt64s2i6cGEq1BLIlTB2wFSOn5D4H
         NmRA==
X-Gm-Message-State: AOJu0YxKCp54q4swkPqpbkpErZHYLH+9aWMcTKRMAG2lKR3IxDP1em8V
	wwvydRKTbQW+FN04h2rw0Bo3wWBWO/0pN38Z6EO+67HHC/AyS1w=
X-Google-Smtp-Source: AGHT+IHNdJGhqXsjxltF0QWrF1B9LLK7GZwpbI936hKA7nuXZYfxhpwy/7Cze9ugZE693R6Pg10qWQ==
X-Received: by 2002:a05:6a00:ac8:b0:710:7fd2:c91 with SMTP id d2e1a72fcca58-7125522fbfemr888096b3a.26.1723479391962;
        Mon, 12 Aug 2024 09:16:31 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab06fcsm4167843b3a.184.2024.08.12.09.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:16:31 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:16:30 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v7 0/6] monitor network traffic for flaky test
 cases
Message-ID: <Zro1XiPDew6PhJcy@mini-arch>
References: <20240810023534.2458227-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240810023534.2458227-1-thinker.li@gmail.com>

On 08/09, Kui-Feng Lee wrote:
> Capture packets in the background for flaky test cases related to
> network features.
> 
> We have some flaky test cases that are difficult to debug without
> knowing what the traffic looks like. Capturing packets, the CI log and
> packet files may help developers to fix these flaky test cases.
> 
> This patch set monitors a few test cases. Recently, they have been
> showing flaky behavior.
> 
>     lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 68, SYN
>     lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 60, SYN, ACK
>     lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 60, ACK
>     lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, ACK
>     lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 52, FIN, ACK
>     lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, RST, ACK
>     Packet file: packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log
>     #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK
> 
> The above block is the log of a test case. It shows every packet of a
> connection. The captured packets are stored in the file called
> packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log.
> 
> We have a set of high-level helpers and a test_progs option to
> simplify the process of enabling the traffic monitor. netns_new() and
> netns_free() are helpers used to create and delete namespaces while
> also enabling the traffic monitor for the namespace based on the
> patterns provided by the "-m" option of test_progs. The value of the
> "-m" option is a list of patterns used to enable the traffic monitor
> for a group of tests or a file containing patterns. CI can utilize
> this option to enable monitoring.
> 
> traffic_monitor_start() and traffic_monitor_stop() are low-level
> functions to start monitoring explicitly. You can have more controls,
> however high-level helpers are preferred.
> 
> The following block is an example that monitors the network traffic of
> a test case in a network namespace.
> 
>     struct netns_obj *netns;
>     
>     ...
>     netns = netns_new("test", true);
>     if (!ASSERT_TRUE(netns, "netns_new"))
>         goto err;
>     
>     ... test ...
>     
>     netns_free(netns);
> 
> netns_new() will create a network namespace named "test" and bring up
> "lo" in the namespace. By passing "true" as the 2nd argument, it will
> set the network namespace of the current process to
> "test".netns_free() will destroy the namespace, and the process will
> leave the "test" namespace if the struct netns_obj returned by
> netns_new() is created with "true" as the 2nd argument. If the name of
> the test matches the patterns given by the "-m" option, the traffic
> monitor will be enabled for the "test" namespace as well.
> 
> The packet files are located in the directory "/tmp/tmon_pcap/". The
> directory is intended to be compressed as a file so that developers
> can download it from the CI.
> 
> This feature is enabled only if libpcap is available when building
> selftests.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

