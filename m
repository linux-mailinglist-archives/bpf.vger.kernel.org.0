Return-Path: <bpf+bounces-70528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB5BC2817
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7A93B1090
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10522F389;
	Tue,  7 Oct 2025 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPj5YkSc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C522172C
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865148; cv=none; b=N0Yxf9eH6hb+Rt6n9oVV1K/kzOoaiztf0jd4JKrc1X1Yz01TQPFGZKp9Yf+/d+D5G2NIxq5YOVOmEYu4KasebTjg71HcPe4KO7V9Q9a0h8lRGdKbAFU/2cDOU61mCkt3bjhEIyHbMiQZ9g99kGUSc258t+VSPnNaVbhOt+JznGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865148; c=relaxed/simple;
	bh=rq4hm5fIReT1QoP/lTxN/0Q2RvlUHepz5WKNwb+hXLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZWe8vBBA60K3vIulPCUZDAQUECn7tzgEKX7zzJ4jrJ+kT+DvTKEgx9rNXq5pXVM60btVcoGNFUV6TCIcIXfcBEefkzqCsIdCU5FMKiuat0i6Nwmb6GPu+huIgpyGVp0VIVvFcam2odx419ITWmTD/Dh/H5oP6BH9VNyy8PwMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPj5YkSc; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso13947732a12.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759865145; x=1760469945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GQKnJr8GVVVJqpKYl8xCvA0bEnYWkRtI0x35p58uncs=;
        b=iPj5YkScvPMxi4yl1CaYCidOmW+7jcD9Q9IpQgoX8AFc4PTpKP5ZzvRWx5H0pu5P32
         fN7V8Y8wF9mVaFoyqytY/XYcBWUQqfIE4MXqoosyUbsb5AO1ynVl63E2Fo/UEP+rZBHx
         7hPB8zpZgRYxoTAEcDEFIgvaPqr/+ReCZkfMBcW7XT4DtuOF3JYcyry4HHgo3xdsf3kM
         JkvK4azTPgc6ZiA0NzEjOiJ9CIGF2vlMZrWAn+8jJBp2uORgA26juWZAe00vVYXaaGTB
         Ogqiyc6cTLc7TABgIGUBrwLmLd7kG9W0DQ0dFORuYlEjMdjY+aJnbbjharuiNUVRojnn
         6bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865145; x=1760469945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQKnJr8GVVVJqpKYl8xCvA0bEnYWkRtI0x35p58uncs=;
        b=OlbbfVr8UO48zfPACcq88JvKOB7WNi9VXzaWXapieisosIzFNSwF3N4bVUZjiYpp2i
         BhaHpdtdTLz9qVVPUaj/7KKIOL9+QJIUkOwtfoWZw2COKmFMgyOQrNBtJGYoz06qA58R
         bio4d2sHeU584QpvKaOBKFxF+kLy8rr3qtviL2CBFd0ZL9OKe/tQxbGwgskgwp3sne4n
         IJvYFMe2fXQmsdRXfztapCw/nAjP3FOOq9PiH/9GYqzQ0fKEaW5U91ocWPkZugF0al3I
         9YvSMLDVfWGYI0B52dG7tMP6d9g3gcvu50hv7WeWRnd1CjA0LgI71v18UD/FUgrsTQ1K
         SfHA==
X-Gm-Message-State: AOJu0YxfjHw3f51g29llRWObfoLPZa+VZRBF5wmKrtPxcMlPXI2HvaK3
	Is+bmmChNA+EHXcUb//UuYyDo+0bLOkMKHAE969O87AwEDdYl1q/SJnkw7OYdDWaQMvtlYv3RRF
	yOiFm1wTaVo0ha06R3knYipKNiBgFxfI=
X-Gm-Gg: ASbGncuKvhZcvo/FVh8dQYCroVukWZ3fzQqgifzMNGPOza/HCNAy9BatxOVP34Gtamu
	QRY/OFqug9rH/DBwh9yJCV3P2sRiB+1PXnIESVM34IObI0FsCmTeyBL3SkAtULH/73MJ6k5obQ8
	hDWGlds/bSnKG2+t/DoKOxuYAgJ0XY3uvxuUGO1w3Waq5B2VZzfa1Wa78Zww7LwvyjiGjsbBIlF
	xFZbu3fIaXXFzkK71PaORzd/qHL7bWVX4eMqWWE/3mlJqXZgOenl+UI7zuZ0J3n6s+ibscrLcYC
	phLnJHnKqK1vuXW9vSsRoQ==
X-Google-Smtp-Source: AGHT+IHWioem91aRy2EQKBQGUeYVR6jL/qbl76BelfvWztUSPBbxmAB4upPjZ3vbGEwt8pfgPqQPIzutqOFn6ywOktw=
X-Received: by 2002:a17:906:c104:b0:b44:fb0c:5c43 with SMTP id
 a640c23a62f3a-b50ac4da779mr85881466b.57.1759865144626; Tue, 07 Oct 2025
 12:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007014310.2889183-1-memxor@gmail.com> <20251007014310.2889183-2-memxor@gmail.com>
 <340fce3310df92a9a2cefb25e3eb2781424958e0.camel@gmail.com>
 <CAP01T75XqJZa5PCtWm29W3+G5y04ok5F7zM4Q-ge_z2kORuJ0Q@mail.gmail.com> <12692a9d8dfce6317025949515b9e057823b70c7.camel@gmail.com>
In-Reply-To: <12692a9d8dfce6317025949515b9e057823b70c7.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 7 Oct 2025 21:25:08 +0200
X-Gm-Features: AS18NWCKL58XfxfPkSlpWusaaiw-pDNmNy8xanocAtSDVh1snPPPP0dTTIqmoso
Message-ID: <CAP01T77hX=3Q-bMQNDp_U5ei3Av_mWh5BomAXcvHDjCyj07HXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix sleepable context for async callbacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 21:21, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2025-10-07 at 21:14 +0200, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > > > @@ -22483,7 +22495,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > > >               }
> > > >
> > > >               if (is_storage_get_function(insn->imm)) {
> > > > -                     if (!in_sleepable(env) ||
> > > > +                     if (!env->prog->sleepable ||
> > >
> > > This is not exactly correct.
> > > I think that this and the second patch need to be squashed.
> >
> > I was mostly trying to reduce it to what it would evaluate to.
> > env->cur_state is always false, so the only check that matters is this one.
> > And we fix it separately in the next one. Unless I missed something.
>
> Well, yes, but that is not a complete fix, you need a second patch in
> any case, right?
>

Yeah, but I meant it's an orthogonal problem wrt GFP flags.
I can actually squash both into the same patch and add two fixes tags
then to the commit log, and expand the message a bit, I don't have a
preference here.
Let me know if that sounds good.

> > >
> > > >                           env->insn_aux_data[i + delta].storage_get_func_atomic)
> > > >                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
> > > >                       else
> > >
> > > [...]

