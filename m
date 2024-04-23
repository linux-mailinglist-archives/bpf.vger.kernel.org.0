Return-Path: <bpf+bounces-27598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D98AFCFB
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 01:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBAA285B49
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 23:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225584644C;
	Tue, 23 Apr 2024 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvnbrcH0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFF44C89
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916733; cv=none; b=Ihxxkm1Koj2wjkHoco8vHn7O9z9wrV7xSj2w4s6eyIzm0aaRv/4g5nC1FReaWtCyQXlDC4TcIGmOth0FhJArf2ccfvNQuiW/mkJZfIUS4kUMfgPeIqzueUv/zScesWPFke1wJkW+72jUn2tvm01OB2HK7I8Cn91CORirE9aPkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916733; c=relaxed/simple;
	bh=PWloTt7+BMWtgc80mA6xrTmAAG8338LS6TOYWg57mr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiGkFm8XJqHHGD/uFhlPr3MOHwHZ2CH9fkjARzMP+CQEeMoqhAbn2ry2NrvJBeSPEiz2DuQAGE5fASSsJirzfsF8mt+4VYxWvgkIpXizSKeucx8EDW6R6V1yiaLy4LzLMYJ31X5ByootMuaxrvEQ3Stus0u9c+vJ6ZBAQT6oEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvnbrcH0; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-47a085dbeb9so2207796137.3
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 16:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713916731; x=1714521531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PWloTt7+BMWtgc80mA6xrTmAAG8338LS6TOYWg57mr8=;
        b=dvnbrcH0vTDgMGrj1/dvLLDG8TvPkM3H75qU5nR1oZFX/ppknpG/NGknbsCaXapCRD
         EzWILWViswHrChIqw+IjxOU2t463n8o4uW5zdmymf9Qj4fLpnO9TZnogkzo1v7eE0Ng6
         VBJ74bc2p2Orwqlkha6V6+j054LQ2i6QhfkfvEIETawNbbEeye03HrI68OpJVqdvc0pl
         +5H1MPNrWyjw+xYWZi84Lfg+QB72Nh97M6ID8628hDyTdU4oGcJOgRWxUtitvq9Je1Pz
         DNXn7hSqTLcUZMDhDiz5NdfWopl6imAhcfZne+hW74maFDwjDqgWsE8sm0DtrZq7vUdu
         mOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713916731; x=1714521531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWloTt7+BMWtgc80mA6xrTmAAG8338LS6TOYWg57mr8=;
        b=Ghm94YgD3xsXqTAuaI5x8CIdKt6EUxjhTKX1qj5YqCt5c/Y1fHXF16j2leC+qDm/5S
         4rthe0Kuqd0wpUZJ5txDU848oWz8sR0eaX6/TCic7fde2M0fTxaGODexTJ9dGvTdyDI4
         YXPFw3kQUCpYPsUN/jquJmpy6OPkViiTMtrnlF6KWHJexJNJrOlBDX5Wbuj05jQnR2at
         WMCDm0uxFgu0PJd26pcsbHV95SGM6VoJ7aeGvYr9dYrkd+Q3wj+glUcBV1sWx4LcZEkA
         jTyAR2Bn15BQrFKXMCYB+RLa3NXvirr8FiOdrX1F/jWWzU+tFAxLZPplyG2pMqj4Gn7n
         xKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlOUnRF52Kl74BYGlahqvjsIBTSe7JVobk4QdFFTxDFJNPe98NFPAdOn86+QB5L+JoOtDK3FZ620UZTyYIS4AK+zv+
X-Gm-Message-State: AOJu0YzF9wl9Sb3FH/vcxSvsAFqOp191RECIKPrnmp8IY/Sbdbl/n43+
	g4/21drVcdCr2+0C9qJZ4ET/v7QhqZIG39N4y9cJyFaOSVs+lHEuzE2UCJewK9YA5OeBaHR6UCY
	J4nyJJHwJ/V+WWp6KhGJlWsqesAY=
