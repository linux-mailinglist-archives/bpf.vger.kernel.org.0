Return-Path: <bpf+bounces-46274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241E69E6FD5
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD70228263A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61490207DFE;
	Fri,  6 Dec 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA11Guc5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDE2E859;
	Fri,  6 Dec 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494148; cv=none; b=IRGcvPjjCvy0eYhQYmTab/ufPLE/pCOF4L3kWCQeLxFnEN2xHP0sksW52l3bhNmiXjZvzMDxdCqbiZOEV5fsur/rukJ+tyUNcObaeYXoyhtkCOLJkjiLk+YvcZTOxRLEDZH4XcPIEP2AkDexhnfnrITLivmbThCtl1c2Oltp5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494148; c=relaxed/simple;
	bh=5byG2XU+5kpJVdaF+EoxTEV/QVS2LOy3OWzTIb7LAtE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWu6utbgUbFo5c1A5dTKi6WTn6vqwyOQaGMb6l5WlzXErZe1mbTM3ZGzZISuzBOCbI6K8o6XvyGH43Zn30MHzvv7xibfhtU+fi+BpZfJJ5XaXKFLQLvJlo1PoMp7gp5035ama8y7yJdocq2ikE5Akq+VvcimdQJ9N5G1gekqglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA11Guc5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5500f7a75so280832866b.0;
        Fri, 06 Dec 2024 06:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733494145; x=1734098945; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEQkk4fFx/6Hy0B/67rmUPlRypoGwjE5KfTmQ56ckDU=;
        b=KA11Guc5IEkYlYLDfjm6Qw1PaTTEKkc53WVl5mCkAnkIOjTP0g9xcAwRHGImQIenHH
         Coabi8FBX9dpqwK2XqNcuKLpa2g47Ew/7BS8LR2/0tY6W3q4EVO7lgLwqKQ9S3cpJOd4
         Uh655LH6HS/OY79bqcE/wkxEkKe6OFIv/rzluwTtwb1JGfhPJNgpcE1wIDyKoXgIYKu6
         AlVhSSmVtyYaugY1T6ZmcgE6g1yv14MnyVIKnea+blCElt5kRGdUZiUxOHdPkqRK//pX
         Y8hxJ/kKlt+IehYC7qEJt2tu2PPgsVbPRPBTIskyx0De49BL1OR9KNJeTqAXcLEliM5N
         WNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494145; x=1734098945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEQkk4fFx/6Hy0B/67rmUPlRypoGwjE5KfTmQ56ckDU=;
        b=H2dGd+SFKbK/LF6SXxWrYqs0TGU9O33HXG+oHl+bx0hTvCbrF5Lz8on1nEegHnNS3e
         czp7R996xXGlZwgti0dGdcxjeORxQKkQgxAxtEAVvtEET869GDiy3bVo4V2yWi+NhkOc
         xDdMerAN8JtF1vLts6J/2R1UR9CYgCu74z6I86NFqCjXxkryyPkHZHkJpBgPhwC1E2/A
         jZ/gKxzNNhB0XBX4EugUzHlCBgEOU0qXycw1wl2fV1fxjtQYP8/RaEGEj8Fly0rArl9C
         mGEJH1IyNaANIop4slNHtBPn+RPS9aHd4cQtr7/e+cnivl4h7Ig/BjWtqpau4FGn6ZGv
         BBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+7XiteMTx4+ewZbrs9OvSLypGljW/E1+lIKAxBTBmXtH+xlThxPvd5o7IUJnIC4jviDwEhnjapn//w+XQ@vger.kernel.org, AJvYcCUahE0UFHsz+Z7lijjtu8YcG0noe9F3m8sCkOcd+JLDgmD4Kb/7t7aaa3VjbB16RX8okek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXGzmOm1KQvl2Xyv5xdjO59Y7Kwq2K7SZHF0Ulnwaut1v5sVV
	LwF9ozdq7BdOH38z+oEuAvkH6qW1cvLloNzAKTHz+jQhNljupcXF
