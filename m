Return-Path: <bpf+bounces-58361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E71DEAB9135
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1AE1BA7E92
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2E289800;
	Thu, 15 May 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PawM7Hog"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB951E7C03
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343474; cv=none; b=cOGXVldiaOMfzWUb33q5PBgNS7CR7k7lY2jx4J3Y+sG3UdH0l8JSjIkaXAs1KHX3YyZy2HPjYatj0zn6FspGjJCSBAr1hzkBzEGIYjPStaCLpFaxetDnvx8FDeOKs3ZSOnWmlH7iRwtvv+IZYBq8yNNTN+0zTGsJ+dCMsvvCUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343474; c=relaxed/simple;
	bh=I3Ox2s40D9MFXRJYqyM+lsxanTz76a1Go1tC/ApHPIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIyNQQiPh3SMj1h3E2XaXcgQsBHpqKCPzE4nADSRE2RBc4+5aSTPpuYx9SW6j32JjpRATuPf3A2nnYtLdDhz1bV38PVV6QIa/IQ0rM6aqBCjwJ21FoSECVe3Q0tyovvUhOYBuqKlRawa2i3sWM8Oq42NtR2iNpwjBd0ikpDYHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PawM7Hog; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30ac55f595fso1422577a91.2
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747343472; x=1747948272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jMlAOrZvviDpstgwBb3kxQ9OMj38eA4jIUVi/7T38M=;
        b=PawM7HogeT1Osx/M2HmSQ/RaA3VfNvKUqsT+8+D5WRJokmZ99lTbVnCLQoHx8UdBMS
         PP8zGM+py6dpIZVBSTssAvdvYefC3ZsSHUfszDapVzyvLpGRUIvEreRhyLmWva3NdZeM
         wSyk4RvPci4e8bedx6h6i1+GqOWJGBBmOybFx0j26T8314t7hIDUvHVJOh6GnowtQYpe
         XMlB+qhCA0K8d7t231pOFGRvv2a6lwmBQWt1AHH+WxA23EKjpKCjsVBguVEtO3DmPabg
         8DX6by0CiF8ybBcGQoj9sgCD3GzdrR5Vq/snZHzO06kEv6snJpufNAMEo/kvt7X4Ak9z
         BARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747343472; x=1747948272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jMlAOrZvviDpstgwBb3kxQ9OMj38eA4jIUVi/7T38M=;
        b=eaAAAn9JW3HRaOWZfMu/jAU1FqvIOYbvDS8/pFBfi4L8fjqHJvnTQvIpPlvrqpbQkp
         br+QwU7EBjbkbXYbUNdINOCOSt0Rkn7PEZi1fZt/to9g4lqd+d3q+8Gj7tPEznTcXoVy
         Rt6UuuxCTlW63j6o+Pe/dNUi53976mxMVDdNHjpmibB+BuaOaYyo6KJhZ38stiRixy2G
         CS14QF5/FgdJmqwN61xEZSG9qHzurKyWIeGSLXS0YCbjZdLiIS+1Wo7E4+9N2i6O7r3y
         +PzyudHPvEvuKmCU04YLtWxm4eqtx2hi5uSkCWfUK7SJQ9OyGHIIro3aahONwxyh7A+1
         rAZw==
X-Gm-Message-State: AOJu0Yx0YNMT42LmrlcF2vS8ZvmFjkd1Fq5OfinOu6XCvzgOdHUl5/Hs
	zrdJfSw1ojgMPGxT6dAd+usT0PU8zScA7c0VjpdP3Os2iP2nMb6vstdgVexMJwwHGWVxnL9iuEa
	O/LFixr1IuXvDZYY3S9S7FjuCwWU0miE=
X-Gm-Gg: ASbGncsKzAGqhv6Uwh7q102YuHoy5GhYiXWG07+0EmpTE8O6tvCi+4y/jv4PLRSh0d0
	nqEmcUWMeydF5IbPrj1IkiYxzy4jA7vE7DF4bevp0cBFUBCOYrtQFD5xMbS3L/s4NNcCofqGIK2
	uHY3wb6NqBZWF8FtNFBsRkpCtZrx91SnfSPiyNk14A6dlB/OdD
X-Google-Smtp-Source: AGHT+IFJXVVTEUIRiIoDpmjWoeaHqCjYkMFJh9LxbFsup1orzcykpbWtgS7srIvN843fHedVdwRNUaa44CUuYExGdOA=
X-Received: by 2002:a17:90b:2f08:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-30e7d5bb1aemr1016084a91.30.1747343472197; Thu, 15 May 2025
 14:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCR_9Ahv4DpvK-Vy@mail.gmail.com> <CAEf4BzZ2i8MMvS4=xGQv0YwoyuARaVP+v8YMeVR4SRcQcdMt+Q@mail.gmail.com>
 <aCZHZKRiAGOkKA5h@mail.gmail.com>
In-Reply-To: <aCZHZKRiAGOkKA5h@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 14:10:59 -0700
X-Gm-Features: AX0GCFvXQccuOEGAW6Cd_8UKksL4lH-Hj4cjs5U8cWrVKVZ-Otdp76V_v-SHy1o
Message-ID: <CAEf4BzYMrPBvpvhSq4do0j-pzJb4VZFMimS_h+09G8zgnkanQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: WARN_ONCE on verifier bugs
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:58=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
>
> On Wed, May 14, 2025 at 09:28:11AM -0700, Andrii Nakryiko wrote:
> > On Wed, May 14, 2025 at 4:35=E2=80=AFAM Paul Chaignon <paul.chaignon@gm=
ail.com> wrote:
> > >
> > > Throughout the verifier's logic, there are multiple checks for
> > > inconsistent states that should never happen and would indicate a
> > > verifier bug. These bugs are typically logged in the verifier logs an=
d
> > > sometimes preceded by a WARN_ONCE.
> > >
> > > This patch reworks these checks to consistently emit a verifier log A=
ND
> > > a warning when CONFIG_DEBUG_KERNEL is enabled. The consistent use of
> > > WARN_ONCE should help fuzzers (ex. syzkaller) expose any situation
> > > where they are actually able to reach one of those buggy verifier
> > > states.
> > >
> > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > ---
> > > Changes in v2:
> > >   - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned o=
n
> > >     CONFIG_DEBUG_KERNEL, as per reviews.
> > >   - Use the new helper function for verifier bugs missed in v1,
> > >     particularly around backtracking.
> > >
>
> [...]
>
> > >                                 /* r1-r5 are invalidated after subpro=
g call,
> > >                                  * so for global func call it shouldn=
't be set
> > >                                  * anymore
> > >                                  */
> > >                                 if (bt_reg_mask(bt) & BPF_REGMASK_ARG=
S) {
> > > -                                       verbose(env, "BUG regs %x\n",=
 bt_reg_mask(bt));
> > > -                                       WARN_ONCE(1, "verifier backtr=
acking bug");
> > > +                                       verifier_bug(env, "scratch re=
g set: regs %x\n",
> > > +                                                    bt_reg_mask(bt))=
;
> > >                                         return -EFAULT;
> >
> >
> > but please don't go overboard with verifier_buf_if() for cases like
> > this, I think this should use plain verifier_bug() as you did, even if
> > it *can* be expressed with verifier_buf_if() check
>
> Where would you set the bar on these cases? Is it mostly a matter of
> readability?

yes, it's all subjective, there is no algorithm and no clear cut
boundary on what's readable or not, so it's no big deal

>
> I'm asking because, with Alexei's suggestion to stringify the condition
> in verifier_bug_if() (cf. v3), we would gain from using verifier_bug_if
> more often.
>
> [...]
>

