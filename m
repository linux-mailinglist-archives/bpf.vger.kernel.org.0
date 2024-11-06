Return-Path: <bpf+bounces-44136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F4C9BF331
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 17:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D2E2810ED
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1A204F7E;
	Wed,  6 Nov 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTdcGpEV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E81DE2DE;
	Wed,  6 Nov 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910453; cv=none; b=jwKeQ7DEw6LUJ8ehsdf1qGrUJyLTl6Rr9kW+tJSLP5UakASEFiKxaXEmcpj2us6y3di4AsP724O+qZm90iexJOu+MsBXfrIQCeH0TjdTfYoJAJkiikq+QYMYthFlPjRYT99+hBwe5riwtd4ea0rU6ECGgz0rfv1oq4h11E/9Ck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910453; c=relaxed/simple;
	bh=dqDHGCKp076r/ubz/6dxcP+mhyFxuV6k2hXCDYfTq+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1qTUUnFZ5Mnt+KD0rSOXrsL0Nf9jOuAzPrRTiE9Vs2AIduVgYcWcACRphlBxrWayfbazbODArO3NYYZOqC8wZpm2Dejy7xcfHOE+0w5HOW1wxx2sAjetr8YRpqIo/B2KH8LkmjOG38f4UhCsuOqkyUb6o/9K2paGaU/Ne/A6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTdcGpEV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cdbe608b3so70161565ad.1;
        Wed, 06 Nov 2024 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730910451; x=1731515251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WsPRBTQwc5dj4lXDl+OK/MBpD2SjiCdDP2sbqnAg9M=;
        b=VTdcGpEV9ZKhzgxY6UBssZWiVgHtvHGLrHC4TtUnttALWq1yqNge6YKthOjF0lNDv6
         JskF1QCKKbsQ5DVnxVUqFcE1qGQ/X5DmaugvNHc4ouZlgbhB9TW90zK9dGOveHjNmuEE
         K9+Tn/5zFUdJ8GiKzx98vtXvIr6y5qauQ6GZXbOLQjA5CF96Sd+Es+bJSJbsjqTSDFAj
         O5HwOPlRAypZQOhQo7KXMm2fJnhtuYLAejSm/fT5KA7uWwHV/kD6k9/fE1Gic6Ij8k3Z
         wtWTrzlgeClOD33qKokL3tMVzWkuLfy5/Ojj9IuCQy1+jGZRc4pZdorepxeqXx2D4Mxy
         LxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730910451; x=1731515251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WsPRBTQwc5dj4lXDl+OK/MBpD2SjiCdDP2sbqnAg9M=;
        b=BzGGKxl3Jpe6MUtbDVbRJBvWH12vLycOaItRdqyDAPGeuMF5m+KUuUhhFcDtSU8S6w
         Mkkt8jN+q708vTf67l6QSwBLvk6YgUEZrEQKzcYum34J0EGATW73go95eiZvdjmsQCE0
         7P8RBcDFShNlTo3d+RArBIjuVpnKtGSYwKkDwBpnae38WS7Cl5HvIzzwsqi7Ym5L2MM2
         LFMukoBJ9oATjUgF5DNnAy6HD9ZvjW2xUNHyquYACwBhNtxegl4PhRccNtESQa36iw4/
         u63djSDQ0Zw+a/h585/Do0JVdczpNeAuw2U2lYn8oEXopvqct37m1SsqcCgwKDfhNWqC
         jE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe7jc0s7Ox2B/pneA7DN0u3OwUWGP434+KRCu40mSVI+JmRBPOHtZb14X7qtp6l1HHXcIxEMRlxt/dl7xq@vger.kernel.org, AJvYcCW0gG3m0bJwoRT9ak5Sh08Hx+lZeAtQ+nHqsJpT2o7t8wjYok0NfG1tTZn/xncJ0DWQiXH0QuXrRiaR1qmF5/Booe3j@vger.kernel.org, AJvYcCXMkYAGetLmFK7XPjwPv7O65hun7SasqqVYDq/p738NNR6ChKJ/JPIprCAFJ15dU89qVJc=@vger.kernel.org, AJvYcCXcBOx76WF2GG2RE6ualqZmAV3v9moPXblhx2ouLF2gip8H5l8gP5OBX+uh6XSHrY4GKDIqrXuFxYEyH/7hQEJxlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5nQX+4IVzGjKhJSibQr1ZnisHTN5XPhEddjvacg8XKS5d4pCv
	yRTTzoppi6LrrfvwJ08W0sNduGIXyfdHmogMVqLzFF5zhQeXhROYdFaum5imq1fIgJBJ1C1OuN5
	nYb0Q7QDT2OJ/nW4nLDPJrte1U8X8Ew==
X-Google-Smtp-Source: AGHT+IFZ7HPko/c4Xkh8GcCqUVhoDlLwVi5fZbQ8zNvjsTCHeshsiiTyyBk7S/FdYeBvDsBuooWoB3NR+4xTtuy981A=
X-Received: by 2002:a17:902:ec8c:b0:20e:5777:1b83 with SMTP id
 d9443c01a7336-210f75339d6mr395312835ad.24.1730910451252; Wed, 06 Nov 2024
 08:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927094549.3382916-1-liaochang1@huawei.com> <8bcc6d5b-08d6-48a8-99d2-d8bb2bef2d6c@huawei.com>
In-Reply-To: <8bcc6d5b-08d6-48a8-99d2-d8bb2bef2d6c@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 08:27:19 -0800
Message-ID: <CAEf4BzbJZ72Yr6tQuGLpz6fpKFXeUw3cD1BRO3T3j1psV4Qkdg@mail.gmail.com>
Subject: Re: [PATCH v2] uprobes: Improve the usage of xol slots for better scalability
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: andrii@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 1:12=E2=80=AFAM Liao, Chang <liaochang1@huawei.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/9/27 17:45, Liao Chang =E5=86=99=E9=81=93:
> >>  2 files changed, 139 insertions(+), 42 deletions(-)
> >>
> > Liao,
> >
> > Assuming your ARM64 improvements go through, would you still need
> > these changes? XOL case is a slow case and if possible should be
> > avoided at all costs. If all common cases for ARM64 are covered
> > through instruction emulation, would we need to add all this
> > complexity to optimize slow case?
>
> Andrii,
>
> I've studied the optimizations merged over the past month, it seems
> that part of the problem addressed in this patch has been resolved
> by Oleg(uprobes: kill xol_area->slot_count). And I hope you've received
> the email with the re-run results for -push using simulated STP on
> the latest kernel (tag next-20241104). It show significant improvements,
> althought there's still room to match the throughput of -nop and -ret.
> So based on these results, I would prioritize the STP simulation patch.

Great, I was hoping that Oleg's patches would help. And yes, I
absolutely agree, STP simulation to avoid kernel->user->kernel switch
is probably the biggest bang for the buck for ARM64 specifically now.
Can you please send a fastest simulation approach that works like
x86-64, and we can try to continue conversation on the refreshed
patch?

>
> --
> BR
> Liao, Chang
>

