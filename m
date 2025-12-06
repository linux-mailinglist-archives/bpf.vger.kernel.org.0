Return-Path: <bpf+bounces-76216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADCCAA61B
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 13:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78D5308B35E
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB22F4A15;
	Sat,  6 Dec 2025 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2oQ5onQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E432D9792
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765023737; cv=none; b=ZKcCYjegpqMt+MS7NHGrYowByfJzzLb8WOGVDrmcNLkr2v3mgcOOcJt6Khz+48HG3M51Z+YAow73FqveXwYSi+KJEhQcodR55xFgl0QNDkYHqGW73YL/ke6xitFmN7AcX7uTNYdamDLSWI/DAlnRjoWxojMYgm+qLYTwSEksOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765023737; c=relaxed/simple;
	bh=avqE80FuNxtKhYsrQn86s5EDGliZlYwIo6L89ALC9u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUEeJD+90w+jrZwxHHp9+dqavBrTzmh3A/K/1F1a2NjHz3K14Xsv8/xJ5Fu/rkLY8LqWsNHGgcc6isCNB2CJBH5zH/86rUyHX/sEqoXaxJB17Fx+r0dGaO3RWnQKSsLn7EoKjJeMDzHhQhXQIvKo4Y51H0OPqeMCbYAAG3237SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2oQ5onQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2d44c727so1429122f8f.0
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765023733; x=1765628533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avqE80FuNxtKhYsrQn86s5EDGliZlYwIo6L89ALC9u0=;
        b=H2oQ5onQ0pFPhEa0hqbyseC8fjech6UnCLlnhYLjodg7Zx/vPRKm+McNKFK440OPWM
         UWpJJOAiDD39gSq/Ry6xLP5rwUj0dy8oBRgVoT/maGQMF2uqotYfR3v2cHPScIgU057r
         1SCbxK7kiHxihJ1fCGqYV/RH51K9QSZoTVXq0Y1AyZ9nzUlBCpISo2w6LzlS9aKkeguO
         3scPe+pTcLevUkLBnALK7CDsOCn/ilthriuzhurw4LlEUY7EFDnZQ2pLmLfjM0bczUee
         BECVBQYW187EjwSHteGWpep81lfwgfdVMIvughbEU7O2/ZkYQ1aK16nFee03/u3Qig1f
         AWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765023733; x=1765628533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avqE80FuNxtKhYsrQn86s5EDGliZlYwIo6L89ALC9u0=;
        b=ZivJRsdfn4RhTqabf5nrQ20yR+ML1MYlgoWOHdEiVWoblQOTAEZ4My5lPHohZnsMGC
         8ASYWJp9BlReYSNe3nI12PuXVHPniRUbgLuFPxO9X9y5kKY3PPrrOu6l16lyYhcQ9ynj
         Yaa4PhWPpqRp00Mf67wJLkcdEQzqowpeR1e7L9wFpXWFIrITyKqXLr3PgD7EUH93rNNr
         8lcIDuHYMdSmhdtCTWxcvnP3wiWRZrZiQySvAVOFCIDIXwvSKw8jsMVULONwGTSVI32v
         SHo/eKs6QcZiKbXLbWnFfMZz2h8XJUHCpwkUTWoW2UgDQYnRCevobhKVyD4fs1DGk015
         qTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0MR4RVYn2mU/wXa9PFhImFwODxGMwrDKBuVqd5ph45lT8xYPm0NZZ3MrdQl4peFVkq7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+cvrjiakiuPT1g+sBLVIbyyXxWbmhI3lFIFkI/TgUu+znFVp6
	ODrXK7UwWu6YZ1fT9+O8kKGL/07zcyIJdvXVRRBnzpoTpdqvvZNYTTPjVpkPS3VTRrt0QwuuAvs
	mKWD+MI4k3Q0aK0+v6NzI1GX2NtDNimM=
X-Gm-Gg: ASbGnctKHRbpdKYn83TPR+ChCdanpjtYCHSoShFFlOvUSOsSPAgSTBnTBBM5ACPQMiy
	Z5Gj2etwoJevjaOtDgHgxQeuPrmkSJbKYv4hMZ1TvMnnCRNHY5C3L1jfceiVJ24SMsUXfdwvFSV
	sdNEO/qI2yXxN7XcLA3d8GEB/OGQJ+IwGjFMgxp1nv6rUvINo0GDQDl7i/37T1eKSoBLWqzf6r1
	vg7UxkXOx3R9L9MgDYHXFASfqUcrg51o4LkZSdX1ih8mESqYyYMS6J4N/qPjJCvqGOTQ5Rn
X-Google-Smtp-Source: AGHT+IFKw1cI9zye4JnFcVRfCJWeiris14USYPq+Fx80W4JZDV4qC19cHYIhu0zTEYoB+fP0fkJHMvEAuQZHqn37SP4=
X-Received: by 2002:a5d:5d86:0:b0:42b:397f:8dd4 with SMTP id
 ffacd0b85a97d-42f89f56433mr2390728f8f.49.1765023733038; Sat, 06 Dec 2025
 04:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKxZv9hCLeFz60Sra5t4J4h=EncoKW3K1OyEBePAfqmuQ@mail.gmail.com>
 <20251206121418.59654-1-enjuk@amazon.com>
In-Reply-To: <20251206121418.59654-1-enjuk@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 6 Dec 2025 04:22:02 -0800
X-Gm-Features: AQt7F2pje1q34bfp3bykmYzXEPk-ALtUw0mFaR5D3NfbkPUolo5MgMXaH7eX0os
Message-ID: <CAADnVQKJ2wzZSCmYPR_wTfp3pLDpHjTVQ0RLviHWGMtWzVy8-Q@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
To: Kohei Enju <enjuk@amazon.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, kohei.enju@gmail.com, 
	KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Song Liu <song@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 9:14=E2=80=AFPM Kohei Enju <enjuk@amazon.com> wrote:
>
> On Sat, 6 Dec 2025 04:06:38 -0800, Alexei Starovoitov wrote:
>
> >On Sat, Dec 6, 2025 at 9:01=E2=80=AFPM Kohei Enju <enjuk@amazon.com> wro=
te:
> >>
> >> Ah, I forgot that bpf-next is closed until Jan 2nd due to the merge wi=
ndow.
> >> I'll resend v2 after Jan 2nd :)
> >
> >?! It's not closed. net-next is.
>
> Oh, really?
> Hmm, I've read the documentation[1], but I may misunderstand something. P=
erhaps that documentation is outdated?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/bpf/bpf_devel_QA.rst#n232

yes. It's seriously outdated. bpf-next was never closed.

