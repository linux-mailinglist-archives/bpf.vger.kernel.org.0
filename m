Return-Path: <bpf+bounces-75515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141BFC87871
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70B13B6AFE
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EFC2F28F1;
	Tue, 25 Nov 2025 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtpw89cL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A02E613C
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114864; cv=none; b=KgJ9x0DJ19DowZ0Bu15W+QumjsBYnFJwJ75ZjBKrQ2udMHVK4OR6p+auDonvxawPPPu8/Dz8PPUNLaZ16/LaBBsUtkCu+xmHBPCE4p7wHA8FrpxUaUX2PPD0iHAfR4+hCuDPKszpVTUTrw5R9luP3Y+5pb7fWyEeRFlVz6HA858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114864; c=relaxed/simple;
	bh=UmA+zl3Jz/3zmGCtyMZouwtZhX1vm0jkAbwHClmqIJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUpkP1KJnz1r+hYz2blB1xYkeYYsJQ6PxhxaOfeX2y+KAd2kEO+TUhSUanazSeQNegsRgiTTKu4J6mn6hg6Tj6qsmhi/Bk6AQ9ZoBnr/waDN0AMSM84i3F89n0nkBW3QCZd7gi+5X9VEjFcjS0uihnpGvA0VkTQAKx7FjYQWbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtpw89cL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34374febdefso6094911a91.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114861; x=1764719661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3RPqln1ANJzd5R6QcbYwk0cJfLEX6kIEy3vJdt+mSo=;
        b=Qtpw89cLqhlxE1Nz3zIbwiz1BGeJpFafeyuT+9pRmA8XYDA00pWpBugGdo1amncSLG
         VC4D0XpQPFOEcRfQNg4WTQz4vXi0V0CoAiDavhINiJgyoSClNeDc8wxpetCOQUvnycM2
         6YwP5ayjCdT06eoKHuv1rCOhBJ5sdtujpBjWVW4oMSaqKKtNxtWlUmkeQSWe/KIllQkN
         er2QBtTW8t7AGZlPy2GVROE9DiKjch3HwfijGR07neFQY4HvwFIs3QMlCoOfjMViuFaJ
         6T/+Bp8YnnOUZYElrsQGoUzHiF0TZhDDL96ESgSuvEywA7jOzCOzdrV9WVZOZVdgg0CU
         SFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114861; x=1764719661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3RPqln1ANJzd5R6QcbYwk0cJfLEX6kIEy3vJdt+mSo=;
        b=XFZpVPZ4xrh6cGdLKTEpvF/DBKC9lVU+sSOl5ifFFRSr7jov3rZk8O55+jWofhQkSE
         vXF9NLcHJYNVr/D6AqXCcokAIOToDbqGkpQd9FkS5qukJfqlYjmjFxgC7TbxRLdYWC+M
         e7v7dK+k3KiYq1u27hww1TOtOFxC9vn4aR96MfZ8qeyntZa09UoKVw0+TVD4NN7I37PR
         k1dn80EW3eA91t7G/f5fGUkQuIf4t+iECTNyOY7VSlB/TMuOQaomTIufjrFFkoUQBFaX
         HqYeZfY+ruyQZaxogy1yEbBAqRoecajKzp7395pbYhd7EIsO3+UeY1Zrq7JUR0SPmNEF
         vDHA==
X-Gm-Message-State: AOJu0YxBVorM5FtAKf5fU/4BFGzEc0VjuQLy9cuNXxEh69zKpp6wyr7X
	zZS/uLeFO7rZOunBeQaqhH4KYKHR99R5yuo0A3UR/+5QDE1o+I1A/SklPb+0q2dU3DUp20us4TQ
	ghIo8a0lH8E79Jg0t3pG+zVHJPQsg1Io=
X-Gm-Gg: ASbGncttcXibWXheu0H6gwOKSuR8N8hm+YX7SWqxiM0sBR1mpVO839e69z+tIiCX5RN
	XgOn+HA3a/8CaC9M6Dzi5lyc+TEWPILNLfrZJqvUsZB673mGAkEK0+KA1wEeIKEN/RTEb0UadtB
	vvt4nr0mIxRRJsYNwfRPrBopJfsBHTyL/f5V/iXkPkDZX63XnmLyoUHv0OHz0D/uWPgACV1MPqh
	MRf2b4oq1E6zvee3SRUvg9hCtPFR3NybkDStVoJu+QsEx5nrODegq93nXlBs6HDnqVKhzQzYf19
	FKOXvKY36nA=
X-Google-Smtp-Source: AGHT+IF6DOi7rb9isyagDTFCSIeNpairvyjgWvoz5d1kCo9mQEw0RTdWc+nqLtog+K5EXGn+7yuTYDMM0zhR2x9reFQ=
X-Received: by 2002:a17:90b:3502:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-34733e72350mr16761843a91.13.1764114861031; Tue, 25 Nov 2025
 15:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-4-ameryhung@gmail.com>
In-Reply-To: <20251121231352.4032020-4-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 15:54:07 -0800
X-Gm-Features: AWmQ_bm7thx54-FFcBIeNbOReQG7DwMzS9jTc_MbqlUFWTrGKvBtFbX0cRXJ5o0
Message-ID: <CAEf4BzYaiBYKEvLZk78MMj1R1yjeTZ5P=C7QCrUquh250ENcpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/6] libbpf: Add support for associating BPF
 program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 3:14=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
> command in the bpf() syscall.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
>  tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
>  tools/lib/bpf/libbpf.c   | 31 +++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  5 files changed, 89 insertions(+)
>

[...]

>
> +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_m=
ap *map,
> +                                 struct bpf_prog_assoc_struct_ops_opts *=
opts)
> +{
> +       int prog_fd, map_fd;
> +
> +       prog_fd =3D bpf_program__fd(prog);
> +       if (prog_fd < 0) {
> +               pr_warn("prog '%s': can't associate BPF program without F=
D (was it loaded?)\n",
> +                       prog->name);
> +               return -EINVAL;

This is an error return path from the public libbpf API, please use
libbpf_err() everywhere to ensure errno is set. Missed this in earlier
revisions, sorry.

> +       }
> +
> +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> +               pr_warn("prog '%s': can't associate struct_ops program\n"=
, prog->name);
> +               return -EINVAL;
> +       }
> +

[...]

