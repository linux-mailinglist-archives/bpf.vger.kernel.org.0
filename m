Return-Path: <bpf+bounces-45640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C7C9D9DE4
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19973283120
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BAC1DE3D9;
	Tue, 26 Nov 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxItrClj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D11DAC8A;
	Tue, 26 Nov 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648417; cv=none; b=uGh6Ur+cMrlaK65yFWMFJmN1n9Q2yFL/O5Ex5ZIuR8SJGmnhMxtbEy+B7RcF/WSk03L/FLn/0sTtuXK5WeziSG4mduc0Sg1J9f8l1afklGOv+Hxl/m8ou2cSCNcyLx8+3nKeOqS/xuJlAXyYqdyBlzKlARkupldWqWw/BCy7x3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648417; c=relaxed/simple;
	bh=QCR/Vp+Xml9sdSSp1Q61LSN07q3Va3I/wbUhG9WAoZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3zU/U2jqIWlWO07AskNWYvO6JGpp0IZg+INniNkmlAcxrXSuKOZ+OmaNA5pL4LLtvJqPy+dPWVPmnubGFtY09uYTF1laIB9z5md9Fiv2yzoMd9exwku2lFAFcerDg38uN4qmwDFxyiwQBTDnw32g+gF2hzul6kNT0zzfSvxN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxItrClj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-212a3067b11so51269875ad.3;
        Tue, 26 Nov 2024 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732648415; x=1733253215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DVAOLhrbGi8jum3karNef7IcoBGxiL98ArEHqKf4PM=;
        b=KxItrCljDYSF15ZVeXlApSeij8tbaFsswj/A2fN3VwAKteEf6QwyZyHsS8V9z2STdr
         W1EBIf/6UqgNRUfd6hnctTtLAH0HTg8LbXqvkPw2t8qt6JIeKsxekrRA8ZOXTgQ87qRt
         R0yzoxA0d7qWptfHx64ml7Ca78JU4IGFt8Gr40Znequn2K8NcdaSG/cnB9DrsmBsaBfA
         jL44Vm4yKAMqfqph1G6H1Me4WFk2fbxHB7QX20uz8/BwdB/J/ym0L296eiuBzEeh2QDm
         gkO4ojdRRpYFuOlZ9zOUEOzVSndyw7wbeLkMh5bn+L8UcVfgNVXSpF62xiS7IL7q2Yol
         TMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732648415; x=1733253215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DVAOLhrbGi8jum3karNef7IcoBGxiL98ArEHqKf4PM=;
        b=tPfWz1mEAYaGC9OM3nGKX005ZW58EoA5LWu88i5Ygny+eiGo1Njc8LuDBQxd6HkVyO
         g4d09cVZrN3NmmlnvaIf6oWHewblPXJONJD7Z6xC29vR8aBb6/TiU26kr61uit3UJujM
         1+OcX1S7QcizHHZqVVzJz2mMU68Rm8vJjzOE7xbFkQm+uyLRIVzdVDp9mI9+UNrWyV5Z
         STHd5QMyMvmngTa+6ryynZj0cRLBIcF7p3ui4k5e3Ra7BWWsi5KqYHI/pcVIRCtU/tUJ
         W4ky5EuIyNKnq0t934HMjg6MF0u/bRgRXRetvW/GoJMaBEJTwupvfWWIRT+ok9gNKTm+
         ofqw==
X-Forwarded-Encrypted: i=1; AJvYcCVhMz4aubBjHxKVOBAtfTtEYAr0O+rk3Rdyq7yY0gvBNH3A9ApQh88UQu+QJGQxcJYS+gc=@vger.kernel.org, AJvYcCW06lZOmOpO1Esg4ofS7luA7ud0vfedKqwI7JIIpMgd8e2Hc4uaIY0DHFmqNhQzf9u9BXB3Nq1pF8RioGGA@vger.kernel.org, AJvYcCWeZqEQI2IjA7bHNodZSHbPSNzX44Xd3pmY1fleBHPluyGrh/RUu3UrQ7/TUMb8EITJMPgiKCFVmFcM93/hkXEt7fgt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+PQwQwkz5U95blknxsJTzuCrHuMpFe3cCqYsbbKlp/vgvDaq
	BBPWUNWdVv4m5Z3sfuyuYPBu7IOvEF1PqCmvrtE/wrL3RBPb5UC2g1QFjZ77JP/36SQyJdtzTjE
	Qf2YS0lPOqBUoFsIyxYgyGLKW21ThfA==
