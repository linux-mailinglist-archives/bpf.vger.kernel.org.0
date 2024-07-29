Return-Path: <bpf+bounces-35954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06C9400DB
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE6728394E
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180EF18E773;
	Mon, 29 Jul 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0VKzxTW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A118A933;
	Mon, 29 Jul 2024 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290872; cv=none; b=F8cW4uo8vfibPLeLuRY1ohTAX02hET0IbT8oXSHPQ1KycuQGKhaq5BGAz457RHfJ8zCENzTt4r/91LMUP+WrbDrBWszRzj52Zt0xjiz/nFVu7JaiO2ImOs8+paaTm1XIBn2bxbALh94Fg5Jm2yO1P2gpyc/CZP1FwltGn1ewjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290872; c=relaxed/simple;
	bh=NbVzDVzFddQfjWchdlUZX+QeD4OBQGWyhqjyyMYw9/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPsdAGoYhkK1BYJogz/ki7jIYQ3n0LrwTv4dr4cMIWQMJZ4mPN5kXiAcbIksF/LS5pMvPD/GTgfkFU2H/cOs8RqdMgMdeiPeEal6sWDPrFj6KVXrhvfFGu3n7vpHVo1Pf3CBgMS24YXWEej/nW3FW/MFLx8/P7GRlbhNqGWDrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0VKzxTW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso2941462a91.0;
        Mon, 29 Jul 2024 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722290870; x=1722895670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz93iE/zRVko0K9iutmgk2llYMcTSMjlsp/nWk5tlVc=;
        b=M0VKzxTWre0XunJ+P03ckGYLGTmqGakSyccQQd5jZWbCpwf4Y7Rd7/MeQtJRG2fOvV
         m3dt+V8r7tvYVye0L6h708TljATF8jbvRsh6VxO97oXxOqSvznabbf8uwT3iLAr84Kjp
         Sbf5P4ebCYtauo7iahk8OFaKgRUZmnUT81/GDs6y/0zPbw5jBhtgvPwi6ds6L779BB36
         zYBKQAZt9pVXwQ276SQhzJfxVNXZ66H1gZq6lXW2RxSmCavg+HgQZ7RQdRKj4HLMWXe/
         fcQukhxGRh+tTXKEqUDYVhDiIgc5LMMcEQwiEaF/MUfB+TW7PC5I1b67CwfFGxwc/eqc
         ti9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290870; x=1722895670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tz93iE/zRVko0K9iutmgk2llYMcTSMjlsp/nWk5tlVc=;
        b=hZ1aLuNIzgM65uZbd3gxTpDaKhPpbSKDsHUC+kKnLiSsM4eqQDWTWMlj7Jo+gnPhXz
         3NfoLQG0GBrtsrTwAZHABYzrkz6mNxnTdBywPucdKo7Z0UmtGQTRK8Jk0GYf/M5UF3If
         0h9sm+p9K15xSx2uZ2XDgK//krLcVMm4Irw0vzKNysUdq2VrV30Az8yA7lS6NRp/SjnS
         7MnR7rU6WMSMt1L8IUPYBfoC1PV5JOzSmrsVVaD1Q8ocPUj+61LeIzIOZpOooTP3e0WL
         xLlhMmaTcyI12CkWyQDNmia4vSVyhg4p8WfcJzfP3GbiEHDgsVE2aSZbhglagnhUmMdE
         /cAg==
X-Forwarded-Encrypted: i=1; AJvYcCUQD6qXpMrSKwSja3PGwv0lXGg2fYpkoHqnABAY2zx4LB4w0mYYUejAAuOGCfiDf0b2qIdXjDUSL8JyS/HhSWbs0mfJbKj2zL6N5Qofl25j5eAlH6GMOuZTBXZ/Na/YKjC33BU8tZ3tkY1zIlQoJ+vItPNU29XGdLBYr2rei61n5wTJyTFXMTKGJOgxVuEZ49CVr8K9GA==
X-Gm-Message-State: AOJu0YykLeb8xJ8/wtxrRrl61n0oByu/Xm/UcF/24lhVCca6o8+i0OBy
	ivYN6CVfrLqfjj3vA6zLpKyswmZK842h/GHrY/AWAQw9zBKFqMP6VmkKaDfN4sJBS2HVYF4i7sF
	i4Pb9nVENfHB1c0w8+62BfsnVB7A=
X-Google-Smtp-Source: AGHT+IFrD5kiur07thzIpqITFCUYzE9vvaE5ExpJM64dGKdG7OWF6YwZ6IbJtFwqySy7Q5OZckFrtQ5i+F4VsFzCumo=
X-Received: by 2002:a17:90b:388b:b0:2ca:ffa0:6cee with SMTP id
 98e67ed59e1d1-2cf7e60bf70mr10843507a91.31.1722290870585; Mon, 29 Jul 2024
 15:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730075047.3247884c@canb.auug.org.au>
In-Reply-To: <20240730075047.3247884c@canb.auug.org.au>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 15:07:38 -0700
Message-ID: <CAEf4BzYhmauUjfj_peuT3ct9p=p6-Uc2F1LZvgT0+6hY+7Z7RQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:50=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> In commit
>
>   76ea8f9e0003 ("selftests/bpf: Workaround strict bpf_lsm return value ch=
eck.")
>
> Fixes tag
>
>   Fixes: af980eb89f06 ("bpf, lsm: Add check for BPF LSM return value")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")

Yes, you are right, I missed updating the sha during bpf-next rebase.
Thanks for the heads up, I just updated and force-pushed the
bpf-next/for-next tag.

>
> --
> Cheers,
> Stephen Rothwell

