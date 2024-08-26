Return-Path: <bpf+bounces-38064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE0E95EE06
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16ED28393E
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C161465A5;
	Mon, 26 Aug 2024 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHieg1lk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B2804;
	Mon, 26 Aug 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666744; cv=none; b=eKwVbCjbdsk31oZ3l9Cii9mHG2XoL/+XSNU7kaWIrEuck5sIdA8UQGOB2DzXX17tODLWUNPnwyRp5TY5AAN27g2xbxCUi0t0JOAXz2MtGb0OfAX9EKV9kSIxKq4R/SaskYPNTPm3ktCtayBHc+iMs94swALewGcAGRuMKfD8E+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666744; c=relaxed/simple;
	bh=HQq8sSpk1x7MtsQvPJS/bUIYn23FdTgDfcF20qzFjGw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZRdrNRzKEq9okDwfdslwPkDL+iJ9Dy9xzN0HO2fnyMn6YyFyxrMVOfEG9bRpvAkkDkO8sTXhv/1jBUL/tL//WkEHa+5TsnL4V8qjVXtw2jaoAKNaaqjmkk824ahLig35zPNSJ97y3TzCLuHD6gua6xd+fLmaGl7hMLJEceMuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHieg1lk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e3129851so36785895e9.3;
        Mon, 26 Aug 2024 03:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724666741; x=1725271541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t40XBDzLJ1B45MoGQZbb3DP7+s/9CmE4kzhKzHKXa/U=;
        b=hHieg1lkfZhyakCQqJeV/rJ8gt8qNX/jcmoZks9tpkwW6e9urp82H3SnhCp+Kj3uK5
         5bo/aMEhg8zRp0cr34VVMwzLxx2zrhDe6Kod0QpM57NCsMzwKYiG7ygW6QBnJ8s3jRdS
         z77lixdA6XaaoUK3N1ff12UwOI2XTpMf92fJ457WOC/t2oxF4bpKnOJuzXmp739vIZLW
         Q0+DzmnZNVN0+Pf9eQCqBJ2c7yo6HcSBg6yNp+DAIEvPZ77kcWSZcney22jrGGaaL5cP
         JdTQ5kHdifnO0g0wYFywLqdHzn9SmD/zX6lYNHLop/tbvteQBuiwb0LiDVQtzauBYkNy
         Toqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724666741; x=1725271541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t40XBDzLJ1B45MoGQZbb3DP7+s/9CmE4kzhKzHKXa/U=;
        b=vtSyPSP4HfdDUlCgjPgnqwm3BaCihmyHdJG7xtAG2rsGGJ2Jb1aJcgY3KBRKL5IMBr
         DS+MIchzmfbylag+7ctkb/XOMqj+XiFJVfDOH+YkfWsK/ufAWtVsDuHXmwM048H3Q/Pb
         EMtQZH6qM+ZkN51PFGxHpT4hYt08MRzEUhycC83CvnU1yA/33QHQeLotTgpcp1hUIhVZ
         2MVIUbk+NG6EycObEUViRCagJkpAnIFOMIdU57xCeVD5XbdV9KFJqG4/S+gTz6A7x85I
         GVDDP+X2Su1rjlrU6pnB47QFZxaKPdbal04uga6LYQtHnP+hpGRa2OKh6uGMqEOYTQxx
         5y9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVufSluKS7M7TJD3oK3PqnuVWlJRqHPmjZe7PMDhH3iaDTRYoN5Xqq2+FruAd+uqauQBHAH2wVPiyn9WANwCWx3OTJ4@vger.kernel.org, AJvYcCW+2CgRV9R1tAk8gi15d48xJT779E/fFpQejEWCXzf+yOCv5/xcGTgugtmPO4y1U9C8mTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3dJpTEWAWKPCRYumU6+LgwEyQocGAQC5EhqSWJ0pPDzTy3XQ
	gypheu8aB5gac+JeHK7OUF5NdQ7DkdT0Wuk+Qy1ebn9tJsDImrO4
X-Google-Smtp-Source: AGHT+IGaEo7nGIRa+g3XsADZ11D5f1+mzHp1pMSQEh75+HZZTuGkXxTo1w/THsBeR+l2GwGMDfMcyw==
X-Received: by 2002:a05:600c:3c94:b0:427:fa39:b0db with SMTP id 5b1f17b1804b1-42acc8ff577mr59698185e9.27.1724666740601;
        Mon, 26 Aug 2024 03:05:40 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730826b4b5sm10252202f8f.115.2024.08.26.03.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:05:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Aug 2024 12:05:38 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <ZsxTckUnlU_HWDMJ@krava>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825224018.GD3906@redhat.com>

On Mon, Aug 26, 2024 at 12:40:18AM +0200, Oleg Nesterov wrote:
> On 08/25, Oleg Nesterov wrote:
> >
> > At least I certainly disagree with "Fixes: c1ae5c75e103" ;)
> >
> > uretprobe_perf_func/etc was designed for perf, and afaics this code still
> > works fine even if you run 2 perf-record's with -p PID1/PID2 at the same
> > time.
> >
> > BPF hacks/hooks were added later, so perhaps this should be fixed in the
> > bpf code, but I have no idea what bpftrace does...
> 
> And I can't install bpftrace on my old Fedora 23 working laptop ;) Yes, yes,
> I know, I should upgrade it.
> 
> For the moment, please forget about ret-probes. Could you compile this program
> 
> 	#define _GNU_SOURCE
> 	#include <unistd.h>
> 	#include <sched.h>
> 	#include <signal.h>
> 
> 	int func(int i)
> 	{
> 		return i;
> 	}
> 
> 	int test(void *arg)
> 	{
> 		int i;
> 		for (i = 0;; ++i) {
> 			sleep(1);
> 			func(i);
> 		}
> 		return 0;
> 	}
> 
> 	int main(void)
> 	{
> 		static char stack[65536];
> 
> 		clone(test, stack + sizeof(stack)/2, CLONE_VM|SIGCHLD, NULL);
> 		test(NULL);
> 
> 		return 0;
> 	}
> 
> and then do something like
> 
> 	$ ./test &
> 	$ bpftrace -p $! -e 'uprobe:./test:func { printf("%d\n", pid); }'
> 
> I hope that the syntax of the 2nd command is correct...
> 
> I _think_ that it will print 2 pids too.

yes.. but with CLONE_VM both processes share 'mm' so they are threads,
and at least uprobe_multi filters by process [1] now.. ;-)

> 
> But "perf-record -p" works as expected.

I wonder it's because there's the perf layer that schedules each
uprobe event only when its process (PID1/2) is scheduled in and will
receive events only from that cpu while the process is running on it

jirka

[1] 46ba0e49b642 bpf: fix multi-uprobe PID filtering logic

> 
> Oleg.
> 

