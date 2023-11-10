Return-Path: <bpf+bounces-14727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E3A7E7925
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34336B21052
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1705693;
	Fri, 10 Nov 2023 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU9Qds5a"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D94538F
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:20:34 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8AA6A41
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:20:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso11549715e9.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699597232; x=1700202032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjVYffylZmhLBFUmXFqsTta6wu0fWDXGP7AuU8zuWck=;
        b=hU9Qds5apbNYaNoR7CqdfniotBNnQB5pqMB9THMaBlYpjR4W1VCjGe+GpGc/AFKlyQ
         5HHcUqCwtT/m92BZF8H5fO9HDFly2af3XIngKRZHGYCGEp/jcNr4MXpzzngVNnpoZDbH
         44gKcsQDzMwFh4h7uGpmaKTImW896uRgctsaMCEDpa+bYCUCcHH+BukwP2ZFZZ/mN25x
         BQupE7vLP553EzwTHWVJrxBWEKlJJq3+erA4PXewRWOl5YzbdQeRecU2fyAp74GWs5Si
         OHj27bNmh8TYH/hgF9c2qCA8tj6yjtU2OSPtUqbBoWsGUWctAqLPZYlZuQdS4xEe8y8h
         nFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597232; x=1700202032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjVYffylZmhLBFUmXFqsTta6wu0fWDXGP7AuU8zuWck=;
        b=nssRbE/WQpb0vjmo1CDZIypPotvQerIbZFU0PBGlI6Ca9DKXg7SkGE2miKaObzgaKE
         FqrXywDBJC9+pq3mPE4V0yF17+Elup6AQjZWWgL9n0Ew8zrOnFeMj8vjbW8YZYfmyssi
         WLkNPS04HKDADbF/MN3ZgyneCoaOk3pYSF95FKDkXg5CDixdZM2ec5xipvHljdsQnRDX
         j3stexSv3enX+0s1xbXrdwHM9jhx+Ct8mFU3g9uxrWLNAuD3f8zre1BY8lrqZgmbMR03
         fC53LpzU2eAovV9F50cWfBHBmpiPffqPlAwI/c3biwt+qbAgmhYsCwxHurnnjJvNmGT4
         rILA==
X-Gm-Message-State: AOJu0Yx1HcybPbkdbC7ngJCXuUMu3IYzZBnK4J8EI+UE0UofzpNEv+59
	fskz2+D0RahlBboqkp7sjj7H+2Fl1b1LEUkOkTMhIKwT4ow=
X-Google-Smtp-Source: AGHT+IHxVmtlw1AQXIDb4+BsigBrpGioZnzSjK/+l3zpm/L71ZYu88ng/gFEAvczh+VEB6sWZAU8D2jbNejU9Um6TJQ=
X-Received: by 2002:a17:907:da4:b0:9b9:faee:4228 with SMTP id
 go36-20020a1709070da400b009b9faee4228mr5933847ejc.56.1699595528774; Thu, 09
 Nov 2023 21:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109092838.721233-1-jolsa@kernel.org> <20231109092838.721233-3-jolsa@kernel.org>
In-Reply-To: <20231109092838.721233-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 21:51:57 -0800
Message-ID: <CAEf4Bzbf0_LYGzzv_dp=3dtRnAjA_nwTkMbZwyjGkycdonXaUw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/6] bpf: Store ref_ctr_offsets values in
 bpf_uprobe array
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:29=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We will need to return ref_ctr_offsets values through link_info
> interface in following change, so we need to keep them around.
>
> Storing ref_ctr_offsets values directly into bpf_uprobe array.
>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/trace/bpf_trace.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d525a22b8d56..52c1ec3a0467 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3035,6 +3035,7 @@ struct bpf_uprobe_multi_link;
>  struct bpf_uprobe {
>         struct bpf_uprobe_multi_link *link;
>         loff_t offset;
> +       unsigned long ref_ctr_offset;
>         u64 cookie;
>         struct uprobe_consumer consumer;
>  };
> @@ -3174,7 +3175,6 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>  {
>         struct bpf_uprobe_multi_link *link =3D NULL;
>         unsigned long __user *uref_ctr_offsets;
> -       unsigned long *ref_ctr_offsets =3D NULL;
>         struct bpf_link_primer link_primer;
>         struct bpf_uprobe *uprobes =3D NULL;
>         struct task_struct *task =3D NULL;
> @@ -3247,18 +3247,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>         if (!uprobes || !link)
>                 goto error_free;
>
> -       if (uref_ctr_offsets) {
> -               ref_ctr_offsets =3D kvcalloc(cnt, sizeof(*ref_ctr_offsets=
), GFP_KERNEL);
> -               if (!ref_ctr_offsets)
> -                       goto error_free;
> -       }
> -
>         for (i =3D 0; i < cnt; i++) {
>                 if (ucookies && __get_user(uprobes[i].cookie, ucookies + =
i)) {
>                         err =3D -EFAULT;
>                         goto error_free;
>                 }
> -               if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], ur=
ef_ctr_offsets + i)) {
> +               if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_off=
set, uref_ctr_offsets + i)) {
>                         err =3D -EFAULT;
>                         goto error_free;
>                 }
> @@ -3289,7 +3283,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         for (i =3D 0; i < cnt; i++) {
>                 err =3D uprobe_register_refctr(d_real_inode(link->path.de=
ntry),
>                                              uprobes[i].offset,
> -                                            ref_ctr_offsets ? ref_ctr_of=
fsets[i] : 0,
> +                                            uprobes[i].ref_ctr_offset,
>                                              &uprobes[i].consumer);
>                 if (err) {
>                         bpf_uprobe_unregister(&path, uprobes, i);
> @@ -3301,11 +3295,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>         if (err)
>                 goto error_free;
>
> -       kvfree(ref_ctr_offsets);
>         return bpf_link_settle(&link_primer);
>
>  error_free:
> -       kvfree(ref_ctr_offsets);
>         kvfree(uprobes);
>         kfree(link);
>         if (task)
> --
> 2.41.0
>

