Return-Path: <bpf+bounces-76761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113FCC511B
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B892B30021FB
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2850630DEA9;
	Tue, 16 Dec 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="parRo7Ou"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792F26B755
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915913; cv=none; b=gRRYFLsxDZ5mQku0HrfrmIBied3Ago49w/zSgBr2Nypd479EoUFWRulFR3KCJB5A2w4LKXhFt5TLLZ672pbxG68b1zf5dbmuH897EvPNkUfYoOVW92MKLv6U2VwB3Lc1yQDpXhFRE3S62FVuOnrsBknKWbS9SQx3mAPZetlw4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915913; c=relaxed/simple;
	bh=FpxM3hyPk29sCv1iF5PmAbojrM+k6yMdCrXOhzo1jI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/MWQheHhoONWWjzKFOLETkidHchdl+LXKGG3BhmxiCpSHyXNKjwHL0FjOY9uzUIkOf+b8qLiy+9BikkoVYRTbTCO6SEFWkjyTyTJm9zR6Z2wl+VCMPiljEMKQ9dT8qXod6wliKULcq4zcAqw/QQnCrbZMjjbRMt5/9n06BPJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=parRo7Ou; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79af62d36bso943947066b.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 12:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765915910; x=1766520710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=54ooJGnVbDasg9v2Af3BmEEgOTp9LOE+tpQS3lIbkvY=;
        b=parRo7OuTudpcezM7UZpQHqiyhRq6LmtPsl4+cqN8Qqw90IyDY/QiukiuVft4UH7bl
         n6Y18yAgoxJM89Iki86ICXQ8ZXcF2bsbHt0BRhP0QUuh2xISn96cxPWsniJwdnVAR7Ls
         BOIJWJYC42kWq3RezVrVu/czdBhlmMIDZuORk/tvK+dYWIWF+8AFIlKRlfgZ+CUYLVoq
         KkN7+MOhAZLiW58cR+HpD5IfNqxDnpacxN0y/o14OaJPDa4TmMDvYwzBat8vis+bE4d9
         AiCDau4TGsOoN+sF6MHda5ps2G5zh7IwlDepFKpWO1fy4oTi+mOLXLnywPgCnRhkQD+y
         dNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915910; x=1766520710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54ooJGnVbDasg9v2Af3BmEEgOTp9LOE+tpQS3lIbkvY=;
        b=K2WAUb83PU/W79yLSeRPAD02y/gv+lYcadnNpf9LzKTXrdqRvbEoq3aoua9RyPQFkw
         8Llp0YgpJMBD27EWX72+4CrKIWb1EXknYX6dwSzJ0oPu1zKXkGUUG9i1wIenzcLUiSnx
         MTRaxx70VoxknRe5OQYWUwqIPoQzQ8K2FtBwv6oKjGNHyqztLr7J93wmdBZobeaUEWXp
         VDrR36GGPWgSRxhhzrDNHdVN0LrxTJtUJbwHE8wAu5kFUmASd+TRknkb3wEPhY4eQKZB
         KYadwYj4pG6kN+5DyCg+VpBV0TQ6Q7xCK1Boq8u3OERH3W0EkLM3U7xjkDQuEDC547zc
         yHwQ==
X-Gm-Message-State: AOJu0YyzmUHSfNkzQWghBBbAs9Z0jBMcgAbby1A9nS9V2Q7y1Y1IPM9r
	L7uOAilAKxg9ASPJ3PEEI06xCeD+RGMh7KC8g6w4WD9YFB601+5hrUpaaHMM/9rPLA==
X-Gm-Gg: AY/fxX4cYsiWv20ImLrqOzVkwCdnIhUb4C34YTAs9bRix7LIxUtasVOtvgp+dPSL39X
	01clkPF4orZdCbYAcbsD8ljYqwP46vmDb6WrisLSAikwB/1+HUd7uM6TNllM/K5NT1o5hNBUDSp
	H0aLg5vZfcM7JOnO3HIfMlsQIfeVFpwYSXtvb4DzsmRi1mJA+z2veiSnoHS4dznKZ0KY5Jrqi+C
	R6TC6t37s73lCVp95ahBslHW2bJzegHEjDq9nQJ6xPrMEkXmnuNYs6Q6Dk3zFWvoFcLekJD1kRn
	E+PP7ev1V0w1YlOOFOUg2Q/beWSUFeeAMYF+wffTGoH8v6q4dgQfrXR0hcQQsbD0dKb4MExG1RI
	I3/1YPy62OH5Jfspn9EZDoFnZQPda5mSWQGqJD+AblWXrZbL2nR5yHdnafr/Bk3e83WxQ+wzJNS
	w49/iGC6HYJdLgP0T4G9yQf3II4v/gDzawmlaPm0OqxHI4sTk/szrz7ddG
X-Google-Smtp-Source: AGHT+IFxckSOf7wn4FIHPPwbvLTIVfww+EINhTTT0re3WN0EeISjNgG7BgV+RmafOwul9iCd21MhxA==
X-Received: by 2002:a17:907:d94:b0:b79:cb08:30e with SMTP id a640c23a62f3a-b7d23a9c78dmr1719514966b.58.1765915909988;
        Tue, 16 Dec 2025 12:11:49 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa51759esm1729802966b.35.2025.12.16.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 12:11:49 -0800 (PST)
Date: Tue, 16 Dec 2025 20:11:45 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: annotate file argument as
 __nullable in bpf_lsm_mmap_file
Message-ID: <aUG9Ad2bGNVShE4_@google.com>
References: <20251216133000.3690723-1-mattbobrowski@google.com>
 <CAPhsuW7cnX6G+YJf-W=RizoZf75286H9vmgh98VGe=kEhh6NMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7cnX6G+YJf-W=RizoZf75286H9vmgh98VGe=kEhh6NMQ@mail.gmail.com>

On Wed, Dec 17, 2025 at 04:45:34AM +0900, Song Liu wrote:
> On Tue, Dec 16, 2025 at 5:30 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> [...]
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 232cbc97434d..79cf22860a99 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -42,7 +42,17 @@ endif
> >  ifeq ($(CONFIG_BPF_JIT),y)
> >  obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
> >  obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
> > -obj-${CONFIG_BPF_LSM} += bpf_lsm.o
> > +# bpf_lsm_proto.o must precede bpf_lsm.o. The current pahole logic
> > +# deduplicates function prototypes within
> > +# btf_encoder__add_saved_func() by keeping the first instance seen. We
> > +# need the function prototype(s) in bpf_lsm_proto.o to take precedence
> > +# over those within bpf_lsm.o. Having bpf_lsm_proto.o precede
> > +# bpf_lsm.o ensures its DWARF CU is processed early, forcing the
> > +# generated BTF to contain the overrides.
> > +#
> > +# Notably, this is a temporary workaround whilst the deduplication
> > +# semantics within pahole are revisited accordingly.
> 
> This is quite tricky, but I can confirm we need bpf_lsm_proto.o first.

Yes, agree, but it's an outright "hack" at this point. Note that I'm
also going to send a fix addressing a shortcoming within pahole, as
per this thread [0]. I'm just waiting to see what the BTF experts have
to say about it.

[0] https://lore.kernel.org/bpf/aTlFKI2IeHQ2-TSE@google.com/

