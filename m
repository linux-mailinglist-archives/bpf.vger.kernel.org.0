Return-Path: <bpf+bounces-32636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5A9112A3
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6572825E2
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287651B9AAA;
	Thu, 20 Jun 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMkcJcQW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C81B3F2D;
	Thu, 20 Jun 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913519; cv=none; b=Ee6jeRvuq0pxZKLoWRS5o6neEkGE9dcjq4ZVZqbZkfQ3lM56oJloMhSpzmLD/f0k/UgvKoe/SidIWR1X+Nkg4ZccIC19vLBEHGVlhqCsCpdG/MbGgHfCraoj7tTRkwJbREY/xP0uY2IrmZOqjdqqrsqqzTC6o7U8nxRodXhHqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913519; c=relaxed/simple;
	bh=dVxfHwtenKBSjV9OfjRyhDKFNSv2wMV5nHOruqsGr5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5TpoBwB6Lbo3mESeU2Wd000Ul+mIUuKdwFqKfAi8WdGKsZQ8x2JopebbH0CovZIoYnsJOxyC0MOFAVia0FsbQFBl3sWkNVairDND+roGGbR07Cwe99D3YjPtVNe2katAqzx8d1lZPGEPybwbFRMx+THb5PlyXY4XXIy8t0d3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMkcJcQW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70436ac8882so1121452b3a.2;
        Thu, 20 Jun 2024 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718913517; x=1719518317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvYBhmIJQ6oNWDLzYCe4j2TV++2BkNYnycvPCo+ymfc=;
        b=dMkcJcQWEPyAGJNF+g4mM9heUYlx3I9nRuXj9eYYmsLvf75VA7Jd+8t2U1MkPtHQBi
         LC98Vrjd61R/tEA6jb3SwR/1xiQOH2ys5hgvXtObxWa1R3MPcPnvQY8uUSDqqG6nOovW
         RDx4C+Y/wlz9r4/cvNyPlEWht8YDGr0jVvuqPVYfeurshdlYp23Qty4vCxvmAN8fEKmK
         5cTlDkQac3Mypq7A4rBfJdBEafbg2WhoBbJZoZIcgOGJAVJ+YfnhEH6yOAUGz3qlQ/7p
         8LZeUbmAST+rzuSZP1W5t990Hylc0KKN5Lomv/4lbNUwBYfzjjWyrUU5xecLKrMx85bR
         fyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718913517; x=1719518317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvYBhmIJQ6oNWDLzYCe4j2TV++2BkNYnycvPCo+ymfc=;
        b=AsPNPESM8EGNCQjeOYnWn81VVVODpkZdMKcCY7QEhdtfI7ifVRPQ/PHYQkE37N8Nhe
         LEaupgHeiaW2pHVSXXgWS/VTg0eb+Ja8VpRyY7oNlZmsAxjUScujJayCha+4wOcu43WD
         iOoVDpCUm4iiBHaLgq8/KHjCca/CNsAfcYuIVA9lsutHaIjgMvL8HaNBOkxDaN+m876W
         eTeol6m1YAIiRJuEP/X594zHuiWQD0AH3VFv7Ky0KGVo6P5CtP4ail/q/PK5wKI6JP5+
         XHvp7sasEXumz/RLHKdZ9q3GgsH1IbgUZoNI9W8R6w0WLsqtGT1/6N9m3touG/8lc1ta
         dnUA==
X-Forwarded-Encrypted: i=1; AJvYcCW6j2g9p9zl6Y/kQi7Ulqc9G1niT/KOucUhDboBK21cIrsx23//J1Ejm78uTHVmpYTFF9DUEfauhCYEREM83BN7YRnqYZtKgpgymN/TUX4y01OQBKjk7kWruwbUvpoixmoy
X-Gm-Message-State: AOJu0Yxe8HWi7FuTCfT9pQnjZqZy9fCIq2K4YkVhZOMFPtizxiANmpZf
	bTSk1qeUppDK+tJVLenH8Gwi4jd/iwIcY+iQLWy+FzDDrfdWyR9T
X-Google-Smtp-Source: AGHT+IFMNYnp7v0mbDJ7mdFJWPxgcQ4HGv6x3IKaKW9ueMkmsnmWYImVH9+vuJQEIGrjlsc652DPog==
X-Received: by 2002:a05:6a20:6a82:b0:1b6:1ed4:e91b with SMTP id adf61e73a8af0-1bcbb5cb106mr6416293637.39.1718913517391;
        Thu, 20 Jun 2024 12:58:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511aa322sm35763b3a.84.2024.06.20.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 12:58:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 20 Jun 2024 09:58:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <ZnSJ67xyroVUwIna@slm.duckdns.org>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q4rpi2s.ffs@tglx>

Hello,

On Thu, Jun 20, 2024 at 08:47:23PM +0200, Thomas Gleixner wrote:
> One example I very explicitely mentioned back then is the dance around
> fork().  It took me at least an hour last year to grok the convoluted
> logic and it did not get any faster when I stared at it today again.
> 
> fork()
>   sched_fork()
>     scx_pre_fork()
>       percpu_down_rwsem(&scx_fork_rwsem);
> 
>     if (dl_prio(p)) {
>     	ret = -EINVAL;
>         goto cancel; // required to release the semaphore
>     }
> 
>   sched_cgroup_fork()
>     return scx_fork();
> 
>   sched_post_fork()
>     scx_post_fork()
>       percpu_up_rwsem(&scx_fork_rwsem);
> 
> Plus the extra scx_cancel_fork() which releases the scx_fork_rwsem in
> case that any call after sched_fork() fails.

This part is actually tricky. sched_cgroup_fork() part is mostly just me
trying to find the right place among existing hooks. We can either just
rename sched_cgroup_fork() to a more generic name or separate out the SCX
hook in the fork path.

When a BPF scheduler attaches, it needs to establish its base operating
condition - ie. allocate per-task data structures, change sched class, and
so on. There is trade-off between how fine-grained the synchronization can
be and how easy it is for the BPF schedulers and we really do wanna make it
easy for the BPF schedulers.

So, the current approach is just locking things down while attaching which
makes things a lot easier for the BPF schedulers. The locking is through a
percpu_rwsem, so it's super heavy on the writer side but really light on the
reader (fork) side. Maybe the overhead can be further reduced by guarding it
with static_key but the difference won't be much and I doubt it'd make any
noticeable difference in the fork path.

Thanks.

-- 
tejun

