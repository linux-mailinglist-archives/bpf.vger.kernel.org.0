Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161614D1715
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346772AbiCHMTB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 07:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbiCHMS7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 07:18:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9B369F0
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 04:18:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCZ940kMhz4xy3;
        Tue,  8 Mar 2022 23:18:00 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
In-Reply-To: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH powerpc/next 00/17] powerpc/bpf: Some updates and cleanups
Message-Id: <164674128395.3322453.15857183834950930927.b4-ty@ellerman.id.au>
Date:   Tue, 08 Mar 2022 23:08:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 14 Feb 2022 16:11:34 +0530, Naveen N. Rao wrote:
> This is a follow-up series with the pending patches from:
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=279602&state=*
> 
> Patches 1-5 and 8 are unchanged. Patch 6 is new and patch 7 has changes
> based on discussion from the last series. Patch 9 has a small change to
> not skip the toc load for elf v2.
> 
> [...]

Applied to powerpc/next.

[01/17] powerpc/bpf: Skip branch range validation during first pass
        https://git.kernel.org/powerpc/c/acd7408d2748533d767387cb4308692fba543658
[02/17] powerpc/bpf: Emit a single branch instruction for known short branch ranges
        https://git.kernel.org/powerpc/c/bafb5898de5d2f15133774cb049fe55720b9c92f
[03/17] powerpc/bpf: Handle large branch ranges with BPF_EXIT
        https://git.kernel.org/powerpc/c/0ffdbce6f4a89bb7c0002904d6438ec83cf05ce7
[04/17] powerpc64/bpf: Do not save/restore LR on each call to bpf_stf_barrier()
        https://git.kernel.org/powerpc/c/c2067f7f88830cdd020c775ffefe84a8177337af
[05/17] powerpc64/bpf: Use r12 for constant blinding
        https://git.kernel.org/powerpc/c/1d4866d5652f7a19dcbed0c4e366c3402c7775b7
[06/17] powerpc64: Set PPC64_ELF_ABI_v[1|2] macros to 1
        https://git.kernel.org/powerpc/c/4eeac2b0aaadc3d1943d348d8565f7cfb93272b9
[07/17] powerpc64/bpf elfv2: Setup kernel TOC in r2 on entry
        https://git.kernel.org/powerpc/c/b10cb163c4b31b03ac5014abbfd0b868913fd8e3
[08/17] powerpc64/bpf elfv1: Do not load TOC before calling functions
        https://git.kernel.org/powerpc/c/43d636f8b4fd2ee668e75e835fae2fcf4bc0f699
[09/17] powerpc64/bpf: Optimize instruction sequence used for function calls
        https://git.kernel.org/powerpc/c/feb6307289d85262c5aed04d6f192d38abba7c45
[10/17] powerpc/bpf: Rename PPC_BL_ABS() to PPC_BL()
        https://git.kernel.org/powerpc/c/74bbe3f08463c48a27088be4823a5803b7f7d9a1
[11/17] powerpc64/bpf: Convert some of the uses of PPC_BPF_[LL|STL] to PPC_BPF_[LD|STD]
        https://git.kernel.org/powerpc/c/391c271f4deb7356482d12f962a6fc018b6a3fb0
[12/17] powerpc64/bpf: Get rid of PPC_BPF_[LL|STL|STLU] macros
        https://git.kernel.org/powerpc/c/794abc08d75e9f2833f493090af14b748e182c5f
[13/17] powerpc/bpf: Cleanup bpf_jit.h
        https://git.kernel.org/powerpc/c/7b187dcdb5d348aa916dcda769313512c08e85a5
[14/17] powerpc/bpf: Move bpf_jit64.h into bpf_jit_comp64.c
        https://git.kernel.org/powerpc/c/576a6c3a00c1a2a3645e039b126b52f6c7755e54
[15/17] powerpc/bpf: Use _Rn macros for GPRs
        https://git.kernel.org/powerpc/c/036d559c0bdea75bf4840ba6780790d08572480c
[16/17] powerpc64/bpf: Store temp registers' bpf to ppc mapping
        https://git.kernel.org/powerpc/c/3a3fc9bf103974d9a886fa37087d5d491c806e00
[17/17] powerpc/bpf: Simplify bpf_to_ppc() and adopt it for powerpc64
        https://git.kernel.org/powerpc/c/49c3af43e65fbcc13860e0cf5fb2507b13e9724c

cheers
