Return-Path: <bpf+bounces-49673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19ACA1B988
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5114D188F237
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B9915C13F;
	Fri, 24 Jan 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj/zZR5S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C31591EA
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733307; cv=none; b=uE7cepTMQZK32m95/Tjfk4GLtGl7iclm1Q3tz+nrVUBsHQtOcvjRBX3GQS0LqLy3lLinHEvGUyNtds0HyV772QxqEZw2KJrY3Ise4uU9ytAvGtanXBL9hJ0LyBagZ23/w2gJ88c14BaKXxfYMwk6C00b+UZh/3T2PDHwWY489ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733307; c=relaxed/simple;
	bh=YF0T86aTLlDQ/SijaNVjE9mnIknpCEiFR/OWuZi2YoM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty28CaeF9/qbenHMkIjB84aiiHuvAyetVRsg3hiNVRivK22mI1lFeUA2oRbAvVc3x0vjtWE+nS0sVp1FjnoFLfua3VMFeEJRv4y+n3Ac/ZQ+UPbLGG2yX3Qz0F33iKZo7ie9TiJ1M4qIXgwDtSWoKhOT97HVH3Sfw5vStbJ5KdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj/zZR5S; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso459681166b.1
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 07:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737733303; x=1738338103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAjnu1txJezqszqEftrENKZ8On6F9joU3BunYnBm7T8=;
        b=Sj/zZR5SdGaon8BnIfBqBITzlg5vhXTDQAIlsFaVeAwzhqQEb4GUictipJVK6c/4YY
         q9M29s56t+SSGrpHI3p/Zh515n/hmCYO3nZHk2ndphnnHWsRysiNY3ZcZOJ9c9dndnct
         RVmUfixT2geWb5AGZQc7PZsN2s4oXTpbHGW8KO42RQfWRjdFSY168y9kj4lPKgqWeYry
         XqfMk32E1sUsZ6tiKZFLBip5u8iRBQseeyUdejFsIOh4/cFqly4LNbZJqDy296DiI1Cq
         8Q5Unc6QjddwcID/u0+i7p6vO9WfnfE7D7moam8+4dPOzGXdT2t2bJ9CBjyyo31urPpm
         ffeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733303; x=1738338103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAjnu1txJezqszqEftrENKZ8On6F9joU3BunYnBm7T8=;
        b=rIZusVND4YgVU8QB+DgvBcuOVDMGaINvgDAQZFeLlxO/v6d6vPm4Fea2KberSB9//N
         wldC5FccvHzL+YiEcBdLzcb6QVAYeSXecJpcqyIlO0tXHx+Mp2XaATl+q1VjfUQflYQg
         e1VRXHk22JNdB2txGeuGW4DUvZ72m1DeGkEAuGAWwJTNYzw8/m9gq4kHXksmqMEvqvHd
         B56V8NuVkz1B4IpmFoX8iUha9dXBMuj0rIbgEUBtwnJtD0WJPHhszP+js6OJtRrDNmjo
         BWWd12np2IXUrskkSBWxfd0JfQDWKkEIfKnnyb8cAf86jtjCsKikRHzrhPvth6/Hp2Oj
         MJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRlNJp7Ts6z9ADsZrI5lpOPS4uJbM4QI0l+tOoplAG7ddLwe9x9pbYWeXDyBb3SM2Zdno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dRgmSB0gKHtIm52GEIaNItdY2TlMGx0jseqI4uKnxtLs5cOT
	+zAP1Z3vm79mV0qWYhPgfXfJCLRLFSyoagfkQGV6aZtqcutLEYbd5dtrog==
X-Gm-Gg: ASbGncuqv3sPjySKXc6xNctgNttArs01no3pZTAbW+8QvKqiqB1LeVaqj838j944qkL
	oGQ1UPR3clxssgUYmS4ymgXNHm0bu7pYVFN8IoG6ajbSjgDVi+OjJsYxg8PE4pchJxnir2FD0zx
	Gm+8ApzLC846kJr1JKg8QAAsWcbC+F8I5iJOAOhDXMo/oh6prJCVwdtBfD+8vhF4FDgl9gToJmV
	1hANTPUrSyQDETZJtAclO6I8p0A6LHCMNng/YrF8gWYynk2PYgd2z/Usrzqcu2KgJV/6XASLdP8
	PdwzbfXNnvwUJhLnhwV+twok
X-Google-Smtp-Source: AGHT+IGMRE9RPipVz6i/gsRWMGKQVGaTFbmE3U5XQUubs02qPXYM+ScHodZ6ep/E7oE3a9SPk5RKCA==
X-Received: by 2002:a17:907:8693:b0:aab:d7ef:d44 with SMTP id a640c23a62f3a-ab38b165f31mr3260904566b.24.1737733303266;
        Fri, 24 Jan 2025 07:41:43 -0800 (PST)
Received: from krava (37-188-182-96.red.o2.cz. [37.188.182.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e64dbesm147868166b.57.2025.01.24.07.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:41:42 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Jan 2025 16:41:38 +0100
To: Jiri Olsa <olsajiri@gmail.com>, Sven Schnelle <svens@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
Message-ID: <Z5O0shrdgeExZ2kF@krava>
References: <3c841f0a-772a-406c-9888-f8e71826daff@linux.dev>
 <Z5N4N6MUMt8_EwGS@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5N4N6MUMt8_EwGS@krava>

On Fri, Jan 24, 2025 at 12:23:35PM +0100, Jiri Olsa wrote:
> On Thu, Jan 23, 2025 at 02:32:38PM -0800, Martin KaFai Lau wrote:
> > Hi Jiri,
> > 
> > The "missed/kprobe_recursion" fails consistently on s390. It seems to start
> > failing after the recent bpf and bpf-next tree ffwd.
> > 
> > An example:
> > https://github.com/kernel-patches/bpf/actions/runs/12934431612/job/36076956920
> > 
> > Can you help to take a look?
> > 
> > afaict, it only happens on s390 so far, so cc IIya if there is any recent
> > change that may ring the bell.
> 
> hi,
> I need to check more but I wonder it's the:
>   7495e179b478 s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> 
> which seems to add recursion check and bail out before we have
> a chance to trigger it in bpf code

so the test attaches bpf program test1 to bpf_fentry_test1 via kprobe.multi

	SEC("kprobe.multi/bpf_fentry_test1")
	int test1(struct pt_regs *ctx)
	{
		bpf_kfunc_common_test();
		return 0;
	}

and several other programs are attached to bpf_kfunc_common_test function


I can't test this on s390, but looks like following is happening:

kprobe.multi uses fprobe, so the test kernel path goes:

    bpf_fentry_test1
      ftrace_graph_func
        function_graph_enter_regs
	   fprobe_entry
	     kprobe_multi_link_prog_run
	       test1 (bpf program)
	         bpf_kfunc_common_test
		   kprobe_ftrace_handler
		     kprobe_perf_func
		       trace_call_bpf
		         -> bpf_prog_active check fails, missed count is incremented


kprobe_ftrace_handler calls/takes ftrace_test_recursion_trylock (ftrace recursion lock)

but s390 now calls/takes ftrace_test_recursion_trylock already in ftrace_graph_func,
so s390 stops at kprobe_ftrace_handler and does not get to trace_call_bpf to increment
prog->missed counters

adding Sven, Masami, any idea?

if the ftrace_test_recursion_trylock is needed ftrace_graph_func on s390, then
I think we will need to fix our test to skip s390 arch

thanks,
jirka

