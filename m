Return-Path: <bpf+bounces-76409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5410CB29F2
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 11:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC4C30329CC
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5F3090C0;
	Wed, 10 Dec 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7h5tVVR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC33081BE
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360943; cv=none; b=qKRR49vySaZgrebXHiWaN4hyzOTzcQJUwAJWzbk2boSw2WqESTKbl79JxNqUsYXLkbGnqNOpVd133KT9ZeVQVQH0k1exH7+F7V7puqEL0WpnHg5Y+EL91MDnWLS1RtoodeIBhkKq3hpkxRE2f1p4cCcU5O5lvR/ZcFP3MmbGTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360943; c=relaxed/simple;
	bh=JwMyjiaVuzyt3SB6ovsT0z1UaunVaxNkUgyWUs+N204=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIXc6+wOaWpdPLLt1jXdGFKOoZRqM6/simeOjKKQDQDwfrgvBT9ecfzVAfE2C7jW/IwAhZEqENHiPVA5xMVbsOnkSTNes9Mej6+oVSWWAufEvo7rrluuh4SDVCWYqiX90o47ioNtR2RLgFj6JfdC/Wq5GMTtDAT2RIj0en3MwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7h5tVVR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso11096651a12.1
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765360940; x=1765965740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0OeS5+Na0IE6SOk8luj/IZtCW9iGSemVzEVOlHuQSzY=;
        b=j7h5tVVR7f9e0qr6N2vy6utIBtiNAJv4LdbZD+Np2XkewpAqvh2XL8Eexup2NyOire
         gGt4pIpeRvqG9swQw1WwpI5jXwyCFg4cpiU3QhV4qiqmE2jVVVDpdcofkOFCFqUjoEHp
         OQ3BOCuAmPFVMk6EJ502/OlQ24bjQQd2UvfWoagBkGiwfQQNfbKZX3ZUsgB3HVI+vCbh
         TmSMZUae1LmeYMECDK4zHQeOaGGNDGOd4C33BdyhLLqXVA/9MwpL1m0Z89Xa3d9Smv3X
         F0j62FzSdW5H/wttluVl+XTnaAMyhazrVGh/8/HoaFxbTw9Www6WRufb3y4J1bKR7mRE
         tubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765360940; x=1765965740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OeS5+Na0IE6SOk8luj/IZtCW9iGSemVzEVOlHuQSzY=;
        b=R9f9a/ywBUK7lfhqo9LwyDSnDfvtNNSud8LkkVscwGSGLp4jQxTDHbe03QYKaAA4q/
         Ex4Gwzvif/6loMU4Ih+4FDB0etjHUMM4am6Ev6eqU3ImFZ/TQseqTjHHFbiPiR2ShYIH
         BzX1OD5H09GbLCxjR1Mo1DY1gEkb8oJswCeZtBi23DmrCfyoJC5QwxU3QA+y+WnQDR7n
         HcTOynD0Hek/0Kymr9gaDcc3WDXUburrzMIZMJjeZ0uKpoNxWiUzubq2jrKz9qm5vZbK
         Cld5HyQ7w0AkGmSFzsrSpoTDAQH5Q/VHPdBTzICUKuaWda6bSBczNnV7b+gNuLnZDn3X
         kLjg==
X-Forwarded-Encrypted: i=1; AJvYcCUqWAVL473n90Gyf45dCXrAPPaWVgq91I+Jz43hkDLj8QUl74o6nmVIkvVBWT/Tr0kHemM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzx1uIV8aZDm57quXYstS4DmIPycQ2PwCNNOedvHUtkg8DZZ5k
	k3iBMPsWRb8D857QJaIshXPhxOVTulXmDdK5cnQSW2P2Mhs3BkxCNWlAaB6mi6dpxw==
X-Gm-Gg: AY/fxX7WCrHjYuOCcqz2hUuKA9EBwUDEPC33uiLtYAQm8CyRM+FaT5XSCSq90dnTlkv
	jBV1gfsPk+Ev6lbk7FxZVtuqFPJtDF0q6PTFTTpi+nhDaSOzBtv2V8rAUOI6+4cDv91WX851Lzj
	j9qbVTPjJjc9iPMpo/CqQFYM4q2I9zE4xl+wXvg2tPgOFBBBmrBEiQ7k1A5EmVvH291QYa1Nxp9
	3DErdEdxEIpSyyLv3EGJ6W2097eBnCIA6xmQd+Y3iGI/XS6/gOu+vy0tpx8h2Sble+g5qs/9YyR
	hBP3eNgpWn1wLsri9WSx9hyKzWvLG49pF3GJtiZ2OsNLshkhj8efcJUjfIaDv+W8qngYqPxPdAD
	Gzmtp2SQ1JBmBxo7YVeqiguOgpyWIqMyTGs7zfV+HbF7W9oSQcPHCDpzbVRsmII2rMTwwil2t57
	JUgw2qvwcxtcnoTfMNB+BUW3x61xTjHb8pppc4YA0QPdjJRdMIQ4SLSlZxtt46Qu7NzQ0=
