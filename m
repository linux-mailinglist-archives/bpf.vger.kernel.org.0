Return-Path: <bpf+bounces-73799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A031C39F78
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 10:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A0422548
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D472DE200;
	Thu,  6 Nov 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0x/BQ3K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="foejwH2X"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E327510B
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422569; cv=none; b=SZIs/HzFvpbL37o9d63FjNIQmJcIwTbdGK2aLXBp0rGlDIus7CpHUFP55CDe/3wnkYPXMU2+W6V80sfSjXYjjbzC3ylfEeMP/U7lqbLjMQaVx8V7pu3BJ1GfFypOrVoTubqTDmPSl34Zjlz55WktGCQ3dMTRhNR+NG+xPMrECQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422569; c=relaxed/simple;
	bh=2sMhzj5ZSerndxu5LUketJQ9VpoNWNO3E0MuBLF1XRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onUuaGmhMpSHqQS5dDYmNkvVUR6Nh0oHSiWE2aA6OTw6W3nhMp2uQgYqq+nY3ZvgwuR+QsBlxUVpMQrP3G9R8zFDdafCR1C+RMdqODygYHf2a77N5hcokDw90k/QpTXd5n5ygTCGdQd/sP/tVVNSQ6B3ebbRg178/oEp+VNGvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0x/BQ3K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=foejwH2X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762422566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97/v+8IzcwHBddy9YosW9MdJRIYiAAxaDT3Ms1fX0hI=;
	b=F0x/BQ3KT1JnuYg7QLGSjzImBWE2ThsmU+s1N8VygJDY5wy0Ltkxw1ecAq9u9LcCnlY5l6
	//JgNFz234nwLHZlzg2Md4QdoHbxCMVxkIkeCG7PlfbgVXWZcfDHH4MosmZjvB1nljRMRl
	1b+Ae3arHyhisvPtsdnHMtqHZnV3fKY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-RD_qoZnjOnmGx-xMiV4rpg-1; Thu, 06 Nov 2025 04:49:25 -0500
X-MC-Unique: RD_qoZnjOnmGx-xMiV4rpg-1
X-Mimecast-MFC-AGG-ID: RD_qoZnjOnmGx-xMiV4rpg_1762422564
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429f0907e13so121346f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 01:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762422564; x=1763027364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97/v+8IzcwHBddy9YosW9MdJRIYiAAxaDT3Ms1fX0hI=;
        b=foejwH2Xm//K0A+CLgfmsWCH0eg6ePOAZoil5CN2qaTwtCC9SfFE+OqgPTDRxYzesx
         BclzFSm9vEGCf1enhroYxQecezL+A/yL4FSrT7RFOhcMQ5lxxli8KTlPGxeO0jD2X/Ti
         luwMcpmgPnpAELwZNWkbxV1ddQgKodkHeBKIhCH9HTi/mP4jhg0tihhBt/bn+lY/H/cN
         t1jtELGAHlt0RggNSBnlvtp0yI4BKpYN6bXE+8pvehOsaMOQGMPLqVmBvHuV++n7psvM
         g2I6WAMtfR2r4TC8SY/IRwiA3wAYyBlvg1ZXU+TS401EyMSBP1N+m0sE4YmZCJpVgGxN
         lE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422564; x=1763027364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97/v+8IzcwHBddy9YosW9MdJRIYiAAxaDT3Ms1fX0hI=;
        b=Z6teHCI1VYMCkpCtdCn4Zm2wJPqDr9oUF7uGxanKTL/9Nd/kKU2YxOrfzHS8X5FNR9
         Hp3N3x0dyQCbHc6d1ZLtwkn4HB5bc7ps72gyFBC3IZR4XKInpjH8Wn4LtACzZgsqg1Zg
         ZHuF6Ds8QYyfDwlp0lvhD/FkEskmv7RhnXTgByMSmgzdwzreNrs/vFQwXO35ApKgP/do
         x2XH4iM967A4IqNL9s+ZQtEsXysRnjkqA44epjwcG6tC6VK9W3Sbcbp/r6YPORVMErER
         qRExaW09duc2C82GK80ph4+sfJs3jP1bXkmNV/Z4fr4/DK+uDzmmHlgKTPonnXti+9qA
         QgMw==
X-Forwarded-Encrypted: i=1; AJvYcCXNvh46U+1OGhFTkGz6jMiqTAoZEWHLAA+li2mBP+1mO4f+sPzDG8+6ZLkEmqlj1tb4HTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzna+qwfZrkruR5Crlx0MPmawmZ8iX9mTD36YGGpa3hAVcM/Psk
	7NqYfp5X4XR0apZhNcoc9so74s3rF0IqpDbMMaFPV+H7+s9Ifv8WBevapmBQAOENfDnzORtqywV
	WmIHkjN3CekRMhfz78BFkn4GmWXJvL6RPfVXyKtJpqIsaFmPNwPqdAvuGIqOWFw==
