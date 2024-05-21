Return-Path: <bpf+bounces-30071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD0B8CA556
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AE31F21EB7
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 00:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24716125;
	Tue, 21 May 2024 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuQ4VCdb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F1634;
	Tue, 21 May 2024 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716250798; cv=none; b=DJd+ctfO7t1sFrrX30mcaDN5TjsmxsvJmhKbmCYvu8SJ5aGZq2gaiZVsyOjfolDWv6P/hs8gOHuxEcOIEHDYfYvj38nPc3DdfQeby0yunw0LcZQ3nH5pdDmkZF/4zVsqs7nPGIBy3s+1VKreZyiU/+Ef4+M91v9swZ+hmd/TYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716250798; c=relaxed/simple;
	bh=Ki8Bp9SUgR7DQLEyHsvWLKl/NizN/oSQO57h53MUybM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T79ne+WINUnzGtdnwFLJkyGALpgqqu+vjTwRIXpD6Zs6LUohdbYaDRXaPTvbYvZKAdXJzUmH94RTPr/kXQK471mAsWltTF1+GYxnMMe+yYPuGs6aM9UfGsmHAv3aXWvowBFhAklRguwSfCVqi0KNvBZdnbP8sxeR8y1XiQbPut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuQ4VCdb; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b52b0d0dfeso775899eaf.0;
        Mon, 20 May 2024 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716250796; x=1716855596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlpouVRTTk0pmMLRXdxhalkkSlcxcFoChAp7xAv/Bsk=;
        b=HuQ4VCdb0f/a74ucuJNVnL9248LrUCk4WL+agv6LvEux4fNcq34HsCrbBq7KBa3JQJ
         p3spz2eBuTkl0u+QJ7+nNHxaWLT9gsTYdOqfouhZ6IWuFxq8aS1wjZaCPBs/Mk+lu1Rl
         MOUlztZwGr1QUAtZAyImoL+nDD3nH+zP80oFzDG7v33o2bpeE86hK2RxdwlMyp7p24JF
         r2ANFYSd1wQYLfYWl09xn0A/NQZM+GaB0wP/DSYVhelnBlgj4MFh4D5pP2A6jF4johZ/
         GYK0wTCkBEvlUtCFYolAjYEpiouo2AH+kWcl77NtH137jqIVthXpPzAK/UvyNINnNcgN
         b3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716250796; x=1716855596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlpouVRTTk0pmMLRXdxhalkkSlcxcFoChAp7xAv/Bsk=;
        b=GIFu2AblLhrjSNrOI0uF0wQmCHHJtirFnxtmsvibS6zNNrYfOs0eHcC3uV7rAOaMWU
         rHtjgnWKbgt9XaTM6Z+JHOmGbKBn1ZXJ8FX2xNuyDf+bH0XcMm8yztM4uEHpuRYlIY8z
         HdTpz3JGlhwAB/RFt2W/gl+h6rylBIbd28ELY2w2g/WvCAabfdcKHN0vPKjCqhAALWN5
         OmYJZ6lU15fEzwz1tLeyrfpp49ezVS58lMeS3sfshu7eMnSN/IYWBxWD3CCUj0IV/Zw9
         eDVuMm46SZHeBa/UbO6BFYldcu/oiMgGzv/KiudlYWuwwS5R5u11HHoXIseS/aCkSBsL
         Os1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOJLrAgp8pwfDtrl+Mhj6sJdBP19g2n66ROUf7bCF9t5KE+T+rsikotq+JBxpXz6hnZS+G07L1VOgzvbQ7hSdSQg/1FnmZ8GgOkvXFD5ZVMhvOP0k8P2XurLVZBgx+qlAv
X-Gm-Message-State: AOJu0YyWyA2KXmboCQeNiXrTTY4HLS61S8jWDCwEdmOdYsJgjkvNV/Ob
	Zc25CKOwMioryL3DbHE429P8LJ1iJuYeDnYqwAor/eVH2e1KN5PF
X-Google-Smtp-Source: AGHT+IE2WiWGaCyDf9H84lq8Z1wXDCNYCcxCbIbRfZ2PYTlZXmLyR4EiEurLiP2WxQ1SzYg0NNBaMQ==
X-Received: by 2002:a05:6358:57a2:b0:192:50d5:fab0 with SMTP id e5c5f4694b2df-193bb638751mr2332172755d.17.1716250795907;
        Mon, 20 May 2024 17:19:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346dc1sm17324065a12.83.2024.05.20.17.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 17:19:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 20 May 2024 14:19:54 -1000
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
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <ZkvoqvY00UDDcKJU@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <ZkUd7oUr11VGme1p@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkUd7oUr11VGme1p@slm.duckdns.org>

Hello, Peter.

A gentle ping. I don't think this subthread reached its conclusion. Would
you mind sharing your thoughts?

Thanks.

-- 
tejun

