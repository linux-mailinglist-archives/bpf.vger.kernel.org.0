Return-Path: <bpf+bounces-58012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3988AB3976
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18871893C7D
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA60265632;
	Mon, 12 May 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctEUfa1H"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1E25A2B7
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057088; cv=none; b=GETvcdUIsOdsnjhVGfKJ+rZ+AWXm5TR5HnRE3obMAbC5o1yuMjeNWgK8nOSvX2JmGHQmjwueKTyYdCyJ9mGDoDwm5tcK9tWqINc0Ii4JGvGJl4Gz6Y4mNS4s6zdOX16k9hCQCaNvyT4bnvsMJz/+2U0bIMefWfoWjVaw1UrslxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057088; c=relaxed/simple;
	bh=BjHjOPeyL4nVfAzamk7y35XVKWRnvl/ucSKe+ZQSA5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBlAzPQqnIjxWXoxdSiQ02kb0C0Z3lT7R9iwy9wCXYzOOJaWtbQ9uwWanoEoI2abAko3o41R6qGkk7sSlnxiPVNlJqLs7srms6MJ1YZ+1EMyiZElK9R7AeQV1VamxitDB23WE8S8CKGILLx7XL8JKMpWdkZJjkF2RozMoH5XhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctEUfa1H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747057086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+d4pcIzBQG+0dzsibKX47VMF4utPM2RH2ZFFbMKIl0=;
	b=ctEUfa1HLGPguLgLcEVNa8n0YG4mLM7hn1r1pv2ar/CLV3MwraOcx6aptVW/Eb2TexiizD
	JwOoNIlAJv8wHoKw+Vfhv3xEfcrLdwNXa9ftY7+kAiDdZc6cs0eZ/mNGL2otb8b4OicirT
	cDzOmBY1N1VkGPuEwAJMFpHG4amnqbs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-bYSc778lMimWzCbSrEbjVQ-1; Mon,
 12 May 2025 09:38:02 -0400
X-MC-Unique: bYSc778lMimWzCbSrEbjVQ-1
X-Mimecast-MFC-AGG-ID: bYSc778lMimWzCbSrEbjVQ_1747057080
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BCA21956094;
	Mon, 12 May 2025 13:37:59 +0000 (UTC)
Received: from fedora (unknown [10.45.226.238])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 290DB180148F;
	Mon, 12 May 2025 13:37:52 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 12 May 2025 15:37:58 +0200 (CEST)
Date: Mon, 12 May 2025 15:37:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out
 of uprobe_write_opcode
Message-ID: <aCH5r9yuyKT1yKMS@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-4-jolsa@kernel.org>
 <20250427141335.GA9350@redhat.com>
 <aA9dzY-2V3dCpMDq@krava>
 <aBoKnP4L-k8CweMy@krava>
 <aBoWEydkftHO_q1N@redhat.com>
 <aB02m4ZdPGJOWatx@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB02m4ZdPGJOWatx@krava>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

I am still traveling, will actually read your email when I get back...

On 05/09, Jiri Olsa wrote:
>
> On Tue, May 06, 2025 at 04:01:45PM +0200, Oleg Nesterov wrote:
> >
> > - uprobe_unregister() is called again and this time it succeeds. In this case
> >   ref_ctr is changed from 0 to -1. IIRC, we even have some warning for this
> >   case.
>
> AFAICS that should not happen, there's check below in __update_ref_ctr:
>
>         if (unlikely(*ptr + d < 0)) {
>                 pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
>                         "curr val: %d, delta: %d\n", vaddr, *ptr, d);
>                 ret = -EINVAL;
>                 goto out;
>         }

OK,

> few things first..
>
>  - how do you make uprobe_unregister fail after succesful uprobe_register?
>    I had to instrument the code to do that for me

I guess _unregister() should not fail "in practice" after
get_user_page + verify_opcode, yet I think we should not rely on this, if possible.

But I won't argue if you think we can ignore this "impossible" failures, just
this should be documented. Same for update_ref_ctr(), iirc it should "never"
fail if ref_offset is correct.

> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -589,8 +589,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>
>  out:
>  	/* Revert back reference counter if instruction update failed. */
> -	if (ret < 0 && is_register && ref_ctr_updated)
> -		update_ref_ctr(uprobe, mm, -1);
> +	if (ret < 0 && ref_ctr_updated)
> +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);

Yes, this is what I meant.

Oleg.


