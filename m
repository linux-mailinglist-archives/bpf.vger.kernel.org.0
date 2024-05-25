Return-Path: <bpf+bounces-30602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1A8CF0AD
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805951C2101F
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DC1272CB;
	Sat, 25 May 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHM6upNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7186ADC;
	Sat, 25 May 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659762; cv=none; b=ByBEcoxdOV4+YGBf3lR1Y+fOidNhnXASI4niUf0O//cgNwj1l7WLDCBwAu79Z7k+2hC29lFsAIU8K1u+MDsDd7H8ig9HaZRCGAjxA1z+5QI9qF6AfnzqSOlaJawfXJS72XlmgLhIHEx1B/rbstf7HL1U38kKZBYtWKfzwy/aEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659762; c=relaxed/simple;
	bh=NzTlXnDHFhquL1GpZIfW8B3BsgkQb9tRQBgtLSR4rh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvYUwfzNdOM8sxeaXDBhZkDHrBFskPK+MwaVcu0n+GMpI+BpBJt35iNliphZ5jFAmnSByIgsbvO+BEq6JLEFVM+NAmfmoGbPPGX6dOUUC3AOB8ISwmaBMJL4n7My0IeXzesche/xS48ieTlv4Y2BJccZj5C4iCF3atWjYPxXDSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHM6upNo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so72693745e9.2;
        Sat, 25 May 2024 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716659759; x=1717264559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0JA9VVmStZPJkpfA1bys3LZMuO61uh29gW0zB1zBlw=;
        b=FHM6upNo4A5UOdBObORND9dlO0Vetmywre1jPMorQvssNHQpfLPZAs0BaQE8jlbZrO
         GHD0wI4m4rcz4bo9TruaP5znNk+3xRAcClwbMjxkzIYzINT7g66BAxu2S66DBS95W1df
         YUro7WMKLR9KJcbRCwe9O9r4GvCegqFYwMXndoxTC+TudvAHLVIhpEeqCpYrlMxDZJVx
         F207dCpyPmoDVJwS2qQDIREZgML2rqqqnHa3Upx8oZrtKSgEzupJyS3dMYdFyTccUfzR
         XoDMEHunOIH3tFfFudNud79lzlKmBIOh2yD0OEJ2XVu6ZZWlo/y2AKVXmxW4WYJsj9dI
         BGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716659759; x=1717264559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0JA9VVmStZPJkpfA1bys3LZMuO61uh29gW0zB1zBlw=;
        b=LxmXPwiRc2+u6lF1XGZHCkTU6PFEHGra7H8EvQpd1jhqGpO0J7ppJrE66CxE8+vH9G
         WXeXy5uENrRAomgnSD50Du6L6FATlUwGpa73yRRFLAy0jVJ5DAYlazzNOkWVLXhY4qGS
         hgCSAYbnznv88XQ/i2CEcR2WSK+zym/EhvbPMPwj7LGIMQW73STj2c/jcAdfqi4eyHiv
         WtIdXpI0y+PgS3K0OIUVIMXHHTVpEgFTjO+K5+hm8f0ldllhMySxdoYhvP/s/ooI+r28
         /4YCsD2d8dzzcGIt0ATQ+/+N9afSFrA9DbQX2ZQEgiUfpzHvJexKVK+IJJHb8uQx47aZ
         WY3w==
X-Forwarded-Encrypted: i=1; AJvYcCVYIfNYiK0oAmI+jzS4uEC4PLWKr57sF+9j5zzw9VrSM2WTg4v15ozBKMRNMfygrhwX0qJqdCn3sYLKJzau174UvXNaj56wgHK6mO1V0CcDukEoNadQH2IPEI5J
X-Gm-Message-State: AOJu0YxyVM4eGuYVRL8hTYDx7G3W2gzT06a3X83DEVBo3KO+SAJap4o8
	ncRrQBcWocp6JWghcUdyCv040YFcZOks7dAzXdvlIGiDMPCZZG7JKGnhrVbMHbsV9P/9S+yxsQl
	eiCE0y9jqzxzPOH+YWKDWcLfb1mnFlQ==
X-Google-Smtp-Source: AGHT+IHVX3HW4yp0e5D0E4NKtYOeqVFzzR7VKYodmoWaBn1jekTl1CVyAZyuiPSRSEeyTpPKIGUP4LODV4r/NqB1HJc=
X-Received: by 2002:a05:600c:21d6:b0:41b:7d6f:1f24 with SMTP id
 5b1f17b1804b1-421089f9d1fmr36408965e9.21.1716659759122; Sat, 25 May 2024
 10:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524163619.26001-1-daniel@iogearbox.net> <20240524163619.26001-4-daniel@iogearbox.net>
 <31b97318-38fc-4540-a4a9-201c619c4412@linux.dev>
In-Reply-To: <31b97318-38fc-4540-a4a9-201c619c4412@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 25 May 2024 10:55:48 -0700
Message-ID: <CAADnVQK5nL2Pkh0pUanHvVh0auYmdbc2yEfMxquknoX0vjiUAA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add netkit test for pkt_type
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 3:05=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/24/24 9:36 AM, Daniel Borkmann wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/t=
esting/selftests/bpf/progs/test_tc_link.c
> > index 992400acb957..b64fcb70ef2f 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tc_link.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
> > @@ -4,6 +4,7 @@
> >
> >   #include <linux/bpf.h>
> >   #include <linux/if_ether.h>
> > +#include <linux/if_packet.h>
>
> The set looks good.
>
> A minor thing is that I am hitting this compilation issue in my environme=
nt:
>
> In file included from progs/test_tc_link.c:7:
> In file included from /usr/include/linux/if_packet.h:5:
> In file included from /usr/include/asm/byteorder.h:5:
> In file included from /usr/include/linux/byteorder/little_endian.h:13:
> /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inlin=
e'
>    136 | static __always_inline unsigned long __swab(const unsigned long =
y)
>        |        ^
>
> Adding '#include <linux/stddef.h>' solved it. If the addition is fine, th=
is can
> be adjusted before landing.

I hit the same build issue. So added stddef.h before if_packet.h as
Martin suggested before applying.

