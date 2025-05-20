Return-Path: <bpf+bounces-58560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D99ABDB6F
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85ACB7B5454
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE872472AD;
	Tue, 20 May 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqB3Wn13"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C4247280
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750122; cv=none; b=sk2LZLyewvrpo1uZnvaD+sNA/yg0vJYnxZWgISEHPW69S8Jy0DRTVMq18pgDiG1S0iuMiDJ3aArXnooWI2oJshMMtSJ8RS+ixvACrKl/ok4L2vIJIBDiBl+2Mp2Mplr8V5mTSgG1uihObm+rdpMvDW1zxXNhG6WiC5LBR4kjOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750122; c=relaxed/simple;
	bh=R9u9GUL7kBZOiQSKUFSWEzUwnZ7B3UQlM+Y4Twnxues=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8dB/BfIILY2xGJJoSwkdzAGW6FJ3wiXa4EIlUNFGINqhli7l3LqIdTzPewD5zB8JTFjMcHzj/EOrytNlBcqKPKZxEnuRiyezAZpmknbdp6leon/blW0XR3wWBiztrihC/oHXPgwUK1p9TXaU6wQbr6whuLuM4lGYVjeT+avZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqB3Wn13; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0ad74483fso59275006d6.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747750119; x=1748354919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9u9GUL7kBZOiQSKUFSWEzUwnZ7B3UQlM+Y4Twnxues=;
        b=LqB3Wn133p8c4Mov2AkMwoOq+KvRHI6ZdteD2UK894Ux8bbD1kFmcjKkHsy5lzWyRH
         JjFOtQH7fmFyBx4V/Q57Z5RnKsx8UTJ8v9uMZotgVWqtRZxi7MFLCCrPN7mWQPGHo7Jk
         l0Xe2btjZi29no0WPSAJRM1YPA8Ku/gMVpuGWSWZKZ40F7luPZ4OdeTJK5PRR1BH6pT+
         n1yPpkJbHPs6d7ZGruBogqbHvCsCOyRxutuIn7PoX4P/tkpewYQRQdVPj4GVrXPLWj1k
         5AiZ2CR+ofutwmZBdHw6oP9Oigvpkdl4L2fYA1wgpLpisUaYvlyJ1tpbzIbuNTwuxPgX
         V4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750119; x=1748354919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9u9GUL7kBZOiQSKUFSWEzUwnZ7B3UQlM+Y4Twnxues=;
        b=Z7KNA6y7dcXWOJOxntlSvwUxq5E4sTm/qhuToGzWfp5eQUCIn5WdxoNeZMb8ppN7Rd
         tFJl5q3OQO1oWpAF/mJW33YY+KzBhoAOAZ254lgsS5J8Rkqkd4Hyhiz1rM+gL+nE5ddZ
         wPtWAKv/ce6kuM1K6CFv4P5Du+AY6MweoaKk1YwRHQFqFKEt7AbXtxlgBwzfneSBnmnR
         9HVZVOP3Fesg5rWBGZHN1GfOEXRASIOKprxI7nyzT/BVoOyKC+o/cbSJZfxfj3xI/FD1
         VZfiuz8eMgBXk9tcN1/V7DSQaPd6ekVb4S2RiTN8PPDDV8fTkvISJz0jSaOEuib1PTwi
         Nt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7nTMOv6QnViWOu2NwmMX8UwDHZU2/GE7Z5JcolZzLLoF00oJJRwpSkBCUb4JAKgStS8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrh+YAw7p5E484VunZS+C85Ka6Owum+09JmeYBZbW9zHaMWHPn
	240OT/eqVNGPxT28xexDhH75L+CDgzi+PNNqHPrHanH87EiuVhejIbItR9APzpad8YEg1MzfERW
	TKpoTAoG6SucXxTDhv7grxLhBD5eo6w4=
X-Gm-Gg: ASbGncvVD3MAYzw/XrDSKVvIkHACx2hX4tmVBh85q5/lGJa5T2q8DmscZoNKCMzOGkg
	IMIuFlgjinjMoT4dYgJEeQlqcejqVXE5MM5IQUwUr2T4V/+x9o6hW+ZUwGPG1GEGb9nGuCVR3SL
	mRxRRBts0SnHD1v37CwICm1GBnbzTqKAmnRIA=
X-Google-Smtp-Source: AGHT+IH7TMMUyDsvRriB+PtNF9NYS5GRdaGxJfFsGLNZmfI5bXhqWMVYC6N9NjlTbhfisISp6iBSL6lnIRYCdzi1oL0=
X-Received: by 2002:a05:6214:19cd:b0:6f8:c2b9:b1f7 with SMTP id
 6a1803df08f44-6f8c2b9b2a9mr248505096d6.13.1747750119154; Tue, 20 May 2025
 07:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com> <aCx_Ngyjl3oOwJKG@casper.infradead.org>
In-Reply-To: <aCx_Ngyjl3oOwJKG@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 20 May 2025 22:08:03 +0800
X-Gm-Features: AX0GCFuzeGC_Vo5CiRuC8Z__YjWOafRsZm9lwTrMJeZeDyr3nvckYp1Izr0sSEI
Message-ID: <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Matthew Wilcox <willy@infradead.org>
Cc: Nico Pache <npache@redhat.com>, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 9:10=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, May 20, 2025 at 03:25:07PM +0800, Yafang Shao wrote:
> > The challenge we face is that our system administration team doesn't
> > permit enabling THP globally in production by setting it to "madvise"
> > or "always". As a result, we can only experiment with your feature on
> > our test servers at this stage.
>
> That's a you problem.

perhaps.

> You need to figure out how to influence your
> sysadmin team to change their mind; whether it's by talking to their
> superiors or persuading them directly.

I believe that "practicing" matters more than "talking" or "persuading".
I=E2=80=99m surprised your suggestion relies on "talking" ;-)
If I understand correctly, we all agree that "talk is cheap", right?

> It's not a justification for why
> upstream should take this patch.

I believe Johannes has clearly explained the challenges the community
is currently facing [0].

[0]. https://lore.kernel.org/linux-mm/20250430174521.GC2020@cmpxchg.org/


--
Regards

Yafang

