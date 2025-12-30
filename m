Return-Path: <bpf+bounces-77497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D906CCE8783
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 02:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20C73012741
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427842DE717;
	Tue, 30 Dec 2025 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exCcTz3Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E22DE6FB
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767057224; cv=none; b=kLxgMweBoDgKa+l3UvYhee9Sj3Aa4CSkBVY2dnj0ZgjHq24NHMF5PAm5I+mK42agHgB9+5xM9MVpQlzUCtqZtzHbiCyLS5Nf2Py8Y5KcoZQNmxQn8OVfU/bTi2WxbtBYsqN2/fcVe22oTvuqgbNEtJjrWcL6/K8yo8eInD4iK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767057224; c=relaxed/simple;
	bh=sa7qLQI5q5Dm3mJbGTVc8XdUtcmibzgwcnRtQlAfcts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAMLOGnZ8bmwxURwWAXq9KLIpQqi/wtoVdKxwqkvn6VOJ6gl0m4T1vwCxYKaoHys3pTotZpuCnT+RLOTUNECt77PU0wrx1mJy+LcySsGAHJ0mDMKio74DynrwdCjBld1DiezLFwGwFx6rrjUtyLCkgVbimbqANrY95SkK/EJw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exCcTz3Y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a110548cdeso132719675ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767057222; x=1767662022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WYWIQM1Og1s1JCoAfx8pw7//2VEw3HJlAFb3SG9XsHk=;
        b=exCcTz3YIIiHJOHKDuN+cGFAsWn0DhPOwrdps5bGe6fmxw+EeHsxDi75vs9aQAlr7y
         YLAzQt7apvQvaPXOc8bYUKBX7Cy2HhiH8+/7K4JEys3bsCf/ZbCiz4z0RiAsUB2+f1Lt
         z6LZ/a5tDy1tLnoBCk8uNeds5Pz5BL6RjKdMxxAADb2ekcVBNsW7F6dq5M9ItUd2ZEgw
         4k1ZH5J2OjoXzqxbnzEhXq8nneEe6pREOO8/YoFMi1uV6iE9B/9dnMx5DsYYweLVdJCz
         c7VM1hSuCTKodizpAaaHptDLWOiu0WEd0m9MqHWrA1mrNFDhkhLsviuDbwnmkZY9LPD0
         oS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767057222; x=1767662022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYWIQM1Og1s1JCoAfx8pw7//2VEw3HJlAFb3SG9XsHk=;
        b=Hheb8ciyoye28cuyKgGojl213woP/XNIGPY0e5Y4ni05S4+NdoLqDedaq8AIn3euS1
         /g9DvMl1SE9DmlitnQNqB4TtvEJ4b0z/9rwqG9nHrRB3uVa7045+e8z4UNbPGSwXE4mw
         cD+Xh577Yzycr0/Q7KW3JRRnlnPR4/5Zrjw/M9+s4ymgvAZal9LV3FOYcWOjaQyD5bcZ
         QfevZe8ztr+d0z1AtJgNh2rAfY1l16iIoHNsgBNIrJa78r5uv2GH2EXDRORT66bb8eh4
         n1osueu2IAddaPWTlAfGF+SJgHWLSkPenWVbQkdSTjYlVAobzLI/47vlAYG6TuDl2d/7
         /5eA==
X-Forwarded-Encrypted: i=1; AJvYcCUf8ZL43nBQXDJkG+/L+Un62N5PGjAGP5paYJNvZ/nWRIDC6J+z45PUQXytvI5VAQcn/RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCcFVdigEt/+5rWro+yxHZUJxw1BZJzwNK5t380KSOxepNoIND
	K3rnNemdqWXhpPEtSMmrSeE6XXbvToSTEQ3MBMQOf5Yt4TJz6wu51hbt
