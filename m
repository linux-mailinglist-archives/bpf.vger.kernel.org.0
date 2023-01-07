Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01F3660B38
	for <lists+bpf@lfdr.de>; Sat,  7 Jan 2023 02:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjAGBER (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 20:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAGBEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 20:04:16 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F01D7FEF7;
        Fri,  6 Jan 2023 17:04:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id cf18so842127ejb.5;
        Fri, 06 Jan 2023 17:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tluQfvA91/nwwhw7TAQOb6vdAq/g9t5OVhApDDMMFeo=;
        b=od9HqVMBVWlMjptqZlsJkAH7Z5w08lPDQtwVOZegDPB2bU2/s/fD9eqCk5prppUs03
         fjWQQhJn+Pg4+akRPCAVc4qtSrSKVYO+JeCLXvwSkbHnoCkvzVX9vn0v6QlO649DK9Mn
         ZpuDW7AVXyrGGGVXWqnByECI6yGvOvfPTuGInVUXPbCm6PpbCO0LDwp3tT2S/kTLwLRE
         g9Xb5giCq0PBYEf9KhHLJgHKdJwbatbmhOUUre8oPpMY4t8cFq7e8LKyw6EmuON0pg/c
         PL072NHjo5LSP+ZMnRKqv9KIjD+QwOXRQQBRUmDdkckkx5zSupVcQ1iBvuJCrWzxJnMA
         u93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tluQfvA91/nwwhw7TAQOb6vdAq/g9t5OVhApDDMMFeo=;
        b=ceViaapv6tMi3Zcr1ekzXOv40NkL8Pzg5TIu7bHhCbHTG04Sr3CTtCTsrX/uE9c2OJ
         +Hlz74DwNwnHGgNaTyiECc6hlr95sjLUXvLB+eAG9udTvyPmyXmZd7BfZT+8WxMd4ETD
         ahGCTet1q8AcHQ0OSn8cY/79ZDcWJng+maJDXQNLM/phwJLFbyoJFFMkqG76k2nBNVd+
         4hqcvbCtYQoSA9xlkhsQiXVWbYmO6jiOEj/rDQGnzVqu0Z3EQis2PG3MN497QQInKGrz
         Daq2fOYWKm5KikRhXHcwhaNSYmu/E7J7Pr+1z7a9Dtrz0Hv5g6Jmcg14LAiNn47QLKmE
         0yBg==
X-Gm-Message-State: AFqh2kqVOyTZ2xPld1p/4zwJ6lhDxfKeNS5GNMS10Th1H0VQ7JhgUDOr
        yHn2YbmOdzNSb8DcrLkd2LU7o9rpPJKKalSEVU4=
X-Google-Smtp-Source: AMrXdXtlZQkPtIyu37ovsd5ugYW9ddfF67gR38eIhxvgT5HwqruPR5D08beB6iPt0G8EzgW/Aq6l7p4/CB++WXqwtvk=
X-Received: by 2002:a17:906:2818:b0:836:e897:648a with SMTP id
 r24-20020a170906281800b00836e897648amr3004188ejc.94.1673053453523; Fri, 06
 Jan 2023 17:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20230106195130.1216841-1-void@manifault.com> <20230106195130.1216841-2-void@manifault.com>
In-Reply-To: <20230106195130.1216841-2-void@manifault.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 6 Jan 2023 17:04:02 -0800
Message-ID: <CAADnVQLpK7WXTjF6GS1hcfPXf=8iERJmEeVFfvmG75mJj0DdaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add __bpf_kfunc tag for marking kernel
 functions as kfuncs
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 6, 2023 at 11:51 AM David Vernet <void@manifault.com> wrote:
>
> kfuncs are functions defined in the kernel, which may be invoked by BPF
> programs. They may or may not also be used as regular kernel functions,
> implying that they may be static (in which case the compiler could e.g.
> inline it away), or it could have external linkage, but potentially be
> elided in an LTO build if a function is observed to never be used, and
> is stripped from the final kernel binary.
>
> We therefore require some convenience macro that kfunc developers can
> use just add to their kfuncs, and which will prevent all of the above
> issues from happening. This is in contrast with what we have today,
> where some kfunc definitions have "noinline", some have "__used", and
> others are static and have neither.
>
> In addition to providing the obvious correctness benefits, having such a
> macro / tag also provides the following advantages:
>
> - Giving an easy and intuitive thing to query for if people are looking
>   for kfuncs, as Christoph suggested at the kernel maintainers summit
>   (https://lwn.net/Articles/908464/). This is currently possible by
>   grepping for BTF_ID_FLAGS(func, but having something more self
>   describing would be useful as well.
>
> - In the future, the tag can be expanded with other useful things such
>   as the ability to suppress -Wmissing-prototype for the kfuncs rather
>   than requiring developers to surround the kfunc with __diags to
>   suppress the warning (this requires compiler support that as far as I
>   know currently does not exist).

Have you considered doing bpf_kfunc_start/bpf_kfunc_end ?
The former would include:
__diag_push(); __diag_ignore_all(); __used noinline

Also how about using bpf_kfunc on the same line ?
Then 'git grep' will be easier.
