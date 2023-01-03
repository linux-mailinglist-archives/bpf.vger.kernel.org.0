Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD065BB4F
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 08:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjACHh7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 02:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbjACHh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 02:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476A5FF7;
        Mon,  2 Jan 2023 23:37:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DEF9B80E52;
        Tue,  3 Jan 2023 07:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FE4C433D2;
        Tue,  3 Jan 2023 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672731472;
        bh=+1+K/QMGEwB/t9nyEjns1p8p9ReMrS/m95IVeeWjbDc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X5xqNylbdKKqVQfqkbksbhlW4tsgpB0FIoJT/BVb5+jvGU0iOh7fIINlPD3cF1m89
         QPuEUm1whigKxqMb3sONrxLlrz07QjEpyFMKU9Nj78To6LwhEoUWphYy9DfG1jf+3C
         bbpJiEKSBrhNaAYj6o6VMfpXs/gF2igh3KRyO/Tn/cdOJj3eKZE7MiakBnq1FijBQ5
         gi+T8NAVQJaZVz4Q16SAUyx19U76SnGrwd1rAGVFUCpk0DHlUkKWpQekv7MDI5wXFq
         9wSNQVLbxReD9Mw0YlV3aBm86EpAryp4bz02J1aOv88rZdh+e8pK6k8DMJlC8JMRUC
         C5wi/oOP5iOCA==
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
Subject: Re: [RFC PATCH bpf-next 3/4] riscv, bpf: Add bpf_arch_text_poke
 support for RV64
In-Reply-To: <20221219133736.1387008-4-pulehui@huaweicloud.com>
References: <20221219133736.1387008-1-pulehui@huaweicloud.com>
 <20221219133736.1387008-4-pulehui@huaweicloud.com>
Date:   Tue, 03 Jan 2023 08:37:50 +0100
Message-ID: <87v8looypd.fsf@all.your.base.are.belong.to.us>
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

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index bf4721a99a09..fa8b03c52463 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

> @@ -1266,7 +1389,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
>=20=20
>  void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>  {
> -	int stack_adjust =3D 0, store_offset, bpf_stack_adjust;
> +	int i, stack_adjust =3D 0, store_offset, bpf_stack_adjust;
>  	bool is_main_prog =3D ctx->prog->aux->func_idx =3D=3D 0;

This line magically appeared, and makes it hard to apply the series
without hacking the patches manually. Going forward, please supply a
base tree commit to the series (or a link to a complete git tree).


Bj=C3=B6rn
