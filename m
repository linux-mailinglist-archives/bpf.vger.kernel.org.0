Return-Path: <bpf+bounces-22600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47286194D
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100492852D2
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A576D12CD8B;
	Fri, 23 Feb 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEYGImvL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224C1C68E
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708928; cv=none; b=E9CEIqPjB/oKZAZlepEg0glYEdE1SGuDDgHf/RSNwKoCtoO/T0JT2+oS2zNwakESs91D5rjjTZFn898ZZ2+A7DyTuy8mXb6Icrt4/Uy5XPSAIESlI0Kmeaon2eYXSwtIPjzSYs/FQ7lEZ1vGmiHeJfqTAY4riUgQ7Jo61JeqvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708928; c=relaxed/simple;
	bh=Vo8IOjImjiZFeEi56KG57gDNg82DHfrJTxheD9u5U14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0fwmV5dLfVOzsIMTee8gZqPzygFA2UDGbaWNjg29tWRE3a/1YToNvYDArk8LaTgtZL+N8Or5DvODatwDbuYrSEjcviAuNMCxsMXBdF5hsKT6b8bjMvSDKotKyodzsyc4sCBslwdGBQb1JHdVc3jLA+LgJP12Q5UTvZ7zoZwebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEYGImvL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412934b98b8so6129585e9.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708708925; x=1709313725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGfhO2aYvcwHTmRO6BvEyerABVFn/OnnOwKMK1mIKPA=;
        b=iEYGImvLlfq5ApenAf/DVJNiuiAQw5l/vxNF4NMYMSGGDrFyQt6gZZkbtOVBFM9BuX
         2YAUEHggoV/grbfOoMYu9fiJCkoDrMJPIes4/rtzJx7ZzVE1BRHAGGcQOjDjeQk3mxoc
         n96/SptWb6iouv2RcOh+Ng7OsSZkHB5iMc3tEjSEWaJ5v2CjvFYABEGmx/zJUkaR/KMp
         /iuXWEPXsRMubVKMh0Wor0XstOCW9inAdzzfzoKueYr83zNCg+Fsn1tzB2uaggEnL4JT
         MBANuSvkPN0E7fDSQ0aFL8ZTWfVn89XeGnsgfeAYaKFxiiP9x0uGs03Don35GZtO0+4j
         oskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708925; x=1709313725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGfhO2aYvcwHTmRO6BvEyerABVFn/OnnOwKMK1mIKPA=;
        b=LXkThBGSwNQIxuhBrltpMgyWMpTNfuQsdiFJ1cXorMYp7U9oAEa5tdhwxXc9QkPhmj
         nRspPtbpU76IF+vg7FBPqDPr2cmPs1rCZ62v852jseOpAgzsZJtwM19PnoOWJNE7Tx1H
         oIrgrk51qf+dP2uJTIwlOOWiAeGd4Obp+cDIN1wXNBdaAulGgTTBINWYj6rnxc6/pMZH
         zm06QLLpbI0fCBK4+ZuigjY7+Xv10ti4Dlv7smErZjGbkCxaSg8/UFsj+P4VszfsN6l4
         mv0ZKYRPMIVJwrMJqFMRjDMcZ0gOpEuPx1+GtGYkBosSJwv8BdISZKPNsrHbMZuflpFM
         TkGA==
X-Gm-Message-State: AOJu0YybSMtEhkoYlkQP7cv/2qRTIPxxFieyDH3NBgqKOto1R3+D329M
	EpDyor6eWcaJMsEQ0SoZxut7r1G3z3I02CU44lM0n5g5FcSadVO5sAMY2bPmYEPopuC6Wa7K8mA
	ELy+MpL6T/4t+fDq72oco/psoDnI=
X-Google-Smtp-Source: AGHT+IFJcZkMo4onpnsTVXdsVweqRLvRMuNfYRYzDqxCt0SxyC9kTzkR4vkA+p2fLRfwXeQM08IR7xyABlpproklgWs=
X-Received: by 2002:a05:600c:3d9a:b0:412:7721:31b5 with SMTP id
 bi26-20020a05600c3d9a00b00412772131b5mr286662wmb.23.1708708924587; Fri, 23
 Feb 2024 09:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222085232.62483-1-hffilwlqm@gmail.com> <20240222085232.62483-2-hffilwlqm@gmail.com>
In-Reply-To: <20240222085232.62483-2-hffilwlqm@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Feb 2024 09:21:53 -0800
Message-ID: <CAADnVQKazm5q3fKFHa1gPpBOz7aJ-7LomK=XmPvJeypT_45iaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:53=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> w=
rote:
>
> +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
> +
> +static __used void bpf_tail_call_cnt_prepare(void)
> +{
> +       /* The following asm equals to
> +        *
> +        * u32 *tcc_ptr =3D this_cpu_ptr(&bpf_tail_call_cnt);
> +        *
> +        * *tcc_ptr =3D 0;
> +        *
> +        * This asm must uses %rax only.
> +        */
> +
> +       asm volatile (
> +            "addq " __percpu_arg(0) ", %1\n\t"
> +            "movl $0, (%%rax)\n\t"

This looks wrong.
Should probably be "movl $0, (%1)" ?

> +            :
> +            : "m" (this_cpu_off), "r" (&bpf_tail_call_cnt)
> +       );
> +}
> +
> +static __used u32 bpf_tail_call_cnt_fetch_and_inc(void)
> +{
> +       u32 tail_call_cnt;
> +
> +       /* The following asm equals to
> +        *
> +        * u32 *tcc_ptr =3D this_cpu_ptr(&bpf_tail_call_cnt);
> +        *
> +        * (*tcc_ptr)++;
> +        * tail_call_cnt =3D *tcc_ptr;
> +        * tail_call_cnt--;
> +        *
> +        * This asm must uses %rax only.
> +        */
> +
> +       asm volatile (
> +            "addq " __percpu_arg(1) ", %2\n\t"
> +            "incl (%%rax)\n\t"
> +            "movl (%%rax), %0\n\t"

and %2 here instead of rax ?

> +            "decl %0\n\t"
> +            : "=3Dr" (tail_call_cnt)
> +            : "m" (this_cpu_off), "r" (&bpf_tail_call_cnt)
> +       );
> +

