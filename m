Return-Path: <bpf+bounces-34608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDE92F2CD
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 01:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3694C1F2471A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 23:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08B1A0711;
	Thu, 11 Jul 2024 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTzQaDsv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223086EB7C;
	Thu, 11 Jul 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741903; cv=none; b=LPVlO96Ya3QC9wUx1xNJuB/7pyFrxGT0+4Bk6r30fgBWx8K/Yzt7x2kNma/+K5WOdiazxplU41Z8byUohaSPUd3myvH+wkhlwgkJW+j2UBnmqKpXK9TRA4zPBFdvGvITA5md2g3tnuZIgBzXdfwKE4j7i9G+AzgTpQNboKaMKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741903; c=relaxed/simple;
	bh=yLuenXi7mNTZLGlPoQmf3M2TZQJUdq3ySkuvd61rF2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5TNySFunyaghGpHVzVC2s3Tgjct4WIopHWTmt2cUTSjP5mI+i99YluHVwMmpGkHyscAFOa7JaoyNkv0PmjCwWMzLdUV4NMjTZcGkY3J+0XwntFKUyRcrAMCFdbiKuMvUgbtRoJl7YYQ+lbZaxj0P7BErDWTEMOCbQ1AhkoZpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTzQaDsv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4279c924ca6so4856925e9.0;
        Thu, 11 Jul 2024 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720741900; x=1721346700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rNOkKqKSlXdOxVSuCJmj91KdmRmhTrpa/Yg8kLQxJg=;
        b=PTzQaDsvpxiKLgA2sTFYuydEsWznDjJzNR68+i+XXBhm5OsPH43P7UEDkloF5gs0C/
         6MuIT/fHIQuNwZ4f9DfHPx+25UAC3ZxoOIoo3lRVHi6ZIsJmQ7/9s9Vgj5vkjHSRi9NA
         yU1BR77EreYQHaB0uIhM0HCPlVcTmYrc2g8sfBCWQRi1NR/C1A9ThxdjAmHalarVyokQ
         i9LOUmb8frg+o4c9GsNyh82FACPO3P9c03poU2Ln3eKiEkWhPtxCNnBodknw2TN9/XDY
         V/AcrFJsKuyr/vIRZuRb/S2sRughH65m5VkWVUwwh+sIxO2/wehsaTzO5HZZ/AE0ama3
         SkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741900; x=1721346700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rNOkKqKSlXdOxVSuCJmj91KdmRmhTrpa/Yg8kLQxJg=;
        b=pPAfDYb4YuR2/8Ba4bickuejoqA6sZl8b4jmQhZolLwIOCK20HVdlhbjd1ED3sqfda
         jWAmN+Svy1icNs2hrNwBYV3J37vUEq8RRPYl6D7JOMb6lBdfOgq9UZ0HCf78UJF135yI
         1fEvDMDqHuD58dD9i4EykfZpX5H7LeMm8stBYGJD5fI+2/LfiUnZBWPdv8O5E85JseUU
         ayOPkYRROe60Q+9eqTzNzLt/2+PyPsKeEKRTa/RZnoqgUYX3SoPYR9ft9dKdBKsto91k
         MaufzLsqKxta2aaw33QzSdM5d+qBSnAokZqGkSqIy9TNZ53H98PBk/mhMsBJZxQDMuia
         WtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvdHv5d0V3N96gj+Eyu70uWTq3wggZ9mqX5O74S3v5vzCU8w+ds8/Vf7gI6evrzQ5j5PfmM1sQf0X79gAlLHbuiq2S8ByEQ4jOSHZ9jCenzg8ZaV84AfhH1dZhhhGLzBkVLQchwopFNXw5o8ghIOPITuNEJ+8uzUgGNgSZcfDYbdU+Oh8i2wdkOky6xTgaTTwGqRvzig==
X-Gm-Message-State: AOJu0YzlvCaCAXI9ilVhC3Sn7jCPwwTYtD9KjweDucQbWOU7AAnf4B1s
	/bMTeoM4X+Z0HaOFx2yt4ZmZriXp6rejamNo4TcqPOxRLyqB+vFqMrl2QLzHWjLpvSNhV8OZHQk
	bEpzH/8JahKLyiRa7X3Y+M7iinVjicmEF
X-Google-Smtp-Source: AGHT+IFrtwMZGSser2pdLEMHu9/BZwtIElLY0d4iYbH3J9P9LMSwb1QRp/owr34MzeIK2Dss6VDWbjorwxkpYt37c8M=
X-Received: by 2002:a05:6000:1887:b0:367:89fc:bc11 with SMTP id
 ffacd0b85a97d-367cea4625emr9022935f8f.10.1720741900251; Thu, 11 Jul 2024
 16:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712083603.10cbdec3@canb.auug.org.au>
In-Reply-To: <20240712083603.10cbdec3@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jul 2024 16:51:28 -0700
Message-ID: <CAADnVQKVC4NGsEU0X3XJmmCot40Vvik-9KNFU07F=VBF-4UVRQ@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 3:36=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> The following commit is also in the net tree as a different commit
> (but the same patch):
>
>   6f130e4d4a5f ("bpf: Fix order of args in call to bpf_map_kvcalloc")
>
> This is commit
>
>   af253aef183a ("bpf: fix order of args in call to bpf_map_kvcalloc")
>
> in the net tree.

Argh.
So the fix was applied to bpf-next back in May and the same people
come back to complain in July that it's somehow still broken and must be
fixed in Linus's tree.
So the new patch was applied to bpf and pulled to net
and on the way to Linus now.

We will ffwd bpf-next in a day or so, if git cannot handle it,
we will revert from bpf-next.
Sigh.

