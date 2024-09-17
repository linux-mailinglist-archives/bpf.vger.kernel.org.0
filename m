Return-Path: <bpf+bounces-40020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE697ACC5
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 10:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261861C2204D
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B415B103;
	Tue, 17 Sep 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvt8OWI7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81C154454;
	Tue, 17 Sep 2024 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561214; cv=none; b=PghvA2wJjqlklhiPx/jkfy4XaNI9YSswh/b8A8cHJ7X4RA4waxxV0obLBNNvSCgE+SR2M9azC9JhRK+8g1bGCE+yhSEdNWePjKriDcC3UGrgDjgwIaWAneriJYjkroX/XaQzlySAlMo9PhKmcJUpncOWX0w6UBj1cWlsT3GqYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561214; c=relaxed/simple;
	bh=m8MW2HrKG5QYTZJEo4ienELOMIdCuJwtNwQzR66o780=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTpAKwj2mVHKaDUWczYbXRMtv1LBLxUAgddbxWxyLBJ+VPwSyILfs1MKz6MOxykDm4vjvPmKVR3kXjVzKje7O+Bz2koqVf4KsBNP0YQc39JGbGD6aWYdGOGtLxmnT8oiIXARqGAwOh6bSR3bivPwmY67aqBCgiv9hrijNT5vb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvt8OWI7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068acc8a4fso38562075ad.1;
        Tue, 17 Sep 2024 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726561213; x=1727166013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8MW2HrKG5QYTZJEo4ienELOMIdCuJwtNwQzR66o780=;
        b=fvt8OWI7Hhlqqu/kF2VBsSqD8KLNw6gBzfmTlqvyrSJyFcPhj4QZQJ4xyOPO4+o8/W
         sMt25J/Nt6r48EjYEuxtA4h1A6/HH/2js3HDRE/rUFTQ/aSm4AuOsGcxz57jTorxUX/y
         I26zg83HAl+aHm+/FAzH4Z5NYPFvGHUmSMV7RNM4HERNI2Mfm6IpGMMRDPlVk6XN4jcS
         hiPVM67FveHut6f3uMJSFrmGMnd4gKw3wnS8u6sHuMAafCZrrIgb7OM013Ac4M8pqF4l
         bucLh1OV34tL+3m3vvXfLdjcEX4Y6bcM0J4JkWekAOxudXj5WcFlbfGSrqODedhaEJLZ
         /z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726561213; x=1727166013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8MW2HrKG5QYTZJEo4ienELOMIdCuJwtNwQzR66o780=;
        b=hZoW4CTztkCknkWUkeOKWeTDPiq455AufHPG/rfc3k7ezPeMwDH69sqVM3XmR63jEJ
         fKJd/i5GhwcGfRyMy+s8vsYKOwrDG0EDp2ordaJMKbXDEYCZUsUjBABoxd5nDMLOPJEQ
         /vFjroJczYZYY+M/AxEpWkvIyHCNWUCpbNEsYzpd4b17Fca/4+zXUzFYSVuStb6ICVvP
         MgRpRoQef7kuJgITfFYBIUhWvnozB7PNvezKr7qgZd+cmWtbwjEKuXlK4N7cKIkDTT+B
         8CfvZrCMEWFpcsQOLkwUNHY0eM+e+JQ9BRHbbpImdY5GpEHfgQheSJesPPvNTHjxDk+k
         EDrw==
X-Forwarded-Encrypted: i=1; AJvYcCU1yAAQHloadVdJ9d34GD3IyMBRydn0kziFLv7PpvuSIriiieANLxucyYQR7eH4UGBmPV/B4KZqjcDPMCXEmxep8Yhp@vger.kernel.org, AJvYcCWPkq8AYe1OcY4/UdyRd+1kxezHOTq0vlNrJlUk9CXDQcaMA3PWh8ety8cC8RxtYfKyvFoiIsHWxz9zXzYt@vger.kernel.org, AJvYcCXVOPkaoHC67P/geokui2FJmNEUOnDCgkBqJR4qETnU63v4CN7OjOJn3zSEpz2lft8ShW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0zgmy8npTLe89Bznu0kBDjDJAAZZE7EZx7PUltqzrYs8raGN
	gOX6C9VeKuqBA6ze7bTgd5rKuXfpr4lhT3+zxdbK0lq3jPaeI4+hPuTRedofO8d01ZQcIdPkypx
	W3L00w15BJGrfJ6Y/p6J2RhR9Ub0=
X-Google-Smtp-Source: AGHT+IGqZuqN4wbUVLy2kShgQISeGWkP8uFVIVUOjDvFst0QujTleRUDrYVW4atXOBBckrqHnoCswQnQJ2RLymQ6fXw=
X-Received: by 2002:a17:90a:ad8e:b0:2d8:c17b:5018 with SMTP id
 98e67ed59e1d1-2dbb9dee8b8mr18340308a91.11.1726561212740; Tue, 17 Sep 2024
 01:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909224903.3498207-1-andrii@kernel.org> <20240909224903.3498207-4-andrii@kernel.org>
 <20240915145105.GB27726@redhat.com>
In-Reply-To: <20240915145105.GB27726@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Sep 2024 10:20:01 +0200
Message-ID: <CAEf4BzYCMj911cj=qdntxLi3Roeav43AJPkMggKVHD4mp5OyWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: implement SRCU-protected lifetime for
 single-stepped uprobe
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 4:51=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 09/09, Andrii Nakryiko wrote:
> >
> > Similarly to how we SRCU-protect uprobe instance (and avoid refcounting
> > it unnecessarily) when waiting for return probe hit, use hprobe approac=
h
> > to do the same with single-stepped uprobe. Same hprobe_* primitives are
> > used. We also reuse ri_timer() callback to expire both pending
> > single-step uprobe and return instances.
>
> Well, I still think it would be better (and much simpler) to simply kill
> utask->active_uprobe, iirc I even sent the RFC patch...
>

let's do it, please send non-RFC patches and get them landed!

> Oleg.
>

