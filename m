Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97C3BD894
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhGFOpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhGFOnx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 10:43:53 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F2C08EC38
        for <bpf@vger.kernel.org>; Tue,  6 Jul 2021 07:41:14 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id g25so2950977vss.3
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTSN/TsZ42ihyFJIr7SrTpDTYHBxd5pPWJlGP+shcyw=;
        b=YAK+YCFdhvDT27LvdTUG0jEZsORIgDDD1T1cNq5wMoOogkZ4FrhJge5A4Cx5NHW/j/
         tlnqS8u76bv04yyu8b0Fo0rTNn4lNJShq1gtKsW6bWGNUb7+jqDauxhVpZ8eO38MCRkS
         o+4DqskC3HE8YdB0nYrwkUiQafHsLRRB+2IogRDM7saPS3ZijLB6rkRyyY5PF2VjMiCC
         N67du1djLw4xcL7Y50ia2FC51dcVvA3ePfTMX2YefWPQ80hqprwq5Fh3aPO7EUvW8OD0
         jFe8zRKSO8/OAw/VE8I0DIEOpQYGapTdX2vzo+qN5lUFUxb0HUukDPDIGyYyQWAhm66s
         P1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTSN/TsZ42ihyFJIr7SrTpDTYHBxd5pPWJlGP+shcyw=;
        b=IpdSZ599f6v0LI9HiVe+VRUqpMT1pcozTmegunyC/8o1AFbae3j/gcnGgISBWh96aj
         H/1RbKFMOo95D+0VWCl1gBAzmhAS5af2tP3ZIH2/GRtTSYMRqW8iq4uEx/lmrL+1pt6H
         cP5Gc9OQ6AB3ZLChX1UhiFbPiTvGeGSUq+JAKFCoUck9DPyci3UZBkmIxIceugK3EJ4q
         Tt5OCZU+7i5QBVVucMx9mxC925dgFVzIC9uPzqApcnq2N1nb/a5RfT9r73wQGMRa1E/B
         6zZB1/LyhmLQU4n/qaTBQ9a1ZOxVc5FBnY8VujVNpwKIdn+OQFiNhxSA2bkTKcVojuLi
         mYww==
X-Gm-Message-State: AOAM530i02UZ5a/+43ZR8d5PkzQBChFjjZ42bjSiGb4yPY7giF0JmEPh
        NpHjRE9CTKyWrU7abEu69Toq9kkq0Ws1mvFI/SmVnQ==
X-Google-Smtp-Source: ABdhPJw/aK0Qk0RnZ6WI52y3rp230jVwtgYhkwbx8aS/wBE4hQmIpJ8D0FLgvjVDorBlpsEN4ImUxrnLulBTYwhJetc=
X-Received: by 2002:a67:f7c8:: with SMTP id a8mr9683316vsp.16.1625582473140;
 Tue, 06 Jul 2021 07:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210705231912.532186-1-phind.uet@gmail.com>
In-Reply-To: <20210705231912.532186-1-phind.uet@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Tue, 6 Jul 2021 10:40:56 -0400
Message-ID: <CADVnQy=vjHrBB=cD7FNedUMi6pOagEovO=H1no3A27fK9-yQAA@mail.gmail.com>
Subject: Re: [PATCH v6] tcp: fix tcp_init_transfer() to not reset icsk_ca_initialized
To:     Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     yhs@fb.com, edumazet@google.com, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, ycheng@google.com, yyd@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f1e24a0594d4e3a895d3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 5, 2021 at 7:19 PM Nguyen Dinh Phi <phind.uet@gmail.com> wrote:
>
> This commit fixes a bug (found by syzkaller) that could cause spurious
> double-initializations for congestion control modules, which could cause
> memory leaks or other problems for congestion control modules (like CDG)
> that allocate memory in their init functions.
>
> The buggy scenario constructed by syzkaller was something like:
>
> (1) create a TCP socket
> (2) initiate a TFO connect via sendto()
> (3) while socket is in TCP_SYN_SENT, call setsockopt(TCP_CONGESTION),
>     which calls:
>        tcp_set_congestion_control() ->
>          tcp_reinit_congestion_control() ->
>            tcp_init_congestion_control()
> (4) receive ACK, connection is established, call tcp_init_transfer(),
>     set icsk_ca_initialized=0 (without first calling cc->release()),
>     call tcp_init_congestion_control() again.
>
> Note that in this sequence tcp_init_congestion_control() is called
> twice without a cc->release() call in between. Thus, for CC modules
> that allocate memory in their init() function, e.g, CDG, a memory leak
> may occur. The syzkaller tool managed to find a reproducer that
> triggered such a leak in CDG.
>
> The bug was introduced when that commit 8919a9b31eb4 ("tcp: Only init
> congestion control if not initialized already")
> introduced icsk_ca_initialized and set icsk_ca_initialized to 0 in
> tcp_init_transfer(), missing the possibility for a sequence like the
> one above, where a process could call setsockopt(TCP_CONGESTION) in
> state TCP_SYN_SENT (i.e. after the connect() or TFO open sendmsg()),
> which would call tcp_init_congestion_control(). It did not intend to
> reset any initialization that the user had already explicitly made;
> it just missed the possibility of that particular sequence (which
> syzkaller managed to find).
>
> Fixes: 8919a9b31eb4 ("tcp: Only init congestion control if not initialized already")
> Reported-by: syzbot+f1e24a0594d4e3a895d3@syzkaller.appspotmail.com
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
> V2:     - Modify the Subject line.
>         - Adjust the commit message.
>         - Add Fixes: tag.
> V3:     - Fix netdev/verify_fixes format error.
> V4:     - Add blamed authors to receiver list.
> V5:     - Add comment about the congestion control initialization.
> V6:     - Fix typo in commit message.
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7d5e59f688de..84c70843b404 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5922,8 +5922,8 @@ void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb)
>                 tp->snd_cwnd = tcp_init_cwnd(tp, __sk_dst_get(sk));
>         tp->snd_cwnd_stamp = tcp_jiffies32;
>
> -       icsk->icsk_ca_initialized = 0;
>         bpf_skops_established(sk, bpf_op, skb);
> +       /* Initialize congestion control unless BPF initialized it already: */
>         if (!icsk->icsk_ca_initialized)
>                 tcp_init_congestion_control(sk);
>         tcp_init_buffer_space(sk);
> --

Acked-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>

Looks good to me.  Thanks for the fix!

neal