X-Gm-Gg: ASbGnctJ+qSgHyxx7r0utUaB0zzk2duT2HcwXWu6CuGlgajiaPJkb2RgGS6oJ7dLM/w
	bMKYOrIvAyiRS2dgCfslcCtSzYOUjuizOQ0lJLdamKTuH3RXFLq3plu3TnzEVwenApnank91NEU
	DV4Wi38OPOxY5bR6cpf403BS4sR7M86vKHI1wXqRUotDcc0Ac+w0L04ePx9o+7ZgCMMiar3M0RR
	m3xVdjbe0pP4TQUXILLihV6fBdw24bIhBN786flUUsLGz9ZUUMNQPtOx6SKXCmQwVJqsgokwBGm
	knBO45ckjuQBzEh1Uvj/mDIPgJvmQ1xKTuVDWTCsm39nOHV4ykVCLxlqcwiB/Ns+xCK2CAebMuM
	TQl1c53IUVpmJprN87Gs4fFn+kMWfvw==
X-Received: by 2002:a05:6000:310a:b0:429:c8f6:5873 with SMTP id ffacd0b85a97d-429e32edf7bmr6285260f8f.22.1762422564006;
        Thu, 06 Nov 2025 01:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL0R8EQ/PK5EAoW8oq2GeV1D9YmMWfZAWeWYzx+9WjjcHM87V/eC7FnOSgRGl6YpJ+tkE4pA==
X-Received: by 2002:a05:6000:310a:b0:429:c8f6:5873 with SMTP id ffacd0b85a97d-429e32edf7bmr6285230f8f.22.1762422563539;
        Thu, 06 Nov 2025 01:49:23 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403854sm3942693f8f.5.2025.11.06.01.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:49:22 -0800 (PST)
Date: Thu, 6 Nov 2025 10:49:20 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] sched/deadline: Add support to initialize and
 remove dl_server bandwidth
Message-ID: <aQxvIBIwOCDDu60b@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029191111.167537-5-arighi@nvidia.com>

Hi,

On 29/10/25 20:08, Andrea Righi wrote:
> During switching from sched_ext to fair tasks and vice-versa, we need
> support for intializing and removing the bandwidth contribution of
> either DL server.

My first and more general/design question is do we strictly need this
automagic bandwidth management. We seem to agree [1] that we want to
move towards explicit dl-server(s) and tasks bandwidth handling, so we
might want to consider leaving the burden completely to whomever might
be configuring the system.

> Add support for handling these transitions.

Anyway, if we still want to do this :) ...

> Moreover, remove references specific to the fair server, in preparation
> for adding the ext server.
> 
> v2: - wait for inactive_task_timer to fire before removing the bandwidth
>       reservation (Juri Lelli)
>     - add WARN_ON_ONCE(!cpus) sanity check in dl_server_apply_params()
>       (Andrea Righi)
> 
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

...

> +/**
> + * dl_server_remove_params - Remove bandwidth reservation for a DL server
> + * @dl_se: The DL server entity to remove bandwidth for
> + *
> + * This function removes the bandwidth reservation for a DL server entity,
> + * cleaning up all bandwidth accounting and server state.
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +int dl_server_remove_params(struct sched_dl_entity *dl_se,
> +			    struct rq *rq, struct rq_flags *rf)
> +{
> +	if (!dl_se->dl_server)
> +		return 0; /* Already disabled */
> +
> +	/*
> +	 * First dequeue if still queued. It should not be queued since
> +	 * we call this only after the last dl_server_stop().
> +	 */
> +	if (WARN_ON_ONCE(on_dl_rq(dl_se)))
> +		dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
> +
> +	if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == -1) {
> +		rq_unlock_irqrestore(rq, rf);

This seems racy. I fear the moment we release the rq lock something can
slip in and the server(s) state might change?

> +
> +		hrtimer_cancel(&dl_se->inactive_timer);

I am not sure we actually need to force cancel the timer (but still
contradicting myself every time I go back at staring at code :). The way
I believe this should work 'in theory' is

 - we remove a server (either automagic or user sets runtime to 0 -
   which is probably to fix/look at in current implementation as well
   btw)
 - current bandwidth is retained and only freed (and server reset) at
   0-lag (when inactive_timer fires)
 - if server is activated back before 0-lag it will use it's current
   parameters
 - after 0-lag it's a new instance with new parameters

In inactive_timer() we have this behavior for simple tasks, but we skip
__dl_sub() etc for servers (since we clear it up immediately).

In all this I essentially fear that if we clear parameters immediately
one could be able to trick the system by quickly disabling/enabling a
dl-server to let fair/scx tasks execute more than what requested (as
each new enable will be seen as a new instance). But, again, I wasn't
yet able to demonstrate this and I am still uncomfortably uncertain.
Please Peter and others keep me honest.

Also, server parameters changes are root only, so maybe not a big deal?
For scx automagic as well?

Thanks!
Juri

1 - https://lore.kernel.org/lkml/aQiE1ULtInJS6X4R@jlelli-thinkpadt14gen4.remote.csb/


