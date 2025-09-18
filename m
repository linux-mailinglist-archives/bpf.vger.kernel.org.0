Return-Path: <bpf+bounces-68766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026CCB83F45
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4E3B4A48
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFDC26E71B;
	Thu, 18 Sep 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiemgmDr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88552AD0D
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189836; cv=none; b=tkyR5XdZ6j5vJQ7Iids40HdigL3MMyekAyG9fQfmKP9phByTdAbq6srEcYuF3sZwpmmdZb/sWz5RgZ2/o3qvQ/7KPDOZF0xtiSxCn6DPJ4CJi6zd8QbmXLMMKTPIoT1RzQTNBariWID3OP01rS9RLeXb4Ya3VehO9HB28DE66EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189836; c=relaxed/simple;
	bh=ByoR0cEGZmt0U5yHB5jQZmZ+RqLPgIYZYhgl1JFL/9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCD5G0mbxvBNa626vYX5YPzE75D1n1GKzQj1oMf7G+LS+b6MX+Z6cFaXvoqFrkhDMJlfrAGY/d/TjJdj8JzlAcVL3xLYHG3W+rGQXNh9+g/687juXEhaU1q2F4+bzxiRLWYxhRvin90GJh6wgeSO29YMV6/QtHSOtzsvVmOPe/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiemgmDr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-56d1b40ed70so750677e87.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758189833; x=1758794633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYCwkNUkEu1XT0gLNt7N//elymkdc3M3C0TwfgGszbA=;
        b=HiemgmDriJrtiUc6x6Z7M/ID2tZGsZimBYbrD0//RX01sKzaWuGPBgdlv9jM/mH4J3
         ya50pFzLfthv3sRUyf96wKLHEIkGnB9a2lylgVVoWM0btPWSuXz4IYsK0TwP7fbYaMJh
         2OMhijyZvnXH/hjlNaF3n5K3AOn5pR+xe25RybqlyN1sco3PfXYwLCfUAWCw23vajAI8
         2V9KEyzdLaRRkYCZcnstNsudEkbJJnPJexXJrdrjZfvMvjXqXCgjGFU1iX0kir7nvhJb
         KjhEI+VbF2ifWpQeopxMyrk2rROGU0CFjVCmRm8lEyqgEY+k8at0Zj1NWwf4xcjPZt/I
         WNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189833; x=1758794633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYCwkNUkEu1XT0gLNt7N//elymkdc3M3C0TwfgGszbA=;
        b=fOK3vyTSi2kEpyaL8aVP/21vP0n9xPDPdosGOzGOXKrtMZfmfELOay2MO2MQElyGpB
         Fs3bU88XiR85J0qeADSkVlxG3wNGDbukKVs9v0cdEr7XcEy+nxAXv5Wd0zNGRCBzUChB
         iduLYRvb+tvgzrp6hJ15Sa8XwwoF9SxiDJiVcmDXUvXmfGnHgO3pS2tdg982zhc+8QZH
         hjydnPHs9a05e//2dOdW9Zep/1vk7xoz2KH5W3w4A5Pu9QQ8AnASQOpm3HsZ1NZ9Lo5A
         Vo9zU8qsc2oX/1PpXty9/S/O0/h2A7xL4a4IoSzDw6tpkB17QB+jQ6jY7B169bwpvQ0J
         3Iaw==
X-Gm-Message-State: AOJu0YwgMRNPd3U2k61zww8UQkjjUJI9+aX0vmLJJ8pOc8UFC2B2d8+S
	MrWvOg5Z5xYH59nIx2ggfgXGn2uyP5c97c03BgrzEG2G2njBdS75igrNKF7DGliipILCThHs6Zx
	blOUX9RnhdseWXUTPRIHXI4r5ckg48kI=
X-Gm-Gg: ASbGncuPzzjw6elRtVoQ2EHfIAQQmTwAK3wsUPOehjNX3YZitg0iGf2StsEaedJiM86
	/JcBYc+ReFkyJKZxWC3oBz9zUxuh6g0rb6Fw9TrdWOmmhWilRu/PHWwSyAGVJNayPEzLRLkpbFR
	WC/LqpIdVyi0RyUHYHwkzDbI3iwkZxaw219fr8UGprUHXsvcMUvQxSkOfudu2oghCC3Dq4Q4dhg
	FfjLsIMvNde5goSZ/+FMUUOPVk=
