Return-Path: <bpf+bounces-61826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76643AEDE86
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B45400500
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB248285049;
	Mon, 30 Jun 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d09pdPHN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48551CA84
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288654; cv=none; b=dA9HKSkPEuqHHVRFIrAUa6P9ZI4aXTm2mps5z5oL1Jj9xwDmhKWWsKKiCFbPnTexvCwxrvSX0DI8uzEK1KV46+oajLReJrycMoUt5cFQiI04ZJxl2iRO1VzLgqg1QM7eJkKnNLJbC5XmgJWuqHigXD5HTgkCwaRAqNDt+IEwxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288654; c=relaxed/simple;
	bh=ds/u0XttWTgQv5sevZWCbsBAuW/0TKp3tCk6NEWZ8do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLN7OL2HgomoTeVLkHTOPmpnVgZiCqs03GoaVLV+ZKo2zW+7QU5jgiQdNOmj97DlwHxo3TeyNppUvaMTCNd2E2Z+1jKrTY9WNJKNbG6d9GxrfFAAHkG65vVrJMd3h89YN9lmlc2LzoJK9XPqZhvDATsweat8hI1pZQBuveXcnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d09pdPHN; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae0d7b32322so349249566b.2
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751288651; x=1751893451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=scUh17P9KXky33Nk6z3Pth1Xg70a2cmpEueJL5Je+nQ=;
        b=d09pdPHNNvVL8WTpqzp8MePeXXlkCx7//OYEQj84kPsPavayakxBAkvPhv2k7Lx1Kj
         ZGaQdbWH40COT9pBq+oUDw1LvQEcW+/xxmPY6JeyzdH8B+RwAgMwwA/6nb949y2AwsDh
         dWMnkO/f1S2m0IxiN/Ud7SNCFpaOoHl8uNUKvyWeazmDH3InEgvDISsH9dKU++HhJwA7
         NZQe2laQJoATXypK3O/J2L0JkcqmBL7fky/aTCEP1aDiKnZ0/PdPvCS9TZfi9crQlGSv
         esFvaGTAdZDgFtMqI9qBJ9ncBoMf2uxJKi8+M2xTaQi86MHXFr4RLWc9LoieOr8nrfuC
         EE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288651; x=1751893451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scUh17P9KXky33Nk6z3Pth1Xg70a2cmpEueJL5Je+nQ=;
        b=EZoupgf/5yxoqko+7cLmW/KCgx0PpkEk8gy9Dw3JGW933xOsYW7nJKtdAgOpUPSr0v
         XcQeJAVlHgQXum7RUVI+rGdtLAWdEjHPGd9yxPuwRQ9hcvXOjMnBJ22LT8sBh7jFCGbB
         hVcltrB0xaETfGh7Fh5sMk0AQ+dKGkhRGjGJfzR1uc3dHuZXDzPXqjSoYKHDgTbd4VeQ
         9iuy8MW0W7dae5JIztX46je04cdlRV6Ex7nLPyEUkrC3R/VdLEYxCJeFHTR9ocgnjjaz
         6c6jD1SxdbRfgpq/i7SUT2GHjDAnjyMq/VcatwY3CWRNX7qSUUKdohbRs0KCuHaYDWOX
         8B/g==
X-Gm-Message-State: AOJu0YwjKGBuosdQNJ+sbIvkwluntUMMLhm9QUfitv/CS1Gzqy2B84wp
	yv6OvnbmbsLmWipzIl+U7pqbM01p+trN7r4utAVkbi+fmpSV6IBz8G4c46tBzJk+jq8Gq+qP0n5
	tZvSAop12ILCJ0Klf5yF+KRwnPJlgiwI=
X-Gm-Gg: ASbGncsUFL/J71s7K057hjLAVDhJMWZIVQRga5+2AGaHIJMj8kcSH0LTtWYFmrKYjBk
	DRCKrrsJ9V4F2BEiliNoa61RquEgdADNLbiW0RIhhjEzMLIpWX23aoVCc6P7L044V1h3Xt3fZJk
	QmVS4LsuiPvLXtIvQfA261KXkHFtXj19h2kiLtT4gFQUDIrsbR9ZvHZ0jnUcXRsoPKrTaS7pA/y
	X+e
