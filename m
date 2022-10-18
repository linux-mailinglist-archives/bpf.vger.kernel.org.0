Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFA160230D
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 06:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJREEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 00:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJREEC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 00:04:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC28C186EE
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 21:03:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so29349066eja.6
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4O1udtvKZA0uuI6JYIr8AojphMxAG7jrjaN9o4zLVbE=;
        b=QzKI/90IN41ewweF2Ze+naJa9LowHVN1IMni+XZtghAo+NoKdUxvASFHajo2iNhD56
         /JBuAlQ26FwIjX8yT4bMH6HBYs53xJorxV7wlFytSm3vwjUL12IQoltcuZ7C4QW4jrwb
         s/9+neE4KWQOnrh9QR+5DqFRyEzM0WqyW1dUvnAfZ1GDQE2M5Z3d1Bzf6HHoJG1Ye/s6
         5T2mmaBTopemN+ttyXqnI1dcXERgNsjoCYalIUIeR7BZodsyvIOR8EFFcmTJ15KXv92H
         f+0rxjMSjMDlLtkRVc+rK3+LZ4WinUt2u6pXVSLDHuUHkLf2wuWwlWmoMSumhBOXC1JT
         hUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4O1udtvKZA0uuI6JYIr8AojphMxAG7jrjaN9o4zLVbE=;
        b=vA0ciu/R6S+an444DqUSMJA76dfB7QQ4bYuS9+MKevWWn2kbN/FAejWLXfeOIBLZqf
         i1L1CEX9vHtJYxmOXrL1nIX7ZRDd9l1GHrFPZ5biVXtB6/NIPMxfC5WJ81orn9hN/7kO
         sjJwHM9NZKP10baF+QuAq7kLMR6Jgb53Lh6eTUzoc4lrOC5DiuGwLMYMEMQYxBeCj6xD
         JJUf8XxuAeUErj7/T/m6DEgZV/lRtLcZXvISxRzFNOSvYVOwoEY7UqpX0P//dguhg+Pw
         a1+IWzo9rwwfuFV5GXcqdmdRz1OeyjbRX1SbtX7ILCa2X7rrXp5E5iFo139cnvAoTPAY
         8Z7Q==
X-Gm-Message-State: ACrzQf37E+zDHCrLc9drwHrRS937vGnQgyyH/kNgBDIusmbwhPoOQzq1
        gdsm5xqv4gXPShLcQ+YlleYzER4iI7tTvIsg5zY=
X-Google-Smtp-Source: AMsMyM5Ie9j7w/Pq4zDk+xaZJPJv+W1/DQtUbKecoYB7XHzqivm37Wl15t7/14cMX0VFS37mIEBPcVAedWFfkSxWhVE=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr737611ejn.302.1666065838131; Mon, 17 Oct
 2022 21:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221013062303.896469-1-memxor@gmail.com> <20221013062303.896469-24-memxor@gmail.com>
In-Reply-To: <20221013062303.896469-24-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Oct 2022 21:03:46 -0700
Message-ID: <CAEf4BzaLvTTnUtAmfZiLSJ6q+sMEhk97vns58_c_mTaA2JtDBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 23/25] libbpf: Add support for private BSS map section
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Wed, Oct 12, 2022 at 11:24 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> From: Dave Marchevsky <davemarchevsky@fb.com>
>
> Currently libbpf does not allow declaration of a struct bpf_spin_lock in
> global scope. Attempting to do so results in "failed to re-mmap" error,
> as .bss arraymap containing spinlock is not allowed to be mmap'd.
>
> This patch adds support for a .bss.private section. The maps contained
> in this section will not be mmaped into userspace by libbpf, nor will
> they be exposed via bpftool-generated skeleton.
>
> Intent here is to allow more natural programming pattern for
> global-scope spinlocks which will be used by rbtree locking mechanism in
> further patches in this series.
>
> Notes:
>
>   * Initially I called the section .bss.no_mmap, but the broader
>     'private' term better indicates that skeleton shouldn't expose these
>     maps at all, IMO.
>
>   * bpftool/gen.c's is_internal_mmapable_map function checks whether the
>     map flags have BPF_F_MMAPABLE, so no bpftool changes were necessary
>     to remove .bss.private maps from skeleton
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Please see [0] for what I think is a better way forward specifically
for the libbpf-side part.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=686066&state=*

>  tools/lib/bpf/libbpf.c | 65 ++++++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 21 deletions(-)
>

[...]
