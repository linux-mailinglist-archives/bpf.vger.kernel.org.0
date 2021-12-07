Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4137E46B2C7
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 07:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhLGGRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 01:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLGGRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 01:17:52 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EABC061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 22:14:21 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v64so37989813ybi.5
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 22:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AT0+T2FEJZFH+44o9gVupQkYIqm1fLV4yrkn4WE3Xac=;
        b=gLGx4iXp6qcS3r5nplMP9Bwk6eSaXi29mCzZlMub0IgoT8sZyDJW3eqXDN8Iq1jhtw
         0YiseH4aPkRuyESi4QMDqDTY4DcTS5Q7rb4cMia8vMssFPapOBKF7yokiPnMZCLnxAOD
         nLb+Q6LcJSQC/D/+EHU2kPvsdaCR3W3kCt0Hd1w2pXdJ6JBAcNKE1RKdiZQds1kabwTR
         6CsIDjp79xEsGwiHc7mpZalzWHXFKbzx8LRGo1ymuxySjr6f8ckgCaCbUgr+pJ6+alpv
         y3G8xoaUkzULBGl3guA8ebmoTKxfgUN087ZKamH+vTk8VRoq04Rz9QzNdsFA5S5zP7g9
         IHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT0+T2FEJZFH+44o9gVupQkYIqm1fLV4yrkn4WE3Xac=;
        b=waT86uRskIsUNRD84BOYeIGmaX7gCHSvo4/WyYVRXCvbIglO52zV5EZDIu9izqRXic
         F2+qunI9qO9DZe+v0SG+Ae/fEGpqfNxWnwLxaRoYd26yCecTQ2zNFpKSFYlie8AgPwFf
         vp8WGnNvs8usFPBhXqXgEu4HSXm1cMnbnrZriU92BmPQArAI3Yowey9YuPU4SNtMlNlE
         dk8YQ30OXjAKlKkZPo0lOTPc89Igtl2OBCK8cPIhRSe5dq7HJrVvVhW/bu+ECITgJVEs
         SamBn/t00fM5tGSFuMEis+zekEuOOAjc2iD6Dhy0Zlu28t9WO8+Fu3D5w7IuXXaFbtg9
         jAwQ==
X-Gm-Message-State: AOAM5329CHuetzG+9BtpP4i/+elFQMOX/YT8tv++3fkEFCntF/QXiHoF
        yxUsQCxGGhZ5eiORMxrF4uyA/p4RjBgV5dH3vIyduLW5MTc=
X-Google-Smtp-Source: ABdhPJyo0Gs4ipl5azAHxG9Ds8lnKBQXXeXpMudF96476oD1dwKXFPoNZDhn2U4E2ucj43nRAMEWmTbLGrfms2/aCmo=
X-Received: by 2002:a05:6902:1006:: with SMTP id w6mr51135657ybt.252.1638857660962;
 Mon, 06 Dec 2021 22:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-6-haoluo@google.com>
In-Reply-To: <20211206232227.3286237-6-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Dec 2021 22:14:10 -0800
Message-ID: <CAEf4BzZ6_KQjnn60pSfadgPOMv2bwme1ajDh89Ziuqogmgd-0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/9] bpf: Introduce MEM_RDONLY flag
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
>
> This patch introduce a flag MEM_RDONLY to tag a reg value
> pointing to read-only memory. It makes the following changes:
>
> 1. PTR_TO_RDWR_BUF -> PTR_TO_BUF
> 2. PTR_TO_RDONLY_BUF -> PTR_TO_BUF | MEM_RDONLY
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/bpf.h       |  8 +++--
>  kernel/bpf/btf.c          |  3 +-
>  kernel/bpf/map_iter.c     |  4 +--
>  kernel/bpf/verifier.c     | 76 +++++++++++++++++++++++----------------
>  net/core/bpf_sk_storage.c |  2 +-
>  net/core/sock_map.c       |  2 +-
>  6 files changed, 55 insertions(+), 40 deletions(-)
>

[...]

>  static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
>  {
>         return type == ARG_PTR_TO_SOCK_COMMON;
> @@ -541,8 +546,7 @@ static const char *reg_type_str(enum bpf_reg_type type)
>                 [PTR_TO_BTF_ID]         = "ptr_",
>                 [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
>                 [PTR_TO_MEM]            = "mem",
> -               [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> -               [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> +               [PTR_TO_BUF]            = "rdwr_buf",

super misleading if it's actually read-only...

>                 [PTR_TO_FUNC]           = "func",
>                 [PTR_TO_MAP_KEY]        = "map_key",
>         };

[...]
