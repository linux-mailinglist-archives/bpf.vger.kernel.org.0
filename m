Return-Path: <bpf+bounces-32563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C717B90FF05
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7851F26337
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B519924B;
	Thu, 20 Jun 2024 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAbMTxU3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242213A1AC
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872668; cv=none; b=djJum5mB+kI9pKlgFz2ySDYd+JzC228+O0+8SVUfXm/KBeVQ8gyau5m3SMyCkhHB1eSpoCiPzjoKaaHcttV81Gbqx7e805ILZORHHn8kcoQ9fjOGPTXX1WFQL5mQIEGtt+n+7IrNFdhBucn4mhsNWmXS7svbgeMTKPRi3AWVY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872668; c=relaxed/simple;
	bh=E2Ju9fp2WTW1iR8HjEuO5MAtycedFCSY0cqdWH009NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em7P1KRdVA6fuFvfKz0614w5phuXARvWXEpuPuquJsd2R3ZwpxJpZ6xk0CkHBmO4st60mlwh30eRPO/5Uj05phgmU3fE0OxBNMBlDnZmYVmyLNGfz51kdLATxRrIsfMuFb+3xf3U1EDO7QW8X2jw4GQYxtDiT1ARZXfZ4CgxHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAbMTxU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SToOFzrIKhKXuIiPgWYwTICjEcUL7XQf34Si3tl9FLg=;
	b=LAbMTxU3oqIYgmiedcSu9Z98Hf6qWuBIv3Z9sFrv7deYPVZ6sHyl46lVSl5KZFM5e4Uy3f
	wpioiJmR6sfZWEb09ZG39qkmG2omXz65BIXhPr+aqURCk3HuqktnutpWNY2R/lVtfGv0yf
	IsrwbMJvEypcm+l9ZyMfzpghIx4zapY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-et_w7DOJNQurUU5Y8eXvqw-1; Thu,
 20 Jun 2024 04:37:42 -0400
X-MC-Unique: et_w7DOJNQurUU5Y8eXvqw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8358519560B2;
	Thu, 20 Jun 2024 08:37:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1FD841956087;
	Thu, 20 Jun 2024 08:37:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 10:36:08 +0200 (CEST)
Date: Thu, 20 Jun 2024 10:36:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	nathan@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
Message-ID: <20240620083602.GB30070@redhat.com>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
 <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/20, Liao, Chang wrote:
>
> However, when i asm porting uretprobe trampoline to arm64
> to explore its benefits on that architecture, i discovered the problem that
> single slot is not large enought for trampoline code.

Ah, but then I'd suggest to make the changelog more clear. It looks as
if the problem was introduced by the patch from Jiri. Note that we was
confused as well ;)

And,

	+	/* Reserve enough slots for the uretprobe trampoline */
	+	for (slot_nr = 0;
	+	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
	+	     slot_nr++)

this doesn't look right. Just suppose that insns_size = UPROBE_XOL_SLOT_BYTES + 1.
I'd suggest DIV_ROUND_UP(insns_size, UPROBE_XOL_SLOT_BYTES).

And perhaps it would be better to send this change along with
uretprobe_trampoline_for_arm64 ?

Oleg.


