Return-Path: <bpf+bounces-51344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADCCA3360C
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEB4167AD6
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6AD204C1D;
	Thu, 13 Feb 2025 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4hLT3nv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F7204696
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417075; cv=none; b=b1QzVNJ4Ny5ogPpHK4fS4aYurI12NolZUDeKKMK2MsoR7YklbeyRCGm6bMt1mBjt1o7+rnrU/FEVlzjRwBTniDClozn1R+LezkR5CL5wQN8/K8248SLhVg1q1A7l2zJRA935YgukMZkYmOq+utsP30Qh22PkosTdOoBdPqWI9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417075; c=relaxed/simple;
	bh=WhOSWdYO4BQXITR5wIoE5ZOxW4UN3AAOtktoAosv83c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ssa7h2P4OT7wm1Xp/5ZVXXqRoORtrTtTR1fUtUBlRhaYpCCLufCMrDJhCTuc1cIgLRSi9j9KrBUWK9ykxwy/4z5caK1OpZRqyVw6OnWIEjmz7dJqhCPiXSA6Kkam5GAEKAfTyCJ9ZKcnS+VpX0c2N7hdswvLVmyHYev2vOM73l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4hLT3nv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dcc6bfbccso181987f8f.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 19:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739417072; x=1740021872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD8arVuXwvB85qMZQTlPY5ia+TuRbg/lcnA5nEmXo54=;
        b=m4hLT3nvKGJksot0gLCpvTdOh2rTTSpZCGT43h0tVdQdDPDCmX4y14HF7v0n5edtFM
         491mv8VNlyIdCRVFTjWt0VZiOwOTVCo/Y141S4O8wlHLDb6uJ3VLJcG2uFhR6QCyXsRI
         TZZbo6sVQJQAg3Vw60h95ew7i2SViPvLGWtxpyCC7C5L+0jFVTsBjNlozg5xnrHMG4xG
         tF8rvXDUCQcMXt+bM9V7KqjAQQDQlNMvrBR4wt5UnO1Ggnv3pP23KD0ET8Hqpz4bZfaP
         bQDTRMfe6HhojK4qiLOnNcXyYl62uyMQXJQToKIwS/S2DvGZydSAw0oMpLLEUUXSM2bJ
         tBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739417072; x=1740021872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fD8arVuXwvB85qMZQTlPY5ia+TuRbg/lcnA5nEmXo54=;
        b=MFYdgWNY6P2YR3ajM5qiQGqE6s+lN2RW1QpCVFXuqcarYBGX+T42ic5Otx1q1rHNA0
         Xi3OqGLOFNWG+AmHTbTMyLCio9+jLQRiINUhDG33chP0pH5MHbFnLCBzmZQGw0635UOL
         zlpEu2DIhY1eCAZ7CIPmydxrhpIbKCLr0YtSsKC17IHbE8W/3h1XO1ySZ1omKbaZj5Rw
         FwlydPPRreMQRZ8v9cE/m+j6gfEP81foU61qUhz3x5Y4v2TfXIYisUAihtQ7I3H0CRw/
         wp1IeJ/snF+qNF3RNGKZt3f83146VHi4mSp/ak8hF2LZQTRHN9BQKYypOhf/zknXJOEF
         rprQ==
X-Gm-Message-State: AOJu0Yxt+0SGJplVVNowy3ete15zlxJVcd9cdX6fJD4EQhC5wGhUT4mA
	2E120nEygZHxd/xPMOgbgwQFeqKi7bRmGtoPULvQLNH3Dw6Ka0XbldadJfxkc6RKLkOiHl6bcgM
	neP5qcmQXHs/YJwnNFVa+sbji/1drBw==
X-Gm-Gg: ASbGncso9LO1zqV7r5fMoE9Q3bZ12gOadoOyxCNOXTNIu1f2iAQkPGOv9CdjF8db/c4
	VS8z7DWCv/OqMF/jPKUfU0d91oxh7Hf85G1YkUkSnyHL+wEaLpvGU5yaX7+TfIaIiNqPORONd6G
	XpIKLCRo3XmCflZmErRi4boLDLO/dH
X-Google-Smtp-Source: AGHT+IE7uHM6BUvbitBrJYaMMDD20QB+5bau3hIDepPfUAQ24RTKYtaE78dgzTjn1vhYP/A7+YFLmUL8Oztb88AxYCs=
X-Received: by 2002:a05:6000:1887:b0:38d:e2ab:1967 with SMTP id
 ffacd0b85a97d-38dea2ed1b6mr4649956f8f.52.1739417072247; Wed, 12 Feb 2025
 19:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213025849.1042428-1-yonghong.song@linux.dev>
In-Reply-To: <20250213025849.1042428-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Feb 2025 19:24:21 -0800
X-Gm-Features: AWEUYZleRUgM4FVHtf3aiYx7We8MWi1nd2Jim-RqBo_REQhRQDOCF-xjtsYlIFo
Message-ID: <CAADnVQJDNdskhEKCu7Uvy-Ch=xmabueWopdf+rD8tBP6d_2gkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow pre-ordering for bpf cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 6:59=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> @@ -6019,7 +6020,10 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> -       /* */
> +       /* This helper list is effectively frozen. If you are trying to \

ohh. pls send it as a separate patch.

