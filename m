Return-Path: <bpf+bounces-20292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0083B769
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AE51F21441
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8E2CA2;
	Thu, 25 Jan 2024 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zip/Oy7/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91C63AE
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151360; cv=none; b=lSDbwXeQ0+rIuz7AQThZCq89p84uQyKLp0ptPxnz328QptMDAgtLLqRwtYddGfxT115fV7wOWywiwIE9LmyqlO5YXRkdh1PPY/p2wLlfAccaSnaQdHeXnn1oadVONacjoSXCE6X93LigT+ZDKlHQkSWvYb0n3445yuOKcQUkgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151360; c=relaxed/simple;
	bh=UB7G7rvSLCpfXURXuM5kdtPDyQmUTJLkXh3foCz5nQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=froNzRTFzTGKJfMaqoEc1Jy/3O+lFPO7titkpWq3rCWYzO80Yj92f4EkyAr8rWh/5uUq0DelqBTGd+KhwURzYDax6bVgPFSsW6coNFATMrbILrdjZv9mS2YoIG3aS874lungQ5jd57jrdmA6U2nhwxmlpB+DHWyapAmqdRPFSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zip/Oy7/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33931b38b65so3976595f8f.3
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 18:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706151357; x=1706756157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbhGA0gDhCjRLVpsKiToXzQlCxMvHT4hJbqH0aQDeuI=;
        b=Zip/Oy7/K714mfzhTtIzrjMu6iWYRPl93TrvbdCgbYtYvCfHnRfmmwf6vwRtxyApd3
         ujZiNX9+NRRlhwXs7qL5zdiUVfo7b/sqAu9snjczV8vMAAF9HSHMqeycWbv4NTFaOREF
         bd50eoGlI8bP3IBPrNyEgfkZ0bLyE1la/2qpfWhAtBXcn6mvuCaCKl7S7XE2C9qvAsk9
         p5AP0W1GHfHu3RTAMG5M2OvxwbWqSr/+JziR9AaTPoBSH1laofkw62TJtqFfw3hMF+7T
         3Wu3tKB8L3UHMGlPyYi/STzXj1m4TF4OMru29oxrQmHRjRRZofX5GtZrc9zMJ5LG1B2o
         m+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706151357; x=1706756157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbhGA0gDhCjRLVpsKiToXzQlCxMvHT4hJbqH0aQDeuI=;
        b=bkoDBzUhHIpO9eCehnzw5EIvsLzySEcZZJWi6SyC3/LK9amqEFBJnR2O/Mrrm6i7FY
         GCE+5EnW+kOeQQAVjRXpj1BjAzNnvJp7HE1PbJx5Y7OxBiXqid8j4m//Oh8ybai/9sca
         asj3inZ1Tm34RgWTkh4JMTZv7uS6D6rKGusAEAm/fPRKsd+yWtGsyLO4+17APBn4QoCz
         VUppMUVFxrj708aqoTy02tlqzS6abmuJ/YCrWUJtVZ5kQJma4i1mIy5xdVjAXJkoN1mC
         wOQd/dLugmDAMTSbApc7WkVsgC/37B2catGh7NpM2xU4ga7fAXxXhgUnbSE0tTfokFfR
         X8qA==
X-Gm-Message-State: AOJu0YxEpPfbBTYbEu9rFZ6e3RAdeiXd5Hf6U7R8d1bEetBEkx/F3lFg
	g7/2S9K0xUqIjgjk6Qw56aq3AY4ad+M03GJiwWgD+KCSrJeyJMLIpnwPEFsxtkREMOew3fDD4IZ
	e0aMdMPM+JKLb8ZSAdCmHC8hIKDM=
X-Google-Smtp-Source: AGHT+IE47PVU+SyIT0Gq5bH3DbX3L55aEhmnlU1Vd0psSXCvryuQERT+5x72Yf6bfGfxjYf8p7qoYgXao8sw8+iorwA=
X-Received: by 2002:a05:6000:510:b0:337:8db0:597d with SMTP id
 a16-20020a056000051000b003378db0597dmr86065wrf.116.1706151356977; Wed, 24 Jan
 2024 18:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com> <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org> <20240105220711.GA1001999@maniforge>
 <ZZwcC7nZiZ+OV1ST@infradead.org> <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
 <874jfm68ok.fsf@oracle.com> <20240123213948.GA221862@maniforge> <1f8301da4e54$0b0ad690$212083b0$@gmail.com>
