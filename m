Return-Path: <bpf+bounces-22218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FDF859120
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF3AB21094
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD17D3F6;
	Sat, 17 Feb 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwMpysoM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4297D3E6
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188268; cv=none; b=oopotdtYH3V1Xgquwz/dhC2Cck0XKZVeWf9n548Sx7X/wvu/faB5zhiMJTiV+C9CtxxCrjbla0RP5YRAJ26sgQd2qjZKppRdz1E8HCG608inago/cyu3oc4TTlmYOVR/xr7nRvTPAaswTNPUCYLtSzwoa6VDp3tCFvo/6PEym3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188268; c=relaxed/simple;
	bh=qw13Xmsf1rKLTr5Fr3kPTKBq6K2QpZrOAuMM/OLHIps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0SOWsnddysTH5VWfXJBgqq/Onw4hj8Xi9AYjsa2nbiwZV+7Ruz/LNQjr89wU17kt5qSLJgYPyjvCMmxQceKkPhkduu8b2KxjC1ibUzPA8f4SdnjfSpS5e6B6iN8/6D6X8aXtVLQGypgFYTrDGTDYBYnq8Y+vrsoVLIXn18jiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwMpysoM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708188265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qw13Xmsf1rKLTr5Fr3kPTKBq6K2QpZrOAuMM/OLHIps=;
	b=cwMpysoM9E6M7kWoczNawFrg6AGVZLKH758GmUnMsgA8CyZOrRzcvYSZzxuCsbCI2UGmCJ
	aRHbE/nw1RQtznxL1Ge01AfqS/ymH+jB6EbiRcqPFalEZbfDuE2Lt3KAYu15fqjqUCN/Y3
	KAzmHJFbDxbNpj7Ogrqf8RGA70iK5vU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-PXL7k9KXN-OduuYTZH5CNA-1; Sat, 17 Feb 2024 11:44:23 -0500
X-MC-Unique: PXL7k9KXN-OduuYTZH5CNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED1581005055;
	Sat, 17 Feb 2024 16:44:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with SMTP id 730431C060B1;
	Sat, 17 Feb 2024 16:44:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 17 Feb 2024 17:43:05 +0100 (CET)
Date: Sat, 17 Feb 2024 17:43:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix an issue due to uninitialized
 bpf_iter_task
Message-ID: <20240217164300.GA22909@redhat.com>
References: <20240217114152.1623-1-laoar.shao@gmail.com>
 <20240217114152.1623-2-laoar.shao@gmail.com>
 <20240217120333.GC10393@redhat.com>
 <CALOAHbCNs4VvVoKGTyw9E5oK=nh4v8+7A=EOt9pmj-n5DTYABQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCNs4VvVoKGTyw9E5oK=nh4v8+7A=EOt9pmj-n5DTYABQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 02/17, Yafang Shao wrote:
>
> On Sat, Feb 17, 2024 at 8:05 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > Fixes: ac8148d957f5 ("bpf: bpf_iter_task_next: use next_task(kit->task) rather than next_task(kit->pos)")
> >
> > Confused...
> >
> > Does this mean that bpf_iter_task_next() (the only user of ->pos) can be
> > called even if bpf_iter_task_new() returns -EINVAL ?
>
> Right. The bpf_for_each() doesn't check the return value of bpf_iter_task_new
> (), see also https://lore.kernel.org/bpf/20240208090906.56337-4-laoar.shao@gmail.com/
>
> Even if we check the return value of bpf_iter_task_new() in
> bpf_for_each(), we still need to fix it in the kernel.

Hmm, OK. Somehow I naively thought there must be an in-kernel check that
would that prevent bpf_iter_task_next() if bpf_iter_task_new() failed.

Thanks for your explanations. FWIW,

Acked-by: Oleg Nesterov <oleg@redhat.com>


