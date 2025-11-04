Return-Path: <bpf+bounces-73412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0972C2EE64
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 02:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D63B7FAA
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 01:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1AA239E9E;
	Tue,  4 Nov 2025 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh3284n9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E4239E8D
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221336; cv=none; b=oIPMCvQJm3pb1rD46azW7veoNOksedPxDMp1g1h8msao7YIO8JlG5dvoJDUqaOxrEvn4c+hZ9TJjsSkBA3Ven9VLTap0nrqcxFje+eF8FmVvrGmynoB3iG60t9A0kBgWqdcGJtAo5Tl7K39TjOAsszRnVZAPmpHx9jdKWaF2TWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221336; c=relaxed/simple;
	bh=vs1fwmtdjacxlbwFi2Gk6OhxOWR/Nx+qEHS4/ukixos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG+EjwUtljBlntrbG0/edwLDMw1sfbEaHSMNll8SOzVvL47P0K+0N9kw1CRD7Wy2PhNbNGHY8SfigT8mt9+REEGYBOhH4z4c0CZ0a5hQUaAApinWS32olqeRs31kH8ZcsXszg0Txnwy1XvNOji6jN0pcYROE7/5AnyRfglzbRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh3284n9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so3234149f8f.3
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 17:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762221333; x=1762826133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xC9/Q7qkWpc3nMkhgA0XmkTn8fAWyesNGprafS8bmI=;
        b=Vh3284n9eSTmilkOQtAbuVYbvg+fpDoUa1dBYVh7ajEFS8+vpxcU8/gCTmOtErcshP
         iN+Hp2TqNhDbXrTSkeIoCsye9uSjQDHFmIGyX3ewDCzlwvlGetb3uyMIANy8V8JTlslr
         eMO+n3Lu+iFqHo1YOoW/Sg8d+CD2kYZZGOMCrDxSORbQ9aHmJGBKAwefTb6y1ihUMGfw
         WPzCtJakCf3czBiFfcCo8p8gJ3tOjZdR9413vXPLa/qHH5yeqY00vdWGD0fktrOU45qT
         ZGSmvx/BqHZwTRRElOFXQqIQdTksR3PxxFSvRUGTGVl7OfRSNUR1tFj0iMuw3zWIa+cs
         JRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762221333; x=1762826133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xC9/Q7qkWpc3nMkhgA0XmkTn8fAWyesNGprafS8bmI=;
        b=CueI3lAySS+SLWRSEhxeml3zj37O67rOev9st2JbGUVaQ6yYdg7pDjyVhujFeghY6/
         lFTD8ls6Zk7OyroVHdEJ50t9jSz/hU0m6UDXBgjFsj5lBWjaHwsdj66O5/UpcXwDbTa4
         9cmjBum6EbBP1OGfl+wPRtRfRB+n7gzn5CQylaGOYhD43n5uYKy2XkdF0UxMGxJ1+Bi8
         0dso0LgEi6tsgZN/S+6tI2DZbXE0RBCk+B026fO71BKxPy6mQJE2WI1F0H/vayBSjZq4
         va1S0bg9Sw155PgYB6MD/s47JyrcIGVXewef7pMVjHf9/y35zWNqE382Ju1JM7vdp1c7
         dk6g==
X-Forwarded-Encrypted: i=1; AJvYcCUemqHrJnWjkxktVoVKp2iUT9NU2uZ7xYXQxDgkAEOReRi4Xn8nmBpS38/oCasb3JWUUhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiX/IwlGzcR7hRzFmdZ816GnpRw+N8TiRbGi5dg6U/rNn9r+Xk
	+X2wV8tnDVYZErW7Q0Gy/eMdZL7GI5inmQttvZIPTBbR0YkK/nB+U9t4OgXGHxaOzxyvQP8/nOG
	di6jd6GSDYoYE+fsNmbsrNtQadno+cEQ=
X-Gm-Gg: ASbGnctYHgHRduRMNHlJCMlV9SCoG058QnBJwwf97+WM/gq3f/xJK2TxBKJTSB36L+r
	S5ZL77YZXt2+x7jVRYPmFGy/QqUSPr5bqm0GuuQtoteibYyxtl+Su0lGZmhH/7uClKCVC+HBUwW
	gYEVNTTUDJImJeBMU9vINU4h4OaKWDBw8/5nDXJCDxrJbRG+R1rTpafVXP/COgxjhcNLRIXUSvw
	yd8BdHrZy6sInsyajCs03FZBUy4jsWbGoRHq+rcrRdQUkqTnHyD0gige73dFRmEN7YSdxEFf3HK
	44B+Owxd56AhUEyRfQ==
X-Google-Smtp-Source: AGHT+IETgDG7oyWLMm2zNhETESqy0wUWNqjzSzMDuq9bOPNhURK0W1xAuhMdoI5wSk8pVm1zvireoIwkcCWoV/wROY4=
X-Received: by 2002:a05:6000:604:b0:429:d742:87e2 with SMTP id
 ffacd0b85a97d-429d7428a6amr3638086f8f.12.1762221332505; Mon, 03 Nov 2025
 17:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103063108.1111764-1-kafai.wan@linux.dev> <20251103063108.1111764-3-kafai.wan@linux.dev>
 <ae64d43491a36fa5efc861be912a615348877d51.camel@gmail.com>
In-Reply-To: <ae64d43491a36fa5efc861be912a615348877d51.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Nov 2025 17:55:20 -0800
X-Gm-Features: AWmQ_blJsKecmU0G4NRm5lQ1v5GbfQDDdfEgcWMVHOprzU3iwNw0Jh_tG0QUCbg
Message-ID: <CAADnVQL9kfkasqd0+dg+PSjrji9KrMTbWTZaajwYKzW2vJ1czQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add test for conditional
 jumps on same scalar register
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, colin.i.king@gmail.com, 
	Luis Gerhorst <luis.gerhorst@fau.de>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-11-03 at 14:31 +0800, KaFai Wan wrote:
> > Add test cases to verify the correctness of the BPF verifier's branch a=
nalysis
> > when conditional jumps are performed on the same scalar register. And m=
ake sure
> > that JGT does not trigger verifier BUG.
> >
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
>
> Thank you for adding these.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> (but a comment needs a fix)
>
> [...]
>
> > +SEC("socket")
> > +__description("jset on same register, scalar value unknown branch 3")
> > +__msg("4: (b7) r0 =3D 0 {{.*}} R0=3D0")
> > +__msg("6: (b7) r0 =3D 1 {{.*}} R0=3D1")
> > +__success __log_level(2)
> > +__flag(BPF_F_TEST_REG_INVARIANTS)
> > +__naked void jset_on_same_register_5(void *ctx)
> > +{
> > +     asm volatile("                  \
> > +     /* range [-1;-1] */             \
>                      ^^
>    Typo, should be [-1;1].

Eagle eye.

Fixed while applying.

