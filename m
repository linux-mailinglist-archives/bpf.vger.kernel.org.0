Return-Path: <bpf+bounces-54094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDA7A626E5
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 07:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159C1189B5FB
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC37118CC1C;
	Sat, 15 Mar 2025 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ1Rjag2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968FCA52
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742018665; cv=none; b=oZwqyCcTmQLSjdwo8N2ivALhGvgixOvgOII72OuY7IZAfFMBM10Kaz6v/iYNxKksTH/6Y8AHJ0Wo6/EFEvWAFIUT442vCrkozj5SUWOkAF43d0gn5B57VYEqO6NfYU0R3PQOI3Aye7Z1wo7fPdMMGI4s7e3nXSFoxPS/KNDV3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742018665; c=relaxed/simple;
	bh=9OykZ8eQjuM6HItjNd/1lttYj43oMYqm/rofhURGfuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YeG1LyhDWISOWSbYcsoVQkDxm1cxkDSzsZN/PPFWKT+3cv8DLtkrvLVNNW6cPJXSV4Vvtnz/u8zD2Gv9Tiv2kjlFNSNAsfWIxO4DQ5NJW1iNZZvuZJFUwrMGYCixXST5H/tc6shCoarprdHvWXSpIwKtTgGsQt0detSlxjTwWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ1Rjag2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22403cbb47fso51492825ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742018663; x=1742623463; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fct6ePNAl6YeW6zn8NV4JGp22O0VG0qDL1GJt9UIZIA=;
        b=QJ1Rjag2yY4tdblRIHt1HgK3TzZjivOYdb2ik1q08j+xsbhqCTo+sV0hfBUBhK4xbv
         hyb0z/Gjy5LEnLAPCSvPdMJ9PZF2dKOTg62+NzYpUOKE9R1g60WstMBGCda8z/ulnScm
         TRsu4EUPIWV8ABzOT2g0OOhxeClwScJ48rYC/5FStGm84vwn9L4oJVPUTnEqvsJaEGiU
         KjeyxteN7GWAwm9Wlitk60zu5LVP3DswqLxzpOV+aIV5a4knd0FLbpf1dGA8Vw5MwvTD
         LeikQ2B/bBp4yp2LPzfHOXbSNM0qui6ApRC5n9ucmSdM6si/tBVHh6B4blI2c+I7HElD
         ouGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742018663; x=1742623463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fct6ePNAl6YeW6zn8NV4JGp22O0VG0qDL1GJt9UIZIA=;
        b=rjIEYc0lOD8/BEF68Nh2tXasPcfvCfbfKKxbxspPW9qzOiVOKpnQjcm95WDpH/WXX+
         hDdc/RFdLV3DKhA/nmCES4hdjucYICyQnmdRyCYXrHTB90joiac1/v1bf7XwjYTh3i29
         r1vK2/kSBmB/YplJQMXHvbyD9namruavoPQl42ygr1txmfZnqG6TaerhVpWTSYGMU0su
         kkVtxvvPUVoFMEhchu+N7k8Dpr+qcDtPVMkgDsMeVM/3AvoqeF0em5ci/7PBJdN8k5oJ
         NjbVF/qkKyGvM4RUGs69z+nUJGoaDiys2LQYvgfaMPpayT2hsnV8G5M9aQmhiCVySyy8
         PFnw==
X-Gm-Message-State: AOJu0YzFhtWWvoOPOv+06opAxZoRWcMYZ4amJwnbFqHUM2IQecce/oKr
	T+jW84rIarRplWBwUd4ZTsSfo7FH0zyHhUVZiXPvseq/DDhHm8nG
X-Gm-Gg: ASbGncsiy2aj3iVrbCoH6IOXzZLgISAc8ePtCPWFZZqvvcERGI+NeiA8GpAlW9z9m9t
	YjYsj4HXkWyPvNHVhOkbtw7AYLPnCVnzh95ODU2ygtQb+0LlGhHCvqnfgfSPEvDIuh3X1wSvM1F
	ABh+wCwxLbYmrOVahV4b9hWyYlf0+hJOcPZ0b+R1RC1Og7f1vbuGN/MdhZ32yvHi8KW43g1jLqz
	ra+2lz+ANW1ReUGFf98qtv4PoIrI8gg4Pe4B2wQAajtEzTO7RdYzG7fzMxoM0opUytbrZBrJW7L
	I4HyVRcDcWeQ4wNySGIQxcaGVbvgOWJP+BC5XX6z
