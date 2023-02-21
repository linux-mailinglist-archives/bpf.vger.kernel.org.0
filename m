Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B7869DAE0
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 08:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjBUHCz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 02:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjBUHCx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 02:02:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF77252B6;
        Mon, 20 Feb 2023 23:02:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE9C60F06;
        Tue, 21 Feb 2023 07:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FED7C433D2;
        Tue, 21 Feb 2023 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676962966;
        bh=KHMXE/LYnRNjuYWIFxQpGNwDw4WhCf5BXnM9jJyFYKc=;
        h=From:To:Cc:Subject:In-Reply-To:Date:From;
        b=Yhirujjn3Gs86md/vNl+4XmkPPjo94SNOAaKFnOQXjQX0yv6l93XMl4Rob/1p9Mz1
         BildrxHwu/yefVQiDMIl7NerNxFloHYRyqcm2B4R4tbghBYAkiMhmCNPjpT1Od05VX
         amluMYPMkNK+MpZbAwYf/8YLhEMvqDTzgSe3GeTjwLDOTUyttUSxZ7IKckID//bHdy
         law45gIPLx1cUA8MzcuejYCUYm9QgN6v3pwGQeyhnP2oWDTUQKixA934HlVQ9vrnV2
         eAmVeCjUaOlME832YphdHzsDFaUFjXu0u2WRsFWYtK5D31ISj2b1xYR7ciu0peUqlW
         v7vDwyZ5fr6JQ==
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
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2] riscv, bpf: Add kfunc support for RV64
In-Reply-To: <80e69e73-b873-6717-fe45-a854dbdd5476@huaweicloud.com>
Date:   Tue, 21 Feb 2023 08:02:43 +0100
Message-ID: <87h6vffqlo.fsf@all.your.base.are.belong.to.us>
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

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2023/2/20 22:34, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> As another important missing piece of RV64 JIT, kfunc allow bpf programs
>>> call kernel functions. For now, RV64 is sufficient to enable it.
>>=20
>> Thanks Lehui!
>>=20
>> Maybe we can reword/massage the commit message a bit? What do you think
>> about something like:
>>=20
>> "Now that the BPF trampoline is supported by RISC-V, it is possible to
>> use BPF programs with kfunc calls.
>>=20
>
> kfunc and bpf trampoline are functionally independent. kfunc [1], like=20
> bpf helper functions, allows bpf programs to call exported kernel=20
> functions, while bpf trampoline provides a more efficient way than=20
> kprobe to act as a mediator between kernel functions and bpf programs,=20
> and between bpf programs.
>
> In fact, it was already supported before the bpf trampoline=20
> implementation, I just turned it on.

Good point. I guess my (incorrect) kfunc mental model was that
struct_ops and kfunc were tightly coupled. (Then again, w/o struct_ops
working kfunc is a bit half-working in my view.)

Fair enough. I'm still a bit confused about the commit message, but
happy with the patch.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
