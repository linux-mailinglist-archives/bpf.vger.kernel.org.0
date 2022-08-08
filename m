Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1DB58CD0C
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbiHHRu6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbiHHRun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 13:50:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865B109B
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 10:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05B42B81022
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 17:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34E9C43470
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659981039;
        bh=kYzYZNbpMQ7r3hpRHKo0xg1Lbcv2YUv1uswr9A4RxdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BEXRMh21X5Sx5kT+rmVsGRuyKwM63HMdpYrPwsPwnf7Bn0X36zzDJ3yFwxOEox9X7
         oo7bwPhP9646gsoWSb+vmWGez5oaV5UPF/66TxTJ3dI6A20K80F7k0qNjuNtlzWoXz
         2Ys01EjKlfX4dGukcsa2I7t9Pxw+FXMrHROhFVutCMnpK7weAMBB6e2AlIqFnBWnw4
         msYiK8Y5IYRlqKVx+zKA14W/gWe+0DQoiwNv34W5Xc9vEs3ekYp4OEN7jb88Y0tuhP
         OnaG/33xaiySydQOAl1C81tsBGPpsSPpuXHEVCguqm7qur8vRYroUAzoSAn4uqsQFX
         NLkpaoqmdaMrg==
Received: by mail-yb1-f176.google.com with SMTP id o15so14760792yba.10
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 10:50:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo0RzNlYoB9+V/Y8/5Fw09/pasuZG4xjeKk/SzJKyyDzM0KpV0mw
        llQAbFeyEuG0LuBkIC1JD7Nbs/k5Bd0aX5erx0M=
X-Google-Smtp-Source: AA6agR62Zqne0BXvoI/iPg5pT7POjQJHCK9CpokqqJ3LVIuHoJAO4qaZCBwQm1jGI1wqxgLo3vzIYo1Cy1fGxDgaw88=
X-Received: by 2002:a25:805:0:b0:670:4237:cddf with SMTP id
 5-20020a250805000000b006704237cddfmr16555061ybi.9.1659981038705; Mon, 08 Aug
 2022 10:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220808140626.422731-1-jolsa@kernel.org>
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 8 Aug 2022 10:50:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW79BmASh7M79DG7O2AT60op5unujeHKe33BUhZdr+wd9A@mail.gmail.com>
Message-ID: <CAPhsuW79BmASh7M79DG7O2AT60op5unujeHKe33BUhZdr+wd9A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/17] bpf: Add tracing multi link
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 7:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
[...]
>
> Maybe better explained on following example:
>
>   - you want to attach program P to functions A,B,C,D,E,F
>     via bpf_trampoline_multi_attach
>
>   - D,E,F already have standard trampoline attached
>
>   - the bpf_trampoline_multi_attach will create new 'multi' trampoline
>     which spans over A,B,C functions and attach program P to single
>     trampolines D,E,F

IIUC, we have 4 trampolines (1 multi, 3 singles) at this moment?

>
>  -  another program can be attached to A,B,C,D,E,F multi trampoline
>
>   - A,B,C functions are now 'not attachable' by any trampoline
>     until the above 'multi' trampoline is released

I guess the limitation here is, multi trampolines cannot be splitted after
attached. While multi trampoline is motivated by short term use cases
like retsnoop, it is allowed to run them for extended periods of time.
Then, this limitation might be a real issue in production.

Thanks,
Song

>
>  -  D,E,F functions are still attachable by any new trampoline
>
