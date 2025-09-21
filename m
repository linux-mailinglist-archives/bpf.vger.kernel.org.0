Return-Path: <bpf+bounces-69121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B6B8D483
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 06:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB22F189E579
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 04:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B0239E88;
	Sun, 21 Sep 2025 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXhBCYgL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9918DB0D
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758427318; cv=none; b=XFg9SAJ7OiuNi/AVjEyKZxrntdWSrRq6uDBKhyBJEzvCdcSh7v8S6dzx0x333umH7mcSmH4d8owSY2p0zEavyK/RMT29NTrT7/nsk3/sZr86zUHTbjwOyPUohnICkFhUIbkC1XYLrEGI0300TU8v6qcVdf4OPDxvN2sp+hcKzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758427318; c=relaxed/simple;
	bh=CNFxgZPKNNACpHkJtQ1E2IGGBkiKawfk4D1P8NXl0Xc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOzd9ijVtrUkVgLzpRLnVGA/nyPgmbdQxczmkEqe8iJam/mhhmyKj4GnlrNzRz9izjqmIV+dNGMH2G4zIIbaBQ3L6Tvbvrj/R7oD30qr/1+Fkw2R4MQB07fM+IqtT6IdFok1oaBsBuAIBLnCe5PgUd/b7ZOuHYo3hnOHPMh1rXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXhBCYgL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f0e9bd80fso1336200b3a.2
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 21:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758427316; x=1759032116; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gv8w0Hzi/OSBpS695pFlf0v4Uc04rn3AUEyjNrtENi4=;
        b=gXhBCYgLCvjAg4se33ItjJ/BT1j9t1wWuFicSOcUzIh6S7RbvfdA4NauQavpmwzK2W
         jorUJlOE78K0sN9HnboYuwrCdusJudHt2WBHSbM1/g/1R9d7dRrqvuYJKtJpGJPE+e0V
         wA69jMF4w3gInAvDvCXz3NhRv0S0FLqiI2o5q/m1donjtDhffNm4T0RoGrSHohGCmLih
         OHUsoXCKnkBdtzl3agZn0hMbDFcwZkibM42OB+5RBjxe6UR3QtamibzcWK2Z5KCNDCWo
         8frbYJoZVJ2cvod5sW53O1w8SzQ8AV258bVZdca7nkPtyBnT4ZEvwm8e9lxUCd8R55Y6
         SD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758427316; x=1759032116;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gv8w0Hzi/OSBpS695pFlf0v4Uc04rn3AUEyjNrtENi4=;
        b=sDehI6LIrX9ObtR5688nIjYQ7gW5SXEAgaz+LL6wvFJ3QTpUKRwB4nGvUNBW+n12Us
         OgzLIIjewdDcg3y3zBC/Z6IM1NkUTRErIlCWcjo77Gdw3VQATXxxjEkkcmCtBNGz0E8r
         oFk8u8jb2Ad6sa1XxqosHpSH46FVegUvfjhAuBjoQBgZeG7b7ZcNZzxaW8V4Pch2D5Bb
         /Re8VXP4rrksejlHfQCM6x0d3wN4n4NbuebLzHf6pDaRKX/4nIkknqVm1gFTzgjE38Nw
         d1C8cLZFpqt1x4aRSLVJRE2X61jgn4hHoEszjLEQwYOoK9vxS9VoCWn3rliGvL45UWJn
         jVsg==
X-Forwarded-Encrypted: i=1; AJvYcCXmsVeiyA/h0U2X9kZbVJr1LyrKBeZq6xaaVHOLwq7rihxb6kJEdPefpWH5/Za55v4loL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNdNCxPUthvZYqHDGbRKxCU15U1vp+zFA4RSteIBGfDo6NG+v
	jc3tRJKafzPqdoVPMO94ZWePI6uuFHbGTOk/d5/DJbaQSe6eGMaQ623c
