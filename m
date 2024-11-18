Return-Path: <bpf+bounces-45075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78279D0B74
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 10:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316A2281A16
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76B0188904;
	Mon, 18 Nov 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="RLUpxDC6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586C18871A
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921261; cv=none; b=A+Q6iu0P7nuBHYdMm0GZaW140ImbtfB3PI7lgThU6jBFggynpwxI+uu2ivyDkjXjQkR6nLvgohgnSgwdjhMdFpdn8iLlhoOx2vldzoLtHRd8hL2AKnwV6D7DiBxfqBIIEhtHQUwcEv9Q347aOKXUX/BWydX1NL9fkrO32gWy2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921261; c=relaxed/simple;
	bh=6UYL4Of/RWENh/wQRVOwvR1L/OHKG+2n8kTTS5Rbzts=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I0cbausI2fN2gD4BNs7Eef5OOnZyG0AnuVKWEYC2Ir5DM/jLF7wNCUnnkbWjzBTqWqjwclh+h2RsX7sEfmtr+1ZmPvMNhDvolf0GFXpIBA8rl2Q3yrOkPS6DbvDh0FrLjXM0acgVcT1vNGR3AL322OB3GYLgzWlosDtK4+IR2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=RLUpxDC6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ea4d429e43so842465a91.3
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 01:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1731921258; x=1732526058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6UYL4Of/RWENh/wQRVOwvR1L/OHKG+2n8kTTS5Rbzts=;
        b=RLUpxDC6V8bGEQ9w+v4HGkbzCAQz7DOt2k0O0/HQAp2bK6becR5hxAeKie8JmM/1Ve
         9+QPRi6kkmns1vfJF2jz75hmZFB8BxTILeRNJmF3jOakjxsMPGacfF2DrJOWtgagbd9G
         qJzrfODXXuHzfE6TB7+TiKkT2PiFNPwMIF9BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731921258; x=1732526058;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UYL4Of/RWENh/wQRVOwvR1L/OHKG+2n8kTTS5Rbzts=;
        b=WPkwlnkulo40BjSYay0qRPlNiaoZ713ohQ+IBIeZqzh2zqCFEZf+9ap/xt82DmRlaS
         3D1z23rIdtR8jWZnbd7BbS3MzWl/P4IGm1h4RECuyRlPOfx3XhcTPvN+fyEqhx+CD9w9
         M4jk2WTOVcZNVFcmy2aWlykdol0erMOsAgO1F2JqSUBJgSFQIMgky48nNh3ivWxwOfWk
         rhaDfcGq8JofJ7PWHjBEbEPpCnj84mmNFQ5z1sEGS3OBgEPPtUq4KQzoOAKwom+jMGPd
         ASgzcGXatYcIkb1XX3YfvuaXgCCoLUeJ5zZaxw1+AmT+MpcI73cFmhnKsQlx4+LTj4Um
         LlNA==
X-Gm-Message-State: AOJu0YyAUbvuLgwDbGsEYtmKlfXAyJMVCZBABMlLVqMXCVw91eehtkd1
	q1uYogjogyoBuB+hPn2UOgYe5txBbjxcc46BIlNCwOIy65hH5R5Kqd5VG0xE/Ly1Yx8hLQlbTrg
	gGq15a5A5ayZftCi5OPlUB17WOQeIs2gGjEt8pw==
X-Google-Smtp-Source: AGHT+IFUqVrUkKuWkAbHig/exPeWSrnZhdnpp8GBx4IRm2yw5kOLc4WljxsR9K9QsLA/8t5mVVB1ojGAoKYP8s9DBXU=
X-Received: by 2002:a17:90b:3ec9:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2ea7fd8a2c1mr2472879a91.18.1731921258060; Mon, 18 Nov 2024
 01:14:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Usama Saqib <usama.saqib@datadoghq.com>
Date: Mon, 18 Nov 2024 10:14:07 +0100
Message-ID: <CAOzX8ixn1d4ja+LOJq_S_WDq=ZqtUTcV0RZzKpyJ2Yd0pBMx2g@mail.gmail.com>
Subject: BPF and lazy preemption.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I hope everyone is doing well. It seems that work has started to
introduce a new preemption model in the linux kernel PREEMPT_LAZY [1].
According to the mailing list, the maintainers intend for this to
replace PREEMPT_NONE and PREEMPT_VOLUTARY as the default preemption
model.

From the changeset, it looks like PREEMPT_LAZY allows
irqentry_exit_cond_resched() to get called on IRQ exit. This change,
similar to PREEMPT_FULL, can get two bpf programs attached to a kprobe
or tracepoint running in user context, to nest. This currently causes
the nesting program to miss. I have been able to get these misses to
happen on top of this new patch.

This behavior is currently not possible with the default preemption
model used in most distributions, PREEMPT_VOLUNTARY. For many products
using BPF for tracing/security, this would constitute a regression in
terms of reliability.

My question is whether there is any ongoing work to fix this behavior
of kprobes and tracepoints, so they do not miss on nesting. I have
previously been told that there is ongoing work related to
bpf-specific spinlocks to resolve this problem [2]. Will that be
available by the time this is merged into the mainline, and the
current defaults deprecated?

Thanks,
Usama Saqib.

1. https://lwn.net/ml/all/20241007074609.447006177@infradead.org/
2. https://lore.kernel.org/bpf/CAOzX8ixsxPbw1ke=DsDd_b38k1TE+JRG3LvJfh4wD60mhHvAqA@mail.gmail.com/T/#m206e33e5a0a0d9d3d498480a53aa9c87c81d91ff

