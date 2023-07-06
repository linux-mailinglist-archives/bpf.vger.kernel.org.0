Return-Path: <bpf+bounces-4335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B274A678
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1180B1C20E6D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4723715AE5;
	Thu,  6 Jul 2023 22:00:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443D1872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:00:34 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB2E1BEE;
	Thu,  6 Jul 2023 15:00:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3142970df44so1163309f8f.3;
        Thu, 06 Jul 2023 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688680831; x=1691272831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofkXSNxaVeUztYNS4iAgszyKuwsa3AELRmpeWgWX0MU=;
        b=FydFxMlkfbDJpw9uSXj2co7p1yUa4PIJ4bOo/AMSkmJEzClIhXf9+n58rG+52Bq3GA
         t6DQ8isi/f0YjbLa5IS9ag33DXFKVCzbeSQwDbbWF0k674bQY757BKuVwhJ9R2LRt9Kn
         y8/HvJUbz5kF4eD3KqtcR+Rb/iATOQz8UD0+LlNG4TLnrhU0CSlWRPbk7SsN7FQ+wBwI
         t6B6IGRMFeIoK3Ja8XXR6/HeGXQnp2Pczbqc8SeV8D1ik5CJ52MnQCYclUA5vnnJXXYt
         cXR8TS9wAmIPbqEoKD5sNHMlzSigHhLbjw9+cxhYsHRHPAnO7rGS3+j6mHZCpAHV6tKQ
         NAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688680831; x=1691272831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofkXSNxaVeUztYNS4iAgszyKuwsa3AELRmpeWgWX0MU=;
        b=XHYl2gDHtsS8OGyXeQl3NbRg6yFZSSHeqYTqytcwAjpqlaNLTwAHV6kwlrkhRTm8P4
         w5LybR4xGTva6L6tDeSjzMqFOo0j1ioopfKRW8UPtckP8aufXlwOn6aeqOw2fkuMKMQe
         Gec7SIODb2W46rBF5xcIGO2HZl1vO6PpjkYpxmr+xIAKr2MdzE7bStQ/Xwt0yYBRF44D
         yh7T+oMEKJHdxWvjTFP9J99iMRl3euids2IqgjaGqWLI4+3TzooJs8+ciTNTNObm9zrn
         AZJcdsdOvl1qUf8LXOqzzgXZn+F49OvIFXr/TPjR22ZmhaMoMMnyLBQvFFvn95zGYONT
         rWJw==
X-Gm-Message-State: ABy/qLYlrVlvo8kUIk3nFMyvJYHXMMX2XaXW1ZqRyPTVE+mEGtHnZTrS
	YQZiQzDdFvqU2QiPBLRFQfoYXCoRapgyc7+XMEE=
X-Google-Smtp-Source: APBJJlG6/Pfuwktu0Iahkltj0GLNaNBKjYfOqT98k0bgUn8B0Dx6reROJHvT4kalyIVaMuDhjRTPVaIv2mrHfJu3W7o=
X-Received: by 2002:a5d:4f86:0:b0:311:162a:ce2a with SMTP id
 d6-20020a5d4f86000000b00311162ace2amr2294237wru.29.1688680830401; Thu, 06 Jul
 2023 15:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-2-laoar.shao@gmail.com>
In-Reply-To: <20230628115329.248450-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 15:00:17 -0700
Message-ID: <CAEf4BzZzuPvyhUPnq8eGugRhCAbQVyQ7wfDDe4sUpUQa4cKFWw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
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
> With the addition of support for fill_link_info to the kprobe_multi link,
> users will gain the ability to inspect it conveniently using the
> `bpftool link show`. This enhancement provides valuable information to th=
e
> user, including the count of probed functions and their respective
> addresses. It's important to note that if the kptr_restrict setting is no=
t
> permitted, the probed address will not be exposed, ensuring security.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---

documentation nit, but otherwise LGTM

Also, looking at other patch where you introduce bpf_copy_user(),
seems like we return -ENOSPC when user-provided memory is not big
enough. So let's change E2BIG in this patch to ENOSPC?


Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/uapi/linux/bpf.h       |  5 +++++
>  kernel/trace/bpf_trace.c       | 37 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  5 +++++
>  3 files changed, 47 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 60a9d59beeab..512ba3ba2ed3 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6439,6 +6439,11 @@ struct bpf_link_info {
>                         __s32 priority;
>                         __u32 flags;
>                 } netfilter;
> +               struct {
> +                       __aligned_u64 addrs; /* in/out: addresses buffer =
ptr */

addrs field itself is not modified, the memory it points to is
modified, so it's not really in/out per se, it is just a pointer to
memory where kernel stores output data

> +                       __u32 count;

but count field itself is in/out, so please add a comment explicitly
stating this


> +                       __u32 flags;
> +               } kprobe_multi;
>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 03b7f6b8e4f0..1f9f78e1992f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2469,6 +2469,7 @@ struct bpf_kprobe_multi_link {
>         u32 cnt;
>         u32 mods_cnt;
>         struct module **mods;
> +       u32 flags;
>  };
>
>  struct bpf_kprobe_multi_run_ctx {
> @@ -2558,9 +2559,44 @@ static void bpf_kprobe_multi_link_dealloc(struct b=
pf_link *link)
>         kfree(kmulti_link);
>  }
>

[...]

