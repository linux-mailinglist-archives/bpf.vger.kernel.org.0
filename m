Return-Path: <bpf+bounces-32148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6D907F8E
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 01:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBDA2843AB
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A848E14D6EB;
	Thu, 13 Jun 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1Hs19XN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFE1849;
	Thu, 13 Jun 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321929; cv=none; b=FTZ/udkSv6AXHaik2FnJUorgefCjyElxrchBMquSqUqSRzVMTO/TxeXPCEku3UlMjGplmbTgLtebcxUyzAUQ6IV6NMwkVklsmWIoD2z+UGeDqUGb2ZG/CWS+24K/GYX8Se1Y2nYhYMOk1PfuaqorNjEUuVRfrdTIJZsYxkuCeO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321929; c=relaxed/simple;
	bh=Ckai6bKnrtzeN9+G/RG8h/FqMpADvwF4Bb3JNcIxTbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kba4dXZ2wZMlo/w+IcEPwAu0jO04fF5ZUzsZdsMCKQ6R7aXcEI6jjEgZkSjYcefAUJ3hU7wUMpDFyApCDpcoUU0cw72bQ0KW9AtigLtzkrU05znjuStz1GwphbzZxPxjG3LNbEbLL10c6O7kKVhuCsiejEl8ksMuuronXxb66Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1Hs19XN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so1052084a12.1;
        Thu, 13 Jun 2024 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718321927; x=1718926727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlXdIMB25WEVXVPSHsCbpLnbY+KHnKzWI78VrJ70+sw=;
        b=N1Hs19XNddFad2fMe3T5WeUMx58IzStcgTdjOFN6ZNt7MoU/vgErYBaq9sGmBEe1Dn
         mgUPKs8Moe6HnMscDejcReFHk/oLDd/w478OYTJMeT+WYQNumN9VQ6MYZLUNvXJERZVj
         wB3OsnscwpNIKdszOizlNh/ehrFvjTcTOCOkkK5fGPKC3Fc612fRgxTSrCIs9k+11WJu
         DzvYF5Le8lJ6ZdV9s3R+ZVZiXQqkn9OTjt9fya+XIFC6Yr/0BxdZSPu+9D9tuQMWNWOk
         h0djcF5qocP2CLbOmZEB+57T9+NknXoD56yDw7GIsRZL76vTccMWIW7jvzePrf7hgoVP
         kPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321927; x=1718926727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlXdIMB25WEVXVPSHsCbpLnbY+KHnKzWI78VrJ70+sw=;
        b=OenCDQK6yJH44fAtYs+EzaqCtf+/lYhBrky9H4n5tYY7Fm7ObuQAiRbE57ASaLBIZ3
         7kzxSTXQ6hHLtq1vX9eQ4r0bTrxoHJC8tN15SbE+wIoRoT9BDUYMwX10+DyoZH1cYEyJ
         c+QDfv3LtsWeUKz/y+hxOpYPjzt9CGSaHoatqGqmJwTUrcL9UfxNuCfgyXg6nDxUM+DO
         djF+o+jjxPKhfETiUo2t4ZBwt3nSV5UwHdb9Hvpnrbe+dzBPG488L+ot/ouj6YY2nOzA
         iSywOQtVjmoFUBt/QY/L7E5TJB1fzndNr5QFDkPQq3A135M8OobPkVmjGUegfmFTUA/q
         qAvw==
X-Forwarded-Encrypted: i=1; AJvYcCWe/5SOLd6LYbiQwtaQMncwyIc2mWKXYbNtwvuvXMPmxHjHQSQdWjRPsk5g6FKE0idGhllYAysm/F983KQe41rU3PAg+jdBM2lRie7U1Rqsdkwufd9LTk3YrYVOTntSu4NR
X-Gm-Message-State: AOJu0YziD4Ex58YhFuD+cBvLxFfHs1vYakHJ1ZbDeLXqxVS4Jm5REOre
	IBnXu/q99oej+jntoQzzVHJTfbvteX2/MZLsIDvPcnM79bB7KlT8
X-Google-Smtp-Source: AGHT+IEbE4wgylv5uV4V0DDcl/MKqPZI0rXJDFiWtNTPwF32L4i7dRbcnR2r1/2smFg8ZYxT/4Bitg==
X-Received: by 2002:a05:6a20:a122:b0:1b5:2c97:a88b with SMTP id adf61e73a8af0-1bae7e1cc00mr1719484637.9.1718321927105;
        Thu, 13 Jun 2024 16:38:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75eeb1asm4747768a91.15.2024.06.13.16.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:38:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 13 Jun 2024 13:38:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
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
Message-ID: <ZmuDBRRhpcqhxO7z@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>

Hello,

On Tue, Jun 11, 2024 at 02:34:56PM -0700, Linus Torvalds wrote:
> Anyway, this is the heads-up to Tejun to please just send me a pull
> request for the next merge window.

As there have been some bug fixes and minor updates since v6, I'll refresh
and post the v7 patchset and start the sched_ext korg tree off of it. To be
on the safe side, I'll separate out parts which interact with other
subsystems (e.g. cgroup and schedutil) into their own patchsets and handle
them as normal patches targeting the sched_ext tree.

Thank you so much.

-- 
tejun

