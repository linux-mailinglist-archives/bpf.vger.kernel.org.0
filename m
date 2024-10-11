Return-Path: <bpf+bounces-41736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B3599A2AE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEAC1C22A1B
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC3B21642E;
	Fri, 11 Oct 2024 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqWN39c2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287821502D
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646103; cv=none; b=gbfzrg+EVPLqoz1+6E7CSmOg1iwmj5Ltpp5Lv/trfxRS/nEMRBu+cYXnkpzFZ+0SaJyUfIuk1e6rNruE1kHYf8AtIFI4D9O1CGUZD8xdUjwlDGUPPynuSdFWnPL94S2kWvs6cRBISsbSPRWVNkshV1hC+zijjS57Cbqer5aSZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646103; c=relaxed/simple;
	bh=BlfqTYePpkTIVLUZqLdbWQakAvYxLoLPft8IAiIF51I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8ZEEjDsE8Hhzhgp0zx7R1uibJ7S/L8PcLXXPRvpNuD5H6iAB19OxNVj4xmzdEld8aqV6Pz9puz9KbOwH8tEYBM8NPsWhskQKXKpb/t5uGRYT+0ht1lZvDH8cr00y+5tsWUXOU/DVLs8PZ1W8sLltx59IieP8E6DBzvnIYJKua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqWN39c2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728646099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4HAG/FNfY4USQmCWPTQgELr7Lx25qhoKxL0+773/Hho=;
	b=dqWN39c2djddKG0BWhGGG/Qu8RmPdSeU27Bd3dylWQVfYt6eK2bS8XYh49zzSXlfI/1gkv
	VNCANvB7BnhkpY5ALqXeellmK9jeAC2QEM74Z5LxmRn59BbkgLJmBggmMzdGqwl/uHaeLx
	DGuZW9PLqAwwQQRDCXH50Oro/eYnAGk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-zU7HdmRxOICk-TfUnEvZQg-1; Fri,
 11 Oct 2024 07:28:13 -0400
X-MC-Unique: zU7HdmRxOICk-TfUnEvZQg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34FE219560B5;
	Fri, 11 Oct 2024 11:28:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.109])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 85BEE19560A2;
	Fri, 11 Oct 2024 11:28:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 11 Oct 2024 13:27:56 +0200 (CEST)
Date: Fri, 11 Oct 2024 13:27:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv6 perf/core 02/16] uprobe: Add support for session
 consumer
Message-ID: <20241011112747.GA26310@redhat.com>
References: <20241010200957.2750179-1-jolsa@kernel.org>
 <20241010200957.2750179-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010200957.2750179-3-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/10, Jiri Olsa wrote:
>
>  include/linux/uprobes.h |  21 +++++-
>  kernel/events/uprobes.c | 148 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 139 insertions(+), 30 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


