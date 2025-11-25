Return-Path: <bpf+bounces-75461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EADC8530D
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87FA3AFECC
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11321E087;
	Tue, 25 Nov 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/h0Rgns"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3B202F70
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077685; cv=none; b=FPcNa5z/0y7cpvP+pHHXflcIskdePQh6B+u7fn2PxVkYWmSC/HxigtWQFFKhB8rIBZkrPqbpc/lfia6c+oa9aZ2t1zBistV9eH8IHKmBOJOSdoB7zgZV2mEvkqT9CIfPPD+3pra/iURf69Cmab7521+g9+y2u0Hbgf/9ayiZ9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077685; c=relaxed/simple;
	bh=etD/zC7KgIaLoz8/uK0eNdolW/aHkPh00njUq2K4OIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfwbECMW3ueRpjQy0RzKMZ9gPXzaXBE2SrlwZyK9yaJTWy6/c72S1a9gryYkDxwFewQLvrUXuRsQJ/wkrdrWGcsR2xlhpLNKq1NqbkdWaHqTz7Rd7rhgK4q9LuQyVvR0Ukpm0eF00ejy6LIwOiGyJEJ7WwGkgzDxQqjGBRA2J78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/h0Rgns; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764077682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzvCE0HXjjHNitafAJjfZm5OBX9yo3X4qA4rV1S0mjI=;
	b=A/h0RgnsqSO0Tc1YABYdZcaUXMDIl/zU2sZ/MbmbvSHvWddGlP5jDJ1eTpGTir5W3V+Yxj
	FyJMPxt/pGSEAsPqtyOtAnADMWTYttC23sNq+GgYc/+djYiAxziUuLkpyF/fDJLbrEW/BB
	BbrjN0ZHw9rH7nqEtC9G4z+M7VmVeSI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-JulBe1UxN4a3XZQUXVTVlw-1; Tue, 25 Nov 2025 08:34:40 -0500
X-MC-Unique: JulBe1UxN4a3XZQUXVTVlw-1
X-Mimecast-MFC-AGG-ID: JulBe1UxN4a3XZQUXVTVlw_1764077679
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-594cb7effeaso3680623e87.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 05:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764077679; x=1764682479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yzvCE0HXjjHNitafAJjfZm5OBX9yo3X4qA4rV1S0mjI=;
        b=OkE+kn5crN1SQFZwYiPlmiB906HlhavptQmLRAwWKdDROhcSuSJhSoinh5O7qWcHqd
         WfHw378BknKTA6go3kbE2XH1UfUacySCAlksdfVEBcM6Ary2UZSQBNTO9VB4T1eAbZa7
         EbZkPCUmJKgNGNijo7JUyq6PdHxO1GqWpDG9nj24BfJBM7slSz3SRgtH/Ag2frRmDEw1
         ePLdxcfDmWhIYQKSVioKCqkPy5b29ymnSu+JaJehRJljp7uv+ah9AMBJk8wKp+c0oGFz
         e8294HcUSqs58icc+ItUJciwmufIbBA8wmfhGa5ky0pJfPMbPeVtYjcxctJaZ1dCCf4K
         153w==
X-Forwarded-Encrypted: i=1; AJvYcCXcCCLSBkaDtjIUAQJvV/ZAHsHXfyhkCdYYJHulQyWuCLknnAKfGckuHsb8PYhmZ1gylG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xw/E4pKjBICHnO4ER+FlY3uY55TUk7llzto3cfuw+Lc477tL
	VfK2QtyzbFsGylGYK+kLYnmzTJ7m6O4oWkb8xE1Ea9V8S486Bz2lwTtaHqIAWWu0tb7x2m2w1Db
	IAo4kV5Z1WNTI1IufqfTdiWughlZwoDOTPqNc3QnZIOJyknyhRU1bt5hnPaEuk/k2tV2Xiz1/+K
	SAKa773MTrCyaPMrXjld4zwuyr3xIR
