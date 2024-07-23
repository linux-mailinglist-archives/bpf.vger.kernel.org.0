Return-Path: <bpf+bounces-35327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AED9939801
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B39D282C62
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB3C13959B;
	Tue, 23 Jul 2024 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="setc2LfB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9801130499
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698848; cv=none; b=tHf2lurgeM15HoC5misAepj6QnPkoYZZgPbXOVGZgxKkBCrUKC2DbwwOC63NwpwcD92f9xDcHCBw9nmGnPZ7NNnS3ABylni2YFhc0EnJ5CjHBPExrGPo5yKi++lj2S705Ogb5P1bIG9IqXuCBIYwpSDjGbEpnehuhAXoicWDmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698848; c=relaxed/simple;
	bh=+32uefvi4o68VGAZy+TvG+cX44KJ89lnH+ahfxWZogc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=mDe2eFLJtcPqhr92ey+SQcJLS5ZX7i8YjFci4UGyBt0EGer1ba9Xc4j4yTt7TaKl0Ha6jtyQaEsyPM5BUThNo95wfnrvLrGX87nQEpkPg839BXWbFoSwwUbOgd3isHe+ubyrt9W8zyljq8rJZ+HrECoh9YL/U8giIAvrrHB3OPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=setc2LfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39319C116B1;
	Tue, 23 Jul 2024 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721698848;
	bh=+32uefvi4o68VGAZy+TvG+cX44KJ89lnH+ahfxWZogc=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=setc2LfBMpsAFSZ/y7EQnRuzxKcYL2x40Ly2UiaQ8FGYN67RrYRj1rlCSwyQPQymW
	 nvOv9FDiKKJqpy69QTW9TJQV76MCQrflcUoMDSGuKZSbsNGb87gSS908j8qTKfdDLd
	 9dF4eKlKnfmtkXWi694GTe1yi5KTUp/ggE1cZ9JlQ+odth6z2MfqQ6HIhiMSwktBqQ
	 aonKE3T4sNqYwtXf52EcxF+ck2MlkRlt3L67196ek6PWj8/QZ2OCHQE98tMGDkiHS+
	 e0k6/NqaEWVTJxemmTSmBWNQzX/XAZ8qm1s8yox8/uxCSHJNrt2I8Bz7akokIcTAAb
	 Xz35IKxFUJ3/Q==
Content-Type: multipart/mixed; boundary="===============8074460021919642973=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef0b8b19b40c5a709709a2dcd87e0efef92e8b8e31dd435a4ffd9abfb886b058@mail.kernel.org>
In-Reply-To: <20240720052535.2185967-1-tony.ambardar@gmail.com>
References: <20240720052535.2185967-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix wrong binary in Makefile log output
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 01:40:48 +0000 (UTC)

--===============8074460021919642973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,v2] selftests/bpf: Fix wrong binary in Makefile log output
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872645&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050695919

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050695919/job/27779231748
test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050695919/job/27779297532
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050695919/job/27779286074
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10050695919/job/27779294437
test_progs_no_alu32-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10050695919/job/27779298637

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
2: (18) r3 = 0xffff0000c3072800       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
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

--===============8074460021919642973==--

