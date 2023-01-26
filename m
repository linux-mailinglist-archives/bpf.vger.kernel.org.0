Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F059367C1EF
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 01:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjAZApx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 19:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjAZApx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 19:45:53 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B215D937
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 16:45:48 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id az20so1296447ejc.1
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOEC8SB7v330+Sk2qj8L+u+lszgSkd7W+1tbXot07Gw=;
        b=HIlxiEu5221erPCWLfOoXF2dtQ5ykIWVYgGqdQumvw3QX22Do1qATe/o3etaYXRfQ8
         JPhMxXPLm6xvUXzYnD7GXhoKu2W9Wpoa2n4a7kLsduPnSZHJQb6oLYYq4312HW6iAVXY
         qVFC82GK8R8oRPd9N5NgM3pM8AhuBtT/dFXlfqLlR0fAxYGaKKs61eIvo1onUMn/PFiw
         B38CGbiudw885rK3emyKLycuoz4h68dU8afGEDXrjBcTMMyK1SrxQKniLRcbs9ZPc1tS
         0+CL0WRmqhfdBR9U9j1pajYANoRKaiiyfKzp63h5t6O/l99nCvKoTuUwQGrY6yk1GH2I
         ZilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOEC8SB7v330+Sk2qj8L+u+lszgSkd7W+1tbXot07Gw=;
        b=XVMz32TqodvzztZmutLTTzwNM/i8gAHB0WfDYp06dzBzmU7iXPbznVM/p6E3viWABd
         wEGWmbWsg6lZ2y4QlJuwY7CNUI8+nClGn/zbssxTmN2z0wT2MUkraGalSE0PXw6ehTID
         FpmNqLMiyONGDR16W8YqjKugAFyHic6b+mCeMJm4n6DPK5fJJshdA0w5nexXubDt961l
         6aSn59EuoNGgdN5TDlINX0n1vkF/i6UzgmRFm5c0F+YmMPkIRw8uaBhBHtqSKjZ7gS1j
         NYFdoUh19svssd2Ph6JYetig1vsu9HSHnP2N/PYsMgEYQxGEKerlDl6jM2+eq/MGLR1w
         F7ng==
X-Gm-Message-State: AFqh2krVoiOt7YJhfpf7kZ0+hGgworNOy+/7hsZWjydG00xjWETnveq0
        eS0NabdgTfmjoTqXtuK2AlpD17DaTzibbg8g4FZrmbFe8ck=
X-Google-Smtp-Source: AMrXdXvNzfaAuomwpOGRl1Kr86PVDA+awzaWcmPWKbGPfEOF4CYuXHglCgqeFTD50qLO9XJRJ5l8l0/glu7SfjjA/iQ=
X-Received: by 2002:a17:906:ecb9:b0:86d:97d4:9fea with SMTP id
 qh25-20020a170906ecb900b0086d97d49feamr5495699ejb.141.1674693946472; Wed, 25
 Jan 2023 16:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com>
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Jan 2023 16:45:34 -0800
Message-ID: <CAEf4BzZP5771Wbv4w1gM+8vcGwvhmFi2tH-8aSGfnzvb=ZgaJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/24] Support bpf trampoline for s390x
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Hi,
>
> This series implements poke, trampoline, kfunc, mixing subprogs and
> tailcalls, and fixes a number of tests on s390x.
>
> The following failures still remain:
>
> #52      core_read_macros:FAIL
> Uses BPF_PROBE_READ(), shouldn't there be BPF_PROBE_READ_KERNEL()?

BPF_PROBE_READ(), similarly to BPF_CORE_READ() both use
bpf_probe_read_kernel() internally, as it's most common use case. We
have separate BPF_PROBE_READ_USER() and BPF_CORE_READ_USER() for when
bpf_probe_read_user() has to be used.

>
> #82      get_stack_raw_tp:FAIL
> get_stack_print_output:FAIL:user_stack corrupted user stack
> Known issue:
> We cannot reliably unwind userspace on s390x without DWARF.

like in principle, or frame pointers (or some equivalent) needs to be
configured for this to work?

Asking also in the context of [0], where s390x was excluded. If there
is actually a way to enable frame pointer-based stack unwinding on
s390x, would be nice to hear from an expert.

  [0] https://pagure.io/fesco/issue/2923

>
> #101     ksyms_module:FAIL
> address of kernel function bpf_testmod_test_mod_kfunc is out of range
> Known issue:
> Kernel and modules are too far away from each other on s390x.
>
> #167     sk_assign:FAIL
> Uses legacy map definitions in 'maps' section.

Hm.. assuming new enough iproute2, new-style .maps definition should
be supported, right? Let's convert map definition?

>
> #190     stacktrace_build_id:FAIL
> Known issue:
> We cannot reliably unwind userspace on s390x without DWARF.
>
> #211     test_bpffs:FAIL
> iterators.bpf.c is broken on s390x, it uses BPF_CORE_READ(), shouldn't
> there be BPF_CORE_READ_KERNEL()?

BPF_CORE_READ() is that, so must be something else

>
> #218     test_profiler:FAIL
> A lot of BPF_PROBE_READ() usages.

ditto, something else

