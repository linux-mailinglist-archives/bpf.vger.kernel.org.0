Return-Path: <bpf+bounces-57469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A514AAB9BD
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108693B542E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09F283FF9;
	Tue,  6 May 2025 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djTqms9E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF82F37B2
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496303; cv=none; b=hptocfB+okBhCv7JRkLIP4Pedxmi9G7n6BZiLW9shPbddGD9Ovg6/zSAu0gXhBtNa6DeHYIrBgju6bIGWxldyCp7WvgEzt7HL4Kse2Ekh0V+BDC0B38TVHEB4eThLLUy6dTUOE9CAkUdsYCMgPzWdZzMExDc7s3MJxlZWl3Vc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496303; c=relaxed/simple;
	bh=zTRdSmyxakIlLdqpNr+79OX1puNgm56DfCZS1keGS3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQ0vSVp32LCVguQ4yvO1fbMy3jSTmhgDr/OaW4vyTXqfsLhuVxXZk7EXnLpJJRNHZbIv7I83FBoCSCtdC/kb13u3YMMRPKKXwXiOtvPRJFKjxLPGytzne1TWPv7I37EpxM3BbfSoLSUkGZxJ60WI2nzoRhigAUZDDzs/2RE+CVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djTqms9E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5428442f8f.0
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746496299; x=1747101099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H7lP+OfFuV82z4byYiWduCN6Aj2w+LOfoyqwUntDCY=;
        b=djTqms9EBOtz9bMYv9oROGPDvN7lg+X3dH49HbQm1qD9WLlqCCHpcrSAl1JL4bVkjY
         rUDw2BFsGTujJsbv4Al7YwPSHshay1gaE09KVbQfW2w0dQrKhPVkH4nv4PdzS7q2Y7sK
         kdZCi3HhCxIwplKd3WnMF9kmFJnIydtSVl8bPNfkDCjryzsHEfz7mB0K0XTKHDu8Q/pk
         J4hzvI/+AufgNbwKNGXGixlacV2eHDWBIV3fq+Ja/0V/HbJVm7W7Lu/ExNpmFqet2k7j
         pNwGa7FqlOsMuNoHqxKZY7DoYV7SGxblBC9yvM0iZAdHwcQlaJ2s6TlY8ce97dS2xVs8
         SB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746496299; x=1747101099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H7lP+OfFuV82z4byYiWduCN6Aj2w+LOfoyqwUntDCY=;
        b=Fjl+VOr6n2MZbfX0TFPnhNyCP8ycdM5XKlSH4ZpGlbiFytUHw9PEVap74c+TQK1xzQ
         sG+6DWqaxa2OTLrhzSMpXW6hb2dyCWpK60wNb5rl9dV1ZGAovQ+2sCWmRbntikfOWgRI
         fCvclzQJxICugr3c245J0x5tZ3tiEUdM1v+Z1ezxrDuQeOKs74nO3fugDnP9JRcToe8P
         BMAnZZHtVTUOZxpcf6QdeFMpk5dI60hUwJKiGjXr1IDjZxuT8twbZ1ZqUdmNS7lDa59Q
         orkC29RahPeUsbMdPrt1/9pZV+0qId3OvFpMi6wmHwTRKU26g14P7GD8B8mzUNlzr0uu
         yl1w==
X-Gm-Message-State: AOJu0Yyls9/CyjWantzlSWsXLGFbxNUWZIS4s4L0iv5rjT7GIc6xptwk
	nz7B1YO+FlrsgWPAj6GhkRljv+h7mAdE5Wu7qfAqHqtnPHRkokqb1C5tVkjjvax8bMWDTKyblwL
	fsUUDQfB9KWj7TLx12Ro0v2aAYk8=
X-Gm-Gg: ASbGncuFxH6P4H7MorAc79djdUeZuBCwGf3d04yFsp7n3KqH0JGRPnxrDFSAIxutAu0
	7QVdl65P2v8ct5qJPavi49jb/ToUQAytXrYdLJVsAWL2+67mxoRnegzLPVviSSKXcQ3zjVDGsoH
	qXTSOcnxY5idLEctLS8ShYUHK9/CEYHVXdFYtwu1Pdh9y+eJfWJBfw86ZOkPsG
