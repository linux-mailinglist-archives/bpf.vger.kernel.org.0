Return-Path: <bpf+bounces-68401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DDB581B6
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEA83BEDD9
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6E25BEE7;
	Mon, 15 Sep 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsE1hAeT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9702216E24
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952636; cv=none; b=V9MKYAeC/NZjEh7ef7zT4tdKGcvPXLnyalQcFRE/HajYra6E9r8Axo1hgRgRHU8c8xn6tdvlY6cvigK5yqs/ZnaS7VJ9RQvAhBbxi/6Ct8qYa6sJhwAMkVm4IshjJ9vr+tvxU1z8J6RyMGxxgU0iBt0JaV3HtgOKadeegZEX7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952636; c=relaxed/simple;
	bh=rjz8iKR3I1D8YttjR9aDeU6w+r928KFXI8axrjgY91c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRAWjrFLJUP+Uj4aBI8hP2CIyQ/9PbL6GvDlqjPUjW3y81tB+oKdSVnyyB3501aHNSfzQQpdYdAIA1N66kg8C9WHs1R8F0JFHgvXr1JkhZiPejAwtRb9ckK2SdlxCiiMXH85pidnt5Yb8sjnqmWA58uOeXfoel1kwM1sp1H8q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsE1hAeT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3dae49b117bso3398562f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757952633; x=1758557433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjz8iKR3I1D8YttjR9aDeU6w+r928KFXI8axrjgY91c=;
        b=NsE1hAeTrjuKai6m2uLhPbRwla+kaNOPMC1JcBW/Jn4xQ8wz+KIFqbYZ2AyIBXMLGb
         /3rzWQmOetRrh1uP0URiTijjme1uocymPlQNfV7hC5xaRBrGuVIrG+zToDyst42vHxkl
         CRyX5Tm35tx23O8EceZRVRXBfAU6DR1ncf7Lex6kcxTlKoR+Oua22vW1iX7moQeZdqbJ
         F6pghxfcwinKbP1PQjbgPWLphn6CUJMBj7wKyrjblUep6Z0kz1FL+mGx0KspBsdnt2uQ
         BlSSy4xkj84XZGBRxpyuKGoeow7Vb1DIMgR36/1NjKL0QhoSO1wzYokMhYv2SfA7B/PE
         4Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952633; x=1758557433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjz8iKR3I1D8YttjR9aDeU6w+r928KFXI8axrjgY91c=;
        b=j9tye5e4VBLqNdKymBE1jP+1jwzXkCxoIvpbU7eO8Ao6MEZkv22LmpizNXNrYuVhVw
         d0oR9PJ+Q6cJSVtC92+6jb39mKtatqfXzqpc8UNN7NDuz9CUG0CHBhcilwQTYWanA1x4
         LcOj81AbtBdUMWOtGTEFX9SjrB0G7vyNHCwPlImNwnKqc6ygloYDoecMAK+7OM0XRHCb
         D7F9oHWdXFz7ltHVTCe2Vmc4M6PcKqBQfjEFsMNqjH7bGpIaBYaAWiDAkLXN+1nJLcW1
         qi5yP161NVftXbLt1OsUT9IcN+K7dse7NwZYw2YR0ynMkE8j9GwyLUmocWCfLORbFGY5
         VpWg==
X-Forwarded-Encrypted: i=1; AJvYcCWAqvC7kkvKfHodzNUrFiD81yf7cVaus2XZuSkOihWGYPT+ltKPyKDlOFiYjH9xGarLtEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHp3Ylr0tbzR2XNZeL92Mier3lVIIe8a83Zz3vE/4/vnrHWSIs
	CS5kVLxAc+WPJz1Q5MJ6g14U/8utTqOjuvvYyV0oEj0HqxnSYVXWcnJbMr5gegp43jZE8WkvmPE
	Wy28d/mjPdVtar5Cn2CAqbcMdb0rw+tQ=
X-Gm-Gg: ASbGncsd+eKq4x8JbC+sMizN89b94jqSef7bh0WyXHxRKtEjLX9/XSrJ+OBPG0s3ATH
	SuTJPpUSRcdvGRojtkYN7dNDWWcdC8vQgup2g2QU29Rt8ARcqvDTkg2IqfqlLDe1ER7i3eNAbR5
	MnZUUiSwKGWO7J6OGnY5b0CcrwrHfy0mP4+lrlBFJ1AQuYVdhhYjssPpuaTdUuToY3Wyri1rJ6Z
	BiWmVvZ0gMX/BB7g5KzCU856+3Vm/SyDLkY+dJeZ5Qq
X-Google-Smtp-Source: AGHT+IGnsvL0yRiQB5xiycw+g/hK+o/JYj0T/QnYlrFdOjniWDwapprP86JD3QohtGzJvv3HtrXuKRlJ3Kte6+OPoTg=
X-Received: by 2002:a05:6000:1841:b0:3ea:6680:8fa6 with SMTP id
 ffacd0b85a97d-3ea66809376mr3348310f8f.1.1757952632748; Mon, 15 Sep 2025
 09:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828060354.57846-1-menglong.dong@linux.dev> <5923659.DvuYhMxLoT@7940hx>
In-Reply-To: <5923659.DvuYhMxLoT@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Sep 2025 09:10:20 -0700
X-Gm-Features: AS18NWBLZW90wU0Q6ucizCkVWFSnM5VbW34SPqWQn5N4r4GYUTY7Cny6Q--rCsI
Message-ID: <CAADnVQJ5jR-koHsxdsizg_YqtDuhLzrKZzNJ=KNP8ZOYp0=ayw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] sched: make migrate_enable/migrate_disable inline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 6:50=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2025/8/28 14:03 Menglong Dong <menglong.dong@linux.dev> write:
> > In this series, we make migrate_enable/migrate_disable inline to obtain
> > better performance in some case.
> >
> > In the first patch, we add the macro "COMPILE_OFFSETS" to all the
> > asm-offset.c to avoid circular dependency in the 2nd patch.
> >
> > In the 2nd patch, we generate the offset of nr_pinned in "struct rq" wi=
th
> > rq-offsets.c, as the "struct rq" is defined internally and we need to
> > access the "nr_pinned" field in migrate_enable and migrate_disable. The=
n,
> > we move the definition of migrate_enable/migrate_disable from
> > kernel/sched/core.c to include/linux/sched.h.
> >
> > In the 3rd patch, we fix some typos in include/linux/preempt.h.
>
> Hi, everyone. Do we have any thoughts on this series?

Pls fix build errors and repost.

