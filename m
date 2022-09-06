Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197235AF84B
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIFXO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIFXO0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA2CCFE
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658F161724
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5649C433C1
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662506062;
        bh=dziqipFZL5XGnC3nlvm+8H11wWAGuH7/rKk5s8DwOqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L4n5RDTRiVsqr5RvhdLSduH7qfhaQligIvQH2y7w+5TnZSbNGpYkkz6JYYj7WzaLj
         RlVeFZX9GLXdjNKxuNQuT5KFkWNW4cr0SJDDADBHl8eqd715qvRSXGT+yrQk6nzzV0
         SGDQ/lVYnHFV3QbYR1PmR9cTWfTucYtAJqonpUcuRNr1HJI0qisW7UvBVq8Gu5enoJ
         x+qI7VLBJJuUhKuV9+1aItZ/Ddon/Tj260z6c4QoW42ByTP9NMzIBpKQ22FxvgVXZo
         1px82Z3OmaZb6dnxkGlgznexPNYmY6BJ5tuseKWw/4nvh64S48ExOa5XiWqoOoymss
         KAnSN3ZYoz8bA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11ee4649dfcso32040159fac.1
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:14:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo2k2OAMswJRJy6qVGOSL8srubBIqQpXY8tfj+VopsuDgUnJCe3x
        2cEYUNPhH9AkxtLqmbsrvkNed6pKVVCnlH0HWIo=
X-Google-Smtp-Source: AA6agR7c961+ObshvNDbYx5Ne0CBSUp1Rt3nQ75VPYCrDIOPRehipb8HUi/Cwih1/SEX232h6hF3CL5kEd6UhJK9gZ8=
X-Received: by 2002:a05:6870:32d2:b0:127:f0b4:418f with SMTP id
 r18-20020a05687032d200b00127f0b4418fmr379089oac.22.1662506061967; Tue, 06 Sep
 2022 16:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220906133613.54928-1-quentin@isovalent.com> <20220906133613.54928-2-quentin@isovalent.com>
In-Reply-To: <20220906133613.54928-2-quentin@isovalent.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 16:14:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6V4_Z=Wtcg1QATuQCMtMRcBu-+xaFqGyyMMo8CP2=N7A@mail.gmail.com>
Message-ID: <CAPhsuW6V4_Z=Wtcg1QATuQCMtMRcBu-+xaFqGyyMMo8CP2=N7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpftool: Define _GNU_SOURCE only once
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 6, 2022 at 6:44 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> _GNU_SOURCE is defined in several source files for bpftool, but only one
> of them takes the precaution of checking whether the value is already
> defined. Add #ifndef for other occurrences too.
>
> This is in preparation for the support of disassembling JIT-ed programs
> with LLVM, with $(llvm-config --cflags) passing -D_GNU_SOURCE as a
> compilation argument.
>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Acked-by: Song Liu <song@kernel.org>