X-Google-Smtp-Source: AGHT+IFDcCZwuHXLg3cDGco1tYcZCgUrmFBpVVgyLG4uKJb2mrd62/NrCLMz72epsG6y7uMquv+fBVUBAJjORJOEVYQ=
X-Received: by 2002:a05:6000:2287:b0:39c:1258:7e18 with SMTP id
 ffacd0b85a97d-3a0ac3eb21amr803741f8f.57.1746496299258; Mon, 05 May 2025
 18:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com> <a74hjevi7tyq36vekcft7mlfdgwtcg6ddvr3bekb3amcf4fiuc@z7xszkyjcrbb>
 <CAADnVQ+OroM-auGvC7GPzaOUz90zHktF545BC7wRz5s_tW6z4w@mail.gmail.com> <d25b6lxjjzi3zqbotlrapx57ukjl7frmyvg2lgx5omos3zqg4m@ukkod2jdmieb>
In-Reply-To: <d25b6lxjjzi3zqbotlrapx57ukjl7frmyvg2lgx5omos3zqg4m@ukkod2jdmieb>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 May 2025 18:51:28 -0700
X-Gm-Features: ATxdqUETKCF09rFxYnbNd2Uigo46QCB2dDIo7qshx6pNuJyDWgxlGcta7qwz5WU
Message-ID: <CAADnVQJt3aRCcG=Zgt+-hwKdeDcvE0Gvcc3fSKXURr0d+7OU8A@mail.gmail.com>
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 6:25=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> > > >               obj_exts[off].objcg =3D NULL;
> > > > -             refill_obj_stock(objcg, obj_size, true, -obj_size,
> > > > -                              slab_pgdat(slab), cache_vmstat_idx(s=
));
> > > > +             if (unlikely(lock_held)) {
> > > > +                     atomic_add(obj_size, &objcg->nr_charged_bytes=
);
> > >
> > > objcg->nr_charged_bytes is stats ignorant and the relevant stats need=
 to
> > > be updated before putting stuff into it.
> >
> > I'm not following.
> > It's functionally equivalent to refill_obj_stock() without
> > __account_obj_stock().
> > And the stats are not ignored.
> > The next __memcg_slab_free_hook() from good context will update
> > them. It's only a tiny delay in update.
> > I don't see why it's an issue.
>
> For the slab object of size obj_size which is being freed here, we need
> to update NR_SLAB_RECLAIMABLE_B or NR_SLAB_UNRECLAIMABLE_B stat for the
> corresponding objcg by the amount of obj_size. If we don't call
> __account_obj_stock() here we will loose the context and information to
> update these stats later.

Lose context?
pgdat has to match objcg, so I don't think we lose anything.
Later refill_obj_stock() will take objcg->nr_charged_bytes and
apply to appropriate NR_SLAB_[UN]RECLAIMABLE_B.
The patch introduces a delay in update to stats.
I still think it's correct, but I agree it's harder to reason about it,
since stats may not reflect the real numbers at that very instance.
But seeing how rstat flush is periodic and racy too I don't see
how it's a problem in practice.

>
> The css_rstat_updated() is the new name of cgroup_rstat_updated() and it
> is only a piece of the puzzle. My plan is to memcg stats reentrant which
> would allow to call __account_obj_stock (or whatever new name would be)
> in nmi context and then comsume_obj_stock() and refill_obj_stock() would
> work very similar to consume_stock() and refill_stock().
>
> Please give me couple of days and I can share the full RFC of the memcg
> side.

Sure thing. I don't insist on this particular way of charge/uncharge.
Sounds like I should drop mm/memcontrol.c bits, since your approach
will address the same re-entrance issue but in a more synchronous
(easier to reason about) way. Thanks!

