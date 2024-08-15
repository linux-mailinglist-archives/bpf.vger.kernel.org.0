Return-Path: <bpf+bounces-37309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F16953CD7
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E6B21007
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50215380B;
	Thu, 15 Aug 2024 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eolZ/pwE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F414BF9B
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758159; cv=none; b=Izkv18b5N6ErJMyOwEcKKORT5rTjI48oWXUpzwN5ymmOT9ATGI0dl9pzJeBDV2V8pDQ8ocXZ+LrCIWCu1iDcNscQF2jwlakYNxmlQaW5Duo/QszCKFgO0EjDZnP6LDsbowDKVMlqbXNVuGxPU8D8l0dfzN/RWOX8eXSTOsyQvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758159; c=relaxed/simple;
	bh=RzDYpC1/nLHwX8uZFUibMven07RzPkw92bCNc45d4cg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=flHAQRFimkG56e/YCol79gjbuBv4FTntPuP99W/D1Q0rzRUq2unLaByQxNJ9qaDoMVTokBCTILD5gi4Zc+OOIVWAhx9xG2FGKx+aVKWynXnP04Kx6dQ20hCi7Wked91scX8iV5cllyZpkXh6GLkMwp0FanJxPYj1+/7w6/nWaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eolZ/pwE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3b4238c58so1056689a91.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758158; x=1724362958; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FrdWSeSI/ENXSQltPo7o9SgbBDmm/g3MJd3F3b8mV4=;
        b=eolZ/pwEqotFTQUJ4s/+28eMMbx8LRqLpQjtdXWW7h1ZhUeNJ5GEB8yDTVz/oCIsua
         WxwD+hkZR1b77X/O76+sme20arn6Dn/hQtEbXlnud8PluMJWz3K0plQDV4FHRNNPpmRO
         5uohh9hueJ00ZajLp5DUXu1uGCH51zqv+DXLP1G0eM1Q7/RzggHxr9q/ex+C+Xl5HdUt
         CMPH/fEXyLBJks7qKP+UgizwjgokIUQlHI860XmgLwCc0zkjWN8jQCCf4YNTgJmxoVaH
         epJmOPW3OH4CKtM74ccEDPkCjzJrccT7MUVIl8NK/F4v5Hq9R9J3rZm57jDvOjL6xbXx
         RrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758158; x=1724362958;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FrdWSeSI/ENXSQltPo7o9SgbBDmm/g3MJd3F3b8mV4=;
        b=On6BgBSt/+4tX23Ftkgn7bXpsuQ2zi2jS8gxn+UjmY/x3HHeg2/pBC3kwIsucFQwDB
         vFypIkzwxq+Q6MS0UxZgcgXmAnAPUySWTmL46enQD30RdigkNNbP8uI25LNt3z04OEFw
         aBiUZg1QDFpF3qlqSQocO5Q50KWX51bvQrfQbclF/h7DEqwqj0BmJjeccOBIP5XHFELl
         thcFLGy+44t7ZNyRtM+pzByqxUztX4fvouaw20DQwe/j7izIBkDVuFWt50SFKO1rZtrv
         kjbTVjfn2fJ+4xqaoZ585Qh4jHxzsHRB1GI3qhfQoHqwITs56wVVLkM0IOZGwFC3hQz7
         CTrw==
X-Gm-Message-State: AOJu0Yz8fZJE2DDTsvbM7SAGbScyvS87GQlOv/afXnoY4VhOdbzI8vol
	t+KCTUqQbc+vT47F22QqaGv4l3BYCu6EMLMj+vapLp3vX9vjAQoP
X-Google-Smtp-Source: AGHT+IFYGFhLPVOgZNS9xK91GVSBax3ilm1cfMTiAxTIUgPsBVbIGE6fm6Rx8aCvhoHEqQFfKen/OA==
X-Received: by 2002:a17:90a:7448:b0:2cd:4593:2a8e with SMTP id 98e67ed59e1d1-2d3dfc4ac72mr1098421a91.15.1723758157555;
        Thu, 15 Aug 2024 14:42:37 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d97f2asm290035a91.53.2024.08.15.14.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:42:37 -0700 (PDT)
Message-ID: <7925b20a052588f5b7b911ed10e23ba9fd56d4a4.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 14:42:32 -0700
In-Reply-To: <CAEf4Bza97Ksce2XYiQrvzYC5Lnqz68xWM+JvDeKMfj5M3pr+Rg@mail.gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-5-eddyz87@gmail.com>
	 <CAEf4Bza97Ksce2XYiQrvzYC5Lnqz68xWM+JvDeKMfj5M3pr+Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 14:15 -0700, Andrii Nakryiko wrote:

[...]

> > +/* program entry for main(), regular function prologue */
> > +__jit_x86("    endbr64")
> > +__jit_x86("    nopl    (%rax,%rax)")
> > +__jit_x86("    xorq    %rax, %rax")
> > +__jit_x86("    pushq   %rbp")
> > +__jit_x86("    movq    %rsp, %rbp")
>=20
> I'm a bit too lazy to fish it out of the code, so I'll just ask.
> Does matching of __jit_x86() string behave in the same way as __msg().
> I.e., there could be unexpected lines that would be skipped, as long
> as we find a match for each __jit_x86() one?

Yes, behaves same way as __msg().
=20
> Isn't that a bit counter-intuitive and potentially dangerous behavior
> for checking disassembly? If my assumption is correct, maybe we should
> add some sort of `__jit_x86("...")` placeholder to explicitly mark
> that we allow some amount of lines to be skipped, but otherwise be
> strict and require matching line-by-line?

This is a valid concern.
What you suggest with "..." looks good.
Another option is to follow llvm-lit conventions and add
__jit_x86_next("<whatever>"), which would only match if pattern
is on line below any previous match.
(And later add __jit_x86_next_not, and make these *_not, *_next
 variants accessible for every __msg-like macro).
=20
Link: https://llvm.org/docs/CommandGuide/FileCheck.html#the-check-next-dire=
ctive

[...]


