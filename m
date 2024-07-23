Return-Path: <bpf+bounces-35316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE89397D3
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2804B21CD2
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F363D3B3;
	Tue, 23 Jul 2024 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDSHefGj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DAEC2
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697506; cv=none; b=Nf1TpDRA9AgjRY7Hk9FQ+PtYcLnAHjefSzGMzR1MfzANGkWa2D2SYFZDa3oU3WFsay5i2ngXTsVcSP0VBclEJ5o+aBXz+RDCgsR9KwAJ5SWv7K0YYScBO6c3YCDy0mhN5fUDS8UB9iqZc3rB0NsPRLJKef9VFCj7yW/ifGrKvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697506; c=relaxed/simple;
	bh=OD5pA9P637C/E9IuZMdsE8Qv/mz/A8bmTrp/9AgruFs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=JsVLedqg7rx28tYKMJATwfZNpgnh1pBX/tatrKua3BYv5j30vnAGpUHbHfeslQPrg+XkWLDiWZQNx4TpEDAjRiZMnhLWg5heMGnbZ01iawAMLvz8+dfvnRUaq1FxZEqhHeuFexVHVv4o0I1URAFE8XR3XofZLy7YjrN9mabsT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDSHefGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1116C116B1;
	Tue, 23 Jul 2024 01:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721697504;
	bh=OD5pA9P637C/E9IuZMdsE8Qv/mz/A8bmTrp/9AgruFs=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=CDSHefGjz237Tloa88pxPQcWvoiwLFJC8ShbB/OWbilvSylOL8op0QoSTVzKGccCl
	 QEAfxL3mQ7SEz6pz+8Y3ntywgQ4oCEQPhU6DzEOVsx4IOIW5GKdnoScP/a2ax9w69H
	 vA0a81YEABQOqVLo3oCl3hHSwQWltOSedSGi4h1p4ftlSXS80MbSESLFsQk56qzyua
	 xmGXwsbshmPpOmHhF+9iHpb4Nsrd32Vq77JezmOenk3N/qKHs8a4jVaSMnww+BoFl7
	 CkIl/4TuIadCM/k+M4YcmQCrg4QYb0hlIbmV0kxJfHwItuQrP0mKuGIvdhoNhwxDMl
	 XhQPLzCLobLzA==
Content-Type: multipart/mixed; boundary="===============4425101232555922290=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a2e84513160393dcd9693394476c699a7c1450e2aa1d96095eaa7638a8931a28@mail.kernel.org>
In-Reply-To: <cover.1721475357.git.tanggeliang@kylinos.cn>
References: <cover.1721475357.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next 0/4] use network helpers, part 10
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 01:18:24 +0000 (UTC)

--===============4425101232555922290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,0/4] use network helpers, part 10
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872683&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050705880

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050705880/job/27779265107
test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050705880/job/27779401509
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050705880/job/27779392788
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10050705880/job/27779412425
test_progs_no_alu32-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10050705880/job/27779413675

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
2: (18) r3 = 0xffff0000c28d1a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
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

--===============4425101232555922290==--

