Return-Path: <bpf+bounces-74402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C0C577E4
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFEB3B990E
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AE34FF7F;
	Thu, 13 Nov 2025 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="DkRFAxJX"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16110F1;
	Thu, 13 Nov 2025 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038162; cv=none; b=LVapyUGu4BZNEIN18FHKSvxM7rXI+fDGZEzoyUWMybJ/SoKK0aS5sQ+m+0e0a4pEpX3Unaettc4kUm40m8BxPTPnA4E1WmDBMBXaksooUqlSePPLKHJMFbRNtylhAazCXPMxoKGvkpkh+kbm0+7mfCIiHV99k8i9Fn05ezHtWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038162; c=relaxed/simple;
	bh=ky0u/MIru1iNujmSeiLsAJhkUiQA2SwI92TF4IwDmUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOv5iiV4lYYf7138TaIxHUlJECpjdCHrnp5BzcIJMc/yKYKDZt8DEBjExJAnascRRx14BMK8zKDwLo4Jj8Lnf2HWaTS73+OmZZKIbNNyfU0feB5MvTTmJFznuxWAu69yOLhpGqRWvNJ6U7vIxr6+Xa0oyn1BUmar2l9I48auA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=DkRFAxJX; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d6g7p0JSbz9tGx;
	Thu, 13 Nov 2025 13:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1763038150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETlY6cW11YPTgH8OAOg3HDZRMzrB3GSd/IDb+viau6g=;
	b=DkRFAxJXDCe8zef7JNKq5OibPjghra1+UAR7n/4fcNiHq5PAcCM68sa/snQP6bje6ADa4D
	u/pdcr1QSrVt4VrEWRJu/8eGsaJ8XM6F11pZDQmHgW+Zm92AJcE5PPS83UHUoRiuD5zE1R
	0Sme8I7y4UN5kIXv5c119ZkY/uJtbSozwunl88AK878kqvcTn5Xj+Pmk25MOCXPq8GJuAd
	/6W5D0Rw+1vDTKObqBjKEazwPumDVDPOVcypCeT/pznZYU3rcmkAgjBZL2cJCAWW6rmzL5
	Px3Xn4a9T9+lXsincvhH4/g/y9QhqjB/MRSgJNixKNy2HU7D5pE33Q2/OFAPqw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
Date: Thu, 13 Nov 2025 18:19:00 +0530
From: Brahmajit Das <listout@listout.xyz>
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack
 to fix OOB write
Message-ID: <kjjn3mvfp2gf5iyeyukthgluayrkefonfmqbugrsreeeqfwde5@rxrzxrsobt54>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
 <3f79436c-d343-46ff-8559-afb7da24a44d@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f79436c-d343-46ff-8559-afb7da24a44d@arnaud-lcm.com>
X-Rspamd-Queue-Id: 4d6g7p0JSbz9tGx

On 12.11.2025 08:40, 'Lecomte, Arnaud' via syzkaller-bugs wrote:
> I am a not sure this is the right solution and I am scared that by
> forcing this clamping, we are hiding something else.
> If we have a look at the code below:
> ```
> 
> |
> 
> 	if (trace_in) {
> 		trace = trace_in;
> 		trace->nr = min_t(u32, trace->nr, max_depth);
> 	} else if (kernel && task) {
> 		trace = get_callchain_entry_for_task(task, max_depth);
> 	} else {
> 		trace = get_perf_callchain(regs, kernel, user, max_depth,
> 					crosstask, false, 0);
> 	} ``` trace should be (if I remember correctly) clamped there. If not, it
> might hide something else. I would like to have a look at the return for
> each if case through gdb. |

Hi Arnaud,
So I've been debugging this the reproducer always takes the else branch
so trace holds whatever get_perf_callchain returns; in this situation.

I mostly found it to be a value around 4.

In some case the value would exceed to something 27 or 44, just after
the code block 

	if (unlikely(!trace) || trace->nr < skip) {
		if (may_fault)
			rcu_read_unlock();
		goto err_fault;
	}

So I'm assuming there's some race condition that might be going on
somewhere.
I'm still debugging bug I'm open to ideas and definitely I could be
wrong here, please feel free to correct/point out.

-- 
Regards,
listout

