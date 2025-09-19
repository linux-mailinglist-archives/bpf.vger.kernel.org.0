Return-Path: <bpf+bounces-68882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B2B87AC3
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221011C84E4D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E21124503C;
	Fri, 19 Sep 2025 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVTHnMdd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB67262A
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247313; cv=none; b=LHrtAKmmbEPsYU+k9sTlTYkKo0+daTSACCcjKi2qGp4ytBcPvbVQfdhXaoR3vKWXqKOWAIWsgX1cYfvDkLkpXTVBYVfR9u8Wf3uQlzAmJGMTC16W2G+640EFRBJkYCoU7CWccwgyF9m7B0EJXMO7zySV4UAXBg26UuG1iETk5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247313; c=relaxed/simple;
	bh=GFt8pFuik9xBCtcF6v21dOZpA6lIwmUZgdZDpPfX3Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufq+uia7zCKQaDFxTaMjGCO+56m0PJSk6CaZf9ne6818VtAbf3cD0BXEGw7JK87fNlVC6E9OXAOSNwtp6rFos/XczTIoxpGf3W8A47YbIwISXCb3UiGNbSgD+R5MEUHA7FOAIBIcsHaRecXcTiT8XolmeskKEh6v88dCy00yi94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVTHnMdd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46130fc5326so10070235e9.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758247310; x=1758852110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5WUqAepWLoNLD7FRaeKdFUWeAJ0W7lZ+MsRWC9QyZ0=;
        b=NVTHnMddvk9fHECdZ/gx23JK+0qTWni77btsPMqs22zXWpMkbvwu46x6aVgSA9Wo+L
         aMTsXy6Rgsoyiig34Q3pfybCk1/GitHnqVZKOXOSO3/q5zwNqF4gmn/IciczNqPzIX0w
         Bkx6FTGVZJuAQtNaTju8K42cNJXVDvA0YhFJpS4MHTMD7WURfvC+Rc8crq665Uf86yVM
         0l1majrcIkuegjwH5JC7zogSyp5VdtyujYG98dLnVj6egleIz4JUiv8Ob0120oCLDRBW
         0EbxBNUC7k50hJHso68BpLY/n4OpAdmAFzOYQp64yfzWd5EPK44HdEvH+jmCY8WCt1XS
         61Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758247310; x=1758852110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5WUqAepWLoNLD7FRaeKdFUWeAJ0W7lZ+MsRWC9QyZ0=;
        b=v5Gccv81qJfoLvSlwZnq+3LYPtQbdV28vLEPLsLEQO35FV3ZgTOqFAdLpjYb4Pl06e
         CF2vwt5EQNmeGocxmMmMT13n76ACG2N3yAMOfHw5Nov1a7HZs4c8BsWfBCl2IPKBadH1
         8TAv7fBiv8gg6JwVFO6trwO8kKAbclWnw/emgd+9DRqQOm62rMc9+N9IgJ6AHINAsIGd
         J0vqAWk376KRcKx/jJF8cEJL625lNkRzWAr1tdPtqikDHY69PLEih7PbPQOe0qXuE2D8
         U1kxKGFtkCtEV4BtZ2G2ehkfpFC6qLtV2AgK7yHVmtny8fXeT2L7Bdddsf7NXgdIleSE
         SprQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWn7LoX20Rmz0026jhOsSCnHtT6wT/IY0hF1h4rYzsp/jy/NUo2LzzF3VFdWVSR40895Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wYAfayTqMHj2PG8cTAUiq0O8E773jSHcgMeo0OcXyJqmqlSM
	bSAlFXAhHxF2xudUXStdce+XRWMKOJCDFaaI4YyoQLo+zcaU9vD55L/dVTuAd55e6hUsutFTePV
	eUKrQ+zTUVJL6olVa8e1qM1ZhZ7YHy2udLA==
