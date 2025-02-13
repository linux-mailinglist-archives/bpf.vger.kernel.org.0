Return-Path: <bpf+bounces-51423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD72A34780
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD2016A194
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0B152532;
	Thu, 13 Feb 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwPfU1GO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9A14658D;
	Thu, 13 Feb 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460592; cv=none; b=ZIDAoK5lIE5JeA620ygTeuKEaY5qJ7xXvDO6Aq+OmoTCqCuL6oN50k0VEZfULI3DKc5ZP5es3ka7l5UfCqnOkIvWdKV1syDBT+jiqAIuVHY51Lnh7WaZEcCSRaTfDO5LgNAzTmCMoBpKNsMn8VZHA53n7pqAoARdsgragvDsU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460592; c=relaxed/simple;
	bh=an2Tkg2VdtHCLD1zMNFZ+7rsr+nYCgoj77j2nKfo4y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VipAg5GucIEyHIySTnL/kkj2GLicmwfdEQpuNvhe3ME5eghvoz3BpsvmTh8qY8lthBHaXnym91D/RACUx5Nee0Al0BRIY1Cesh5tMqBNUpc0aXSjVa004XTDBczGAKl+iPACJo6iZAlC8WazQYFyevVup4OCmdeBIhUxF6VECIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwPfU1GO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f7440444efso8912707b3.2;
        Thu, 13 Feb 2025 07:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460590; x=1740065390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcQVloAv2EBWUK1i2c2LG7Q/7kJgRUweSsPixkGeEdM=;
        b=iwPfU1GOeuh5YqOAmLnKH3q1og1jIhLp+DmnfXNy2YeOkdIqnxL/3g3TWWdivkkV7c
         1CqO46IeDjPAtQ9cj7b+Gs58rr/0dgjcfHtK3Ux7OS80vjb516O7rdbw0KL5BkAS4vLE
         WYUgyQ+k5HXm2KTJ6FszhCVWQWNHnKkT/rl9t3mey0vYt2s/oxXp1+ml1/kazw0Us+kR
         D8XWN77eDwEEAHU/cW4u+K5ReAGg/nnjm1N5oYI5vuUjO2vJ+fwmsr26udI1CvT0xHi5
         ZHo8bQVBqHXMGCYzHUDB6OGtmQkA5a/x4Kq6uky3UhUyGdlis8puYms/OwW9tW1X4W4f
         Ey3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460590; x=1740065390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcQVloAv2EBWUK1i2c2LG7Q/7kJgRUweSsPixkGeEdM=;
        b=h1KxyVW7aCnroH31ZL2Zmw5Nd7/t5A+fKUMI7BhKZtZ0GwksGB7dcz4fuLi6Fis1lC
         A8QXVQMn5yVrmSQxmrJIFrzCYSDM/+QNYr6u94rLq1ZIr/Sf1vH3zeMXSQczhANu0QZb
         wYMoAUimUInJdyLxReRmnVH4lL+pyFU2LZ7TEyPG1cijhH5tU1v5SOtpDsiJU/6Rlc1g
         9Cd3p8G+DqtH+w2kp+5DytGX8bnKya9Bt+DyHCq8C7I30p0zDnhZ+pWbhRQ6wfRTaH+w
         EZzjvRPUyWjW5jm6QrE92SE08kg5A7TdeNSThdyyrxvy3t+0qfWTCx3vHljRyzHY9WPk
         6l/g==
X-Forwarded-Encrypted: i=1; AJvYcCVI1HJVq7V8D2CuPCY81lW7yJ0N4iPZIsk6ZoFbXMWdSyMlEaBR4LpwNZzm64OmXSbskQ6b4Lsd8gIFAdVA@vger.kernel.org, AJvYcCXnpoDTaermkLs3yiSv48sbRAYUppgcqKzI7vVUKQ7r0Q2zTJmoMwI0tLdZNVLWU48ZxV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8H3xN+14ljF8CgGZ5k+A+FIFM4htHR4gtPh0mc3WX+11AL0A
	av3M+vdLX/WLgndtKuOy3id43+a7ZdPbEwgFsangqh5UnKEN2BHR