>
> #281     xdp_metadata:FAIL
> See patch 24.
>
> #284     xdp_synproxy:FAIL
> Verifier error:
> ; value = bpf_tcp_raw_gen_syncookie_ipv4(hdr->ipv4, hdr->tcp,
> 281: (79) r1 = *(u64 *)(r10 -80)      ; R1_w=pkt(off=14,r=74,imm=0) R10=fp0
> 282: (bf) r2 = r8                     ; R2_w=pkt(id=5,off=14,r=74,umax=60,var_off=(0x0; 0x3c)) R8=pkt(id=5,off=14,r=74,umax=60,var_off=(0x0; 0x3c))
> 283: (79) r3 = *(u64 *)(r10 -104)     ; R3_w=scalar(umax=60,var_off=(0x0; 0x3c)) R10=fp0
> 284: (85) call bpf_tcp_raw_gen_syncookie_ipv4#204
> invalid access to packet, off=14 size=0, R2(id=5,off=14,r=74)
> R2 offset is outside of the packet

third arg to bpf_tcp_raw_gen_syncookie_ipv4() is defined as
ARG_CONST_SIZE, so is required to be strictly positive, which doesn't
seem to be "proven" to verifier. Please provided bigger log, it might
another instance of needing to sprinkle barrier_var() around.

And maybe thinking about using ARG_CONST_SIZE_OR_ZERO instead of ARG_CONST_SIZE.

>
> None of these seem to be due to the new changes.
>
> Best regards,
> Ilya
>
> Ilya Leoshkevich (24):
>   selftests/bpf: Fix liburandom_read.so linker error
>   selftests/bpf: Fix symlink creation error
>   selftests/bpf: Fix fexit_stress on s390x
>   selftests/bpf: Fix trampoline_count on s390x
>   selftests/bpf: Fix kfree_skb on s390x
>   selftests/bpf: Set errno when urand_spawn() fails
>   selftests/bpf: Fix decap_sanity_ns cleanup
>   selftests/bpf: Fix verify_pkcs7_sig on s390x
>   selftests/bpf: Fix xdp_do_redirect on s390x
>   selftests/bpf: Fix cgrp_local_storage on s390x
>   selftests/bpf: Check stack_mprotect() return value
>   selftests/bpf: Increase SIZEOF_BPF_LOCAL_STORAGE_ELEM on s390x
>   selftests/bpf: Add a sign-extension test for kfuncs
>   selftests/bpf: Fix test_lsm on s390x
>   selftests/bpf: Fix test_xdp_adjust_tail_grow2 on s390x
>   selftests/bpf: Fix vmlinux test on s390x
>   libbpf: Read usdt arg spec with bpf_probe_read_kernel()
>   s390/bpf: Fix a typo in a comment
>   s390/bpf: Add expoline to tail calls
>   s390/bpf: Implement bpf_arch_text_poke()
>   bpf: btf: Add BTF_FMODEL_SIGNED_ARG flag
>   s390/bpf: Implement arch_prepare_bpf_trampoline()
>   s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
>   s390/bpf: Implement bpf_jit_supports_kfunc_call()
>
>  arch/s390/net/bpf_jit_comp.c                  | 708 +++++++++++++++++-
>  include/linux/bpf.h                           |   8 +
>  include/linux/btf.h                           |  15 +-
>  kernel/bpf/btf.c                              |  16 +-
>  net/bpf/test_run.c                            |   9 +
>  tools/lib/bpf/usdt.bpf.h                      |  33 +-
>  tools/testing/selftests/bpf/Makefile          |   7 +-
>  tools/testing/selftests/bpf/netcnt_common.h   |   6 +-
>  .../selftests/bpf/prog_tests/bpf_cookie.c     |   6 +-
>  .../bpf/prog_tests/cgrp_local_storage.c       |   2 +-
>  .../selftests/bpf/prog_tests/decap_sanity.c   |   2 +-
>  .../selftests/bpf/prog_tests/fexit_stress.c   |   6 +-
>  .../selftests/bpf/prog_tests/kfree_skb.c      |   2 +-
>  .../selftests/bpf/prog_tests/kfunc_call.c     |   1 +
>  .../selftests/bpf/prog_tests/test_lsm.c       |   3 +-
>  .../bpf/prog_tests/trampoline_count.c         |   4 +
>  tools/testing/selftests/bpf/prog_tests/usdt.c |   1 +
>  .../bpf/prog_tests/verify_pkcs7_sig.c         |   9 +
>  .../bpf/prog_tests/xdp_adjust_tail.c          |   7 +-
>  .../bpf/prog_tests/xdp_do_redirect.c          |   4 +
>  .../selftests/bpf/progs/kfunc_call_test.c     |  18 +
>  tools/testing/selftests/bpf/progs/lsm.c       |   7 +-
>  .../bpf/progs/test_verify_pkcs7_sig.c         |  12 +-
>  .../selftests/bpf/progs/test_vmlinux.c        |   4 +-
>  .../bpf/progs/test_xdp_adjust_tail_grow.c     |   8 +-
>  25 files changed, 816 insertions(+), 82 deletions(-)
>
> --
> 2.39.1
>
