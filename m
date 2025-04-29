Return-Path: <bpf+bounces-56943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0AAA0AAB
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2613B0256
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F252D9988;
	Tue, 29 Apr 2025 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a7C2cKzz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650E2D4B40
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927173; cv=none; b=g6bwF64ZaxvZyf2m3Qf2IdATcs2PLJaxruVzub5comShOBdjjXWaBKYWMs2CkZIHg+/+2SsPXW5PpOmZRxfHUJLFcVRVQ2tkkGaYjYZ8MSF9/65iqsxx95CWB0Ee8be5fNRqgRe0yR2Sk2O5qwkSyxbefU4gGbG4RcDnc2wnGPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927173; c=relaxed/simple;
	bh=ULcK5tqpMbySYpVfeIJT28xVpefLfkaAs7WExUaK2V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwcckfMfO2Q8RTeg2/0g8FNJzhLISaNvyawJDomTHFP3bIbr9eKasGsxMBxOcV1NEhL4oa4ZC5jUY0wWgr4X5QmaJQbaM8f+bRhh/C97/WabGUdOGluiMZo+D0BvfWPHrfHiRiYWL6iLw3kuAxvIoj3ViTyt6baKmJLCT2zBvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a7C2cKzz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f6c3f7b0b0so11105855a12.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745927169; x=1746531969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znQpdTxcq5Q59q25hWrDZ7jqcfAs7XVIcl5H5jOTHxU=;
        b=a7C2cKzzs5yVR2SxJNS71x0+DFcvalG3AghOtS2uiVLM5AZ76PHFlHPLtsu+ES8sed
         dF3/kWuVEjSlUIFMzEOd6nSF7Vfjm6vI6/iaC3zfpvzaqJhVoSapa0yfYBhifS9YysHR
         Epy9teKgO4XaTz3RKnVxaNOHW+xfh4m0R3RZqyrl9yJZaXa222G1KsxfJYmOjD8V+tyW
         ocd1SHaDznCXG0cIoctclzO700ie6+UkRtK6f642d/JD4a4bc0pEyk1KHU6yvSJL9xiN
         HJHcwE2yCQ8nsdCv65douqA26vAUpeeXtT2busSV/SXz5AluR/fletWR4Q33uH9cibEo
         l6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745927169; x=1746531969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znQpdTxcq5Q59q25hWrDZ7jqcfAs7XVIcl5H5jOTHxU=;
        b=VeS4jeQx3cP70/RH0ZrF7Z2quPnkTNfR8GUA4eDTOEQzcl3SOKi8lbC84q+Y+aw1Ka
         VdNFR/QSYOdcUd9PYnMs8kSHbSXg8glDQaMO5ZpzpASE1zDl9SoedxK6tV5liUtFedf8
         nzV5YG995vP+8BdweozYKF3ww867fhfIgAxn8k73CWqYVaQZppFf8Szkhm89fJ08dAK1
         yUj4RHHTtqxUKBY8hE7NSmpjjRyrIKii6mccu3J49tjPIEmYLn3pmDA6RnkODArZP1px
         wUIQJ7cUrlg6whmQqCylzR/XPbdYMDXlAI4tK0yk6rfg90IgPh1ed0PHab3Z/mss3PA1
         I0hw==
X-Forwarded-Encrypted: i=1; AJvYcCWkj+Jqb0XTmVo5JQ61xVL6dICximTwk3meJrIgpefhTrsBl+VsztnVwDATe+TE6308500=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxud7fUUacNPuRE6EzW/VOiChreh7xbbXeIKcTDOnjS8G20sXHo
	3Na9Fmcm51jhSD8svIwN1WJwkLGdMsQlaoX5hCLu05FWjkrpv5TyeoazMGibtb0=
X-Gm-Gg: ASbGncsIq8FiBzH8WqE8WDjO1O01JZvvTPZ1mfMrX8kpc3kw7kQxzL2+TE57VJHauui
	jJPmRGJsWjdsrhnVhwR07igbDeksPuD0iMOag53GBlCixZeSE2/OE1E4YUSh6+7XK3ZkddHC0/d
	Q7zbUdrgGWvN/VDJmiJ039an49bkQ+A0FbxPPMgWRf9LssTv4lJq3erTlvSU0qphfJcn/g3HBJ+
	OeTkSzMzcn/z79assrDfXcI/uy78b/7i/3FsWQn2Y734PnEReK4SzmVH5eLK9vKW5fcnsIm1RAY
	Ln0oywmQ4F+8HK4hYLbreFHrhyImiGzxg3VAAYAzkryzt0R6FJN2cw==
X-Google-Smtp-Source: AGHT+IHdwrLpQIpUiiyBR38B/ZttRSS4g/Wv80xkTkGlVkMPcowVbaa+12lFPhCvhIOfAu66scr/kQ==
X-Received: by 2002:a17:907:60c9:b0:ac7:cfcc:690d with SMTP id a640c23a62f3a-acec6ab3db1mr282121166b.40.1745927168683;
        Tue, 29 Apr 2025 04:46:08 -0700 (PDT)
Received: from localhost (109-81-85-148.rct.o2.cz. [109.81.85.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ace6ecfa33csm760681066b.119.2025.04.29.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:46:08 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:46:07 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 10/12] mm: introduce bpf_out_of_memory() bpf kfunc
Message-ID: <aBC7_2Fv3NFuad4R@tiehlicka>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-11-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428033617.3797686-11-roman.gushchin@linux.dev>

On Mon 28-04-25 03:36:15, Roman Gushchin wrote:
> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> an out of memory events and trigger the corresponding kernel OOM
> handling mechanism.
> 
> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> as an argument, as well as the page order.
> 
> Only one OOM can be declared and handled in the system at once,
> so if the function is called in parallel to another OOM handling,
> it bails out with -EBUSY.

This makes sense for the global OOM handler because concurrent handlers
are cooperative. But is this really correct for memcg ooms which could
happen for different hierarchies? Currently we do block on oom_lock in
that case to make sure one oom doesn't starve others. Do we want the
same behavior for custom OOM handlers?

-- 
Michal Hocko
SUSE Labs

