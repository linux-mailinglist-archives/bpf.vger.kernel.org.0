Return-Path: <bpf+bounces-4336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFBC74A679
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E2F2814A0
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA215AEB;
	Thu,  6 Jul 2023 22:00:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA901872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:00:37 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B4B1BF0;
	Thu,  6 Jul 2023 15:00:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso13908345e9.0;
        Thu, 06 Jul 2023 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688680834; x=1691272834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTNk28msNnXIhTeY8JE4dqW9N4O9yyFjR9BGrXnP200=;
        b=qxbUnkkzv6bYgldbUdVSx64dCN+a1fGjMNyoyYxfT6vheyOutcdDzDkvu87T1WFXgh
         o1hXLuyXOtTPwI3fmvnpS35BNGqOrcN7illBn2gg/vCH6+S8lSZKAb9gaww7Pwab1Hr3
         QXTpwfojJqroUbO8tW+zEsxRIwDbvCN9BWr9CY3QzAquCcgvwyDcjR/rmMXkuJ3c32mx
         yhedXe/vVi98JJ+MqwsihN5Ba3EDAVbcqPk6iLfrKxkvHmRjEi4PTzfFtfPXbvxqn36f
         HgrW+N4tfHXsHnRGwT/weet/useDuQWkDXm1t0/JgmZ1caQgS5WNZFHK2G/DmJG9bLLY
         S70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688680834; x=1691272834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTNk28msNnXIhTeY8JE4dqW9N4O9yyFjR9BGrXnP200=;
        b=aIHZtIw/5Pw8RJxU1w018Hdpnk+mhOAfMp/XTOJxwKXqDBbvcc5JBrAfqiJ+jvFwWc
         gaGb9Lvc8Q7hdqKXhvItgAZOti8yspc7mToAAYsJEYXjPnyKWdb5pDSl8rCcB8vq5Brk
         6blvZA1JNZGoWX11OSmY6IGoesbA0hgTSkTBx20WBiutyDb4VCa0tEQzIbZCgrz+sSku
         kcXQsM1dB9hgktWsP10IVFBvhuTWd9NySHdE1pw5xfyXQyhMQw+2unLSBfMgTBuryGRu
         CASm8Q6K49NHBqBpfVUzpFkNAO1r6PCRLzordMGKQBauVTcBL9CZRa2IVsYc7ZdO5MqN
         Ooyg==
X-Gm-Message-State: ABy/qLaCbDDx8IIGCyNBfv8WmgrSxzEQW1TNix6wyB8YHd/9JQtIGVgH
	hXypiwRPCVAZkdIxIWaLGkagXH4ch7QnA+sKduQ=
X-Google-Smtp-Source: APBJJlG4lwvNTYTkGbY0TRb3l6im4mSUjRUhOEgAGWRY9n5406M40rOUd95bdN20mH5cQHi4VZboDKZahcVcoPvNqho=
X-Received: by 2002:a1c:6a03:0:b0:3fb:a576:3212 with SMTP id
 f3-20020a1c6a03000000b003fba5763212mr2170453wmc.39.1688680834407; Thu, 06 Jul
 2023 15:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-8-laoar.shao@gmail.com>
In-Reply-To: <20230628115329.248450-8-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 15:00:22 -0700
Message-ID: <CAEf4BzYGVuvZznF+_7cNJ1PRtPsoXop5r4m9WChkfMNnCkj5Nw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 07/11] bpf: Add a common helper bpf_copy_to_user()
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
> Add a common helper bpf_copy_to_user(), which will be used at multiple
> places.
> No functional change.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/syscall.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>



> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a2aef900519c..4aa6e5776a04 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3295,6 +3295,25 @@ static void bpf_raw_tp_link_show_fdinfo(const stru=
ct bpf_link *link,
>                    raw_tp_link->btp->tp->name);
>  }
>
> +static int bpf_copy_to_user(char __user *ubuf, const char *buf, u32 ulen=
,
> +                           u32 len)
> +{
> +       if (ulen >=3D len + 1) {
> +               if (copy_to_user(ubuf, buf, len + 1))
> +                       return -EFAULT;
> +       } else {
> +               char zero =3D '\0';
> +
> +               if (copy_to_user(ubuf, buf, ulen - 1))
> +                       return -EFAULT;
> +               if (put_user(zero, ubuf + ulen - 1))
> +                       return -EFAULT;
> +               return -ENOSPC;
> +       }
> +
> +       return 0;
> +}
> +
>  static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
>                                           struct bpf_link_info *info)
>  {
> @@ -3313,20 +3332,7 @@ static int bpf_raw_tp_link_fill_link_info(const st=
ruct bpf_link *link,
>         if (!ubuf)
>                 return 0;
>
> -       if (ulen >=3D tp_len + 1) {
> -               if (copy_to_user(ubuf, tp_name, tp_len + 1))
> -                       return -EFAULT;
> -       } else {
> -               char zero =3D '\0';
> -
> -               if (copy_to_user(ubuf, tp_name, ulen - 1))
> -                       return -EFAULT;
> -               if (put_user(zero, ubuf + ulen - 1))
> -                       return -EFAULT;
> -               return -ENOSPC;
> -       }
> -
> -       return 0;
> +       return bpf_copy_to_user(ubuf, tp_name, ulen, tp_len);
>  }
>
>  static const struct bpf_link_ops bpf_raw_tp_link_lops =3D {
> --
> 2.39.3
>

