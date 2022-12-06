Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE106441A1
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 11:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiLFK6B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 05:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLFK57 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 05:57:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C781181A;
        Tue,  6 Dec 2022 02:57:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D40361639;
        Tue,  6 Dec 2022 10:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91942C433D7;
        Tue,  6 Dec 2022 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670324277;
        bh=oioQ2q8bR8USiRel0ZxqKjrQ/0jFx43JLXf+oz1BzU4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fsXiDUxkzmX+RIzVJrKr6FEUqv0lA5yEYEqLlcrvSw/ZHQwn0/7rj6J1JVBgdcmEG
         ZCqys/kjttsYYC4GTxw4gknCD3+UtvIOO2m6XhUVHmF+L7VahEjFyRetO4BbnQrRDo
         VsTNc6pEwd8Jah2lpQa/RT3h0SG0F7HrE+fCd+Nq1XrgIJZTVGxPfyEzq7ysp7RHwD
         jypzudpdjgf9q1+Yw+0mVSP4beWnejHxNYSgi4bw/zg4dFwYVX0/fZN+5OnClfKu0g
         0Y9FzxFqWmYNp624YVhmdZhrGDKcpo4+TvvH9wJ8GrLnIHUx1HMy17nClrVvqd7NEB
         Muu2urD/363oA==
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
Subject: Re: [PATCH bpf v3] riscv, bpf: Emit fixed-length instructions for
 BPF_PSEUDO_FUNC
In-Reply-To: <20221206091410.1584784-1-pulehui@huaweicloud.com>
References: <20221206091410.1584784-1-pulehui@huaweicloud.com>
Date:   Tue, 06 Dec 2022 11:57:55 +0100
Message-ID: <87fsds240c.fsf@all.your.base.are.belong.to.us>
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

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> For BPF_PSEUDO_FUNC instruction, verifier will refill imm with
> correct addresses of bpf_calls and then run last pass of JIT.
> Since the emit_imm of RV64 is variable-length, which will emit
> appropriate length instructions accorroding to the imm, it may
> broke ctx->offset, and lead to unpredictable problem, such as
> inaccurate jump. So let's fix it with fixed-length instructions.
>
> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> Suggested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Thank you!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
