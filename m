Return-Path: <bpf+bounces-44712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55099C671B
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 03:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A592834BE
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C67083F;
	Wed, 13 Nov 2024 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Ee+ucclc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461969959
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463893; cv=none; b=p2k8GiCWETYADGZn8kyBlB/Yf8IXsO9fT8wri1sBU77upXvdmpOhe/MjcmEbP5VgKaeN2PIj9/BNKsmedb8yL5WFhQrQ1+uZyPxyZWGa4AqW2jO88mXawZCFjbQkNGgKhq1In9Aia9vB08mlaDAw0aVp/0A+MkQzNwkUhF9GMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463893; c=relaxed/simple;
	bh=gtebWBf+C8EwWbpFJDL7bxq8x6uXcE6UCDHzYbnr7QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gesseWcCxOxdJX33/Dp1xkNisBJfjIAc/1CrRxRcRiO9M55tLTC/xJ05b+P4p8luQeEkrob+E+NX2GAuoIeQn8qbwPfAxiCm9Z9NfGfZ0ujJ0j0KfhOFl5PtGddRluM3ES4EnzLnyZ5jyB9RPxcSCpsMr+147Yajn4utqPR6y8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Ee+ucclc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so51915755e9.1
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 18:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1731463890; x=1732068690; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LFeDb5On9x0Tkle3P5uwhUHYCgn44xc2GeEc1uOismE=;
        b=Ee+ucclcc4rYWveGBQdbqkSRWpNxRyL1BI/2ftqxANkof1m6EgTpgfNMrOJlWFaC2i
         0NCsCtseRC9lj+yih8GuCW5LXN+iuPBwT0q95KsgBcm/WiGAsJ95PrlEAqzCx6/9geTQ
         QtX/pLI4EH9iy8dGfF+BgefOiAlB7dxzVDVokbPNzFQr6jVOLHxvHfo5bAeINfo2EgRW
         WWW7jJ6O69e4yLyqRTum3vZX6wYZ+PKWaEKxiQBsmhHSgpBDUuBxaSnWp9ApwrNmHWvZ
         IfAyq1aMdT9tenTBahbZj5ZNg2Q7XHR/Kjh8/RRNwFYuBpozax/3wqWTe3x6aXkvArw7
         wIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731463890; x=1732068690;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFeDb5On9x0Tkle3P5uwhUHYCgn44xc2GeEc1uOismE=;
        b=EgfVdbe4aJ+4j8T7SONyc4AvNbY+3/7ccebQGQTICNTf+woZbJbpZlCH39OUm5da/8
         fY3j1fhJPR8cI1w8GE8PlZPmcwF3woYAU3NYeckYd9rJttW15rI2O2iO+i0LgmlgEyMz
         s3NIYzC1cI5+BpE8eTaQjxxMs30BnRmFGPrKSOypTI0Lx7v0q4OBrcq4dLrx+XNIatrb
         OSkUyjsLKmxCmpuBW17QVw+i2CYRsiiWPzzArm+S+tb1m++eqFoHnW9yjF3IQESO6FKD
         LSTWBVjoGJoMR6G1JetfAflEoPSMj/GXXaSQNRpFGTt/QNc3QpN46bucGtVKfpHOiw6/
         ySjw==
X-Forwarded-Encrypted: i=1; AJvYcCVPXpCtPCEYti+0XryzFLnHuK4Zp2DZky9ocQ3gv0QXWao24d1GUChadYuh2HaMwEnqY+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIU7zNaO8AsIYZJLcK0oywU4osuGpzUqV1qfB5eAI3QmBzgACb
	DkD/a6eDk4MZHWsAMJDSSXXfRveylSSLv3SmVbO1U/VqupiBGvDKbctXbLJEKrQ=
X-Google-Smtp-Source: AGHT+IGxKTuHuWFwwp7UcCnG7wQKveWvLfFoN/Oa74hSOhnpJLg8YZ02NlkK7RkAxlHx3rr4Tn9d4Q==
X-Received: by 2002:a05:6000:691:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-382080f6881mr4170507f8f.2.1731463889640;
        Tue, 12 Nov 2024 18:11:29 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda07097sm16644764f8f.106.2024.11.12.18.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:11:29 -0800 (PST)
Date: Wed, 13 Nov 2024 02:14:40 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Eddy Z <eddyz87@gmail.com>,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v3 1/2] bpf, x64: Propagate tailcall info only
 for subprogs
Message-ID: <ZzQLkD02BA/FQMeB@eis>
References: <20241107134529.8602-1-leon.hwang@linux.dev>
 <20241107134529.8602-2-leon.hwang@linux.dev>
 <CAADnVQLvt3T5X3wev2fZ1pvwqzJ0_tB-DXxTdBp8GOo+DP_c9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLvt3T5X3wev2fZ1pvwqzJ0_tB-DXxTdBp8GOo+DP_c9Q@mail.gmail.com>

On 24/11/12 05:31PM, Alexei Starovoitov wrote:
> On Thu, Nov 7, 2024 at 5:46 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > In x64 JIT, propagate tailcall info only for subprogs, not for helpers
> > or kfuncs.
> >
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 06b080b61aa57..eb08cc6d66401 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2124,10 +2124,11 @@ st:                     if (is_imm8(insn->off))
> >
> >                         /* call */
> >                 case BPF_JMP | BPF_CALL: {
> > +                       bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
> >                         u8 *ip = image + addrs[i - 1];
> >
> >                         func = (u8 *) __bpf_call_base + imm32;
> > -                       if (tail_call_reachable) {
> > +                       if (pseudo_call && tail_call_reachable) {
> >                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
> >                                 ip += 7;
> >                         }
> 
> I've applied this patch with this tweak:
> if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable)
> 
> I don't see much value in patch 2.
> The tail_call feature is an old approach. It is now causing
> maintenance issues with other features.
> I'd rather not touch anything tail call related.
> So I dropped patch 2.
> 
> I'd like to see proper indirect goto and indirect call
> support being developed further.
> Anton started working on it, but dropped the ball.
> We need to commandeer the patches.

Actually, I am still on it. I will start sending patches this week.

