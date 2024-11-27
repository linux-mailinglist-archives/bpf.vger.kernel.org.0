Return-Path: <bpf+bounces-45696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2D29DA377
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 09:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF168165094
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 08:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E613156236;
	Wed, 27 Nov 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGYnTtyv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F21272A6
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694559; cv=none; b=Y4oESnrx4O/ggfJFMHYIXaHKvc3D/uR8CG1LjNMf1k7z6oM9gOuSIqKsBpGiWgXQRi2zfL22yI1fFEjBMbpMemKME/zTiYI433/rTddVou7qJeVkXQr4Ed9DKY5QTE7FtuBnZXSR2BWUrMat8bfTXLkEVG96q+9puxGdYEnAJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694559; c=relaxed/simple;
	bh=Psq5ZuC5Inn1c7voFTAP1G67H7S83lRQXRKRS4yE4mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1cwuU3oftXIJlnzoDbWulKMEiw/8oKYenWVkF8/u5pHgRYzd1wzKn0l+IoFweOXYpOcTjc3Dz8eCgdqp8XHdMgKM2PpqhrJ4bcCIm2AXYDO9/Q6LsTYro2prMz07I5GiBNesJx6l8N3J78l0aCA9sZcTq6IbiY7DP+GqpS5gHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGYnTtyv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732694555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Psq5ZuC5Inn1c7voFTAP1G67H7S83lRQXRKRS4yE4mk=;
	b=YGYnTtyvYASdVWfzWvnePpXbY7rlGGgtcVUBRp+FOVDn4JFMLKgqqEcKJrVc6nDOqTtUju
	tD7mCo3TSSG1JCRUUmnpbKQb8xDBT9lgfHIrmKk4FMAKbN2BvBifi1wMQcwUkwNtLscZqE
	YF5fZZLdzrGJCAmZhJZOQNX32Nj76NM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-KBXU4aMHNGi2YkGLDQqVAQ-1; Wed,
 27 Nov 2024 03:02:32 -0500
X-MC-Unique: KBXU4aMHNGi2YkGLDQqVAQ-1
X-Mimecast-MFC-AGG-ID: KBXU4aMHNGi2YkGLDQqVAQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1501E1955F57;
	Wed, 27 Nov 2024 08:02:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.52])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E418519560A3;
	Wed, 27 Nov 2024 08:02:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 27 Nov 2024 09:02:07 +0100 (CET)
Date: Wed, 27 Nov 2024 09:01:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org, peterz@infradead.org,
	mingo@kernel.org, torvalds@linux-foundation.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com,
	brauner@kernel.org, mhocko@kernel.org, vbabka@suse.cz,
	shakeel.butt@linux.dev, hannes@cmpxchg.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	david@redhat.com, arnd@arndb.de, viro@zeniv.linux.org.uk,
	hca@linux.ibm.com
Subject: Re: [PATCH v5 tip/perf/core 1/2] uprobes: simplify
 find_active_uprobe_rcu() VMA checks
Message-ID: <20241127080133.GA7717@redhat.com>
References: <20241122035922.3321100-1-andrii@kernel.org>
 <20241122035922.3321100-2-andrii@kernel.org>
 <CAG48ez06=E-rXYk59yJR2aKFD2yaqcQu+6wqVau9pQ8X36A+aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez06=E-rXYk59yJR2aKFD2yaqcQu+6wqVau9pQ8X36A+aQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/26, Jann Horn wrote:
>
> On Fri, Nov 22, 2024 at 4:59 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > At the point where find_active_uprobe_rcu() is used we know that VMA in
> > question has triggered software breakpoint, so we don't need to validate
> > vma->vm_flags. Keep only vma->vm_file NULL check.
>
> How do we know that the VMA we find triggered a software breakpoint?
> Between the time a software breakpoint was hit and the time we took
> the mmap_read_lock(), the VMA could have been replaced with an
> entirely different one, right?

Right, but this doesn't really differ from the case when another thread
replaces (or even unmaps) this VMA after find_active_uprobe_rcu() drops
mm->mmap_lock and returns a found uprobe.

So I think this is fine.

Oleg.


