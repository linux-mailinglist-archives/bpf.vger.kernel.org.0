Return-Path: <bpf+bounces-62602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7050AFC012
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7897B1AA690F
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC9F1E0B9C;
	Tue,  8 Jul 2025 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwLqV0p+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258131D7995
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938575; cv=none; b=rbZOrwvlU5Ty2luInOj55Vs+LOnoNogwfWaQ67MnIMprPvXugjw1t5P64hbHNBKEE6baamE/w1ANuV23zEKgS/yFo3euQBPZuHrEePT+hnh9ZVxX4MpSEtw4KFtcCZ7dsO3+vcvVvEcfLdyK5SlEsQPtHK4HiD8wojHUArnzU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938575; c=relaxed/simple;
	bh=mPdHDnsSbrlffFtKsuK3PZCDIhU4cAP9syp1+yii++M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAIaFPklCWfgnpjpOIFmTHtao6bTGIUcwqE8GKyeCysuqAuYIlG/MkaTn9WikEisD3uQsfJy+f7a5s3znp3OAVeU3OvWNY3TbjhKQRvn866EZ1pghHdI8fibhl+fQs28A//xHz7KVm5LvzDNwDszRtTvdnzK5+Ez9i2eUnwBbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwLqV0p+; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-407a6c6a6d4so1025632b6e.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 18:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751938573; x=1752543373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrTVjvGly2L/LnsPLWxtjOU2megBnWr13nVYJkRJptY=;
        b=VwLqV0p+D8YoWJcVskqfRuHBqo+iHBX6vOFkBq8Fmzy/9jrcqmgX7Zp5QgOSMO+sSJ
         V8K8SsU/p9MknaxXyT2J3lNipaWHcyrRxQILpwgrQHN/B1NBy3ufyB/inSCTNwqA25ff
         xTS0X3B7iz+LsbWYgouVWLqXipHcO08W+ohMnGB12ekYuo3Sb6XGfs6uzaBYnruwHb2J
         dT4/sZN0kdVdJcT2VXCI80d4bXraFWXGiIY7o7HpyII0I7KlivB6eZ/1k2WSyXl6soMR
         v8Wg52kevAvjkdcz8PIQeh1mmPRY9qx45QssB1zqfmjzta8GZQUX1QIx3BAKg75tqdbX
         TEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751938573; x=1752543373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrTVjvGly2L/LnsPLWxtjOU2megBnWr13nVYJkRJptY=;
        b=CSpqZ1WCN8foR1oc7/hAEh824H0Z7NEQU2m3qgKgmwa3IZ9bklcjZZ1xChYVgreUmV
         XugP8XqU/dRdQqgh24Ak8b6mNtbiCnNXNz7H9wntIp3XCzxQQUbjqFDm79reTRI95nj7
         8gj/G1Ie1rVzzVTHAjKwMx7n2oaiLR3OmJDjFCxgdX/lAlfsIM3uqNOYBLpInyAdY6cg
         7sAcvFKf/WZpUnaHegKqkLdJn3EXegYbhrLRPSnmN59PuD37JwglKR4s6LUwV/dg0UOZ
         q0sD8JV5TpJT3osohLNZtSTL9aBJ4hEyhS9QUPVpEdfG/Yg+lW0ktF6Ir62G8nRMN3t1
         NOgA==
X-Forwarded-Encrypted: i=1; AJvYcCX07qmaQ5UL6amzEEw1AVPWhJkhZIUXmR18M/cLKsGBWkq8oJ/SaeXTA6FpxE0rXcCrcyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+lUgHzt/6osuQFm2uVocyxl3zZtPePyPmqIEz1NTB/1Zf7/3
	Dm1lSYpdhQNB3A+rItmSXHvZy0z3Jn7goLnSnPBCTlrAbgJFAKMAWWGU4H4Ka0k1nHV5Gq5/wKT
	8jbRHIWzeN7aLRnF70FOlfQ2NQSl5XLI=
X-Gm-Gg: ASbGncvCEDLJ+X72nudF0IQ4H78rEdcMVg7g2kqwQm4X7Qct8cRglJQfBQnb80bFyfP
	yDwV37HMcL45c0a/wCSakpVY3q+H7OXdnwqCk2DhjRyGKVjKzToC0By+gLmav2EThpRYT3EYQb6
	1yTxExd36j2HObHAfHHr5oq6VGyBK0td1CqfsJfsp+aGs=
