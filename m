Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07778852E0
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfHGSUE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 14:20:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45995 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbfHGSUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 14:20:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id a30so1682474lfk.12
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LlA7Bhfd8lOeCVreLVe1AOVGZgVPyE+1LLTHiDxxwE=;
        b=THwxkpU05f6ByIl9jSOahvj0vxaL18svz2TehTBLYIVL4x48zfpyBjXR1v7wlt4LS2
         wZgwPhjr+O8iSZjIATr85pBj9Dkssn42c3PMAUqapMvCLVfbIiP5vSYVItBMN4qt1VaG
         NL+/tBbfEGjmD+ElTDfCssnmC3rKhA5Vi37bmX+ye0hp4oqj+pM/zX75txRca/+AEO5A
         b1PiFvj1/nehfbp5r7y2gxybZWRuhZhF7o2IDl4yDb7vJdT5tq0yZpvB95DihjMMUVCr
         8DAvnYuJo/GOy3b9ai3hg+j1egkgSkkM/4BBjf31cYbEWjLG2hksJcMZmLWvPSTOVfCl
         15UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LlA7Bhfd8lOeCVreLVe1AOVGZgVPyE+1LLTHiDxxwE=;
        b=cHl4G2KhQmA2B5kODaL2kgvp3HDK08pd0KD1hYulDJVxVg5dQTrVKwuh+yz3UPDUGN
         BrT1NTI589Dmjyl2l4uJXs0m9SrBvsm6wY5KSgi5ZnW22PD6Vbj5F+mbJt5CiEqIP1WP
         Le3EHBYTFGMfnta2gTOTI/vlFJoRaPmhetZhiAkY3W8ri5PXwqnIYu30Joj6WXPFoI8+
         wdDsOuFbK5w0xzE0MN/w7ZEzyk6wKDUDIBP5M7Zafa4lMY0lrSl5T6UU/8pifoFGPLQB
         tIzkYcUA5h4N2YYZ/kqMmJOKuoQ5s17k5chUiBTlVzHBj7TPE7ZjLdOytq4Bb1NvNnRh
         CigA==
X-Gm-Message-State: APjAAAVwJpha/eYVBnvApUo+pGMc7TNshwvsQybafAbTn+lzH6+8QMVB
        af0ZiM6U+54c3KYRMreLxAeOlIYLqmkUXCEcY1s=
X-Google-Smtp-Source: APXvYqznBFmdPIKYNDldD/AI5hlteOqRVkYdDNiYsLsBzVVYFhDy0TXDRGAHoVT5xB5sHUr6eYdIROI2B2X4NOzLqPs=
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr6785898lfn.20.1565202002112;
 Wed, 07 Aug 2019 11:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190806234201.6296-1-dxu@dxuuu.xyz>
In-Reply-To: <20190806234201.6296-1-dxu@dxuuu.xyz>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 7 Aug 2019 11:19:51 -0700
Message-ID: <CAPhsuW4wHQ0XhtzeRXamBjTPpuA-ejUwmqSkhSk6sM58MTXPMw@mail.gmail.com>
Subject: Re: [PATCH 2/3] libbpf: Add helper to extract perf fd from bpf_link
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 6, 2019 at 4:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It is sometimes necessary to perform ioctl's on the underlying perf fd.
> There is not currently a way to extract the fd given a bpf_link, so add a
> helper for it.

Missing "Signed-off-by" tag. Please run scripts/checkpatch.pl on the patches.

Otherwise, looks good to me.

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/lib/bpf/libbpf.c   | 13 +++++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  5 +++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ead915aec349..8469d69448ae 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4004,6 +4004,19 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
>         return err;
>  }
>
> +int bpf_link__get_perf_fd(struct bpf_link *link)
> +{
> +       struct bpf_link_fd *l = (void *)link;
> +
> +       if (!link)
> +               return -1;
> +
> +       if (link->destroy != &bpf_link__destroy_perf_event)
> +               return -1;
> +
> +       return l->fd;
> +}
> +
>  struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
>                                                 int pfd)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8a9d462a6f6d..5391ac95e4fa 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -168,6 +168,7 @@ LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
>  struct bpf_link;
>
>  LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
> +LIBBPF_API int bpf_link__get_perf_fd(struct bpf_link *link);
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_perf_event(struct bpf_program *prog, int pfd);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f9d316e873d8..0f844ce29b04 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -184,3 +184,8 @@ LIBBPF_0.0.4 {
>                 perf_buffer__new_raw;
>                 perf_buffer__poll;
>  } LIBBPF_0.0.3;
> +
> +LIBBPF_0.0.5 {
> +       global:
> +               bpf_link__get_perf_fd;
> +} LIBBPF_0.0.4;
> --
> 2.20.1
>
