Return-Path: <bpf+bounces-12107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7D97C7AB9
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 02:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73760282C18
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 00:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740036A;
	Fri, 13 Oct 2023 00:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2cjcK44"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC3360
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 00:04:46 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F4CC
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:04:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2755026a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697155483; x=1697760283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogBPpaAnw8TjxPDFn/gx1fTwgo+/9CqxDoKmAN2f07M=;
        b=a2cjcK447/dQLGbeRdcPQwxc6R1slOXSTDU6kj7kCLGOkENWaFx2wCBOQIhr5bN5d9
         Uh0mvEKIEREw4WY+9y5iwzprn6sLRvrBHhWAPcQYv2Cgdfo7064NcyDOnJDkx+qfyIQ3
         WgbvazrblJyECsguxUuMccjTfxnS6WjB3VGRZ+mHwX7o8visqEVqhna6O1jzwY2QdtFr
         pIqLG92Rg1wt28uM7nB0feL562xiLaeY4Xhk7ZLbqHbvtLywQoAfs6rnB+zjNQSiQbtS
         pl0nTYrnm9P3GbNNNxj/FFlMqLBXenlkFkzgoyQC5+ql2tn4mfuxJ6yFUGkJ8bWFNJYV
         qzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697155483; x=1697760283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogBPpaAnw8TjxPDFn/gx1fTwgo+/9CqxDoKmAN2f07M=;
        b=tll4hi1cHUI9hW39jrh+V0iizKmhFEjp80glWfK/rs/V+2SW/nio0Z/fUwSbchJkPr
         hQeNjC2oH9BGnIzgyIiVHalzYhROling+gqct3KcRoUQVVP71QUiBxvMc7tJ1BnR7WmQ
         J5u6DRIPLZ4S/OAnUpINYdbtXmqj7glZQCc07WlMpD2uU4oNG9wU2j+MoNIDH503v534
         iToyP3vrQFwnAPxkDwujK6+7Vs0lD3aTlSzo+qDnRfQ6823EqX/rP3/Lbb66FIHQigMf
         Pntlp/cBI3H25b/nCeM5rcVWhjgw71i745XRoE2b5tywj6nwk8/CntPMrQ4LcaTkrbnR
         l6Xw==
X-Gm-Message-State: AOJu0Yzj8fgwODguK0f7b7OHA39p3KBLjaurUDrxsGZsVFN9H0AdvjsS
	0QSwdI5vq1wSmW56Z8SCq0IRDDKa8rDUzxnXwxM=
X-Google-Smtp-Source: AGHT+IGwcwSTHDNHF4uX0Pzy3Iossp6eIgNAcAhataQmW/W9Z9hX5GtorX/DgOY1Cn3wOnNSrhsiFJpVZcal/3sKT5o=
X-Received: by 2002:a05:6402:50d4:b0:53e:1f6:c694 with SMTP id
 h20-20020a05640250d400b0053e01f6c694mr3137466edb.42.1697155482954; Thu, 12
 Oct 2023 17:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010185944.3888849-1-davemarchevsky@fb.com> <20231010185944.3888849-3-davemarchevsky@fb.com>
In-Reply-To: <20231010185944.3888849-3-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 17:04:31 -0700
Message-ID: <CAEf4BzbBNdmVt88V1KhJcEvae7or8oL4_ttPWRcobG9Rzmg8+w@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/4] selftests/bpf: Rename bpf_iter_task_vma.c
 to bpf_iter_task_vmas.c
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 11:59=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb=
.com> wrote:
>
> Further patches in this series will add a struct bpf_iter_task_vma,
> which will result in a name collision with the selftest prog renamed in
> this patch. Rename the selftest to avoid the collision.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++++++++----------
>  ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
>  2 files changed, 13 insertions(+), 13 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf_i=
ter_task_vmas.c} (100%)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

