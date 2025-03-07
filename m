Return-Path: <bpf+bounces-53593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CCA56E61
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 17:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F4E3A8ACC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5504B23A58F;
	Fri,  7 Mar 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="KP2/loS6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68622DF68
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366448; cv=none; b=bXBc+gjvq0zATk2DQ0Xz6eEKEUNI5pmzcaJo9j6ax9aKe2DG/JqMkG5LDoH1Beksc7NudW4HGcA5ezYNuW1tHscaMgJBRbx+52zStOiuNTg6lbdWAd87rYaIxR5/Qb6MFbirr/m22Gz2UQS3P+8uFd5ltW0gJpISNqK0IJEijA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366448; c=relaxed/simple;
	bh=Mf26Qwc1/QuPy6FIlB9SaM+hKmbDWQ7zc8isLjuZ21w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eatTRX0CbI9MngxPY3CUdPxtpjqopnYFbZkOSRQ7O9RFRw+yQyQsU0Hh0u57qdOsniExBrh3N9zMbhVJRYXBrAtqjdm45uhMHwgojay8ApT+zFR7auhMkOnzmqIxFXX7dLECFKWy1tXUNcLh5xqiM7ILxS48TdKAKEMbcYEyzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=KP2/loS6; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6feb229b716so19470837b3.3
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 08:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741366445; x=1741971245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlOVy80+/7qrBzCMDwFKpqD0bd+BiJTGr7ikU6+BX0Q=;
        b=KP2/loS64sKRLuaqhDyiNR2QqC4q/qBqkZewjeQAewXOGwHk/OUS0vjtEJbrOX5H9m
         unTlwccYwcCj1/SWIUG9Q7uhkfp+2YPzOecY5M5VlYLV4OZqnahqxnG35rNcEnPk8zzs
         LLbRRJ1DsM8CBPnRMZJc8r2BYO6hZn6t4P/VsB975jcBwIJ7Llh1UpJIEvzkde2tKFN8
         Tmgc8OlHoH7S+Nms93VE36lGrllg00OdJV7JiX0/saeE24RjM+w5A4TkSR4Ywyec7oN/
         7OjKD7NKbD7Ftb7DDeDWt6ioHbXWYlQH3jUL8aCIYUB3gUkGYFwMCpj+pVGymfKrz9Md
         htLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741366445; x=1741971245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlOVy80+/7qrBzCMDwFKpqD0bd+BiJTGr7ikU6+BX0Q=;
        b=YcPWvRt5xvX8oQHgaeu+D3/OvrdHhe6zC9bObalRmubbcrjClGfuKFssSxOwspjCrp
         v7Q4f6G1+WiosjS61m0H1iTG5q5LP1oItjOu5dewfGQtzOwJr43cPlVYvAFg6tY7Z79T
         tbn+WN9ExnBgKMVehWxClmL9ditJNPIQ9VVy9IDPzwtjYbaiIOjNYoFBA6PJcSzBilOk
         /F0IqKBNlzPYGbAQN4TQMxML8JFNOtNy7o/wkhihkmf4O7MlrpHUNGYqDcX9rlnWbV4z
         118n8YbFp0Cwknz3JQijZ9qALNv+3EhIsjsztSWZ1FjePsw2Lali8w5Dobqf7WpbDS53
         2O6g==
X-Forwarded-Encrypted: i=1; AJvYcCXjpL16SkZ3REiAAV85dazKnYG8ocfiK/CbLMdFp+vEWNszDMaclkLHJA2vn9qyKniNaVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlG0dOuUrB2BtTuta6IYsKpbDwA9jPegOllTXHpg6WsFhnclt4
	Z6R7fguVyuNv/I1G1R8RsLdtftC4B+IjeuBgbMYKQzrqoyaMwpKVixJevEWDZV68dTbA5+P7MnF
	ITZOy40ybigBiogdXYL24Uzr9X4XbzTztxCg2FA==
