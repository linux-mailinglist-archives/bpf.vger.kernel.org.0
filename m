Return-Path: <bpf+bounces-59470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE71AACBE64
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FBB3A2B42
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 02:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132547080C;
	Tue,  3 Jun 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3KuAOME"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C028F7D
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916444; cv=none; b=ZCKTXKkh18IcSPbeL7Q21MaECOCgpOFtSf2Yv+o3qjU9ZQpZiy6yhHCDs4DJDcVCNIqqBD7PHWFmmksHLxUuyFsXJCbGzZQuO7ysUEK4p4/El7Ysl2Fx5QmofKvr28w0OdKbpbaQZlIJCR1WKBiDTwDGGYnixPsKAfdt0/DO+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916444; c=relaxed/simple;
	bh=pnC36MI1sjrl3JjZ7SPweizFKhnNMyiNtmsK3qfgsv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKMEDiN14J7wouqDIaaZTMvsJk1M+X8dSv2PvHOBXGG7gYqJT/plSjTktm9wFn7EvNONZcn2ySDbuF4WjWqoIBZZKSDV4sTwHCPiwqfUqL3UhMnP84tHw0+XeWGBf74Zj6nZqdn0w/5rXp9OjKIC58rs9702coWYo5EnEcw8uSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3KuAOME; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so629157166b.0
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 19:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748916431; x=1749521231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=serAT91OdA6Au5+WsnLnAIRm8RZu9P7NEKGgG5Ge5sA=;
        b=G3KuAOMErf1y5O8OlLbjGtafMlze4WgqJhCod0sRLIQbKckpGklV7V4VWDQFmIU8ct
         pUby5tp6ZMknqn/kh0POrLz0rSA8dgFX2H4CWI3vIEA1FUwwKDne+YeN452YMtPEYvwm
         P+ajSwq/UL8lZy4Y9j9G9whi4YNIh2u5kVMWRzaRpJGoUTSG9ZGW0tTleYKyJ/Qmadit
         plgx4fgX3ZigTVxbROw25WrH+P4LDcBnZkYEVYqnknkjqpA3cPmJwd2vPFl44HV4r0Mn
         A2lp1cFNxOgSKDffEG8+L0nMAZq3zp1Hhy/ZtF993lfuIYOoBskF8pO9pv7Ga/cFmy2p
         wqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916431; x=1749521231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=serAT91OdA6Au5+WsnLnAIRm8RZu9P7NEKGgG5Ge5sA=;
        b=ToTKKAbFnPrrzCsOrBdqwkLvcR7uBudBr/WOYaqfTKSumgvL3RY8o3fWbUauNGuFRr
         TLVHzEJ91huYFPGIBadSWaEFL+fngHfMTa58uzQWUx4hU/qfITFKmHfg33xs9eIvWJqr
         NRh9tIVEEb2bsOHh72Cs++GbJxR7VZrXNOimpesEj45o34zGLvymYnMipA7QFUBQE7J3
         AbroM5o2FWrWQS0VFh9dq6XX2O00BsKvOu+ziH6W/j4XC4x+7suJueeUP6S/9W4CHEoL
         knd0PO9dhNLTfyGpwx87IRvjw0/jisdg4x5XpvPr3c72EpKx1SFgWFsliwY9ki8hBES/
         zSCw==
X-Gm-Message-State: AOJu0YwdONqLo+F11I/WYT/WBL5+8eOPmRDXHeLbjRcB07pX/cUFoMlT
	c/vsCvDzFVWXa//gxpeMNYzJW5ahHVwsvO7Syyqr0CRVdSgWrz2AjyVyolcrnSna1MOv7Cv1X6I
	JqLU7CcJt0JqZv4sque4QUZhtekrmNDo=
X-Gm-Gg: ASbGncuqpNIdRZhnPwQX1Mu3wGJFOLL4+y6zdZeRLfGhhmSQ0YqyoM/FQnCq67AH/N0
	4WjNheZiTAm8+zks4D5gFu58q6zyrrGOXY3+aQYyoU4dTryABLjUnPYvIT31+RGvTKXrU9IkuPw
	YXkgbYAsjfr6187TN35clhSaV38Oe6mdZKC/d/y252y+phYhjOZSOzO8MEY+y56hvLVoBls4MQQ
	ONWyw==
X-Google-Smtp-Source: AGHT+IHjh2dik3m2+yy+6Kj/ajwSTkAwl3dJ4lIF4O5DfOUVfCAuYRQ5uu1psrm/JaP1HiYe1GHYep5nlrR0X5mWOCQ=
X-Received: by 2002:a17:907:1c92:b0:ad8:9b2c:ee21 with SMTP id
 a640c23a62f3a-adb322b344cmr1273969166b.2.1748916431031; Mon, 02 Jun 2025
 19:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-8-memxor@gmail.com>
 <CAADnVQLMP3AiuLA7rU2pKbUgatxt+NtrJRUiBm-8tBqYB58=0A@mail.gmail.com>
In-Reply-To: <CAADnVQLMP3AiuLA7rU2pKbUgatxt+NtrJRUiBm-8tBqYB58=0A@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 3 Jun 2025 04:06:34 +0200
X-Gm-Features: AX0GCFvP5kxUHwiCJdXLSb_5GRqjkvZpG8sKcndjWhozynO347DCNM2Z2bFpj4c
Message-ID: <CAP01T74bDoXf4-gu9hsYJKD2-22Py9hsCvCdgfPiGJjj3oVhTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/11] bpf: Report rqspinlock
 deadlocks/timeout to BPF stderr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Jun 2025 at 00:33, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 23, 2025 at 6:19=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Begin reporting rqspinlock deadlocks and timeout to BPF program's
> > stderr.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/rqspinlock.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> > index 338305c8852c..888c8e2f9061 100644
> > --- a/kernel/bpf/rqspinlock.c
> > +++ b/kernel/bpf/rqspinlock.c
> > @@ -666,6 +666,26 @@ EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowp=
ath);
> >
> >  __bpf_kfunc_start_defs();
> >
> > +static void bpf_prog_report_rqspinlock_violation(const char *str, void=
 *lock, bool irqsave)
> > +{
> > +       struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_l=
ocks);
> > +       struct bpf_prog *prog;
> > +
> > +       prog =3D bpf_prog_find_from_stack();
> > +       if (!prog)
> > +               return;
> > +       bpf_stream_stage(prog, BPF_STDERR, ({
> > +               bpf_stream_printk("ERROR: %s for bpf_res_spin_lock%s\n"=
, str, irqsave ? "_irqsave" : "");
> > +               bpf_stream_printk("Attempted lock   =3D 0x%px\n", lock)=
;
> > +               bpf_stream_printk("Total held locks =3D %d\n", rqh->cnt=
);
> > +               for (int i =3D 0; i < min(RES_NR_HELD, rqh->cnt); i++)
> > +                       bpf_stream_printk("Held lock[%2d] =3D 0x%px\n",=
 i, rqh->locks[i]);
> > +               bpf_stream_dump_stack();
> > +       }));
>
> I agree with Eduard that hiding __ss is kinda meh.
> How about the following:
>
> struct bpf_stream_stage ss;
>
> bpf_stream_stage(ss, prog, BPF_STDERR, ({
>      bpf_stream_printk(ss, "ERROR: ...);
>      ...
>      bpf_stream_dump_stack(ss);
> }));

Ok.

