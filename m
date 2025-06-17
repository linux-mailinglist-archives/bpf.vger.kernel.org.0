Return-Path: <bpf+bounces-60807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB94ADC6D5
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 11:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CB57A3B67
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D7293C71;
	Tue, 17 Jun 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="zH+lJMUa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC11F4606
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153390; cv=none; b=M/aFT+M0xJv9ziwD6FI5TW7iou2q47Q2RHNBfjAPIR7+WfPlD3oXeTYizyj9jXwpeMDBDYWYQlR7UFdshtUDo8nf26doCgIDrF/Y11KdQOLcCD10CqLzunJchL1NgoDfcxvhq4W1QCWk3lqHAt2e/WjKopN2eCO9LArfUozSpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153390; c=relaxed/simple;
	bh=0wxpnxxjsJ5M1lClgfAqSI9H3ajmJ+XQrovGZjKTfT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEtdhfqQ8bkIOqQqEiD5RsUqx8HKRsC3+nxVyXM88vaQkqUWPT1t4btsFRHgVQTQZ3u7+QQTGfYWsniOfw0OBvnd/5FJWf7twuhhSzQB0snZmTE9ijVaOkO95BOOkaFxV3csclZpG1HhcpXyJ8XZ4YJAZpXCprr1EiWGl4Gl8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=zH+lJMUa; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311a6236effso4512855a91.2
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1750153389; x=1750758189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wxpnxxjsJ5M1lClgfAqSI9H3ajmJ+XQrovGZjKTfT8=;
        b=zH+lJMUaIVgv828u65AMFat/POahJOyDW7BeQusLrAUoBobQGsVlkbq2/3w1QPCvUg
         +0rxllD3y7W9JgRasB9RhTO4FrBbB/2dy9AhwiMftP4BCSi5VYgij3hOMUD7IoA7PtRy
         2o9lBiY3j0gq8o0STFWM9ULtU9Z7FZ9/Rmjm89H/XLn2PXECVj8XChLymG/7FsKcwcZj
         AY/U8FTNxlsDVP6KKehzf1vY1Vgf/Vh74GP+2iCb+sIaaqjLG/UoI5DF7sTJRoB5Wf96
         9X+SbhoKyvh251h2iNdyp3mCtKlNb9x+uN1leK1GxCF/qPIX4plrSnjjswZMt7q3QWZc
         8oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153389; x=1750758189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wxpnxxjsJ5M1lClgfAqSI9H3ajmJ+XQrovGZjKTfT8=;
        b=midrTGcDZs6hoFexcvu/V7JEkzUMEQZsCo92g056OYFkyOVAuGzfEpoG1git0y3Nme
         arPMbhcST/rg40bxqk/jIHrrww1uGde2IHQVVje46oxYe7MJjC3ESQ7uUl0pjky7Hsxp
         N0g9syki7tcAzP6OQvimU2+n+9h3DYRwNPgnAOVlUZeAFoMPPC5sZ7DVIMpV4M1l4FEx
         4gFf2qyg5Nwu5MEkdcCv3RSXx2cCxWK3zCZBtJJWoEM7JBGPIFFh1kbqi9fVliJCDGN/
         iMHkPaXVmF8bQRRXtouc6pRyqrh+MntfSRsLuhetQPdiOA3A0M5B/5MJmi3RpAPEeD1g
         4T5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9ywKFkd8vVen6BRTQPHjt+b3N/J7rOjD4yV/k0LAg9T8bk8clE7iHM9J7NFDhboXouIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQx0/F9Er+7/Og43pruW0Ar2+4iMKoJ5XZ9e+JYFxNfdYbMcd
	PJEYSLqUBsjmulTrjvYVP2HqRkDioOHUq3orWbJHPkeAax9qF0sK7eKl/nFSKW/4Yg+GWWUmvT/
	8AapTjSGu7uFRCpIUiB572u0d+W4HB8njkI/8F1Uvzg==
X-Gm-Gg: ASbGncvoioLVOVReQJkxQj7DP2Cn3ofGt7x0bR5G/Sjw9jHvPHx8k+lyRHThfgkJFBD
	zMB9eFqdWyASgCfykFsrIGvV/86mrlrgrehLknmqukSR0zVQJFO04PilRiddl7Eac7MXV9J+FkM
	A/zJgvZ6xXH36WvJJLtoGds/him7IL00MLyF3+Hm4ryUFZQ1D7SmLwaQqwX0WvAMYVTAF1xHU=
X-Google-Smtp-Source: AGHT+IEIZvsZUfqmRVeCIjkrVoCuKUL8ahsqAAeD9x3l4XudbvcbKCMdofS/Auh12FqlEzOp64XiTb5YFEu870NtyJU=
X-Received: by 2002:a17:90b:4ed0:b0:313:17ec:80ec with SMTP id
 98e67ed59e1d1-313f1dee7d8mr15413081a91.26.1750153388815; Tue, 17 Jun 2025
 02:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
In-Reply-To: <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Tue, 17 Jun 2025 10:42:57 +0100
X-Gm-Features: AX0GCFtPDyBqn7BE07OuWxDr-_mR00jG_TcPmACHAVHTct3u7WfUCCgw3Ksrrgs
Message-ID: <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 4:51=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jun 16, 2025 at 2:55=E2=80=AFAM Matt Fleming <matt@readmodwrite.c=
om> wrote:
> >
> > From: Matt Fleming <mfleming@cloudflare.com>
> >
> > Calls to kfree() in trie_free() can be expensive for KASAN-enabled
> > kernels. This can cause soft lockup warnings when traversing large maps=
,
>
> I think this could also happen to KASAN-disabled kernels, so the commit l=
og
> is a bit misleading.

This issue can definitely affect KASAN-disabled kernels.

I mentioned KASAN to give context and explain why I saw this and
nobody else seems to have reported it. I'm happy to reword this part
of the commit message if needed but I still think it should mention
KASAN somewhere because that's the reason I discovered it.

Thanks,
Matt

