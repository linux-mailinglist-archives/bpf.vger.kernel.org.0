Return-Path: <bpf+bounces-61414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BAAE6DD0
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350E417B431
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345322E6126;
	Tue, 24 Jun 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YymBHdsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036E126C05
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787120; cv=none; b=Ymr/Q6S39e1tpC0ohp/r9JuKybSa+W+vNATesc3JPEcjkOEl616IQAy1HQsO6ltPVxj+nvpPlk/E9YGeSzf6lU/VbCWd3rt9VrwzabrHI0hWyKiLIN7fqWyu2pebzDB4CQIMeCaOBLyldl/J3kewaLHtXJVGgG7LBtukLNK80rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787120; c=relaxed/simple;
	bh=TUtthUHFJ/Ol3SboUPKI0GS7jsYDwfGCJvyuvKBZ8Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1IJv6R8ZZSVnu6Y6OAUIaDATY4OBywikwlQVobuivStDdTd6SrcycGrEaRmn4ZmawboeHW+DEKwmoeWAOWltd9jrTEapmTi7PWD9+xZPcraNUP8R2GQK9px4WLn2qvfAF8rvDITpN2zB+IBaW0bBqM/lR6P7SqMOFGFMn5QLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YymBHdsj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so3852185f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750787116; x=1751391916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlWvk0Cr7aIK1SoveZrEy2lNuPSsCBNqncsMmg6/eIc=;
        b=YymBHdsjs/Ovx/UGxj0XUW/HQlxkaMW8f7MlV/TKvbeOUw8oSqImVKEAI9YzgIdePa
         loB8+ttkr7etJDSovTogzwMnNI6MzCwleiGe/0/GRLyAuog6w4ArQCq4JAy057aIQe+f
         sfM7/2+3FzV/ejORn2bOOQzbll4pGD5gf1zzMBPJebCDftoybqg21a/sX/v9nzip8Azg
         /pE9kLd9jQZUoFK+M/JF5zIgM8JGWsfhsEjxVLJqHt5tbxiGsFPUAzs6/cQsDZMN/8DZ
         Du6MCeOHbjGXDuYR+yN9RELhnY3/NIevtFi1cZdDLxVgxoy6r+1OydJLRsqvxAXYWywH
         Bymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750787116; x=1751391916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlWvk0Cr7aIK1SoveZrEy2lNuPSsCBNqncsMmg6/eIc=;
        b=Ldh6UMUFIbzErf7fCnGyx205eY53hkxv/XgVb5EaqU8XDmJCofuFAaXP3azEFjZhsK
         Yzq30OXOnTwHTjo7EBKu/7mqcZitbcZ5TgYPqIHdU+YNy3FVes5twY4pl7IUYIZGqBV/
         10wDJzcVzY43aNT7tAh/FzWOADsoWHZEHTOWvZW99A5VznIjX4zE6LkUny/hWV7q6pEy
         SbOxdmfaQbKZJBILkmeRp5gVs/kgNUTGods/KhoKeeFQ92Lr6CXgVAHqFt4STNufZAK5
         7P+6o7viy8gOwahaKoYZ8m6crjMPcFpb27DPfuOytfqUKQVl6yGx9Gm49FyUG+icgVWs
         n9dQ==
X-Gm-Message-State: AOJu0Ywo32EpJi60FYQyDu/4nFfd3eQSWh8CAvA702WBmrB/iO0mH3h0
	oiEO+NuGdD5NvNU6o/9QKGTK9UxJ0HjG20UzpuQkNM6/90bi508gdkzIzqxQ9q813deEFIWPAND
	qHp/8w6jssi99CRbHea22wd793yJJ/2A=
X-Gm-Gg: ASbGnctdwhyp+NbbS5phS0sdTapNb3XaMA6Vb0TN6ZwUxdPueJyCfUnh4LpYDx7UfNL
	E1jwLoICPbmSOtE1to36hdoLUi2i8r4ARTUAjpDeR4knhAV9Tf7BqaIPJRboZJPWr51ZCn9MpKm
	AD73bvjpJzMMyC2Spm5AiCboBIqAY8TURM2j4gCzBIx2jPqlu8j/V1GeUdznE=
X-Google-Smtp-Source: AGHT+IEgsQmTyvLwbZGGOmo8QpWoTHGGj5fRzl+E4pGVyvjYXLx/8HqT1khi2O5+gwcSfBCyQCLBFwMiCpIHnsIc6FY=
X-Received: by 2002:adf:9cc2:0:b0:3a4:f379:65bc with SMTP id
 ffacd0b85a97d-3a6d131dd70mr13599323f8f.40.1750787116241; Tue, 24 Jun 2025
 10:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624031252.2966759-1-memxor@gmail.com> <20250624031252.2966759-5-memxor@gmail.com>
In-Reply-To: <20250624031252.2966759-5-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 10:45:03 -0700
X-Gm-Features: Ac12FXzIQOSMw6i4Ce6zrERFEgbHvPjbcD6L5pyMiL4-cnC07kirLumiPoYFirE
Message-ID: <CAADnVQ+2dfTeryb-2SXHvBbeVEw5O1AJxAUXyNx5dqUjVLK9eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/12] bpf: Ensure RCU lock is held around bpf_prog_ksym_find
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 8:13=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add a warning to ensure RCU lock is held around tree lookup, and then
> fix one of the invocations in bpf_stack_walker. The program has an
> active stack frame and won't disappear.
>
> Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/core.c    | 5 ++++-
>  kernel/bpf/helpers.c | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5c6e9fbb5508..b4203f68cf33 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -782,7 +782,10 @@ bool is_bpf_text_address(unsigned long addr)
>
>  struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
>  {
> -       struct bpf_ksym *ksym =3D bpf_ksym_find(addr);
> +       struct bpf_ksym *ksym;
> +
> +       WARN_ON_ONCE(!rcu_read_lock_held());
> +       ksym =3D bpf_ksym_find(addr);
>
>         return ksym && ksym->prog ?
>                container_of(ksym, struct bpf_prog_aux, ksym)->prog :
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8fef7b3cbd80..61b69eb08c4a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2936,7 +2936,9 @@ static bool bpf_stack_walker(void *cookie, u64 ip, =
u64 sp, u64 bp)
>
>         if (!is_bpf_text_address(ip))
>                 return !ctx->cnt;
> +       rcu_read_lock();
>         prog =3D bpf_prog_ksym_find(ip);
> +       rcu_read_unlock();

Please add a comment here explaining that rcu lock protects
struct latch_tree_root bpf_tree access
and returned prog pointer won't disappear.
Otherwise the rcu lock usage looks highly suspicious.

