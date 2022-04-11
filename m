Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C949E4FBC70
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbiDKMwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 08:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346215AbiDKMw1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 08:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E231DF9
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 05:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E50616A3
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 12:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7DEC385A3
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649681412;
        bh=dUzLlQ/ZP4JOlwkxabVbYohZa7/xE4mVkwe8Av49ND8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FRaZXIaInIBQVGu2hjSFsez3w2wJw5uWhpq3EQQFwBJYULTIWHMDtwhHAzLJjL+pG
         OyFvgSKrBWux+5kEjoLByjMZ4hAYu+ZwpGG9uETsvppzQ3w+xHFBeINvso9qN7mzbk
         IEaxtCSkt1aS4asnRU8nGWPsp1+AxXJHAqK0R/4k5JZdXuZMs3D6eya119JVqSD7t6
         u5aaD5RbtUEugsv+QsYC1zwW9hZOeOqiKv7OCaS4i6hBJV2Ze9zea7+Od/9T4rWOBm
         O/meuynmHpRc09iedhinKgNSG+cKQnqoNxCweo8039EPcpY2sxoceYpz0IvWd6cFZW
         FwSz/6dedp96A==
Received: by mail-wr1-f53.google.com with SMTP id e8so6455345wra.7
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 05:50:12 -0700 (PDT)
X-Gm-Message-State: AOAM532IpvmqYn+/Gn9XPA2L5/ytSXCve58UcZtBskNkJPAGTIiQN72k
        zbc3FJLAxY3F2iy2j1UI5s7+7meWjYfOOBO8KBE=
X-Google-Smtp-Source: ABdhPJy1K2xOrHfwDw26te0LKpYibGXf0wkirVPf3evW6NGryoDVre34N/2Fa7zJeboTRE157pU9XkaGG0Lbxu+mOLU=
X-Received: by 2002:a05:6000:1868:b0:204:1e4f:7f9a with SMTP id
 d8-20020a056000186800b002041e4f7f9amr25010406wri.106.1649681410549; Mon, 11
 Apr 2022 05:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220410101246.232875-1-pulehui@huawei.com>
In-Reply-To: <20220410101246.232875-1-pulehui@huawei.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date:   Mon, 11 Apr 2022 14:49:58 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNg0zsf7sRfPiQCNDvVKARbQq0kO9ya9rk=fAh92cvpHHw@mail.gmail.com>
Message-ID: <CAJ+HfNg0zsf7sRfPiQCNDvVKARbQq0kO9ya9rk=fAh92cvpHHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] riscv, bpf: Implement more atomic operations for RV64
To:     Pu Lehui <pulehui@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 10 Apr 2022 at 11:43, Pu Lehui <pulehui@huawei.com> wrote:
>
> This patch implement more bpf atomic operations for RV64.
> The added operations are shown below:
>
> atomic[64]_[fetch_]add
> atomic[64]_[fetch_]and
> atomic[64]_[fetch_]or
> atomic[64]_xchg
> atomic[64]_cmpxchg
>
> Since riscv specification does not provide AMO instruction for
> CAS operation, we use lr/sc instruction for cmpxchg operation,
> and AMO instructions for the rest ops. Tests "test_bpf.ko" and
> "test_progs -t atomic" have passed, as well as "test_verifier"
> with no new failure ceses.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Thank you for implementing this! It's been long overdue.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
