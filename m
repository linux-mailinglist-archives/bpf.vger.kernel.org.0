Return-Path: <bpf+bounces-19617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7355C82F2B7
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 17:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAAD1F25446
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3B1CA93;
	Tue, 16 Jan 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ4pRd6x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA381C6A1;
	Tue, 16 Jan 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso8211063f8f.0;
        Tue, 16 Jan 2024 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705424283; x=1706029083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWIMOxwPuwlyypi9mGRlB1wNl0jlfrKw1ScuZdtPpAE=;
        b=iJ4pRd6xT/iZA0xUDuiNyKnNuxPjyrb+y0dg1DUodjolwttlJibv05ZLkLL6+3gKD3
         0zpkPkM+3JvxcVNrqIvpY5V5eOYK/2nrKPxQf83UIBkxMRebE89lvbcKsSn6TwyCzhXh
         NiuPFXkVTIZ9APRuDOrJOVWWQnwdrC5z/1yFImsAxNpYCcbtt16zBxjIhsLCFx5XMF0W
         lKP4f7WHj50jjsr4r92UHwYgOsOYCrqdJDY1paSfS6p3YCrx8HDA3nFkxrMS6aLqv/p7
         PVQ7tR6g5VQZXfoIOazul/LAqAFhDl+tNk2QOgvyJSXrxLsD/ctQpEmOF0mTFCmSnHkN
         2YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424283; x=1706029083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWIMOxwPuwlyypi9mGRlB1wNl0jlfrKw1ScuZdtPpAE=;
        b=Pn0GM/BnPhjvmGoo7LTZFwfqkPNI2QZ7NJylHmOEYw5BE8kDvwDPbDtJ265lkrIY63
         rDcnM+CzNFLRqhSwEyLCcn4OwBLCzgVjoVnaMoUCaxH3VwFNRwqrlkGu7y362xKKxaiK
         /RJzC/SYu8qb79nKqR7l4Q5b77xYsXmhT9Yaih6CDdumIvWqkLw1zR4b8WhFJXJG+52a
         fyZk/WhexuWFdhettmt6OZo7rl503/vwd35zXcWzzcjREvr+sndkM7a4mRWsjzrGcEd5
         W8eHzKhyF6xKXTVDbXqe7EJq04h0WULoRI2v/8LoEd4BF3U2nT6PV06TpxAlqULBgK4F
         oNoA==
X-Gm-Message-State: AOJu0Yy/oNVHxiswgEBPJIrqc2WWX+xWzsGvBg9BTyG4x/d6Kf9QLGSn
	LJVAz7S0MH1AYNI6dxFMH6U=
X-Google-Smtp-Source: AGHT+IEzI3h4gWrHRgRIUCmkOWf7L17Yh04pMYuuDkCdMR3c+TIBaC98FCnb6ejWkKylpXq7lzn3Qw==
X-Received: by 2002:a5d:5943:0:b0:336:608f:91eb with SMTP id e3-20020a5d5943000000b00336608f91ebmr2017052wri.95.1705424282738;
        Tue, 16 Jan 2024 08:58:02 -0800 (PST)
Received: from krava ([83.240.60.213])
        by smtp.gmail.com with ESMTPSA id co8-20020a0560000a0800b00336755f15b0sm15100243wrb.68.2024.01.16.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Jan 2024 17:58:01 +0100
To: Artem Savkov <asavkov@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix potential premature
 unload in bpf_testmod
Message-ID: <ZaajJVrGLakTmtH1@krava>
References: <82f55c0e-0ec8-4fe1-8d8c-b1de07558ad9@linux.dev>
 <20240110085737.8895-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110085737.8895-1-asavkov@redhat.com>

On Wed, Jan 10, 2024 at 09:57:37AM +0100, Artem Savkov wrote:
> It is possible for bpf_kfunc_call_test_release() to be called from
> bpf_map_free_deferred() when bpf_testmod is already unloaded and
> perf_test_stuct.cnt which it tries to decrease is no longer in memory.
> This patch tries to fix the issue by waiting for all references to be
> dropped in bpf_testmod_exit().
> 
> The issue can be triggered by running 'test_progs -t map_kptr' in 6.5,
> but is obscured in 6.6 by d119357d07435 ("rcu-tasks: Treat only
> synchronous grace periods urgently").
> 
> Fixes: 65eb006d85a2a ("bpf: Move kernel test kfuncs to bpf_testmod")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 91907b321f913..e7c9e1c7fde04 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2020 Facebook */
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
> +#include <linux/delay.h>
>  #include <linux/error-injection.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -544,6 +545,14 @@ static int bpf_testmod_init(void)
>  
>  static void bpf_testmod_exit(void)
>  {
> +        /* Need to wait for all references to be dropped because
> +         * bpf_kfunc_call_test_release() which currently resides in kernel can
> +         * be called after bpf_testmod is unloaded. Once release function is
> +         * moved into the module this wait can be removed.
> +         */
> +	while (refcount_read(&prog_test_struct.cnt) > 1)
> +		msleep(20);
> +
>  	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
>  }
>  
> -- 
> 2.43.0
> 

