Return-Path: <bpf+bounces-59354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41534AC9296
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 17:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB71D1C081C4
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D91C2356A4;
	Fri, 30 May 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXixmb+A"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB0235041
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748619377; cv=none; b=SI9ITGiHPC8xwjVLwL8BvoSAoOb58WZRB3AryZkhZawfS4na9ytTX9ncpryiQJ5g+VEV25JccCBuEIhCTZP3FCWfQs0l2LxM8BaweyNqMIv0rcWvfkPBrkq9VrOpA2lL3twvEpUOgq9YCCKL0yeKESaGwWrFZcha3dCEL7jFrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748619377; c=relaxed/simple;
	bh=RkelDLdR+ef2jdTN+XrIgdcdRMK26x8s+PgnUAYXPl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7r1007UjsNYvRITqbsnmGKogEcWiQ5bjmhQvVJaI8rCBl4lS7AzJGw3TGhilwPJUf/oh2edQqR3cKndYQdCIPj4qYgKy3szpPacektLlelzsZ6hgJ61XP35rzuCSDC9ctOQe9u7GyvhGO89CDpHVz3PCUEkJivHlr28MqLzgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXixmb+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748619373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TINaLGJe/LUsyTXNKbUWuUbVXt+87LUgitg/LAQmJis=;
	b=aXixmb+AsYp2yHlPo+/ZUVrReUUoVu6mDXvLHnPcmqsoQDWsPiKMOV6/CIuP26r22Br8Q4
	UeqE65krtJ4jzsECnUQBrngfl7XI7xib72vnTrjQBiYciXkET2MEcaoyNx5n45BcaOSG3X
	0oQ2G3S0+AipM/tMg2vpjjldYRfAAh8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-dz05wDx5OiCL3L0TP3d08g-1; Fri,
 30 May 2025 11:36:09 -0400
X-MC-Unique: dz05wDx5OiCL3L0TP3d08g-1
X-Mimecast-MFC-AGG-ID: dz05wDx5OiCL3L0TP3d08g_1748619366
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 366B51955D84;
	Fri, 30 May 2025 15:36:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5433130001B7;
	Fri, 30 May 2025 15:35:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 May 2025 17:35:25 +0200 (CEST)
Date: Fri, 30 May 2025 17:35:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 00/22] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <20250530153516.GA25160@redhat.com>
References: <20250515121121.2332905-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 05/15, Jiri Olsa wrote:
>
> Changes from v1:
> - rebased on top of tip/master + mm/mm-stable + 1 extra change [1]
> - keep the refcrf offset update inside write_insn and enabling it
>   via function argument
> - fixed locking comment for uprobe_write_opcode, but skiped suggested
>   comment on register_for_each_vma, need more thinking on that [Oleg]
> - added acks
> - removed refctr from uprobe_trampoline object [Oleg]
> - change find_nearest_page to use vm_unmapped_area [Oleg]
> - re-structured x86 set_swbp [Andrii]
> - use -EINVAL in __arch_uprobe_optimize [Andrii]
> - added usdt.h from libbpf/usdt project [Andrii]
> - several minor test code changes [Andrii]
> - man page updates [Alejandro]

I forgot to send this email a week ago, sorry...

This version seems to address my concerns. I don't see anything obviously
wrong. So if this optimization is important for users... FWIW,

For 1/22 - 10/22

Acked-by: Oleg Nesterov <oleg@redhat.com>


