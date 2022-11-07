Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9961FBE6
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiKGRvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 12:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiKGRvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 12:51:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD01FCCF;
        Mon,  7 Nov 2022 09:51:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8A760EC0;
        Mon,  7 Nov 2022 17:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F91C433C1;
        Mon,  7 Nov 2022 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667843476;
        bh=4LXa6C3utC5hFi7jr0THCrMlopaxq6gu+qTu+NmrJCM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jJlluNNXko3tP2Eo+4YJypIwk3mj/SodclE1XNIHkXVsuzOUcxg5+jXHiXkQuFc1S
         s2pJ8mV7X8iTn8DkPX5ru3MXu7I0nA05mM36EwS/y0+qt4EnXca+Wy2Qjy/l+00P39
         11NtPIN1/XDFx+yvDV9sOnnVQ8wVfMXHwFRM7aPcP4KNDCZOC240INegZ08MEM6cSS
         8M9NWBZRYZkNlxQUUkMCP6sXSbFw/k5WEnR77BiqvkrtKIDmVrvX6XmGQsKCsYr4Qg
         E0ouXkti4JM0e0emoFLab5Oa/3WnGKChKZ4M+m0EYY7iylGmK3urOdBaNj0SXXVwj4
         Zoks3C5oU1Bvw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH bpf] bpf: Add explicit cast to 'void *' for
 __BPF_DISPATCHER_UPDATE()
In-Reply-To: <20221107170711.42409-1-nathan@kernel.org>
References: <20221107170711.42409-1-nathan@kernel.org>
Date:   Mon, 07 Nov 2022 18:51:12 +0100
Message-ID: <87wn86d567.fsf@all.your.base.are.belong.to.us>
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

Nathan Chancellor <nathan@kernel.org> writes:

> When building with clang:
>
>   kernel/bpf/dispatcher.c:126:33: error: pointer type mismatch ('void *' =
and 'unsigned int (*)(const void *, const struct bpf_insn *, bpf_func_t)' (=
aka 'unsigned int (*)(const void *, const struct bpf_insn *, unsigned int (=
*)(const void *, const struct bpf_insn *))')) [-Werror,-Wpointer-type-misma=
tch]
>           __BPF_DISPATCHER_UPDATE(d, new ?: &bpf_dispatcher_nop_func);
>                                      ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/bpf.h:1045:54: note: expanded from macro '__BPF_DISPATC=
HER_UPDATE'
>           __static_call_update((_d)->sc_key, (_d)->sc_tramp, (_new))
>                                                               ^~~~
>   1 error generated.
>
> The warning is pointing out that the type of new ('void *') and
> &bpf_dispatcher_nop_func are not compatible, which could have side
> effects coming out of a conditional operator due to promotion rules.
>
> Add the explicit cast to 'void *' to make it clear that this is
> expected, as __BPF_DISPATCHER_UPDATE() expands to a call to
> __static_call_update(), which expects a 'void *' as its final argument.
>
> Fixes: c86df29d11df ("bpf: Convert BPF_DISPATCHER to use static_call() (n=
ot ftrace)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1755
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
