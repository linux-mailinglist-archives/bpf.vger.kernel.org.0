Return-Path: <bpf+bounces-67637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58510B4660E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3D33ABF58
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2530102F;
	Fri,  5 Sep 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FC+s6T3B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6E2F7468
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108465; cv=none; b=l6bL+XDq0QRegDCyRN6hu3NlZ4pxSWrSp46P1+EsaTeJ2v49I3yfwA3QQsbKVhgfWVN6UjKqqzgwziGZ8wsmLdxokgzhAljy/zSnK2f+epdPUSscko6dqh+z0v6W+5F3kb0wQvA6uu1gLQ/DKv/usp4/FvO6w1bDIDb+/CvhMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108465; c=relaxed/simple;
	bh=EISgDghY/knXbNwDvDGK2KSaNFpugS1NjVBQvkSH1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnrPfS2l7H121/K6vTHpZFeBWyphSpyfJ/xyAUTQX+MavblVe8s4ByNkK1jmn04qucGnzpNfZHMou9Aa1hso1nxRzFL5y5taB5cTy8vVETvsXswJfq+OWOWrcGgTkSlAeuOHprmin9Ql/RqutmVHm0lsoI1l3LL0VjBi9oqypo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FC+s6T3B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b2337d1bfso57295ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757108462; x=1757713262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ/emNLCJz3vxOzQ9R3rq9Yl2yjJO1c1zooZAILHbKw=;
        b=FC+s6T3Be9OhbfE3d46wlRbNypqlcHGfaR3fU5bGf9ZyZZ2fmGWCSbQb8rlZzeCopj
         pjofAdVG2MdF0FLFJNlh06l1AmQhy0a4E+kRIKUgBoRZssqSbeOHgvo8vu7514bZHzPK
         iDT+AMRi0oWyCNR/ccVAKWZKlLYIgihTf0MA6nv+onyUu+RUvcXDwHJ727YGTjOItv0X
         dPVBLYEr/8muy7TKkxfBC7ig1GE4nqlEcJTYe9jyEuqO296rAivFxzq/b+lBSBHrxoIQ
         GgNavhIfeBMjXK+1dBa645uzHc1zrm5STYCy4wgaq4yAN/kfLWnwDPyvDSipNESsqV2n
         CGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108462; x=1757713262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ/emNLCJz3vxOzQ9R3rq9Yl2yjJO1c1zooZAILHbKw=;
        b=wPvSZOId5CNRqso/BaNOCDkm2sZA6iouSFutYidBNcQQFF1OqOdjg3nXDlg0/Diyy8
         3ooWGGTs8iaZBLmFgol7pKgSDzvCShxmQUp6WAyFGDVt4PHVfrqk1vhHlvC9FtJtzuBz
         4ypzhuKwD574x+WPmyQN8K77m7Ek/kEqrXhEgmnPj5Y4Lv1Cfk255eq0gRn6uVRCEW4k
         79t3ioH3PhCD9OgYIAo70hWFLV/3pHIrcLWkC5xcSj/p72WwGRoyReOakFBlwJ6tQs8M
         n+rj+mllHxhTkgKVMcpBvxJk1Qfn1kXnF+275a75RutlO/j/X5sVCSMIxI87WIjnYUsw
         1J1A==
X-Forwarded-Encrypted: i=1; AJvYcCWO2Q1Yh+J6QplvOB21OSjkPPqVYUXlI6uX2uAgRKZS6XU4Ds03nZNEG1khr26KA18CJTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mc5svn9St6VWYKj+ay8Gm0vKRD+YZLmsvxRgR50Ak1JtpCEL
	74JRrGrNlO/gsr0ph54NFNlxCS9dcn8xecAtrSDJNks0Kl/xybv9W25god0gpO8chQ==
X-Gm-Gg: ASbGncsiPWQ3lv8c2VZ0cAm3QCwXP+tQseP/3QiaGctGQSk1c8wH47zHn6G6+tvJSMF
	HuER8vTVbiOd5bgui45RszBZJqNNV6ns0uBi/mGKoIzOb8iksU1Yqr8Lenkn7YdQs1q1xjOvLv+
	F2/ymsiuAKX0jtR0hTEjzyPPPwO9XXBvesCW/Ehtl+lGOFSINe7XSeAt1TUG0PcgKqEdfAkFGjf
	Hoawlf8VfrznbCevWyq1QQ0LeMxFRY4i95z5Y1iPO5lwDLediaTfpmXJ6NMN0YfqyJT8VUdN6MJ
	xdWX6MUC3re1qxxbA3cdFHrJ//P0w/tkdGLLFdLvtweYdR5t83YgJTNAuAFRy00dPkplIoJllj9
	LKQxMFsngxhThYkg16ejo3iibxVb93XoD+iO+9wkb1vFdwS+JaNKZxm4mqNT40xaebv4=
X-Google-Smtp-Source: AGHT+IEgsoKeEdAOmf7V3AwPOG3rhylbsP/X4Pjd1kcqhKfVj8Dc8zkYrCPZC0GXi2o1KWjaV1iW6Q==
X-Received: by 2002:a17:902:f546:b0:24b:9056:86a5 with SMTP id d9443c01a7336-2517446f701mr288115ad.7.1757108461368;
        Fri, 05 Sep 2025 14:41:01 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2aaa70sm22678386b3a.24.2025.09.05.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:41:00 -0700 (PDT)
Date: Fri, 5 Sep 2025 21:40:56 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aLtY6JqoOTMA-OtG@google.com>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com>
 <ukh4fh3xsahsff62siwgsa3o5k7mjv3xs6j3u2ymdkvgpzagqf@jfrd7uwbacld>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ukh4fh3xsahsff62siwgsa3o5k7mjv3xs6j3u2ymdkvgpzagqf@jfrd7uwbacld>

On Fri, Sep 05, 2025 at 02:33:16PM -0700, Shakeel Butt wrote:
> On Fri, Sep 05, 2025 at 08:48:46PM +0000, Peilin Ye wrote:
> > On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > > Generally memcg charging is allowed from all the contexts including NMI
> > > where even spinning on spinlock can cause locking issues. However one
> > > call chain was missed during the addition of memcg charging from any
> > > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > > cgroup_file_notify().
> > > 
> > > The possible function call tree under cgroup_file_notify() can acquire
> > > many different spin locks in spinning mode. Some of them are
> > > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > > just skip cgroup_file_notify() from memcg charging if the context does
> > > not allow spinning.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > Tested-by: Peilin Ye <yepeilin@google.com>
> 
> Thanks Peilin. When you post the official patch for __GFP_HIGH in
> __bpf_async_init(), please add a comment on why __GFP_HIGH is used
> instead of GFP_ATOMIC.

Got it!  I'll schedule to have that done today.

Thanks,
Peilin Ye


