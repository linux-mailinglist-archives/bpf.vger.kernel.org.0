Return-Path: <bpf+bounces-34169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0292AC91
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCECB1F2277E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36283152DEB;
	Mon,  8 Jul 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9qZmD4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259698C06;
	Mon,  8 Jul 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482048; cv=none; b=hZCCDE3mhXHwqYVY6eavTP1ByM3qLI28kqRuW7BVyREECsR44olHG0gadPGS/5XQgIQGiU7zXnx1ybpXw5do3mBG0z5esAjTaCiAHq20dXLlhmIHiTrGktI86+nYgu1pZd4Hq6NKM9GcRjJOel4Go9C57RCg4nAVtJWrAND3sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482048; c=relaxed/simple;
	bh=WDzDyGwxTgPZl9cq95FJdwhpZkmi7Sw4SDaI8id1C6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzfEn7484OZ4HZ3DIF4PLcF9bvgoFa6CwYImQUnYEpXmmthIuQF4E2ekLODVGZwTLZT5age2vPgGNNj/7sVId71O4Hl3mbREK1NwI7x+lalm9pcVDcP66jZxEvYaI05Ak7ovFoQjou5xMBWINoWgrV+WhM6hKg24CMtdOnr8a/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9qZmD4B; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d9306100b5so1037882b6e.1;
        Mon, 08 Jul 2024 16:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720482046; x=1721086846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vW/81UX4t/tUsTA9sWlBeD8YuK3csS1v63vL09aNdGE=;
        b=L9qZmD4BwAJV+lGmDxzXnoM/7X5il0R//dFEiYuPxIZOvtwcj5P3PB3o7DEA+XtlFl
         YbUJCwQFv2eXTnqPD7uXU3gI8SVXeupn/wUxhCcXP8ThFQ+XrGtcj8lg60ikRRjzk/6m
         K/vS9H5aVimNpHBtGHa/xXmVapW5Fa8GMKcLBe2jY0Mfr50cglKqzC6kEuj7YsTlBQWn
         6omPOknGQ1CBvebmMCYXjT0bBuS3WrS6gY7PtQ7njegvBI/eydPz6+HSXtt2GoIj74w3
         sS34ngooihXQ6Cfil70BopO85YOGvziCNJmK3p9jJaLcDJkFeW+28EZ2WTptRpk1m0GG
         TI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720482046; x=1721086846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW/81UX4t/tUsTA9sWlBeD8YuK3csS1v63vL09aNdGE=;
        b=ZqYxqlS73mcDDBtITOFnQEDRpfTQvNyIvyBn/zYFqs5d2Ohu2g3mB1LyXLhBo5Plai
         CdZaKTvov7Gnm5mfLlZJnXXUIsY/AKJyihwjvNRv1OQVVllWfFD5zsJ6HYw+VyFkqfMR
         Hf9uWhrDYuICbtydBHyGkDAsbGmLup4zDJAhXxYmEiuMQBDTl9oUkn5+KJ7NEcrg2LTh
         tRnt19YzzZtvHsnuejN1g4G71VK+XpHn9ptfRZJdPYq3+fBaOC5PUygRyXVrX40mNEKC
         hx8Y5RHfAPqoCWW4Jpa49d/8vdJ0De9BFgApp7fVmB7XIoObWojBzUECWV3hVxwRkf1N
         2J+g==
X-Forwarded-Encrypted: i=1; AJvYcCW+SA5GR6iDCwTHa9cVm9YUvwmcFud6BMbZtFBZOqTxFvfWUr6/LjJkbTGzNq4aknRGTaaemHOmryuWiOAxYRfKw9sgYCuhA3rhGSomX1n5Yf6V+Z+UZLnDA47FKFXSKzs0
X-Gm-Message-State: AOJu0Yz+yneUjgjEWC69qxlvwOntK61XHEj9uBRISo5/ELtG+QmT85N9
	E4BXpie+GL8/cV4oofwoVJXTKQlIepABY8yCupZPW5v0YwegVQEFZoKqQg==
