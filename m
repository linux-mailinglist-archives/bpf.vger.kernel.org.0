Return-Path: <bpf+bounces-35325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF29397FD
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CCB282CD1
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3272136E27;
	Tue, 23 Jul 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMdxxv0x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610012F5E
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698796; cv=none; b=ISopkW4zpLQVX5OUGIHMzzOI/jJVVMb/u1Hgzb0Py+Joqj5BsTwIm1Ect/2Hyw9/AE+BsncYxcfYt1WzqjL61m986mR3uEW2p2UanZoxIVLg5z1596JhSwGG4behE4HX6IwjSP7JJBkZ2Jn15i8FohPg/eFWak5PCpi9vh9skyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698796; c=relaxed/simple;
	bh=YNhwbcDzsJ1WvYdMSUP+lYRk9qyXUjksIZpNy+TzOF4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=QGSOQ2G2mbWuqVXGPPDi+FVlKuNihhrYIHo3+2dCgdwidDxL4Pe04MG2jeZBmCXdzXv7j1x5I6H3Fyc3GktRTGhVvytX8lG+Xxkm1KOi5Iyw6Ba36Ni8fSH3XYnLi2Ri2Oa2AeK0i1UFG1+G5Rf1jAFEpmImnBnxOcImDf0GA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMdxxv0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A2DC116B1;
	Tue, 23 Jul 2024 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721698795;
	bh=YNhwbcDzsJ1WvYdMSUP+lYRk9qyXUjksIZpNy+TzOF4=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=mMdxxv0x4jfRqn7a+/VGu/V7QwZdX+sk0s4ktOUb9677c9ju+XQTUkOfxdZLTcB61
	 fHEhLozZ1ceeEiThcDWJy6q8bqXCEeZFXgn7kHs47scJ3kyVOUqFE6Jmkp3gjODmlQ
	 VM4vZDKjhCFwZ3V8p3vKZfBxJ5pU8aXXyO1IpDSOlil4hWczNjFOGKxy5k0Locet8B
	 eaF71HqGLCb/5ktGZSMq8jk0RAlSe3SU5a+tVKClXlslIrbWm0oGCRoCO9l3jsug+m
	 hig8LiaBBuhIWJrzpCU1PYomMX4tJiCS2PakIFiY9MZA/GxttIKOxh5u2M24LMn8OP
	 4wWufKLQCWjvw==
Content-Type: multipart/mixed; boundary="===============1454569527039721626=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c5f0985de66704d1bad3533d8ca6224dd77b6ea1d98811b053c453e514c51b17@mail.kernel.org>
In-Reply-To: <14eb7b70f8ccef9834874d75eb373cb9292129da.1721692479.git.tony.ambardar@gmail.com>
References: <14eb7b70f8ccef9834874d75eb373cb9292129da.1721692479.git.tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix error linking uprobe_multi on mips
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 01:39:55 +0000 (UTC)

--===============1454569527039721626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,v2,2/2] selftests/bpf: Fix error linking uprobe_multi on mips
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873092&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050686380

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050686380/job/27779204312
test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050686380/job/27779282003
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050686380/job/27779242545
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10050686380/job/27779265515
test_progs_no_alu32-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10050686380/job/27779280320

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
2: (18) r3 = 0xffff0000c4890c00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
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

--===============1454569527039721626==--

