Return-Path: <bpf+bounces-30896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18818D456B
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 08:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6401F23246
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 06:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCCA155335;
	Thu, 30 May 2024 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR92Aqaq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FC143897
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049991; cv=none; b=rNlzH5IcpPdZbk0LZNwKN0OqqebLGARtUB1OJx6D1mlgUua3tcZLOSE3SzJSEsXVO1m+CCpSvoC0tmz4Ub/hqCsQbz6y1g9GlgWVMmATVNwnsj5PIRRIzzfejs2QTIqbWS1EVbmRdOuxbLajjp58M9czoKEwPl37laLTItRo5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049991; c=relaxed/simple;
	bh=snECerw4ZcTF3uBUVwM86A2uKEG3ujiYM90mEHA0oxo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwxzJiQi0dBvwrOQ9yLHxYUVbGq3Wgu9HQrDmEmLgGlS77v/C1tlqflg+RjfRbknrs2FlEjJv0A3x7Rd0yUt98T6m4gV7ULOUSfk7NEMxCBftG9POAdtjpZTTonkgG5lp6+IBwaY7FopVPP3RtTpSZiMTnM8+EzBenHMA4Dy1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR92Aqaq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so6267335e9.2
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 23:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717049988; x=1717654788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tB81vdYYLlcOexuwHR2H9iw76InYiTIYKN97CHf3v4I=;
        b=MR92AqaqtQC/VoeJgi1xvRqOxe6nYLCsWsCoQd7xS2g9QsTg5CCir2Z2YKOgYH8Zo6
         CprNaCPQuK2QbPhLCL33hlSqLD77Z6l+FniF0GeTWclfUqns1oW9n+W6xvULYPrQWHrG
         FdFDoCzsLGn2W6TtZedu8TJfdpo0qEsMHWxfT+E458Ogw+1WMAKeWFbbTdDOoXvmYLtU
         3G8VZXgYeF7GaITrM1W8hZM2q9ufaCodHuizDRTvMGqYwmYz4QwEqUJZmPqD4wLcWbDl
         X4VO1LjIQfqcjp0Be2Ns9l+wvh3NwNuj++Vu25tP/wqan+lf5yrKnPBqUE8i+L10FpB6
         sExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717049988; x=1717654788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tB81vdYYLlcOexuwHR2H9iw76InYiTIYKN97CHf3v4I=;
        b=QEPKWKj8KGz6zOzw3oRcf5Mb5gDT60iWeXbx10aUdUVp3jLhzoMOG68WUZ35PslFg7
         PIDYFynfMquaUn+kNg6kgbFo3oaf+Q09FqOs/3PLB0z16+eUasGqA+EzfXrD1A0l9wG1
         9nHCuxqxF3KkuCIJ6DBHtVMLtqYkz65x9rGzO7/d4XIwSj2vR8PQ7zN75ImbN+Opul2u
         Hq1co02dMS0M/7gEBcpTgznEFI07uo1+iATxFBlQbQrVdh8TxWummKEshr3LemwcHTiT
         m/5JMr9cs/G4m6g3yuzWUu5XieIyc4JOiP/Ipu35VJ42Z0aMT0yq5GQHLFfhUPOo4ZQd
         MdEQ==
X-Gm-Message-State: AOJu0YwwT8EeXGqzSAIBYa4ti5SlW52ZiJ9046zWePx7AD496OA//bS2
	CIaXN9u+2U30MbLZ9tWZJd0H4z819+XKSJuOEN8YE9HqLMkMZf0H
X-Google-Smtp-Source: AGHT+IEJJH27WdWzbLsETWukwE0gZyIfVy9RfnEni/1JH7+5LWDQxtprT8UQRsWjHMVrfbtEXtMSDQ==
X-Received: by 2002:a05:600c:4689:b0:420:1592:da3f with SMTP id 5b1f17b1804b1-4212781e250mr12790835e9.11.1717049987984;
        Wed, 29 May 2024 23:19:47 -0700 (PDT)
Received: from krava (static-84-242-84-227.bb.vodafone.cz. [84.242.84.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f9649esm16312981f8f.29.2024.05.29.23.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 23:19:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 May 2024 08:19:45 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf] libbpf: don't close(-1) in multi-uprobe feature
 detector
Message-ID: <ZlgagR3lXeropyXX@krava>
References: <20240529231212.768828-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529231212.768828-1-andrii@kernel.org>

On Wed, May 29, 2024 at 04:12:12PM -0700, Andrii Nakryiko wrote:
> Guard close(link_fd) with extra link_fd >= 0 check to prevent close(-1).
> 
> Detected by Coverity static analysis.
> 
> Fixes: 04d939a2ab22 ("libbpf: detect broken PID filtering logic for multi-uprobe")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/lib/bpf/features.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 3df0125ed5fa..50befe125ddc 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -393,7 +393,8 @@ static int probe_uprobe_multi_link(int token_fd)
>  	err = -errno; /* close() can clobber errno */
>  
>  	if (link_fd >= 0 || err != -EBADF) {
> -		close(link_fd);
> +		if (link_fd >= 0)
> +			close(link_fd);
>  		close(prog_fd);
>  		return 0;
>  	}
> -- 
> 2.43.0
> 
> 

