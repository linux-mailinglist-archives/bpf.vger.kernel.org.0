Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82C2AFD2C
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgKLBcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgKLBBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 20:01:41 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B114EC0613D6
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 17:01:40 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so4209185ljk.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 17:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vj0T9jCxvL9rbvqFxOX6yy1sKsEXWVTpaVdI8wUxbqQ=;
        b=dJFMPfX272QV6ESoGr0BE2Q1Z4A2wgZDODphLfdmXAKGlI1KURMxjYxuywbI/ZElF3
         1PIb1ELFnoYmkLNVkM0IQSsrWfRzneV+iq6GiY8yToXDnBVM1lLEvJ8YliZOVlX/ly4A
         QY7kk91jQ1ihQrLQNvJxZ2sclM7O64PFyFZwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vj0T9jCxvL9rbvqFxOX6yy1sKsEXWVTpaVdI8wUxbqQ=;
        b=OBNmHVvstfG8Ps6y/zthe9ftxx/94lGBvxnXvTWzpPTdLkvryPv+LXxGAmc8fYHnPz
         3bURtrIhsqrcqT1bVppfPzCJQBio0PAv3+/NUhtEYevZgbz0dYlkEEmElhrlU1TWtAxv
         r4S91SFDEWEIE8gpzwJdYLrkXUcvVHndP8Pz3MJMUkQtbhTl+mBOuwaqjzXJzI+Dvysa
         EwzNwaCGuh4x++KYWKyym1PpPb4SHWkKFKiIaDb9AdhzvkToQiTTTj/qXUTy0WRrSIy9
         6CMm59DoXZBV7PKILWsRoLYPpqdsuC5nMfFIdTKh6ee66ACh9yfT06PCMCtesUuPNHcM
         ZmLw==
X-Gm-Message-State: AOAM533fcNnqIL3BjvAKdiPMNErLHyToCnXgSN+6epWn8Aw/oJxkkCqo
        xo6jJwVE7+hkbg77DuM5f8xZCAUZst82d9nhNU6EKA==
X-Google-Smtp-Source: ABdhPJzmNCkYHPo9pNcHfEG79wIs4dcKeol0ZqLte7SnWm62D5av7SPF4ODgtR5h5w8u7F6sA7p0mFTIX5U8OO6r30c=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr1511433ljj.110.1605142899143;
 Wed, 11 Nov 2020 17:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20201112001919.2028357-1-kafai@fb.com>
In-Reply-To: <20201112001919.2028357-1-kafai@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 12 Nov 2020 02:01:28 +0100
Message-ID: <CACYkzJ7RTsZz3tRxCgMrh0WNu-RZJQWQ+H4+KKbV=Bz=T0SCbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix NULL dereference in bpf_task_storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 1:19 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> In bpf_pid_task_storage_update_elem(), it missed to
> test the !task_storage_ptr(task) which then could trigger a NULL
> pointer exception in bpf_local_storage_update().
>
> Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
> Tested-by: Roman Gushchin <guro@fb.com>
> Cc: KP Singh <kpsingh@chromium.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: KP Singh <kpsingh@google.com>

Thanks for fixing this!  I had it in v1 and while actioning:

  https://lore.kernel.org/bpf/20201028011321.4yu62347lfzisxwy@kafai-mbp

I inadvertently removed it from bpf_pid_task_storage_update_elem too.



> ---
>  kernel/bpf/bpf_task_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index 39a45fba4fb0..4ef1959a78f2 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -150,7 +150,7 @@ static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
>          */
>         WARN_ON_ONCE(!rcu_read_lock_held());
>         task = pid_task(pid, PIDTYPE_PID);
> -       if (!task) {
> +       if (!task || !task_storage_ptr(task)) {
>                 err = -ENOENT;
>                 goto out;
>         }
> --
> 2.24.1
>
