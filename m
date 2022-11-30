Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5668763DA26
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 17:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiK3QEJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 11:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiK3QEI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 11:04:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384CA43861;
        Wed, 30 Nov 2022 08:04:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09DA61CD1;
        Wed, 30 Nov 2022 16:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EDDC433C1;
        Wed, 30 Nov 2022 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669824247;
        bh=F3sWtcU7a7aYF64WpYOXHrijQk18lttkWuDDJI5zwjE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qljpPVH1X/YzQkI471Z5zFai4D6J7ig8vaK36cf/yQl9LtdX6cnagLUpDf592B5G2
         tRBwIZAFi0V7VHmC0A/+jpl/AiUrq77XV2/9KS8MNBRXFQgTRnsyU6SGiUEHKWgumQ
         7qItlXEulP8r7LSDjQRBwxJmnIY/THzjqngUTjfve/2wtFb6vZ1YFhUcqfwSYFJ/Mn
         F+ZggTdDzWlNDO5DWbsmKyWFUrU9DL1cWG6FpkkdJQl+dMgzPs5bXUALUTxdagTdV+
         uFzrUdBMz2yEBZw7bpkfsDzTrojbx2J+o6IPhWKe/c2d3pobnAgArC0WDsUjzj2l14
         b3f3O0x8pi7Cg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf] riscv, bpf: Emit fixed-length imm64 for
 BPF_PSEUDO_FUNC
In-Reply-To: <87h6yg1xlo.fsf@all.your.base.are.belong.to.us>
References: <20221130033806.2967822-1-pulehui@huaweicloud.com>
 <87h6yg1xlo.fsf@all.your.base.are.belong.to.us>
Date:   Wed, 30 Nov 2022 17:04:04 +0100
Message-ID: <87a648ig3v.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> The range of valid address for RV64 (sv39 to sv57) are
> 0xffffffff00000000 to 0xffffffffffffffff, so I think we can do better
> than 6 insn, no? My gut feeling (I need to tinker a bit) is that 4
> should be sufficient.

Ok, thinking a bit more about it; A proper address will at have at least
2B alignment, so that means that we can construct an address with lui,
addi, and slli (31 bits).

u64 addr =3D 0xffffffff12345678;

u32 (imm |=3D 0xffffffffUL) >> 1;
u32 upper =3D (imm + (1 << 11)) >> 12;
u32 lower =3D imm & 0xfff;
u32 rupper =3D upper | 0x80000; // for sign extend

NB! Make sure it's !C insn, and emit:

lui xx, rupper
addi xx, xx, lower
slli xx, xx, 1

Now we'll have fixed three insns. WDYT?


Bj=C3=B6rn
