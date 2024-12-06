Return-Path: <bpf+bounces-46323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AAE9E79F8
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC4F16C007
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E171C4616;
	Fri,  6 Dec 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS0EEAdw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C31C548A;
	Fri,  6 Dec 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516592; cv=none; b=CxxzcuTSVopv+rdPvtWee3GZMjDUiktDlmgFClj/dRtL/MFhNac01xgVJN1zfV6o8WvIV1co7/ljXoj/CLlOL6XQe95O/cKHrdxB/jLIcAWandHNmXu53u+h18r4nhJ/MkUBvjHOZlpoaNrkrsmQbBIr28crqKRoMYrqXvdXFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516592; c=relaxed/simple;
	bh=IgiKD1VD5Vekp+qbThAMAhBM2U5WjXLSW2vueS1r/ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5zQPkUOrwryRoG73r95pmh/l3tsSvg8SMDyPBU9mI/kakdbdHDYugTAWUPg8Z+7eFcr1tICHPVneL08fKOpbvCyOu+IrB/C5pkIJqPzwWeA6NqwYMCR22CcEeyBN6dX3sCy/mLqNZcY+auYYDNz3Xeen/i0OQH2ukrn1c7wlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS0EEAdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447C0C4CED1;
	Fri,  6 Dec 2024 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733516591;
	bh=IgiKD1VD5Vekp+qbThAMAhBM2U5WjXLSW2vueS1r/ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mS0EEAdwMiO0gp9U63MMnnHtL+r9NgGu4C/QYI/CY2Mk/XRtVNAytlllHoVzQukRn
	 AUBsucxDQYvxUFwI9Bl2dEAFUizBzXNPk+342pjXz0V9mMjNjOIhMkR7GQwoAcBSTN
	 6QNOKoVkz47LbZ/EKExKcx4vtrhxcCKDMEviGhkv62xyIpFpbFUyx7C3mHkHMBxNYp
	 0GInbCvqPyUSQOg4IBLn0O/JzQQ5Nj4lJesFiYu+Rq16NxINX49B7JMLTnoDfsZ+oY
	 S39qruC1TR2oM2sG+dfAI46LYTyehH5NHyG+XnLYEhpFdLyF47PAkqckkmVQ8MaDZm
	 GZwkKWozxXddg==
Date: Fri, 6 Dec 2024 12:23:09 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Qiao Zhao <qzhao@redhat.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [BUG] perf trace: failed to load -E2BIG
Message-ID: <Z1NdLbOUBzj91Jut@google.com>
References: <20241206001436.1947528-1-namhyung@kernel.org>
 <CA+JHD90D86YC=Kn3P_B1xLamxKS9+_zOxmKxXMWyTDQGwGnNsQ@mail.gmail.com>
 <CAM9d7ciJjat3fSFEy8PpAa2Q+1=FfkoOFW=5cneAWeS5-e_1Qw@mail.gmail.com>
 <CAATMXfkk4VHyrzwdKfFiRaQbgPN=-EJ5-gf3n2G6Tq=qTNdTRQ@mail.gmail.com>
 <CAH0uvoiG4pXYip9NWGaLK9V5se3_TcVRvoY-Yj46KfO+GTMw4Q@mail.gmail.com>
 <CAH0uvojjyEm0Ezf6sXXvykzjtD9JxijTCNr=8WGGT_r6Fyu_FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojjyEm0Ezf6sXXvykzjtD9JxijTCNr=8WGGT_r6Fyu_FQ@mail.gmail.com>

Cc-ing bpf list.

