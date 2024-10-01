Return-Path: <bpf+bounces-40715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547EB98C693
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134652845CE
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAE61CEAA3;
	Tue,  1 Oct 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5oBiDJN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA921CDFBE
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813645; cv=none; b=u6TLxLym/kD4527PIRL3XSGCFihHgc1AO1Yh9oZR2ulJrFAHH/Nm8KUY1k41IjkYuDxKdqWe5KFcS/1PA239dJvOqqsec9+UcZo2fnVv08W4hXwzJLYTpmaTakl3uHVFLBaksTuXV7TloRrrQ2/Cpq6XbeLIyz2nhnYqLamT7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813645; c=relaxed/simple;
	bh=feFrE7VfaDylY4CslnA9JQBwCPQtZ04O8WA8A57Y93s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUvS+6lTQ+tvxQmef8eesrg+kLaBnUN60MWni0Ys1o2Z71Pp4nJ2VmYNXF4SKxIuqkdhdd1Ti5VaQrFRum1bplZZ+hhG5jgXp23AAmT7y6EnebMDSauiJC3y9G4Yc6IvdB3SgJSz4tVl+jVRCHVpdsBirMhqdKprGc03hrJ7p8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5oBiDJN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ba733b904so16516625ad.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727813643; x=1728418443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuSgw1vpI5HOihSZi5ccJyl9TTA7J1M9/DCT4jExjp8=;
        b=Z5oBiDJNWZboy3x08EILxK7sGDYZ+td6yuVnS7nHrZg3tjZ8HMQkQXcsU54NAZBED5
         S6TUP3AaMrKABVNk4uxmCd5dn+69WTIbYhhTxy7oXYqon79GjWHvZINuw7iMsLcrjtIv
         RIPvtmp3miM05o+YG6mUr0zVgAe434wob9RIyyUGlbIQKXj3AzTB9zaYNHmx5kfKseIc
         XN6+bCZ6H2qmZuIR8BspB9pG38/4LerNl1kAPFTmFuAZQZnZdevpf+SW6RL3eu3q0jBx
         nlwN1xhtSvskqK7pjRsrK4qIY0PzrkxUGqSifbMy3ylOMr3IrivHf4X8Ahu08D58Ir4L
         x7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813643; x=1728418443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuSgw1vpI5HOihSZi5ccJyl9TTA7J1M9/DCT4jExjp8=;
        b=dR6jSV+DWj4HMCoTZ5yAPplPZNCOSJjqWsQ7Xkw8sAj/2sq3GzW7hvzwbobM9eAazn
         E5OFDIiHiCAdH5t8VvR+P2mXjdSQfMep2iXUhYJsqWKtwmhSthtgdhj4Z00JjVFSqQ4o
         cmm6lVAYf4aEu6guswnh2QZGpIU8Z5iR3myrVFRIDEaunu8FrIQYjB1BbpEs8hTegyyd
         0a1Ru57DEohKdmqa3usXwLJmKK5GFxHjE3gAgGbRjkcQ4ovlvT9uR2cPaXzGhI0gwzUR
         p3kqIGvtdrtpIGafbos7Wo1Xc+rz6OJuqA12GDv7Hylid3JcVxG3Zcalq/1J7buxQl1v
         y84A==
X-Gm-Message-State: AOJu0YzPWe/bcE7CrMl3W/GCTfVEq9rCL0aFgZfvzIse+BbneFc8qyiU
	j8JLEHp18txibTci2Z6aBgzJG5jAHr126birGohld2qhev91dLgQqollfy3B4YYtWZnb4MhCvOl
	8gXP+cxeQTRD3uH/6uR7kGT0matZ2Eadq
X-Google-Smtp-Source: AGHT+IFk2OWUMijeal8fB6YNLKn93FDajI+guS/+WyWqtWdMA3osoKsVX7aykG4euBzUTFMcVsSwUPIQbuz+1vtC+pM=
X-Received: by 2002:a17:90a:6406:b0:2e0:f81c:7313 with SMTP id
 98e67ed59e1d1-2e18490a164mr1072847a91.27.1727813643407; Tue, 01 Oct 2024
 13:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0102A73F-5317-4412-8E74-921CF146531E@getmailspring.com>
In-Reply-To: <0102A73F-5317-4412-8E74-921CF146531E@getmailspring.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 13:13:51 -0700
Message-ID: <CAEf4BzY0cG0xCOeGZxrDqiYMw==QCJMgWHyKK6eVO4y6vM-GPQ@mail.gmail.com>
Subject: Re: Maximum amount of uprobes and uprobe and uprobe_ret relation
To: =?UTF-8?Q?Sebasti=C3=A3o_Amaro?= <sebassamaro97@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 5:13=E2=80=AFPM Sebasti=C3=A3o Amaro <sebassamaro97=
@gmail.com> wrote:
>
> Hi everyone!
> I have two questions related to user function probes:
> Firstly, I am trying to have a process attach more than 1024 uprobes,
> however, I am getting the error: "failed to create BPF link for
> perf_event FD 1023: -24 (Too many open files)" even after changing
> ulimit -n to 4096  github issue[1].

See [0], it might be that `ulimit -n` isn't really changing the limit
for your process or something. To be 100% sure I'd do
setrlimit(RLIMIT_NOFILE, ...) from inside the process to verify.

  [0] https://unix.stackexchange.com/questions/8945/how-can-i-increase-open=
-files-limit-for-all-processes

> Secondly, I am running some tests with uprobe and uprobe_ret in multiple
> functions in the redis binary, but I am noticing that when counting the
> times the uprobes and uprobes_ret are called, in the end they do not
> match 1 to 1. Either individually (a uprobe/uprobe_ret in the same
> function), or the total sum. Is this a predictable behaviour?
> I am tracing several functions in such as [2].

Attachment is not atomic, so you might get some uprobes attached
before corresponding uretprobe is attached, and vice versa. So counts
might not match 1:1 during attachment and detachment.

>
> [1]https://github.com/libbpf/libbpf-rs/issues/942
> [2]https://github.com/redis/redis/blob/3a3cacfefabf8ced79b448169319ce49cc=
a2bfb7/src/rdb.c#L1782
>
> Thank you, and Best Regards,
> Sebasti=C3=A3o Amaro
>

