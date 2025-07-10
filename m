Return-Path: <bpf+bounces-62866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545CEAFF62D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 02:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2046B1C45020
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9D672636;
	Thu, 10 Jul 2025 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPvkFl09"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53E539A
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108890; cv=none; b=Nupw49d0hSdHbZro17LMOH+NTR0fOM2+1BOdYoNEnuiAJrnhmZD2u3JWC55ZHVghQ0BpBqiro/9JfzolltdFU+4rFEPzVtyNftDgjFq9xZQ7QXgdlKzJb4YBfEoiE7+u+wq6vGhPz2PooKoN1IX2lermeNLIBD9TPjkan5sbM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108890; c=relaxed/simple;
	bh=AO25ryHk2I0XA7aU+gTnKwqKXD8DSb4Kxr+qAtasj20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPIEs0UrMLMPd/eBH2sVUTvnosGXcTwPWjLLzYtNAkE/wPgppw3UXWT2EOsoOkMeLj0YfV7NFDCOFJhNVp+dj04uCgQINgJSR3Q8b0OwrnBFuabwutaxLy+uwkIq7oiTGV+YWLfDbsfN6L9TG72Fe3/tTAnrNaUw3B6ogUDuc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPvkFl09; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae0dad3a179so64498866b.1
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 17:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752108886; x=1752713686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AO25ryHk2I0XA7aU+gTnKwqKXD8DSb4Kxr+qAtasj20=;
        b=NPvkFl09aXKfE3M/iyGxbxCQdXydTlti4B5kmXQhBzVRJ3ZrmBT9KeEYSs7xg6iyZ8
         cRrYHhre3yH+VUMTkyMsHMdtOr/1r5NDj25LQxMRNqFK1z2btm6tCHPG+NTxaJ1E8cE/
         z2QxrKsz6xU31LShsr99efUIZbbH3JHZV1/WJl32nOXorekOUPt+8RClTKHVOvuvfX3i
         0xkvskXyv3YHfwHSyN82sSvS7tZAZDaZDQvC9d14d0WJ6pzR4Zz3ct42Jjommw1Qd6Qj
         VeiU3Ki8N1HEYpxIAmuUsPU7OdSH0WI7CMv3FMNPcErMrV4dVgfEiePWOstnBFmYZgS1
         nZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752108886; x=1752713686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AO25ryHk2I0XA7aU+gTnKwqKXD8DSb4Kxr+qAtasj20=;
        b=qMe9Eng+PlPlGTH3z/Omeyj3qYLWfTZasTgBI3Nqn0D03N5zk1zuW4ZRR4lrZoNAPr
         AyU2z0fvsbes0B9GznHfLlCjwyVPgRPRA/n+VgrZ4WRRacJcm8sPixlyNmXboEd3Y09d
         SHUD6Ey94cBvtEgNlPqn/Cv83VTZVqFBQyWCFxLZEZNPiAyoN7mdNP8iWWOgQk80tvkS
         dOhnZ10laRPmTIG/nQUNF0GmxYWgN6gKfb612vF1W2DCOLWGRC3kS+7o3kV/ntmCyP4B
         K9QixCI21SNYc8X4nX00anY9TZjgoDKcVD3LwtRcxGBM9lDG61L6/FLKsi8icq3Jyb2O
         swZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8DvkXMDqfxkRFQWCzl6mM6d/Jh2SSDb9E/4z0+/TFh/gXJ0KFYoW38FRVZMad0rvAdDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzv7lynAHjliJ9Ll5+8FdowJmXbIHKQwAPZxodWHXFf7JkHgz4
	xrxMgqnzlu63QQGAqyRLc7TfsDuDRl4bXB3P+e5/bUxDDhbabnnpoxIyaU9+zJPelxZwfmveRYk
	1k1HjRBfULwFbTwTLTE7+IaZyHHfrP7k=