X-Google-Smtp-Source: AGHT+IGWZd43JlKEWN+6I3rADVYp29++tuAbpqU7PxhYsMZJEVGNUvfnGTLsMFkPHV6lU3pTyYHqYCeJcd9azkwT2OY=
X-Received: by 2002:a05:6512:32cc:b0:571:f077:d96f with SMTP id
 2adb3069b0e04-57798756ae8mr1625467e87.37.1758189832455; Thu, 18 Sep 2025
 03:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKMdfmZo0520HqP_4tBDd5UVf8UY7r5CycjbGQu+8tcGge99g@mail.gmail.com>
 <CACYkzJ7X2uU=c7Qd+LUKnQbzSMyypnUu_WCMZ=8eX6ThXn_L6g@mail.gmail.com>
In-Reply-To: <CACYkzJ7X2uU=c7Qd+LUKnQbzSMyypnUu_WCMZ=8eX6ThXn_L6g@mail.gmail.com>
From: Ariel Silver <arielsilver77@gmail.com>
Date: Thu, 18 Sep 2025 13:03:40 +0300
X-Gm-Features: AS18NWC1YY66Iv1oonE3FepE-UmRLhzM1gqFCSI5l7KKoA-asGkp7gFlZKHvA10
Message-ID: <CACKMdfkPsemrUMPXNO5OR9Y2y70xNVVY9ss-3hX9NtGXFJxyQg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/bpf: clarify ret handling in LSM BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just so I understand.
1) The docs are indeed wrong, correct?
2) Any idea why I get an automatic response of "CONFLICTS" when I send
my patch? Even though im 1000% sure there are no conlicts

On Wed, Sep 17, 2025 at 12:31=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> On Thu, Sep 11, 2025 at 12:52=E2=80=AFPM Ariel Silver <arielsilver77@gmai=
l.com> wrote:
> >
> > v2: Fixed trailing whitespace (reported by checkpatch.pl)
> >
> > Docs currently suggest that all attached BPF LSM programs always run
> > and that ret simply carries the previous return code. In reality,
> > execution stops as soon as one program returns non-zero. This is
> > because call_int_hook() breaks out of the loop when RC !=3D 0, so later
> > programs are not executed.
> >
> > Signed-off-by: arielsilver77@gmail.com <arielsilver77@gmail.com>
> > ---
> >  Documentation/bpf/prog_lsm.rst | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/bpf/prog_lsm.rst b/Documentation/bpf/prog_ls=
m.rst
> > index ad2be02f3..92bfb64c2 100644
> > --- a/Documentation/bpf/prog_lsm.rst
> > +++ b/Documentation/bpf/prog_lsm.rst
> > @@ -66,21 +66,17 @@ example:
> >
> >     SEC("lsm/file_mprotect")
> >     int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> > -            unsigned long reqprot, unsigned long prot, int ret)
> > +            unsigned long reqprot, unsigned long prot)
> >     {
> > -       /* ret is the return value from the previous BPF program
> > -        * or 0 if it's the first hook.
> > -        */
> > -       if (ret !=3D 0)
> > -           return ret;
> > -
>
> This is correct as of today, the return value is checked implicitly by
> the generated trampoline and the next program in the chain is only
> called if this is zero as BPF LSM programs use the modify return
> trampoline:
>
> in invoke_bpf_mod_ret:
>
> /* mod_ret prog stored return value into [rbp - 8]. Emit:
> * if (*(u64 *)(rbp - 8) !=3D 0)
> * goto do_fexit;
> */
> /* cmp QWORD PTR [rbp - 0x8], 0x0 */
> EMIT4(0x48, 0x83, 0x7d, 0xf8); EMIT1(0x00);
>
> Acked-by: KP Singh <kpsingh@kernel.org>

