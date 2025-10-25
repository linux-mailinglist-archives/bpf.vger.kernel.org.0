Return-Path: <bpf+bounces-72201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 316EBC0A060
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18D654E3FAD
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C6242938;
	Sat, 25 Oct 2025 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZEX4CE+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECE25A338
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761427098; cv=none; b=elOQuALaBnMUHpBnXXKpdMvZNT3W5xjySeD200or+O8PzGR5uHH8G0XXEKmGMXEGVNREGBEgHXDJ9B8/DRP/nxQTmqYEv/KReJwjbFjsweWpfl+51JMX2dGXcuH0tUpGqTyV2VXZ/d8PLkKPk7piC87oUS7sMaW/vMDd2B26Usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761427098; c=relaxed/simple;
	bh=3bsFJNE4DE47AGrHwWCWsH5kkVM8VML79+gkO8TWy4Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgrA0ZKP0It4601xLgws+KrGRIsXk29qPPVKGwi2G3itLL6VyfLzHa53ZfIMh56tYoUmoWp3JtJLw/itg8VgfxwMDD2+7kjnc//nG6n5IfF33NuMNDj/39enmDe0UDrP6+DeOKybsVuEqQalmXXH6iBJ9W5Q773DV0joTcBMnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZEX4CE+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710665e7deso16267335e9.1
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761427093; x=1762031893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3c1WBcRxq8wi3EgsqQk7zV+qxOcJsiv7FtZH/pCDIvU=;
        b=mZEX4CE+Evz7rK6n13uoO+oaBt/vTGBXt6fMM7JWaD83VHSqUwqR8XS9AA/Ol8qIhc
         4GcmTV3pvquzRxqc2hPUKAsiT8jDcLxBsbBTf1V+HLskARyMqjmeRWROkDCf5VoRc/NT
         gyE6puY26dU+BDRxJriQfusveL7gHfG2lAMSWoa5CRsbQkDUAzZOrYpQVvfW6TxlfLWF
         39Vex8olo0zFL91ltxC3ncEYXDLSlumoL0JPGv/gIEyNz33LJ0mtUnZwEKVTG64JNkgi
         DnjcdRQlnJdypsllSllkeo+c/+PV7PDeQGXB+ZEfNKr+oRJi45h5FF6zKVY2ngPbqoDt
         dscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761427093; x=1762031893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c1WBcRxq8wi3EgsqQk7zV+qxOcJsiv7FtZH/pCDIvU=;
        b=VKXbMwK8TQI52R4o4j6Ze1d13AkDx3M5o735NRJVrZz3sKUlR/tlFXw+Kg8oe5oSd1
         jOVA7J+EI/PvDc05ibTvfMdFWkM1v51euc7om7koMK3iM09xxgny6qNhCjagXTxBsiVT
         TNNM/q89pPZnVEK71Yrz+z6HaGkY3E3CGdcHLGKTouH2OHRSGZuidUcG4wATLa+Lyb6x
         M9OyPvvUEu/nrwG4VvDV9Hm5wG/FmyOiw+NBFwQJazN1mH7Rczi6oEGtG53fYk2W5olS
         9/yC1MR6SEFgjc7wHyXbi+Rwp0xTBtRjzyXo7h3LzHUqzGFUUiuVHBhAggr3QZ91U4UB
         A6JA==
X-Forwarded-Encrypted: i=1; AJvYcCUU4UN9JSrBB73KHsci8vqfe7sOF+Cbee7GkAKv/OnttfdFY15c3WBmkNXmB1YFEAcCbR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqzXx3lINFpt+4I7RWYF+1c6mK1GEB25ZkCeQJy8ZqKuWdyn/
	ZPNdJ6phTz9ogN7DsSf//l3HYji2+blOc07QnkL7ixxj549nmNLNOt0x
X-Gm-Gg: ASbGncswPFu/7mNWHHH0r/zjh3a57RduqNzASW6Ai6d7pWumEJuPhL+HbRIYJZJIT79
	UOEDveNnwePPLbYWH4Lk9tafOQ8DXfglLX1fRz1GbaxaP+fPhKNscnh28/rm2vz5Lje8PvqoSIv
	t5558Eddpa09xCGMiKQBg4LzQyBi4GmX5c4ylEuneC3DDf77zrAJITexIpOyv3Z0MXz7MTmJJ75
	g3RvGFs9lNp0ER/VNHyJd6F1vIPjRXwFUTfoUZXmmQ2yMm4SfkzLkzXO8+qJ3cuKe4XWi19Aowp
	cGF1zrXxaQ1UxNhn4PPDCz5OD4LMetLyLTzkFPTDXRq5CHRC+ELksUouTdQu35NaD3/0wl/fdVJ
	V3YYKs/sFG20VyFLMUCM1ZauvbMEqJkS4EU+zFBSb1/k+cGzdJXKet+rdYF/oJOuFpotxzQh/9k
	4=
X-Google-Smtp-Source: AGHT+IEKmGV6iwycAf4O/Au0c79Uf5s26+e12RwvflkfNHz45yscxbt7voylHffu4v/BbZtKilFDgg==
X-Received: by 2002:a05:600c:64c3:b0:477:ad4:4920 with SMTP id 5b1f17b1804b1-4770ad449b4mr8309285e9.10.1761427093382;
        Sat, 25 Oct 2025 14:18:13 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db964sm5427322f8f.33.2025.10.25.14.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:18:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 25 Oct 2025 23:18:11 +0200
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	khalid@kernel.org, david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
Message-ID: <aP0-k3vlEEWNUtF8@krava>
References: <20251025184903.154755-2-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025184903.154755-2-nirbhay.lkd@gmail.com>

On Sun, Oct 26, 2025 at 12:19:04AM +0530, Nirbhay Sharma wrote:
> Fix compilation error in UPROBE_setup caused by pointer type mismatch
> in ternary expression. The probed_uretprobe and probed_uprobe function
> pointers have different type attributes (__attribute__((nocf_check))),

just probed_uprobe right?

> which causes the conditional operator to fail with:
> 
>   seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
>   expression [-Wincompatible-pointer-types]

curious what compiler do you see that with? gcc-15 is silent,
the change looks good to me

thanks,
jirka


> 
> Cast both function pointers to 'const void *' to match the expected
> parameter type of get_uprobe_offset(), resolving the type mismatch
> while preserving the function selection logic.
> 
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 874f17763536..e13ffe18ef95 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
>  		ASSERT_GE(bit, 0);
>  	}
>  
> -	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> +	offset = get_uprobe_offset(variant->uretprobe ?
> +		(const void *)probed_uretprobe : (const void *)probed_uprobe);
>  	ASSERT_GE(offset, 0);
>  
>  	if (variant->uretprobe)
> -- 
> 2.48.1
> 
> 

