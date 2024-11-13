Return-Path: <bpf+bounces-44815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF759C7E94
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 00:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620D1282A53
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 23:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041E18C348;
	Wed, 13 Nov 2024 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es1G9CGd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62842AE84;
	Wed, 13 Nov 2024 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538797; cv=none; b=hGRRbKDkYZs1a32yujidoFdY8WyUwuMx/WvABpo8Aeeasp8c0OH+qSYBNS2a+w+4bZ8EyqKO0s0w4y9xcJdQPht/HFC26lvE7B+JxVdcopr10u6PUKlewX83/sVme9x65Lmf/TQSiXszTEqrYAH+ac3GdE8gjj0l/PQZsdWE6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538797; c=relaxed/simple;
	bh=P4o6noBwxKclWruPKIEJq7jRNQ6JmEK4g7sgUwx8fCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehDQOvF5jZLWqOSd9LxD0RwcO+MdNMQwgh9oWhE8v2wCeEmrsNBXxNVB1WSQ+g/yolrTFCoLjKVgL3Fam1AlsYXz/hGofrPq5dW1WeK9MkQQVeS58ooAknA7oGshNHEA36/TWjrFEHrHb2eADcKRJjPRiI2E76yzkvnCFGYuj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es1G9CGd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so7377665e87.3;
        Wed, 13 Nov 2024 14:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731538794; x=1732143594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPnoa5kJESuIfhZM4IZ9Nt1wIRz5hW1xyaJdPQqT+Bo=;
        b=es1G9CGdLlgmiL9z20rzaaLbgtcPEUZHcwyiuWQ/mdyMWal2jkA9s2VixXUGv75rWr
         FIE7REJboxvFvkam+SsZTTOQ9teZu6vRQjr/1A1inXnVv5flo+r5A408CPICb1eq8WtC
         WxpN3mhIGNRxSQCa1gsGVYyuSrV00h0P9VO9WAwgUpTViy4wjqm5+EFUnLohUmLCXd7H
         L3VnKEebeAz9M4Yzjo5vHAyJwnCF5CCwf5gMD+/hpkuGN2N8F6Z2Z1zXcmetfD0JwoRv
         0lUSwDapHevs1bYI12GE61Fx44dh3j/ou2AROYb2gXeMyzjsi7NGXPGnTFSBdB/RgmiG
         unKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731538794; x=1732143594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPnoa5kJESuIfhZM4IZ9Nt1wIRz5hW1xyaJdPQqT+Bo=;
        b=ox0YPCQrNasN+ihw+MJ+JudlI8SMRV1ISAxJiZFOVP/FH9dK4vfEo96XL31OHJShVn
         3/Yn/ASNN8xAW2f/2oZkVhz0ri7l7wCc8JWuMVWugl6CC0Q28QxuNxNefG5lRDlmdlKm
         /OO6vXbC777i+IgPbX1s83YhcV2JzNHRQU1nbxYXGyj6tCaIHsTqllJMrCFQq101gN0S
         UEt+2FumuPHsKp5VxMGXPvIeFcKegY2K74QHCsKuNo0234RhDHN92iuRgyur/B8fleUF
         FDrD4csbYhCG+93AH5ibJv+9gLK5I3NJik0fI8CqiDiSKjENsKAzkaTHdzkMFbRXGOAJ
         78gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnOhpphszSeHitwJRE3jhe7RHMCYwZadp0pAYr7g+HC/fSTIUVs3FpwrS798Ok1eOILN1InYN5YYkqpcjI@vger.kernel.org, AJvYcCVdIP8bPaixnyrDm7MjzPbwmVGQg9sv27y2CZfC1XxaHHa3LC18PBfZo5JTTxwbafDfkck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGA7cCjMCTRtbN+lKowbdSC8/0l1ldsZ7UY2nWzBG1aeDu9myU
	snc5l9sA3x3dEGDQeR34KhAWEaBhfBV4eiju+QIKsS+WiKyf6PGi7XPwn/Qa54X1xjLote9Nvqf
	SUVdZrP7WVABuINtLBg7Rw0GEYp78x7Un
X-Google-Smtp-Source: AGHT+IE86IQhayL6ZlO/ZiGdLIHBHsrEAa3BnTxjnXJ9fRF16YRt4VJQ/gbI4u/usQc9PCC7lpP1oW0Js9MK47xC7EM=
X-Received: by 2002:ac2:43a2:0:b0:53d:a132:c68f with SMTP id
 2adb3069b0e04-53da132c789mr1442601e87.47.1731538793422; Wed, 13 Nov 2024
 14:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zxk2wNs4sxEIg-4d@andrea> <13f60db0-b334-4638-a768-d828ecf7c8d0@paulmck-laptop>
 <Zxor8xosL-XSxnwr@andrea> <ZxujgUwRWLCp6kxF@andrea> <ZzT9NR7mlSZQHzpD@andrea>
In-Reply-To: <ZzT9NR7mlSZQHzpD@andrea>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 13 Nov 2024 23:59:42 +0100
Message-ID: <CANk7y0gdNGM36Er9vq42-YouoGVVQ4gp0yvgVHarm0-NFC2i1w@mail.gmail.com>
Subject: Re: Some observations (results) on BPF acquire and release
To: Andrea Parri <parri.andrea@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, puranjay@kernel.org, bpf@vger.kernel.org, 
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:25=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> [...]
>
> > I guess the next question (once clarified the intentions for the R
> > and Z6.3 tests seen earlier) is "Does BPF really care about 2+2W
> > and B-cumulativity for store-release?"; I mentioned some tradeoff,
> > but in the end this is a call for the BPF community.
>
> Interpreting the radio silence as an unanimous "No, it doesn't", please f=
ind
> tentative fixes/patch (on top of the bpf_acquire_release branch cited in =
an
> earlier post) at the bottom of this email.
>
> While testing the changes in question, I noticed an (unrelated) omission =
in
> the current PPO relation; the second patch below addresses that.
>
> Both patches were tested using the "BPF catalogue" available in the tree =
at
> stake: as expected, the only differences in outcomes were for the new/add=
ed
> five tests.
>
> Please use and integrate according to your preference, any feedback welco=
me.

Hi Andrea

Sorry for the silence and a huge thanks for working on this and fixing
the cat file.

I have applied your patches and modified them to add the new tests to
kinds.txt and shelf.py
now these tests will run with all other tests using 'make cata-bpf-test'

All 175 tests, including new tests added by you, pass :D

make cata-bpf-test

_build/default/internal/herd_catalogue_regression_test.exe \
        -j 32 \
        -herd-timeout 16.0 \
        -herd-path _build/install/default/bin/herd7 \
        -libdir-path ./herd/libdir \
        -kinds-path catalogue/bpf/tests/kinds.txt \
        -shelf-path catalogue/bpf/shelf.py \
        test
herd7 catalogue bpf tests: OK


I have pushed it and sent a PR so we can get all this merged to master.
https://github.com/herd/herdtools7/pull/1050

P.S. - I am writing this using gmail so the formatting might be
broken, sorry for that.

Thanks,
Puranjay Mohan

