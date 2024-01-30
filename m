Return-Path: <bpf+bounces-20649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CC8418AE
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 02:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FE31C226C7
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89905364A4;
	Tue, 30 Jan 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8Z1Pf0J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAE3611F
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579456; cv=none; b=WzIHNB/zKe/AvtWj0yV0JU/RzE6h/WKgTmhmoGxfV546DyE3GqSJ/J0ZdryPR8vvkfh+HHCWtm45duQsgUcHipQBYhsikYj+0fEgK0DUJOfaDquJNw1IZr0QL+wD1794B0VHiEZm54OrArjEhf1ICVYqPY7QKXvlw8GhiIs+DtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579456; c=relaxed/simple;
	bh=UXeeJGQF71NxlETutk+l/LIy474ts5fok/PMQ0FZkUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBiQGrpsQ5oIPfTsxVbDnlBtITHsKrgVkcTRnHmhJROxPzb6bCJoOGOOynfjE09Txv3usBOuF+eiKZnzHFCIOBzV7Dc/IFAdKFAivwvASBpWHct+kx67lk882JOE6RAoEXvRgGTgrWx9lNwtA8Rphn/NLNU2nusBeRnasAIa+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8Z1Pf0J; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2909978624eso1849788a91.1
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 17:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706579454; x=1707184254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrgz6tZOiYpLEFoYzGvfcOnrH4dVKsSLP5m7v4meYYk=;
        b=b8Z1Pf0JZcCO+dl9gVFsfteYO/qqwR4U11Ty07tjFtlfekuxcQW6UmV8Smpmiu0ca/
         Yx33OWK6zBrpfI5DD+OP3y81ueF6G6vk876hvyRSva4k/OVsEGqqBOHG7gUYFzdZeVwK
         K8n56cz/DyZPjvZdM52vBXFJ27qqh48vWec6W9A3DysgFsU6VI4TJxNcZAGq0mQZRvbb
         o1rbVLSHL/z3b9SSzrdoyvrtD5oBXZKAbTp6Hc7rgcfpK1dFDP0KyLqJJxb65DOpif+X
         59ARJMXrVa/IFY9zfWh3d+eM0g44LSJdgTjIhfL6/8AaYN7cAjeXH6QfUFjsi7MnEk7G
         fAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579454; x=1707184254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrgz6tZOiYpLEFoYzGvfcOnrH4dVKsSLP5m7v4meYYk=;
        b=BaUBVddpNdMSUs2yhjjpuoS7gfXMZHSwYoSfIqHbw7KOdrRhJsp30/ah46M0VUBhJy
         iAQvuDeiQ0JiGzwsy4oAA+impiS6UnvABnyzdg5WQSjW/ByTxG/yXgXD/+xvrtDFzw0r
         MSwz9886AuzrycSLTuG9Iw3OcZEjHLET+cgqSzZJls+/AG+9traef6W0RQPmjmpew5Ap
         xBlraaNQTjy3rHcEPd/IBxWD9bdzEgkFUcDSQJI6rDqsaxOv9QXOXjNb2OZSkXDSH9yL
         a3hAzVHbnpWvsEQ6uiPLggSv84ZpAr1NTojP5TOs9mnq5koYmlzhHABDa9LdfybGhlUe
         zU8g==
X-Gm-Message-State: AOJu0YxMG4KYmk2YvuTyp53Ef1VCDRZof0uz2ocRzNeSIR6unFWgU0IZ
	d6gsNOv5U5ZLRzW0qbjP8JA/Nlp1tINlNJJhssLoW8EsRGY8k+EW
X-Google-Smtp-Source: AGHT+IH+JIUcf8WBD2YFYBWcO9SkUFk800hvRoQu8/xI0XeULQNXNg0xAHB/s8zhSHsAy8NHNB/+yQ==
X-Received: by 2002:a17:90a:c8d:b0:294:abcb:13cc with SMTP id v13-20020a17090a0c8d00b00294abcb13ccmr4249194pja.29.1706579453731;
        Mon, 29 Jan 2024 17:50:53 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ns1-20020a17090b250100b0028e821155efsm9222838pjb.46.2024.01.29.17.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:50:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 15:50:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: David Vernet <void@manifault.com>, lsf-pc@lists.linux-foundation.org,
	bpf@vger.kernel.org, schatzberg.dan@gmail.com,
	andrea.righi@canonical.com, davemarchevsky@meta.com,
	changwoo@igalia.com, julia.lawall@inria.fr,
	himadrispandya@gmail.com
Subject: Re: [LSF/MM/BPF TOPIC] Discuss more features + use cases for
 sched_ext
Message-ID: <ZbhV_NSMUaAknOMW@slm.duckdns.org>
References: <20240126215908.GA28575@maniforge>
 <7f389bbb-fdb2-4478-83c4-7df27f26e091@joelfernandes.org>
 <47d47cd3-f49c-401e-9f45-b3de5a084b67@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d47cd3-f49c-401e-9f45-b3de5a084b67@joelfernandes.org>

Hello, Joel.

On Mon, Jan 29, 2024 at 05:42:54PM -0500, Joel Fernandes wrote:
> > This is a great topic. I think integrating/merging such mechanism with the NEST
> > scheduler could be useful too? You mentioned there is sched_ext implementation
> > of NEST already? One reason that's interesting to me is the task-packing and
> > less-spreading may have power benefits, this is exactly what EAS on ARM does,
> > but it also uses an energy model to know when packing is a bad idea. Since we
> > don't have fine grained control of frequency on Intel, I wonder what else can we
> > do to know when the scheduler should pack and when to spread. Maybe something
> > simple which does not need an energy model but packs based on some other
> > signal/heuristic would be great in the short term.
> > 
> > Maybe a signal can be the "Quality of service (QoS)" approach where tasks with
> > lower QoS are packed more aggressively and higher QoS are spread more (?).

This was done for a different purpose (improving tail latencies on latency
critical workload) but it uses soft-affinity based packing which maybe can
translate to power-aware scheduling:

  https://github.com/sched-ext/scx/blob/case-studies/case-studies/scx_layered.md

I have a raptor lake-H laptop which has E and P cores and by default the
threads are being spread across all CPUs which probably isn't best for power
consumption. I was thinking about writing a scheduler which uses a similar
strategy as scx_layered - pack the cores one by one overflowing to the next
core from E to P when the average utilization crosses a set threshold. Most
of the logic is already in scx_layered, so maybe it can just be a part of
that. I'm curious whether whether and how much power can be saved with a
generic approach like that.

Thanks.

-- 
tejun

