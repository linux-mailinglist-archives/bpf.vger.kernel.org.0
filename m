Return-Path: <bpf+bounces-47567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC67D9FB731
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 23:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464C6163F7E
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D91D619D;
	Mon, 23 Dec 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDsHMgxc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB0188596;
	Mon, 23 Dec 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734992884; cv=none; b=nejZFxvN9UHglFBjKHX9wYLbpVUBoQBsnDduuwnEtZ2b3q/LRP6UWA0kI8OdRMlObQiMsb6+SG8pqHKu728jXI9LNMg2osJbfl/sACm9maPAYqtATd6W5mtgeVy+mKTOtiFhrQM7GOY7H9RniL+r5VYALaul/05U5jwcCJD0y14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734992884; c=relaxed/simple;
	bh=oaffhKLnETu4abUceUpP2X2Yj+IpxAeS7c+9sd5/PIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF+5QHPn6R8ncJ/Dt7O0W4x/NVfRvpshP4JKYsIi0lGbWYqCPVQ2UzNWvbElDC4not1TO+QCX4PjyGXVVq//SxrtlQQg2xhDMjaQ3NEv4EJcSJEKCNoIRJAzyE7Ciq1fcGH/Ugetz1FTsxZT8xtRDTzjN3X1BGrUNVbrkw9ui7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDsHMgxc; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso4608771276.0;
        Mon, 23 Dec 2024 14:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734992882; x=1735597682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xz0/8C+bzVJfmHcdBdT86GN6AXXsNpcoMUWodDd+Qf0=;
        b=PDsHMgxcE+7GbJ8nSYLgzv+5Us3NuyL78TG8r4j1tz84ZbcSXchh0pTZcbLZeSpA1R
         CBHxtPZun78FW51XKuiaek4mZyd618Fto9fVgw7ghqnH0YR7FO9i3xq5fL/hO0d9thUa
         wxIX2ZondWTWozFyenOAWrcZs8VfgDBMiQFQiBojZBeOabR1oQy+sdEhPBTmZm/5SwrI
         +ycThkh935K0XSjXJ772CvW1MQ94sf6Xx3nI9JBIxzpNgk711H2sNT6Ifb/zelEcOUy1
         KMRvE2nOtlKcj0zxq/g8kngz8YzwN1bYfwYz1srAdsz2RaQoGSi6zPRH5T1G2k7FXAID
         HXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734992882; x=1735597682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz0/8C+bzVJfmHcdBdT86GN6AXXsNpcoMUWodDd+Qf0=;
        b=FK9R5XWkGXpbwKPz1G1NzNfotYow2l/Z/GttAY/YTUIAUlSpYf+4dc5dmm7DP6sRf3
         vjEnpgXWk8QV1r6dyFRLd241TrzemeYFBii8nFyt4CIOXR7BmbpxRqa+MeCZwZ3g3bWR
         R+XsQnfk/MnVKmjBvE+arSO8dMBl/TM616vSnysdsJIZVwDZ2E3DsPuTDXbYWHRNpQCI
         hd1wyvLaclxb00aGMig6t7ccFPdpPb3deNFKExixZhKvHFet0P7xQSsnOfSk3D6gUTOf
         L6UoWBhHqOvOq9O4znP4ysudweS/TCbqu6RLZ8Vk2fM5s8CtSO+SxuGMW8AqugynLgrK
         1vmw==
X-Forwarded-Encrypted: i=1; AJvYcCUKEmXQavbC2URA3aB85MXaxcZ0tHljPVZy3lthsDT2wDDiKMkZsoRBdPcTl86TPNmmTTJU+qbaomOtYkCZ@vger.kernel.org, AJvYcCWqrFB+UkUS8bwhORq5NViwJnX4HtqlSQuw67toxnlc+WR5rtXtSUMq5rtBKn1/mQWGQkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxjWsPHQjXKKcYvArjbAhvR0TNACuI8N4Bi/eAanghiBQ8VAQR
	vzkyDFnEuUE0rlW129hgpgEuh7yjQWgFZf22aC/S+VtKk8yf+fEpz6/vdltR
X-Gm-Gg: ASbGncs1evPbSGEt6GNCsBYBkNmIhggxA7MHZl14reaWrkxe+hFGk+27VE8fJRFZ9mn
	q4OL/MoAzfLRl2wdMRNKLOahmXrv98nwMrQ5LjS4n6nH1MT8x06/tJA99q2kqI+EYU0tJnsrUBz
	VGhtpwJxPPeXCMRnnx+EkPnrNdVHMH5V4A7ChWkuAjA5cwYCSJQXIzlY7991XBSE6cwJfll7hR3
	JKksFrIyFB9zUPPOtCZmYN+EodyRjw3ZYhtkVx3ZMHa2WVJMgulNeLAVqehHIjA9xnbJNKmWMGV
	oZmj3brjPgewCDKH
X-Google-Smtp-Source: AGHT+IFCmj3A1ekVAHZh/yMwrpEp1PE1b1De1n/S+7otkPEWNaFHpnwU/nz4K8XEjS90aB/t3o3rug==
X-Received: by 2002:a05:690c:64c6:b0:6ef:63cb:61d0 with SMTP id 00721157ae682-6f3f8115f87mr97477427b3.10.1734992882219;
        Mon, 23 Dec 2024 14:28:02 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7499b47sm25421197b3.64.2024.12.23.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 14:28:01 -0800 (PST)
Date: Mon, 23 Dec 2024 14:28:00 -0800
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
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] sched_ext: idle: clarify comments
Message-ID: <Z2nj8O12hnilYjjf@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154107.287478-6-arighi@nvidia.com>

On Fri, Dec 20, 2024 at 04:11:37PM +0100, Andrea Righi wrote:
> Add a comments to clarify about the usage of cpumask_intersects().
> 
> Moreover, update scx_select_cpu_dfl() description clarifying that the
> final step of the idle selection logic involves searching for any idle
> CPU in the system that the task can use.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

> ---
>  kernel/sched/ext_idle.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index dedd39febc88..4952e2793304 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -52,6 +52,10 @@ static bool test_and_clear_cpu_idle(int cpu)
>  		 * scx_pick_idle_cpu() can get caught in an infinite loop as
>  		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
>  		 * is eventually cleared.
> +		 *
> +		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
> +		 * reduce memory writes, which may help alleviate cache
> +		 * coherence pressure.
>  		 */
>  		if (cpumask_intersects(smt, idle_masks.smt))
>  			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> @@ -280,6 +284,8 @@ static void update_selcpu_topology(void)
>   * 4. Pick a CPU within the same NUMA node, if enabled:
>   *   - choose a CPU from the same NUMA node to reduce memory access latency.
>   *
> + * 5. Pick any idle CPU usable by the task.
> + *
>   * Step 3 and 4 are performed only if the system has, respectively, multiple
>   * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
>   * scx_selcpu_topo_numa).
> -- 
> 2.47.1

