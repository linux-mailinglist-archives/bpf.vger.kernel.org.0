Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1523E529
	for <lists+bpf@lfdr.de>; Fri,  7 Aug 2020 02:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgHGAcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Aug 2020 20:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHGAcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Aug 2020 20:32:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04BC061574
        for <bpf@vger.kernel.org>; Thu,  6 Aug 2020 17:32:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so96334wra.5
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2020 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hToE6KcyuWM+662KE+/RTcRe3ZU1Jp6Exk5eY0or3rg=;
        b=HARCf8EgY43LFRhwHsR6GPpScvmW2JkPlYWIfBcqGF68//9+T5o/bTBvumodSOpCdn
         RWR3x44Ta5GJ4zDhdOHT6jp1RwUGfox8aXa9vz10xAVvsvQVhX6Akbd0wGpwMDWlIzPF
         FhQy2iANTN63MRK97dlj1LLo/a1LlDX3cH48E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hToE6KcyuWM+662KE+/RTcRe3ZU1Jp6Exk5eY0or3rg=;
        b=ZofMrsqIXzsy7C+wSVyl7s8/2gmzb+nBSSUx3ovKQ+Fq24/cPbjwNiRtgpoaXCSJ3x
         1D+NPzPbyP7KCdKVQ1Stq8F0Q6p5s/j98sZfZgHbCi/kBHm7H9/+5jjXnAQoI8PtgnyH
         u37uM1ySb18j8ZGRapLBwLO+tV9b84dTn8a9yM5kFVk0+clpj1RhkaePTWlXmJb6ENmQ
         SZyuxTUAGCUFvz7drPsKALQ/KAZ/wqrtlXhQgvIGYl4gmqH0xD2P4hI5dZ8XIrOJswfO
         7MjEC13h6eheTT+hmOFgySt+Vc7+HyB4MSAPJO5CAclEXWEorvvOPNbwb/kv9ag6+hDm
         A4SQ==
X-Gm-Message-State: AOAM531ICUm0AWNd5FIubbpQUv05wIKjl3bhLmX4krnN57FwjNjppJ+J
        f+OGOct9jYkNAqEJ39F02uYx3IwXjaIKRtfkh3nnmQ==
X-Google-Smtp-Source: ABdhPJxWiAL4g/PAklK/iNNIXWYNdvyyy5CxQbu9ymTtRdus9OhEcqe3D3c1iWwX5gfRRAVLwyJAVZzrQm4X20zKwKM=
X-Received: by 2002:adf:fdce:: with SMTP id i14mr9414192wrs.273.1596760323139;
 Thu, 06 Aug 2020 17:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200801170322.75218-1-jolsa@kernel.org> <20200801170322.75218-11-jolsa@kernel.org>
In-Reply-To: <20200801170322.75218-11-jolsa@kernel.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 7 Aug 2020 02:31:52 +0200
Message-ID: <CACYkzJ57H391Xe20iGyHPkLWDumAcMuRu_oqV0ZzBPUOZBqNvA@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 10/14] bpf: Add d_path helper
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 1, 2020 at 7:04 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding d_path helper function that returns full path for

[...]

> +}
> +
> +BTF_SET_START(btf_allowlist_d_path)
> +BTF_ID(func, vfs_truncate)
> +BTF_ID(func, vfs_fallocate)
> +BTF_ID(func, dentry_open)
> +BTF_ID(func, vfs_getattr)
> +BTF_ID(func, filp_close)
> +BTF_SET_END(btf_allowlist_d_path)
> +

> +static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> +{
> +       return btf_id_set_contains(&btf_allowlist_d_path, prog->aux->attach_btf_id);
> +}

Can we allow it for LSM programs too?

- KP

> +
> +BTF_ID_LIST(bpf_d_path_btf_ids)
> +BTF_ID(struct, path)
> +

[...]

>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> --
> 2.25.4
>
