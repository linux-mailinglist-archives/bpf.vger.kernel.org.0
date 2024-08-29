Return-Path: <bpf+bounces-38493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 242AD965361
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AFC1F240B9
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7730218EFE2;
	Thu, 29 Aug 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsMJhWXr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1218A6DF;
	Thu, 29 Aug 2024 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973732; cv=none; b=QC5m7saaPrW0acyILOaeuQFFTFcmZyUu0a6rsGsKNZemeiYzn/Q/cR8Rq4+FdQ4Lh/2MV1cFmy39tSpGbrVbjfwnB6OFaqXv8rwK6WNwSbrcJB6Fd6LfAlhDqOK+Rb9MeQ9DPXcmuW0S0QkKZwvd1jXg6ZV3wMJjssfaET9PQu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973732; c=relaxed/simple;
	bh=WjZ0YuCmWeTfS41eFeBoL00JPHivgyV/5ac6p20S8ZU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YysQvebNJdv43ZD2NF4+UeBezSddItG27Q4OL0/dVS12iMnO0FJbOq4hU9nGxff5sMkFafT/NP2EUtEgcsMFY2nBfh7jSu9BeuOpqQDhoul4/obdpEw7xe3yrClhLxA00F/yInDfIDH859O++U4wwbRy1uRIzwTNEYxGhvc3uDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsMJhWXr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86883231b4so138905366b.3;
        Thu, 29 Aug 2024 16:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724973729; x=1725578529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=97ngE1ffUnVmsYK1irtGNA671vYHlu0JelFLB7b/UbY=;
        b=SsMJhWXrjuh5iDPACrnnCx1v8YAOMPGqnDDOudswSqTu28IZ2VhAfUYKWfd6TRrlSk
         d/YAiM/bwx4gDbjW47+rlE+OT1/ChJcNuZupYWY7CrJ+C0Vj+M8UWVV57jxgDG/hXBh9
         jXRdDjXL2lloh9+qWOy8MMhLd2A+fZTqTzAn46DPOhoA/0wD0TLkIyBhnIbiGcPBy5NL
         nO/3nUh8KNIipFy+6RBadRLm5iuc8iBpe8FH/jZyrJD/FG/kf9PbA6liem0ZtK4ME61B
         JK1NkkSA051mubXmLFBt4x0Ld3SLuXb/A4BBLzy7TZWiQSTRYSUDRmHva98/w3vCvDRc
         vu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724973729; x=1725578529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97ngE1ffUnVmsYK1irtGNA671vYHlu0JelFLB7b/UbY=;
        b=Ir92npFdSWdm0pNAWdj9iQ5OF3Wh5fmefMxF1uO7Q5gBNItzvcz1cv4bqtGCDhZDUj
         IJOQZ1MUq8nPanrNWFWU1vGcp0mrpfXMImKa82Xicjtv5npbz7ZisKvRtikFytj+9KT3
         Aubl7ISdUzf2lhums2w1U9an8RNpy2EfVmvSxdCo3yHbDQYAXFm1invqUPX95B5qDeLm
         3359IKWH+ztzG1iQB/yLJ+bqSkROhr0OuUfx3W3Ujra1ZkYwiq+2K23VP0vZ9oZ8sYvy
         37O6H+QaOR6Jbew6fOzcbkk2KH19NF7xgBaVWC9tWCT5DogNHAHttUP2LyTSc0Bpefn1
         kBnA==
X-Forwarded-Encrypted: i=1; AJvYcCUgeugVNKvGBQTUx+pxDm2JnNDoAMaXuNf/X5VOytkpXYIKHjpI5z5NehQ/gUylVe9JV58=@vger.kernel.org, AJvYcCXXJJND4ZQq0+zMJSYU/azu2k48ZjJNpIgOMun8bcdJAW6QsbMDirY79KL2yHBuKLlIKM8qNzDW1Sik6KTj61QZ+5nC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/Q69NH2aHHPtEZMpPGdnfOwtN0UPmh3ZqTNrjBXNTWdR/KEA
	aijkyDuRHjGxfEuw2TKVXNbKzteMYHZRMMXEAA7DBOF48p6jdTJV
X-Google-Smtp-Source: AGHT+IEtAeb0UqUed4amZvxJhaV1Y9gzUUPW8wTm4GchdkHdHRWoevy9WuPtbaM8DQvf7/yJY5M6Xg==
X-Received: by 2002:a17:907:7f15:b0:a7a:aa35:408a with SMTP id a640c23a62f3a-a897f83b281mr391791066b.25.1724973728169;
        Thu, 29 Aug 2024 16:22:08 -0700 (PDT)
Received: from krava (brn-rj-tbond02.sa.cz. [185.94.55.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989223199sm135242866b.219.2024.08.29.16.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 16:22:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Aug 2024 01:22:04 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <ZtECnGA4-vq-t9c5@krava>
References: <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
 <Zs3PdV6nqed1jWC2@krava>
 <20240827201926.GA15197@redhat.com>
 <Zs8N-xP4jlPK2yjE@krava>
 <20240829152032.GA23996@redhat.com>
 <ZtDQEVN1-BAfWuMU@krava>
 <20240829211241.GA19243@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829211241.GA19243@redhat.com>

On Thu, Aug 29, 2024 at 11:12:41PM +0200, Oleg Nesterov wrote:
> Ah. we certainly misunderstand each other.
> 
> On 08/29, Jiri Olsa wrote:
> >
> > On Thu, Aug 29, 2024 at 05:20:33PM +0200, Oleg Nesterov wrote:
> >
> > SNIP
> 
> SNIP
> 
> > right.. if the event is not added by perf_trace_add on this cpu
> > it won't go pass this point, so no problem for perf
> 
> Yes, and this is what I tried to verify. In your previous email you said
> 
> 	and I think the same will happen for perf record in this case where instead of
> 	running the program we will execute perf_tp_event
> 
> and I tried verify this can't happen. So no problem for perf ;)

yea, I was wrong, you should be used to it by now ;-)

> 
> > but the issue is with bpf program triggered earlier by return uprobe
> 
> Well, the issue with bpf program (with the bpf_prog_array_valid(call) code
> in __uprobe_perf_func) was clear from the very beginning, no questions.
> 
> > and [1] patch seems to fix that
> 
> I'd say this patch fixes the symptoms, and it doesn't fix all the problems.
> But I can't suggest anything better for bpf code, so I won't really argue.
> However the changelog and even the subject is wrong.
> 
> > I sent out the bpf selftest that triggers the issue [2]
> 
> Thanks, I'll try take a look tomorrow.

thanks,
jirka