X-Gm-Gg: ASbGnctefrjq896kumgcfi3wC1H3uwp7wTgZaUwH0TFLuUEwX0LhT2qucyudxc+VsW5
	iTNPrA3NEud2+ItxRZY6sSkdG+kJDY7c5Pwb4Q25zRQ+UAjPljEct6grVZc+ZCWlOCmi+IHhO8P
	DcnBiIUwmylpLOtN6mc97XJN+C8b/r4y8P/+Sl5sPsB7O4kSGs1geXSiNJnvmlNT+IvpNKLwbw7
	L0zl54nRiF8z1e9S16O1wsXfwYBgRPBmessII4QZr+fH2LEizNgXpxHuxbLr6BlqkJiH7bqkY1W
	3ciHDReXIzE6DzlzoAINR8GYCZ+j6GQB8E+4IwzKJ4TTX63XvLhllUk1K1XRvQehe9bsiyK49RM
	7nuWnqx52nQR7oQEdWU8=
X-Google-Smtp-Source: AGHT+IFEbs4q7aetTzCWGz/YkQ1joLBm3cYv6Le4DYcZvYQcnztxvV9uPfjazPvqCW6K/wSq7VhM7Q==
X-Received: by 2002:a05:6a21:e082:b0:24b:3b75:b059 with SMTP id adf61e73a8af0-29276c793d6mr11077243637.55.1758427316189;
        Sat, 20 Sep 2025 21:01:56 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc24739fsm8928338b3a.28.2025.09.20.21.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 21:01:55 -0700 (PDT)
Message-ID: <1a26b31cd03091dc4610d42fa79249e703eb233f.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Silence newly-added and unused sections
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Sat, 20 Sep 2025 21:01:52 -0700
In-Reply-To: <22db8dd3-5df4-401d-8d63-5e0f2294bfd3@linux.dev>
References: <20250920153531.3675700-1-yonghong.song@linux.dev>
	 <bb7aca1aa66dc0791cbdb16934b4b4a139a63695.camel@gmail.com>
	 <22db8dd3-5df4-401d-8d63-5e0f2294bfd3@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-09-20 at 18:41 -0700, Yonghong Song wrote:
>=20
> On 9/20/25 5:30 PM, Eduard Zingerman wrote:
> > On Sat, 2025-09-20 at 08:35 -0700, Yonghong Song wrote:
> > > With latest llvm22, when building bpf selftest, I got the following i=
nfo
> > > emitted by libbpf:
> > >    ...
> > >    libbpf: elf: skipping unrecognized data section(14) .comment
> > >    libbpf: elf: skipping section(15) .note.GNU-stack (size 0)
> > >    ...
> > >=20
> > > The reason is due to llvm patch [1]. Previously, bpf class BPFMCAsmIn=
fo
> > > inherits class MCAsmInfo. With [1], BPFMCAsmInfo inherits class
> > > MCAsmInfoELF. Such a change added two more sections in the bpf binary=
, e.g.
> > >    [Nr] Name              Type            Address          Off    Siz=
e   ES Flg Lk Inf Al
> > >    ...
> > >    [23] .comment          PROGBITS        0000000000000000 0035ac 000=
06d 01  MS  0   0  1
> > This section is generated by MCELFStreamer::emitIdent(), virtual
> > function.
> >=20
> > >    [24] .note.GNU-stack   PROGBITS        0000000000000000 003619 000=
000 00      0   0  1
> > And this one is generated by MCELFStreamer::initSections() virtual
> > function and is controlled by NoExecStack formal parameter.
> >=20
> > MCELFStreamer instance for BPF backend is created by function
> > BPFMCTargetDesc.cpp:createBPFMCStreamer().
> >=20
> > I think we can define a sub-class BPFMCELFStreamer, override the above
> > virtual functions and suppress generation of the sections above.
> >=20
> > [...]
>=20
> Two=C2=A0llvm pull request:
>    to avoid generating .comment section:
>      https://github.com/llvm/llvm-project/pull/159958
>    to avoid generating .note.GNU-stack section:
>      https://github.com/llvm/llvm-project/pull/159960

Ack, thank you for the links.

