Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91644AF8EA
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiBISB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 13:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiBISB4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 13:01:56 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4CC05CB86
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 10:01:59 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id b5so2368617ile.11
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4aKoHGKd1zCLowHvBPFJkMbzIPxbZkRSzbjqEgNI90=;
        b=nUjwMR/Qy2v9Ug7/736tI4Vmz6aSq9jSrByOAA31bcWe5kK0hjjw5BsesauEtnDKD5
         8HV4etGsiPvQpgShspY9OFmOtvTjXvR6TqqGh4KIazbvjBwxNHMVk+KZs7F+C+Poi1an
         QoYh+aZ1fB6oj/29tYgT0X62UCQ9dElsdsi8N34GuE+G9AFS4XHePE+Vdy2XZDFL2b55
         EvMQ1KQZ/QlfxWI5VQaJekZ7cB3U0oJAEkrtUypsgw8MQMgYGj01REKUiJSFgvRcAdnX
         suVD+Xm834ottDlT2VrwfCZGl5neHw9B30nVQH4sQIkb+YkJo76wrSlcdYS8SDaG5USR
         4PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4aKoHGKd1zCLowHvBPFJkMbzIPxbZkRSzbjqEgNI90=;
        b=x93trT6e8wK6YEpej/MTrM98sm0M8C/Ns/9uAGKWCnXVNAS98QLcMP9IzW3UkeKhwo
         EBe+WXdhWfOm4ZgYlnoQ9Pg6KYbFdA3NhUxbzTKvmG2bYf3rQnzVltCRKNVT511U+ZSI
         9w4QfCwu9PP886RLiyHg6Vhwcz/g8kFW8YNAnPBqtIq3EXIVs8PWRhYCvauDAZU4N5JC
         Jppar9imdZcU5jkNZfeJ6DghwyLr/90+hNEWqW98EB20Ve+dmDBoUBxcuVrcBXpuJM9u
         wH2H/L8JQZFNo0RR3XG6N62koZqEdbAKxYQLQmN9q8MUzUZKw9rWNtv0fc9JyyrwFUyu
         duBw==
X-Gm-Message-State: AOAM532IuCo5PYJmbQHjfTjRur3TSrLMP0nTbNM/jHeR4zch5A8x6xZG
        Bsk+g0o8BGFaShsWPi/5k42VYrPMl1jz7EZ+DFg=
X-Google-Smtp-Source: ABdhPJz/uCq9dmIBvjG8qaSvfEfvCsNmE13TVr+hC9HYsA9j/gw0ErEYq6d2/BMg7IlAQLua2JNjOaz7xeg6RN3DRJ0=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr1638227ilv.252.1644429719067;
 Wed, 09 Feb 2022 10:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com> <20220209054315.73833-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20220209054315.73833-3-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Feb 2022 10:01:48 -0800
Message-ID: <CAEf4BzZtm22V4m6tePBiq_mEg1v9CF3pdM2L2_aD=F2ZQwmndA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/5] libbpf: Prepare light skeleton for the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, Feb 8, 2022 at 9:43 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Prepare light skeleton to be used in the kernel module and in the user space.
> The look and feel of lskel.h is mostly the same with the difference that for
> user space the skel->rodata is the same pointer before and after skel_load
> operation, while in the kernel the skel->rodata after skel_open and the
> skel->rodata after skel_load are different pointers.
> Typical usage of skeleton remains the same for kernel and user space:
> skel = my_bpf__open();
> skel->rodata->my_global_var = init_val;
> err = my_bpf__load(skel);
> err = my_bpf__attach(skel);
> // access skel->rodata->my_global_var;
> // access skel->bss->another_var;
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

I like Yonghong's suggestion to remove unnecessary function, but LGTM either way

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/gen_loader.c    |  15 ++-
>  tools/lib/bpf/skel_internal.h | 195 ++++++++++++++++++++++++++++++----
>  2 files changed, 189 insertions(+), 21 deletions(-)
>

[...]
