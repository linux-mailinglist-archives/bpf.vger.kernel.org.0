Return-Path: <bpf+bounces-78434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D630D0CA30
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 01:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF8AF300FBFC
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27FC1F09A5;
	Sat, 10 Jan 2026 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPfvlhZl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283641DDC28
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005416; cv=none; b=dCaZX9v4UgamvUazWw0zjs/hos73mYLaNQshbEc6eDyL8MswTBll+T2pWESbYHqPpAvay+1XcqJOCyLFWQJISycNMgwu/yzI6nwScybiDjBqDJGywLmYSF4DPrFWbMVQcxchBSrw2dduyFSe1+tOzHkLJGQkyv7tpdzzniykbdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005416; c=relaxed/simple;
	bh=qLjmFngL2lpBaKabuTDzsU4j7Y2e7O5Rz23xDOBslZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ig/UZwn9xt3zWIQSxL+djL9tQSBOhP9rZQ/Z/hbQ1qExuSOM6LuW1gZBiZPeRJY7iB2loDZvv1wUqGmr/3n9JisRHY8HZJHk83eNJFWHDxPBvy/0Lp+iRtl+B5vLYqrlDPZLwtNJpm5cuTOm7CtDnKBCffJLFdIon/c9yRGApu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPfvlhZl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bc0d7255434so2192505a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 16:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768005413; x=1768610213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xfM0Rfu3A5cPqn5pc0s1J4LLhtoigHkOk+JZgFzv3k=;
        b=FPfvlhZlDmfJkJxbcDfZVBfefbx1fUVtlhnbaQtNbnLHAepeUWRS8YFsFIaVe61P/9
         T9+MqL2hmEyk+miEP4cee/PZwQi8VCpTBW5iX5WjIaFFV2mFMhH7/ndYmw3nOVkOSJnQ
         H9HPaMRhniyYrmMu8LSQ7W0yQDZ1aX0tW7A6QE1aZj8eIojMiuO7EhI08jjX7wgqUXy9
         1D9PgIOpmeIiwcz48bpaatSMKZo+2bYF3nmg65+SvUHY17xm47M0igg9gN83kIU9Flqn
         tQPEthpHSEF+iZrkW17jhlyKwP3ImVNUv7mtct6DztC51sgLt1PySOvg7mtSPBzuek5A
         xFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768005413; x=1768610213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xfM0Rfu3A5cPqn5pc0s1J4LLhtoigHkOk+JZgFzv3k=;
        b=gxAx5Fvq/+TmpIl0/bHr6F+NsDvCcNtOe1dMxNPvLdY7I/A7dMSi2tCw1f8me4gweb
         t1o914yl0vlL3Cnd/MKli1n31YLFmIrLF31nW/jUMkZ8VYwr1KkOHS2KoiTbhfaycLzN
         9sESC6YXZlC0MtUQ67nCHZUt64Q4J7Y9rVMmMFYccb6tRh5Qp+QGywsCpSl/6PL8v3yK
         ptaZXrQ4JkfRdTiXkbPrn8Z8oYMmbVnSfIn01PxFNnYYEE2eCJEpVBpvpbEAuKnCz6jR
         gS3yR3E/TwA0J1/KZyO3agdG5RjZyHGwPNaPoCs5puc3o4ORzLr48sR7vxVp/ODt01JW
         FHGA==
X-Forwarded-Encrypted: i=1; AJvYcCUrC6N3gNe2Ch92hxOnfO+ov95VSZs+1pAPS5fJko62O+K2DHyRp/upQhHqKwKKna+AMjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydtr8IzGUh2OPJosSHHQeuv0KDz/PqA7UKEL0ATrUu2OlEzz2M
	Tr6ZZyexNS7vyfMsYuaA4GaO6ZYWhU82CMk3n+qCCxr4/0yKdKVTwNGwJfmoUSZb71UVi9mESQW
	KCOe1Bfdo0j3oIRPV8JRxtZCLPyfuyIs=
X-Gm-Gg: AY/fxX7rq5zEkpHWQMOr2/P9bArIhl108DvtToA0RTM2XmQ3KQKsopNsYEwt5nZg3Sq
	0xwUZg/qfrVmJnZdOQAKDJN6UEFW2RKA9ZxD0MMKmnUVdpUzITjYqb6QgYI9uPlVjqwkEY0IbLZ
	q2FbqsjRxlj4SPeLKZFgFi2yQKKXqwayNHiiLWPKIi7ybwmexclc99p3EIxLUOMYY1IquZOtSUs
	T8oHtRoKeAl26KXNIFJaYvImS0gcv2zjzx8fW+dDBZcjezNXnLj/62C+XDjMGKZ65wkAmhceFsG
	GdESw98e
X-Google-Smtp-Source: AGHT+IGuujBpONry1gvgsQzsvJXudiQyMGBcQwh475VUNcINJSDIO8LkyvpNvKKLPS3N+zwKEoYGeXXz/tJgdhtuXz8=
X-Received: by 2002:a05:6a20:7486:b0:35f:b243:46cb with SMTP id
 adf61e73a8af0-3898f8f4c75mr12372471637.12.1768005413568; Fri, 09 Jan 2026
 16:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230145010.103439-1-jolsa@kernel.org> <20251230145010.103439-8-jolsa@kernel.org>
