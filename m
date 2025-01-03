Return-Path: <bpf+bounces-47849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E7A00B62
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 16:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D65A160748
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13971FA827;
	Fri,  3 Jan 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzlVAbHM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912C158553
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917771; cv=none; b=Pfv5nkpZ/DVGPj6oj8qTcrSuoKYOx7+cP+h1sLctRh5hwwUoeRM8T/2yyyxLa2Y5Req4AwSAFV7TXZpqKbd4d7fxXyHYPuzCrY+mamW3DMaupJvULwLI3qvKvmaGo/GfrDoSWSTxiCGK01g8qkAYWbvo7hgnaBzdwm1jIyj5wV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917771; c=relaxed/simple;
	bh=3rSeyUiJpDhdND+8XxyaCKGZ2HgEztvmvA7yRwYF5KM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDFDV1Dc/N+CfNUY6ej9kLUM/VEYjCgqeciYGU/iZKt7Vqp4HoI8re2qGHJv32eyev23t3YLMwCuEIZxwGxDBFdciMshwKNqhm5+svymcWg/lp47pQ5FzwG67E3ibfBBwab2187npxSQ8skVsuwkTgaO/1lFANr5bRp29ls7kX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzlVAbHM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so24703014a12.0
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2025 07:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735917768; x=1736522568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=my1yZUajqvD2M4i+fH2QVHwD7AyxFdsN23ecNimmgPU=;
        b=OzlVAbHMEi8q7kQZDKk1bTaH/aGWu6fD7N2Wot+Nrm1d793HWj/WMa4jfocfXvHz6K
         mQrhh4ZwNAEHn/S+hHFReZsYW+FlTUaUmvDkmGcNY3KOaNgZl9dzfPceYTJY5UEvdb1O
         ALGbEO/B0ixOXkZuzW9my9Gh7xvrat0x43Zr9H9zus6MXLzo0ALlMruqY7/2/bUfFxmt
         zL5xq8b7R5az86svWSr0rALNGbXg/kfaZK9retHrNw0+Py5XpkwNv95ogxqszey+4YRL
         IG6d37ypmPvrLdND9/DpVt6PRV+AsnPJ9guO1gKmaeFySd3XNmXqkt/XVh750D3uyYG6
         i8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917768; x=1736522568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my1yZUajqvD2M4i+fH2QVHwD7AyxFdsN23ecNimmgPU=;
        b=EbpfuKcWEwySwdcbAVU+yNHp8NB/xzUwgKxqfkKBZB+ztzyeQ+uiB70FHsl17Blwsf
         Te9GmuhZmXl/KbJfUFktJ5TCHu+uHscIUih7513JnmGu7QiLx0+OhsVfZohcmWphYxN3
         NKMtoUvqIk1umOYY1FJ9I2wKKSldvtntl9VCzs4ORyfC4ALZ5yPON1FUNMd5xtBuIc4Y
         RrIzqQ6AfXv+FerN1F8QBLHucPdQmB/mBRIT17CdMT98FR5/rYBT2lBkdO/88ajcmzcH
         boDRdYUgjg15hg8tayhDVUz+GlNYRdIbQ+x+vaqXfvcOoYOsaHIzd1Is7hB91yUhkE3a
         wFBA==
X-Gm-Message-State: AOJu0Yy7QFlXJnE5a8ZB+ZiKYlnAXkYccDgHBqHScvP4YSyFaqPeeQYo
	xBm6gyFWLZnSZ21LsXNPRliRuQPoxBkuHIknUqqqskPKIUC9cMbW
X-Gm-Gg: ASbGncsCY100iU+tZ3XthxBTvoM4uKaPCsigCHGuE3brjhZHRoSfVVQJx/nBV7/SiBo
	4yWMblR3KNdLpxiPh0pbYoPQ8H5CskxHDVG+WepNN5anyYYS+hkdmk8AOraMVzT/ELpLc7P2Dqq
	rM6dK2L4lWX/szs5I7vgHqi5I/AaaVmyR4r4mFr86B90zXwSklie4pZD/xhzCEPRY0nzYm1FtAt
	+oeoQW5Y1udBtBwYOtfbt88EHj5vrAbgie5pObTXs4=
