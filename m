Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFE67B692
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjAYQGm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjAYQGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:06:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6178559E75;
        Wed, 25 Jan 2023 08:06:24 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g11so16826426eda.12;
        Wed, 25 Jan 2023 08:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4kWGlqJC/g488ocuFK/LpqeMy7MO0k2vXLk45E7PuA=;
        b=Yp1kdybDLtCnI2z/5VhhA7iGsp6U22cJcv1sV+Vrt4BB4SxnuRzjyZcawy62hQgSP0
         PhgVXQSdQS7OpozLe50sdNtwH4b8zyDOAH22bx52dfH4quSoyAh4gdBoX2M1/CM5svmK
         BXZx5ZO+A3g4BRKxvLtO+yLhAUGrW0BlNoPb+73fiRPjOCxe7YokKjnLDUqfvwxpf5an
         SxyLFTntE9ZqxwV7fcYq6HWnWWBe4Vk0LGb3RCzGh66Mo5ge3Hm9JkiBWugreuGYIVnx
         A3yO2GzGVpWHMfjEbcBLSj+hrCIrQrE7SL6zBOOSPVxiZGpoo+5nb8KOHUUXIUxYuGlg
         TTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4kWGlqJC/g488ocuFK/LpqeMy7MO0k2vXLk45E7PuA=;
        b=7i23s/pGKqb068vbcy1KM6P4nkcIAxDY1YqO2JXCiRV8X0Di7rRA71glUomKDrbnh5
         v7kKSL39B7QRV2tEH837KJpmV8rlmmZW73rKwxMt+cynIGYMGLvWf4ozm5sl96lfkM9l
         vu1tYZfn9NdR5geg7JPlBbrmOZkmCNlpHFAEZu+LcbNPxzKrE7XCX0cYwqwkjmb7lspa
         yfsyW1Og3jsb9iUWkhKO9E5M01iiSheH5AriQkb2/m33LGQ3US8AalkgZzFyC/o2kAl3
         XWz/0cvmm6mzF6drXgAUcrEER1MAO+Een8ZViN/T4mI6HMj4hjenbuwjQdJJU/CUXTQ9
         8CDQ==
X-Gm-Message-State: AFqh2kq48bH871xVbkt0/TjJ2gewKp/t0gsDTQ3NbQmTp/COmV+i7JNP
        QKxsR+f6YaOy0XoPxh2VDFutlrc9QHkHxihDFr4=
X-Google-Smtp-Source: AMrXdXvMsK7VCK3lJs6JPXWyszE2beYfRsVcLZJ8q4Z4ovR0YsDmmv43+SS9/v/GAHu5h2IJrwRIg4xirUJy9rDfRdU=
X-Received: by 2002:a05:6402:22f7:b0:49b:651d:7930 with SMTP id
 dn23-20020a05640222f700b0049b651d7930mr4339446edb.79.1674662782804; Wed, 25
 Jan 2023 08:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20230125050359.339273-1-void@manifault.com> <20230125050359.339273-5-void@manifault.com>
In-Reply-To: <20230125050359.339273-5-void@manifault.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Jan 2023 08:06:11 -0800
Message-ID: <CAADnVQJ18MRB+z5feD-hu8zdV2s=rhTW--RWW06NWp-kQaBhag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] bpf/selftests: Verify struct_ops prog
 sleepable behavior
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
        Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
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

On Tue, Jan 24, 2023 at 9:04 PM David Vernet <void@manifault.com> wrote:
>
> In a set of prior changes, we added the ability for struct_ops programs
> to be sleepable. This patch enhances the dummy_st_ops selftest suite to
> validate this behavior by adding a new sleepable struct_ops entry to
> dummy_st_ops.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  include/linux/bpf.h                           |  1 +
>  net/bpf/bpf_dummy_struct_ops.c                | 18 +++++++
>  .../selftests/bpf/prog_tests/dummy_st_ops.c   | 54 ++++++++++++++-----
>  .../selftests/bpf/progs/dummy_st_ops_fail.c   | 27 ++++++++++
>  ...{dummy_st_ops.c => dummy_st_ops_success.c} | 19 +++----
>  5 files changed, 94 insertions(+), 25 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops_fail.c
>  rename tools/testing/selftests/bpf/progs/{dummy_st_ops.c => dummy_st_ops_success.c} (72%)

It fails on s390:
dummy_st_ops_success/dummy_multiple_args:FAIL

Please add to DENYLIST as part of this patch.
