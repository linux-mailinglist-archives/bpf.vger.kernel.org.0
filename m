Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342FD435245
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhJTSDa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhJTSD1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 14:03:27 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110DC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:01:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so7455177otl.11
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cupflte1zq90gW1ccTXvlIjvbCfDXy0IhF6QWIY1PEY=;
        b=SoIXUOtE9Alqx2NxcYxBnCORgimBcYzGPaxU9ynyftblKa61YB/ndQGoTen5UDgcmN
         7jtHmWK6oixRhSjFI2RGkf9d0X+3sir1kSu3vonBsWs48uPRdFyfJpKkn5KW2pWJyHjf
         u3o5tAW7EU2Ry2/5ZPAmKLk4VFEi0ZS7Bsog7W3NV5Qqffs3RDaYVUVLIBcdskPzdJ56
         /oxKJKeD727mZWbMuRYFtMqBvVleAphudRBQMw+ss3F/qXueq1nhHXwsaIyXz8JTh3Bj
         TXcPNUlNUblzWCZc41FQhxexTUo8j1fraZQ+ReAHN9sYDc8ae8OKKyGBEpc6sIHM9b2B
         1LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cupflte1zq90gW1ccTXvlIjvbCfDXy0IhF6QWIY1PEY=;
        b=Ks1wGib1gy6bVrFKnV+qs+AZ6ZkBN9AgbuYJsA4/my8Kw5+mWSRU9bLWQf2nb17HX2
         KS1tMviUeMiRgZXG+gYBb6Og9V0cfcP8smYbrLio/dydsPaToasjJ6GqcvthzRJVuXTn
         Bs0EDBOlu5ZYBKNP9aP+hwXLCGC5NZmnWdcRvJCoOGw2L2cftNdMTHar6qduvOG00441
         dQDv3zpkNv5wpWsG69RyxLvi6lOHSBAKEbHvd/9/jno3qe8O8SejNXTf+za8bPkkdM71
         ayokGMCJtcX7bpdzziEZZzKWKA1irwwbpnXdy9fBdCesbjHjdRS24opAVYu3DrLT3RQj
         U9dg==
X-Gm-Message-State: AOAM533b1KlM/gFtH3vmA+vfKuT7Beet8Cg0EtRaFTDkd7FbrV7tl6x8
        FOnf1Y+mKVhRRB8vv3ZU+5UASMk+uki1/ubMxUYhXQ==
X-Google-Smtp-Source: ABdhPJw6/FSGoIjKPaOACQopMsh/iVUFBfAhKaMwlQW9gEuhr1NwS6g04TLnlV2BQd6juy/jlA8fFDatcMA2cDQ2ooQ=
X-Received: by 2002:a05:6830:3096:: with SMTP id f22mr620491ots.195.1634752872088;
 Wed, 20 Oct 2021 11:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211019144655.3483197-1-maximmi@nvidia.com> <20211019144655.3483197-11-maximmi@nvidia.com>
In-Reply-To: <20211019144655.3483197-11-maximmi@nvidia.com>
From:   Joe Stringer <joe@cilium.io>
Date:   Wed, 20 Oct 2021 11:01:01 -0700
Message-ID: <CADa=RyxEQwQp++1JD67h5_JZMokGhMi6ediGKjQSQeBR2-TeBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] bpf: Add sample for raw syncookie helpers
To:     Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@chromium.org>,
        Joe Stringer <joe@cilium.io>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,  just one comment related to the discussion on patch 7.

On Tue, Oct 19, 2021 at 7:49 AM Maxim Mikityanskiy <maximmi@nvidia.com> wrote:

<snip>

> +
> +       value = 0; // Flags.
> +       ct = bpf_ct_lookup_tcp(ctx, &tup, tup_size, BPF_F_CURRENT_NETNS, &value);
> +       if (ct) {
> +               unsigned long status = ct->status;
> +
> +               bpf_ct_release(ct);
> +               if (status & IPS_CONFIRMED_BIT)
> +                       return XDP_PASS;
> +       } else if (value != -ENOENT) {
> +               return XDP_ABORTED;
> +       }

Is this the only reason that you wish to expose conntrack lookup
functions to the API?

You should be able to find out whether the TCP session is established
by doing a TCP socket lookup and checking sk->state.
