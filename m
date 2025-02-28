Return-Path: <bpf+bounces-52841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28598A48FB7
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 04:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288E61892DBB
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 03:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C411A4E77;
	Fri, 28 Feb 2025 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgHU+xts"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D62F2A;
	Fri, 28 Feb 2025 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713669; cv=none; b=u3Cyr/bqfUxbDM4xVP6XHA+CdZ0g6shCTf3esSKa4fGde7uI4QmjZqAnkc0Qo2IfcHJAZGf+bhq9nZOXSmWxPdfla0tkX+Uo0qjvrDfW9cHW6IIw81tqjVuUj+CEsQx4gNWqnYiiwaLlc2k86p5TbndauP+QC153jXejam3CuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713669; c=relaxed/simple;
	bh=xewQyuL4nA2p6gR4v1MrOq2dw76pK2ntfkLhDKOBlMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bjl1vlw8M6+eZC/uKGGPRhg54kIzqRM3HSMFtYRyqGB0pHE0e8GwV5d6tibfwCthXcy4Fu7gLwU5xX7u+641JIK26UIBnj8Ve/SM2ITSVBt+n22NKqRpQ7N1jii2K/hhjYSIjhm/5rXVig/eRhHwN+lLZ8Egiqel85mmIQtIWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgHU+xts; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390ec449556so434449f8f.1;
        Thu, 27 Feb 2025 19:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740713666; x=1741318466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xewQyuL4nA2p6gR4v1MrOq2dw76pK2ntfkLhDKOBlMs=;
        b=CgHU+xtsq1dSkmELJexFXy18f9zKi/G88e6hBhZqOiOfYAQWlkXteeL51Jusr6iHrK
         1t17gHl/P1s+9sjRAOQ4tTv+qRZC418wKs/rXyk6arfG0CsJTGahMuIK8hXACepnbOPN
         5CyGPCNk76Mfwh8W5Rq1c8q50x11SCXQ1+rIIAYu4bY/6cmNKnGDZQuwEI0EQ851tAtg
         DQczuTzRkeGXoa217YgQjZYXl73kQzfEJFNscKYrre/+SWs9+tO7vHe4GEzckXVXe/r6
         XUCJjh3l86zKnOUwMFTvPLuaQuieWugOGDpF0buJnxLGaOnmWeLLwIEjdeBdkjYKgcfh
         YT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740713666; x=1741318466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xewQyuL4nA2p6gR4v1MrOq2dw76pK2ntfkLhDKOBlMs=;
        b=SlMnVvf19wetiUKrj4MfZaVvKuzq9vgZ5a2/2lMoawMdnG9z8Z1yONAGqQnL2BcAYg
         +lfZ+4qUX6tI10HzlFOYnpScSfH89A9y+v4Q7FXzGtIrJgJl3OlhFIsTrwZkaH69L2Sj
         fxvXjpCIJXsszxTCTmKErkXfSCHh+gbNIWiTCvBy6Rnt6Mu/w9Hxn0gIJzQZoSUejNyI
         Kt7j02qpXIHF7+bkSpBwZOUZK8R7WWY1aARkCdzWVG9ONNMY0neq80jXhXPmYspWtgs3
         mBi4tbBoOpTBdWGT2CVQIF/Ck2J+4YVTqedgJquSB9j1du2wFO443eK5E1z30/Fi8u5H
         IGAw==
X-Forwarded-Encrypted: i=1; AJvYcCUQeq3r98PkweSp6yA89tU3T4BAxeGdBPlfk3fdRRqHbnAA6Fj5pqWxR+WjzMl9oJeLt2WhLaY3m2Ce++G+@vger.kernel.org, AJvYcCW+v+Nj5lIQryFDS3ixIaxaeNl7EfSDkfLd7fjmde+4ITjObYevkOBxHzK36kZ4kIS5Jn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5AsWJOe3qSBGHNR6zPxfAsU8WYBZ3ZgYOcQRBHm4b8ldR8Tf
	IouavH7VSF65gobL6Tf4WNsB2NJfliL2Dy5auOQUEIMISJNFdFRTFtVlwCyaI3myRt1E7XRimNr
	i2dgubm3/mLbl7K+Oq6K6c0enIGo=
