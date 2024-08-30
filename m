Return-Path: <bpf+bounces-38545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B674F965F0F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 12:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265D0B28AB8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72218E37D;
	Fri, 30 Aug 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQe1R1Qt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572818E35B
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013466; cv=none; b=OpYkUUn/u05ZV2t4cDTmmkyUFsIn+wsvqbJJTlZ2P8k3a4MQ4FphfhVEu4vhO04RbgSqvfkiV+FWw/bwLXVI9fTDjYDn0n965OGJquFbgASkkP1YIKs9ce/NmOXenMsBdMfiPPVZOUOqtAFNotbLOMe7CkpHl/+tFVoK3ajwaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013466; c=relaxed/simple;
	bh=RQsHHI7kpVwOdK1joEOHTJ/7pkW/4sUkVR399XuvvWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5SQOryPRN5i8r0qc4CcbUA+BPyTBQu61VBHE85r3pq38pJhoohfFYensblHfROujQMH6vsE93Ws1Plf39oaJ661w7GSsksMJsA5WXM9XJbh7xyx7R0O4exivdfv627ZRr0A598QQz5GwqDc+vDn1Q4h38Q+EHsH/Q00akseSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQe1R1Qt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725013463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYesMj5ueiMNqutffq7npoYQS7CjMMgXBJZZO+/Hjyo=;
	b=FQe1R1Qt39S7rZqUVpm1Ab/l1e7tS2KjELg6VAjDg2d9MBmuZFsx4DkocRoRVnBz0XlmZC
	nklkwt5xLSKVckyPa9a0KvgfR7j9klnb0BaeZFVuB0pmqKs55rq7ARKrV/1PdIlkPk0+1U
	1F69T5rRRJP01KTQ1o2bewVkkR8Q2cI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-nL0bmLKMNpqdezNL84YlXg-1; Fri,
 30 Aug 2024 06:24:18 -0400
X-MC-Unique: nL0bmLKMNpqdezNL84YlXg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 967581955D48;
	Fri, 30 Aug 2024 10:24:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8F0F61955F45;
	Fri, 30 Aug 2024 10:24:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 Aug 2024 12:24:07 +0200 (CEST)
Date: Fri, 30 Aug 2024 12:24:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240830102400.GA20163@redhat.com>
References: <20240829183741.3331213-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829183741.3331213-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/29, Andrii Nakryiko wrote:
>
> v3->v4:
>   - added back consumer_rwsem into consumer_del(), which was accidentally
>     omitted earlier (Jiri);

still,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


