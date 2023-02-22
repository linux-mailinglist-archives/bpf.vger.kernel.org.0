Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F569FDA5
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjBVVUe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 16:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjBVVUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 16:20:33 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1238EB0;
        Wed, 22 Feb 2023 13:20:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id da10so37156049edb.3;
        Wed, 22 Feb 2023 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JMMSmHe912RQvblGevXKqRKvjih/+Kh5utuEpNYnIfI=;
        b=UyKkA8eOPcONc5JBguvchZ0OkPdUJAoPjZFLYswcWnAOwnH48WHE1vmiHhTiAJFS3P
         CsJJNmEfsmtU5jHhJiosasHRnj2xDIb842L3g005sOpR9686i5WBqsTyBTdL+dsRF6Yw
         QxvcnTgRo9pUftPBBW+Yngq880V27WRMTk4auC0+t/FIH/eSLZloQ7pCNchAsvLXJ9Rm
         h1FY1dJza9xMT7C7fs2QkzvCzIODLGrFlBOh3xWlNNDvskzgSwYATI58+TVT3zUpQkyc
         zvjgjebTS+B82wrVr0Bxp4QihojtF85BUYZvJJwIrxqVX71rR4VijDKX+P0Ssjl5/9yi
         uSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMMSmHe912RQvblGevXKqRKvjih/+Kh5utuEpNYnIfI=;
        b=JE13gwBJjJZsPKpI1nSe0VDyBqeSZONRkXq/qCV6iwEKUrr8UEPWXG09ONdLyehIIY
         liAU+iRSyEKemtiyxOh3ELcfpzTASU5wZb6mRLOqoAFgpuUGf20sdrbPf9YUM18qr1xb
         6ClRy0NRiqnra0K29UeYcX4Au39jnJ/hmcTgKdN/bdU65LE9/be5aodOCEhG+ElJcQf8
         AFHxakRF2rMH1Y3BuVLwbpIbf7Mt1eTaBEVdjGscRqowN3j1/HZH+fWgeMFyKzTo8j/N
         et6obRxknvKMm76hRXX8pnHWRwlys6gnPKzS/93wHaMBkAyTo5AlqcYX+8X9tjAakCnd
         ijJQ==
X-Gm-Message-State: AO0yUKU3/TacOwCXXFf61bZwIqIQQrWd3GGNy8lgJH6jeShVpIWh7AGV
        N4tEV8R8TxJeEWVgq0ECRCURF4nUOWe4UfitzvY=
X-Google-Smtp-Source: AK7set9OJHeC5ZH4wSlR5PXYLazKqODY9vCXdldP+gxc+StIlnZQAnXHlOYMSClz8ZxJMgP2Mt7lkBXrMLRC4B2cKM8=
X-Received: by 2002:a17:906:5e42:b0:877:747d:4a85 with SMTP id
 b2-20020a1709065e4200b00877747d4a85mr8679376eju.3.1677100830688; Wed, 22 Feb
 2023 13:20:30 -0800 (PST)
MIME-Version: 1.0
References: <Y/VA+jP0mB5cMZEz@slm.duckdns.org>
In-Reply-To: <Y/VA+jP0mB5cMZEz@slm.duckdns.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 13:20:19 -0800
Message-ID: <CAADnVQL0Zf3Dq=6wCMmj+R9bz1B1J4b=mUkvkObKfPQprUjyag@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_cgroup_from_id() kfunc
To:     Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>,
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

On Tue, Feb 21, 2023 at 2:09 PM Tejun Heo <tj@kernel.org> wrote:
>
> cgroup ID is an userspace-visible 64bit value uniquely identifying a given
> cgroup. As the IDs are used widely, it's useful to be able to look up the
> matching cgroups. Add bpf_cgroup_from_id().
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  Documentation/bpf/kfuncs.rst                  | 10 +++--
>  kernel/bpf/helpers.c                          | 18 ++++++++
>  .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  1 +
>  .../selftests/bpf/progs/cgrp_kfunc_common.h   |  1 +
>  .../selftests/bpf/progs/cgrp_kfunc_success.c  | 42 +++++++++++++++++++
>  5 files changed, 69 insertions(+), 3 deletions(-)

Looks great, but could you please split it into two patches:
One for helpers.c and kfuncs.rst and another for selftests
with [PATCH bpf-next] selftests/bpf: subject ?
Doesn't matter much in this case, but it might ease backporting
and easier to track patches grouped by subj.
