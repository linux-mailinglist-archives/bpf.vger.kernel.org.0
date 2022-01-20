Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91850495685
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 23:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378104AbiATW6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 17:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiATW6l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 17:58:41 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86BC061574;
        Thu, 20 Jan 2022 14:58:41 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u5so6254876ilq.9;
        Thu, 20 Jan 2022 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2R1r7lbzHjwFkrPG1ysQPgQWbz3uiy9tgPY3MmK5Ws=;
        b=MRYVqzTGoAkxyUzB9Famjb5NrAotUS3LSEUky6Avw5Zxc44adDnkUPXBhc3sXEvfzO
         RHTcrdZETpds5YGXIOVpTFHDteM4AreN4EboLLVWnFZIVQcVcmF6yzJ7umt29nHVknpp
         sQbbr0tEvVQeMS0GPmQlBoT3jYQ/qQPxhFhnY7IYjdO71Sp+xumQR9zQznr1QbyZQCto
         FBX0ZuFAn/uXp2ram/y3TSVF0PaY5Pz7WXb+qTMpS5YHsC4liPr6SXGrMufjAfD8hFNd
         5T2mxPrzg4JPXBBOIE/eK0UOhBfbDWjdx7OHm+aLCLVIAT6WFClmGqndjuJBUdf7YNON
         1dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2R1r7lbzHjwFkrPG1ysQPgQWbz3uiy9tgPY3MmK5Ws=;
        b=3ynj77eVKpqskJOsCFPOCW/I9NzH7qne7u+svY+bNYXykZumEKCfkJDXBoOokDvv3w
         hB+3Cy6icK6KQuC19h2AhxSeYhRchCwlXErWjD12Zt8nZuYLr36ZdPHlPpMwVHwdq96j
         v7MsfImLVJD+qHLiHCu0+xATnFblmJz3FR2VdFHeKkeNbuCNQ+OcXUeNYG4tQf1j/Rt5
         g0uhyZrOBhmF6Y2aJmww0K5g2VqovxUwtCkhZNjZAbPLBuGAjVtbBI5elxzRa4JXPMoO
         xwQKWOyih7a49pbnP07PgqBxx5P8bF1S8eNs5dwG5bz0L+W06EzzsdsdEJoH3rGZt06T
         ecvA==
X-Gm-Message-State: AOAM5309fMANdKtQ5bxAuvqyaLdjYNQYpdBCK9aWeXup7TNEyyFeB19E
        PZM4QXODzwxmvAyg1XuVWi/Ur9t8Yy2gidJgUeA=
X-Google-Smtp-Source: ABdhPJxv12+U9/t2si5uTSEBaw22wdMZ1AdqMkYylA+CD0UnrloTfwIMhIBx6zDqc1WejgvulfR9LsJrEUpxnEryZpw=
X-Received: by 2002:a05:6e02:178d:: with SMTP id y13mr618198ilu.71.1642719520642;
 Thu, 20 Jan 2022 14:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20220119230636.1752684-1-christylee@fb.com>
In-Reply-To: <20220119230636.1752684-1-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 14:58:29 -0800
Message-ID: <CAEf4BzbODQmEH+wuFsEPFdtRoZ1Y-vDJKAKkBLsUDBLoQOmrvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] perf: stop using deprecated bpf APIs
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 3:09 PM Christy Lee <christylee@fb.com> wrote:
>
> libbpf's bpf_load_program() and bpf__object_next() APIs are deprecated.
> remove perf's usage of these deprecated functions. After this patch
> set, the only remaining libbpf deprecated APIs in perf would be
> bpf_program__set_prep() and bpf_program__nth_fd().
>

Arnaldo, do you want to take this through perf tree or should we apply
this to bpf-next? If the latter, can you give your ack as well?
Thanks!

> Changelog:
> ----------
> v3 -> v4:
> * Fixed commit title
> * Added weak definition for deprecated function
>
> v2 -> v3:
> https://lore.kernel.org/all/20220106200032.3067127-1-christylee@fb.com/
>
> Patch 2/2:
> Fixed commit message to use upstream perf
>
> v1 -> v2:
> https://lore.kernel.org/all/20211216222108.110518-1-christylee@fb.com/
>
> Patch 1/2:
> Added missing commit message
>
> Patch 2/2:
> Added more details to commit message and added steps to reproduce
> original test case.
>
> Christy Lee (2):
>   perf: stop using deprecated bpf_load_program() API
>   perf: stop using deprecated bpf_object__next() API
>
>  tools/perf/tests/bpf.c       | 14 ++-----
>  tools/perf/util/bpf-event.c  | 16 ++++++++
>  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
>  tools/perf/util/bpf-loader.h |  1 +
>  4 files changed, 75 insertions(+), 28 deletions(-)
>
> --
> 2.30.2
