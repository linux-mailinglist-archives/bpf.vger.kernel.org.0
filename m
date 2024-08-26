Return-Path: <bpf+bounces-38049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF395E92C
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 08:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74432281D01
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18F83CD2;
	Mon, 26 Aug 2024 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aUnzGn4y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9983CC7
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654378; cv=none; b=VxAH11GVCEm0wa0LRfAGLb9ueceTd3lUGlgam4J04wNT7fA7tzHon3nym5+h5Z92quJ+asGEcwveq1HznMw0Un/GnI/azod4uB6/0xQa2y5wOITQXpZUMLlZ8Xp+HTBTd0nZBS7eQxO3dthmfQyFGu26ZvtdU29anX5t7e2HxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654378; c=relaxed/simple;
	bh=e/870TQ7HwPV2iLPH2TiK90/3Q7uE2tY3HFzQw/CCaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvWB7h1bs9ASCTqTLJxwsODjkij7OiMjYdKM1bAoFaw8AZaWapafGQOzHqkHgBvOKBijI5ywmGSSlpSYJTcKWmXAHD5dN7N676B3GsqK2CjKNddYtJ2RaT02FHk/Tw9Cw4bvl3n5pDUZcDwGPw5D+TRYnCp7pjboU8miAt4PnQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aUnzGn4y; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f4f2868783so33710001fa.2
        for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724654374; x=1725259174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqsGTE2o3cnmLgcfuE+0UrEVh8CaMk/60Wk442weXOM=;
        b=aUnzGn4yBFqhzJl1VqGb2p7U+IHSVP4+l5+Xorin5HtYUJFO8ZBF5ne/1DYzSCpJGA
         d+g+bm9ySkac4papTG/pJZlYHuzlWa9x83Fzh+tZ5pUfpQPydIg/rGJjpcGFCaFhmy6H
         j7XU5LjywuyGWn6cDE8A9X/LSLtAKUzHyOlVBKAlh0PF+aelnfHda3mweMIf2shu6AG1
         hYQv3wtcbVvBhs5MZXATjymaw/vfqA4063FSw5MzQh2IBwgvMEb1FfvMPgJk0S/Geo/C
         2I7ZzW5Ny0eNHFtkcWHzkjxPjRe3QbiLAV5T2kYg+321+vTo57HkqxvnLv0GtuoAlPBR
         i86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724654374; x=1725259174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqsGTE2o3cnmLgcfuE+0UrEVh8CaMk/60Wk442weXOM=;
        b=CjJztSJt+PEGBRqiYwgUvKIbtUmwa9jSDZ4i0eFe4F4ovNkejza+knZZANbHErzOC8
         i+xwrxv/+oOOrevwYVhSxFvdJyCoH+9kwDuAUIxqfIPYPSsI9fE1bfvg644RK1Qo3ous
         y00O9K6kkaLcldUazTKdF4RyyGoBtSMrjOHLDu4r/0HmxJghnuTsrhP040irb9YH3sxq
         AV0WXdFyzkXhJt3iFKBTqgI8kLtvNzjk2QWXeC7w40yvyuUVY0vw1aaAg9824bNmM1oq
         aUwM10hE+ROLnIT7k4BPV9BjaqJdf8PuEykp2kuz1zUei1eCAj/c4QGliXZh071K44AN
         DM6Q==
X-Gm-Message-State: AOJu0YzAD6FRbvhNXrvBZ9wGgMxRJVVimx1SMwrbUe3B30v9UzpY3/zC
	Dxy/pI8ierBsIBiIbRZEPl91qO/PlfnFLqLNdfJbJJ8zZ8434WHFBWdRglVckZg=
X-Google-Smtp-Source: AGHT+IFXtgT/AQH3sIcEUO6V7V0IenjL3znLmp3PlL0031EwwEatPGKdU/AP9QqxgNe60MqzR5kKgA==
X-Received: by 2002:a2e:741:0:b0:2ef:2555:e52f with SMTP id 38308e7fff4ca-2f4f4937bf6mr58642671fa.35.1724654374365;
        Sun, 25 Aug 2024 23:39:34 -0700 (PDT)
Received: from u94a ([2401:e180:8812:1b5d:e57e:cdf9:3562:dd80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b1ac7dsm8904786a91.47.2024.08.25.23.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 23:39:33 -0700 (PDT)
Date: Mon, 26 Aug 2024 14:39:30 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kongln9170@gmail.com
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Add a test case to write into
 .rodata
Message-ID: <wvgb7c67evkh6royv7jwzq6elcs3u3jvvivb7jo7h4lrgiwtfx@delzz7gse64t>
References: <20240823222033.31006-1-daniel@iogearbox.net>
 <20240823222033.31006-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823222033.31006-4-daniel@iogearbox.net>

On Sat, Aug 24, 2024 at 12:20:33AM GMT, Daniel Borkmann wrote:
> Add a test case which attempts to write into .rodata section of the
> BPF program, and for comparison this adds test cases also for .bss
> and .data section.
> 
> Before fix:
> 
>   # ./vmtest.sh -- ./test_progs -t verifier_const
>   [...]
>   ./test_progs -t verifier_const
>   tester_init:PASS:tester_log_buf 0 nsec
>   process_subtest:PASS:obj_open_mem 0 nsec
>   process_subtest:PASS:specs_alloc 0 nsec
>   run_subtest:PASS:obj_open_mem 0 nsec
>   run_subtest:FAIL:unexpected_load_success unexpected success: 0
>   #465/1   verifier_const/rodata: write rejected:FAIL
>   #465/2   verifier_const/bss: write accepted:OK
>   #465/3   verifier_const/data: write accepted:OK
>   #465     verifier_const:FAIL
>   [...]
> 
> After fix:
> 
>   # ./vmtest.sh -- ./test_progs -t verifier_const
>   [...]
>   ./test_progs -t verifier_const
>   #465/1   verifier_const/rodata: write rejected:OK
>   #465/2   verifier_const/bss: write accepted:OK
>   #465/3   verifier_const/data: write accepted:OK
>   #465     verifier_const:OK
>   [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
[...]

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

