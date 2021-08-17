Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A413B3EE44D
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 04:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhHQCXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 22:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbhHQCXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 22:23:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167AAC061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 19:23:16 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c5so23544699ybn.5
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CvsCzt/eTDP4q1PQIvs9XjunIdMo8sqTqmX4yJetl0=;
        b=a0eejU24s9rgdmhTlkOc4kOuCAh7W9fc3ja8rrRSyYteR6G2Glzpr7po6aRslNJM+K
         6UTeQOJrAnrlK5jkHhfbC6w8jd3OtfdZ6ekP+a29cDudyOiOBQb+E56EhcqknKEiFjNO
         aSO/TABFm277v2WpksBGCyKF3PX1Eo/R+rrVdL82LsaZmzjqzcjV1UUxaOdMMMiw7OFb
         Z3M/UECmuqGw/ld51EOZDHn6ROX1fe34nrEleo5KyHFBJYepXtigVr1I36TIPoVGXwW6
         kSi94VHeoGgcRFA3ZncAq8fqtp4Hoq17cOuZDCb0N9pQ8dxe6x4vHOG9HtB531hV5AOz
         FiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CvsCzt/eTDP4q1PQIvs9XjunIdMo8sqTqmX4yJetl0=;
        b=m1G8QM+LpNGNb5IVCrNds6dQ2jY3ooXE3ezhe12UMLQI62IV5s9xlJrGpI/2IfbPit
         fVO1t29XrxheJg4Wrg55A4uU5vxIXua6lJtRkKZcPLjcMt2EbnwGxXd9/ZzZMGgLMqLW
         jQLo2Qt2ZNqXGlaxsM5s3hG428qRg73y7IT3ywZkaQ+Q0KhR4/6cy9QurFKgiI/uFj6/
         suG74Lwnl1ROCyFEdDtSZDdl4N2T9iCdHmmqJBvyB/RUciR10o5XzsZs9GCvi+XGKqD9
         y25dMEOngw7TdJPJTQjJL+ke35sO2qlwVKv7t9JVOQKtADy/Gm8m1km1RwaR26yVbJxy
         LMYA==
X-Gm-Message-State: AOAM530JWpN2CR98ITM9lAweNPa+Cw9sHes1SzZDYBKptmOe10Dp0AVm
        E7t205xC1WT5fa8f5rtArp8AncHhxpD2LhSwAO8=
X-Google-Smtp-Source: ABdhPJz2RPXCRyjhmY5M9o0jnRdTf7zYOfImd+AueHvpQ7hLo2NuqmBuRhm6xQCTvnMvGkfJJVxnO6KJvo8hDCuS5gg=
X-Received: by 2002:a5b:648:: with SMTP id o8mr1516682ybq.260.1629166996083;
 Mon, 16 Aug 2021 19:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210816231716.3824813-1-prankgup@fb.com> <20210816231716.3824813-2-prankgup@fb.com>
In-Reply-To: <20210816231716.3824813-2-prankgup@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 Aug 2021 19:23:05 -0700
Message-ID: <CAEf4BzacXvT5tsVe-xYSOYrxrf8B_02jG=Hv67SXhC-8rWcxrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add support for {set|get} socket
 options from setsockopt BPF
To:     Prankur gupta <prankgup@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, prankur.07@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 4:17 PM Prankur gupta <prankgup@fb.com> wrote:
>
> Add logic to call bpf_setsockopt and bpf_getsockopt from
> setsockopt BPF programs.
> Example use case, when the user sets the IPV6_TCLASS socket option
> we would also like to change the tcp-cc for that socket.
> We don't have any use case for calling bpf_setsockopt from
> supposedly read-only sys_getsockopti, so it is made available to
> BPF_CGROUP_SETSOCKOPT only.
>
> Signed-off-by: Prankur gupta <prankgup@fb.com>
> ---
>  kernel/bpf/cgroup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index a1dedba4c174..9c92eff9af95 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1873,6 +1873,14 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_sk_storage_get_proto;
>         case BPF_FUNC_sk_storage_delete:
>                 return &bpf_sk_storage_delete_proto;
> +       case BPF_FUNC_setsockopt:
> +               if (prog->expected_attach_type == BPF_CGROUP_SETSOCKOPT)
> +                       return &bpf_sk_setsockopt_proto;
> +               return NULL;
> +       case BPF_FUNC_getsockopt:
> +               if (prog->expected_attach_type == BPF_CGROUP_SETSOCKOPT)
> +                       return &bpf_sk_getsockopt_proto;

Is there any problem enabling bpf_getsockopt() for
BPF_CGROUP_GETSOCKOPT program type?

> +               return NULL;
>  #endif
>  #ifdef CONFIG_INET
>         case BPF_FUNC_tcp_sock:
> --
> 2.30.2
>
