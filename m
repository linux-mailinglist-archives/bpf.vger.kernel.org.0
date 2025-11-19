Return-Path: <bpf+bounces-75064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD5C6E972
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 13:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3E1D02DFFC
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A6352FA6;
	Wed, 19 Nov 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdpTc3Lp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197534BA5B
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556518; cv=none; b=dWNPADZc11lBXm7mFhkkwZ5JjI+aZziJVAZSc/53dbcK1AligOWluFFDgOb06Xo2NSYCjpET4mMebvFUlk8uxc2iZPi2j7pCzypQNpUxRKUdYBCpDWqFU2DBNdYrhdPnGW3pwD7/kx0xQ/Dldip1VJe9b9iFae3EQgFN8wcXjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556518; c=relaxed/simple;
	bh=YrLEZCMhKuLkmV8cqoQB4dwtBq0G8sGkqVF/kgzHOtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIY0Cbv7Hw3auACYN9S3zIhM9ZUfB50qXPE+kDiYnj4lrvsoDyhyMnPmTRaiJu/tcXMckK1nNjdevBnX0UXZbU1liyycPjtqcHO/c6mCahdSj5KI71Q55ZDSEUG74y/vv8TrJ8qvcjwiVBr8Ljy6OSY6L9dcX0vNqYh1ON3TCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LdpTc3Lp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b427cda88so4774866f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 04:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763556515; x=1764161315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bG4wdM+vnyp9WSnbKcPbks2fDuzKu7FK1Xy90/2r7u0=;
        b=LdpTc3Lpw6vd6s+bPZ6N9SvYcJsIwJ8ZuQ31Web2tjbK0H+BdjUFr/xYqxyZjMt7B/
         tLCvq4CVBc0KJ50g0F/yFHYKdnHoB8sBxO3jR0Ifyr0YqbQCM+ayz79+asmQFpzUWu0k
         22E4HPDJ5FdNvCiUReDUwC5cn9+dMzZCFleUt1QdI1fw1iFEo7kFGe2PYFAoknH9JqJP
         Or1o2tHV9MiCVpas7B1ve5LGKLk9mwxqizhUVh8zZsrbUSPziNLAUH3rEyselofehKA2
         +Gb4BVhFE4i1th0CpSPlbUyXEUgaClz1DhEjP+0xW/J3ZBmAmKxB7ziWgpFV0dSzZDZk
         9Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556515; x=1764161315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bG4wdM+vnyp9WSnbKcPbks2fDuzKu7FK1Xy90/2r7u0=;
        b=ovfm0jjB0nHQZdU4f1yU9PnqGRv6zvQaWYkMjrSNkH60hS1f4uBhJbHhNZpgQk7g3s
         kK36HdRm8bBotbqrm6Zjm68C+HIdxjcwU1Q4eS9VKGiuw0k7LzOWhj65xooiIYPU390Q
         Uj8B+BYqhWZjMxRoFkpQzSeYjMOblVptLgROZSmw11m1V9R3SnZs1aR/lFPqpRUumJ4X
         k6eR+Pli3HDUoCkMSQpeJxtAjasCsx4rQbY9M56LrZ2Pf5/Y+dsL3nbbqY8nynP3zZMC
         6hr8Iq2ZU0PHAMHMGt6y9xCOI0V4FieQMcIW7MSPdYJSm2wqCScb+M1F9WlEtfw/G+uU
         0nng==
X-Gm-Message-State: AOJu0Yy4PjT0vlxOOOIZ0ZzVXVymwgFs8nB3KWMGvDEgpw4L3mwlRD7o
	RwrAEeRrJUovmRwTV41xv7fAF4YEFl4ReTeRZgldUEgFMm42e3WFbPv48YkKNDGiDgg=
