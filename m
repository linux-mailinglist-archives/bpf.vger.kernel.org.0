Return-Path: <bpf+bounces-18041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F958151B9
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D5D1F26705
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1012147F66;
	Fri, 15 Dec 2023 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUHaJRVi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627F47F5E
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1f8a1e9637so195003566b.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 13:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702674939; x=1703279739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZX/aGeM/eAc2JLCovGkdMBhWDbv8ZxkWMT65adB9bE=;
        b=lUHaJRVixCUGU3p53wOvPT0zFQN93TiJooUFiOEKzq7SphfTUuEcFDKMwbIfGNNw1V
         ebumKdXse04YQwvEGEX1kwgva9c1F3GZ3ZEGJO1tEx7u4OaQvql/BEf/L9rmW6TNfhKT
         /4QKauIYshA7nOWcxKkhTDIrYLJlCXZHiCZmXqZv4H1bZMQSYLnPUAy4B4eO7L2hHk7R
         VVOPkY8CkDNEV9THdgL56JzvTtXxCTjeWDwMnFXUO5l4UBRIQseWbvtm4/Z4v3pjPg29
         08yRCr0BV4eqyD/6YZipQgBuN+4lx76Ok1Kar4hnFbaV4vLR/7jtTbdUDJn0uAuItVYm
         Durg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702674939; x=1703279739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZX/aGeM/eAc2JLCovGkdMBhWDbv8ZxkWMT65adB9bE=;
        b=l7PwADDCJRVJx8BTp8mse019ZujDqlJCPqSwIpjIpcEy7Czf/IWVfaOzf3i/GRh39s
         f01iVCTvHn6Dqh2Sa6VkvHHkmD+BDU0P0sSFTsrwDD3u/z5Akv+otNSMjeCDceI7R6AW
         dPtWXjV5cWKvrBxH5Mn0mvT/Dlnw5girFcl1cuhtGuDTHsHDqkJuWs3l4TcYDVAiBdAe
         FYBUUMsG6KF1bQa433891PRX7bwSx9JJi74Op4XEn9pwGFmZoIev6pPmZeW8AgsrBnwN
         izfbCgXxo7wzC6LN5TDj60d8XUQaGoA2SLINyVa9VPIbi/pykZutC6eA6VD/QzykrXGW
         jEnw==
X-Gm-Message-State: AOJu0YydiOBi6ol2bkrzD2LYaX2kVEEUe27hctUiSpQkeEwFFrrmZVdP
	DTCzS28T6cf3/vAmW2uADp+kHr2+c8TGwPxKIhiuplRdMCk=
X-Google-Smtp-Source: AGHT+IGgDemQGrd3NdeqBS/LZvcpix775vWKB9TCH4FknerG6t8k+AxFsTXLwVxYrPsfybi+n4x//Q1gzgoZ6QYsl7o=
X-Received: by 2002:a17:906:10cb:b0:a1f:9613:fe8e with SMTP id
 v11-20020a17090610cb00b00a1f9613fe8emr9673450ejv.51.1702674939091; Fri, 15
 Dec 2023 13:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215100708.2265609-1-houtao@huaweicloud.com>
In-Reply-To: <20231215100708.2265609-1-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Dec 2023 13:15:26 -0800
Message-ID: <CAEf4BzYNtmEOmwigoXKU8Y8htwbMAde_bKoZUHEM9DjH9iM-Kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/5] bpf: Fix warnings in kvmalloc_node()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 2:06=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patch set aims to fix the warnings in kvmalloc_node() when passing
> an abnormally big cnt during multiple kprobes/uprobes attachment.
>
> Patch #1 and #2 fix the warning by limiting the maximal number of
> uprobes/kprobes. Patch #3, #4, and #5 add tests to ensure these
> warnings are fixed.
>
> Please see individual patches for more details. Comments are always
> welcome.
>
> Change Log:
> v3:
>   * add ack tags from Jiri
>   * return -E2BIG instead of -EINVAL for too-big cnt (Andrii)
>   * patch #3: rename the subtest from "failed_link_api" to
>               "attach_api_fails", so it is consistent with the naming
>               convention in multi-kprobe test.
>   * patch #4: newly-added patch to remove libbpf_get_error() in
>               kprobe_multi_test (Andrii)
>
> v2: https://lore.kernel.org/bpf/20231213112531.3775079-1-houtao@huaweiclo=
ud.com/
>   * limit the number of uprobes/kprobes instead of suppressing the
>     out-of-memory warning message (Alexei)
>   * provide a faked non-zero offsets to simplify the multiple uprobe
>     test (Jiri)
>
> v1: https://lore.kernel.org/bpf/20231211112843.4147157-1-houtao@huaweiclo=
ud.com/
>
> Hou Tao (5):
>   bpf: Limit the number of uprobes when attaching program to multiple
>     uprobes
>   bpf: Limit the number of kprobes when attaching program to multiple
>     kprobes
>   selftests/bpf: Add test for abnormal cnt during multi-uprobe
>     attachment
>   selftests/bpf: Don't use libbpf_get_error() in kprobe_multi_test
>   selftests/bpf: Add test for abnormal cnt during multi-kprobe
>     attachment
>
>  kernel/trace/bpf_trace.c                      |  7 ++++
>  .../bpf/prog_tests/kprobe_multi_test.c        | 31 +++++++++++++++---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 32 ++++++++++++++++++-
>  3 files changed, 64 insertions(+), 6 deletions(-)
>
> --
> 2.29.2
>
>

LGTM, for the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