X-Gm-Gg: ASbGncsaRcGWNN2aC1pfe6SgX0ONAwuB0YGGPg61Veyg9ZoOrEHTFqyI+zL6Ww6YUeC
	xqeKCDhCzdh1OQQ6rK/eZbZJ38/L0lQ4IC3n1HHKESKPvkp3jUx2xzDSKlkwLZq/Q9FRmBsyWrf
	WgWTaAP653PIWZfZd0Sm871fU6I3GU1syc6WVfWAQqZex8NlJsS19V9Fr7+lOKS2sb0gNHm2IG+
	oYrzMRYlECovIi2avzXAPRhu5Qku8gYzwzESTSVEALT8eBqGWe3QyE9EfS1SmvITe3GG17Tqlcd
	PlDmWjlIQ/agfcs4Bp2XHucfmcyNinJ3lDZ0aq1dGDbejoHJiDA=
X-Google-Smtp-Source: AGHT+IGyYufuCrDeEXSxqbqutU4G5peorZyshwANBUZGcAr07nTicsjBih9Pi047QrzTWGuRV0nqsA==
X-Received: by 2002:a05:690c:7205:b0:6f9:88f2:b8d with SMTP id 00721157ae682-6fb32c7f40emr38445737b3.11.1739460589685;
        Thu, 13 Feb 2025 07:29:49 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3619baf7sm3366877b3.71.2025.02.13.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:29:49 -0800 (PST)
Date: Thu, 13 Feb 2025 10:29:48 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] nodemask: numa: reorganize inclusion path
Message-ID: <Z64P7OgJqPsPUMj6@thinkpad>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212165006.490130-2-arighi@nvidia.com>

On Wed, Feb 12, 2025 at 05:48:08PM +0100, Andrea Righi wrote:
> From: Yury Norov <yury.norov@gmail.com>
> 
> Nodemasks now pull linux/numa.h for MAX_NUMNODES and NUMA_NO_NODE
> macros. This series makes numa.h depending on nodemasks, so we hit
> a circular dependency.
> 
> Nodemasks library is highly employed by NUMA code, and it would be
> logical to resolve the circular dependency by making NUMA headers
> dependent nodemask.h.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

You must sign-off this patch yourself as well, if you pull it with
your series.

> ---
>  include/linux/nodemask.h       |  1 -
>  include/linux/nodemask_types.h | 11 ++++++++++-
>  include/linux/numa.h           | 10 +---------
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 9fd7a0ce9c1a7..27644a6edc6ee 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -94,7 +94,6 @@
>  #include <linux/bitmap.h>
>  #include <linux/minmax.h>
>  #include <linux/nodemask_types.h>
> -#include <linux/numa.h>
>  #include <linux/random.h>
>  
>  extern nodemask_t _unused_nodemask_arg_;
> diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
> index 6b28d97ea6ed0..f850a48742f1f 100644
> --- a/include/linux/nodemask_types.h
> +++ b/include/linux/nodemask_types.h
> @@ -3,7 +3,16 @@
>  #define __LINUX_NODEMASK_TYPES_H
>  
>  #include <linux/bitops.h>
> -#include <linux/numa.h>
> +
> +#ifdef CONFIG_NODES_SHIFT
> +#define NODES_SHIFT     CONFIG_NODES_SHIFT
> +#else
> +#define NODES_SHIFT     0
> +#endif
> +
> +#define MAX_NUMNODES    (1 << NODES_SHIFT)
> +
> +#define	NUMA_NO_NODE	(-1)
>  
>  typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
>  
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 3567e40329ebc..31d8bf8a951a7 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -3,16 +3,8 @@
>  #define _LINUX_NUMA_H
>  #include <linux/init.h>
>  #include <linux/types.h>
> +#include <linux/nodemask.h>
>  
> -#ifdef CONFIG_NODES_SHIFT
> -#define NODES_SHIFT     CONFIG_NODES_SHIFT
> -#else
> -#define NODES_SHIFT     0
> -#endif
> -
> -#define MAX_NUMNODES    (1 << NODES_SHIFT)
> -
> -#define	NUMA_NO_NODE	(-1)
>  #define	NUMA_NO_MEMBLK	(-1)
>  
>  static inline bool numa_valid_node(int nid)
> -- 
> 2.48.1

