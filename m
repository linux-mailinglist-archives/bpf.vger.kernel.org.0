Return-Path: <bpf+bounces-45469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B59D6114
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 16:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE1B280E61
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E97158848;
	Fri, 22 Nov 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKeu89N1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6212CD88
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287857; cv=none; b=l8ryeyJusQ/49nNBk5lFahtA0rBby8TEanN1HOEWWrGWigzNNWaszybSEBz2zBXtHVaV+Q7u6bGAb7N2v7vQzWi+GM+ELqL7v9dIXnH2Acu3bkX9+Tl3OI9YJSjSpn24CpkY40hg2gD0n0j075YYk3zPQI8iOO3rTwKjrFw5swU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287857; c=relaxed/simple;
	bh=JPwzMxxKiG5YAlFM7ggPNw4cNqkrUfOxQAIgSiAFjHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rv1SswJprp+CbhSY1ZR0Ck6vQpp5bNzIo2uo9qmYF/YgcjlZC/M9OY0aYwE5g9XdF/0Jx9JMKaK6LvmeGyFpuXPMtHSCiVXejCq6Vwke9ialpJlgX8cGYUp2UlbHV/cGwNym39c4ifG8TyYFjaN9jZua1QyAmzwbuT9HCNGuUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKeu89N1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460969c49f2so285131cf.0
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 07:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732287853; x=1732892653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8ZUSSRLGw9xTBQ7M4Y0SwWvv6Kuw0ebYJzTcfGAtqM=;
        b=BKeu89N1zweV+T8VLC/CM6PNaT7yibRv/RQ3goDgRxpYajorV2NH9JYEz4hJkBFmQC
         i/OpZfoBKXKhSFjIE8QuJmPEQsyPFRsF4eUYyMWngj2MBwv+2RYMLQjQspjxnJtcT2FQ
         QCQOU9qLxA4TtXVDgVVdgfS6t0KMwFTGz/Hr2h93fFEH6GCinELz9cd9mSpqdePICR6i
         0yKcWTgJp5Vkxr6U3NbII0LUAMThNpXPa0OeadbJ5kxPz7ZYn0Nz+Z0/4elhALCpc0S+
         eZ0PbG9HbQLRJGXqZDdROJZLFTHwv5sOtta1VLWrhLEJJqPJSTkru6nvccJLvEri8JNW
         GeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287853; x=1732892653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8ZUSSRLGw9xTBQ7M4Y0SwWvv6Kuw0ebYJzTcfGAtqM=;
        b=AZrMGmjK05E9uE2AESLOtYIBP2K4UzRfItWE8ZWuEXqZo8owWxy9BHZHNfwbc8+33r
         QMq++bmRkmCGHJc0ym9F5ZUOaQjtleKC8ANR/CF4dDcZRvriR6kvgl6AUUFixzm55xbh
         3M0JVIWOh91+Lxwd6c0iA1f9AglFIpccfv1nkmUwDC3BrPCza7bfSC0BuGg4zpGbutFu
         mK19essqd2Eqm0O0pkBKvpRT8tROEdw3qJYIqGz8E/IXnIdB+QzeYG1RTrYN4eiRawNm
         kfwIRtevTRpahf+h/vII4j3YFnUV1tejcF8wGkNS9KhJYLhxhn6UVEunEgVUk+eY0sxB
         JcJA==
X-Forwarded-Encrypted: i=1; AJvYcCUHmMeRdKZKtOUSFTqqhcpCEr0clynKkEsMwIkpDdMwQS1PpDKOJduyyKIFLjWbqzYq4ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRP31iLuTABXfmz2ma81/tKoh3mQ2SG1q8LnE1vLyvG0Ks7a0
	sWKMavw5p9POC1j3BMdAPxDlvu5Zd6Prfysy+zqLT4EQP6avopEId+IphY6hJGl6jR7Pe2hkB1w
	6JH5Z/oa1dumyTAi4ySu0gv5G9/Y45tcSp6uU
X-Gm-Gg: ASbGncu+ApFh/D7kP/2tqAQ/wnoxkhvgXDmN3f7jxTv1+vSCXrvpAM0rmQux6r28yl2
	UOX39HaJcNf7YSkSl8gksShjyTJMAAek=
X-Google-Smtp-Source: AGHT+IH/FyuQ/03I4l56fu/4U8V2wW9Bn9XSq15JGKrpMqDO7NvvvR33bmdKWIL+KU6uDt+D8KmNCQJZ8ruY0FD9UAo=
X-Received: by 2002:ac8:1188:0:b0:465:c590:ef19 with SMTP id
 d75a77b69052e-465c590f0bemr2293521cf.5.1732287852689; Fri, 22 Nov 2024
 07:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122035922.3321100-1-andrii@kernel.org> <20241122110737.GP24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241122110737.GP24774@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 07:04:01 -0800
Message-ID: <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
Subject: Re: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless
 VMA-to-uprobe lookup
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mingo@kernel.org, 
	torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, david@redhat.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 3:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 21, 2024 at 07:59:20PM -0800, Andrii Nakryiko wrote:
>
> > Andrii Nakryiko (2):
> >   uprobes: simplify find_active_uprobe_rcu() VMA checks
> >   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
>
> Thanks, assuming Suren is okay with me carrying his patches through tip,
> I'll make this land in tip/perf/core after -rc1.

No objections from me. Thanks!

