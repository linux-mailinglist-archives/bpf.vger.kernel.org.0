Return-Path: <bpf+bounces-680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39271705A90
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 00:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA86281378
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 22:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE3D2720F;
	Tue, 16 May 2023 22:28:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6B101C0
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 22:28:08 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8135BBE
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 15:28:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso4039971a12.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684276085; x=1686868085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk1czeaCkGbD+IrEe/YkKcbhx9f+njqF0DzONApq5LI=;
        b=ZqCS5KedQ/646bzFZtNeCdZbSYBGfxw1AQhV2o5XgmdblPOnciHTZaPSekpAMheLuv
         1FVFOYsI08jQWZdsmeLuQ/2dsKi5Dtgpxz7dLNyJk9LlFRek2X+MBGFcHFoF0udKLFF8
         b56uzcMBgRPXLCEEGhSESJLjk0vuTQSil8jQUYSCpDKoPTjiwEAs75fime75XhkdR6gJ
         OpFu6ReSCuhfTB2M8UIxdO9XHbiRmk5YaxYpfVTkqONoQBCHrepgtm2G1wHGiYlpSoKt
         kZZ+jJTXZDLNvCQn1dxj/2jtHABnZM8GczfcP+PZXF4+0dI+ougvjdacf6KTcHyJf8m7
         ehug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276085; x=1686868085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk1czeaCkGbD+IrEe/YkKcbhx9f+njqF0DzONApq5LI=;
        b=J6KgIcBwrBBgn24jcjmu7oTc4pYovFv0YOXCwJkYm9MrV0rFs3s5/26gChvjDFi+sf
         UDMgPtwIHCU8UCyU7Lja/B+geI/5MSVFAWPUlIf+bBeVEr1nS4L/JCHr4sJFwwzY5zT+
         QwU6vu0jtLSCSnR7TkdXYsMVDFIXDliiCZ+MeVB/XNmAvcgZKJtlytfcIJPmUOwsNRcA
         I4+luPjVHO+lRG+GmpcjBX4J4HnzzgH7xhsBXvJPzmgLo3A4GiiyhlVc44hiWKkA/1ZF
         6OKcvXIA1B0icz9phEHToXiIjeqc4YD0CJMYTrTyErgY5oAAEOrnro3YT9RPlpktXEAm
         wVAg==
X-Gm-Message-State: AC+VfDwQAXHR3FWSJsA3jyQdwsNRsVEgwBS9NK98S2pGEiG6rteMpWKm
	eMS7p9ZtiPBTd4X3GpaZvsaHRKLBLze9StL0GVs=
X-Google-Smtp-Source: ACHHUZ7WENMpBPGgZYNf8W9uMPa0PasZ23HixLD5AAZqh+LJmGnvK7ettqqvae9Q+P87pmGybTDKgva6VdSaZApwTn8=
X-Received: by 2002:a17:907:d24:b0:94a:4e86:31bc with SMTP id
 gn36-20020a1709070d2400b0094a4e8631bcmr281598ejc.13.1684276085108; Tue, 16
 May 2023 15:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516123926.57623-1-laoar.shao@gmail.com> <20230516123926.57623-2-laoar.shao@gmail.com>
In-Reply-To: <20230516123926.57623-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 15:27:53 -0700
Message-ID: <CAEf4Bza=ujh+HzoT4V3bc7gjAH92veg0Ez_vBqszm7qETk6SMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Show target_{obj,btf}_id in tracing
 link fdinfo
To: Yafang Shao <laoar.shao@gmail.com>
Cc: song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kafai@fb.com, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 5:39=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The target_btf_id can help us understand which kernel function is
> linked by a tracing prog. The target_btf_id and target_obj_id have
> already been exposed to userspace, so we just need to show them.
>
> The result as follows,
>
> $ cat /proc/10673/fdinfo/10
> pos:    0
> flags:  02000000
> mnt_id: 15
> ino:    2094
> link_type:      tracing
> link_id:        2
> prog_tag:       a04f5eef06a7f555
> prog_id:        13
> attach_type:    24
> target_obj_id:  1
> target_btf_id:  13964
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/syscall.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 909c112..870395a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2968,10 +2968,18 @@ static void bpf_tracing_link_show_fdinfo(const st=
ruct bpf_link *link,
>  {
>         struct bpf_tracing_link *tr_link =3D
>                 container_of(link, struct bpf_tracing_link, link.link);
> +       u32 target_btf_id;
> +       u32 target_obj_id;

nit: combine on a single line?

>
> +       bpf_trampoline_unpack_key(tr_link->trampoline->key,
> +                                                         &target_obj_id,=
 &target_btf_id);

formatting seems odd?...


>         seq_printf(seq,
> -                  "attach_type:\t%d\n",
> -                  tr_link->attach_type);
> +                  "attach_type:\t%d\n"
> +                  "target_obj_id:\t%u\n"
> +                  "target_btf_id:\t%u\n",
> +                  tr_link->attach_type,
> +                  target_obj_id,
> +                  target_btf_id);
>  }
>
>  static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
> --
> 1.8.3.1
>

