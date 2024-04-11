Return-Path: <bpf+bounces-26486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFD08A06E0
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 05:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D022842F3
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5D13BAE3;
	Thu, 11 Apr 2024 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqndJBGr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0991B2629C
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806980; cv=none; b=TpJncekwru4YG0FoQgvvsWPYOQUyKOiNwV/xUYilYCw99GcbPFvCIIg14HfgyzFgsGqsVVkFturUtFiSGwGWraydL0swMFUfr4mFuE2l+pYjWuKV9YGOF3vviZ9OnMQfOvt72Kd2NQAQa55x6J+tqMscPTpn6mQ5ODfGKBRbNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806980; c=relaxed/simple;
	bh=YFTmkRqsCR8cxEPOUVZ4Mqp2vKmcDoYpAsjo976uK5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7A8b+GyYQjljyHD37Q9ZYXwdER2z+jdTQqeCGcm5LrKWnd9yF0OzRvfhHjxm25iz86p2cbUxcoCgv4s1Ri3FIcerGgJhb0hxtgnExemgOHvhlJTCnNRQQieTu8Iv7hdEwJHgqVk5tx4GbIL9qVjcwEqNU9M3HSOps/DcbVZLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqndJBGr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346c5b83c6eso47950f8f.3
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712806977; x=1713411777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSuZL3y4pr/nudklAeUf5iUbhV2Y2udQQt2vSsQeOX0=;
        b=WqndJBGrjBCuFvCuy+TU1DB4J6W6+pSruemhetTYfGlwjAFHCnjlVha501nDS6o0Hr
         wllsQieAmHilbTC2UM+0muRk+N7D8BWXIxDxf22+rgobk+Xv47FhzNxD6+6RPg+Xffrv
         NgRQb8tUpU80c9utAg/T1mATkARhvVSsMDyNKgkhr7SaBqVo4+6YQ+h28eR1iA0aHbeX
         W8sXXYWkdwOtLsN3YjFIrVTvzjqctdChyT8R9B5Y+4HAkEn8dAQnNSIXbbKFGsTj0w4Z
         iqoDxawSEX0hyRj5lu3h8UQ8Nykpo9+jItp55g/YZLR6q0HxGma/S5EG/EDCnPTzEPeV
         WRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712806977; x=1713411777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSuZL3y4pr/nudklAeUf5iUbhV2Y2udQQt2vSsQeOX0=;
        b=c+iBxWkHYPYfSdOplPXKoysyURgAIBmYGfWM4XhMohnR4s042tl1ewEmQPEnfdMxjQ
         Yp68a2i5Uxrd/A4BCp+d2c/BFIjjt/09v118E1o6i/aW1eTgqgR/xRutSmoqJMuj/1Gn
         WRkAFnPWA8h4u0EPrIPQCgswYQgvZrGsYJoqLurkoVgNOzQ7iqOJDY9s3rWsF0ZnBN3Z
         Uknxv/uVzgYPGg2w1Pxk+w7T2TtbXPXAQ7IJhra21qJbo6njS+tcDY9jkIDKmCZ2pJoT
         G6A+5EBnY6oWZnedfq9FKfU9lW/KrWEiNDdYmFkrZTuc8ICJsi6Qu8gnMV3UJ2vbmRG3
         NLRA==
X-Gm-Message-State: AOJu0YwMdM6ExTE+GEXkrbTShZwAxj3BKcbZhMaVqBbGIdgQOM1MkTcu
	G2qLhfKtLNgv1nvVluZfRigKFH/O3wFu1bRRB9LzzmvlzrX25xNjVWTQKQX8iCNTrWNI1vZqWLw
	c4zB8zf4Nz5V2sfyf4kmlHoZ+EE4=
X-Google-Smtp-Source: AGHT+IEnE1C3c2mrpzTchWZhKc8wzHKkLvxl0qCCETKUj0oYrI2LFIl8Tw3GqRkRXqA7fXh1dInLyk5GGgGcCVsh1KQ=
X-Received: by 2002:adf:f8d0:0:b0:343:d06e:51c8 with SMTP id
 f16-20020adff8d0000000b00343d06e51c8mr2863279wrq.18.1712806977040; Wed, 10
 Apr 2024 20:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402152638.31377-1-hffilwlqm@gmail.com> <20240402152638.31377-3-hffilwlqm@gmail.com>
 <CAADnVQ+vJyi6JFsck8KbyxvOuRvmAO5gVTJPwNiyNeBwzsHu9Q@mail.gmail.com>
 <55442238-33d6-4e7d-9dd1-e36da20f7c90@gmail.com> <CAADnVQKxnEBS7JxK8YqXaa1C0kZZ=KSyPmqiE79KuZbe8Y_7YA@mail.gmail.com>
 <6140d7a3-53c6-46ea-b812-d2f45ed2ca92@gmail.com>
In-Reply-To: <6140d7a3-53c6-46ea-b812-d2f45ed2ca92@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Apr 2024 20:42:45 -0700
Message-ID: <CAADnVQK1qF+uBjwom2s2W-yEmgd_3rGi5Nr+KiV3cW0T+UPPfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Pu Lehui <pulehui@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 7:09=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 2024/4/8 00:30, Alexei Starovoitov wrote:
> > On Sun, Apr 7, 2024 at 4:34=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com>=
 wrote:
> >>
> >>
> >>
> >> On 2024/4/5 09:03, Alexei Starovoitov wrote:
> >>>>   * Solution changes from percpu tail_call_cnt to tail_call_cnt at t=
ask_struct.
> >>>
> >>> Please remind us what was wrong with per-cpu approach?
> >>
> >> There are some cases that the per-cpu approach cannot handle properly.
> >> Especialy, on non-SMP machine, if there are many bpf progs to run with
> >> tail call simultaneously, MAX_TAIL_CALL_CNT limit is unable to limit t=
he
> >> tail call expectedly.
> >
> > That's not a very helpful explanation.
>
> I apologize for my poor communication skill. I hope I can help to fix
> this issue.
>
> Why did I raise this approach, tcc in task_struct? When I tried to
> figure out a better position to store tcc instead as a stack variable or
> a per-cpu variable, why not store it in runtime context?
> Around a tail call, the tail caller and the tail callee run on the same
> thread, and the thread won't be migrated because of migrate_disable(),
> if I understand correctly. As a consequence, it's better to store tcc in
> thread struct or in thread local storage. In kernel, task_struct is the
> thread struct, if I understand correctly. Thereafter, when multiple
> progs tail_call-ing on the same cpu, the per-task tcc should limit them
> independently, e.g.
>
>    prog1     prog2
>   thread1   thread2
>      |         |
>      |--sched->|
>      |         |
>      |<-sched--|
>      |         |
>    ---------------
>         CPU1
>
> NOTE: prog1 is diff from prog2. And they have tail call to handle while
> they're scheduled.
>
> The tcc in thread2 would not override the tcc in thread1.
>
> When the same scenario as the above diagram shows happens to per-cpu tcc
> approach, the tcc in thread2 will override the tcc in thread1. As a
> result, per-cpu tcc cannot limit the tail call in thread1 and thread2
> independently. This is what I concern about per-cpu tcc approach.

The same issue exists with per-task tcc.
In the above example prog1 and prog2 can be in the same thread1.
Example: prog1 is a kprobe-prog and prog2 is fentry prog that attaches
to something that prog1 is going to call.
When prog2 starts it will overwrite tcc in task.
So same issue as with per-cpu tcc.

