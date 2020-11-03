Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D292A501C
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 20:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgKCT2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 14:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgKCT2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 14:28:13 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DBC0613D1;
        Tue,  3 Nov 2020 11:28:13 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id h196so15862193ybg.4;
        Tue, 03 Nov 2020 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=086QXPQOFmQa0/qNNMQMF6FnV1pJVActXTh078XtSYc=;
        b=p3LFK3c3EHixzrX4mi7n6oPv+ZpesKIo7xuKoHcCiotv7JoEIM41cEMwWam6g2FeWF
         xadndj/3JZ/H+GK+iIrOtl/gtUyESLr2lQkgJOGt3vYg0wR/aL/peh49K6O8RbDcC3Zl
         EoaTjVEbZF7GGVeeRQm5ALl1b1caWaKBQM8EfDXi04E2zLGzy16/Cx7ROIm4RhE1+Tv7
         p9M1YSIPkoMH8Yn5r5H2I9KOfaYoljvaatBGOHEJARaYb9Hw3zfOFmnvF+WJ/z2/kBLZ
         g2PylIY5JUB8SD6YxZuC0hadhgLf/cRZwZcyDRoiUbeQP3qA3w7YjlpjtDwHihh5GzmT
         VXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=086QXPQOFmQa0/qNNMQMF6FnV1pJVActXTh078XtSYc=;
        b=s5WgEef3Cp6LFPKEO66OrjGoQyCTTOJTfaTEMwkIkozL+nJFNYoy9vf4mz/y1XF+cc
         QTHwPS/zq+ZRTMNpTydprgZV45iLrkvRizU7u5gsRvBtEKgBeQRyzAbreSoUKBqMKbiR
         pjZJw3U5wJvj2JYZrGHj60kwVw4B++btlUxfR/LwlDFlTwbzW8Efe+cwXQ2MDuE+4C2p
         +WV2q7WHS4zbCCXRaeke1L9TRLqj8hii5SvDQNZ1lxq5ZSZw5EWahApuGFjAC53Osum9
         g8sTNLGd30IlmIm5xZG8zXVye0q/PvSR+NBoLq3ZeJwssvVRbvQ8vV1YQ6XxidXYAyDa
         E5sw==
X-Gm-Message-State: AOAM530HB/c0rRZJoeGO3BIEPPQdkMo43pKMtLbVBbskd4xtabg5qQ6n
        NNZvJPHbe8ogkSUUANcNbqTT4wouvuGxpS00BexZ4dvw+Vk=
X-Google-Smtp-Source: ABdhPJyRTxVYFvH+vCHhvE92SRpLSfLl8VAUYb6s2IyLJxS5DZNcR4smEyOo1rR106jfLpou5Z8wIScaTzq10cmmU/0=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr31418948ybl.347.1604431692776;
 Tue, 03 Nov 2020 11:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org> <20201103153132.2717326-3-kpsingh@chromium.org>
In-Reply-To: <20201103153132.2717326-3-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Nov 2020 11:28:01 -0800
Message-ID: <CAEf4Bza=80OMCBMLJJa5Vu1qokwzCtePcu4arruXUi8jHK8eWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/8] libbpf: Add support for task local storage
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 7:34 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/lib/bpf/libbpf_probes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index 5482a9b7ae2d..bed00ca194f0 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  /* Copyright (c) 2019 Netronome Systems, Inc. */
>
> +#include "linux/bpf.h"

why "", not <>?

>  #include <errno.h>
>  #include <fcntl.h>
>  #include <string.h>
> @@ -230,6 +231,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
>                 break;
>         case BPF_MAP_TYPE_SK_STORAGE:
>         case BPF_MAP_TYPE_INODE_STORAGE:
> +       case BPF_MAP_TYPE_TASK_STORAGE:
>                 btf_key_type_id = 1;
>                 btf_value_type_id = 3;
>                 value_size = 8;
> --
> 2.29.1.341.ge80a0c044ae-goog
>
