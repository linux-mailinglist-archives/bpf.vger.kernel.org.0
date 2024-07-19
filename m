Return-Path: <bpf+bounces-35032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEA93718C
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5AE1F21730
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143181388;
	Fri, 19 Jul 2024 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB1Yij+U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70D10E6
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721349421; cv=none; b=MkfLLwaWNlp3NH74+d3tGIgYsj1YuXxglL2ph8n6nWrXsE9qXH8zLl458xplsVAuZ2Lk/CBPkmYjLHX/N8ErBkPgJOeazRtZ0T0fW/d+iDZIhZ6OAXa6n+TPN/Eb7sl7PZRQB4uUlymM0bS2eI988XePCXXL6LWXbQs7DhBOszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721349421; c=relaxed/simple;
	bh=FpE40iSiNTZcEOBm1kT4pK6NWcJAChbZxbRA2AGVCUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hkug/L7T78ewsqTp8SwTIu65HnOxWXD3k8OXSUryapEUJt9Oy4pDEPOiBao089pW/eZSCT/FUhPvseHY6oxQrlGg8hWQDiDM6xYotoblyc7XzuGAhT+jE94Z/O9s2jSbADds2/psHM7MkvYKVxktC6sur7QF/LnsVBurAt7fuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB1Yij+U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so8372235e9.2
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 17:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721349418; x=1721954218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9sUPAQL/bfTqmbHPYm0k2PNx50yKDSCxbbJ9mvuiEY=;
        b=AB1Yij+Uc4INO3NmvtWkV/aPnLfJ+E1oGfDMd0dUEzUt2jeCJqw/RHly+4wygpJjPP
         rbac49v0O8DUehyrY/KVasXxMEiCdiUcuW32TVuH4xA5m35BgDmNoBvDth7evkBB0b++
         MIzvyZshVes6QPH1HTw/6Tcc0KThGhexxBoRYuzGxrMTe7jEqHpGR465f2WVIpxWhtwd
         oD2uU4kpjlwKGxr8IatTJMerx51t7Oq/yenwD+qeJbYcseQEeT5DJbgW9PkhYnDJLrp7
         7Nk/bretU2ej9V903rvziXj2JRXkSpIvxBTZMzjFkPFawOcsPDSu3zpz2vJQ6/A3DLFq
         DODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721349418; x=1721954218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9sUPAQL/bfTqmbHPYm0k2PNx50yKDSCxbbJ9mvuiEY=;
        b=j9TNMIA2DXIfgC3SSu/LE7fnQ+6VyLfd3EsBDKBxmSAi6m/ZzebHkpN04OXsIHrSDC
         Kp8J1ihq4u+TXbJv5EDKk7alG3hfRglbYddl1uTtwQVoFLbqNHmm7OelrvVMzZDFF6hF
         w1tPUyDtx+8EFaWzOYmXa8OrrsKcQjIHRzrxN1HoUmL+Z0Ljp+5URBwLrvIsFl0cl4/M
         HUOw4/uSQKU2Qc/JIlo3XH324iAqFfGcLR18y/51H0B6rY1nm/A99GWgAjcvjyTwmz1a
         KA6o/T5Ho8JL/z5vjsHaWmIYvBYUyv2eeezcMop08kuA4IUUjVTnJ8jyhv25c3K5BpMr
         ELeQ==
X-Gm-Message-State: AOJu0YxHtcvHz1lOCZwdrchOXiUEXq4b8irzJptcjyBEbvDdY67pm6pr
	080GBgf+/0tkM0a1opUlgHJUiaLeonMGA+ZwvMem4TBdEc4UlTlr4ewU203FlENZI1rdiFElswg
	gmB48ubaXFYUAtdjS7GYSvWG2WVQ=
X-Google-Smtp-Source: AGHT+IGQppAr7VDmEzn4AhLbb53MLBzl4uUfqT5rATnvQGnb+GusNKfYxCed0eIcx5oSe5gNvh+Gta4JTRIzOfcrbaQ=
X-Received: by 2002:a5d:4845:0:b0:368:3f5b:2ae7 with SMTP id
 ffacd0b85a97d-3683f5b3871mr3752465f8f.24.1721349418148; Thu, 18 Jul 2024
 17:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <20240718205203.3652080-1-yonghong.song@linux.dev> <1297da19-18a7-4727-8dab-e45ef0651e14@linux.dev>
In-Reply-To: <1297da19-18a7-4727-8dab-e45ef0651e14@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Jul 2024 17:36:46 -0700
Message-ID: <CAADnVQJ_-FR45o89SWJWZPD4+A+AEArJf1Pjw41=9f0+Ujzg+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] [no_merge] selftests/bpf: Benchmark
 runtime performance with private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 2:44=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> >    $ perf record -- ./bench -w3 -d10 -a --nr-batch-iters=3D4096 private=
-stack
> >      18.94%  bench                                              [k]
> >      16.88%  bench    bpf_prog_bcf7977d3b93787c_func1           [k] bpf=
_prog_bcf7977d3b93787c_func1
> >      15.77%  bench    bpf_trampoline_6442522961                 [k]

...

> > NOTE: I tried 6.4 perf and 6.10 perf, both of which have issues. I will=
 investigate this further.
>
> I tried with perf built with latest bpf-next and with no-private-stack, t=
he issue still
> exists. Will debug more.

Try this fix:
https://lore.kernel.org/all/20240714065533.1112616-1-houtao@huaweicloud.com=
/

btw you were cc-ed on it. your @ fb goes to spam ? ;)

