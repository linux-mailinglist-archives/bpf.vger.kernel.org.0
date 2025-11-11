Return-Path: <bpf+bounces-74116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE5C4A298
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A4188F12B
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690425EF81;
	Tue, 11 Nov 2025 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT+Utmz+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50124E4C6;
	Tue, 11 Nov 2025 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823048; cv=none; b=Gq+/9ypn0tBhktNhVrtZFcfmp3tnbhgDw2hO/r2EME75HplcrTGQE9U+5iFyqjtEj88FATumu7J64nS+iJN+iK5IBxy9ywoU8OfcAvmdV03yckdrhqra6NySvdQvsQTTXPCirNdNMCuMGsXn8Jl0G1ckPD+4T0a4y9CcG149tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823048; c=relaxed/simple;
	bh=bzFRHvP3Uj2Sd/Q4prwF7kIjFFp2NXwttzrVIDsxfyo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y9BSvf/rT2PNgsH/5T/vnbv4Qbbsm7qjW6MfH5rYu2ip1x/WAji6QjZaHi4SEp0oXYn3iQyE2pXSOI9OgPHGjvrFgB9x2A4CPlKohmdkJPVIuee1Io3EMIzXJtNqdjCnYas4UC18nMA8Q0N306Qn4Aktwa9ZNfvfRAu9JJU5sgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT+Utmz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63A9C19424;
	Tue, 11 Nov 2025 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762823045;
	bh=bzFRHvP3Uj2Sd/Q4prwF7kIjFFp2NXwttzrVIDsxfyo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NT+Utmz+pPuJVV3g285HG7IokAnkYEx5JLs4FQjw8bFTKyaO1bdwhViHZ2RkH/qnZ
	 eW3pelBfw+UwlCEcu8Qz/7agl6hGxEw0WLH6uzpNaILahsTfiP7p23NeOw3hwZzJZF
	 pPzEvIQje2aiA9q2Z5bZQYsCjag6X1UKetHrckPLfhNetGCoxPs72WcVR/C6Ti8PpC
	 n9k+PcaX1GEDERfHPNAiSK5v/lMOrZdUshyApWHIPkG0SDaJBZ7E+wdeM0FS4CKE10
	 QYNTQiDK3ecr0QM1jpxAK1ViOi4I/QOp0IPApBU7CrMyZ0MGO6P3FoA7MAd9AguFat
	 E7j+qcQ0xavhg==
Content-Type: multipart/mixed; boundary="===============2251693144866189753=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a5af7f40972e72de126df6dd3da4dd17b3231815f71e9721ad528acc8e534fa@mail.kernel.org>
In-Reply-To: <20251111003721.7629-1-listout@listout.xyz>
References: <20251111003721.7629-1-listout@listout.xyz>
Subject: Re: [PATCH bpf-next v2] bpf: Clamp trace length in __bpf_get_stack to fix OOB write
From: bot+bpf-ci@kernel.org
To: listout@listout.xyz,syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,contact@arnaud-lcm.com,daniel@iogearbox.net,eddyz87@gmail.com,haoluo@google.com,john.fastabend@gmail.com,jolsa@kernel.org,kpsingh@kernel.org,linux-kernel@vger.kernel.org,martin.lau@linux.dev,netdev@vger.kernel.org,sdf@fomichev.me,song@kernel.org,syzkaller-bugs@googlegroups.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Nov 2025 01:04:04 +0000 (UTC)

--===============2251693144866189753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 2365541c8..f9081de43 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -480,6 +480,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	}
>
>  	trace_nr = trace->nr - skip;
> +	trace_nr = min_t(u32, trace_nr, max_depth - skip);
>  	copy_len = trace_nr * elem_size;
>
>  	ips = trace->ip + skip;

Can max_depth - skip underflow when max_depth < skip?

The stack_map_calculate_max_depth() function can return a value less than
skip when sysctl_perf_event_max_stack is lowered below the skip value:

    max_depth = size / elem_size;
    max_depth += skip;
    if (max_depth > curr_sysctl_max_stack)
        return curr_sysctl_max_stack;

If sysctl_perf_event_max_stack = 10 and skip = 20, this returns 10.

Then max_depth - skip = 10 - 20 underflows to 4294967286 (u32 wraps),
causing min_t() to not limit trace_nr at all. This means the original OOB
write is not fixed in cases where skip > max_depth.

With the default sysctl_perf_event_max_stack = 127 and skip up to 255, this
scenario is reachable even without admin changing sysctls.

The pre-refactor code used:

    num_elem = size / elem_size;
    trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;

Perhaps the fix should directly use num_elem instead of max_depth - skip:

    u32 num_elem = size / elem_size;
    trace_nr = min_t(u32, trace_nr, num_elem);

Or check for underflow:

    if (max_depth > skip)
        trace_nr = min_t(u32, trace_nr, max_depth - skip);
    else
        trace_nr = 0;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19251115736

--===============2251693144866189753==--

