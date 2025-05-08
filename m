Return-Path: <bpf+bounces-57820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E2AB069E
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3734D3A3CCC
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4AA22D78C;
	Thu,  8 May 2025 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IerUooPD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438E227EBB
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747254; cv=none; b=kNoPcSB9TJn04H7rBsyR4gbSRGEpMI+iOQGI7qDUQd/EXSk1yKn5imf4A4dOmrXued10FqhzdemKmRG91pzLu91QVQKjaUJGweS3rvgcVc4IcMee+X4RcICBLvcORl7jeNQrpCmmsD32mkU3T3JZ1p4T4A+eFfJ1/DU7qIYx2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747254; c=relaxed/simple;
	bh=NEQoObU9In/8sVOO1bBmyJCwRJ4YguP71MUdRNwbdk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyPnuX6G2FBS069qkfpyT0hMGv/MJwB4LRky50PMXQ4XGfjeJpBAMWHegHkQTw1yj8l0VNJ7a/2AbfWhRoC9PctJV81HWe/9rpSFCnBiSWbAR0MtsfovGYqDEa2ro8Vu6MJpF/8+iwAl5hrxNu6w2S/BRg3WHno+OR1vkaKChmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IerUooPD; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so2944266b.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746747250; x=1747352050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nuhwVRt5X8hOvfw+Bz8Lfw9XUQOLxy8gckjGnAmgqw8=;
        b=IerUooPDFhKczrPYNBuz9f3OfGfqYkjO/LAuWboyRDJ++wK11BfNOnk7hjihWvYO76
         +7imgYx4XHISAUWT72IsE14uDKrLYTakY2NzyeA6yxKH4DAcRW7pt/AonPeQgJKn3iPU
         GWK/M7rjI+XlfhHLAIkqXJ9d/Xz3wkARnXDUBs/K+D2f1dLFUdKIQe4gvd01QECbeVh4
         RW9P1Gv6DkYJpF+cw3Lg5rAn6Qar6m+ekpq2v+RIQjRVeD2Pa9UVDZQTxzBOVHCPHWN+
         mwfmrv8vpG3tOTwkPgVmR4yRsNkXQ6stipaAfEGEwGQawzHwCZSdDIzivesx2oWWiGng
         7GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746747250; x=1747352050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuhwVRt5X8hOvfw+Bz8Lfw9XUQOLxy8gckjGnAmgqw8=;
        b=F2tTmUiFoN1LK1FADqUEfYf2+9zxKHTKnfiah1gukyihhXiOWNIWQ63yNhu/tsn3Fr
         lF3de9qY6rHRmVs0ofy5avrOq+DwITuimuXPZ7XmpC1PNwti8uZPPTnw3dpq7U7F9e5Z
         3CCIyVsAfH74nrNHZ/GkWK6C/p2+yMQtxJo99XRs8psK4A/vW/8LuOBHhDhA7CmOC4h+
         6G05EsAQHkDFSsXX7+HHw6mgy0OapJSffdSP6SmI2HR0pNjseeqVo83/2rCDs+X2ZaLq
         TiFPqjYuO+cwRkigu8f5Niy+Au/9GoS7AxciC444y+CEVdyhNrBnngPBCa8SmW+KohpJ
         4O2g==
X-Gm-Message-State: AOJu0YxJlA/BL85P81TagcS1rEG9c9WCnxzWAb/7cQcaGhc/j4J/E/Sn
	AnYTRFDZGBcLr97EgO6i5YXRw2zP6MWyB40HSZZ3dEtH9+CyZI80NSt3BmAM5H/YLiEc4P0kfz6
	S/4d5y6MwdcP09J8WEzScU90LvUQ=
X-Gm-Gg: ASbGncu/W04ZStcBwYwGOGhmgpSThPG0D2v7p10MbnOmPT+Lxa6qbB6tXYnyIp5YQEq
	n3IsfRxL14hbfr/tvViO/YykxcROuUm0ES1p24liImBNBSmDlvSyK39ujC1G8GLvx/XwOi4Rdr6
	Lb+hAA5n9pKdASi4lr2jbwTh1lSo89XsEjxsLNYMVEFWezKvefAY3n5eHI
X-Google-Smtp-Source: AGHT+IGM8V206q5mMN4U8K35w3+a9er6OVQQJynLp2lA2Cmd5XrAReVK+eiZyZASeZQWfwfg4JctmSwU1WWk3rx6t6I=
X-Received: by 2002:a17:907:97d6:b0:ad1:fa32:b608 with SMTP id
 a640c23a62f3a-ad219170628mr139409066b.42.1746747250183; Thu, 08 May 2025
 16:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-10-memxor@gmail.com>
 <82fa97637f995a1a004221b8d4e869e775a5f008.camel@gmail.com>
In-Reply-To: <82fa97637f995a1a004221b8d4e869e775a5f008.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 01:33:33 +0200
X-Gm-Features: AX0GCFvHDNpek6VYxEzmj-0uzheU6Xn5lC8RE-h6in7UZKK_6IlG7PDLtt_Odlg
Message-ID: <CAP01T74ND3d=deo=YVpETG7HVfUf4rD21TEkJJmsByVS+BTy-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 01:31, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index a50773d4616e..1a748c21e358 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
>
> [...]
>
> >  /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
> > - * Otherwise use __bpf_vprintk
> > + * Otherwise use __bpf_vprintk. Virtualize choices so stream printk
> > + * can override it to bpf_stream_vprintk.
> >   */
> > -#define ___bpf_pick_printk(...) \
> > -     ___bpf_nth(_, ##__VA_ARGS__, __bpf_vprintk, __bpf_vprintk, __bpf_vprintk,       \
> > -                __bpf_vprintk, __bpf_vprintk, __bpf_vprintk, __bpf_vprintk,          \
> > -                __bpf_vprintk, __bpf_vprintk, __bpf_printk /*3*/, __bpf_printk /*2*/,\
> > -                __bpf_printk /*1*/, __bpf_printk /*0*/)
> > +#define ___bpf_pick_printk(choice, choice_3, ...)                    \
> > +     ___bpf_nth(_, ##__VA_ARGS__, choice, choice, choice,            \
> > +                choice, choice, choice, choice,                      \
> > +                choice, choice, choice_3 /*3*/, choice_3 /*2*/,      \
> > +                choice_3 /*1*/, choice_3 /*0*/)
> >
> >  /* Helper macro to print out debug messages */
> > -#define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
> > +#define __bpf_trace_printk(fmt, args...) \
> > +     ___bpf_pick_printk(__bpf_vprintk, __bpf_printk, args)(fmt, ##args)
> > +#define __bpf_stream_printk(stream, fmt, args...) \
> > +     ___bpf_pick_printk(__bpf_stream_vprintk, __bpf_stream_vprintk, args)(stream, fmt, ##args)
>                            ^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^
>                            These two parameters are identical,
>                            why is ___bpf_pick_printk is necessary in such case?

In our case choice and choice_3 are the same, but for bpf_printk
they're different, I was mostly trying to reuse the pick_printk
machinery for both (which dispatches correctly to the actual macro).

> > +
> > +#define bpf_stream_printk(stream, fmt, args...) __bpf_stream_printk(stream, fmt, ##args)
> > +
> > +#define bpf_printk(arg, args...) __bpf_trace_printk(arg, ##args)
> >
> >  struct bpf_iter_num;
> >
>
>

