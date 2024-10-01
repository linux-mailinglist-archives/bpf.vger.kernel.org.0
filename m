Return-Path: <bpf+bounces-40716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5298C70A
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 22:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3E5285298
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 20:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD01CC884;
	Tue,  1 Oct 2024 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOUHRKvA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B51BBBDC
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815892; cv=none; b=cAo67PM1QKCku4rKh4F4CV67UK4wV1qussUrd206cRRoseewm9aUWQi4xRapD+Sgt/oGZtSt+Nm0o8yKF76egWw6yC/6l8Ejpqpo588JajNA1eT2CgeYoTaEkB04987UDYJkGNx7RpohYitqZ2GDEhE/W8D634bNY4e1ehx0m9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815892; c=relaxed/simple;
	bh=K31v44yxJPiBAox33YbUNk7y5qshzfGHWlae+dnhuFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfqO4kKAG9ZQtGliatAJmJ9HROMhCGx6KtxZfZtzux6abcOhcP3xfuoF7RUrq7OafD/1nJhrQNfJNNX2NG+6TLtyxQmr5c46IZ/nLTzg7HLqnzQsKipZQOEh7IHvEVMNzNHi/3C5dUjWWB4mDZyVWIprBK5M1yrDbSuqvZVofjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOUHRKvA; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso7016458a12.3
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727815889; x=1728420689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K31v44yxJPiBAox33YbUNk7y5qshzfGHWlae+dnhuFM=;
        b=UOUHRKvADRXqfnbxkzAoUqkwKj9DKDAGYlPQklXxcxev0vxSETFHJYw7ikFGaxnXjK
         4NP42D0Wmeuu06qVWAR8BdVzNeG+HDLoNTR5S1JLfhZUVIkXQtudutXOdfkSvR1ecXwh
         vU537e194dFUR9qRjNZc/3a1wN9wfuZ3EBjRjcZhcXEHy85dquah2ozqUk5HmQX9wDCa
         i0+37o7mL3ZxGGqno9wEtpOh2ER59tPuhv0xfGu6o1GIc53Bfid6LxayzKDzZZXQvQ4o
         gx5kD57MCYx8O8jLDoaeE/lhtFquGPQ1ycd0yy2F3R/nfrxJOctulAs50VNEjUFRVEXc
         QT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727815889; x=1728420689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K31v44yxJPiBAox33YbUNk7y5qshzfGHWlae+dnhuFM=;
        b=I8kyRTgc9Ph4rhf9MoSV5wShY99JIL0QnkB1FW7FzY/6M3qJRO8ZusSSwoSt9UdOuj
         XVc3W573H2ZJuegmOJYIcXmCKyqK4fxJdmis2PB41uB4NGOyPS1Z9cUniRn0rGeAiLqb
         mYmW+xwYmMwgrRn1CCdVG3i54pjnFTM7fU0MduGoe9GRIghqzBUSoTUu2HNHL9BHacWB
         CzGbyTJkTcpWx4kCgKrdl6PrMKiiQB8bjZlXHDp7pQHmt/5J5HvnE4Unh3G99ReBBqbL
         1ZFOWG1y8ZK/VGm6hzfNcT7sEozJWkly+67SPxOsB8i0SCrAmPPeR9TnVubXXxzTUqG4
         6XBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs/wf2JWdhSeuGiaqF+FyktL7ICfbaFZkQZhHTQJoN+37wxLWnVIFjV6nL/+IdUUCqkkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Jy7aEuY4/mE1ylmh+HOB2p/h6w9NCVD0m8thrSQHS7MJUiSI
	4Ao70dnjIBywfnpGz4Wvylcd6lCXjfdOnd0IJThBXGywgFRsULI0F97oPozm+GTegu7QXrYH++J
	nXJ+Knyb1GzAX9xfVwcrEFn3DWDE=
X-Google-Smtp-Source: AGHT+IGBBSc+08LrdGV3tXodrC1J/xB2wY76ftdGdCm+MnsGRE4D3GJd8NMzaFmn2Ykc/FExwLMrZrQv0RhNU+7pPAE=
X-Received: by 2002:a05:6402:5209:b0:5c8:9f81:446c with SMTP id
 4fb4d7f45d1cf-5c8b18e8683mr534498a12.3.1727815888292; Tue, 01 Oct 2024
 13:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com> <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
In-Reply-To: <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 1 Oct 2024 22:50:51 +0200
Message-ID: <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 21:53, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Another idea...
>

Thanks for explaining why push/pop is still necessary. I agree then it
seems it cannot be avoided.

> Currently the prologue looks like:
> push rbp
> mov rbp, rsp
> sub rsp, stack_depth
>
> how about in the main prog we keep the first two insns,
> but then set rsp with a single insn to point to the top
> of our private stack that should have enough room
> for stack_of_main_prog + stacks_of_all_subprogs + extra 8k for kfuncs/helpers.
>
> The prologue of all subprogs will stay as-is with above 3 insns.
> The epilogue is the same in main prog and subprogs: leave + ret.
>
> Such stack will look like a typical split stack used in compilers.
>
> The obvious advantage is we don't need to touch r9, do push/pop,
> and stack unwind will work just fine.
> In the past we discussed something like this, but
> then we did all 3 insns in the private stack
> and it was problematic due to IRQs.
> In this approach the main prog will use up to 512 bytes of
> kernel stack, but everything that it calls will be in the private stack,
> and since it doesn't migrate there is no per-cpu memory reuse issue.
>

I think this is much better, but I'm wondering how the hierarchical
scheduling case will occur in reality.

Will it be the main prog invoking a kfunc, that in turn invokes
another prog, which can do the same thing again?
If so, the lack of using a private stack for main prog would be a
problem, right? Because effectively if we don't call into subprogs we
don't use the private stack at all, and all invocations share the same
kernel stack, which brings us back to the current state.

Instead can we set rbp to point to the top of the private stack in the
main prog itself?

> Thoughts?

