Return-Path: <bpf+bounces-12106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A791B7C7AB8
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 02:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A17C282CA8
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 00:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2586E36D;
	Fri, 13 Oct 2023 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuraGBcs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D79360
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 00:04:42 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABCC9D
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:04:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53406799540so2716309a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697155478; x=1697760278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t98go7cn3XAEMbPhQXDwxjLTCi1zC8S47PtFLIc/JKc=;
        b=iuraGBcsaF1lBG4Z77YPkUwIRmds535no38HKS9mQ33+Cbhqax5ndQE2hlSYxlr5Gq
         sRq+mCOA8vE+5Bd0dpiibR4MQnL8xxXBeXx5OM4rJqVTRd0f1PWxe3erlGrM2Zpc6/Sy
         5XBgaHW/jnPnLk+LCRxMBWjhId/YZ1Hnz3jsHQcwA8YI+sx9iuKqJ9tal58kGRKvjSqL
         ODKdMhNr11B0LKd9asSeaHuMQmJR6jewUpLBNPHvYCI5WyxuURyzTfkz/oX82dFmDA8m
         xgqJvYW4Lj8vCPgxEzXnIbUKXeVqmMZo/c6/4OSGCvttOmvTI6n+gzT/Bpb5qGtSVYrI
         YCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697155478; x=1697760278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t98go7cn3XAEMbPhQXDwxjLTCi1zC8S47PtFLIc/JKc=;
        b=Vh3RRHVtytOa0wPrg7xFYYMFOFwIg9kl84zhtoyo0jNO2KiaVlu39sTcnhR1mZmbyL
         gRrnwwPqXJzgT92hH25tIWPBI7dbGrcU0GHkD0+KpkFC8o6UoyNf1UHzlaBpz7VTXaMU
         D2be+nfZvcBtuhczAb2EcQeH6W2eDVllUN9bb96T9/+k4flBAuw8pI48+7e2J4d7tsd5
         Hql/WE1wZydOo0KeeErEk+oCoCypR506g14j8fBoHPMbWN/wpkTxDbFLVXIVeMG4K96/
         s8xln3sIqQplmuWN7ojx9xpxv9z2qbawtiaAD1lAio2NijtKyEnAYV+YZHKbUrlc8GdD
         d6CQ==
X-Gm-Message-State: AOJu0YzOSml/6L3j9tU0WA/03EVR70cyCB7VbMQPcEfTkqXF6haewy7r
	po4HWBTSy7ThGlLPx8T/C0LDxxToTHeKD5jE+mo=
X-Google-Smtp-Source: AGHT+IExkxGGYE3bI9+xJ7i2maLZobDoHwysrn0lGue48CsEZOHIqBg+/doneA0W4oXMTLhdzJMtWHz7adlXYjMfzQc=
X-Received: by 2002:a50:c047:0:b0:53e:3b8f:8ce1 with SMTP id
 u7-20020a50c047000000b0053e3b8f8ce1mr416905edd.23.1697155477905; Thu, 12 Oct
 2023 17:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010185944.3888849-1-davemarchevsky@fb.com> <20231010185944.3888849-4-davemarchevsky@fb.com>
In-Reply-To: <20231010185944.3888849-4-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 17:04:26 -0700
Message-ID: <CAEf4BzbibvWhvs8s-XreymAPjo2Kt+gOONt7_1Mie3Rg0ib7-Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 12:00=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb=
.com> wrote:
>
> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_task_vma in open-coded
> iterator style. BPF programs can use these kfuncs directly or through
> bpf_for_each macro for natural-looking iteration of all task vmas.
>
> The implementation borrows heavily from bpf_find_vma helper's locking -
> differing only in that it holds the mmap_read lock for all iterations
> while the helper only executes its provided callback on a maximum of 1
> vma. Aside from locking, struct vma_iterator and vma_next do all the
> heavy lifting.
>
> A pointer to an inner data struct, struct bpf_iter_task_vma_data, is the
> only field in struct bpf_iter_task_vma. This is because the inner data
> struct contains a struct vma_iterator (not ptr), whose size is likely to
> change under us. If bpf_iter_task_vma_kern contained vma_iterator directl=
y
> such a change would require change in opaque bpf_iter_task_vma struct's
> size. So better to allocate vma_iterator using BPF allocator, and since
> that alloc must already succeed, might as well allocate all iter fields,
> thereby freezing struct bpf_iter_task_vma size.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Nathan Slingerland <slinger@meta.com>
> ---
>  kernel/bpf/helpers.c   |  3 ++
>  kernel/bpf/task_iter.c | 85 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d2840dd5b00d..62a53ebfedf9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[...]