X-Gm-Gg: ASbGncusgtp/rhxvWOeFGUPNtdIEltpgp5GojbkHiSRsfkgYrfMZeqoc2DsQ6Bt3/Ao
	MftqGqj0auNKa8sZnRjzp/hybU8KaxMXxuibzh84J3ap76vqv5Pe0mYlZkQMe0paMeOLJeOT384
	p3Jn30/aPpRNdsF/+gfgzKV4ZRTg8WwteuG2Xp1Oup0PSSfgUBYTa3dLjQmCA5yqlgcQ==
X-Received: by 2002:a05:6512:12c4:b0:595:7d95:eacd with SMTP id 2adb3069b0e04-596b4e4b76dmr984715e87.8.1764077678660;
        Tue, 25 Nov 2025 05:34:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfGw3W8ScMQe1ku6YWllmhNAIovzKH3FJqo8QXbxYKH/hwDLT0p8hMBiFjD56rgk/v8JStgTQmMj9ANJkgq4M=
X-Received: by 2002:a05:6512:12c4:b0:595:7d95:eacd with SMTP id
 2adb3069b0e04-596b4e4b76dmr984702e87.8.1764077678103; Tue, 25 Nov 2025
 05:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-5-wander@redhat.com>
 <9770045bcf400920152f0698c07090a641cc4aa1.camel@redhat.com>
In-Reply-To: <9770045bcf400920152f0698c07090a641cc4aa1.camel@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 25 Nov 2025 10:34:26 -0300
X-Gm-Features: AWmQ_blgXR85mYgUfaQ8idupZ16Ae7dRI2-VhSy-jeUInMobXiAc48bASO5gx-Y
Message-ID: <CAAq0SU=MPghhj9FxB9M0M2Lk0H23ZgyBs6qnucXit7YE+tr0NA@mail.gmail.com>
Subject: Re: [rtla 04/13] rtla: Replace atoi() with a robust strtoi()
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:46=E2=80=AFPM Crystal Wood <crwood@redhat.com> wr=
ote:
>
> On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
>
> >
> > diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/=
actions.c
> > index efa17290926da..e23d4f1c5a592 100644
> > --- a/tools/tracing/rtla/src/actions.c
> > +++ b/tools/tracing/rtla/src/actions.c
> > @@ -199,12 +199,14 @@ actions_parse(struct actions *self, const char *t=
rigger, const char *tracefn)
> >               /* Takes two arguments, num (signal) and pid */
> >               while (token !=3D NULL) {
> >                       if (strlen(token) > 4 && strncmp(token, "num=3D",=
 4) =3D=3D 0) {
> > -                             signal =3D atoi(token + 4);
> > +                             if(!strtoi(token + 4, &signal))
> > +                                     return -1;
>
> if (
>
> >                       } else if (strlen(token) > 4 && strncmp(token, "p=
id=3D", 4) =3D=3D 0) {
> >                               if (strncmp(token + 4, "parent", 7) =3D=
=3D 0)
> >                                       pid =3D -1;
> >                               else
> > -                                     pid =3D atoi(token + 4);
> > +                                     if (!strtoi(token + 4, &pid))
> > +                                             return -1;
>
> else if (
>
> Please run the patches through checkpatch.pl
>

Good catch, thanks.

> > @@ -959,3 +967,25 @@ int auto_house_keeping(cpu_set_t *monitored_cpus)
> >
> >       return 1;
> >  }
> > +
> > +/*
> > + * strtoi - convert string to integer with error checking
> > + *
> > + * Returns true on success, false if conversion fails or result is out=
 of int range.
> > + */
> > +bool strtoi(const char *s, int *res)
>
> Could use __attribute__((__warn_unused_result__)) like kstrtoint().
>

Sure, I will do it in v2.

> BTW, it's pretty annoying that we need to reinvent the wheel on all this
> stuff just because it's userspace.  From some of the other tools it
> looks like we can at least include basic kernel headers like compiler.h;
> maybe we should have a tools/-wide common util area as well?  Even
> better if some of the code can be shared with the kernel itself.
>
> Not saying that should in any way be a blocker for these patches, just
> something to think about.
>

I thought the same thing some time ago.

>
> -Crystal
>


