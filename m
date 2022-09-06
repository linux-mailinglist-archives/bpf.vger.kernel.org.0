Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3066D5AF84C
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIFXQr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIFXQp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA617EFC1
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18EBF61722
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DA5C4347C
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662506203;
        bh=xyJrRRsmR70jkaKml54Z3w8kXihDQL9dv5skmjoaTks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uqzmUh/WlCQssxLlGPNjUj8aGcdKC7pRWcLOgMWMrnyVh/b5DNFqLvC26XDznEuNs
         ITsXawUCRV1ivGHBiWCpjFqf9cSr2Lb+zDEH2Jvv5sgeKt99xXLyvrV2DW3dgH3r0N
         y+UvEy1jB67DtCSjEFRHKzBxwZnFqxyOZbbAodds52VFoh0uKkmVZVgLokIPgIpxWk
         Q29islnQiV+snrJZ9ameNXLdXxJv6sRNTQbSQh7PMjxuCCJvVFgwoW6tBvL61AOTnT
         W9JTuZlEMaRjS39j6EdCemFZyYbT+D1ybe5QcrdDveSz0HoRZyIj7lEJuZQhqUjdFZ
         vmF/54DfN3tRw==
Received: by mail-ot1-f41.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so9102172oti.9
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:16:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo3Lx35BgK/VkxgpD88PtNR5zOQBCX2bjKA9zPgvkhqZ5DDu7EQ3
        cdwZbV2e6EwFViOD2TOgsbn/OYHzRjNasGj+7HQ=
X-Google-Smtp-Source: AA6agR5fg0Om86/3taFvjzGKgKtqbxaW4k4ka9vKjF9UnkefLKtSYg/k/05SFkFdngm6aMjWc3mzM2KDnUD6vH/6rG8=
X-Received: by 2002:a9d:7c94:0:b0:636:f74b:2364 with SMTP id
 q20-20020a9d7c94000000b00636f74b2364mr343835otn.165.1662506202614; Tue, 06
 Sep 2022 16:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220906133613.54928-1-quentin@isovalent.com> <20220906133613.54928-3-quentin@isovalent.com>
In-Reply-To: <20220906133613.54928-3-quentin@isovalent.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 16:16:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6tkpK8TV-K=JPiCyYA12xasM+Dh_g2nLnaemYuhz_mbg@mail.gmail.com>
Message-ID: <CAPhsuW6tkpK8TV-K=JPiCyYA12xasM+Dh_g2nLnaemYuhz_mbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpftool: Remove asserts from JIT disassembler
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
> The JIT disassembler in bpftool is the only components (with the JSON
> writer) using asserts to check the return values of functions. But it
> does not do so in a consistent way, and diasm_print_insn() returns no
> value, although sometimes the operation failed.
>
> Remove the asserts, and instead check the return values, print messages
> on errors, and propagate the error to the caller from prog.c.
>
> Remove the inclusion of assert.h from jit_disasm.c, and also from map.c
> where it is unused.
>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Acked-by: Song Liu <song@kernel.org>
