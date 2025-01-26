Return-Path: <bpf+bounces-49838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B485A1CE55
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 21:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EDB3A6D10
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9EF175D4F;
	Sun, 26 Jan 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7NBrwmV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEF1487F8;
	Sun, 26 Jan 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737921874; cv=none; b=Sm0f3rqvJ1RQP9h5aO9PKFQxRU3hIF1Humd5VAQKH+WNpB+miMNK8vxmjMMptp5M2l0Hh0WA1SG95bRGAAQLwR1KPZ8julYDv8aSnjZsB5Gf0ESc1EOLumaQ3i9DyqDqmmEplVRYdAlcxzf4oyiiY8cO+lmJuEx5ueqLeOhTotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737921874; c=relaxed/simple;
	bh=cA2sHLSy+IECdgnCU0W45BIEjNF7mxy9cjFQpF7naOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QApg/57Wd1A9jm8H4uLIp9NUW5z8nq6+P3AZoYqOM24mtN3w2rAEYY4cz+9El6ZgU8CUh2XbsWrYPC5CId907EmYuclfWVu8Pgy3ZcCkuUfZcrpObiGVobxWpSwhn3TsoYBQBD+9zWJF5k8Q8v+kxHGXQFIfwcykGh0eAEYfJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7NBrwmV; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85c4d855fafso641324241.2;
        Sun, 26 Jan 2025 12:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737921871; x=1738526671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UFB2cdGGKotEJHKLG+7okveVa4RPRX04Ef/GbO4+/g=;
        b=W7NBrwmVsByyoHhEeaPJYlfi4D4d+GoYqd8cBofuKCzLkydCPahnu1f9Ywuf5eSzxZ
         FryDWSu+FRlC0FRhqorunCsS10FqGLn8hVKYDvtBzzNj1oXy6JKj94ximmzFsu8Mirz2
         hVITrhPmgVUsgOlQ0jz5N7gC3IOsC4h8LVDG5UN2XcsdFz9AZdmuLTYmj6p1uSbAQNml
         xqsjUL5kbPMZCUx17RRMRUhlRNH0m0NlPlWLpKPEDdpq7kvH41DMura3pYUdH+MNIdkS
         mczo3Cqmv3b/glZYhDPBVLsXBYTAflWgVdueqWGXmFZ3608Iso+kqxrwP08dKzSkeJ7S
         BkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737921871; x=1738526671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UFB2cdGGKotEJHKLG+7okveVa4RPRX04Ef/GbO4+/g=;
        b=uOAdOa8udCkzd/FePjsPs31VdzVOZCu2kpyozOlwGoKZQHyAoRD1k7kizRWPF8ToYY
         5y4jLdqWOJ+gVqBvvbtTLuF3odQrXUf1N1tOvlPZaqqxzOqDqxlSGid2vpz+6ye8aPXW
         F6mwmdooSZEgaURTstKE8Q4x9x8BciHsO015FUQHJ2QVgj+NnwIe9r6C45vAhPuFbt0H
         nDtI8/lddDDdB/jo7HljpR0KdnoZTEKVvLRTr9HB/DReIR8wvzIIYta7AFnY7jx8Fgps
         qXfI+gW2qOlXY8Kw9wZIYt3DdzVhmpIj618qsnmBZM6VT/+4lzaQD7OzKEEarGqh6nSU
         mEaw==
X-Forwarded-Encrypted: i=1; AJvYcCUPdtiNNRjtFtWwlzzsAthpYdx/nFPtlNGqSoCxNurYQAKFBBkmMv+DauJtZ1nYrta4eUg=@vger.kernel.org, AJvYcCXyXSLDFvyR1379t4Tsdl5rJ6+GbGLbcQWFAhwrl1Z8wHBDMbzD9rBbSnnzsxBVO1xwxUSbRYC4uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRiEo/AVZyiQozuCHWlwIR4+vwDzOSwpFE877W1NSOvJA6Rdoq
	HdUbOsDt/owiyoiwXd+PurNVw39HEQdED9WkYYqHptx8XgaqHjOkcMoadbz/Tr8bUdzqCMOlPhH
	FJbfLhthlPUEcfli3stWhglqG3YLA4A==
X-Gm-Gg: ASbGncsamR+7IQhYQtuYv9Hd4BO7acqsjjrlRQLQMi6AghHkTGsNFIEQTqpNIWs8JRO
	SWHyP6bj8HnJChvmh3mX7OiOtZRiKEOq1IfFon6yci+L1716wMM734keDV2MTXzplETEfzEGCLm
	uIgdeCxSEKDifrTwWHwv0=
X-Google-Smtp-Source: AGHT+IGbZszlaUqrEoNChwpMD/TouWv1o51Lx10zKeJCaCrz2n1IqHvAZCs0yJZ7YvwC+VX47CGzsEL7cug21QJNRsk=
X-Received: by 2002:a05:6102:f08:b0:4b2:c391:7d16 with SMTP id
 ada2fe7eead31-4b690ba7dcamr32509801137.7.1737921870753; Sun, 26 Jan 2025
 12:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217103629.2383809-1-alan.maguire@oracle.com> <CAM_iQpXGzy5ESZ3ZE0Wo_p_pkXYbgMe3L8stbBcBCo+oJuWimw@mail.gmail.com>
In-Reply-To: <CAM_iQpXGzy5ESZ3ZE0Wo_p_pkXYbgMe3L8stbBcBCo+oJuWimw@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 26 Jan 2025 12:04:19 -0800
X-Gm-Features: AWEUYZnymLgvb1R84UVxarIqrqwBu4pmkgz0CA5MQil9Y0z-IVhL1RyA5w6rhuc
Message-ID: <CAM_iQpU8jQ9yEs_rAf2gdyt5yie7BwkiU4vpa-efF6ccVo5ADg@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: verify 0 address DWARF variables are
 really in ELF section
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, yonghong.song@linux.dev, dwarves@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com, 
	stephen.s.brennan@oracle.com, laura.nao@collabora.com, ubizjak@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 8:55=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> Hi Alan,
>
> On Tue, Dec 17, 2024 at 2:36=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > We use the DWARF location information to match a variable with its
> > associated ELF section.  In the case of per-CPU variables their
> > ELF section address range starts at 0, so any 0 address variables will
> > appear to belong in that ELF section.  However, for "discard" sections
> > DWARF encodes the associated variables with address location 0 so
> > we need to double-check that address 0 variables really are in the
> > associated section by checking the ELF symbol table.
> >
> > This resolves an issue exposed by CONFIG_DEBUG_FORCE_WEAK_PER_CPU=3Dy
> > kernel builds where __pcpu_* dummary variables in a .discard section
> > get misclassified as belonging in the per-CPU variable section since
> > they specify location address 0.
>
> It is _not_ your patch's fault, but I got this segfault which prevents me=
 from
> testing this patch. (It also happens after reverting your patch.)

Never mind, I managed to workaround this issue by a clean build.

And I tested your patch, it works for me with CONFIG_DEBUG_FORCE_WEAK_PER_C=
PU=3Dy.

Tested-by: Cong Wang <cong.wang@bytedance.com>

Thanks a lot!