X-Gm-Gg: ASbGncto6rHwG000r7oZnJWjJMsUoOB0PYo26RYfanotnNcohAW6fqepV+Hqy5L+CgU
	2R6ABYe7WzCONtVVRpPYs/H6QmW93TrMGBjqODY0txjXffskPrF7Q3rp9grtQCLxc+3BGJRg+F2
	JkcEH5zuUaB43nphusNVlzgPFaXZHiJGMAn0iiudFZ77GQGwHbnmWMgODJB0iT/WyHdxHP1Cfjs
	z6YeczUhCk4Je6oLMSoFws1LU9mquWRvksjUaddQ6JCQ2v2GreMQADARvVBmyEVPcLLMQT9DJNX
	CinhPOQnuxhjiPJ9HOyOv2+iaKM6ZtZjQhcVIYclMGJRwjYTD4CCTk5urQDYIbKUkX6d8Ai05X6
	deDrWuPiZ7vQjUv7rYZqKJ0S4b0/6qWPQUO8e9Bzl023ZhdB4xbDrYKApnF6rLo/B2VCu7pDk3b
	1MKiQow20ZBWDN9qlQmgTbFjzW/oI=
X-Google-Smtp-Source: AGHT+IF7mv89hHwtG3kYFDwPiCtukGaZGCZ/+dZeuUUQSceFcmVubB/LmsP72VTqnvsE+109AvDjMg==
X-Received: by 2002:a05:6000:288e:b0:42b:3b55:8927 with SMTP id ffacd0b85a97d-42b5933919dmr19279464f8f.21.1763556514485;
        Wed, 19 Nov 2025 04:48:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53f206aasm38122928f8f.40.2025.11.19.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:48:34 -0800 (PST)
Date: Wed, 19 Nov 2025 15:48:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [bug report] bpf, x86: add support for indirect jumps
Message-ID: <aR28nuYIPPL-89lG@stanley.mountain>
References: <aR2BN1Ix--8tmVrN@stanley.mountain>
 <aR2n7mrFwjucPsYm@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2n7mrFwjucPsYm@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:20:14AM +0000, Anton Protopopov wrote:
> On 25/11/19 11:35AM, Dan Carpenter wrote:
> > Hello Anton Protopopov,
> > 
> > Commit 493d9e0d6083 ("bpf, x86: add support for indirect jumps") from
> > Nov 5, 2025 (linux-next), leads to the following Smatch static
> > checker warning:
> > 
> > 	kernel/bpf/verifier.c:17907 copy_insn_array()
> > 	error: 'value' dereferencing possible ERR_PTR()
> > 
> > kernel/bpf/verifier.c
> >     17898 static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
> >     17899 {
> >     17900         struct bpf_insn_array_value *value;
> >     17901         u32 i;
> >     17902 
> >     17903         for (i = start; i <= end; i++) {
> >     17904                 value = map->ops->map_lookup_elem(map, &i);
> >     17905                 if (!value)
> >     17906                         return -EINVAL;
> > --> 17907                 items[i - start] = value->xlated_off;
> > 
> > ->map_lookup_elem() returns error pointers on error and it returns NULL
> > (I guess if there isn't an error but the element is not found).
> 
> I didn't check the value here, because in this case map_lookup_elem()
> always returns a correct value or NULL (= index is outside of boundaries).
> 
> >From BPF point of view, map_lookup_elem must return valid pointer, or
> null (see the bpf_map_lookup_elem_proto in kernel/bpf/helpers.c). But
> some lookup functions might be called from kernel (as in this case)
> or from userspace via the syscall. So I'll send a fix to add a check
> here and make the static checker happy.
> 

I wondered if this might be the case.  If you don't want to, you don't
have to add an IS_ERR() check, but I think a comment would help.
Otherwise people with questions could just find this email here.

Generally, in the kernel we assume that all old static checker warnings
have been addressed so anything remaining is a false positive.

regards,
dan carpenter

> >     17908         }
> >     17909         return 0;
> >     17910 }
> > 
> > regards,
> > dan carpenter

