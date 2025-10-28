Return-Path: <bpf+bounces-72653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FDEC17708
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAA81A65637
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7F355808;
	Tue, 28 Oct 2025 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b5mm2fmB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1933711A
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695936; cv=none; b=p2ZhJ/OxHblfFbsGZA8jRuVCIPRPus5OPcfPBh6f/myjm8mMIfV1nGiDUmWnuI8lDDSNK427eAHzkKGw6IZQwekbdtRGnNpbPr+yZF2qbiZ/wd1+IEbTVvOrGwPAYQmLaaO4IoCjxA7jELQIZFNjWsRoz1OSb6Yzb8JcMf61yiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695936; c=relaxed/simple;
	bh=kk8zkzm83REChxkZSsstjBUXBS7wFfE2QPwc7AaZrqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4aiTSK2qzhLZQGaU4pZ3muCWFCIw1GkgQzNr3VqtD0bYk2HILwQwJsmwFDVdyvX695Hi+KXu+2vD1ccWPCq8OJU42JOFjzNulUrRm5Jt9bldKW2xDomZpS0K6QABOpje3WOAKCNDNMoItbRYxREnl0C/RnAs1SJWK1KYvbeP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b5mm2fmB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso9605493a12.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761695933; x=1762300733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WE4n4TCb18hPsMXmSS/+ET4xqQfmAur/mQUYq6ibGY=;
        b=b5mm2fmB9zTSMmFv4iKcb4cYmBOnPB/Zy4oRNHUHZ2iikAuKggazvFoh6D8vH5ZaA9
         DhmA+LKcnFO/ZrtWv+2TA34YvpTl7erhnFKoSbM2HAtVpRNrZuJyEJhtkWIlZY9GLHks
         +/MXfaI5oLqKh5dze2y6Rt0r5nN8ipVqo9HD3i/WJISxOx+NS6+V0zoCuTSi9yCJkwlh
         lqEpqob3fsMnFyMfsJoSfvvOBZDCMfGFjBNH6d4vTByQp0KRH60bi9LyW2aLznonIwV+
         XUn44AEioKOrWDBMX7EER2Pxhi4Hytd2/q/OVHWxKd1TUG2EPGrQA6fIBm6xvgqMNQor
         I30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695933; x=1762300733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WE4n4TCb18hPsMXmSS/+ET4xqQfmAur/mQUYq6ibGY=;
        b=FmVKsYryg7ZAq0GH8QFZ/X4XN5N4tNdbWoXpzF0s1UbMxWRlytSfGb33R9uealzmeE
         fQ9nImp4EM3s6XA8dkLx9lih0MW9j9X45RXY8TvNwBFSt5ulxoPmHVDeZN7/k0NbhmYI
         bVC5w+i5BZyNVj5uEPyG5KWJ2fG2kWhY9Zo6K0d7EpwOTMS8URkxEAe/fe8X6ZPMycrU
         ki5qofgppq2ipVDBAu/ImUY4/qyaJVw7KM9k5iEwxwO20PLTAY+XrHZ8tUhpqtt/Peyb
         UjUh733MMEnPNFA5wiI4h7lAWCSXvhWQfd8S/D+aSCrMEZgapbRZNHJ6jyp9BZEtDP1M
         bQzA==
X-Forwarded-Encrypted: i=1; AJvYcCUTS7jBhT+p8AXEmb1q9cnIBQMsWcZfpr7zXSBxcAFk5b2JtdAil3J4M/dBIZFUwQG+lO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjaGay0yvk6npq/CZIPg3FTBl1EQPPRIXbS2uycjsayNAqG65L
	clg9jXo/wU8uoTVcJoiuT/x9wHDCmPuRxP5O+j2Ud07xeQ6gBm+7siXAxadRDqjbu6/LAZJI5KT
	bXmLb01pUD+XYJaenQmjscuWhCRxP8weWxdoLxpEX
X-Gm-Gg: ASbGncttS/z7DuwyOlVxRvpzy8L28OEcX3t+RSnkFPThDtpOfQlJkzkaxilPFoa9GuL
	OVfQsUOinfZXj+yuzRNk0FMUZUsbpuX8ZDLlXpiiUQ5YkwhRTUa3NQWqTkvHL5Beds0PO7VAjhS
	ga/yQRG00VDtuW9tE5HvbuDhsJUjC2DpO7J73wMy9930QNHPCH8qVV8scAFlIvqHS7uoBbi0tc7
	wk1Tm/Zn2RdyF71NON5qwDPpkj9edf/lLPseev1WUak7BZKKqMRbzsUmrHn
X-Google-Smtp-Source: AGHT+IHvIzFCAVsIe9KLnMzhe7HeHw161tWjaGF8dq9LK8mHTJ5LNBNsg03z1RN2kv4hUoIzYntUB79AzDiL37F2WAo=
X-Received: by 2002:a05:6402:50d0:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-64044380bd9mr816143a12.34.1761695932545; Tue, 28 Oct 2025
 16:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-11-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 19:58:33 -0400
X-Gm-Features: AWmQ_bnbOFuYYw7q6A3vKx1W9tiGVviHbdGsSFCW7Z6eJ8jFBd6mwoz2mbQdJG4
Message-ID: <CAHC9VhR4nO+TanWwz4R-RQijy9h5B2h6HuBDXxBNp0+kAE4Asw@mail.gmail.com>
Subject: Re: [PATCH v2 10/50] configfs, securityfs: kill_litter_super() not needed
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> These are guaranteed to be empty by the time they are shut down;
> both are single-instance and there is an internal mount maintained
> for as long as there is any contents.
>
> Both have that internal mount pinned by every object in root.
>
> In other words, kill_litter_super() boils down to kill_anon_super()
> for those.
>
> Reviewed-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/configfs/mount.c | 2 +-
>  security/inode.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore> (LSM)

--=20
paul-moore.com

