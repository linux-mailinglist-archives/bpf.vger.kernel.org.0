Return-Path: <bpf+bounces-40860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9198F6E0
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 21:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97D31F2250D
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637631ABECD;
	Thu,  3 Oct 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF8jdGKl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9681AB6DD;
	Thu,  3 Oct 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982862; cv=none; b=lW9IGnxkEn5oQFR+Kw/uDwUPIVhF9Zhj5C+W9mj+tO35F/L/WtWvMhlQncRE2x7fhg+ZvpSpnx02PC1cux2vPM2ofoqyeDJGueNlHcE/qiNm53CtSaoEw0eymnq8fUjrZVyVn2Uiw8kRyGTLq4uOud1pGv61YytkG5DaMmRPKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982862; c=relaxed/simple;
	bh=hkek51HZiFyWjMuH339bV7tUDXiEI3ziQgVq8TrvAqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnsToUTUWoSOmhNcQ38hG8goqsDo4qL/oF2j3daoZP6jrh8uU43DoOQiaCn4KJ3vKgId/t5r7gZJi/DEjOkhwgR+IXrgZnZc6qvY2Jhltc4HS4+atfg9tlrrFOTvASOHNAolgoUPJRjvQGNUfaYm7L2+K0g8XNd/0w8BfyHx8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF8jdGKl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so167381166b.2;
        Thu, 03 Oct 2024 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727982859; x=1728587659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crbKlFaWCZXIwLHF2Ztk874znYfbQRFp9tVROKFLT2o=;
        b=JF8jdGKltUI7FvYliXqz6E3YI8uBSNRkZ5iLYimQ64Kwim7pea5HLZ4/cBj5M/VQTN
         DaESPavU8OXCaTcaVdUyi9QTUrmwQ61/IB9UH1zaXNSMfeYHUriYYAtXXkTm6hp721W/
         jeu6K9cIx9o2WY3Tpy/DZvvjmhJ4yIWlCeCM6MxPM4snAnzk1yPVkBEtcbNUnT4+kjYx
         1QAS/lg/mWEcLK0Fch56aBNitETH8oskfCrxGOS/Yro+s8aLjZiItP83Ix7CgCaRekAN
         rrpKwdmu3tKNCCg0+KrrrEc27j2OSUfGxAvXnlD0rDp555splcqeKQvsOFmw+KWHk8MF
         j3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982859; x=1728587659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crbKlFaWCZXIwLHF2Ztk874znYfbQRFp9tVROKFLT2o=;
        b=q8315wZavQ9bBNCE98lRKVqbgdQFPs+Ddc/N32KBn94Wp3Bz1G+vhEP8t9ziIqaM8R
         ldv3+b3q3CjLwUmijBlRpyWNNsA/3PKBnewEpHktyOdAMsa4iBS1O2gLbRUNGokcJ8+v
         tbGT7hiIbdjEiTRYC+XXRaVVcSo/+plv6EjuoJ1jner863Z9zRPbY0U4sXC6fdz2V/4A
         cAZic4WRBUmQFWz0cl2yQ7BPzYWqMkBSN0fbsv6yZFN5FhhbNn5bLGB7TAyWUX7tcerR
         nYNW+RvBAsbLpzjpmbhA5XfiZkkRKsaZf0dSIYGJImEqtiUdEZ0iwVKoa7YosQl1rf7O
         /+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9tdjLknddsSzLlpPF8jf7xF/Be3EkeoZU6H9elv6QjAtEU97JWGVHhWrSK5dTJKfrYGA=@vger.kernel.org, AJvYcCXjsqKHjrxEmqJ/a3MMrVZHrcyjj21kd+bcwx4uXIClHAQ69JIb7oMlg0lvDkiVMR2vyqgkkjp/@vger.kernel.org
X-Gm-Message-State: AOJu0YyYem02At/xNj7rO4G/qsrFeuTpVsKa+h5+sUHqIGOZetxgfvtY
	BH7p9I6HRBAjhY0Byw/ErKFEoCcAyB+p4f30zn/i3cj+meRfHUIEG637n1Xvl4ybf+OwNNlkK64
	OfunKtlL2ymMsx9Es8jD219zmDYB7yw==
X-Google-Smtp-Source: AGHT+IEWq7oIiILMRmTpsmtonKFza5sucToClW+/lDk3WfPo3k5okik3W//eMMYTGkdEO9um1IWqrLQmTctQUz6fq9s=
X-Received: by 2002:a17:907:d3c3:b0:a86:a1cd:5a8c with SMTP id
 a640c23a62f3a-a991bd44f67mr34862166b.22.1727982858510; Thu, 03 Oct 2024
 12:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003180320.113002-1-daniel@iogearbox.net> <20241003180320.113002-3-daniel@iogearbox.net>
In-Reply-To: <20241003180320.113002-3-daniel@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Oct 2024 12:14:07 -0700
Message-ID: <CAADnVQL1ULq1tHHO7wVJfADiFPnQuTrap3+iQcQs-_y-zgKQeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] tools: Sync if_link.h uapi tooling header
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, jrife@google.com, 
	tangchen.1@bytedance.com, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:04=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Sync if_link uapi header to the latest version as we need the refresher
> in tooling for netkit device. Given it's been a while since the last sync
> and the diff is fairly big, it has been done as its own commit.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/include/uapi/linux/if_link.h | 545 ++++++++++++++++++++++++++++-
>  1 file changed, 544 insertions(+), 1 deletion(-)

iirc we decided to start using kernel uapi headers for cases like this,
so we don't have to copy paste such things all the time.

