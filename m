Return-Path: <bpf+bounces-46413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488AE9E9CD5
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1611887DF6
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E0B1547D2;
	Mon,  9 Dec 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYLVRdHi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106DB14A60D;
	Mon,  9 Dec 2024 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764746; cv=none; b=N6MqoWitpsOrSpbw4fbvq/9grDih8j0ybhq8nmx8OhBnmWKEH2L6ZPjVChxIlZR3C/InbECaqJfERKg+ra470cUEeNhSy9t6OMfyOMeek4d11fUsR0liE72Hw8aDl14gGnrUt6Pt3YJPbjNYJ0zGml5veGJC6mQqepL4MEBBmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764746; c=relaxed/simple;
	bh=ItD4eplOn/dhoyPmVWtZF6jzHpii+Rtqx285G2OsUWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tbk0h7/dH+LzU1B95u1XNsAynm446f+J5oRq5qis9b6S6WL+YloJNOQ7KHZdTM5f0nBASX146qWmech6OkUeTJfZwl3SaEAYKWxteQvQwlC/yHPJqZcNuCuFKeRyB+6PtzbwkPHNLHM9sPA3Wrqv8wsaZ8ez7v9LDJu76P9UxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYLVRdHi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434f0432089so17603895e9.2;
        Mon, 09 Dec 2024 09:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733764742; x=1734369542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnHwODGAbEIMfTKBL8qUAljRu8OgOtDIjJW4GIX7tSM=;
        b=HYLVRdHiNJUBYuDTxog7IBCWm4XqiwioaLbZzAa4bpMZ1Fn5Y+ZtnNEzguXx2pY1B3
         By0JIDEPaUly/06FoCOISumsDPGHXVJ/NqIDM/mfPZzizJ4IdEH753gstqVe6LuyyVxR
         ZNrtTEBvjTcH8FIgCEgsEQWaLIC0VpLuQUX2/Fy/p+q/CjKB5fNE2oZ2p4XeI43WKbq6
         mTcwRcqsUupVvoxVN4UpXADuu2DvFHygJDq323dSTV+LKDjJ0ZMm/fhDjTAP8tzEsLsR
         sNibV4+2/9/3YsY2IRmABF+9h7ucNWnoq75h+Bg9ZJ+SHvORsYWcaBpqntmWPSqqn44f
         a0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764742; x=1734369542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnHwODGAbEIMfTKBL8qUAljRu8OgOtDIjJW4GIX7tSM=;
        b=CSYKMVasuOg2QuKFRVVJ5vGnY6X6qeOqc3KkbuxjQyzSluiIlb83os93tfrzuT92+q
         XBpZ6b+2FjbmvDTw9R5MYo6+FGdCBjomyBd2ZJRiBhY4wMe16v4h0HdNFOdS7WaEESed
         kT9IiIiIJNEpsu53e04eKgQNUpFN5jYFF/volAA+qBMTTTStQailEfry8Td5S6yaNivM
         hyXXLt17BM2EM7JNJ3nE33dyDdFbpU7c4ouFy2QTyisSQdNQvUIdsQlU1OGZ588zcHD3
         6g96Ur86ItdINcytoE5t+zex4XKhUre91s9ulNgCLX0YQqjIhxCUH3qF5Q3HO4EDSoCy
         uCpw==
X-Forwarded-Encrypted: i=1; AJvYcCV0pfETKPWrL1l9KeK9M1u66pDaOminr7Ur7kbFh+PiJro/NjUildPXdQ9PFHJpjsRj76pmvDswID59hw==@vger.kernel.org, AJvYcCVfXuh91QhgDkosjtt+RvHOKCsSqR0WgItJlKq3TUy/EXox8VW9PNjkuVYMERtrvEUrhKLWbZsFM9yxjzXZ@vger.kernel.org, AJvYcCWOxPf8DAnSxHmWA7noCG7aY/9a529minsInlLKoy+GcPsYQgUFuLqcyOR8RAKWoUjVDzpft+gn@vger.kernel.org, AJvYcCXLQyNoqwTLn3HBe67PymdMjcK6O7zLnrwpvYqRNa/CuUURy2weoLxgS/6rF5nP0sQL2zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw313y9XSYUK1UYZnSZVEP6wTd9oRGaPNA7uQ2JXL9hNrzAGNF2
	mcTqbSIZ5YkH7qMVOtGcAWJdUP9vezdeA8gtnNE/mzG1rb5EIRqpbARXrfpPJkmoNd5GLB6Bf9a
	yPxf0DcEoH/DmGBLB/RoxfnHutgs=
X-Gm-Gg: ASbGnct8JS91jDFu4ZM0x/6ut7+41XBlRGBPMSNDNhYPmyWelYTWouulTmudyj/Q3aL
	5vSw7TaCWIF5oOwadiwif12qkQLuMmL8UEvQO1aEuswZ60DA=
X-Google-Smtp-Source: AGHT+IFdRGZ/2e8nYotBGdaClS5bSaHlkeM7IP9OXCyHHRen0+4G9xbNC8ZyRxXXJaithuNWY6QpBYreynnJliiOeHQ=
X-Received: by 2002:a05:600c:a09:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-434fb65ecb9mr31310295e9.17.1733764742223; Mon, 09 Dec 2024
 09:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209181607.421c025f@canb.auug.org.au>
In-Reply-To: <20241209181607.421c025f@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Dec 2024 09:18:51 -0800
Message-ID: <CAADnVQKrU3d8dt9SFLM_0wLAjQBfhU=utENF5gYtLCMds_f7uw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
	bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 11:16=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> In commit
>
>   c721d8f8b196 ("selftests/bpf: ensure proper root namespace cleanup when=
 test fail")
>
> Fixes tag
>
>   Fixes: 284ed00a59dd ("selftests/bpf: migrate flow_dissector namespace e=
xclusivity test")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 6fb5be12d1bb ("selftests/bpf: migrate flow_dissector namespace exc=
lusivity test")

I believe the fixes tag was correct when it was first applied
during merge window (without being in for-next),
but then bpf-next/master was rebased after rc1 was released
and fixes tag became wrong.
Now the commit c721d8f8b196 is so far down that we cannot fix it and
force push it. We don't rebase after rc1 either.
Sadly it would have to stay this way.
We probably need to run our pw-check [0] script during the rebase
to make sure such mistakes don't happen.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/pw.git/tree/pw-che=
ck

