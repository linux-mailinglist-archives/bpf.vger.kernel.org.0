Return-Path: <bpf+bounces-12158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C5F7C8D4A
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 20:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A8D282F1F
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727591C69F;
	Fri, 13 Oct 2023 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eii5x7q6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C415EA4
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 18:47:35 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D33D95
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 11:47:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d885e97e2so2350985f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697222852; x=1697827652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3H5sKyWQC/MBi1BetfNFC7+y5/uAtsWXs/E4coShvUE=;
        b=eii5x7q633JFkE1eBki2Z+2fkenE8T4g0L0maIDkva3whmmYAUISR/c3F4OLxeb/oA
         rj2ng6vYVoc0AzNM9W7n7M36mDlUo1tbO3oCyTnYd9EaFibVVTkCMitIE4fJPEvwLRfm
         3ABoqlbLgqYjnup8D3T04rpxyQa9FKkdrRZwEdST4BHBBw5AO/QJ/bvyYd5oNuxRqxXy
         GKx1MO8hFUbo0xIf976JBBoUxUTDgTa8NFdgtamBaYECehJ3kfnXbHl3lii+tUMmfdRl
         nWlwDLqaXCFJa+BmlkwbXFt0kPFzL6F55VQP0F+TYNqmM9pxzYogIhmPKLOSl6AlF2dq
         PVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222852; x=1697827652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3H5sKyWQC/MBi1BetfNFC7+y5/uAtsWXs/E4coShvUE=;
        b=IM+emSQegzMJxUUKtvKqdgaTq/GWBf12GKNl8uXA040ufIqzI3NUJmK6hErrrXEdz2
         bKlacrv+uLPestYaWzska2MCl76kK+taXacavAYvStrU7ENY5xTqC+djxnALorkT3xk6
         gkVaWhaZtg9hng0iZmnHDzH2vg1C+Or3tQrL/uPr2a8XyM0eE3LXaPtveGLtkcCTavM7
         1h9s0U3kjs0BcgMLoO2phTBsSJ5y8oWrQdPC9dIauWumzjLC04H+EJZgfmf3iPlJ7jTr
         OR0EYQcyJZ2lLCK+rEfZortHv5LTCOBO3pRNF/7rb0rZgo8i4uzRsSRQ/yR/9fSJanpG
         805Q==
X-Gm-Message-State: AOJu0Yzlnep1GLYj97wmlBNO6fqYaWdDXbr+MwRf8LkLqlERlDdn+swK
	KFtqTU6vqxhSth3vcrEOkxcrp7JYhvW1JdoZ3c8O2oY3cQU=
X-Google-Smtp-Source: AGHT+IGeOrIayuA2C5bcK3Q5O7Z6d6SjFp7XMk41ZzLWXjWQji35ib4dAXk6rt3kzHoypuL0X4nNEL+nOlpH4qi0eA4=
X-Received: by 2002:a5d:4c50:0:b0:31f:dc60:13b5 with SMTP id
 n16-20020a5d4c50000000b0031fdc6013b5mr24048280wrt.25.1697222851752; Fri, 13
 Oct 2023 11:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_C59755D2B2D8A78676CFECBC4DA9031C1908@qq.com>
In-Reply-To: <tencent_C59755D2B2D8A78676CFECBC4DA9031C1908@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Oct 2023 11:47:20 -0700
Message-ID: <CAEf4BzZnZ=jqTxShQ7p2tp=0sT5iMEJVB+zqhf55XtwQHOODtA@mail.gmail.com>
Subject: Re: [PATCH] Fix 'libbpf: failed to find BTF info for global/extern
 symbol' since uninitialized global variables
To: LiuLingze <luiyanbing@foxmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 6:45=E2=80=AFAM LiuLingze <luiyanbing@foxmail.com> =
wrote:
>
> ---
>  examples/c/usdt.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/examples/c/usdt.bpf.c b/examples/c/usdt.bpf.c
> index 49ba506..2612ec1 100644
> --- a/examples/c/usdt.bpf.c
> +++ b/examples/c/usdt.bpf.c
> @@ -5,7 +5,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/usdt.bpf.h>
>
> -pid_t my_pid;
> +pid_t my_pid =3D 0;

This is effectively the same, my_pid will be initialized to zero
anyways. The difference might be due to you using too old Clang
version that might still be putting my_pid into a special COM section.

Also "failed to find BTF info for global/extern symbol" is usually due
to too old Clang that doesn't emit BTF information for global
variables.

So either way, can you try upgrading your Clang and see if the problem pers=
ists?

>
>  SEC("usdt/libc.so.6:libc:setjmp")
>  int BPF_USDT(usdt_auto_attach, void *arg1, int arg2, void *arg3)
> --
> 2.37.2
>
>

