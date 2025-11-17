Return-Path: <bpf+bounces-74703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453CC62D46
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BEDF4E69B7
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E898223F429;
	Mon, 17 Nov 2025 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBxVfjMn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682A8462
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366481; cv=none; b=BSc/Wlv1WtUb53v4ubCSMb1t6jPwpMcgLcke30TMgdR/DhDpru0HjR0hcyLpzO+0JWoP06KG3ekiVYKiiDSZwZITFHBABsjjR6mZP04ayjIU0z6FgzqEY59YT9F7kZ1aVpWmciBKtVSMVkxlZMm+SZ6OqrFx9U5DmpvGyXeTkS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366481; c=relaxed/simple;
	bh=ldWrn4/4dGN5tyDYADFjeNSDikUmn5bLbi1mO0yfGTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9NqG1e2vxZWuIsWJW4NmRhHAqKqwZYaD4boKLCFYMhGck+BWNeXAhz5sZdgPUcZOOAsefW59S2eYagDj/SgwIF/0gLqGBKCDMwUkBZ+3qZ9qDNo42IuO5EtrAEfXz9+tbcB95ZEPU2lPlfB6h2g1wuM7ER9m0Q0C0SNYGNFfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBxVfjMn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso20195015e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 00:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763366478; x=1763971278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ2V3ClwzvtK5ZGuVjKWlrVxcpGffy1Lae3rK4VNwNI=;
        b=VBxVfjMnQjreMt9osVt+wT5oz+D+kTFCKU/G9tPpndqX40qBouR1EAuvDgZVB4XNbx
         COaOmmrA8EI/D6OrIGrfk8p5n97qSLO1v/CVtYpT21zA0ypZF/C+xubGQvdIjNfam7tH
         86IAqKM5O4h1yAg+hzE7UnI1BhxQnTZ52g+/8AuNwTcMkEG3jIvwXGVnWrXQUnIY6tzc
         uF8HknyUK0tw/abm8QfC3SHtb33Pojk6gZjFxZ729QUV+w1EBOYqRCFHg7Idce16Z7Dn
         A0VmTOkOiqt6SG9Utx00eH3QSzx6sbnST8+lYwI7fZj/9uX+CU8Uf7JMQEFYACv9WptQ
         BJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763366478; x=1763971278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZ2V3ClwzvtK5ZGuVjKWlrVxcpGffy1Lae3rK4VNwNI=;
        b=W8eYtajXvxV9ELWIGiWjSJIIgv16StyZ4jGK3O9bVSjQdHEuABlwLa/kdWRxOBjARh
         AArBwjGI7UVwQ5qEJ6mzZ6TEYjHMJFZecN4b37I19L3nC6uqmitNzH7ThRWudUBr6W/o
         lysrdW4dCPuTRnEXw7Ls4pP5HqrVLk0PNqUuCxSVqDEb2wYWw7ikbkOw9jr2A5RVApfN
         XR1XayZkIwjMVyhmGDTBSYvNbElbgoBP66BsIU228gnSsNIttnLofVKiVPK2CXcRLozl
         6uYKhRFR1m+ZjJ18UKo+Dqtbh+tU+SN/ttPAqPIikZ+hndg5oLf9SYBU6s/fh963VGOS
         DDIg==
X-Gm-Message-State: AOJu0Yzk1ZgFMMW4nDzSxNbFBzl2ziVcPZRV52FPt1fHjEgSYJuKl6vo
	rlCZkQpsaJn6j8rUiKS3ujFSKoAxXfB/0HOaMu59/LtQls8ht4JAhRZD
X-Gm-Gg: ASbGncsXvmWtekvprHH93qrXsAPH4uIJlnwwn6XOdh6I1/UPpA+P5QYyJ0hldKsPGo6
	xIcixIOBXZBhULm4otqhGVg+03HLewU+JMCUsn+2SkWXmMl8ZkUbAnCGJTsnBAuy2XA+ktmmoXs
	pxJHpUWVbx64bQO8t5V8hWDmF4Fp28ugg6xAxywhpt3Dn2+mkaOA1wkVAAFQbwS42fiEFIlPmPA
	jyVMN+DPHIEc7IhaSgvSiPkw4XAOfQAJq1IN4MP0qbwJD8HaQwrYwM3+i4jzTgbea9rUWRrxzN5
	2xbpCZ8hWtRroRouH8e+Lyr4eXEy4Wx2fa6ZD9YY4Eh57jhVliVVzpwvoNYWjRJGFOqhYRItTlg
	A8SVNtS45/lgdm7o/pnwsJcCJIovNHU+y4ZJls2YTfIVU6EwjTcWhHU/N65gBo4DU/GHvfHPdS/
	JourYBK47xFQVDFXadOGhI
X-Google-Smtp-Source: AGHT+IEhwXWnh2PDBFttyEHjm0POpI/lLrbUZ8xaDLMLJTs2KphK+Y5wvtZEhdvs+QS0FF8TSNNItA==
X-Received: by 2002:a05:600c:c178:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-4778fe5732cmr97775695e9.14.1763366477391;
        Mon, 17 Nov 2025 00:01:17 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779525d2bcsm151309385e9.5.2025.11.17.00.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:01:16 -0800 (PST)
