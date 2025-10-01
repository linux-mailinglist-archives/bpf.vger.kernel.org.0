Return-Path: <bpf+bounces-70066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9185EBAEFBF
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 04:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A201C4CA7
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 02:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8425DB1A;
	Wed,  1 Oct 2025 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CGOo6OXc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18125C6FF
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759284605; cv=none; b=gISpVHlLpM36XwqjIJZNl46gnYj1DrRPK3Nx4J67bE0B2EEIPKLFO4am79kTYVjbWb72Ey9pvIn93L8i8fPnCaYEKmTO6/MAV/5ymL0tCYr0irtMUT3WYFaTAG6tXkGDaxPX5qpZoTl7g2TSAFJD/j7Mu8YN550zxoiyzXGUWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759284605; c=relaxed/simple;
	bh=ewy8bEtm2e2qFkCfiN1Yi8GekyihfoxvOUMheYkIH18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c32pVrSz7qbFjnZZIYJccszkayrBXfvx1mWTWqQyRYFqJYagBSfRbN3PHq1W+GVnrPXChecXeNP83Lw/qFmGqbusYcCAOMhQgQXszoM4Az6QebzEYFyM8WidR/rtqHuBd0TkdQLggrATJDkFAZpA5V4heV9mgOtskZViI4DbZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CGOo6OXc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so13268270a12.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759284601; x=1759889401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7erB5ZGDmVyr8AkZLrpn4uzVS17t4/mCKRzLiEmHgA=;
        b=CGOo6OXcmUhMZEtbtW6LWfGpxv2CPJrLc3u5NvfMLnGcYF2JmfHNbkS/zvArXz72pt
         nBN9XpvPN0zT0W/hIsjR2lBuP1y9KWsPzCSBFyEox7gZdjyT1eOjKzOFVULfYWUFLebg
         G4Bf/qgmLt7fG2EB9xlHiJZJFRMiHMXW+aVE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759284601; x=1759889401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7erB5ZGDmVyr8AkZLrpn4uzVS17t4/mCKRzLiEmHgA=;
        b=fEbTioiDKPosdUudEAdoEtr1EJnOTLtgUfro7Z+YIDxYPCzfnDoOvPGnn8xV7mu2Sr
         Z5Y8004yHoNLbd8i469Q+bg3vjyivm/dtREG8P824GTlJwNMXe01IOU+wRHqKSFGnrTD
         kToB+kdPXi3l0YkmQROsrgWCWSAXClspBzqtDUWghZqViKnsB76UC732xHpPp/Q7e0WO
         7Gu+m8SOSgbc7/kSiUyZNj3CsdwRlo9FeRVLWhbO+FwXLR8F3F7mYAgF0plJQqqbFS8W
         vRUUFGfCazXgo9fk9PHkJqJ7BFgG+1/lPtr1gJTjsILBPkilHsLTWZBujdxkYfjZWdEL
         P9AA==
X-Gm-Message-State: AOJu0Yz5IQ/a0AOmDUYHlPj3QXBxLUDaNkJJ0KKPnhVSOF8NcUnf0Xhs
	Scy5AN/q29FPVV/Nzlg02qFVMuck7p5qi60LiACoTsM1RDkwjDDAZFWTF7SXLjsTt/5x2HdVkAL
	URPHJ0Pw=
X-Gm-Gg: ASbGncvp4AWFucwHBgnCntq0n2NPdWF2vAcjlzlVaHbCCvpWigkmGG4tN/maHgIvBrs
	hkA20c/N6rwArGTUuRHecqYNPd/JsWtU878j6/oa0TIUVU/RdLoTGv1uHIpHF/i3DDD+4RkGMfr
	KgSo20KwPABaSNcZ7xQA9QYd3banyt3E01C/cpOxXaucDCcnE1jWHlAotP1SmyQJAkhF3i2fOf7
	mE+2Rxciq75elX+gEF5ctiBzAUykQrHytT32TOtElAA42RdNk/f82f2sbOp5Di3U154r/u+ySUv
	VO3JdwZmj5J4ZlGQzjnColnOuWAN00+5qo+khCjyOju1RK33ZATBOt54bJQM9QHyzvsiLPsUtLj
	z8073NrqV5NdVMDjTKGxpYacWN/RwMSrd1gLMGc1EKsX06BE0Hf6MBAyekQgV1P0xBYXr8MwNLS
	fiHjmGBuCPUtAXSvPhD6Sa
X-Google-Smtp-Source: AGHT+IF8CDuuf2oPK/DlTFnsdJfkLY5WoYvW7XE2gUFG14fZyiIRGKiGhWxE0UFquhQ1A5QJMECdaQ==
X-Received: by 2002:a17:907:9808:b0:b40:e2d5:ce28 with SMTP id a640c23a62f3a-b46e5d3baa0mr189456466b.53.1759284601032;
        Tue, 30 Sep 2025 19:10:01 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3d277598bdsm639772666b.3.2025.09.30.19.09.59
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 19:09:59 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3b27b50090so662740466b.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 19:09:59 -0700 (PDT)
X-Received: by 2002:a17:906:c146:b0:b46:1db9:cb7c with SMTP id
 a640c23a62f3a-b46e4791038mr207901666b.33.1759284599468; Tue, 30 Sep 2025
 19:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 19:09:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
X-Gm-Features: AS18NWBi9I9vAHH4YHKcIzlLSZYxGaQO5CqV_lK8IoryGo-bstgFslhzgwijcZU
Message-ID: <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 6.18
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, peterz@infradead.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Jiri added to participants ]

On Sun, 28 Sept 2025 at 08:46, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Note, there is a trivial conflict between tip and bpf-next trees:
> in kernel/events/uprobes.c between commit:
>   4363264111e12 ("uprobe: Do not emulate/sstep original instruction when =
ip is changed")
> from the bpf-next tree and commit:
>   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
> from the tip tree:
> https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
> since Jiri's two separate uprobe/bpf related patch series landed
> in different trees. One was mostly uprobe. Another was mostly bpf.

So the conflict isn't complicated and I did it the way linux-next did
it, but honestly, the placement of that arch_uprobe_optimize() thing
isn't obvious.

My first reaction was to put it before the instruction_pointer()
check, because it seems like whatever rewriting the arch wants to do
might as well be done regardless.

It's very confusing how it's sometimes skipped, and sometimes not
skipped. For example. if the uprobe is skipped because of
single-stepping disabling it, the arch optimization still *will* be
done, because the "skip_sstep()" test is done after - but other
skipping tests are done before.

Jiri, it would be good to just add a note about when that optimization
is done and when not done. Because as-is, it's very confusing.

The answer may well be "it doesn't matter, semantics are the same" (I
suspect that _is_ the answer), but even so that current ordering is
just confusing when it sometimes goes through that
arch_uprobe_optimize() and sometimes skips it.

Side note: the conflict in the selftests was worse, and the magic to
build it is not obvious. It errors out randomly with various kernel
configs with useless error messages, and I eventually just gave up
entirely with a

   attempt to use poisoned =E2=80=98gettid=E2=80=99

error.

             Linus

