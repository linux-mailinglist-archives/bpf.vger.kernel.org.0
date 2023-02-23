Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7030E6A0509
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 10:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjBWJhl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 04:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjBWJhj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 04:37:39 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFF515F0
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 01:37:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m7so12985250lfj.8
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 01:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4jcY3Hr7EE2Olq+/x/mn+U//ThHzLvzlE87RvTwn58=;
        b=fi56/eYkJ2DbpmpHRWFHkOcoVy1p0Du6dybLu/JZxmQHv+oAuLOrbwDVwzoQIuzVNc
         s8LnP0Kc5+yZhmHdATksfqgOVXQ3wjNEDv91P3N/04+n8PSvTC6wmVlLMOe60oZcTgU9
         X4qYSOAMYIRo8t9N7kzsjlUkEmPIhMRlI3khGY014DlX6YWb2fRALYzETud+1tAbemu+
         LjwQYkx8aBe37ioYFkgnYPCnvh6Qs9llPYwBZYmx3cAe10dRmeCSxoBh828LyvwFntLZ
         jkTs9YE4dq+FhVKxH7jmhfEJQEZkKlcAh2Q73lYz+WGAxtH+ZaZfFY5FuRUZF6j6yxf/
         4JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4jcY3Hr7EE2Olq+/x/mn+U//ThHzLvzlE87RvTwn58=;
        b=CWSTFZcTuEuieZWwTNRQYpUfxOv62IIRZQkYTO3F/lMCDzSkXxGI85c5XgvSo2DIMm
         wegSc4FuZBgM27j1/PsNthEJHvVOIAITI8Pti3PNPnqlI3F9EBmeXUlOJM8LO8jbwlMn
         geX4wzYfz6a6lHEdEKV+bxpD3ckxAG8w/Ir15CQeUAUQi6Pm0Eq1yBSxQpgqKDX5GWB2
         x/GYLf/8cvDm6YPH86LWpBNlJ78tR0KbSNe2a3T6aK7nt3O+b5ilUMc5/cTxQFO2XyB1
         gLZUi9VHfcU2e11rr7zytPN6EJUW6Noi8TMM2aWuijt4Azf+w5JLYV2Ol4YfXC62hAOd
         Ijzw==
X-Gm-Message-State: AO0yUKU5A5BeRb/LR5WBf3Is1twpAfb9UfT7m/te48mm9I4MfImLOvKh
        M4gr1ACFZ+MdgFki1e8Sw6FDHw==
X-Google-Smtp-Source: AK7set//EXFFlOIFfRU2EMgB2c+0LFTUgFbC+yoEIx912ZVpQZsn3qVOASd0fAbGqYfIvbTgk1sQtQ==
X-Received: by 2002:ac2:554a:0:b0:4a4:68b9:66b7 with SMTP id l10-20020ac2554a000000b004a468b966b7mr3835638lfk.2.1677145040718;
        Thu, 23 Feb 2023 01:37:20 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id d27-20020ac244db000000b004cb10c151fasm780243lfm.88.2023.02.23.01.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:37:19 -0800 (PST)
Date:   Thu, 23 Feb 2023 09:37:14 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, acme@redhat.com
Subject: Re: bpf: Question about odd BPF verifier behaviour
Message-ID: <Y/czygarUnMnDF9m@google.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
 <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
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

Hey Eduard!


