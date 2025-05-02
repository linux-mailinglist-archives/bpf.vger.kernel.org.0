Return-Path: <bpf+bounces-57240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F310BAA76E7
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6149A0BAC
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C725DCEA;
	Fri,  2 May 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekSXBxOS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AF256C88;
	Fri,  2 May 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202502; cv=none; b=lmGRa1d5SyMtagZ00di1tHv5Gwwbly1xh5kKHjvHxJfgbLgPzv5aDn+kXW+mztNUsGG9mK5hejPAeIGX3fmv9i64N/d4VOjlLt0D8WXtX3KpU0hxoQp3Zbac3RWh2GrjahP6Yr9Q4iCyI1l1CYEQoTpjHSOWleswEhDZy6TwDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202502; c=relaxed/simple;
	bh=SukgM/UQNKAzoQ0iUfrpP+w7ksRhCsC54/qXkl058Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbHVnj79tKtOr/tIJF3I4hcMxyZLIowHc3CP4PPnCgdwU7/mwd0R6qTLJkP2aSnkrZZjywWkOOS0ndFFIBhkzkOjErrsaPrfj+ddyvXlBejFTKAM1BdAyu5aJMzdrcqv3rB1vGz09lrMFsPNrd3k+fT83NF/HpcOejlTue3cWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekSXBxOS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301c4850194so1967387a91.2;
        Fri, 02 May 2025 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746202500; x=1746807300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U8daFb5FdrcIFtShOeiDSKS9nURK52nGKQOfwg2Gc0=;
        b=ekSXBxOSBVRYhtuqnch7LWix+xedHI8JsLXWCr8N+3TWCs4Uo2AxBnNoMF+l1J/eHJ
         E1KIxrEFgWDGQayrGH9wkqHlrayurVRy4+5ybUgIDdKGD3BrRtCdit5NtYO91VS/9Hep
         JJmIsfySPUSM42sjNg++duvF2wpTJ5Zn0rmd+d4Qf5hdG29r3vnVm2Bw4DLG60mojPKS
         q11zvi7h7qFt57/kqdEFIaLhBwRAzSeuHs9uBMfB+RnRzNn940Y7DQX+Hl45WG6C9mxq
         eX/J4q/pMieT8Mfa9wCH2kwvYAOvqyamVtiHC1AdCdT9DSkK/3UovPtZn9yowHxTyskp
         WZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202500; x=1746807300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5U8daFb5FdrcIFtShOeiDSKS9nURK52nGKQOfwg2Gc0=;
        b=LPqxDNmGwdX3H21bsMIreHlBizMR0B2mwn+gN+pwv5nVHpJ7RjlyCID2AvXxGfLN7+
         bYw7cYjkIe2RsbvjzuV4yQW9TmPhBefH9zEewiYkpjFRyfKgBZHY6JY9cOa7LXg4e+gw
         Sxe2UJ17KHWejmOU4jE8GfnUT3HVaokMsJdA/dENO2UYCWQILmbDfbFLA+rHdPDpJwOY
         1hxC4wfo7YYPAAD6ADIrPPsCE0bsYVroJVnbW8YYUrOnJrtUK0iE8nVG1+aVy7ClTxeA
         pAesSIFVTbXU7C1bQ3r+l3VF7sR3jrYBgkZ3k4rxINrbIZ7LrhTRVS5ykoNFnuIaXHpB
         OeZg==
X-Forwarded-Encrypted: i=1; AJvYcCX6QMKbOCi42uckavhzYT/R/VaT0Z1+fzqxs7P7TTwDzXeNk2IXwkLrfLhVRSftcT2Fh74aFuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkGAnxcvlb9SWahNquabiyzMJxB04NkYS8b+lUyyLOO3dTFET
	NE5RfedFVNrD54rLeYGBiSrdOmiRZQFn17sAAApnFWVdg2DEkctAYdsGV+9vBU/BKV96+OxNroC
	ygqeHcqGgHCvYpEm5fGlePQNZtBs=
X-Gm-Gg: ASbGncvb2NmfSExoQJqFx3KvJIJCbGDYexWMOo7qoKgkbViS2UDGis1wEfa8+to92gR
	9lOptEdb0GpjGGl/8C1FM6amlAG0DMJKvlLX6MksRKxLe97+aA9604Uw0NLScklU2Y1WDpQFHk6
	vSvnmC/d1o0Dhx/RQDkk/BdYaXVhk9kAglEzhimg==
X-Google-Smtp-Source: AGHT+IEfei7LR33fvupbVqaG/xmAwuT7Z3yG8veVRITSh7EfBgL+wlVnQnUB00IxqjtixJON2nFwbFYYNWrMb80ZKo4=
X-Received: by 2002:a17:90b:4fc3:b0:309:ebe3:1ef9 with SMTP id
 98e67ed59e1d1-30a4e5ae182mr6781292a91.12.1746202499929; Fri, 02 May 2025
 09:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
 <CAMB2axMbAjYVB3+bMuwOszqAn153_9S_vG6iN26-J-n67NGwPQ@mail.gmail.com>
In-Reply-To: <CAMB2axMbAjYVB3+bMuwOszqAn153_9S_vG6iN26-J-n67NGwPQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 May 2025 09:14:47 -0700
X-Gm-Features: ATxdqUGwdEwzC9NDd_O2NWuS834DkuNRiLHTe0-rfJMbu_gn2ZmfZzLi1BRBffA
Message-ID: <CAEf4BzZ=HORw6JnQz=pguoaUSc=swFiaG9mzQLxqLZgTamc1qA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] Task local data API
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 9:26=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Thu, May 1, 2025 at 1:37=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 25, 2025 at 2:40=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > Hi,
> > >
> > > This a respin of uptr KV store. It is renamed to task local data (TLD=
)
> > > as the problem statement and the solution have changed, and it now dr=
aws
> > > more similarities to pthread thread-specific data.
> > >

[...]

> >
> > This API can be called just once per each key that process cares
> > about. And this can be done at any point, really, very dynamically.
> > The implementation will:
> >   - (just once per process) open pinned BPF map, remember its FD;
> >   - (just once) allocate struct tld_metadata, unless we define it as
> > pre-allocated global variable;
> >   - (locklessly) check if key_name is already in tld_metadata, if yes
> > - return already assigned offset;
> >   - (locklessly) if not, add this key and assign it offset that is
> > offs[cnt - 1] + szs[cnt - 1] (i.e., we just tightly pack all the
> > values (though we should take care of alignment requirements, of
> > course);
> >   - return newly assigned offset;
> >
> > Now, the second essential API is called for each participating thread
> > for each different key. And again, this is all very dynamic. It's
> > possible that some threads won't use any of this TLD stuff, in which
> > case there will be no overhead (memory or CPU), and not even an entry
> > in task local storage map for that thread. So, API:
> >
>
> The advantage of no memory wasted for threads that are not using TLD
> doesn't seem to be that definite to me. If users add per-process
> hints, then this scheme can potentially use a lot more memory (i.e.,
> PAGE_SIZE * number of threads). Maybe we need another uptr for
> per-process data? Or do you think this is out of the scope of TLD and
> we should recommend other solutions?
>

I'd keep it simple. One page per thread isn't a big deal at all, in my
mind. If the application has a few threads, then a bunch of kilobytes
is not a big deal. If the application has thousands of threads, then a
few megabytes for this is the least of that application's concern,
it's already heavy-weight as hell. I think we are overpivoting on
saving a few bytes here.

[...]