X-Google-Smtp-Source: AGHT+IEx3+UpRM4kNuoxTecOTMxppBUGVMhRFPWJIrv/QhPa2dubXYAgzkJ6jSY0Qg8wzOFuyAos2Q==
X-Received: by 2002:a05:6402:42c9:b0:649:234d:70c2 with SMTP id 4fb4d7f45d1cf-6496cbd497cmr1709954a12.25.1765360940188;
        Wed, 10 Dec 2025 02:02:20 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b4121eb6sm16728360a12.26.2025.12.10.02.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 02:02:19 -0800 (PST)
Date: Wed, 10 Dec 2025 10:02:16 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: =?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn,
	KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
Message-ID: <aTlFKI2IeHQ2-TSE@google.com>
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
 <aS7BvzTJ-2Xo7ncq@google.com>
 <aS79vYLul06oLPT2@google.com>
 <CAADnVQ+NASuOdgu-bD=xXtd8UM_N-83gKci3XQG1RHLbSFfwgQ@mail.gmail.com>
 <aS87V-zpo-ZHZzu0@google.com>
 <CAADnVQ+UDCh5JKjUpX63xcaV3CEcj18W2C+8TZ4QFYKGV6GZKw@mail.gmail.com>
 <aS_5K_CJcB1rIEVj@google.com>
 <CAADnVQLf10J688CXFWg+=UaOv_zPTr3ViqNFcjbe5u4no2o_GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLf10J688CXFWg+=UaOv_zPTr3ViqNFcjbe5u4no2o_GA@mail.gmail.com>

On Wed, Dec 03, 2025 at 10:23:43AM -0800, Alexei Starovoitov wrote:
> On Wed, Dec 3, 2025 at 12:47 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > > We can play tricks with __weak. Like:
> > >
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 7cb6e8d4282c..60d269a85bf1 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -21,7 +21,7 @@
> > >   * function where a BPF program can be attached.
> > >   */
> > >  #define LSM_HOOK(RET, DEFAULT, NAME, ...)      \
> > > -noinline RET bpf_lsm_##NAME(__VA_ARGS__)       \
> > > +__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)        \
> > >
> > > diff kernel/bpf/bpf_lsm_proto.c
> > >
> > > +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
> > > +                     unsigned long prot, unsigned long flags)
> > > +{
> > > +       return 0;
> > > +}
> > >
> > > and above one with __nullable will be in vmlinux BTF.
> > >
> > > afaik __weak functions are not removed by linker when in non-LTO,
> > > but it's still better than
> > > +#define bpf_lsm_mmap_file bpf_lsm_mmap_file__original
> > > No need to change bpf_lsm.h either.
> >
> > Annotating with a weak attribute would be quite nice, but the compiler
> > will complain about the redefinition of the symbol
> > bpf_lsm_mmap_file. To avoid this, we'd still need to rely on the
> > rename and ignore dance by using the aforementioned define, which at
> > that point would still result in both symbols being exposed in both
> > BTF and the .text section.
> 
> Not quite. You missed this part in the above:
> 
> > > diff kernel/bpf/bpf_lsm_proto.c
> 
> it's a different file.

Yes, yes, this will work. However, as discussed, it's fundamentally
reliant on a small "hack" which I've implemented within
kernel/bpf/Makefile here [0] to workaround current pahole
deduplication logic.

Andrii and Eduard,

I’d like your input on a pahole BTF generation issue which I've
recently come across. In the series I just sent [0], I had to
implement a workaround to force pahole to process bpf_lsm_proto.o
before bpf_lsm.o.

This was necessary to ensure pahole generates BTF for the strong
definition of bpf_lsm_mmap_file() (in bpf_lsm_proto.c) rather than the
weak definition (in bpf_lsm.c). Without this forced ordering, pahole
processed the weak definition first, resulting in a state array like
this:

```
btf_encoder.func_states.array[N] = bpf_lsm_mmap_file (weak
definition from bpf_lsm.o)

btf_encoder.func_states.array[N+1] = bpf_lsm_mmap_file (strong
definition from bpf_lsm_proto.o)
```

Because the deduplication logic in btf_encoder__add_saved_funcs()
folds duplicates (those determined by saved_functions_combine()) into
the first occurrence, the resulting BTF was derived from the weak
definition. This is incorrect, as the strong definition is the one
actually linked into the final vmlinux image.

An obvious fix that immediately came to mind here was to essentially
teach pahole about strong function prototype definitions, and prefer
to emit BTF for those instead of any weak defined counterparts?

[0] https://lore.kernel.org/bpf/20251210090701.2753545-1-mattbobrowski@google.com/T/#me14d534fb559a349c46e094f18c63d477644d511

