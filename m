Return-Path: <bpf+bounces-51757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A034A38A81
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F45D7A1ADC
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A931229B0E;
	Mon, 17 Feb 2025 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjPYV0q8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510434EB51;
	Mon, 17 Feb 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813063; cv=none; b=RJZWPp1NL5+Wwd2RDhReIzmgH+hYZJyarLNxLWsFl9rd9QKayap3BIJMCQt4eFBR22zqdltSNnRkpnDI9xDCopPza2h6nHsL3iyIVjkGZFzOQhjFfn91YQVRe3taiGBCaifI0JI1nj7a0xaY+9cdy5AsIyMPhfaTaflhLuy7ZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813063; c=relaxed/simple;
	bh=g0vm1YkGweGh3dE9ZFPmqaZKrH9a9CGcXL6grPYiiW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjsvN9YfUDal8NyPdUGo2OvUgvgMsfBqyJG69qvYoZgm8ozFvQqH3VOro6lU+F5C+sd8RFbAlj6dBHMqwIiXznn1PU3iFvuUogXr7phn9KSmXrxeaG14a9DJhAbNDLoePHSfaZTspaX/EHO6Edbk83bLn/43sbwqiorAkhIEECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjPYV0q8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f678a27787so39246527b3.1;
        Mon, 17 Feb 2025 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739813061; x=1740417861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trmHvlmyg8wXRQZMDpykG9IBwhlaXbIm3VRL+oM3rwM=;
        b=ZjPYV0q8EJcoN7EKrqcvLNCcRDpgNogtzKffZSDWXnSHysbhoK0tOm5urvHf6EX94D
         IqCp4B8fsCLby8nNcGqfib2cQC6ao6OB+qvKtmW0JbpE9iSU0zfTiweqzojwJFswPkVp
         FoEl1RGNEDZHSIReTvlpkH/5HfN4XvYgHC3PFz6caXij2e+07ZvdAGA3AYxzc0wYWEhf
         vEEQmjkvSVRisQfwgiIZJkEC3xffAX9fcnbRDl85KC+ZXswVU9n/DJX87VZIdekV6POd
         C5gsjVd8tKG6qpY1fTnNXuKWBHAWLOYf6hXITvj+w5T1YljGW08tAs7SmGwC7Cbv51ed
         IjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813061; x=1740417861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trmHvlmyg8wXRQZMDpykG9IBwhlaXbIm3VRL+oM3rwM=;
        b=A4PwgPRsr5zFatsGux2nVmGRdOsX+nQYIXq1zB/ujboTJM7OKJfq7pvCR6nl7661Ke
         VER7C19+AlOSrYrcx0vA7vdc35rIMzpw7YLI1NZge1UshZWdeNCaX9r6ya7BDBF54u4T
         Jf1G2mWCFtFcvDw6FnKB+LM96mFV8KL12ppLbjOhWlPaEj2LmxiSymz4qrLJ9dEslrI8
         wJgcMkRV6x0EgSD50nXe1m5B9aNptzk+k83VjvXdJ9zJLPc5d409hcwm2h4/ocyD4lyL
         7i04aVW+RAoNfnZJu7oBeKYXYQIRwUCfC25aO88tYQY3qJN3t7Qqektl1vPjUMmKhvFl
         jyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBLLj+9Q58+kWFrviQqnx+8b8MndQUbaM4Zi9lL1rUNXSIkhk428/p7Ag9SZvWr1XsNZ4=@vger.kernel.org, AJvYcCUUtTvX2Z456jdIkgeoKpkWxLSOPvrKNYLRsdCWqA/Bv23Z4Uix0xt/84OvJ0xo7hfpYgfvkENUtfZndsAW@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsE4ZP3U3WJix82yfOaXaRbJar5Vg2oMz6NhvsYuWRBnA2VXe
	QE4Ky27z+XdNTzr1OPh5gw4ce6vO7ZZ0GPNLu0R+G4klTd0kiRjm
X-Gm-Gg: ASbGncvoeyRYSWhCJ84cHaSWv85zYt5gh1Qo5bCBm05fB3OtDPkM2hZB+wBxpJim18V
	4tTBqlZhis+7r/Rd+siyFwWS8bieafjN+FMsPDiPYY8hdQ1v9YkJ5/keRy6TPWu5uXCblHCePFe
	LfHrCF6HACWEMO2Ut7pWw1M7cZAiE8W/j3+zugfz1MHocA114Ea3/IFFYi8xuaMclYpzJLrTjdd
	JJMtkmyBvglmGiWlZRlbivPV6XBTXglr9w6Nh4WZ1OFq2iJEI1Gy/hM3rlPmaPglT8KNeMz/mR8
	Zjl2s+Tbdj5ppyz8/wTghcfM1yDYT0dEUT3ShTgmPdWzj1sPg9M=
X-Google-Smtp-Source: AGHT+IGq8UykHWtvtSX+h4LucnpHiIbU/Cxz2bTgynb88Ucfpgy2hDrjBlOmfdLAP6jih5kIFQaWTQ==
X-Received: by 2002:a05:690c:6505:b0:6f9:8916:3b69 with SMTP id 00721157ae682-6fb58269c2bmr74644857b3.5.1739813061142;
        Mon, 17 Feb 2025 09:24:21 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb745ea189sm7187477b3.98.2025.02.17.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:24:20 -0800 (PST)
Date: Mon, 17 Feb 2025 12:24:19 -0500
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
Subject: Re: [PATCH 8/8] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z7Nww_e-aHXsfXcS@thinkpad>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-9-arighi@nvidia.com>
 <Z6-1mQMBhq4OOlvB@thinkpad>
 <Z7M8h8jGEPoPmmiT@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7M8h8jGEPoPmmiT@gpd3>

On Mon, Feb 17, 2025 at 02:41:27PM +0100, Andrea Righi wrote:
> On Fri, Feb 14, 2025 at 04:28:57PM -0500, Yury Norov wrote:
> > On Fri, Feb 14, 2025 at 08:40:07PM +0100, Andrea Righi wrote:
> ...
> > > +/**
> > > + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
> > > + * idle-tracking per-CPU cpumask of a target NUMA node.
> > > + *
> > > + * Returns an empty cpumask if idle tracking is not enabled, if @node is
> > > + * not valid, or running on a UP kernel. In this case the actual error will
> > > + * be reported to the BPF scheduler via scx_ops_error().
> > > + */
> > > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > > +{
> > > +	node = validate_node(node);
> > > +	if (node < 0)
> > > +		return cpu_none_mask;
> > > +
> > > +#ifdef CONFIG_SMP
> > > +	return idle_cpumask(node)->cpu;
> > > +#else
> > > +	return cpu_none_mask;
> > > +#endif
> > 
> > Here you need to check for SMP at the beginning. That way you can
> > avoid calling validate_node() if SMP is disabled.
> 
> As mentioned in the other email, I'm not sure if we want to skip
> validate_node() in the UP case.
> 
> I guess the question is: should we completely ignore the node argument,
> since it doesn't make sense in the UP case, or should we still validate it,
> given that node == 0 is still valid in this scenario?

Ok, I see. You don't promote the error from validate_node(), but you
print something inside.

