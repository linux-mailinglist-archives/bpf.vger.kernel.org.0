Return-Path: <bpf+bounces-37026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3595058B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10DCB2B379
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83F19ADA6;
	Tue, 13 Aug 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1T8gHxL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E719923D
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553278; cv=none; b=TRRTu8ICGgA6bd/LycAIby1FbpzP8JEiTzOOoyQrUXlf7recrMegc1eZc+M8PvE7pHvt9AfE8PsgI9Uzi7ffJKXe19a+TTPE3u0REiCym3XMjPIL+kcSrS8O55h5BXSshmMDARtW4imbWp63QP5jPe2rqfiLNZXIPWbn1bQqZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553278; c=relaxed/simple;
	bh=0KWhrcU0YHbJiksdyGvlsjytVHRYOXJJLdmQ+/bgpig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6vOY+uxdcDKV/GoAsW1KlxNu4o+CJGzbAAcmZTDU8nbB7zsTp6jckX8o8uwJNeH8qWO1m8pnZc5adRo1EJ01DZ+BdP1FcMkLcSNQGsA/9Qzl7LnNJ/NU64/UKvPQKK4kSq7wkUl99nDHc2CbjOFk0x/k0iQQEEMUxlKa5PKyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1T8gHxL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723553276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XjhAxPmiM++L3njaRU1wOJhxoxtQOjrtQvzpozAwi8=;
	b=O1T8gHxLQQLZo209TavUhwIznXemHNY7fFdK0cDqMgt9fwE40G7hIt6KGexpPV2BK3JJPV
	Xyz9DgiUZGQkCoKwJgj4pvLvYaAo8Nhw3HUBcXr5cpFS6Lxidfvtk5Z6tIToSlh2B6enCR
	GmuNkSDN9Y364De6FJhSkdbFDJLOAng=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-9cj9z-qYMRa2lP7hsRm5jg-1; Tue,
 13 Aug 2024 08:47:51 -0400
X-MC-Unique: 9cj9z-qYMRa2lP7hsRm5jg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 329EF1953957;
	Tue, 13 Aug 2024 12:47:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CB21F1955F66;
	Tue, 13 Aug 2024 12:47:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 13 Aug 2024 14:47:45 +0200 (CEST)
Date: Tue, 13 Aug 2024 14:47:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, andrii@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] uprobes: Remove redundant spinlock in
 uprobe_deny_signal()
Message-ID: <20240813124737.GA31977@redhat.com>
References: <20240809061004.2112369-1-liaochang1@huawei.com>
 <20240809061004.2112369-2-liaochang1@huawei.com>
 <20240812120738.GC11656@redhat.com>
 <2971107e-75e7-8438-c858-b95202d7b5ea@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2971107e-75e7-8438-c858-b95202d7b5ea@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/13, Liao, Chang wrote:
>
>
> Oleg, your explaination is more accurate. So I will reword the commit log and
> quote some of your note like this:

Oh, please don't. I just tried to explain the history of this spin_lock(siglock).

>   Since we already have the lockless user of clear_thread_flag(TIF_SIGPENDING).
>   And for uprobe singlestep case, it doesn't break the rule of "the state of
>   TIF_SIGPENDING of every thread is stable with sighand->siglock held".

It obviously does break the rule above. Please keep your changelog as is.

Oleg.


