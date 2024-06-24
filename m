Return-Path: <bpf+bounces-32931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F66915685
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7E21C22241
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6F1A00D6;
	Mon, 24 Jun 2024 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LumA4zE7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1E1E4AE;
	Mon, 24 Jun 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254082; cv=none; b=pmC+PB5PbhtNq2pw19I/siRlqouGl0yXaPcxgbTcJZI6FNrFpVR3/MLXsbnsra3WHp5+CelXOogTnuaPknjXx9CH2MPzo8a4lxCWWolD3THhZwfVw+fc+9ux22d1LUWDV3RZbc07Tu4ZRb0lI6r0urKKYIh87kYSMWf+uF4NxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254082; c=relaxed/simple;
	bh=v/KIbbApgJ4bHyw2dAkwpivzE7uNXHS1xfRko7iogSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf6wP+1R0RKnUplR3YIJPQP5CL4yqeoZNxvd+mpEBj+luhrKAyeR1ZGQ1k0iOJATaKci0bLno4BaidFAk8g9NvqDmWtDh6tlqyXTOp6ecQfWH85n1+1YDncBh7n5Cw17OCFkxCxXGv5kSkv1apOs8/kcBeHTrjm8/IFAJ+UTYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LumA4zE7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706524adf91so2473593b3a.2;
        Mon, 24 Jun 2024 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719254080; x=1719858880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TohhoMIowz1ewOVnpSvu5LM9Byxn119/5fGaNjoth3g=;
        b=LumA4zE75uz+7hQEviUDrVH/xjYbwP5Nzy4+f2RfT2olwypqaHcLq3aiwsl4+PHm8E
         pqmO7FqV/aGBQA7xaBj1MwQmzGNkPHkn4GhWUO2jKLy+ZyUtHU5/Owaemw6Wh93io7pL
         RAlUObc3h5W6GX3bMtCWYYSxaEZj4cohtNHn7SduzpKjW9KsAq5zQhc9icWAYyxVIipO
         +tV1iNJPQllextGNEIjTIAIkleay66MCjEqaJ2S+d4SbZ4sJ2pwfhCeO/8mRKVtY4FdW
         4OzOXtCBEyINEiFFI9uclsCvN31oJ4OFeOMsbxa6R/nD7RgUQ2Ey3A+LOnvtf3YvwtqW
         YhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719254080; x=1719858880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TohhoMIowz1ewOVnpSvu5LM9Byxn119/5fGaNjoth3g=;
        b=JyprvySZto+/FOWdPq9ykyT8XId9VKwvkbR3Yn7ahBnbFW5dTUMkzxKZV8Cw4O89F8
         2S9gS2RRsOT6SyqvRkR6vz91wN1Fc18skWSqPyVLz0pCz93HS1r7PN/ifVC7djvq8Ip9
         cBTxFmLsfML5p1io1+vnx/Z+DeglXWT5OqAcdlxjfxtybtgYFRFFP02LsyyU7ZWnoa7c
         WFpPz1ovpElquPNKZQ+c8Mc6xYIWrHXkTpP3BtEeZmHKj8mNJmJmzBKhnhjQgJIU+vXv
         9TdyqN9+x7sw0VXwh2DXx6dQRd08rhgRGFsU5Utc9d+5V3utT1ygnEWy/RMdI0cCQ3Kp
         Iq5w==
X-Forwarded-Encrypted: i=1; AJvYcCWYZeRE7yBmpQ+ard+vFCNPW/bRAg/abrBxzqra3drYRCL7MT62g+kQU/CEqEEZZeqOb6mQD+LKkkc+gKPYjeGmV44YSI2YGI32/SPFj7kURvJs47jpF+MopJNMRGOVEe/X
X-Gm-Message-State: AOJu0YziOFTiW+T2pgOqXRa2AnbiF2Q0v4gVRZqVg8NHmIk5KJYyPWKJ
	AsRs5yB8abHIwsfDbPAT9s1QOorxqoQNTn1z/Ts5bj3R8+J9G1cM
X-Google-Smtp-Source: AGHT+IGQ4YU+NCXEsr5X/u9JQrGaDAnvi3FJsNGxnW0xgNqEw4eZ0V3syDgaR3+qGLet/VOfoWQ7Ag==
X-Received: by 2002:a05:6a20:1a01:b0:1bd:3a8:dd42 with SMTP id adf61e73a8af0-1bd03a8e020mr3985782637.44.1719254079950;
        Mon, 24 Jun 2024 11:34:39 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065124dd26sm6507293b3a.127.2024.06.24.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:34:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 08:34:38 -1000
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
	kernel-team@meta.com, David Vernet <void@manifault.com>
Subject: Re: [PATCH 19/39] sched_ext: Print sched_ext info when dumping stack
Message-ID: <Znm8PhfeK7nSQuuo@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-20-tj@kernel.org>
 <20240624124618.GO31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624124618.GO31592@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Jun 24, 2024 at 02:46:18PM +0200, Peter Zijlstra wrote:
> On Wed, May 01, 2024 at 05:09:54AM -1000, Tejun Heo wrote:
> 
> > +static long jiffies_delta_msecs(unsigned long at, unsigned long now)
> > +{
> > +	if (time_after(at, now))
> > +		return jiffies_to_msecs(at - now);
> > +	else
> > +		return -(long)jiffies_to_msecs(now - at);
> > +}
> 
> You have this weird superfluous else:
> 
> 	if ()
> 		return foo;
> 	else
> 		return bar;
> 
> pattern in multiple patches, please change that to:
> 
> 	if ()
> 		return foo;
> 	return bar;
> 
> Throughout the series.

It's just my personal preference. When the if and else blocks are relatively
short and completely symmetric like the above case, using exlicit if/else
structure looks more immediately intuitive to me. If it isn't too bothersome
to everybody, I'd like to keep it that way.

> Also, if we consider 2s complement, does the above actually make sense?

Maybe we can update jiffifes_to_msecs() to be 2s complement transparent but
probably not a good idea given how many are calling it.

Thanks.

-- 
tejun

