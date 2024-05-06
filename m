Return-Path: <bpf+bounces-28725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B837B8BD6EC
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636181F2178C
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80A15B986;
	Mon,  6 May 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyHMjl3b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D042446AC
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031353; cv=none; b=oG4fgkXSBEz6ItzoSjceD9MVAHIjXCqMikfq52in2KuEx+cHKBXgnODOpjubsc8kjy/RBx66SlAusiXYJqlTy41tXOlkvnkoLEBKS7uD0LmSUr4jUiW5ePQeBaZAgvCnG+HKvI5LcX6JmNLYkGFs3oF/83ieJ9UsqZ7pXHjSu0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031353; c=relaxed/simple;
	bh=hbSBckcyTv2R8wm0XejBVj4iZ21QvAaX3gL1OlApLog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBWILt5bq1JiwRGpS8g95B+rR6wlrDJGmjpgCwx3BR5SfSdWztQe0sEDGddyVdMAVe40KYSudBoFQ7/OaQYTDol6GQkhXA56yKHZVz67oZZjI5Ed3Oxbr83f6Qs/nIAOa399WBLkqgunIHk50Ku5dFBBgC/Oow570vmjQnegt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyHMjl3b; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f43ee95078so2115688b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715031352; x=1715636152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkncC5nAr2+HVVsQ/RIMDZCO8xH8AjZHzpWKGBHrdOg=;
        b=DyHMjl3bFWZ3vQ0yrzJ6vxnRrypIBI0FcXrUY7I+iQr6/czmKa63jJelzW2r2BG7ve
         Mrd6FGHGq0P9708frAZ8IRR0qgng0cG9RduugoKKZISiQPL/FtU4zexkDZ2hcDDd40NR
         CZ92QMWKzxRTb1xmg7rmjK8XWCyAqyUNq/dF8he+uBmUScf6ujZObWZNmQCwrdXDnDAK
         1NfJc9cks2va0UGmClVr+N773DqV+jsC5N07aJ8hP69rdxZjI+aJzOS5fpk2ray9UBh2
         B7vwONLArK1eQgkyQcSmYnnK/gYU2dTDw0ORzNZ2sRxahwDqMo3t1XJGaepvZIqgY1Q2
         NNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715031352; x=1715636152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkncC5nAr2+HVVsQ/RIMDZCO8xH8AjZHzpWKGBHrdOg=;
        b=hq6J6uArPz00xVN9dItQWWNumetozG+iCZ8eBJ55vC0nu26IY8Hxf25s2yl5SePPer
         jJGPR7XJsJQNq2GPxc9DR6A52dpsNsdeKGzSgo+acJRbNKUvQRfZWnieujpcxeiC/Kg6
         hKwcKSgCBz5jSVhkh0MNHF7Uw5P59bkvyybiJv98pw7N3+y5FGJgnZo/g8yq1wHVXa9r
         f/5nEM6BuhEXnEvNWU6D9LBabOw7FVpy6CwL/u1mpRqR8z9689bm7Lt89+KBznNONGou
         xkLqvrxPoeCssZfKTO0P09lLOzBxkZhdioaG0KJe4YzPbFpOLaCaRmui254Y5VtS7Os3
         ADgA==
X-Forwarded-Encrypted: i=1; AJvYcCX69zhvg2nXIP6co8SyBs42OjDpwzRQIqUOfz2fPtoLIdRl658pnLLA03vEAnR//iukKkqI/15h+R0hk/rakbu/Of1f
X-Gm-Message-State: AOJu0YxVuGFEKNK5d+6iSKQUKVjTYSz3yYe/ZLmT8OwDyo3LqICm2cIV
	KT65PD/g/tR7zhoEsPXOvL8qeAKlfSTwR0GQQmjPwZq1f7Owl8pvjZcOtWvq7jvDpM5/FbpjKi7
	guY7BN2UGdXfVzzE5jDIsCIqsZ55N9uvy
X-Google-Smtp-Source: AGHT+IGttfjTXoNdoQaSPGuHMb7xRRi1FIskn7043rzQExqgr54bsPfC31tmmAFSu4b9naJPw3qw83qdK8YijPbn4xk=
X-Received: by 2002:a05:6a21:2d8c:b0:1af:62a6:e2 with SMTP id
 ty12-20020a056a212d8c00b001af62a600e2mr12224688pzb.56.1715031351802; Mon, 06
 May 2024 14:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503111836.25275-1-jose.marchesi@oracle.com>
 <6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com>
 <171a007587c02ff4a8d064c65531fde318c3b4e2.camel@gmail.com>
 <CAEf4Bza5cmJK-+tK1QJ-SVUWmTOTOM_3gZQ=9yhynU5vE_wWyg@mail.gmail.com>
 <87a5l5jncs.fsf@oracle.com> <14531c3db62da3761e0783d12fa67060171ed722.camel@gmail.com>
 <87h6faiwo9.fsf@oracle.com>
In-Reply-To: <87h6faiwo9.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 14:35:39 -0700
Message-ID: <CAEf4BzaP7pgW6+hDvoSgRV2inP=YMg2fECpVjqfEbctuo4EU-A@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute
 pragmas in bpftool
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	david.faust@oracle.com, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:10=E2=80=AFPM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Sat, 2024-05-04 at 23:09 +0200, Jose E. Marchesi wrote:
> >
> > [...]
> >
> >> I have sent a tentative patch that adds the `record_attrs_str'
> >> configuration parameter to the btf_dump_opts, incorporating a few
> >> changes after Eduard's suggestions regarding avoiding double negations
> >> and docstrings.
> >
> > [...]
> >
> >> I am not familiar with the particular use cases, but generally speakin=
g
> >> separating sorting and emission makes sense to me.  I would also prefe=
r
> >> that to iterators.
> >
> > Hi Jose,
> >
> > I've discussed this issue with Andrii today,
> > and we decided that we want to proceed with API changes,
> > that introduce two functions: one for sorting ids,
> > one for printing single type.
> >
> > I can do this change on Tue or Wed, if that is ok with you.
>
> Sure, thank you.

For now, for GCC-BPF-specific case we can add
-DBPF_NO_PRESERVE_ACCESS_INDEX in Makefile, if that's blocking GCC-BPF
effort.

