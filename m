Return-Path: <bpf+bounces-27733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74388B154D
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5A01C21FF8
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DF0156F57;
	Wed, 24 Apr 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzLAMI/m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC96156999
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995300; cv=none; b=j9+0qbyxWOXmJG/5lP2MTzQQxyXQxONsPSzizYrTuQJDvJ9v+p4XWG/Iu+lM53uoKJnSZTkHU65NlSAqBCe8VCC4ko3f+DfXBAhO6kKR26ygjwORyGQYI1TUGLzQ3V5oB87WSHOQC/1/IMtHKTQPlcd5PHOWhLTKZWtQTWWgqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995300; c=relaxed/simple;
	bh=4aqZ9F0WW5IGbPb87ZCyB+Wcg8CJxbTyGemerDLmiEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzoEThglWeyuQ2xYSvCSTXDHHN1CPgbdIU4ClBZkGDyDPRXRP5WebQKmMkJe0jhIJhtrffa0ODXGzefHlG3hIRzC8AquzcbPL0FKZrgx0lMpbFz5btjWTufxuzeplE69Hf3uInTto7jHxKC9WBmKNke8Zd+GAuguH0Ro/Kzw3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzLAMI/m; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346b146199eso222973f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713995298; x=1714600098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qmtXtCj2x/kSVf2PGm8iTNdNrb3sju4wFdk+FNs0+o=;
        b=VzLAMI/mstnm/ooksDgQMgcd482fZE+xdxCttvYN1XjrW1tizDTDoQMexZHPlgdxIw
         BMwzfXpj405hYDYyPQ6AESYK8KAesV1wFXLgP0dN2b0oz0pBfkVkANzSORIyZJPtRVR+
         xPpOeo0C5Uc2m2NQeRhAzD5QfEV4dKX72RBmih1+2zoX0oW4v8ddJ9XnKkDiIqb4GxOz
         JJXcqBGz6PwrtXjX2Xhk5FDnArNrdVFKTE8fu0/YGMeokEg2g5ohV6aUchiQaa5v0ANl
         QUuzyr18JpCkjaE7hHQgYiHvS1UViaDqr80S0LHJSqSgAcHIsMEKD93PM40uhs4f012A
         eKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713995298; x=1714600098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qmtXtCj2x/kSVf2PGm8iTNdNrb3sju4wFdk+FNs0+o=;
        b=IDUn+a8hPQNRLGzrRb72VmsiiSiknNcxwiJRlUsADMwC2QLeFxWkPubSa9ZLR2LJMf
         1brnh2VNhnGzn6OT0r7mLNReqQ2k3dXnSuFVIvcRm6vyAnihLDC7qHJXodr0LRN8RtAX
         haIHwKRzeihDK6gFR7WRqvvlwOrdKnC0k6lGXiA/AID+ZA016ijBIpl60YZym2QTWs2a
         CU0a0ueb7tIUBJ9cTok4RBzUMS0Hfuc10fHDCqRj0YGoD7MXFE5bD/efILxUvJHPRX3K
         U+7Q0lcICHpuK0g/xqcbkpx41Cfd25W8kwkgMDoBvoeKQG4q5gTDPdWs4sBZhpwvbooY
         R3bA==
X-Forwarded-Encrypted: i=1; AJvYcCU8QkBvESBnHgZXBAHoNPk3STj7RVrX7KWDQFVAIViXhDgMjw45rlDR1Pyy5cJTThGsy6tQ7SPrdHVSxoNFTpjrIAM2
X-Gm-Message-State: AOJu0YzNt7QP5UoHChA1zzXUUUbSI1gdxjO+PucITX4OSAPVVdNHqKIt
	mdtQSp3LFDVG+p8q6jv5kdID05sULejRiv39c4N4awh7lNJNI29WgZCs+SBKVDlXu4j1z9cZC7X
	fkz8J1E1EHLO4RzygebBX4/ORtqo=
X-Google-Smtp-Source: AGHT+IHcZcgj/8EFuK2hnW13/sHLpCVX8TBaDQQ1lLBSWBPb+Dp4xLwTOCU0lXJ+JssqEmzHrH6zKVHGMeLzWLc3pgU=
X-Received: by 2002:a05:6000:1817:b0:34a:3f3d:bb22 with SMTP id
 m23-20020a056000181700b0034a3f3dbb22mr2326914wrh.26.1713995297640; Wed, 24
 Apr 2024 14:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
 <744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev> <87v8465u8p.fsf@oracle.com>
In-Reply-To: <87v8465u8p.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 14:48:06 -0700
Message-ID: <CAADnVQJzLzrxtHeVcpNBtb-rnwWfApFEy_kv7LzWDee4pH1ezQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in selftests/bpf/Makefile
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, indu.bhagat@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:30=E2=80=AFPM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> Hi Yonghong.
>
> > On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
> >> This little patch modifies selftests/bpf/Makefile so it passes the
> >> following extra options when invoking gcc-bpf:
> >>
> >>   -gbtf
> >>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
> >
> > Could we do if '-g' is specified, for bpf program,
> > btf will be automatically generated?
>
> Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
> -gdwarf.  DWARF can always be generated by using -gdwarf.
>
> Faust, Indu, WDYT?
>
> >>
> >>   -mco-re
> >>     This tells GCC to generate CO-RE relocations in .BTF.ext.
> >
> > Can we make this default? That is, remove -mco-re option. I
> > can imagine for any serious bpf program, co-re is a must.
>
> CO-RE depends on BTF.  So I understand the above as making -mco-re the
> default if BTF is generated, i.e. if -gbtf (or -g with the modification
> above) are specified.  Isn't that what clang does?  Am I interpreting
> correctly?
>
> >>
> >>   -masm=3Dpseudoc
> >>     This tells GCC to emit BPF assembler using the pseudo-c syntax.
> >
> > Can we make it the other way round such that -masm=3Dpseudoc is
> > the default? You can have an option e.g., -masm=3Dnon-pseudoc,
> > for the other format?
>
> We could add a configure-time build option:
>
>   --with-bpf-default-asm-syntax=3D{pseudoc,normal}
>
> so that GCC can be built to use whatever selected syntax as default.
> Distros and people can then decide what to do.

distros just ship stuff.
It's our job to pick good defaults.

I agree with Yonghong that -g should imply -gbtf for bpf target
and -mco-re doesn't need to be a flag at all.
Compiler should do it when it sees those special attributes in C code.
-masm=3Dpseudoc is a good default as well, since that's what
everyone in bpf community is used to.

