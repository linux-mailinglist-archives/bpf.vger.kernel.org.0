Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BD6A1645
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 06:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBXFbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 00:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXFbm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 00:31:42 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4B81E1C0
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 21:31:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m7so16473788lfj.8
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 21:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBr7scei8WMrWSmS+XDGH6gXTOmddoHl7DI082wdvHQ=;
        b=apakqd3GKNe7gu2Cezk75l2tedLzAaeMHbYLCuXfzjzRE7UVRo5lyYKEk1jPEAbA1J
         GNUShwIhtlmnnp71PKyjoLS3xk/3bH86oGSW9I9pEz9kl9hQfByAFu5eJEBE1wsQ4Ydf
         b4M+sZYplMRt0zP18vShLCSNsySqS97bQySUoW1AsO65Kflbn/FHETyMw4HIaa3b+WaA
         tF0sAwBlurEkpVj5c4FRELwzjA94ZpBLLtr/AiFxuAsLJbXqpj/3vkf/g2BlAnapsVQ4
         aexTDpnCWQMWrIe3lUtYO+Pkng5UKvYD3F5WtShfaAaZIRRb2tvjsnsgsUfk8oBtRn+Z
         Qf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBr7scei8WMrWSmS+XDGH6gXTOmddoHl7DI082wdvHQ=;
        b=rXuCWsi2Ji1zL3mFy1wpD8EwFs2iViRRFH838Th9ccz5VoXmd6bTS5X4a5dvqxzMyx
         zLTVdAT6IeYiGL83+taPjzMDgxtD979IDyARSQB3VcwwDZe9KfFW32jf/etmdxXoY4Q5
         kJOqXIA+s2+8WtKSwzOBohacqO6iFZEeEBhd0Hz2F/bYZac89D9j0bBRFmSGkM5veZCu
         hDNa5eGaOgonUAgWpgStsoK0C1zc11LPy1aVEE4gku4ecrixy3gKptku+kL3ZePzMkcl
         yCJkyd/mPflWz3n71w7Zv2aMGSTH3ESwDoqgdUGN1by1apqiYzTeq99xSlaNX3NhDyOg
         Be2g==
X-Gm-Message-State: AO0yUKU99KOeZWsKylBmNTQFobpFlTVVohm32Eh8A6LiUSsuzNas0fWY
        usJxghIJXnuDIm4I4ZdEZOprqA==
X-Google-Smtp-Source: AK7set+p8G+KcC9dFbeAfnD5BwPy5sx85P7wywjhafarHZJBkuuCd6G1uWKEPs/IDWm6Z7NkP1E4kQ==
X-Received: by 2002:ac2:5204:0:b0:4dd:a57e:9960 with SMTP id a4-20020ac25204000000b004dda57e9960mr1564398lfl.5.1677216697475;
        Thu, 23 Feb 2023 21:31:37 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id 12-20020ac2482c000000b004cc548b35fbsm660592lft.71.2023.02.23.21.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 21:31:36 -0800 (PST)
Date:   Fri, 24 Feb 2023 05:31:30 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, acme@redhat.com
Subject: Re: bpf: Question about odd BPF verifier behaviour
Message-ID: <Y/hLsgSO3B+2g9iF@google.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
 <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
 <Y/czygarUnMnDF9m@google.com>
 <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 23, 2023 at 02:42:40PM +0200, Eduard Zingerman wrote:
