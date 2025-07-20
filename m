Return-Path: <bpf+bounces-63855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38AB0B59D
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4873BC530
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078D91F0995;
	Sun, 20 Jul 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNDhpEiT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BD21DDC07
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753011584; cv=none; b=MKWrpkfxOIe2I3i3bbAwLlZ1zlhwaUMt27p1qSm0PpfC9kN7mT/QYYn/6HksVvfXwQQpKxaUhcvn7HSDmDhb8K777V+hS7FKos2AaNj4YWaQW8WfFGidbMHuWgWIshwp7Wn4CAuJlm7KHXhTME/OtlYsTjDRRlGq3XQiqauZPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753011584; c=relaxed/simple;
	bh=Iu6H7igpd/ZsMaAM411NjFixrXtxN56J3mN+7gbg90c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbv9fG+cpBycHiI+pLv4L79dI/eScQQmH7AlOD2pybz6h5nlAXYofrn4j1pcvLYHjJ/yNGfCZOrVD77tkRSB9azRLKg9tLhx3/c6c1upw+EV6krKcvyCH1/+rDF9eVzVVos+aReMPKR+CvK2y3ZdbrPObAChHRflZt5sQTaCa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNDhpEiT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753011582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu6H7igpd/ZsMaAM411NjFixrXtxN56J3mN+7gbg90c=;
	b=cNDhpEiTma0B66UQysvaDHQw0ir279vtEHao5YQopd2fnvcrD0xBDWy+G7BeM+qwGo89g0
	/ytyaemWPPGwwf9augpu3KMA3XiR1nBiKi3VuLatZADF9EoQRmVdbfqgE/Rs5/iHbmoUkG
	vPxK05Hks2uC21QOytPew2RSCwVr+jU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-MRzKWyJ3MKuUez4dgd4jOg-1; Sun,
 20 Jul 2025 07:39:29 -0400
X-MC-Unique: MRzKWyJ3MKuUez4dgd4jOg-1
X-Mimecast-MFC-AGG-ID: MRzKWyJ3MKuUez4dgd4jOg_1753011558
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 458A11800447;
	Sun, 20 Jul 2025 11:39:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5711E1800D82;
	Sun, 20 Jul 2025 11:39:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 20 Jul 2025 13:38:24 +0200 (CEST)
Date: Sun, 20 Jul 2025 13:38:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <20250720113816.GA23012@redhat.com>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720112133.244369-10-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/20, Jiri Olsa wrote:
>
> Adding new uprobe syscall that calls uprobe handlers for given
> 'breakpoint' address.
>
> The idea is that the 'breakpoint' address calls the user space
> trampoline which executes the uprobe syscall.
>
> The syscall handler reads the return address of the initial call
> to retrieve the original 'breakpoint' address. With this address
> we find the related uprobe object and call its consumers.
>
> Adding the arch_uprobe_trampoline_mapping function that provides
> uprobe trampoline mapping. This mapping is backed with one global
> page initialized at __init time and shared by the all the mapping
> instances.
>
> We do not allow to execute uprobe syscall if the caller is not
> from uprobe trampoline mapping.
>
> The uprobe syscall ensures the consumer (bpf program) sees registers
> values in the state before the trampoline was called.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

My ack still stands,

Acked-by: Oleg Nesterov <oleg@redhat.com>


