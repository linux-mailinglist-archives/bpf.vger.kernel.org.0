Return-Path: <bpf+bounces-63675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C44B0966E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 23:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7BF7B17CB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C762367B5;
	Thu, 17 Jul 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ol/dfOSG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA122E3E9
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788516; cv=none; b=bRs3KDdLoD/C4BDfCjZNKxsRFAJGaJTjqhulhthR6y7AKyTRNhbLX2plHRYfR9c/XUjK/u+a4iLZ8meSATKDzgz3UTIxuFj5IPZDWd9V2VDEWI71yffSoY4yl4wO7EOsY7yanWLmilOWOve6FOf5HZqQ6lJsD24BhfXjK7s39ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788516; c=relaxed/simple;
	bh=dYT4onUuR63vQ1U/FPLFwrXmlwNIiAFoiKf8LhM8HKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx0iqEVyxZcLpJyn0tiEn+SXjjw8NcMmvs+a0D2Gnluo5LO2p47z/sU2/VYobAXBsto9qfmGC1bqViuiPlrdTX+wGITkx8CfocN94CVtbqZUtiUjGgSZOdijaJxVXJL7ANH2W3ubgsUr0UvkvihIvq6Cy1cbSwR6ZIVnXAdNXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ol/dfOSG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so1301496a91.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752788515; x=1753393315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1RVsAatRchXPNwv1tD3AMQfnAtyWtrmL8imZzj0jaU=;
        b=Ol/dfOSGhtfMsli4NMhZZNhGwqsQgXOlZYBOXOrNMV1/AF25JHkq5uHIZ53T8neGdg
         Tf8ZjJpZtQ7oqJuTinXPPn6JTKgRkxRZdGnWlvRAVkBaGtAZEffWZcm4HRjZYRK/u2XH
         4AtTLcfe5JeBQDk7U64zDHCYxnjc+BZqdagV+UC0NvfKTXswo2Y3nWy6wnXmVQyE2D0K
         XQaWR1qvM2FeYl4TEgoDVXKTM59sCfWxmauurUzFUDBYYMllMvd7JzgOkF68v7rNw+2w
         nAUmYNS/fj2wzLzEldwl6M48904GxVwmrKOnmFrnRwNssWSi8igHeeclvpzhKI9sw24Z
         Lyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752788515; x=1753393315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1RVsAatRchXPNwv1tD3AMQfnAtyWtrmL8imZzj0jaU=;
        b=Pz1iaJpEEJMaMlerThoDozdOk1iKKvAn4a9mK29FZDUhomOUe4h3rIjUR4KLDe+5By
         aEKvIiXkF37YPiZqmV1UiiVO3gFizhFstclSFe5gOOpF0QHpRLwtuc4QG/QmYsSsXwh9
         kinIVxm5/iIq1FkF5Jx7jWTE9Z/ZpO17Lf0gUEK6bVH0IxLWxRexDWqDU5mJUvjI0vGv
         Kn0+PgPUmwXPVGsK2cn+PTjEhB3GdeCdQ4oyd3h3E3yYr7SJLe36tbmsL/PGi9Qrl3Ox
         M4oqHem/95o+iGL856JC8zCUtTz9FhGFr37k5XilkKd49ygq/VdsDUXOrho8JS+Y1by/
         XoWw==
X-Forwarded-Encrypted: i=1; AJvYcCXt4I8o8eDII8tsQEBl9Jq6Xr8jGXcZPF8RCJrNXTqDab8vmxmyfilYAtMXrO8W16o8x1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGEF59A4w6Z0BpOTPJdNtNjvLKJU1A82f0X6fT4TaWxQ3w94y
	ZJoVfn9m26FhRSQleKOLVeNogwQlugPoqsrICLgf22EnG7fM9lOj22UoqBtmWGZ7XuRWxL3l3ly
	GKk2/6stI1Tu4Oi2KodzbYz0GTikNSKQVC1QYvqIe
X-Gm-Gg: ASbGncv1SKL/f/fE8BJdb4cAaXUCAsR2UdfvqMYq/z7Cibr6Mk4IRaxc+6PNT6YEdHZ
	ILOSycz/f3m8MKTzw1CesjOWE6koirxjxcKKH7s4xiX+4s4GTFH2QuDU9pkLv7zkQI7CcZiwj07
	TryC6L6eJs/BeH7YDsWTQtTFIJeULjb0V1VCXHHsvDtGxoWYXxVX5WKifJKnzobqdSi0wzkaH78
	hHPaz8wlDJBGztds6/deDzPMzmKfq9EFeGY9jbM
X-Google-Smtp-Source: AGHT+IFJ+VcxLXyyUjZfKsbth9zKtPrAaTF5y1GZg9JU7qJ47TLHsTGnbyEHLd9uXo6XsFb8DAiXJk5JvRikRWhYvT8=
X-Received: by 2002:a17:90b:5708:b0:313:2adc:b4c4 with SMTP id
 98e67ed59e1d1-31cc25e6754mr654793a91.24.1752788514570; Thu, 17 Jul 2025
 14:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717185837.1073456-1-kuniyu@google.com> <CAADnVQJdn5ERUBfmTHAdfmn0dLozcY6FHsHodNnvfOA40GZYWg@mail.gmail.com>
 <aHlqiEaG43iqUsOX@strlen.de>
In-Reply-To: <aHlqiEaG43iqUsOX@strlen.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 17 Jul 2025 14:41:42 -0700
X-Gm-Features: Ac12FXwOVNDpIK0boXx9z2Ddijuq6YU-aaoMI6hEk48L6rjvoQhda96DcILS6DE
Message-ID: <CAAVpQUD=_-rsQcva7EkkV6oqOuah+n17NZq3r05yeiE1z9N=Lw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] bpf: Disable migration in nf_hook_run_bpf().
To: Florian Westphal <fw@strlen.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, netfilter-devel <netfilter-devel@vger.kernel.org>, 
	syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 2:26=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > Let's call migrate_disable() before calling bpf_prog_run() in
> > > nf_hook_run_bpf().
>
> Or use bpf_prog_run_pin_on_cpu() which wraps bpf_prog_run().

Thanks, this is cleaner.

>
> > > Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFR=
AG in netfilter link")
> >
> > Fixes tag looks wrong.
> > I don't think it's Daniel's defrag series.
> > No idea why syzbot bisected it to this commit.
>
> Didn't check but I'd wager the bpf prog attach is rejected due to an
> unsupported flag before this commit.  Looks like correct tag is
>
> Fixes: fd9c663b9ad6 ("bpf: minimal support for programs hooked into netfi=
lter framework")

Sorry, I should've checked closely.  This tag looks correct.


>
> I don't see anything that implicitly disables preemption and even 6.4 has
> the cant_migrate() call there.
>
> > > +       unsigned int ret;
> > >
> > > -       return bpf_prog_run(prog, &ctx);
> > > +       migrate_disable();
> > > +       ret =3D bpf_prog_run(prog, &ctx);
> > > +       migrate_enable();
> >
> > The fix looks correct, but we need to root cause it better.
> > Why did it start now ?
>
> I guess most people don't have preemptible rcu enabled.

I have no idea why syzbot found it now, at least it has
supported the netfilter prog since 2023 too.

commit d966708639b67fe767995dfab47bf4296201993f
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Wed Sep 6 13:38:44 2023

    sys/linux: cover BPF links for BPF netfilter programs

