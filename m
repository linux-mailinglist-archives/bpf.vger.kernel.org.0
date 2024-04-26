Return-Path: <bpf+bounces-27973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8528B402A
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8B028575E
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D1B179AD;
	Fri, 26 Apr 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrpoqVLf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F31BC31
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160221; cv=none; b=LlMtlz46tgb28mdnoWU83X/Fh3Tnp0F7gZmXsp/RtXPrs5ziyQJSUmW+sAAm7X7Fgr2Os091jupyx88jI+Ptl8OtKZHh1YKtjRGpVxwQ64Vq6mlYnEnL4iX9ZIj6xOX2w1zeTYLk+zGWqPEaLYcZxqWFv4EqZerOXANm9JNlFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160221; c=relaxed/simple;
	bh=7k6a3/EhncXyLVx/zpor+3qnf7U9i924MflSxGcjAQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5OWP5OsFt6WUVuSukIKgqkMiQWxFPSYlIAdQdfTS/zBG9vk7U0iwZ7B59rsmLcVwmLmjwOhlBevGkECyJj6K2zyWKAMy/pewMgUeMDnR75t7whb6Qkvw0rR08dzP2cSYYdAH6J5lWqVWqj8rHh1PIqTZllZMzV2apX6BWYZhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrpoqVLf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34a32ba1962so1994965f8f.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714160218; x=1714765018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33uzk/12JSTqzHrlDliFHquEnnPOJaATS1bFfJZ8ERs=;
        b=JrpoqVLfUWEp7CzaqfYrOqK2KoDeMqlYqEfSQmXX7dKJQfWYeflnq/nKpPmmm0uSOS
         1wTKHukPSmOYjozogED3n3hdTTbieXpe99erEiVoxK2l19kK8GwH3xoXisDY3PNgEEjd
         2qAi/uleuoEefZ6uHe2uDC4hZLoRYJL51NR/2NOjY1Qya0Q33ev6ocsg0PtV7OwDvgeT
         GEisbqMOpQ+HFUWoFha1tpgB5Y4+1R1oYPlQ2XwJBM+71WKJnrrJim+/2DsqpVjU5b6e
         lBOtl51M0BWZP1aHttT6W3cFAnR7LiCxlk9JRCupY0MWDybN7NdzBjYrmAqVTXZA74zQ
         8mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160218; x=1714765018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33uzk/12JSTqzHrlDliFHquEnnPOJaATS1bFfJZ8ERs=;
        b=QLgSgzAQgbkJ04GYMJo67CFzTvcQfcL6Qj+OrVN/wWJG7+aNTX9liNeJz++UVoR93T
         niwiM1H+O2sQnPgY34CCAY02z+7OM25J5bMSFDUGL1k4zLP8THCR1KgCbUbQJPGwTky+
         YMWwk5VWe1ZF9ruJIg0dk0FAKhHSQzX7WTFitct8wvMe+0NWEh8IdWuYAOYllrQIZkY2
         38llG8rY5AHGR3GjWmqg3rJpI1f5mcM+HMEvEnZIVV1CN9CSY1pM4UM1Xmv09EceoVsa
         /egUbYIOhvaprljDz4ou+kUWPHnGUer9fWMzqREzPuCh9Y/JhThO//n1pS1SzjeQ5A9r
         Zjrw==
X-Gm-Message-State: AOJu0YzOrGDqcM816hn02UQAtHAocz15IgbBaV9iSYrPjwBJsLTm4OYj
	w898MbdrEHv93o89HrouTdYg6P8bi3YslmxnNZE/IMes1t0OaDnJu/2NLFKXTja2QnbgHqQS6An
	jchlLFHuxFS1hTlp7eatDGR9sV1d5UbO/
X-Google-Smtp-Source: AGHT+IGiqL7P/qGkTA/qqCu/Td3fnc1Zje66+F762HGNfdF0d/b9o+P3CHRFiot10nMPgs4M5H/jmV+CLLRR+rYoLSE=
X-Received: by 2002:a5d:630d:0:b0:34c:4061:5579 with SMTP id
 i13-20020a5d630d000000b0034c40615579mr2250631wru.45.1714160217843; Fri, 26
 Apr 2024 12:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426171103.3496-1-dthaler1968@gmail.com> <CAADnVQLmu-v30D=JP75Cd0qBhDXm8izAnUnyZZ4-QwyM67nNww@mail.gmail.com>
 <0dae01da9810$3a657fc0$af307f40$@gmail.com>
In-Reply-To: <0dae01da9810$3a657fc0$af307f40$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Apr 2024 12:36:46 -0700
Message-ID: <CAADnVQK7W7gQVhB+MqcoDd1xrNqCPqOFrwVWVAi1Zb9t5iyuLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Clarify PC use in instruction-set.rst
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 12:30=E2=80=AFPM <dthaler1968@googlemail.com> wrote=
:
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Friday, April 26, 2024 12:22 PM
> > To: Dave Thaler <dthaler1968@googlemail.com>
> > Cc: bpf <bpf@vger.kernel.org>; bpf@ietf.org; Dave Thaler
> > <dthaler1968@gmail.com>
> > Subject: Re: [PATCH bpf-next] bpf, docs: Clarify PC use in instruction-=
set.rst
> >
> > On Fri, Apr 26, 2024 at 10:11=E2=80=AFAM Dave Thaler <dthaler1968@googl=
email.com>
> > wrote:
> > >
> > > This patch elaborates on the use of PC by expanding the PC acronym,
> > > explaining the units, and the relative position to which the offset
> > > applies.
> > >
> > > Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
> > > ---
> > >  Documentation/bpf/standardization/instruction-set.rst | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/bpf/standardization/instruction-set.rst
> > > b/Documentation/bpf/standardization/instruction-set.rst
> > > index b44bdacd0..5592620cf 100644
> > > --- a/Documentation/bpf/standardization/instruction-set.rst
> > > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > > @@ -469,6 +469,11 @@ JSLT      0xc    any      PC +=3D offset if dst =
< src
> > signed
> > >  JSLE      0xd    any      PC +=3D offset if dst <=3D src         sig=
ned
> > >  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >
> > > +where 'PC' denotes the program counter, and the offset to increment
> > > +by is in units of 64-bit instructions relative to the instruction
> > > +following the jump instruction.  Thus 'PC +=3D 1' results in the nex=
t
> > > +instruction to execute being two 64-bit instructions later.
> >
> > The last part is confusing.
> > "two 64-bit instructions later"
> > I'm struggling to understand that.
> > Maybe say that 'PC +=3D 1' skips execution of the next insn?
>
> If the next instruction is a 64-bit immediate instruction
> that spans 128 bits, do you need PC +=3D 1 or PC +=3D 2 to skip it?
> I assumed you'd need PC +=3D 2, in which case "PC +=3D 1" would
> not skip execution of "the next instruction" but would try to jump
> into mid instruction, and fail verification.

Correct.

> Hence my attempt at "64-bit instruction" wording.
>
> Alternate wording suggestions welcome.

This "jump in the middle" issue is not obvious at all from
"two 64-bit instructions" part.
Say that PC +=3D1 skips execution of the next insn if it's a 64-bit insn
and fails verification if the next insn is 128-bit.