X-Google-Smtp-Source: AGHT+IFAugfJRnrBMxyoi2p/C/6NM3kBFO0FRMDv8490JJP4LvOKOrIAJltu88jijp8nn8vL+HAlWrjUsJF7clbg6/U=
X-Received: by 2002:a05:6808:50a4:b0:408:e711:9aa with SMTP id
 5614622812f47-4113f6434bemr827129b6e.37.1751938573138; Mon, 07 Jul 2025
 18:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701074110.525363-1-jianghaoran@kylinos.cn>
 <CAEyhmHSzfMr0J4t7v7cC7roTfybJRqHF_iumFMCYm_iqzJkGOQ@mail.gmail.com> <d61697244565d2c423fdd965decc4fcd0a3a8f74.camel@kylinos.cn>
In-Reply-To: <d61697244565d2c423fdd965decc4fcd0a3a8f74.camel@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 8 Jul 2025 09:36:02 +0800
X-Gm-Features: Ac12FXyQhWH9XzoMAPXYfUVao4ZzM6XCFtGrI9gAVikvpaqWQ5JnzJhYGf7vf4Y
Message-ID: <CAEyhmHQnmzX_-PpWsg+WcesJuO6pn5ZGBLYvzAXSBtKnGQpjmg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix two tailcall-related issues
To: jianghaoran <jianghaoran@kylinos.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
	chenhuacai@kernel.org, yangtiezhu@loongson.cn, jolsa@kernel.org, 
	haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 1:53=E2=80=AFPM jianghaoran <jianghaoran@kylinos.cn>=
 wrote:
>
>
>
>
>
> =E5=9C=A8 2025-07-03=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 20:31 +0800=EF=
=BC=8CHengqi Chen=E5=86=99=E9=81=93=EF=BC=9A
> > On Tue, Jul 1, 2025 at 3:41=E2=80=AFPM Haoran Jiang <
> > jianghaoran@kylinos.cn
> > > wrote:
> > > 1,Fix the jmp_offset calculation error in the
> > > emit_bpf_tail_call function.
> > > 2,Fix the issue that MAX_TAIL_CALL_CNT limit bypass in hybrid
> > > tailcall and BPF-to-BPF call
> > >
> > > After applying this patch, testing results are as follows:
> > >
> > > ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_1
> > > 413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> > > 413     tailcalls:OK
> > > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_2
> > > 413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> > > 413     tailcalls:OK
> > > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > ./test_progs --allow=3Dtailcalls/tailcall_bpf2bpf_hierarchy_3
> > > 413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> > > 413     tailcalls:OK
> > > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> >
> > Thanks for the fixes. Will review this series soon.
> > BTW, do you test other tailcall test cases ?
> >
> > Cheers,
> > ---
> > Hengqi
> >
>
> tailcall_1/tailcall_2/tailcall_3/tailcall_4/tailcall_5/tailcall_6/t
> ailcall_bpf2bpf_1/tailcall_bpf2bpf_2/tailcall_bpf2bpf_3/tailcall_bp
> f2bpf_4/tailcall_bpf2bpf_5/tailcall_bpf2bpf_6
> /tailcall_bpf2bpf_hierarchy_1/tailcall_bpf2bpf_hierarchy_2/tailcall
> _bpf2bpf_hierarchy_3/tailcall_failure
> These test cases passed
>
> tailcall_bpf2bpf_fentry/tailcall_bpf2bpf_fexit/tailcall_bpf2bpf_fen
> try_fexit/tailcall_bpf2bpf_fentry_entry/tailcall_bpf2bpf_hierarchy_
> fentry/tailcall_bpf2bpf_hierarchy_fexit
> /tailcall_bpf2bpf_hierarchy_fentry_fexit/tailcall_bpf2bpf_hierarchy
> _fentry_entry/tailcall_freplace/tailcall_bpf2bpf_freplace
> These test cases depend on the trampoline capability, which is
> currently under review in the Linux kernel.
>

Please post the full test result of the tailcall test cases for future
references.
We can safely ignore those ENOTSUPP cases. Thanks.

> These two patches are relatively independent. Could we prioritize
> reviewing the fixes above first?
> Trampoline-dependent changes will be implemented after
> trampoline  is merged.
>
> thanks
>
> >
> > > Haoran Jiang (2):
> > >   LoongArch: BPF: Optimize the calculation method of jmp_offset in th=
e
> > >     emit_bpf_tail_call function
> > >   LoongArch: BPF: Fix tailcall hierarchy
> > >
> > >  arch/loongarch/net/bpf_jit.c | 140 ++++++++++++++++++++-------------=
--
> > >  1 file changed, 80 insertions(+), 60 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
>

