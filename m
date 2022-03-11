Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AC4D6AB2
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 00:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiCKWvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 17:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiCKWvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 17:51:12 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946AF2CEA69
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 14:25:11 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id r11so11732539ioh.10
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 14:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZj5Uvyn/ejeeSKg/2zxJUo5nzTSl3iH0VdUKBcn6tg=;
        b=b2vvnyEIr4ImMMgwg8RfpnRySq3Ida23H3qsOcVyCwq4AHHXj7m6240+juGqw3IlZs
         92TQVDLSBr2VcziZsz5GdhA2IIW993JpHDegH81GYjQIonkN/q4eKSfQIXUnKDkwMJTO
         wuPRItmKhc9BHR2GYsWt4NpTM33ztXiqbNIxO97LDRQ+0wXnt8s7ZOqplpZj1zdCjiG6
         FAPm+XOXvN5XClGYHCMpwzprd3bFUAgCJ48iYvsAYwGUrcGURtdvjTDQ1wDl51lEAysU
         u6eD4xN6c14wwiJmg+8pv0N7Q8QyGLbfB20kUw2kAHXiqf7Ok9+Vp4Gp6xMEtQJ1sYkH
         crmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZj5Uvyn/ejeeSKg/2zxJUo5nzTSl3iH0VdUKBcn6tg=;
        b=xcQnXxJul9VuMB40fGZ1hwKgMGJ3LIL4Wt8XHJ5h+X/X9qfJmsl48hmNo3nbFvToAs
         EntZ5Hx7tlMARYSiJFxCL3NdwOCT+93zLXeAwTfs7IeoP+qHFT+yf4swHjOOwBT9UDwX
         h+LgbA5vt52MLFex6eU9IhyOixPWKiPZn1tqd9ftGL0XEUJOrziKWW12gglik7LFt0DO
         XL6Kx6iR/oqMEgI2170VgBhKTpIotIeXr5yQFl26M2tVydFsr7XAyOBKt9Se3J29ebPg
         b1H2NVCcEG1UthkhT5/yltKoR8qP+uIvgXmpIaoo1RRuHUR5ay3Xe9KtS8eu+hHtqoO6
         ZQog==
X-Gm-Message-State: AOAM533WWoJBXWe+N4RWDhWBqsPKLEObpTC7d+67NfXnKcHWVGIoqInS
        EgpZyp/2Zeqdyda9KwD5Xrd9nNWvsd4Wv+EajiQ=
X-Google-Smtp-Source: ABdhPJxU0IiqeT4zaks3HdNiqSOfBu9JvePkXwNygXgDD/mhq7N3UvFLBPRpXcQ12uNmRjcparJ6iusvOMAD33W2/q0=
X-Received: by 2002:a5d:948a:0:b0:645:b742:87c0 with SMTP id
 v10-20020a5d948a000000b00645b74287c0mr9351425ioj.79.1647037510975; Fri, 11
 Mar 2022 14:25:10 -0800 (PST)
MIME-Version: 1.0
References: <20220309163112.24141-1-9erthalion6@gmail.com>
In-Reply-To: <20220309163112.24141-1-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Mar 2022 14:24:59 -0800
Message-ID: <CAEf4BzZJ1DBuhHi400ObWoEQA7nLMT8TD4cVmhea_g4tdRFzoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 9, 2022 at 8:33 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
>
> Implemented using the pid iterator BPF program to actually fetch
> bpf_cookies, which allows constraining code changes only to bpftool.
>
> $ bpftool link
> 1: type 7  prog 5
>         bpf_cookie 123
>         pids bootstrap(81)
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Quentin, any opinion on this feature? The implementation seems
straightforward enough. We'll need to not forget to expand the support
to other types that support bpf_cookies (and multi-attach kprobes and
fentries will be problematic, potentially), but this might be useful
for debugging purposes.

> Changes in v6:
>     - Remove unnecessary initialization of fields in pid_iter_entry
>     - Changing bpf_cookie_set to has_bpf_cookie
>     - Small code cleanup (casting bpf_cookie when needed, removing
>       __always_inline, etc.)
>
> Changes in v5:
>     - Remove unneeded cookie assigns
>
> Changes in v4:
>     - Fetch cookies only for bpf_perf_link
>     - Signal about bpf_cookie via the flag, instead of deducing it from
>       the object and link type
>     - Reset pid_iter_entry to avoid invalid indirect read from stack
>
> Changes in v3:
>     - Use pid iterator to fetch bpf_cookie
>
> Changes in v2:
>     - Display bpf_cookie in bpftool link command instead perf
>
> Previous discussion: https://lore.kernel.org/bpf/20220225152802.20957-1-9erthalion6@gmail.com/
>
>  tools/bpf/bpftool/main.h                  |  2 ++
>  tools/bpf/bpftool/pids.c                  |  8 ++++++++
>  tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 22 ++++++++++++++++++++++
>  tools/bpf/bpftool/skeleton/pid_iter.h     |  2 ++
>  4 files changed, 34 insertions(+)
>

[...]
