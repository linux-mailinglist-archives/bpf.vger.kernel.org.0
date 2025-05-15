Return-Path: <bpf+bounces-58353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C7AB9067
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 22:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310B21BC0AF1
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC48298244;
	Thu, 15 May 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC2e9HuZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C1297A48
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339114; cv=none; b=ZStQFdKbUhWBa0prowCiGah0iiYFl+OM9LzvaxwJYgaskeVHykZNaARf9GZqJ9BBecWLImzD067xKgKEjrypF/iiV//WS5zekFvljB2XqFYPMX6Nvx086csTcOoTk3jtT7oiyHH2c88cv+J2U/sAQMupQ3JaHpoyQXwOfX8U/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339114; c=relaxed/simple;
	bh=4zRd4CNQ80GQJ3HyDMIHOCE6o/MixivEr90yWr5xu74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mB+P99kQcXds30XF7GiCiXV1J3GyZrJqLVExa4aUt4fsi35XiFEgt5S6pQaoJ1vtt9VGryIIz1Zl1ChB2eJWKYBMbK+V1kit06Z123K2cAuwyIldz7tw0BDRUvuvjBmY4KC/rtraduKi+dV0MZ2bAxB2crQuBVuJkMB6uhkWPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC2e9HuZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so13921715e9.3
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747339111; x=1747943911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tf2l9sdR0bvStF0zC/IgUr7xrRIZAAXzVw5yAauTjzQ=;
        b=AC2e9HuZRuR//kHRQvwLgEYiz01WiWHOgwdgBZ/OYoNUVihCttoGD1H/LgTlFd/aJx
         zncWgRdyuiPVsDtmbFaTuh+3QJzgQ7VrOkjB19y0Hgvuv8/05bFKXny6U6DIBLg322pk
         5o0St3gTa6rz2cdJ6xsLKENNeXO2Oyh03sc80WnUFpaYP9DexG4mrEKrz/ZCl8UhTtUV
         ug2cToTDu8HiQAsOMACN8US+eqvqprl6lRC10FWUrrFR8WhN5S5uvSr7IHJZU2uemY1P
         zAYKRWY3bXu1RtRV/Jkq7kuHd9wWfWNUde3KSg/UJqZfOAGvLGyUMWhZTptP2th6Ok6L
         P51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339111; x=1747943911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf2l9sdR0bvStF0zC/IgUr7xrRIZAAXzVw5yAauTjzQ=;
        b=ibfWQM4kum254C0vOl8Tsh08Dou8jMu/viuWiWZ02SUAbA80rtcqBt6CKFtXG846cK
         dL6zFf9mTVFvnphDnbVMFHSMMysIZFPt3HXO9L4+hNNePDmUXMagUx6UKZ0arCrYIsA9
         9JYuDvceDlwHNeo52qgQK6lXfBUww5IoKY4a7HKyCixDTtzD/AcbfaRQN8WvFfK8MEsQ
         5RcxqWTirAEpNF99plET2ugso1/KASiLuwgdvK9MJ4kXD30P/TanDL20VJT8peIh+ZTp
         S5i6WgAoucoX3FGpFzXFu2j57zn0oL7azat5O07uc/xfpB7L3u6qPzuAGHFNIvT629he
         5v5A==
X-Gm-Message-State: AOJu0YzcJiLfjNe5CWI2SQAuGbXWETf6s7un5IvibbNGCVf3tyTh1Tkx
	4syKsBeSOZSafqkPk6inMmqov8jLmKSgvARw2faAhP/LsRHcEDCPbfwJ
X-Gm-Gg: ASbGncu5jbgDv/Ql04BnaxxUjeFlINPRcETF8S8dzXCYD3vCRLMU/KB0lbv1gzwGkmX
	p9kaYuEZ2/kFsQR4RLNRSdBVx92UO3of2mM5Z1zAK4OhOqR6GC/2rjvOTONMK64sHqvDI5WPDOT
	jjYknc0BPc+3caTVRUtGZtvTh+Nqh9Jw3s5KOlZ2Ni8rVuoJXWPGYrE3d1iERGgD4pwLjqUFk7j
	c1LYRNzK45z5fPW18pNxgwBEVmMu3EHDM6zwItzgOBZxSrXt3kZX0BEDaKQ7W8TScCiU0yF29kG
	J/+72N9kyJ+ZBQIvzNn68Qplr3oODZe6Dz0qEOdleR2Zds001nSjVq0br1m1LIWZHW+q4tENciS
	69tCYbQEqjdWcwaB5PxC+GYPnFqy3j6pih6s19zi2cjizQk0KmA==
X-Google-Smtp-Source: AGHT+IF430ifhKssbpoJ5oTCmXV8Lksjj2c3SRgDCXMK5uQ3KkjtidGjNLhrd5xL42Cetg3+jkKqbA==
X-Received: by 2002:a05:600c:4e0d:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-442fd664a0dmr7088755e9.21.1747339110591;
        Thu, 15 May 2025 12:58:30 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00227f1046c823512d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:227f:1046:c823:512d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50ee03sm7251875e9.14.2025.05.15.12.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:58:29 -0700 (PDT)
Date: Thu, 15 May 2025 21:58:28 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: WARN_ONCE on verifier bugs
Message-ID: <aCZHZKRiAGOkKA5h@mail.gmail.com>
References: <aCR_9Ahv4DpvK-Vy@mail.gmail.com>
 <CAEf4BzZ2i8MMvS4=xGQv0YwoyuARaVP+v8YMeVR4SRcQcdMt+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ2i8MMvS4=xGQv0YwoyuARaVP+v8YMeVR4SRcQcdMt+Q@mail.gmail.com>

On Wed, May 14, 2025 at 09:28:11AM -0700, Andrii Nakryiko wrote:
> On Wed, May 14, 2025 at 4:35 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> >
> > Throughout the verifier's logic, there are multiple checks for
> > inconsistent states that should never happen and would indicate a
> > verifier bug. These bugs are typically logged in the verifier logs and
> > sometimes preceded by a WARN_ONCE.
> >
> > This patch reworks these checks to consistently emit a verifier log AND
> > a warning when CONFIG_DEBUG_KERNEL is enabled. The consistent use of
> > WARN_ONCE should help fuzzers (ex. syzkaller) expose any situation
> > where they are actually able to reach one of those buggy verifier
> > states.
> >
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> > Changes in v2:
> >   - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned on
> >     CONFIG_DEBUG_KERNEL, as per reviews.
> >   - Use the new helper function for verifier bugs missed in v1,
> >     particularly around backtracking.
> >

[...]

> >                                 /* r1-r5 are invalidated after subprog call,
> >                                  * so for global func call it shouldn't be set
> >                                  * anymore
> >                                  */
> >                                 if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> > -                                       verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
> > -                                       WARN_ONCE(1, "verifier backtracking bug");
> > +                                       verifier_bug(env, "scratch reg set: regs %x\n",
> > +                                                    bt_reg_mask(bt));
> >                                         return -EFAULT;
> 
> 
> but please don't go overboard with verifier_buf_if() for cases like
> this, I think this should use plain verifier_bug() as you did, even if
> it *can* be expressed with verifier_buf_if() check

Where would you set the bar on these cases? Is it mostly a matter of
readability?

I'm asking because, with Alexei's suggestion to stringify the condition
in verifier_bug_if() (cf. v3), we would gain from using verifier_bug_if
more often.

[...]


