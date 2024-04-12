Return-Path: <bpf+bounces-26594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34A8A2320
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 03:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E927B284A5A
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 01:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899904C8E;
	Fri, 12 Apr 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sBSbOsbh"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7933D5
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712884486; cv=none; b=VLJDbgN09lrTFSA30Mlag9FBQo7OFIyebRxXOdr8kuNvG/r+VJB5Ib/BxsMQL7/2EqUNsqBgzW9DfeGp5TZgFveTVTrRCLplN2NBBS0IsvL2HHh24LKJFRrsql3DaqXvxuFbuVhHQwFglab5acIEibQzuc0jBPmqKKOAkqSHL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712884486; c=relaxed/simple;
	bh=e6+AYuksM/OkdD9KeQZdNWHeNxAHypqErI5Qn8MY/Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2Xd5x4frkVh+r4q/XL5Il4R2Z7xzcFgT05zwGQ/RCgyq0/9XPyqit2uX/rImkAS6/Qs2RcGhqHjzIeXJzLpQFEYVLHlFvhzxXm6bhjwYNsx9PcaBfQBKf1v7B+wWeZaeGBf8omIoN4QsSyrTTRVuZ2RHjSUGrgxErqIs7qleFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sBSbOsbh; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ded0129b-2a32-4de9-aeee-fcdf74ffdd4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712884482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X33cbovPiEfTGdBBISnr1h/yfgzXYiMloxhJKyuAgEA=;
	b=sBSbOsbh6k4hKzZ2xR90un+SIdTm4jYFsZv4PE+/Pzkh3SBcCsyJRL+49sY9o+3kYpkQOY
	rl9eYQisrhV+7huBD/oHaWThlgOAozgySpOYtdZsb1cTr6Uvsovl4VUwlDcaXGc7laDNjQ
	h8TFOMGFvcwn68Omajr3lJx3B7qR8go=
Date: Thu, 11 Apr 2024 18:14:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Incorrect BPF stats accounting for fentry on arm64
Content-Language: en-GB
To: Ivan Babrou <ivan@cloudflare.com>, bpf <bpf@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/11/24 11:09 AM, Ivan Babrou wrote:
> Hello,
>
> We're seeing incorrect data for bpf runtime stats on arm64. Here's an example:
>
> $ sudo bpftool prog show id 693110
> 693110: tracing  name __tcp_retransmit_skb  tag e37be2fbe8be4726  gpl
> run_time_ns 2493581964213176 run_cnt 1133532 recursion_misses 1
>      loaded_at 2024-04-10T22:33:09+0000  uid 62727
>      xlated 312B  jited 344B  memlock 4096B  map_ids 8550445,8550441
>      btf_id 8726522
>      pids prometheus-ebpf(2224907)
>
> According to bpftool, this program reported 66555800ns of runtime at
> one point and then it jumped to 2493581675247416ns just 53s later when
> we looked at it again. This is happening only on arm64 nodes in our
> fleet on both v6.1.82 and v6.6.25.
>
> We have two services that are involved:
>
> * ebpf_exporter attaches bpf programs to the kernel and exports
> prometheus metrics and opentelementry traces driven by its probes
> * bpf_stats_exporter runs bpftool every 53s to capture bpf runtime metrics
>
> The problematic fentry is attached to __tcp_retransmit_skb, but an
> identical one is also attached to tcp_send_loss_probe, which does not
> exhibit the same issue:
>
> SEC("fentry/__tcp_retransmit_skb")
> int BPF_PROG(__tcp_retransmit_skb, struct sock *sk)
> {
>    return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_retransmit_skb);
> }
>
> SEC("fentry/tcp_send_loss_probe")
> int BPF_PROG(tcp_send_loss_probe, struct sock *sk)
> {
>    return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_send_loss_probe);
> }
>
> In handle_sk we do a map lookup and an optional ringbuf push. There is
> no sleeping (I don't think it's even allowed on v6.1). It's
> interesting that it only happens for the retransmit, but not for the
> loss probe.
>
> The issue manifests some time after we restart ebpf_exporter and
> reattach the probes. It doesn't happen immediately, as we need to
> capture metrics 53s apart to produce a visible spike in metrics.
>
> There is no corresponding spike in execution count, only in execution time.
>
> It doesn't happen deterministically. Some ebpf_exporter restarts show
> it, some don't.
>
> It doesn't keep happening after ebpf_exporter restart. It happens once
> and that's it.
>
> Maybe recursion_misses plays a role here? We see none for
> tcp_send_loss_probe. We do see some for inet_sk_error_report
> tracepoint, but it doesn't spike like __tcp_retransmit_skb does.
>
> The biggest smoking gun is that it only happens on arm64.

I am not an expert for arm64. But you or somebody could check
and compare arm64 and x86 jit trampoline codes to see whether
anything is suspicious.

>
> I'm happy to try out patches to figure this one out.
>

