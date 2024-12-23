Return-Path: <bpf+bounces-47566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF79FB72A
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 23:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40977A16BC
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 22:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D731CEAAC;
	Mon, 23 Dec 2024 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6BGfmrY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E835433D5;
	Mon, 23 Dec 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734992812; cv=none; b=Ejc9we7HpT/edRqOGGcBj7vcFoDAEnWjdmKQOxNldvWf96Fqj687Gjngqq7vuVIbNHRHN7XPVRIpxExJobzDPbMDc6Oujw4OmhLiZ7y7kfchsNRUUcv4c8aUwd0rcezFPSIwSwsfvnY/IRViX9ZZpK0tJ8tvuL79QiFkwC/eC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734992812; c=relaxed/simple;
	bh=fUypFC6HphtaPlfD0FEXlmjWj12raqixs8ILrIpMRKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLnBGq4kt9MQT3Encf2Jbnbtj94wLdFkGOHUiVi+4qiYsxzKPKkLBboEe5BmF9Woraw5HuyaXsHEQp2Cjr6fz5hlcLTY0y7lwMpMlXkcJe9ggxZfYsLO3ZrwbVnr/pQ88ovuqBXcW+t4M7ru745KLbVy2K2YQ1RpsAJATck6kYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6BGfmrY; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e479e529ebcso3705838276.3;
        Mon, 23 Dec 2024 14:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734992810; x=1735597610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tUaXpDk1Sgww0OqyHi1MAHDK4v28U9v9Mw3DUD7/7B8=;
        b=f6BGfmrYPV+lrcDoiJii5PaR6IsYebr/YM20kwhvtq49BtG9wkpajymM8qBCWVFd8B
         JTX7xw/r+HLofY8SBOi08r0S7j0VuYMyhVCmBcS/QBIK6s5jyjr6oq4+T+Hqg81D9cwO
         EVA1uPGdyvdcidqu9PXskjnG9fJ099oqKwSfZDbmVRfOn2ZJbmYBiitZCC1nxpyaAXco
         1WB9g3siWCBLWXHXLuW2g7GqBpFo2S0sjjeZdSyWiCPn6f9RjrrWW0l3KIRAT8vGlneL
         +Ql35nGysXtbkV7EGQU4jnWyNscctlNEYw7fYxaCsVUBVIEDWtoA9PGG1c/Vp1Qk0jvl
         adkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734992810; x=1735597610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUaXpDk1Sgww0OqyHi1MAHDK4v28U9v9Mw3DUD7/7B8=;
        b=UH7ayZuLpV5+9OHFTd4klk1xUrLX8zMtrDihTGHhGRLzyb3lalgZFUKbe4yxQYRG49
         GdIVEKU+UX3Is3PXSEnZ9MgDgAD4QrGV8tpiNMn/kaVjOHYT2jAfUA+iEcz1lNKF/xjV
         FLLIc8YgSRkN2IMx4NRGoik2/oPJSBO4rQzaJiwXPDyL0PDGn5iu19tTyW1+CMnme6ss
         UGVrDWl5q5icZuGwOEYV0JbMbJ4dlA3/0yjt//ZLsfqz9WeB4uhsbj902IVl1n85wKfD
         iu+JuLqaylLf3uMNRZHrIZQx91gtyeXNSmfioNv5zFDubJOpd9DwcDOu6FCYF1tYBKIC
         quCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEKeJ6jNPrxmYWNEYRjrH+hic/jubaQmsY7BuQMpm+cbTaym93DM5X7QWdrVSGDJZSwZY=@vger.kernel.org, AJvYcCWMwknTFr8X3l1ceniSdJNU7B3aaVaiiOPrYS4ApHEsSZJ8GWjAOQcTDZlr68WSYvtKbIiiwR2CVFpIrHQK@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXwFYX5G1WClHOLbvDMU/hZLS7rGZ9vYzMVCkARj0JNb6u710
	9RaQXqtTBCpZUb+hDAPMBeBNhpbg4e/oLiCUJzxnfftPoHvwWd6l
X-Gm-Gg: ASbGncvXsof/YX4TMI0rI2rxMnk2qxJ4RKS6CgxMslAwKBjJS9sJnva2eTFX8X8C+zn
	9wy0YrSQaUR8sJK8PxyuZKho8Serj5ncViueCzXEjixTViBEL1bpbrYw2xvK3wZggAm/CAD6tp6
	y34ff2eu9VePgD3gbDiH1eJwjQy3reY7UcrBEJl78tJfKnfgAlVWZET8tgwD0bi/FsIqet6Yhw/
	UKMhHoQMAXtfv3VdZi6vUr9JrOZJ/SD8qhqx4m76YBDX8F7Sn/eTmZ2mQeak1sYy/kobO+XIaWz
	sYEm6kM99jVspg+2
X-Google-Smtp-Source: AGHT+IHU5ELfdHjF5RjV9H5/QeELZxdVcLRUacsn5eOK9wiJVnl4ObMEJ8EWCECkF6p9SZdRgra5fQ==
X-Received: by 2002:a05:690c:7405:b0:6ee:7797:672 with SMTP id 00721157ae682-6f3f80d6caemr108866657b3.7.1734992810048;
        Mon, 23 Dec 2024 14:26:50 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7477596sm25159527b3.54.2024.12.23.14.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 14:26:49 -0800 (PST)
Date: Mon, 23 Dec 2024 14:26:48 -0800
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
Subject: Re: [PATCH 04/10] sched_ext: idle: use assign_cpu() to update the
 idle cpumask
Message-ID: <Z2njqApQccTHU_aN@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154107.287478-5-arighi@nvidia.com>

On Fri, Dec 20, 2024 at 04:11:36PM +0100, Andrea Righi wrote:
> Use the assign_cpu() helper to set or clear the CPU in the idle mask,
> based on the idle condition.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: Yury Norov <yury.norov@gmail.com>

> ---
>  kernel/sched/ext_idle.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 0e57830072e4..dedd39febc88 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -460,10 +460,7 @@ void __scx_update_idle(struct rq *rq, bool idle)
>  			return;
>  	}
>  
> -	if (idle)
> -		cpumask_set_cpu(cpu, idle_masks.cpu);
> -	else
> -		cpumask_clear_cpu(cpu, idle_masks.cpu);
> +	assign_cpu(cpu, idle_masks.cpu, idle);
>  
>  #ifdef CONFIG_SCHED_SMT
>  	if (sched_smt_active()) {
> -- 
> 2.47.1

