Return-Path: <bpf+bounces-38048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395D95E92B
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 08:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF09C1F20FE9
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFC78C98;
	Mon, 26 Aug 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JY7VdMjG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAEA77104
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654331; cv=none; b=poDKY4HdhnAisd5nMcKCbKABlHSILMfjB1OXczICNQp0T62l/lQi9285W7ZHa2frFulW9/N8vIJ1TOw1GlPDx3WiGuVvTkSillITJBdLdGts0yHj44Yh10bjWaIkE8SClzdT+ZrDOBtRGCRJ2JzEBCmewivfc7+lbGL5DI5YAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654331; c=relaxed/simple;
	bh=vXbnw4Udsn5y9pQHPsmWZw6G2ky7/vw+wXKrkww5EAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0NSHdKbCLryyI29OpeNmJZW0T5eDZvc6b/3MJnvqMKWcJunO9cnLrBrB0fFcEr9L5C4TH0vF5P5oJPhA6gZoJXfYEolpYZ/Nfb2txXii5Z/IxeJ5deiKhrDV2CpzT/0Mugr+pSBYSgdWW6VYkNLVFdych2kC+pHkZ9l083Y3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JY7VdMjG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f5064816edso13618941fa.3
        for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724654327; x=1725259127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=deXNWHin9iHMfwOFWZZTdmmhFltgFZQ30NCTP3efJ/c=;
        b=JY7VdMjGZgrjIzeaDa9IbJiPbi1IeC+6A77hlxNNU5z2hZlciXnEq/lFKdVJozFOZ2
         2EbEF0WTMc6+YD0KRXAfSs3rFRmT991L3tRKeK4GNo6Aja6soTBZbHEn8de8IWr4dBB2
         /hR4HqSauBxNpUF2Xv9I4JlcRU/12oU66jtNLnfTGse1+7syhOwJhh4ULJ9vgvw7KP9Z
         0h07aAlCwhpaBmoeyeMxGHjS3P5jSeobOmfTWuYXw92LTX2KP9ca9ju49BWPpAaFi8IL
         UJqeqhMCSjPY11B+RfQOF4za5auMOvpvhmYI8kO6gHzEsiGfkIuzalP8T1UzvXgTKBxY
         7Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724654327; x=1725259127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deXNWHin9iHMfwOFWZZTdmmhFltgFZQ30NCTP3efJ/c=;
        b=OwWB2gokpdIVVEol9E1kOWTN0OiyWDF5fUbPrF4IbINhWYTlKU1OlhPxtUolN+hHp9
         03OnkVpyTlZn44DIyloCn3TbX4VmLTDLPaSMsFj5xCrsS0U/oybr3vc1j00fRPa2Yf4P
         lzinnH3BFXRQrRoMQzdQeKj0JASladcW8BsnlHOE26kpPRgDKzJFjQ51RKaw3Us6//11
         UNRE2zl9Ag0HUvN8V7on+saf6g7BU9yG390+OGpc9XTr4AGGDe0VZ+CmQDd9HKLViDje
         xwdkXLUM0Qe7fzHrBIaKHavNiIslWn1DL6mKgr9yNDNg+fYX46Uv/aisZqSlWL/adri8
         BsQw==
X-Gm-Message-State: AOJu0YxRD7hJgkYnDbcM0CdmBHcwC9+yVWtwNTvizw5+YMiKZRqWgXw5
	IMm83XsdEmcDeDSU+84wkpUnZPHP4rD1IxgUKHNE9X/1uHlvZTO8Js16dSYh2Ik=
X-Google-Smtp-Source: AGHT+IFB/zu2WLlBIMf2pLP9B66y40FhqF3JtbG2+Mq9GevjR/sVZ9XLgKYr8mNF8h3ut/Tl6YSlsg==
X-Received: by 2002:a2e:743:0:b0:2f1:563d:ec8a with SMTP id 38308e7fff4ca-2f4f4945386mr60089521fa.41.1724654327449;
        Sun, 25 Aug 2024 23:38:47 -0700 (PDT)
Received: from u94a ([2401:e180:8812:1b5d:e57e:cdf9:3562:dd80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613921a33sm9033202a91.20.2024.08.25.23.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 23:38:47 -0700 (PDT)
Date: Mon, 26 Aug 2024 14:38:42 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kongln9170@gmail.com
Subject: Re: [PATCH bpf 2/4] bpf: Zero ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
 args in case of error
Message-ID: <z6ibywiho7uinssscgezwmqh37r5ujy7wvdz55654b2bdwsvq4@ddckgf6yl2bm>
References: <20240823222033.31006-1-daniel@iogearbox.net>
 <20240823222033.31006-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823222033.31006-2-daniel@iogearbox.net>

On Sat, Aug 24, 2024 at 12:20:31AM GMT, Daniel Borkmann wrote:
> For all non-tracing helpers which have ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
> input arguments, zero the value for the case of an error as otherwise it
> could leak memory. For tracing, it is not needed given CAP_PERFMON can
> already read all kernel memory anyway.
> 
> Fixes: 8a67f2de9b1d ("bpf: expose bpf_strtol and bpf_strtoul to all program types")
> Fixes: d7a4cb9b6705 ("bpf: Introduce bpf_strtol and bpf_strtoul helpers")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
[...]

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

