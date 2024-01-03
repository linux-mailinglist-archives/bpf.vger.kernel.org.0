Return-Path: <bpf+bounces-18903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C108235DC
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3A1287468
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6C1CF91;
	Wed,  3 Jan 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlSBPsPS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E21CF82
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4535DC433C8
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704311247;
	bh=MUCk1H8WUzKPez/O6hzT1bZevWLedX1XpAtphoR6OK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PlSBPsPSsSpbn6YpTHIViqYA0IC/gT4pj3w97cf3vo7JTahNYcvu4sPQrcJoug+E/
	 8xNSvm4qFHMlmElvehazfbZ8BPAZhXbPNOkKdtaPYDY/PAuh6sFhl3GQw2LOg4hZ7u
	 vXxr4TlBSpCyqV14tUiI83JnxAEG0XA6QWVYcg5vjLK4fKdu/1gysuY1rXiBCoMzZd
	 G0CO7TonOeuAsqOLUCdyLLDCE6hYyz4sNc1dNpTaMoTb+aSmMl4nOr02ofn53oLvu7
	 6CbrqipLr57/UOrw2FfXomeo7yd66Tgl9ATG+1r5YoCUv+GXPzdEsdbT4ln2R3uyv+
	 i3LiY2H7TRYzw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso21674901fa.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:47:27 -0800 (PST)
X-Gm-Message-State: AOJu0YxjTU341rc16zb/MlgGtfEhZ8FDAe8ABLD4iAqO4pvvZcsDOI/R
	pzCpPeoA02NcCWOFfffhKG5m0QfuWn1BJN5SRvU=
X-Google-Smtp-Source: AGHT+IGbIduvMLFLU6xhPPiA/FnLyHpJoxNgquPlvTP23FDQc1xQrYjVz16A8KTDh9go8Gn+yh/CzyKnIew3m8U+9zE=
X-Received: by 2002:a05:6512:246:b0:50e:6460:fb91 with SMTP id
 b6-20020a056512024600b0050e6460fb91mr7251079lfo.73.1704311245430; Wed, 03 Jan
 2024 11:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103190559.14750-1-9erthalion6@gmail.com> <20240103190559.14750-3-9erthalion6@gmail.com>
In-Reply-To: <20240103190559.14750-3-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 3 Jan 2024 11:47:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7Nn2i1PBCH5JDcShH6dYYwPKU9tHrVmT822n7BHNByLw@mail.gmail.com>
Message-ID: <CAPhsuW7Nn2i1PBCH5JDcShH6dYYwPKU9tHrVmT822n7BHNByLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:06=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
[...]
> +
> +/*
> + * Dummy fentry bpf prog for testing fentry attachment chains
> + */

Comment  style. This could fit in one line.

> +SEC("fentry/XXX")
> +int BPF_PROG(recursive_attach, int a)
> +{
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c =
b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> new file mode 100644
> index 000000000000..6e0b5c716f8e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Red Hat, Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/*
> + * Dummy fentry bpf prog for testing fentry attachment chains. It's goin=
g to be
> + * a start of the chain.
> + */

Comment  style. I guess we don't need to respin the set just for this.

> +SEC("fentry/bpf_testmod_fentry_test1")
> +int BPF_PROG(test1, int a)
> +{
> +       return 0;
> +}
> --
> 2.41.0
>