X-Gm-Gg: ASbGnctwAHnghaYjHMf6yYkyg8GtCq2bY26PRYrrQJ4/Nimlx5c1oS8EIqNfu5ipGuE
	7oZOy2MDf/FOzWSIKuytkHdvKv5k1MenESOh9afHXJlr9RBf9NGE6UqnFA54NFf3GOxCdGEfu6D
	IVKGuZWlSQUJyaysXXCBOzlKQZ5vNRsTNCzV9Y4+XdOmgzdtDbwAtQ3SorL1c05mPq5gQ13In1P
	H7iOBUGGmIzk3hD69hA4FiBMKWjXRPFIGmjr9O7brzHih1FdLGet5yuf7ef+xVqJVdaOnU6WjhN
	Ha21/pV6gyDGXdO8ts8oLzg=
X-Google-Smtp-Source: AGHT+IFKFPRm11x4mfUND5YQitW1R/PrAiz1fZWusMP4dh6vJmZemIkQ7jlkBQZZxbnTB6t4X8q+Cg==
X-Received: by 2002:a17:906:30cb:b0:aa5:3782:53af with SMTP id a640c23a62f3a-aa63a07edfcmr222168166b.27.1733494145215;
        Fri, 06 Dec 2024 06:09:05 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260a3aa0sm245075466b.170.2024.12.06.06.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 06:09:04 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Dec 2024 15:09:03 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, liaochang1@huawei.com,
	kernel-team@meta.com
Subject: Re: [PATCH perf/core 4/4] uprobes: reuse return_instances between
 multiple uretprobes within task
Message-ID: <Z1MFfyNLRilb8G6r@krava>
References: <20241206002417.3295533-1-andrii@kernel.org>
 <20241206002417.3295533-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206002417.3295533-5-andrii@kernel.org>

