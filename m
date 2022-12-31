Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB265A5B7
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 17:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiLaQcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 11:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiLaQb4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 11:31:56 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606F6420
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so35866151lfv.2
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sBQ1uLn4pbrhFWwV3TbPBLJVGkRvqJx7o12YCrxc2o=;
        b=gbiE055v5obobVSF2eBNtnxCwUwnuKudZJzUAXq78zvDG3FfMgBcQnznDnj7TpH2OT
         NwvxZ3y6ho/vfkOzmEIH96rIj29fzaYxbItp0dtMgCXxB25n5LLEpJpf4zP4DY19sM0X
         auI+ID+NU6Xi3xEZk5c55S8bbJ9WAlV1i7HJkU9XzY4py+S5V/anjFP3iCADwslQtafh
         ALcs8Des6vlkKCtUlfWe5Sfncw316SjXHtpBaazo+VkjQCc9o/bkCEGFjGwpS+hYBl/Z
         8ssf5dPWSWPQP+kf4KccXMEi+69CwUA9fxaitm+kLCg2jVb1VGPrW99CGBbNx0MKzSFo
         bKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sBQ1uLn4pbrhFWwV3TbPBLJVGkRvqJx7o12YCrxc2o=;
        b=BpNEYUQMuGN4pfd0/M16vDxYrIk7ri7btkgmBb1IxkTL3wO9iq5i1oXCTQ5PIV9Ck6
         5vjHEcWKlMwT0Oqd9dCFrWMlykoFOFDaQUo0boeoDMoVorExiBQfqYtf76D1GAhU4wgo
         eeded5KYKjn5sSNM/wuzCNsdzirRKT4fkV/N0nZPBDHQGML0G2E8BtukXzS4yirH9CoV
         juRjYxg+8qQCyFGtVFN9GJZyhx8WEhoGdfGJrO2vTgfJa+WsIpYDJXTIFyn6bzA+XDug
         1iRfU/rBnM9xKhbUQXwZgRDIvFT2r3gmeBVsRJTrthCaVGE0gMK6QmDTYuH8iwg5krE2
         u4OQ==
X-Gm-Message-State: AFqh2kr40lJVIcyO2vAJo/Cv+C8yUdugccSnIZM3wObhkSgXhhHFGnKP
        tR7SEr0NKoFpc/DIlY3juw+rE6qcZHE=
X-Google-Smtp-Source: AMrXdXtnQSneJG+er8xlWCOz0NVlKR3xLVqVrOzLghbl6HFlUYGVeS3dU2tahExy81TD7A4n1alCzQ==
X-Received: by 2002:ac2:464f:0:b0:4b5:7925:870d with SMTP id s15-20020ac2464f000000b004b57925870dmr10910267lfo.12.1672504313106;
        Sat, 31 Dec 2022 08:31:53 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a19e34a000000b004b4930d53b5sm3876784lfk.134.2022.12.31.08.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:31:52 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C compiler
Date:   Sat, 31 Dec 2022 18:31:17 +0200
Message-Id: <20221231163122.1360813-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF has two documented (non-atomic) memory store instructions:

BPF_STX: *(size *) (dst_reg + off) = src_reg
BPF_ST : *(size *) (dst_reg + off) = imm32

Currently LLVM BPF back-end does not emit BPF_ST instruction and does
not allow one to be specified as inline assembly.

