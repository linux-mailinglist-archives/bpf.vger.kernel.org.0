Return-Path: <bpf+bounces-39770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2E977388
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 23:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582611C214E3
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FE71C1AC6;
	Thu, 12 Sep 2024 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eILEPcnx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF31BF7E3
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176131; cv=none; b=YUM3GTzTB1Sm39G4+F9r+lArrCAAlNHvjVn2BUOiaZFVO9R0cmYn9U29SLpMmIPr4HY+VVycRcPeV9imuacZXXhbPQPEAdXWpc7qwVao5YfWOQXDyNhZNOwIoqC6XdmWKTx/XLZTBFXKICfw9Iro5QSaA0HonIx2xTGTXtQBg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176131; c=relaxed/simple;
	bh=TQawtmTUJgfQqSFgNjDib+wpBVm05rng4pvOeawm/ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stOYroHEXeABVf4/VNc8rD9VxlhuaWB43wrEAyd7V63EpHhQX4EAAWTUD+UmHCYoCfGa+87psK8yElErsgCwlUGYn344SVGxTfGhPyk+MIbt+bJKSAhy6LqXK+a1irNPk6Ac9PocTkB+tgTzsX5OJT4mUC7eNR/40hn5p/eq3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eILEPcnx; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5dc93fa5639so128581eaf.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726176129; x=1726780929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuU9UIhvXjSz78840FaGp7kb94KPeUI24x6/4WDdi4o=;
        b=eILEPcnxbcWGxW1bPxyXVTtgtCjVqE/m0WQPk0oWz0wn9KCYSRt57kJD9Dx6koEWYs
         ZSy6qInfjIoD0+MRhJQ9QdE8cznX7BwTYBONEo0py0hca2CA2XZ5yDYiQy1apZszl8QK
         pdsyyzmDhg1+eyreHRgSmC63C5UryBdu5fKfeceb30PLS8NY1w0kCu/6TIyzTWT7d6J/
         kHwGbQOSz+u+mnYCWmTZ5a6vY0MzgslxbRw8K+85aj20MW8Iz3Dp5MXtNghX+93lmu9D
         1BaicQuINKMLgCrpGV8QHayl+DuKcTchttu8qJaio5xq6i4AfpS9cU+E1hzfS8fDIijg
         jtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726176129; x=1726780929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuU9UIhvXjSz78840FaGp7kb94KPeUI24x6/4WDdi4o=;
        b=CmZZjpOs1//gPsNe/+AxJUcrcjcaZbn7bcv8ow0JLR37KuoYTSPZiX3dgzCL0w4TUj
         5afrdM71VKP4SHS71WyElhT5EAIeiIyHbz5B3RHsdGbFs02jEEhUajm8sb2rvDCHblw/
         SAKmTel/HJyJAOQQyoQZ4qaAfv1Szx089dt4FyNxpZy2WO6v0fbN+8gYwz12NeXtxsvZ
         PvR7fMzwzoMupJX4Df0BEiAhi5DiWTX2D/vIpcSWBAPz/dKa10Sgf0fCFfz5VfFkFZAG
         PtTeLbgXkR20DWoDPeGBTqIfDv1Dd4mGKi0tEuA8hRBH9cDkvwd9PjH5L3wKGtikue3K
         wfjA==
X-Forwarded-Encrypted: i=1; AJvYcCV5CL6MbU8lcWSDw8QMwl8kx+xXyT9pn8b0HpI7Dn5F8H0eLw1N3nLjTQSI69H/zCJpqmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNKf1BxJLDt8FsVYAwhR7Op/5s8dXcTVhnkoyoSdKhVfvDRiT
	lOePDTM+fRWnAOnZI8rGMDib5jKHsnuHlnudOC5on8Rjk8k/wb+JzI+THYEyFA==
X-Google-Smtp-Source: AGHT+IFkVoD/Nk+SYy04kMCW6WhfdrSdzd/PRUZlVwBXDw7def1QUPBiiqZ1N65kkjgIJI+qKHmPfQ==
X-Received: by 2002:a05:687c:2c2a:b0:260:ebf7:d0e7 with SMTP id 586e51a60fabf-27c68955c20mr593311fac.15.1726176129175;
        Thu, 12 Sep 2024 14:22:09 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba3ebabfcsm3299170fac.24.2024.09.12.14.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:22:08 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:22:05 -0700
From: Justin Stitt <justinstitt@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	alx@kernel.org, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v8 7/8] net: Replace strcpy() with strscpy()
Message-ID: <sp3njca35fg5drajiy5ofq5t6nfmbhzec3alsm2o4itsdispdt@e45zirwvovcm>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-8-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-8-laoar.shao@gmail.com>

Hi,

On Wed, Aug 28, 2024 at 11:03:20AM GMT, Yafang Shao wrote:
> To prevent errors from occurring when the src string is longer than the dst
> string in strcpy(), we should use strscpy() instead. This approach
> also facilitates future extensions to the task comm.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/ipv6/ndisc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index b8eec1b6cc2c..cf7c36463b33 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1944,7 +1944,7 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
>  	static char warncomm[TASK_COMM_LEN];
>  	static int warned;
>  	if (strcmp(warncomm, current->comm) && warned < 5) {
> -		strcpy(warncomm, current->comm);
> +		strscpy(warncomm, current->comm);
>  		pr_warn("process `%s' is using deprecated sysctl (%s) net.ipv6.neigh.%s.%s - use net.ipv6.neigh.%s.%s_ms instead\n",
>  			warncomm, func,
>  			dev_name, ctl->procname,
> -- 
> 2.43.5
> 
>

Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks
Justin

