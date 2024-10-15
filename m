Return-Path: <bpf+bounces-42102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E36A99FA75
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 23:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F7DB221F3
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723071DD87C;
	Tue, 15 Oct 2024 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMk39xMJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C971FDFBD
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028403; cv=none; b=YEkax7IFxtYruSiARdEgv+9SEfgaAY4/vTHIQQaex9rjW/grqr50+4JHLY8Ot0H8gBzzoRHHXW+qDL+1HpH/e2ZzAW/ssSPPhV/w5s8WgaQHQgUEk5n+GJBvb00OrNiaK3vwVXoKPbWvi8OtJ3y5/Rrf5TachznwKq6GRLqarzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028403; c=relaxed/simple;
	bh=om1LCMkHlsFrVT8QeQeKmnL1vATYlbV+Ov292ng3+TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJrGUoXRX7MkGkRc/9dlbm50TYDRua7KQtVGmYhp0CZf7Gh99RLG3oltr2/DKCDpbvRMpq0Toa9AEmIlMPCgDgW+PrNUbFRSMtIDMJFEpLqAg5YiQjnBWNCpOr0rriTxa8LixTol7wcvn4DrQAeANsRnBFiKEHIw+L68G0Lnh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMk39xMJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d58377339so4634231f8f.1
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729028399; x=1729633199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ3z8199d5KhqXICiG009SEZu7DCq2Pt9o5Q4AkhuJM=;
        b=lMk39xMJhXe3hKttjTIUWJMQD+3NrCXTnPkp/qkJquY11JgDyIMRZF7ppWPQ0VyKBs
         LhULDjU7m813F+InGT0Vh+T4pVFV/bTsCyuA7THhRGpMvBJXcwYTICy594TQLFb/TgBy
         qjMVtOQlzyo0PEPTfBKZQgyPTNXjoOGPtLOLc2GE5boPgXVWIXQkxDySRqQDk8x5v4xJ
         uHSAZ8zgoUdzMbiqAKSTgIJHXTt9///zpIIz1Dh5mQ16QCyOyQ1QS0Oow0+vkLETEUBB
         mFWlWEZCmUBtNR6u8oEV4PYRO2X8LjmQZgfHBuVLvqUXs4+Xl09IVs4us8RsyIPcx8y/
         Gfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028399; x=1729633199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJ3z8199d5KhqXICiG009SEZu7DCq2Pt9o5Q4AkhuJM=;
        b=csLY4skNej4dGBkma2JcTY4j01J7ENMXBxBNZ2WljEt9ndoAvC1mY+GeedWSA9Kp1c
         SPmaDtfR3srlKWHVDqX9ubyZqngFWsO620C4WM1/Pmpa8TSzNbZ7Zt1PIDa8Booxnrju
         nb3NKmmKznuPQJ55U0JHKoW3vGdBoO7IKIvVPOhT9S1XAfpwp3rVQ5wM9rlkrv2hnxii
         UKBY4KGTciDB64kdyrmpGWCKHmPmS5NBA50eIAeOPSghSGbIHSdzq8AZZvRXV+6415fh
         WbS3Jr+oN6PLWvTA0PDoUPU5vLsMhRZF45k28SMERVkQxnVXXvX+CVgB6kPk5AGSH0cI
         THQA==
X-Forwarded-Encrypted: i=1; AJvYcCU4VCq0nOhC/tQpODT7R/AzNfpAElWqwsLn3OvYmAyotaD/eMNnQhI/+WXW4xwFreCQcUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypcIfHHq0Ev1HB3GJfZX0UvpHut22uYkv1yRYsVaqVAaV1Ss5b
	fg0OiOo0Lm/qnDSF3nvGTlYtfL8BfH6oGe5wcuJTB8g+9aoffbqTNmBlWOdIB1xkUfunDEPBy9c
	NaChuNv/8eD3a+AYjeMBuGW0slPw=
X-Google-Smtp-Source: AGHT+IGpPpAI07AoHH7OOzf0I/BjKDAQy0XK+XsFBbHq+5Y1BR2GPZ4xOlhDsApIb1Z9n+rbEfyCfGKBNJ2GDRFSJPE=
X-Received: by 2002:a5d:5d84:0:b0:37d:7e71:67a0 with SMTP id
 ffacd0b85a97d-37d7e7168e8mr3124779f8f.9.1729028399424; Tue, 15 Oct 2024
 14:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010175552.1895980-1-yonghong.song@linux.dev> <Zw7eYb9XZYqhazlf@slm.duckdns.org>
In-Reply-To: <Zw7eYb9XZYqhazlf@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Oct 2024 14:39:48 -0700
Message-ID: <CAADnVQKegqpSbDjDUSZVz96z+d1SJP-4dfdCQ_2Qb_VHQYPfRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/10] bpf: Support private stack for bpf progs
To: Tejun Heo <tj@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:28=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Oct 10, 2024 at 10:55:52AM -0700, Yonghong Song wrote:
> > The main motivation for private stack comes from nested scheduler in
> > sched-ext from Tejun. The basic idea is that
> >  - each cgroup will its own associated bpf program,
> >  - bpf program with parent cgroup will call bpf programs
> >    in immediate child cgroups.
> >
> > Let us say we have the following cgroup hierarchy:
> >   root_cg (prog0):
> >     cg1 (prog1):
> >       cg11 (prog11):
> >         cg111 (prog111)
> >         cg112 (prog112)
> >       cg12 (prog12):
> >         cg121 (prog121)
> >         cg122 (prog122)
> >     cg2 (prog2):
> >       cg21 (prog21)
> >       cg22 (prog22)
> >       cg23 (prog23)
>
> Thank you so much for working on this. I have some basic and a bit
> tangential questions around how stacks are allocated. So, for sched_ext,
> each scheduler would be represented by struct_ops and I think the interfa=
ce
> to load them would be attaching a struct_ops to a cgroup.
>
> - I suppose each operation in a struct_ops would count as a separate prog=
ram
>   and would thus allocate 512 * nr_cpus stacks, right?

It's one stack per program.
Its size will be ~512 * nr_cpus * max_allowed_recursion.

We hope max_allowed_recursion =3D=3D 4 or something small.

> - If the same scheduler implementation is attached to more than one cgrou=
ps,
>   would each instance be treated as a separate set of programs or would t=
hey
>   share the stack?

I think there is only one sched_ext struct_ops with
its set of progs. They are global and not "attached to a cgroup".

> - Most struct_ops operations won't need to be nested and thus wouldn't ne=
ed
>   to use a private stack. Would it be possible to indicate which one shou=
ld
>   use a private stack?

See my other reply. One of bpf_verifier_ops callbacks would need to
indicate back to trampoline which callback is nested with limited recursion=
.