Recently I've been exploring ways to port some of the verifier test
cases from tools/testing/selftests/bpf/verifier/*.c to use inline assembly
and machinery provided in tools/testing/selftests/bpf/test_loader.c
(which should hopefully simplify tests maintenance).
The BPF_ST instruction is popular in these tests: used in 52 of 94 files.

While it is possible to adjust LLVM to only support BPF_ST for inline
assembly blocks it seems a bit wasteful. This patch-set contains a set
of changes to verifier necessary in case when LLVM is allowed to
freely emit BPF_ST instructions (source code is available here [1]).
The changes include:
 - update to verifier.c:check_stack_write_*() functions to track
   constant values spilled to stack via BPF_ST instruction in a same
   way stack spills of known registers by BPF_STX are tracked;
 - updates to verifier.c:convert_ctx_access() and it's callbacks to
   handle BPF_ST instruction in a way similar to BPF_STX;
 - some test adjustments and a few new tests.

With the above changes applied and LLVM from [1] all test_verifier,
test_maps, test_progs and test_progs-no_alu32 test cases are passing.

When built using the LLVM version from [1] BPF programs generated for
selftests and Cilium programs (taken from [2]) see certain reduction
in size, e.g. below are total numbers of instructions for files with
over 5K instructions:

File                                    Insns   Insns   Insns   Diff
                                        w/o     with    diff    pct
                                        BPF_ST  BPF_ST
cilium/bpf_host.o                       44620   43774   -846    -1.90%
cilium/bpf_lxc.o                        36842   36060   -782    -2.12%
cilium/bpf_overlay.o                    23557   23186   -371    -1.57%
cilium/bpf_xdp.o                        26397   25931   -466    -1.77%
selftests/core_kern.bpf.o               12359   12359    0       0.00%
selftests/linked_list_fail.bpf.o        5501    5302    -199    -3.62%
selftests/profiler1.bpf.o               17828   17709   -119    -0.67%
selftests/pyperf100.bpf.o               49793   49268   -525    -1.05%
selftests/pyperf180.bpf.o               88738   87813   -925    -1.04%
selftests/pyperf50.bpf.o                25388   25113   -275    -1.08%
selftests/pyperf600.bpf.o               78330   78300   -30     -0.04%
selftests/pyperf_global.bpf.o           5244    5188    -56     -1.07%
selftests/pyperf_subprogs.bpf.o         5262    5192    -70     -1.33%
selftests/strobemeta.bpf.o              17154   16065   -1089   -6.35%
selftests/test_verif_scale2.bpf.o       11337   11337    0       0.00%

(Instructions are counted by counting the number of instruction lines
 in disassembly).

Is community interested in this work?
Are there any omissions in my changes to the verifier?

Known issue:

There are two programs (one Cilium, one selftest) that exhibit
anomalous increase in verifier processing time with this patch-set:

 File                 Program                        Insns (A)  Insns (B)  Insns   (DIFF)
 -------------------  -----------------------------  ---------  ---------  --------------
 bpf_host.o           tail_ipv6_host_policy_ingress       1576       2403  +827 (+52.47%)
 map_kptr.bpf.o       test_map_kptr                        400        475   +75 (+18.75%)
 -------------------  -----------------------------  ---------  ---------  --------------

These are under investigation.

Thanks,
Eduard

[1] https://reviews.llvm.org/D140804
[2] git@github.com:anakryiko/cilium.git

Eduard Zingerman (5):
  bpf: more precise stack write reasoning for BPF_ST instruction
  selftests/bpf: check if verifier tracks constants spilled by
    BPF_ST_MEM
  bpf: allow ctx writes using BPF_ST_MEM instruction
  selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
  selftests/bpf: don't match exact insn index in expected error message

 kernel/bpf/cgroup.c                           |  49 +++++---
 kernel/bpf/verifier.c                         | 102 +++++++++-------
 net/core/filter.c                             |  72 ++++++------
 .../selftests/bpf/prog_tests/log_fixup.c      |   2 +-
 .../selftests/bpf/prog_tests/spin_lock.c      |   8 +-
 .../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++--------
 .../selftests/bpf/verifier/bpf_st_mem.c       |  29 +++++
 tools/testing/selftests/bpf/verifier/ctx.c    |  11 --
 tools/testing/selftests/bpf/verifier/unpriv.c |  23 ++++
 9 files changed, 249 insertions(+), 157 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_st_mem.c

-- 
2.39.0

