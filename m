Return-Path: <bpf+bounces-41884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929FA99D87A
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 22:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FC4B219B4
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 20:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFF1D12EC;
	Mon, 14 Oct 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3oHYq2i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7E1D0E05
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938918; cv=none; b=HmmQR3otMNaAquGj6CcfkragT/PILgYqtJSOfIezjCDIM1mn5IJn1f4UYjj3pxHxZjkrZfg56mv0SIOySbWjdrR/9jp+SvS+oABLd0icxpwSH41T+uMggCyyXyhSdz2TS/2bDLiDYwGS577av4b6NueCJKufc10KwnmhnZHga4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938918; c=relaxed/simple;
	bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1Nv+GpsEAtZfCvsjWzlRSn2mgTEWIn07fbUBxT3UJKJpai1TliPPLvEoe0YggAM6yO6JbZ0XxFa2id4KSqnobBD/pw87VJQETxBm25zHg/sNZloEcBS4PG3kJvCJr4C+KgsWsG/TuR2Z3ahZDyPf6gyCL/hJHzT3JJyO6pLAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3oHYq2i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c8ac50b79so327705ad.0
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938916; x=1729543716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
        b=A3oHYq2icxsJJhuHZJ76PIZC/B8owrWq4oGhC0ybqMsNnT926a2I7NDiDIO0WNOAk3
         SUyyM+SF1O6+m19vpzWc+oCTO1VNmadjYUAn4ERqYrA7ANLIn7iigwaHP/UUDerddsOD
         bYs+yT+sJejmyMZMeQdVBnrMscZ9rAJKqvcVlkG7HjxljptNamPs7xFovEvkVFehplUI
         nbkvOyXaMuoAM3SKAuQpsS451DMXhdf2cxLM0DN6nWF9YP4omRYfHuVNZJB9RDLa3Kv1
         m5M3A1LLsmYwJJ/T69m5sZBCQmIkG8+oz5HdkrWGJQVapJdKfQQuxln6G5GMjw88s+Fw
         HReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938916; x=1729543716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
        b=qde0DcF/YQRK6EkpIuuDpM+nqzcgwzgz5ALIUxIAewF5Zf1t1Oqxz8Jit1Nwktn/iy
         noAV5dTYAVEWUg9ZVpKqHoT8xXidY38rLT7wQFdu4UVlUZBe056alpQlaiDdPIJJZyRB
         PQFLzLdB1IC400Ddfd2H3uzPecBfkqHOn6Is4NgrQGS+Rg011OmA+lDkyiuH7OyKhm3j
         kP8I4smwqFG4bJi2q/5Rul/+65aASaRQugZ2NFdCwiFJwmGFoSf4kokmyXlJKs9mu3ji
         7n23PTjbf+R+3d6YYIF50kbKCPKzG606MSFsshXXNHuHKoxtVu8X5sWXD0Zxk0L6kANZ
         VmoA==
X-Forwarded-Encrypted: i=1; AJvYcCWUgQyAJb1WWLahZDkjwFOVia1rwVyKZQTExE5dUfedvUhKrh1YA1e0m4f96a+9+xwdy7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+AgEb2+xL6B8ofTYXnZgR9BT/10SUYTuQ9+9lpG4pqdGF5SMs
	FmnrVlYwfxlFNKI1ssLeHpH+4aIjDwcnZmW627dY19P2/QfMTT/BEa2NuAT5zKOjvGt27DKRpp6
	r5CBz7cA2QUTamQKu4CwmDgPv3pBuLvyaTtF8
X-Google-Smtp-Source: AGHT+IElWbl5AVByUDgVhkR4DJhOP0D4H2xXZYriU+tuWxs0dxelbS2co5cCS0cZFwpG8zDMPaW/VapnM4qXE+UzLNw=
X-Received: by 2002:a17:902:ea0d:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-20cbce0d691mr4772125ad.6.1728938915788; Mon, 14 Oct 2024
 13:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <haivdc546utidpbb626qsmuwsa3f3aorurqn5khwsqqxflpu3w@xbdqwoty4blv> <CAEf4BzYRiE9vYCRLmiRHD+fqb_ROwqrb0sX6sktqDNdfeH85DA@mail.gmail.com>
In-Reply-To: <CAEf4BzYRiE9vYCRLmiRHD+fqb_ROwqrb0sX6sktqDNdfeH85DA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 14 Oct 2024 13:48:23 -0700
Message-ID: <CAJuCfpF+YeXVYuEuTt_XKFJuSbu_BxWU96znnfnwG6mMQC7ETA@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 1:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> >
> > On Thu, Oct 10, 2024 at 01:56:41PM GMT, Andrii Nakryiko wrote:
> > > From: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Add helper functions to speculatively perform operations without
> > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > write-locked and mm is not modified from under us.
> > >
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@goog=
le.com
> >
> > Looks good to me. mmap_lock_speculation_* functions could use kerneldoc
> > but that can be added later.
>
> Yep, though probably best if Suren can do that in the follow up, as he
> knows all the right words to use :)

Will add to my TODO list.

>
> >
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
>
> Thanks!
>
> >

