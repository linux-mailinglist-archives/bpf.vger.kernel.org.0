Return-Path: <bpf+bounces-67277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F17B41E2E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B795471F8
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376E2874F8;
	Wed,  3 Sep 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMOrIeEw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8228314B;
	Wed,  3 Sep 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900932; cv=none; b=EEArAplpUcA1PTTLmJjrsTNqrOav0q1EUoz0M/G/lKA+/2fHG2voVY6iR6QUBYr86FvQWMybNq6WIWK2c15J+Vp3Mhw55eN4ImeVC0Lk956NzBOoQShgyVZ/QhEoOkVqL2KVz7PDRzxCLJcSAT5IEQu27enxmGcTHBUvFid4Dcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900932; c=relaxed/simple;
	bh=RHN5oEkTfn3JsAe+GpiE4nW5aWlzMvqAKSPR5QlfZ7A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpVrKM+BA1bRUVMfjqE5bFJGlFI+IAdvfK/552Or0I7IfXs9QbtX2d490hIohW7p8OaCdrpqA4HH1qGuT7aCRz2AYmnH6OTxafY+YKboa0r/O8cWMbqc7ryEq9o8BE0ushLijvb2ck3FNJ32ZmXIBTR3psCgkWsqun/dcGg9kFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMOrIeEw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0473327e70so34874066b.3;
        Wed, 03 Sep 2025 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756900929; x=1757505729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1gjB8mQ7w+HuSdS/LNDCGeThnfKSvvTg9EfJrll2aY=;
        b=WMOrIeEwMYaBrEkV/CgL+xAbbB3G7a+G91CEK9ek+pWk0+NM/ThH6iLyHJpuGGbwpi
         V2GTDrRzkTMTr13kPV5MgLorJOdWJnMFbmjgTltXtc3y8NmayEYVNJCrORv9KyiVsnHD
         VBXY928jTrOu4FaAQBcxc1hTvOFfvyAB5q/clETmmebW2FwYk2H37h8xEK/bhCAnB9lK
         +8u4hICMlHs4hAIFY3tRwI7d9K9LWH+Ud1I71LUzI2POExDOHTjmUnRDlDR+i/EZGiMd
         Pmm/mXMfpOVhaMeC1NR3uNnO78xJaKAczGuiRGIbifDp/94RyfgddjQs/mVCrL11F4Va
         xoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900929; x=1757505729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1gjB8mQ7w+HuSdS/LNDCGeThnfKSvvTg9EfJrll2aY=;
        b=ZEFxNTjXAHdhWXqcD+d+4nsF9K2Ac+Qbau2rGtlQJaxDDqZgAAJs9VYaT+JRYgfdvd
         TH2T04BPq9SKDOdJAB4e2HRtAyx6eox3KJR4AjTfWM2yW41jNZ/AYWBIHKT7TvDMbljB
         G1PM2MefBLpdXKlu4iAT9EBqH87FEbYU7qBxvA74HNkXNcs92JizRPcYe8VEGSs04t22
         /p8EYSesxSu67vvrQPzaFMxABO+GBKEydGzqGbEjlQRzaW02ciZgn/5qWx0EBFBcoN+F
         TAKCCzAeksBXoIqjMjpbk1ohm9bcyPYNGHgD5cSOIG3Hwhi0kq0FpQYGU5g/qsxNX8Zd
         6A6A==
X-Forwarded-Encrypted: i=1; AJvYcCVhBN3XHCSasLWzcke9K9fBFCLRwRJ+lk5i1+ScF6atNGSjKcwhRIDxtOlO32yQRQPSCys=@vger.kernel.org, AJvYcCWYwYOfbo0x38h3PjOBaDkIJYqIOxfUYRZjMr8OxwUn7rQEllw6kuWimqxFEY1Cr0pXNNWH+nM58LnUi+O4@vger.kernel.org, AJvYcCXRfeQNoRq3iFEmqedQzw2htucCt/P82GSLidp64v+eM1u14N0Sw6myyF2EgENml3d0dy0HesFDNYvwvS1gt/ckRd/+@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrRs2ESYfc2DGcqcE3JYGPzZPc/FgZfNDQNz8NEAAbD9kRvmo
	okPrvRvCpejUJNifag6Vv6J6An106ZdGDkDb00cYKGeQN+uj679mrW/lVc88g7Vs
X-Gm-Gg: ASbGnctUDUzpkgI/ZYXaTuoxY8t1Lamsg6ytXz4S8k4+HpnVwwxojHi8Dw+nZeDbzfl
	JQXT2owLwNBCOAYoRr+KQiSRM0iOlmA6b4wPEr/mhZ/L5v7K8hzFFKxMrYaCuadP61HQZiaxFBu
	P7LRDvjSKT1Pn8WlwIja2N2F3Zt/cNWiIyeQeeGueNM/YsHB9QHzAn6NCg4E0uQUqiwpe7VcUNf
	jZ/COrwRErmOIy5NWnSsZjwYTiT4u8eEZ6hU5JMvByPZOLD8cjy5qibX4MRot3MLHInYPK9b+Be
	W3iJMK6E/6bLmIgWLYMCMFitz0tkO9eyIMp3A2av1NyVZm/V/LlAE80KvixEVDWIqKGY7I6ok4i
	IzCqeXovcq5bPqwtQED9qmGk9hECKK2ANwq7dW2/YUHR7oP4e3Dk=
X-Google-Smtp-Source: AGHT+IG9DyL34GVO4GIs+oue3ZsqNCivtiVZQCJjLvba3WtVSEqWZD/5goexi5Z22OTJYifTNTVQ4w==
X-Received: by 2002:a17:907:7ea8:b0:b04:53cc:441c with SMTP id a640c23a62f3a-b0453cc4688mr566717466b.28.1756900928868;
        Wed, 03 Sep 2025 05:02:08 -0700 (PDT)
Received: from krava (ip-86-49-253-11.bb.vodafone.cz. [86.49.253.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b017e4b9ed7sm1077649466b.90.2025.09.03.05.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:02:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 14:02:05 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 01/11] uprobes: Add unique flag to uprobe
 consumer
Message-ID: <aLguPcQFauCX5Wfp@krava>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-2-jolsa@kernel.org>
 <20250903104933.GB18799@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903104933.GB18799@redhat.com>

On Wed, Sep 03, 2025 at 12:49:33PM +0200, Oleg Nesterov wrote:
> On 09/02, Jiri Olsa wrote:
> >
> > +static bool consumer_can_add(struct list_head *head, struct uprobe_consumer *uc)
> > +{
> > +	/* Uprobe has no consumer, we can add any. */
> > +	if (list_empty(head))
> > +		return true;
> > +	/* Uprobe has consumer/s, we can't add unique one. */
> > +	if (uc->is_unique)
> > +		return false;
> > +	/*
> > +	 * Uprobe has consumer/s, we can add nother consumer only if the
> > +	 * current consumer is not unique.
> > +	 **/
> > +	return !list_first_entry(head, struct uprobe_consumer, cons_node)->is_unique;
> > +}
> 
> Since you are going to send V2 anyway... purely cosmetic and subjective nit,
> but somehow I can't resist,
> 
> 	bool consumer_can_add(struct list_head *head, struct uprobe_consumer *new)
> 	{
> 		struct uprobe_consumer *old = list_first_entry_or_null(...);
> 
> 		return !old || (!old->exclusive && !new->exclusive);
> 	}
> 
> looks a bit more readable to me. Please ignore if you like your version more.

yep, looks better, thanks

jirka

