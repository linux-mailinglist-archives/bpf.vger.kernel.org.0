Return-Path: <bpf+bounces-52251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3848DA40867
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 13:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E84D189AB46
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC44420B7F8;
	Sat, 22 Feb 2025 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWiVInF0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906020AF69
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228043; cv=none; b=WNz0ZPxm1lH7s5t6qgyeC07qHdFayZe2oj+qPZtaoxFDDRJwM2qE+h9orRIxIGK0+23iqbtUJtLzZ0ukxLmkIRlrycRNEj7xZL36/TfIz+ASeSiBim26TVl/+2KxiH21K1W5sSAbdqNhRobQLMQWfJpvwu2axq5N1vWd+nJvEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228043; c=relaxed/simple;
	bh=44WiBU3e87uUbt5Joj83rDplJVriJ4yNvs0txze1vTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpjC+Wn9f9pkImd5z5ByC/gbDEoEDZtwT0/sLL6353hjEZU/6UMdEmjP7aOp52ickYxJmqr1R3kjXp4XEui/uZUhDTYn8ZH+O7IIGB6EMEzjiMOm57rkcw/lo8QLcP4QdaGneIom5XWy1/XjXpQ2iIqMNu6Tb+fOv0NPn715tI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWiVInF0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740228039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAd8SANoOauq5uEymG+29fWeYf7y+gGWAJmdDdaiSKs=;
	b=TWiVInF0NcltMZ4JLPeMSZ7FuqCb3ojP3yPDx3eDe1T4Z4z5XpTKzGYL1WMSSGkftQF0S7
	lZjwfIOOnrz+pz4xN+UrpAL8Tvvo6SCIsokX8c8iHhPi4bjCBlzno76ufwV/yM2TIJGZlD
	nHfWy6bph9pSeqcs/XiY+PnA5Mpes3o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-u0F871nGP4-7jWvcSvDHtQ-1; Sat,
 22 Feb 2025 07:40:35 -0500
X-MC-Unique: u0F871nGP4-7jWvcSvDHtQ-1
X-Mimecast-MFC-AGG-ID: u0F871nGP4-7jWvcSvDHtQ_1740228033
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6224619560B9;
	Sat, 22 Feb 2025 12:40:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8A6E8180094A;
	Sat, 22 Feb 2025 12:40:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 22 Feb 2025 13:40:03 +0100 (CET)
Date: Sat, 22 Feb 2025 13:39:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Peter Xu <peterx@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v2] uprobes: fix two zero old_folio bugs in
 __replace_page()
Message-ID: <20250222123952.GA17836@redhat.com>
References: <20250221015056.1269344-1-tongtiangen@huawei.com>
 <20250221152841.GA24705@redhat.com>
 <46a48eb4-5245-81ba-9779-ace8f162c31b@huawei.com>
 <ef999493-cac0-68bb-2684-97da0fb8b583@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef999493-cac0-68bb-2684-97da0fb8b583@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/22, Tong Tiangen wrote:
>
>
> I'm going to add a new patch to moving the "verify_opcode()" check down
> , IIUC that "!PageAnon(old_page)" below also needs to be moved together,

No, no.

I forgot everything, but please don't do this. IIUC This is optimization
for the case when the probed file has int3 at this offset. We should not
skip update_ref_ctr() in this case, just we can avoid __replace_page().

> and as David said this can be triggered by user space, so delete the use
>  of "WARN", as follows:

Hmm... I think that David meant the new WARN_ON() added by you in V1?

Please don't remove the old WARN(PageCompound(old_page) check. If userspace
can trigger this warning we need to to fix this code and add FOLL_SPLIT_PMD
unconditionally (and likely do something else).

I take my words back ;) Don't do the additional cleanups, just add the
is_zero_page(old_page) check right after get_user_page_vma_remote() and
update the subject/changelog as David suggests.

This function needs more cleanups anyway. Say, the usage of orig_page_huge
_looks_ obviously wrong even if (afaics) nothing bad can happen. It should
be reinitialized after "goto retry" or it should be checked before the
"orig_page = find_get_page()" code. The usage of gup_flags looks confusing
too. Lets do this later.

Oleg.

>
>
> @@ -502,20 +502,16 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe,
> struct mm_struct *mm,
>         if (IS_ERR(old_page))
>                 return PTR_ERR(old_page);
>
> -       ret = verify_opcode(old_page, vaddr, &opcode);
> -       if (ret <= 0)
> +       ret = -EINVAL;
> +       if (is_zero_page(old_page))
>                 goto put_old;
>
> -       if (is_zero_page(old_page)) {
> -               ret = -EINVAL;
> +       if (!is_register && (PageCompound(old_page) || !PageAnon(old_page)))
>                 goto put_old;
> -       }
>
> -       if (WARN(!is_register && PageCompound(old_page),
> -                "uprobe unregister should never work on compound page\n"))
> {
> -               ret = -EINVAL;
> +       ret = verify_opcode(old_page, vaddr, &opcode);
> +       if (ret <= 0)
>                 goto put_old;
> -       }
>
>         /* We are going to replace instruction, update ref_ctr. */
>         if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
> @@ -526,10 +522,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe,
> struct mm_struct *mm,
>                 ref_ctr_updated = 1;
>         }
>
> -       ret = 0;
> -       if (!is_register && !PageAnon(old_page))
> -               goto put_old;
> -
>         ret = anon_vma_prepare(vma);
>
> Thanks.
> >
> >>
> >>
> >>.
> >
> >.
>


