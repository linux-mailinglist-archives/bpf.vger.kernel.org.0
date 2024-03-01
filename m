Return-Path: <bpf+bounces-23104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C176E86D84B
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 01:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B317B222B2
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 00:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0851D622;
	Fri,  1 Mar 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1Bre6dd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1A17E
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252731; cv=none; b=UGZiQQYFmlqhA348drsCMzuuWyQS7XWLUt5l7sj+PFymlieQH5zvdf91/njkLTOquFda5YA+AhumX0DyXQPJKzRQmQVK1Yjjnl0D4OEdXdEW7AsqpfLrdcXQCBtK+4gy1AjVq9WNk0b0l9nIGJOrP27QsNkrS26Yxo3sqGCceEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252731; c=relaxed/simple;
	bh=5XpI+yEYQT6oy0RkaDFdU4mJ+7KhnKg0WWMwNNyg3yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDhVsOy/K6pFlsOFhX5/7YdYpnSd4wlIvl9cQrJE2+YJ5uqDg+rP+GckshgGFs9pCXQ16K4v7VuUviIyfnZJZKfFgkSY1Gn9l5gARyRbWNBsRdMJhQT2/0U7zh4EDAsRDySLFxHo+T0qE+d4HiDMRoqqA1uC/QZUWi14b4QD9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1Bre6dd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1340331a12.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 16:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252729; x=1709857529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2rpWakGXN/SzrLujhrBpzSG8AopzOJG2GTjMZFadsI=;
        b=C1Bre6ddDmUlDgrEgG/5c9tCk3B1eowuTpJBturx0TOcvRh/jktfIukoOZDP8D1Pc2
         ZIWiI8qXMXt1li1E8jPT1o8fkcCTM9Nr5gzsrYm4QSnAeLlAryvt4ofI7stUH5+jQqVj
         uchaLsj8CNK6Tl1s7xXD1GKsFkC7S6/wT/3aPCW/QgfjoFIB0qcO9/O99CLrYIXmovVz
         wjpAw8yjzQ5jBn4abqkKCSt4eY3va7x/rEaMILG+chT6Tep2XzAFJ4aRIfC+vqTakVVo
         jPooeLbDV9B55tYrUeu5FQPUUSXxwyI3vrCRwIJ9gvH7HV2Dbxjn2bbW+kD2FuNQ+IMF
         Wznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252729; x=1709857529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2rpWakGXN/SzrLujhrBpzSG8AopzOJG2GTjMZFadsI=;
        b=oWdtqxrPhjhdEFOjJP8COufic6Dti9TnfOs6zcQ5AJlMNiKXp0nS9sFVbVRgExHa7a
         uq2ppO4R/HOJlw7P5iSDg5Xwftye0LQcovDXaMPYAdjqT9TQaH2UGZ2PUoe97j5n8tnc
         tpGy+iqBG63Seo0dG5QQ+zIslNQtr4hzhawcLqCqlMjSUvbv9fi/I85/LXCsQzr+mx80
         /rKsxtoI/+Gzm4whKWtph5NHSITuW4QWqpMWch4qZyF/bfIVTX9LmiVxi7R1vXwOIRBj
         ED97dufD2HZySVumoNwOnrVDdn11IN/KwmdFcVtLDGsuen5rJjVKf8ZAvponchekpBdL
         /pig==
X-Gm-Message-State: AOJu0YyH1Pzxxy0+kn8pMTZeo0hHCWnzAElrifj3RXaMVc0qI3Hfq86h
	yEdqwWFMG92oyLi65ASBLc26KFcaw5XQj+4zbmo+O+ddaOlAHgMvzTMKFz4VO0/x17GyNgsdWVg
	oB9LG4FiH3LNpoPiOw2RMrJQkcMM=
X-Google-Smtp-Source: AGHT+IHuK1sR8S6beM4pMKE2Cssl2oKv4IgpWF15zAhNuytSRpniexabD1mZx8W5fo8OvI1HmzRoa0qCGuwaP/ixrPM=
X-Received: by 2002:a17:90b:23d0:b0:29a:c21c:674d with SMTP id
 md16-20020a17090b23d000b0029ac21c674dmr218181pjb.14.1709252729547; Thu, 29
 Feb 2024 16:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava>
In-Reply-To: <ZeCXHKJ--iYYbmLj@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Feb 2024 16:25:17 -0800
Message-ID: <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:39=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> One of uprobe pain points is having slow execution that involves
> two traps in worst case scenario or single trap if the original
> instruction can be emulated. For return uprobes there's one extra
> trap on top of that.
>
> My current idea on how to make this faster is to follow the optimized
> kprobes and replace the normal uprobe trap instruction with jump to
> user space trampoline that:
>
>   - executes syscall to call uprobe consumers callbacks

Did you get a chance to measure relative performance of syscall vs
int3 interrupt handling? If not, do you think you'll be able to get
some numbers by the time the conference starts? This should inform the
decision whether it even makes sense to go through all the trouble.

>   - executes original instructions
>   - jumps back to continue with the original code
>
> There are of course corner cases where above will have trouble or
> won't work completely, like:
>
>   - executing original instructions in the trampoline is tricky wrt
>     rip relative addressing
>
>   - some instructions we can't move to trampoline at all
>
>   - the uprobe address is on page boundary so the jump instruction to
>     trampoline would span across 2 pages, hence the page replace won't
>     be atomic, which might cause issues
>
>   - ... ? many others I'm sure
>
> Still with all the limitations I think we could be able to speed up
> some amount of the uprobes, which seems worth doing.
>
> I'd like to have the discussion on the topic and get some agreement
> or directions on how this should be done.

