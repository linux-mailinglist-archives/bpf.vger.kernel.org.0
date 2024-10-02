Return-Path: <bpf+bounces-40774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC398E0ED
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B350A1C22FFD
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4211D0BAE;
	Wed,  2 Oct 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqbnpDn+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE621D049A;
	Wed,  2 Oct 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886639; cv=none; b=rCv0TXqs14sGoHMPNI+0hoMBlqn38MvDt2+USwNLaHaStti+h7x/wlYrNfHVwlNapmUhmnLxxAU6r8ree2bj4kvOXAIitImrmS4f46yHVvsrAw0gffB7rdyfV0dzGss+iGLGjFGoYRj+X8QaC79jjYWi7vNP9LJQLRGx/ypwuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886639; c=relaxed/simple;
	bh=eWAy5noGgSd4kqNCsOuVn9U38TKfAbgPkZ+8/we5oJ4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuW/A8MY0MSc+QZ/OXZ+aMKN/qM6G+dgoCWWha0bcmkyXdrjVvIJC0ZPv06nZcauFC1yHwKU+JPgEuP9Jda2zbUwjAbHKoZ+qM7qwaFVq08FR3MGj4zwClhtnWQ8Zg44hMBN0hELIHuwRfEoXAP4ENNJKN77YrmMo54+P7l308Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqbnpDn+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso76940995e9.1;
        Wed, 02 Oct 2024 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727886636; x=1728491436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6myugfbCrbDny+mEmCAN2TIpAKufb9K7Ngm8wrf3Dw=;
        b=YqbnpDn+B0KOi6C/HGjsOG0zd8C5kxrxD5ihOvB7MJgK0ck4DhOxW+e+NZnr8YbGxr
         lN+962ZBESWEXThBRWAV9vdlkACl9uEsnDdDtjUasM4M581FUMyMnFGUB9531Wiqy9Pb
         26hBoX4mF8No9Jx1YGpf+pHtUAPwpai7tTcVVKShbxLl9t3XJHwgDaRcS9SiwRl+8lvu
         A/hiAIA9X7xgfvi0SvSxvQZRltMmF7P/jeRwlF1ffHuCly2FA7xwZj0sQ4MzAdcMo4nJ
         smRPqQ9RF6RvLcozurHqDQIsQE3crBxdfCNL5emTmBVITyT+FrpvP5egYLwLOIBWTr6f
         G1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727886636; x=1728491436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6myugfbCrbDny+mEmCAN2TIpAKufb9K7Ngm8wrf3Dw=;
        b=kuzYzmiHBqHAwiO+Dj+ZhC2UDPhXu+Hi4DLLCErRTKWrMnL90MG3wIrKDHzhsmeMm7
         BSPX0hKgTLpjAUdBtXhRlMPWxV2ijJm1v3entafNrOQhkdD6azf6ZRpwzQGu3GToYlcD
         zm4RCxwzsNyXCvqMt9MftSBOV/l2JMbvuTpROjQAILHlvXV79JMCJ6hYBSXCG909dI53
         f4zyNo5Zsjj0VWcHsuBRC+ynmjnBFZOBod+p6+oM+9cqMWXlsnO8dXfMBtI+j+yWkyyl
         fRsPblZd5kh4HIbhI4xwXXznlHCoYdIG3vx32+BoOg3A/zK2/dN6/zBuBFKtVIZyBLo3
         +a/A==
X-Forwarded-Encrypted: i=1; AJvYcCVK5AC+EDOBpbT/bnrMq0zyMCORpa3g48XSNet1BINAgpUhxfzYm09dHK3VKN2HQIfi9B4=@vger.kernel.org, AJvYcCXZ+4VrVdCo3ZnAN0InzDwMswCFvbyXdy9P+kWdANsGRWU/yFkvypkHs3beXaxXlqPo5KCOGz70qjqjOkPM@vger.kernel.org
X-Gm-Message-State: AOJu0YySt+m5z03QVv8MV/5/tQe9U8KJi+cFmgvT/cntLlOfM3VXF4Cm
	3vGLCZRZP6ygh1QFXaEa4ageRuUFuUSd8xqeJLraqflpEZWshPp0
X-Google-Smtp-Source: AGHT+IGIEr6XIfLvyxkEDAKzd09LAqFb3H9Vlqb9y8IyQuQzFrYEZ7955Au0NwSMmxSb0S0k3dzCwQ==
X-Received: by 2002:a5d:498d:0:b0:378:8b84:4de9 with SMTP id ffacd0b85a97d-37cfb8b566bmr3296670f8f.12.1727886635620;
        Wed, 02 Oct 2024 09:30:35 -0700 (PDT)
Received: from krava ([2a00:102a:401f:9164:64b2:964a:dc:50f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e881sm14235716f8f.44.2024.10.02.09.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:30:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Oct 2024 18:30:30 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <Zv11JnaQIlV8BCnB@krava>
References: <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
 <Zr3q8ihbe8cUdpfp@krava>
 <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
 <20240816101031.6dd1361b@rorschach.local.home>
 <Zr-ho0ncAk__sZiX@krava>
 <20240816153040.14d36c77@rorschach.local.home>
 <ZsMwyO1Tv6BsOyc-@krava>
 <20240819113747.31d1ae79@gandalf.local.home>
 <ZsRtOzhicxAhkmoN@krava>
 <20240820110507.2ba3d541@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820110507.2ba3d541@gandalf.local.home>

On Tue, Aug 20, 2024 at 11:05:07AM -0400, Steven Rostedt wrote:
> On Tue, 20 Aug 2024 12:17:31 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > > Could it be possible that the verifier could add to the exception table for
> > > all accesses to tracepoint arguments? Then if there's a NULL pointer
> > > dereference, the kernel will not crash but the exception can be sent to the
> > > user space process instead? That is, it sends SIGSEV to the task accessing
> > > NULL when it shouldn't.  
> > 
> > hm, but that would mean random process that would happened to trigger
> > the tracepoint would segfault, right? I don't think we can do that
> 
> Better than a kernel crash, isn't it?  I thought the guarantee of BPF was
> not to ever crash the kernel. Crashing user space may be bad, but not
> always fatal, and something that can be fixed by fixng the BPF program that
> was loaded.
> 
> > 
> > it seems better to teach verifier which tracepoint arguments can be NULL
> > and deny load of the bpf program that would not check such argument properly
> 
> These are not mutually exclusive. I think you want both. Adding annotation
> is going to be a whack-a-mole game as new tracepoints will always be
> created with new possibly NULL parameters and even old tracepoints can add
> that too. There's nothing to stop that.
> 
> The exception table logic will prevent any missed checks from causing a
> kernel crash, and your annotations will keep user space from crashing.
> 
> -- Steve

sorry for delay.. reviving this after plumbers and other stuff that got in a way

Steven,
we were discussing this in plumbers and you had an idea on doing this
automatically through objtool.. IIRC you meant tracking instructions
that carry argument pointers for NULL checks

AFAICS we'd need to do roughly:
  - for each tracepoint we'd need to interpret one of the functions
    where TP_fast_assign macro gets unwinded:
      perf_trace_##call
      trace_custom_event_raw_event_##call
      trace_event_raw_event_##call
  - we can't tell at this point which argument is kernel object,
    so we'd need to check all arguments (assuming we can get their count)
  - store argument info (if it has null check) into some elf tables and
    use those later in bpf verifier
  - it's all arch specific 

on first look it seems hard and fragile (given it's arch specific)
but I might be easily wrong with above.. do you have an idea on how
this could work?

thanks,
jirka