On Wed, Feb 22, 2023 at 05:28:52PM +0200, Eduard Zingerman wrote:
> On Mon, 2023-02-20 at 22:35 +0000, Matt Bobrowski wrote:
> > Hello!
> > 
> > Whilst in the midst of testing a v5.19 to v6.1 kernel upgrade, we
> > happened to notice that one of our sleepable LSM based eBPF programs
> > was failing to load on the newer v6.1 kernel. Using the below trivial
> > eBPF program as our reproducer:
> > 
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_tracing.h>
> > 
> > char LICENSE[] SEC("license") = "Dual BSD/GPL";
> > 
> > SEC("lsm.s/bprm_committed_creds")
> > int BPF_PROG(dbg, struct linux_binprm *bprm)
> > {
> > 	char buf[64] = {0};
> > 	bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
> > 	return 0;
> > }
> > 
> > The verifier emits the following error message when attempting to load
> > the above eBPF program:
> > 
> > -- BEGIN PROG LOAD LOG --
> > reg type unsupported for arg#0 function dbg#5
> > 0: R1=ctx(off=0,imm=0) R10=fp0
> > ; int BPF_PROG(dbg, struct linux_binprm *bprm)
> > 0: (79) r1 = *(u64 *)(r1 +0)
> > func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 137293 type STRUCT 'linux_binprm'
> > 1: R1_w=ptr_linux_binprm(off=0,imm=0)
> > 1: (b7) r2 = 0                        ; R2_w=0
> > ; char buf[64] = {0};
> > [...]
> > ; bpf_ima_file_hash(bprm->file, buf, 64);
> > 10: (79) r1 = *(u64 *)(r1 +64)        ; R1_w=ptr_file(off=0,imm=0)
> > 11: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
> > ; 
> > 12: (07) r2 += -64                    ; R2_w=fp-64
> > ; bpf_ima_file_hash(bprm->file, buf, 64);
> > 13: (b7) r3 = 64                      ; R3_w=64
> > 14: (85) call bpf_ima_file_hash#193
> > cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
> > R1 is of type file but file is expected
> > processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> > 
> > What particularly strikes out at me is the following 2 lines returned
> > in the error message:
> > 
> > cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
> > R1 is of type file but file is expected
> 
> Hi Matt,
> 
> I tried your program as a ./test_progs test using v6.1 kernel and
> don't see any error messages:
>
> VERIFIER LOG:
> =============
> func#0 @0
> reg type unsupported for arg#0 function dbg#5
> 0: R1=ctx(off=0,imm=0) R10=fp0
> ; int BPF_PROG(dbg, struct linux_binprm *bprm)
> 0: (79) r1 = *(u64 *)(r1 +0)
> func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 3061 type STRUCT 'linux_binprm'
> 1: R1_w=ptr_linux_binprm(off=0,imm=0)
> 1: (b7) r2 = 0                        ; R2_w=0
> ; char buf[64] = {0};
> 2: (7b) *(u64 *)(r10 -8) = r2
> last_idx 2 first_idx 0
> regs=4 stack=0 before 1: (b7) r2 = 0
> 3: R2_w=P0 R10=fp0 fp-8_w=00000000
> 3: (7b) *(u64 *)(r10 -16) = r2        ; R2_w=P0 R10=fp0 fp-16_w=00000000
> 4: (7b) *(u64 *)(r10 -24) = r2        ; R2_w=P0 R10=fp0 fp-24_w=00000000
> 5: (7b) *(u64 *)(r10 -32) = r2        ; R2_w=P0 R10=fp0 fp-32_w=00000000
> 6: (7b) *(u64 *)(r10 -40) = r2        ; R2_w=P0 R10=fp0 fp-40_w=00000000
> 7: (7b) *(u64 *)(r10 -48) = r2        ; R2_w=P0 R10=fp0 fp-48_w=00000000
> 8: (7b) *(u64 *)(r10 -56) = r2        ; R2_w=P0 R10=fp0 fp-56_w=00000000
> 9: (7b) *(u64 *)(r10 -64) = r2        ; R2_w=P0 R10=fp0 fp-64_w=00000000
> ; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
> 10: (79) r1 = *(u64 *)(r1 +64)        ; R1_w=ptr_file(off=0,imm=0)
> 11: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
> ; 
> 12: (07) r2 += -64                    ; R2_w=fp-64
> ; bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
> 13: (b4) w3 = 64                      ; R3_w=64
> 14: (85) call bpf_ima_file_hash#193
> last_idx 14 first_idx 0
> regs=8 stack=0 before 13: (b4) w3 = 64
> 15: R0_w=scalar() fp-8_w=mmmmmmmm fp-16_w=mmmmmmmm fp-24_w=mmmmmmmm fp-32_w=mmmmmmmm fp-40_w=mmmmmmmm fp-48_w=mmmmmmmm fp-56_w=mmmmmmmm fp-64_w=mmmmmmmm
> ; int BPF_PROG(dbg, struct linux_binprm *bprm)
> 15: (b4) w0 = 0                       ; R0_w=0
> 16: (95) exit
> 
> I use the following revision: 830b3c68c1fb "Linux 6.1".
> (also works with current bpf-next master).
> 
> Could you please provide some details on how you compile/load the program?

Firstly, thanks for taking a peek at this! Secondly, I do apologies, I
should've provided some more detailed on how I'm reproducing this in
my initial email. Below you can find a transcript of how I'm
conducting my tests:

The source OS which things (kernel and BPF reproducer program) are
being built on:

 $ cat /etc/os-release 
 PRETTY_NAME="Debian GNU/Linux rodete"
 NAME="Debian GNU/Linux"
 VERSION_ID="rodete"
 VERSION="12 (rodete)"
 VERSION_CODENAME=rodete
 ID=debian

Building latest LLVM and Pahole from source:

 $ sudo apt install -y cmake

 $ cmake --version
 cmake version 3.25.1

 $ git clone https://github.com/llvm/llvm-project.git  && cd llvm-project && \
 mkdir build && \
 cd build && \
 cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm && \
 make -j $(nproc) && \
 sudo make install

 $ clang --version
 clang version 17.0.0 (https://github.com/llvm/llvm-project.git bc85cf1687435f28fb01b1aa5303317e6118490c)
 Target: x86_64-unknown-linux-gnu
 Thread model: posix
 InstalledDir: /usr/local/bin

 $ sudo apt install -y libdwarf-dev libdw-dev

 $ git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git && \
 cd pahole && \
 mkdir build && \
 cd build && \
 cmake -DCMAKE_INSTALL_PREFIX=/usr -D__LIB=lib .. && \
 make -j $(nproc) && \
 sudo make install

 $ pahole --version
 v1.25

Building a test kernel:

 $ git clone https://github.com/torvalds/linux.git && cd linux

 $ make defconfig && make kvm_guest.config

 $ scripts/config \
 -e BPF \
 -e BPF_SYSCALL \
 -e BPF_LSM \
 -e BPF_JIT \
 -e BPF_EVENTS \
 -e DEBUG_INFO \
 -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
 -e DEBUG_INFO_BTF \
 -e DEBUG_INFO_BTF_MODULES \
 -e PAHOLE_HAS_SPLIT_BTF \
 -e FTRACE \
 -e DYNAMIC_FTRACE \
 -e FUNCTION_TRACER

 $ make olddefconfig

 $ make -j`nproc`

Building the BPF reproducer program:

 $ git clone https://github.com/libbpf/libbpf-bootstrap.git

 # Both libbpf and bpftool should be the latest versions here.
 $ git submodule update --init --recursive

 $ cd examples/c

 $ cat > fentry.bpf.c<<EOF
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>

 char LICENSE[] SEC("license") = "Dual BSD/GPL";

 SEC("lsm.s/bprm_committed_creds")
 int BPF_PROG(dbg, struct linux_binprm *bprm)
 {
 char buf[64] = {0};
 bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
 return 0;
 }
 EOF

 $ make -j`nproc` fentry


At this point, I basically launch the built kernel using QEMU and push
the built 'fentry' BPF program to the VM and run it. At that point, I
face the BPF verifier issue.

LMK whether you need any more information.

/M
