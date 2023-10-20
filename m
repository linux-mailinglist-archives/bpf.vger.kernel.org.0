Return-Path: <bpf+bounces-12782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE77D7D066A
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 04:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D9B21474
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40F80E;
	Fri, 20 Oct 2023 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/xR8l/Y"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FA648
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 02:18:55 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B376115
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:18:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso219066f8f.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697768333; x=1698373133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iowCwKx0hms+9vWcvXMBlb3EmsxwHOzjkcYgLeha20w=;
        b=O/xR8l/YOFj7GwNI0BcRYdMfwMSy2rmvohmudIi/4nxz4fLEHL+2+VHOdk7SxKdRFT
         u3DajhAhio9gDRZut/w0Aa+Hc8b1/K+HAWREnNooGF3a4ZXRPjG17g7+g86/U+5nZlLU
         fQCCdqKh1u641qva+N2taeEUvMQapQ/cgbCxm9fXplPqcaRSR86DVvh8Ccn2t6R+FZM2
         UBQpHPh8z0MF/Ief85jodatt0KEZuDKA0fLRZxaDR6Bd9CJ+aYDDrXD6CzT4PT01a4WF
         0nG9uhe9iBDLkqSMxsO5WBCmu7v5yhtwYvaCuVxW7Zm1gXqguCl/f1K0l7CJ2MucY6NF
         5hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697768333; x=1698373133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iowCwKx0hms+9vWcvXMBlb3EmsxwHOzjkcYgLeha20w=;
        b=Nsyzoc7JP+Nh7FySfXWSwcXjHKt7i5Ka55hAnALYTce34qFYafGTnZb2i1h3Zp5G46
         59fpZVq4WYiXd2F/eziadcbTgRdFn7us6zoBHs+E/dqWVslMnyQPhmuLJAXmCe2WV3aO
         K9skscXyQZtSVarsPqvvmj8IUwrwP5ljXiXnwvF0VTQyzdzGr7Sl6PA0LlT0PfNHZI4V
         3qaI36JaUyTWRilIH5YBAD5LdlYrLCntETG1Hh8BDta0Mk2gKc5xpoELNRrROujT95SU
         bhop85w6Ylj9vXXZytXgUDb4vDCHkSXH1pWoLFH6Sw5tebjS5xCdPRBiBUJYIN0s4Ezg
         U91w==
X-Gm-Message-State: AOJu0YyByApd5pZhyoVI6namrbKliOul2mWU4pPYxc0dPCBf9B9J5aYQ
	WaBLUV3pO6qAgdBR+tTjDM2G3Nqln1RtXWLY0O8=
X-Google-Smtp-Source: AGHT+IGqpYWrGh2bULQjA6Rsk7bkvBsqvu+32qO9K+2xJ/VsIB22i/+F749KQErKIhBvGoXTwBx3/zZYkLLNDgdKSJ0=
X-Received: by 2002:a5d:5347:0:b0:32d:a373:2f2b with SMTP id
 t7-20020a5d5347000000b0032da3732f2bmr274337wrv.36.1697768332908; Thu, 19 Oct
 2023 19:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018113343.2446300-1-houtao@huaweicloud.com> <20231018113343.2446300-3-houtao@huaweicloud.com>
In-Reply-To: <20231018113343.2446300-3-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Oct 2023 19:18:41 -0700
Message-ID: <CAADnVQ+GSet7pttt1A-U6HCbfssUxUpGV_AQpCWUg58p3+FWgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] mm/percpu.c: introduce pcpu_alloc_size()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 4:32=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Introduce pcpu_alloc_size() to get the size of the dynamic per-cpu
> area. It will be used by bpf memory allocator in the following patches.
> BPF memory allocator maintains per-cpu area caches for multiple area
> sizes and its free API only has the to-be-freed per-cpu pointer, so it
> needs the size of dynamic per-cpu area to select the corresponding cache
> when bpf program frees the dynamic per-cpu pointer.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/percpu.h |  1 +
>  mm/percpu.c            | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 68fac2e7cbe6..8c677f185901 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
>  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_=
t gfp) __alloc_size(1);
>  extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_=
size(1);
>  extern void free_percpu(void __percpu *__pdata);
> +extern size_t pcpu_alloc_size(void __percpu *__pdata);
>
>  DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
>
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 76b9c5e63c56..b0cea2dc16a9 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2244,6 +2244,36 @@ static void pcpu_balance_workfn(struct work_struct=
 *work)
>         mutex_unlock(&pcpu_alloc_mutex);
>  }
>
> +/**
> + * pcpu_alloc_size - the size of the dynamic percpu area
> + * @ptr: pointer to the dynamic percpu area
> + *
> + * Return the size of the dynamic percpu area @ptr.
> + *
> + * RETURNS:
> + * The size of the dynamic percpu area.
> + *
> + * CONTEXT:
> + * Can be called from atomic context.
> + */
> +size_t pcpu_alloc_size(void __percpu *ptr)
> +{
> +       struct pcpu_chunk *chunk;
> +       unsigned long bit_off, end;
> +       void *addr;
> +
> +       if (!ptr)
> +               return 0;
> +
> +       addr =3D __pcpu_ptr_to_addr(ptr);
> +       /* No pcpu_lock here: ptr has not been freed, so chunk is still a=
live */
> +       chunk =3D pcpu_chunk_addr_search(addr);
> +       bit_off =3D (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;
> +       end =3D find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk=
),
> +                           bit_off + 1);
> +       return (end - bit_off) * PCPU_MIN_ALLOC_SIZE;
> +}

Dennis, Tejun, or Christoph,

Could you please Ack patch 1 and 2, so we can apply this fix to
bpf tree before the merge window.
The series fixes a serious bug.

