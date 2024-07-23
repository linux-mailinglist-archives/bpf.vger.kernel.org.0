Return-Path: <bpf+bounces-35315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD39397C8
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E680D1F22518
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3613211F;
	Tue, 23 Jul 2024 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svvdW+/i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC1433A0
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697196; cv=none; b=NXbjh92qSzkyfrE1Fi+zuq+RYMxnJy+fNp/T4YSZQL2mcIPbv2uLPBVqfC5InWj4SEAXWKdx3ZpcuasYMfjz9/jTuANHoxAMFCe+DmLHuQgfmsu9UpIwx66eo/qq9bbuysv0OsqbEEJ7MHiovQwxL7mVYNuDppbVIBDJPUOsv04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697196; c=relaxed/simple;
	bh=07GVG1Y8faQ6+JgLyQqi9hezxOFae8W3ZkWw8uXuKo8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uFk965rmLN4Br2hJ2PrNXJCkfyAcJxWVA/y59vpvFng9OK9Zbb4KLARXnLi29xleeiEw8Vwne1dHgDgn9h6vAMMV6msU4tCPTu0LbJqB211vHDULCgQJ6AEYXaeH8n6k+wWlgr567PweAxLzXS3+JYRTkL75/0wuunugiYIDwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svvdW+/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48518C116B1;
	Tue, 23 Jul 2024 01:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721697196;
	bh=07GVG1Y8faQ6+JgLyQqi9hezxOFae8W3ZkWw8uXuKo8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=svvdW+/iqccoVi8mAe0Dy6Hok2AfST/69NdkpvMAI76qZ/WKfOTf7GthWVkCatIBw
	 3Cc4xmZk0CBMIE3Gv0sJe4UGZDu/1NXgSaNvhw+xmv5Tm3awO8XZQfmi/5cOH4utLK
	 OpTftctYxzEKWeGNyaItjA1Sxce95RGPqqBLtxx1lvc7D+QnRszt2T/4V+fr4U7qni
	 Wz5PJuu2XkNT4cJdfvnl0pxTNeYLibuGaMuTsHDO7q7ScWiCPFFSnCy5CXy37gAxD0
	 YPgy95wmDcH2K+R8z1dzbQcIGWDFVtkFR55dASHIwbAQBnz4I1uy8f2dxnzPuAa1rN
	 NtTzRNHGrQnXw==
Content-Type: multipart/mixed; boundary="===============1152780972591838371=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da59c8f35db4f2dcd905781e3f80c7d87472bf3dbce21ab6f5dd90dab7150bea@mail.kernel.org>
In-Reply-To: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
References: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
Subject: Re: [PATCH v4 0/2] selftests/bpf: convert test_xdp_veth to test_progs framework
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 01:13:16 +0000 (UTC)

--===============1152780972591838371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [v4,0/2] selftests/bpf: convert test_xdp_veth to test_progs framework
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872778&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050700194

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050700194/job/27779246678
test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050700194/job/27779302931
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050700194/job/27779303865
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10050700194/job/27779312541
test_progs_no_alu32-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10050700194/job/27779359687

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
2: (18) r3 = 0xffff0000c5c3da00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
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

--===============1152780972591838371==--