> On Thu, 2023-02-23 at 09:37 +0000, Matt Bobrowski wrote:
> [...]
> > LMK whether you need any more information.
> > 
> > /M
> 
> Hi Matt,
> 
> Unfortunately I can't reproduce the issue.
> Here are the versions of the tools/repos that I use:
> 
> - kernel (tried both):
>   - https://github.com/torvalds/linux.git
>     a5c95ca18a98 ("Merge tag 'drm-next-2023-02-23' of git://anongit.freedesktop.org/drm/drm")
>   - https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>     830b3c68c1fb ("Linux 6.1")
> - config (tried both):
>   - one obtained using your instructions
>   - my small debug config for executing BPF tests ([1])
> - LLVM:
>   https://github.com/llvm/llvm-project.git
>   bc85cf168743 ("[TextAPI] Add support for TBDv5 Files to nm & tapi-diff")
> - pahole:
>   git@github.com:acmel/dwarves.git
>   ef68019 ("pahole: Update man page for options also")
> - libbpf-bootstrap (just followed your instructions):
>   https://github.com/libbpf/libbpf-bootstrap
>   db4f7ad ("cmake: Fix btf header missing in legacy kernel env.")
> - gcc (from my distro):
>   gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)
> - cat /etc/os-release 
>   NAME="Linux Mint"
>   VERSION="21.1 (Vera)"
>   ID=linuxmint
>   ID_LIKE="ubuntu debian"
>   PRETTY_NAME="Linux Mint 21.1"
>   VERSION_ID="21.1"
>   VERSION_CODENAME=vera
>   UBUNTU_CODENAME=jammy
> 
> Could you please copy-paste output of the `fentry` application, I'd
> like to see the log output of the libbpf while it processes
> relocations, e.g. here is what it prints for me:
> 
>     # /home/eddy/work/libbpf-bootstrap/examples/c/fentry
>     libbpf: loading object 'fentry_bpf' from buffer
>     libbpf: elf: section(3) lsm.s/bprm_committed_creds, size 136, link 0, flags 6, type=1
>     libbpf: sec 'lsm.s/bprm_committed_creds': found program 'dbg' at insn offset 0 (0 bytes), code size 17 insns (136 bytes)
>     libbpf: elf: section(4) license, size 13, link 0, flags 3, type=1
>     libbpf: license of fentry_bpf is Dual BSD/GPL
>     libbpf: elf: section(5) .BTF, size 5114, link 0, flags 0, type=1
>     libbpf: elf: section(7) .BTF.ext, size 188, link 0, flags 0, type=1
>     libbpf: elf: section(10) .symtab, size 96, link 1, flags 0, type=2
>     libbpf: looking for externs among 4 symbols...
>     libbpf: collected 0 externs total
>     libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
>     libbpf: sec 'lsm.s/bprm_committed_creds': found 1 CO-RE relocations
>     libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [7241] struct linux_binprm in [vmlinux]
>     libbpf: prog 'dbg': relo #0: <byte_off> [6] struct linux_binprm.file (0:11 @ offset 64)
>     libbpf: prog 'dbg': relo #0: matching candidate #0 <byte_off> [7241] struct linux_binprm.file (0:11 @ offset 64)
>     libbpf: prog 'dbg': relo #0: patched insn #10 (LDX/ST/STX) off 64 -> 64
>     Successfully started! Please run `sudo cat /sys/kernel/debug/tracing/trace_pipe` to see output of the BPF programs.

Sure, here it is:

# ./fentry
libbpf: loading object 'fentry_bpf' from buffer
libbpf: elf: section(3) lsm.s/bprm_committed_creds, size 136, link 0, flags 6, type=1
libbpf: sec 'lsm.s/bprm_committed_creds': found program 'dbg' at insn offset 0 (0 bytes), code size 17 insns (136 bytes)
libbpf: elf: section(4) license, size 13, link 0, flags 3, type=1
libbpf: license of fentry_bpf is Dual BSD/GPL
libbpf: elf: section(5) .BTF, size 5149, link 0, flags 0, type=1
libbpf: elf: section(7) .BTF.ext, size 188, link 0, flags 0, type=1
libbpf: elf: section(10) .symtab, size 96, link 1, flags 0, type=2
libbpf: looking for externs among 4 symbols...
libbpf: collected 0 externs total
libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
libbpf: sec 'lsm.s/bprm_committed_creds': found 1 CO-RE relocations
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [3971] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [9214] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [36310] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [36973] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [122219] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [151720] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [163602] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [175117] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [176645] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [179130] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [189263] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [237046] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [240978] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [264207] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [268773] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [276058] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [295158] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [306160] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [347067] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [349932] struct linux_binprm in [vmlinux]
libbpf: CO-RE relocating [6] struct linux_binprm: found target candidate [380629] struct linux_binprm in [vmlinux]
libbpf: prog 'dbg': relo #0: <byte_off> [6] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #0 <byte_off> [3971] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #1 <byte_off> [9214] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #2 <byte_off> [36310] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #3 <byte_off> [36973] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #4 <byte_off> [122219] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #5 <byte_off> [151720] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #6 <byte_off> [163602] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #7 <byte_off> [175117] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #8 <byte_off> [176645] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #9 <byte_off> [179130] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #10 <byte_off> [189263] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #11 <byte_off> [237046] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #12 <byte_off> [240978] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #13 <byte_off> [264207] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #14 <byte_off> [268773] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #15 <byte_off> [276058] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #16 <byte_off> [295158] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #17 <byte_off> [306160] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #18 <byte_off> [347067] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #19 <byte_off> [349932] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: matching candidate #20 <byte_off> [380629] struct linux_binprm.file (0:11 @ offset 64)
libbpf: prog 'dbg': relo #0: patched insn #10 (LDX/ST/STX) off 64 -> 64
libbpf: prog 'dbg': BPF program load failed: Permission denied
libbpf: prog 'dbg': -- BEGIN PROG LOAD LOG --
reg type unsupported for arg#0 function dbg#5
0: R1=ctx(off=0,imm=0) R10=fp0
; int BPF_PROG(dbg, struct linux_binprm *bprm)
0: (79) r1 = *(u64 *)(r1 +0)
func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 176645 type STRUCT 'linux_binprm'
1: R1_w=trusted_ptr_linux_binprm(off=0,imm=0)
1: (b7) r2 = 0                        ; R2_w=0
; char buf[64] = {0};
2: (7b) *(u64 *)(r10 -8) = r2         ; R2_w=0 R10=fp0 fp-8_w=00000000
3: (7b) *(u64 *)(r10 -16) = r2        ; R2_w=0 R10=fp0 fp-16_w=00000000
4: (7b) *(u64 *)(r10 -24) = r2        ; R2_w=0 R10=fp0 fp-24_w=00000000
5: (7b) *(u64 *)(r10 -32) = r2        ; R2_w=0 R10=fp0 fp-32_w=00000000
6: (7b) *(u64 *)(r10 -40) = r2        ; R2_w=0 R10=fp0 fp-40_w=00000000
7: (7b) *(u64 *)(r10 -48) = r2        ; R2_w=0 R10=fp0 fp-48_w=00000000
8: (7b) *(u64 *)(r10 -56) = r2        ; R2_w=0 R10=fp0 fp-56_w=00000000
9: (7b) *(u64 *)(r10 -64) = r2        ; R2_w=0 R10=fp0 fp-64_w=00000000
; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
10: (79) r1 = *(u64 *)(r1 +64)        ; R1_w=ptr_file(off=0,imm=0)
11: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
; 
12: (07) r2 += -64                    ; R2_w=fp-64
; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
13: (b7) r3 = 64                      ; R3_w=64
14: (85) call bpf_ima_file_hash#193
cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
R1 is of type file but file is expected
processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'dbg': failed to load: -13
libbpf: failed to load object 'fentry_bpf'
libbpf: failed to load BPF skeleton 'fentry_bpf': -13
Failed to open BPF skeleton

