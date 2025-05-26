Return-Path: <bpf+bounces-58930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3FDAC3D0A
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 11:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51507A65E4
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A47F1E1C02;
	Mon, 26 May 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVz5XXa+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC28143C61
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252275; cv=none; b=bw0jfhu1HXxaUSfhnaK0m5nAYnp11xxms4O13ShFQcAAHTOV1lnYbJ+v1/AAoWQU8Smeg7rwABMxIYRME7LnVLghSpgoTjk7eKjqIShdSVVr+NqlOwFb32cFKcU7orv+d/to5VTLbHHQGvEJ87pEYYxiNfREz2tg/6X66XFmfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252275; c=relaxed/simple;
	bh=+QNg8KFqZBXglluawpmiVP9DWPx5eeamnQZjAqShtzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlJfonLrrVm2dup/vG8PBxvc9ej86tGEA6bhcWsPTm+t3a+c17GD16PckFn6bjEkG8CkYyA0oK8x+dO6BAg3FwXEaN669j0uC7TiJPFhrYy7YsVh5IXxx9VQrxIRiXs4c/tFrMC601yv6vsqlQpA9aChqxsBxQN35J5dUqGc6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVz5XXa+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so11609206d6.2
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748252273; x=1748857073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpPIAXlYpFE2am0BQB+sd7iQJSZxXWCM2Ai0vvYdY6w=;
        b=bVz5XXa+G75LpB/pq3vKmIypZVK8lY+n8sxZsOtb3S95rDA3+K+NaLV+ReZNDi4uvy
         cpiNWoph8wbktvckZgJbkdUvBqHSEyB53nDlyIGLYx+OhDG6sD+3DPTXY0oIs08Tij1G
         +Jf0aDbIE9mg0qtuq7Es2EcOv+EeYI8nUxH7zLNDSkRd7za1s6Jg7HZ979YuJob8j1T3
         NNVHKmXgFJACStlQatpgr7jGI62gpZb8KC1DbIdFnA1a+AMLtbmzDod8s0+YSXlkscUF
         jNeQ22fAeHPNXTrd28QlmnQsZunD7NFHVexuNv/Ttoxz31V9inFOyyHTUutaSbX/C81N
         UHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252273; x=1748857073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpPIAXlYpFE2am0BQB+sd7iQJSZxXWCM2Ai0vvYdY6w=;
        b=ta9bdAnkJJI1eISGH9dqU40T5/lr95GnXEj9vqs60t+bYw5VQne54pxuF97X2RmZjo
         kwqFDbDEY3ifaBXbe93m5TE6vHpEZl7vpv4yyY5ZwUWmwwXsppnJu6ZvuRhr1DM4Bnnw
         ecjR9IOcmRb3xnyRiBTGP16Lks740qrcajuzjHnOxCxc/9zZ5D5/EF4KJ0RhbUm4dmjL
         flwzM0Qlrmdp7q2GfezAVYCor2wssNFTxYGYsVwKcahhb+VY1iwzYy161pBy7uZs3Elx
         cCSk2Cm5UBXlb4SFZ7NTRRb8aWbwIpUBcoA0/YpIDgzK9FiJbgcC1mYmUXlxKr76b7Y3
         bmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwbEwpnmDjv8eaPdE8SDQ2C88OU4LZW+xf5d4lxU/ZnJFCcMENn/CC42IuJiAlYtCZlTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9E2fFQmtGCSfa3MU+z8rlbBgIGm6dU04VicY+dxDtepekIz1b
	3qO6D1LYIjlzgGM17nHZzU0qHO/g2ZKKPczK9yynQ/9QIsUaXX5vpFhcJaWs2b1O3n9N7QNxXtA
	QCYFh42q0Gvv/6vvXUV1UltCFb9CIJQVV9oN2AOjYMw==
X-Gm-Gg: ASbGncsPNy5M3tbzwDd9oLH99aE2mXcX0U+SnacC2Ze+MA8hnpjscBcsEJ33g+xMuwN
	/iP3cb6DI6C6S56/DCmhuzLYawNN2QxRX0JDFkrYc1gor794MlJUbbSeFDu8BvjLMvK/D02Y1BF
	RQlwMkTnt/6aByoDxkDHcypAHJHgd7AsGAVQ==
X-Google-Smtp-Source: AGHT+IHFRegTp2MaOa67maX95yPRXcfxL5k4LhdvZZ8dYcwyIFGsOxCLC8HSR0yagAAojDRaxYiJkrfc1ziwJCFD47o=
X-Received: by 2002:a05:6214:268a:b0:6e6:684f:7f78 with SMTP id
 6a1803df08f44-6fa9cff2f69mr127386966d6.3.1748252272881; Mon, 26 May 2025
 02:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
In-Reply-To: <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 26 May 2025 17:37:16 +0800
X-Gm-Features: AX0GCFtd1o2YYF7YjW_CC9HarRQ9vCcTbFUgfUfMqL9x9nt1OZbMdaro7AlINHc
Message-ID: <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 4:14=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> > Hi all,
> >
> > Let=E2=80=99s summarize the current state of the discussion and identif=
y how
> > to move forward.
> >
> > - Global-Only Control is Not Viable
> > We all seem to agree that a global-only control for THP is unwise. In
> > practice, some workloads benefit from THP while others do not, so a
> > one-size-fits-all approach doesn=E2=80=99t work.
> >
> > - Should We Use "Always" or "Madvise"?
> > I suspect no one would choose 'always' in its current state. ;)
>
> IIRC, RHEL9 has the default set to "always" for a long time.

good to know.

>
> I guess it really depends on how different the workloads are that you
> are running on the same machine.

Correct. If we want to enable THP for specific workloads without
modifying the kernel, we must isolate them on dedicated servers.
However, this approach wastes resources and is not an acceptable
solution.

>
>  > Both Lorenzo and David propose relying on the madvise mode. However,>
> since madvise is an unprivileged userspace mechanism, any user can
> > freely adjust their THP policy. This makes fine-grained control
> > impossible without breaking userspace compatibility=E2=80=94an undesira=
ble
> > tradeoff.
>
> If required, we could look into a "sealing" mechanism, that would
> essentially lock modification attempts performed by the process (i.e.,
> MADV_HUGEPAGE).

If we don=E2=80=99t introduce a new THP mode and instead rely solely on
madvise, the "sealing" mechanism could either violate the intended
semantics of madvise(), or simply break madvise() entirely, right?

>
> The could be added on top of the current proposals that are flying
> around, and could be done e.g., per-process.

How about introducing a dedicated "process" mode? This would allow
each process to use different THP modes=E2=80=94some in "always," others in
"madvise," and the rest in "never." Future THP modes could also be
added to this framework.

--=20
Regards
Yafang

