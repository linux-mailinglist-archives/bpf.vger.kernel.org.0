Return-Path: <bpf+bounces-68605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE6B7EA21
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF5D326763
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 02:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F942DF719;
	Wed, 17 Sep 2025 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMY1IgN8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A403223DFB
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075236; cv=none; b=BMOa9TDRshqD6EOr8gy2Lkun17cOFI+sWHZn2gSs2Ozm6/3f4jCyEuioyJEI15GPbx0mRzu+IzGR3/DQqMuR8YHMzo7lFNVOIawhpSiP6cHUT1lFnWW/E1UDoFb7ZjQm5GVLniZK1Ovkaah17POYD29dF47LmHtpYF1QpfG5x1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075236; c=relaxed/simple;
	bh=XkkxY+uWeiznbbKTcnWPQQ4KL6DI+cqikFVZUBx186I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fztyNJDg9P2rpT7zk1JZ8nZL0+Yz5xbll+66UqFuBvCC0azXXxvpoM3DojTzxmjnb5viSNbY3t5PBTmCoE6UREJYgozYITmBiepbWNeE/qE7iy6UN6Ce+ntEVj/LL8aMhIxN6CcIxui6rXZhvJSAGpCYUxcGUQDdIxPw9MK2l9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMY1IgN8; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso6965024a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758075233; x=1758680033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZiOnQxCURFhPiCC6IE+mRstZwiaZ5bM6DSquReBY9o=;
        b=dMY1IgN8kxstloiQWFj9gCKh3ls+sxQDG0znkxvKsOoBdeVZec/3h0XY4rBK6yWnBP
         78jfaJiihAMoXhfrN6XgGQUpbG78BWSZIYbPDszaKZp3cvaOXJJ0PQUYnXvm9+vtmP5I
         dD3AUxxU0KJbo41YOSs44cwa45t5ZUlkkUFzi5diJoEyHZvW0vEbCc1z4mmU/OuMrj+8
         fHcYdL2PnZv8VGhXHsDmlhUODLcsMFI8PnBbEzexlcN9P2kVRMrQvRTZs1C6aKSVjpcJ
         zbZsJIqkJybFdP3Qm+mZs7nfQOi0QtpJKXd7gyHE9UyvYFKwPHdKLRzjohp3lopvk7dd
         TAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075233; x=1758680033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZiOnQxCURFhPiCC6IE+mRstZwiaZ5bM6DSquReBY9o=;
        b=IkoEEb+xyqRsVPhXgLmH2DzR0y1V0+YlRq8OFXZ9hm5YV6y/5wznDUuP7JtjMtRzd0
         DdPSTBJhM/C1AvbYQalsrMvo7P9U4qFwc/XGcATCxrt48jPZI9VbUFX2alUd+CF24a5t
         NbVPstNaoQdHLEEN6FPoEa2G8O8ZefUO9d2FioWIu1PWdzJGaqdEtiRWLeNtuIr5uMDb
         Ws911QmmVo9xYK4oubME9bTtq5J3BWQd1wh1eEAbK7j1+8IGW+4NKQnpsVkclUMH+igq
         LhwB96PD++HPSL7JTq3VJSnXo5yAww24M8uVEyxGWmEg/DFJbUDxZGP0C2BWSelALnvi
         M45Q==
X-Gm-Message-State: AOJu0Yzkw3C0GqRURnW7ED95HzZ5SfjrZX0+slVWzG0VH4PTGkf82HYm
	Yk+8lcfSYX7ixt/w7aWIyB0w7Mr605KMnRJMiIn/6zseq3+A3UsIG/0QuQXj3iZRkVDPlfI7L1N
	wa/0fKpHDdqDdOmhgLP6nIuxQ+eD5L6I=
X-Gm-Gg: ASbGncv+nl2POssU610+WAFahn0cswddHDUSphEHBe5p63W1YWVxMB7GPAdwtgUQYOD
	ZnUc1nUQmkWdrDZjBJmZXQob+jA585Wnq8GT5TizoYQuRHvPzeL05EW+Y7hOwHFPo1+5K7L6goi
	qtGdqyoJopx28kb/DFzCFPbOE7zeit+NunQdNgdaUjIxT9bALKluSNLxapVXipOtj1pZjMkZSNW
	p93P93Q2A==
