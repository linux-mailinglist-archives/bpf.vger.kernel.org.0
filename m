Return-Path: <bpf+bounces-40480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D41989377
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 09:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836241F23E54
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44FA84E18;
	Sun, 29 Sep 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1CJm4/O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC21F95A
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727595152; cv=none; b=eGBY7TwWjmhQtVmF3h8WHxQOldBRWLO+4NReysbSWfBZ9hfpQkUFTBKeWDSL+IGxmqJKMHH2nUplMRUUpr7WAFrOonpEMAQuLcRD6CpHpx8Y11222PB/z8xUhamA4XZ6zncnoGYmHMesdsSJnz53eS6GY2YzH4tT7lIre2qCzvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727595152; c=relaxed/simple;
	bh=qMbChOq48uyiS+eoJMWyaVILpMNm6THV4cmcw5lnG1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bej8Q2BJ5T2ezk40DSemMdO8fZZ5KLyKTlkFuoqEinCIRcYviMzOAuskOUHYwT/ohyjkPbHOX9YoiiE/emGEpaKwlzhrLrWFls198VkCKF9L6hmGZ4Z9FzEk8B3kDRCY1Q1R8ggGOKwmYAaPzjdJufzcbhu0kdhD/HcO1ujXTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1CJm4/O; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb3ba0a9a2so17611226d6.2
        for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727595150; x=1728199950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvHHx1HPQCFIJRj5copAb22W7uxh3f8cwMv1wzZNzSw=;
        b=P1CJm4/OIDSsyWc2x5+bdaSbamx7KBJtC60B+VjXYQ617gVxWfmXb7cyE5E6QdNPq9
         WlxnUGdNFdIIqCo3cMVVQaKJbW2hAPRbQBS3sNuNyfy8vbXqhmgYcG7+UmAUP5G6AeXG
         nM+BKnRMeDOqKFcOYrJ/8xmSU9ZpgUOuw3esRvU2XYdjF3s2geLxbWFA4apmhP7fac6S
         kYmm+vtqW0FBSvwPSP6kyweiz1F+LhsGeS63PFD8yNtaOu/Ti0xjrdHdyLPOMfjCYSJN
         FDi+4g7S2Mfd8cYPSyCDsU2X8A1doqCqYG71Xxiaih7AdkJHu0FJehbyaPpL5IctEP6j
         Ae9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727595150; x=1728199950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvHHx1HPQCFIJRj5copAb22W7uxh3f8cwMv1wzZNzSw=;
        b=XTboZ1RV+cXa3LnEt4R37ARQ5WOn7LV+/O26z0bzHnjqtwSlP9hTsOJChEZDXVX5aS
         A/AnogCkI4w1koNraf/R5G33Fx5inOH86gt+v8lndIPSsv62ZS1t7idoPnlqDwYVkVjl
         RMtod8mfmD6rbbCkzM+1wHvwPQc7KJbP2mF03dhpJyW8yNY+7Hj98ZZqQxrq2x1cKJ1h
         KeYhHaDpqPy/Lz7zsR3khuYXRAcZbV1XS8Z+J/agvS77nEGeyFS3vFOOVdSZzvICZTRW
         5kzOpMsBp2rD4MkWti9QZdh5cJF4lg0NSKzzXEeuyLYYZUrsuP28YqNYpSKngvKvX/rS
         +p9A==
X-Forwarded-Encrypted: i=1; AJvYcCURxOdXJ8c/Tb6iRnt/QtjieEaz4kPIQ0GZX1e7jCJvG2AvLGtKN+Zhd/jAT4UI+IC1gJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFbSSvGt7C6J2BE9oyx2f/UXG3adMKzA+lQp33s2DUWX1mN1V
	jJuTbbK3KVV5Jp+wvYF/3x9Z2aAHjKdrUSO1999ZSK0mB1eoycm3HmM5b1dDg7sBOUaS07+1ekE
	Fw0s5TptP0y/Nc/XPdieyRdmoZgUHclJG
X-Google-Smtp-Source: AGHT+IGl5Vbg8OUBYcxTAC0JwJcH29mGgGiIuXYQ1ISO0l2BOxpcmTLCZrQ+KsxxA6E8Q08cg5zsW6d6wM1xo7a+BDY=
X-Received: by 2002:a05:6214:4602:b0:6c7:50bf:a443 with SMTP id
 6a1803df08f44-6cb3b60141fmr100793376d6.30.1727595149622; Sun, 29 Sep 2024
 00:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABVU1kWEHkt+z1c0vu1bXMn81iY8rDjwU=B6KPi2dPVvgeZUPw@mail.gmail.com>
 <CAEf4Bzbeqj3qneOEvKqcMf2XYx-1E=RKcAMo2L2oJz4qqqKbuA@mail.gmail.com>
 <CALOAHbBTLXWJ5EnXUzD-nGFxes-Q+Wu_-KPDZWHUKFfXsvdM0w@mail.gmail.com> <CABVU1kWDy4vPM-Kw1fGEyFtZqYkBcbB-2hktO2CBxE1P0L350w@mail.gmail.com>
In-Reply-To: <CABVU1kWDy4vPM-Kw1fGEyFtZqYkBcbB-2hktO2CBxE1P0L350w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 29 Sep 2024 15:31:52 +0800
Message-ID: <CALOAHbBsaw2KE96sajYaCie4ooyOva-cBmh3xnQYU1JqYZMf0Q@mail.gmail.com>
Subject: Re: bpf_link_info: perf_event link info name_len field returning zero
To: Tyrone Wu <wudevelops@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 3:14=E2=80=AFPM Tyrone Wu <wudevelops@gmail.com> wr=
ote:
>
>
> > The reason name_len is 0 is that the user did not set both the buffer
> > and the length. IOW, this happens when the user buffer is NULL and the
> > input length is 0.
>
> Thank you both for the follow-up.
>
> > However, we should make this behavior consistent by
> > returning the actual size to the user if both the buffer and length
> > are unset.
> >
> > I will submit a fix.
>
> I actually made a small patch for this when I was initially exploring thi=
s behavior. If it's alright, I can submit this after some clean-up. :)

That's great.  Please do it.

--=20
Regards
Yafang

