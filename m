Return-Path: <bpf+bounces-72716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637BC19F35
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 12:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 675E7501E24
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3232AAD6;
	Wed, 29 Oct 2025 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOGFpQ8d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FAD324B25
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736446; cv=none; b=G+EuPinl9z003MObRGwm5o3ftl8cEpxU0V6HVJBtunkagg7Tvpk1tuh2dIgWawh4M/yqWzwiILA7leScvyg4sdJVjb5jhEhVAara9QZQ+CM/EMs+ERRp5PjWz66vR2dxxWgdXrkTOSCuTy0+ZCja96omiX6GC61odNra89kaKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736446; c=relaxed/simple;
	bh=dRMgEAVrbLB6t767VUoWXvx7LGiIWpYgs3DMBhXzxII=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKKL8/gUG7U25DLDfcrcsx2Ie3KmF1qEIm8eLERedzwxOZA6VDgzda7CZtuotpRTkZNKMMuhVbv0evA51mQCOQo+UPwgwJdTAZiWqG3KnXcA/Y0DeZ/o07ZQAaK8fqr/z6ApfmcyJQ3qQi/IWnsg7shQ8d/uHnjMrpa02F8Xgrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOGFpQ8d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so40096335e9.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761736441; x=1762341241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cExzyq1+DdekChO1jhj7ZSGYtphuWQrDzLW8j//bDCs=;
        b=NOGFpQ8d4deZZ8xRDB2G++xrJPmaFu1/dYtYetB8bM9MkghiLwlM1gPwy6D/ky1SRE
         zXED1ANYYpFFtkCdswuwUs6kLBF40WKGwBhnWQS189WCwPDiH2IkkMec/07Nm53xjM5P
         yetSYZFeYhm07DLrCprDWJyNfobGkuzapjtKtipSDTu0B07geeDVywsm7EhnpvRqdEjt
         CvI3sbQxo63LFh6vSGQSN06FiVwLWpVHW5SwZVKll21bQLkHKQewOHns0jNPzsJ/PwgD
         9YhmZnIXv0DSo9gCzlzUNp87aN4Fi1Ams/Anz2kDXewIhtJYFQocPHCClPzbRled3gsG
         H5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736441; x=1762341241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cExzyq1+DdekChO1jhj7ZSGYtphuWQrDzLW8j//bDCs=;
        b=QxxqqbLsJW6Gz8XtycKcd9N1LRiem2l73P6vj2ABXIRW161UHC6ncUOGrGZpMVitM+
         yHIqW8JaMD7XRoSpzb1UcGLYKeGDAusHoDDH/+gebffli5i8CMsNyetpZ7NKSkfTJ+NE
         WFu8IRqJ8ZDa7mW/7dNulwnskuiHpXWN6IQ7vrjlBKSoUxP5n4ucL2VD4peJBy6iumAE
         bp0OVrK7kxvvQEQO47SCRYPvjpVuxAoDYtsaDBObiWEjvmlhKATtUS98qcs+5jq0EhN9
         IUdlcw6GVePytynH0MpBgCeX8ICaidBHER6z8BUjVmYUtqekG5Nx11/FIm/E55Yy5D/7
         DOZg==
X-Forwarded-Encrypted: i=1; AJvYcCVSMh6ifyDiSSnfN1rY89iRbxSpGxXFx0t/lH7UTTCvchGntGC2s8kQLmFGMdx7ldrWrHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxScsGd5lnPS7ZTwf42bSSb9NWJ84WY1ui+SfcKjAZCLr2tQHhu
	AiNi20kuAeWtTEGfmHyxtVowE4fsxopKct6MhvS6B4bnFn1DH3XADoHI
X-Gm-Gg: ASbGnctn1K5QwP3vGDKoVJnHtr96XIK8qlvLUJwuG88ziLuwJSSEzSE3FNASQMEXBPp
	dvdlacGpGwhJ+umi82E7YT9wGelvq7Rr6xEwbj73P1cHLXVso5hm7XEdI7+7E1h5LCPBkN8S9Hh
	a3q1Sk54ES0/V955w4SB2++CrUHcn404LOFnC+Z9L6xvZcY88GzYszmjLkVjnzJ76m06lgp20tl
	wAEWHcwk2Rjw3xlJzGKHMGp8a2oy9s/8U05trhCL7iwTTGoHO4X2jvvixYziAGqln2MUu97mJRs
	dBIXdqFzxnmQQ8JJC2vgzfK0Nso63qDPGwK0G1TwcrJKzWY9Fg1QtjfvyST8gMaz1w/RKpSPeAw
	SiBhBqgxZPCUWldGlcIymXdQKFQndAkLBIz6Wwv64HGv7Kk1LAA==
