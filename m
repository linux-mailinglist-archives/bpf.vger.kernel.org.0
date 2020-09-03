Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A6525B84C
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgICBbp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 21:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgICBbp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 21:31:45 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C446DC061245
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 18:31:44 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c17so997100ybe.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 18:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uR4ZtZeHS1/d83ho3BZ9S4Tp0tJrYvrXmakrWN1Hzqs=;
        b=MEzjvz9HhDz7jyqyRKJgi0Cw5RlGIhW3aaq+swjQkCQMfyfTsAFd1oYKFwfc8XtJTV
         WgeVXPMKGai4+KbJjV1u/KvMC2CNPKr2YhZdqZypTt0FGNC5Dkjuwsobf30e95x2nKZ8
         ranEQa2cHGV7vJNaM7KLSgfU0YoQ1L3p3n1Nj//PGKIK+3rdlK7iooTUak6ux4WVmzld
         DWi6qYptWlRafri245NZV11Spy9uz+8gcbUEb+JDiusjioWwd2lG7gaZoUNztfulpgjP
         XU64vHUmm92EO4y0SH0zUfZFNcFFupe2MPM0i8ZcDJtGKNxU+QmDcrui/XNNMIT6NqeN
         yedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uR4ZtZeHS1/d83ho3BZ9S4Tp0tJrYvrXmakrWN1Hzqs=;
        b=PvbLRmP491TYXuPzXh62B5eQ2WXxINCsOgFjsgcPCZQREYnn69NbppKVtWTPz1kA2G
         MmzCaDKj2unDekSie5T3eK1rmKti0dyBQBVQVzRm3LVSFC4zA6OGKhe3eXtgMzmieUp0
         EDfkzGq3kLNu4zAQObus/OIpdvTGnQ8WJT60UDTXMajEXT/NvlMXObt8PQZoQkpzg4gg
         ZY/UxIJZvJwPuEZVxx396u9F2vhEA1O9M2qGeN3KrmVt3qaePlIorkYUKLRpWvrLFsSV
         FQ/xL0omSlucrWi0Ugmi06QRuSdn/vHYj4vdrdVkHh2XftKSoNPEllcHjK6FMwQIMU5H
         +2cg==
X-Gm-Message-State: AOAM533jDcBdElY0xesEUQQmVnXQ7bPLS1yE08+u7d3ztVXwc/K7+CLb
        VERnkMD5Yx7xTORgMo5i9GhI12dF/Q6m1tfzaSW23hZK
X-Google-Smtp-Source: ABdhPJzSpSCNhtbZ3QtiK88zoaSnK/rkAJQXNmbHziibs9cGt9Etr9cmFPdxxWL8j+HOEISxdJ/LTj9RntX/PSw2Y1A=
X-Received: by 2002:a25:c4c2:: with SMTP id u185mr759902ybf.347.1599096703332;
 Wed, 02 Sep 2020 18:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200901103210.54607-1-lmb@cloudflare.com> <20200901103210.54607-3-lmb@cloudflare.com>
In-Reply-To: <20200901103210.54607-3-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Sep 2020 18:31:32 -0700
Message-ID: <CAEf4BzavEyerq8an-rwFi5GRGtrOqObnCBx7jAbx-GmxA4-9-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] net: Allow iterating sockmap and sockhash
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 1, 2020 at 3:33 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
> hashtable implementation. sockmap and sockhash share the same iteration
> context: a pointer to an arbitrary key and a pointer to a socket. Both
> pointers may be NULL, and so BPF has to perform a NULL check before accessing
> them. Technically it's not possible for sockhash iteration to yield a NULL
> socket, but we ignore this to be able to use a single iteration point.
>
> Iteration will visit all keys that remain unmodified during the lifetime of
> the iterator. It may or may not visit newly added ones.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  net/core/sock_map.c | 283 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 283 insertions(+)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index ffdf94a30c87..4767f9df2b8b 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -703,6 +703,114 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
>         .arg4_type      = ARG_ANYTHING,
>  };
>
> +struct sock_map_seq_info {
> +       struct bpf_map *map;
> +       struct sock *sk;
> +       u32 index;
> +};
> +
> +struct bpf_iter__sockmap {
> +       __bpf_md_ptr(struct bpf_iter_meta *, meta);
> +       __bpf_md_ptr(struct bpf_map *, map);
> +       __bpf_md_ptr(void *, key);

For sockhash, the key can be of an arbitrary size, right? Should the
key_size be part of bpf_iter__sockmap then?

> +       __bpf_md_ptr(struct bpf_sock *, sk);
> +};
> +

[...]
