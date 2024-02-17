Return-Path: <bpf+bounces-22210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1DB858F98
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 14:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498081C20D56
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A887A733;
	Sat, 17 Feb 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCyMKDmj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5F2C6A4
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175525; cv=none; b=KzPwQ/Dk5KnC+oYbUjX63FDydJWs1HH6GqiCLDip4hp3aEYb7x1LNrL9ZxO6nLxnrWlGZ0e9EELEcx3h5UEU/phGwfhkTbaMw9xC1WfBhHX+Je6XCyGuhshkG1ta2JUKSnIqwrnxxj95g0laQ4UHTvFe/rmCbxS3lMNyjjZE7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175525; c=relaxed/simple;
	bh=OABZTzRyqcNHJ8zA49gRiDCDfVt1lm2cquUbw3LqfNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdoJw23UaFYuYuAdNrVDZ3eMEZqik8AlnnNPuXhL1H6wuJbEQr4NWpTofixx1kePrirQjIq+dcuY3Y2WvwbNewCwWvodSlJuzktXbYqb1sjT2QBPwnyOey9qG0pqVQ8iZynqjh9iW4DdxwT4ci6OhggbQF74NP7Fy2VL1tgXUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCyMKDmj; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-787225a2addso156184185a.0
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 05:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708175522; x=1708780322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYarMsOl5WdoTVMh050Hl+4TKIykRXAYxFjzLCBLlfY=;
        b=cCyMKDmjF2Mz6ceTqbkHe5GPa4l5oUqHkvWMBmpUFVhpZ/4E3aFsaHjdZmWe1HMDGV
         NRCk/xxr2JyFirakIhnyI6PMZxFC914mJ/GpPMaszCEG2jPJIwvYEu63AZ+BVSIV/8UT
         gU2jZ4xvWp7/MjUmRAqvFcGOzIOxoVcxGTcCOhIcurfaMYgwl0XAqS0fcYUd5b0PuL69
         XILrcmLF1RhQgyGbSFK1qMy3j3tDCI7JCerYZTXJpD0VUNS3euKBmQkYO7u4PMYuX+De
         PKyGC654rzeqfR8M/NKXyG1KWeBRh7MqxUYebmBXy+NgN8GUTn+EHMB5x5kDwGqpXd8u
         7zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175522; x=1708780322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYarMsOl5WdoTVMh050Hl+4TKIykRXAYxFjzLCBLlfY=;
        b=R1v1XsodqBRLzGwMy+7xeuPFZGGUYjVgjpBnCkv+ngOrWM1kueN9KXLdkgPo+Zg2cC
         6t5luT/O/wdQsPNxs3Q3fLtFmubXaxtL5FfJFh9OENtMPf7yeHwxHiwieH9y6kZMDjhU
         JMVAwIfBbctvHNeS7WI6S3f8hCU+iPuQkDyziNWgQj0y8H+fdCsC8GYoiim+sj5azoll
         K9yVQFIr5iYF1XmcsHmAQsz837exBMIn+PKDbEMOFC6TUVHjHUS7dpSaHOeCEkAnW8ak
         +eSYIBDMP2pCk8OGC0p3nuRuxLOAvUDKkKRQiPrv1EEyBx0gShd2pHEF51pzBqlSdKlA
         8k/A==
X-Forwarded-Encrypted: i=1; AJvYcCUoa+4V2+IMhJsi9ZU7LGWAMtbWI2yGPxg+S6q3L7oDXna8SjAMZx1yjPWOu8C4IkErpqplrn+1ESBJMi3U2S+fVDBc
X-Gm-Message-State: AOJu0YwWGvtH9ixV67y2QZ+mL597p6usX+VjLrRVPz83Pnf4Oedw4Mrl
	Rsp/7s8xlFe+YDhbfMRYPBbqupE1LkE1aDnTTQ7nsuM2/m3BRaiGX1/NZHbAb+Z9pgs6yM1xrTK
	U2wQydpy4Na9lt2NtnnhMys3Ek30=
X-Google-Smtp-Source: AGHT+IEsVln8aw/MTNCv6N4EH0Ls2xlignZ4EmmUydQfIDMi1jiZL0v0y6GGgKEDt6U48w9iy8rqrm5cNvZvCsYmz+E=
X-Received: by 2002:a05:6214:2a45:b0:68c:83f9:fa3c with SMTP id
 jf5-20020a0562142a4500b0068c83f9fa3cmr10053412qvb.65.1708175522551; Sat, 17
 Feb 2024 05:12:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217114152.1623-1-laoar.shao@gmail.com> <20240217114152.1623-2-laoar.shao@gmail.com>
 <20240217120333.GC10393@redhat.com>
In-Reply-To: <20240217120333.GC10393@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 17 Feb 2024 21:11:25 +0800
Message-ID: <CALOAHbCNs4VvVoKGTyw9E5oK=nh4v8+7A=EOt9pmj-n5DTYABQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix an issue due to uninitialized bpf_iter_task
To: Oleg Nesterov <oleg@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 8:05=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 02/17, Yafang Shao wrote:
> >
> > Failure to initialize it->pos, coupled with the presence of an invalid
> > value in the flags variable, can lead to it->pos referencing an invalid
> > task, potentially resulting in a kernel panic. To mitigate this risk, i=
t's
> > crucial to ensure proper initialization of it->pos to NULL.
> >
> > Fixes: ac8148d957f5 ("bpf: bpf_iter_task_next: use next_task(kit->task)=
 rather than next_task(kit->pos)")
>
> Confused...
>
> Does this mean that bpf_iter_task_next() (the only user of ->pos) can be
> called even if bpf_iter_task_new() returns -EINVAL ?

Right. The bpf_for_each() doesn't check the return value of bpf_iter_task_n=
ew
(), see also https://lore.kernel.org/bpf/20240208090906.56337-4-laoar.shao@=
gmail.com/

Even if we check the return value of bpf_iter_task_new() in
bpf_for_each(), we still need to fix it in the kernel.

>
> Oleg.
>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > ---
> >  kernel/bpf/task_iter.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index e5c3500443c6..ec4e97c61eef 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -978,6 +978,8 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_t=
ask *it,
> >       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=3D
> >                                       __alignof__(struct bpf_iter_task)=
);
> >
> > +     kit->pos =3D NULL;
> > +
> >       switch (flags) {
> >       case BPF_TASK_ITER_ALL_THREADS:
> >       case BPF_TASK_ITER_ALL_PROCS:
> > --
> > 2.39.1
> >
>


--=20
Regards
Yafang

