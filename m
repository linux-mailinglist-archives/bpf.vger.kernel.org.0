Return-Path: <bpf+bounces-77891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8ADCF5E85
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 23:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064B730754C7
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC79313E08;
	Mon,  5 Jan 2026 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbfOf5sM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7B313554
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653591; cv=none; b=Et09rBErVNFSuIO9oB8M/nfHIq0w0c0l+C/qTFgBd73i0hZ7mKKDdcjsbOu/isMKBaGxXxtjGZZ9afKA+sgkLs+GedUyeVHquJdmmjypoF+oIdG+llYpot0ZDi21kW7l40igwho2MDHfIeWtn1JfyKO0ZTjQtPCaKJr6QUTPkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653591; c=relaxed/simple;
	bh=qgHZyddmSjjpbydijy7mJTNrUIqMp/ikqRyqr2jWbAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbJHm1WA1ZnIl5tyFryN9OP8VWIx0yqe3H4Nr/5ywDNxlF7976vCGu52ppXaMEwgiCyZa66f1ftqr5BtqAgbKeD5QUU+W4eTtG5F+yXtsfo/OFgRKDckEsXYSBiRwr7Yb788XTqTUplIELMgTgJdMYWn9O9vZuDtsaR8URQx2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbfOf5sM; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34abc7da414so410325a91.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 14:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767653589; x=1768258389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq0IsKWNaJqQlZAbShbTtFsRUf+Yz8XfXGFUPRzcsQo=;
        b=LbfOf5sMBnGTHp1ORftmDNBEm+Wbfyo8f054ok0tL+IMAuSRHo9kknpHMj2WqfTA2l
         MvEGN+Yf3VnTqud2VrblhbXhueVy0wbk9FC575i2jwfiZNVpM1ipIgzrxBDi5/Ydyka6
         XyqBxPCkFg6aBBoXK+s1QK9WIUMadueqxQ22ZygCmHucu8V/0+8AQxV64bN+RQZaYMzy
         tAFH7BOpTy5ZqFHnn8rRSGuPu72suoJhcG8E83IGtxwOPZIA8gCKkTVh6oXhE2HJ//w+
         SnkxeRLIuydftLfXnIVHSAg2sNhcUBYKUsr3NX5rGKQiJnuYJk0XrI3qRe3MFp7RGhj5
         uFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767653589; x=1768258389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lq0IsKWNaJqQlZAbShbTtFsRUf+Yz8XfXGFUPRzcsQo=;
        b=LRHuqtYIp3DPX2SSvD+w6VzVcdeLjl6wkeV78K5Ex3YflJgo/mFqKbrz5whK7d6nhh
         uKbW9jP1e875BfNi5wUfnQs58DBcB7gFvdg3SFyxahM+KMNH3Fm2I+hKJeCJqtfcJnHb
         bzL94Xkr23TBvt9pZAnXqvE6D5L7XvWERiPUeVt9NQWCCJoq8lX6KmQwYvWcRV6S27/X
         P2K8SE7PIO5mBQzpr8z/GXAtY1Fi/Su87r35OU6L8DVYsaIausxqopJXKzeSWmeLZCKv
         C/WlKdXHgPqdkrXhbEgWYF59THXQarpdVR4YFdV4wmnkLtmA8x6jr7N82BYejfIfYS7x
         FKkg==
X-Forwarded-Encrypted: i=1; AJvYcCWHknmf4etAubmUIKah6n+aG9Q2tqbsXxeLV/12PRtgsPBlpp3xmnV5Q4ovkJA3BVTMEFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT57m9Usav0VN4CD5xw+wl1yKpCkpCDlmCKocaFvE/yqqslNE4
	jvSbvzMj+NJMMk2rFev5O4YFU73Y38W8Xs7NLOjlLm6+AF3UGyShgXIIu0XSJTuNO9HFc/1AWuS
	AX5F1HNEarabfEtMnulcsatS4Ir1UT0I=
