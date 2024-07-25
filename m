Return-Path: <bpf+bounces-35666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BD93C968
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88202281FE6
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E3147A5C;
	Thu, 25 Jul 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JOcXrD3/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79B3224
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938640; cv=none; b=C+Z03IpPYu9dPT+CYeSes+pE4hGPs/gI4Q/nexITZK1RfhCIX02b58NtHuy7EXdbFqVaRVYpYPaL17LvcsGrOrMWz4LsOblz8kUfLvicittyrVblKwb9Ogs77ru5YCR/uxCFFPkDSg6AQx78EpjfZnWse3/j4k53vv/7KNxK3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938640; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTRnLHMFvWatn/5yKJFNF1EUchMSERXsl+dEJnibat1rOcXtCnM1mAxvL9mYvRqRC9W6XrSCZT3DBiQALr+trHHNUPjd5k5t88Suy7yzr897Q95IgF2BrhaInLVXoIm4YD95OLCJkOhVSVcHLsZlqjTO+a5HoeFw2CS9wMeTNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JOcXrD3/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a94aa5080so121098066b.3
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938637; x=1722543437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=JOcXrD3/r66nWqAoKLG+NA5sd8y4k3C1c1DEj7Gon/u9bdnvp0QuuQhxI7ck46rMFc
         EovOuq5nvdqDmc/njlcPEs2TfClUea8h/4AUYjwwaIyVW1jfQt3NHyEeWaTXBW/pMyO1
         RiaQGct77frMVIADAuacL73KIH+C+Jyatsglw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938637; x=1722543437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=TPFnEof1ON+I3J+8CuKfd8ALXM9ztc1NkwEVoyM0AtLVME9bmVq3YCEXZrTl6utCr1
         Xt8d6ghNpmOtlNSKRZ0ZD6Fe3Q451duxbsAWbyFi22TAwZYgiXsPyLfVyQDq7rysLqpv
         E8G0Xry596roA/fgnrSlSeeAWDLCMsy/m3usBKgMIsUI0oVDqRrINLtde7FB/nv8ELkX
         PLdDyozs0UX998+LG5Q9+Veu0YnJV5HLpfYtEYvDMMlgvbTIucY26sZ1XM3HbjVwPFk+
         ouRGd5qKUPTWkl5LAiy0ikFFogAZV5YgJzYLM4DZGqzHFeOn+cn7AOUgGFmvZX9/trGj
         xAFg==
X-Forwarded-Encrypted: i=1; AJvYcCVTc3RVumI9lFzZJ33X45jb3JcyRUc9AGIC4YoInAaJyl9wcH2nXzGGUIC36LxfDogcCMb1f36eYNluCreL69qXiJfn
X-Gm-Message-State: AOJu0Yyc3sCb469PdyDk5IoQkmwDufMUNchix5GzQEguRAgCuNf8M1VV
	nbXakT0NpZ0TSpmNeMUm14nxV0rtJOwFevH9Ew3eRtoUNAbGuUd6H7pp14mJXzrqPAkKEIOTg3a
	scILyNg==
X-Google-Smtp-Source: AGHT+IG5GMDXUjoLBWFgR/dJQoZqHF+42N1LarqcEsxLs7P0l/11ZkYHojBwutO+B8UJvzS9RWxVHw==
X-Received: by 2002:a17:907:7f24:b0:a7a:a5ae:11ba with SMTP id a640c23a62f3a-a7acb82325bmr245850166b.50.1721938637141;
        Thu, 25 Jul 2024 13:17:17 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad902e2sm105520866b.146.2024.07.25.13.17.16
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:17:16 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a94aa5080so121095866b.3
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 13:17:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkFZx761fHVzYTdRnd35M5B3dZVscRAgQknZK/aapGD0yOpQHB4CDDKjngaqApuFfQgeWKw9F4EdZg/aTkxvB9jr0Y
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus

