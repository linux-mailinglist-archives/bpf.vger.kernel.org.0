Return-Path: <bpf+bounces-33683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279C99249E7
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E921F2306A
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FF220127D;
	Tue,  2 Jul 2024 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmHS9e2a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B7148FF0;
	Tue,  2 Jul 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955446; cv=none; b=R4/xl/vPdccJz1K3qhlg0iX1DhsAsY15q/cvWEzuGF6U0HslHNma/6DTkCrC3p3TwScVYD1xPQlCWZ5eszR/rsVd4LxyO1beVG/wQgE17i5vtu5v460QOPE6jVKdF6OC6O6fkROvF4GfRdn2jiea8yvgtKHytSBfBe/9Gy4TH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955446; c=relaxed/simple;
	bh=R9xuYBV9v9qX0Vg50TywmOry6cS8bvfIIYme6jpoVS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiTg+SbpehtaIZeMttzXY7wfYIjctt/IoUuXkVIwAB1XUQ3LmNS6rT+Yz8ZVtcpWr61FgUuaUn3GoV3zn5q2cJJtaG4vbno16RncVyGpznnO5mKTxwywb8936J47QjXel4PepLNkNKSWR6kp4Enx9/KbeMzHnoKg0hQPW1S6O6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmHS9e2a; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-70df2135426so2659074a12.2;
        Tue, 02 Jul 2024 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955445; x=1720560245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9xuYBV9v9qX0Vg50TywmOry6cS8bvfIIYme6jpoVS4=;
        b=TmHS9e2acyNTyc4BWvNVNPnUWt68UnWKp7HMzLNGrVvVpvFLrhMMIelJzfft0OhYoC
         2Lhzl7g1Xtjc6Ukv6NIonGjfBmne4lB9NzZi5EZsm6gaCtF5pP1IkgmNyR40tFZw9l8L
         M048l7GiCExTm0uJscsZ6PyWR2Rm3AK72gvHtQXis71N21DvO5IS/dqBQ5HlF/PdBTZA
         0rfejCix9oK5rP4q3Qxi/92TFTZRJJGMpvXYFNWolz+KVHRBCbbzrs0yWTYM1b91ywIv
         LHDhywDf9LJPz7aMQe80vAHhIgj5FdSz9/GMlKZhgKyo/k2ukiRp/w4R1mZ+iGJExV5m
         tqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955445; x=1720560245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9xuYBV9v9qX0Vg50TywmOry6cS8bvfIIYme6jpoVS4=;
        b=Bw1f2k0VLZXHi6kAw1jHRHEBMjY9r3o4RE15ga/s5AaEDd5dRaARQ2qfKnbnspZj7Z
         X7i7Yt8jYIZV6rH9N+/t2VtDCaZ5T1bPZjwHnXoUDocyhgJ5kL1kz2Y+pBjim4w8kq4D
         NyEnpxLR52UFJxNVcZo1OUej68loVe2RaD4rYA6TewMUUI+4TNzXIy+d94wqeWDfpC/O
         b+rH2gR4d8fbVCX8VV5g+ntywIZU74ydUJvmboEo9vViLklIDDkLOKu+NUUHkuZa5Qbj
         6sUS4Sp1J6YfsAtg2phuF+gCeSes1G869JvNeOIgJ8ZFiw22yQ/wowzgZMGq9axocHIh
         5RqA==
X-Forwarded-Encrypted: i=1; AJvYcCUbaVnXkUHZBJnwcnKosV46mzeX05/VHGBjio7BpF1mtXXjhwq9MeDY/x1wvpD9uvi0Hx1GQOmsTx0gsc4Hu2DD6eafcvURJUI9YGDJqXpDYcIdaTI6FmPPvTdIA9ndTGKCmW9ZCzHO
X-Gm-Message-State: AOJu0YwgN+oCcIheeu67YjOHHBMGzdgnv3PDhU7UKUrzI163TO3OiLc9
	jXdWyBP5uZ+cVPb/rRwQjo1FagE2Cdf2ZrhDCqZuKSzxbuXsj/I3XYVkEhCoWMHKVSvObOKfVJz
	AvnFdEKzjPImVOLivSZg+af5e/ak=
X-Google-Smtp-Source: AGHT+IEZdLK2woq80lIw83J0hxLEBTyc338C3fF2vRSGIXVE6m8lox7jlv/+IynCskcqdzvjdSrxwsduYewCLbVDkX4=
X-Received: by 2002:a05:6a20:a10f:b0:1bd:248d:990d with SMTP id
 adf61e73a8af0-1bef61034b4mr10223713637.25.1719955444703; Tue, 02 Jul 2024
 14:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-7-andrii@kernel.org>
 <20240627220449.0d2a12e24731e4764540f8aa@kernel.org> <CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
 <20240628152846.ddf192c426fc6ce155044da0@kernel.org> <CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
 <20240630083010.99ff77488ec62b38bcfeaa29@kernel.org> <CAEf4BzZh4ShURvqk-QxC5h1NpN0tjWMr1db+__gsCmr-suUNOQ@mail.gmail.com>
 <CAEf4BzbRQjK7nnR2nnw_hgYztPPxaSC6_qFTrdADy3yCki_wEA@mail.gmail.com>
 <20240702100151.509a9e45c04a9cfed0653e6f@kernel.org> <CAEf4BzYShpT2fZKv3yZYxZA0Ha9JQXC3YQyJsjGB+T-yLOKs+Q@mail.gmail.com>
 <20240703001905.4bc2699cf91b8101649a458a@kernel.org> <20240702125320.64ec588e@rorschach.local.home>
In-Reply-To: <20240702125320.64ec588e@rorschach.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:23:52 -0700
Message-ID: <CAEf4BzYmK=mE5VUViZ+AvON51jzp2szqv5=QwwpsuEjhc-M4Vw@mail.gmail.com>
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:53=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 3 Jul 2024 00:19:05 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > > BTW, is this (batched register/unregister APIs) something you'd like
> > > to use from the tracefs-based (or whatever it's called, I mean non-BP=
F
> > > ones) uprobes as well? Or there is just no way to even specify a batc=
h
> > > of uprobes? Just curious if you had any plans for this.
> >
> > No, because current tracefs dynamic event interface is not designed for
> > batched registration. I think we can expand it to pass wildcard symbols
> > (for kprobe and fprobe) or list of addresses (for uprobes) for uprobe.
> > Um, that maybe another good idea.
>
> I don't see why not. The wild cards were added to the kernel
> specifically for the tracefs interface (set_ftrace_filter).

Nice, I'd be happy to adjust batch API to work for that use case as
well (when we get there).

>
> -- Steve

