Return-Path: <bpf+bounces-51313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E266A33287
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67143A4AA6
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45B256C82;
	Wed, 12 Feb 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrLRpXJ5"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A32063DE
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399161; cv=none; b=PUlkeLQsS0NBjdGF3xNMsiX4wFzKKJb1AS4tjG92mVF5PVGLzTJmlkG59piL4l7pSLB45n1+hYLxyHiXxT7Vy1Chhp9lMLYAFALieW3iEc2CE9U5Aq9VhHLl/UxJxtLhV66VxJfMOnL9z1NwVcHF0M+2kMpZN/4JeND2SOulvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399161; c=relaxed/simple;
	bh=uKV3KqsynzdIb/LMoWcY3A8YZP96ipksOMa35TqOjCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=illD4rqk2yAbXjiiUW9Ycfbq+OYyDBp0X7tEElW2ZzPujp/bdgnPRMoTc+FkiIO3oN5+Jr1ej12qwc+RFUlyNYPUu6RvROyWkPL4Q2MCxtGwi7KHNMbxNqPtKIJ/tGBB1IYlBKGhSHIi6ihS7wJ2B1T86aXPXKdsJvJA+1hm1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrLRpXJ5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Feb 2025 14:25:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739399157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m9HBBII1nXU+thEECyzJU0uguy9bFF7mdhp10qRQOVI=;
	b=SrLRpXJ5qzKU1iqI2AZ8397DntehUUTtddlftErTwaaLdtlyqgP3yJ8Ykuen0u/8MqpGG3
	wYtYQhblm+6QR9WCspKZg36XGWtVAbXid4H7tW21PyaMQsQlBpvhdEWdyeufy6FKDXCBtm
	feXOnRziB+3+heC0wg0EWC9OQ4x7YfA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>
Subject: Re: [bpf-next v7 1/3] mm: add copy_remote_vm_str
Message-ID: <rkor47tohikmgixexi46mpalttxud7k2n5gidqbxoqzhwkjkas@rdl4dzndjz47>
References: <20250210221626.2098522-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210221626.2098522-1-linux@jordanrome.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 10, 2025 at 02:16:24PM -0800, Jordan Rome wrote:
> Similar to `access_process_vm` but specific to strings.
> Also chunks reads by page and utilizes `strscpy`
> for handling null termination.
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>

If you decide to send a newer version, my request would be to add some
more text in the commit message particularly on the motivation.
Otherwise this looks good to me.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

