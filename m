Return-Path: <bpf+bounces-35326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480AB9397FE
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB102B21D24
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE647136E3E;
	Tue, 23 Jul 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMw60VJd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F951332A1
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698811; cv=none; b=jGiaQoG6E8hHsCOtBaPAlXSWU3Xb4qZ2TcMi2olacnYR6KQN3/BREz4n5KJDj7MTzPswvDPImM4qG3NGAJimzj21UaAYxzzJx3/2zJ/jfNZj9L53VKYRsylPXL3r1YPnYPGXF5dJWhfRNKANYSIiSUvkoLbrYXY2IjyAEQqnpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698811; c=relaxed/simple;
	bh=HNwdtX+2lHEvQZFtlBmE3p1u8liec5ALc3VeXQRFTBk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=Ebfid/iUwjHq+yUV/2tXziav+2ax4uYD2G3ZEgzgsa0ABdQid4NfiZXgUYL9o+AG4sqmc3+kiQX/Hc+pa6W94cCJdSUZyv2sG9ypdTb8TQWS2MLcUzb1MdtFqnt7OKYq0oCBotRVYaKy79oecT2ALy+aRHLF9p6CDfJPZxjr7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMw60VJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DF2C4AF0A;
	Tue, 23 Jul 2024 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721698811;
	bh=HNwdtX+2lHEvQZFtlBmE3p1u8liec5ALc3VeXQRFTBk=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=LMw60VJdw7B8hU9/k8+Vl7sw0VE0LxVjrfGVhldYI/9RWg5bosUqkg/+MDbApm6Mo
	 Ve/vmgO0nhufrDpbxm8DimLtE6+zn6sTWVUh1QhqxWkBA4ndJDzGdxph0iWXSDyHIF
	 bnFhZUBEVkMaWqwHIvnZRCTCPAZbSUOMkhm2AAtNk0FGIpH1KlTZ3dv3EmvQPMxtPN
	 blZWQqBb1xGjhHbhqiY9/88myC3D7cUDn2hKgEV+2X1DB0R/BzP06o5+ZSQjLtQMMl
	 i5O8Oie6ho6fq+CzRo/wy/duMNOqNXD06WwdlQ8f7joLlaMvOKZ+mr6L8ML1dWkbXV
	 SjxBy/w+X7ung==
Content-Type: multipart/mixed; boundary="===============1841634473543922863=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1a3316c4b56ddaff9efd61e4163bda4ae0cf43ee9fe92de9711d4480fb41361@mail.kernel.org>
In-Reply-To: <20240723003045.2273499-1-tony.ambardar@gmail.com>
References: <20240723003045.2273499-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2] tools/runqslower: Fix LDFLAGS and add LDLIBS support
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 01:40:10 +0000 (UTC)

--===============1841634473543922863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,v2] tools/runqslower: Fix LDFLAGS and add LDLIBS support
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873093&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050688717

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050688717/job/27779227454
test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050688717/job/27779289243
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050688717/job/27779279451
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10050688717/job/27779281639
test_progs_no_alu32-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10050688717/job/27779287211

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
2: (18) r3 = 0xffff0000c4be4600       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
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

--===============1841634473543922863==--