X-Gm-Gg: ASbGncurn4vJH/iMp7fwWZW1lMJwwi7dG9E+ngli91L3d1h+60DeSqhL0IKxFXajH2T
	ZIMLopVDDKau7XxJVlXyBgMi8F/FgwjH6ZVzAGMYHuPDguPTswZGzBJT6EjH0MkjUz85bQjcteM
	/KemXUQqGF9WHYsXlDth2/H9OvC6N7/rGELlQ7XSrbfINblg==
X-Google-Smtp-Source: AGHT+IF7SRgPK9T2y4tbI5jAxjSVAaquLXgNLKMVoB440qWjC542SojUBmNmwRHvuD1At+AUYyFMcOFSFoUqRZR27LQ=
X-Received: by 2002:a17:907:d28:b0:ad5:78ca:2126 with SMTP id
 a640c23a62f3a-ae6cfba40a1mr456095466b.59.1752108886164; Wed, 09 Jul 2025
 17:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-4-sidchintamaneni@gmail.com> <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
 <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com>
 <CAP01T76S4X4f=owz9D7dXfv15=vD8HB8dO_Ni2TmKfqTKCtuhA@mail.gmail.com>
 <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com> <CAM6KYssLVB+Wqw5ptQQufjmV3279AX7ZKhXtkG6OWaM3vWde-Q@mail.gmail.com>
In-Reply-To: <CAM6KYssLVB+Wqw5ptQQufjmV3279AX7ZKhXtkG6OWaM3vWde-Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 10 Jul 2025 02:54:09 +0200
X-Gm-Features: Ac12FXzKzutP-zFYpE_6p0Lca8wkDKMg36Sv0rY6yq99aCyqkOGh0rO59Vm0OZ0
Message-ID: <CAP01T760JcsZ0o5BfKZ7pi0viseocTQCUW6KjqbxzTW7TwXF9g@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Raj Sahu <rjsu26@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, 
	doniaghazy@vt.edu, quanzhif@vt.edu, Jinghao Jia <jinghao7@illinois.edu>, egor@vt.edu, 
	Sai Roop Somaraju <sairoop10@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 09:07, Raj Sahu <rjsu26@gmail.com> wrote:
>
> > If we have such bugs that prog in NMI can stall CPU indefinitely
> > they need to be fixed independently of fast-execute.
> > timed may_goto, tailcalls or whatever may need to have different
> > limits when it detects that the prog is running in NMI or with hard irqs
> > disabled. Fast-execute doesn't have to be a universal kill-bpf-prog
> > mechanism that can work in any context. I think fast-execute
> > is for progs that deadlocked in res_spin_lock, faulted arena,
> > or were slow for wrong reasons, but not fatal for the kernel reasons.
> > imo we can rely on schedule_work() and bpf_arch_text_poke() from there.
> > The alternative of clone of all progs and memory waste for a rare case
> > is not appealing. Unless we can detect "dangerous" progs and
> > clone with fast execute only for them, so that the majority of bpf progs
> > stay as single copy.
>
> I just want to confirm that we are on the same page here:
> While the RFC we sent was using prog cloning, Kumar's earlier
> suggestion of implementing offset tables can avoid the complete
> cloning process and the associated memory footprint. Is there
> something else which is concerning here in terms of memory overhead?
>
> Regarding the NMI issue, the fast-execute design was meant to take
> care of stalling in tracing and other task-context based programs
> running slow for some reason. While I do agree with your point that
> deadlocks in NMIs should be solved independently, kumar's point of
> having several BPF programs needing termination, running in hardIRQ,
> puts us in a fix. What should be the way forward here?

I would give the prog->aux->terminate bit idea we discussed in the
other thread a try.
If we can can know that it has acceptable overhead (see example
microbenchmarking I did here:
https://lore.kernel.org/bpf/20250304003239.2390751-1-memxor@gmail.com/)
then I think it seems the best option to go with.
You can also try loops with costs for the body, since it's more
appropriate as the % of cost of the loop body.
We can sample this bit and later on hook up enforcement to set it when
it detects a timeout, but let's keep both separate for the next
iteration.

