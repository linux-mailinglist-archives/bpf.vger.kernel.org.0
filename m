Return-Path: <bpf+bounces-40696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52898C444
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9B6B21EDC
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76F1CBE8A;
	Tue,  1 Oct 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTFjYeBZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157FA1C6F7B;
	Tue,  1 Oct 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802823; cv=none; b=HrCgOyKSvmnus+is8OgaORFcCOpnKsLNKpdzzEd2vdsbMXgq2hK/drD5m2iQxgiw7twuTofv1HEp0uvmnrTvjoIFCJbPUIqn/9+Z6Gzolo5Ohqoa/P7WFBWUNvkkvBxlZIL08Mw8KEozboVoUMmIhrcPL6kWTpX66It6Q+pETwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802823; c=relaxed/simple;
	bh=00sbHMuGV3Dwx3ttoTGSUJiHbYnX7tR4TimId/PO08I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwNzg4sJ+7j0tOlfq0T0dGgVKf8EGEzmK/fKZ2Qe+KQQJNG7kmF9aNYp+j6Bh4F9QqY3kmJI64zKyBOYNsugp55AEFGAeHoiScK7E/i4Q6+lsF7EoOPZ/mRnrB2Fxee+y7w2olPadO9nrBjx17heZOYfS4ORi3Jk66Kyq9liyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTFjYeBZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so4658729a91.2;
        Tue, 01 Oct 2024 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802821; x=1728407621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE/aVUCEIzpw0RB+1Vee6XU/y9TIKS3BYrMMft7eMdM=;
        b=FTFjYeBZTHG3oALEQ0jDFSk6/gZrwU7akQtKmlZ8qNFOb3SlhOWmXw2NPKfstLqtFT
         XVgTYiQRZVndpd/iWCDgBSQzGbP/YFuInHItQRuCrBUeVdOWRMdk1E9CD5q3dtZDdxA4
         FsMVcbHtz/djxyYQ+0A++npaV0Hc4dpqAnF8CXtLbE8Uwk4FfQSpohvndOTWz5mnZCzi
         sgcy2Qz4Dnnj33YTyyH32tfmopvCce6tst4ZwPj7B+meebBtyRGuBypo5yh1TftVVSDh
         EhBP57Fg0EOvKQ5L7nectjfb5rKsm0mCh9echIjjGsWpRJtImfe1FkZJdqedbNWZKHaP
         Kg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802821; x=1728407621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE/aVUCEIzpw0RB+1Vee6XU/y9TIKS3BYrMMft7eMdM=;
        b=cihDBHG2Brs3wyyqY7Ht8/iLXSOr2I0J5rSdHtXIGUS9lHpsySmIEA89h/+dPCkbx2
         rqvEPCwqIqin6xxomhihTbYGKeGIpC5KmjmGsggVUK5s0sPXsthmTwB/R70b79PgkqQ7
         mw1Ng+F5vt64R3QED+psRR1gb+obXb0T8jHPedKDtkZq5BC3QG+fHbKsXZchm80j5Mc2
         cO0h4AJTwkVjKnDM35q6pm5i+YLOvrqXH/df1tmtpadcEFymlnmbETMaX86lI2qf+wKz
         rKK5J08vGSoe1nW8CEwv4lZscda0W513aaGz3YiP7/HQ/kjkhXC0cnE4K9cQc408ysCg
         pBBg==
X-Forwarded-Encrypted: i=1; AJvYcCU4XdJThFrwJMTVEmNsX8MCeRnmqjiZYLY0ZGteIfvB4tGSGYVgeaWUmWpvt9GefH0U7uQ=@vger.kernel.org, AJvYcCVyioyLqvTcaH4Swghy0sYPPoUDonypxdVbPgsObc3y1TVOmueJPMNcx6OmghD6Yh6mCmzqCI+Cr7ZTI2G7w114@vger.kernel.org, AJvYcCX/IAHZEM5+VFQiJZS5he4ZNCl2b91IXSDvtqpmK7n7H51HhuQzpycy5Xt5gV0SdAMlQ5o67Au5Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlVqJAScILNnZ5BCi+Q67d/Y5VcPYtchG4l8PvFP8BgX7P8h3
	uSmq+RINY+rLfy+HDfTgoGufJhya3RbynKlcSsZ3mvR4NTDA5uZhct06db02lNcpO8UjUzB2HF+
	MBkxWX1+nCYmyAZUSMrHLzYTH/lQ=
X-Google-Smtp-Source: AGHT+IGE9l+kaimNC430ZGM25gNzhB0Qgna0N2iAc3QgTPzNNazYHyhg0Uyjn+TcAhSA5mSMUgvprHr9ghQ/C9XDHBk=
X-Received: by 2002:a17:90a:bf14:b0:2e0:b741:cdbe with SMTP id
 98e67ed59e1d1-2e184942206mr458198a91.26.1727802821272; Tue, 01 Oct 2024
 10:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
 <20240920081903.13473-5-stephen.s.brennan@oracle.com> <ZvwQR_LFnjxQNPIY@x1>
In-Reply-To: <ZvwQR_LFnjxQNPIY@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:13:29 -0700
Message-ID: <CAEf4BzaJXiEk03Tkcd2njf=0+pieZHrZ4gBhra0JL_7vF9uwpg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: add global_var feature to
 encode globals
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 8:10=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Sep 20, 2024 at 01:19:01AM -0700, Stephen Brennan wrote:
> > Currently the "var" feature only encodes percpu variables. Add the
> > ability to encode all global variables.
> >
> > This also drops the use of the symbol table to find variable names and
> > compare them against DWARF names. We simply rely on the DWARF
> > information to give us all the variables.
>
> I applied the three first patches to the next branch that soon will move
> to master, but the last patch I think does too many things and ends up
> being too big.
>
> For instance, you could have done the btf_encoder->skip_encoding_vars
> transformation into a bitfield in a separate, prep patch, also you
> mentions "this also drops the use of the symbol table", can this be made
> a separate, prep patch?
>
> There was a conflict with some new options I added (--padding,
> --padding_ge) and I fixed that up and made the series available in the
> btf_global_vars branch, can you please go from there and split the last
> patch into smaller chunks?
>
> Thanks for your work on this! I noticed that this is not the default,
> i.e. one has to explicitely opt in to have the global variables encoded
> in BTF, so that would be interesting to have spelled out in the chunked
> out patch that introduces the feature, etc.

We probably shouldn't enable this option in kernel build until we work
out details of loading vmlinux BTF(s) through the kernel module.

>
> Also since we have it as a feature and can ask for global variables
> using --btf_features=3Dglobal_var, I don't think we need
> --encode_btf_global_vars, right?
>
> That will also make the patch smaller, and even if it was required, that
> would be something to have in a separate patch.
>
> - Arnaldo
>
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  btf_encoder.c      | 347 +++++++++++++++++++++------------------------
> >  btf_encoder.h      |   8 ++
> >  dwarves.h          |   1 +
> >  man-pages/pahole.1 |   8 +-
> >  pahole.c           |  11 +-
> >  5 files changed, 183 insertions(+), 192 deletions(-)
> >

[...]

