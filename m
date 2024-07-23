Return-Path: <bpf+bounces-35328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58D939802
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBBF1C21952
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2239137742;
	Tue, 23 Jul 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHx+E2o9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57D130499
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698888; cv=none; b=SVaiiGL2vkTAUhArP45jYxAcBx1eNSEqIebfYn3CeMcGtTJcHjteBkiwzBbyHzDVoQN7+W3hubGVhBwWAGCpI30wJTSz+e8F6y98VyensjUEqSHO8QX7OQqT+QgPRBf24Zun6tyDhnS+DKDJmZgkSDqEk2cTxR43td80bbgnZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698888; c=relaxed/simple;
	bh=ILZFlmiwuLwZwQJDW9aXyy7EX442K1N4Eq3hQ/Ex+M0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LeGZyxnsIWG71LNjvTcIWo56gOLR3QqNTBOlcg+IfKJP5bWiB/CBKZaEU8eEzXIyiHPLFIqv+1T1QbGWcLkbg2YwAG+luQJcMXVWZH3VKbies7CgJBFMWbja6dZdVGt866rcMjafBUYdFGR6JTZmFKHzyrb5iz6WVGiwswgi8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHx+E2o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6516C116B1;
	Tue, 23 Jul 2024 01:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721698888;
	bh=ILZFlmiwuLwZwQJDW9aXyy7EX442K1N4Eq3hQ/Ex+M0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=vHx+E2o9cl06sET2TSP5bSdwbZqdnf8CFe49cBNOvP+Y0yBmsWO2cD7KUt7ilhUw1
	 sqn97bKA/meNAZYekNtfp4BjndGq8OFOFelR7XpuCfxwVssoO6BqL7n3cF+859qf5g
	 o2Gkf/yv9ItjXy0jfJ3CevRqK3qm3Pfk0gNLu/Mr2fa4LJhfF54pB1OvlYC0zBm9Wc
	 kwAnJOqCk7lZnfsb/O/eR6N0rWzACQOBrbR00pXUAI1YB57xdKAldvwBOYiQV4Op/M
	 Bf4TdtONMTYsTPWLex7822vRNBePGlg2IsYZ4tALx5BjOpINxOxWR5y1jKnHu7bOu/
	 hiAhCZbcy5gKg==
Content-Type: multipart/mixed; boundary="===============2478699474969294196=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d6c310347a87ed4fd6713fd81582e6151ea147764a2ee2374e210d452833cb6@mail.kernel.org>
In-Reply-To: <20240722202758.3889061-1-jolsa@kernel.org>
References: <20240722202758.3889061-1-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 0/2] selftests/bpf: Add more uprobe multi tests
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 01:41:27 +0000 (UTC)

--===============2478699474969294196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [PATCHv3,bpf-next,0/2] selftests/bpf: Add more uprobe multi tests
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873053&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050702681

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050702681/job/27779250571
test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050702681/job/27779381610
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050702681/job/27779406344
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10050702681/job/27779390782
test_progs_no_alu32-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10050702681/job/27779387928

First test_progs failure (test_progs_no_alu32-aarch64-gcc):
#134 libbpf_get_fd_by_id_opts
libbpf: prog 'check_access': BPF program load failed: Invalid argument
libbpf: prog 'check_access': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
0: (b7) r0 = 0                        ; R0_w=0
1: (79) r2 = *(u64 *)(r1 +0)
func 'bpf_lsm_bpf_map' arg0 has btf_id 2072 type STRUCT 'bpf_map'
2: R1=ctx() R2_w=trusted_ptr_bpf_map()
; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
2: (18) r3 = 0xffff0000c341f800       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
;  @ test_libbpf_get_fd_by_id_opts.c:0
8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
9: (95) exit
At program exit the register R0 has smax=9223372036854775795 should have been in [-4095, 0]
processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'check_access': failed to load: -22
libbpf: failed to load object 'test_libbpf_get_fd_by_id_opts'
libbpf: failed to load BPF skeleton 'test_libbpf_get_fd_by_id_opts': -22
test_libbpf_get_fd_by_id_opts:FAIL:test_libbpf_get_fd_by_id_opts__open_and_load unexpected error: -22


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============2478699474969294196==--

