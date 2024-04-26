Return-Path: <bpf+bounces-27971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4050F8B4027
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA48F281FBC
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE0171B0;
	Fri, 26 Apr 2024 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XCPJ9mex"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF634BA45
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159846; cv=none; b=SYL6s1RTHll9BkLc2pVrisUu5QTRIpFJ/+oppUVyLTkP1u+YKyrkpKTzgneJXj/nwznlVJILKEl9lmSZfo4n55uxslJdpfVkxliT5Jat0wiRwk5Q2FxcPqkdcjWE4tcdEzb8XZqtFYXwqHhHa8mH1rm5Shrb/fgs6zwTPDOEU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159846; c=relaxed/simple;
	bh=SApHqcY16+Ff2UwV7/U/67eOgp9igNLWqvMksAfhvSg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqpu5xIfBBo3yp0T7tXd/XLMOjcMbOIaYvK4952/zLfQ5j9xkuS+JKSW47fsMMaR4asjbPInGiQnpnJgRmrxF8z9VWHdqGOI7jbiBl2eotAWCzarq4EJXdm53Q5ADD19PluW6iJYhHDP4YWqCBoBl6ITv+QWYl5yUvhbHOvG4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XCPJ9mex; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1979023a12.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1714159844; x=1714764644; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7oFPJ/9s3WV/rpddHBChs//6gHJrZ8yZzYu5cYUrig=;
        b=XCPJ9mexgi/9df7bfv/oIQko8yEkocfSCTHpO1mJJwc+b9XUG1ieAkoOZolwMXN3wD
         w0ZOolFtIMO5PtbwmQxsRbJSg0pgW8SaQJaEKuiUJhyzr33twORayH47JjOUWNZu/9qg
         nPag2s++9MSkDnpcVeSG65Yr9SnMQ/J3WN9zQGpV9ofCiQ+XcXOEFiTfymoEilImSoPp
         z3zevkblbOMc46qAsOYUET2j7Vp90F7lJBYZzV0VHtMjbCtFYMLxBGazP7UUMT2+fdaP
         d6ddr4A5WskGCwK0UH0B6shKaXwmRsxt0U6SZlGlv8hO3S+JRRyFeSTlZQvSsyQr5D66
         f72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714159844; x=1714764644;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7oFPJ/9s3WV/rpddHBChs//6gHJrZ8yZzYu5cYUrig=;
        b=Aq4aiu+TYKp+ksh4Vt0hZRsQXtlx0srZdXYpFBAac5wGunfVMf/VhTCibWkvrIuv6d
         fNKoS85NqPD9dSPzvXfk/PysNJ+I2RxCSxJrUR/sgBgs6b8DQXMxJyHdT7irb3Q58tqN
         qRTfetXj36zLkBoOIFHQtJaYYbTz5gKnBOSU9mYaYmbk/M2vp+na72UQV3hvFpcZzEyB
         PkN+h+JUW+PEI/vUvfBr+GTqOnwbZFGmqSkefALt1srbKnCnCfktFV7selntKb23lWCw
         LnhIDGbisFPhs4NAMk4vHeE36L1Y8bz16rB1TS9pkV4ISGkTPcee3yCjCfwiNioIICLB
         +wUA==
X-Gm-Message-State: AOJu0YyqlepeVxEIykVmeLcPK4CM/GZl0CZo3HpW7Lml43vcRR+5/J/7
	Czd9Qt/itUOnf/hQfr3IfRATRz10Tsf23uHBN/eZ22TZhkB5KewVlkb5JFyk
X-Google-Smtp-Source: AGHT+IG7SEoXxN1aZkPs+qK2scgk9EVMEr8uPopx0YMZlAGltldLBaw6I2e4vXj7h7dACjkzzDWYDQ==
X-Received: by 2002:a17:90a:4206:b0:2b0:303f:ab84 with SMTP id o6-20020a17090a420600b002b0303fab84mr3920389pjg.14.1714159844217;
        Fri, 26 Apr 2024 12:30:44 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id l5-20020a654485000000b005d8b2f04eb7sm12570514pgq.62.2024.04.26.12.30.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2024 12:30:43 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>
Cc: "'bpf'" <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240426171103.3496-1-dthaler1968@gmail.com> <CAADnVQLmu-v30D=JP75Cd0qBhDXm8izAnUnyZZ4-QwyM67nNww@mail.gmail.com>
In-Reply-To: <CAADnVQLmu-v30D=JP75Cd0qBhDXm8izAnUnyZZ4-QwyM67nNww@mail.gmail.com>
Subject: RE: [PATCH bpf-next] bpf, docs: Clarify PC use in instruction-set.rst
Date: Fri, 26 Apr 2024 12:30:41 -0700
Message-ID: <0dae01da9810$3a657fc0$af307f40$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDf9I+jjNNnBl+gCvpsjooEkTqcQwHzRDvSs2CcepA=
Content-Language: en-us

> -----Original Message-----
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Sent: Friday, April 26, 2024 12:22 PM
> To: Dave Thaler <dthaler1968@googlemail.com>
> Cc: bpf <bpf@vger.kernel.org>; bpf@ietf.org; Dave Thaler
> <dthaler1968@gmail.com>
> Subject: Re: [PATCH bpf-next] bpf, docs: Clarify PC use in =
instruction-set.rst
>=20
> On Fri, Apr 26, 2024 at 10:11=E2=80=AFAM Dave Thaler =
<dthaler1968@googlemail.com>
> wrote:
> >
> > This patch elaborates on the use of PC by expanding the PC acronym,
> > explaining the units, and the relative position to which the offset
> > applies.
> >
> > Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
> > ---
> >  Documentation/bpf/standardization/instruction-set.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > b/Documentation/bpf/standardization/instruction-set.rst
> > index b44bdacd0..5592620cf 100644
> > --- a/Documentation/bpf/standardization/instruction-set.rst
> > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > @@ -469,6 +469,11 @@ JSLT      0xc    any      PC +=3D offset if dst =
< src
> signed
> >  JSLE      0xd    any      PC +=3D offset if dst <=3D src         =
signed
> >  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > +where 'PC' denotes the program counter, and the offset to increment
> > +by is in units of 64-bit instructions relative to the instruction
> > +following the jump instruction.  Thus 'PC +=3D 1' results in the =
next
> > +instruction to execute being two 64-bit instructions later.
>=20
> The last part is confusing.
> "two 64-bit instructions later"
> I'm struggling to understand that.
> Maybe say that 'PC +=3D 1' skips execution of the next insn?

If the next instruction is a 64-bit immediate instruction
that spans 128 bits, do you need PC +=3D 1 or PC +=3D 2 to skip it?
I assumed you'd need PC +=3D 2, in which case "PC +=3D 1" would
not skip execution of "the next instruction" but would try to jump=20
into mid instruction, and fail verification.
Hence my attempt at "64-bit instruction" wording.

Alternate wording suggestions welcome.

Dave



