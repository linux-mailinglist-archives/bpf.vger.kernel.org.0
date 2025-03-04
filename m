Return-Path: <bpf+bounces-53248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF06A4F000
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 23:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A587A7397
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96951FDA9B;
	Tue,  4 Mar 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7EpLZGq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275A1F03D7;
	Tue,  4 Mar 2025 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126774; cv=none; b=tcln5iujsVcl5L20rnBzKOJkLnWGMYxnHDmVI4mIYaZkX+KGS6OaZmT1FEF7Vn42XQ7Yc3s/mMDkFECDnlz4NwiE7HV/ynr+7VSDE7U2sXQsCYGGCrnjDm++fKEs5O01N4zTyYGz0E33EEcPn3q8MPywFhxrohhCE6qfaQjjVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126774; c=relaxed/simple;
	bh=JlHcj6u/gzHc+jr2w3RZkgVR2UBvZLumzzsoWt33zVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=holbrC73ovYQIsCq1uqMgT8VQy1bEglx0erXfAtQ3BjyAT/gvmPe0VAO0GyOT5ytpyddcyyQXuZIRYLa74mx65RB4fMQWCLfe39ORzrxAb43Y+s5tYsGgKXh1/uUI3YkwMI+lKdhUb+tCz43YaU2lQ5UFSLwMTVlaaEaZRxDP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7EpLZGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA1C4CEEF;
	Tue,  4 Mar 2025 22:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741126773;
	bh=JlHcj6u/gzHc+jr2w3RZkgVR2UBvZLumzzsoWt33zVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g7EpLZGqw+3Oi28j446nfBJaVbYes3y4HfkpwGlfIkYIKzJbLl62rC8e74cSkZ2kN
	 x54MQaR/MRel2YMWOze+Kn4s4Ft4x9UYusozXx1qgJz12WH7hG1mvFPgBxwMUT2519
	 6axQQYdDcxvAeIf3YjNJpc9+K1v6OLBZtrqFw25CkpcwW0yHxP09z5nFfgKWBlROGy
	 tAMxjso3h5Y1oVoZcIGLob8w2rD1Twi9XBx7s/DcfkfF1eUunv4bHTulP4A9/7Lovl
	 wFGCLJtZRBaUMxjAECUuJf0iANOpBFjKfeMOYlOwbi48HQQWymOiESrN8NjEbm8VPF
	 q9UihKgk0x2Vg==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so20422625ab.0;
        Tue, 04 Mar 2025 14:19:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/HjqsMgdqKzs975AmQrppLzO80o8iiN9/o7GVDqJlHognqGKRXyJrk0UUu5JQfcgZ74k=@vger.kernel.org, AJvYcCWGq9kAkw61PG48fRydaMNLafG9AsAPmv4B/jUaWf7DtBeEXmAagXyMcxWij62Z/fLkfOOntKgmTZO9vqut@vger.kernel.org, AJvYcCX9FpRZdNW3STLwOuDmKCbUFth9yl3zQ9j0YPBJ54XWhQa0Dpq+v7O9aIkrXpa5OxaLdDHFnBOZfcrz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywznn8nGWbkuWRBYNwzCj+W6epJqee2TyN8hzMhlkJc/NO9mH4K
	LtD6bWnyevcVAeXw2q05RlNCct+omCGJpWujwCERrixeBfRM9Mo8QorkdTKlMI6G/+ZN60dFwAm
	awWb3NPHLv0mKzxpg9i1T+N97Dcw=
X-Google-Smtp-Source: AGHT+IFUvrwnqLa+FC83yVK8URcKieeZt/81kczIwIO/bglfFZBkiSZtmOagtbAFh/+0HdTfNdrPo25hl/hEM0vM3ec=
X-Received: by 2002:a05:6e02:180c:b0:3d3:d17b:2d95 with SMTP id
 e9e14a558f8ab-3d42b8d3dbemr11785515ab.12.1741126772988; Tue, 04 Mar 2025
 14:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304204520.201115-1-tjmercier@google.com>
In-Reply-To: <20250304204520.201115-1-tjmercier@google.com>
From: Song Liu <song@kernel.org>
Date: Tue, 4 Mar 2025 14:19:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5uMAHoT0XbDLW23u_SYLyM7-oJXykG+az2RkQdiD2SqQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpYFT97tNU7gIjgCbQmuo9nkTMDE3uPBsNRPXkiH37S3HdGrI2R1NVpL_Y
Message-ID: <CAPhsuW5uMAHoT0XbDLW23u_SYLyM7-oJXykG+az2RkQdiD2SqQ@mail.gmail.com>
Subject: Re: [PATCH] bpf, docs: Fix broken link to renamed bpf_iter_task_vmas.c
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:45=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> This file was renamed from bpf_iter_task_vma.c.
>
> Fixes: 45b38941c81f ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_it=
er_task_vmas.c")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Song Liu <song@kernel.org>

