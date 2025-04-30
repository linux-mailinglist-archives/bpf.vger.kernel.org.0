Return-Path: <bpf+bounces-57034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB59AA43E7
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 09:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC02466FCE
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1C2202F7E;
	Wed, 30 Apr 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AMMURuwr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02182AE7F
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745998063; cv=none; b=brVjAaPeMu3BGa2LoW+ZoRcOJLdrSEiv/RwulUAg1Uwz1yeTaHqn01t8NiE4WxO4SnROJyo5crJgpZfbZ6rK0HiQuM8vy/MXV6HOYhVWaDxw57VgEyIocrlZW2opA5qBqh0S/e14t6lb/gzOo8+MlTU+sFMP3DzifvNFizoUQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745998063; c=relaxed/simple;
	bh=zDGaPsNn+sHsyuMSVVCvcKEN9xOybH1pQe4tKyhYIbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpFXQSr+qD10ELc3JXCtInBWMSASUZLz6poqjXnlaJadMBQna60vU3teHGpUWjby6r1ZzPLcSnPfSDMYhtzrSn8ZtndUYUcP5mHfOoOasKGjzgDhtge/c+3LwM5Io91Vb5qvvu9wlSqLTQNaHD0Fct4mtYe+oFCdperUJQI0BoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AMMURuwr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb615228a4so124322466b.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745998060; x=1746602860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlBz7iF1hek+FTGw3X4aAHw5f1S4jYqTggUPhRMIVXc=;
        b=AMMURuwrJ5A5njlldNIV6popjXuhXpRp056f0DCoCYg9aodP5BPku5C/GCqupBLy9w
         tBc/YDVjDSrWikWqRLwE+RwIf6hWyuc+8vCSP6Rio0NJ/U6Nfd3WfVUJ0jil/NVHMyhX
         0L5M2GSlcu8/Z0v0B0xzPAEwmqgCynZY38GTwp+tDDH59OLoCKyYqns7UAVgWS7bY+Ei
         qjdXntdbDuwuoTMRBt/W9J4ZuZL7ddTWeuQ3uDMshqPGmssBIblLBTNu40IG5cE9YIvh
         +qg0zhgayhMexJOuFwiBd9o2fUUUSMCB/XaZVe20s99v7bUH929ZWpqw+83QqALJN4mr
         avbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745998060; x=1746602860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlBz7iF1hek+FTGw3X4aAHw5f1S4jYqTggUPhRMIVXc=;
        b=D6raZ4HJp4mYiW7IX1LqnkDBaREfLylgqktMAqWsEj0YojVym3LGOBmdlZPZIeEilX
         mXpGrQlOq/bIyE8U9xVGzGX7T+KLrUvD2XSXPP7+pIpFkM43FIshWiClR2kLcQG4qPGv
         cHmPRsJokYIWYbbAg+W3zrFndypNfdA17Tw7kg7UcguXqqLD/+LxLC+PB1bZCPHH/E+G
         41sN20wlzRqizIUm/jj27qVA6AV/4yYledgy6c4g6BnBKcMTlpFUtWhA9BbllzuG0zrF
         IGAF40k1mex9H9oEFF/KPN6oppChS8PYcWXbWnJDBdYPvzhBirJNQz0dXbO1iGzPsIoM
         H0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8xl+zctqj6m+ka0ddBhAq4p8uirfTwu9gURTxrIbdS5LZZF8NM9fP+2OdYoptTinC4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLnbiwjSsDNkDsl/SyYgu2TQeZjB03XUTdclSsM5i/0VXgmKE
	SKoQ+p/fTpw8uKHy4e425vQsziKUIWQSHvK8fXBsNNO66XwRjyarRnQnafWFIz4=
X-Gm-Gg: ASbGncuoEbS4j81maXTpV8BWYjkTAQEyU1YgsR6PMArlcZ3FJw5fq4iY9OpuEoUfEtu
	mil0dda9AMxLbJ8zk2hRa39+U/AzyKgBB4WvPl60ZSH5PderPn8Evv8vOZzw90shKlR32WyBByo
	w4b2ciVkycjzWXcwVkBF+LWlfNZUsMUwrGVM3tCA3uK9eX73DN7yY8tRmNb7WuJEFoeqUgsyKa6
	W1UterUJoF4I9oj+7QHsqTmVtccPJdQDuw2+AmPp+noHkKD3QWc62RoVjXhuHg/sJQ261OmrkHS
	kQ10vvgjdCikGNZJ35WHP+gjw+ZhkeQ=
X-Google-Smtp-Source: AGHT+IGHXR5iYRXyJph1iKrCVhcSCgbOSnDW32/4au9VmEwpUAXHvuV7+98LviohpFzXoUW7wi3S0Q==
X-Received: by 2002:a17:907:f495:b0:ace:4ed9:a8c3 with SMTP id a640c23a62f3a-acedf68c196mr173112266b.7.1745998060149;
        Wed, 30 Apr 2025 00:27:40 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ace6ed6affesm884107766b.130.2025.04.30.00.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:27:39 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:27:39 +0200
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
Message-ID: <aBHQ69_rCqjnDaDl@tiehlicka>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-11-roman.gushchin@linux.dev>
 <aBC7_2Fv3NFuad4R@tiehlicka>
 <aBFFNyGjDAekx58J@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBFFNyGjDAekx58J@google.com>

On Tue 29-04-25 21:31:35, Roman Gushchin wrote:
> On Tue, Apr 29, 2025 at 01:46:07PM +0200, Michal Hocko wrote:
> > On Mon 28-04-25 03:36:15, Roman Gushchin wrote:
> > > Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> > > an out of memory events and trigger the corresponding kernel OOM
> > > handling mechanism.
> > > 
> > > It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> > > as an argument, as well as the page order.
> > > 
> > > Only one OOM can be declared and handled in the system at once,
> > > so if the function is called in parallel to another OOM handling,
> > > it bails out with -EBUSY.
> > 
> > This makes sense for the global OOM handler because concurrent handlers
> > are cooperative. But is this really correct for memcg ooms which could
> > happen for different hierarchies? Currently we do block on oom_lock in
> > that case to make sure one oom doesn't starve others. Do we want the
> > same behavior for custom OOM handlers?
> 
> It's a good point and I had similar thoughts when I was working on it.
> But I think it's orthogonal to the customization of the oom handling.
> Even for the existing oom killer it makes no sense to serialize memcg ooms
> in independent memcg subtrees. But I'm worried about the dmesg reporting,
> it can become really messy for 2+ concurrent OOMs.
> 
> Also, some memory can be shared, so one OOM can eliminate a need for another
> OOM, even if they look independent.
> 
> So my conclusion here is to leave things as they are until we'll get signs
> of real world problems with the (lack of) concurrency between ooms.

How do we learn about that happening though? I do not think we have any
counters to watch to suspect that some oom handlers cannot run.
-- 
Michal Hocko
SUSE Labs

