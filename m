Return-Path: <bpf+bounces-57975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD9FAB23D3
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 14:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2771B674DF
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4C201017;
	Sat, 10 May 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="JnhmDiOn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A32571A1
	for <bpf@vger.kernel.org>; Sat, 10 May 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880591; cv=none; b=sRt/rS1iM3iQWC8t453U8AimEEBcA2wAe5EHA2Di1qrfqJh++u64nTc4u8Fkv2AyI37QJY1Xey09pAtVvaGnt21LgUHU/giEhwWdOFutFB6EU4GpzVd6p8niqBGd5SrAuJ5Td/wsqrHMFsyxIpC9U1krkkgDltzi0zP+VKvizYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880591; c=relaxed/simple;
	bh=/q8kJgwSmIb0A+1OH8aR16uosjpTozYi7B4etrb0gak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMPH4yzOFIbj8QDAbemGkfWyUDOr5Nty+N5VWApBwRirnHSiDoj6VijJ4dfBN1ov2OzvxEDaZWiVi836GDC1GG60xQT9WlGinLIZPNiDarC+6XWT/IwjW7SEjzlOONpNrb5dmSXb7YmBjsoavmygLx3LXTy7O066Ai99RB5PcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=JnhmDiOn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a108684f90so1670328f8f.1
        for <bpf@vger.kernel.org>; Sat, 10 May 2025 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746880588; x=1747485388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q8kJgwSmIb0A+1OH8aR16uosjpTozYi7B4etrb0gak=;
        b=JnhmDiOn3JyXi1rB/Rk/jiQayDue2ATqLPkXIqCVLFuN9EA8fMeMq+Zg1RfO56qxDR
         hnafcwzIA+0s8f9H2JUVtd2YH5I4C3Vce6EB9pUorfbt2YCs8biILjNQhfK++hSPJeGQ
         6Ia763+XmuOQYsaVewDY7P2D19c8fXTQoJh3bsqGx4tJw0VWVagHu5EvMbUZTonMB01o
         sW3ajfWtKPYIbkv/E0tC7is/Bxx0LPS2JDirIE6u1hjVqV7xg2NBpZ/VOUFU/DgKLMT4
         plt+eza4baVqaJDI1+Qw3nIbEkhsnoH9so+tdH7G+fGfJDIsCIk2Pb9PLbC85KxmskU9
         e/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746880588; x=1747485388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q8kJgwSmIb0A+1OH8aR16uosjpTozYi7B4etrb0gak=;
        b=mp9hvdxR67S7/9cnJQprQ3dUh1jSs+3S+heg/j3rq/OmtqXvh2l/iA1QwCihFxYcN/
         GDjejff/S4oo8MKwy2NEjOU0fSC2j9zsdHcqZtyu52donVP6EEW4HZouSDHzKSedK6sW
         nLx984JZ8WQRGly8E4L4LWTCi8zLHBlGdDIK+M9eLhfsbcscAQO7DLD5Hvy8Rx4VV8tV
         R6feVSyKV+Hswvd/IORAC9/jybl5Rcm5jqbY8yhCzn0bDPdkpFMc4xVi/lBW+Ous9tJR
         bIlFr8/1oAndtuF7dki/Ye2BdDhgWTKhni28kaf3UrMEW96iCqdHhX/jenAf2Bc13tac
         cwZA==
X-Forwarded-Encrypted: i=1; AJvYcCUP3VlSFyidtDpwH97bu6wAz3ZgA5DmS1JjMWsH/OYk/2fRDmVYlJS8Z+ESEzKvnaJMhho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5TGBj46wXTVCiyFBy1oMld5RdrrQ79bwsmFNgGDpBRvJoO03
	Vw0gwt9XV4DydiCd+i6/wCCyz2soKhUR+5R4Y2N7faZ9g7ASoOhuGmmKRcfHU1m7OL18rgZjQg4
	sAZSmp1NtIvLNv+rvTZJn9Y9NJt4Jal7JxEdxgA==
X-Gm-Gg: ASbGncsd8fD1J3d6QRFOQ+KPdUn6vXq2p3M9wWn5n71+t177dc+C2zBUSUYTBpD73py
	+WkhiyfaubYko5ZPqKvHxCU3jpM+3Dx+pUG/oXx0FVLxG+xMAFlfe3wakJWUQqEmDBNglr2FkDi
	JYRWfO3W+xgYvjHpnnZjrXcIGU+KH7kuHCo3I7sJMC42I=
X-Google-Smtp-Source: AGHT+IFHEmlECyB0ycoiT7KqmR8BBrcHrfyJ47/wPoTlxlscoWMwUFxhf2uMLK3rqXX7RVZTcaPTHckT/1pNNJmdWRI=
X-Received: by 2002:a5d:4081:0:b0:3a1:f68b:60a8 with SMTP id
 ffacd0b85a97d-3a1f68b60ebmr4283389f8f.10.1746880588245; Sat, 10 May 2025
 05:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
 <729dc77d091967d9496abda4ab793033f3979b2681da287f8bbf2df3de705dbf@mail.kernel.org>
 <CAN+4W8hDMdUnXitHuqUxA=mFOb=-QRQrejY8Koqb5mk0z-q9zQ@mail.gmail.com> <CAADnVQK8c+kM+j_YU3o61gdbfY3fH5N0i5h_Mef1Rb9j+pSYVg@mail.gmail.com>
In-Reply-To: <CAADnVQK8c+kM+j_YU3o61gdbfY3fH5N0i5h_Mef1Rb9j+pSYVg@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Sat, 10 May 2025 08:36:17 -0400
X-Gm-Features: AX0GCFtjjoeTa0sCys4Znd4njwBkEIg_e24SkXHYwR85O77YL1TOjSq7jW805kQ
Message-ID: <CAN+4W8i+CzB9=e0G5njGH7rf9NdJQ6RV9yHemq4ocqmxf8vtOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Allow mmap of /sys/kernel/btf/vmlinux
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Xu Kuohai <xukuohai@huawei.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Not sure how arm64 maps loadable data sections.
> Could you check what virt_addr_valid() returns ?
> I'm guessing it's false.
> I guess we can try to go back to remap_pfn_range(),
> but it may succeed, but the data will be wrong.
>
> Xu,
> could you help us ?

Yes, virt_addr_valid() is indeed false. I went back to remap_pfn_range
and this seems to work on aarch64. Sent a v4.

Lorenz

