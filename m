Return-Path: <bpf+bounces-37977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED695D5A2
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102481C2284D
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6556191F7E;
	Fri, 23 Aug 2024 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="qwNHQyP8"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232142A90
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439360; cv=none; b=bBMuRzT+87RdFtN0KLhXarHWaKJoz0teo7SPbgWBIt/2icwO55HPdaj6Ex6HnDDMOw4/i0ilU+uOF5LNbfklX3sk+Nce/gqWTWalTWKtu3mnElhjeHkscG5L2AxqKTFinR9wYHSQJ8pPMZOx5rU5FlAOOoYC+L/XWpdnTPD+fc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439360; c=relaxed/simple;
	bh=TJ39QYwSjQ6bLtVpL2SFmG679F0mbwzkLGsvhvnmYpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spyJJ03/55X8ZCglFI/sao9wSAodtv07iehtE2+J2z4y1iHnCeNVBZYdMQ1+SrXatsIBv1oWXCzVIoVqnKBftkjKVp4CDL+sR9fvZna6acMDgvPClu8Qhf9RL6FW6Fjonl0MkKt5K2lD99p9FJMSmt38VgNHXyo/4pYIaEfe7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=qwNHQyP8; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1724439357; x=1725044157; i=linux@jordanrome.com;
	bh=Dn+cocr/xX7ibhubmp/O9bsc473SzzmSt7HZjuyuK+E=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qwNHQyP8xnNSRBvjLdE5dkRMaGBW/z1nMMoq/ZMHpYTwkXLXOeUJ3wK+TEG1iKtn
	 xSvhesju59gthIf68CIl17hw9SpIa13O/sJbCW1kVYosb/Js836QghKjIpjfU05bC
	 NHA6Laq5pvLcc2L5pSQjS4XTxqLcJvstXTejuYqlji91u4wd8TRfHbYhtx75cwc21
	 mR8ftGIoT271iJ7eqjyf00AiIs8ZoF5Umm3Hdi3rhjnB4sqEYBz8wEFr7ua0Rc+QB
	 iNIOX8dRdzdeW/pF7eMszLmHq+vYvlrH/Cp7Xa16ak3RU+G88Vl8YkenGpeOexJgx
	 i8ybrTa7OBxfTf5TzQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-io1-f52.google.com ([209.85.166.52]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lb44F-1sF8RY1ffV-00aLgw
 for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 20:55:57 +0200
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f95052c2cso132777639f.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 11:55:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YzK/g/sSrQOYkdYiGfdL05dkLsnSqKjOa0+tGtdq4doMksL5M0F
	jwFx2YNyJiBxCqBOFt3c19Pt7kzkH+emjZiDtef6anlZueT3BFO5Sac3ZyyKWOaRbV+gJI813cH
	3i3D6aSKwjGFC4SsCqfwbbklqgb8=
X-Google-Smtp-Source: AGHT+IFZF05VnueioLN7XrINsZwDXkQCoo0DQY/Bi3NzXAoLexokuemygqQ9P58biRT1bVZiw+2d6o92NcRUwY2dy6A=
X-Received: by 2002:a05:6e02:20c5:b0:39d:286c:5b72 with SMTP id
 e9e14a558f8ab-39e3c9edeb2mr34191625ab.28.1724439357001; Fri, 23 Aug 2024
 11:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823184823.3236004-1-linux@jordanrome.com>
 <20240823184823.3236004-2-linux@jordanrome.com> <CAADnVQLkbkz07OpGkg0v0CYCw6MtOWoSLQT5qtYg82C-3BpN9w@mail.gmail.com>
In-Reply-To: <CAADnVQLkbkz07OpGkg0v0CYCw6MtOWoSLQT5qtYg82C-3BpN9w@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Fri, 23 Aug 2024 14:55:45 -0400
X-Gmail-Original-Message-ID: <CA+QiOd5dKW_omDmKkDiFNfKT=5LN8pyG2i3T7FJF8ybWPu1rkQ@mail.gmail.com>
Message-ID: <CA+QiOd5dKW_omDmKkDiFNfKT=5LN8pyG2i3T7FJF8ybWPu1rkQ@mail.gmail.com>
Subject: Re: [bpf-next v9 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GUnI9QIg4iAhBqKSdg4U/dtPODYP/zAEQGrd0zU1kYJWwyUFiKh
 i/QJFfh2tOvsLGD5ISwymIDRWfxBNEOpOUXtRl715RifS1nSpYSVvKWs3ZplaAEJVv1cgfI
 Mt8RavENbpcPDwTcd4bXZEcx7EFY1bWAqafHReeiZyxeWdD+k3s4Eyl0Ebeb9Jfzkf4FyKU
 FjruGx3CXPrxE8AeRhLMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IrtrNj2FauA=;NfMzmElH05PAiLn53GthQjpdIBb
 uT9kSMxGNJxEQp5C83qxS4p6vd+WNpAnKdCVkYzRzJv9SVVIH6vju7FL75o5wfb/+LmhGoPHV
 /h86XwPrnKgBoVRYz7PA4h0QnY3yvM+8xxJHwcrfT4AiIMLw32aQBwiMc9lz8kCG3pz2MYVYJ
 MbBBrkichCrH2qEFguZypcqlgAYWalXjSu2gcJuWLgGYDid4WRGeKkEBNt7eFAeC5qNumxahu
 OUSLRVoYM3KAOTgyox1n5Q4U4utYKoCEal5saam0zZqyNzJG6igDU88b8I9T8wYH2GZcJVNaR
 h+C/P+koliViYNonykbRpe8QygA4zpmspznj5IPwpXQq/wD3/TtejsnXxH9gRPjiEIXb1mzje
 9k2cUFluKkRW1Z9RNbUOCa69yVjqklvsusmnrXZ2OjH6VpsU9YLymM2rep+nrbxVXTOcWs1U0
 P/7fo/dZ3gWhm+z6mnvTGe6Ysh2Wm5pHigqyx87YxaS5g/rJ8eUrygjuxnqxaP4Ru/p4XjjxA
 5G9f0qvxJTyUD6fbZ71M78wgblmC/1ukWaIwE/y1nrwo02nX8nc4KyjQNMhCiTjS3J3q3Qjh1
 d05bl6b401Y1nZd6mO7z4OrSCVp4ozuHmR3/JcAc4uO3EEhO0yijlTJdVPj2w0t+Ds2+tWAa4
 7ST6/EfND21jVkB3/qyTek6cmkQKqy/59ZZaOwpyApKrjFooUWvF/XLpTBeOu6llC6Bt5IyKK
 Fs8gKFElzBvCsYrlusHun5V0yJx7ccz+g==

On Fri, Aug 23, 2024 at 2:52=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Aug 23, 2024 at 11:49=E2=80=AFAM Jordan Rome <linux@jordanrome.co=
m> wrote:
> >
> > +u32 dynamic_sz =3D 1;
>
> ..
>
> > +
> > +       // Make sure this passes the verifier
> > +       ret =3D bpf_copy_from_user_str(data_long, dynamic_sz &=3D sizeo=
f(data_long), user_ptr, 0);
>
> Did you really mean to &=3D into the global variable while passing it as
> an argument?
>
> And the compiler didn't warn?

The compiler didn't warn but no, I meant to do just '&' - here comes v10!

