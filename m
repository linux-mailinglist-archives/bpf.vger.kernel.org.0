Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A62485CBF
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 01:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245674AbiAFABm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 19:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbiAFABk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 19:01:40 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCBEC061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 16:01:39 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id o7so1082182ioo.9
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 16:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tsBpPh92soPgIDEG+Lp/LfMHgaYOY7UbA3lPU+blps=;
        b=LSpUK3E+VjE8/WKZSudEnotlW1Vr8z2xOVbNlhgVmsIV+Q85+/GCjo860hDnekhJgB
         HPmnOqr4V0pg9CXdo8dF+k9f8f43dUyHimyaQy1n4XtWfiN37Q6sQCPRvHVQ2eA2ZJzW
         aWfwf3CyKKA/2gFqFfB07HaKZSKrjrBgObDjQir4N36K2TNqkuCHOmGoxuKDvVHFnT0S
         nPMk5v6hTsU6YKf2bW7P8Z7kosvMdAegI5lV3GMRmXAM8MBfXTcHbVWGtv4umAit1x2o
         WsrgHZGe18SOx707dIYp8UvecUYkvERpfRZvYmJ7ycwNsDKGZu71wNKRHP8wqucs9B5P
         0YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tsBpPh92soPgIDEG+Lp/LfMHgaYOY7UbA3lPU+blps=;
        b=A4PzK7SC8es+mlJvI2Jsn5MZ1xG8VfKaafQi6JEtB7DSAP7+PGHLCMhRQ1wZBFcNOa
         DA5m1KqHQoKb/pINiggtcmjeJvWIQJq9ScR9gRb08irf0MoMu2ox0h/pC4/31smF5XoZ
         D1ZfxcNzt0I10goT5/YHoFY9JPThnhsrJ1xCebnu39L6W/dB1tkih6d5lGA6+ymDg+PO
         Jmb4MRRQUrk7WL+eg9nTHiZzZB3+rkrp43EYsVGH7kmUC0qJRn6FSz+ps1bk2Z2zaSfL
         zU/0vGWqWWh0Ft4ng9omMeFwiKaXAM1qiYzyBt+2GiqxzhTCilLmYinK7kPIhrrOZDO8
         Zmhg==
X-Gm-Message-State: AOAM531r9Lo/pWfLMVQacxWCRsLI5od1ovBoMeXXlAXxQ0xXMjLv8kk5
        gIF+T0FVREc+cU9SJ8PXitkYuNbEFLi+kSlOYb/b72Vr
X-Google-Smtp-Source: ABdhPJwan0dVdDvbRIJTKV9mjfE/O3po7GN2vm75lwi3Upu4/T1agQoU2ChdlkgxGh454PP//Aj3bXbTi6Sa9yd1+g8=
X-Received: by 2002:a02:c72e:: with SMTP id h14mr27566726jao.103.1641427298919;
 Wed, 05 Jan 2022 16:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20211230204008.3136565-1-christylee@fb.com> <20211230204008.3136565-4-christylee@fb.com>
In-Reply-To: <20211230204008.3136565-4-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 16:01:27 -0800
Message-ID: <CAEf4BzYbifPCrKVA+5qcf6jTOsDBtmxNOG4SXHYay7WiZCaS0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: deprecate bpf_object__open_xattr() API
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 30, 2021 at 12:40 PM Christy Lee <christylee@fb.com> wrote:
>
> Deprecate bpf_object__open_xattr() in favor of
> bpf_object__open_mem() instead.
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  tools/lib/bpf/libbpf.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9cb99d1e2385..25b571a297f8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9443,7 +9443,7 @@ static int bpf_prog_load_xattr2(const struct bpf_prog_load_attr *attr,
>         open_attr.file = attr->file;
>         open_attr.prog_type = attr->prog_type;
>
> -       obj = bpf_object__open_xattr(&open_attr);
> +       obj = libbpf_ptr(__bpf_object__open_xattr(&open_attr, 0));

there is no need to use libbpf_ptr() here, it's used for proper
handling of error returning from public API functions. Here you don't
yet return an error (it will happen with libbpf_err() few lines
below).

>         err = libbpf_get_error(obj);
>         if (err)
>                 return libbpf_err(-ENOENT);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 063639a109aa..aa507a330b61 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -185,6 +185,7 @@ LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_mem() instead")
>  LIBBPF_API struct bpf_object *
>  bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
>                         const char *name);
> +LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_mem() instead")
>  LIBBPF_API struct bpf_object *
>  bpf_object__open_xattr(struct bpf_object_open_attr *attr);
>
> --
> 2.30.2
>
