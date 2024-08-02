Return-Path: <bpf+bounces-36265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE87945A4A
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BD7280E1E
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED61C37A1;
	Fri,  2 Aug 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7zW+TbS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864791C0DF0
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588657; cv=none; b=ky6C8TVoL+RQXwXAHVwibU2p8fTygOvEvp4rBbuDA5jtrO+qxkbMiWM99AA3Gb55T9zer2UAfZdAUOnZ1RgzutHLelMOyVJgdl/DsBIWXsLfJOciX9iG3+u9F0xkr/seQmWdF6jVxs8gr6pM6RQqKYi81cTvInkjTNoIgMi4FnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588657; c=relaxed/simple;
	bh=HPlsNDCyl1pA4SJW2l3/u62IkAccM0lCQp9d6Y4qNO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF0Lxjp9dc8xZXxrPDxpQS0U1MbTjrryu0xC4C6zS75cplmJdAQGzyKreB3YCdvBlMb8u+9moXgCUSnh84ivCM5EgI3fnVwHTAMDD34Qq6eKLFRsmxYhWuh1GjAN2r0JXTafoSr9kxHvj6q+1B8KwPwdtDKL8wZFqHxKbWC7X20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7zW+TbS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722588654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s5DZo4o3X4z7a84jIBvonPi5Z0Gb8BZSJthltxDUVjw=;
	b=H7zW+TbSQFWUuC3YtYmhpcHVMBoS7nqjVvwkcA+iqVPLf7OH1+vYQAbXXvZ46wbSp5pyxA
	807zQW/jTClEdJzqILrq2Omo3m5NoR07FJ+lMuR5uQfsZGpPvUJR6qs9emuue6RZ6QpqjI
	muq9M4W6+vnNYmogSAY/X+9kvgNvgVo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-7kBEnFfKMK6GyAT2Jrsglw-1; Fri,
 02 Aug 2024 04:50:50 -0400
X-MC-Unique: 7kBEnFfKMK6GyAT2Jrsglw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5236B19560B4;
	Fri,  2 Aug 2024 08:50:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6362B19560AA;
	Fri,  2 Aug 2024 08:50:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Aug 2024 10:50:46 +0200 (CEST)
Date: Fri, 2 Aug 2024 10:50:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240802085040.GA12343@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-3-andrii@kernel.org>
 <CAEf4BzYZ7yudWK2ff4nZr36b1yv-wRcN+7WM9q2S2tGr6cV=rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYZ7yudWK2ff4nZr36b1yv-wRcN+7WM9q2S2tGr6cV=rA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/01, Andrii Nakryiko wrote:
>
> > +               /* TODO : cant unregister? schedule a worker thread */
> > +               WARN(err, "leaking uprobe due to failed unregistration");

> Ok, so now that I added this very loud warning if
> register_for_each_vma(uprobe, NULL) returns error, it turns out it's
> not that unusual for this unregistration to fail.

...

> So, is there something smarter we can do in this case besides leaking
> an uprobe (and note, my changes don't change this behavior)?

Something like schedule_work() which retries register_for_each_vma()...

> I can of course just drop the WARN given it's sort of expected now,

Or least replace it with pr_warn() or uprobe_warn(), WARN() certainly
makes no sense imo...

> I don't
> think that should block optimization work, but just something to keep
> in mind and maybe fix as a follow up.

Agreed, lets do this separately.

Oleg.