X-Gm-Gg: ASbGncunZBImHJUG3TJP8WHxDz26lfwRUQgnhwSkAmEViZZDjoxR0Sc23J6J20k8pS9
	NmkNNPCVWHoXe3C95+oGgQwVpbkHPq/t4qWgr/dC7T3T2+PGSlEFPoBPvLtXx6MnG8d9Y7IBS7v
	tUYcnE748RDD42Zn8UIzL5zRwbbW8CJfcRkWv1rTY=
X-Google-Smtp-Source: AGHT+IHgd3tfWodkiyjPtlDKV6Db1jKtjXRF6i0SrQp49u2uSFNU9lIXTNgQJDqewLoF2eJVuADCD84LJ+hhDB3mf2A=
X-Received: by 2002:a5d:5846:0:b0:38f:2f0e:9813 with SMTP id
 ffacd0b85a97d-390ec77587bmr1687147f8f.0.1740713666110; Thu, 27 Feb 2025
 19:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com>
 <AM6PR03MB50802FB7A70353605235806E99C32@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+TzLc=Z_Rp-UC6s9gg5hB1byd_w7oT807z44NuKC_TxA@mail.gmail.com> <AM6PR03MB508026B637117BD9E13C2F9299CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB508026B637117BD9E13C2F9299CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Feb 2025 19:34:14 -0800
X-Gm-Features: AQ5f1Joe29kJVCiuEvWMvNS3gwtkrux_fKgRJ_LxJDT9H1VoMZ1tL0XlbIA07h0
Message-ID: <CAADnVQ+cokog6j5RjO7qNwBWswXTbu-x2j4EoQEt405-2i5jXw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking
 runtime acquire/release
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:55=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> I have an idea, though not sure if it is helpful.
>
> (This idea is for the previous problem of holding references too long)
>
> My idea is to add a new KF_FLAG, like KF_ACQUIRE_EPHEMERAL, as a
> special reference that can only be held for a short time.
>
> When a bpf program holds such a reference, the bpf program will not be
> allowed to enter any new logic with uncertain runtime, such as bpf_loop
> and the bpf open coded iterator.
>
> (If the bpf program is already in a loop, then no problem, as long as
> the bpf program doesn't enter a new nested loop, since the bpf verifier
> guarantees that references must be released in the loop body)
>
> In addition, such references can only be acquired and released between a
> limited number of instructions, e.g., 300 instructions.

Not much can be done with few instructions.
Number of insns is a coarse indicator of time. If there are calls
they can take a non-trivial amount of time.
People didn't like CRIB as a concept. Holding a _regular_ file refcnt for
the duration of the program is not a problem.
Holding special files might be, since they're not supposed to be held.
Like, is it safe to get_file() userfaultfd ? It needs in-depth
analysis and your patch didn't provide any confidence that
such analysis was done.

Speaking of more in-depth analysis of the problem.
In the cover letter you mentioned bpf_throw and exceptions as
one of the way to terminate the program, but there was another
proposal:
https://lpc.events/event/17/contributions/1610/

aka accelerated execution or fast-execute.
After the talk at LPC there were more discussions and follow ups.

Roughly the idea is the following,
during verification determine all kfuncs, helpers that
can be "speed up" and replace them with faster alternatives.
Like bpf_map_lookup_elem() can return NULL in the fast-execution version.
All KF_ACQUIRE | KF_RET_NULL can return NULL to.
bpf_loop() can end sooner.
bpf_*_iter_next() can return NULL,
etc

Then at verification time create such a fast-execute
version of the program with 1-1 mapping of IPs / instructions.
When a prog needs to be cancelled replace return IP
to IP in fast-execute version.
Since all regs are the same, continuing in the fast-execute
version will release all currently held resources
and no need to have either run-time (like this patch set)
or exception style (resource descriptor collection of resources)
bookkeeping to release.
The program itself is going to release whatever it acquired.
bpf_throw does manual stack unwind right now.
No need for that either. Fast-execute will return back
all the way to the kernel hook via normal execution path.

Instead of patching return IP in the stack,
we can text_poke_bp() the code of the original bpf prog to
jump to the fast-execute version at corresponding IP/insn.

The key insight is that cancellation doesn't mean
that the prog stops completely. It continues, but with
an intent to finish as quickly as possible.
In practice it might be faster to do that
than walk your acquired hash table and call destructors.

Another important bit is that control flow is unchanged.
Introducing new edge in a graph is tricky and error prone.

All details need to be figured out, but so far it looks
to be the cleanest and least intrusive solution to program
cancellation.
Would you be interested in helping us design/implement it?

