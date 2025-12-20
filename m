Return-Path: <bpf+bounces-77216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC46CD262B
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22B78301A73F
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 03:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA72BEFFF;
	Sat, 20 Dec 2025 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqNFQoZC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99E4C92
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766201285; cv=none; b=YQp6cQgdEc4fwZoyMnlWNqmugGviE3tP4FG/BQ+DIQBDjIrRV9pu9Bts8W7yP1nV/JRc/5DGPDsx3MZqKVlpcksfJARVAkKZa2BWGRwNgXTNrZ8F2ZAOpir4/PIolS7x6qw0m1M1zAoLnBWzmU57/XJveR/YjsUqR1PYlEExgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766201285; c=relaxed/simple;
	bh=xRCx1nr62R91KtuJnNxXXqfs4vTYHzW4KgRjxoCuNKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7q6gCnp3jNnR4K6KDPXWdGJL3yai2QxhvooBM3dDwE1sLO/G9HU3ii5w1vmKEYvSSyedZwP3id3oFsyX72tzqfSg4zhT+y+8KAHIKIRJwzwAQHWGKSeUcwKxSj1v8rKIccfT6W6MoFggm8JIs33j6QnRjMYF9hYWeLnkan7bIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqNFQoZC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so1988304f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 19:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766201282; x=1766806082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRCx1nr62R91KtuJnNxXXqfs4vTYHzW4KgRjxoCuNKc=;
        b=ZqNFQoZCwgZaWQW1eMtz5XKT1zCaR8+zRSZpVwB7NmFrbFJvwQ0Mk6PEM+xq65AVUY
         fhNJt5vqsLde2UQo5+xy2Kqv2khqGoavXbDUjgNIiirxGNu8LrdgUlb8pV4M1T8TAFSV
         vhBk953uL5nDflu3iXPZsxXE+zx2HfVqFaUkR666dxlqZYMCt8NzRtYC8yZGpegENoAN
         KYMTjZ9Tndhawy5XigMb/z9cn8MQt/NOZZUS1F8XvKkZYTnCmeDOZ0XsuXb3ObL9xUKs
         RzKne9gS2r80moRxSEoNW/EedGeM/NTugTb7cvYa/uUYQc2bdQeG7vYLqqDAquQ3DyYU
         AqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766201282; x=1766806082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRCx1nr62R91KtuJnNxXXqfs4vTYHzW4KgRjxoCuNKc=;
        b=kYyp+YpcbGLLgXEj4zr3cUIDvln4jlJls67vfes9dfHQjSI0XlXEy5/JPjXpdBZ/OO
         jFU7rI+67phvra8Pq929R4WTquHHr41HKXcE0iv6ABhUJ3mQTf+z6ao4HnrwPYhQ7LmG
         stGSAr4lo5uQOFbH0gpU87U0IQ8MWbKxlbOza3do129a9WR5LSJkGBuiaZ1kXChaGN+L
         /8M4XMemZ3n6MQOiIR4Tex85zwHOZwgfyJQzQXkV/DAwLPeS+E1yWd0ZxiQ52rs2atG8
         V9Xjpw9hC/fmGorKzoValYJDxOLvwcthkwhUgwF9UL8a3QzhoEtBmwz4kER2e/nI67qo
         gFpQ==
X-Gm-Message-State: AOJu0YxcipPKBic2XjyMvluh1JfIZdx9Xnh5pFwa0I/pVYfV9heTZgSm
	MrXPcZxmQuuiP4Vxvh6/A7ZC0dxIchKOanUE7ZZGyfd2PE7j91os/0HcWy1fwoL/ctYAPHKW7CD
	D+oNPW5kWq2tBhmMqKHyyM2Of/5a2ouc=
X-Gm-Gg: AY/fxX5hQL5k/LvVlrQscAJq7j+C6GOkLuqD3Vqjcqrg40P36D8pPcVvYHLKAUbuIaK
	Bq0LsuauszcVRXofikdnA0vruxD/cNjlWgONlxG/wjWoc5K15KVnujE1oAK4JqyWqi5Wld7h02o
	qynLnyetZfZVP2hKa8D+Z1kbG8AihPDi8+0pCFy5TbrkUZPDlszvkEg23BEMZOL3DK7gMno66BL
	4kEL5Ztl0zjuGFfssXKyXQoNa+1eWz38P4v6LBJPNBh7q6k18x+d3r3HpEb/ewfZ1qrECuZ
X-Google-Smtp-Source: AGHT+IEOXFoPWZp9kz2gRwbpPiV1d8dFcm7NlW0JmcyfwFgPU1xoWm/5iDdbqTZaIBoKJIFZ6pb3fUxZjAthbLfwOY8=
X-Received: by 2002:a05:6000:2382:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-4324e4cd052mr5228343f8f.14.1766201282061; Fri, 19 Dec 2025
 19:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
 <87ike29s5r.fsf@linux.dev> <CAADnVQK26E47RF6TWKAXZizn1QQL1GBMx5MF9pqAA4+5ev1xWw@mail.gmail.com>
In-Reply-To: <CAADnVQK26E47RF6TWKAXZizn1QQL1GBMx5MF9pqAA4+5ev1xWw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Dec 2025 19:27:51 -0800
X-Gm-Features: AQt7F2p8R3sRdgWzbGXmUzFavtDa72NaxK1JKTU5B4BpHdJ9v8JACC-MN7FNszY
Message-ID: <CAADnVQJduVYJ5-Z9wS-QagZ7ZyMRXYR91G5eAu5iTQ+T4XdgUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] mm: bpf kfuncs to access memcg data
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 5:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 19, 2025 at 9:40=E2=80=AFAM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> >
> > Roman Gushchin <roman.gushchin@linux.dev> writes:
> >
> > I believe it can go through the bpf tree or the mm tree.
> >
> > I'd slightly prefer the mm tree, simple because follow up bpf oom
> > patches have more changes on the mm side.
> >
> > If Alexei, Daniel and Andrii is fine with it, Andrew, can you, please,
> > pick them up?
>
> mm tree has no CI and no ability to test bpf things,
> so in mm tree it will dead weight while in bpf tree
> it will be continuously tested.
> So I don't really like the idea of anything bpf related
> to being in some random trees.

Adding to the above...
bpf-oom needs to target bpf-next as well to actually go
through CI and AI bot review...
mm tree is not a good idea at all.