X-Gm-Gg: AY/fxX721rmQES3MwWBfB1FLbg9qqEkZGfKxGI2K7+S6LRfzGuZ1gqsfyEmsYVxd/9N
	TJbIcM03+UU5NLqMCT/37GoJ/eFLKHKe/29a35kc8YyWOciHa4rX9qITBk/caHAECdkzdubArmB
	5TCim+5qRKSgf1pWWZslsTJRMRseqWsfdFa32wHroacQSbAcR40dUYeMqN/Gxab9YhogvkQ3i2Z
	WZdRcNltylK9lOqHMifW/Befm5Pi3JXA48qmhrsrNak3ImCgO8msBrCfVr7PWvULoKTYcFmBJCf
	laDLqLtDaiO+aBPqzEZz3YQ94Yuxks73fwqT5AoqNHYQdJj7B2GUd8YH+yFc7WSSfJTlrNV/Yh5
	eR6RCUhmul4Bwh7Ls/E1dC0KF3lEwLpf/4EDyqp12McbMsbA3tcgt5AU7TMzykohCO5JNA3VolN
	IfhOthvipf5d1zAX1UgCEv4N33zUzIZjk1DUdwma5O316sOOI=
X-Google-Smtp-Source: AGHT+IE6mqbQgA7uzu7rDp2aK+RuMAZGHFL8WZz77h4FNUQklejhaqD6TgN8G1EKI7983eo7YVvZZw==
X-Received: by 2002:a05:701b:251a:b0:11a:436c:2d56 with SMTP id a92af1059eb24-121722abf57mr21646958c88.2.1767057222364;
        Mon, 29 Dec 2025 17:13:42 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac6b:d5ad:83fe:6cca? ([2620:10d:c090:500::2:1bc9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm127521342c88.0.2025.12.29.17.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 17:13:42 -0800 (PST)
Message-ID: <62ba00524aa7afd5e1f76a5a2f4c06899bf2dd64.camel@gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers
 print
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mahe Tardy <mahe.tardy@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Paul Chaignon	 <paul.chaignon@gmail.com>, shung-hsi.yu@suse.com
Date: Mon, 29 Dec 2025 17:13:40 -0800
In-Reply-To: <CAADnVQLsJeSjwFVE=gcnVzh7HftDqZJM+xByr2cD6TRmTRGLsA@mail.gmail.com>
References: <20251222185813.150505-1-mahe.tardy@gmail.com>
	 <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
	 <aUprAOkSFgHyUMfB@gmail.com>
	 <4eec6b7605d007c6f906bf9a4cd95f2423781b0a.camel@gmail.com>
	 <CAADnVQLsJeSjwFVE=gcnVzh7HftDqZJM+xByr2cD6TRmTRGLsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-29 at 16:42 -0800, Alexei Starovoitov wrote:

[...]

> > Imo, it would be indeed more interesting to print where checkpoint
> > match had been attempted and why it failed, e.g. as I do in [1].
> > Here is a sample:
> >=20
> >   cache miss at (140, 5389): frame=3D1, reg=3D0, spi=3D-1, loop=3D0 (cu=
r: 1) vs (old: P0)
> >   from 5387 to 5389: frame1: R0=3D1 R1=3D0xffffffff ...
> >=20
> > However, in the current form it slows down log level 2 output
> > significantly (~5 times). Okay for my debugging purposes but is not
> > good for upstream submission.
> >=20
> > Thanks,
> > Eduard.
> >=20
> > [1] https://github.com/kernel-patches/bpf/commit/65fcd66d03ad9d6979df79=
628e569b90563d5368
>=20
> bpf_print_stack_state() refactor can land.
> While the rest potentially bpfvv can do.
> With log_level=3D=3D2 all the previous paths through particular instructi=
on
> will be in the log earlier, so I can imagine clicking on an insn
> and it will show current and all previous seen states.
> The verifier heuristic will drop some of them, so it will show more
> than actually known during the verification, but that's probably ok
> for debugging to see why states don't converge.
> bpfvv can make it easier to see the difference too instead of
> "frame=3D1, reg=3D0, spi=3D-1, loop=3D0 (cur: 1) vs (old: P0)"
> which is not easy to understand.
> Only after reading the diff I realized that reg R0 is the one
> that caused a mismatch.

In theory this can be handled in post-processing completely,
however I'd expect mirroring states-equal logic in bpfvv
(or any other tool) to be error prone. Which is very undesirable when
you are debugging. To make post-processing simpler I'd print:
- state id upon state creation
- state ids upon cache miss + register or spi number.

This way post-processing tool would only need to collect register
values for state ids in question.

Idk, not sure if any of this should be upstreamed, I'm fine with it
living in my debug branch. On the other hand, this might be useful for
people debugging 1M instruction issues, as I discussed with
Paul Chaignon and Shung-Hsi Yu at LPC.

