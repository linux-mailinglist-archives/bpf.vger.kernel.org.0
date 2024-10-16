Return-Path: <bpf+bounces-42234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EDE9A1376
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FD2286E11
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11168216A05;
	Wed, 16 Oct 2024 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za1UtJPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A5216A22
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109369; cv=none; b=PaWYQjKXdNFqr0ABg6GTD4DKvBWeqcLGCD+TOUvnBfAb+4tmKTr5mX6pqv/1yqAAXtQCba4spA7SjULVUwDtqRmBIoAs5o2jaItdyjooKHs4J7fDtGjIIcH96Bx6bGbVq6MHhCZmRlEcDK6/9dT9ZKnkqKnJyMTu6ANH8DWGP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109369; c=relaxed/simple;
	bh=R7qSGs+kpMz2xZaUAOUlZXVgPMg6uf5NpSfCwvPHiIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E627Wk9WhLN5rEm4xDEPjNZvVNfqVM9BzG+Rk4STZIWYzkxA8/ZH4H7uavdCEuUMvPfaSOYH3hUoSAaRhxb+WvWAtLCV8uxfia1okr5V7l/c1xnVvS0MDdezVZjkQaow/svUxhLm3dt/IeNNqr9vZH2CytSXAhLzupkUBgMQxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za1UtJPT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso124742b3a.3
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109367; x=1729714167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqjwo2lQ+8JvYA/BPmPMxJ85EJU2j4vCfVcnk6ftGtk=;
        b=Za1UtJPTYci5CmuEzmz11gYgtYxEi62Fj0ONdMm1A1Na4gH0BSOjo5qYoQEl0ubHDG
         vbAubTYlS6eT0nGjht6wlUYL3+weRK+7h6pu0bajEsZra4zTn/de0rDN1gIav8nrSVZp
         aqPTTUSpsePbCyw5x5RBid0jN+Yc4OtQtgxKOnsppJsTfsobRZaEVJlMsJc/yl0qG49U
         Bv1VjZEjogYTkUJHP2ngS1QVvZi8qDY5Q3rZIqKMM8miRA1HOnG5zDB8/YkbXwcgT20H
         NvMZ1Mz04c6AcyLTJ89H9j6J8SSbpSxPWKkh6vr4hUmpUqdiEeaQBJHitLECAcMVtn+v
         UBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109367; x=1729714167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqjwo2lQ+8JvYA/BPmPMxJ85EJU2j4vCfVcnk6ftGtk=;
        b=hF/PkCZ5fPsAEdp8Ywr6HPw/q3aGYigdL0dn4QsPn6EyUk8SzzFjNu2FcNSy76UWM/
         hU+tJycPOSRj9fXXuopfGnBkf2R1/2y1kjbbKjwVWSvXUOSIeZfVJekeiPJHP7vKDVRZ
         HAvVLo+TozfaOTv+Fxu4+M4sjgekBPh57WD0ibuZQ3dWNx/SAGJP6dKP6srMu4P/CB3S
         y2/bZMqfGAMmrwcS2F6l1XwsCit20Tx5s67gFZe0RWqrR0tRG2jc9+qGpVUdjta26hxs
         zHgVMdJbDdgr7egBzNq3G/DIXqJgiHZJ3o+lWnwnmYisJSseYa1FM2uXKu3s6/PGJnGH
         AqYg==
X-Gm-Message-State: AOJu0Yz9X2VNA+oqvt15MNjxgeSb6Y7JazyVHWjZGVv0bmYTD1ZKDslX
	dESKDveui8QdnWyZojIhErlcdj12RXLtlW1vMZgQtaW1OQ98AiqrFgozeZHrBLQnLitOkltDKVG
	BbuaZWN/hVz59Qr5TLEzS0A+HHLW87A==
X-Google-Smtp-Source: AGHT+IGRLdOdqpljQpN12KX9Q1awz+lfB1WsXiSf68uzRr8Q8zqXbwAhRV+Fq1z3AVkCMhtfA58TstqPhpRnw4rpyk0=
X-Received: by 2002:a05:6a00:3cca:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-71e7da25185mr8258281b3a.8.1729109367468; Wed, 16 Oct 2024
 13:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015182707.1746074-1-linux@jordanrome.com>
In-Reply-To: <20241015182707.1746074-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Oct 2024 13:09:15 -0700
Message-ID: <CAEf4BzaAbD7GL9dKdROWDfsKsMCPiNLLGAUNJZ-+mLf56UR2sQ@mail.gmail.com>
Subject: Re: [bpf-next v1 1/2] bpf: Fix iter/task tid filtering
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:33=E2=80=AFAM Jordan Rome <linux@jordanrome.com>=
 wrote:
>
> In userspace, you can add a tid filter by setting
> the "task.tid" field for "bpf_iter_link_info".
> However, `get_pid_task` when called for the
> `BPF_TASK_ITER_TID` type should have been using
> `PIDTYPE_PID` (tid) instead of `PIDTYPE_TGID` (pid).
>
> Fixes: f0d74c4da1f0 ("bpf: Parameterize task iterators.")
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  kernel/bpf/task_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

This change is an important fix, so it has to target bpf tree, please
use [PATCH bpf] subject prefix

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 02aa9db8d796..5af9e130e500 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -99,7 +99,7 @@ static struct task_struct *task_seq_get_next(struct bpf=
_iter_seq_task_common *co
>                 rcu_read_lock();
>                 pid =3D find_pid_ns(common->pid, common->ns);
>                 if (pid) {
> -                       task =3D get_pid_task(pid, PIDTYPE_TGID);
> +                       task =3D get_pid_task(pid, PIDTYPE_PID);
>                         *tid =3D common->pid;
>                 }
>                 rcu_read_unlock();
> --
> 2.43.5
>

