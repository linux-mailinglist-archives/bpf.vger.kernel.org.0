Return-Path: <bpf+bounces-34620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A892F5A3
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E6A282CC5
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E513D52F;
	Fri, 12 Jul 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mt7gkb/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73D339AB
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720766491; cv=none; b=dCXcA5wnPWqqGNQ64do8JXIJrDgt+zUW/a9bpuP8X9jOV70k7vgpmjlzAfGxEXzMjYBG6vZX+rDeLVf7Cc8II8uMTFoWje9SYjcGkYRWX8DuzOPmli1LmIi/Tmy5Il23Nnp+i8J4VawBqCmRwamsdVz+NLjmSgE/jgBoNfWFhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720766491; c=relaxed/simple;
	bh=Q4K7SyDTZ2DBh379Ixl+ADDNnpm4aWtlC7M71SS6Q4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icti5UxPFZlIjvUEN3u13NAPrm/OBRaJfpQhwU9R0oT3FKLoHPeq388/usC8GfZqJUK6xVneeY4RK4z5cKsuZjefttI3Ys4PToNB7XMHx+GR3abf4AdLrDsD8IWkHCX/d6ALVI/Zlbepctey17ZxGfS1nuuOVaUFU/5CM52ldds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mt7gkb/u; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3678aa359b7so1700525f8f.1
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720766486; x=1721371286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aV/B4Uo3nqoDXCN18vJDXPhRTIVGbA62z5bowfHDQeA=;
        b=Mt7gkb/uGZZR0mOGxe+PYewY8sg68uaWeKP+7/4ZF+zi3pNQZk0qMHQDWhy5WfTIV8
         R5jspVKZeLH0ynmjZRJg1ho4EyWbfZ/IkmeQERkP+Xh84g86egkmF1MUTAmW/h9OpYPG
         lzHIDP4AooOyUn1QGC61rzX41l7MFn7GMcjYoVint19nVtoChe8qN6q4WasOmznu9UQ4
         a+9Ybx3cTdVJ6Wit275JxxGfwJFoWSPLVxQeHifGs3FvygUI4ca+rrs3lZWPdiAFgjPN
         2/QXX1Y9zV+e8ud0RjDIqxabX1mvB/KuQuL81TIkY9Kw6dCdFR1TqO7p8nwJ0TMCVitf
         d3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720766486; x=1721371286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV/B4Uo3nqoDXCN18vJDXPhRTIVGbA62z5bowfHDQeA=;
        b=Bw8nWpWXvLJdtBwQPxtTPDIQrSe5YfZlJ4FjqRtrALhygNc0Zk6Dj5SBZsgMTUqtZC
         8tKcB8dUtA8wGXLZDNnldVzgEgEAOv18AmTo2vWb8BEWFd+f6DUocw7H62QU3BsJVovg
         zyIv6+YTQ1APQat4qrKV5avEFUmH9T+SH31G/lCqMZeoXSCVJ/4Xwe7McaVZ6yZaRf3m
         bP2pG34ZMxqgFy0KE26u4U5qb+/olBKDasrczYSA7KdNDLlCcfA7M0rB2VaDBPERy3j+
         4iX5uVj5HMb6CtEhwZYRTSAb1bMQZQaO6WaKl30tUt8RPKS13GDW9Imee0VawAIlvVL3
         ZIDw==
X-Gm-Message-State: AOJu0Yx2kJkOOqXi3GOmcwQPf3UmBgfsR6lqnJmfJkklKuqX14dO19P7
	UmfkgoSNyLWVRNjn5noHSRK5nXOSgROJ90Tmrn/J8prLHz/aX+Wl56J5QYFUM10=
X-Google-Smtp-Source: AGHT+IGivMtiJENzZE9EJn2/gRP02tJHr4eUVPC0Q2UDWMxQIJPJHjBsBNDYV0RYG4V0GBNjXiaBQw==
X-Received: by 2002:a5d:6dc4:0:b0:367:895f:619e with SMTP id ffacd0b85a97d-367ff6edd0amr1222862f8f.11.1720766486512;
        Thu, 11 Jul 2024 23:41:26 -0700 (PDT)
Received: from u94a ([2401:e180:8873:3610:1f4f:ec99:f5d7:cdde])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acef34sm60017305ad.238.2024.07.11.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 23:41:26 -0700 (PDT)
Date: Fri, 12 Jul 2024 14:41:17 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com, zacecob@protonmail.com, 
	kernel-team@fb.com
Subject: Re: [PATCH v2 bpf 1/2] bpf: Fix the corner case with may_goto and
 jump to the 1st insn.
Message-ID: <myyr3qp5h4bnzd3j4qypqxhjixebmwxmw3dknud3rbkohpmewl@ncmply4puxgk>
References: <20240619011859.79334-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619011859.79334-1-alexei.starovoitov@gmail.com>

On Tue, Jun 18, 2024 at 06:18:58PM GMT, Alexei Starovoitov wrote:
...
> +static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
> +{
> +	struct bpf_insn *insn = prog->insnsi;
> +	u32 insn_cnt = prog->len, i;
> +
> +	for (i = 0; i < insn_cnt; i++, insn++) {
> +		u8 code = insn->code;
> +
> +		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
> +		    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
> +			continue;
> +
> +		if (insn->code == (BPF_JMP32 | BPF_JA)) {
> +			if (i + 1 + insn->imm != tgt_idx)
> +				continue;
> +			if (signed_add32_overflows(insn->imm, delta))
> +				return -ERANGE;
> +			insn->imm += delta;
> +		} else {
> +			if (i + 1 + insn->off != tgt_idx)
> +				continue;
> +			if (signed_add16_overflows(insn->imm, delta))

Looks like this be signed_add16_overflows(insn->**off**, delta) instead?

I'll proceed assuming so, and include a fix for this in v3 of the
overflow-checker refactoring patch-set.

> +				return -ERANGE;
> +			insn->off += delta;
> +		}
> +	}
> +	return 0;
> +}
...