In-Reply-To: <20251230145010.103439-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 16:36:41 -0800
X-Gm-Features: AQt7F2rtiT73HgLTPQ6UI1koaE9wmnP8DTvaic0PVhGcL9KRoTH943ScnrAVW1o
Message-ID: <CAEf4BzYgqWXoKTffa5Y6Xm-nPbL9aFgrStR0GfUs4-88f10EgQ@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 7/9] bpf: Add trampoline ip hash table
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:51=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Following changes need to lookup trampoline based on its ip address,
> adding hash table for that.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h     |  7 +++++--
>  kernel/bpf/trampoline.c | 30 +++++++++++++++++++-----------
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4e7d72dfbcd4..c85677aae865 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1325,14 +1325,17 @@ struct bpf_tramp_image {
>  };
>
>  struct bpf_trampoline {
> -       /* hlist for trampoline_table */
> -       struct hlist_node hlist;
> +       /* hlist for trampoline_key_table */
> +       struct hlist_node hlist_key;
> +       /* hlist for trampoline_ip_table */
> +       struct hlist_node hlist_ip;
>         struct ftrace_ops *fops;
>         /* serializes access to fields of this trampoline */
>         struct mutex mutex;
>         refcount_t refcnt;
>         u32 flags;
>         u64 key;
> +       unsigned long ip;
>         struct {
>                 struct btf_func_model model;
>                 void *addr;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 789ff4e1f40b..bdac9d673776 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -24,9 +24,10 @@ const struct bpf_prog_ops bpf_extension_prog_ops =3D {
>  #define TRAMPOLINE_HASH_BITS 10
>  #define TRAMPOLINE_TABLE_SIZE (1 << TRAMPOLINE_HASH_BITS)
>
> -static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
> +static struct hlist_head trampoline_key_table[TRAMPOLINE_TABLE_SIZE];
> +static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
>
> -/* serializes access to trampoline_table */
> +/* serializes access to trampoline tables */
>  static DEFINE_MUTEX(trampoline_mutex);
>
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> @@ -135,15 +136,15 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
>                            PAGE_SIZE, true, ksym->name);
>  }
>
> -static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
> +static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned lo=
ng ip)
>  {
>         struct bpf_trampoline *tr;
>         struct hlist_head *head;
>         int i;
>
>         mutex_lock(&trampoline_mutex);
> -       head =3D &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
> -       hlist_for_each_entry(tr, head, hlist) {
> +       head =3D &trampoline_key_table[hash_64(key, TRAMPOLINE_HASH_BITS)=
];
> +       hlist_for_each_entry(tr, head, hlist_key) {
>                 if (tr->key =3D=3D key) {
>                         refcount_inc(&tr->refcnt);
>                         goto out;
> @@ -164,8 +165,12 @@ static struct bpf_trampoline *bpf_trampoline_lookup(=
u64 key)
>  #endif
>
>         tr->key =3D key;
> -       INIT_HLIST_NODE(&tr->hlist);
> -       hlist_add_head(&tr->hlist, head);
> +       tr->ip =3D ftrace_location(ip);
> +       INIT_HLIST_NODE(&tr->hlist_key);
> +       INIT_HLIST_NODE(&tr->hlist_ip);
> +       hlist_add_head(&tr->hlist_key, head);
> +       head =3D &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BIT=
S)];

For key lookups we check that there is no existing trampoline for the
given key. Can it happen that we have two trampolines at the same IP
but using two different keys?



> +       hlist_add_head(&tr->hlist_ip, head);
>         refcount_set(&tr->refcnt, 1);
>         mutex_init(&tr->mutex);
>         for (i =3D 0; i < BPF_TRAMP_MAX; i++)
> @@ -846,7 +851,7 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_pro=
g *prog)
>                                          prog->aux->attach_btf_id);
>
>         bpf_lsm_find_cgroup_shim(prog, &bpf_func);
> -       tr =3D bpf_trampoline_lookup(key);
> +       tr =3D bpf_trampoline_lookup(key, 0);
>         if (WARN_ON_ONCE(!tr))
>                 return;
>
> @@ -866,7 +871,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>  {
>         struct bpf_trampoline *tr;
>
> -       tr =3D bpf_trampoline_lookup(key);
> +       tr =3D bpf_trampoline_lookup(key, tgt_info->tgt_addr);
>         if (!tr)
>                 return NULL;
>
> @@ -902,7 +907,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>          * fexit progs. The fentry-only trampoline will be freed via
>          * multiple rcu callbacks.
>          */
> -       hlist_del(&tr->hlist);
> +       hlist_del(&tr->hlist_key);
> +       hlist_del(&tr->hlist_ip);
>         if (tr->fops) {
>                 ftrace_free_filter(tr->fops);
>                 kfree(tr->fops);
> @@ -1175,7 +1181,9 @@ static int __init init_trampolines(void)
>         int i;
>
>         for (i =3D 0; i < TRAMPOLINE_TABLE_SIZE; i++)
> -               INIT_HLIST_HEAD(&trampoline_table[i]);
> +               INIT_HLIST_HEAD(&trampoline_key_table[i]);
> +       for (i =3D 0; i < TRAMPOLINE_TABLE_SIZE; i++)
> +               INIT_HLIST_HEAD(&trampoline_ip_table[i]);
>         return 0;
>  }
>  late_initcall(init_trampolines);
> --
> 2.52.0
>