X-Google-Smtp-Source: AGHT+IGez+x3PMNE+HD/RYIGldLVLGfJDE0EuC6SmFd4JZcwFzWfuDjprnCHhqlDmaq3WQABzZG9jA==
X-Received: by 2002:a05:6a00:893:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-737223e6b61mr5062484b3a.15.1742018663069;
        Fri, 14 Mar 2025 23:04:23 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529526sm3813316b3a.24.2025.03.14.23.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 23:04:22 -0700 (PDT)
Message-ID: <bb678c4ff954f8feb3a3e47e1a2c4ab146e64d55.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: states with loop entry have
 incomplete read/precision marks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 14 Mar 2025 23:04:18 -0700
In-Reply-To: <CAADnVQKBdJsDWVCNk2LaEc7ZTPFOEeQrRgoEiio4YWFYsijkcw@mail.gmail.com>
References: <20250312031344.3735498-1-eddyz87@gmail.com>
	 <3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com>
	 <9190c8821684a6c75c524c58c6d54f7d9b2366e3.camel@gmail.com>
	 <CAADnVQKBdJsDWVCNk2LaEc7ZTPFOEeQrRgoEiio4YWFYsijkcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-14 at 19:51 -0700, Alexei Starovoitov wrote:
> On Fri, Mar 14, 2025 at 10:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Thu, 2025-03-13 at 12:28 -0700, Eduard Zingerman wrote:
> >=20
> > [...]
> >=20
> > > Which makes me wonder.
> > > If read/precision marks for B are not final and some state D outside
> > > of the loop becomes equal to B, the read/precision marks for that
> > > state would be incomplete as well:
> > >=20
> > >         D------.  // as some read/precision marks are missing from C
> > >                |  // propagate_liveness() won't copy all necessary
> > >     .-> A --.  |  // marks to D.
> > >     |   |   |  |
> > >     |   v   v  |
> > >     '-- B   C  |
> > >         ^      |
> > >         '------'
> > >=20
> > > This makes comparison with 'loop_entry' states contagious,
> > > propagating incomplete read/precision mark flag up to the root state.
> > > This will have verification performance implications.
> > >=20
> > > Alternatively read/precision marks need to be propagated in the state
> > > graph until fixed point is reached. Like with DFA analysis.
> > >=20
> > > =D0=A0=D0=B5=D1=88=D0=B5=D1=82=D0=BE.
> >=20
> > And below is an example that verifier does not catch.
>=20
> Looks like the whole concept of old-style liveness and precision
> is broken with loops.
> propagate_liveness() will take marks from old state,
> but old is incomplete, so propagating them into cur doesn't
> make cur complete either.

Yes.
=20
> > Another possibility is to forgo loop entries altogether and upon
> > states_equal(cached, cur, RANGE_WITHIN) mark all registers in the
> > `cached` state as read and precise, propagating this info in `cur`.
> > I'll try this as well.
>=20
> Have a gut feel that it won't work.
> Currently we have loop_entry->branches is a flag of "completeness".
> which doesn't work for loops,
> so maybe we need a bool flag for looping states and instead of:
> force_exact =3D loop_entry && complete
> use
> force_exact =3D loop_entry || incomplete
>=20
> looping state will have "incomplete" flag cleared only when branches =3D=
=3D 0 ?
> or maybe never.

I think about it as follows:
- We can think about our path-tracing as if it is a path sensitive DFA;
- To make path sensitivity work we instantiate each "basic block"
  (span of instructions) for each path;
- Hence, instead of CFG there is a graph of states;
- So, use/def problem can be solved on this graph just like it is
  solved for CFG, but one needs to keep the complete graph to
  propagate the marks and reach fixed point;
- When "loop entry" is reached, assuming that all registers are read
  and all scalars are precise in that state is an over-approximation
  of an exact solution.
 =20
But I might miss something important.

> The further we get into this the more I think we need to get rid of
> existing liveness, precision, and everything path sensitive and
> convert it all to data flow analysis.

That's what I think as well.
I'll get back with analysis for cls_redirect and balancer_ingress from [1].

[1] https://lore.kernel.org/bpf/CAADnVQKcOLDqwhhQpy6YU13ZbY3edGgx1XpXF5VsmX=
t9Byxokg@mail.gmail.com/


