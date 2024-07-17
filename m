Return-Path: <bpf+bounces-34970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B17934506
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 01:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40C91F22450
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139753362;
	Wed, 17 Jul 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXeQDQQe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10079D2
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721258671; cv=none; b=SVsrzsTn2i/SwMkfmVByWanqrFzRSLZA2mKtYEi6jus8nbYjXiUdDBeNFaWCy2azwbTtJR+nyrJSfD5Y9xkjR7pvy8nTzEdkeIDoCT5/L1L0KAg+uG+98s5zrp6y1OKw6Dzster13Et57JQxtWQURQBAhFY2IjjXQBSg8WEERB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721258671; c=relaxed/simple;
	bh=demEjO6sWIZYq359j4EKHYB2e4cz3jsTVPfwIicDff0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rl/EP3+Xr9ifdoRZ+RIUO0UdneTC4kVJudMD3DlfrSg0BDs9epUTLYBk3Tj2IkDNrZAYIeDc2e1jjtxhcxihR5sSUSJgR8jUzmDphJ74G2NExZj2SOddpGbuF4Srd7keOdWZ0EdU4zUpdy1IuisnDLms1fTXn8dvBW4KQK0QIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXeQDQQe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb585375f6so155718a91.3
        for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721258665; x=1721863465; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YffrxvWWNyE7MJbioYLD6/xJof3k0AnU7a8Gie2Pax4=;
        b=RXeQDQQeHbpmEAlNGwheOshzyWHliANfvukadwhhqIsX+Fta0V8sJFP2HhOVeiu+jW
         7HG4c4UAvz73PsGuWoHffAE3FsPnBd2+kbnW4w9bqW323LDiov5UHjcSJRxq5T6Jb8b1
         AAd+9r1iE5u9WMw5qh0b+ziiNWwdC8RxQENBMMkSOarCWxhppYP0M0DK5MMyT2Bpd3rq
         nnwLq1NJcWJ1a3V1fOsz1sUY+q6yUUMn+UlH99I59QxvS2OW+GO/Bfj2NvpSyOj/yEYZ
         ddNC/Dxv9o2x/5LDK4t3ChTnwAzwrabG3/pD1+9ASVDz+hymMMcs16dmF5LT8aYVHH2h
         9Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721258665; x=1721863465;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YffrxvWWNyE7MJbioYLD6/xJof3k0AnU7a8Gie2Pax4=;
        b=xRpd2xtQ5vSdg2PpMwAKoz98PlT1LwupWoHyVDaDiBDklACsXiiEZS92Y0IyQZbm4k
         23RcwWbhdkB4dKYMsTchpj+QdN/N2uLNpdR3yv1c91xDDfp2mMhUFp+tpi0A+D7ZAa+A
         NJ+8sgHgzF/2bgC9MZYiCLYbksyiXbpUuaMiq36YshCNGrNZvJlpiH8LECea9mRiUQIE
         B4GByLSf8muzkudd/bAKhIZ+CtJ+Md/QoQosNyjhEnJQZfxNIj/mgH5o9mEefGSy30ae
         zxi/wChi5I/ULq/pvBQ805G0Zwyf98U5Y89CNLP9i7zdxO9+T6EjKLZlGliVXCO/Jpxk
         oOaA==
X-Forwarded-Encrypted: i=1; AJvYcCVKk9jv4Ub0lKek9xUt5CaOu8DkdQZkMmk6Gtgg0rVyg1/eG+o/j2sbaLXSC9mfnqwNmwf3xZntmWingLHwQzFd+rAS
X-Gm-Message-State: AOJu0Yzvk38A4EKEKYYad4OeKPYqH8EbVy6ORTeuBXtkxRtHyg33Ou3I
	WzirjBR5rkwm5NfYYdlT1gW5ifco84GpvDkup9j5lxxwDPcmHwX+
X-Google-Smtp-Source: AGHT+IGakqofwSvaXnCRDkB2axvHHjHwGt3qKfJ853+XwMdg+iqud+rK9MuQdBi5ay44StkwgOCnNg==
X-Received: by 2002:a17:90a:b885:b0:2c9:a151:44fb with SMTP id 98e67ed59e1d1-2cb527a585dmr2578081a91.22.1721258665019;
        Wed, 17 Jul 2024 16:24:25 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb601204easm523068a91.25.2024.07.17.16.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 16:24:24 -0700 (PDT)
Message-ID: <e33b186a5f728a96987347964a622cab64543189.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for
 test objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, Daniel Borkmann
 <daniel@iogearbox.net>,  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>,
 "mykolal@fb.com" <mykolal@fb.com>
