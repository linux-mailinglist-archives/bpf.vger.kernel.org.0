Return-Path: <bpf+bounces-72597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166C4C161BD
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA41A23936
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471AF34AAF8;
	Tue, 28 Oct 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGuRx9Na"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30F34A766
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671931; cv=none; b=sEqg4pct4IQ5imqJYImj4Lv8MsB1oB4uN3IVRf1ukARbEKFgK8LfzFoZyr5bvbiyou9pXFRC8SVUoMinE9jb2gaH9DDy270PURY+r4csfltKjLYpGscB5uKuBqVotI+wLV1epNh1ynfGltGrKljFA3id7iakCJJfyJJPCKWLaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671931; c=relaxed/simple;
	bh=UYwxvkY2zdm/DyH3ka2ma9lDVPuQqvHwI04Qpd7l7vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqifQrnNMSTOKgTgRhOBaNSmLMne2EhCVxykLdYqncwnLd1z7ChC8Utd19xo51pnkx7y2kB1GCAUCYXJrBmDNqLaUQ3uy+Z7CsEIEu/H2oqI2Fl8W3V7ET0soYoo2l6LDpBEZA1i5yVhsB5oWGMS3kNQMXsjkmp8zkUKOgFkKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGuRx9Na; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290d4d421f6so58759895ad.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671929; x=1762276729; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D4n1AXwmY/rwCKDx/cQZwkmGhjBWLLIwBisORqaR6Wo=;
        b=bGuRx9NaTGJ62kAPYH+q5pqRoO0ej+L5PiwZYUnuW43y6S9i5KN7+nHFW6oZc2wOu4
         FZlibd73IiEPZfuvWpSTm/JaNqBHfFLzzIdATnRmA06gSLlNRFGzaqyOInGITFI5B6yB
         CE4f8ONvwmarcuUW7HGLq5pVFaTwAHkMOWN82IvZfegT0XYAuJI0wFXa5DGDQoKfQrtS
         bSCAvXWtgE55awhMVG+hrlQ14Grt8+X8510FipZNE9RuZhKXlJ0BU3R3RZHGNCa4N7Ka
         7CGvYSRl8/q/76q1JbyGooGlGkAdP0vuKPwG+yIsoMS5eNE6ib2ckN0PQ3nLBIgDUmc+
         TBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671929; x=1762276729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4n1AXwmY/rwCKDx/cQZwkmGhjBWLLIwBisORqaR6Wo=;
        b=ihMnX0TV4bxyRFqlLfqPBAS9kGHqV34esXAM70zqpfp5tr6H0041p+xFZ9scJsTJsv
         ZBG0wGY+w2Y6gkLKSKjyHCHw7NPDZd+pi4zwnHNKZM8ZV+nSSNDYSyoFxaLSHeqWyzyQ
         mCOCWBp7PyNnAac8bm9lKfj8Yom+C2fcLvg26jdqh9wkL6ZzQuwL9cQ9EJJx33wmLPAX
         q1X/HByBtjNgoohHM39p3iB2F5+UK2LVNi+L2WCqj4JSLfov1xRne/OtZHcNl20GIgNn
         +qnRP+ghCcQsuLvUjPqgEkrsMO+jo2NDScD6/NLHdUqM6jXXyj8kcZrrQy+zdd3ua2ED
         FkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4DQgRpriZBijDyu67I+7oCr5bMTDe9YDc3V/GusPva+8OIgGk387wDU6ozimFh3n65xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjHoKEb9Jd2skVLP1IXyAQIEuNSSJzcpb3pU+oE2B1kH84Sbc
	Sa2PiMUJ6po0dpNaq09Mhqy0yDfV4FRHrex2LOIVkZlv5BBrYbyNcAzt
