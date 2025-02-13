Return-Path: <bpf+bounces-51370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D01A337C8
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA97188C7FE
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467F207663;
	Thu, 13 Feb 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaC0G2OH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16918C0C;
	Thu, 13 Feb 2025 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427367; cv=none; b=Tjab1VODMiIu7J3eGq3uTvglNXSwYZ2MAV93V/i45bTyoUA1zIDlJ4Us2Qf93GMG1Z/DLa/l3ZC02ipgU3u3VCwgNwczM1pcKWfms8ts0iVwu9PfEPDfpXXWn6axnHJ18DEzoe2zOHm7GMQvn8W1Aao4wU8XvvFB5EyacfWTvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427367; c=relaxed/simple;
	bh=Gv6P96WmOQrbC3P256YzatTY2ZKaxCszZnGNiwVr44Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/9p00GkEgBLpohpr851L4reE9rsihOfqBd0eLPCxcD20hNlGVyoVolDX6LAj0WsytYaAU1PRArQBoDyF6nRdnppQ+3oJtKdhB2rb2xyKA9zxzErJ8HIqLk4xGAKO02wDRbgT83S4VHjCzuLgKiJOq4VugP0AgeoFYqWfbP5RgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaC0G2OH; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso760178a12.3;
        Wed, 12 Feb 2025 22:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739427364; x=1740032164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv6P96WmOQrbC3P256YzatTY2ZKaxCszZnGNiwVr44Q=;
        b=TaC0G2OHy91PoY9/e9lDm9K3cSl6xoXVgHK+0ZY9ui1O5VAVIWfYKZHY+V2kP8wHNm
         XKzUWk55fvRhbenRuolqfGv7vDFbtLBQeOnzcuFjgEM3fcgqs8vmWlJshlMRJyqMFczx
         q900qcJzEmeQH9rIv/dN6KkPKRLddd94UCdmPLAS6MoOTiTqNhPRmS4q5zJlz3r4KiWf
         GStYwZX2RKmudHOwhTFNNcDHyl6z+Pb/Jm8e6WXdYjI/5c/zQuyC2kS5Yvy/hjUPftjZ
         BrpPjoHwOBNeVmDo4zJqVkgqDRhshYyq4Ege1KF087V1DqWWbEThmwHc5v/UG7VH0pEn
         2cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739427364; x=1740032164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gv6P96WmOQrbC3P256YzatTY2ZKaxCszZnGNiwVr44Q=;
        b=tJoVEw0UPSFM/rID4dKlom9+8eb4yvQiaFi1a42tHpKLaTASaNm2gNVJhwIl9b3y7W
         puf2Z+m9rgsDdqmTERD3TsOUXoDY+95D2gXwBnK029IVw1xgDko3J2644FDReMUNq3CR
         M3Ob8HkcArC+jNGVsL5oIS4ZiDVkDVOUnRF9dpNTON5Q+mSwsmJrz1p68ICuQlXY/zw4
         R+iudTzRNslBz0D4VZtBCbvcJajBX7n0mM+CMnNs5gY5BbvI+A9eQUF2rZyaQLuXFbTe
         hXPBnRf+W/v0LnHX/m66IrPkewQykgginUFD/jSpGy9ixSTGDtoDLYrU3WuY0YPWo6Bf
         F1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVjrQooKGJh3TnAS+7eqaDRuyRLnCopO5a2h3Re5OI5WxNSfMoXOSLqU/WvHOmh+r3Pjd4Tk4FCT8hLNHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMJheHCx0kRA5+Gdn+Ccw7O5+OMcfbXeR6n5QQOvD7CFUVvio
	TMjpVlsapU19AqtWKm2Ml7PyhCkg/8LDpdSvFUAfMSgW4gzBbA53GQmAPhZ49J+XJvyqi+P1MFD
	p1dj4cWH8/LVA/P8tGr7rFfgapOg=
X-Gm-Gg: ASbGncuDhwIeFaKLaNCRdemPpkuDl+Y4j76nICfaIlr+oYlup4NzgrRuSRRPGBBJ/yT
	tgXRFRbTVlb+6NjhrIFbw924HjNX2bU30Y2i+TblprmUR5FXSk8ob+W4BZMlbeXcEsEx3O2QfGg
	==
X-Google-Smtp-Source: AGHT+IHFCPal8XyiRpNELMJ8NBCTaRWNSJ89jjVFoE90aeSCR4Yqu4INXbyrSo6a7ISMjZGsyZRiXpy3HscM3AvbHVo=
X-Received: by 2002:a05:6402:3205:b0:5de:5717:f235 with SMTP id
 4fb4d7f45d1cf-5dec9fabe15mr1741758a12.24.1739427363633; Wed, 12 Feb 2025
 22:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-18-memxor@gmail.com>
 <20250210095324.GG10324@noisy.programming.kicks-ass.net> <20250210100316.GD31462@noisy.programming.kicks-ass.net>
In-Reply-To: <20250210100316.GD31462@noisy.programming.kicks-ass.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 13 Feb 2025 07:15:27 +0100
X-Gm-Features: AWEUYZl7M0DetoXSoe_3tNiqDhURqRz8Da2S_9eZM8rtLeudxKegHHRX9bQwnzE
Message-ID: <CAP01T77B9OH6vPqYNyLwmdo4Q6EE5iAi4dTKduPqpTOgdkO_Bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 17/26] rqspinlock: Hardcode cond_acquire loops
 to asm-generic implementation
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 11:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 10, 2025 at 10:53:25AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 06, 2025 at 02:54:25AM -0800, Kumar Kartikeya Dwivedi wrote:
> > > Currently, for rqspinlock usage, the implementation of
> > > smp_cond_load_acquire (and thus, atomic_cond_read_acquire) are
> > > susceptible to stalls on arm64, because they do not guarantee that the
> > > conditional expression will be repeatedly invoked if the address being
> > > loaded from is not written to by other CPUs. When support for
> > > event-streams is absent (which unblocks stuck WFE-based loops every
> > > ~100us), we may end up being stuck forever.
> > >
> > > This causes a problem for us, as we need to repeatedly invoke the
> > > RES_CHECK_TIMEOUT in the spin loop to break out when the timeout
> > > expires.
> > >
> > > Hardcode the implementation to the asm-generic version in rqspinlock.c
> > > until support for smp_cond_load_acquire_timewait [0] lands upstream.
> > >
> >
> > *sigh*.. this patch should go *before* patch 8. As is that's still
> > horribly broken and I was WTF-ing because your 0/n changelog said you
> > fixed it.
>

Sorry about that, I will move it before the patch using this.

> And since you're doing local copies of things, why not take a lobal copy
> of the smp_cond_load_acquire_timewait() thing?

Ack, I'll address this in v3.

