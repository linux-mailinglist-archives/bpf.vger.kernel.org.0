Return-Path: <bpf+bounces-63653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18254B09412
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26B04A6872
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464F20C480;
	Thu, 17 Jul 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A5/s8k66"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35D20B215
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777367; cv=none; b=RjkAUiSFCjvCj5EAoC7/Xxaxkn/fHz7eaPOqAtSGAHFRqt8/eQfjlVQFlqksMGD/i4/b9AHBXyHzF465bNojBfiiFXqPuLnLoVn+BrAUoBkXKUY0uNugnGRF7AobgbI0LI3j0MyAR44kPwTEL+TL8sdRlLSeHZBJfVhQ7a6db9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777367; c=relaxed/simple;
	bh=nT1GppLNav7xgnl/ObI19ndyqjnUwbm8v4pO3iyByg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I70FwB49mcIK/oF5utGORBIUolCrrSrAndaL1ZYrp2zaZIbSZrkui8lzekrLeoUAOzGoTbtp2WeiJMxeQwVaJdK3ZhRChK5VH37+ARiUqUCLlb54Nt/mKSnvpReA2LEfV/FjMj2dqZDZhMXqFI5G7houJmlKN1xZjCdW5mTv3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A5/s8k66; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so2399502a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752777364; x=1753382164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=A5/s8k66tCbfC+9RAt6MBuSzJ8VP8GwKQ5hvQ9J0MVZbkYpp3lNCYGqeK2zreI1Wgz
         lD0iRJ9lF29b/0afjjvnHQL7lO35eF1u7IcO5jyrvYNleDD52Inyw6HBAXbbh+v3NjR/
         Wn5wHU8igXlRbF7qMLzgvDjo57OVPxkxp5AXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777364; x=1753382164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=EHzuW8ds1uCa/R2LR31sa80O+gj1M0ty+WNh7D0TSegRHG8kD7XPfWzSQlhqH7jOL+
         AstfJ8wKtFO2A4YSJAJPlR7ZXrU9cnd+Ez9cAIao+rqS81VV2uGDj808JOiOWgrjGQFE
         aZj1m3gK0sdrkTzzU11RF+1rd3gso7kEezd4yK9WQ4rs52abPqphdFo/ylC9MlV4AroG
         OV5WzX5XyV2aKOS137363avl7oWalYoBeXJRY4XQVXGt7TgD+WPlkFauBdAk6F6znBLl
         sxs+rOgi0o2pMlfOobBdHpZPixXo4lTSoIAo0cafKsfcYeRxSXFI2T7dgDTaTMh6MiVY
         9frQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXdc0px50wwsNUgPCi6SkaZSlO4rVtuSMpeTWBx6D+3ER6svBWDzmgLUMPxrVsyqEaly0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBg8eZJGD5DtEGrcbrRcB0r+UgOdoJFHPh/r5xCw0XWKbwOPI2
	A7Nua6wwfTwE6GfOxzrcQj5Gh7bFAhDVXIC/qNcWskvbTNu5KkKdPoCAmZHxUD8d2dQ6MCG320a
	4d0oG1vU=
X-Gm-Gg: ASbGncs48UesPWEP2HMyREch/EAWfY1xykYAPWt20T9Hxu3TRud3bfJV/9ebfw3uP6b
	utYO9w8p1cSSlDGpr7yG01KaaGys1/0dlRTSHXeq0+/FLbppG5jRYTehNCIK4PYstZHzGaYn3nw
	kb0klZ3FPq5Fs54a0Y/rTo+1f5qVe0o9wxnJI6TTlWeZ20BWq7Bfcc95luQIrG6p3wPjexTjggH
	azMOKgY5OtoX+uHvy1ZBuhuzhDy+ok4C0himaAj8PhDePL7OmZQJlpuzaPeoluwqEKSFn017xhl
	KEBdsiz7olHOTb9hRPMcT+9HzFxEIUmAe4dMzjOIRXoKf0ZbeK652YnR1oqxysEF7mz2sLg28aY
	dftsg82m7xAPW6JSIrtIDTWyqTSg7bOYgjHkbUp+FTJVvQrZPLaA2bREpRoJbaWZt5YmInpOM
X-Google-Smtp-Source: AGHT+IH4vd4In2kzWwGEZFJUUiWb24dJwxy++Km797kPlTp/bM7jj4kq57+pnNSYzOxpWd5rVo5GMA==
X-Received: by 2002:a05:6402:254c:b0:609:241:1deb with SMTP id 4fb4d7f45d1cf-61285920f44mr7893218a12.10.1752777363714;
        Thu, 17 Jul 2025 11:36:03 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611f9c9c425sm8750904a12.12.2025.07.17.11.36.01
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso2414286a12.2
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmCa/G1/KTCKLXCFSyM+1BlLGZ6liLKzrcysHfR/CZXBX2Bzg+noJLxO7NByjHoZyc/kk=@vger.kernel.org
X-Received: by 2002:a05:6402:34d6:b0:608:6754:ec67 with SMTP id
 4fb4d7f45d1cf-61285bf3730mr7487110a12.30.1752777361408; Thu, 17 Jul 2025
 11:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123916.511889-1-bhupesh@igalia.com> <20250716123916.511889-4-bhupesh@igalia.com>
 <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
 <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com> <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
In-Reply-To: <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Jul 2025 11:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
X-Gm-Features: Ac12FXw_kNIbTRokcm7T_S0XklVgvPSebW7F_Vtc8CMTkt7DzdcMPhb6rT3qzqo
Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bhupesh Sharma <bhsharma@igalia.com>, Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, 
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org, 
	willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk, 
	keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org, 
	jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org, 
	kees@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 13:47, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> But given how frequently task->comm is referenced (pretty much any
> profiler or tracer will capture this), it's just the widespread nature
> of accessing task->comm in BPF programs/scripts that will cause a lot
> of adaptation churn. And given the reason for renaming was to catch
> missing cases during refactoring, my ask was to do this renaming
> locally, validate all kernel code was modified, and then switch the
> field name back to "comm" (which you already did, so the remaining
> part would be just to rename comm_str back to comm).

Yes. Please.

Renaming the field is a great way to have the compiler scream loudly
of any missed cases, but keep it local (without committing it), and
rename it back after checking everything.

Then just talk about how every case has been checked in the commit message.

             Linus

