Return-Path: <bpf+bounces-48027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EF5A032C6
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD113A1D89
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA8D1DF984;
	Mon,  6 Jan 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw2nPYDr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14F1D79BE;
	Mon,  6 Jan 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202835; cv=none; b=p76n9fWwryRzOFiA8suNNEv8MCmfbERZCHzmOolFsOt0DbvBNY81ptxy8QPoJqssL5zcP7Vw5iewUgDZqfnOYbhz53cio3VhXksuSYtp1G9cM71Tmd72EY3sKnfnW9MMku9xEWJMOVw8Yh+nlbzh1D+Rxok7YCMGAVc0tHreFAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202835; c=relaxed/simple;
	bh=4IunlP+3pR4NVpiWLK61PvzeiAJgexQAbsM/MsLgQLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erbKQkfK7lWqBUAs8tv9WlMfmJelkyr84lFl41DbugJBhuzCcPCIPH4eMDAed3WLsofHeZY2zEYrXr0IkNww5isZJDBrFYQp1PGUXFelpYTD01VVo5rEnJumh/VeQlIyGdFjGnGjfpgP581BLfO295cLA7YzY1CDBgFYOkNWULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw2nPYDr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e06af753so7468768f8f.2;
        Mon, 06 Jan 2025 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736202832; x=1736807632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIqcj4ndtF+eWjBdn5daQLscYntk+KLV28y4CxPxmBU=;
        b=cw2nPYDrozQninRHi0k33Qe/huAl/LtCqiMOPovOCMJMl2xdjgTvk/NmUtDRkARrv5
         Q+6kvtmuk1u8S1giHRR5LFNafBSv+IraV3xz3HL6qEMtjhPwusE3GDo2HpYgrbhsnb46
         FPcsahGil4BV+K3tg5GyleAizNEdxM83CQRQOQLClazNP0A4LRh3NCXdPJFvlFxbmPT2
         sax9EXYwG1IPEN1dBU817E/gaY0oWIEDhwMuO4hbnJS2h5h1zFD30TaQvusKCM0lVaW3
         O472N7A/MPDVfnFYUoJujwdKN3lx8Y4Oiq5qYNCeX9J3ULLX9mr9n9hnhiwUpW/hSvZd
         5JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202832; x=1736807632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIqcj4ndtF+eWjBdn5daQLscYntk+KLV28y4CxPxmBU=;
        b=JAYXJrbCa+kFJm5pdq5hwlqETF9J6FpqHggiBBB7PQ0HTKwNWUGGIMi8o3mSMxUMjP
         ygBSIo+62Lkml0ocLihmByXgodWTGchS4USoC1dLHhG+yI6Okj0dmcsZXonFVWShBuJf
         aUrG7gPHNudiKEeYzfJ2Fhkm9IBCXF92bTTBzUfOyPkpzkpYCYWeP3Ydqo1iCZSUZQrI
         BZ9AfOkm9ze3HouRlF49grfyWFmfmsZM8RTiZMHI4m/ZNytbWjUPjfmm/2a3X1Z+SNa+
         yHnIFXG17mD1yFmZ8khUNMmg5an3o0WEqGqpYt64CqctEDiIOJjh80z1qN1Uvonxf0eZ
         l9pA==
X-Forwarded-Encrypted: i=1; AJvYcCVZwyWOlF6vibhQ7hqCMHjKAX6pTEKALqIM7I5LOjn9L+ybFM7I965pL7Ttxih/eGmkwkg=@vger.kernel.org, AJvYcCWa+Bnx4wSQ+jtP7fRgVCRHmpheh79WrrgGaLygwXKERlXCrf1kk6XAOz0ZXZ9nG+/6PKmqALIi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97GqeZGN457fRYeMvsceTMbXT8TrOk5OGztoUuAfuDw9wn5s7
	H3dAiT8DK8y8yQH3BWDUOuJvmITd9tBrLUiO+jneAVt7ZN0XJ079I/i8tShTobkh4BZ09Tkm/y2
	2Pp3oafFMxJ7mt+u4Em8TEUxadWLjDA==
X-Gm-Gg: ASbGnct376BrE6BQUHjydQTTVsc6oHgAc7xq/c1vNxwRpKhLD+uuWK7eSQVFJx/q9CT
	/SBL7Ph81NnJZvbfK1BTOzWJbDVixmFOzUw3EUA==
X-Google-Smtp-Source: AGHT+IE1TDZtv0U1oLEJwh1jLdP8vq3j7EUOCPigPznN17STIlUEE5HIUTMgrD5tdnLwT1ea3pfA0UnPFAnAQ7JkhyU=
X-Received: by 2002:a05:6000:2c2:b0:385:e30a:394b with SMTP id
 ffacd0b85a97d-38a221ea33cmr45725633f8f.16.1736202831567; Mon, 06 Jan 2025
 14:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105124403.991-1-laoar.shao@gmail.com> <20250105124403.991-2-laoar.shao@gmail.com>
 <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com> <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com>
In-Reply-To: <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Jan 2025 14:33:40 -0800
X-Gm-Features: AbW1kvaolV3tZNOByuTwrw7DAsSkRTOpx9NLBwM_P78qasl9JYvZqji33MXQ5TQ
Message-ID: <CAADnVQ+Cbq99wpNoijyJbvtqaMTAxQF_S-n8yf9+0JGHJnShLw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic tracepoint
To: Yafang Shao <laoar.shao@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 6:32=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Mon, Jan 6, 2025 at 8:16=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Jan 5, 2025 at 4:44=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > Dynamic tracepoints can be created using debugfs. For example:
> > >
> > >    echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/kp=
robe_events
> > >
> > > This command creates a new tracepoint under debugfs:
> > >
> > >   $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
> > >   enable  filter  format  hist  id  trigger
> > >
> > > Although this dynamic tracepoint appears as a tracepoint, it is inter=
nally
> > > implemented as a kprobe. However, it must be attached as a tracepoint=
 to
> > > function correctly in certain contexts.
> >
> > Nack.
> > There are multiple mechanisms to create kprobe/tp via text interfaces.
> > We're not going to mix them with the programmatic libbpf api.
>
> It appears that bpftrace still lacks support for adding a kprobe/tp
> and then attaching to it directly. Is that correct?

what do you mean?
bpftrace supports both kprobe attaching and tp too.

> What do you think about introducing this mechanism into bpftrace? With
> such a feature, we could easily attach to inlined kernel functions
> using bpftrace.

Attaching to inlined funcs also sort-of works. It relies on dwarf,
and there is work in progress to add a special section to vmlinux
to annotate inlined sites, so it can work without dwarf.

