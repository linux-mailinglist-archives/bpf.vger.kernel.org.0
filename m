Return-Path: <bpf+bounces-28475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192CE8BA105
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 21:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1B11C20CDE
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6D517B518;
	Thu,  2 May 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqNRqgeP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31F15FA74;
	Thu,  2 May 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677619; cv=none; b=V0iL0HR5poX1c+zfZ9ihGVUllHEQ5gzmFPS7jLhrHjL2cuNbDhlDCjxbXP8LLqZkhNVkdMCqkJrNcyB2v4EedcVWqQwA3nubgRa/GOEjX8701+OFWKO/mrWlJjtGZtC+4EPt28RzSh8EAxw5TSZVelaiHdTwqU/ST50UnzsS44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677619; c=relaxed/simple;
	bh=MEWa0OmxG6zCKvHOIRcQ/VXFBiLY5rryNnDHAF/xD5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajeOBze+ElIpnkk7/Pfuagil4OGmjdpuCQAPPfZJHje5pI9FVSoMjcTu06P6C0hZicZsjw7vYkQnZpzWpc4G+nIvyYsnRC2Xa1aLMT5BLEQXazrGKpgF+I0lxntGq2qhMLBwomePv4SCh4I0Wr7pZf5HDsgw/bmBUkHGteOqMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqNRqgeP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eab16dcfd8so72288855ad.0;
        Thu, 02 May 2024 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714677617; x=1715282417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kZobPO3Sq7Kiv2EReP242+eszjDQ0IT8WjWo7osu1w=;
        b=KqNRqgePkLZKsOFuyBAbiyRjHVyPL/7PRn1bW45fLL9NRcjUrywyMae2O5Z+JI5YQM
         vwuO0HJNoqi/dMW0RqoaOdchobaL0UGR2ycov9uXSDJJs8PPxseOC6CQGGpyzLWd8Rct
         zLBoi6wbI5EXr7+RMsO7SoRN0lIILBMf9szFdWpqlBPDnfc4jvAulxFQy3FN6MPfrana
         fGAzhvvr6j2+OALopGK3iMGqIhMWQbC0eMULoBDG6UhJEV5OBEIW4ITdoDCTyB0Waa4C
         2LBBxB4rtieJIqiGIGUVGD1oIBvHbuFo3FobzTo5lrH2MsYom/3mENu5NMl15HMxQU80
         Thog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714677617; x=1715282417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kZobPO3Sq7Kiv2EReP242+eszjDQ0IT8WjWo7osu1w=;
        b=pbgxwzc7xBu0XzQnRcXP4luOphyquO86HzUdsThUKs10kxgDXMusOERYWxMYti4Kyb
         2KeBb086CDJ3toWvy6ltOPPNEBDwFn6vhVoQZt1pR7CN7zYLOhZrwnDiKiUvZt1yEJzv
         ulPBaysZJYFJlASty1GEjPGg2C+chQCv5W4HDVnwdshugG5b6DAvgPz0MayYSsQCfP8E
         G8yxhQnJpJghWoNu8N4DUOPRz7tZ7EIRCdXwB5xBFHBGJ0+Vsp+nDz4pX5yFen74wNRE
         Cu6OQozzRjX4WT7xDXfVYPqYyGx6XjHM+2QbPtx9cDN/lt/LbrOY/BCBQjdZxXgGzbZc
         Y7DA==
X-Forwarded-Encrypted: i=1; AJvYcCUyamVwwK5F2uPEYhtR0yiqyeogJJZ+YHksFncCCQZ2XxUU8HhwLKfKWN8t1XIYM1aW4TImNr5Yx5C3AmCBYFmrnR9C0vD0gFALE6KaTD48XWi5RvZCNSjp5hpBia0jhRR2
X-Gm-Message-State: AOJu0YxlHA3a9X12SWjvGAelpgP56mfovDl1p6exMz5hw0PpgKfzSED/
	zhl9CjTCyhBg/+7KVmX108m+M6rcVPn08W69kXmmKxG1JmKJiKE7
X-Google-Smtp-Source: AGHT+IGdNs9k8PTPDPlJOQpSSLCCGovUGEi3uq+1GlQECEtX/2eQJn3W0PeLF5PDQRfjVcykQ8BqbQ==
X-Received: by 2002:a17:903:2cf:b0:1e5:a3b2:4ba3 with SMTP id s15-20020a17090302cf00b001e5a3b24ba3mr694463plk.56.1714677617529;
        Thu, 02 May 2024 12:20:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001e27557050dsm1678564plb.178.2024.05.02.12.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:20:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 2 May 2024 09:20:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
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
Message-ID: <ZjPnb1vdt80FrksA@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502084800.GY30852@noisy.programming.kicks-ass.net>

Hello, Peter.

On Thu, May 02, 2024 at 10:48:00AM +0200, Peter Zijlstra wrote:
> Can you please put your efforts and the touted Google collaboration in
> fixing the existing cgroup mess?

I suppose you're referring to Rik's flattened hierarchy patchset.

  https://lore.kernel.org/all/20190822021740.15554-1-riel@surriel.com

Rik spent a lot of time and energy on it and IIRC one of the reasons why it
didn't get pushed further was the lack of any enthusiasm or support from the
upstream community.

We can resurrect the discussion on that patchset but how is that connected
to sched_ext? One of the example schedulers, scx_flatcg, does employ the
same approach with a twist (instead of flattening completely, it builds
two-level hierarchy so that a leaf cgroup can be treated as a single entity)
to demonstrate the idea but the two projects don't really have much in
common otherwise. Are you saying that Meta and Google working on the
flattened hierarchy is a prerequisite for landing sched_ext?

Thanks.

-- 
tejun

