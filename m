Return-Path: <bpf+bounces-56370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04ACA95C52
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 04:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C027D7A6950
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 02:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB6D166F1A;
	Tue, 22 Apr 2025 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doYddmrl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EB196;
	Tue, 22 Apr 2025 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745290176; cv=none; b=gAePYXKTtUiaPXptSSaThLYTHNOf9QaXRjjSXJ7LaMVw1p/vVlX1KY9QDT9AuhRyAMHvW/DTpUSLK1Z2mfkxw3bRScgW+8+2CXZZyvW9cKHRXc4kwuJYjKiHm7vNueh+in4vcj+zNIzntjJ1cbt0F5/LfuCwU4Kugdkj70I9yKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745290176; c=relaxed/simple;
	bh=RaIEgCh2TEvA1la4KlBqbAlcY0Njpqnb/C+q628v9Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+WcLlbOkwzn9+J1+jNUi460roZo9Yq9AH/tqxnIN4ul+VdGjf3sc+355PyaqBPW8MT/BXN3raZafVR/93Mt/jsiZ2/HhnlLSBCyKsF/D245NajZi6bBVC8GRom9dJ7IOnkgpVEHqfodzYJ60x9dwKzcj60oeoevD/R4q4L8cTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doYddmrl; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso8349923a12.0;
        Mon, 21 Apr 2025 19:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745290173; x=1745894973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RaIEgCh2TEvA1la4KlBqbAlcY0Njpqnb/C+q628v9Xc=;
        b=doYddmrlFh9vCBpNqIkfJzwa0uzA1UKXYfo1J+NCA1ZVO2yL9Zvq4B06ar9ibkxsiN
         LAfocWLx0zOSqhNqDe79ChOvidsf5R7fT7Nz0r83CLJPvBBHroeL42BgsTmq+NniRcXd
         AniP9Zr8jD3gsXm6/wGnZbMNfjnRqVq+HRs3pDkwTk5YGMiZzankJ7XIXEvkUmMdp/Ok
         hcyG+4wWo7k1l311IkMDCZFSyiBOHtue96zQZfF7eHnZd/F4EBl+fSXcG2Pmvz7ZZNoi
         m6sLI5AXh0LnQfTZMleo9d2IvyC5kbLkvrp3l8zT7OhRYZNTgaWVurnN8AoJkoS75ZuA
         iJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745290173; x=1745894973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaIEgCh2TEvA1la4KlBqbAlcY0Njpqnb/C+q628v9Xc=;
        b=JMvJtJ/333zgMBxPP7Z9bj9asr+fXzbGdZ2VMtGeS3Ik8BrxC3deSps3EnNZw/cTXv
         Zvxc1Sbnmvm6Ozv1NobzWdmcnvUs3R6cP1wcjHLn9qXK1I0ZKKB5tGKru/UnAFkS4TPX
         NK7z2lo6h0UUe9v8ffQil5zkQ7lyKvaWd43HYPT1cD6uMqSG4fo7rof0cHVFAL0A8ezI
         K1pKaxbIcBbSpI6wYthHe9YVSC0gDKvpaPu00FIx+QWFprMyWe5di2zRylYe+XB6qRbu
         RMhGo08qjNNdU5tecUWD4MajStIEE+FkN3X3U+Cn15E/emqVvPUG/aRx2QTrtuSMNYy7
         FPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hVIcpUA6MmadYxwU6HLzakZB1yZUbk0wqHjykajHtE8Cvq/RC5et+47PogXFeSKfiImMB7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/FgMEjeH6Z89t3vSjoQxYtWDFpejdWSSIswfy4e7HhtBeAmFY
	IE/PVXSOQ+Ad/uY6TCawCteA2YijGGc41jv71UtYvRQcPhSWKkktNS7x59NSBEtsL8FuefXRRiz
	asGxpdD1+DZXSEKmZMh5XMuzGXes=
X-Gm-Gg: ASbGncsTqduPnKWdd13egrzSIUV12xuzKUfohaF7jRmauWAKzQ7wmxJvGc915VmYuCF
	Se7rop/11eiRY8+/ZAp09UcvZZpg9dAYZK1HZ0PemoISqbtoQtgxXuy+PeU3ilJ8ICTcBx1X2ji
	W6bJeu1GoItOaDnq4FPzhvRL3M5pqqrbztdbdqXiOt9iw=
X-Google-Smtp-Source: AGHT+IHImA/Zy1gUHqDNTK0diNFAcJndq7/PKGTnS2xKd1UDuybcAckqX6ksErDikwSWszZ5iP3wfsZvj3vq3fRfO4A=
X-Received: by 2002:a17:907:868d:b0:acb:4f4a:cbd0 with SMTP id
 a640c23a62f3a-acb74b364bemr1294422166b.14.1745290173024; Mon, 21 Apr 2025
 19:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-7-martin.lau@linux.dev>
 <CAP01T77kU=LmH-z1WQa-4fiC8XvF94mH1NApTxt=hEPSfYFYfg@mail.gmail.com>
In-Reply-To: <CAP01T77kU=LmH-z1WQa-4fiC8XvF94mH1NApTxt=hEPSfYFYfg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 04:48:56 +0200
X-Gm-Features: ATxdqUHUyKvtW7A-dGX_dfnZrHIMWSALVGguOXc_tUz0ozy1YEZs93Pk0cc7cAY
Message-ID: <CAP01T75S=ud9m3w9g2AcgEPRAuxr3Cb44ehX5wfegQEZKaJ-CQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 06/12] selftests/bpf: Adjust test that does
 not allow refcounted node in rbtree_remove
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 04:36, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Sat, 19 Apr 2025 at 00:48, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> >
> > rbtree_remove now allows refcounted node now. The
> > rbtree_api_remove_unadded_node test needs to be adjusted.
> >
> > First change, it does not expect a verifier's error now.
> >
> > Second change, the test now expects bpf_rbtree_remove(&groot, &m->node)
> > to return NULL. The test uses __retval(0) to ensure this NULL
> > return value.
> >
> > Some of the "only take non-owning..." failure messages are changed also.
> >
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > ---
>
> Looks good, but again, we should fold into the previous patch.

It would also be good to ensure that we tag return values of root,
left, right kfuncs correctly,
an easy way is to add three tests then try to pass them into
bpf_this_cpu_ptr, then match
on the R1 type= in __msg.

