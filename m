Return-Path: <bpf+bounces-64439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC4B12A7A
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 14:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD61560571
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD1D245033;
	Sat, 26 Jul 2025 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qbgd8olm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE123BF91
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532948; cv=none; b=OklchhcoCyF8f5xu3W71it/qrlKL2zaOXl+lPPQu8ecbZazKjud1A/7Oxs6q6nkkPraIzy0Vrf9kR7cOCP350zlPu0p/xegTeR6dFhVenc1qjP2EUDUSdooOWtJs2W0jZcbl6kUEfSrhtdYKnRdNN6wa2Xo7GwMhQHNav/93bSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532948; c=relaxed/simple;
	bh=jGaXAcnEF7xT7khsh4mvqObFCn+mfNMqccU3RIXgjrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHYRJuisFI0jZRfY2q2To8Om86TbA3KqRD6lXdkpw/Y1zEeJGq0b4Fi7pNsfxQqb/5bnDoDwrcluEa2DG9OJDR+ot7GfFzdXWS/1+FKfO2sLvg1aNXbfY0DQ1fS0MLgasSnPOBkuTN0a3chAy0XcqgHx1uP6cysL2zpjGab5Xhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qbgd8olm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso31653255e9.2
        for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 05:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753532945; x=1754137745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MubEv+r0PbUXomjtMZpgOnpNkdL3iqT7q5Jvt9Sgef0=;
        b=Qbgd8olmOuEZv0kerlFomRSF6NDznL9sAC01SDW4yQ255E7JdAPE6SoUOcg6kVsLZZ
         XCP96mZMpEdtgyos/s1Szr5K5MV2BkjM+UXmzQPQsUmr8j1LnKXGiOhJ0Lx+WEQabjsw
         KAVABHnDjfT+YxlmOMNmB7f1JDvsjMm2sAkticsjMqHPRpKkT8oezYgng2SjdXEqVb1Y
         e+rCcCirALql9fRbxMBMiq1oXn0UNZstD8bduHPpBRESqCje+Y2pjvx9GLJ6C3Eh6ENI
         A+6Ns7C6ItH2AK4EVO6ckp/A+0Dsfy9OJ8Whe57iqWlMXtsLBimYNXQVjZEkgXPlM/N0
         g6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753532945; x=1754137745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MubEv+r0PbUXomjtMZpgOnpNkdL3iqT7q5Jvt9Sgef0=;
        b=DEhlZIRT1cxEN6fDlKwDnquVfSSklH2xVjJd5rQY3h0khOLNaAW88EF9jOzWBJt/MK
         BziRKL8cPQaiK7BJXwg5oYl0lHdSLSBo3mO9p0FCsjj1xPTr9YdfZkWBjOtvcDn8nUSW
         +Tr7WAed8qG9PbBlTc7XRxIZPvf6cHi+Tf0YO6aaonivPuZn4NwMLgwFxvY6fB9R2zFA
         Q7sVJBADiLzpmgZcezek8LZwExeo/iv4IRI4zUb7ohnlG5N5d5cgSiUzj0PtvCGVBZHO
         buF6znKQNXCYGw8e/+FxjXczvSNChoyZtZTXaodSjPdIS+iWGcnWiiWb4HqPP+9HPiz0
         e+QA==
X-Gm-Message-State: AOJu0YxCVQveArr67P3WgWyNum9YIBCJvVze0hpkmWgiIIld0fAyLadg
	TVzLckLSaIaUIcJBOa4rlqqLqbBZn2ahGr1NrhkmPALy3aXHBK+ocrXY
X-Gm-Gg: ASbGncvLU+7sEvRiR6uW/8QRsTu3ranrI7ePHEufPlIMzHPcj7JegH+UJAhdXfZjzpO
	4f9kQEwJ9VSTVPKCI+UC9ZgD5A19y1gtWTm6oDe0jAuentd7NECc09/1nQzBPWyJGgZp2ky2qAb
	sk28ImX+lOgi1AZCfgTtNn9ZU4gjT7ydHWrUIlVEWbQxlodGcQF+Bn6/3w04th+IlkplbFd5juA
	5p9ShhNcp0ymfltpjOiNOuhIh2U2g22JqZHiWfmDmfym53ccT8ow2HYFdTY8FygoXQIw6mzTQ7g
	8r0sR9qjqbUCaIrDw27LNAjFhWv9gnhxzo+vS8ZuPeONZqAOv3zVCmgIWJSlVPrTf5hvo+Hg+wc
	I88jUnnk0Mn5x3plmQ9pdTpu2KN+I/59gmVAh0tv0bSYOb9fvwdSMJgHhoJNWuXs6INAn694Mx5
	RF4ipWUVyjfApiw+06beJyk79p+11Jemo=
X-Google-Smtp-Source: AGHT+IE/9adaWgwheHLLMlHRAYU2SYcPbGxgBaemvYk/oOFPG9eC57vvAr0ESTD2WSbgo+0JotIYfw==
X-Received: by 2002:a05:600c:6217:b0:456:58e:318e with SMTP id 5b1f17b1804b1-45876665de5mr52073785e9.30.1753532944524;
        Sat, 26 Jul 2025 05:29:04 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d448ffe25653721a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d448:ffe2:5653:721a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac5818bsm29476045e9.20.2025.07.26.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 05:29:03 -0700 (PDT)
