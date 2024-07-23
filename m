Return-Path: <bpf+bounces-35391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A568293A259
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C33D1F225D2
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17362153BE3;
	Tue, 23 Jul 2024 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWe6FZUs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2B15383D
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743996; cv=none; b=AmChLG3LdI3hKAt+vJjTjRDnrLo78p9F53NrWK2s9xsMaAnC6GkaHEOP/DvQYCoSrlG5qQttMW36o8KIh+vHjMURRozYK3cc/ZZzljZKqu26ZvYynI5+755ZfnpYAE7BSJj49rgmj7m8RBktZj5G9VxpTUqW81bHk+gmKbIAc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743996; c=relaxed/simple;
	bh=xluyvzuCXzqIrHsxIWqG3WxV9Aq+5nUu9opWv8bjB/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5y+nag+gCmknTK0LjuJhdKTsdsfyKvzyZd3fdYebiCxha7+f1c6iY3ReQrauAO2fwVTaRj3Au5TgBUDXuo3U0KwrZEEnX7D+yssAZWQNj2TPildkvnHp3+J5U/Yopb1CiBKwT9c0Y1nSi8ZBv2LWKgLSmaGV92ulMeHr+ExSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWe6FZUs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so2831139a91.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721743994; x=1722348794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1CoHedGwheh2wNjBZ2fFhj7FZq8rY5KKpdHr3mdYf4=;
        b=LWe6FZUs7b9Aj08QOlGDe4g4Kkb3bqei9skal6JLmpSzxP+Dn3HVjzHDRiaQKpQqNf
         /dbONZshjzjHlZ6tQ1GCwqI4HWUI2b5QjASBa7uRfGp3tKQOevVjTDJdETHaFgey9ndB
         BCUYuaJkBnKC4P/wnlXz3GMGe7apCmL37csCAQw881rgv4EU1pCugImOxpLWsgyccB2I
         bDK7yZNOeYifiVjPljrnVR4LrxFGAOMLd/MEkSZAhziBs68a5CBA7WdPPcSfo+ACXvmd
         6eWx2jAPi7Hv3W0B8CELxY5/5DrsEHosdgRsMmadFUI40u6KdcSg9Kl7JUPUxnSIZwqj
         wUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721743994; x=1722348794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1CoHedGwheh2wNjBZ2fFhj7FZq8rY5KKpdHr3mdYf4=;
        b=gjNPBVGbn965ePieRzelOOSQCMGKoQil2FgWKdSztIFwxz0fUKWX3nRKKG5xXGoLAr
         zE2hNUUeP4rid4X2Ieuig7M3XSuJ/q7/zBqt/JqvlLiTfUf3X6O4VpWsbBFUFXZNQlgD
         /szi70ZN2RXZDIuk3Y+KqnZak8AGrfbtvrGi57z03yYV7K+Iu/Dq6lBNwujqV9ufAd+K
         w1DH3ErcMPMeziiy1yBsg//4m9wwxzSm9esKWm9kTwr1cyABlP/wPoTg9y8/pdt38u1m
         LmxgbotudYbuW4x83WMEAnDvftQ0L6LCGtvUk8dExv2KeMcORbQdZripmFFhSWUp+vDM
         CWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2VDQf88du7B0pBMAsHcY5eWJcDsqOj6jotBHyxDNYaGM6MAnhqSRJbKcwIYkysNtF5nHnGzb6KM49TjBjAV3IyoOq
X-Gm-Message-State: AOJu0YwAd+IwZlR6W4hZcp5CDK73WZMzmJmMcH9Um2R6Lq1cR4fY5EmF
	VhAlNJ0xNqLdWVw0h6kP8xye3rwdKWZBbuL/aW7H+41R2BeGg6Xk
X-Google-Smtp-Source: AGHT+IHzEklVcEr8SZa8KjnjbkpI/U6gum21t3lGrh4M2C9gXMzOOf2p9/9y8hiVrgMqr1XCW+/Qqw==
X-Received: by 2002:a17:90b:3911:b0:2ca:7e7c:83ec with SMTP id 98e67ed59e1d1-2cd27434cb2mr5536075a91.20.1721743994128;
        Tue, 23 Jul 2024 07:13:14 -0700 (PDT)