X-Gm-Gg: ASbGncvalYZDNozb4XLUIzBnZxcgzQj+HB3fdJiDE2viVw/XhUkxwiH+4ATm261Mmpz
	LjC52h2wzvEcPkNrEFD/nvoGL0XxKvpFq2UOB4FaG74C0Mkw=
X-Google-Smtp-Source: AGHT+IHfu+fT5zfF3DAnsl3ePjUgszCAqr2LVqByX7g1cOz4bYKIk1DFvz9urAi7eP5+0pFn014qIVRK/I1V0X28dj8=
X-Received: by 2002:a17:90b:4a11:b0:2ea:61de:3903 with SMTP id
 98e67ed59e1d1-2ee097bf2cfmr451311a91.27.1732648415376; Tue, 26 Nov 2024
 11:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241117114946.GD27667@noisy.programming.kicks-ass.net>
 <ZzsRfhGSYXVK0mst@J2N7QTR9R3> <CAEf4BzbXYrZLF+WGBvkSmKDCvVLuos-Ywx1xKqksdaYKySB-OQ@mail.gmail.com>
 <Zz95aiWM5cN6MDED@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Zz95aiWM5cN6MDED@J2N7QTR9R3.cambridge.arm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 11:13:22 -0800
Message-ID: <CAEf4BzZS_2w42Vxy6Cj89OXQqAOYdm+kbTX_VEjF-zL0HrZU9Q@mail.gmail.com>
Subject: Re: [RFC 00/11] uprobes: Add support to optimize usdt probes on x86_64
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 10:18=E2=80=AFAM Mark Rutland <mark.rutland@arm.com=
> wrote:
>
> On Mon, Nov 18, 2024 at 10:13:04PM -0800, Andrii Nakryiko wrote:
> > On Mon, Nov 18, 2024 at 2:06=E2=80=AFAM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > > Yep, on arm64 we definitely can't patch in branches reliably; using B=
RK
> > > (as we do today) is the only reliable option, and it *shouldn't* be
> > > slower than a syscall.
> > >
> > > Looking around, we have a different latent issue with uprobes on arm6=
4
> > > in that only certain instructions can be modified while being
> > > concurrently executed (in addition to the atomictiy of updating the
> >
> > What does this mean for the application in practical terms? Will it
> > crash? Or will there be some corruption? Just curious how this can
> > manifest.
>
> It can result in a variety of effects including crashes, corruption of
> memory, registers, issuing random syscalls, etc.
>
> The ARM ARM (ARM DDI 0487K.a [1]) says in section B2.2.5:
>
>   Concurrent modification and execution of instructions can lead to the
>   resulting instruction performing any behavior that can be achieved by
>   executing any sequence of instructions that can be executed from the
>   same Exception level [...]
>
> Which is to say basically anything might happen, except that this can't
> corrupt any state userspace cannot access, and cannot provide a
> mechanism to escalate privilege to a higher exception level.
>
> So that's potentially *very bad*, and we're just getting lucky that most
> implementations don't happen to do that for most instructions, though
> I'm fairly certain there are implementations out there which do exhibit
> this behaviour (and it gets more likely as implementations get more
> aggressive).
>

I see. I wonder if the fact that we do __replace_page() saves us here?
Either way, if that's a problem, it would be good for someone familiar
with ARM64 to try to address it. Ideally in a way that won't ruin the
multi-uprobe attachment speeds (i.e., not doing stop-the-world for
each of many uprobe locations to be attached, but rather do that once
for all uprobes).

> Mark.
>
> [1] https://developer.arm.com/documentation/ddi0487/ka/?lang=3Den

