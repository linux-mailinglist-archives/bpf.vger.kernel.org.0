Return-Path: <bpf+bounces-39309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DB9718BB
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 13:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC0A1C22C66
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FC1B9B2B;
	Mon,  9 Sep 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oc1eCbt7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD81B652E
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882725; cv=none; b=S+Bcdgc/Kv74MocXYcLwiD/8nPEMR9rtSC6S3HJyDXt/MKQvUu/0Wk9EjdLaW9J1vrLGcnak0jmpjFYBVIinj+wpJ5UNeH5NWY7PDYt/n6Jvq73bQ7Txqf6M5yiZxPPFgKQqjuxVUtYTxGDwLUNkn6kyJgyIB209G5kMm+I1qLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882725; c=relaxed/simple;
	bh=EiC8OQDhRuRRnspMrUz355VI1ThpTLym3dvoV13glgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSIzNcMOn+1csiYiE3Ap81w+6+kqxwEdYpCuMh6RBVh6YcCv57tdYANHc0rNP5fTp9gbVq7tffX6Ck5Dug5WetvtL9jSbkLC2HbGPUEwPnXTSE1eOeXfNUdLhj8F1wXZxCKCltETdpeQYBV6Jf0RWViEoGNhJrWvZAYDxdCbKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oc1eCbt7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso21074361fa.0
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725882721; x=1726487521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lq5kjTXazkMKiLd8iRoej7o/kDO4fOput9ybJCZQfQo=;
        b=Oc1eCbt7YmtevVACe1C1kNw8j9295MpmM2s9EYW/+YTVyqlOoO22rLaBQkMsSC3v0X
         oQ/Mh+oNwziyq4oDmKbgWPACCi/4BHP3wyy6uPNxvYaKxe6u4NORP37fc0QFt9rpsuEu
         4Ei/n/Mtyzh5RuLQHtVAdpYP2iU44rcqYaC7V8aYfs9xqOW1igpfVEHX7MbRNyJiQOzN
         BlW6ERBAWhfY5YzER73mnLD8QYEb8bza8XfLWBqD461lrgcLERygnY8yFMr60/eNJmsg
         uQPJlCWKOc9mUF0j9UHEg/tMzz4z6B9QaQoLS/b/qQpUZjKi10WXPzDv6R0SgtXSwNbI
         vHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882721; x=1726487521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq5kjTXazkMKiLd8iRoej7o/kDO4fOput9ybJCZQfQo=;
        b=f6ZFLe1vNeQ2vIASwd3yGWkaQCkpTnMtuejnIFKieBdMnkdxgO8plGd3IYgZXd6xtl
         T2szSREbLmdjYi/DThTeDB48ayeL2XmjdWhmaN31f14HQidYsXPlXBn+Qjmdz8UM8Oos
         Gzqku79SNFbEMochq8PYcOt78omc2mBkPWZEN+7cG3OygEqFiggUCd7PnjOhDPfO62Vh
         1Pl5H8Kg3AYUy8hSOyTDsCCtjeCxTtGFAMu/hzTT+d5LvIE7c0Mg+I58vtA1kKVZDnZM
         ClZ4WL3yMNgnnAmlJ7grt86/n82X8GKRycTAYK0ESQJ1Afeyyc+WPUFQPOnO2Ei+Tydf
         Syuw==
X-Gm-Message-State: AOJu0YwLWCEPXm/CktWq4gtr1E2pXliDojF1LDIUQ7qfIkT5Fc71p4u4
	KhXjRCJpWWMF2vkbfTAbzZ2AxRNkhJlQxuMbK2tYR3iefAPrQ7zNB73USMIS59s=
X-Google-Smtp-Source: AGHT+IFdaoJccYZZ2yEfkDsNa2E4IuN3airm5H9G53hmkVPTnFbd6dKUbvsKY3/zOsDpVqXpjLkl2Q==
X-Received: by 2002:a2e:a552:0:b0:2f3:e2fd:aede with SMTP id 38308e7fff4ca-2f751f5e4bbmr82554011fa.31.1725882720413;
        Mon, 09 Sep 2024 04:52:00 -0700 (PDT)
Received: from u94a (1-174-29-79.dynamic-ip.hinet.net. [1.174.29.79])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa76a6ad5sm139386039f.43.2024.09.09.04.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:52:00 -0700 (PDT)
Date: Mon, 9 Sep 2024 19:51:54 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	kongln9170@gmail.com
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Fix helper writes to read-only maps
Message-ID: <i4jixqefn3wb5vsepxcdarux7olysohgvb3yalm3reglovpesi@en5kud6i5xfb>
References: <20240906135608.26477-1-daniel@iogearbox.net>
 <20240906135608.26477-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906135608.26477-3-daniel@iogearbox.net>

On Fri, Sep 06, 2024 at 03:56:03PM GMT, Daniel Borkmann wrote:
> Lonial found an issue that despite user- and BPF-side frozen BPF map
> (like in case of .rodata), it was still possible to write into it from
> a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
> as arguments.
> 
> In check_func_arg() when the argument is as mentioned, the meta->raw_mode
> is never set. Later, check_helper_mem_access(), under the case of
> PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
> subsequent call to check_map_access_type() and given the BPF map is
> read-only it succeeds.
> 
> The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
> when results are written into them as opposed to read out of them. The
> latter indicates that it's okay to pass a pointer to uninitialized memory
> as the memory is written to anyway.
> 
> However, ARG_PTR_TO_{LONG,INT} is a special case of ARG_PTR_TO_FIXED_SIZE_MEM
> just with additional alignment requirement. So it is better to just get
> rid of the ARG_PTR_TO_{LONG,INT} special cases altogether and reuse the
> fixed size memory types. For this, add MEM_ALIGNED to additionally ensure
> alignment given these helpers write directly into the args via *<ptr> = val.
> The .arg*_size has been initialized reflecting the actual sizeof(*<ptr>).
> 
> MEM_ALIGNED can only be used in combination with MEM_FIXED_SIZE annotated
> argument types, since in !MEM_FIXED_SIZE cases the verifier does not know
> the buffer size a priori and therefore cannot blindly write *<ptr> = val.
> 
> Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
> Reported-by: Lonial Con <kongln9170@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Agree with Andrii's suggestion in silbing thread. That said, logic-wise LGTM

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

