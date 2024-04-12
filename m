Return-Path: <bpf+bounces-26607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C8A8A23C4
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 04:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9996284176
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E36F11190;
	Fri, 12 Apr 2024 02:30:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34760DDAA;
	Fri, 12 Apr 2024 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889001; cv=none; b=hNPc637syVox16ywLMT61afxHi2XUdnIuK9tW5mfk4+m9q/LA4Jjl7nXpctRruW+ackiCA32/+8oK8CXjVnOnYa9F/G9haSJfbM03blBxQ3GGNV8HKtGYd91eyfY4R5D+AmF+6riCkojsig12XLWUCxxkJ9CP+/CJagSPVT7ArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889001; c=relaxed/simple;
	bh=lN9nUDuQTd76FAFSsaPs3BYVE2gIVqoz5FcnCPR5g28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiuUoeG+dXIWpM/2SNUKmiI1Yq8Oz1GI14dhbfZ9HFBtV0GSksurre+UOQBhomz6VQ/pAHCHE119B849Qta7/HK6m4ICTh4eb4SM7aIoig74NUsAWFg/zPe/4Dp8nGLkuubh3lp3PzEffBCyUgPW99kCgNTlPHsPXCrGZy/M/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VG0rr5b9Nz4f3jMh;
	Fri, 12 Apr 2024 10:29:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AD8C51A01A7;
	Fri, 12 Apr 2024 10:29:55 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgA3956inBhm8L9uJg--.9624S2;
	Fri, 12 Apr 2024 10:29:55 +0800 (CST)
Message-ID: <25703ec0-f985-4d5f-8bfa-0c070da5b570@huaweicloud.com>
Date: Fri, 12 Apr 2024 10:29:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incorrect BPF stats accounting for fentry on arm64
Content-Language: en-US
To: Ivan Babrou <ivan@cloudflare.com>, bpf <bpf@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3956inBhm8L9uJg--.9624S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13tF15CFW3AFWfAF4xWFg_yoW5uFW7pF
	48ur90yF48Kry29a4kAwsFyw4Yyan3Jry3G3s8Jwnaya98CryxuFy5A3yYy3y5urWakw1f
	Z3yjkFWIgFyDAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3w
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/12/2024 2:09 AM, Ivan Babrou wrote:
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
> 
> I'm happy to try out patches to figure this one out.
> 

I guess the issue is caused by the not setting of x20 register
when __bpf_prog_enter(prog) returns zero.

The following patch may help:

--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1905,15 +1905,15 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,

         emit_call(enter_prog, ctx);

+       /* save return value to callee saved register x20 */
+       emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
+
         /* if (__bpf_prog_enter(prog) == 0)
          *         goto skip_exec_of_prog;
          */
         branch = ctx->image + ctx->idx;
         emit(A64_NOP, ctx);

-       /* save return value to callee saved register x20 */
-       emit(A64_MOV(1, A64_R(20), A64_R(0)), ctx);
-
         emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
         if (!p->jited)
                 emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);


