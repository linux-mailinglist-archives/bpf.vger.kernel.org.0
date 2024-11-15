Return-Path: <bpf+bounces-44937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032A9CDBAF
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 10:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3849E1F23492
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1D190056;
	Fri, 15 Nov 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg9e0gUn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3818FDDB;
	Fri, 15 Nov 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663281; cv=none; b=cJQHuS0ydLtuNcywmjlpcAEvgLP/s2EB465V70u6LbNR8RLkjtKv5fIZ06eWrKhfF6hxCveZJHxEBg6cT6J1qu4h08puwGaDqvuu1J35jbQ9ZhFc3Rr4vwpaAqxX7QqP5aIfzJHJvFMXmqFR4yY+4NiYT97/AP2lULAerrw+j+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663281; c=relaxed/simple;
	bh=WtmG4Vkcl7Z6XOh0kChSiuBh21pZ/wDtQ7qmRnedq/g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBTDzA5pKwv15JhDhkpk+pRoEZBsZVMn/YKHmwAhF5kNDPeW9lyJMmcW4GmHsUaRRqvA3QQACuS+W5NyNH03hAf2VbUvm60J/W9deYBBH5x5TfMZZNjXwktH5WcT4LI/5afp0BD8fU7U2eJpolecgh04mmr91SVGXZpFrzapvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg9e0gUn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa20c733e92so69747766b.0;
        Fri, 15 Nov 2024 01:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731663278; x=1732268078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MX66+aEET0Wug4jq+LlfR7APokjStdY3uwRIUrvs+1g=;
        b=Fg9e0gUnqB2hc0HTlQYhAtHwXlZ50k6Jqbpgtoad+EQgIiqe1+oPuEkq9Ib3X+ijKS
         0bsmP5CefjtjO8OKhdAA6Jyt/5fBJf88tYidqwytGtbeO10fBo/VaKWHR6LnO9+bBOjZ
         bUNTVVJ3KudYGhHTF2zslkZWs7XTLosxgjrueN0xaFhNuGIbzhj2aO/7jt50P1bVFr0U
         GeAB1pYVslhynmWI824fb0MUJJmAQGTkgmJbmJ44vrsJMqVbZPQVptAk1DSXcI+rvhM3
         fmPmUVJSHkHdb2JZ9qCEIhu1NNW0lkldZchbeFMB4jNF2s7SF/xGH3SNzQMmDPaQv7r8
         cgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731663278; x=1732268078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX66+aEET0Wug4jq+LlfR7APokjStdY3uwRIUrvs+1g=;
        b=lt9Etl7+Rdd/8z9iLefy/w2aediW8QwdaOfYekxBT2IC8eedTa8kHeCNarayTUxMnV
         iwFuyGB+Xt/edeJEepLfr5p0JHS5zpI59i/AP/Qb1qrcy2S+WK5OBGuEkh1Tu2hcZeJA
         Ie2WVqu4OBKsfovR68hdlXz74zkd8H+mDvdMhW+pF+r3UlNzsJvSp4rISN0UNZSw8Sp6
         ICBbuvA9UQAcR6NOkV1x97Q1XRhlwKE890UDlER/DwiMBfSLcD2Tao6rqGaftucZDKrT
         ITBLXWxNOb6XuLZLu5E+KCeuvJ83AYTbQzBj2M9HgBRazfajXHNG5Gb5pp6jNqbPPusb
         xKHA==
X-Forwarded-Encrypted: i=1; AJvYcCUqwuicsOhd3uVI9falPCmznhNhwqcxszIdAQUfPGyv5QmVwlGPh8XiE01mmt4f7EwnBkPDt150aA==@vger.kernel.org, AJvYcCVVVeskrlSWSeoKPLtEOJ2Brvm/zbtHq0FGpyUe9YRf+ji5PLSh1Bfh+rC2jz6ZP6/vTw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdASA66Kp2TfX1RjYx3z3dljLd02B4xB1nXvQndO/1n6HXrdF
	UmBWqiQCJBv327EsmL1Ed4sTxYvttf3DHlybH2F5xdE5KYB3LL7B
X-Google-Smtp-Source: AGHT+IGrMqybB5jssKYeWnRPqQhqhyeYeLg/u6t6KCD93Nl8rEDXC/pZDwA8SzH6oD5DBeffxy3L5Q==
X-Received: by 2002:a17:907:9688:b0:a9a:1437:3175 with SMTP id a640c23a62f3a-aa48354c8b7mr180185266b.51.1731663278071;
        Fri, 15 Nov 2024 01:34:38 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e003ff2sm161775066b.123.2024.11.15.01.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:34:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Nov 2024 10:34:35 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, yonghong.song@linux.dev, dwarves@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, kernel-team@fb.com, song@kernel.org,
	eddyz87@gmail.com, olsajiri@gmail.com
Subject: Re: [PATCH v2 dwarves 0/2] Check DW_OP_[GNU_]entry_value for
 possible parameter matching
Message-ID: <ZzcVq8zcdFm0mNxJ@krava>
References: <20241114155822.898466-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114155822.898466-1-alan.maguire@oracle.com>

On Thu, Nov 14, 2024 at 03:58:20PM +0000, Alan Maguire wrote:
> Currently, pahole relies on DWARF to find whether a particular func
> has its parameter mismatched with standard or optimized away.
> In both these cases, the func will not be put in BTF and this
> will prevent fentry/fexit tracing for these functions.
> 
> The current parameter checking focuses on the first location/expression
> to match intended parameter register. But in some cases, the first
> location/expression does not have expected matching information,
> but further location like DW_OP_[GNU_]entry_value can provide
> information which matches the expected parameter register.
> 
> Patch 1 supports this; patch 2 adds locking around dwarf_getlocation*
> as it is unsafe in a multithreaded environment.
> 
> Run ~4000 times without observing a segmentation fault (as compared
> to without patch 2, where a segmentation fault is observed approximately
> every 200 invokations).
> 
> Changes since v1:
> 
> - used Eduard's approach of using a __dwarf_getlocations()
>   internal wrapper (Eduard, patch 1).
> - renamed function to parameter__reg(); did not rename
>   __dwarf_getlocations() since its functionality is based around
>   retrieving DWARF location info rather than parameter register
>   indices (Yonghong, patch 2)
> - added locking around dwarf_getlocation*() usage in dwarf_loader
>   to avoid segmentation faults reported by Eduard (Jiri, Arnaldo,
>   patch 2)

looks good, I got 95 more functions in clang build including perf_event_read
and there's no change in generated functions with gcc build

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Alan Maguire (1):
>   dwarf_loader: use libdw__lock for dwarf_getlocation(s)
> 
> Eduard Zingerman (1):
>   dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter
>     matching
> 
>  dwarf_loader.c | 121 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 96 insertions(+), 25 deletions(-)
> 
> -- 
> 2.31.1
> 

