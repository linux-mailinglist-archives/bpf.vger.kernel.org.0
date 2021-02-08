Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F992314127
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 22:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhBHVBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 16:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhBHVBa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 16:01:30 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A17CC061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 13:00:40 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id i71so15976089ybg.7
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 13:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJ7D8zrNRbV1x3s1jebH7uco1/OALvok7U18Lk9J6s4=;
        b=DuFXhgJXYqJN4/S3isLLk8lLNIObjVzlSotrrzCsjQ6ZrUSvrevTHK9npIcZDWI7kf
         8Bt4bGq6mBUVANV24XFDAr4zwnSpdqihqkaRf8K+nLy8uQlMvl7StafczQ6rsnxIzji1
         R9Orkj6t4MWFuzyfySxh3U4GI6WtP3EzwvpSXq1HwtFnespbl1i5W3dhwSfIkVVgZLVw
         ZV7SYingjuxovLxFTSdL11KfANA/DLmTRHKYGpSmUykY3OnTkyVvKD6flB8qb/BXd0pe
         aSwVoJVZ5WXImDJh+Uc+vGytLEyIEGiGoVzs2OoTA2DMdJi10W/AimKkBZYssoS+Julp
         PrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ7D8zrNRbV1x3s1jebH7uco1/OALvok7U18Lk9J6s4=;
        b=Yf+APyUjSFFSGMkrFGiu/tEIZpNwCt1exLyX0F6Gave6afP/adORUrUL5Sej2VZChO
         BCHDOz+v8+s0wnvZuT5QIaf4DVayWdX0ytq59cCNohX46DRWHZNWZ3dv0aL9yGML2kqM
         LVNFuST3EMjILOeDu8P8HaZ+NcN1Qw5CvBA1BOGzxxjWnZF80HDSkFFq3vTl4eMkKYZK
         BniSHA6DfHXlVApD9lNQZ+OX4yd3+QxROo8TGZkxlMG6XYgo/sRZgIqXfYBtW3CPC+EE
         6p0GYiaPiRG6vXWmT5OODg9uTHhKphFMJF24nQ6t3GpjsH97m0RHuzrRWpMgpqpetodi
         2xhQ==
X-Gm-Message-State: AOAM533Ftx3e6zCnNDfLN6X4pH3h4JkU+dP+kl8DldOq2FzrYqoZQ49u
        Lt7VbeAdoEbUMXx1f/x2jjaH9fQnjtdvUH7x3jc=
X-Google-Smtp-Source: ABdhPJzbV64EhOKYM+19S8SMFfeKb/n9AUEm0bHHZUCx2c/L2UjEJvvdNVhO+4tt9khcHX1tjaO+IA90sCFyfZv1ivI=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr28260663ybd.230.1612818039475;
 Mon, 08 Feb 2021 13:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com> <20210206170344.78399-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20210206170344.78399-7-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 13:00:28 -0800
Message-ID: <CAEf4BzaAvDYU4jD8N=CziaRAXnEsvU1QYSa=-x8Q-Sv7iOTdtw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/7] bpf: Allows per-cpu maps and map-in-map
 in sleepable programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 9:06 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Since sleepable programs are now executing under migrate_disable
> the per-cpu maps are safe to use.
> The map-in-map were ok to use in sleepable from the time sleepable
> progs were introduced.
>
> Note that non-preallocated maps are still not safe, since there is
> no rcu_read_lock yet in sleepable programs and dynamically allocated
> map elements are relying on rcu protection. The sleepable programs
> have rcu_read_lock_trace instead. That limitation will be addresses
> in the future.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Great.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/hashtab.c  | 4 ++--
>  kernel/bpf/verifier.c | 7 ++++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c1ac7f964bc9..d63912e73ad9 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1148,7 +1148,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
>                 /* unknown flags */
>                 return -EINVAL;
>
> -       WARN_ON_ONCE(!rcu_read_lock_held());
> +       WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
>
>         key_size = map->key_size;
>
> @@ -1202,7 +1202,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>                 /* unknown flags */
>                 return -EINVAL;
>
> -       WARN_ON_ONCE(!rcu_read_lock_held());
> +       WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
>
>         key_size = map->key_size;
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4189edb41b73..9561f2af7710 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10020,9 +10020,14 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>                 case BPF_MAP_TYPE_HASH:
>                 case BPF_MAP_TYPE_LRU_HASH:
>                 case BPF_MAP_TYPE_ARRAY:
> +               case BPF_MAP_TYPE_PERCPU_HASH:
> +               case BPF_MAP_TYPE_PERCPU_ARRAY:
> +               case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +               case BPF_MAP_TYPE_ARRAY_OF_MAPS:
> +               case BPF_MAP_TYPE_HASH_OF_MAPS:
>                         if (!is_preallocated_map(map)) {
>                                 verbose(env,
> -                                       "Sleepable programs can only use preallocated hash maps\n");
> +                                       "Sleepable programs can only use preallocated maps\n");
>                                 return -EINVAL;
>                         }
>                         break;
> --
> 2.24.1
>
