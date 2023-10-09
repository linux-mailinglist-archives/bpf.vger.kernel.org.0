Return-Path: <bpf+bounces-11734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9BA7BE65B
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BADD281AA4
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7538BC6;
	Mon,  9 Oct 2023 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFN05zIp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2C1A71F
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:28:58 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1083B92
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 09:28:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3942461aso589492276.2
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696868936; x=1697473736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=19HHGQ3oNEnnEVZ/ClG1wJq3/mmndqDn49m0nA/lXo4=;
        b=WFN05zIpsVeSNfu+o74EDXJZWDGMOJRGWMVJJHzrbt40wUUe7FaKsjGKfdAJpee3IZ
         NjV9tE3PK9RCC9EzwtlUO4G+UhEYBNfoN4bpro0124tOWkgt2n7LZXlgt7Z3Z+hBm3iP
         0mc3bzYN0/mFhvkN3Icc//MSdKf1G6mSFIOgqaLuoc9uMAJ9v9jtCjP6LPEtaCtfVEcr
         EmGlpSuBgNkl+ygKxsU3RzOmby4UKtOLuRxH7dXChuYcKI7CvnDPYCzunUH+0l7kLkKn
         fCzpoSIrZCqfv+5c8VCVggmxCs9nUE3m3o/pHjVpPoBsZ1XlD2eTCDLMDA7CUnj0Ts28
         D3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868936; x=1697473736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19HHGQ3oNEnnEVZ/ClG1wJq3/mmndqDn49m0nA/lXo4=;
        b=IXQxeXqD1yxVxG4JVGt4cEnmjOOEqnKpTlGElZsHYbYmw5C4CWfGsiGVL5B7JJbFqe
         N72Ch0hCWS+NPf9c8wy3nx5MspnSDX6FhiMFJygCUgSZ5rsSwBPht36TDjt1e+onR6qs
         shZIhJGr73TSNk7q7Q3wP8qwNuf6Oy4A5QRtDk+6vF3DuRiEjXfUjuyOuHYtpkoLgWLk
         700v52PL5oFzckZWjv1yJQImgQVg06jYK/jrOye15weFEpnTR7toJ3NU7kKSPxKQ9nzz
         GMrU5yNgVYVrGfdEWtqng1v+B63dUyxk77K0iOnZm2/LZoM94WUI1Grru5SkRS6bMPYR
         NbRQ==
X-Gm-Message-State: AOJu0YxO3AqDZrYO7Qk9byPJFA91L3k8FnEbUQu6Zgsyol/lgMaE+RDV
	Nki4D12znC5MCz545t/5ItYs5ig=
X-Google-Smtp-Source: AGHT+IH+W9Z8tYIhdCRB7tkdQG5zQXa1wHNLY5WwOHgAwb2hBJXRjyZxkKCgLWY92fImc69hDjbHv2o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:990:b0:d89:4382:6d14 with SMTP id
 bv16-20020a056902099000b00d8943826d14mr256390ybb.6.1696868936283; Mon, 09 Oct
 2023 09:28:56 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:28:54 -0700
In-Reply-To: <20231007135106.3031284-5-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231007135106.3031284-1-houtao@huaweicloud.com> <20231007135106.3031284-5-houtao@huaweicloud.com>
Message-ID: <ZSQqRuC3aBHcrUZ9@google.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Move the declaration of
 __bpf_obj_drop_impl() to internal.h
From: Stanislav Fomichev <sdf@google.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/07, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> both syscall.c and helpers.c have the declaration of
> __bpf_obj_drop_impl(), so just move it to a common header file.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c  |  3 +--
>  kernel/bpf/internal.h | 11 +++++++++++
>  kernel/bpf/syscall.c  |  4 ++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
>  create mode 100644 kernel/bpf/internal.h
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dd1c69ee3375..07f49f8831c0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -24,6 +24,7 @@
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
>  
> +#include "internal.h"
>  #include "../../lib/kstrtox.h"
>  
>  /* If kernel subsystem is allowing eBPF programs to call this function,
> @@ -1808,8 +1809,6 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>  	}
>  }
>  
> -void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
> -
>  void bpf_list_head_free(const struct btf_field *field, void *list_head,
>  			struct bpf_spin_lock *spin_lock)
>  {
> diff --git a/kernel/bpf/internal.h b/kernel/bpf/internal.h
> new file mode 100644
> index 000000000000..e233ea83eb0a
> --- /dev/null
> +++ b/kernel/bpf/internal.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd
> + */

Don't think copyright works this way? You can't move the code and
claim authorship.

In general, git tracks authors and contributors, so not sure
why we still keep putting these explicit notices..

