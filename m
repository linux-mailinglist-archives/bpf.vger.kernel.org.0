Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF337B080
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 23:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKVIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 17:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEKVIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 17:08:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC35C061574;
        Tue, 11 May 2021 14:07:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i9so24080832lfe.13;
        Tue, 11 May 2021 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxkCjpyVTgAvYrFtnrZrEueuxhsHKne885eSCkZ9jts=;
        b=At5yBczqo8f9k+X/AaeWpNzVia95KOdYlw3S2nIBmrJrmUFE+ExVwCMMHMxwlVC9h5
         jMOmFVvSY6G5bdAk8OC+Krk1ciP+5s+w4x5s9R4m7mhxHS1wQ6K/VP9vCedM/6dMoBd+
         GqeApr1rJ2tHJIuAJCrbSeNgGeK4s0qsMnzZKEevXmBBqAPO0drgwmsLk5ItxQ+H7iEQ
         EXjQ/YnQzJLhlQwiHOnNeM2uah9QZyeB4OlLegEIo5rP1/vqNPlZUSMRHWU0Rly6rfoK
         OOL6TA27ayR+BjxivLhYy0svr2xPW3vqonNDBNS0KuaKZyssR1a/cHN5t5lC4HX/Ct6J
         Rhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxkCjpyVTgAvYrFtnrZrEueuxhsHKne885eSCkZ9jts=;
        b=f5hO2gSUM8vQ4q9GbTsI8xU+SvQ4hGfdJMaeH0PhAEpnj0BSXZ6HNzWLWqtpuOmNcC
         RD9Apwziz1JGy2Ur6kWS5EnWXNm+R+9i6cJUzfNUEyL87I0gPjRHgLtYgFpMsrv45NwK
         KQm30mk7b06yk0rHcJJELa09IMkiptrHskTGQy2LvbWpZqUZyqA6HZ2XD2YbNrXuxWLz
         s9j3TnH5JA3RWaBLZqLHEHX9cb0ZBJmUg+QSId3Nizht4F815AEdpzUoTXpCsLn/z4aX
         0147kpsI3gvVq+spLVNvLTkdJYKZ5AAn1URzsnXByzWd+kEa5PcYFvok9uEyLxFSqpyd
         r4EA==
X-Gm-Message-State: AOAM530sCh9gMLBa4VpHe9BrDb2aM5uT/xSgmVZkJ6F3ADlf+IPJPMsP
        MwL5V7/hfzijbyNHSp8YkaUBUrrxPZEbGR7A5jc=
X-Google-Smtp-Source: ABdhPJzn602oVRfm9+oMv9sUiaslUHsTAnEEoDBmCvqlhSv4t2eIY934073yVXcbciePrir/wRIFwwOAVk9AziwTLwc=
X-Received: by 2002:ac2:5b1a:: with SMTP id v26mr22697382lfn.534.1620767250846;
 Tue, 11 May 2021 14:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210511081054.2125874-1-revest@chromium.org>
In-Reply-To: <20210511081054.2125874-1-revest@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 11 May 2021 14:07:19 -0700
Message-ID: <CAADnVQKq+b7uJb0J32swWEZmoDfdrUfx=f8ndSM4vicTCtYebA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix nested bpf_bprintf_prepare with more
 per-cpu buffers
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 11, 2021 at 1:12 AM Florent Revest <revest@chromium.org> wrote:
>
> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> per-cpu buffer that they use to store temporary data (arguments to
> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> by the end of their scope with bpf_bprintf_cleanup.
>
> If one of these helpers gets called within the scope of one of these
> helpers, for example: a first bpf program gets called, uses
> bpf_trace_printk which calls raw_spin_lock_irqsave which is traced by
> another bpf program that calls bpf_snprintf, then the second "get"
> fails. Essentially, these helpers are not re-entrant. They would return
> -EBUSY and print a warning message once.
>
> This patch triples the number of bprintf buffers to allow three levels
> of nesting. This is very similar to what was done for tracepoints in
> "9594dc3c7e7 bpf: fix nested bpf tracepoints with per-cpu data"
>
> Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
> Reported-by: syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/bpf/helpers.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 544773970dbc..ef658a9ea5c9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -696,34 +696,35 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
>   */
>  #define MAX_PRINTF_BUF_LEN     512
>
> -struct bpf_printf_buf {
> -       char tmp_buf[MAX_PRINTF_BUF_LEN];
> +/* Support executing three nested bprintf helper calls on a given CPU */
> +struct bpf_bprintf_buffers {
> +       char tmp_bufs[3][MAX_PRINTF_BUF_LEN];
>  };
> -static DEFINE_PER_CPU(struct bpf_printf_buf, bpf_printf_buf);
> -static DEFINE_PER_CPU(int, bpf_printf_buf_used);
> +static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
> +static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>
>  static int try_get_fmt_tmp_buf(char **tmp_buf)
>  {
> -       struct bpf_printf_buf *bufs;
> -       int used;
> +       struct bpf_bprintf_buffers *bufs;
> +       int nest_level;
>
>         preempt_disable();
> -       used = this_cpu_inc_return(bpf_printf_buf_used);
> -       if (WARN_ON_ONCE(used > 1)) {
> -               this_cpu_dec(bpf_printf_buf_used);
> +       nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
> +       if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bufs->tmp_bufs))) {
> +               this_cpu_dec(bpf_bprintf_nest_level);

Applied to bpf tree.
I think at the end the fix is simple enough and much better than an
on-stack buffer.