Received: from [192.168.1.76] (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2f300sm9103175a91.10.2024.07.23.07.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 07:13:13 -0700 (PDT)
Message-ID: <93853c6e-b79b-4499-9fb8-fe587e7abe64@gmail.com>
Date: Tue, 23 Jul 2024 22:13:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix null pointer dereference in
 resolve_prog_type() for BPF_PROG_TYPE_EXT
To: Tengda Wu <wutengda@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20240711145819.254178-1-wutengda@huaweicloud.com>
 <20240711145819.254178-2-wutengda@huaweicloud.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20240711145819.254178-2-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/7/11 22:58, Tengda Wu wrote:
> When loading a EXT program without specifying `attr->attach_prog_fd`,
> the `prog->aux->dst_prog` will be null. At this time, calling
> resolve_prog_type() anywhere will result in a null pointer dereference.
> 
> Example stack trace:
> 
> [    8.107863] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> [    8.108262] Mem abort info:
> [    8.108384]   ESR = 0x0000000096000004
> [    8.108547]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    8.108722]   SET = 0, FnV = 0
> [    8.108827]   EA = 0, S1PTW = 0
> [    8.108939]   FSC = 0x04: level 0 translation fault
> [    8.109102] Data abort info:
> [    8.109203]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    8.109399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    8.109614]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101354000
> [    8.110011] [0000000000000004] pgd=0000000000000000, p4d=0000000000000000
> [    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    8.112783] Modules linked in:
> [    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc3-next-20240613-dirty #1
> [    8.113230] Hardware name: linux,dummy-virt (DT)
> [    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
> [    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
> [    8.113798] sp : ffff80008283b9f0
> [    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 0000000000000001
> [    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 0000000000000000
> [    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c1138000
> [    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: ffffffffffffffff
> [    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
> [    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> [    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008021f4e4
> [    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001e0e0f5f
> [    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000000001c
> [    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
> [    8.114126] Call trace:
> [    8.114159]  may_access_direct_pkt_data+0x24/0xa0
> [    8.114202]  bpf_check+0x3bc/0x28c0
> [    8.114214]  bpf_prog_load+0x658/0xa58
> [    8.114227]  __sys_bpf+0xc50/0x2250
> [    8.114240]  __arm64_sys_bpf+0x28/0x40
> [    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
> [    8.114273]  do_el0_svc+0x4c/0xd8
> [    8.114289]  el0_svc+0x3c/0x140
> [    8.114305]  el0t_64_sync_handler+0x134/0x150
> [    8.114331]  el0t_64_sync+0x168/0x170
> [    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
> [    8.118672] ---[ end trace 0000000000000000 ]---
> 
> One way to fix it is by forcing `attach_prog_fd` non-empty when
> bpf_prog_load(). But this will lead to `libbpf_probe_bpf_prog_type`
> API broken which use verifier log to probe prog type and will log
> nothing if we reject invalid EXT prog before bpf_check().
> 
> Another way is by adding null check in resolve_prog_type().
> 
> The issue was introduced by commit 4a9c7bbe2ed4 ("bpf: Resolve to
> prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT") which wanted
> to correct type resolution for BPF_PROG_TYPE_TRACING programs. Before
> that, the type resolution of BPF_PROG_TYPE_EXT prog actually follows
> the logic below:
> 
>   prog->aux->dst_prog ? prog->aux->dst_prog->type : prog->type;
> 
> It implies that when EXT program is not yet attached to `dst_prog`,
> the prog type should be EXT itself. This code worked fine in the past.
> So just keep using it.
> 
> Fix this by returning `prog->type` for BPF_PROG_TYPE_EXT if `dst_prog`
> is not present in resolve_prog_type().
> 
> Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
> Cc: stable@vger.kernel.org # v5.18+
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  include/linux/bpf_verifier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index e4070fb02b11..ff2a6cdb1fa3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -846,7 +846,7 @@ static inline u32 type_flag(u32 type)
>  /* only use after check_attach_btf_id() */
>  static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
>  {
> -	return prog->type == BPF_PROG_TYPE_EXT ?
> +	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
>  		prog->aux->dst_prog->type : prog->type;
>  }
>  

It seems not good enough here.

When I want to update an attached freplace prog to PROG_ARRAY map, it
will fail, like this selftest[0]. In this selftest, there is a
PROG_ARRAY map in freplace prog. And when loading with freplace's target
BPF_PROG_TYPE_SCHED_CLS prog, PROG_ARRAY map owner type is set as
BPF_PROG_TYPE_SCHED_CLS. Next, after attaching freplace prog, when I
want to update the freplace prog, it will fail because
resolve_prog_type() returns BPF_PROG_TYPE_EXT (because freplace
prog->aux->dst_prog is NULL after attaching).

When to run the selftest:

./test_progs -v -t tailcalls/tailcall_freplace
test_tailcall_freplace:PASS:open fr_skel 0 nsec
test_tailcall_freplace:PASS:open tc_skel 0 nsec
test_tailcall_freplace:PASS:tc_skel entry prog_id 0 nsec
test_tailcall_freplace:PASS:set_attach_target 0 nsec
test_tailcall_freplace:PASS:load fr_skel 0 nsec
test_tailcall_freplace:PASS:attatch_freplace 0 nsec
test_tailcall_freplace:PASS:fr_skel entry prog_fd 0 nsec
test_tailcall_freplace:PASS:fr_skel jmp_table map_fd 0 nsec
test_tailcall_freplace:FAIL:update jmp_table unexpected error: -22
(errno 22)
#327/25  tailcalls/tailcall_freplace:FAIL

It is better to fix by my way[1], which passes all selftests[2].

When to run the selftest with my way:

./test_progs -v -t tailcalls/tailcall_freplace
test_tailcall_freplace:PASS:open fr_skel 0 nsec
test_tailcall_freplace:PASS:open tc_skel 0 nsec
test_tailcall_freplace:PASS:tc_skel entry prog_id 0 nsec
test_tailcall_freplace:PASS:set_attach_target 0 nsec
test_tailcall_freplace:PASS:load fr_skel 0 nsec
test_tailcall_freplace:PASS:attatch_freplace 0 nsec
test_tailcall_freplace:PASS:fr_skel entry prog_fd 0 nsec
test_tailcall_freplace:PASS:fr_skel jmp_table map_fd 0 nsec
test_tailcall_freplace:PASS:update jmp_table 0 nsec
test_tailcall_freplace:PASS:prog_fd 0 nsec
test_tailcall_freplace:PASS:test_run 0 nsec
test_tailcall_freplace:PASS:test_run retval 0 nsec
#327/25  tailcalls/tailcall_freplace:OK

[0] https://lore.kernel.org/bpf/20240602122421.50892-3-hffilwlqm@gmail.com/
[1] https://lore.kernel.org/bpf/20240602122421.50892-2-hffilwlqm@gmail.com/
[2] https://github.com/kernel-patches/bpf/pull/7432/checks

Thanks,
Leon


