Return-Path: <bpf+bounces-47166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D09F5C75
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 02:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C9D188220A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B43433D1;
	Wed, 18 Dec 2024 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8ipFaGh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D443595E;
	Wed, 18 Dec 2024 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734486813; cv=none; b=lawDKM7aCNZ2aalNxaq9oPlM3dPpgkO9Iy85tHcc/WRogJD59gTHXvqrUhzz+nx5a5zKYfJnToxjtT9A/JtYR+/Lk4XPbSYlA5T8u3ZWzoJFZHeD5J/Odp+zRE1FGthqUgpbnr/xnUM2DYxylYowqolkqTEMSZNm3B6VrdiCQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734486813; c=relaxed/simple;
	bh=0MacLhJZg+yxuaM39qxq8qliTrBFhVPj18GKi+i4MN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuDw9r5eIUVMrKXVMEm82dj3EHyKkyRRvmYCNyD1CQda6H75IIfZeF2w+0v9dz9+gSQ4yKPkEmt3rXkESTeHoDcrFSnYDVzmIpGTYLkjjIVaKqIdGgHw9mWjF31n7jVh7WGR2k56l0qTl49PGxXusk3id8vVe6iDtTyEQOqCK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8ipFaGh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382610c7116so3076327f8f.0;
        Tue, 17 Dec 2024 17:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734486810; x=1735091610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgDjO+XV404/R03Y6i6kekDFyN4MU8iyp3capm1FsOg=;
        b=M8ipFaGh+T4amPDziQ7kW6QmiIfIjbqdwjgjK7tuQg52TLSqxkLDEejGCz1n2L+GYI
         SHr6NI+oqF3HQ6aVUMRurukY+IGzgNayDdfSxOnbrzeIN7B3KRJ2yMQEg77UtinepZpC
         fR+8zSsHHFUY3R9DJcDiQALexXsEGMZJgQrGU3P2XmL0o2tbMQmuK+deegjyyF6nPkLv
         MvARkw8AGqMkv4rltzCh7T/pe3mKEWVKhQ6HgOUDBoYK/Dlt9BDqK6FXW36GGrMU6euL
         O8XfEnl61+gJt656vPRo5toeOGGEY9hpWUnyKeOq4F12lNmOfyutl3q6YRO8uUMiPV2/
         KC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734486810; x=1735091610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgDjO+XV404/R03Y6i6kekDFyN4MU8iyp3capm1FsOg=;
        b=oHXZHVml+W4D/IqlW2SQqaAnjSC3f5L3b81FtEwYCw5jApjjNhWMgc2m1Q99q8IdIu
         vl93Z0O0R4UBpGdcjwo+NMCLZaYpyvI4Toqpz6KCtP0mpBfwH9+yK+MVWag7ybfeRJrP
         xLZjSylUUyf6yl1yDAecjH62cjaJj+Msfn0Eg7H/fe1AGn9hzYRsr4RLZ69jAzDVr6H/
         fkToRwFPPPnxT/+SHL3DQZpTMWepYjyii9Xzu2rNUDCgJWNP1pm2UW/ZDdpBzU3FLodF
         mu3yx9LTLNrHlNSqBHjOiO00b1CMt+C83lQyYAyW2+xlExx8rPO8+rZb4A04vzhCeyOX
         BtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFU+GxqkhkhCLVp0sY8ZoMo3W+a7qJzin9y2iC+Cs3vA7WeFDnu7sfns11ecgffFs4ZuTAwO5EC2q9DVHo@vger.kernel.org, AJvYcCVO8aFv/LKCxBM4UvliXj9EaBewn4tCy/JmaTcTFbRpi7Ft0PWybV0zQfNH5szwfriA8Rg=@vger.kernel.org, AJvYcCWn6Q3AFp3jvZ38zZLczXz7CVPv2yspqoeH/9wNTvSepIgJCDArVjX77gvEJr5ZykcamSTezkZp@vger.kernel.org, AJvYcCXoMl5GNfhx4aDCpSxDtfupym8aB0oEKvBHsn8gSn/bLK4FP0OriNijIbUmmpDY6tNTbJ4+0DQGFtL8OUKw0BQkPAWB@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyqHqURSpryDtiaCU4tAkuN2u0K5ZLw6NyXm7FO2sczssrMEh
	SetgpbBqWIKoBzMuMJwvUMBPS+NGfx30cXn3whkGecfQkxhq50pyEVo355fUC2la4zWXBt9KRIH
	FSoMX6djwsW43mRv3a6M2tUAB0Tm7KNQa
X-Gm-Gg: ASbGnctxa5OgVO+ETF3xvkzsqxrdWevDqPUFyY4p2GzwuShBGNF6BkjebXufJw2nDMe
	qK+B+W1v/QglIy1WoI28N4Oab0nRN+PAHOZRZEMeRLvch9C7eEEw3Lg==
X-Google-Smtp-Source: AGHT+IFPLIbZGLYJu/sw8hnvYfZMGnbwgLG1qK2C+0pIE0AN5HmsPsP9g9u6miggaPkcut2TC8I8cnhJvemJfwkq+oo=
X-Received: by 2002:a5d:5f4d:0:b0:388:caf4:e909 with SMTP id
 ffacd0b85a97d-388e4d56a4amr824122f8f.25.1734486810198; Tue, 17 Dec 2024
 17:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home> <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
 <20241217175301.03d25799@gandalf.local.home> <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
 <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com>
 <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com> <CAHk-=wjOr6tJ2TsZg-gZkmNTLrDPcWWb1h-WsAo45AmV5KkJaw@mail.gmail.com>
In-Reply-To: <CAHk-=wjOr6tJ2TsZg-gZkmNTLrDPcWWb1h-WsAo45AmV5KkJaw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 17:53:19 -0800
Message-ID: <CAADnVQLwP6DsPCTu-xQ_q7S5ismAM_XvVOfG_EUSVQAqh64VzQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florent Revest <revest@google.com>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 5:39=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 17 Dec 2024 at 17:26, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Let me go separate that part out and maybe people can point out where
> > I've done something silly.
>
> Ok, that part I had actually already locally separated out better than
> some of my later patches in the series, so I sent it out as
>
>   https://lore.kernel.org/all/20241218013620.1679088-1-torvalds@linux-fou=
ndation.org/

lgtm.
Since bstr_printf() converts 1/2/4 to unsigned long long num
with a sign according to the format specifier it's good
from the calling convention perspective.
Doesn't matter here, but anyone passing 32-bit ints around
needs to be aware of odd riscv abi promotion rules.
x86-64 and arm64 zero extend 32-bit ints while riscv does sign
extension when s32 and u32 are passed.
Quote from the spec:
"In RV64, 32-bit types, such as int, are stored in integer registers
as proper sign extensions of their 32-bit values; that is, bits 63..31
are all equal. This restriction holds even for unsigned 32-bit types."

