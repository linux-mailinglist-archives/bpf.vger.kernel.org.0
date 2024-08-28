Return-Path: <bpf+bounces-38263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48F96263A
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 13:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137121C23BC9
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73117175548;
	Wed, 28 Aug 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQWtY+fJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91C1741D4;
	Wed, 28 Aug 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845220; cv=none; b=VUnkpvD08JW8CYNuzZUjEN8cMVZ+vgcNJDS2ZlETbl3seMUmg2YpWICtia6a0Q9SPAqkv+H6j0fEZeDtC9xPifKXK65V8YTP1S0Vz1Zh/6KIXgV8db4k11bpI1m83y3bwWy5fkNVbLCNgBx3Zn3Ra2AAmliKc4U4rKlrLRdEYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845220; c=relaxed/simple;
	bh=FePAsMvHLmE22op2flEQFmGYfkih/ncSqzEQLiob984=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnJ4/zY9B70BV+lNQZfSHlC2u0fB7FcZJOY9Omm3OGm8IMlufU7WGlkuXUt699cMoocX95LJouYUZaG7JpDuFVX83XeWGgrt4dTEB2cRrPQrtenBHdyrdJ7IzFEWpcZ5GjFZc4clS9VJd586wT5vWX8xZYerH4fOFhxMlytMMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQWtY+fJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so7708247a12.2;
        Wed, 28 Aug 2024 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724845217; x=1725450017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5doiDsQOeWB8JxD1pa6SuHZTechKzHGIPcY9ZB/Tn0k=;
        b=PQWtY+fJKPUE2cr6k2SYIQLEIVh0atYTOIhpMVui7dIIMaFDOYTxOQYKxNMccyKYT8
         izWb7emN9B9RBqKLY07PCiNOF2YmOxr2cPS/Y/SvZwOAced2dfDa7JHo4huiXjUcS+oz
         +sQF0dLJrbNl/g3fSAL+MXfcflq1oRZyJo9Dqkc/MQeW2oDkLh8TRk0JNS5KcHrWysOT
         3GkWSpWwz2rdIVAV/PudeoDfV8mgCpJW1VeJcWo2pzXmXyTxJdCIABhH9jJPrTQiFv1O
         P3jG5CrpW3tE9xTAOXm1U0q3BhPOWcgoOTew0wxGRd2xnDEq/qGhY9h59TMbdeZ38ZbJ
         rXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724845217; x=1725450017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5doiDsQOeWB8JxD1pa6SuHZTechKzHGIPcY9ZB/Tn0k=;
        b=IhHd4SAYptcNkvHzPiPZsWLRIRacUGZJhoy/nOfJBjlw5VTj5nDQsAtvvIiALI1q4B
         tIO+UZQdQeD2q9dgpvdYE55MSrqszo6NwYBIoKDSeF+pRl17rnfOWNScbZY4YTFz8mD0
         ugL3svqv5sYBSjDlVRqnWSR/ImqAV0h62T36cvlYnHSy3qkaBCBFfEEQfKBKi+++fy6p
         7vCASUwmfMe7w09EHxUgGKxt4Yl7qaF8WAq+txfM1m3RT62YeV2s2UoJNaEUM67PVERE
         IvhKHHO56uq9cxeYxBfhiRU1tnYTGFKCM9tBMedap6NYzAhw29Y7WLxVX/ESPJ23pfXr
         y7SA==
X-Forwarded-Encrypted: i=1; AJvYcCVqIgOx0zOoAGAsCf5f94hA0COEGmLzpEF1x1TnsYPG5MLiDBi9FfFTgrHrAKs2xuxb8bp2WNNG5oEZ9adc4t3T+kEh@vger.kernel.org, AJvYcCXv59YEoioLewcgxzw5pJZdDpyIEa+kUh1OWBQTNIT3JIVyMfMrkdN0k2hfBXQl8zqmBso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+za/FH7FXtwJG5zz3Rx/ksWgUUtKbMeZTclC3iWea5SXDlUTD
	rAZXKxUxuaIbGFgMyOFdWyCtgjpNYyDJT8YYtfKeRExPUNagNWio09yfr4fdgaLdcA==
X-Google-Smtp-Source: AGHT+IFJRBhL32fcNwMsF1ysq2poybkCQQs3c9osXyU1UUhvo3TmtZue1y4ttg3vqgF3b0HDB/bYEQ==
X-Received: by 2002:a05:6402:40c6:b0:5a2:5bd2:ca50 with SMTP id 4fb4d7f45d1cf-5c0891a032bmr11591310a12.25.1724845216161;
        Wed, 28 Aug 2024 04:40:16 -0700 (PDT)
Received: from krava ([173.38.220.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1e3446sm2267223a12.30.2024.08.28.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:40:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 28 Aug 2024 13:40:13 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zs8MnbfvyxInIMTj@krava>
References: <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
 <Zs3PdV6nqed1jWC2@krava>
 <20240827164545.GG30765@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827164545.GG30765@redhat.com>

On Tue, Aug 27, 2024 at 06:45:45PM +0200, Oleg Nesterov wrote:
> On 08/27, Jiri Olsa wrote:
> >
> > On Tue, Aug 27, 2024 at 12:29:38AM +0200, Oleg Nesterov wrote:
> > >
> > > So, can you reproduce the problem reported by Tianyi on your setup?
> >
> > yes, I can repduce the issue with uretprobe on top of perf event uprobe
> 
> ...
> 
> >    ->     uretprobe-hit
> >             handle_swbp
> >               uprobe_handle_trampoline
> >                 handle_uretprobe_chain
> >                 {
> >
> >                   for_each_uprobe_consumer {
> >
> >                     // consumer for task 1019
> >                     uretprobe_dispatcher
> >                       uretprobe_perf_func
> >                         -> runs bpf program
> >
> >                     // consumer for task 1018
> >                     uretprobe_dispatcher
> >                       uretprobe_perf_func
> >                         -> runs bpf program
> 
> Confused...
> 
> I naively thought that if bpftrace uses bpf_uprobe_multi_link_attach() then
> it won't use perf/trace_uprobe, and uretprobe-hit will result in

right, this path is for the case when bpftrace attach to single uprobe,
but there are 2 instances of bpftrace 

jirka

> 
> 	// current->pid == 1018
> 
> 	for_each_uprobe_consumer {
> 		// consumer for task 1019
> 		uprobe_multi_link_ret_handler
> 		    uprobe_prog_run
> 		       -> current->mm != link->task->mm, return
> 
> 		// consumer for task 1018
> 		uprobe_multi_link_ret_handler
> 		    uprobe_prog_run
> 		       -> current->mm == link->task->mm, run bpf
> 	}
> 
> > I think the uretprobe_dispatcher could call filter as suggested in the original
> > patch..
> 
> OK, agreed.
> 
> > but I'm not sure we need to remove the uprobe from handle_uretprobe_chain
> > like we do in handler_chain..
> 
> Me too. In any case this is another issue.
> 
> Oleg.
> 

