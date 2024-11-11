Return-Path: <bpf+bounces-44529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C79C428E
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 17:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65B81F24551
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0CF1A2541;
	Mon, 11 Nov 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBAW8Is0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1397189BBF;
	Mon, 11 Nov 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342313; cv=none; b=Kp3y0hsFAZO7e95Qp73IjpMu4nsAvwWwM8ZN5OUpclSeQisFKw+v7CcsBxYa1M7hfU6LoL9k3F3agELO9woe6Ho/ly761K7vGtgxnKVaHlgad8hbCgN3ZZdDc/Indb2T9fP8zxtcQMjE0Jn2jPHonmUsIezy7gNv1plYnRfdWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342313; c=relaxed/simple;
	bh=OccHd1rTDxGip1Tqu1chnXzqdTStVagIc6+eFig3HFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+auHMPF7azSQhfA0wwSkjBKH6N2x0DLu4rROG3w0hsscsHK5WxFBwEW2FW/KIpsGZs7MEELz6gzbH9nOcd6OMM3PyWAysJ+wnaDdPxBbrLSZOAv0nW4Kp/pWh4sFiAAZ3mPg5UY2ILPwLIABj6vzLB1HXIUSB+9VY+Z7kAwtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBAW8Is0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso3648243a12.3;
        Mon, 11 Nov 2024 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731342311; x=1731947111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg9x1RcRnG2WX//9+175aTG+cJjttqB0GgtrQ7pKtXo=;
        b=XBAW8Is0hciM4qwKuFJPfP2r8jMK7Knk/8MIrlHWgKFqr/5/kgOzlYPdK75o1GzOaR
         f+uOtaRsahEUP5WMRsAuIzezc45JT6L16O4efl1tMQfyUHMUHbaluqvQcLHrmW/8pQFD
         nJ/J4iSXTO2CnYhqDRUSxy5NmqjJAf67eBM4rhkUflolaXCs5lolgicCX8PssCkR7Twf
         2tyaZELtfxHmMJlcP8ZOb8j0ha8lBgdz3ABcE3/lulffhWuiegXhiRzfyne6cOc8W4sM
         ABsTxoWsHOJDHZLOURkNitNEn1pi2L6u4TXDtweLj5PuxK/s8ocVRXTlh1W+adcywUdp
         ukaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731342311; x=1731947111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qg9x1RcRnG2WX//9+175aTG+cJjttqB0GgtrQ7pKtXo=;
        b=AsiAXrPSuEdOBHkjKFjgvG8mIHDaD5yxAU35Bw/LE/1Dg8ZigmoYVeYUXgSAtn87ai
         1clvQIhB0kOoNmh1HdQryztwp+2Cb1K3F4xoyDCKvLgpWWighPFXvvLsbAVpC0uHdxXo
         SAoLkXvUwhanHgv4sJXqz0ozpJugLWug0xqntWCW7JGsZe8Bl92Qxv17nA+E7uM45gY6
         FPW3YUAFiQv43+20gdvcZUE4wIDJUJVMv9gDyM3NG2bHjNCe4O3FWKY5Qf7uFKIrY6jT
         5uWI8g1dUvVK7MtnoT+EwuQF3/eoti4ZgyrsqtoxlhDR62ooP+zIMjDW8/oAZ9n/4rjb
         2rcg==
X-Forwarded-Encrypted: i=1; AJvYcCVL6a8IRdfaRCr2oSUYBxRA8LuJWa1wqOgMHDoGka0CSuZe5uMRXXsSnuIKzAYXIkLbisTwnEb/@vger.kernel.org, AJvYcCWNaOnOfgHINAYOOwGRodOOxfm9ux/rt572tMmbQ+8GFaa94sgefAd/k/+BkDRNmkPGCD1PYLXa/UzR0mO2@vger.kernel.org, AJvYcCXNbRSZoZnN8cSLqjUCSRu+aQnFse6ozFEvrZ2233F+KKjeZulGknB9iawZHW7HmlrNsMI=@vger.kernel.org, AJvYcCXwU6SLhWOvbTJQ1zv5baTUONJAEmdESdUKWOCkJM8NL7aSSx6mkXVdIxtzFU7ETf6VZVZh56PGzv11Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlc74tfjKRE3teeKlDDuEbXma2w8URM6o8UJz31XT57ususFY
	fVoiXWIKyaIq98xURt9Ln6u/1SYuzg5v763EIALBI4EvYLHYKKQJQZO8/MsNgKQNHsJzVpzW/Ql
	0w7flGR3wl+6utAx//GghwNnHF5Y=
X-Google-Smtp-Source: AGHT+IElDdvIgdZx0aKMKrebaZqvXhoopHUdyBWc1+UNJ1thTyzTdJrn8cYezzwf7Sv059fw/322Sk+U+ScPg32U+2U=
X-Received: by 2002:a17:90b:2b8e:b0:2e2:8f1b:371f with SMTP id
 98e67ed59e1d1-2e9b177d6bemr17818331a91.26.1731342310976; Mon, 11 Nov 2024
 08:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111080035.10b4609e@canb.auug.org.au>
In-Reply-To: <20241111080035.10b4609e@canb.auug.org.au>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 08:24:58 -0800
Message-ID: <CAEf4BzZE631YjigS9sbG0XcU974hf_PNFRRfuaneb=uHPAY-6g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 1:00=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Commit
>
>   9a28559932d2 ("selftests/bpf: Allow building with extra flags")
>
> is missing a Signed-off-by from its committer.
>

Fixed it up, thanks for the heads up.

> --
> Cheers,
> Stephen Rothwell