X-Google-Smtp-Source: AGHT+IFgNEmxbb/XUjghe3ptMjIRKOL5MFIlb9mmLm8OFnWUwZbIUvAdnfGAoxDG7drYiWec1+Kvxg==
X-Received: by 2002:a17:907:1c96:b0:aaf:ab78:34f0 with SMTP id a640c23a62f3a-aafab784915mr269464266b.30.1735917767529;
        Fri, 03 Jan 2025 07:22:47 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06543asm1899875966b.175.2025.01.03.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:22:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 Jan 2025 16:22:45 +0100
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jann Horn <jannh@google.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next] bpf: Move out synchronize_rcu_tasks_trace from
 mutex CS
Message-ID: <Z3gAxZTJTYngLnYi@krava>
References: <20241231033509.349277-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231033509.349277-1-pulehui@huaweicloud.com>

On Tue, Dec 31, 2024 at 03:35:09AM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Commit ef1b808e3b7c ("bpf: Fix UAF via mismatching bpf_prog/attachment
> RCU flavors") resolved a possible UAF issue in uprobes that attach
> non-sleepable bpf prog by explicitly waiting for a tasks-trace-RCU grace
> period. But, in the current implementation, synchronize_rcu_tasks_trace
> is included within the mutex critical section, which increases the
> length of the critical section and may affect performance. So let's move
> out synchronize_rcu_tasks_trace from mutex CS.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  kernel/trace/bpf_trace.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 48db147c6c7d..30ef8a6f5ca2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2245,12 +2245,15 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  {
>  	struct bpf_prog_array *old_array;
>  	struct bpf_prog_array *new_array;
> +	struct bpf_prog *prog;
>  	int ret;
>  
>  	mutex_lock(&bpf_event_mutex);
>  
> -	if (!event->prog)
> -		goto unlock;
> +	if (!event->prog) {
> +		mutex_unlock(&bpf_event_mutex);
> +		return;
> +	}
>  
>  	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
>  	if (!old_array)
> @@ -2265,6 +2268,11 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  	}
>  
>  put:
> +	prog = event->prog;
> +	event->prog = NULL;
> +
> +	mutex_unlock(&bpf_event_mutex);
> +
>  	/*
>  	 * It could be that the bpf_prog is not sleepable (and will be freed
>  	 * via normal RCU), but is called from a point that supports sleepable
> @@ -2272,11 +2280,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  	 */
>  	synchronize_rcu_tasks_trace();
>  
> -	bpf_prog_put(event->prog);
> -	event->prog = NULL;
> -
> -unlock:
> -	mutex_unlock(&bpf_event_mutex);
> +	bpf_prog_put(prog);
>  }
>  
>  int perf_event_query_prog_array(struct perf_event *event, void __user *info)
> -- 
> 2.34.1
> 

would something like below be simpler? (not tested)

jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 973104f861e9..a4c0efa3a26e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2246,6 +2246,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 {
 	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
+	struct bpf_prog *prog = NULL;
 	int ret;
 
 	mutex_lock(&bpf_event_mutex);
@@ -2266,18 +2267,22 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 	}
 
 put:
-	/*
-	 * It could be that the bpf_prog is not sleepable (and will be freed
-	 * via normal RCU), but is called from a point that supports sleepable
-	 * programs and uses tasks-trace-RCU.
-	 */
-	synchronize_rcu_tasks_trace();
-
-	bpf_prog_put(event->prog);
+	prog = event->prog;
 	event->prog = NULL;
 
 unlock:
 	mutex_unlock(&bpf_event_mutex);
+
+	if (prog) {
+		/*
+		 * It could be that the bpf_prog is not sleepable (and will be freed
+		 * via normal RCU), but is called from a point that supports sleepable
+		 * programs and uses tasks-trace-RCU.
+		 */
+		synchronize_rcu_tasks_trace();
+
+		bpf_prog_put(prog);
+	}
 }
 
 int perf_event_query_prog_array(struct perf_event *event, void __user *info)

