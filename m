Return-Path: <bpf+bounces-43076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92039AEEA6
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170A01C21D71
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3A01FF049;
	Thu, 24 Oct 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mt8uySRP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DB1FF023
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792260; cv=none; b=ssaWQm9K2cV1eACZUXfv9ZDDD7Dj1n1eBYavCfcHGjiXLifkVPvXuzufMk4CbuoTuVwIFe8TbC+sf5jGSZ8/B0Klg8K3w1DGZqbuhi1gEQO/lGt6o6p1K1vJ4syoWNvdKX70GeB54p1drk4GGnTghCCMZpq3pJhDpaaizC6Dd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792260; c=relaxed/simple;
	bh=/tM5oJkYSDIxAbnk01u6JH0cD+6nKWl90fud8hBuiyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsXz9xlt3g+0co9sYK/KjP4xMqCRRAa02A4/K/4Ye/oB4GAJO08njBZckJUajrF1S0YIOCV46Uz/uE5odDmcawvrzHoTdwj+B7a/kB2reBowTTgGDTegwTT0QDAd8Gp7gpiJf+oN9l1pepULogoU2FpHcLAHcE7OBa5I67c4K/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mt8uySRP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca4877690so13225ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729792258; x=1730397058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RkjXg6PY0r08PgmUd9ZxlQNovB2X2eRq3KqUjeeCP+w=;
        b=mt8uySRPqzVxl2Hei3Bw304LqD1sijgYvHL9cEsZ7q//GlldAF8DNeKTMJ04hKPLnh
         C5z/I7J82yel8t6QJsPMziQeB3jhasxXjxFOfT6e5s0LOtq6Nw1he6Eh2T+9oy/asNyZ
         Nxmj7lVpISxeddiLgC1qg6foh/R7Nq9jdLokVSlnNs4Ox0UUEweXrjh3S4rnb4w3zbXY
         1sKJ5NHQLR5YGdA4XUQfcA5W9BtZ78/eqbb05I9wRB16exVXIZwwM9j/XjEyQ2LsvVhH
         cwPlL+LuyHPMgd+YGaQThGAqUOZL4RDAT7MPw+9xOyUEsK5A+oYc3wfeGR+1k5qhp3Cm
         3OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792258; x=1730397058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkjXg6PY0r08PgmUd9ZxlQNovB2X2eRq3KqUjeeCP+w=;
        b=UeVfKb1rnXTOs1CfCl0cjrazxjdc0Q0PxJT2qh4+R1t6C3xWl/peu6GS0owrn4Pl1m
         dVaaE16ts9j5jBceb1AmvVO4ZNoxcsua7M0WcJrx6uEEDLz4muwkcaERw9HUfi90fn+F
         /GJSbNMLiRLMReLTf8I0tb7zkMsVKaoUWx1cUVf7rOJ6wR1dUvwGWmrUlv5HpghK9AMV
         bS3WQtdILNGblX/8YMOOISGYTjXN9djPUbDGDBpqTgxq6xq7ao+LLnveoPpZz6u0nrEr
         NuLj0bdecbI32bAg7HXVg+rj5BaPcKyJd+5L52hSKgPNQtY7IKOkw1V8BvFz5go46Oap
         Jzpg==
X-Forwarded-Encrypted: i=1; AJvYcCXgAnkxI9PA/mlAdmIK2ff7RAxu+iIZv/JmZH4OCK2RgpTSEOqOGiMpws4wM6o0/1wwnCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+EMhh07NuczCrFsL358RNUqagzq6ErBrMz5gq6rC5mbKKsHo
	ylRLHERoAif1F4VUsCTcioS43aGtTinpHzvSp7FQLwIMbw83aaYlOImwk2wiLCmEGBJ7QLGO4ii
	aeGZpuh37vZiSd86JV/wcLskOnOkR7EA9Ye3r
X-Google-Smtp-Source: AGHT+IGmMF6Oi1vLba4m0kqHuNX8J81qghfcDxfqm6mH4PqLXBdjonza61cFVolDXqPL3rLs7uZVHPnQpEkVmW5BoD4=
X-Received: by 2002:a17:902:d488:b0:1ff:3b0f:d61d with SMTP id
 d9443c01a7336-20fc2219cd7mr74225ad.24.1729792257213; Thu, 24 Oct 2024
 10:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com> <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
 <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com> <20241023220552.74ca0c3e@rorschach.local.home>
 <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Thu, 24 Oct 2024 10:50:45 -0700
Message-ID: <CADKFtnSBkSHuR8XLhwsB1NZ5pPeUXNAPCzoCiEqJ5X5=NqqWEg@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"

> You guys said you have a reproducer, right? Can you please share
> details (I know it's somewhere on another thread, but let's put all
> this in this thread).

For reference, the original syzbot report is here along with links to artifacts.
Link: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/

syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ef887980000
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz

The steps I performed to reproduce locally are roughly as follows:

1. Copy the syz repro script to a file, repro.syz.txt
2. Download the disk image, disk.img
3. Build syzkaller (https://github.com/google/syzkaller)
4. Start up QEMU using disk.img: qemu-system-x86_64 -m 2G -smp
2,sockets=2,cores=1 -drive file=./disk.raw,format=raw -net
nic,model=e1000 -net user,host=10.0.2.10,hostfwd:tcp::10022-:22
-enable-kvm -nographic
5. SCP syzkaller/bin/linux_amd64/syz-execprog and
syzkaller/bin/linux_amd64/syz-executor to root@127.0.0.1:/root/
6. SCP repro.syz.txt to root@127.0.0.1:/root/
7. Run './syz-execprog -repeat=0 -procs=5 ./repro.syz.txt' over SSH on
root@127.0.0.1

This typically crashes things within 20 seconds or so on my machine.

-Jordan

