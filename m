Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCD426B9B
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhJHN03 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 09:26:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:60125 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhJHN02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 09:26:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQpnW597zz4xqN;
        Sat,  9 Oct 2021 00:24:31 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Song Liu <songliubraving@fb.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/10] powerpc/bpf: Various fixes
Message-Id: <163369937665.3568929.6807087799195929903.b4-ty@ellerman.id.au>
Date:   Sat, 09 Oct 2021 00:22:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 6 Oct 2021 01:55:19 +0530, Naveen N. Rao wrote:
> This is v2 of the series posted at:
> http://lkml.kernel.org/r/cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com
> 
> Only patches from v1 that need to go into powerpc/fixes are included.
> Other patches will be posted as a separate series for inclusion into
> powerpc/next.
> 
> [...]

Applied to powerpc/fixes.

[01/10] powerpc/lib: Add helper to check if offset is within conditional branch range
        https://git.kernel.org/powerpc/c/4549c3ea3160fa8b3f37dfe2f957657bb265eda9
[02/10] powerpc/bpf: Validate branch ranges
        https://git.kernel.org/powerpc/c/3832ba4e283d7052b783dab8311df7e3590fed93
[03/10] powerpc/bpf: Fix BPF_MOD when imm == 1
        https://git.kernel.org/powerpc/c/8bbc9d822421d9ac8ff9ed26a3713c9afc69d6c8
[04/10] powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
        https://git.kernel.org/powerpc/c/5855c4c1f415ca3ba1046e77c0b3d3dfc96c9025
[05/10] powerpc/security: Add a helper to query stf_barrier type
        https://git.kernel.org/powerpc/c/030905920f32e91a52794937f67434ac0b3ea41a
[06/10] powerpc/bpf: Emit stf barrier instruction sequences for BPF_NOSPEC
        https://git.kernel.org/powerpc/c/b7540d62509453263604a155bf2d5f0ed450cba2
[07/10] powerpc/bpf ppc32: Fix ALU32 BPF_ARSH operation
        https://git.kernel.org/powerpc/c/c9b8da77f22d28348d1f89a6c4d3fec102e9b1c4
[08/10] powerpc/bpf ppc32: Fix JMP32_JSET_K
        https://git.kernel.org/powerpc/c/e8278d44443207bb6609c7b064073f353e6f4978
[09/10] powerpc/bpf ppc32: Do not emit zero extend instruction for 64-bit BPF_END
        https://git.kernel.org/powerpc/c/48164fccdff6d5cc11308126c050bd25a329df25
[10/10] powerpc/bpf ppc32: Fix BPF_SUB when imm == 0x80000000
        https://git.kernel.org/powerpc/c/548b762763b885b81850db676258df47c55dd5f9

cheers