X-Gm-Gg: ASbGncuMUzVAKFrCXORxo45fUOJL/vWllBTFE/ryJDaLWzWeWVFACSi/cTw06Uzvlep
	jwmo6h44Z4wpEGWFZiBxQrNjGJpVpI28Kus1ZUcRYFN0KEGYEbeofPIfE44+BVkg4z4k04on7yW
	xB8bInOtERDmMcBhEX+tnvWypcbsg=
X-Google-Smtp-Source: AGHT+IHRTcKrQA3L5FnqRlH3F7/q3LVNsjFPFTXeNsw+j0sxcXALOgBzlWln93E8cBUMbtMzN4PZeySxIZ4omkaMEbI=
X-Received: by 2002:a05:690c:7441:b0:6fd:385d:5f10 with SMTP id
 00721157ae682-6febf3b354bmr58319857b3.35.1741366445490; Fri, 07 Mar 2025
 08:54:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307153847.8530-1-emil@etsalapatis.com> <20250307153847.8530-2-emil@etsalapatis.com>
 <Z8sVxBI8B7oga-zL@slm.duckdns.org> <CABFh=a63-=TooZ1s56=HqbNRUO5fWT3-+FSbK9U39HRVzY0i=A@mail.gmail.com>
 <Z8sepWRKPbXvnMzf@slm.duckdns.org> <Z8seyEHwlT5mhi4n@slm.duckdns.org>
In-Reply-To: <Z8seyEHwlT5mhi4n@slm.duckdns.org>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 7 Mar 2025 11:53:54 -0500
X-Gm-Features: AQ5f1Jrhhss6rdkiS8SO1npdXxFzrZ5VNeC1JyHlPiWFnPk-Uh0hPsVu5reBINU
Message-ID: <CABFh=a5f0a1uEyd=QoG+Riks1QBOw01Rqr=jZ6wwzF3um+kCyQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] bpf: add kfunc for populating cpumask bits
To: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, yonghong.song@linux.dev, andrii@kernel.org, 
	Hou Tao <houtao@huaweicloud.com>, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 11:28=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Mar 07, 2025 at 06:28:21AM -1000, Tejun Heo wrote:
> > Hello,
> >
> > On Fri, Mar 07, 2025 at 11:18:46AM -0500, Emil Tsalapatis wrote:
> > > On Fri, Mar 7, 2025 at 10:50=E2=80=AFAM Tejun Heo <tj@kernel.org> wro=
te:
> > > >
> > > > On Fri, Mar 07, 2025 at 10:38:44AM -0500, Emil Tsalapatis wrote:
> > > > > Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF=
 memory.
> > > > >
> > > > > Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> > > > > Acked-by: Hou Tao <houtao1@huawei.com>
> > > >
> > > > Would a kfunc to transfer it in the other direction be useful too? =
If so,
> > > > how would that function be named?
> > > >
> > >
> > > We could add one, but it is not necessary because the BPF program can=
 do the
> > > copy itself by reading the struct cpumask e.g. like this:
> > >
> > > https://github.com/sched-ext/scx/blob/ecdba1f4d9d518bd6a58343cd303187=
155a39bf3/scheds/rust/scx_wd40/src/bpf/cpumask.bpf.c#L184
> >
> > Ah, right.
> >
> > > If we added a function going bpf_cpumask -> BPF would
> > > bpf_cpumask_into() work as a name?
> >
> > Yeah, was mostly thinking whether the _populate() name would look weird=
 if
> > we need something in the other direction. If we don't, the name is fine=
:
> >
> >  Acked-by: Tejun Heo <tj@kernel.org>
>
> Oops, you dropped the cc list. Can you restore the cc list and quote the
> whole exchange?
>

Ah sorry about that, I fat fingered the reply. Hopefully this properly
restores the thread in lore.kernel.org.

> Thanks.
>
> --
> tejun