It looks like there are a lot more relocations attempted by libbpf,
but I suspect that's a result of their being multiple definitions of
that same struct within the running kernel's BTF?

> Also, could you please compile `veristat` tool as below:
> 
>     cd ${kernel}/tools/testing/selftests/bpf
>     make -j16 veristat
> 
> And post the output of the following command (from within QEMU):
> 
>     ./veristat -l7 -v ${path-to-libbpf-bootstrap-within-vm}/examples/c/.output/fentry.bpf.o
> 
> It should produce the verification log as an output.
> 
> The reason I'm asking is that your verification log looks kinda strange:
> 
> >    ; bpf_ima_file_hash(bprm->file, buf, 64);
> >    13: (b7) r3 = 64                      ; R3_w=64
> >    14: (85) call bpf_ima_file_hash#193
> >    cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
> >    R1 is of type file but file is expected
> >    processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> 
> I don't understand why it mentions `struct llist_node` here and don't
> have such messages in my log ([2]).

Yes, I also found this strange and couldn't find a valid explanation
for it either. Looking at the BPF verifier code in the kernel, we hit
this case when performing the struct member walk in btf_struct_walk().

Here is the output from the veristat utility:

./veristat -l7 -v ./fentry.bpf.o 
Processing 'fentry.bpf.o'...
libbpf: prog 'dbg': BPF program load failed: Permission denied
libbpf: prog 'dbg': failed to load: -13
libbpf: failed to load object './fentry.bpf.o'
PROCESSING ./fentry.bpf.o/dbg, DURATION US: 4903, VERDICT: failure, VERIFIER LOG:
func#0 @0
reg type unsupported for arg#0 function dbg#5
0: R1=ctx(off=0,imm=0) R10=fp0
; int BPF_PROG(dbg, struct linux_binprm *bprm)
0: (79) r1 = *(u64 *)(r1 +0)
func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 176645 type STRUCT 'linux_binprm'
1: R1_w=trusted_ptr_linux_binprm(off=0,imm=0)
1: (b7) r2 = 0                        ; R2_w=0
; char buf[64] = {0};
2: (7b) *(u64 *)(r10 -8) = r2
last_idx 2 first_idx 0
regs=4 stack=0 before 1: (b7) r2 = 0
3: R2_w=0 R10=fp0 fp-8_w=00000000
3: (7b) *(u64 *)(r10 -16) = r2
last_idx 3 first_idx 0
regs=4 stack=0 before 2: (7b) *(u64 *)(r10 -8) = r2
regs=4 stack=0 before 1: (b7) r2 = 0
4: R2_w=0 R10=fp0 fp-16_w=00000000
4: (7b) *(u64 *)(r10 -24) = r2
last_idx 4 first_idx 0
regs=4 stack=0 before 3: (7b) *(u64 *)(r10 -16) = r2
regs=4 stack=0 before 2: (7b) *(u64 *)(r10 -8) = r2
regs=4 stack=0 before 1: (b7) r2 = 0
5: R2_w=0 R10=fp0 fp-24_w=00000000
5: (7b) *(u64 *)(r10 -32) = r2
last_idx 5 first_idx 0
regs=4 stack=0 before 4: (7b) *(u64 *)(r10 -24) = r2
regs=4 stack=0 before 3: (7b) *(u64 *)(r10 -16) = r2
regs=4 stack=0 before 2: (7b) *(u64 *)(r10 -8) = r2
regs=4 stack=0 before 1: (b7) r2 = 0
6: R2_w=0 R10=fp0 fp-32_w=00000000
6: (7b) *(u64 *)(r10 -40) = r2
last_idx 6 first_idx 0
regs=4 stack=0 before 5: (7b) *(u64 *)(r10 -32) = r2
regs=4 stack=0 before 4: (7b) *(u64 *)(r10 -24) = r2
regs=4 stack=0 before 3: (7b) *(u64 *)(r10 -16) = r2
regs=4 stack=0 before 2: (7b) *(u64 *)(r10 -8) = r2
regs=4 stack=0 before 1: (b7) r2 = 0
7: R2_w=0 R10=fp0 fp-40_w=00000000
7: (7b) *(u64 *)(r10 -48) = r2
last_idx 7 first_idx 0
regs=4 stack=0 before 6: (7b) *(u64 *)(r10 -40) = r2
regs=4 stack=0 before 5: (7b) *(u64 *)(r10 -32) = r2
regs=4 stack=0 before 4: (7b) *(u64 *)(r10 -24) = r2
regs=4 stack=0 before 3: (7b) *(u64 *)(r10 -16) = r2
regs=4 stack=0 before 2: (7b) *(u64 *)(r10 -8) = r2
regs=4 stack=0 before 1: (b7) r2 = 0
8: R2_w=0 R10=fp0 fp-48_w=00000000
8: (7b) *(u64 *)(r10 -56) = r2
last_idx 8 first_idx 0
regs=4 stack=0 before 7: (7b) *(u64 *)(r10 -48) = r2
regs=4 stack=0 before 6: (7b) *(u64 *)(r10 -40) = r2
regs=4 stack=0 before 5: (7b) *(u64 *)(r10 -32) = r2
regs=4 stack=0 before 4: (7b) *(u64 *)(r10 -24) = r2
regs=4 stack=0 before 3: (7b) *(u64 *)(r10 -16) = r2
regs=4 stack=0 before 2: (7b) *(u64 *)(r10 -8) = r2
regs=4 stack=0 before 1: (b7) r2 = 0
9: R2_w=0 R10=fp0 fp-56_w=00000000
9: (7b) *(u64 *)(r10 -64) = r2
last_idx 9 first_idx 0
regs=4 stack=0 before 8: (7b) *(u64 *)(r10 -56) = r2
regs=4 stack=0 before 7: (7b) *(u64 *)(r10 -48) = r2
regs=4 stack=0 before 6: (7b) *(u64 *)(r10 -40) = r2
regs=4 stack=0 before 5: (7b) *(u64 *)(r10 -32) = r2
regs=4 stack=0 before 4: (7b) *(u64 *)(r10 -24) = r2
regs=4 stack=0 before 3: (7b) *(u64 *)(r10 -16) = r2
regs=4 stack=0 before 2: (7b) *(u64 *)(r10 -8) = r2
regs=4 stack=0 before 1: (b7) r2 = 0
10: R2_w=0 R10=fp0 fp-64_w=00000000
; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
10: (79) r1 = *(u64 *)(r1 +64)        ; R1_w=ptr_file(off=0,imm=0)
11: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
; 
12: (07) r2 += -64                    ; R2_w=fp-64
; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
13: (b7) r3 = 64                      ; R3_w=64
14: (85) call bpf_ima_file_hash#193
cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
R1 is of type file but file is expected
verification time 4903 usec
stack depth 64
processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

File          Program  Verdict  Duration (us)  Insns  States  Peak states
------------  -------  -------  -------------  -----  ------  -----------
fentry.bpf.o  dbg      failure           4903     15       0            0
------------  -------  -------  -------------  -----  ------  -----------
Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.

> [1] My config for BPF testing
>     https://gist.github.com/eddyz87/aca79692d7bf57cfdd01b283b4304fd8
> [2] Veristat verification log
>     https://gist.github.com/eddyz87/49b211740bf99c426a37a3555b4542a3

/M
