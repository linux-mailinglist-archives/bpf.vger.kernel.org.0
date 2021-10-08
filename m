Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3348426475
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 08:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJHGI3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 02:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhJHGI2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 02:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 253FC60F5B
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 06:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633673194;
        bh=bwAqI4nZvAkUZWRYS3ZV4cQHeoKs2iShXOnevhCNLnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DMblaFIi7T8dl6rl4121688YxqJzmnNBFigItvsh5Ml2cJrB4eRGxk73CEszs1e0w
         ZRyouOKg/R65LgbF4aku/S7aJMI3IhibroGijG0FiRDTAN5qRiSeDkmIWgMxd034Uo
         iHSyJTy5AysaujZ5JQQP8nuKmldqHHidqVSj+qC1yRGOPB9MKeRzvHTfDES1UA5GUi
         cCd3wAwP2w97pc4hSj7M+1gU8QfQVlpMqwzrZItPfVkzuPOiD0QTjyszrjBle92Qzy
         sRvfAXYmg5HXfKxd2IJtU7cbVBKrWM3ds7m9mxZAneJuQq+Nvb+k5sDwfIUQ7qs9Gp
         NyrHLZJ/7UhdA==
Received: by mail-lf1-f43.google.com with SMTP id x27so34776375lfu.5
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 23:06:34 -0700 (PDT)
X-Gm-Message-State: AOAM531BB4orqurQ9lE3XVDarl7c61Z8i9MhOOSwznmLvAHhP+Or+ze/
        UaA+9jCWsLP4CyhbW22d2Vt+U3bxGKpYOBkC8WA=
X-Google-Smtp-Source: ABdhPJw4WbiFTrb370Sfp5DBrXXg2hXoEpzX8c4lWy1H9Vz6etHa+qqIUhOMxvZxLY0HEICTpk5+eQw/cz4taDbvQ0I=
X-Received: by 2002:a05:651c:c5:: with SMTP id 5mr520927ljr.48.1633673192508;
 Thu, 07 Oct 2021 23:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-2-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-2-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Oct 2021 23:06:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5yb3nkGzXo6eTFBzCNyCJr3rQeVFWU-6U0E4z+BJob5g@mail.gmail.com>
Message-ID: <CAPhsuW5yb3nkGzXo6eTFBzCNyCJr3rQeVFWU-6U0E4z+BJob5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/10] libbpf: deprecate btf__finalize_data() and
 move it into libbpf.c
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:03 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> There isn't a good use case where anyone but libbpf itself needs to call
> btf__finalize_data(). It was implemented for internal use and it's not
> clear why it was made into public API in the first place. To function, it
> requires active ELF data, which is stored inside bpf_object for the
> duration of opening phase only. But the only BTF that needs bpf_object's
> ELF is that bpf_object's BTF itself, which libbpf fixes up automatically
> during bpf_object__open() operation anyways. There is no need for any
> additional fix up and no reasonable scenario where it's useful and
> appropriate.
>
> Thus, btf__finalize_data() is just an API atavism and is better removed.
> So this patch marks it as deprecated immediately (v0.6+) and moves the
> code from btf.c into libbpf.c where it's used in the context of
> bpf_object opening phase. Such code co-location allows to make code
> structure more straightforward and remove bpf_object__section_size() and
> bpf_object__variable_offset() internal helpers from libbpf_internal.h,
> making them static. Their naming is also adjusted to not create
> a wrong illusion that they are some sort of method of bpf_object. They
> are internal helpers and are called appropriately.
>
> This is part of libbpf 1.0 effort ([0]).
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/276
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
