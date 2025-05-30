Return-Path: <bpf+bounces-59398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AFBAC9824
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 01:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E72C1BA3EDC
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39728C877;
	Fri, 30 May 2025 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBJlGDdA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E33186A
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748647951; cv=none; b=lIZO8yRmSId850RCXdR06gAItPtSADvcNwvGGsj3ofC5hylV7O/rdTe+xVDfXGbMNeWo3/DRQ9YZMI2+xpLgx5fmThNL9Xvd/LqM3U4P+IEOn62wIgx98gV9S63R6ugPH5r18AlAZG0tIkpBrnpF45siRlDZRIiHV3To1xOwIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748647951; c=relaxed/simple;
	bh=kggCqTMPG5sotUIYA3iRlmrG1UM6sH0EEjF6Bj7Gd/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae5oGh8eOkrLA35Xa3sEXNav4bRFpzOw1xhUzYlJ9LsLUridDqwDeYD077RhX3MLOpbB/nbuwzgYXozLu5YwDm8l4keqZdnDZzscrp/LaDkIPNmndyou1TeHTdJ/DfZVDMwTK6E3Da9i9qYvP8Jxym/DRCihxWBALKGYwCZgSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBJlGDdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD871C2BC9E
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748647950;
	bh=kggCqTMPG5sotUIYA3iRlmrG1UM6sH0EEjF6Bj7Gd/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MBJlGDdAy/YjAIoESj63/k2Kd+PzzEmI3LV/Tu+LxRHW+sOsSJZxlosyV/cjmOrCf
	 MyrKHMVf+ZEVApBUQaFCuh0F97bYgEgLH6PrkIdhA6upA/TMLqW8OvdXZEDOf0R+ld
	 P6ybXSaEnFLariJo6jqHFdxRgbBLmU/7pdZUYiUjG+BAqS9anvN1Kgmm7wQvlVYhKy
	 iTl+Pv+L/XZCVmwdtFLch/puQk5Ecbv8uPRzopnkmaQ7MZYrDo2Vfyfl22H2BQrh9j
	 qE3S5UggUGzGlY1Gs7aNY+rDik1UkriA2OAfsgEGUJpcqO+l61uYOf/EKwzxN0zVAe
	 9g6sRVE+kZAvA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso5098449a12.1
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 16:32:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIzcdMvDSiw5jopmtzKVIn3XBES3qOK4ZbtiQhoEQ/UPkA1Y9BYmJ+FTU/yWS2CPw7coY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxL2FyWoM3YRHkQogzRxuTC1Vptw8FN1X90Hjbnyxj+FwlIAld
	Z30B1FkKdi3rQyxGBM9vXf2qn8V2ujOTt8BJzk8ghQTMZZrdJG8bYZgFC91iKoOBg3EWnXRcK58
	HB3llrxUg7J+rVgrL0pFDuTBx48g6zw6fo0G+lc2O
X-Google-Smtp-Source: AGHT+IGnT7gcHCA6T9nJz/Po1RVmey5EX60YKSUOFtgmIA3wDq2w5CiZNs8pkH3x66RYx+isVTtJ5wHdkcQjB7rhyEM=
X-Received: by 2002:a05:6402:84e:b0:601:94ab:790c with SMTP id
 4fb4d7f45d1cf-6056e14ca18mr4710890a12.18.1748647948800; Fri, 30 May 2025
 16:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
 <87iklhn6ed.fsf@microsoft.com> <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
 <87ecw5n3tz.fsf@microsoft.com> <CACYkzJ4ondubPHDF8HL-sseVQo7AtJ2uo=twqhqLWaE3zJ=jEA@mail.gmail.com>
 <878qmdn39e.fsf@microsoft.com> <CACYkzJ6ChW6GeG8CJiUR6w-Nu3U2OYednXgCYJmp6N5FysLc2w@mail.gmail.com>
 <875xhhn0jo.fsf@microsoft.com>
In-Reply-To: <875xhhn0jo.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 31 May 2025 01:32:18 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5gXf4MOdb4scid0TaQwpwewH5Zzn2W18XB1tFBoR2CQQ@mail.gmail.com>
X-Gm-Features: AX0GCFv_7BJJSl838TozCcwnoaszDpfbe-yzu3mWadgSeXOyob3Yk8byF4z0Rt0
Message-ID: <CACYkzJ5gXf4MOdb4scid0TaQwpwewH5Zzn2W18XB1tFBoR2CQQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] BPF signature verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org, zeffron@riotgames.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, code@tyhicks.com, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com, 
	James.Bottomley@hansenpartnership.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Anton Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"

> And I'm saying that they are, based on wanting visibility in the LSM
> layer, passing that along to the end user, and wanting to be able to
> show correctness, along with mitigating an entire vector of supply chain
> attacks targeting gen.c.

What supply chain attack?I asked this earlier, you never replied, what
does a supply chain attack here really look like?


- KP

>
> So in summary, your objection to this is that you feel it's simply "not
> needed", and those above risks/design problems aren't actually an issue?
>
> > Let's have this discussion in the patch series, much easier to discuss
> > with the code.
>
> I think we've all been waiting for that. Yes, lets.

