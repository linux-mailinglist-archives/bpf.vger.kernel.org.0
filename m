Return-Path: <bpf+bounces-32585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEBF9101F4
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F3728130E
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E291A8C0C;
	Thu, 20 Jun 2024 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZIzyRo0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB082C694
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880828; cv=none; b=ZkMdv/4CuEcCdCu59XyXLSo12U9KaQMw94LgGWLHI4CNl8a6tOcSt+hK8N1KRIPHkzAPMB6Dd9YCEdy2whmp7uZ5IE5ELpvEUu3xl7IbDhh9Gb9Qlxq9d47hqxJt8uQSaBYI/S3fuyJWXeivJMu+ig60WuYBPWVJ4NI6NM0kh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880828; c=relaxed/simple;
	bh=YhVNZVJotcrbQnNA0C2ERjJ5On3FcuCmck5hLWMIyPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7DTMULjV0F6uulUIqHFucK4N/zIVW8hvI0y3qNwNLcaxHr7JNek1TAr1nQsyPbKChx7WZk75DE4FeJC3wC2Vw+8oKJVLmJgBVdQswpnfW7TUUy+DwyTKGHffJbwEb8AXaqpbFp6xYBbOSO9CQoRxNtWMQjh6jDOjqDp6zvKB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZIzyRo0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718880826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhVNZVJotcrbQnNA0C2ERjJ5On3FcuCmck5hLWMIyPk=;
	b=EZIzyRo0d13x5gIKpEXTG3TMlcP/m6lp/VRMxRMKu0VsNUuIO3j755bSe7DklXhNgRxaPU
	AlQJgJZWaUwmwZhrRgsXnRG3ynj89zlk6/UrT5Zh2JrIkBhZt2368yxNYWRSrc5Bh9aZGd
	ggkzoeyD3KYclTPULooPggRuTYub4rI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-cEh00LHwMS2gzgbBqp2q3A-1; Thu,
 20 Jun 2024 06:53:43 -0400
X-MC-Unique: cEh00LHwMS2gzgbBqp2q3A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2B4C19560B0;
	Thu, 20 Jun 2024 10:53:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D396F1955E80;
	Thu, 20 Jun 2024 10:53:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 12:52:09 +0200 (CEST)
Date: Thu, 20 Jun 2024 12:52:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	nathan@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
Message-ID: <20240620105203.GE30070@redhat.com>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
 <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
 <20240620083602.GB30070@redhat.com>
 <f0678e11-dd59-2e9b-56d5-cb28a20ffac7@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0678e11-dd59-2e9b-56d5-cb28a20ffac7@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/20, Liao, Chang wrote:
>
> 在 2024/6/20 16:36, Oleg Nesterov 写道:
> > On 06/20, Liao, Chang wrote:
> >>
> >> However, when i asm porting uretprobe trampoline to arm64
> >> to explore its benefits on that architecture, i discovered the problem that
> >> single slot is not large enought for trampoline code.
> >
> > Ah, but then I'd suggest to make the changelog more clear. It looks as
> > if the problem was introduced by the patch from Jiri. Note that we was
> > confused as well ;)
>
> Perhaps i should use 'RFC' in the subject line, instead of 'PATCH'?

Well. IMO the changelog should explain that the current code is correct,
but you are going to change arm64 and arch_uprobe_trampoline(psize) on
arm64 can return with *psize > UPROBE_XOL_SLOT_BYTES.

Oleg.


