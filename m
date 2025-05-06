Return-Path: <bpf+bounces-57576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A8AAD117
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916ED4E68FA
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018621ABA3;
	Tue,  6 May 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icnWH/Yn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBD18C034
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571534; cv=none; b=rkV7WN6UnXWxFVKMj7kg96WxftBOdFQAI8OsoOqBfgjMMNmvT6u91RmOq9N2i2JVmhOsopc05k5qMecSrcJpUr3JSJD1VNlaIHvIc+rfx1nrv6Yr8faqyRy5NJo21krbsKJzsCcTbIncoGhp6gUfzDA7iH9m8IcCYqb+N2PMHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571534; c=relaxed/simple;
	bh=ItF5bpElyejTv9OmoXazSp/LOydS6iVrC0CMr9QhzcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb4xlcV5nI/JngLVhsEmiaoxYOlJgrAZ3fqmfLXxGeck3gE6n/4C3t2wzfIpa5ZCMprGmuV+/GqLd+7H0MlVXvTL+yHsTfF+HdM1iFfhMqOC/10SKemnq57Yve+KDN/D1eLNqh5m6DwZagHeRR5g5DyWEUMZdpEx9QWAw3OM+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icnWH/Yn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso28204445e9.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746571531; x=1747176331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQDRAa0gDw2vyxx39TvTrNUdPJBKQDWdaFQqgsQb94I=;
        b=icnWH/Yn+k/Twkx3WEABsAEw0shlol4vgcCz8EUDORTEc2K9SGqmix+wAyID0KWOiy
         vgYMmQNBAeiQ1t88QdA49sUY1TGBgfPmOJBzbGT4YoyEIet7wK2d8M06Hy+I8CmzzH6q
         tx3x+rE4PZ6xLMAerC78wwHSo6pgPgM/Pm/+aFUO3jsewhqEW5YLPyLwhjRzhlrq6LHT
         L5sUh1+OiGi+V3Jz9Rz+eaNE3sTKAmIYp9cQ8akMbeBgDCUZfgOYQq2ivuEk4nKVCtl2
         tzvi/ZfkXP94Xvs+w38jtjMtHwivzvXacb+j+niFNl3B5NlJlTfMZlzWweUReEP7iOIY
         DQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746571531; x=1747176331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQDRAa0gDw2vyxx39TvTrNUdPJBKQDWdaFQqgsQb94I=;
        b=DGQ4c6L1YC8TOABOKz3SQQRX03jR9VL9pd+9P/jS8J2JMaFt/ww0GQOnAVllF7ah0j
         0WU1qUhkJNJ0n0osAZM2X0L4WComU4tlXYwZ15ei3RZDkisk/EyAmqT/o/fT/0dkb734
         tLg+MejQL4z4ITLy0OWL/U0IIdKfiai47gupCyZ/LZ8FaKHzpm7sOnUKErD84gjwmbBy
         wJTGunEPqn9aLi79+9AZZeduUDQ68RxoMw7cSrfWkVmIgCZ9T2nB5tQgnrBG+xQgzoRt
         7yYrMS7GdITXGUtT2sJOJ3qWb2S6WNB2z1xvHgA+gIdS3Wkn0k7LY56zJaMRxHZVD/Io
         PE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWbLata2WuvnGsSPbk+D0bUsJ0dNuLIGCqG9ujLsKXQV/GRpDRPuVkioQA649YLmv8s4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmipBjMgxGdmhibEtyQEswk8qJtkOFBMHef3/Rr7QGKqFYQ7Y
	F2EjAjx+1EhmjT1+I3j96ohx+pAATt/lBr5jhrKf1RuI92SedQhnpVuVMW93NP2oglajV0TJFhR
	AgbI6TWWEriMH6kxg6TTq64yZfkI=
X-Gm-Gg: ASbGncui/rsuSjedaUREiWIcEJc9YdD8rrKeDG0R4KAUUgRlBTO7KExE/kkJ25FwBnK
	uI1egaZDQvtufRp5kvMqZLJXcMbuYsuhvwAIpsGCB6AB2yAyYr7wTpErrx6J4ciW6Cw26B/BEzY
	OYHnNL04Hzc7rxnnoOkBkbqBeVkReq57hFPfMAKNWXZHv6TGijbemfbC59fmK0
