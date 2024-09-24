Return-Path: <bpf+bounces-40260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBF9846EB
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6200284097
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B51A76DC;
	Tue, 24 Sep 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUUvJJoD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76C1A3AA6
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185250; cv=none; b=q5IINEm1p5d5wR7H1jCL/uiT1k/wgUX6huMxTWD420+4ElDeGkNMEopcx/J5Pfk1FJWdVX7tRMh+6aKwXJQ2SNAvJ22zrXavB3m+qJiKIv/1+jF9tYkGp+FH1O9c5Ch+L+T1RxIxHGiDJRenaKHEltXEJT55OyyZBNWv3Ns41Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185250; c=relaxed/simple;
	bh=tR4tMiGz+darHrb14/OSuvM15nx88qECdq+fm7CshiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHJVd24ZqVNezDIo6iMJvLZ9LiyrRXADnZzRw09qRsY8H7gzqQOmzSxnq7SKH6cF7yT4G4R3cxt6OuOMsFrI5OaPWWJC4S0FP8IzncGlyJxgu7KTUa4vstD8ilDR6xqo5NgkMEKfiRcgH8roMCHasXdGNTdjEPplw/XWDADXqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUUvJJoD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d446adf6eso856567966b.2
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727185247; x=1727790047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR4tMiGz+darHrb14/OSuvM15nx88qECdq+fm7CshiA=;
        b=IUUvJJoDd0mmj4jXRCvmBlHVvaJj34vIwnAmZJflABMQ3BOsqBo9I/KRKx5DNAx6HP
         cO7bUk+4mDi2Q5t/IIqlLWLH5mp3k+D0uSeTa+hw/wZawe+gm5SgbqqMd1cg4Z+FvBNm
         0+rYS9TgFjjH9jMn4CB+70FbKlzxp8h53yEsSa/o4SpKPgck96z4zQURTXCtuN1sYZMc
         wFUxXsN83fdlEpAIgyQ8TELHNVAP53iwfSahcmHw0QVAgS1e4kcYQj9WDOYlSChyblXo
         7HRx0tvjeMUpA8hKJAT4UimkYQYUpJmoRfWbMs2bttdv3ldwIQxEV6EWsmDgMO/MWqkU
         brXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185247; x=1727790047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR4tMiGz+darHrb14/OSuvM15nx88qECdq+fm7CshiA=;
        b=MYz4I4owK7IKsGBghCGjYan9Ah7EFxmWB0FyoPnujpg/F+OIFNXph6SRrO4742HCVh
         Ududt5/DOX/9k/iYv2sB0l81gO4yLmqVuHQevnA16PJnCNCT7MuEe8PFfAC37u9xmxiW
         j3eV4+6f3QUsP1H7DH8Vl0efcQDJzSbvzG10ahYAvT0FkGw6+eHHum3hgprbzS64cJq+
         RQZCQJIEsFGrMy+XCQtALMV2Psg/6yH3G5O6lSCvWs6N9Co6S5LMJLh8dGVF5hhIfdte
         E+jUDRnV/lGXeg2KM34T5RhuKMEkAcqIiaJxSCN+DchnwCEF7VvG4suDeV6Z5Zt+8/q6
         B64A==
X-Gm-Message-State: AOJu0YyiAtiM1qAIo/vsRU7FM/pgBMl47mUuTpIWsublyDo93AEkK45t
	dgXhKm4hMIyVQ5iy4d7fdYoZWUW3F/uVLF7d9A1a8052cLgJYyeKVy/zrtBmGUAOG3N3q8/zgkW
	C96oz/zfX8uqmc+Vr2fjHAcpb5WvJOLrEpSw=
X-Google-Smtp-Source: AGHT+IHbOtGtEb661lYnnPP00b7ZdQ61spuyXFLsxdNMRehNRmJDRZkW0XullEqGfRuvDT0MZLQbiSGbAC6XZ36Ss70=
X-Received: by 2002:a17:907:e6c7:b0:a7a:9144:e23a with SMTP id
 a640c23a62f3a-a90d50d0b0dmr1496634866b.43.1727185246537; Tue, 24 Sep 2024
 06:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
 <67451140439fafa1bae3e3b010d2c6b9969696a1.camel@gmail.com>
 <CAH6SPwj6=zu8fLNLwZ06fTso9634GV6ku21xpyzN+bwvrOevFg@mail.gmail.com>
 <62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com>
 <CAH6SPwjoACNcNBWCjYauSMYCFOUAys10uH-xM6mF8_Q79D0Yow@mail.gmail.com>
 <CAH6SPwhUnn9-nNz9fpX3YGeA9WHT_BA5UzNgS5wYMqO=+8Ly_A@mail.gmail.com>
 <7e2aa30a62d740db182c170fdd8f81c596df280d.camel@gmail.com> <e90b14ef01cc49b790b2b7a6dca19e873e47c671.camel@gmail.com>
In-Reply-To: <e90b14ef01cc49b790b2b7a6dca19e873e47c671.camel@gmail.com>
From: lonial con <kongln9170@gmail.com>
Date: Tue, 24 Sep 2024 21:40:35 +0800
Message-ID: <CAH6SPwg9z6rXsvN0MgCj4tnGy8Fny_Lk_S0JPS98LrTORzNydw@mail.gmail.com>
Subject: Re: [PATCH] Fix a bug in ebpf verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eduard,

Sorry, I was on vacation recently and didn't reply to emails in time.
Could you please submit this patch directly? Because I am on vacation
and don't have my computer with me.

Thanks.

Eduard Zingerman <eddyz87@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=8C 16:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 2024-09-12 at 16:36 -0700, Eduard Zingerman wrote:
> > On Thu, 2024-09-12 at 22:40 +0800, lonial con wrote:
> > > Hi,
> > >
> > > I tried to build this environment, but it seems that it needs kvm
> > > support. For me, it is very troublesome to prepare a kvm environment.
> > > So could you please write this selftest?
> >
> > Please find the patch for test in the attachment.
> > Please submit a v2 as a patch-set of two parts:
> > - first patch: your fix
> > - second patch: my test
>
> Hi Lonial,
>
> Do you plan to proceed with this fix?
>
> [...]
>

