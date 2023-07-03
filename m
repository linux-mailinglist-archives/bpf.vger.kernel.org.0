Return-Path: <bpf+bounces-3884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0677460E5
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3641C1C209E7
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6861100BD;
	Mon,  3 Jul 2023 16:40:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D351F9E4
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 16:40:38 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074E4E41;
	Mon,  3 Jul 2023 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0dZbAs9Pg2492mzH9fXMYYaC8bteDNxA3zY/QslrSjs=; b=hRKrVyI5J9lrA1zPSvyoLLWES3
	y23YvwFzc3spPWtYeYoJXuIsxwNNHVse+0juBt49M/SkwPSGG4JEjrTpY+R+K8agf92s5/D/OnrEM
	pyctOBEEfs03Wju12zPjJ6X8FYUpBEn8aCcqF4tciprmFCQ/nHwWsw2yIiE8ycaIf3CIstKEAareg
	GekjEr9RBilyLPCWYjau/mHHq4PiMZw9NIn6dwRuaGXC3S/IJiMFOaAbF/u9JkBR9/zCsnKCsVBZf
	Ak/r9ymR6qzkF3kKjS8xkG1gD9ZApY50ZV/5FZrP09AwWDdjLQcbb3jbcLdWxA99ioM1Lu/EH1Rhn
	g5jmiJRw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGMb8-0001A2-G1; Mon, 03 Jul 2023 18:40:22 +0200
Received: from [178.197.249.52] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGMb8-000LEc-0I; Mon, 03 Jul 2023 18:40:22 +0200
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230626085811.3192402-1-puranjay12@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net>
Date: Mon, 3 Jul 2023 18:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230626085811.3192402-1-puranjay12@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26958/Mon Jul  3 09:29:03 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Mark,

On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> BPF programs currently consume a page each on ARM64. For systems with many BPF
> programs, this adds significant pressure to instruction TLB. High iTLB pressure
> usually causes slow down for the whole system.
> 
> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
> It packs multiple BPF programs into a single huge page. It is currently only
> enabled for the x86_64 BPF JIT.
> 
> This patch series enables the BPF prog pack allocator for the ARM64 BPF JIT.
> 
> ====================================================
> Performance Analysis of prog pack allocator on ARM64
> ====================================================
> 
> To test the performance of the BPF prog pack allocator on ARM64, a stresser
> tool[2] was built. This tool loads 8 BPF programs on the system and triggers
> 5 of them in an infinite loop by doing system calls.
> 
> The runner script starts 20 instances of the above which loads 8*20=160 BPF
> programs on the system, 5*20=100 of which are being constantly triggered.
> 
> In the above environment we try to build Python-3.8.4 and try to find different
> iTLB metrics for the compilation done by gcc-12.2.0.
> 
> The source code[3] is  configured with the following command:
> ./configure --enable-optimizations --with-ensurepip=install
> 
> Then the runner script is executed with the following command:
> ./run.sh "perf stat -e ITLB_WALK,L1I_TLB,INST_RETIRED,iTLB-load-misses -a make -j32"
> 
> This builds Python while 160 BPF programs are loaded and 100 are being constantly
> triggered and measures iTLB related metrics.
> 
> The output of the above command is discussed below before and after enabling the
> BPF prog pack allocator.
> 
> The tests were run on qemu-system-aarch64 with 32 cpus, 4G memory, -machine virt,
> -cpu host, and -enable-kvm.
> 
> Results
> -------
> 
> Before enabling prog pack allocator:
> ------------------------------------
> 
> Performance counter stats for 'system wide':
> 
>           333278635      ITLB_WALK
>       6762692976558      L1I_TLB
>      25359571423901      INST_RETIRED
>         15824054789      iTLB-load-misses
> 
>       189.029769053 seconds time elapsed
> 
> After enabling prog pack allocator:
> -----------------------------------
> 
> Performance counter stats for 'system wide':
> 
>           190333544      ITLB_WALK
>       6712712386528      L1I_TLB
>      25278233304411      INST_RETIRED
>          5716757866      iTLB-load-misses
> 
>       185.392650561 seconds time elapsed
> 
> Improvements in metrics
> -----------------------
> 
> Compilation time                             ---> 1.92% faster
> iTLB-load-misses/Sec (Less is better)        ---> 63.16% decrease
> ITLB_WALK/1000 INST_RETIRED (Less is better) ---> 42.71% decrease
> ITLB_Walk/L1I_TLB (Less is better)           ---> 42.47% decrease
> 
> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
> [2] https://github.com/puranjaymohan/BPF-Allocator-Bench
> [3] https://www.python.org/ftp/python/3.8.4/Python-3.8.4.tgz
> 
> Chanes in V3 => V4: Changes only in 3rd patch
> 1. Fix the I-cache maintenance: Clean the data cache and invalidate the i-Cache
>     only *after* the instructions have been copied to the ROX region.

If you get a chance to take another look at the v4 changes from Puranjay and
in case they look good to you reply with an Ack, that would be great.

Thanks,
Daniel