X-Google-Smtp-Source: AGHT+IH2RXKy4Ei+T1gdaRC2N9jVfop8KFowuJF/c375r4ye7Fyfnzcav6KBJKD7g+fQzXA4SmjX85H4lNmpH27XexA=
X-Received: by 2002:a17:906:aada:b0:ad8:9466:3348 with SMTP id
 a640c23a62f3a-ae3500dfa77mr1037954666b.36.1751288649837; Mon, 30 Jun 2025
 06:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
In-Reply-To: <20250614064056.237005-1-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 30 Jun 2025 15:03:32 +0200
X-Gm-Features: Ac12FXzTNMmDdVztk4YKthblWC9SSi_VqOy4Tf2H_VHP54Yn9eyCBJaaTE15mYM
Message-ID: <CAP01T74kVb-Nnxd=en9T3Oab7DnwArzmNRUMdC=_khr9_f0TYQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 0/4] bpf: Fast-Path approach for BPF program
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jun 2025 at 08:41, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> This is RFC v2 of
>         https://lore.kernel.org/bpf/20250420105524.2115690-1-rjsu26@gmail.com/
>
> Change since v1:
> - Patch generation has been moved after verification and before JIT.
>         - Now patch generation handles both helpers and kfuncs.
>         - Sanity check on original prog and patch prog after JIT.
> - Runtime termination handler is now global termination mechanism using
>   text_poke.
> - Termination is triggered by watchdog timer.
>
> TODO:
> - Termination support for tailcall programs.
> - Fix issue caused by warning in runtime termination handler due to
>   https://elixir.bootlin.com/linux/v6.15.1/source/kernel/smp.c#L815
> - Free memory for patch progs related fields.
> - Include selftests covering more cases such as BPF program nesting.

Thanks for sharing the new version. I think there's a few
implementation issues that need to be sorted out, on a high-level.
- Move arch-specific bits into arch/x86 and ensure all this is not
invoked / disabled on other architectures.
- Drop the hrtimer based termination enforcement.
- Drop extra prog cloning, since I don't see the need anymore.
- Add an early-short circuit by padding the entry with nop5 and then
changing it to return early.
- Other comments left inline.

Code patching when not in_task() looks problematic, I will think more
but I guess deferring work to some wq context is probably the best
option.
We can potentially be in an NMI context as well when we stall, so
either it needs to be made safe such that we can invoke it from any
context, or we defer work.
Right now, the invocation happens from a timer callback, but we may
synchronously invoke fast-execute termination request for cond_break
timeouts or rqspinlock deadlock.

Otherwise it might be simpler to just swap the return address with a
copy of a patched/cloned program on the local CPU, and replace
prog_func globally. But we discarded that approach.
Doesn't feel right to go back there just because we can't modify text
from any context.

In terms of design we still need to figure out how to handle tail
calls and extension programs.
Tail calls are relatively easier, since they can potentially fail.
Extension programs with the current approach become tricky.
If you had cloned the program during verification and replaced the
original with it at runtime, then any extensions attached to the
program do not get invoked.
Now, since we patch the original program directly, it's possible that
we still enter an extension program and end up stalling there again.
I guess we will end up patching the extension program next, but it
would be nice to verify that this works as expected.
Other options are removing the extension program by patching it out
and replacing with original global function target which would have
been patched.

>
>  include/linux/bpf.h                           |  19 +-
>  include/linux/bpf_verifier.h                  |   4 +
>  include/linux/filter.h                        |  43 ++-
>  kernel/bpf/core.c                             |  64 +++++
>  kernel/bpf/syscall.c                          | 225 ++++++++++++++++
>  kernel/bpf/trampoline.c                       |   5 +
>  kernel/bpf/verifier.c                         | 245 +++++++++++++++++-
>  .../bpf/prog_tests/bpf_termination.c          |  39 +++
>  .../selftests/bpf/progs/bpf_termination.c     |  38 +++
>  9 files changed, 674 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_termination.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_termination.c
>
> --
> 2.43.0
>

