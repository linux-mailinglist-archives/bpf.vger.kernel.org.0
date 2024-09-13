Return-Path: <bpf+bounces-39819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB4977E14
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 12:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68249284FF8
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F751D86E5;
	Fri, 13 Sep 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDwK5nO/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D01D7E5F
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225098; cv=none; b=g1/OBN+THddXqx1VAxrXRUhqn04be8Iu1fF9SDGLHKeCzPLawm4lYRfBpJ22TsWW+k3oFagPXGFW2mofaWcSD/H1Y+5ZC7QkgLMHIdzRluSDNC6awsXYmaNtBoRd9+pYVnAjYde7CbD+jVI3tI53I0Fml/GWs468NFj7nIZUSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225098; c=relaxed/simple;
	bh=PuICNJQ41hQAOKN1VIgzlPpSfWBu0kS+xFesko2vUbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7zv28+mmg7soTYnjFlXB4p4Osk8y9t4Xn9TYVlw9QFe0HCONUYTZLtXtnv1300ZBX7/p9RCd0it9yFk0fZNZXWbM+GX1V4bUTYmpwAeCwFCkyfgSU9C5DRhljeWl9RJOt0pkHuyinoYcDND4tvdPl2HTy5GuhHOydPeVv20UOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDwK5nO/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726225096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yEyCfC7/27Rfki8MipJ7YVuASL9eBnGBIDBoZ1Zsp6Q=;
	b=hDwK5nO/5SF5Xk64RlBeLsQCdOL2WpOrxt1s/IyqiylSZdt3sIqjI9eUM2LT3nCkSTueZ0
	sMx6BCVoEcSpoUbv5Io48qDspFBpCFlHkmimb7fLgjoeaqBO32uqiuriOx100MOCZNszXC
	A1JpweVFlKRfDRDpG0EqYP5RL4TH6qs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-t8K8AcN5NbuMAQUtXCsswA-1; Fri,
 13 Sep 2024 06:58:13 -0400
X-MC-Unique: t8K8AcN5NbuMAQUtXCsswA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06A8119560AB;
	Fri, 13 Sep 2024 10:58:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C5E4319560AB;
	Fri, 13 Sep 2024 10:58:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 13 Sep 2024 12:57:58 +0200 (CEST)
Date: Fri, 13 Sep 2024 12:57:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <20240913105750.GC19305@redhat.com>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912162028.GD27648@redhat.com>
 <ZuP2YFruQDXTRi25@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuP2YFruQDXTRi25@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/13, Jiri Olsa wrote:
>
> I'm not sure the realloc will help, I feel like we need to allocate return
> consumer for each called handler separately to be safe

How about something like the (pseudo) code below? Note that this way
we do not need uprobe->consumers_cnt. Note also that krealloc() should
be unlikely and it checks ksize() before it does another allocation.

Oleg.

static size_t ri_size(int consumers_cnt)
{
	return sizeof(struct return_instance) +
		      sizeof(struct return_consumer) * consumers_cnt;
}

#define DEF_CNT	4	// arbitrary value

static struct return_instance *alloc_return_instance(void)
{
	struct return_instance *ri;

	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
	if (!ri)
		return ZERO_SIZE_PTR;

	ri->consumers_cnt = DEF_CNT;
	return ri;
}

static struct return_instance *push_id_cookie(struct return_instance *ri, int idx,
						__u64 id, __u64 cookie)
{
	if (unlikely(ri == ZERO_SIZE_PTR))
		return ri;

	if (unlikely(idx >= ri->consumers_cnt)) {
		ri->consumers_cnt += DEF_CNT;
		ri = krealloc(ri, ri_size(ri->consumers_cnt), GFP_KERNEL);
		if (!ri) {
			kfree(ri);
			return ZERO_SIZE_PTR;
		}
	}

	ri->consumers[idx].id = id;
	ri->consumers[idx].cookie = cookie;
	return ri;
}

static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
{
	...
	struct return_instance *ri = NULL;
	int push_idx = 0;

	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
		__u64 cookie = 0;
		int rc = 0;

		if (uc->handler)
			rc = uc->handler(uc, regs, &cookie);

		remove &= rc;
		has_consumers = true;

		if (!uc->ret_handler || rc == UPROBE_HANDLER_REMOVE || rc == 2)
			continue;

		if (!ri)
			ri = alloc_return_instance();

		// or, better if (rc = UPROBE_HANDLER_I_WANT_MY_COOKIE)
		if (uc->handler))
			ri = push_id_cookie(ri, push_idx++, uc->id, cookie);
	}

	if (!ZERO_OR_NULL_PTR(ri)) {
		ri->consumers_cnt = push_idx;
		prepare_uretprobe(uprobe, regs, ri);
	}

	...
}


