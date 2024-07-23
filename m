Return-Path: <bpf+bounces-35314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D59397C7
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC17B21C3F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E6132804;
	Tue, 23 Jul 2024 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg0alk8M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F37132114
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697180; cv=none; b=Qk8GMzlvfcSyok3kcOi/4w4lOXF95RDlsoqGuqQpxzXLOXCoFgjKIiWPx6hnDtmV9inbBb1IO/eXZnkBvqydXi3MDO6caJQYjaYk6kGAOg8hkJA4t1BJNBppbpOgJJw2aj/PASbLpQkAiPFPhEUuiNe7lOGRb2XHJ3sziNXOxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697180; c=relaxed/simple;
	bh=d3CNE0+LXEMRxFaTpeG+Kg5v8DyTTlwc1yLFwEiVlCs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uTkyN9Ow7vGDeJmRQ+EQkxNhBRF8vBHa9ToEq2x5ArUWGFcMO4T/Gg2m3WQeAvQU/oUIlhSCTHT1v58oEqL3FqELHgXExhnPCLv4RS7Ngd2B9syxNDikzv9WpSXihSevjw5K5CN0BLAKVFz0235z0EcAy21CNqyEul/Y8Y+/GxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg0alk8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839BEC116B1;
	Tue, 23 Jul 2024 01:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721697179;
	bh=d3CNE0+LXEMRxFaTpeG+Kg5v8DyTTlwc1yLFwEiVlCs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Lg0alk8Ma3PUDH5KbkRxoeAcrDzYdYD28zhP7oUruU5OQXvAGnYNDOw3c7AerAsPL
	 Uo0mgC10reZA8HbG4TLdppk2CnXx9h5mEpFqZTGO/4csLYKhwIT79SHfdMVd83HGG2
	 h0kQfwGNsCOhh646f90EMrRS+ppbg1d2w6h5EQ59yC6nWycC1Hw1KtGsn44AuHZNmA
	 3tSWojNzInxrMptH+8d+GBZIBpFPQeD+GQfmIo1xiRk+lVv+eLzl6doHJWAY8xEAKc
	 z9YxCC7dngHn4EZCpN4nP5FbIXwAHmoWyg5C3tt7pskJG0YM7IE7mYufjO3h4vcrIc
	 biedd35cTuKKg==
Content-Type: multipart/mixed; boundary="===============6501212187479675384=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e1c1b22f3c23b54a03897864a70cc6969fb18d593fe7d438050a14cd1c5ea113@mail.kernel.org>
In-Reply-To: <20240719024653.77006-1-dracodingfly@gmail.com>
References: <20240719024653.77006-1-dracodingfly@gmail.com>
Subject: Re: [PATCH v4] bpf: Fixed a segment issue when downgrade gso_size
From: bot+bpf-ci@kernel.org
To: dracodingfly@gmail.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 01:12:59 +0000 (UTC)

--===============6501212187479675384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [v4] bpf: Fixed a segment issue when downgrade gso_size
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872394&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050697643

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050697643/job/27779246113
test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050697643/job/27779299595
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050697643/job/27779290704
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10050697643/job/27779296439
test_progs_no_alu32-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10050697643/job/27779303677

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
2: (18) r3 = 0xffff0000c3462600       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
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

--===============6501212187479675384==--

