Return-Path: <bpf+bounces-35529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2525B93B551
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46821F22C46
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B1415ECED;
	Wed, 24 Jul 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx3+9w/M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8B29CA
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840067; cv=none; b=QZH+slktd6RTpzbRwl6tBm8CEOePUZ1G4W17u9+F8+gPowf3FjbWPUZBMD9u48vMQEM+Ic9X230Ukx3zaxvF8zq3sokGzLnh4Si0c6gVxixZOWXYgGvBUfEW1dIzWeGuLFbhyp0cic1XUn3hSMu4Oywjry6iaSAgtreZb2ggl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840067; c=relaxed/simple;
	bh=wPrf3bpOYdyNSOf32i04pqx43rHY3yUf6g3HnlLLY3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNNYKJB3lcPds6afkkwIYYgHnLTTKJ5b+EePf2HqoUrzodV6hKVQDb6motPG3+bgLZLyf5ScT0zFldJor3JzqEvprSgN+2OUBg7FtOEBDXnzdABVr7CzHMJ8aJCl0giEu3Q2hT68IImT6SXFYq527xYsa1fmUGVhKhcXAsAq+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx3+9w/M; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3683329f787so3891271f8f.1
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721840064; x=1722444864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCObS5s6JwzipkWLPwVrfAC28ySk0WgvHQRELOVz6NU=;
        b=Yx3+9w/M+mTm1qstKMLgEgPcQCvM2cEnZtomV8zRig7lW7IrEhDR0qzHogQuOdelBB
         NwsdhvuaApDvE2IBHD5WNRNejcYWiuCxONOTreBNt4jb76nXCfcrtIutcu5Y1T+0n62V
         RfElH72sZUSzUSNLjnxasBUZ+HKTm0npVhaYLWAXkwS3cZ8V9hoZLai60PAQnl/57l2I
         k21DvHLZ2LW31BlCmAprYvydnq8tA9o5mhBArBQpnvjAxniXdBK5j7qY7h181xXuwnc7
         4wz69o2TrytWxrcOYY7H36FuMY2Ydgp/HboS9/a/MB51Ci9wLqBszn23fkt64dYMVvpQ
         jXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840064; x=1722444864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCObS5s6JwzipkWLPwVrfAC28ySk0WgvHQRELOVz6NU=;
        b=wDov58Z6W+xuRPEMGwcUwzpLU/MH1I9v8XoBAv2s+VL6BJDUrfZSKcGDyqLKrWqm2e
         CFzrXGn6MMKKVSmHBLvZB3s7/K1N7FnWM58b0s980R0ckWWXzID+3uTbFVAfO9Ksic2U
         oQz0eVOjy3MayveHoP5xHRjxlLOPBYHlyUoHhvq1o2Xw+VroDXMgtNw1/87SIh3cBl/a
         Wkih1fBApuvK/v7JzokO5gAQ0wYDvY73958u7p6qDPdZxKXEvrw8Qq261njm/Nf0R0+P
         vhU7f69t8dh9jum1jtPY4rExUI312vhzpuet+KZkXECZh2h0RgAUpuPCjipAT553tciC
         5BMw==
X-Forwarded-Encrypted: i=1; AJvYcCWgQDdfwUKn0QMl2ZdLRbLYtAR02PtZ4WauYqaTXrgYx0zKuVwARYt0bUBq6pwqC2YPIIroE3FGZyViDgGMZ9iUQrdU
X-Gm-Message-State: AOJu0Yyp/IlBvLMinTAnf87zoqUgBdwSNwHsvOeZad8aNTfwjXr21LYh
	as5u00cRey0jOxf6j5werPIQp95/1HgCaGCCeSwdIh0bwHuA0e2tkI3sjDca8YOuOU8/XTqW/pV
	q0tt5dIehFdr7FacEVOAgVIxBXAA=
X-Google-Smtp-Source: AGHT+IFkAD+IgLi7lK/SQjYbBsLxuqJXMwcPbHTS4ES+vGyNMjkgwa/40+jufyKlURRBJwiUwXZYwWtwqZcmLXbD97g=
X-Received: by 2002:adf:f489:0:b0:367:96a1:3c91 with SMTP id
 ffacd0b85a97d-36b31a459femr193588f8f.62.1721840063878; Wed, 24 Jul 2024
 09:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <036e4320-1e22-4066-bfa5-42b1fa290a39@linux.dev> <f12db0b4-bcd4-4fb3-a0cf-35c96c2b549c@linux.dev>
In-Reply-To: <f12db0b4-bcd4-4fb3-a0cf-35c96c2b549c@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jul 2024 09:54:12 -0700
Message-ID: <CAADnVQLCk9Rccp3UPVzn3qrEzx1kPxqYv4QVWUpw1pSE1PHuZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:09=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> Discussed with Andrii. I think the following approach should work.
> For each non-static prog, the private stack is allocated including
> that non-static prog and the called static progs. For example,
>      main_prog
>         static_prog_1
>           static_prog_11
>           global_prog
>              static_prog_12
>         static_prog_2
>
> So in verifier we calculate stack size for
>      main_prog
>         static_prog_1
>            static_prog_11
>         static_prog_2
>   and
>      global_prog
>        static_prog_12
>
> Let us say the stack size for main_prog like below for each (sub)prog
>      main_prog // stack size 100
>         static_prog_1 // stack size 100
>           static_prog_11 // stack size 100
>         static_prog_2 // static size 100
> so total static size is 300 so the private stack size will be 300.
> So R9 is calculated like below
>      main_prog
>        R9 =3D ... // for tailcall reachable, R9 may be original R9 + offs=
et
>                 // for non-tailcall reachable, R9 equals the original R9 =
(based on jit-time allocation).
>        ...  R9 ...
>        R9 +=3D 100
>        static_prog_1
>           ... R9 ...
>           R9 +=3D 100
>           static_prog_11
>             ... R9 ...
>           R9 -=3D 100
>        R9 -=3D 100
>        ... R9 ...
>        R9 +=3D 100
>        static_prog_2
>           ... R9 ...
>        R9 -=3D 100
>
> Similary, we can calculate R9 offset for
>      global_prog
>        static_prog_12
> as well.

I don't understand why differentiate static and global surprogs.

But, mainly, +=3D and -=3D around the call is suboptimal.
Can we do it as a normal stack does ?
Each prog knows how much stack it needs,
so it can do:
r9 +=3D stack_depth in the prologue
and all accesses are done as r9 - off.
Then to do a call nothing extra is needed.
The callee will do r9 +=3D its own stack depth.
Whether private stack growth up or down is tbd.

The challenge is how to supply proper r9 on entry
into the main prog. Potentially a task for bpf trampoline,
and kprobe/tp/etc will need special hack in bpf_dispatcher_nop_func.

