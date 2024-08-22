Return-Path: <bpf+bounces-37893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1757095BE6B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FDDB22996
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F61D048D;
	Thu, 22 Aug 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfJa7tXN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4937165;
	Thu, 22 Aug 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352211; cv=none; b=SwE/TQurHvyQUcUXylaM13SvLmm3JOjCtIbzgKeS3oPRffJlLmGE7g8n9BcV+lfnvl1MjO8Cv6wuXpRSCN9MsLnm3FJgMvuJu3Ih0LPT1v9e5tSPc7hIGINdVSgMiy3ZgOpZ7ROc8y0H/LvLLzaeXA0Xzmi5v0t7Xrx4OaslGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352211; c=relaxed/simple;
	bh=SQ1W6+ZJoQljEuMcjLRF9j7tyxx3u5v2buo2l30dB5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eygyhiAjOR5kIz6dTYbFunIj0kZ6lIn8ga9KcSMGMseC2MmbKyFRnS+REn6S9ymjJ46vCC9CCscoCCIlJIyi5EL2lf4UFYhwRvqTtm6sP7oU0fp8qZW9sh8CqNYGFxU4SkYwsBL4x4ZTlQMEHdfyEKC5R2xgmJPqGwCcHHZFBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfJa7tXN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533461323cdso1406827e87.2;
        Thu, 22 Aug 2024 11:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724352208; x=1724957008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TO//WAYHXFXWsXsZJ8YpAAzDIi0eDn6U/BulbQYOss=;
        b=CfJa7tXNTiQv5lwlJItATMzAGpfx6sq2vMAy3h3zUUvbcTKseTdmUpLSBKTK4xuJlL
         GiapHuLPjKSnsnqvk89NOyhB5ZiTCyKKsjBbTDdtrRzG2Pok/qeVpFdFHobOLmURwf+J
         SkcWGy3ZAGZA3KtTPcbJrTEKZPzWarrTnGCNFRbu7+9dM0lt0PJC8i58fCjk/K7k/63F
         4fCHFooI52f3l5QXbt2Dddd+iI8LgCCI50Fw5Rdoh5NdvUU0v87xIsST8dsRSG19lcan
         db3VgHblzCDfgUgY6BpslVNpZkUwQ660TAOq7b5ditpYfYu75+6dnrbrsoZUEb7DTIpW
         pmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724352208; x=1724957008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TO//WAYHXFXWsXsZJ8YpAAzDIi0eDn6U/BulbQYOss=;
        b=o3XWW5zCb0SPDoCBWC+nCtCEYOGbR6H4SwwUq5xqDEV5LgGM3sHwhkJdC7ZIQjVpRw
         X3yRBkpdoWv8TuI9k306wHwgb/4q7EUpaLa0tXgkOUPAQIqcgfaaZS1kKtGO0wGdhDzu
         i6/8hxvmo5zaTf62dCC2374xg1gcHkuGMtq3og9WxsU6XQLRGj1KHYH+bTUIlv7EX2cn
         v2xywr9yn1BvPr6YtL2ns4ptw1SgQy1YQr+/Qg8EIQqE4Mw+W+LX6umYAIqGcipWJVf3
         LPvgJ/nWGfzc5/hmjUk9IxlEV2+KZ6MfppZR+LVds13c9kMJHcyc2YlYgZIQKE9tbyaM
         AyGg==
X-Forwarded-Encrypted: i=1; AJvYcCUgowyFNPEF2w5FTn4Tx4O3aS/MI1FoPlQKzbRSikHJiQ4WeSo04lK0tHNqiI0VCVHHcHE=@vger.kernel.org, AJvYcCVka+ums+kEovWd4GSnx5tMw3O78nTC8Aw8Pyu5nbuG3KT8BlhwmSolpXtQS3cJOJDERNwTrKJB@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIY+ExreEP79laOis6oIPH8ivGNyytg2KlAf4z8TfSxvw9jQe
	1ZWtCfxthuAxtijMj96yAEKhtH/gtpVL/NGuSSsOPd2mD3SX355qR0ncI2/b4rqOl6JSyvyMg21
	LGYEXj7Y4CFd9SXsSfdTFBy4KSGQp+P9h
X-Google-Smtp-Source: AGHT+IEVvWzgP2h8CvTyzmkEXdZyf+JDIv26MKmGAYMTUKLHy9A3fDpG+XXOM6jXDBvQG0g+Jt82ReLEq9sSyOSG1fw=
X-Received: by 2002:a05:6512:15a7:b0:533:448f:7632 with SMTP id
 2adb3069b0e04-5334fae85e9mr1697438e87.1.1724352207522; Thu, 22 Aug 2024
 11:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1E619C9E44C8C4B2B713A0D6DD45B92BF70A@qq.com> <20240822082935.1ac2b305@kernel.org>
In-Reply-To: <20240822082935.1ac2b305@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 11:43:15 -0700
Message-ID: <CAADnVQK_RTRT+DVPj8daBqJO-1neY9_efTMgbTL+kDnJ9VNAQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow error injection for update_socket_protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gang Yan <gang_yan@foxmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Gang Yan <yangang@kylinos.cn>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 Aug 2024 14:08:57 +0800 Gang Yan wrote:
> > diff --git a/net/socket.c b/net/socket.c
> > index fcbdd5bc47ac..63ce1caf75eb 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -1695,6 +1695,7 @@ __weak noinline int update_socket_protocol(int fa=
mily, int type, int protocol)
> >  {
> >       return protocol;
> >  }
> > +ALLOW_ERROR_INJECTION(update_socket_protocol, ERRNO);
>
> IDK if this falls under BPF or directly net, but could you explain
> what test will use this? I'd prefer not to add test hooks into the
> kernel unless they are exercised by in-tree tests.

This looks unnecessary.
update_socket_protocol is already registered as fmodret.
There is even selftest that excises this feature:
tools/testing/selftests/bpf/progs/mptcpify.c

It doesn't need to be part of the error-inject.

pw-bot: cr