Date: Wed, 17 Jul 2024 16:24:19 -0700
In-Reply-To: <CAEf4BzaLatHkXGZ5pmNSC+b5_iZKBeeGqkS-VE8SwXQySviUHg@mail.gmail.com>
References: 
	<gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
	 <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net>
	 <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
	 <4d757f19ac6f7e17da2e87f482f129e75c6decf8.camel@gmail.com>
	 <CAEf4BzY4kXRSci3Lb6ZFT7++6fics-w4_8rYMB4vCEHgrCWEnQ@mail.gmail.com>
	 <b97340645b9a730df46e69b03b3ccba39816c414.camel@gmail.com>
	 <CAEf4BzYFad_hhk+ju1_Y+JeDGmOeD-Ur=+Yvfu2vkbR3frR6SQ@mail.gmail.com>
	 <k7SpuAM7weZyfgdgXEHzOiDkk8iBsBrl7ZsTpvhKQNvijS8cWjJrBN9DVOxF45edRXxA2POvIu9cZce3bF2FmoFOEbfevr09X-1c1pKgZrw=@pm.me>
	 <CAEf4Bzatg_CsKf7HeekaO3ZroXWg1ceJBgZ9KPWf2VkK1yKQ6Q@mail.gmail.com>
	 <bcee1451ef43fd08675e1296b1ce82058cd29d94.camel@gmail.com>
	 <CAEf4BzaLatHkXGZ5pmNSC+b5_iZKBeeGqkS-VE8SwXQySviUHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-17 at 09:41 -0700, Andrii Nakryiko wrote:

[...]

> > I don't really see a point in migrating tests to use skels or
> > elf_bytes if such migration does not simplify the test case itself.
>=20
> Hm... "simplify tests" isn't the goal of this change. The goal is to
> speed up the build process (while not breaking dependencies). So I
> don't see simplification of any kind as a requirement. I'd say we
> shouldn't complicate tests (too much) just for this, but some light
> changes seem fine to me.

My point is that we don't need to update *any* tests to get 99.9% of
the speed up. Thus, the tests update should have some additional net
benefit. And I don't see much gains after looking through the tests.

> > By test simplification I mean at-least removal of some
> > bpf_object__find_{map,program}_by_name() calls.
>=20
> Some tests are generic and need (or at least are more natural)
> lookup-by-name kind of APIs. Sure we can completely rewrite tests, but
> why?

Sure, I meant the tests where the above APIs were used to find a
single program or map etc, there are a few such tests.

[...]

> > - by adding a catch-all clause in the makefile, e.g. making test
> >   runner depend on all .bpf.o files.
>=20
> do we actually need to rebuild final binary if we are still just
> loading .bpf.o from disk? We are not embedding such .bpf.o (embedding
> is what skeleton headers are adding), so why rebuild .bpf.o?
>=20
> Actually thinking about this again, I guess, if we don't want to add
> skel.h to track precise dependencies, we don't really need to do
> anything extra for those progs/*.c files that are not used through
> skeletons. We just need to make sure that they are rebuilt if they are
> changed. The rest will work as is because test runner binary will just
> load them from disk at the next run (and user space part doesn't have
> to be rebuilt, unless it itself changed).

Good point. This can be achieved by making $(OUTPUT)/$(TRUNNER_BINARY)
dependency on $(TRUNNER_BPF_OBJS) order-only, e.g. here is a modified
version of the v2: https://tinyurl.com/4wnhkt32

[...]

> > I assume that the goal here is to encode dependencies via skel.h files
> > inclusion. For bpf selftests presence of skel.h guarantees presence of
> > the freshly built object file. Why bother with elf_bytes rework if
> > just including the skel files would be sufficient?
>=20
> see above, just because there is no guarantee that we use all the
> dependencies and we didn't miss any. It's not a high risk, but it's
> also trivial to switch to elf_bytes.
>=20
> another side benefit of completely switching to .skel.h is that we can
> stop copying all .bpf.o files into BPF CI, because test_progs will be
> self-contained (thought that's not 100% true due to btf__* and maybe a
> few files more, which is sad and a bit different problem)

Hm, this might make sense.
There are 410Mb of .bpf.o files generated currently.
On the other hand, as you note, one would still need a list of some
.bpf.o files, because there are at-least several tests that verify
operation on ELF files, not ELF bytes.

[...]

> keep in mind that we do want to rebuild .bpf.o if libbpf's BPF-side
> headers changed, so let's make sure that stays (or happens, if we
> don't do it already)

Commands below cause full rebuild (.test.o, .bpf.o) on v2 of this
patch-set:
$ touch tools/lib/bpf/bpf.h
$ touch tools/lib/bpf/libbpf.h

[...]