In-Reply-To: <1f8301da4e54$0b0ad690$212083b0$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jan 2024 18:55:45 -0800
Message-ID: <CAADnVQ+iN=HMdZD3jVhQxPzCWKi07DZo_wxq28nuC4JuXk2ZGw@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: David Vernet <void@manifault.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>, bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, David Faust <david.faust@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:29=E2=80=AFPM <dthaler1968@googlemail.com> wrote:
>
> > -----Original Message-----
> > From: David Vernet <void@manifault.com>
> > Sent: Tuesday, January 23, 2024 1:40 PM
> > To: Jose E. Marchesi <jose.marchesi@oracle.com>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>; Christoph Hellwi=
g
> > <hch@infradead.org>; Dave Thaler <dthaler1968@googlemail.com>;
> > bpf@ietf.org; bpf <bpf@vger.kernel.org>; Jakub Kicinski <kuba@kernel.or=
g>;
> > david.faust@oracle.com
> > Subject: Re: [Bpf] BPF ISA conformance groups
> >
> > On Tue, Jan 09, 2024 at 12:35:39PM +0100, Jose E. Marchesi wrote:
> > >
> > > > On Mon, Jan 8, 2024 at 8:00=E2=80=AFAM Christoph Hellwig <hch@infra=
dead.org>
> > wrote:
> > > >>
> > > >> On Fri, Jan 05, 2024 at 04:07:11PM -0600, David Vernet wrote:
> > > >> >
> > > >> > So how do we want to move forward here? It sounds like we're
> > > >> > leaning toward's Alexei's proposal of having:
> > > >> >
> > > >> > - Base Integer Instruction Set, 32-bit
> > > >> > - Base Integer Instruction Set, 64-bit
> > > >> > - Integer Multiplication and Division
> > > >> > - Atomic Instructions
> > > >>
> > > >> As in the 64-bit integer set would be an add-on to the first one
> > > >> which is the core set?  In that case that's fine with me, but the
> > > >> above wording is a bit suboptimal.
> > > >
> > > > yes.
> > > > Here is how I was thinking about the grouping:
> > > > 32-bit set: all 32-bit instructions those with BPF_ALU and BPF_JMP3=
2
> > > > and load/store.
> > > >
> > > > 64-bit set: above plus BPF_ALU64 and BPF_JMP.
> > > >
> > > > The idea is to allow for clean 32-bit HW offloads.
> > > > We can introduce a compiler flag that will only use such
> > > > instructions and will error when 64-bit math is needed.
> > > > Details need to be thought through, of course.
> > > > Right now I'm not sure whether we need to reduce sizeof(void*) to 4
> > > > in such a case or normal 8 will still work, but from ISA perspectiv=
e
> > > > everything is ready. 32-bit subregisters fit well.
> > > > The compiler work plus additional verifier smartness is needed, but
> > > > the end result should be very nice.
> > > > Offload of bpf programs into 32-bit embedded devices will be possib=
le.
> > >
> > > This is very interesting.
> > this is necessarily something we need to figure out now. Hopefully this=
 is all
> > stuff we can iron out once we start to really sink our teeth into the A=
BI doc.
>
> "Integer Multiplication and Division" in this thread doesn't seem to sepa=
rate
> between 32-bit vs 64-bit.  Is the proposal that multiplication/division i=
s ok
> to require 64-bit operations?  I had expected one rationale for the 32bit
> multiplication/division instructions is to accommodate 32-bit-only
> implementations.   So should we have separate groups for 32-bit vs
> 64-bit for the multiplication/division instructions?
>
> Similar question goes for the atomic instructions, i.e., should we
> have separate conformance groups for 32-bit vs 64-bit atomics?

risc-v defines only one group "M" for div/mul and another group "A"
for atomics.

What it means that groups "base32 + M" means that only 32-bit mul
is available while "base64 + M" means that both 32 and 64-bit alu is there.