X-Google-Smtp-Source: AGHT+IHOyKnkPWpZWm9VwQQzbPvhhWZ5egi+N5GQKC9oYxaeA4lnEzo8HTI8ArlDhsDGkf2C4o0mQjVIGqbt0Ym7TP0=
X-Received: by 2002:a05:6102:284b:b0:47b:5eb8:9768 with SMTP id
 az11-20020a056102284b00b0047b5eb89768mr992314vsb.27.1713916731011; Tue, 23
 Apr 2024 16:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421234336.542607-1-sidchintamaneni@vt.edu>
 <ZiYWKbDKp2zHBz6S@krava> <CAADnVQLn+zCAGCcFeE3wUfGULXBs3xii2shYTmS1BQMN5ZNYbQ@mail.gmail.com>
 <CAE5sdEgMB=hGjsCfSFkdS-b_YJDErobu=r1-xKvMkqZqLuW8=A@mail.gmail.com> <CAADnVQK+yZVcDTKNEKNdyJ9kaCHffcp9Wd0QLvipM9RykvByVw@mail.gmail.com>
In-Reply-To: <CAADnVQK+yZVcDTKNEKNdyJ9kaCHffcp9Wd0QLvipM9RykvByVw@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 23 Apr 2024 19:58:40 -0400
Message-ID: <CAE5sdEgcVssirq8GYPgEqdGiP7LMyo7JkU_YZsFbAwxb9tPhvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Add notrace to queued_spin_lock_slowpath
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, miloc@vt.edu, rjsu26@vt.edu, sairoop@vt.edu, 
	Dan Williams <djwillia@vt.edu>, Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"

> > I agree with the point that notracing all the functions will not
> > resolve the issue. I could also find a scenario where BPF programs
> > will end up in a deadlock easily by using bpf_map_pop_elem and
> > bpf_map_push_elem helper functions called from two different BPF
> > programs accessing the same map. Here are some issues raised by syzbot
> > [2, 3].
>
> ringbuf and stackqueue maps should probably be fixed now
> similar to hashmap's __this_cpu_inc_return(*(htab->map_locked...)
> approach.
> Both ringbug and queue_stack can handle failure to lock.
> That will address the issue spotted by these 2 syzbot reports.
> Could you work on such patches?

Just seen your latest patches related to this. Yes, I will work on the
fixes and send the patches.

> > In those cases, the user assumes that these BPF programs will always
> > trigger. So, to address these types of issues, we are currently
> > working on a helper's function callgraph based approach so that the
> > verifier gets the ability to make a decision during load time on
> > whether to load it or not, ensuring that if a BPF program is attached,
> > it will be triggered.
>
> callgraph approach? Could you share more details?

We are generating a call graph for all the helper functions (including
the indirect call targets) and trying to filter out the functions and
their callee's which take locks. So if any BPF program tries to attach
to these lock-taking functions and contains these lock-taking
functions inside the helper it is calling, we want to reject it at
load time. This type of approach may lead to many false positives, but
it will adhere to the principle that "If a BPF program is attached,
then it should get triggered as expected without affecting the
kernel." We are planning to work towards this solution and would love
your feedback on it.

> Not following. The stack overflow issue is being fixed by not using
> the kernel stack. So each bpf prog will consume a tiny bit of stack
> to save frame pointer, return address, and callee regs.

(IIRC), in the email chain, it is mentioned that BPF programs are
going to use a new stack allocated from the heap. I think with a
deeper call chain of fentry BPF programs, isn't it still a possibility
to overflow the stack? Also, through our call graph analysis, we found
that some helpers have really deeper call depths. If a BPF program is
attached at the deepest point in the helper's call chain, isn't there
still a possibility to overflow it? In LPC '23 [1], we presented a
similar idea of stack switching to prevent the overflow in nesting and
later realized that it may give you some extra space and the ability
to nest more, but it is not entirely resolving the issue (tail calls
will even worsen this issue).


[1] https://lpc.events/event/17/contributions/1595/attachments/1230/2506/LPC2023_slides.pdf

