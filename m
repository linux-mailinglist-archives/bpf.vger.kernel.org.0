Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3F9697C0B
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 13:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjBOMnK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 07:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjBOMnJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 07:43:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77666311CD;
        Wed, 15 Feb 2023 04:43:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGyRF73j9z4x7w;
        Wed, 15 Feb 2023 23:43:05 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>
In-Reply-To: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
References: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/9] powerpc: Remove __kernel_text_address() in show_instructions()
Message-Id: <167646484231.1421441.4745112349089639781.b4-ty@ellerman.id.au>
Date:   Wed, 15 Feb 2023 23:40:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 1 Feb 2023 11:04:23 +0100, Christophe Leroy wrote:
> That test was introducted in 2006 by
> commit 00ae36de49cc ("[POWERPC] Better check in show_instructions").
> At that time, there was no BPF progs.
> 
> As seen in message of commit 89d21e259a94 ("powerpc/bpf/32: Fix Oops
> on tail call tests"), when a page fault occurs in test_bpf.ko for
> instance, the code is dumped as XXXXXXXXs. Allthough
> __kernel_text_address() checks is_bpf_text_address(), it seems it is
> not enough.
> 
> [...]

Applied to powerpc/next.

[1/9] powerpc: Remove __kernel_text_address() in show_instructions()
      https://git.kernel.org/powerpc/c/d9ab6da64fd15608c9feb20d769d8df1a32fe212
[2/9] powerpc/bpf/32: No need to zeroise r4 when not doing tail call
      https://git.kernel.org/powerpc/c/6376ed8feca829039d31a208216b958f0e439d87
[3/9] powerpc/bpf/32: Only set a stack frame when necessary
      https://git.kernel.org/powerpc/c/d084dcf256bc4565b4b1af9b00297ac7b51c7049
[4/9] powerpc/bpf/32: BPF prog is never called with more than one arg
      https://git.kernel.org/powerpc/c/7dd0e2848764306d7a70943b97584ffdc7754708
[5/9] powerpc/bpf: Perform complete extra passes to update addresses
      https://git.kernel.org/powerpc/c/85e031154c7c14edee0705532a9ffc8a2fe591d0
[6/9] powerpc/bpf: Only pad length-variable code at initial pass
      https://git.kernel.org/powerpc/c/d3921cbb6cd663193cecf04f0b170a30c6d0e390
[7/9] powerpc/bpf/32: Optimise some particular const operations
      https://git.kernel.org/powerpc/c/8616045fe785229b53a24b8698631826298d1500
[8/9] powerpc/bpf/32: introduce a second source register for ALU operations
      https://git.kernel.org/powerpc/c/c88da29b4d2ce8d0070646b8f99729e9b355a4bf
[9/9] powerpc/bpf/32: perform three operands ALU operations
      https://git.kernel.org/powerpc/c/19daf0aef84f33bde9c742ed41b4ded567b8dfbf

cheers