X-Google-Smtp-Source: AGHT+IGh2i6URRWhV4v6iibwi6PKg5mIhn8IeEnLTzK+ExGgJB2BU2r7APSIyzP/bl5sdigj/wtwxQ==
X-Received: by 2002:a05:600c:5488:b0:477:10c4:b4e with SMTP id 5b1f17b1804b1-4771e1f59demr21695235e9.41.1761736441089;
        Wed, 29 Oct 2025 04:14:01 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm51661495e9.17.2025.10.29.04.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:14:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Oct 2025 12:13:59 +0100
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jonathan Corbet <corbet@lwn.net>,
	bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] docs/bpf: Add missing BPF k/uprobe program
 types to docs
Message-ID: <aQH293IIz8hvobH7@krava>
References: <20251028182818.78640-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028182818.78640-1-donald.hunter@gmail.com>

On Tue, Oct 28, 2025 at 06:28:18PM +0000, Donald Hunter wrote:
> Update the table of program types in the libbpf docs with the missing
> k/uprobe multi and session program types.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/libbpf/program_types.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
> index 218b020a2f81..5e7a202dce5e 100644
> --- a/Documentation/bpf/libbpf/program_types.rst
> +++ b/Documentation/bpf/libbpf/program_types.rst
> @@ -100,10 +100,26 @@ described in more detail in the footnotes.
>  |                                           |                                        | ``uretprobe.s+`` [#uprobe]_      | Yes       |
>  +                                           +                                        +----------------------------------+-----------+
>  |                                           |                                        | ``usdt+`` [#usdt]_               |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``usdt.s+`` [#usdt]_             | Yes       |
>  +                                           +----------------------------------------+----------------------------------+-----------+
>  |                                           | ``BPF_TRACE_KPROBE_MULTI``             | ``kprobe.multi+`` [#kpmulti]_    |           |
>  +                                           +                                        +----------------------------------+-----------+
>  |                                           |                                        | ``kretprobe.multi+`` [#kpmulti]_ |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``kprobe.session+`` [#kpmulti]_  |           |

hi,
uprobe/kprobe session have BPF_TRACE_UPROBE_SESSION/BPF_TRACE_KPROBE_SESSION
attach type respectively

thanks,
jirka


> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uprobe.multi+`` [#upmul]_      |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uprobe.multi.s+`` [#upmul]_    | Yes       |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uretprobe.multi+`` [#upmul]_   |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uretprobe.multi.s+`` [#upmul]_ | Yes       |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uprobe.session+`` [#upmul]_    |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uprobe.session.s+`` [#upmul]_  | Yes       |
>  +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
>  | ``BPF_PROG_TYPE_LIRC_MODE2``              | ``BPF_LIRC_MODE2``                     | ``lirc_mode2``                   |           |
>  +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> @@ -219,6 +235,8 @@ described in more detail in the footnotes.
>               non-negative integer.
>  .. [#ksyscall] The ``ksyscall`` attach format is ``ksyscall/<syscall>``.
>  .. [#uprobe] The ``uprobe`` attach format is ``uprobe[.s]/<path>:<function>[+<offset>]``.
> +.. [#upmul] The ``uprobe.multi`` attach format is ``uprobe.multi[.s]/<path>:<function-pattern>``
> +            where ``function-pattern`` supports ``*`` and ``?`` wildcards.
>  .. [#usdt] The ``usdt`` attach format is ``usdt/<path>:<provider>:<name>``.
>  .. [#kpmulti] The ``kprobe.multi`` attach format is ``kprobe.multi/<pattern>`` where ``pattern``
>                supports ``*`` and ``?`` wildcards. Valid characters for pattern are
> -- 
> 2.51.1
> 

