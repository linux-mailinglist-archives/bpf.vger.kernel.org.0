Return-Path: <bpf+bounces-21936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3285414E
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B62E1F2291A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310922907;
	Wed, 14 Feb 2024 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqKAdPC1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691A79E4
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874688; cv=none; b=YWI54Ovwb7lZJziK9+1cu2cydn36aRkFrUPqnSNssNu8W18UvGzOT6yQfVCfS56e5fa9qw/xH+YghRLJw2FBMw8D9CMm3or1frO9MbkuxDhQV0/XL96ShL5whuDJspiaJNKvdovkBUTHH6rPtvKD28xCEVxfyJTfCHZiZUobazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874688; c=relaxed/simple;
	bh=kHcof7QCIfZmj7AKADRqlVBUmWlRCk5QuZwqBYLbwMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S254kjWHiEFW951sVPymr5E6yGZVaKjeTcU84lb4UBci4ZzJHNP7AcsohWfDefcf/h5ziqa/vrHSh3JtuooGUEoVVJsJaqYRXsZHBoACgOERh9SEH0eyRXVZvZ2cZP7aO6A9pBOuHb0FGmDpQfixni42KZa6Q1WOZ57WR+4Hg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqKAdPC1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b189ae5e8so2169356f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707874685; x=1708479485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHcof7QCIfZmj7AKADRqlVBUmWlRCk5QuZwqBYLbwMc=;
        b=UqKAdPC12BTNgKBXz4vqEUN9vtvB9Gt4jsbA4xDabisngSfKpb+maP9LoC4ZhBBmzk
         wqDqxbr3/mzKJP0bVBb/OsaeduLAnnnBFjXTCwMYBShx1Kq3oNYBnoXH0e+mQDfUrL5e
         diP/0Bwo5vEJIhwfWnVsYheJxvBWzsUl+dpdskm1ZhVTZDz/fqv8wxa5smaR2Q9wbHmK
         ZKfW+aNIWvyRvkFiHMVRPMscu6RQFI1guyBP29KtGq1TFPDvZ0cNpO/6oU17cCw79MgG
         XbNm2bYTQSfZ+xMKv63wM/nPuFkIp3qVWJfJqMKTbwVGfw1Xh3pxo5zkLhY1VYt4j1Di
         XNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707874685; x=1708479485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHcof7QCIfZmj7AKADRqlVBUmWlRCk5QuZwqBYLbwMc=;
        b=PwGTA7n8fL7lB4v57dYQmm603ty9j8V+dfDTgBsxn4IFvcFp/EKGfdRzItyWXgtxEl
         Zd6AGvxzjSf6WeLmL9k2U22xjkZP5y7pkaaOEth9m0QA7CA0iJ7QHJXJPLWUi8a+avNi
         oi50PiWgkzUib+uMQinfZIUQnGN35BJ3xFTUwDohff8PEPvOuCyxf+2aWehW+XpaU72k
         qHQA+Ph2P/MUMnx2hBkIh0tkeOpZB5rwiXYPGIk3rIWlLYllWqvf9Zb7Zn0NqciK2Wjg
         GWKlkoW4oYvBbVQ98ZXFUHP9ZqfbFz/4LIX3Li0CT2nPp2BfmeEGmwFh+T0p28yh3t7n
         j6JA==
X-Gm-Message-State: AOJu0YxOub87YDGZZpHKe9Uq96pvLp7hQu5f3qocQa83ncF540asMUqW
	MMstAZdRzkHFbtStgEqrsnqr5iPhad/nZGb0hPgQXYr8NdZF6o2LOmuTAvUTK8iJq78YCAt3Prl
	P3TeMdLrMIZ9llEnOCRSWoTf2kQ+x8FzeVX8=
X-Google-Smtp-Source: AGHT+IGsfWlyBERzY3gGgEv5j2eEm1NzU37D024cAj+C7Lh60FGBjWx5oiLl1XbawoegwGkkRd3PPksH6bjr/UXnzzk=
X-Received: by 2002:a05:6000:1003:b0:33b:2ca6:5a4 with SMTP id
 a3-20020a056000100300b0033b2ca605a4mr639937wrx.4.1707874685288; Tue, 13 Feb
 2024 17:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-21-alexei.starovoitov@gmail.com> <CAP01T74x-N71rbS+jZ2z+3MPMe5WDeWKV_gWJmDCikV0YOpPFQ@mail.gmail.com>
In-Reply-To: <CAP01T74x-N71rbS+jZ2z+3MPMe5WDeWKV_gWJmDCikV0YOpPFQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 17:37:54 -0800
Message-ID: <CAADnVQJzBM8NZF=-R2600G7itwFJPsoKPEPz89ivH1zjV9jvFQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 20/20] selftests/bpf: Convert simple page_frag
 allocator to per-cpu.
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:06=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 9 Feb 2024 at 05:07, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Convert simple page_frag allocator to per-cpu page_frag to further stre=
ss test
> > a combination of __arena global and static variables and alloc/free fro=
m arena.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> I know this organically grew from a toy implementation, but since
> people will most likely be looking at selftests as usage examples, it
> might be better to expose bpf_preempt_disable/enable and use it in the
> case of per-CPU page_frag allocator? No need to block on this, can be
> added on top later.
>
> The kfunc is useful on its own for writing safe per-CPU data
> structures or other memory allocators like bpf_ma on top of arenas.
> It is also necessary as a building block for writing spin locks
> natively in BPF on top of the arena map which we may add later.
> I have a patch lying around for this, verifier plumbing is mostly the
> same as rcu_read_lock.
> I can send it out with tests, or otherwise if you want to add it to
> this series, you go ahead.

Please send it.
I think the verifier checks need to be more tight than rcu_read_lock.
preempt_enable/disable should be as strict as bpf_spin_lock.

The plan is to add bpf_arena_spin_lock() in the follow up and use
it in this bpf page_frag allocator to make it work properly out of
tracing context.
I'm not sure yet whether bpf_preemp_disable() will be sufficient.

And in the long run the idea is to convert all these bpf_arena*
facilities into libc equivalent.
Probably not part of libbpf, but some new package. name tbd.

