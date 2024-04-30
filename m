Return-Path: <bpf+bounces-28291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACF88B8062
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 21:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9C21F23997
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB9199E84;
	Tue, 30 Apr 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YizhJOof"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA515194C8B;
	Tue, 30 Apr 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504762; cv=none; b=rKR3iPPDvBM95F74345poEaZn0XdBBOyJDDibNyBIkgBiTHjJc/wfoSOuhfNB9u/JA7iTkLPq1w/mN0rbe/+p/wSAJtU8THDpelOHc+FkVo8Eq3RIMqMNaQaomI22e8gVaR3wmY8XjpNNIADJmX9yHDnmyQYSpTeO2iZrwAmTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504762; c=relaxed/simple;
	bh=z+qde+gt9C/fcxAsuzbK9YjKXb2Ca0riTnpbLCOoQzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwVw5ATWJMU65jx5nqy/X735XQiKvdfP5t0rJkFSQwtApOUtLpxwkWQDrSEzGnYFlcLSzjhSklUq4Tx68bEjn4AxWQWKbTpka7BNVYW4UZhD5Wslmzzs5QYHfBqw6/fnTZP4NYlxSGgGg0XEgw739vdFZrObdgfz+3w65NC+jJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YizhJOof; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso7460865a12.2;
        Tue, 30 Apr 2024 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714504759; x=1715109559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8uFehdUx8z7xRSqATk4C9fttlOvgfKnCVngjCGKN8k=;
        b=YizhJOofhd1KBfqNBW50da+471do1Uwd5VZO8btYFTUfx7h0QAIfXLUOB0Clf19YSH
         H9L1ZXwTzLCOk4H3TS+YnK88ca0jdeHjgxuqGPdhM1htQn7pQsuahb16/OMIJlKBXkAh
         fPxd0JYRv2oXOwS5saJW7HDogeAYQ9AQXkBWXEZiKPHjZvN9SD8HT19xwd94ZaGUXbp5
         G3JQvI67kTDZaNKcq16GpJ4hsyUkK244NvB9hl4vVEnFkwwhYz4drfFDE3cTAlZd4wsV
         w9L/5YulxkWC811jjt5//VdTz8U6PAgeZInEeykRNsrR5xEqWxGGWYBirGsCd0RzvTTC
         CG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714504759; x=1715109559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8uFehdUx8z7xRSqATk4C9fttlOvgfKnCVngjCGKN8k=;
        b=MXDuFXUXu3xrim972B3mwRguGHWM6V7TGDO9CHCU5OJ3zVbq5jByxctTbg2olwCKcJ
         O4iWAkBYHIReOlcfZv0GBcbVQKAr/6mlCFmkP8SqgSh6oMqpGyzwXaAdIMRfx56hIGWV
         afViFzXwL9+fwg1c+hliw+/v921HaKYg+UluBiBaSw57f7wgIhSq7U3mRGpmGw4kfQxn
         yXPbuBk+9+LVUgbiAqZcyxzOKRRu6ZNIpdlEqfm0Mg451fMai1FlKIGVSiprbhvzbvhS
         td1+og9U8XqV0hXV8AgGAzsKlVFWYl8iZg2lTjuO25WbOD2Ho5Nal0330+KyhqbUt2G/
         zptQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmv2IVJ6PaaUln/Dks7rc6+fDoJcORYh7yG68w+G192YOBsu/3JKhQ/bGPDL+VafLjDjPlF5cBlrfaqskd9iKmVlhNjMj1QWo7fDhe9A9kfU4eLYKYOoLNb2a9KBjd+Qdu
X-Gm-Message-State: AOJu0Yza3cJLf/DS84XbrhGWR/K5vsT6Pdi0X5ryBN5Fe7erJVo2rMuC
	+ggsk6ZTaBstx/F9VNAYqUOP+cBJvL40k0ugQaVxJwE3Wi8AlU8GPTvEEKnuUB0TZGPRvkpYnqg
	cYNlGGJjkV8UFJG+3E0Fshv2/IbM=
X-Google-Smtp-Source: AGHT+IEKrt23r1vzcFtSNgqLbuDM5BDbdQzAfothjE9a3Eoilzg+lQJblIhWkCeheA0myxL8nNfFZi4b+9i0EQuW3Rc=
X-Received: by 2002:a50:f613:0:b0:572:47be:be36 with SMTP id
 c19-20020a50f613000000b0057247bebe36mr182665edn.0.1714504758705; Tue, 30 Apr
 2024 12:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430175834.33152-1-puranjay@kernel.org> <20240430175834.33152-3-puranjay@kernel.org>
In-Reply-To: <20240430175834.33152-3-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 30 Apr 2024 21:18:42 +0200
Message-ID: <CAP01T74ASv5t8O1SPZgsWhgymK3303x9z3mFroHNgaHEZdjoxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] riscv, bpf: inline bpf_get_smp_processor_id()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huawei.com>, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 at 20:00, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Inline the calls to bpf_get_smp_processor_id() in the riscv bpf jit.
>
> RISCV saves the pointer to the CPU's task_struct in the TP (thread
> pointer) register. This makes it trivial to get the CPU's processor id.
> As thread_info is the first member of task_struct, we can read the
> processor id from TP + offsetof(struct thread_info, cpu).
>
>           RISCV64 JIT output for `call bpf_get_smp_processor_id`
>           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>                 Before                           After
>                --------                         -------
>
>          auipc   t1,0x848c                  ld    a5,32(tp)
>          jalr    604(t1)
>          mv      a5,a0
>
> Benchmark using [1] on Qemu.
>
> ./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc
>
> +---------------+------------------+------------------+--------------+
> |      Name     |     Before       |       After      |   % change   |
> |---------------+------------------+------------------+--------------|
> | glob-arr-inc  | 1.077 =C2=B1 0.006M/s | 1.336 =C2=B1 0.010M/s |   + 24.=
04%   |
> | arr-inc       | 1.078 =C2=B1 0.002M/s | 1.332 =C2=B1 0.015M/s |   + 23.=
56%   |
> | hash-inc      | 0.494 =C2=B1 0.004M/s | 0.653 =C2=B1 0.001M/s |   + 32.=
18%   |
> +---------------+------------------+------------------+--------------+
>
> NOTE: This benchmark includes changes from this patch and the previous
>       patch that implemented the per-cpu insn.
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

For non-riscv bits (& fwiw):

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

