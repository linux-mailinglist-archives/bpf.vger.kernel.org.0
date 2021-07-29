Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09CA3DAFBE
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 01:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhG2XQy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 19:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhG2XQy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 19:16:54 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9223EC061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 16:16:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k65so12755099yba.13
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iK2mtNwJ1bl7v708B7Woz6KhhwQcnLkGu8atb7KCvrU=;
        b=ZQ7zic2NT1jZgNbDxfCa/7APNXQ3YOl9vL0ilD98bvISrsxaIC6NUfj/Rm78c6Zkvb
         /EGvJZbj7vN6Z8LLs+e22UuTTMQZ5sZyP6YfLo3b3OlYCyoVA1biz1baMGX0iOSlGwOh
         XEjTTWg0btuNqTOzk2PYS//NWBDKRD/6FmoAZBPeoWCbDBJu659U8p0XsX5/+JQc+sfH
         oOON2gxvBY0d0fyMiEY22Vewhpuenrc+GETl0Hlix31kC3uafoFVcs59nsb1u7BqozFC
         mROnEXf9sDMI1keGgvuzmaJUUuB4qXwar8lzuFR9WHf1TftWS9pLjvGZlQY+LFKvO+ew
         D7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iK2mtNwJ1bl7v708B7Woz6KhhwQcnLkGu8atb7KCvrU=;
        b=i+iDLYYZEyMvLK2qyFFBaLTdzzuqiq/FsgyZwxhJdW3GbxtPguaYHAHG2r7l2nf4Mj
         KlbhN9PR8aBK+1m0McE37UBJvLRJrQXB4pXfAC2g7Vy4XMVTed53Hog/4OO2EYspk9eC
         +2Lm8j3M+4M9TQUwnODU3D2fKC4rLZD0MGO8B9g64PqnesHUPI4XcUh8F4FStVm5lFZn
         bcnTHu6HN1nUaQZ+sTrJNN4E4ADaZzPx17TZLn+7x91unZH80g1XYPReW/rlDRAOvtUi
         HvvsfvYEVJh/9MTbD6HsuiHVy92hiRW9hiqoxBewsqfYmMD80juzlZxhtcO20cgMOZ4R
         baLQ==
X-Gm-Message-State: AOAM532S7oHIFlUBM86WTlVu2XWogqm2MLyj8q2wlF/8be5QWXCwLm4Z
        L99cfoPohxxbPnCbh2myFbw/8qSI220hsY5JLZkFy8T7WTk=
X-Google-Smtp-Source: ABdhPJyKJt7LJzSMAPwy/m1ma0XqwrgV/cwOi+uFNcAahw6014lzZRtt6ZfFuTEJZb5wdC29cIKfAysHIv/1Nr0UPXQ=
X-Received: by 2002:a25:1455:: with SMTP id 82mr9660417ybu.403.1627600608879;
 Thu, 29 Jul 2021 16:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <5969bb991adedb03c6ae93e051fd2a00d293cf25.1627513670.git.dxu@dxuuu.xyz>
In-Reply-To: <5969bb991adedb03c6ae93e051fd2a00d293cf25.1627513670.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 16:16:37 -0700
Message-ID: <CAEf4BzYU5Wq699DY8d8CLYy_YvLUkNCtzyAw9KTUyJdza_vg_w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Do not close un-owned FD 0 on errors
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 28, 2021 at 4:09 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Before this patch, btf_new() was liable to close an arbitrary FD 0 if
> BTF parsing failed. This was because:
>
> * btf->fd was initialized to 0 through the calloc()
> * btf__free() (in the `done` label) closed any FDs >= 0
> * btf->fd is left at 0 if parsing fails
>
> This issue was discovered on a system using libbpf v0.3 (without
> BTF_KIND_FLOAT support) but with a kernel that had BTF_KIND_FLOAT types
> in BTF. Thus, parsing fails.
>
> While this patch technically doesn't fix any issues b/c upstream libbpf
> has BTF_KIND_FLOAT support, it'll help prevent issues in the future if
> more BTF types are added. It also allow the fix to be backported to
> older libbpf's.
>
> Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Thanks! Applied to bpf. We should bite a bullet and make sure that
libbpf itself never uses/allows FD 0 internally (by, say, dup()'ing FD
0, if we happen to get it) and get rid of the -1 special initializers.

>  tools/lib/bpf/btf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b46760b93bb4..7ff3d5ce44f9 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -804,6 +804,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
>         btf->nr_types = 0;
>         btf->start_id = 1;
>         btf->start_str_off = 0;
> +       btf->fd = -1;
>
>         if (base_btf) {
>                 btf->base_btf = base_btf;
> @@ -832,8 +833,6 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
>         if (err)
>                 goto done;
>
> -       btf->fd = -1;
> -
>  done:
>         if (err) {
>                 btf__free(btf);
> --
> 2.31.1
>
