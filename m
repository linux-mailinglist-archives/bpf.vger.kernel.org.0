Return-Path: <bpf+bounces-33765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1465C925EE7
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D87328526F
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF32142649;
	Wed,  3 Jul 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASxXKxjw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAE13AA2C
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006972; cv=none; b=HGG92GLvUUcpXt49iC3vTCdjeoVqzY6JEYchb/uVF3+0v7sc4BDcPMjsNSSRBk/50s37r5h0ySnn1LykEeOF496fxHbpM837RjEYPeZB2CGJJT+uJjj2MW0SNqiSD2ms/S8VXfp3H/5JJoKAMdW1DAcctw3VkzIeKX2zIiE/mJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006972; c=relaxed/simple;
	bh=4sNK2ppBVN9/ZqYZi5JjZS4Zc7zCyu7uaoZJqNxVpwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMiKBjl3ikdFz0QpGsACB6QAbWAgujI82b+FWPlBwFtG7A7dYBH8d3OzapXhbLJ+jnG5wr6P12E1LhJNZI+uqBAc/2/9rqjGLbdyahmjq7bmr44bVTR52xm+kExzFuQy6RBxa2oN21NZqViCTYlqv7klLFW4cvJpQ7Pgzr1fV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASxXKxjw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720006970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/PZ6xrKTnI/WBJhbaJ3sWlKKb/IBmTt/4C2c0YjNIAs=;
	b=ASxXKxjwu6PwU+lOror6Igza8ppZNXAd30iSw4oooHgN/15SwrIdf90LAjtsnzK62BHUIn
	J3ieLO+Bu4C3Mjy4nCGE8mxBroCRF29Atze4lBkN1uoehuZakgkwMgQm1Ip+Js2l6uasu4
	I+07YKRDrg55VJ9BIBrsQoxVafxoaNc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-yMnVDJd2OeOLH-_KWuHR9A-1; Wed,
 03 Jul 2024 07:42:46 -0400
X-MC-Unique: yMnVDJd2OeOLH-_KWuHR9A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 373EC1956095;
	Wed,  3 Jul 2024 11:42:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7117D1955F21;
	Wed,  3 Jul 2024 11:42:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Jul 2024 13:41:08 +0200 (CEST)
Date: Wed, 3 Jul 2024 13:41:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 02/12] uprobes: correct mmap_sem locking assumptions
 in uprobe_write_opcode()
Message-ID: <20240703114103.GB28444@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701223935.3783951-3-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/01, Andrii Nakryiko wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>   * @vaddr: the virtual address to store the opcode.
>   * @opcode: opcode to be written at @vaddr.
>   *
> - * Called with mm->mmap_lock held for write.
> + * Called with mm->mmap_lock held for read or write.
>   * Return 0 (success) or a negative errno.

Thanks,

Acked-by: Oleg Nesterov <oleg@redhat.com>


I'll try to send the patch which explains the reasons for mmap_write_lock()
in register_for_each_vma() later.

Oleg.


