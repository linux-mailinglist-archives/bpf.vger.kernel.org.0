Return-Path: <bpf+bounces-23290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC72C8701F0
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C81F22B5C
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD373D963;
	Mon,  4 Mar 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/gFyWTp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1A3D555
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557329; cv=none; b=F41PyqjjrmtnkblIOty6R5sIPTAdqzI06UMFakmvPk1NhR1uSGibYQdMqmfVe7Wh6OICVTKwR0b2pBybHTi69OhatBlCoLWxEiVbYTJXIUZAQxSrfOCuAKKITeGI97uEhXsjg0S15vGfaq3CjN/lPZiRzhSroYok4DPK9uUUVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557329; c=relaxed/simple;
	bh=QqH2KnWFLqxpG5B4aFBPQ0iQ+M6Ls3KRzEdS47EsRUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYixObSQ06tSAQX+94dLjcaGMbfAZQ1cyWecvcWl+Ssd2NrHV/9Yw/RdaK4DaFornfcx5Rt5O/fn9rdRECVQhuQf7eMb5qsB2o1chLSrGGtPIw+VAGqvxqmGn/KlrtRvxR7ftBjLKcMICVz4oZSdK15tmPzuFdF3pj4f99rh4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o/gFyWTp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412cf3c5cdeso17205645e9.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 05:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709557326; x=1710162126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a84/4uqqJhM7gOiloziWXmFL3J+LSry0nXQzQ8TxAac=;
        b=o/gFyWTp8PhEgzuJzoHezsMxwUvzFaFbuKiGY1iLtwR9e7kwic5YzxMH6FY+9lP6Z5
         n8tV26gmshJ1JlbpOEjDs9aSQVhhr7zLYo3UTI3gfDET6YLpzwm5lFCnpolGhpMWtCoQ
         VW8Vuoj9DXatwAOdkZGdTzyam5FvsF1r5IZU/lzXBxFCfnztyK2FghbAsklIrCWrDWjU
         MSmobeC6jhgHZQZuYJCol9/dy/PMxDLzZx/vyhcN2HDmkT9ZZ4fWo7Ak5M9Z+Ntn3k3k
         /5cNH2V8Qc+4wf0vcuvArDdtyFfbbdJiC1abLcsKMplNA++BPr58sachD6BBbrYRY4wj
         A+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709557326; x=1710162126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a84/4uqqJhM7gOiloziWXmFL3J+LSry0nXQzQ8TxAac=;
        b=RvmTCXDWb2sttLCNtcBmXpekLsXiRQE/jQqddXolxNWkXiFrAgNZ1spuJSskYA3MY8
         TI+m3BoKCOYt4DNEKhK0LTREcIUnI33fBGCYU+iB4SvQq/b5oztFcRgRzkcqv15gaFpk
         MqOZSG52FA5PylmJEX7HKlwdVMcDEUUlbKQShMT9o3J9K8KfaU7XOwLUf3QdT49EExiP
         izWz8Gzy7YxyJMIYHD0UZUXnHDklewPzryj1LiIX4tBVqjxD1ex2ZyJh3v0Dx0ElMsAc
         vgG7efeXofVvcGR3cK9MN2Do1/E/DhSlVThlTfUuuryZE/5bBuolwypSa6mTrNIWCxv1
         9TXw==
X-Gm-Message-State: AOJu0YzQxM3TBFcgZOuBBlTez1EAuYjJNKsMA7FK9DTeJE50OVRtefIW
	OaCKQ12l2X/ePZyFWhNjc9yeJ0oPeS4v4SQ948EEiVuYIlo5s6qew4umDuljM2k=
X-Google-Smtp-Source: AGHT+IFQlB+tCusVhE+FdH46GaC8gIHK9eLzYSpDo1oGmBpiVJEphyJiDp0uLD46KRBkj8lhO1+6kw==
X-Received: by 2002:a05:600c:3512:b0:412:9eeb:fbca with SMTP id h18-20020a05600c351200b004129eebfbcamr7684112wmq.13.1709557326033;
        Mon, 04 Mar 2024 05:02:06 -0800 (PST)
Received: from hackbox2.linaro.org ([2a00:2381:fd67:101:f4c1:e8ff:fe8f:2fb2])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b00412b2afb2c8sm17228496wmf.26.2024.03.04.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:02:05 -0800 (PST)
Date: Mon, 4 Mar 2024 13:02:04 +0000
From: Haojian Zhuang <haojian.zhuang@linaro.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH] bpf: check mem for dynptr type
Message-ID: <ZeXGTP3ZIFRPGFCG@hackbox2.linaro.org>
References: <20240303023732.1390919-1-haojian.zhuang@linaro.org>
 <07f7315efef78b7a19dec16b59b74b15f7b97dd6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f7315efef78b7a19dec16b59b74b15f7b97dd6.camel@gmail.com>

On Mon, Mar 04, 2024 at 02:46:06PM +0200, Eduard Zingerman wrote:
> On Sun, 2024-03-03 at 02:37 +0000, Haojian Zhuang wrote:
> > When user sends message to bpf prog by a user ring buffer, a callback
> > in bpf prog should load data from the user ring buffer.
> > 
> > By default, check_mem_access() doesn't handle the type of
> > CONST_PTR_TO_DYNPTR. So verifier reports an invalid memory access issue.
> > 
> > So add the case of CONST_PTR_TO_DYNPTR type. Make bpf prog to handle
> > content in the user ring buffer.
> > 
> 
> You are referring to bpf_user_ringbuf_drain() helper function, right?
> Could you please provide an example of program that fails to verify?
> (ideally the patch set should extend
>  tools/testing/selftests/bpf/progs/user_ringbuf_success.c
>  to make sure that intended use case is tested).
> 

Yes, I'm referring to bpf_user_ringbuf_drain() helper function.

Yes, I should extend bpf/progs/user_ringbuf_success.c. And it could be
loaded by bpf/prog_tests/user_ringbuf.c.

But I failed to find the binary of user_ringbuf.c after bpf test cases
built. And there're no binaries for the test cases in bpf/prog_tests
directory. How to make use of these test cases? I failed to find
documents on it. Could you help to share any tips to me? Thanks

Best Regards
Haojian

