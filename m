Return-Path: <bpf+bounces-29795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D78C6BC1
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A191C21D1F
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED901158DA8;
	Wed, 15 May 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4u4j2h/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812815687A
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795827; cv=none; b=jZ8HQsQWISnKohU0zclvHOoNNg+1WDl9Oq+xYewLEBCpwhOU1KvAlRVqosW8Qq5DtiGVFVe4UTSe7/rtetrRr39ztRuZKLF54W01RX1DBN/GOeED76AIip+sgT7I5s6zAYsJE3TB5ShtyWwujmSH9GAx49mZDHRwHOyOPm9Hpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795827; c=relaxed/simple;
	bh=s+bC+MDFMm3YPeFA5IULf10Pzzhn5wixAk19b3bw0nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7PHdUipxdIxjN3HofQAWz8yAyHxKNbH3GDrkF+ZS9l4Xv4hm4SotriCAMTE8OOpLCIRvdiATkcjQWCUYjGlmzUzecSa2qfn3J8hp5P5LMi+ZUs9ze4LnzA4OQuqdbNc1RPjPxksGfBXpIDALAhu37RQk/wu4PtQI+EQs6zOBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4u4j2h/; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-34db9a38755so6757943f8f.1
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715795824; x=1716400624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s+bC+MDFMm3YPeFA5IULf10Pzzhn5wixAk19b3bw0nM=;
        b=d4u4j2h/vPJMsDFrOGW/ixTPa0tkveLRQqsCg+T8Y9iHcUv50isJ97p9izsUIqe45v
         fX39K2bhiLmET8iKrwbsjZmvuiRkFYQEqxNyt7kOkU75oBhhjO8Rvk9p4Q5mifc9RZiv
         fVSZhhMG6k5AxpTTRMameaued7225U0eOY8MnxuOzQvuTDifoPr9N4iZympfay4Vje83
         3AEPG7ScUdad025GUAzUQI+Yxwc3+s0lZzPpyn2Cvsj+akXMI10j/YlMWdIssQk9MFUi
         iiN2THP08PYqS+sjn8i1qdzXfNfWZVvTDD/9BbQnEuXPcMRQILX9T1MRIxAD6ZVHY7mS
         qE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795824; x=1716400624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+bC+MDFMm3YPeFA5IULf10Pzzhn5wixAk19b3bw0nM=;
        b=wx3tI3IgNIXX9Po2NTy09u+ZsAF27dmeIDLMV8U+Uz7QUGafPCp8dwC/uOg3psOXSU
         GRCT63SNt5uoijFNQ62kSAgk3o/nuyVev0IgX0WrDNXBNHLmYrGIH7rX7hnrX/sPZ96x
         3QU7SZSdxUOGNg6ger0KW1s3BCLH29IDd/z4X4cKVvZqUpZfIhlCKwiXFqLtLZGdvWUv
         liJ4KBFKv8PX/nZEhetuYyYfXfrqiB3noTA67k0zS4KPfdZm283zgzqH0sN8pvLlzIOZ
         OBtq7GSZuLMNSMkx9r+onfXRb/CztmxPN1wutZQoVKaF30hLchb0ed3lhnimIvDr4no2
         mJmA==
X-Gm-Message-State: AOJu0YzI2sSyCTEL5mkZzBQtkppoA/lLO1jZuWdnT6coW/GU4shkPnhf
	ixBGpfGZ0m900CnoyfCe8wLignkGYq0LCeOMDYXphNzvYbdUdXtK1QYew8Vc5jfJ0WMB0FQtS+g
	HWuagMKxL8ticHwxCdLQ5kV/fWkQ=
X-Google-Smtp-Source: AGHT+IFRYezdpnaFOuCtpHi2T//0qEiUQ2F3MWCpYlm1ZlDlNaN21HvGO6w+CWfjtn5n2GZWhIsr9ye6VHZfLUz0gbQ=
X-Received: by 2002:a05:6000:d82:b0:351:bc37:c688 with SMTP id
 ffacd0b85a97d-351bc37c6acmr7621750f8f.46.1715795823961; Wed, 15 May 2024
 10:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
 <CAP01T778YG3sL1BTJnPdOJkqhcNG=zv2dEp1hquUV1+aX+DXDA@mail.gmail.com> <CAE5sdEgjqYkSyG9MgrpJ=dDCEGtC0e-L4hzV+tz8Pr8c2EbrnQ@mail.gmail.com>
In-Reply-To: <CAE5sdEgjqYkSyG9MgrpJ=dDCEGtC0e-L4hzV+tz8Pr8c2EbrnQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 15 May 2024 19:56:27 +0200
Message-ID: <CAP01T74tenD5vWgh_Q2JzkWP=xTAVJiovqk0C5aMYmUNbpedog@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Added selftests to check
 deadlocks in queue and stack map
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, miloc@vt.edu
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 19:44, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> > CI fails on s390
> > https://github.com/kernel-patches/bpf/actions/runs/9081519831/job/24957489598?pr=7031
> > A different method of triggering deadlock is required. Seems like
> > _raw_spin_lock_irqsave being available everywhere cannot be relied
> > upon.
>
> The other functions which are in the critical section are getting
> inlined so I have used
> _raw_spin_lock_irqsave to write the selftests.
>
> Other approach could be to just pass the tests if the function is
> getting inlined just like in
> https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/prog_tests/htab_update.c

Yeah, it is certainly tricky.
Skipping seems fragile because what if x86 and others also inline the
function? Then this test would simply report success while not
testing anything.

One option is to place it at trace_contention_begin, and spawn
multiple threads in the test and try until you hit -EBUSY (due to
increased contention, leading to queued_spin_lock_slowpath being
called and the tracepoint being hit).

The other option would be to add a dummy empty call within the
critical section marked as noinline, and then attach the BPF program
there. But I think this might not be liked by everyone since we're
introducing code in the kernel just to test stuff.

So option 1 seems better to me, but the test needs to be set up
carefully to ensure contention occurs.
Others can chime in with better ideas.

