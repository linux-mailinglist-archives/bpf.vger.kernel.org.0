Return-Path: <bpf+bounces-53827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE0A5C422
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82061189A274
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746125D526;
	Tue, 11 Mar 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3ILEWZE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE425D20B;
	Tue, 11 Mar 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704078; cv=none; b=oAuuCZohuArNTzmaK4QWP2jGW7jLioCtq+IOn7Ko6/aHp5UXath7K70jxitW/SMp+tsJSjOonKegQBkdbNnCEJ7wMTaZErUAkbvmM0AetDNjBaDKS8LvkaOsslda3LkkVWL0FkVm0VNVrPF+Pu68k5SbyGg3Zr/IqAUi9FmD0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704078; c=relaxed/simple;
	bh=tzR4oTMWZrrlzTf+DNT98alVDMZid85WIeYI2G+dsl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRtyCIrYOBY9vWPUlvddc57oMJewuJ9C2zDArab77WBzTpesvF/uwghitvCpNLG0n9AoV60kB6Z2V8XODpE8raMKB1XmCCGoeBgZyiQ7dl59Koo8MHLFWHnFAyEcgQIoinI8brePs9pORFQ1Ry2oo9v68KlibtmsEPK/TlYh1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3ILEWZE; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso4802000a12.3;
        Tue, 11 Mar 2025 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741704074; x=1742308874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzR4oTMWZrrlzTf+DNT98alVDMZid85WIeYI2G+dsl0=;
        b=i3ILEWZEOmXfZA3dXYncuoRN9utsQWuUpWoZ/aWDgFon86Dk5MQJR2Znfa+UTMkA0v
         IdwSn62UqwFf5Li0BlcHWWy/wkqj4QD4DxY9fOIhLtjdGNe/1L/9Plfq8blD4ccB6qmt
         GrgXOLkRNZeH0GublH0PFBvPCcvaEq+7hjUuGG+kCIYEfjvE5IBndqB9GQrSgUh79+rs
         ZHF4eXaelA9yy05UfmgZnjN1WDHbyD6F9y1POdRPOVhaYTo2dU+lYinWMkGomljLrIp7
         5mkqiVGCFtBLvhnkFOjh4xtieyGUYircDo3o02Lm7Ei4dMdNc3JbfBs7+A2W34uab6Dl
         RSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704074; x=1742308874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzR4oTMWZrrlzTf+DNT98alVDMZid85WIeYI2G+dsl0=;
        b=VhpzsJPDcMkevOTfmULEhckCI5zfwC8qfREDtjgmUOiePcVjtsBhA+OAPhya1nlxK0
         enoI8HcQltGLv9WOzsljPVT5VnFqh5FWimdtMouj6UEXhX7AqpDwx6IPMJaREC/kYeQb
         w13l14AhsFXX8RzmpOO6Msds5YOVoKpjXeRG3Ygd3T9MT+D8PJFnLgm27hgpzSpq9Rd9
         XztBhuGJYWkH3yWXO5J9dUyZ87gvy6h0uVp6jUu86qbgpiPvnGUj72zzwZiBfF4Mw0r9
         2cgnjbrogmna1LZL8zgS+Rsy9TOcufyXSiesLmoicHCwnbBDT4T8kD0yS0rd/rb9Gity
         9iUA==
X-Forwarded-Encrypted: i=1; AJvYcCXUX2tTVFYc7b19smisheJnEJ/pN5crCMwpPwP/Y2M6d2pWWSVv79pP9+l55ohzJzCFSyALtCrMGJ7K3nxi@vger.kernel.org, AJvYcCXdyZdkE+w+XgQKszJ0IbzXYRwVbrnWIWBEG6KVnt9IMLnvCnMdpRIenTR7QQI2ijJduBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjI/PjS+DUrCwdsnN23oMjhi83/KyMicuCseGw0y88kRb2FIGm
	6Q7fehMUiNLWMGvAvdSOEMpIGjfdIjBHwmhTTvEXTbNAposau1/LBbEv4FSQAnRUDGLDxdK3nsn
	Vwhb7pZ2Td6FDwYiDLObiHicAokusbD+w
