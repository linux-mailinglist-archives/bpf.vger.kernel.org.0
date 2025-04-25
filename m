Return-Path: <bpf+bounces-56658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A298A9BC29
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 03:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8343BF5FA
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF9822318;
	Fri, 25 Apr 2025 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy2Df6h/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE13323D
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543660; cv=none; b=KGL4r6rmpJVNIOoycL9NLM3l8LS5mM55fBX/zv2Xbi+1biVUb85J7HhNZnwcBnssc0h0NGsyPoA++4Jk/jUnzSdzh5wv49w3+dJkk6Z5jE1GK2jri2ls/A56yJ+Oi0WwizsDGYiiA6xa6XHu7wQCf5JVGMR4Dwb3tEHJ7fMavO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543660; c=relaxed/simple;
	bh=SbUWUBaKPKkLD78xDF7OYTHHGgd3J+RbC62STwzUOhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0uExrTQJ/tBwjtCDE+poOW9C5SeipoKLJO/qn/SkgIbGyszsH0SoUT7LZr18WDGEgl59pu9r72vqIolUq70d+HjXaGQ80Y/GiEiTdYvqF281qZ3Vm0TUIAbXA/zNSJ6cm2moWFV73Ox6pp9uzl//l7LyUQaztNeU9MGuo0cozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy2Df6h/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1132315f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745543657; x=1746148457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZVVefzIaw8mBFkipxvS82ua1mko37bem8KfWLXCCXY=;
        b=Xy2Df6h/tiB4YQ5VesLbHE4zGHEb53lHmwj7VAlitvkruawjZVZXBBCaaCQCKgECaX
         MKx2eBTLeQcIr/mbMhhnqzm2Un06ORItF9YP+/XLTCKeyf3PR7nd2umuyixtNccMmtkk
         rm3dMEaod0Z/dBwQX9qpox2RbZigU/AeXxdYlIjpr2zL3WmDelkH6GsQSKHYwFyk1I5X
         vfxPa4b7RMKT45iLSTKmYEu8bouNWdBViWinkaPIweBYQH84PDK7UwwRmTH4k2cXnxEm
         vHVaTtQl4aSgOJ6YzldGaUduDGJABOG5G2iAb/LqS9xP8+04lAprB/HPXa/OsAPrxyms
         ghDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745543657; x=1746148457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZVVefzIaw8mBFkipxvS82ua1mko37bem8KfWLXCCXY=;
        b=LTQvPQlDKgm5ilf3gz/nZQ4U6BmOaItO+82bVnwfOzez5sXSK+Yv/mtHz3negzfNL0
         lvSA7W7tHuuBUXjeXlMTSQIr1Yoc0IqRcxf7lJDUhJxK0VRnyrlp8WS4p2J/t60Dp867
         0wa2Ml7bssqouYFg+vO3hebIBLH6QpmjzHNjt4ENKNc3tLccinZWPBHkMrrzctnPnSvM
         B9bTJJnwsNhyhX06WMZ+gpkyX/224M0XcUqltpEYRESEXAqNLrtnVDbbv0HgijuubEKr
         8wez6NP77/d5ZGKlvuQNKodReBH1MI0tefEL2d79Cee0jsyub8TJbC8cyVHaovxf8c1Q
         sD0g==
X-Forwarded-Encrypted: i=1; AJvYcCXpLa87yOjpbGyZgmGYJrC/4PrB1Nbig1meEYrg8iN9ItmZsBuEU8ne8h7wAcqsn6T2zvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJ7HmsucoVrq32hUx8Vr1o6jgfF7Q+m+v4JzOxtE13ebEp9P5
	gwlu3Uly7t7IrIvgjCm4YbRQ8B6KXOcWvQ3/nxoBIVbrMtVMC2lvPrVLiygyIzVozqjRc/ieo77
	0h/PU+rsVT9lqetRpvlvWfjN4y2U=
X-Gm-Gg: ASbGncu50PBelxeabJcG4Ig5hJPhlpNRr+JlMzJ5HtIKv75jBGqtumgZAY53GFnvjey
	RcxBlyJYW7iKmslsqcioS55RK+Baw8r7DTmq7e+9fdf4GUMBYlWwdGs+lF7JPxdWs/KzUavH6QL
	pyiftaI0vdRQBxQsv/q+1HGEPJ5MeY63ClqARqPA==
X-Google-Smtp-Source: AGHT+IHX78SSIOkLbSX9N1O/yOHs1wOd/A/fdrre5tzRrmXOweZY71uP5NjSb2+f39azHrfcBFJX1aEO6YoqwDGJvh4=
X-Received: by 2002:a05:6000:2211:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-3a074cdb972mr205252f8f.1.1745543656621; Thu, 24 Apr 2025
 18:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424165525.154403-1-iii@linux.ibm.com> <174554163275.3532237.3982010492009484651.git-patchwork-notify@kernel.org>
In-Reply-To: <174554163275.3532237.3982010492009484651.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Apr 2025 18:14:05 -0700
X-Gm-Features: ATxdqUG5CcFihSyZNByIUkJfK1NrG_Vt2gS6sySRKnJsstD27OHdXBYGiVj25Og
Message-ID: <CAADnVQJ0Zx_-6xX7EKBCuVabO7dL2JgnWo8hTj9dBS2_B0zVMw@mail.gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
To: patchwork-bot+netdevbpf@kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 5:39=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
>
> On Thu, 24 Apr 2025 18:41:24 +0200 you wrote:
> > Hi,
> >
> > I tried running the arena_spin_lock test on s390x and ran into the
> > following issues:
> >
> > * Changing the header file does not lead to rebuilding the test.
> > * The checked for number of CPUs and the actually required number of
> >   CPUs are different.
> > * Endianness issue in spinlock definition.
> >
> > [...]
>
> Here is the summary with links:
>   - [1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
>     https://git.kernel.org/bpf/bpf-next/c/ddfd1f30b5ba
>   - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16=
 CPUs
>     https://git.kernel.org/bpf/bpf-next/c/0240e5a9431c
>   - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
>     https://git.kernel.org/bpf/bpf-next/c/be5521991506
>
> You are awesome, thank you!

It was applied to bpf-next for real.