On Fri, Dec 06, 2024 at 11:03:19AM -0800, Howard Chu wrote:
> Forgot to mention clang-13 gave unbounded memory access too:
> 
> ffffffff,var_off=(0x0; 0xffffffff))
> R9=scalar(id=14,smin=umin=umin32=2,smax=umax=0xffffffff,var_off=(0x0;
> 0xffffffff))
> 90: (85) call bpf_probe_read_user#112
> R2 unbounded memory access, use 'var &= const' or 'if (var < const)'
> processed 490 insns (limit 1000000) max_states_per_insn 2 total_states
> 23 peak_states 23 mark_read 15
> -- END PROG LOAD LOG --
> libbpf: prog 'sys_enter': failed to load: -13
> libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> (was it created?)
> Not enough memory to run!
> 
> Kernel:
> 
> perf $ uname -r
> 6.11.0-061100-generic
> 
> Thanks,
> Howard
> 
> On Fri, Dec 6, 2024 at 10:36 AM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > Hi Qiao, Namhyung, and Arnaldo,
> >
> > Apologies. I observed the same issue and tested perf with trace BPF
> > skel generated by clang-13 to clang-18, turns out BPF skelw generated
> > by clang version <= clang-16 are not loadable, with clang-15 and -16
> > showing the same error as yours. Additionally, the BPF verifier is
> > running longer than usual to process the instructions.
> >
> > perf $ ./perf trace -e write --max-events=1
> > libbpf: prog 'sys_enter': BPF program load failed: Argument list too long
> > libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> > 0: R1=ctx() R10=fp0
> > ; int sys_enter(struct syscall_enter_args *args) @
> > augmented_raw_syscalls.bpf.c:527
> > 0: (bf) r7 = r1                       ; R1=ctx() R7_w=ctx()
> > ; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:423
> > ...
> > 140: (79) r7 = *(u64 *)(r10 -48)      ; R7_w=ctx() R10=fp0 fp-48=ctx()
> > 141: (79) r0 = *(u64 *)(r10 -56)
> > BPF program is too large. Processed 1000001 insn
> > processed 1000001 insns (limit 1000000) max_states_per_insn 28
> > total_states 37670 peak_states 330 mark_read 16
> > -- END PROG LOAD LOG --
> > libbpf: prog 'sys_enter': failed to load: -7
> > libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> > libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -7
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > Not enough memory to run!
> >
> > For clang-14 however, I encountered an unbounded memory access:
> >
> > perf $ ./perf trace -e write --max-events=1
> > libbpf: prog 'sys_enter': BPF program load failed: Permission denied
> > libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> > 0: R1=ctx() R10=fp0
> > ; int sys_enter(struct syscall_enter_args *args) @
> > augmented_raw_syscalls.bpf.c:527
> > 0: (bf) r7 = r1                       ; R1=ctx() R7_w=ctx()
> > ; return bpf_get_current_pid_tgid(); @ augmented_raw_syscalls.bpf.c:423
> > 1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
> > 2: (63) *(u32 *)(r10 -4) = r0         ; R0_w=scalar() R10=fp0 fp-8=mmmm????
> > 88: (79) r1 = *(u64 *)(r10 -16)       ;
> > R1_w=map_value(map=beauty_payload_,ks=4,vs=24688,off=112) R10=fp0
> > fp-16=map_value(map=beauty_payload_,ks=4,vs=24688,off=112)
> > 89: (bf) r2 = r9                      ;
> > R2_w=scalar(id=14,smin=umin=umin32=2,smax=umax=0xffffffff,var_off=(0x0;
> > 0xffffffff)) R9=scalar(id=14,smin=umin=umin32=2,smax=umax=0xffffffff,var_off=(0x0;
> > 0xffffffff))
> > 90: (85) call bpf_probe_read_user#112
> > R2 unbounded memory access, use 'var &= const' or 'if (var < const)'
> > processed 490 insns (limit 1000000) max_states_per_insn 2 total_states
> > 23 peak_states 23 mark_read 15
> > -- END PROG LOAD LOG --
> > libbpf: prog 'sys_enter': failed to load: -13
> > libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> > libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > libbpf: map '__augmented_syscalls__': can't use BPF map without FD
> > (was it created?)
> > Not enough memory to run!
> >
> > I thought I had tested them, but apparently I didn’t. My apologies
> > again, and fixes are on the way.
> >
> > Thanks,
> > Howard