X-Gm-Gg: AY/fxX4WaukNJIFg02qYuDEPf2H6elVZ3D8E4W6BJzGk+U+X4xAfha2QJqw05bKZ9Bj
	Et7nUSccbDxzWes1cduhLoSpT6zRLDzaCB4LV9M+7eGzSs8usKCiBGQGlfkgWjZnHsJLvoTShzf
	eoiB625Q9hmuFqF7HB3LBSEtHcXDMQ5sZ2nRqGmCML0r6cTX+CYU72hxqxc0u5iFFFmwOupz0tE
	kjfS4EpisSclbChVNIEtdc8wE6uS4dipRDXet/YrCIwPy6huhCxSz/n4cLn5Mfi4J/LDLLsTxF8
	D7GzHTGyxoo=
X-Google-Smtp-Source: AGHT+IG5VlQ2V5/GmfhA5mw+9K+jF2zAxz6zNx7z1uBzB20Ko6KKoL1L1TJNYmuOYYvvvd3D1et4yo949QbbbHJL9ZA=
X-Received: by 2002:a17:90b:4d0b:b0:34c:6108:bf32 with SMTP id
 98e67ed59e1d1-34f5f34391bmr537795a91.34.1767653588715; Mon, 05 Jan 2026
 14:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223103214.2412446-1-wangjinchao600@gmail.com>
 <20251223092932.0a804e046fc2e5de236ced69@linux-foundation.org> <86b3f8af-299a-4ae7-b2dc-0b068046fe92@kernel.org>
In-Reply-To: <86b3f8af-299a-4ae7-b2dc-0b068046fe92@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 14:52:56 -0800
X-Gm-Features: AQt7F2pqoi4I9OPLX0m5A27Z7GWrP_sfJUgm5JSKSPrBmkYAqklfl6ER-z4mkY4
Message-ID: <CAEf4BzaozamTRoK8YromvPZ3b1wNBvxwWrbpfpX4ZFwkMDbMGg@mail.gmail.com>
Subject: Re: [PATCH] buildid: validate page-backed file before parsing build ID
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com, 
	Axel Rasmussen <axelrasmussen@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>, Omar Sandoval <osandov@fb.com>, 
	Deepanshu Kartikey <kartikey406@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 2:11=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 12/23/25 18:29, Andrew Morton wrote:
> > On Tue, 23 Dec 2025 18:32:07 +0800 Jinchao Wang <wangjinchao600@gmail.c=
om> wrote:
> >
> >> __build_id_parse() only works on page-backed storage.  Its helper path=
s
> >> eventually call mapping->a_ops->read_folio(), so explicitly reject VMA=
s
> >> that do not map a regular file or lack valid address_space operations.
> >>
> >> Reported-by: syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
> >> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> >>
> >> ...
> >>
> >> --- a/lib/buildid.c
> >> +++ b/lib/buildid.c
> >> @@ -280,7 +280,10 @@ static int __build_id_parse(struct vm_area_struct=
 *vma, unsigned char *build_id,
> >>      int ret;
> >>
> >>      /* only works for page backed storage  */
> >> -    if (!vma->vm_file)
> >> +    if (!vma->vm_file ||
> >> +        !S_ISREG(file_inode(vma->vm_file)->i_mode) ||
> >> +        !vma->vm_file->f_mapping->a_ops ||
> >> +        !vma->vm_file->f_mapping->a_ops->read_folio)
> >>              return -EINVAL;
>
> Just wondering, we are fine with MAP_PRIVATE files, right? I guess it's
> not about the actual content in the VMA (which might be different for a
> MAP_PRIVATE VMA), but only about the content of the mapped file.

Yep, this code is fetching contents of a file that backs given VMA.

>
>
> LGTM, although I wonder whether some of these these checks should be
> exposed as part of the read_cache_folio()/do_read_cache_folio() API.
>
> Like, having a helper function that tells us whether we can use
> do_read_cache_folio() against a given mapping+file.

I agree, this seems to be leaking a lot of internal mm details into
higher-level caller (__build_id_parse). Right now we try to fetch
folio with filemap_get_folio() and if that succeeds, then we do
read_cache_folio. Would it be possible for filemap_get_folio() to
return error if the folio cannot be read using read_cache_folio()? Or
maybe have a variant of filemap_get_folio() that would have this
semantic?

>
> --
> Cheers
>
> David