Date: Sat, 26 Jul 2025 14:29:02 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Simplify bounds refinement from s32
Message-ID: <aITKDtyGIox5FdkD@mail.gmail.com>
References: <aIJwnFnFyUjNsCNa@mail.gmail.com>
 <4da44707e926d2b2cb7e1d19572d006d7b7c06bd.camel@gmail.com>
 <nrsym2fuoeqoewmf7omq5dr2wtnq63bmivc2ndvkybi3xh4ger@7fenu3fa566i>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nrsym2fuoeqoewmf7omq5dr2wtnq63bmivc2ndvkybi3xh4ger@7fenu3fa566i>

On Fri, Jul 25, 2025 at 05:21:38PM +0800, Shung-Hsi Yu wrote:
> On Thu, Jul 24, 2025 at 02:49:47PM -0700, Eduard Zingerman wrote:
> > On Thu, 2025-07-24 at 19:42 +0200, Paul Chaignon wrote:
> > > During the bounds refinement, we improve the precision of various ranges
> > > by looking at other ranges. Among others, we improve the following in
> > > this order (other things happen between 1 and 2):
> > > 
> > >   1. Improve u32 from s32 in __reg32_deduce_bounds.
> > >   2. Improve s/u64 from u32 in __reg_deduce_mixed_bounds.
> > >   3. Improve s/u64 from s32 in __reg_deduce_mixed_bounds.
> > > 
> > > In particular, if the s32 range forms a valid u32 range, we will use it
> > > to improve the u32 range in __reg32_deduce_bounds. In
> > > __reg_deduce_mixed_bounds, under the same condition, we will use the s32
> > > range to improve the s/u64 ranges.
> > > 
> > > If at (1) we were able to learn from s32 to improve u32, we'll then be
> > > able to use that in (2) to improve s/u64. Hence, as (3) happens under
> > > the same precondition as (1), it won't improve s/u64 ranges further than
> > > (1)+(2) did. Thus, we can get rid of (3).
> > > 
> > > In addition to the extensive suite of selftests for bounds refinement,
> > > this patch was also tested with the Agni formal verification tool [1].
> > > 
> > > Link: https://github.com/bpfverif/agni [1]
> > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > ---
> > 
> > So, the argument appears to be as follows:
> > 
> > Under precondition `(u32)reg->s32_min <= (u32)reg->s32_max`
> > __reg32_deduce_bounds produces:
> > 
> >   reg->u32_min = max_t(u32, reg->s32_min, reg->u32_min);
> >   reg->u32_max = min_t(u32, reg->s32_max, reg->u32_max);
> > 
> > And then first part of __reg_deduce_mixed_bounds assigns:
> > 
> >   a. reg->umin umax= (reg->umin & ~0xffffffffULL) | max_t(u32, reg->s32_min, reg->u32_min);
> >   b. reg->umax umin= (reg->umax & ~0xffffffffULL) | min_t(u32, reg->s32_max, reg->u32_max);
> > 
> > And then second part of __reg_deduce_mixed_bounds assigns:
> > 
> >   c. reg->umin umax= (reg->umin & ~0xffffffffULL) | (u32)reg->s32_min;
> >   d. reg->umax umin= (reg->umax & ~0xffffffffULL) | (u32)reg->s32_max;
> > 
> > But assignment (c) is a noop because:
> > 
> >    max_t(u32, reg->s32_min, reg->u32_min) >= (u32)reg->s32_min
> > 
> > Hence RHS(a) >= RHS(c) and umin= does nothing.
> > 
> > Also assignment (d) is a noop because:
> > 
> >   min_t(u32, reg->s32_max, reg->u32_max) <= (u32)reg->s32_max
> > 
> > Hence RHS(b) <= RHS(d) and umin= does nothing.
> > 
> > Plus the same reasoning for the part dealing with reg->s{min,max}_value:
> > 
> >   e. reg->smin_value smax= (reg->smin_value & ~0xffffffffULL) | max_t(u32, reg->s32_min_value, reg->u32_min_value);
> >   f. reg->smax_value smin= (reg->smax_value & ~0xffffffffULL) | min_t(u32, reg->s32_max_value, reg->u32_max_value);
> > 
> >     vs
> > 
> >   g. reg->smin_value smax= (reg->smin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
> >   h. reg->smax_value smin= (reg->smax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
> > 
> >     RHS(e) >= RHS(g) and RHS(f) <= RHS(h), hence smax=,smin= do nothing.
> > 
> > This appears to be correct.
> > 
> > Shung-Hsi, wdyt?
> 
> Agree with the reasoning above, it looks solid.
> 
> Beside going through the reasoning, I also played with CBMC a bit to
> double check that as far as a single run of __reg_deduce_bounds() is
> concerned (and that the register state matches certain handwavy
> expectations), the change indeed still preserve the original behavior.

Ah, I didn't even think about checking input-output equivalence. Thanks
for testing this!

> 
> Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> Simplification of bound deduction logic! \o/

Yeah, I'll admit it felt too good to be true :')
I feel more confident with both of your reviews. Thank you both for
reviewing this closely!

[...]


