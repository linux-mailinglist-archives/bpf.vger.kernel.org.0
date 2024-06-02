Return-Path: <bpf+bounces-31162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D028D782E
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB7428149A
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C6C77F32;
	Sun,  2 Jun 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoEUrgeS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15A2F50A;
	Sun,  2 Jun 2024 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717361568; cv=none; b=bfqC8QwrBJGj6wjAcbHXR1GSNkws4OZLcwtZOypToECP2ZBr0l2aeD60bF56WseUZlbTruWhD21f5/Iz7Lckh9T2UW+DeFnj8yUmkcGG9BQ6Ild8Zy3WnVgF+E5SPH2L5pZX4GlvWHZvCuFbqzEODnOFCKja6gbK288Ik0LH1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717361568; c=relaxed/simple;
	bh=bgxweLWteITqcPz1qV1ksGMaNutWhvRQeS8W/dMIDeM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbN4f0BsI3WaLtUSa0bidzat0cBvKhKxglbQrSsVHGaY4n6bHBSJgLTo6HpP9DG8YlrQwkuXWn8dhce3wnDbj0Pe5r9Q6M8vf31a/wHBfbKFehk+uNojE3O3H2pRqX98htJgD0D2bCiVRBvwlEHndjmDPl0aMzxn6NMzv7ueEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoEUrgeS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421392b8156so5562685e9.3;
        Sun, 02 Jun 2024 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717361565; x=1717966365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CppJObiXH7D+u0ahB6gLF2RpVELWDr2oksVB71bHssE=;
        b=BoEUrgeS9dlAOZ6utai7d90EWKyAe8LJAF/NZzQJPHC4TzJ7y4SExC53wxOh9ltYjL
         R4LoCRSa2c6mX1Ff4DN1DNNwUxNrGzM0wxnILaHADfDBaigHqhEK/ncQwLl8oBiWJXsK
         OB5fhXbwqp4keEG2eAZHt3RcVbGr+O9Q3CoVofgQ2yU12M4YfBBGn+2dcdQtW1U4CyDj
         a8yfFSgFj68xSJ/yqGfDpP/+Jsq3bEStyZytE5QJ2axn/LowH8E3bUVCbzbf8lzsNa9A
         DiEJtUs6+tHH63RC8ZVEdvaJETBftsv+ILzwG8bc3p1yqYspCPMzHGZX6j0vrDX9GQhW
         fQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717361565; x=1717966365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CppJObiXH7D+u0ahB6gLF2RpVELWDr2oksVB71bHssE=;
        b=O0m470wZzlvNW70VVsQMoFwuoUvBVnns9DAb8I7FW7miww1KUoDXGI0C5+DWAfWJT7
         nLvIKUL5eCZOsm2qGeZC4seo/SAVkJZR5A2PGcYsK5Ze/HlDRW9dsFGUrZy2MsgD00KN
         TH7viVNNE1oa1C46VIRVDQqRatVSPLz318WsgtR9qg2DIE1FnHIUo+jixSlEKACFLcIM
         cJqjctxGi1oDN/ItGRRIBrn4/FjX9FyfHAk1Qo4Ko0gDD+mBJX48TMNmDTNPLJmtkpdp
         zrZLki4UDWYPFG8S6Y+Ynb1umG+gHob8f9PuR67LsSJCq/wjdWumquSbfV2sSXRmVRwP
         AGzA==
X-Forwarded-Encrypted: i=1; AJvYcCXEfocLRzHBqqyipxJO7ZHiSS7gbDNKhoG/k8Mw3ERadoQTuOINtdDB25xX502F2isui/bHV61j/mzR0Uyt47qxcbSOKbybWTOqMXCS34igqdPQBbTgYslF0k64j29deDwwusOAEL4MianBFZ0Q2W7WIRwCx0AZbfyBnZHsz38m08JDJxBb
X-Gm-Message-State: AOJu0Yzt/sq6hICksJBDfnilu9jbu+iZci4zBXNc8gE9zmp3PCywIg3x
	IsbtmQJT54hIosRXXAglWOJTTdn+9kN4b37AUHa5tXgW6WKV+2/R
X-Google-Smtp-Source: AGHT+IFEa4g3vRAtf1FCeRf9246v4xQREPZ8qlRZwoulVYhRivZRAIfPthESDZz6dI0QDwDhp5EJeA==
X-Received: by 2002:a05:600c:3155:b0:421:29b4:532a with SMTP id 5b1f17b1804b1-4212e05ef29mr60498085e9.16.1717361564764;
        Sun, 02 Jun 2024 13:52:44 -0700 (PDT)
Received: from krava ([83.240.60.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a4c88sm94149775e9.31.2024.06.02.13.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:52:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Jun 2024 22:52:43 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: syzbot <syzbot+list0820d438c1905c75bc71@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org
Subject: Re: [syzbot] Monthly trace report (May 2024)
Message-ID: <Zlzbm0rvNN9XY5v_@krava>
References: <00000000000061fac40619ba66f6@google.com>
 <20240602120950.8f08ef16ad9c485db374c08d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602120950.8f08ef16ad9c485db374c08d@kernel.org>

On Sun, Jun 02, 2024 at 12:09:50PM +0900, Masami Hiramatsu wrote:
> On Thu, 30 May 2024 23:50:32 -0700
> syzbot <syzbot+list0820d438c1905c75bc71@syzkaller.appspotmail.com> wrote:
> 
> > Hello trace maintainers/developers,
> > 
> > This is a 31-day syzbot report for the trace subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/trace
> > 
> > During the period, 1 new issues were detected and 0 were fixed.
> > In total, 10 issues are still open and 35 have been fixed so far.
> > 
> > Some of the still happening issues:
> > 
> > Ref Crashes Repro Title
> > <1> 705     Yes   WARNING in format_decode (3)
> >                   https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
> 
> Could you send this to bpf folks? It seems bpf_trace_printk caused this errror.
> (Maybe skipping fmt string check?)
> 
> > <2> 26      Yes   INFO: task hung in blk_trace_ioctl (4)
> >                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
> 
> This looks like debugfs_mutex lock leakage. Need to rerun with lockdep.
> 
> > <3> 7       Yes   WARNING in get_probe_ref
> >                   https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
> 
> Hm, fail on register_trace_block_rq_insert(). blktrace issue.
> 
> > <4> 6       Yes   INFO: task hung in blk_trace_remove (2)
> >                   https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
> 
> This looks like debugfs_mutex lock leakage too.
> 
> > <5> 5       Yes   general protection fault in bpf_get_attach_cookie_tracing
> >                   https://syzkaller.appspot.com/bug?extid=3ab78ff125b7979e45f9
> 
> This is also BPF problem.

this one seems to be easy to fix, can't reproduce with either the change
below or with instrumenting __bpf_prog_test_run_raw_tp to set current->bpf_ctx
as in __bpf_trace_run

will send a patch

thanks,
jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 593efccc2030..fc303c20f402 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1148,6 +1148,8 @@ BPF_CALL_1(bpf_get_attach_cookie_trace, void *, ctx)
 {
 	struct bpf_trace_run_ctx *run_ctx;
 
+	if (!current->bpf_ctx)
+		return 0;
 	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
 	return run_ctx->bpf_cookie;
 }

