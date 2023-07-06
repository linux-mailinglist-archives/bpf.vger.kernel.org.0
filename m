Return-Path: <bpf+bounces-4344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1374A709
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154E51C20E8B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC3C16418;
	Thu,  6 Jul 2023 22:29:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F567AD44
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:29:23 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF81510F5
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:29:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso13328375e9.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688682560; x=1691274560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a48OCGW6nrUbhLvghFZCwrojG6ZOgkTfn+EONeie7Fs=;
        b=BTp0+1WTiDZ4NOLPpmY3c3KYNASZo4GD9XKK7bjBYQA0YOJ8xeZBHvli9hA8krTqE2
         6QF/jPxovm5SN2KHGAEVnxTzq/3GqK3zVv8mZsYbILPr1eHSJKfFz4f5Yy6gJzYXVNM3
         aeodLZOhHe2lEFd6FBBxWrXylRH//Ev3kWXyzgrdWfG3CRIwb1Gyq7oowvuwbphNPwpV
         2hvAD/LA1WeFxLd5U7cCwDaLXfFsipXuseLOBcOjPSbOGAZdp4Grnclz9VwTspv0/OoO
         j1Qu7l1MKqrR3fJ+QDLQz0LXksaVcj7zPvXPcJ3rMnWc+Vtb9IQe7lQVPWvNf9bK8mrB
         PyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688682560; x=1691274560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a48OCGW6nrUbhLvghFZCwrojG6ZOgkTfn+EONeie7Fs=;
        b=C+zJGyyxGBGwAEXw8bWFssDHTv7UzmhDC/IG66ZRI66zlS+FqXwaGwkfpCuOQIPBgl
         D3ZoAM3A9wJHta4gUyZs2+nff1vW6i46EJaDUeqGU1ZiujK8CZjgkrn7uVT+HKdB7qnd
         lItjkehz304g+ZeaU9lNNB4MrVv/NUIR5lFVCpBf6sg7VPDq9H1OxQgvr6hWSSj2PL9V
         yOew2dpNsg5gJFrqDV0It412/UKTvtuHaYzYsoy5e2cVie1EGcSE7AaAMZtciir+aqzV
         Ug9usFQ85QZ7AoRrTK0F9n8pmw05GTkDY3p1UErIzdm+3vDQdRh+LQI5XS0Aao/zBwu0
         4d8Q==
X-Gm-Message-State: ABy/qLZJ7JrFCFFj3gIFkoGQ+A5v8renPwHGAUszfr2SiFIrzxe9cKBC
	IF67QDHJZpvuRm9NAle3Db/jIBapgYcraTEye7w=
X-Google-Smtp-Source: APBJJlGKeDvyxu0EVti3KBZmqUKH85MgocTgDMAawZzmz1Nk7xMfJ2bH3mO3Z1DM45MHEzxAdNepT9OeT91s9Lmb5MA=
X-Received: by 2002:a05:600c:2054:b0:3fb:fea1:affa with SMTP id
 p20-20020a05600c205400b003fbfea1affamr48237wmg.37.1688682560086; Thu, 06 Jul
 2023 15:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-6-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 15:29:08 -0700
Message-ID: <CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 05/26] bpf: Add bpf_get_func_ip helper support
 for uprobe link
To: Jiri Olsa <jolsa@kernel.org>, "jordalgo@meta.com" <jordalgo@meta.com>, "ajor@meta.com" <ajor@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 1:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for bpf_get_func_ip helper being called from
> ebpf program attached by uprobe_multi link.
>
> It returns the ip of the uprobe.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>

A slight aside related to bpf_get_func_ip() support in
uprobe/uretprobe. We just had a conversation with Alastair and Jordan
(cc'ed) about bpftrace and using bpf_get_func_ip() there with
uretprobes, and it seems like it doesn't work.

Is that intentional or we just missed that bpf_get_func_ip() doesn't
work with uprobes/uretprobes? Do you think it would be hard to add
support for them for bpf_get_func_ip()? It's a very useful helper,
would be nice to have it working in all cases where it has meaningful
behavior (and I think it does for uprobe and uretprobe).

Thanks!

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4ef51fd0497f..f5a41c1604b8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -88,6 +88,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *=
ctx);
>  static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
>

[...]

