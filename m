Return-Path: <bpf+bounces-11469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99427BA894
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 20:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 80CB9281E86
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F43CD10;
	Thu,  5 Oct 2023 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAlXVb4h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470FD3B7A7
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 18:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A71C433CB
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696528923;
	bh=+l7mOjSiwSal81QDJtVM80LFre2XvA6AqnrfHrlRfhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jAlXVb4heWAqr3m2OTxdoR3hF3951I0a/RYPs5el4uYuinN0ejTQJf1+Wf70jlz1s
	 7ba+AGfLaYCXtqCd9JMwxQZjVgpcxaTJp+MctzU8vpSG9aNEW+Yg3e0mlnWMIYPPaU
	 sQ/I/L2de7uYwB3+dzjEuFpbLnj8jl4lme9u1QUuhhiaE3aopoDRb6caJ6WJbMgJYr
	 TYgL5tQezkm9Bj32H9XRtMBK846TSC3Qvwv0lqasF3cIvPxhsdE9sq3k8aVnnzTaH6
	 GLOlu2dqss1zkc5fXqUjSgVnnCzj6R+OvIem4k3qA5QKEqrHM4ClVWMz1s2QCTKXs+
	 l0TWN26UeQcCw==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3226cc3e324so1279148f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 11:02:03 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyq2sG0JllbQyZ4pfvIFs8+eOioilJLOv0elWM/kw++FM2ssCtL
	ChchX83dVjkQcXHtXENX17jZbjTRaNf0oDDXTcU=
X-Google-Smtp-Source: AGHT+IG5nn8NqPZt6pK9kqvGpZILee+G2qJetjx5dMlzxONMCj1gSyQ1k61IxUqrM69NRZXF47u78/pkXZr1GxhNRvc=
X-Received: by 2002:a5d:4149:0:b0:31f:eb8d:481f with SMTP id
 c9-20020a5d4149000000b0031feb8d481fmr5552851wrq.29.1696528922066; Thu, 05 Oct
 2023 11:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005084123.1338-1-laoar.shao@gmail.com>
In-Reply-To: <20231005084123.1338-1-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 5 Oct 2023 11:01:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW70-kKGT1RQRGYG0b6zixKTzaU_-SUfvhhrwO3y_WZcBw@mail.gmail.com>
Message-ID: <CAPhsuW70-kKGT1RQRGYG0b6zixKTzaU_-SUfvhhrwO3y_WZcBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, Luis Gerhorst <gerhorst@cs.fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 5, 2023 at 1:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Currently, there exists a system-wide setting related to CPU security
> mitigations, denoted as 'mitigations=3D'. When set to 'mitigations=3Doff'=
, it
> deactivates all optional CPU mitigations. Therefore, if we implement a
> system-wide 'mitigations=3Doff' setting, it should inherently bypass Spec=
tre
> v1 and Spectre v4 in the BPF subsystem.
>
> Please note that there is also a 'nospectre_v1' setting on x86 and ppc
> architectures, though it is not currently exported. For the time being,
> let's disregard it.
>
> This idea emerged during our discussion about potential Spectre v1 attack=
s
> with Luis[1].
>
> [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@iog=
earbox.net/
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Luis Gerhorst <gerhorst@cs.fau.de>

Acked-by: Song Liu <song@kernel.org>

