Return-Path: <bpf+bounces-71366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88169BEFFC4
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CECC18976F4
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA9A2EC08D;
	Mon, 20 Oct 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE+T+XCA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC22EB873
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949385; cv=none; b=A6AGUhIs/2pvTS6rMt/jKHt0xFrqLVYzjA7EN+FQjTFI16WJdMca4QUOt4FiRVHLiLN53+/7lzZXMZi9Jo8eRA/JuXEUsiVL+D0jAzIAl/pxbBi1vlLIqAkYG2xlt7WCqUEFf3K1X+Eovp9vMsmWH4SBSe0jGEphIzgPa3eiDMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949385; c=relaxed/simple;
	bh=wzYeKe8llsS8xH05UqQBqkk5pJepcdnzGoYD0EgvANs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdW4vH6EQ7TeX4sLS+K6ri9vZtjyotRzpMtuENKa3/DJ0a7C92oGadLfrHO+9ynUu9BN0ys8/yXy/l4KBoSa0CI8Ya90oJhmu5+2+b/jS+/MTHw5gF8KDQ4IV4E59t1narZOoGFTQ092BFjQwd8lkTWhj1wI3szKI9NERfvBngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE+T+XCA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760949382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDPZ0ul7eThbecq+UNdvM4KlBx5eDgTRibaStyKpTWQ=;
	b=JE+T+XCApnvv31aq5BvuV65PVpgUeen3+KaEzi97ptpHJn2BP9vaNG0j/Oqhx9GDWS1prq
	/FU/qLkRTRloi4Vae+1VlXRIvf4r7XdWqKsEIiiWs6sl1xxmZPZTHppEaNSLegqwQgVdM8
	G8DEBYa8qQsc2RANavpO+gntlW2gn5c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-DFK4c_3mMRGFUX8mncxo5A-1; Mon, 20 Oct 2025 04:36:20 -0400
X-MC-Unique: DFK4c_3mMRGFUX8mncxo5A-1
X-Mimecast-MFC-AGG-ID: DFK4c_3mMRGFUX8mncxo5A_1760949379
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso14314395e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949379; x=1761554179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDPZ0ul7eThbecq+UNdvM4KlBx5eDgTRibaStyKpTWQ=;
        b=c9VKDfP2mNf90lITj0xXnUL6XdBoJRnTy1tKA+NJUURk1opNq49b3BajFnvOQbWJlo
         KTPNTv4BRjHKyHxm06fZ/VgSLsgP8ju2g8gO2v13jguW8rf9NHW8P4Hhsi0Uf7LW5EVo
         qV36R/8Y2ypRiNJyEyhFmYfKJ0sMpS0tJh5QqYdJq7UJeodFuRATyHWautmVGOIE6Bfp
         zLrktVhaOicY5cSlAEFo+E+QoUxEKVO0aEuzc+gGwU+KknWWEDly42iDDhJ6qks6skp3
         YpTvvE+qA/ETsJ0LKTYWLI7sPsvRtWs8OchIiEbi5xmxYjNTig58ha5B+G/h2KI8wN1G
         DyTw==
X-Forwarded-Encrypted: i=1; AJvYcCWTCuLoov1PD2yom7+J9+Ryw4Fgg7C3KAigFZZYAnn/CwspmuAEjv+h4feIlO9MEK+2qTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLo70m+WF1uXt3JL+YsA0weCqGK3mgk3EAM4Yd97J/FtPGPFa
	0PB8cZJ5zRGKFv7egu1O/Q0RmJ3uZ6gPXxygO98iE8xAaWqJ2jmwJPZDX8KjKu5mWvQ7BCjUWin
	1gm209FRus7vRVdfWrY0tDIed8qGAq9bl8I4j/6l+WKo8ym1/qt693A==
X-Gm-Gg: ASbGnctsYOwtCd0tDRb3JfJwCvGV55mGZN1l4+JQloj0LlIJY3klPLSqJEaa5Dwfxav
	hFu/Eut/GMUeW8WBUoRCs0Kgy0g+5kHUzN5DPoG+gFShgHQ0q8ZOs40r14tNMOBMNAccZsfrcrQ
	CahGwY9WJJBpFYyvhrw3U6AEnBWbWKjRhRUV7TiuZfJVOtNZCE+Mj7boOtAQ6zyvP8FWzVeVHiD
	r6RLvkCiv+5gQCfIcDJZRDCjUuSjUqVCmf1mQuCnyYQzje3JayyYknwOlP0gapOgg2MsSbcLctY
	dQNqkLcrowN47HvyZWpaso3/P370ThwYKw3CV91Cv+Zn27OLaXpRRHMROauv7JgppFobKrpm/XB
	ZF4yKvYCnKsv9eDjEr95SVN/RwcX6Csg=
X-Received: by 2002:a05:600c:6290:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47117345ffdmr107954745e9.19.1760949378905;
        Mon, 20 Oct 2025 01:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9PwoSk43ABFo5essiejYiBkUkNUIQWrYCuPXPAmRDQtUNGUR37Zqt6yI37QTO1Cp76s6VKA==
X-Received: by 2002:a05:600c:6290:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47117345ffdmr107954455e9.19.1760949378471;
        Mon, 20 Oct 2025 01:36:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710ed9e7d7sm112564395e9.3.2025.10.20.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:36:17 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:36:15 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] sched/debug: Fix updating of ppos on server write
 ops
Message-ID: <aPX0fwMfPi1M9SL_@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-2-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Updating "ppos" on error conditions does not make much sense. The pattern
> is to return the error code directly without modifying the position, or
> modify the position on success and return the number of bytes written.
> 
> Since on success, the return value of apply is 0, there is no point in
> modifying ppos either. Fix it by removing all this and just returning
> error code or number of bytes written on success.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