Date: Mon, 17 Nov 2025 08:08:13 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel-team@meta.com,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 0/4] bpf: arm64: Indirect jumps
Message-ID: <aRrX7eXoWL1RhtJO@mail.gmail.com>
References: <20251117004656.33292-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117004656.33292-1-puranjay@kernel.org>

On 25/11/17 12:46AM, Puranjay Mohan wrote:
> This set adds the support of indirect jumps to the arm64 JIT. It
> involves calling bpf_prog_update_insn_ptrs() to support instructions
> array map. The second piece is supporting BPF_JMP|BPF_X|BPF_JA, SRC=0,
> DST=Rx, off=0, imm=0 instruction that is trivial to implement on arm64.
>
> When running the selftests after doing the above changes, I found that
> on arm64 builds of llvm, a relocation section was being generated for
> .jumptables sections and it was making libbpf fail like:
> 
> libbpf: relocation against STT_SECTION in non-exec section is not supported!
> Error: failed to link 'tools/testing/selftests/bpf/cpuv4/bpf_gotox.bpf.o': Invalid argument (22)
> 
> Which is due to:
> 
> Relocation section '.rel.jumptables' at offset 0x5b50 contains 263 entries:
>     Offset             Info             Type               Symbol's Value  Symbol's Name
> 0000000000000000  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
> 0000000000000008  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
> 0000000000000010  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
> 
> This rel section is not generated by x86 builds of LLVM. The third patch
> of this set makes libbpf ignore relocation sections for .jumptables.

I added Yonghong to this thread. He had fixed this problem in
https://github.com/llvm/llvm-project/pull/166301 changes doesn't seem to be
x86-specific...

> 
> The final patch enables selftests on arm64:
> 
>  [root@localhost bpf]# ./test_progs-cpuv4 -a "*gotox*"
>  #20/1    bpf_gotox/one-switch:OK
>  #20/2    bpf_gotox/one-switch-non-zero-sec-offset:OK
>  #20/3    bpf_gotox/two-switches:OK
>  #20/4    bpf_gotox/big-jump-table:OK
>  #20/5    bpf_gotox/static-global:OK
>  #20/6    bpf_gotox/nonstatic-global:OK
>  #20/7    bpf_gotox/other-sec:OK
>  #20/8    bpf_gotox/static-global-other-sec:OK
>  #20/9    bpf_gotox/nonstatic-global-other-sec:OK
>  #20/10   bpf_gotox/one-jump-two-maps:OK
>  #20/11   bpf_gotox/one-map-two-jumps:OK
>  #20      bpf_gotox:OK
>  #537/1   verifier_gotox/jump_table_ok:OK
>  #537/2   verifier_gotox/jump_table_reserved_field_src_reg:OK
>  #537/3   verifier_gotox/jump_table_reserved_field_non_zero_off:OK
>  #537/4   verifier_gotox/jump_table_reserved_field_non_zero_imm:OK
>  #537/5   verifier_gotox/jump_table_no_jump_table:OK
>  #537/6   verifier_gotox/jump_table_incorrect_dst_reg_type:OK
>  #537/7   verifier_gotox/jump_table_invalid_read_size_u32:OK
>  #537/8   verifier_gotox/jump_table_invalid_read_size_u16:OK
>  #537/9   verifier_gotox/jump_table_invalid_read_size_u8:OK
>  #537/10  verifier_gotox/jump_table_misaligned_access:OK
>  #537/11  verifier_gotox/jump_table_invalid_mem_acceess_pos:OK
>  #537/12  verifier_gotox/jump_table_invalid_mem_acceess_neg:OK
>  #537/13  verifier_gotox/jump_table_add_sub_ok:OK
>  #537/14  verifier_gotox/jump_table_no_writes:OK
>  #537/15  verifier_gotox/jump_table_use_reg_r0:OK
>  #537/16  verifier_gotox/jump_table_use_reg_r1:OK
>  #537/17  verifier_gotox/jump_table_use_reg_r2:OK
>  #537/18  verifier_gotox/jump_table_use_reg_r3:OK
>  #537/19  verifier_gotox/jump_table_use_reg_r4:OK
>  #537/20  verifier_gotox/jump_table_use_reg_r5:OK
>  #537/21  verifier_gotox/jump_table_use_reg_r6:OK
>  #537/22  verifier_gotox/jump_table_use_reg_r7:OK
>  #537/23  verifier_gotox/jump_table_use_reg_r8:OK
>  #537/24  verifier_gotox/jump_table_use_reg_r9:OK
>  #537/25  verifier_gotox/jump_table_outside_subprog:OK
>  #537/26  verifier_gotox/jump_table_contains_non_unique_values:OK
>  #537     verifier_gotox:OK
>  Summary: 2/37 PASSED, 0 SKIPPED, 0 FAILED

Cool!

> Puranjay Mohan (4):
>   bpf: arm64: Add support for instructions array
>   bpf: arm64: Add support for indirect jumps
>   libbpf: Ignore relocations for .jumptables sections
>   selftests: bpf: Enable gotox tests from arm64
> 
>  arch/arm64/net/bpf_jit_comp.c                      | 11 +++++++++++
>  tools/lib/bpf/linker.c                             |  4 ++++
>  tools/testing/selftests/bpf/progs/verifier_gotox.c |  4 ++--
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> -- 
> 2.47.3
> 