On Thu, Dec 05, 2024 at 04:24:17PM -0800, Andrii Nakryiko wrote:
> Instead of constantly allocating and freeing very short-lived
> struct return_instance, reuse it as much as possible within current
> task. For that, store a linked list of reusable return_instances within
> current->utask.
> 
> The only complication is that ri_timer() might be still processing such
> return_instance. And so while the main uretprobe processing logic might
> be already done with return_instance and would be OK to immediately
> reuse it for the next uretprobe instance, it's not correct to
> unconditionally reuse it just like that.
> 
> Instead we make sure that ri_timer() can't possibly be processing it by
> using seqcount_t, with ri_timer() being "a writer", while
> free_ret_instance() being "a reader". If, after we unlink return
> instance from utask->return_instances list, we know that ri_timer()
> hasn't gotten to processing utask->return_instances yet, then we can be
> sure that immediate return_instance reuse is OK, and so we put it
> onto utask->ri_pool for future (potentially, almost immediate) reuse.
> 
> This change shows improvements both in single CPU performance (by
> avoiding relatively expensive kmalloc/free combon) and in terms of
> multi-CPU scalability, where you can see that per-CPU throughput doesn't
> decline as steeply with increased number of CPUs (which were previously
> attributed to kmalloc()/free() through profiling):
> 
> BASELINE (latest perf/core)
> ===========================
> uretprobe-nop         ( 1 cpus):    1.898 ± 0.002M/s  (  1.898M/s/cpu)
> uretprobe-nop         ( 2 cpus):    3.574 ± 0.011M/s  (  1.787M/s/cpu)
> uretprobe-nop         ( 3 cpus):    5.279 ± 0.066M/s  (  1.760M/s/cpu)
> uretprobe-nop         ( 4 cpus):    6.824 ± 0.047M/s  (  1.706M/s/cpu)
> uretprobe-nop         ( 5 cpus):    8.339 ± 0.060M/s  (  1.668M/s/cpu)
> uretprobe-nop         ( 6 cpus):    9.812 ± 0.047M/s  (  1.635M/s/cpu)
> uretprobe-nop         ( 7 cpus):   11.030 ± 0.048M/s  (  1.576M/s/cpu)
> uretprobe-nop         ( 8 cpus):   12.453 ± 0.126M/s  (  1.557M/s/cpu)
> uretprobe-nop         (10 cpus):   14.838 ± 0.044M/s  (  1.484M/s/cpu)
> uretprobe-nop         (12 cpus):   17.092 ± 0.115M/s  (  1.424M/s/cpu)
> uretprobe-nop         (14 cpus):   19.576 ± 0.022M/s  (  1.398M/s/cpu)
> uretprobe-nop         (16 cpus):   22.264 ± 0.015M/s  (  1.391M/s/cpu)
> uretprobe-nop         (24 cpus):   33.534 ± 0.078M/s  (  1.397M/s/cpu)
> uretprobe-nop         (32 cpus):   43.262 ± 0.127M/s  (  1.352M/s/cpu)
> uretprobe-nop         (40 cpus):   53.252 ± 0.080M/s  (  1.331M/s/cpu)
> uretprobe-nop         (48 cpus):   55.778 ± 0.045M/s  (  1.162M/s/cpu)
> uretprobe-nop         (56 cpus):   56.850 ± 0.227M/s  (  1.015M/s/cpu)
> uretprobe-nop         (64 cpus):   62.005 ± 0.077M/s  (  0.969M/s/cpu)
> uretprobe-nop         (72 cpus):   66.445 ± 0.236M/s  (  0.923M/s/cpu)
> uretprobe-nop         (80 cpus):   68.353 ± 0.180M/s  (  0.854M/s/cpu)
> 
> THIS PATCHSET (on top of latest perf/core)
> ==========================================
> uretprobe-nop         ( 1 cpus):    2.253 ± 0.004M/s  (  2.253M/s/cpu)
> uretprobe-nop         ( 2 cpus):    4.281 ± 0.003M/s  (  2.140M/s/cpu)
> uretprobe-nop         ( 3 cpus):    6.389 ± 0.027M/s  (  2.130M/s/cpu)
> uretprobe-nop         ( 4 cpus):    8.328 ± 0.005M/s  (  2.082M/s/cpu)
> uretprobe-nop         ( 5 cpus):   10.353 ± 0.001M/s  (  2.071M/s/cpu)
> uretprobe-nop         ( 6 cpus):   12.513 ± 0.010M/s  (  2.086M/s/cpu)
> uretprobe-nop         ( 7 cpus):   14.525 ± 0.017M/s  (  2.075M/s/cpu)
> uretprobe-nop         ( 8 cpus):   15.633 ± 0.013M/s  (  1.954M/s/cpu)
> uretprobe-nop         (10 cpus):   19.532 ± 0.011M/s  (  1.953M/s/cpu)
> uretprobe-nop         (12 cpus):   21.405 ± 0.009M/s  (  1.784M/s/cpu)
> uretprobe-nop         (14 cpus):   24.857 ± 0.020M/s  (  1.776M/s/cpu)
> uretprobe-nop         (16 cpus):   26.466 ± 0.018M/s  (  1.654M/s/cpu)
> uretprobe-nop         (24 cpus):   40.513 ± 0.222M/s  (  1.688M/s/cpu)
> uretprobe-nop         (32 cpus):   54.180 ± 0.074M/s  (  1.693M/s/cpu)
> uretprobe-nop         (40 cpus):   66.100 ± 0.082M/s  (  1.652M/s/cpu)
> uretprobe-nop         (48 cpus):   70.544 ± 0.068M/s  (  1.470M/s/cpu)
> uretprobe-nop         (56 cpus):   74.494 ± 0.055M/s  (  1.330M/s/cpu)
> uretprobe-nop         (64 cpus):   79.317 ± 0.029M/s  (  1.239M/s/cpu)
> uretprobe-nop         (72 cpus):   84.875 ± 0.020M/s  (  1.179M/s/cpu)
> uretprobe-nop         (80 cpus):   92.318 ± 0.224M/s  (  1.154M/s/cpu)

nice! left few comments but overall lgtm

thanks,
jirka

