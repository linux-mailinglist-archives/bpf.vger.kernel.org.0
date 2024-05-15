Return-Path: <bpf+bounces-29796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD528C6BC4
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCF228477E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED32158DA7;
	Wed, 15 May 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQmkrbB7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866D433BC
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795947; cv=none; b=bO2K9nxcRD61gHXfssC/D0yBc3DgYdf6RjnUMdh5du6gxNJINlXBNgcLu/4M3JOSKQZPssD3iK2QPvlWpLQrOEFOd/2IIiGXG0gCHdj8KmktgP5KmfKBnbhdITIdChETX6y2g9ha2a8cOzAb+zUjd2psMkvbuECelrpE9pzvF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795947; c=relaxed/simple;
	bh=KUTeCvMDgTCsVJ44R6j5fpxyU9u+LpGW6pcncK9WxOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXqph3ryjExA1myHX9xymRISKg8VzhUWlcWFXgqCmM9po/4DndHyiZ0XRdO2+rYyKOMJw7EQepb5diHMr8/XhS2M+HUBzkEvsNZsg+QBTk+PtfZ9tVbhn2et2IBXrRAzEUVsNkYS7mkBacNLypigTjBUmg9ksUGwa/lyAKfyHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQmkrbB7; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5725cfa2434so946812a12.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715795944; x=1716400744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUTeCvMDgTCsVJ44R6j5fpxyU9u+LpGW6pcncK9WxOo=;
        b=cQmkrbB7moF4PHTPcwB+5mIaToCM/YAQwyRvr1wbmtZJAQZNWijBMkrioIC3/u0Lio
         Y6zXUrj7AAjddu5TdGqb9LMF4R7rM9Z3DbOfPoadyqN9GYOV9OrEHrU07Z4ZjOvmZeXN
         IGHHhEMsskq79KBjQ/bp1uAAZ3QNbv295SaGVbCxOCGCEZW0WDXtCdXgC+UdztSRMRFa
         eZp7ZA4Y+IM4x+2vGy4P0B1iCvO79uFQjRX5Er0Ku5rJiHuIvZqTXj4HIWgLauiFeDMG
         WeaLOWoTY6qRxbU9juwMybr+owus1w/orIrhJhStw4JUuUZ1DGLjXy+IudlpLf4hMxzb
         xrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795944; x=1716400744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUTeCvMDgTCsVJ44R6j5fpxyU9u+LpGW6pcncK9WxOo=;
        b=oAhAVaR5zwwzZ/EAOZZGfwhyWBd4+uF7grW0jmK13pJVJkiGb0jXJOfuI+4MV61zjB
         xR5XtIZsjT07s6AAMIcD3qZslt0AKPGKMlGh1YQwB0Xibwsb2NMRV70EoRWujW9Sp3sx
         xvogs6tFjd+An5tnyKU9oUYiYdZ3nsv4xZxRdGnGwVGGdcbEi7z0Ke0MEqa594YFXtMb
         F7uv3ZEUURUuj7Nm016rrg2IcA8ZaByNd5bpsDbpyt4oYVCNt7GhhHnmdhHvedvLbtP6
         +alq/unlsE9P/+mhAWusMVp82DL45/FP/JdaCP7wYFihjovQKr0F8KZuTwgZZm5meRcA
         H+Vg==
X-Gm-Message-State: AOJu0Yz26VGX+x6No8MDHaDk/xCaObQGosR0HyD/PLDrS/oOmOqn6HoQ
	su9TNDZlwPLhGkRq5gw9j4o1cwQSbZAmvC9zeduE3/qWYKFj/y5y++w9tsI3hGuxDQQMZ/plcOP
	U+ybqPRgqEj1EDCfU0AiQ0r5d86g=
X-Google-Smtp-Source: AGHT+IE1k3EDAJgW+U0dB/4SHmMX5GAX3ZcrXCFe1CV9H3ptNw532DDCHDXeTtPlZQoQNm26NsTj4vf4YhcXf75pHng=
X-Received: by 2002:a50:8d50:0:b0:572:689f:6380 with SMTP id
 4fb4d7f45d1cf-5734d597df2mr16930361a12.3.1715795944009; Wed, 15 May 2024
 10:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
 <CAP01T778YG3sL1BTJnPdOJkqhcNG=zv2dEp1hquUV1+aX+DXDA@mail.gmail.com>
 <CAE5sdEgjqYkSyG9MgrpJ=dDCEGtC0e-L4hzV+tz8Pr8c2EbrnQ@mail.gmail.com> <CAP01T74tenD5vWgh_Q2JzkWP=xTAVJiovqk0C5aMYmUNbpedog@mail.gmail.com>
In-Reply-To: <CAP01T74tenD5vWgh_Q2JzkWP=xTAVJiovqk0C5aMYmUNbpedog@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 15 May 2024 19:58:25 +0200
Message-ID: <CAP01T76f+KPuaYGOz20_UrKO67oQCK0CYKKQAp73Fhi+V5CTkA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Added selftests to check
 deadlocks in queue and stack map
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, miloc@vt.edu
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 19:56, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 15 May 2024 at 19:44, Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > > CI fails on s390
> > > https://github.com/kernel-patches/bpf/actions/runs/9081519831/job/24957489598?pr=7031
> > > A different method of triggering deadlock is required. Seems like
> > > _raw_spin_lock_irqsave being available everywhere cannot be relied
> > > upon.
> >
> > The other functions which are in the critical section are getting
> > inlined so I have used
> > _raw_spin_lock_irqsave to write the selftests.
> >
> > Other approach could be to just pass the tests if the function is
> > getting inlined just like in
> > https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/prog_tests/htab_update.c
>
> Yeah, it is certainly tricky.
> Skipping seems fragile because what if x86 and others also inline the
> function? Then this test would simply report success while not
> testing anything.
>
> One option is to place it at trace_contention_begin, and spawn

Sorry, this should be trace_contention_end, the lock is only held at that point.

