Return-Path: <bpf+bounces-35317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7249397D5
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51E5282BFF
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862243ADE;
	Tue, 23 Jul 2024 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8D5NP9C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB4273DC
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697529; cv=none; b=pfqhwdZlyCtLs27R2Sl0ivnULbUuuYYUCVZjMuapCfTMiU+xR24Q/rdJMSlMXhpFP/c1y3qdi29o+ZsmpWHedzgTFEXyzApFgrHzZuhTmL41NHYtWbRByEZaGBgrNgiC8evgC1GhUnxlFdIzSWiSDTRBKcmAtbbuy8B6HhYf3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697529; c=relaxed/simple;
	bh=2sWq4pgnBVmlBN4UQt+qMOnCNcZh86KMyHVOXJ9VNxQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=auGoedF/yoZEQVW2b/LpxEOMiOqlj60jWRl6ZD1PeDslHccAV254cGQdwTwnqQ0VEmihPproz6O4oxcOxAv2W3OW4vUxPMnqKTFbilXB5/54MkRnFQVeLUsZA7lPuP4F1tw/+XS9s2njz6LpY+oPYzCpior1C60ChZ/MSvFFYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8D5NP9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D627C116B1;
	Tue, 23 Jul 2024 01:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721697529;
	bh=2sWq4pgnBVmlBN4UQt+qMOnCNcZh86KMyHVOXJ9VNxQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=e8D5NP9CXFOQv+Yt5gYQJAnTRUSF4v7C7I5b7hf/Hj5T8ZvuYnliAt03Ml/7pc9a+
	 EdefFWssx7uiS+9tnyfdlu2FXrbDn1SsfIjFSyZyF+RiDnUSBAn6am49CZZN/1l9C6
	 J9Ak4ammoTgefUFsWSEzHK/TrJteN6LP0btvZx9Hwb0b7mm3ikgjayo1DFqBrBLVUn
	 y223xBQ5uDD+pNWhrPG+oPsR5s5rzaUwEmROqIYLuBW2FelEY27GJ2grYQsLKkF6gL
	 pUonXjZouIt0VeQYaWLu+FPz0JjnmLxpd/aW2K3V8wx9BkZlTJC/MFV2GXCEt8wXrY
	 +pgMzgDBBc8OQ==
Content-Type: multipart/mixed; boundary="===============0632086043324520423=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8077ce3048a284b96e74ac93965219fdac73fada00a37b9a8cff00d193cb9acd@mail.kernel.org>
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/10] no_caller_saved_registers attribute for helper calls
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 01:18:48 +0000 (UTC)

--===============0632086043324520423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,v4,00/10] no_caller_saved_registers attribute for helper calls
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873083&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050709206

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050709206/job/27779271465
test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050709206/job/27779454667
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10050709206/job/27779437404
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10050709206/job/27779452223
test_progs_no_alu32-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10050709206/job/27779453627

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
2: (18) r3 = 0xffff0000c0273a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
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

--===============0632086043324520423==--

