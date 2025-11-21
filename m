Return-Path: <bpf+bounces-75262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 27519C7BDBA
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 23:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE47B349376
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED023909C;
	Fri, 21 Nov 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buKTnOaG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9B36D510
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763764297; cv=none; b=TYdxDp+C9BPFs3nuifvTr1XcqROB//3sY6gL71FMetdumtrOJifM75oydMwcXCsOybpMU+ryRoQoHl8++S1kwCDIOnIHFtE0lX0MhsCHf+XKJ7/BA/V3LqWypNcYuiutRka5rCyUCah4kjFVl9swIGdhsKP/7lEacLQQF7vdiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763764297; c=relaxed/simple;
	bh=64y6hnlFNxWYp8GqUcUIhWdBRcpZ/ex/JGt4M0wZlUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eePZIT3Zkk1cKaq7m8QEyx7VCB/YhrRApWOVT2BhkMtNycPfpdhkJH39rLtOTlq5Q7coeUayg1afa1d/3H/t1Ni7frWmCSDnZO9RpaU0F/ktWO2mpwGg55CWqo4+JbvF0V9RE7T1YUGXAxWepDHnOhUlZ0b3AZ/m0V1xlSyoi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buKTnOaG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so2726134a91.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763764295; x=1764369095; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=64y6hnlFNxWYp8GqUcUIhWdBRcpZ/ex/JGt4M0wZlUk=;
        b=buKTnOaGwrPz7KOYBCam4YfSgkP10KJ1UCzBlVfSMKIgjkJh6TthDFJ/JnOwgppLuI
         KqwPdeWBn/8vnX8FtVdjzJ1U0ZrIejlt3urCi66jcBeSkfwOWSnyDAWNTtWMputd1fNi
         hdnOUp0WL82DA7JHnk6WQ6SPTQoGPrBQWr4GxrFCNoU7tilxRhdRkbBujMzoDPuX1LjU
         inE97ndrbZ9s524r/PtjrRBQ1V1S9yNCpzh4hTi2B8h4LZZX1E39EGtajWXrN/jYmBnR
         nMYbiAts8BD67VtrnZFc/ts1I6CIUe1zy59K4mfa101Jisv9XtzxeieuVPg5GV4q47oO
         8lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763764295; x=1764369095;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64y6hnlFNxWYp8GqUcUIhWdBRcpZ/ex/JGt4M0wZlUk=;
        b=Q1+r9/jWfWnyE4OQ6JUG5Asa7URZ256gRQ4PLqO3R4mTHXPj9x85zVoBFsz8m7S+ub
         vCafDl8hCS6jbTo1S53UKGudZjSO5EIk0/ukYjNddanVXDPjmTw0bt48gqvoBQuOXZy3
         CON4ZsCqq/57I9BgfoGRQorc4/ZgS92No9WCEiqlvxURB4I6We1Bz+xRLCS1iSmaGAR7
         R8VQADj+DwVrrs4xwBdt+tIvc2CudRGBWzzLLi1C9AibZ6BVKqEVHgeE77BNMdYNrtC1
         lscukRY2k32DE8K0WLH5/3iIBABy68sCl/gmFYh6YmnXAyBo6MVwl0Au3fdCifMLf79o
         +W+w==
X-Forwarded-Encrypted: i=1; AJvYcCVGlW502LRPenETwYh1EvPAyJmSdC/qz2rg5l/Ulh7DxEew9KNJd+39CNem8zlyeKK0rVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4QY7WKXHW1WHzELNwkHlxPg4nTGEclelaLQkslrWwYOssPyj
	sHQIb1hppDzACr1bR0Su5KWJdl88wyB0L7FuYWin/Z/i6/ftLI51SRJk
X-Gm-Gg: ASbGncvukWZjQb7s3KrGTtV8kQxjLY3D+lBc5fP5qPBFfN0clJDtILqIlItXaywCXEN
	TdsjzB9dn9zs+lc+3IlIDSnq1uU7IvAGX1G7Ngj4ENsi5rKPtE0GTsO2JRjP3qWfnGuXRnFan26
	iWgWTP2LMuldvTSubkC9PsnXGusw93Z0LwORccl7fLgTNo6Y0V+B2MU/EdrQRECgHbOEtSlIH2J
	vcspd+SCIkJy3XgfWsNWxOSs2RIkpTQfg657EV6dT5YCB/D+mirohpfhRji0JhHpLMFlJ2rsE8t
	/gfsi+WXz+fAQCM+ZDeUaZlx/BWcn9gbqxhaI8y+xcXzk3bvSy3viCl/Q9E3YCNfra+Pjaqixq+
	Yc+katnCMyMOvTfsDRa9brVtvKcIro8dvEztk9+knZgxWirTDKh+sUdPtJOhFwzL6iiYO5XwnHK
	dVtpjRYi4=
X-Google-Smtp-Source: AGHT+IF9hZBovdrqb1icHAnmUe34TqheZmkkY4d1B7+2a8o5HzwDBj0eLKUyeCcoopFVYz9m4yW0SQ==
X-Received: by 2002:a17:90b:5112:b0:340:f05a:3eca with SMTP id 98e67ed59e1d1-34733f0c7c6mr4537279a91.20.1763764295159;
        Fri, 21 Nov 2025 14:31:35 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7e08fsm7073061b3a.10.2025.11.21.14.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 14:31:34 -0800 (PST)
Message-ID: <13f7a40c5a089207d7c4a7e1ec0cf568ec66dd67.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add debug messaging in dedup
 equivalence/identity matching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org
Date: Fri, 21 Nov 2025 14:31:32 -0800
In-Reply-To: <6a41d047-762e-4c03-8959-73f497445535@oracle.com>
References: <20251120224256.51313-1-alan.maguire@oracle.com>
	 <37e74a8b398b8fc69797ddf16b21f21282ab0a3d.camel@gmail.com>
	 <6a41d047-762e-4c03-8959-73f497445535@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-21 at 22:11 +0000, Alan Maguire wrote:
> On 21/11/2025 20:52, Eduard Zingerman wrote:
> > On Thu, 2025-11-20 at 22:42 +0000, Alan Maguire wrote:
> > > We have seen a number of issues like [1]; failures to deduplicate
> > > key kernel data structures like task_struct.=C2=A0 These are often ha=
rd
> > > to debug from pahole even with verbose output, especially when
> > > identity/equivalence checks fail deep in a nested struct comparison.
> > >=20
> > > Here we add debug messages of the form
> > >=20
> > > libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent =
but differs for 23-indexed
> > > cand/canon member 'sched_class'/'sched_class': 0
> > >=20
> > > These will be emitted during dedup from pahole when --verbose/-V
> > > is specified.=C2=A0 This greatly helps identify exactly where dedup
> > > failures are experienced.
> > >=20
> > > [1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@=
oracle.com/
> > >=20
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > ---
> >=20
> > Lgtm, but maybe also add id1/id2, cand_id/canon_id to the print out?
> >=20
> > [...]
> >=20
>=20
> I experimented with that originally alright; problem is the ids at the
> time the message is generated don't really relate to the final ids in
> the (mostly) deduplicated BTF. As a result I figured it was best to
> stick with type/member names. Thanks for taking a look!

Oh, makes sense, thank you for explaining.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

