Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A204485C47
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 00:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbiAEXav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 18:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245409AbiAEXas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 18:30:48 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F5C061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 15:30:48 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id x15so757245ilc.5
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 15:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxm7dLqbdNgrYkxjVr/JmItl1bkQXyyZTqu2n4Uzhck=;
        b=ZJ3WPNOSJaH+l1cnyd9CHRiZAI8jMEm9vU+KYuY3fQrXR8yCG+3SfDTH8vaVhLuwSd
         TuK7Y+HJU+gG64crfc0axZZg3+r0dGyJVYNDsjF6slJ5wv7MsiGzm6xc9evniG15rc3p
         DtXr6tN21U4XN9ljW+WqtHkcmNOkSLpp4ytmTY5mFBxpZ4ei0y1TKdIzlubUg7AZpX9J
         RQMCsMbCDd9/Gm3fGsY5tKZPlFUja3lN+9OTUQ9bjhuq+0L2SKz6d13qSXxOyW+EDtPm
         i6Gig+Cem4J1wKtR+pwcs3z+sx0YPBloUWsIQm9JJKkUEJVt+kIF6lTJitmmsmdTSiV7
         VAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxm7dLqbdNgrYkxjVr/JmItl1bkQXyyZTqu2n4Uzhck=;
        b=zn0GD0rIZI2Pt9YcLYDkGyc2F4P/8tUUpifb0AbDg0wijLT44iWhdqzqS+yHJoGRIe
         o8r5C1NvlSZvr4RNS9BENhr1c0FyJl+G0J27kTDn0EWKDTJh8q705jo+bEiLBV8EKwwp
         8iaqstBhJIAGyLDpvdUlYpgtDgnxbW9JA/tASqiogMk1eviNy5tUjy4gruMJSTj7YMGU
         5hPbzmEU2rEiyO5yTQjgr4uJ75U9UKeX+cBDqiKqkSCODxCzPVJzoS/b6y+rx6rxyDA3
         +h79nFg69aLB+MTaxXkffsJw0U6R6AMON0BWQ+ioA9289/GT9LHIwB4/2+eLZu8GvIJr
         evNw==
X-Gm-Message-State: AOAM531gVq15zg4BX5bRmWOw0X1bGrninir7vq1p4gW99mhIykYGf7Db
        9SWiEq9ugYu0OIQRTlmDraQNxVfMhK/+o9B6CyA=
X-Google-Smtp-Source: ABdhPJxsaZE5WZKp0Icryycupu3e7WujX2TKjJ94N7i/kHmhSG/Y4irzpjm8nGS0Fyf9x1X1DL95OfY9l1S+6m1IBWk=
X-Received: by 2002:a05:6e02:b4c:: with SMTP id f12mr25128827ilu.252.1641425447453;
 Wed, 05 Jan 2022 15:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20211229204156.13569-1-christylee@fb.com>
In-Reply-To: <20211229204156.13569-1-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 15:30:36 -0800
Message-ID: <CAEf4BzYHcV-Wz8UT37f63bVZK0xFhVMPKUWsLJmzvqn59WFS0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: deprecate bpf_perf_event_read_simple() API
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

On Wed, Dec 29, 2021 at 12:42 PM Christy Lee <christylee@fb.com> wrote:
>
> With perf_buffer__poll() and perf_buffer__consume() APIs available,
> there is no reason to expose bpf_perf_event_read_simple() API to
> users. If users need custom perf buffer, they could re-implement
> the function.
>
> Mark bpf_perf_event_read_simple() and move the logic to a new
> static function so it can still be called by other functions in the
> same file.
>
> [0] Closes: https://github.com/libbpf/libbpf/issues/310

nit: we usually have two spaces before such referenced, I've fixed it
up while applying

>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 15 ++++++++++++---
>  tools/lib/bpf/libbpf.h |  1 +
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9cb99d1e2385..8a8020985db1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10676,8 +10676,8 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>         return link;
>  }
>
> -enum bpf_perf_event_ret
> -bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
> +static enum bpf_perf_event_ret
> +perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
>                            void **copy_mem, size_t *copy_size,
>                            bpf_perf_event_print_t fn, void *private_data)

please also adjust indentation for wrapped arguments. I did it this
time while applying, but please keep that in mind for the future.

>  {
> @@ -10724,6 +10724,15 @@ bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
>         return libbpf_err(ret);
>  }
>
> +enum bpf_perf_event_ret
> +bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
> +                          void **copy_mem, size_t *copy_size,
> +                          bpf_perf_event_print_t fn, void *private_data)
> +{
> +       return perf_event_read_simple(mmap_mem, mmap_size, page_size, copy_mem,
> +                                     copy_size, fn, private_data);
> +}
> +

here you could have just created an alias instead of passing the
function through. I've changed to an alias when applying.


>  struct perf_buffer;
>
>  struct perf_buffer_params {
> @@ -11132,7 +11141,7 @@ static int perf_buffer__process_records(struct perf_buffer *pb,
>  {
>         enum bpf_perf_event_ret ret;
>
> -       ret = bpf_perf_event_read_simple(cpu_buf->base, pb->mmap_size,
> +       ret = perf_event_read_simple(cpu_buf->base, pb->mmap_size,
>                                          pb->page_size, &cpu_buf->buf,
>                                          &cpu_buf->buf_size,
>                                          perf_buffer__process_record, cpu_buf);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 85dfef88b3d2..ddf1cc9e7803 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1026,6 +1026,7 @@ LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_i
>  typedef enum bpf_perf_event_ret
>         (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>                                   void *private_data);
> +LIBBPF_DEPRECATED_SINCE(0, 8, "use perf_buffer__poll() or  perf_buffer__consume() instead")
>  LIBBPF_API enum bpf_perf_event_ret
>  bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
>                            void **copy_mem, size_t *copy_size,
> --
> 2.30.2
>
