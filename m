Return-Path: <bpf+bounces-69581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD4B9ABF7
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFAF188806C
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286330DEC4;
	Wed, 24 Sep 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Ry6iG2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4D17B418
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728544; cv=none; b=cEKxW1Lfse20/1vmGMEY0EuwaIp3+NT4GOMTQPoCXDQUtfxaJXRjxr4Pn6fhupOnyF5E4hlGq90d3BG50Uc4GYHi+gBzCBK6qf+LShHg3eDwG2ywGyB9lUjzQeRq5jKKsewzefArEglxUPPUOjC5sgc+tFSjnheHWpKMUG4yv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728544; c=relaxed/simple;
	bh=20vf8MIfcOOTOyvo/9xRmTDvKyBmElpBdVToJq0DjdU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcOzWtqImG2TtKpmJNfR+MoFP/BvIIPeEQVQSDsDd6gYLxI4xCZriyvtMlCLYvkwb+EKQUcej43tihwcp8j3H6uQ/Y0d1jXCwBdIWFN58uRvSfJkM8mvcjsyhkuUuBt9H9f8FH6LRYqp2fVFRA24JgLgyMNBaFgYWcwu8LJxT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Ry6iG2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee130237a8so20006f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758728541; x=1759333341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/zCkLJ/tAP0MvUebDdhfKxISOr0VaRLT4RSkHZQ/bE=;
        b=J0Ry6iG2r/SifHFUCWPHtJZ3IX64ZxxR+0cnwmJiHyWVHvNoQFJzurF0RatrAlUlqV
         7iCq8Hu6S9A7N6sUoxB3NAwOm95kEetwkeyjBQYJuTeEuBL//z5VNbc73/U7JL76Pc35
         kpy4iFLJXY59QPX1vuNFF+X/c2chQu+g40z5rOkwiRKEreckxK3A/gGvWvobdu3nIh6T
         pNGkVDV4Nl5eEjCEemXAmoaATtddQww0uBod7gdb0XN5DZrh6NpJmdnpXbnAk+izvvNm
         f0Y3QmR5h9kBjNNk8rdRLQ1OHaND+i6ePj762aOpcwpcbdb+fcyHgjO2OfDnv9iIW/rl
         o6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728541; x=1759333341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/zCkLJ/tAP0MvUebDdhfKxISOr0VaRLT4RSkHZQ/bE=;
        b=oCE18ZeurwzxAhBFWx8Jsnr4oW+cJoBryP9RMiARo0C6HRhypvEsRuySzuTEodqvEU
         lmMz8+xcd/oK+IwNG2zOOPKzK/K1sZQpGITQ/fENvO7y0xVPH8yZSOH2COcFw8VwSbce
         cd6ykVsuNXOJfdViaGL9ex3AkfwWwGImmFGQPNCvJjCPntagsMhiYEoPGWKASTCcmGEP
         RGWPIMbcVYDdD9YitGOReS5nq9xpteQUyvOKRbS3xGAkI4Q/9H+vsPRqI7VGbxQS36RH
         rPT/Wu5SqFpxqibPUHAbldq0Gp8cLiL3NosDby+ej3SiVuGM1hy8wZbiTZqC5AB4H7nt
         WKOw==
X-Forwarded-Encrypted: i=1; AJvYcCVLBHu44xVGqj7hVON3a6A/t8caPq+4N0Bv5Tmj/CMgdFMOl1nl3+bbLlDRCUlxBOokeWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKL/jxbF1Xuo3/POs0wfWilPsoTOpB5iUp69n7cvc33+eFIhF
	xXpn9/vfBFydyzohs6hq+9a5dY9j2Lertq6bEVFpeFxdfuSY/bs1BKCa
X-Gm-Gg: ASbGncth6Yi3Chmfm0TTkovwluiZL6U16fDWpith2IR8jCAV/KEB09f0JQ66UCxUU6L
	RvThy5IK5cDBKHVSxLlCY79JtqI/DrMVaCGf35BnwkTYxQv5Bw9s3aNt02Ko5ypRC0ve/5/m7iP
	z86wR0/Die3SASlbi1han+/X92r8gyLZ/TZXDqyLcROZF3HPk25kgGVygUWlfVp+Vv3+njGWnWf
	SVB+I1sZcRARkctPQkovH0JEuKchkGWAw7h1TLRgNcc6kCB4Dq7oP6qtCwxaeWnG2JZ/wFvWFSV
	yyW59mNL49HcKRMn+rFUWqPrJFhuOXxwmuicLC3RymHMA+NFav61cZjXJJ0MSdebMgs3GEUg
X-Google-Smtp-Source: AGHT+IGLTOf1jm7exVsmcXsctHj+zPS0JPgI2KUuGj0PB5VIe8D8ekaVPCFkj/mn7VqohMIXLmygfw==
X-Received: by 2002:a05:6000:2404:b0:3ea:e0fd:290a with SMTP id ffacd0b85a97d-40e458a947bmr353578f8f.12.1758728541123;
        Wed, 24 Sep 2025 08:42:21 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm36596225e9.20.2025.09.24.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:42:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 17:42:18 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: mhiramat@kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-ID: <aNQRWlNIno3ThMkv@krava>
References: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
 <20250924062536.471231-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924062536.471231-1-yangfeng59949@163.com>

On Wed, Sep 24, 2025 at 02:25:36PM +0800, Feng Yang wrote:

SNIP

> > Hmm, can you also dump the regs and insert pr_info() to find
> > which function fails?
> > 
> > Thanks,
> > 
> 
> After testing, it was found that the stack could not be obtained because user_mode(regs) returned 1. 
> Referring to the arch_ftrace_fill_perf_regs function in your email 
> (https://lore.kernel.org/all/173518997908.391279.15910334347345106424.stgit@devnote2/), 
> I made the following modification: by setting the value of pstate, the stack can now be obtained successfully.
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 058a99aa44bd..f2814175e958 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -159,11 +159,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  {
>         struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
>  
>         memcpy(regs->regs, afregs->regs, sizeof(afregs->regs));
>         regs->sp = afregs->sp;
>         regs->pc = afregs->pc;
>         regs->regs[29] = afregs->fp;
>         regs->regs[30] = afregs->lr;
> +       regs->pstate = PSR_MODE_EL1h;
>         return regs;
>  }
> However, I'm not sure if there will be any other impacts...

nice, the test works for me with this change.. could you please send
formal patch? I can polish and send out the test [1]

thanks,
jirka


[1] https://github.com/kernel-patches/bpf/pull/9845/commits/11b31cd465a83b8719cb06331c8e81794cca40fa

