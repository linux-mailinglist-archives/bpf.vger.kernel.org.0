Return-Path: <bpf+bounces-56653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA47A9BBAD
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 02:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2C7A99FE
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5804E139E;
	Fri, 25 Apr 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI/uOYeB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBDA29
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540207; cv=none; b=J+YthJQy3YWlw8w4oUmOudiPLfjynK2muI+b3bzxZGckYmrPArgXViUcCjn21EpOOHHWf3p/kI65Ugi6dYa4sUAqK1nudXKImhTwNP9PTCk74x/M8vn0839vwn9jkeTt0X52FbP0B7enpfsMXP7Xi5vOJGzvDDaSkepjhPRD4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540207; c=relaxed/simple;
	bh=ifcDe2k2hnWAkOkwHmaxLgaGSLMhXOHqwskgZyoFSf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbIb8a/o4OliR/xw3Je7Sk7j5X+++PS7OPUvi/Aex/zfRNWMWUKPprdGGKDp0JaUE0HoYp4kqAerniAY/tXSWCz0AU1cNxEYxs1iKYUHDISM8u7981Y9ltTbPaock/EQP3CK2m/n/ok3VFVWOlP6ExvZWeaNWeRRWQOcdq2vYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI/uOYeB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so20953565e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 17:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745540204; x=1746145004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAta25ND5aNfM4WJGTATjnnkMeYD7VJ9+xwL5dXyvJ0=;
        b=UI/uOYeBUR0j/uWHei5QDUGn+E74bIwkRUb1O7yXNBMRjnHrhy9RZ5pqOIn+lP17gj
         vfOlyaY6p2/30ddooA4mvMiB82Voim4FNkPSLHotpLbTxrOajTpPg5/6Xqxs5m0kML2B
         bp6131Y2XKDeOzJli0DcjDbfFMbyMztLl2pFp2PdSrHBH/w+DZN/cSALwLegKPuEEzRl
         salD+nv2zc3AiAVzJlMpOQHzQG61ZpQw1neRT/ye1pUs4y7MyL1YpvJm5msqkCktGGkf
         vVyCXbNqC0ABqEJbaX7ZMeXvq9WNSe779f7KqORrhtlcKvWOmajbTy2NTs3DAqZBZeaT
         PR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540204; x=1746145004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAta25ND5aNfM4WJGTATjnnkMeYD7VJ9+xwL5dXyvJ0=;
        b=sRixqR5NCeyBimwFbmKnu/2tKKukN1kLPF9ktFHuhmz+7PmeOSEMHY8AsfpBaloKxu
         6MHro+KO98gIt7T8H0PcnzleJCmd6PyKmITNdRjfl4kmpCLeNK98CloRLtir8N4etcDj
         4yzml2CCKwOfK+fq3IuMPDEM9AhkaQNJ+FM0aHikIW0Nn2JMQhO2ONAw/ZQW0AeXtVeO
         TmnL/tb+LkovEb77uv2DavLjeeuXCHr9xZHnWX1/T30Fm6qH+1jWQurSwlgYGFmnAf8o
         9MkL9fxQW6AJARmHONWL8+jlua4olObuBNXmDY8+H/knzQkmz8ToYCGuNj7jdWak+tVL
         RHPg==
X-Forwarded-Encrypted: i=1; AJvYcCXFPDvsq68Z4j3cl3GK4VZPqZfvNKGmLfMQ4+oEvCte8g7U9roPRgynk3lI5SPFTHKN5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH8R+vc8TGmmh/1u3RSxg6gh76fNtKUSTNdqmVrUWjzML18xF6
	lP/LXLxeVLN3/DtEjlyMpMEG/ejARVjV5JWvJVZjcd8wQ/GOWtQi0wxarYSiz4nxGf1v3u6IDWc
	PK+jyZWPsl1TMqqKH7kk1Ci2127lwBA==
X-Gm-Gg: ASbGncvVUZindCkJ6xwWOsNx+kItCVKUclDZdUDZYC0Rosp76is8lQfN9TUhV0fjHW0
	V+Xj2z9llAIgtd3oGrQy9D404NW0AtRCZ1tm7ojAR6SWXtjl0IxZU8s2tQigPeq9+Ti02z3x+UA
	RbF9ybuhJkWeb30JfKZThMLKjs+BpdXpK8XcpnGQ==
X-Google-Smtp-Source: AGHT+IF08VCzkIGBlCJC8eQ9R/ui2U0ICwrmUtxq322b7HseSPjui5l6hxhKJeQ69sfn7XVtXixNmeCFmttMril4Gmo=
X-Received: by 2002:a05:6000:2211:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-3a074cdb972mr133096f8f.1.1745540204415; Thu, 24 Apr 2025
 17:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424165525.154403-1-iii@linux.ibm.com> <174553983700.3526942.13762326617930238465.git-patchwork-notify@kernel.org>
In-Reply-To: <174553983700.3526942.13762326617930238465.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Apr 2025 17:16:31 -0700
X-Gm-Features: ATxdqUFXCT7AiIg1SdcI78vWYETwpWbBjymK-9o-aVgB8CRg5hpUwBmmdLt_vxE
Message-ID: <CAADnVQJ2gpjdQQgMmDOR-0KEsce4u_f2Djufqw7aKBjy=e+_Ow@mail.gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
To: patchwork-bot+netdevbpf@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 5:09=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
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
>     https://git.kernel.org/netdev/net-next/c/6fdc754b922b
>   - [2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16=
 CPUs
>     (no matching commit)
>   - [3/3] selftests/bpf: Fix endianness issue in __qspinlock declaration
>     (no matching commit)

Konstantin,

pw-bot is going berserk.

