Return-Path: <bpf+bounces-35463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7F93AB65
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 04:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC054285418
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8F199A2;
	Wed, 24 Jul 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faBltDxY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525331757E
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789436; cv=none; b=bnov3e+5BN9B/hgjBFv5Z9n4n4jmEsn5EvMzH/T0OfGuHISZrSHJz236GoYwTuOMzKQMUFHA0OL3arnvleNplotse4Bwd3YrKyiSy9wxZXyhbfW0c4YlwR9Bi1535n+3ioymsd2i5avfCXerZPv3F0gQT6vuSNZC5EKg7b/HWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789436; c=relaxed/simple;
	bh=dQP/jWvNQgbpqnrmikqJ1DOdYKt2Ip3Aeq2nhD2Sc3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YhKXVCjYNfjBvs8t2SNVuZ4eG62YabEDve3gBf/YGf4GRE1qrzHMHT1qPUSYTKVGaZFSn+8uaFJ5Ib9PeEolr3F3PNK+8hnhjy0V1tXM0SSn/jnG1XCGOIVD27ov96eJ+4PDE7/MA1sDuADlzZbyFf8xqnqBVmyCiLE55yDsZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faBltDxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E714BC4AF0C;
	Wed, 24 Jul 2024 02:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721789436;
	bh=dQP/jWvNQgbpqnrmikqJ1DOdYKt2Ip3Aeq2nhD2Sc3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=faBltDxYCyTkHk8/URjr31YyXt/NnFze1nY6GXNotRBQRQpGlUw+r1GfGu0BjBu6T
	 LBf2mMqPY6kWAI+LMUlsmqoIDoRWAyUkIvZPqccu4kncAOJ6rFaLQs+Buf2yMHrEgU
	 CwhJOV39nAX3yVYkbI2xAHnvOU/kE+L7AEiEfVYXcjKK8hChPTGO8OlGEqoWYkB9d1
	 vqpvGAmk8kMB4fcmUfd3K8qJHu/mMfLPFF4BssZLZ1P4hZx4gLduvZUu2zS8ss8D5p
	 VV+21o+/EJ9a2iCil5Bu9JlxwiiCBdQOhLOrqv/x7MKzcVaf+VS5HYGuQYxJkPgKOJ
	 7ma91kIG8JrUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4809C43443;
	Wed, 24 Jul 2024 02:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Get better reg range with ldsx and 32bit
 compare
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172178943586.26430.17071776543777943498.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:50:35 +0000
References: <20240723162933.2731620-1-yonghong.song@linux.dev>
In-Reply-To: <20240723162933.2731620-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, shung-hsi.yu@suse.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Jul 2024 09:29:33 -0700 you wrote:
> With latest llvm19, the selftest iters/iter_arr_with_actual_elem_count
> failed with -mcpu=v4.
> 
> The following are the details:
>   0: R1=ctx() R10=fp0
>   ; int iter_arr_with_actual_elem_count(const void *ctx) @ iters.c:1420
>   0: (b4) w7 = 0                        ; R7_w=0
>   ; int i, n = loop_data.n, sum = 0; @ iters.c:1422
>   1: (18) r1 = 0xffffc90000191478       ; R1_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144)
>   3: (61) r6 = *(u32 *)(r1 +128)        ; R1_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
>   ; if (n > ARRAY_SIZE(loop_data.data)) @ iters.c:1424
>   4: (26) if w6 > 0x20 goto pc+27       ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f))
>   5: (bf) r8 = r10                      ; R8_w=fp0 R10=fp0
>   6: (07) r8 += -8                      ; R8_w=fp-8
>   ; bpf_for(i, 0, n) { @ iters.c:1427
>   7: (bf) r1 = r8                       ; R1_w=fp-8 R8_w=fp-8
>   8: (b4) w2 = 0                        ; R2_w=0
>   9: (bc) w3 = w6                       ; R3_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R6_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f))
>   10: (85) call bpf_iter_num_new#45179          ; R0=scalar() fp-8=iter_num(ref_id=2,state=active,depth=0) refs=2
>   11: (bf) r1 = r8                      ; R1=fp-8 R8=fp-8 refs=2
>   12: (85) call bpf_iter_num_next#45181 13: R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R6=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=0 R8=fp-8 R10=fp0 fp-8=iter_num(ref_id=2,state=active,depth=1) refs=2
>   ; bpf_for(i, 0, n) { @ iters.c:1427
>   13: (15) if r0 == 0x0 goto pc+2       ; R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) refs=2
>   14: (81) r1 = *(s32 *)(r0 +0)         ; R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff) refs=2
>   15: (ae) if w1 < w6 goto pc+4 20: R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1=scalar(smin=0xffffffff80000000,smax=smax32=umax32=31,umax=0xffffffff0000001f,smin32=0,var_off=(0x0; 0xffffffff0000001f)) R6=scalar(id=1,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=0 R8=fp-8 R10=fp0 fp-8=iter_num(ref_id=2,state=active,depth=1) refs=2
>   ; sum += loop_data.data[i]; @ iters.c:1429
>   20: (67) r1 <<= 2                     ; R1_w=scalar(smax=0x7ffffffc0000007c,umax=0xfffffffc0000007c,smin32=0,smax32=umax32=124,var_off=(0x0; 0xfffffffc0000007c)) refs=2
>   21: (18) r2 = 0xffffc90000191478      ; R2_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144) refs=2
>   23: (0f) r2 += r1
>   math between map_value pointer and register with unbounded min value is not allowed
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Get better reg range with ldsx and 32bit compare
    https://git.kernel.org/bpf/bpf-next/c/2e716457a823
  - [bpf-next,v5,2/2] selftests/bpf: Add reg_bounds tests for ldsx and subreg compare
    https://git.kernel.org/bpf/bpf-next/c/1d6189935f1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