X-Gm-Gg: ASbGnctOPTJp1+tnRWuxZVyN4HZZNLa6539eJ9CxVosTK7MCC+EVN8cWPqFAio5gyxm
	ZN0fm2msonm0tfVfJrj2LBOF+2aArU1d4f0bsSEwxM3w9+YNKxE2Es5ClaCNw4ZOdWdwDcbBzq0
	zQhx7eowZe/TbboNVo7k1W93tw+dMxKr/vYdnGwuGBkXHRw6mU4qnhMpCs7xniLsI9j7s5+97d8
	hN5QnwfrMB70D4bBB3Zp/zyqUhMSaMhMfDY49PyEn9PZqM=
X-Google-Smtp-Source: AGHT+IGqrAFmcKNFldXwl+7lGTYe5vLdPKGJ3FDX6GFFmDnR/ksftzRaTmDcFLsw0OzFBwVfJXvS93pGqqn07g8Sud0=
X-Received: by 2002:a05:600c:3b26:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-467e7f7d558mr10524025e9.10.1758247309372; Thu, 18 Sep 2025
 19:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909163223.864120-1-chen.dylane@linux.dev>
 <CAEf4BzZ2Fg+AmFA-K3YODE27br+e0-rLJwn0M5XEwfEHqpPKgQ@mail.gmail.com>
 <CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com> <457b805f-ea5c-460e-b93f-b7b63f3358af@linux.dev>
In-Reply-To: <457b805f-ea5c-460e-b93f-b7b63f3358af@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 19:01:37 -0700
X-Gm-Features: AS18NWAUCzCGY0hlax5izykpElRA9BP19wAxU45go4krfvf0sGMlA8XbTCJNj8w
Message-ID: <CAADnVQLwV=fUkgLF3uTmevA97WX2FH4vG-7=97Px0H_WJOJieQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
To: Tao Chen <chen.dylane@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:35=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/9/18 09:35, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Wed, Sep 17, 2025 at 3:16=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >>
> >> P.S. It seems like a good idea to switch STACKMAP to open addressing
> >> instead of the current kind-of-bucket-chain-but-not-really
> >> implementation. It's fixed size and pre-allocated already, so open
> >> addressing seems like a great approach here, IMO.
> >
> > That makes sense. It won't have backward compat issues.
> > Just more reliable stack_id.
> >
> > Fixed value_size is another footgun there.
> > Especially for collecting user stack traces.
> > We can switch the whole stackmap to bpf_mem_alloc()
> > or wait for kmalloc_nolock().
> > But it's probably a diminishing return.
> >
> > bpf_get_stack() also isn't great with a copy into
> > perf_callchain_entry, then 2nd copy into on stack/percpu buf/ringbuf,
> > and 3rd copy of correct size into ringbuf (optional).
> >
> > Also, I just realized we have another nasty race there.
> > In the past bpf progs were run in preempt disabled context,
> > but we forgot to adjust bpf_get_stack[id]() helpers when everything
> > switched to migrate disable.
> >
> > The return value from get_perf_callchain() may be reused
> > if another task preempts and requests the stack.
> > We have partially incorrect comment in __bpf_get_stack() too:
> >          if (may_fault)
> >                  rcu_read_lock(); /* need RCU for perf's callchain belo=
w */
> >
> > rcu can be preemptable. so rcu_read_lock() makes
> > trace =3D get_perf_callchain(...)
> > accessible, but that per-cpu trace buffer can be overwritten.
> > It's not an issue for CONFIG_PREEMPT_NONE=3Dy, but that doesn't
> > give much comfort.
>
> Hi Alexei,
>
> Can we fix it like this?
>
> -       if (may_fault)
> -               rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> +       preempt_diable();
>
>          if (trace_in)
>                  trace =3D trace_in;
> @@ -455,8 +454,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
> struct task_struct *task,
>                                             crosstask, false);
>
>          if (unlikely(!trace) || trace->nr < skip) {
> -               if (may_fault)
> -                       rcu_read_unlock();
> +               preempt_enable();
>                  goto err_fault;
>          }
>
> @@ -475,9 +473,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
> struct task_struct *task,
>                  memcpy(buf, ips, copy_len);
>          }
>
> -       /* trace/ips should not be dereferenced after this point */
> -       if (may_fault)
> -               rcu_read_unlock();
> +       preempt_enable();

That should do it. Don't see an issue at first glance.

