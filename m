Return-Path: <bpf+bounces-78966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D2D2144D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 22:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C126C30700CB
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04343358D09;
	Wed, 14 Jan 2026 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fogJao0+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D1356A38
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424781; cv=none; b=EkBUS60vOrZI0g9RHUnLFGvl+vTnt+d413uxOsn8j9NbdwGKySJuh1r2uRfrwQozGzFFDuqqPCf3VItgeOJ56eAqalQenYJ1FxUbYTHhGKDqMQWZ8bTjYJv5dpG8giKj7fxKm8EWc3bPNYX5BeNWmmDbevqJ68kxOAs4zyfaDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424781; c=relaxed/simple;
	bh=mun8+NHwdhbsJ4vaOUWC8JQAkyOVT1xXGpUSUxcU7ts=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeIw2Gaf6yvJPjjBQqnocakIC+a84hYJ9yJ6j/NgqNnd2nY3WWlmMEk0pWR0V8JLUG+LmMiHNpkf8OoGdsDfktRktVcdcnDMuVY9hlzmn7ZdVTx6hB9zuZ2juT57LaacWIBona7KWX+KunuvTiFLkyEA8xHqdgRj3F8b8a+2g9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fogJao0+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso2212515e9.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768424778; x=1769029578; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d8QWXU2aIMD2J80JcqYSmh7DpjHDbURMvR21XnlyKTA=;
        b=fogJao0+RYMNotALOZkr2L+H3Nz4qTezYtwJ00dD2vf8tAkNn72xlzHCp6eHB2seDp
         SY5Uhwj3JlZy5L44dBL+PedVmmxaH5FuAA/08Twzo6vuHZv1vQX+0wObBYf/enM82b2O
         6XsdiAaumgFXviT2Mt/VEI+xtfovlnp8/2/n8fBdrkj/cgAxOsq8XH0zqQlYUCR+UlaI
         fLRxm7ScLZQNVZyWDzXJrUdOGounPZg9C2bQ49YKLXWSlVQvmqKcYzn3ZrZGG9xlQxf7
         ds4UtmnT0uCSBy2iu6qYccyJlWe65Z3d+AkxDZnCtG1ReoU/ch+Wo9afuh7XKCMp16dF
         0wrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768424778; x=1769029578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8QWXU2aIMD2J80JcqYSmh7DpjHDbURMvR21XnlyKTA=;
        b=cFmRWyEQUhzXgmlTmWrDSpBvjVVNuD0BMnlxGenP5iiJ/lISpqPp7CcJPza522pL/Y
         3Ur06Lisc4jc9QRs1Qt0ezq3EG9OvG1Ofb9UAzTUKnURsJuaHq/FSmJLhJcieqDflmjb
         XGvD69ast85SLsX4S6dyIQf2zxcxzs/4zTURjbTpgjqd4tkIculClqVrCAdUXSj4s8BF
         oD2EJtSp8AProxZ9Yl92ZlaZwA47yT/joE3FyaDckbPAhpqjQguRSzSdxZkmYAvlZCyL
         pV3W1CFutDVDGJC94upfE5/lKd1tbfJVr13ho050/7NoYlbQGf+r3KjTdkEdbjaHKooX
         fYCA==
X-Forwarded-Encrypted: i=1; AJvYcCWHVw2Q+8Cv6q6GQcy0D/f2mE0K0lb6nDJFNMMxumGM4J0iB1F6BhhPZL5zRBhOA4bEMfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ab091EsGTDgmlBOEfElSwdzeot9ORgIXIquj3djBp6Pwq9fS
	tGc3q6e++pTg9gYdxkvuKWOpt4OE9Za0twzh7eEDskVqWSLtAFz5mgFXaAkRdhM4
X-Gm-Gg: AY/fxX6GHTqHWOQItA6NvgRjJn7ZEAqjy//nx1YucDKEDyo6dtf/h8f4QdJ02OHfWy5
	44px6baaLgKQD0dmIRKKPtIfeZPIJVv2S2fpAo8Bq4obsT+nzTIHIJtz5KQg3Udn9RrKeyWxFw2
	ioZ0TD/rIY8f/uLgwBmnQW8CUriR7WHgDpRSAMqlGzzT2GmDls4G6qNnzMkFpt/8MzeOdGbKobX
	vQ9nsRoECv6325iLLL1xCXwGzaFvcyPhbJhl30QBQGGZ26sBqJmt1Y4aze2T0PKXW7gkvPKWY7v
	GgodGpZQeaioncLh+YjvrzI35Cj8/tvN/WfMgD5hN0gXGN+sorE/+69/114KMRy3a+YFc/Wvotx
	mzI26sQKB/aZ/z8FMYExD/Imrf1YzBqSDz3vv1aVGfm95U8ZjyFR56k8RSSdtu8QLrfClbDKoFd
	22GJEWfqaZKA==
