Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBA6A3BB7
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 08:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjB0HbH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 02:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 02:31:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29751ABC7;
        Sun, 26 Feb 2023 23:31:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F9860D57;
        Mon, 27 Feb 2023 07:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A22C433D2;
        Mon, 27 Feb 2023 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677483063;
        bh=BKhCyAlJfue3qCvD5gMnMzJg0H76KaUopSvrz0ZoyQg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TmYqZkRB9HOHTkjyN7ucvV530Ru4DXBhtuoiDpIFeWrO3r2bKRVAwQKDNeDMIP7Dd
         4aEL0nX1rwJLEjcHPAKMejx+PHjv1Yj6kG6SnnLmxPOPedgTMTs6036OrC9HUHFQjs
         uiFtLbPkV8SE90m52pllzCmbaOTq4+EgyYAT/4eNPCFjUkJJFNZzbMaBNhj1Ommm/x
         rnquABFHmNe0jHm2Z237hJoiAceY4lW+jm6FXDSQdiIl1qIvKnhr3+1L7vL3TVDQZ/
         Ykl4AYR0En6yYRwdWOe5FtD1fArR1VoDgMRNjwhscOw54Y67Xkdd14SYEjlU6EPwXF
         Kp73Qnt9Gmmug==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Pu Lehui <pulehui@huawei.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf v2] riscv, bpf: fix patch_text implicit declaration
In-Reply-To: <20230227072016.14618-1-rdunlap@infradead.org>
References: <20230227072016.14618-1-rdunlap@infradead.org>
Date:   Mon, 27 Feb 2023 08:31:01 +0100
Message-ID: <87k003a7ka.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> bpf_jit_comp64.c uses patch_text(), so add <asm/patch.h> to it
> to prevent the build error:
>
> ../arch/riscv/net/bpf_jit_comp64.c: In function 'bpf_arch_text_poke':
> ../arch/riscv/net/bpf_jit_comp64.c:691:23: error: implicit declaration of=
 function 'patch_text'; did you mean 'path_get'? [-Werror=3Dimplicit-functi=
on-declaration]
>   691 |                 ret =3D patch_text(ip, new_insns, ninsns);
>       |                       ^~~~~~~~~~
>
> Fixes: 596f2e6f9cf4 ("riscv, bpf: Add bpf_arch_text_poke support for RV64=
")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202302271000.Aj4nMXbZ-lkp@intel.com
> Cc: Pu Lehui <pulehui@huawei.com>
> Cc: Luke Nelson <luke.r.nels@gmail.com>
> Cc: Xi Wang <xi.wang@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: "Bj=C3=B6rn T=C3=B6pel" <bjorn@kernel.org>
> Cc: linux-riscv@lists.infradead.org
> ---
> v2: add header file directly to bpf_jit_comp64.c (Pu Lehui)
>     change patch target to bpf (for fixes)

Thanks, Randy!

For the curious; The asm/patch.h file was picked via UPROBES (via
PERF_EVENTS=3Dy). For PERF_EVENTS=3Dn, you get the build error.


Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