X-Gm-Gg: ASbGncsFz7rjPfnU1XGGS3qLlKV7sekNU+FWfA7TGYZIMA55r+ecWX/2KG6qDxJsnjg
	XYc86BAJgPyekqVyezAnTSxt0Po3p45rQqu8AguQYsXjxO8RQjcp0BviQU5Ss169JKt/xjbAg5+
	BwY3C1FUy7RxI3mumXS+11qVa1BvLClU4c+237ke7T1FXfHumD8ElFgqPTOhvTPLiQoBqNFkJ9V
	pIiFXA1H+rR7rL3jM5qK9NTjP+pYigy3ZNBSiL9Nb862BFjj8zhJNMQDomH9cvWH7HcHW6gvYUP
	y0gQcX5wZAeBMVp/M/zbmEE/36jQl4/KF/0ksosU+p/ojLMn83RG+FBdtnyZRLcVobIkHrkyVcs
	VhpPw7pkSE6TmDa6qOEuiiyzZtJ9WhCDPIKKkPBdHcH8o4fn8+ZtC/N6ZIKfj/pVy3Br8DjRXbh
	t4U4MCm/bmvob//W8qp9taNABcjuBoGYl4T+cp
X-Google-Smtp-Source: AGHT+IGzWUp6pB0RrxfOplxKt3YLhG+4AtzqD0EnJQYft/iHYC0j5K1snUzrTanQqB8W/931TN3xVA==
X-Received: by 2002:a17:903:1c2:b0:27e:ef09:4ab6 with SMTP id d9443c01a7336-294cac96c6fmr55866035ad.0.1761671928527;
        Tue, 28 Oct 2025 10:18:48 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3f28:abaa:8fee:bfa5? ([2620:10d:c090:500::7:f7b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0827fsm121791055ad.31.2025.10.28.10.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:18:48 -0700 (PDT)
Message-ID: <bf1de6a8291d2607b8c77674af899551607bdb79.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix tnum_overlap to check for zero
 mask intersection
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, kafai.wan@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	shung-hsi.yu@suse.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org
Cc: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 10:18:45 -0700
In-Reply-To: <da8e2759ad57dd96dcc722cfd781141b045ee718df316cec8705e2908e0cb948@mail.kernel.org>
References: <20251028151938.3872003-2-kafai.wan@linux.dev>
	 <da8e2759ad57dd96dcc722cfd781141b045ee718df316cec8705e2908e0cb948@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 15:45 +0000, bot+bpf-ci@kernel.org wrote:
> ```
> commit 16cbc4520eb13d2065d145c76b97fb93035d81e8
> Author: KaFai Wan <kafai.wan@linux.dev>
>=20
> bpf: Fix tnum_overlap to check for zero mask intersection
>=20
> This patch adds an early return check in tnum_overlap() to detect
> non-overlapping tnums when their masks have no overlapping bits. The
> fix addresses a syzbot report where the verifier failed to recognize
> that two tnums couldn't represent the same value.
>=20
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
>=20
> > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > index f8e70e9c3..1a75b7c9a 100644
> > --- a/kernel/bpf/tnum.c
> > +++ b/kernel/bpf/tnum.c
> > @@ -163,6 +163,8 @@ bool tnum_overlap(struct tnum a, struct tnum b)
> >  {
> >  	u64 mu;
> >=20
> > +	if (a.mask && b.mask && !(a.mask & b.mask))
> > +		return false;
>                               ^^^^^
>=20
> Does this logic correctly detect non-overlapping tnums? Consider this
> counter-example:
>=20
>   a =3D (value=3D0x5, mask=3D0xA)  // binary: value=3D0101, mask=3D1010
>   b =3D (value=3D0xA, mask=3D0x5)  // binary: value=3D1010, mask=3D0101
>=20
> The masks are disjoint: (0xA & 0x5) =3D=3D 0, so the new check returns
> false (no overlap).
>=20
> However, these tnums actually represent overlapping sets:
>   a represents: {5, 7, 13, 15}  // 0b0101, 0b0111, 0b1101, 0b1111
>   b represents: {10, 11, 14, 15} // 0b1010, 0b1011, 0b1110, 0b1111
>=20
> Both sets contain 15, so they do overlap. Can this cause incorrect
> verifier behavior when is_branch_taken() calls tnum_overlap() to
> determine if JEQ/JNE branches are reachable?

This is a legit bug, please address.

> >  	mu =3D ~a.mask & ~b.mask;
> >  	return (a.value & mu) =3D=3D (b.value & mu);
> >  }
>=20
>=20
> ```
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> In-Reply-To-Subject: `bpf: Fix tnum_overlap to check for zero mask inters=
ection`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/188801=
08453

