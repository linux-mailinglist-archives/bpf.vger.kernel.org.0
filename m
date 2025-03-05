Return-Path: <bpf+bounces-53281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC0AA4F4B5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CBC3AB8D0
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6B1459F6;
	Wed,  5 Mar 2025 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiomJ5dd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FEDF5C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141892; cv=none; b=bu7Er18+CTXxNC/1C8fGQj99hV+I/BuofZlHOGlZ9HjdTbsuxXOcG66sbvgpp+bSvzvesmotnb/q+7Qzo3Zc7zzpQSDBbeygy6J2Ca2WXUwbj6REwLi+K/45vR67mlzBNl0/8/uUZiqkSFTjD+3zbXQtOvVMXGusaZMGAS+U+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141892; c=relaxed/simple;
	bh=FFY7sob+Xq/HBJAmcvz7XWfK+U2pHQ3DLN95m89t2ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHU+ZI2xjenaVp43JCrvOuS/jcHGWvq23szjkn1hkUQpdl8kbQC6DWojSw87sPRZdq7tFQC/fzoir9EVkiaEiC0szuZgY5Rmu4o9Pv8vBK6FGmCimJqq829h0EcTQh5Kd2QVrNElZX7NOvhoUdATilLF9lxSA9RqE2BeOdxLRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiomJ5dd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso40921605e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 18:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741141889; x=1741746689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX3ihw62Kc0Fe3IbsSKcSTYV7Mf87hYNhqHZt6DTO/c=;
        b=eiomJ5ddJ65SjC+r43XOocl1wMTGa55pKv6Pne9Ih5iEMXZZI1ZJ7OC9GrkMHsVe4J
         H2G1gFFJF+dq9kyN0nn423stoN6iC9udgRR5AOM2Ad26c+q8b5vRKpAoQqyieqIyVtU8
         1oxgdtBybEBf/tEajfoOJSsoVRHJwEICoklH3u1uo/Rdt4KLote1MRuZZKMra0PI+eI4
         ajsquyjmoenzIaOBocIBhQ5/aM7ezIf7UjTD38rW1bbNV7U1zrJyIPpFGjt/D21KSmFG
         O8doXEOrw/dLnsU11IRozC2GDuItv6IesrcMUb3/woXUiSgl2rUPmOcDjLdI1Q023r4t
         wg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141889; x=1741746689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX3ihw62Kc0Fe3IbsSKcSTYV7Mf87hYNhqHZt6DTO/c=;
        b=vWhJVUq35YFqmHA2IiqeFRgffX/yZ/ZsbosMxE/44UZY2ZFUW+2cDOB/+Eyk10VYhR
         Xc7A8t9AwiXEO9z/1qqBmqkvrsZf0LMHos6FBStoCGXK5USyUp7qkJJ9zlaWD0Wz4NGA
         5P7Oq8Wt8qzmetWhWjFfvL/TABd8zuCG5ZO226LiTQKFY/x9vZ6wMCOGIwzNkTqNi22w
         zGADYmL/Q9G15MMHz+6HeRn8JEkCHo9yBxQrbc2FFQVDvyOKD0B89yTIGIYYT/tVgwNd
         mN41HaOiesBqclRGgY9A1y47yyM8KyHts1uoV/EDJ/rOR9JzdKi1wFFC690waA5PgG/i
         baJg==
X-Gm-Message-State: AOJu0YxFYaagYtDW9eEDX1crtsuhqFqYAaU5BV3hSiHe+QUeArt9gtEj
	zTTSnl/EiMLp29+wseeAaC4ux+dE/YKMLNSg7RZpf5g0cc3QWuDC7rXyIO4HXGhAy5xvptXV15f
	glnIsrQPprE4/ypgEbD2Y8O/FyHk=
X-Gm-Gg: ASbGncur30oxpXo/0ZToT8XfNmuwSEYwG9lQgYBWWhbwQgsl75PdchTqjAJoXz+JZPm
	muXDws4h/cwcZs2z1aNpj6IfrFKJljW+ZFVPvA2vk/hRj/kUEfcVKunKbQDNgXKcHiOuJYHiEaI
	KtyqTYBynUtDZ9EDcfosJX7NQkcPiycS7aRRpXez0T3g==
X-Google-Smtp-Source: AGHT+IHg92PfcOlB+h16TqtEHaNGIOxDY9w+l1ISE9419Rv0O96TaD4exof8jiUwKIsZOrjav5SG4bDbLp/yy8N5MtM=
X-Received: by 2002:a5d:5f4d:0:b0:38f:3224:65ff with SMTP id
 ffacd0b85a97d-3911f725ea9mr811104f8f.5.1741141888660; Tue, 04 Mar 2025
 18:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305021020.1004858-1-emil@etsalapatis.com> <20250305021020.1004858-2-emil@etsalapatis.com>
In-Reply-To: <20250305021020.1004858-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Mar 2025 18:31:17 -0800
X-Gm-Features: AQ5f1JqGSZ85gkiwE2QXRxqmIReGRRdCtbYVnrSkkKQI44Tpp_RMAnsMCoXgMWc
Message-ID: <CAADnVQLiZLwbGkDTT40vQCAw+G74F0wHH=nAER-wS7Emzv7Yow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add kfunc for populating cpumask bits
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 6:10=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

commit log cannot be empty.

> ---
>  kernel/bpf/cpumask.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index cfa1c18e3a48..e4e4109b72ad 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -420,6 +420,32 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpum=
ask *cpumask)
>         return cpumask_weight(cpumask);
>  }
>
> +/**
> + * bpf_cpumask_fill() - Populate the CPU mask from the contents of
> + * a BPF memory region.
> + *
> + * @cpumask: The cpumask being populated.
> + * @src: The BPF memory holding the bit pattern.
> + * @src__sz: Length of the BPF memory region in bytes.
> + *
> + */
> +__bpf_kfunc int bpf_cpumask_fill(struct cpumask *cpumask, void *src, siz=
e_t src__sz)
> +{
> +       unsigned long source =3D (unsigned long)src;
> +
> +       /* The memory region must be large enough to populate the entire =
CPU mask. */
> +       if (src__sz < bitmap_size(nr_cpu_ids))
> +               return -EACCES;
> +
> +       /* The input region must be aligned to the nearest long. */
> +       if (!IS_ALIGNED(source, sizeof(long)))
> +               return -EINVAL;

add !IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)

so we don't penalize good archs.

> +
> +       bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
> +
> +       return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
> @@ -448,6 +474,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> +BTF_ID_FLAGS(func, bpf_cpumask_fill, KF_RCU)
>  BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
>
>  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
> --
> 2.47.1
>

