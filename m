Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F11549C25
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbiFMSuE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344170AbiFMStq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 14:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C5EAB85
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BC1E614F9
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 15:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6F3C34114
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655135293;
        bh=mmVu2lhSDeg0eBKKJrz5YQVwgZwEHoER0JIpaaZADME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qqc9sgifg8XDsxLd1QQZf9enxezV810kGb/7SNND+5TLT9vJRxJjotW95SyqoUuGG
         eUdL67DgC3aDxmoPU+SL1/gN6sPfsbJHSkOjL0lGDdQ7T5q1BkesbZVs0SEtS2MpLv
         XHGLyHrZVW3SpupzzvjyPUk6sSIIMxkaWF+i79qHCgzEIS1Y4EbrNgxi5GPkcBhN8k
         Y7AgK7Egk2bJwheRdKLDDUXxv3N7UBZ46PHbQZI7HXwsy8WUK+niKXno9Eg6ijaqs5
         QAgCjswFcU4mLjSK8rk/qwZUNBMrROv747pz2oXVTua5QePUOXcYDE8nZk6NdebGRT
         3aJxJ8+ROmqDw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ef5380669cso2293977b3.9
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 08:48:12 -0700 (PDT)
X-Gm-Message-State: AJIora/0BMTKbmjP92YfYYV0DHBhKEKBsWCvBU3nHyVr3SDF4LzJjxs8
        uCaObjpBCIiPfIq+630f0m74fVeGLTyrXLemVvQ=
X-Google-Smtp-Source: AGRyM1sI2SxnwL1ejoM2AA6QhWUGm4lXl0GtGvBjtoLyYRpFnx5Ha3MLxADClP5kLvuHcvHYusSDqpdrBcFDYUToNt8=
X-Received: by 2002:a81:7505:0:b0:30c:45e3:71bc with SMTP id
 q5-20020a817505000000b0030c45e371bcmr403480ywc.460.1655135291975; Mon, 13 Jun
 2022 08:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220613150141.169619-1-eddyz87@gmail.com> <20220613150141.169619-4-eddyz87@gmail.com>
In-Reply-To: <20220613150141.169619-4-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Jun 2022 08:48:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW44ryeaWog0+md=q-MgdaUqJQczcoksybKzmCy9j=w7hA@mail.gmail.com>
Message-ID: <CAPhsuW44ryeaWog0+md=q-MgdaUqJQczcoksybKzmCy9j=w7hA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 13, 2022 at 8:02 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Calls to `bpf_loop` are replaced with direct loops to avoid
> indirection. E.g. the following:
>
>   bpf_loop(10, foo, NULL, 0);
>
> Is replaced by equivalent of the following:
>
>   for (int i = 0; i < 10; ++i)
>     foo(i, NULL);
>
> This transformation could be applied when:
> - callback is known and does not change during program execution;
> - flags passed to `bpf_loop` are always zero.
>
> Inlining logic works as follows:
>
> - During execution simulation function `update_loop_inline_state`
>   tracks the following information for each `bpf_loop` call
>   instruction:
>   - is callback known and constant?
>   - are flags constant and zero?
> - Function `optimize_bpf_loop` increases stack depth for functions
>   where `bpf_loop` calls can be inlined and invokes `inline_bpf_loop`
>   to apply the inlining. The additional stack space is used to spill
>   registers R6, R7 and R8. These registers are used as loop counter,
>   loop maximal bound and callback context parameter;
>
> Measurements using `benchs/run_bench_bpf_loop.sh` inside QEMU / KVM on
> i7-4710HQ CPU show a drop in latency from 14 ns/op to 2 ns/op.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
[...]

> +static int optimize_bpf_loop(struct bpf_verifier_env *env)
> +{
> +       struct bpf_subprog_info *subprogs = env->subprog_info;
> +       int i, cur_subprog = 0, cnt, delta = 0;
> +       struct bpf_insn *insn = env->prog->insnsi;
> +       int insn_cnt = env->prog->len;
> +       u16 stack_depth = subprogs[cur_subprog].stack_depth;
> +       u16 stack_depth_extra = 0;
> +
> +       for (i = 0; i < insn_cnt; i++, insn++) {
> +               struct bpf_loop_inline_state *inline_state =
> +                       &env->insn_aux_data[i + delta].loop_inline_state;
> +
> +               if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
> +                       struct bpf_prog *new_prog;
> +
> +                       stack_depth_extra = BPF_REG_SIZE * 3;
> +                       new_prog = inline_bpf_loop(env,
> +                                                  i + delta,
> +                                                  -(stack_depth + stack_depth_extra),
> +                                                  inline_state->callback_subprogno,
> +                                                  &cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;

We do not fail over for -ENOMEM, which is reasonable. (It is also reasonable if
we do fail the program with -ENOMEM. However, if we don't fail the program,
we need to update stack_depth properly before returning, right?

Thanks,
Song

> +
> +                       delta     += cnt - 1;
> +                       env->prog  = new_prog;
> +                       insn       = new_prog->insnsi + i + delta;
> +               }
> +
> +               if (subprogs[cur_subprog + 1].start == i + delta + 1) {
> +                       subprogs[cur_subprog].stack_depth += stack_depth_extra;
> +                       cur_subprog++;
> +                       stack_depth = subprogs[cur_subprog].stack_depth;
> +                       stack_depth_extra = 0;
> +               }
> +       }
> +
> +       env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
> +
> +       return 0;
> +}
> +
