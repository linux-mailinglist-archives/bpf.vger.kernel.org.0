Return-Path: <bpf+bounces-12610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6637CEB41
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B55281E32
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 22:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC13D38D;
	Wed, 18 Oct 2023 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84E37143
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 22:29:05 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B92115
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:29:02 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-66d060aa2a4so47556316d6.2
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668141; x=1698272941;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+kgU0/OVWAaw1sKs0CW5C18BLbSdEMvpGBE9X5n4Y4=;
        b=qjYwJzwJJ4BkRFfzC/ulr4pDX4UKOlBV9TbXWbC9kHRVOTEPXov7S+SCv/w1uUpkAX
         QbSk+0+dkfgLmK08ylT1F8te5r27nZ2bxldfQM5s+JExl+Qk4vZ4ratp+Cm6LAFUKhuT
         8tjnl067cKn3qX38r9mkZvslD8m+YiPF3SUfYAAZPMVtavdO/+rV6vmAX556m3NAWetT
         P7udU1rf6idjSNPdOmPKzrt+469QLvlq7k6kmSL8y9KBgQuNnMSi6VD1LcpGRNgDPw9V
         ndZ86KZB4vjKeemT8PJeJ+RtdeRcMc7Kbe3cBh3hnfXP3Ac5w+HQV4GQ4YEWQBKxnDVT
         6iTw==
X-Gm-Message-State: AOJu0YxA6RSCnY5GoruHkppV6kIJzWAnG8wNxQZSup91bbWhcO2vCDUq
	ySWSEHwlcFOYgO4xVB669JY=
X-Google-Smtp-Source: AGHT+IFesjPkusA0tUPAzXZOoFWo5njxAWQVfZO19LlPnPXhHC4LLe7+rZYS4K1rzjjxcP3SjDe/+w==
X-Received: by 2002:a05:6214:c4e:b0:66d:55d9:9522 with SMTP id r14-20020a0562140c4e00b0066d55d99522mr559946qvj.23.1697668141552;
        Wed, 18 Oct 2023 15:29:01 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id bu11-20020ad455eb000000b0065afcf19e23sm286055qvb.62.2023.10.18.15.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:29:01 -0700 (PDT)
Date: Wed, 18 Oct 2023 17:28:59 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>,
	eddyz87@gmail.com
Subject: Re: [PATCH bpf-next] bpf, docs: Define signed modulo as using
 truncated division
Message-ID: <20231018222859.GD4176@maniforge>
References: <20231017203020.1500-1-dthaler1968@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017203020.1500-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)

On Tue, Oct 17, 2023 at 08:30:20PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> There's different mathematical definitions (truncated, floored,
> rounded, etc.) and different languages have chosen different
> definitions [0][1].  E.g., languages/libraries that follow Knuth
> use a different mathematical definition than C uses.  This
> patch specifies which definition BPF uses, as verified by
> Eduard [2] and others.
> 
> [0]: https://en.wikipedia.org/wiki/Modulo#Variants_of_the_definition
> [1]: https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
> [2]: https://lore.kernel.org/bpf/57e6fefadaf3b2995bb259fa8e711c7220ce5290.camel@gmail.com/
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Acked-by: David Vernet <void@manifault.com>

+cc Eduard as well in case he wants to take a look.

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index c5d53a6e8c7..245b6defc29 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -283,6 +283,14 @@ For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
>  is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
>  interpreted as a 64-bit signed value.
>  
> +Note that there are varying definitions of the signed modulo operation
> +when the dividend or divisor are negative, where implementations often
> +vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
> +etc. This specification requires that signed modulo use truncated division
> +(where -13 % 3 == -1) as implemented in C, Go, etc.:
> +
> +   a % n = a - n * trunc(a / n)
> +
>  The ``BPF_MOVSX`` instruction does a move operation with sign extension.
>  ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
>  bit operands, and zeroes the remaining upper 32 bits.
> -- 
> 2.33.4
> 
> 

