Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A2A383BC0
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 19:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbhEQR4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 13:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236507AbhEQR4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 13:56:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C1DA6109E;
        Mon, 17 May 2021 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621274101;
        bh=kfgD+1roEe0cmIsLzeegpXQgTxQShJuGp7ZDdjEeAZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K4P1fxSMaFXuF3BG524N0wpVmNDV9bvMEIK9INz/KALIsX3gUNHoDufVz2MH8JyQR
         6sLvRMuE2iPxnhVRJmUySyAkiURYZnnJ1mOjClItf+QeZIk8OhES2xpG6uUej4KtNI
         qTIrkTfzGqj76fXBvTqASWKxTjsfZotxItHctLivZbaN4e39PtY8LxC0CS7I8TnbL4
         2PKVIjo4xsWCjusnowQ2/WpPcoH/qtUHXDlh6FrRdFvgW7oeVnEOEmC3TngnqBU6Y6
         HSaQdFOwLIi83b9DmSXsRTSg9ZxX7CGdGp4dnvug89n6FQClh4quyk2iSeNBeNSyDW
         aETHv1paBEOKA==
Received: by mail-lj1-f175.google.com with SMTP id o8so8367004ljp.0;
        Mon, 17 May 2021 10:55:01 -0700 (PDT)
X-Gm-Message-State: AOAM531uKgpJpfz9Es3WT8ZY8ACLhshySLBrDOs7s3Lkk9rKNAp7TZ6p
        sAKMZ5Py+FwmtmGtPv+EGkszyGC6M1dYPBsaQLY=
X-Google-Smtp-Source: ABdhPJw/JqBZfYknMEKki4Mts6TOOJGqZQH2R858CNegDFI7OlOVz+QiiiJvsgpM0U5osZ7MbKHRTCiM3MsD4p94Bm4=
X-Received: by 2002:a2e:7119:: with SMTP id m25mr462521ljc.177.1621274100008;
 Mon, 17 May 2021 10:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092830.1026418-1-revest@chromium.org> <20210517092830.1026418-2-revest@chromium.org>
In-Reply-To: <20210517092830.1026418-2-revest@chromium.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 17 May 2021 10:54:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4dk71WPyFgoQdLJj-0h3994jRC750F=M4WJS7cDAUtEw@mail.gmail.com>
Message-ID: <CAPhsuW4dk71WPyFgoQdLJj-0h3994jRC750F=M4WJS7cDAUtEw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] bpf: Avoid using ARRAY_SIZE on an uninitialized pointer
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>, jackmanb@google.com,
        open list <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 17, 2021 at 2:29 AM Florent Revest <revest@chromium.org> wrote:
>
> The cppcheck static code analysis reported the following error:
> >> helpers.c:713:43: warning: Uninitialized variable: bufs [uninitvar]
>     if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bufs->tmp_bufs))) {
>                                              ^
>
> ARRAY_SIZE is a macro that expands to sizeofs, so bufs is not actually
> dereferenced at runtime, and the code is actually safe. But to keep
> things tidy, this patch removes the need for a call to ARRAY_SIZE by
> extracting the size of the array into a macro. Cppcheck should no longer
> be confused and the code ends up being a bit cleaner.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/bpf/helpers.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 3a5ab614cbb0..73443498d88f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -698,8 +698,9 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
>  #define MAX_BPRINTF_BUF_LEN    512
>
>  /* Support executing three nested bprintf helper calls on a given CPU */
> +#define MAX_BPRINTF_NEST_LEVEL 3
>  struct bpf_bprintf_buffers {
> -       char tmp_bufs[3][MAX_BPRINTF_BUF_LEN];
> +       char tmp_bufs[MAX_BPRINTF_NEST_LEVEL][MAX_BPRINTF_BUF_LEN];
>  };
>  static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
>  static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
> @@ -711,7 +712,7 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
>
>         preempt_disable();
>         nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
> -       if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bufs->tmp_bufs))) {
> +       if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>                 this_cpu_dec(bpf_bprintf_nest_level);
>                 preempt_enable();
>                 return -EBUSY;
> --
> 2.31.1.751.gd2f1c929bd-goog
>
