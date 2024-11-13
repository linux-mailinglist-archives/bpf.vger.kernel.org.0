Return-Path: <bpf+bounces-44698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6BD9C667E
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640711F25333
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15B14A84;
	Wed, 13 Nov 2024 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKQeCEwZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65905382
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460425; cv=none; b=XTezkbrkUgqzdlHjAS72bmVjBmWm/wqmJiI8Mzzx2Klc+9Tn239Ykc63IQmgHJMUUVcmFHxiNCot+LKSJRXngPglqbPJofJc1CRGIg9svdWUJCxJfIPXZ/XV2gH72AlGkiaL7uONCsbEoJqlBw93WfLP5oIIUjdzZB0hf1CrtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460425; c=relaxed/simple;
	bh=U6h5bD3FvHQzWIPkzZRJUoz242k7Q3EKVtEIwVNt0qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFSbnVMMH1g59aU/KqbZ1/psf/rSRw41hhmLVZ74Gx6D/nqqgLO/5A0t1uoDUtQTpAa5ZXAlNVEUrw4WvJhkfdaQCkZEdwChMooYztymqZ7yX/zMR0psRphzJ1Fyv20IkWXEhPTFo1yYA7h3b3cVTardCkgGaGxhRJQWcEKAp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKQeCEwZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso4017818f8f.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731460422; x=1732065222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2J/fzb8Z+Z6V1ow+GsjF1gd8ZPu6q1zdXccNAVZN6U=;
        b=VKQeCEwZCgu/d2okRHwIk4deLrPbAfSqNfifr2i730xq5GPr+z/zUHuwThmKEZPVPV
         EJ17iaGjd2kEuH8OJzsuD8MzWdrmoYZWAJErNMjzqGvDSiO+KQ0OQA4XGUve66Gv8Xiv
         dtz89QMSp/69fjOZDmR/ICfUwMPoKol9d5phgHc8FKzvrjWmzmGPGztfbCwOaFXN8Q/A
         AaWSnVWvqySw4cl9V88eUf4eGflCQCedjWcZbZdDD2BMfnDLY/R2mAAC5evBp/7mfRil
         nxxaiS2NTItbbYVD2px9oc5Md0bko9NGGdpf1r2VuusA5uc3NHbfh8br3opgF7bsyHIb
         6w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460422; x=1732065222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2J/fzb8Z+Z6V1ow+GsjF1gd8ZPu6q1zdXccNAVZN6U=;
        b=AfT7X3oGJ0D6vyHTzC+Z98EKQfA8cqATq4xDacxyf5nfrFnXeLMG71f5bXFXGZUpSe
         KV/WgLyGpGH+6hseg3qXpWHt2SKARe/5ezEemEWaGKScpWDChhVfD4Bu+zm2TYuJGyiv
         K1YKnJAN5Rf1TA0T9pJXcb037Q6roJb0lDAQBimgmpXglZ0I6TU7b5zUxGAUXrCYF+/Q
         QyTxED7KA0XD005IMCsEjML+DBENMVrISX+R74559///4FBPwswxBYMuAnjtkQJWXr1Y
         HnlvHAHvYYa2FReyrnG3aDsL77YP/bGM0OTdmoVWWXZZfaj9Vks9T3DT6IlH6XI4Ik2z
         YPaw==
X-Gm-Message-State: AOJu0Yz6cIhFh3fra+vJwHaBROKGrACxkHTJar9kWkC68DJnoIMDPZ08
	L+IyGWT+irZVg5n+kDVzByf62/D+cIE0Ah495BKFXIz8L3inX5H8kjqRCxbnQS5eFcuTbffYEEV
	sqhsIZQVKEV6gEJ45edVrArOqmlA=
X-Google-Smtp-Source: AGHT+IE2fsw5r0k9NUmI07gMUErT0/DL4VLjVl9OMnWy3l4LaDq67SvmAroeupc7m53x+ev6kHmcMAaqWWGt2n9fEiM=
X-Received: by 2002:a5d:6c61:0:b0:37d:5084:b667 with SMTP id
 ffacd0b85a97d-381f1873091mr15581461f8f.33.1731460421656; Tue, 12 Nov 2024
 17:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112163902.2223011-1-yonghong.song@linux.dev> <20241112163922.2224385-1-yonghong.song@linux.dev>
In-Reply-To: <20241112163922.2224385-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Nov 2024 17:13:30 -0800
Message-ID: <CAADnVQJ0Hzfn8rUtOPCUy+qFjMMQiyPFpLRr6fN+8gRzh9wsPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 4/7] bpf, x86: Support private stack in jit
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:41=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> +
> +static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int al=
loc_size,
> +                                  struct bpf_prog *prog)
> +{
> +       int cpu, underflow_idx =3D (alloc_size - PRIV_STACK_GUARD_SZ) >> =
3;
> +       u64 *stack_ptr;
> +
> +       for_each_possible_cpu(cpu) {
> +               stack_ptr =3D per_cpu_ptr(priv_stack_ptr, cpu);
> +               if (stack_ptr[0] !=3D PRIV_STACK_GUARD_VAL ||
> +                   stack_ptr[underflow_idx] !=3D PRIV_STACK_GUARD_VAL) {
> +                       pr_err("BPF private stack overflow/underflow dete=
cted for prog %sx\n",
> +                              bpf_get_prog_name(prog));
> +                       break;
> +               }
> +       }
> +}

I was tempted to change pr_err() to WARN() to make sure this kinda bug
is very obvious, but left it as-is.
I think kasan-ing JITed load/stores and adding poison to guards
will be a bigger win.
The bpf prog/verifier bug will be spotted right away instead of
later during jit_free.

