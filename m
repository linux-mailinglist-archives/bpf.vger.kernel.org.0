Return-Path: <bpf+bounces-72636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C67C1709D
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DD33BFC4D
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF22D8395;
	Tue, 28 Oct 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phmrTVky"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F97155333
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687235; cv=none; b=U1CsDtFhsQPq6UUeXxYujqo48xqd/YOxXTK0fofbUp4TDdj81GwNTMqc0eMRDZUW+oxMjeZASqk7QJasZ4+IQ0/YOmp9hsIeB5Kb1c/8+ZCmdksfpRxK8o8G9GuDyo9cNLfDHDOLF9rzhe6x9kgip1/XJCyYxt/hDaz7wf92FPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687235; c=relaxed/simple;
	bh=iFWP7xxMJgkbRCwFD/Ow8yzZAuMAdW311BwnuPvp2SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtocNgkq/+ayGujzwZAhGw23uiFAr/kiCgHIJnhWuT/5gkcCD68Kzva4KbwhqpDKyGFqwL48dGEteU0TwQrURunjpDo7JgPZdWk7Ylt9gNMwe/Icoap0cvQ3hVI/ssXpfelzffQ8qAL0/RZA4JREt/pjYuo8FOjn843BWWexmPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phmrTVky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD2C113D0
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 21:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761687235;
	bh=iFWP7xxMJgkbRCwFD/Ow8yzZAuMAdW311BwnuPvp2SA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=phmrTVkyk/RJJ+EFRqA64SJtzZw1RrTXF0Jy7f1CXc/pvZLehllXnDr4sgfEh9lXA
	 2/twG9h2eNIdBfauTgXEQuIRcS4YaIBUHDFnASGVKVGIr9PViTjDz3uHg1aUHndGnm
	 JfmMrIDVcmMtfhGvsEaRyHNrcNHVVSFVyWqW7mc2lxSIew6H7Ge6bK3IDkKkVZFTE+
	 ckLbL07VYqopMUKqVW/aEdK3rZ1Vhdn7Jx2oYQrh9yRmC9zb2iiksD6jhqrAr/U6XF
	 BoaOIR9Ixch8dADOEBUFirZRLio3iFt5cOVoN7gFFs9TvytO8YcKQnFMJVdWxBjyCE
	 nG+tulYpts/hw==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87dfba1b278so68400346d6.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:33:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9LAy8bZXMltJRCrRSjCwGNxMWz8O5qtuqLR2TIjpuWGCscS3YagnyJwLAXpTqL8Rl124=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1L7pBYsgq/B2A9ywFTZEKSoF4d5efc2z5cKmTLyX7IfIoklnn
	XA0D1cxL7qn8FipnuZqHETy0LnL7Szz2wv0yNviM9T2H4TU+lGUGalZoLlGBSFjvgaEEqS448DP
	SpJcUY6Gv9/W4rhixeqhBnVDN0zFkAsU=
X-Google-Smtp-Source: AGHT+IESUEc3eeZzEWwxs00NmoTrW71KQg0jPt0Nsondh+RQEdb4dLarCNV80h0sV/jj5ri8Uz9bMzHY51U++MLe3GA=
X-Received: by 2002:a05:6214:2129:b0:807:ca4f:5666 with SMTP id
 6a1803df08f44-88009ad0903mr10291646d6.2.1761687234390; Tue, 28 Oct 2025
 14:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev> <20251027231727.472628-7-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-7-roman.gushchin@linux.dev>
From: Song Liu <song@kernel.org>
Date: Tue, 28 Oct 2025 14:33:43 -0700
X-Gmail-Original-Message-ID: <CAHzjS_vrNZpEbBuHLhHwHaGzLaF3QEeKWz-VikCm0bYrFBq4UA@mail.gmail.com>
X-Gm-Features: AWmQ_bn4FJi2CLDbiuBc051gpuUbvflP1rY5GJvh4T7UtMPVn-sJ9ZXRwYG7Zb8
Message-ID: <CAHzjS_vrNZpEbBuHLhHwHaGzLaF3QEeKWz-VikCm0bYrFBq4UA@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
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

On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
[...]
> +
> +struct bpf_oom_ops {
> +       /**
> +        * @handle_out_of_memory: Out of memory bpf handler, called befor=
e
> +        * the in-kernel OOM killer.
> +        * @ctx: Execution context
> +        * @oc: OOM control structure
> +        *
> +        * Should return 1 if some memory was freed up, otherwise
> +        * the in-kernel OOM killer is invoked.
> +        */
> +       int (*handle_out_of_memory)(struct bpf_oom_ctx *ctx, struct oom_c=
ontrol *oc);
> +
> +       /**
> +        * @handle_cgroup_offline: Cgroup offline callback
> +        * @ctx: Execution context
> +        * @cgroup_id: Id of deleted cgroup
> +        *
> +        * Called if the cgroup with the attached bpf_oom_ops is deleted.
> +        */
> +       void (*handle_cgroup_offline)(struct bpf_oom_ctx *ctx, u64 cgroup=
_id);

handle_out_of_memory() and handle_cgroup_offline() takes bpf_oom_ctx,
which is just cgroup_id for now. Shall we pass in struct mem_cgroup, which
should be easier to use?

Thanks,
Song

> +
> +       /**
> +        * @name: BPF OOM policy name
> +        */
> +       char name[BPF_OOM_NAME_MAX_LEN];
> +};
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +/**
> + * @bpf_handle_oom: handle out of memory condition using bpf
> + * @oc: OOM control structure
> + *
> + * Returns true if some memory was freed.
> + */
> +bool bpf_handle_oom(struct oom_control *oc);
> +

