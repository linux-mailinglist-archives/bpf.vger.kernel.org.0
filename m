Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB663F822
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 20:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLAT0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 14:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLAT0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 14:26:14 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD3BE6B6
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 11:26:14 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id o127so3340620yba.5
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 11:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZqJJZn7WTQIIqtb1kQazkiac+O+s8rmRa31ubTMLpI=;
        b=Ss7MjkvbNEuRDipxT6yNwg04M5yohG5euOwsEav0jTbLvGzCg9rs3WVUs16YQJkgjC
         VK6nPJOrb0CJuK1RkqQF5YFLNivqhdU90y450s0WozOhBEIVW+F/CRiEO20IvyNZMMIH
         +vPfbcDRQplCqAMn81AAdoUoDXT4T6QKiQkVVmPElz10i9ur9Y16vlN/Z2QHhxjEZRwp
         8QX3XUplQMzcpwBhJCGSoWManQpjwzR0bd+nIXIZX31T3Y7cZpN9t1FKMZZ4uSKJ8lSk
         dbW7r6BGyOVkSpT40C06AK/n1vhnsNi4Oim1NNidKqmeile2amP30vVwzhon082pChr2
         pnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZqJJZn7WTQIIqtb1kQazkiac+O+s8rmRa31ubTMLpI=;
        b=NEZoRwcZ+DzBQd5/beShq7cYCCT83sTyEsigpiaeU6/0Lu+X30JrJsMcLDwhTTTJy+
         4GI0YUilQGDyGdy+FCMa2iNiJGnfbnP5PrrtbNN5ibBB62FF0CSdkHiWxPiXkJDr90jc
         DmMWaMUxecqDKSUuGiMxj0zzLwVXmjwIcUjHLrLj0CpKEym9T1uOACUO43eF4cErZMdC
         qPgFUz726KNK1rrdVDsAtZaMORaitjv7/vXjOwGvy441wgI3jrj2JnNdQxlHKjrzfDBd
         btHV3NobevJINilV3IFlDlva9TQ0++jZzmpkML8qnEN8f359rUqZk4S7uzAHjytrnCAk
         DKOw==
X-Gm-Message-State: ANoB5pkMzHTY9FIQXuhgxfnaxBAKbwOmR758127m7qUw78M1qOalmIkx
        bAERM+y6DJLTmMG/G8splv/WQMKgJWUtkhcLLiHdPA==
X-Google-Smtp-Source: AA0mqf7rg3jTJMxfAnWkIgvblnCm7qhYp8cE1qg5Vtq0PXwXHPc13yHXPeFi/mMa7hAyG9bmNYaONZEePRHFGCz2s2U=
X-Received: by 2002:a25:f20a:0:b0:6e9:8005:56dd with SMTP id
 i10-20020a25f20a000000b006e9800556ddmr58539960ybe.2.1669922773394; Thu, 01
 Dec 2022 11:26:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669787912.git.vmalik@redhat.com> <e7d42f8f48ab4323ba460b4c843c27f3c475f106.1669787912.git.vmalik@redhat.com>
In-Reply-To: <e7d42f8f48ab4323ba460b4c843c27f3c475f106.1669787912.git.vmalik@redhat.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 1 Dec 2022 11:26:02 -0800
Message-ID: <CA+khW7jZmPQpJrAN4JEbMPC=SN+iwj6-tBW6wvd=UKoeeq07Eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Fix attaching fentry/fexit/fmod_ret/lsm
 to modules
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 10:54 PM Viktor Malik <vmalik@redhat.com> wrote:
>
> When attaching fentry/fexit/fmod_ret/lsm to a function located in a
> module without specifying the target program, the verifier tries to find
> the address to attach to in kallsyms. This is always done by searching
> the entire kallsyms, not respecting the module in which the function is
> located.
>
> This approach causes an incorrect attachment address to be computed if
> the function to attach to is shadowed by a function of the same name
> located earlier in kallsyms.
>
> Since the attachment must contain the BTF of the program to attach to,
> we may extract the module name from it (if the attach target is a
> module) and search for the function address in the correct module.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---

Looks like we need to define a trivial
kallsyms_lookup_name_in_module() in !CONFIG_MODULES. With that added,
this patch looks good to me.

Acked-by: Hao Luo <haoluo@google.com>
