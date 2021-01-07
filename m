Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440A22ED73C
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 20:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbhAGTIF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 14:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbhAGTIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 14:08:04 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDFDC0612F6
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 11:07:24 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id w127so7088720ybw.8
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 11:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPMNlYualM+N/+Fns6VA0GYnh+CUNtOcKT0VzR778Ak=;
        b=H/a2OF33anH68hj3YbEoN1V7IyjztcCvjuS9Q2mP7SEyd1K7fj8200kf5AmudB1c3J
         h2uplo6A+AK+g1m7elctIcTdTXzzm4BjD51H3jP+EJKAcpLGCHL8gPzqNK0PiDz32Iri
         FzDH3qsbkTolyZ/ANXiR8vFZyRrkb4T0ZZrnfF/aqJlp+ARMaEqzdopgTIqlEUDGeIsq
         OjF6U93+RqiKK60rmLfELKC3gmo8E4GTMQLue9+Z3VLCV8i+2bbQr80P4oTEGUTy6Uub
         /TLxdGxWFyokcBDxNCuiyRa95TgPk06WbceVQSIYWDQ+bwxTi/08c9u7XycnTmpvP8p4
         eOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPMNlYualM+N/+Fns6VA0GYnh+CUNtOcKT0VzR778Ak=;
        b=M8xS8DkVTNpYbRbB+Z2BsoCkcBzsXOS4HhlmFpktLNSzA9whkRRvCYE2FmZg+pP1NB
         3u9sWqPAjC2OhwWoIrimg+TwxZKvjmBqUD72pUfDsLR4rr/t9MosQWPpVQR0vMQ4sFRo
         N5t321iBcUbh3VwiNan/SRC8jCZTFsl0SxFl8gIWWHgXnMT2thmgtE5iaBbTy6pK50s7
         TvNxjYWcKdusCrs9Gf0chDK11vepelDNiSxMJDjx4hf1g4oduCx8JUToxWXv5xkKd3yr
         kKOPoZ78ZWi48jW6HpqmF56ST9x3GwYiCiTlfLggjsoPGg8WZc3i/sKWmVSgiR23NHzN
         ubcA==
X-Gm-Message-State: AOAM532HJQLef1NplnLYjRWfkHu3CGUn0C5Nu6HZPKPca73eWVc+fUPG
        L3THYJPLMF1ZthIAyXtWVWRWYUEIcJNchssBWFQ=
X-Google-Smtp-Source: ABdhPJwlkBxKesDHI1VSjI0S6IOGvsqI3O8TXHjJ04sK0mb9jSFFfk5QiEuvwNbM+8+xSo4Rk85Lt3q1qmILX+JDLUg=
X-Received: by 2002:a25:2c4c:: with SMTP id s73mr384162ybs.230.1610046443964;
 Thu, 07 Jan 2021 11:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20210107173729.2667975-1-kpsingh@kernel.org>
In-Reply-To: <20210107173729.2667975-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Jan 2021 11:07:13 -0800
Message-ID: <CAEf4BzbxVtR+kaTFyHiH0tz3npr_vnpOidmG=t4sQAtaNE95UA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: local storage helpers should check nullness of
 owner ptr passed
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 9:37 AM KP Singh <kpsingh@kernel.org> wrote:
>
> The verifier allows ARG_PTR_TO_BTF_ID helper arguments to be NULL, so
> helper implementations need to check this before dereferencing them.
> This was already fixed for the socket storage helpers but not for task
> and inode.
>
> The issue can be reproduced by attaching an LSM program to
> inode_rename hook (called when moving files) which tries to get the
> inode of the new file without checking for its nullness and then trying
> to move an existing file to a new path:
>
>   mv existing_file new_file_does_not_exist

Seems like it's simple to write a selftest for this then?

>
> The report including the sample program and the steps for reproducing
> the bug:
>
>   https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com
>
> Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
> Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
> Reported-by: Gilad Reti <gilad.reti@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  kernel/bpf/bpf_inode_storage.c | 5 ++++-
>  kernel/bpf/bpf_task_storage.c  | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> index 6edff97ad594..dbc1dbdd2cbf 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -176,7 +176,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
>          * bpf_local_storage_update expects the owner to have a
>          * valid storage pointer.
>          */
> -       if (!inode_storage_ptr(inode))
> +       if (!inode || !inode_storage_ptr(inode))

would it be bad to move !inode check inside inode_storage_ptr itself?
same for task_storage_ptr() below.

>                 return (unsigned long)NULL;
>
>         sdata = inode_storage_lookup(inode, map, true);
> @@ -200,6 +200,9 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
>  BPF_CALL_2(bpf_inode_storage_delete,
>            struct bpf_map *, map, struct inode *, inode)
>  {
> +       if (!inode)
> +               return -EINVAL;
> +
>         /* This helper must only called from where the inode is gurranteed

Gmail highlights a typo in "gurranteed" ;)

>          * to have a refcount and cannot be freed.
>          */
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index 4ef1959a78f2..e0da0258b732 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -218,7 +218,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
>          * bpf_local_storage_update expects the owner to have a
>          * valid storage pointer.
>          */
> -       if (!task_storage_ptr(task))
> +       if (!task || !task_storage_ptr(task))
>                 return (unsigned long)NULL;
>
>         sdata = task_storage_lookup(task, map, true);
> @@ -243,6 +243,9 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
>  BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
>            task)
>  {
> +       if (!task)
> +               return -EINVAL;
> +
>         /* This helper must only be called from places where the lifetime of the task
>          * is guaranteed. Either by being refcounted or by being protected
>          * by an RCU read-side critical section.
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
