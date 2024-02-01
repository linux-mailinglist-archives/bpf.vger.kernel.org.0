Return-Path: <bpf+bounces-20988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D3384624C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 22:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B4928C865
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5213CF72;
	Thu,  1 Feb 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="Kk0VT8zu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4DA7472
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821526; cv=none; b=hwSDGZ9av6JSjbrDqr02sRKuZSTdAMP2VwgXTz9iSkZ88gdhglWEu04mcpl8EoMo70hUnhRBZA6yI+UwMpDOnEAzwyEL5XYS044jav9q5RdqQqhU7VWFl3voNVHxPtdDZ74yVwOSoOA+QlLn3DvBjtt+B9cTRrxELVW/ceUHv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821526; c=relaxed/simple;
	bh=7fKjcPH7+WRV60VlmhPTxL7sF+B3HBAC+YywHUp2ojQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPzBdI0gOWEVnQB/j8pBjMpVOs53UhUeWcmzu3m3B/ZHzQhp4V1y+DKcOvjNqcbMS8iBhfaDmTiemaZHtJs6DnbYUgL2qc2njZgqI8tfAzX1E2ySaDW8Ygos/Kjvp7Q2E63VruihPS/IAsKBlAgRS4ABPPWGMq4iq+tdybhoCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=Kk0VT8zu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40efcb37373so12503065e9.2
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 13:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1706821522; x=1707426322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fKjcPH7+WRV60VlmhPTxL7sF+B3HBAC+YywHUp2ojQ=;
        b=Kk0VT8zub6HWEAzXpgy4yB3fIqk/ygiCzJuJczCrMV6ByzQxC0tdO1rouWN6uyu6Qf
         E7qAGGIjkU1H/bnuCr0eNSrD3pljCLYpfrFFExGFboE6Od6vNRmZnQea279YDdkaaPoN
         WsEsBihIaKWG7kWE7tAAOftxhX4BcSjeYGNG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706821522; x=1707426322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fKjcPH7+WRV60VlmhPTxL7sF+B3HBAC+YywHUp2ojQ=;
        b=Xc6i/mYa35839BbcEYkovFIuYydg0APnxU7q4jGobc3vRODeffUHRvtmGwoqk3B6Y2
         2dugJ25F7I0ZVRjt8/aKjCEEsWuCL1/JiyaolyZCx84nKCGC/iBc7Qcctb3AEU3kEXbZ
         KmAtKjRW5DkeZYkAq5sXxU9BiIh+MacVO5TA2VCkMCOQx1UkH/T5cT4AKMpH2WeW7WP0
         pRHH/h5egOE1thOFC4k1QHp7ZOegHCUDC+ZzyfGEN5tA5+mUD53CcimJ2UsvZ8yHSFae
         fWM3DXlrkh+ZrmhUmGJqYxJ60/QKsZFqru5+jO3K3Feoh5QX8u6lXv8EbohrkgyPv/od
         BE/Q==
X-Gm-Message-State: AOJu0YyYNrD6Fe319032eRPCVkq2V3BJ76ydUlQQnnHFBEcvLBzZpq2U
	l0mrQ5gM6aQgMvy1RrTjU9IBaZikNCiPwsSSVK9zPJa/lF1/4iH4vuE87aCH2UxnMZy3FoRw4DD
	g0K7tH0Z2SY+Po63Ybhkk+Y0nRQyQNRTUoctO5A==
X-Google-Smtp-Source: AGHT+IGjXsMGdSCI/WBgaSqCgw7rBBgu7vQ/CExXURIBGRX2BurPRo5NHTWcrYb2dS4EwSjdg06sSq6GeQ169TVT/ns=
X-Received: by 2002:a5d:428e:0:b0:33b:1803:7c91 with SMTP id
 k14-20020a5d428e000000b0033b18037c91mr1753394wrq.15.1706821522151; Thu, 01
 Feb 2024 13:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
In-Reply-To: <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
From: Bryce Kahle <bryce.kahle@datadoghq.com>
Date: Thu, 1 Feb 2024 13:05:11 -0800
Message-ID: <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Quentin Monnet <quentin@isovalent.com>
Cc: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have discovered an issue with this approach. If you minimize the
vmlinux file first, then it can remove/renumber types that are
referenced from the module BTF. This causes bpftool to fail to parse
the module BTF file. Likewise, if you minimize the vmlinux second,
then the minimized module BTF will reference invalid vmlinux type IDs
because they have been renumbered/removed.

We essentially need to minimize all the modules and the vmlinux at the
same time.


On Wed, Jan 31, 2024 at 4:54=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2024-01-30 23:05 UTC+0000 ~ Bryce Kahle <git@brycekahle.com>
> > From: Bryce Kahle <bryce.kahle@datadoghq.com>
> >
> > Enables a user to generate minimized kernel module BTF.
> >
> > If an eBPF program probes a function within a kernel module or uses
> > types that come from a kernel module, split BTF is required. The split
> > module BTF contains only the BTF types that are unique to the module.
> > It will reference the base/vmlinux BTF types and always starts its type
> > IDs at X+1 where X is the largest type ID in the base BTF.
> >
> > Minimization allows a user to ship only the types necessary to do
> > relocations for the program(s) in the provided eBPF object file(s). A
> > minimized module BTF will still not contain vmlinux BTF types, so you
> > should always minimize the vmlinux file first, and then minimize the
> > kernel module file.
> >
> > Example:
> >
> > bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> > bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
> >
> > v3->v4:
> > - address style nit about start_id initialization
> > - rename base to src_base_btf (base_btf is a global var)
> > - copy src_base_btf so new BTF is not modifying original vmlinux BTF
> >
> > Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
>
> Looks good, thank you!
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
>

