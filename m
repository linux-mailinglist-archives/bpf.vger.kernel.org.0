Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90DA3A8415
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFOPh3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhFOPh2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 11:37:28 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BFC06175F
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 08:35:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f84so21205157ybg.0
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TW++UaYH676wBlxAmC5epOAFhyC7J56lUkKh39lO7w=;
        b=i9s9QuGtGYUZIpHX1mDsmvAli3APV1bnEClSUAQuQkTp6lMS5FBJ3rNm6CHo/TmTky
         cCSQllfsfxI0Otq8jBh0LSthABYKt5wtuPiiV94lS9FfZfv4r1lfLRoVhAb7GhxdccOq
         G+3zUsMBML7/+CbFx0w6DlyLp7QCEhjfDX9USfwbFNXfrvhhT9Ph6kuW73CclrBFekDG
         6BI5skkWF91+i2He/zCobWaFuTzJi/4OTiOzg3WVcbBR4RUUJAl3+6IuctcpyAph+NoL
         xQkAhb5ENwOuhvhLnBxRTUtcEhe9pcpXPudD9XW/yYFi4NZO7+c3CxcpzDQrKKgMYm/k
         Bscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TW++UaYH676wBlxAmC5epOAFhyC7J56lUkKh39lO7w=;
        b=Ce2lBSNx/w//VBDhWv0ERVxpiR1T/03NULeOScAFnLvqURje2XJiPpz8LckCwo5Jb4
         o6okyGuNtx6EzoEf78P2tpKx0KH0xQGLbYihwcOVSBBGdWSGyW8QN7qZiPKwj4NYoV2F
         ypE71+huQaZaMUDfRaPAsdVZS6x4x1trWzDnp6unQ5dQyFssdzWpAZJY2x7FN60v8yfB
         VcsJKlx6SUWx7ycqYbC5wJ+Uvvz/zwkPfbNvd3QDWIXeY/gMVDq2jwDnDbXDe6cF69t0
         N6z45nsAA3C7d+0BC9bQsvfOCBYJ+Sbx+9Xm8qAJ4EYzZ60zuZIQR9o+svC6LC7czWso
         dxdw==
X-Gm-Message-State: AOAM530s8DKK9sFrTB6DGG4oyQU2LO1VlXp8BlOjBhv1RTX0iOok8USc
        5i/1cTy+nleQ6/xyTxawuQDeWL9ONV71pqXVV89LJg==
X-Google-Smtp-Source: ABdhPJyU4VoPOerwCdHdI/jGGLIbnbwrAkYWkiCKScaeblfZCVDF0S0kXo5eZbi0qJoHTNMn0naDL9ROsuN4+BIxc08=
X-Received: by 2002:a25:1fc6:: with SMTP id f189mr33298185ybf.452.1623771321743;
 Tue, 15 Jun 2021 08:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210612123224.12525-1-kuniyu@amazon.co.jp>
In-Reply-To: <20210612123224.12525-1-kuniyu@amazon.co.jp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 15 Jun 2021 17:35:10 +0200
Message-ID: <CANn89iLxZxGXaVxLkxTkmNPF7XZdb8DKGMBFuMJLBdtrJRbrsA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/11] Socket migration for SO_REUSEPORT.
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 12, 2021 at 2:32 PM Kuniyuki Iwashima <kuniyu@amazon.co.jp> wrote:
>

>
>
> Changelog:
>  v8:
>   * Make reuse const in reuseport_sock_index()
>   * Don't use __reuseport_add_sock() in reuseport_alloc()
>   * Change the arg of the second memcpy() in reuseport_grow()
>   * Fix coding style to use goto in reuseport_alloc()
>   * Keep sk_refcnt uninitialized in inet_reqsk_clone()
>   * Initialize ireq_opt and ipv6_opt separately in reqsk_migrate_reset()
>
>   [ This series does not include a stats patch suggested by Yuchung Cheng
>     not to drop Acked-by/Reviewed-by tags and save reviewer's time. I will
>     post the patch as a follow up after this series is merged. ]
>

For the whole series.

Reviewed-by: Eric Dumazet <edumazet@google.com>
