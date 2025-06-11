Return-Path: <bpf+bounces-60411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E6AD62F8
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 00:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E642188E969
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B379218E9F;
	Wed, 11 Jun 2025 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpJb4k89"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8E219FC
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681938; cv=none; b=Uv3Iysy6J++eS1HQ6TL6E4ZQxQ+Ho1Eib9pMsc45h0zn3k5X4+goQSpBIjGrmYIhshEuLBD05upUX153cqudtjNsz1Fqj6HXEXzSIBvuIzPZjcsLoJkhSj+hR9QcNVtDWO8Kdv/yxnZwuxk9Yf3YvGTIsR0YO974P9+q+9HnNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681938; c=relaxed/simple;
	bh=t5h4yemyjxppvtGtfuJtGcCS5arjy87Ttpb0t8j/CCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxhxLhdWrBd5358zV8zNykK72C9RLDnR4XZBlGX2hHFLginPovqbZ2DDnGo+YL9NQLO/g2tGdlYZGDWO5WDs1gTWXbD7POBtCdsoPlXd/Rjls7KS/WV238Q1tkizcKyDio1O7AvDeqSfge4aSKjs132wohbyksDD2yOr9Np7Knk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpJb4k89; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d3f72391so3282465e9.3
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749681934; x=1750286734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn5pGZSR96Uxe7tRI04Tu5u5aVp9yNC2AxLD6BNE7YY=;
        b=IpJb4k89/pHeVlv59dpux0lgaQUd9KiwRtYYUILvw+iDQSDsEBHXIzvhKn2hfWWOIU
         QKSfBeuHoF1iEj/Hh8VIPsPWm3TdnM2SMdX6ArT5PnlvrFa+FkOtWvv639SRhfMocWi3
         YdEg8hIpdP4Ynd1YmSdUntHwd3YoIWhJvYWsVs83RyRB+XhqBai2YSsGK+FeM5W5hgF9
         Fq31vIRen+F5ePkGRDOWQ3A0p6YsrnQYhRkW4QRS9plECg79BAiw1k/IsuUXYXQqrW2Q
         /gL8yYRJCUpZQiS9++kERUvNyaaP+6YddBf32nM4qwYR5VqNV3WqmPmwQWRzLOvxi8k7
         c1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681934; x=1750286734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn5pGZSR96Uxe7tRI04Tu5u5aVp9yNC2AxLD6BNE7YY=;
        b=AWEhgHkLM459djPNz9Jc4dOXEQK0/LtUMkl1PIrpeb04Z3jO/KeuPtWxDQNo/8lalH
         gbN4fePW6KI4LDUClJYAdxcD9Zo467WP6oIitcaMwbZdU6iMEWXEvpvc0hohf59ETY2g
         0igjwjXcqhzRFCWi4cnEPHUD2E3LqQV9VgXHlq9MT2AhxlMxcWpJga9Hibc0P+HDf/Pv
         iOT/puctTcpCLxPIyBNSaj8pZ6raNhDDvHTicnRzZYSLHeV7gDO9yeqV6qgUNTXIR8/O
         CGoKuGazbmk00+eVw8XzOzaU44W0quu0pxhKhPZWRgKcUpmS99E6cUQqr9WQbmgYMeBc
         s0ag==
X-Gm-Message-State: AOJu0YwBjvNK506IzUXvZRwZpUoed/u9kuzeIA6xFJtXsj9LoYwm7sYC
	t07F5caMfWZQ/xDq+6q2Ty6MeWoKumIcN9g7iR2TcPyxT5tGgxeCm198jKQpcjiAUvKgwkmrAfb
	Rp9d9Y3oSeeUoVNY6QVbexuuVHA3N0hQ=
X-Gm-Gg: ASbGncuq1XYw+e+MH45QNOUds1OQ8OfsAMNS8dq1XwW7sAFtOpSsX1BcUm6Rh0NhYCB
	3ENLcU6LX6S4vSIjEP9y7De1h7HBBd5boDIE4l0lO8j1bUhKjQuQmk47ygQfXomrULrgXZAumQu
	lTeIbEJ+AkTj1uSOc8rTBTU3LUVoKaVpFr29oDYcWHbD5SeXcr42jIzYK+THQZbw5CJzVMZxIx5
	xOZOPcbpzk=
X-Google-Smtp-Source: AGHT+IHTNiKyt0Im18/FPVbm1O5phXkbd+ind4Ir0Br6c/Myz6QdX228xWtZvujRkQumqlqrssuzSVfeuIsQzR59ll8=
X-Received: by 2002:a05:600c:1c9e:b0:450:d4a6:799d with SMTP id
 5b1f17b1804b1-4532b8c5807mr14254665e9.7.1749681933852; Wed, 11 Jun 2025
 15:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611200836.4135542-1-eddyz87@gmail.com>
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 15:45:22 -0700
X-Gm-Features: AX0GCFvfLbJfdaR_X3h-kSfiyu1GAVU12WiCU68WceZgwq1PKePd7riy7Y9W4xY
Message-ID: <CAADnVQ+J+ZUXb6Kgry520V2Dvo85f7MeBnKH5OMm6fqoAJFqnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] Revert "bpf: use common instruction
 history across all states"
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 1:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> This reverts commit 96a30e469ca1d2b8cc7811b40911f8614b558241.
> Next patches in the series modify propagate_precision() to allow
> arbitrary starting state. Precision propagation requires access to
> jump history, and arbitrary states represent history not belonging to
> `env->cur_state`.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  19 +++----
>  kernel/bpf/verifier.c        | 107 ++++++++++++++++++-----------------
>  2 files changed, 63 insertions(+), 63 deletions(-)

This wasn't a clean revert. It broke the build with:

../kernel/bpf/verifier.c: In function =E2=80=98check_cond_jmp_op=E2=80=99:
../kernel/bpf/verifier.c:16503:23: error: implicit declaration of
function =E2=80=98push_insn_history=E2=80=99; did you mean =E2=80=98push_jm=
p_history=E2=80=99?
[-Wimplicit-function-declaration]
16503 |                 err =3D push_insn_history(env, this_branch,
insn_flags, 0);
      |                       ^~~~~~~~~~~~~~~~~
      |                       push_jmp_history


Though it's fixed later in patch 8 as:
-               err =3D push_insn_history(env, this_branch, insn_flags, 0);
+               err =3D push_jmp_history(env, this_branch, insn_flags, 0);

It would have been a bisect issue if not caught by CI:
https://netdev.bots.linux.dev/static/nipa/971030/14115002/build_clang/summa=
ry

I fixed up patch 1 and 8 while applying.
Pls pay attention to such things in the future.