X-Google-Smtp-Source: AGHT+IEQT8XcljQEe+LmA6l3MYAxEJZwnq2V9/5qhF44hpyDm8VSOXMM+PeURCTYW78/hvv7KhFeiA==
X-Received: by 2002:a05:6808:2128:b0:3d9:2043:e170 with SMTP id 5614622812f47-3d93c0b333bmr943658b6e.57.1720482046075;
        Mon, 08 Jul 2024 16:40:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389ba28sm448599b3a.9.2024.07.08.16.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:40:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 13:40:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH v4 sched_ext/for-6.11 2/2] sched_ext: Implement DSQ
 iterator
Message-ID: <Zox4_MHR9HiwmtHt@slm.duckdns.org>
References: <Zn9oEjsm_1aWb35J@slm.duckdns.org>
 <Zoh4kp7-jAFZXhe6@slm.duckdns.org>
 <CAADnVQJ6o-ikfnHiatbNwS8+MKi44kcBfVtnDQkYLdDUZ80Rtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ6o-ikfnHiatbNwS8+MKi44kcBfVtnDQkYLdDUZ80Rtg@mail.gmail.com>

Hello, Alexei.

On Mon, Jul 08, 2024 at 03:41:48PM -0700, Alexei Starovoitov wrote:
> In the future pls resubmit the whole series as v4
> (all patches not just one).
> It was difficult for me to find the patch 1/2 without any vN tag
> that corresponds to this v4 patch.
> lore helped at the end.

Sorry about that. That's me being lazy. It looks like even `b4 am` can't
figure out this threading.

> > @@ -1415,7 +1487,7 @@ static void dispatch_enqueue(struct scx_
> >                  * tested easily when adding the first task.
> >                  */
> >                 if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
> > -                            !list_empty(&dsq->list)))
> > +                            nldsq_next_task(dsq, NULL, false)))
> 
> There is also consume_dispatch_q() that is doing
> list_empty(&dsq->list) check.
> Does it need to be updated as well?

The one in consume_dispatch_q() is an opportunistic unlocked test as by the
time consume_dispatch_q() is called list head update should be visible
without locking. The test should fail if there's anythingn on the list and
then the code locks the dsq and does proper nldsq_for_each_task(). So, yeah,
that should be a naked list_empty() test. I'll add a comment explaining
what's going on there.

...
> > @@ -6118,6 +6298,9 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
> >  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
> >  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
> >  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> > +BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
> > +BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
> >  BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
> >  BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
> >  BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
> > --- a/tools/sched_ext/include/scx/common.bpf.h
> > +++ b/tools/sched_ext/include/scx/common.bpf.h
> > @@ -39,6 +39,9 @@ u32 scx_bpf_reenqueue_local(void) __ksym
> >  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> >  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
> >  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> > +int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
> > +struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
> > +void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
> >  void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
> >  void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
> >  void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
> > --- a/tools/sched_ext/scx_qmap.bpf.c
> > +++ b/tools/sched_ext/scx_qmap.bpf.c
> 
> We typically split kernel changes vs bpf prog and selftests changes
> into separate patches.

Let me think about that. I kinda like putting them into the same patch as
long as they're small as it makes the patch more self-contained but yeah
separating out does have its benefits (e.g. for backporting).

> > +"  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
> 
> tbh the demo of the iterator is so-so. Could have done something more
> interesting :)

Yeah, it's difficult to do something actually interesting with scx_qmap.
Once the scx_bpf_consume_task() part lands, the example can become more
interesting. scx_lavd is already using the iterator. Its usage is a lot more
interesting and actually useful (note that the syntax is a bit different
right now, will be synced soon):

  https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_lavd/src/bpf/main.bpf.c#L2041

Thanks.

-- 
tejun

