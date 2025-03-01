Return-Path: <bpf+bounces-52955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7827EA4A7E0
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 03:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413263B771D
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C801531E3;
	Sat,  1 Mar 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoFU+/wS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753222066
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795052; cv=none; b=V7sapn0tvSgaNirSKrellzPwU44bChfa8GIpv8qr3utg9cQT6vASzU7M2SuzGzM2lTX6jiXSY+73p0ByfFsp2R1zJ7SY2j46nnlGiqoWA1qq8+rY628B6NwWm0XvOuxoXzReU8fpZiLgKUxXrWnIdnynp/tGsfETpZXVML6wddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795052; c=relaxed/simple;
	bh=19UB8E9NSuEOBdybO5++U0my+o3P+kPjhK8x/rHYUHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRKL6oE30djQsP6dqrjo4MtxQNweOKBWzj57dLM+IWDiUs25ZtWePqqaMzL3vCDjlpV9rPRS9c5F9U6xtNTI/HG6i5WgVkdnY28BDNfl3dOP9Io+RXp5klwMxwlD8UOHr/viluXprAJYSVQ7ZmQRU0z5X4S3VoTqdKYcuhtKvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoFU+/wS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-438a39e659cso18902575e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 18:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740795049; x=1741399849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19UB8E9NSuEOBdybO5++U0my+o3P+kPjhK8x/rHYUHE=;
        b=OoFU+/wS/jtLw1QMO/1sp9NG/VWBhmQC/Oiw2bdtQykD5hzhsYfPRNEDVrrdDAP8IG
         OyAoQDw1odIDcbrjZbNr/BvKyh7fL683LWevHfxO3ACWzYKk1EfKutoG7Uvy/Y7XME0N
         hNQ+jh0KklgF7ZUDf/MeeY25pCZ1JMag0RzM6JrHnep7n9bAaEAvjJIJJNuUi4pD/lZS
         J7GE8vRsUX3XNkDTJ6sHiYKcBUak2tUZILC0mGoly8Xj0cZmA2JmLgiqOjycfspnfKzp
         riubRM6/PsyIT31xju+Zp3qMzhO7ExJSW4Owiqs7WQJlb9joO2o8ZR2PqsiagIqN1iMG
         vegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795049; x=1741399849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19UB8E9NSuEOBdybO5++U0my+o3P+kPjhK8x/rHYUHE=;
        b=xIAaH+404pqAgF+LPIVsSfMrJY8lAkyIT1IMIaipV2rEtN3mgmvtDpnz/oPf6SC595
         rBJjOU+/WQ8Vld7uPnWGv7Mq7ZI8wsKD5hf4Fbjy9nVL0k0E5VR/qFwi3RIOvoa51Tui
         gBPEeUzCKxpXZl1mJyGQKh0Jsl5zvvH9NrBvdhJYGbCOkRte8DXhDCybShkqX+dqe4J6
         XfBni58xILsW3Y9ppsLiMdP/I0YfPxm0kQZPrVcdhfIh7XRzBwYSe8n/AOFZNK76P2Kf
         5xo2Kbu6v8jHl64npGGU2LzTPdMvzP14CLWSXZ2sH3zPDBNm0UZ0DmSbqCy9ihFZKX92
         30aw==
X-Gm-Message-State: AOJu0YxST6cUm6KU78F5QZMuz3zEQMvUVAiXFsDIRAw9s0JXZBv87Gus
	1yalY63rhZMI3jkGR28Z95GbTwlU7kAAUd9M7OW/zTJ6I4HQtslx2AtF7DK9WFhyY6EBr+PKcgK
	ufm/LopUqSK064eBwusmiluSa/6U=
X-Gm-Gg: ASbGncvZktBdsI3dl+ipIvfVF/q0AawF6ntuVTqosN+J4uDeO4jqaI8XM+74o5JOfiT
	A+ZA3NBeq6WQ6CXbYBpn6GMoDuaXeQoX+vQGahunuUxBVw4fQDcggBwW1VhYrMddJD8YcE+gdN7
	k4b907CfE1IBsxZY8cjtmKFx1TcWeA9AXjvpNK43NmD6t0b05tL0QtVTKHCg==
X-Google-Smtp-Source: AGHT+IFfbBg5ZnKc6eaFILZkul8c+aaZMbW9BgLmM5WO6gEjne+5i2c5YvMK9++mLNqWxwgXHOzyuA+NioMHNfN3g3M=
X-Received: by 2002:a05:600c:1c25:b0:439:a25a:1686 with SMTP id
 5b1f17b1804b1-43ba6773996mr39178595e9.25.1740795049178; Fri, 28 Feb 2025
 18:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228060032.1425870-1-eddyz87@gmail.com>
In-Reply-To: <20250228060032.1425870-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Feb 2025 18:10:38 -0800
X-Gm-Features: AQ5f1Jo-CLwS4fMQfPbAe4vvQhYhm3vpYd1pvDgT7aB1N4Qhjx_F4krFQ2Dy5Ok
Message-ID: <CAADnVQ+BEW_yTsm-pMYcCsHhpZ4=FhAMmGvY7AhwyiUOZ+X1Gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf: simple DFA-based live registers analysis
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> This patch set introduces a simple live register DFA analysis.
> The analysis is performed as a separate step before the main
> verification pass, and results are stored in `env->insn_aux_data` for
> each instruction.
>
> This change improves handling of iterator/callback-based loops, as
> regular register liveness marks are not finalized while loops are
> being processed. See veristat results for selftests and sched_ext in
> patch #2.
>
> The patch set was tested in branch [1] by disabling the current
> register parentage chain liveness computation, using DFA-based
> liveness for registers while assuming all stack slots as live.
> No notable regressions were found in test_progs-based tests.

I think the end goal is to get rid of mark_reg_read() and
switch to proper live reg analysis.
So please include the numbers to see how much work left.

Also note that mark_reg_read() tracks 32 vs 64 reads separately.
iirc we did it to support fine grain mark_insn_zext
to help architectures where zext has to be inserted by JIT.
I'm not sure whether new liveness has to do it as well.