X-Google-Smtp-Source: AGHT+IF7SSrRC0WDkscLJAfJt1TKgOwuj33O3cjXi5mKWWhUh3bepT5wyOlVmhZ/9GyrbMYa5v9s9FetJMchz7eS/Ok=
X-Received: by 2002:a05:600c:3b8e:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-441d44c473cmr4406095e9.13.1746571530593; Tue, 06 May 2025
 15:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <CAP01T75B87Vnq-kdq6gaNXj5xeOOiah-onm4weEZA=jm8W8JVQ@mail.gmail.com>
 <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com>
In-Reply-To: <CAM6KYsuk060Fv43Djp4q57AwBcmmkHBitGgfSsCJZwbGqRmQEA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 15:45:18 -0700
X-Gm-Features: ATxdqUHY8F-Gcug1FeD2U7vqMtI_SrWEVlzoAI9TUb6Ooe7eWlftLwSQmdeupPE
Message-ID: <CAADnVQL_+5FiOwNEnaYZ-i52r4jDiStboWxA9VycARFboOjx6Q@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
To: Raj Sahu <rjsu26@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, 
	doniaghazy@vt.edu, quanzhif@vt.edu, Jinghao Jia <jinghao7@illinois.edu>, 
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:55=E2=80=AFPM Raj Sahu <rjsu26@gmail.com> wrote:
>
>       2. A BPF prog is attached to a function called by another BPF progr=
am.
>              - This is the interesting case.
>
> > What do you do if e.g. I attach to some kfunc that you don't stub out?
> > E.g. you may stub out bpf_sk_lookup, but I can attach something to
> > bpf_get_prandom_u32 called after it in the stub which is not stubbed
> > out and stall.
>
> We have thought of 2 components to deal with unintended nesting:
> 1. Have a per-CPU variable to indicate a termination is in-progress.
>     If this is set, any new nesting won't occur.
> 2. Stub the entire nesting chain:
>     For example,
>     prog1
>          -> prog2
>                 -> prog3
>
>    Say prog3 is long-running and violates the runtime policy of prog2.
>    The watchdog will be triggered for prog2, in that case we walk
> through the stack
>    and stub all BPF programs leading up to prog2 (In this case prog3
> and prog2 will
>    get stubbed).

I feel that concerns about fentry/freplace consuming too much
while parent prog is fast-exiting are overblown.
If child prog is slow it will get flagged by the watchdog sooner or later.
But fentry and tailcall cases are good examples that highlight
that fast-execute is a better path forward.
Manual stack unwind through bpf trampoline and tail call logic
is going to be quite complex, error prone, architecture specific
and hard to keep consistent with changes.
We have complicated lifetime rules for bpf trampoline.
See comment in bpf_tramp_image_put().
Doing that manually in stack unwinder is not practical.
iirc bpf_throw() stops at the first non-bpf_prog frame including
bpf trampoline.
But if we want to, the fast execute approach can unwind through fentry.
Say hw watchdog tells us that CPU is stuck in:
bpf_prog_A
   bpf_subprog_1
     kfunc
       fentry
          bpf_prog_B

since every bpf prog in the system will be cloned and prepared
for fast execute we can replace return addresses everywhere
in the above and fast execute will take us all the way to kernel proper.

Re: prog cloning.
I think the mechanism in this patch is incorrect.
It clones the prog before bpf_check(). That will break when
the verifier does different logic for stubbed helpers/kfuncs
vs original. The bpf progs will not be identical and JITed code
will be different.
Instead the verifier should collect all code points where
kfunc/helper should be replaced, then clone and patch
after the verifier is done, and then compare JIT artifacts for both.
JITed sizes must be the same, and prog->aux->jit_data should
be equivalent. We will need an arch specific function to
compare jit_data.

imo that is the next step in terms of code.
watchdog/trigger_of_abort details are secondary.

