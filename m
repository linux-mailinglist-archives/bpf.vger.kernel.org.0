Return-Path: <bpf+bounces-72840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D1C1CACA
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FAE625412
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC68354712;
	Wed, 29 Oct 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgJGfjhJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB82F90E0
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760872; cv=none; b=M4upVkogQel1ZAHzPTEtk9Rp5EP9qaW3qkl68+UN0nwdhXNATmC0v8MxCyAfaHlXXqyieLRXeBnnlpXFli4UY0M7C5cwPohll8PbxCIx8pNP0Y+jnPsqAcN7mDwBfVWHQEp9d/HyRy5kKUasrx7zfteEjShGuXXEaKWj11JIYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760872; c=relaxed/simple;
	bh=JkICoGulKusPgrOc+3fQ7LIX9fdSC22eFlUBUNRokJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtyHf9IMfaLs0j0Udns+MxBlTrc//N/E4CAMMGRuPRtGphGkTKhPQYNcKoonTNeNPZqjOFSJHJktrHqrueWerGvN1ekr8/+VWGSU0lrl0X/Nmmh71TCCvKG5t/8Yu1hpgLb+R9qIvtdYw5xPm2DDEltXsiRUJSV9ny65a/V2GMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgJGfjhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A92C4CEF7
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761760872;
	bh=JkICoGulKusPgrOc+3fQ7LIX9fdSC22eFlUBUNRokJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NgJGfjhJaNs4l82+eMSh2r1EAx9uk5HPJAyypHw9PeFAnh2Pd/T9Ut6BEUZDAxvMW
	 C51qBFa5otR/uKQ7dcLeycr0Ay+T0GY6ye9UTaCGCjrJu/lkMmwtbaJOSfdo3XJHd1
	 ObCh5UYVDwzRvT+NLz+PqSgB5CBSK1564+6og8MbDc86VgxBGBy1xAjPIcIDlPsT0u
	 hW5hzztdbZa2bABOBiKSqpn0d4KBxiMJThHlo5sPOMM2g34vAqpZgX63HfzlaZ4nN2
	 H0VO0XKTKApg1SgG+qo2ojtqWg35sQ3GMu5U4W5++yNuGiU1RZ3tsm73dC8fHRQsUt
	 ASSg8KjoiFbFg==
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5db4006eb0fso134363137.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:01:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1S3zpq3nWfiEylSxxI+seVuc/VQral7fGPb5LA8Irarx3rhyxMfj3sDBul73A7PRMNEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJ331OnysJcgW49YHpVNA6JZzLM34pBre6kZFo44C3vvrLKOy
	awhK88kx/sveEfWz2SBJ9Rsbm8pzLby843n535Kx+ItVib8LNqAOwPiRcDxl8OLcefPc6oPO2xQ
	d96ZeClQZ1pW0VJI8ow3g3rOOBN/hapk=
X-Google-Smtp-Source: AGHT+IGGluDTc586NCbCdlpQu935QL/Y8fXJ0sSPv0be/Dt3sEhhVMZJsoK1V7je9HKakunNObg8WJdRv0NwLivAn6M=
X-Received: by 2002:a05:6102:2c06:b0:5d6:6e6:e097 with SMTP id
 ada2fe7eead31-5db906819d1mr1467428137.33.1761760871248; Wed, 29 Oct 2025
 11:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev> <20251027231727.472628-3-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-3-roman.gushchin@linux.dev>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Oct 2025 11:01:00 -0700
X-Gmail-Original-Message-ID: <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
X-Gm-Features: AWmQ_bmAg580HVj5YBdyFsS189BaIn-vGa9b15QV_82EsPqPQmTP0zb5M7q-qAQ
Message-ID: <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
[...]
>  struct bpf_struct_ops_value {
>         struct bpf_struct_ops_common_value common;
> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *att=
r)
>         }
>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_map_lops, NULL,
>                       attr->link_create.attach_type);
> +#ifdef CONFIG_CGROUPS
> +       if (attr->link_create.cgroup.relative_fd) {
> +               struct cgroup *cgrp;
> +
> +               cgrp =3D cgroup_get_from_fd(attr->link_create.cgroup.rela=
tive_fd);

We should use "target_fd" here, not relative_fd.

Also, 0 is a valid fd, so we cannot use target_fd =3D=3D 0 to attach to
global memcg.

Thanks,
Song

> +               if (IS_ERR(cgrp))
> +                       return PTR_ERR(cgrp);
> +
> +               link->cgroup_id =3D cgroup_id(cgrp);
> +               cgroup_put(cgrp);
> +       }
> +#endif /* CONFIG_CGROUPS */
>
>         err =3D bpf_link_prime(&link->link, &link_primer);
>         if (err)
> --
> 2.51.0
>

