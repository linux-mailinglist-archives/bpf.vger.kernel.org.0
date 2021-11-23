Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE27845AFBD
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 00:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhKWXFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 18:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhKWXFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 18:05:55 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4002C06173E
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 15:02:46 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 131so1714614ybc.7
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 15:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jYNvJR/ZMO4AsNQEoxXlpBNonI3w0BCt0LHy2BJIfwc=;
        b=EoadG8zh/DDKPiytCwQ9f9n/iKi3JlBtjUUY6Tzhf3RQQe0jFTJUjuxhgmlgRDHKZt
         +8WL7g5CVtZuajl02UsPbmUMEI4GJn4mvWXDcL1iZb716t6eSg/3EbpepmZLfNUtJxyG
         01tU3w0mpaw4GKLjWU3ae/HqfcYH0XttKAHhcewfFCQ+0ElGjffeDlgtOrcYqo2vpoMA
         KajYEgqsshIfqfwx5ITwzfbbBvr8wGsyB7W6tLRGNhxIDJn7KEmfLOFqK4U/KgxCWhSI
         oLQ+taY2NbIARDeGidXtgfHLcW7oeZuJEc+827Rn2FTcmCzjpnxAGIyA2mzi+41IoPi5
         9LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jYNvJR/ZMO4AsNQEoxXlpBNonI3w0BCt0LHy2BJIfwc=;
        b=EeFLl1CFsykXNPnOdNglQvEFm9qTFD+vKwTR+8VGjGoz5sI6gWChSwmpwPBpnzSm7O
         +jrSOcavpQER5B9D6LI+7+Z0cSRLi3uaDAvzmm8TZy7xlIQ5siC/ZYLPi8FHlXscdmUR
         kCd0wmu50UDm/Yf/wIGoa4KQpjILzVqhlW6eQ/KOJPi+BmXD1hqJ50ixK+hilTW0RPSt
         CLsmGZqpi79GAZ+gOpx78o7vYl/tNB7WaZrs+H4CNvm8agZzOGyQ07/HMsaT2uKpKrLb
         tum48bK7MtnwjlIKnigdR5gehg0xw8qjMkddkH915GIekArSF4vUPKuehe/hfGCbnXI5
         W7LQ==
X-Gm-Message-State: AOAM530RDuflFCPzN/wrJ7CjmryOLHhKbsQeRGCq8lbx+nSurz/kJBJW
        Fod8AtzhVdGp4FcoJbyr9/cA4M/v23VFdJGi8Zjt5w==
X-Google-Smtp-Source: ABdhPJxUExcw/sUIewzH2m2aJqB1DQz8JVV+JSuEPsSeWafHZDN27gbuARPQ5eq8Yz1eR6uYAta8VxaEU38mODyFhtE=
X-Received: by 2002:a25:cecd:: with SMTP id x196mr10749762ybe.63.1637708565519;
 Tue, 23 Nov 2021 15:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20211123205607.452497-1-zenczykowski@gmail.com>
In-Reply-To: <20211123205607.452497-1-zenczykowski@gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Tue, 23 Nov 2021 15:02:33 -0800
Message-ID: <CANP3RGdZq6x0NB2wKn5YG2Va=j0YHKd5DcM7_dyaKWhdyUrzOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: allow readonly direct path access for skfilter
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Linux Network Development Mailing List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Note: this is more of an RFC... question in patch format... is this
even a good idea?

On Tue, Nov 23, 2021 at 12:56 PM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> From: Maciej =C5=BBenczykowski <maze@google.com>
>
> skfilter bpf programs can read the packet directly via llvm.bpf.load.byte=
/
> /half/word which are 8/16/32-bit primitive bpf instructions and thus
> behave basically as well as DPA reads.  But there is no 64-bit equivalent=
,
> due to the support for the equivalent 64-bit bpf opcode never having been
> added (unclear why, there was a patch posted).
> DPA uses a slightly different mechanism, so doesn't suffer this limitatio=
n.
>
> Using 64-bit reads, 128-bit ipv6 address comparisons can be done in just
> 2 steps, instead of the 4 steps needed with llvm.bpf.word.
>
> This should hopefully allow simpler (less instructions, and possibly less
> logic and maybe even less jumps) programs.  Less jumps may also mean vast=
ly
> faster bpf verifier times (it can be exponential in the number of jumps..=
.).
>
> This can be particularly important when trying to do something like scan
> a netlink message for a pattern (2000 iteration loop) to decide whether
> a message should be dropped, or delivered to userspace (thus waking it up=
).
>
> I'm requiring CAP_NET_ADMIN because I'm not sure of the security
> implications...
>
> Tested: only build tested
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 331b170d9fcc..0c2e25fb9844 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3258,6 +3258,11 @@ static bool may_access_direct_pkt_data(struct bpf_=
verifier_env *env,
>         enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>
>         switch (prog_type) {
> +       case BPF_PROG_TYPE_SOCKET_FILTER:
> +               if (meta || !capable(CAP_NET_ADMIN))
> +                       return false;
> +               fallthrough;
> +
>         /* Program types only with direct read access go here! */
>         case BPF_PROG_TYPE_LWT_IN:
>         case BPF_PROG_TYPE_LWT_OUT:
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
