Return-Path: <bpf+bounces-57949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF93AB1F1A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585EE1C28876
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444225D21D;
	Fri,  9 May 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbc4TacB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2E235072
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826578; cv=none; b=NH7mKGOPlz/7qL05BI55NbFldRoEM2WuH+FnggT/SgiXS1scCcfRTKuJlgZHKJsa3CHE7354RB+sehGIt/2z4U7VWeQUSqEdehm7GgqSRknFypKIQP3mx73peorzNvTHhfRcu5HQzs35tiAf+TrhPh0bhXkERtdrA5dpufjwJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826578; c=relaxed/simple;
	bh=b4+j9wEJYIwos8bofD+YLPonhYur0aOJ7kxItTX5log=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bocoJDNQBMsiN7xtjr2vktLvkOZ5gfrd8ye6qpTqthlsmgPYxnX5WZNlsmwg5FDTWF5I2wnI3BDYwdBcveYd+voba++z3z79dB+yXfTpobnsmbIM9jCePpTdMpKvAPi9lHtsGvqRQ0430uRDJejQ0ydiEvWcYK+DjGo8PbL6TIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbc4TacB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b1fb650bdf7so1621287a12.1
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746826576; x=1747431376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2fxBH4HLVj/j3bIV2Hr0mDDgRA2FIrAHXXFX2oeVSA=;
        b=nbc4TacBJLCSw+7/xWFuBm3r6MsuVeIMZABEVwFTDTfNbXOVGKha5V6zFcsoPLHXdK
         OqP5hQ9g3rRWc6kPHV2lf63ECYyZ0aEb+2UKTk9RvC+WO1jfh7T7NpK5VMlHciVJi49h
         IRbVmpMc/RWNOxeBDMLiGREYhSWEwCB5vFvSwefhwYoxqCPZKigG/0J+qyL9oa6UeABk
         BJ6+kThYPLeo5B9+1OnePKc3M/2pFgeB5xzspxXvhaBGVUPq7CmejL6ChWRFrB+n5d7i
         RwJotlzJ15VH8pKIK+4bwA9Ver9CVbYMfu6v6G2yfFQ3v2bFGU40vM7YdM5bcQRl4QJp
         iWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746826576; x=1747431376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2fxBH4HLVj/j3bIV2Hr0mDDgRA2FIrAHXXFX2oeVSA=;
        b=gBa7MkNL4igFmreyuXYQScCrcwGaGRn29zAUxG2b/eN1bIEcJf/96fgZUAijugXPSK
         kN+MpNd0zqmoci6VuwGYrKlXhWyeY6u3QTQIdq5k/mhiIMCkMTBbfr6LL3mmWGTvt6jV
         LZypddm5gzpnJSta1jbh+PWLf+2yun4GgjK38/OET0H1hqrhkw6dcQ5j0k7Ma4FWuw+u
         KwlHpRqsljBnvF0bqDp8ETHDxMh/+heNv0N0BcSTfPLBLHAlxMUal89WcoorqDBE0QiU
         STUGtxTbDA6QAgLS3AfimShdNVkhT0WJ8J3JFB2q7dEVZwHBEBaISk8jTswizCH/t9JL
         u0nA==
X-Forwarded-Encrypted: i=1; AJvYcCURyEaQm5HN+uT7UIBLL25fOpCoFfP6h5w8VTiEXe2LvdFzOwvERzo30+zQ0tZMnVFChQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1cF1eHSZIgfl9qk3c8UER/3txSUGcemhSGv1bdheaUhGD3+b
	7LSIoAmWBoEcLPxuc6PwkU1xYEPBOhLGojIvz2Wq7puBjMHXZ7+5qrxV186d1gz1QRr/SDhbp+7
	JsgthR28dozlQDZ4IWfbhggvbkpA=
X-Gm-Gg: ASbGncuy8mn0zrjIPL6bWc+vQ4MtrYBXSm1VipYQr1tQ7nUPMnBjATg64jXWhmNBmWh
	8pHl7jlzMRSIDGvb3UYMmnI5JG0x4JpbjNfvKeNyJbPjmg+ER56P0+T7CZ0S8Fg5gJqSlI0IEvv
	pCelXH0kLL9O5VST7jD/TRRZgd8zpYoLs7TOwaJTl8lye63GBVar408R053uc=
X-Google-Smtp-Source: AGHT+IF4pn81GoY9yzz6SQ/3lMhq9eZKrSDLa2BE88k24ygobxOebSYkuxLSAiovt/ufBtxGVyzcTYJuakDKNC5hfmY=
X-Received: by 2002:a17:903:187:b0:224:194c:694c with SMTP id
 d9443c01a7336-22fc8b592c5mr81201035ad.28.1746826575834; Fri, 09 May 2025
 14:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
 <20230728011231.3716103-1-yonghong.song@linux.dev> <Z/8q3xzpU59CIYQE@ly-workstation>
 <763cbfb4-b1a0-4752-8428-749bb12e2103@linux.dev> <33a03235-638d-4c63-811d-ec44872654b3@linux.dev>
 <CAADnVQJBgEDXnsRjTC0BUPAqfiHoH+ZL6vk1Me-+QcXbT811jg@mail.gmail.com> <342054de8fb765780b1856e5b3b81b4e0a531620.camel@gmail.com>
In-Reply-To: <342054de8fb765780b1856e5b3b81b4e0a531620.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 14:36:00 -0700
X-Gm-Features: ATxdqUGiFplJdWseflvFpZPHTZSgkaMNIe3Xy2SkyJLBjNzqokmur9l19Dw2sN0
Message-ID: <CAEf4Bzbgci5pOmHmYoAYTe6cYdwJ4ju=5LuT0VQzsu+aKQ1AgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 07/17] bpf: Support new 32bit offset jmp instruction
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, "Lai, Yi" <yi1.lai@linux.intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	David Faust <david.faust@oracle.com>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	Kernel Team <kernel-team@fb.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 1:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2025-05-09 at 10:21 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > hmm.
> > We probably should filter out r10 somehow,
> > since the following:
> > > mark_precise: frame1: regs=3Dr2 stack=3D before 7: (bd) if r2 <=3D r1=
0 goto pc-1
> > > mark_precise: frame1: regs=3Dr2,r10 stack=3D before 6: (06) gotol pc+=
0
> >
> > is already odd.
>
> Not Andrii, but here are my 5 cents.
>
> check_cond_jmp() allows comparing pointers with scalars.
> is_branch_taken() predicts jumps for null comparisons.
> Hence, tracking precision of the r2 above is correct.
> backtrack_insn() does not know the types of the registers when
> processing `r2 <=3D r10` and thus adds r10 to the tracked set.
> Whenever a scalar is added to a PTR_TO_STACK such scalar is marked as pre=
cise.
> This means that there is no need to track precision for constituents
> of the PTR_TO_STACK values.
>
> Given above, I think that filtering out r10 should be safe.

Yeah, it makes no sense to track r10. It's always "precise", effectively.

> In case if sequence of instructions would be more complex, e.g.:
>
>         r9 =3D r10
>         if r2 <=3D r9 goto -1; \
>
> backtrack_insn() would still eventually get to r10 and stop
> propagation.
>

