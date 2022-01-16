Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200AE48FC30
	for <lists+bpf@lfdr.de>; Sun, 16 Jan 2022 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiAPKmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Jan 2022 05:42:42 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:40517 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiAPKmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Jan 2022 05:42:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JcBSY444sz4y4p;
        Sun, 16 Jan 2022 21:42:37 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     ykaliuta@redhat.com, Jiri Olsa <jolsa@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        bpf@vger.kernel.org, song@kernel.org,
        johan.almbladh@anyfinetworks.com
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/13] powerpc/bpf: Some fixes and updates
Message-Id: <164232966375.2885693.16633538158150214426.b4-ty@ellerman.id.au>
Date:   Sun, 16 Jan 2022 21:41:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 6 Jan 2022 17:15:04 +0530, Naveen N. Rao wrote:
> A set of fixes and updates to powerpc BPF JIT:
> - Patches 1-3 fix issues with the existing powerpc JIT and are tagged
>   for -stable.
> - Patch 4 fixes a build issue with bpf selftests on powerpc.
> - Patches 5-9 handle some corner cases and make some small improvements.
> - Patches 10-13 optimize how function calls are handled in ppc64.
> 
> [...]

Patches 1-4, and 8 applied to powerpc/fixes.

[01/13] bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()
        https://git.kernel.org/powerpc/c/b992f01e66150fc5e90be4a96f5eb8e634c8249e
[02/13] powerpc32/bpf: Fix codegen for bpf-to-bpf calls
        https://git.kernel.org/powerpc/c/fab07611fb2e6a15fac05c4583045ca5582fd826
[03/13] powerpc/bpf: Update ldimm64 instructions during extra pass
        https://git.kernel.org/powerpc/c/f9320c49993ca3c0ec0f9a7026b313735306bb8b
[04/13] tools/bpf: Rename 'struct event' to avoid naming conflict
        https://git.kernel.org/powerpc/c/88a71086c48ae98e93c0208044827621e9717f7e
[08/13] powerpc64/bpf: Limit 'ldbrx' to processors compliant with ISA v2.06
        https://git.kernel.org/powerpc/c/3f5f766d5f7f95a69a630da3544a1a0cee1cdddf

cheers
