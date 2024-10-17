Return-Path: <bpf+bounces-42263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A49A1856
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE81B1C25513
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39A381B1;
	Thu, 17 Oct 2024 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4CF6VfZs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D081EEE6
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130533; cv=none; b=S7GyH5iNZSE7TZ18UqTKhnUkTurYcoiKulVJGrQVQljF4AYrwSlhjCKWVC73RwUOHBSSYWMZdkj1nTmJdVWsb/XAhU3/LhiTWCp/hrjXrMn0mu56gT2mebobsnJeekmGre4H+fT3AattsItM3FjPD7Qh/OIPyYb/cCbjzyN42xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130533; c=relaxed/simple;
	bh=3keh0drJK4A5IspIKmRy+fJb/NxoXe2holMkNt2ddy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvpgNA+oIzPm7kc2VIu6+8CVSL/0B4ehgShK2JQbFGRvD/jei0g0qkksNBYC1NMaY1j8Vc5Gnf2H1YeHE5JtROKcQ4qmtxyWI1hmKJcx6SOvUXrYEosDkns5/hr3iUjgA3T66CaKwGeC5SSplNH18Pt08C9hcfxppVXS7GXbJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4CF6VfZs; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so135665ab.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 19:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729130531; x=1729735331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3keh0drJK4A5IspIKmRy+fJb/NxoXe2holMkNt2ddy8=;
        b=4CF6VfZsmcVhs9FVWN7vQWsp0mAuwkJou1loNyaqadIKjIP9/MgIDTzEl48E24V1H2
         T0behTmA2D1etVjys8fra/K//eX3Fv8Ku+20xwgjKvWlUBY96m7rih/TCQ0ubwt85dbM
         z7i4Li6Z/u3Tz0uJewIkIpKQOrQDfRrC5xjn/e7ssVSLilBz6N2oDnvcJX4B1AH7WXR1
         k+QLkKnWHJAsBzp+ZKqwv6muKIqWyoKLMC50FaHZJHFrWVG1vsuYYg899HDCbgUcj/BP
         Yhro9Opl3N0u3Ap/lkz4robPdSblY/dYQCpuENpn5R672Gpl7QfJ06NXFj/tYnfViCiK
         oLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729130531; x=1729735331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3keh0drJK4A5IspIKmRy+fJb/NxoXe2holMkNt2ddy8=;
        b=D9tHcx7WdMqlTK7q2wqL9JuUBRXIsuyVU4S/2u9zWzJGmg+3Eq4nC0Ee4sbobdFv9e
         225h27u77FC+z2FU6fYDwy7TProHSBA8ZayxWXRhdKmWhTDHkqpitSBIo2R17xGpHpg+
         U8A4+KnqtCC0iiPJeFAa5SQxY5Rx8rslRLF2g5J37yH/p7uYua15sTlzK6AG3YXjb2+f
         v7Se5EFIflZrKj+ahY40hwDs4ulPefM00xjfkFPvicJ62fDbbjd1inVdNen0fzX6yCQl
         O64ZVApzuLXNpFdPg2UaGknL05nzeCIRuibBvkpkxioFNGb88mtDJ45yr2mChaGx/919
         r0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWp5MJsjC4V0zqm11GH8+TXnNVy9SxTDLpInmSCv35fZgPe/eHPt4LHjKvAoQ5f2xKQRu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqIzXnYwyFLa4WhcvlHS0KoBHasR2OFJVY7Sydm1/vQ50TD6A
	UCMDNAbFVMN4wu4tZsyh21lwqiMbdq8n3S/IjewfUdSmAnWYSsbXYoMXDbC1a2QuOYcZQGfC/5y
	ajo72VCEQiUM2S9aocxC49Ou30yYJA39GUzx6
X-Google-Smtp-Source: AGHT+IH5iPpq9np2Qf/cswLWKMwDXvm2L6Ui8ogR+LLbQ2zhopltvCLAK8nRlN0DajbqNCn5EW+t6Jy5Dar3BZzKulY=
X-Received: by 2002:a05:6e02:1b06:b0:3a3:a053:c0ad with SMTP id
 e9e14a558f8ab-3a3ea04e3e7mr1425915ab.25.1729130530610; Wed, 16 Oct 2024
 19:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-3-andrii@kernel.org>
 <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
In-Reply-To: <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Oct 2024 19:01:59 -0700
Message-ID: <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> > To increase mm->mm_lock_seq robustness, switch it from int to long, so
> > that it's a 64-bit counter on 64-bit systems and we can stop worrying
> > about it wrapping around in just ~4 billion iterations. Same goes for
> > VMA's matching vm_lock_seq, which is derived from mm_lock_seq.

vm_lock_seq does not need to be long but for consistency I guess that
makes sense. While at it, can you please change these seq counters to
be unsigned?
Also, did you check with pahole if the vm_area_struct layout change
pushes some members into a difference cacheline or creates new gaps?

> >
> > I didn't use __u64 outright to keep 32-bit architectures unaffected, bu=
t
> > if it seems important enough, I have nothing against using __u64.
> >
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

