Return-Path: <bpf+bounces-32929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE93915644
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386031F2199C
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5719FA82;
	Mon, 24 Jun 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEgrqU2l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4F13BC1E;
	Mon, 24 Jun 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252701; cv=none; b=gstAfrbTFZ0axfmY5SS88cLmWxBSST+u4ldKZRyFpgJel+5csZ1KnnASk9Hv8TL1DS8ZduAH/j2eZKrrJ0OMxuubhBiW2tbuRMJKyNKb6xoC9svOYBms7Sdf6UahPqlSBAp4a3hsoo9Liur/YQX3UC2xlmqOpP+PagPg48vbYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252701; c=relaxed/simple;
	bh=8ZpHeMdA41tz6VxVLKTzAZjGJmZnGo+/owcvRa6kIcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvDn33RTpoAemAIyQh8JwfpE9ZKI9kkq1mIah+CAaHLhPVIWr0Fh9xzdxQ5rfckohOg/nhFt/3Z7Dsijp1FDiqColsvYW+dJkatqmEzYlSb2EAg5HZJ5zHVnn8ZCjXpZnbyRTc1Tv3sve/aZgS9z4bUO+knbnTCPE0As3Rlp/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEgrqU2l; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa07e4f44eso19718215ad.2;
        Mon, 24 Jun 2024 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252700; x=1719857500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAzqIGCealTp3KkbLdhI79UaVuk53m7yBh30uNglZCY=;
        b=CEgrqU2lTve33ptZTEq9WwbqwLUw/DehrwLWEcn9p4gjSmJt/n/CHdOdBTpd8QPHCe
         QwIYa8kpPXGb+dcUabVzhJ4GX8ifjhulvyvae1KnAhrn8N9IuMlepwE7xI1oq1GUwmnl
         AmHI3tlkf9hp0VkF4Rb/48nxa25aKUEWF2d++UUdYqoumhmSb+J5emx29YT6TwZa530N
         lbzavOzoj9My8cbZxF9fNt7FiV5Px95pD6nYlFJs1C9uz85AlP7hkyvEHpmDr2gllvuD
         yNRPSZDQQ5rUSxP30XfGGSBKbmmgmk8Juux5mWnC+NIlgE3IpRvBeXsujQFuzljfMdRX
         bLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252700; x=1719857500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAzqIGCealTp3KkbLdhI79UaVuk53m7yBh30uNglZCY=;
        b=sgNcuKnH1DwWdg3OqhWhxLzuEep+49y4tRD4VJvvaR5HrmHomBzXCa3PzGte0RqLwc
         2PPLMNUX0a3mzUJdx3lL+ZxK6L5HVsdaTe+L5GqbLWBTYR40J+K9DJmbaDfLdeWBRWvp
         iL+inp7gXeAjgTD/JfLlWKYNWSIbErzf0/4534UVBJ4bdxCCBBf4cCF39mQze5zoa2Fe
         5FHkCWusvcTa+EVPP49xqvADh6QrGrklR9MTEsVDBA21cSy7QsFJed+k2XBBXCOjJKms
         A2VXow+deQm3vOwXb3Z2UyzRCZJEUow1y2YdC+C3hYowF7bRmsm78lGmq5UQKLLpph1y
         Yz5A==
X-Forwarded-Encrypted: i=1; AJvYcCUqmYmMpwRL+s95wjofC30QPyYpItfJcoXQolzcFAok+l5e07JPEQdMLpR/Ux+v/Xbrofz04KMpkhnSaH6w7qiVMqbAUOkuKrJ9G5P4Dzg3bTTg/Mr39DQhbgDnRA0Uv9xQ
X-Gm-Message-State: AOJu0YzpycYdVkY4XhfRQKrpmJXRPRwyv2kxNAa5sfeFXsF/c4aZlBAG
	CHWxzThqEQrMe+IiulbYcp6qXWdIWuTPHWkpzJJAXljTENHKj/3C
X-Google-Smtp-Source: AGHT+IGJJRR3n10wLw3QMIlVWhHQKtg3N1/E34FVbH9wm7We3eJKltNoMxQv8m3zZbFI3++mznQ7iw==
X-Received: by 2002:a17:902:ce81:b0:1f7:2bed:226 with SMTP id d9443c01a7336-1fa23ecee77mr65422275ad.36.1719252699549;
        Mon, 24 Jun 2024 11:11:39 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7cbesm65663735ad.298.2024.06.24.11.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:11:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 08:11:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
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
Message-ID: <Znm22Sgt-rIU_sp5@slm.duckdns.org>
References: <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <ZnSEeO8MHIQRJyt1@slm.duckdns.org>
 <87r0cqo9p0.ffs@tglx>
 <364ed9fa-e614-4994-8dd3-48b1d8887712@meta.com>
 <878qywyt1c.ffs@tglx>
 <612c8f18-21e5-452d-8e9f-583f224d8e54@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612c8f18-21e5-452d-8e9f-583f224d8e54@meta.com>

Hello,

On Mon, Jun 24, 2024 at 12:42:01PM -0400, Chris Mason wrote:
...
> >     - How is this supposed to work with different applications requiring
> >       different sched_ext schedulers?
> 
> I'll let Tejun pitch in on this one.

Long term, the tentative plan is to support a hierarchy of schedulers where
the intermediate schedulers are responsible for granting CPUs to leaf
schedulers which are responsible for scheduling tasks. Barret Rhoden has a
framework called flux on top of ghost which already implements this albeit
with compile time composition. Nothing is set in stone yet but it's likely
that I'll follow what Barret is doing in many parts.

Taking a step back, because sched_ext currently supports a single
system-wide scheduler, many of the techniques that the current crop of
schedulers are playing with are pretty generic, at least to a class of
problems - e.g. gaming.

Even for scx_layered which is the least generic in a sense, while we it's
also used for a really specific ML setup internally too, what it's more
widely used for is experimenting with things like soft affinity where e.g.
workloads that are not latency sensitive are grouped into few hot running
CPUs which are dynamically scaled to keep caches cleaner (and other effects
too) for the latency sensitive parts of the system. Dan Schatzberg is trying
to generalize that with scx_mitosis.

So, the summry is that there are plans to support a tree of schedulers but
we're currently mostly focusing on more generic single scheduler
experiments.

Thanks.

-- 
tejun

