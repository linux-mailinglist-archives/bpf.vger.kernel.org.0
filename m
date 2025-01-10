Return-Path: <bpf+bounces-48610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188DA09EE2
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2B33A1A41
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9991C223337;
	Fri, 10 Jan 2025 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6BOgtlH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5C21D5A6
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553354; cv=none; b=ZytTl6mNKMcZpgo033T3GvFmOKWfvarzPeZkyNdrTebji1dKFWpm7CF8Thusj+JQ74z/Q0GTYSo7Wrewcy/kgSB/+mpDTrsEuaeew5ApAqwpvmUOO6a5XqY12MR1nOXwkiCmBLACUKCoUvlrXEshFt0ICWs/lPs9aCurUxSBzjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553354; c=relaxed/simple;
	bh=ioQKeFDzb/+MUMb4xKiQ1a6pidlMBS2076l3PmKk4y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmOLtTPWWMjLWu+WIBh7KjxdbA+ubvFQi5sGeyoLyF5+Hwo920o5e4rKonoun8GvKEfiBMJGMNo05jHJFQuIgr3L56K+CVDQhY9ZmeHJ0wE5ysZFz4nVna3LSzzmHi6V/34EPumngP55K7gYOW5vKpmttymofFX0vWqDXG6Il88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6BOgtlH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f441904a42so4512934a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 15:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736553352; x=1737158152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzgDf3gv1Ffpl96Ku1GwHQVduv+X7hxjrDqo/dOiwwc=;
        b=Q6BOgtlHv/rv4ax9DOvDf71YKvz8IIggWZ31ohqBNaq05OasRmbk1yzY9ZGb/PjQbs
         PXe/7F881c6JdWGrq0myYF5g6WC1LfcIVFDEvwhrFdD1fduAUiOqRUy/pJQUCB4GzoKQ
         OYYfKUTkFpnjxdSG5jA2ltiS5u3SSdqI29xuUa38dd8KvNIRLaipJ0KBPGXwdAim0ZoM
         ZmJP+JYIzyz37p6Ip5OLSwRc1Qj3hDteR2TTdYW0w41V3VCjs4PjrILKMbHalNlI8Abl
         1Co9j7iEHTjDSKOQw+1iPU6J7gx9HDHDoZUy24JV93xybrco+dqMW9ajPkme/PwuAMu+
         3Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736553352; x=1737158152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzgDf3gv1Ffpl96Ku1GwHQVduv+X7hxjrDqo/dOiwwc=;
        b=XryC4b7IDcdSjOktacRKXBF2I9aw0Kq3VU61XFoZMxulid2G/NatBWtqTzlAm47/dd
         2R1MJE8GDpJwLjpTk+livxhzcs2kFtvm5ecKoMChjMiN38Qkh1WPXL2gJeH8efcftCRA
         XJT9gMKvNqR0LQIKeTXJdL4dEAhbDw8bEMvplQij30qbFKV6NEZHWM/s/CvobLjHklOb
         ROJcEo84uRSwdmTkLE31nSl6GGLJBgnhTqkGRnk5Jeu2e/hQNjAmV4wYuxggbKqXyj2X
         f5Gcwqe/TQpxmHWN2sH1r8jSqQ5dtofG7kxPUJ55vE9D3XUN7FBL//K2on3BUVpo4Q+L
         sjpw==
X-Gm-Message-State: AOJu0YxBXvSVpn/ve4or8d5h1aHTqzws2B8gD/A5IvTaXhDl6LC0rAdl
	zEgOs0retp/cqfUOU7NLzVucuhBa0sqXixFYwoVsFvjqHJvoWfK8LiO7ZX+SnHOJFFV3SASqQmG
	g4atYEGQiwKP7ls7CNf6dqjs8V48=
X-Gm-Gg: ASbGncuq9Km1cgei5lneiPLQw4PT4ojU2Xe+FXDEKEvfdUbi12/C6YhWk0E/HzokUeX
	r8EbwYc6EW42macJBFTQ7sJpYsP9ZEJInaZJl1tJmTnwVKvZ3926hdA==
X-Google-Smtp-Source: AGHT+IH/T+A4IKxP323omvnkaK/xgJijCzZwsLyhRImimjxG5JOdB89sqLFg2U2xnkXiBRxr91rFSPfG3MOBZT4pZYs=
X-Received: by 2002:a17:90b:280a:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2f548f2ecb6mr19183869a91.9.1736553351955; Fri, 10 Jan 2025
 15:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107235813.2964472-1-ihor.solodrai@pm.me> <CAEf4BzZ_2=CquVPBD-WgzkfSk5UAqyp1SOeZHTfD+OsVRiKPhw@mail.gmail.com>
 <aQ6AOJh7xmPLqca9GMQahFPCLjiCkrlDBEMh0UBm-zX4ngEkwJaDJv55lrwMRBuwaf_yrGH3LpKqBXl86kbdRIJLUcKZCUxKAx4uCBsxBeQ=@pm.me>
In-Reply-To: <aQ6AOJh7xmPLqca9GMQahFPCLjiCkrlDBEMh0UBm-zX4ngEkwJaDJv55lrwMRBuwaf_yrGH3LpKqBXl86kbdRIJLUcKZCUxKAx4uCBsxBeQ=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 15:55:40 -0800
X-Gm-Features: AbW1kvaJu1Keou1U-AnRTrhj4MlQ1LqZifI_heb0anYkJLl6b-FGT7IdYgJ9kkU
Message-ID: <CAEf4BzZ2U=+=8ePb7b=VTuwTPBSeJYsUa0WdR4PCKXHgHzgPyA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: add -std=gnu11 to BPF_CFLAGS and CFLAGS
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:44=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> On Friday, January 10th, 2025 at 3:34 PM, Andrii Nakryiko <andrii.nakryik=
o@gmail.com> wrote:
>
> >
> >
> > On Tue, Jan 7, 2025 at 3:58=E2=80=AFPM Ihor Solodrai ihor.solodrai@pm.m=
e wrote:
> >
> > > Latest versions of GCC BPF use C23 standard by default. This causes
> > > compilation errors in vmlinux.h due to bool types declarations.
> >
> >
> > Do you have an example of an error? Why can't we fix that to work with =
C23?
>
> See a thread here: https://lore.kernel.org/bpf/ZryncitpWOFICUSCu4HLsMIZ7z=
OuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLott=
eNbQ9I=3D@pm.me/
>

Yeah, thanks, still catching up, just got to that thread and saw the
discussion. What a mess, I'll pretend I don't know about this. :)

> The one I ran into is about:
>
>     enum {
>         false =3D 0,
>         true =3D 1,
>     };
>
> Which is illegal in C23, because true and false are reserved words.
>
> >
> > [...]

