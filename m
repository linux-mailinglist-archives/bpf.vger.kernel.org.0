Return-Path: <bpf+bounces-35784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8109493DC7E
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB22816D7
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43D19F;
	Sat, 27 Jul 2024 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbCPQlx7"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C215394
	for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039805; cv=none; b=cqcG8tkrO/JBS6cYAson09vMvE+5RaPui+8rYJi6I9kmM81y1HfMJjnWmhfq4Io3fPHqkqOZLMYcg+a4ELaaqAbgECUXQp67JeMY/Yr8VgQ+cD59Fb+kP3pF/yTGomDG4UvG0ZEs8DRvq5iS2yuN41cY/MYvSAhYsjIeb/bPKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039805; c=relaxed/simple;
	bh=A/QghP1kC/F9yP/tRw6bC4GPFI+X2dMLw/W/e67lx74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=iNae/G1LCPTwRKwIjoiXW1jZYdRh8AwcVnX+JJkKt38JV54ctIgPd8vt+OjOZks7C92CzUIv0WYNvGRokbS336L6aFWR71hB8qj1gnjoWvTavAHkFGKDLJOBWSyQ1t0VrMQKJypYj4PsJ0n3Pw/v16ClAJdso0G8NXDaFH8kLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jbCPQlx7; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <996212bc-c9e8-4486-a7ce-1869599ff01b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722039798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuLZ73EM4Bz7w9MVTSr5t04/o01U86YNpQKYWrf5abQ=;
	b=jbCPQlx7h604sr4CC67A8U+DLL+6zrkbRmygXRToE9VyHPT7YK/6LeFiezPjBI24Mx779Q
	Z0QsALDqnacN+h99sfldipZWpQx9NznarSX1pNEBIOrM895Sz264qR9v+eo6VkPdkkykby
	WoWcEwmgCCjvQz9vffu+lmYpypR+r3k=
Date: Fri, 26 Jul 2024 17:23:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Assistance needed with TCP BBR to BPF Conversion Issue
To: Mingrui Zhang <mzhang23@huskers.unl.edu>
References: <CH0PR08MB86628C12C14CCAB20681BCA38EB42@CH0PR08MB8662.namprd08.prod.outlook.com>
 <CH0PR08MB86623CB07E3EB7CC3D370AF78EB42@CH0PR08MB8662.namprd08.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
In-Reply-To: <CH0PR08MB86623CB07E3EB7CC3D370AF78EB42@CH0PR08MB8662.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/26/24 2:15 PM, Mingrui Zhang wrote:
> Dear BPF community,
> 
> I am a student currently trying to use the BPF interface in the TCP congestion control study for faster Linux system integration without compiling the entire kernel.
> 
> I've encountered a challenge while attempting to convert TCP BBR to BPF format and would greatly appreciate your guidance.
> 
> My modifications to the original tcp_bbr is as follow:
> * change u8,u32,u64,etc to __u8, __u32, __u64, etc.
> * Defined external kernel functions
> * Removed compiler flags using macro (e.g., "unlikely", "READ_ONCE")
> * Borrowed some time definitions from bpf_cubic (e.g., HZ and JIFFY)
> * Defined constant values not included in vmlinux.h (e.g., "TCP_INFINITE_SSTHRESH")
> * Implemented do_div() and cmpxchg() from assembly to C
> * Changed min_t() macro to min()
> This is the link to my modified tcp_bbr file https://github.com/zmrui/bbr-bpf/blob/main/tcp_bbr.c
> 
> I use "clang -O2 -target bpf -c -g bpf_cubic.c" command to compile and it doesn't output any warning or error,
> and the "sudo bpftool struct_ops register tcp_bbr.o" command does not have any output
> 
> Then the "bpftool -debug" option displays the following debug message at the last line:
> "libbpf: sec '.rodata': failed to determine size from ELF: size 0, err -2"

Good to see works in trying tcp_bbr.c with struct_ops.

It is likely the .o is invalid. Are you sure the program was compiled successfully?

 From looking at the following lines, the kernel you are using is not the 
upstream kernel.

extern unsigned int tcp_left_out(const struct tcp_sock *tp) __ksym;
extern unsigned int tcp_packets_in_flight(const struct tcp_sock *tp) __ksym;
extern __u32 tcp_stamp_us_delta(__u64 t1, __u64 t0) __ksym;
extern __u32 get_random_u32_below(__u32 ceil) __ksym;
extern __u32 tcp_min_rtt(const struct tcp_sock *tp) __ksym;
extern unsigned long msecs_to_jiffies(const unsigned int m)  __ksym;
extern __u32 tcp_snd_cwnd(const struct tcp_sock *tp) __ksym;
extern void tcp_snd_cwnd_set(struct tcp_sock *tp, __u32 val) __ksym;
extern __u32 minmax_running_max(struct minmax *m, __u32 win, __u32 t, __u32 
meas) __ksym;
extern __u32 minmax_reset(struct minmax *m, u32 t, u32 meas) __ksym;
extern  __u32 minmax_get(const struct minmax *m) __ksym;

They are not kfunc in the upstream kernel. Most of them don't have to be kfunc. 
Try to implement them in the bpf program itself (i.e. the tcp_bbr.c in your 
github link).

It is hard for the community to help without something reproducible in the 
upstream kernel. Lets target for getting tcp_bbr.c compiled in the selftests 
first (under tools/testing/selftests/bpf/progs like the bpf_cubic.c) and post 
the patch to the mailing list. bpf_devel_QA.rst has some guides.

> Additionally, the new algorithm doesn't appear in "net.ipv4.tcp_available_congestion_control" or in "bpftool struct_ops list".
> 
> I did not find much related content for this debug error message on the Internet.
> I would be very grateful for any suggestions or insights you might have regarding this issue.
> Thank you in advance for your time and expertise.
> 
> For context, here's my system information:
> Ubuntu 22.04
> 6.5.0-41-generic
> $ bpftool -V
> 	bpftool v7.3.0
> 	using libbpf v1.3
> 	features: llvm, skeletons
> -$ clang -v
> 	-Ubuntu clang version 14.0.0-1ubuntu1.1
> 
> Best,
> Mingrui
> 