X-Google-Smtp-Source: AGHT+IGl1hvYPqDPzGwXOxJksRy4dwHluAbAFB0b8JD03uiJn4Y7rXVs762xOunME9M3UaKlIuZF/ey/HYBBaI+Pak8=
X-Received: by 2002:a05:6402:5106:b0:628:f23f:1cc4 with SMTP id
 4fb4d7f45d1cf-62f842319fbmr634388a12.20.1758075233349; Tue, 16 Sep 2025
 19:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907230415.289327-1-sidchintamaneni@gmail.com>
In-Reply-To: <20250907230415.289327-1-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 Sep 2025 04:13:17 +0200
X-Gm-Features: AS18NWCGU95qxmDenDo8nwelYax7bW2Aq6DltxPINS_UDNmmLdiuFDhvWkTyT8k
Message-ID: <CAP01T77_ehzSZVEYY3tbTkG6Az+=Ljq9gsKaXQjinO+FMhG7dg@mail.gmail.com>
Subject: Re: [PATCH 0/4] bpf: Fast-Path approach for BPF program termination
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com, 
	rjsu26@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 01:04, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> This is RFC v3 of
>         https://lore.kernel.org/all/20250614064056.237005-1-sidchintamaneni@gmail.com/
>
> The termination handler call from the softlockup detector is mainly for
> the demonstration of the entire workflow and also serves as a potential
> use case for discussion. However, the runtime mechanism is modular
> enough to be ported to different scenarios such as deadlocks, page
> faults, userspace BPF management tools, and stack overflows.
>
> The main changes that we bring in this version are: We have avoided the
> memory overhead caused by program cloning in previous versions. During
> normal program execution, none of the termination logic causes any
> additional overhead.

I think the bit missing from the changelog is why the sampling of a
terminate bit in various sources of stalls in a program was not
investigated.

https://lore.kernel.org/all/CAP01T760JcsZ0o5BfKZ7pi0viseocTQCUW6KjqbxzTW7TwXF9g@mail.gmail.com/

The last time we discussed v2 the conclusion was that it was possible
for all CPUs to simultaneously get stuck, such that the punting of
patching to wq or other non-prog context isn't useful in making any
progress.

It seems to me that the terminate bit sampling approach can apply more
broadly, to cond_break, iterators, bpf_loop(), etc.

Did you investigate that approach? Was there a reason to discard it
and continue with this in v3?
I am curious why you didn't look into it after the discussion in v2.



>
> Change log:
> v2 -> v3:
> - Cloning of BPF programs has been removed.
> - Created call sites table to maintain helper/ kfunc call instruction
>   offsets.
> - Termination is triggered inside the softlockup detector not affecting
>   any fast path operations.
>
> v1 -> v2:
> - Patch generation has been moved after verification and before JIT.
>         - Now patch generation handles both helpers and kfuncs.
>         - Sanity check on original prog and patch prog after JIT.
> - Runtime termination handler is now global termination mechanism using
>   text_poke.
> - Termination is triggered by watchdog timer.
>
>  arch/x86/net/bpf_jit_comp.c                   | 141 ++++++++++++++++++
>  include/linux/bpf.h                           |  77 ++++++----
>  include/linux/bpf_verifier.h                  |   1 +
>  include/linux/filter.h                        |   6 +
>  kernel/bpf/core.c                             |  67 +++++++++
>  kernel/bpf/verifier.c                         | 135 +++++++++++++++--
>  kernel/watchdog.c                             |   8 +
>  .../bpf/prog_tests/bpf_termination.c          |  39 +++++
>  .../selftests/bpf/progs/bpf_termination.c     |  47 ++++++
>  9 files changed, 482 insertions(+), 39 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_termination.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_termination.c
>
> --
> 2.43.0
>