X-Received: by 2002:a05:600c:8b12:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-47ee47d0067mr41297675e9.15.1768424778237;
        Wed, 14 Jan 2026 13:06:18 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f3b7a5b06sm10295855e9.0.2026.01.14.13.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:06:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Jan 2026 22:06:16 +0100
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Tao Chen <chen.dylane@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: The same symbol is printed twice when use tracepoint to get stack
Message-ID: <aWgFSJIpsP2M6mYA@krava>
References: <e876fdea-ad0c-49dd-80ec-bd835ebfe0a4@linux.dev>
 <31e5d219-07f4-46c0-bef1-53af20d473f1@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31e5d219-07f4-46c0-bef1-53af20d473f1@oracle.com>

On Wed, Jan 14, 2026 at 05:35:45PM +0000, Alan Maguire wrote:
> On 14/01/2026 15:09, Tao Chen wrote:
> > Hi guys,
> > 
> > When using tracepoints to retrieve stack information, I observed that perf_trace_sched_migrate_task was printed twice. And the issue also occurs with tools using libbpf.
> >
> 
> You may need the fix Jiri provided for x86_64 [1]. Eugene mentioned that
> the issue persists for arm64 however [2].

yep, there's also follow patchset up for kprobe multi [1]

jirka


[1] https://lore.kernel.org/bpf/20260112214940.1222115-1-jolsa@kernel.org/

> 
> Alan
> 
> [1] https://lore.kernel.org/bpf/20251104215405.168643-2-jolsa@kernel.org/
> [2] https://lore.kernel.org/all/a38fed68-67bc-98ce-8e12-743342121ae3@oracle.com/
>  
> > sudo bpftrace -e '
> > tracepoint:sched:sched_migrate_task {
> > printf("Task %s migrated by:\n", args->comm);
> > print(kstack);
> > }'
> > 
> > Task kcompactd0 migrated by:
> > 
> >         perf_trace_sched_migrate_task+9
> >         perf_trace_sched_migrate_task+9
> >         set_task_cpu+353
> >         detach_task+77
> >         detach_tasks+281
> >         sched_balance_rq+452
> >         sched_balance_newidle+504
> >         pick_next_task_fair+84
> >         __pick_next_task+66
> >         pick_next_task+43
> >         __schedule+332
> >         schedule+41
> >         schedule_hrtimeout_range+239
> >         do_poll.constprop.0+668
> >         do_sys_poll+499
> >         __x64_sys_ppoll+220
> >         x64_sys_call+5722
> >         do_syscall_64+126
> >         entry_SYSCALL_64_after_hwframe+118
> > 
> > Task jbd2/sda2-8 migrated by:
> > 
> >         perf_trace_sched_migrate_task+9
> >         perf_trace_sched_migrate_task+9
> >         set_task_cpu+353
> >         try_to_wake_up+365
> >         default_wake_function+26
> >         autoremove_wake_function+18
> >         __wake_up_common+118
> >         __wake_up+55
> >         __jbd2_log_start_commit+195
> > 
> > env:
> > bpftrace v0.21.2
> > ubuntu24.04，6.14.0-36-generic
> > 
> > The issue is as follows:
> > https://github.com/bpftrace/bpftrace/issues/4949
> > 
> > 
> > It seems that there is no special handling in the kernel.
> > Does anyone has thoughts on this issue. Thanks.
> > 
> > BPF_CALL_4(bpf_get_stack_raw_tp, struct bpf_raw_tracepoint_args *, args,
> >            void *, buf, u32, size, u64, flags)
> > {
> >         struct pt_regs *regs = get_bpf_raw_tp_regs();
> >         int ret;
> > 
> >         if (IS_ERR(regs))
> >                 return PTR_ERR(regs);
> > 
> >         perf_fetch_caller_regs(regs);
> >         ret = bpf_get_stack((unsigned long) regs, (unsigned long) buf,
> >                             (unsigned long) size, flags, 0);
> >         put_bpf_raw_tp_regs();
> >         return ret;
> > }
> > 
> 