X-Gm-Gg: ASbGncviHQaZ1kYI9vt3lVJiLiAUepMI1+Sxl6RbAPWsWl1gouNwlvYiAzDTfgGuG59
	mglK4CzINGqa5Ae5yaxL6HiaE1izMO8+IrxSsKZQZ0zg+4lkRfTsnlKkIfYQ8PD73XAc/SSqQwd
	8L2UoY7VyU+WSAy1rp/N8PXIGF2p8EIpc3CMP3p2DJOD5yG2c=
X-Google-Smtp-Source: AGHT+IGmRfRAQ1YO4ZEbrrHK0DuI10D+z3ukWil2ra1XlKwIHvFVHsrOQ7PvCHOwXV5WaHJgEnqvJVQHdb0VjeYW2v0=
X-Received: by 2002:a05:6402:3547:b0:5e4:c026:2d7a with SMTP id
 4fb4d7f45d1cf-5e5e22d8c92mr20442935a12.16.1741704073551; Tue, 11 Mar 2025
 07:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7bc80a3b-d708-4735-aa3b-6a8c21720f9d@linux.ibm.com>
 <CAADnVQLUxTjYuvwyO0CMS5=e0YqmP525+EDfJX-=dH55g8XTXg@mail.gmail.com> <7e47814f-37de-417d-a84b-de21147e372f@linux.ibm.com>
In-Reply-To: <7e47814f-37de-417d-a84b-de21147e372f@linux.ibm.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 11 Mar 2025 15:40:37 +0100
X-Gm-Features: AQ5f1Jo_nH7jDVykqLyjOuNRKVLoDczT9LjIFIPBK23DaWK_m_7HcYQ549hJvHM
Message-ID: <CAP01T77sC4czYEC6XX-qUs3a7aNy=GNjRR+t6Q8srTFrRSCpqQ@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf fails to compile
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 at 15:12, Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
>
> On 10/03/25 2:15 pm, Alexei Starovoitov wrote:
> > On Mon, Mar 10, 2025 at 8:32=E2=80=AFAM Venkat Rao Bagalkote
> > <venkat88@linux.ibm.com> wrote:
> >> Greetings!!!
> >>
> >> selftests/bpf fails to compile with below error on bpf-next repo with
> >> commit head: f28214603dc6c09b3b5e67b1ebd5ca83ad943ce3
> >>
> >> Repo link:
> >> https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
> >>
> >> Reverting below commit resolves the issue.
> >>
> >> Commit ID: 48b3be8d7f82bea6affe6b9f11ee67380b55ede8
> > ...
> >
> >> If you happen to fix the issue, please add below tag.
> >>
> >> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Not quite. The issue is likely that your llvm is too old.
> > Please upgrade.
>
>
> Thanks for the feedback.
>
> I did try the compilation on fedora41, with linux-mainline kernel and
> /sefltests/bpf compiled successfully. But on the same set-up
> /selftests/bpf failed to compile on bpf-next kernel.
>
>
> OS: Fedora Linux 41 (Server Edition)
> LLVM: llvm-19.1.7-3.fc41.ppc64le

After staring at the error log in disbelief, I guess I have the answer.
https://elixir.bootlin.com/linux/v6.13.6/source/arch/powerpc/include/asm/qs=
pinlock_types.h#L8

PowerPC overrides the type such that lock->val is no longer atomic_t.
All of the bpf_atomic.h helpers assume it's atomic_t, hence they try
to do lock->val.counter which obviously fails with val is u32 instead
of a struct.

The "fix" would probably be to replace the usage of struct qspinlock
with our own definition copying the asm-generic qspinlock type.

I can send a patch later today in the evening, unless you beat me to it.

Thanks


>
> gcc version 14.2.1 20250110 (Red Hat 14.2.1-7) (GCC)
>
> Passing repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> Failing repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
>
> Regards,
>
> Venkat.
>
> >

