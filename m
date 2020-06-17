Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E21FD928
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 00:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFQWro (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 18:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQWro (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 18:47:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC12C06174E
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 15:47:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b4so3710891qkn.11
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nT4qhp2XXOdNg4SSqlnlsQXfL02Mk0K8ZkYYmFsCl/o=;
        b=YWzeAf/kxk9p3xcyU/3phfq/x5bCXxj8GfoohsWzjxbCvLhw+vpp5E/j9xbOdw9tHg
         KDzJBu/8/FJ0KtSFLWzf0l7H59maJO2WasSjSsL/MtnSBC3boeNikZM1XJJqmtQTXgmm
         kQGXvFDrSrTodat+NdeGuVx2D/RVRVQtDQEsy1s64Ak3Hdgj7Zu0GIQxtFoND0OLnOmL
         vSbZhl+mHiSJFsKyWbXJpfO7MZWhYBCpYvS03gdpiRGTc9hQCz5zTLyzBX2JYto+QiBn
         9d4IT34m3jn+tIhCi5Q+tH7PoHpjVyd4z/0sjRQTQ+R5dat4xFAKqVcYFJtsHjKc1ETw
         merg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nT4qhp2XXOdNg4SSqlnlsQXfL02Mk0K8ZkYYmFsCl/o=;
        b=gu3q7Vq4tgVxVJDacFlG9UrgoKQ0jU1+KjUif5y+9+z4v/S/uh+yd8Xriz5AN9Y1oD
         PWxfIfPvOgXDZh7EmS4t0Uf/xQYQaSn3rXugWnrg9cQT0RHOdnUFmOnxFhB0zYqvn+qR
         4BTv0SdcaVWcQDuKtyHws8XOr6TlCzEa/bPvxtqvU4mMJTmWk01PQG8ZDZNTuBhDsMa/
         PubAR6w3atA0IjRfE77dzSeI9zfaiSL9GpcONuBQCY5mvEs8qaciwsxFv33nuuxpZvDl
         XNamtdmrymemhVbLzxXbAN3O84HzrwC9LglZpMolgzXhT/q6I0RdYZAv3zRhEsAgFQg6
         71Mg==
X-Gm-Message-State: AOAM531a02/c3NBWXL4zYxCEzMRIkdZ6fg72o5fyQf26hfu64js0SmWj
        GQRH5qzg0YswaqP5HaktikuH9wNH5wPCxL9TSW58bXm7
X-Google-Smtp-Source: ABdhPJxDa3iROL6Sqi+Wkv42uvLN0YhVtPC6wK4ZcZ+ey1531zoTjij8KlOdqGIRAPA1QKZwl/e7ud2m5TQZ01k1VpU=
X-Received: by 2002:a37:a89:: with SMTP id 131mr989279qkk.92.1592434062870;
 Wed, 17 Jun 2020 15:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200617211536.1854348-1-yhs@fb.com> <20200617211550.1856546-1-yhs@fb.com>
In-Reply-To: <20200617211550.1856546-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 17 Jun 2020 15:47:31 -0700
Message-ID: <CAEf4BzYYYogTQuzxRA0AsfcPGtNK7+s24ehFS1o_VDrdHAxSEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/13] bpf/selftests: move newer bpf_iter_* type
 redefining to a new header file
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 2:16 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit b9f4c01f3e0b ("selftest/bpf: Make bpf_iter selftest
> compilable against old vmlinux.h") and Commit dda18a5c0b75
> ("selftests/bpf: Convert bpf_iter_test_kern{3, 4}.c to define
> own bpf_iter_meta") redefined newly introduced types
> in bpf programs so the bpf program can still compile
> properly with old kernels although loading may fail.
>
> Since this patch set introduced new types and the same
> workaround is needed, so let us move the workaround
> to a separate header file so they do not clutter
> bpf programs.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Thanks for the clean up!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/progs/bpf_iter.h  | 49 +++++++++++++++++++
>  .../selftests/bpf/progs/bpf_iter_bpf_map.c    | 18 +------
>  .../selftests/bpf/progs/bpf_iter_ipv6_route.c | 18 +------
>  .../selftests/bpf/progs/bpf_iter_netlink.c    | 18 +------
>  .../selftests/bpf/progs/bpf_iter_task.c       | 18 +------
>  .../selftests/bpf/progs/bpf_iter_task_file.c  | 20 +-------
>  .../selftests/bpf/progs/bpf_iter_test_kern3.c | 17 +------
>  .../selftests/bpf/progs/bpf_iter_test_kern4.c | 17 +------
>  .../bpf/progs/bpf_iter_test_kern_common.h     | 18 +------
>  9 files changed, 57 insertions(+), 136 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter.h
>

[...]
