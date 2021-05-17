Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C8383BB8
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 19:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhEQR4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 13:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236840AbhEQRz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 13:55:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A1F26108D;
        Mon, 17 May 2021 17:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621274081;
        bh=jiEeCtCrsDMF9QllnOiUbRVpV9taErAhHTbDHtEG7QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OwaMs+nU5kR1JYU5rzaty4sUIKE1xtd5O4qGk/r6SfH5ZYwdn/mDD9Klwl7ANoy9z
         RSJhuW0PN3io710gZvQ1tPSPxKCeVFKwDhq8CC4RmwjSq7a3eRuGfd/IS5t9ceUqxs
         0W5+RXf2G8ITSTaSGZY1udqbNkrjNGQ+frn20KWGiK/bWJXsYwBjGXO/8rHOERaMe1
         bNlliNAtvt43ow57pwGvwuhqanWRedtf6wu69/WenY/961j/kKRYNvVPjXUm4hjkGp
         HYPFQx1riZ7TBkDaw7b6plXvQG3SjIkeDUjTiTINDM6IqC4kBTzFpUZiyJBsa/Cf9t
         KP/GHQsObd9vg==
Received: by mail-lj1-f172.google.com with SMTP id e2so1990495ljk.4;
        Mon, 17 May 2021 10:54:41 -0700 (PDT)
X-Gm-Message-State: AOAM533kyBaqgaIRzgKQNd5+j6WzBnePQN/FaSwYVu7dnovXRCRYT/NN
        nMouGhohOTCKaYcCNt1QwHX2EG6PTB2Rw/MnbtU=
X-Google-Smtp-Source: ABdhPJxzwjY9y7VK+QK3QovMADJ8au82rWOcutY7OHv0i3qPCx0ccVe6D16Ewmt8+2WakK1+AdSOthv0yOr8AVBldNk=
X-Received: by 2002:a05:651c:39d:: with SMTP id e29mr489160ljp.97.1621274079735;
 Mon, 17 May 2021 10:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092830.1026418-1-revest@chromium.org>
In-Reply-To: <20210517092830.1026418-1-revest@chromium.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 17 May 2021 10:54:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7yDZCC+34L38HcjOXofM6_U_8tMpkgTxR3gZffCakoBQ@mail.gmail.com>
Message-ID: <CAPhsuW7yDZCC+34L38HcjOXofM6_U_8tMpkgTxR3gZffCakoBQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Clarify a bpf_bprintf_prepare macro
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>, jackmanb@google.com,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 17, 2021 at 2:29 AM Florent Revest <revest@chromium.org> wrote:
>
> The per-cpu buffers contain bprintf data rather than printf arguments.
> The macro name and comment were a bit confusing, this rewords them in a
> clearer way.
>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/bpf/helpers.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index ef658a9ea5c9..3a5ab614cbb0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -692,13 +692,14 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
>         return -EINVAL;
>  }
>
> -/* Per-cpu temp buffers which can be used by printf-like helpers for %s or %p
> +/* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
> + * arguments representation.
>   */
> -#define MAX_PRINTF_BUF_LEN     512
> +#define MAX_BPRINTF_BUF_LEN    512
>
>  /* Support executing three nested bprintf helper calls on a given CPU */
>  struct bpf_bprintf_buffers {
> -       char tmp_bufs[3][MAX_PRINTF_BUF_LEN];
> +       char tmp_bufs[3][MAX_BPRINTF_BUF_LEN];
>  };
>  static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
>  static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
> @@ -761,7 +762,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
>                 if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
>                         return -EBUSY;
>
> -               tmp_buf_end = tmp_buf + MAX_PRINTF_BUF_LEN;
> +               tmp_buf_end = tmp_buf + MAX_BPRINTF_BUF_LEN;
>                 *bin_args = (u32 *)tmp_buf;
>         }
>
> --
> 2.31.1.751.gd2f1c929bd-goog
>
