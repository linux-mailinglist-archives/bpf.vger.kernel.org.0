Return-Path: <bpf+bounces-58638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9624ABEAF8
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 06:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6416C4E1883
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 04:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026EF22DF9D;
	Wed, 21 May 2025 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGxVesP/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343322D9EB
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 04:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747801729; cv=none; b=FSjlDv5eDZERdjFhIOsY5JtN9GA2pKafKTykJK0rX4eBlQIj36T85o2jr6TvDcAL43H+VXhetwhKa/y56VvU1ZEUlLt9wSMRJKT9p4yGeR0SIgzAJw4yA4xyla7GeAc/7tn8PiIC7cMPkmqqEeCGXsFQAUJx+cFhUmxjB0joCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747801729; c=relaxed/simple;
	bh=rC7aPFRp56kGAZuIzL7I+c0AH6LmBhz8iy35R+WP+q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idHh9GBx+8Qda/q6P1bFAqp1Vp7tVv4HvlX2s2z8LNtizDlW7fAINXNk6wCVOyygpHJYMlZhxjHRTZvw6O5jsJRylJ3c9sulNyvvp/5Cd1LN/sU3W2Yzk/O5MLAI9O225QOYWPqTwLLk9mBlkYApvWAqWwgXvhJJz/N5o8HdvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGxVesP/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8a87f0c0fso61063506d6.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 21:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747801727; x=1748406527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE+s01DccinR49vJy2RYweLyn+HO4R840h70MDC4FS0=;
        b=HGxVesP/ly24lJqk810z6Sua5abDIPanqO11yx9XsqKUQya9qvswD2WqIf8pDDXaK4
         aWjajDtjkYth130SBMAUrzl/XopJe/Syk4Xn7mryzwuR1Jzx8mfko+lAKUrhAXpaGG4B
         Vfj22hlc/kQQL3FvvzjN4ugwkO4CLmehwMeoqgyvsyzyEQyx4/b5A6SokxKjdk4xyWe5
         GeeJ9+k/nDLpUUflMe0ZPVsY0tq1kIVL7OPGAicHNvbOwnkmhX9Er5sVGVEXXrNpsoyz
         mBoFZVXK0R+LPWpyHu7BhjWTZYPE6SnAgrqy8Uj03IZnfvNBFrGC8z+ny5NROlm6I+yV
         6RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747801727; x=1748406527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jE+s01DccinR49vJy2RYweLyn+HO4R840h70MDC4FS0=;
        b=n+YGssOf8wlPB7blV8MT+VkSUHdVGXqCVRQNrT88B+ywuIbvR4Nuk0S4Gr/3UhV4k1
         0kvaPP6py92eD8GiZVBuT6nbf0oELQT3SHKONUcsB737cmVy6wRtJlb5/NDC9Tdq6FIR
         h2v0KTt+gUOddxBEc45NCfMVVnoo/6XpWoUAARwsjmPF7Db9Q4A45A8x/erEJ9x7hg87
         41+9MlmQJmHY+dg7nj8X/8x7+tnx/JiBokl6ae9BzUqJQlLXJugl6NOKPkJL22HhfjJA
         Qn0ihZG2VTcs7XQHCFoTP+oZ0DQZTFr3krcdnVhkH+/vjt5T7jUIGOhnZuYtQUnYBLCs
         IfHg==
X-Forwarded-Encrypted: i=1; AJvYcCXCv0AmJ5o0qA3SBvg1y2FeuWbt/u4nPIkSP+b03xnmj4ufweCpQ02DADsbSYQ9nI/dvFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzizsba1fozTznKns0UlHm6lZDBNFmhwta1dzhyZYt3+TPO2ogo
	861MaQk/fWCbxztpV0aj4jDEBFyDVuKKPKgChK6p5foCAvFt9QbIz9SlnV4wglFbxPsaq3DTLC3
	oB0LB5C1KKR5Cd3F+wDSC9B4+uVLEPeQ=
X-Gm-Gg: ASbGnctdXWKM3YZxbCymQ5iO53Dv0FTf7nT1R07X33iVkDkaBNknlUDhwRMMwxgazHf
	ev8thtYIyMYHrRMBI4rd7eEkhFuXcHsS9JHG44aeos/Fr+ZI3uDewrrqz5ALVaHI3x8rZGGw4vO
	lf7b/oaoEsXdVl5l4kAbpcgNhk+63OApB2ZA==
X-Google-Smtp-Source: AGHT+IHT/SSNN7DKcZkNza7jUsEL1rq8UaOlE9FpXkdns53FR9CMMY99/4sCR2U7P21T5j0e+CHkTTR7dgMJxthW9dg=
X-Received: by 2002:a05:6214:f29:b0:6f4:b265:261 with SMTP id
 6a1803df08f44-6f8b080f7e7mr360771636d6.8.1747801726829; Tue, 20 May 2025
 21:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
 <aCx_Ngyjl3oOwJKG@casper.infradead.org> <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
 <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local> <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
 <a3dfae27-2372-47b7-bc67-49a0c5be422b@lucifer.local> <aCyU7Q2DhPPF3Oau@casper.infradead.org>
In-Reply-To: <aCyU7Q2DhPPF3Oau@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 May 2025 12:28:09 +0800
X-Gm-Features: AX0GCFvEYBCpG5ieUqLgW7G-4T53eX0Vl0ZmrBW1VnRhKy_dwQL_lAIxVIqTVu4
Message-ID: <CALOAHbBTretjRExbBj7YSvfrv531jhqmaB6e-=yv9nTn0Chaeg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Usama Arif <usamaarif642@gmail.com>, 
	Nico Pache <npache@redhat.com>, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	gutierrez.asier@huawei-partners.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 10:43=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, May 20, 2025 at 03:35:49PM +0100, Lorenzo Stoakes wrote:
> > I agree global settings are not fine-grained enough, but 'sys admins re=
fuse
> > to do X so we want to ignore what they do' is... really not right at al=
l.
>
> Oh, we do that all the time,  Leave the interface around but document
> it's now a no-op.  For example, file-backed memory ignores the THP
> settings completely.

This essentially invites downstream kernel developers to implement
their own "file-enabled" solutions ;-)

If you haven't yet encountered reports of file-backed THP causing
performance regressions for specific workloads, you may be missing
something. Our testing has confirmed performance degradation with
certain HDFS workloads, even on the 6.12.y kernel - though I've
prioritized discussing BPF-based THP control with you over
investigating those specific cases.

> And mounting an NFS filesystem as "intr" has
> been a no-op for over a decade.

--=20
Regards
Yafang

