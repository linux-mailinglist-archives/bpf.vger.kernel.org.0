Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5165837B1BA
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 00:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKWqt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 18:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWqs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 18:46:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE85C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:45:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id m9so28454057ybm.3
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ER/hymdriwYsotFQHbExyXVOw+A2RjH7yZCn5D1jGg=;
        b=u4QRiwJLjlWm+a5YoilrbqFyNEPw8/TCT+IvZ8mOeAe+TycEfOPcxCgdxz/VX43Q5x
         CTFSZeKakP448Id2I/vnAuSMKyNoAm4juLgVD2dYMbRycZiVP8t7uAoIAfwTipWWZdC2
         xpsm8VMXZBq0eX3wJLBO6R0NYxpfj7tfLD6I0ZvKKuaIxsiIYsP+BdEEM4+sLOq2eKME
         bhdvc6X84VtRhYzW/hSPEc0FL1yJDHJPtxB7dFW43xCFzyx/b01i0mDXyvnE7g1HR90t
         GTmcmiGwvT6ZNmGxw7XpyZdOKZf7yiAEjhmvJZKdBN3TGMgu/lJu+azgDpiXLjEZrOLj
         4PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ER/hymdriwYsotFQHbExyXVOw+A2RjH7yZCn5D1jGg=;
        b=UAYoX5Ct8NssO7RkXiQTvz+AuDVVx2YXdLcZSv3ENpZ6ivL6GdGPgVxpKDWHusMjcE
         tBT0BOIKViVYFIamVP0+TuQaXILacriPJ6IFGdECamNmtYsVyNHzYbdsMmSl/dMuGbPo
         0TipLCdzm9p+pc8qLP9eGmS0wagRhxUJy7JtO91zw0tl30j/muvkA73PVFSblYjtbAj+
         sk12nd81lj+xnFEzP7xTE+FLDGz7VZVQsgBGgQKMIvvHnz+DA5D1dSZw0VOqn5roQ9YF
         9cn/Ufz2QPL64IO7raIp4SmB8Zrq384quqlfy8f3TwlyIjKUwhMhtfq8ozwD1iCxWB1S
         n3Uw==
X-Gm-Message-State: AOAM531hdGkx7Yh6/SU6g/QNeL+1+dUzU0frTbmvTOHOqlg4BOP/r5vW
        /syxNsV6691pNBLvX1DqJcCftzswNLusq5t+bzw=
X-Google-Smtp-Source: ABdhPJxpCvqvpwf4GogSqAScHfvUDpU+tcK+yNioj8T3yladYu9zld2mIDgqmgO20GNQSel8/WHIHvStIilbGflwXkQ=
X-Received: by 2002:a5b:d4c:: with SMTP id f12mr19477488ybr.510.1620773140150;
 Tue, 11 May 2021 15:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-8-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 15:45:28 -0700
Message-ID: <CAEf4BzbJDRAVmjPSk6XWcfxuLUvymouN4G+-UYM1G9f=2pX-yA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/22] selftests/bpf: Test for btf_load command.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Improve selftest to check that btf_load is working from bpf program.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/progs/syscall.c | 48 +++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>

[...]

>  SEC("syscall")
>  int bpf_prog(struct args *ctx)
>  {
> @@ -33,6 +73,8 @@ int bpf_prog(struct args *ctx)
>                 .map_type = BPF_MAP_TYPE_HASH,
>                 .key_size = 8,
>                 .value_size = 8,
> +               .btf_key_type_id = 1,
> +               .btf_value_type_id = 2,
>         };
>         static union bpf_attr map_update_attr = { .map_fd = 1, };
>         static __u64 key = 12;
> @@ -43,7 +85,13 @@ int bpf_prog(struct args *ctx)
>         };
>         int ret;
>
> +       ret = btf_load();

Maybe let's move patch #11 (bpf_sys_close() helper) in front of these
selftests and call bpf_sys_close() appropriately on error and (if
success) after map is created?



> +       if (ret < 0)
> +               return ret;
> +
>         map_create_attr.max_entries = ctx->max_entries;
> +       map_create_attr.btf_fd = ret;
> +
>         prog_load_attr.license = (long) license;
>         prog_load_attr.insns = (long) insns;
>         prog_load_attr.log_buf = ctx->log_buf;
> --
> 2.30.2
>
