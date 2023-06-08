Return-Path: <bpf+bounces-2174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02790728B9C
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 01:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F541C210A0
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2834D83;
	Thu,  8 Jun 2023 23:12:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CC2A9CA
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 23:12:58 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1BEB
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:12:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so2095578a12.0
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686265975; x=1688857975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw5sXaOJoEeSLbR6VtFcgbsKAssg4yg/BdfWbShf4mo=;
        b=SL2aMeOzPCLTLiBWJq5M1mHyM0usvm8v133iEEH8f6voJSqb1QovlWorFnFCWmLOc/
         PTQxHe9AcoyqjH+cA5IOUsJO98s0XE5JUyg8HTbq4IPPpG+UDTjB5dsVYa5Or+1K9dyW
         eFzyVPGt01qgfQ4fpuYS5GMI1bhyw6XtAKdBiU5XLJ/CPv53CGZLR6I1wLxIuytuU1uD
         BBnRcYMD01J+mxf8+AdvroOx2UKDQ1zWPqFmHjiB73zKshHnJ6fYw0XoNUbS49wLJoUD
         a8QoJpgQOX+F7B1Trpqwk7lTKHicIpxZ7FRrbR5DfweVWBciowkbPxMblzBSEVoQmktm
         59Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265975; x=1688857975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw5sXaOJoEeSLbR6VtFcgbsKAssg4yg/BdfWbShf4mo=;
        b=ZDTYsMOx3KEMDYsYerTRSStWtsTHpLaPREci3W1ZF1wSwjuyz8APmXE7MXD6YzgagM
         YHX1q51ulcVacJkGskh/ecUsuYboinm2VUxma26DFlmFWUvRWmvaQBqE+wjWfYjlE7M5
         oFyU61NIl3KoGiboBDIEM3jN7V+DRQnj/HpdKAeV7T2B33F+ZoS41CThCo4VJ3tnAkwo
         9BjEOLI2Bgy6Ml4ij/sACZAAA56ICkPy6kZrEnDWAtN702VQ0389BBqLF7+o9C89zvnB
         IpPUcJKV2OihlScfh5eegYbpz+OXpF49wNeHOnkjYHkCUTlkjlgzoYB1MjP6x6MkqXH9
         qGEg==
X-Gm-Message-State: AC+VfDzUsXGwrryCK2zObsa69GM+ixc/af4rmxorHK3og/QwhR61+8aU
	42ALBc9FYMpPQvgdNhl9852nLqjEx2ixnAMir2Y=
X-Google-Smtp-Source: ACHHUZ5ULMJeSVKvJFPuELghXguxyMvgDO7J2GP5MenzTyGCYYYSgPDdLt49NeWeYfi01ZOb87OoaiDSL1aISwE4q28=
X-Received: by 2002:a17:907:3ea0:b0:94a:7979:41f5 with SMTP id
 hs32-20020a1709073ea000b0094a797941f5mr605504ejc.71.1686265974525; Thu, 08
 Jun 2023 16:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-9-laoar.shao@gmail.com>
In-Reply-To: <20230608103523.102267-9-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 16:12:42 -0700
Message-ID: <CAEf4BzYEwCZ3J51pFnUfGykEAHtdLwB8Kxi0utvUTVvewz4UCg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/11] bpf: Support ->fill_link_info for perf_event
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> By introducing support for ->fill_link_info to the perf_event link, users
> gain the ability to inspect it using `bpftool link show`. While the curre=
nt
> approach involves accessing this information via `bpftool perf show`,
> consolidating link information for all link types in one place offers
> greater convenience. Additionally, this patch extends support to the
> generic perf event, which is not currently accommodated by
> `bpftool perf show`. While only the perf type and config are exposed to
> userspace, other attributes such as sample_period and sample_freq are
> ignored. It's important to note that if kptr_restrict is set to 2, the
> probed address will not be exposed, maintaining security measures.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 22 ++++++++++
>  kernel/bpf/syscall.c           | 98 ++++++++++++++++++++++++++++++++++++=
++++++
>  tools/include/uapi/linux/bpf.h | 22 ++++++++++
>  3 files changed, 142 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d99cc16..c3b821d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6443,6 +6443,28 @@ struct bpf_link_info {
>                         __u32 count;
>                         __u8  retprobe;
>                 } kprobe_multi;
> +               union {
> +                       struct {
> +                               /* The name is:
> +                                * a) uprobe: file name
> +                                * b) kprobe: kernel function
> +                                */
> +                               __aligned_u64 name; /* in/out: name buffe=
r ptr */
> +                               __u32 name_len;
> +                               __u32 offset;   /* offset from the name *=
/
> +                               __u64 addr;
> +                               __u8 retprobe;
> +                       } probe; /* uprobe, kprobe */
> +                       struct {
> +                               /* in/out: tracepoint name buffer ptr */
> +                               __aligned_u64 tp_name;
> +                               __u32 name_len;
> +                       } tp; /* tracepoint */
> +                       struct {
> +                               __u64 config;
> +                               __u32 type;
> +                       } event; /* generic perf event */

how should the user know which of those structs are relevant? we need
some enum to specify what kind of perf_event link it is?

> +               } perf_event;
>         };
>  } __attribute__((aligned(8)));
>

[...]

