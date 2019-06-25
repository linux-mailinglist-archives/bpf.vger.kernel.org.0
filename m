Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3355743
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbfFYScz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 14:32:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43159 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732860AbfFYScz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 14:32:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so9907174pfg.10
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D1yWkLuPQ28KWW7K7QdlJ9HbJ+2HGPcbZ0bmcIG8Xo0=;
        b=moU2u1V3Qh8J1hPlHaZz1CymCnc1sa24lshPcARXEL6urfTJZhOxDuV4nfrO8mjbVs
         yugdY3l66uhheDa8r4QbmMwexq/mmHKgsAvf0R4EmF5zsxPsXq8HVASzWwXnepJuPSmi
         e/spoalsDXQgxxTJ+zY6UbGtmagTbQ4KQ+9F+skLXdblT9s/6tRp3nHfzZXsIaXD8NIv
         slmLmG4/Tjkm1ZbBGy2Ya/4anlhlR/+oPenq9+YlNR1RdxOtP7N68M+XQUiebj/IwRmE
         Kv5u6IwxmRZH0N5P+tEseNu2K94msKftEYgJebGbUi/1U2frF4bavWJ+w5KXGClYpT1D
         nsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D1yWkLuPQ28KWW7K7QdlJ9HbJ+2HGPcbZ0bmcIG8Xo0=;
        b=QjH/WoAxNR4uLnLrqasr5AeI8Y8LRg68mvzXouVKvAtci31PS0SGZ7zfKUlm8VrEOI
         50R+/TMd/QM7XR0zpbDlL2vaVOSGmT8lN6fbwnut6zqeoOqqvpZAUfU5PzeGCQOWjDyY
         Lj0WQNAyTLBq50vqqE2OJ2no6RTbaawAG3vqUqybOImHHmXRV6yn7a2kNRbXNyavnPoO
         WB9i5+sBujkHEyRBwWwrdU7thO2HT0gXwelZa3gxASlfain0tEmgqDXFCDUs0hGtYp+A
         beW+aiSr4STH0Ll2O/IkoakofmusNtVy2A6tc0alsb3qTzoiaC46Kn6/hXcjIOMQVihu
         X+Iw==
X-Gm-Message-State: APjAAAU8PUOj5G0TeJldkn9wCWquIFq6JbPcNSsFhpxfU55OUFMUw3xo
        fOHXASvoucTiw1X2odS3ltpG1xXOcuW96w9C1NAwDg==
X-Google-Smtp-Source: APXvYqyKjZ/WKdRGYvvfMtHRGXNfsMEhqydqLgglBcUWoW+MIQpM+Bv1t6eGKozRx5tmkn3zgYBW6uQjx7xYhNKsGns=
X-Received: by 2002:a63:52:: with SMTP id 79mr39875246pga.381.1561487574002;
 Tue, 25 Jun 2019 11:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190625182352.13918-1-natechancellor@gmail.com>
In-Reply-To: <20190625182352.13918-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jun 2019 11:32:42 -0700
Message-ID: <CAKwvOdkdXRRrTSukQ4mJ6FfjqD-GJeBzOK34e+=jJzaQ3qOaiw@mail.gmail.com>
Subject: Re: [PATCH] xsk: Properly terminate assignment in xskq_produce_flush_desc
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 25, 2019 at 11:24 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> In file included from net/xdp/xsk_queue.c:10:
> net/xdp/xsk_queue.h:292:2: warning: expression result unused
> [-Wunused-value]
>         WRITE_ONCE(q->ring->producer, q->prod_tail);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/compiler.h:284:6: note: expanded from macro 'WRITE_ONCE'
>         __u.__val;                                      \
>         ~~~ ^~~~~
> 1 warning generated.
>
> The q->prod_tail assignment has a comma at the end, not a semi-colon.
> Fix that so clang no longer warns and everything works as expected.

oh no! -Wunderhanded-C-contest-style-use-of-comma-operator strikes again!
Great find and thanks for the fix.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Bj=C3=B6rn and Alexei should carefully review.  Because WRITE_ONCE is a
macro that expands to a GNU C statement expression, which returns the
last statement, this code was previously assigning q->prod_tail to
itself, now it's assigning it to q->prod_head.  I assume that was not
intentional, but am unfamiliar with the code.

>
> Fixes: c497176cb2e4 ("xsk: add Rx receive functions and poll support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/544
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  net/xdp/xsk_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 88b9ae24658d..cba4a640d5e8 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -288,7 +288,7 @@ static inline void xskq_produce_flush_desc(struct xsk=
_queue *q)
>         /* Order producer and data */
>         smp_wmb(); /* B, matches C */
>
> -       q->prod_tail =3D q->prod_head,
> +       q->prod_tail =3D q->prod_head;
>         WRITE_ONCE(q->ring->producer, q->prod_tail);
>  }
>
> --
> 2.22.0
>


--=20
Thanks,
~Nick Desaulniers
