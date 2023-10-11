Return-Path: <bpf+bounces-11850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA007C46A0
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 02:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B788B281E44
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 00:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5A38F;
	Wed, 11 Oct 2023 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bnV0DCKR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE5198
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 00:27:55 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452EC19B5
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:26:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-693375d2028so5611634b3a.2
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696983979; x=1697588779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mdeBYmV3Iz7hBYw8oNEhI6gNWC/shNZ9/fkqlI8Fj8=;
        b=bnV0DCKRefmUflgQkyrxnItazRMUPu2M/q4DavlYFLSJpv4A6TY0xfGRZILJL4cEp0
         hW+5uRIMxBve2WrifzvRT1uu7Pcx+B/GrgCK6ZuavfXuUvrHNYViwgJ3TeH0pM/+ZmJL
         DZ8NFVAidbb3qtjdNiviQbwvY8hRBg/5jzeRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983979; x=1697588779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mdeBYmV3Iz7hBYw8oNEhI6gNWC/shNZ9/fkqlI8Fj8=;
        b=a9Hv0gyxDm2WI4dNzR+elWuBVTIVpC8R/gCKUcXGle4FxAdJHfz2izGau2p2WZJJ7q
         Xku2gbTFggB2239tYy/x4JOSlAAYjyXNviGnjKDDThxoKAPh2kCIfJwsWBouaKP+DRbV
         eCQuJ86b9npvPDeVtgP9sZQby8Ud41Mo9Sto+Lk6dD7YTbcTZbdBT4DwY8QhVsbKrGhc
         KYh6LDbSm5TQ48HQCCLjnAF2UShzakEenlGcNQhScdHE4pf0oFJM4LUhgnocI9qKMjxj
         OLQ+wT+z+uLtIOJlcCYEp17lW4NGkfB5bPCJOdzb3+KM6BrZXMjsD311iz06MZfHzU5H
         q/yQ==
X-Gm-Message-State: AOJu0YzL+cBR585GpHP9Cmks65iUiAOeMFAMHQVo3Pdp3TWe/E54UK5D
	o5FeBLThEGX+MZInqjQ8NcqF0w==
X-Google-Smtp-Source: AGHT+IGbQurWzUeSrvjJAXJayp/LYxys+6GCRaoM5udwyGZn8Yl6aR5Ironz9eErZ12xTuOTAdhVog==
X-Received: by 2002:a05:6a00:b52:b0:690:15c7:60d8 with SMTP id p18-20020a056a000b5200b0069015c760d8mr25141187pfo.22.1696983979003;
        Tue, 10 Oct 2023 17:26:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a63bd09000000b005891f3af36asm10776300pgf.87.2023.10.10.17.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:26:18 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:26:16 -0700
From: Kees Cook <keescook@chromium.org>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net,
	wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [PATCH 4/4] selftests/seccomp: Test SECCOMP_LOAD_FILTER and
 SECCOMP_ATTACH_FILTER
Message-ID: <202310101725.0BCB9CBA9@keescook>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
 <20231009124046.74710-5-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009124046.74710-5-hengqi.chen@gmail.com>

On Mon, Oct 09, 2023 at 12:40:46PM +0000, Hengqi Chen wrote:
> Add a testcase to exercise the newly added SECCOMP_LOAD_FILTER
> and SECCOMP_ATTACH_FILTER operations.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 38f651469968..8f7010482194 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4735,6 +4735,26 @@ TEST(user_notification_wait_killable_fatal)
>  	EXPECT_EQ(SIGTERM, WTERMSIG(status));
>  }
>  
> +TEST(seccomp_filter_load_and_attach)
> +{
> +	struct sock_filter filter[] = {
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> +	};
> +	struct sock_fprog prog = {
> +		.len = (unsigned short)ARRAY_SIZE(filter),
> +		.filter = filter,
> +	};
> +	int fd, ret;
> +
> +	fd = seccomp(SECCOMP_LOAD_FILTER, 0, &prog);
> +	ASSERT_GT(fd, -1);
> +
> +	ret = seccomp(SECCOMP_ATTACH_FILTER, 0, &fd);
> +	ASSERT_EQ(ret, 0);
> +
> +	close(fd);
> +}

This is a good start -- please check all the error paths as well.

Thanks for continuing to work on this!

-- 
Kees Cook

