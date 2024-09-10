Return-Path: <bpf+bounces-39474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0B7973B91
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DFA1F22B48
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49196194132;
	Tue, 10 Sep 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtERHhjZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD3187FFF
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981706; cv=none; b=h/SuOJUJjBlbM6mOjr4AWnIi/Gp0sstdJ1bxqAdkaiL+k2bcawdbURrw3li1UhbncvsvgApRTSCsF3w63N00zU9iLFYpQTLfYnGHOR/E8VgrUDjpE29tTYKnmJJEeKIYzZtHvVJUANDXZHjX19e5Y0ZU+ZKt7rC4rWsnNAgLFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981706; c=relaxed/simple;
	bh=PQ5LU9UEwcUPGxe8JP+NGItM/IBKDakkr1bMgIY404Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzzVMyxXnPPb4eoLetoryIwjO8plKjlZqZytuJdUxr9rF+1M6TWOHTNQloiQnsy4p7JyFsP9FkI4XfnYuQm/dVMnojtceC0KTpYJ3iCIMXbSth8BTeb5h5/bCjE2ecv/5Hr+34ntxXtAD5GOPJY/EhQHfSOCrrhay5k2ZYgCa5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtERHhjZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso24628445e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725981703; x=1726586503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8byPQIRp2MV8C+Ltmp2JHMjxLIhgdasJFKY2Uh6aig=;
        b=dtERHhjZ4wWu/si/AOMkl2sSzCc4/xRaFmYaH0heulPkk4NLAGcDWmpvPVOEwpHjhn
         cy2QDA7B87JNxUZ2VWVi3itA1aC4cT+3b+YqC9xcAnKBuPArGqtf8nCNDVNWCn8iV8pP
         LqgB2r/yqWEDI5SGRaRWqGU91r71NaHrUDriWg6KvK+up4SQi46jRzzI5hSc1p3G4T9O
         I1as35OZR6rkwO8bb5DSYqa9pTEnK9oJlYwAeWn4nKrFpTRhnFuqSY+z0FFuPDH4Vnaq
         SgYLcqHdz1ncUrd1iwEK0nX988B8M3GmnUxU4FuDYEvo+XuwDMrG0AlaSO3XekSnM5C9
         ut9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981703; x=1726586503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8byPQIRp2MV8C+Ltmp2JHMjxLIhgdasJFKY2Uh6aig=;
        b=m9Nk+iYmHMHsXNcAZDdZR93r1e76EqAa1buZj/KDQvXwHW7QaZfTT9rmwJMKy925aG
         gTDBfcRMcF8tmiPXvL1dJe1caO/+Z1n+uPoifAvKBtJ/mQrQ2lURErpw4wDjMVA6nZhx
         ekG3+aTEsOuXcNZwy8lgEOhHeVt0RvpCxomp2MgHOF5ta4GDA2m7gEWnETcMUJ0eBnnN
         idvyKsX44drQJ/rEb5LX3RVJv2TSBCcrnvMHbRCKAuSbsQRtOMu1VUSdJzyZ+FlISOFN
         BFNTa3w/A5LEKVSrpQRfRrW4td/oNdHVgjf0prGQmyfko0djdj1ZcC7bCHTA2h8YQDNv
         jXGg==
X-Forwarded-Encrypted: i=1; AJvYcCXhKmTNGe8TM2j68+AxhpUtZwyApth0RUX/NKGvz6SuyHA3HBR04ZYUvz4p+8HmJx6Hyz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcqltntZjzon4AF5GUUL38QR7s04rNE0zkFNcB5wSZJCIFc/0
	HI+d6o0Kkpk4U/kLSr3Y5NNvgTLPgTzqdiPC/TCcbBPBGKNrg1KEEpGGT2Spq7nRu6kBdS4vM5C
	edrG36eqzlAUzFe4NiuoHQUkBbjY=
X-Google-Smtp-Source: AGHT+IEH6Kexq6tRaMQiA9lzHuofWAF7yWFi8g8X6dTiiRSq2BiqcKXCI68k7oNjiVcvWrIeO1e3l1WucP9TPSm7LUo=
X-Received: by 2002:a05:600c:1d18:b0:42c:b98d:b993 with SMTP id
 5b1f17b1804b1-42cbddbd807mr22225665e9.2.1725981703198; Tue, 10 Sep 2024
 08:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com> <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
In-Reply-To: <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Sep 2024 08:21:30 -0700
Message-ID: <CAADnVQJPnCvttM+yitHbLRNoPUPs6EK+5VG=-SDP3LVdD70jyg@mail.gmail.com>
Subject: Re: Kernel oops caused by signed divide
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Zac Ecob <zacecob@protonmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 7:21=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 9/9/24 10:29 AM, Alexei Starovoitov wrote:
> > On Mon, Sep 9, 2024 at 10:21=E2=80=AFAM Zac Ecob <zacecob@protonmail.co=
m> wrote:
> >> Hello,
> >>
> >> I recently received a kernel 'oops' about a divide error.
> >> After some research, it seems that the 'div64_s64' function used for t=
he 'MOD'/'REM' instructions boils down to an 'idiv'.
> >>
> >> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then beca=
use of two's complement, there is no corresponding positive value, causing =
the error (at least to my understanding).
> >>
> >>
> >> Apologies if this is already known / not a relevant concern.
> > Thanks for the report. This is a new issue.
> >
> > Yonghong,
> >
> > it's related to the new signed div insn.
> > It sounds like we need to update chk_and_div[] part of
> > the verifier to account for signed div differently.
>
> In verifier, we have
>    /* [R,W]x div 0 -> 0 */
>    /* [R,W]x mod 0 -> [R,W]x */

the verifier is doing what hw does. In this case this is arm64 behavior.

> What the value for
>    Rx_a sdiv Rx_b -> ?
> where Rx_a =3D INT64_MIN and Rx_b =3D -1?

Why does it matter what Rx_a contains ?

What cpus do in this case?

> Should we just do
>    INT64_MIN sdiv -1 -> -1
> or some other values?
>

