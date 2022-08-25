Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7105A1BD4
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 00:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiHYWAu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbiHYWAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 18:00:49 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8C3501B9
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:00:47 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kh8so525157qvb.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pZQ/2nHQhIrhPnU1bKwTlnrZA3djIkob/YiqxMhnkcg=;
        b=mAdzoUW7wW6FM0q0jbONT8uA9l3acX/GFHpJ7wC6WDxytlS0wUPjpaO4famr4o6UGI
         bRb7F3jg1uTrWwJkvILebhbpdBg1kwY8Y4GY1zaNauGK7UZ0WtYg76kz9OxYmQ1y/p24
         jE+mSSjJCthamtLl8RK3mgfcNE9Ri9yEuMGDJr/9jPm8NrkDcOCYXQEP2+Z/EEoO+lcD
         npjYu58k2kZ/rDc0WXISd/Hqpc69fiMaHu9gC9mefIdF6UB/RJbA9gKRVpO/SnanWqKF
         jkI11Vue+dQ0K3za7FLXgIm8E+oOsfrgmcGEOYBgAkyuy4+HL49apMopNpTMFkLJJrDi
         afbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pZQ/2nHQhIrhPnU1bKwTlnrZA3djIkob/YiqxMhnkcg=;
        b=a3+FAWu5BXmrI21huUxR3FK3pLudSASS9JLkSAFdbFonafuAHK+YHZcokLSFyW8znz
         A9tDHII2N7kC4ZV6mZCzIEzJ+0ib8XNfEx+RQvWKVJtDBUesX+WBvnDVrv+CsUcXQteK
         jROgY13FfqeEAZGXzvzXrE0YgL5F012QAr/Q1xh3qRWm+nnMbN+8XAewhTR3lB8Iij7G
         YBXLjNHIF2FS64cezecq46iCXTCtwoBXWPEB/bSiXLr8mj3a8/P7tVGEjoJwgTuohLpR
         A2KmssnwFc0/5+XJD4NHudS1UW0qHpV/3BGt5MpBwNaujqccOj5fyGCytz2XAYu+2tra
         PjBg==
X-Gm-Message-State: ACgBeo0sYd52qjRQ7AvT/nfLvpiiBPmKv+N2sv3g/+ywBfZ1eBMkoQ1t
        rBgZW0tKbCRwuw5NwuIym95VMKziYovEQjxLRtsJGw==
X-Google-Smtp-Source: AA6agR6XGAhoPsEzWX90e7VRQZdeYxFMQQX4NeTgsf+duYJt3Y7B9gdEI/cnVtfnEfrD3kJVO1DJUXmAHc0T+c4Bkpw=
X-Received: by 2002:a0c:b31a:0:b0:473:8062:b1b4 with SMTP id
 s26-20020a0cb31a000000b004738062b1b4mr5569946qve.85.1661464847009; Thu, 25
 Aug 2022 15:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220825213905.1817722-1-haoluo@google.com> <CAEf4BzaQOj3QqEbKKXhgUmWMF3gef-8+a-dYoe_t4=g+cM2KaQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaQOj3QqEbKKXhgUmWMF3gef-8+a-dYoe_t4=g+cM2KaQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 25 Aug 2022 15:00:36 -0700
Message-ID: <CA+khW7j-OZmr3ax03CwRvtyvEMYafaWPfkiwLRe2HQcPscWkug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Add CGROUP prefix to cgroup_iter_order
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 2:56 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 2:39 PM Hao Luo <haoluo@google.com> wrote:
> >
> > As suggested by Andrii, add 'CGROUP' to cgroup_iter_order. This fix is
> > divided into two patches. Patch 1/2 fixes the commit that introduced
> > cgroup_iter. Patch 2/2 fixes the selftest that uses the
> > cgroup_iter_order. This is because the selftest was introduced in a
>
> but if you split rename into two patches, you break selftests build
> and thus potentially bisectability of selftests regressions. So I
> think you have to keep both in the same patch.
>
> With that:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>

Yeah. I wasn't sure what to do. Then we need bundle this fix with
those two commits together. Will squash the commits into one and send
a v2.

> > different commit. I tested this patchset via the following command:
> >
> >   test_progs -t cgroup,iter,btf_dump
> >
> > Hao Luo (2):
> >   bpf: Add CGROUP to cgroup_iter order
> >   selftests/bpf: Fix test that uses cgroup_iter order
> >
> >  include/uapi/linux/bpf.h                      | 10 +++---
> >  kernel/bpf/cgroup_iter.c                      | 32 +++++++++----------
> >  tools/include/uapi/linux/bpf.h                | 10 +++---
> >  .../selftests/bpf/prog_tests/btf_dump.c       |  2 +-
> >  .../prog_tests/cgroup_hierarchical_stats.c    |  2 +-
> >  .../selftests/bpf/prog_tests/cgroup_iter.c    | 10 +++---
> >  6 files changed, 33 insertions(+), 33 deletions(-)
> >
> > --
> > 2.37.2.672.g94769d06f0-goog
> >
