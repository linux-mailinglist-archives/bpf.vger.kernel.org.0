Return-Path: <bpf+bounces-23129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1D86DCE8
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 09:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5E2B26BDE
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559E69DEF;
	Fri,  1 Mar 2024 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKoAwdBd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82269D3D
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281114; cv=none; b=rNMOy2gCGo7C3UQvwUKnNCVf+2Nd3KAlkvOo2lWX5lyJZ/45bUIlH6qGTk88FB//7ShvLsiqKo5EjXTihyqHndQyGVSg1LQQYP+CkEyy/ibsq83orJ3LoKxaX299rHebMj9O+nELpIDfM2OfNl4qfM0JLUgXEO/Y6+KjikG4OIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281114; c=relaxed/simple;
	bh=Ghq4UAbCg10W3fP+ERlHjjPNG8qCm6kZUfbrQ+aiVy0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIF5Guv3YqK0ijYy3f9YtbdNRujHCCe0oT4++JBMaFWSsowyab7so1xuDkGO5dOfK7e/OM/Po/5i/cp82gPZCAMjRzY4y2xuWzzc7ZWFnqjx/IgKr9cx0ONqkaihiYGXf2TkDxFXLJEfOFsxfhPhT8ZBR+4svhHp9yh7lnFXwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKoAwdBd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a43fc42e697so252356066b.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709281110; x=1709885910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4N7iC6zK4AXBAZBQwklli9tGGcmWG8ahkikLWt4GnvM=;
        b=HKoAwdBdxqyaqfSCcks5PzPa6UBlw6A4pusbxBYmR9tZzbQqlFrK93UotvE6r7BTNW
         AB+zBjCPJ/k4iLrW0pDwRgFxG+shBpDaZX70jCEYaXrI/JyDy0sAtjRIlKcuoPY4EoXI
         mZydztRgTKqnLoK0eE8g2vFEhRF+1/l/8w1qxR+LNlEOy75t4B8zzpqUcbPZ5CeX3hnR
         dPC0pXBrWQopjaUcA65DlGwxV2xVthE++ZrMATP7srToyBpj7iuZceiWlvBqVcybvklT
         VWV2XiwKmlywzx+XNw3n/kCGeyH8mGp0n3aDUITEjvTa5RlLAquOBdtVqEG7xgfStV+E
         MvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281110; x=1709885910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4N7iC6zK4AXBAZBQwklli9tGGcmWG8ahkikLWt4GnvM=;
        b=DjnJVrd9CWlf3k9caqgTzEKwkS8yFHaLLfENWbUEdZ7w9Ys84XKctOg2vMZaqKEyNK
         qJk0RpyJ1ejLMAfVjbZidYbM4CnmmIAMjy5cyVXywGbwqPSvvYnpBxSSvnRT22rFIiZ4
         H3W+e/HO/mqYdEzSy5NFN48ux4o9PaWj1bFESWo4DtH0OL9uT4Hwu6REzoJrIJiIekdY
         F3ZHXAmNjRqBag5iccLOvSM9bPokqMituiaoJ/6MC1KIedqyHlYAqY/OmLymcClV/wau
         E3xQDrtidFufbO8lZrKt9Bnxrq6ojnC/hpd0gYrufwpVlE/OVprFkvDk28GId8wlMmZu
         +vPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL7HOYvmUYVZnJNK2KCvfDyDJgmAxhU+G5CTA7J4bRlV7tstptRQxJTWypLFs20LYUeFkVFUY2T2TCgNYQBxqBQCKx
X-Gm-Message-State: AOJu0Yx3luJKCbfOSZdq3bTaymaiNj7GDycOjKYCpxb5ayW/Mgk/g7XL
	dbzsLsuBGzI7Y+bEYoqudUo1Uz8eKnawsgjICqSo1Rj+Yr1JKDue
X-Google-Smtp-Source: AGHT+IH28mWHZ4Olb9N2UR3/VUXI19y0hXt7NXy3GeTsDkrreVRtbFc64q2+zYp5RKMArSag6ayeoA==
X-Received: by 2002:a17:906:f8d2:b0:a43:793b:5b05 with SMTP id lh18-20020a170906f8d200b00a43793b5b05mr721973ejb.60.1709281110108;
        Fri, 01 Mar 2024 00:18:30 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i2-20020a1709064ec200b00a3eb1b1896bsm1464134ejv.58.2024.03.01.00.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:18:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Mar 2024 09:18:27 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <ZeGPU8FRqwNuUJwd@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>

On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 29, 2024 at 6:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > One of uprobe pain points is having slow execution that involves
> > two traps in worst case scenario or single trap if the original
> > instruction can be emulated. For return uprobes there's one extra
> > trap on top of that.
> >
> > My current idea on how to make this faster is to follow the optimized
> > kprobes and replace the normal uprobe trap instruction with jump to
> > user space trampoline that:
> >
> >   - executes syscall to call uprobe consumers callbacks
> 
> Did you get a chance to measure relative performance of syscall vs
> int3 interrupt handling? If not, do you think you'll be able to get
> some numbers by the time the conference starts? This should inform the
> decision whether it even makes sense to go through all the trouble.

right, will do that

jirka

> 
> >   - executes original instructions
> >   - jumps back to continue with the original code
> >
> > There are of course corner cases where above will have trouble or
> > won't work completely, like:
> >
> >   - executing original instructions in the trampoline is tricky wrt
> >     rip relative addressing
> >
> >   - some instructions we can't move to trampoline at all
> >
> >   - the uprobe address is on page boundary so the jump instruction to
> >     trampoline would span across 2 pages, hence the page replace won't
> >     be atomic, which might cause issues
> >
> >   - ... ? many others I'm sure
> >
> > Still with all the limitations I think we could be able to speed up
> > some amount of the uprobes, which seems worth doing.
> >
> > I'd like to have the discussion on the topic and get some agreement
> > or directions on how this should be done.

