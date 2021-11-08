Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A576447DBC
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 11:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhKHKVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 05:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbhKHKUe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 05:20:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB95C079781
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 02:16:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d12so31376312lfv.6
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=wBTGDdEbwTqmD91ho01NVCxfHBjXUNqSEHyU6L4B96A=;
        b=QT7MFGgtlRoza6BS8EuBiHBk0UTkAX7VbtFE9fkoJF3ho/Cy/pXG0Cdcqm5Z0MIgx6
         SvXSwj+CVlTiAULRBr4tXLHI5A6JEqvBpB6qdIv4j4scnftDlU+KdnR6TqlgFF9e4T7/
         xSQ7weMoLZ2ATVgJ+2owplXh4g9TIHZ4DUyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=wBTGDdEbwTqmD91ho01NVCxfHBjXUNqSEHyU6L4B96A=;
        b=U9FXNW9obpI+T0EBjO1Pfyo+8ZPT6umrZGn7yet6X8k9/iVjRnD3cfnHle5GF8K2Zi
         gYBiF0clKtrjwOSKdVnDdPGVkOjVOwhJuGnPN/O4aBlAV1thrO4P8YAGgW979AzlWJW1
         p9TgUNTKGAU5iXH+WS77eUIQ+Bw25KV366JS4PR2ypYlPChrGU9f1ibak077j/8CwMKe
         Rt8ihxqQ+KJz8DiNg7KIc/Ixh0Jj2xGpcQzcFvFQkggAa1fnZJeu2z/yOcLhJhi8GoKN
         6yLu1adu41PvSmxkdMzHIg2xzi9/R8OjRd7732BX3whJKZXhL7WLEBfj5NhjN/3ufzqD
         906Q==
X-Gm-Message-State: AOAM530xW29dkI4HBH1Y7octiGMTZljDzEHvyTXDVI+pOqx8Y7W2lxDP
        CBL7WIwW/4Kf8IgE7T9r3zTWVg==
X-Google-Smtp-Source: ABdhPJwvn/Ri3oM+ePuKFOTOJynVxf0RmNvI49kCZj9vQ4OJg7jDocr1tCdXCgCJhf4DVQbdgNDIWg==
X-Received: by 2002:ac2:4f91:: with SMTP id z17mr71831935lfs.38.1636366577731;
        Mon, 08 Nov 2021 02:16:17 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id j8sm1655566lfe.160.2021.11.08.02.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 02:16:17 -0800 (PST)
References: <20211103204736.248403-1-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        joamaki@gmail.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH bpf v2 0/5] bpf, sockmap: fixes stress testing and
 regression
In-reply-to: <20211103204736.248403-1-john.fastabend@gmail.com>
Date:   Mon, 08 Nov 2021 11:16:16 +0100
Message-ID: <87v913gdfz.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 03, 2021 at 09:47 PM CET, John Fastabend wrote:
> Attached are 5 patches that fix issues we found by either stress testing
> or updating our CI to LTS kernels.
>
> Thanks to Jussi for all the hard work tracking down issues and getting
> stress testing/CI running.
>
> First patch was suggested by Jakub to ensure sockets in CLOSE state
> were safe from helper side.
>
> Next two patches are issues discovered by Jussi after writing a stess
> testing tool.
>
> The last two fix an issue noticed while reviewing patches and xlated
> code paths also discovered by Jussi.
>
> v2: Add an initial patch to make sockmap helpers safe with CLOSE
>     sockets in sockmap
>     Added Jussi's tested-by line he tested the original patch series.
>
> John Fastabend (4):
>   bpf, sockmap: Use stricter sk state checks in sk_lookup_assign
>   bpf, sockmap: Remove unhash handler for BPF sockmap usage
>   bpf, sockmap: Fix race in ingress receive verdict with redirect to
>     self
>   bpf: sockmap, strparser, and tls are reusing qdisc_skb_cb and
>     colliding
>
> Jussi Maki (1):
>   bpf, sockmap: sk_skb data_end access incorrect when src_reg = dst_reg
>
>  include/linux/skmsg.h     | 12 ++++++++
>  include/net/strparser.h   | 20 +++++++++++-
>  net/core/filter.c         | 64 ++++++++++++++++++++++++++++++++++-----
>  net/core/sock_map.c       |  6 ----
>  net/ipv4/tcp_bpf.c        | 48 ++++++++++++++++++++++++++++-
>  net/strparser/strparser.c | 10 +-----
>  6 files changed, 135 insertions(+), 25 deletions(-)

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
