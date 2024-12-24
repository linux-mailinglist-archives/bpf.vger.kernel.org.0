Return-Path: <bpf+bounces-47595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872EF9FC109
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 18:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBED07A1D1B
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589A212B35;
	Tue, 24 Dec 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjgHajkx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8B149C51;
	Tue, 24 Dec 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061600; cv=none; b=u3uCS8mCAeQ+xF9Q5aqbVOMLVn+IvHBdDxGQwIJlQGyHAHzMz3zRP9/8X+WyanQPol0H+x2ZyPaja+1zXMxBkF2Td6OPiuJ4E0qWwOs4Ovlbq7jzZisdvQkQmVqnzmdjE0DCtfhVXHf6xPPPl66xv7wFlEW7FN3uTAG9FF/WF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061600; c=relaxed/simple;
	bh=/snrGP+ljyyESNAw+z48HKXTRQfHkm1Xx1PHQ+IHS18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVQqxdsXAx0el0vgdsSO8z/aJ1EmAH90dOUVx/784MQjX3/mKilPAQttb4v/ZRadhs7/cYNrvPcnhuWCBsFUnKNtHvSbWYhyJXqVDHJBwvzr8jXGbk2O7VB7AxPh+SkKeTmMmwsjLif/0Uqypb2D1vEl7hv6y2XbURjevq4Obzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjgHajkx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21649a7bcdcso56146255ad.1;
        Tue, 24 Dec 2024 09:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735061598; x=1735666398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TUjb/Vf/+7BERE1Vbq2MVyWvD2wcMcLAENxGIoIAZzo=;
        b=kjgHajkxS7/JjEin+1SlvXkYOG3/WIucqNaXo2MlBCL9ctlGIQtIT9GvEMw45d6R5C
         8vhnPEXPQNdFqz2dUfFkSi4OmjybWPkbpZW3PyE8dJCeY5/BnBB+S1DPu8a2r21iNZm0
         98+CXX6WcRBTXe8sk9FAkQpIJJoEs5MSli7aceeT6cMnzzGx38Nk5v+TW2o2puWXCyeg
         5jUd61diYVcmTgOHKb/PdJgUG2jx+5fSjLLDpFWcj3xlujMB9nNdQc4XT7UXuwZUx9c/
         loIvqrpqBuTMO21Wl7miNfUVcH9Hu8azZy9m4faxuSgfAerQYso4nBwQaXp/8DBlf7B8
         W8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735061598; x=1735666398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUjb/Vf/+7BERE1Vbq2MVyWvD2wcMcLAENxGIoIAZzo=;
        b=UI6BPqxYW826w8GO7Ou/jO2Z3cwlzbmPtiiVJtfR7p+R+wR2d2ZoY2sS/A2uJ8t5Ev
         7S8R3Hr2SuuC1u20W/2OYTqzU4kLNUcheuRQv8r2c9UmLlhmE+vGK5PSHzEuXmkXoD5f
         BUR4yREgbseuDSoKwAy/w6kGVXMm/ZEuC289jTVBUEz6BrwM55Sq246/O5zMV1Ml+P/7
         NwoJijvSKrVADdejXikVyLwZRgk9N/gjGPOx3+llpDj5P/BV2zKdmZhZbNl6g7RiHcXD
         JqJFMTSbioBZuG9RBkvci0yw3j9Rtr7tDYlten5196DclEllwEeROdkBeIAdtVqS6Bfx
         IrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkZkntXUCZ/WSaGi4Zz0TNuxR0HsbLungAaOUPeeiGIhsg9MAQilF+rjbIBDu7taA6S+s6pk8c6BX3q6G1@vger.kernel.org, AJvYcCXqm0Zar9e7sQrm6Oan1z8Uu0Mo4/zzlIlzRSVi+rbk+YyQdt1tZCeQjM1VO+7fAX/ESs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLzf2BrP2shZ/gUO2eQZvEttA+IJfDw4g6SeibiusGrvX/vb5
	sGLrw0jRcqvralZ7S5FlIOUEf4M9HblJ/xC+YVtSzfvXP6LnLqs0aw3emw==
X-Gm-Gg: ASbGncvC/3sCbDRvF0TJPiBm4inWK92NuRSh0qLv9DfZzDUC8eA/rdPfDEt9EEV2Wyy
	fLMfw/7m+eA7bLj9Ja5/BkN1NvaTOjzRtqBBm5+5YK8BKL9MGET/8o2HQQmAaotlX5t0WEqE6wM
	E5ztsRYHeKz1CX2IXqh44iMC9BWXQsY3+ub9C0NoOLzFsPyI6tX9twtkdYZzOwtZBUfOkffJVjN
	vOPBgwr/6iYcpw1/gLK0vgrxzgi6HRp/AQ1M8zrif8qpXSLsIdj5b/8
X-Google-Smtp-Source: AGHT+IEw+tLzX88TucEceIPG20P6ylXm/8RKmNPsl8vCHkKLGsnRhWUNaYfAtzlCuALrA+fH1J8xxA==
X-Received: by 2002:a17:902:e5cc:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-219e70bf156mr210978605ad.46.1735061597680;
        Tue, 24 Dec 2024 09:33:17 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6285sm92386665ad.215.2024.12.24.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 09:33:17 -0800 (PST)
Date: Tue, 24 Dec 2024 09:33:15 -0800
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
Subject: Re: [PATCH 01/10] sched/topology: introduce for_each_numa_hop_node()
 / sched_numa_hop_node()
Message-ID: <Z2rwW_6idRAKp6nJ@yury-ThinkPad>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-2-arighi@nvidia.com>
 <Z2nTkshW2sUmNLVA@yury-ThinkPad>
 <Z2powPXbWlZqzU6r@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2powPXbWlZqzU6r@gpd3>

> > > + */
> > > +int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
> > > +{
> > > +	int dist, n, min_node, min_dist;
> > > +
> > > +	if (state >= NR_NODE_STATES)
> > > +		return NUMA_NO_NODE;
> > 
> >  -EINVAL. But, do we need to check the parameter at all?
> 
> numa_nearest_node() has the same check (returning -EINVAL), it seems sane
> to do this check here as well to prevent out-of-bounds access to
> node_states[state].

And I don't think we need to check state in there.

numa_nearest_node() can probably explain it because it's an exported
function. But your sched_numa_hop_node() is an entirely in-kernel thing.
Kernel functions don't check parameters.


