Return-Path: <bpf+bounces-39558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360AC97477D
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 02:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689E01C255DE
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC054125DB;
	Wed, 11 Sep 2024 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI9KT42/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628FCA62;
	Wed, 11 Sep 2024 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015468; cv=none; b=mjS9qw4g1fHuwWcjXXsMX8dag8yueQqvBh9CxCVWeFtmkvgAomUMRPitk8jFXwQf7ixr4b+P89D3vRnV6SFEIM088NzCjcxLlXJ5x5nDQ9jipvFf60tUho5gV1XhwpBvE2g1LAA3Ny6OoSOcSiwfniNmIDhwJT6dpvUvjkYg04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015468; c=relaxed/simple;
	bh=FcTDMieK61+L94Iv3lWs3uGBZiqaLqFbGjthUE0jfuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gck/6Uc0+TWML/La2f154tRn3r7ry0uopEvT2juxIMYYIUopbMU8FojQX3g/Yo3l8CZLdqkmW9hi5oyqRJFTid6frVFvjqkZ0D9SKdgJAswmswm7tYXJ1jUQxwT17RUqtCPE4C1/eK5pO4dMK2m5Ocz3v/+oqBD4MyQqTLQtvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI9KT42/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8a4bad409so4246995a91.0;
        Tue, 10 Sep 2024 17:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726015466; x=1726620266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haJk1tz8+Zb+6ojTw7BhoTCfZ+DeE2XVR4RtK09O8WE=;
        b=MI9KT42/JjBlMyScu95akN3lUluyUilSPhItl6hIEb9uzMRp5bz7Tw4N0SVzQ2B3V/
         LCmNhos0FVOp36/7DmWo8+2orDeGcxpmx+sN0P3D1MsI8/V9iZ0co5A/gvhappwYt2Uj
         d9QU9xdvYqahfv+y6LtFIyLW1VI/zrMic4raEanlFXPxChjJu4a8LRwGVeRq2+60/k/H
         QLXw35m9zKqnamuu/xGmTTNY944d6pBIC0GPUhqSUJh5+JP/AKikx2bEs8zYWHMQETqa
         3NvjUXnMTzVyHbp+QTHc+C/SG5uPw2jC/wA/5+2F9k0OEcNqQb1Pg9lrVj6r+S+OuYjm
         zJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726015466; x=1726620266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haJk1tz8+Zb+6ojTw7BhoTCfZ+DeE2XVR4RtK09O8WE=;
        b=GU8CD7/Grr/WRtMk6323JQS+bgSvVPcjXXwet/1cJDnSB3zAm5tpi+sxy6zunTGqEs
         V5aHEOlHsM52ie18sQyvL7v9dJiakNyLM1R9KoDAHl2KyNpUNPoZ6SBrO47qsBRHPwND
         WDMd/SCN2q1gogB0iKTJA4k/VnTvKft8u5kQLmPzBzmkacdaaNVL1MAMIPtVPgPmYanV
         G4111EqQfWp+pp36/HpvhoV9KFipUOIYQwHLwzPlnLmO+RoIYwyuM3rRfR0GK3uMljW0
         TNAd1LljvZeE43zxi6Hn6afiIMWAnwnRl4M3sotnDL1ErmVNM0Zf0gE2p4eF9gXA8Sxg
         Xv8A==
X-Forwarded-Encrypted: i=1; AJvYcCVlrfRJDd+S6bf18yYYX8hq5UlZG1g0Ux8A8/YTamplB86djPncQ0RwwdKfvHwBcvyUv+VvsxXjQC3/3OBY2ZQ/GDBU@vger.kernel.org, AJvYcCXEXtFhyzmeKW5PJ7tfIvtPkQSj5/PydDp9Tsc8RTpRlSCcN1d/UF2BqcTg5H1l1aqDfI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAcDuqt2ZF3+Lw0vy1BQUerF0s5dUjubXIuk4ibX+/108E/Ed
	FTnWJNjdnvjpyxK1h/9AA7v397PStFuNwKYeQ3RP5UZpv+oB8ZOXqPFZJCqf+W+O8gL8nEEUbJ0
	BZT4clXFmDCSqcdXkuXFX34A82Jc=
X-Google-Smtp-Source: AGHT+IEbcl34fe0St6atUp2AGhE70G/pITb9zBr/6Q5f1xxWHHvaYtRh1SIgkeo8YXSIwi0tvQtmOquHgR49J3wTaHw=
X-Received: by 2002:a17:90a:8d07:b0:2d8:8f24:bd88 with SMTP id
 98e67ed59e1d1-2dad50d25cfmr15469204a91.14.1726015466005; Tue, 10 Sep 2024
 17:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
 <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
 <20240910145431.20e9d2e5@gandalf.local.home> <CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
 <20240911093949.40e65804d0e517a1fa1cba11@kernel.org>
In-Reply-To: <20240911093949.40e65804d0e517a1fa1cba11@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 17:44:11 -0700
Message-ID: <CAEf4BzY2_HN36Lvy9p2s57tGet3ft_1oT6d690vwu4JMgOd9XA@mail.gmail.com>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Florent Revest <revest@chromium.org>, 
	Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:39=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 10 Sep 2024 13:29:57 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > You are probably talking about [0]. But I was asking about [1], i.e.,
> > adding HAVE_RETHOOK support to ARM64. Despite all your emotions above,
> > can I still get a meaningful answer as for why that wasn't landed and
> > what prevents it from landing right now before Masami's 20-patch
> > series lands?
>
> As I replied to your last email, Mark discovered that [1] is incorrect.
>  From the bpf perspective, it may be fine that struct pt_regs is missing
>  some architecture-specific registers, but from an API perspective,
>  it is a problem.
>
> Actually kretprobes on arm64 still does not do it correctly, but I also
> know most of users does not care. So currently I keep it as it is. But
> after fixing this issue on fprobe. I would like to update kretprobe so
> that it will use sw-breakpoint to handle it. It will increase the overhea=
d
> of kretprobe, but it should be replaced by fprobe at that moment.

Ok, given kretprobes already have this issue, can we add this support
for BPF multi-kprobe/kretprobe only? We can have an extra Kconfig
option or whatever necessary. It's sad that we don't have entire
feature just because a few registers can't be set (and I bet no BPF
users ever reads those registers from pt_regs). It's not the first,
nor last case where pt_regs isn't complete (e.g., tracepoints set only
a few fields in pt_regs, the rest are zero; and that's fine).

>
> Thank you,
>
> >
> >   [0] https://lore.kernel.org/linux-trace-kernel/172398527264.293426.20=
50093948411376857.stgit@devnote2/
> >   [1] https://lore.kernel.org/bpf/164338038439.2429999.1756484362540093=
1820.stgit@devnote2/
> >
> > >
> > > Again, just letting you know.
> > >
> > > -- Steve
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

