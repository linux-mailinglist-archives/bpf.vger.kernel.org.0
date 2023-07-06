Return-Path: <bpf+bounces-4337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE1F74A67A
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6701D1C20E60
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51ED15AEF;
	Thu,  6 Jul 2023 22:00:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF81872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:00:43 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DF1FC1;
	Thu,  6 Jul 2023 15:00:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso13718895e9.2;
        Thu, 06 Jul 2023 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688680839; x=1691272839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJMdyJkJ1mr8FBDXUnVbesfT+m0E5CU75mKK+JpWXZM=;
        b=OUhtPgDl2e/XhW1R7zEMjRwTn3ZbTObDqgIPfzYXgC0Fn1FIqDn6Kxf7tChlcy/Aez
         0u4any6LVIcSi8bUv7ZhOPbnF/QET8xKJyA8TTRHBRC46gF1LrBe4L/Vwp57qsoOPLrO
         JBPh/LvQZz+BPO/lHvNLpF7G2bAOYSBVq4ZXr03gjxbHOZmhvoeDH/5oCN3aK4k7MjJp
         kLZMb3ycrKx8zfYrViCUvf/BUD9qqtnXkZKvYrWf9EUkzqZv0lQ5OKpyxVlvlZw00A64
         5L9N5126yiDBRAwJ3Ui5cnMampD/wNqSZl9RorEnsYbhPfqZoT2hm+1tKJ6XNxsaHRua
         AcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688680839; x=1691272839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJMdyJkJ1mr8FBDXUnVbesfT+m0E5CU75mKK+JpWXZM=;
        b=HqJgiH9VpoaLXTKQ+88MYng1/Y5t4ADW3D78s4Rl+6yJwv5f6QY6vsSKyl00tfXRV3
         SeUJl7HrQJovPRtPn1OWG0vJLBDlWqSLn1QePhwSiqOQxV7TyElAMPmTvXnZl0jM4s51
         xvVIj0+JGRsnTYmCKj7/x1SpIKW6Hf8HEb0/gzy0EfNnLA6LQBMugRrP0OtqaROG4j4e
         WAwlbBG99GasNLb03kAtR+yWbWyWdRUoxX1PfUo3ADI841w8gD7jlBpKN3tQRRBr9Qdw
         296Y0Wo8Q9ejGUl2e0iHP4fo3bkAJa7XzdEjnQFf2eNS7fkK79aHVDKi3nCZvrZEhYV1
         XojQ==
X-Gm-Message-State: ABy/qLZWFD/kzb4nzwIRKgrrQfcmICFxwPSwvTDzmBbf0PWuCHyuSLh+
	7puiLIsVzEsGEoeF0uR7pItqWkh10s62Gj9RyxY=
X-Google-Smtp-Source: APBJJlH1rJzs216rPJjjCDCxYxXYu6xV0enaNZ0w5EBsw/TR+Z7VCLylZxbjpjOdyXHQDX5KOdHaH1tCyd7/cRY6Zwc=
X-Received: by 2002:a7b:c019:0:b0:3fa:973e:2995 with SMTP id
 c25-20020a7bc019000000b003fa973e2995mr2422304wmb.12.1688680838627; Thu, 06
 Jul 2023 15:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-9-laoar.shao@gmail.com>
In-Reply-To: <20230628115329.248450-9-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 15:00:26 -0700
Message-ID: <CAEf4BzYOQQHFo6OwRb4ORsCq0iqYRp=MtVFNeGgSW9NCMrdnAw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 08/11] bpf: Add bpf_perf_link_fill_common()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 4:53=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add a new helper bpf_perf_link_fill_common(), which will be used by
> perf_link based tracepoint, kprobe and uprobe.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/syscall.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4aa6e5776a04..72de91beabbc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3364,6 +3364,40 @@ static void bpf_perf_link_dealloc(struct bpf_link =
*link)
>         kfree(perf_link);
>  }
>
> +static int bpf_perf_link_fill_common(const struct perf_event *event,
> +                                    char __user *uname, u32 ulen,
> +                                    u64 *probe_offset, u64 *probe_addr,
> +                                    u32 *fd_type)
> +{
> +       const char *buf;
> +       u32 prog_id;
> +       size_t len;
> +       int err;
> +
> +       if (!ulen ^ !uname)
> +               return -EINVAL;
> +       if (!uname)
> +               return 0;
> +
> +       err =3D bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
> +                                     probe_offset, probe_addr);
> +       if (err)
> +               return err;
> +
> +       len =3D strlen(buf);
> +       if (buf) {

if buf is NULL, strlen above will crash, so you need to calculate len
inside this if branch


> +               err =3D bpf_copy_to_user(uname, buf, ulen, len);
> +               if (err)
> +                       return err;
> +       } else {
> +               char zero =3D '\0';
> +
> +               if (put_user(zero, uname))
> +                       return -EFAULT;
> +       }
> +       return 0;
> +}
> +
>  static const struct bpf_link_ops bpf_perf_link_lops =3D {
>         .release =3D bpf_perf_link_release,
>         .dealloc =3D bpf_perf_link_dealloc,
> --
> 2.39.3
>

