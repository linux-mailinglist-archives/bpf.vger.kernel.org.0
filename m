Return-Path: <bpf+bounces-58956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F4AC44D8
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 23:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE31F16534C
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 21:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D970241668;
	Mon, 26 May 2025 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1PkB8Wy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21F14830A;
	Mon, 26 May 2025 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748295378; cv=none; b=rrYqwIMCHhLEWR8jMQcYGsnok3WbooUswo57qHYy1Q+9ZCdAt6BnnNMHBNWaokTkB8sKUG8/sULEtrloxxfvtZiV108e3xs5ivxBm6GSRNxTnatPxrIDXn1HAs+kBNq7pmdm7yKZc750sicuW8CH7fJLN9XJE8TvM3gKTr4ee+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748295378; c=relaxed/simple;
	bh=A1O2aaqb1msQ3ciMI88tVBNeU3i1ThpwfS74QsymqGA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzgNybWIy7vCX3cnYfgUnjVAAwKY6l4WDDLntSaSZvy2gyi5qwtJ8tXUUigADA61S3rxE+TGEJ6eRlN920b/rghlwHIG4iSBpK8ltbNaCmZAZyPI1kZur4W9VsYrYQ7oTIw/RxaPOqwgzbfgTtHswr7EQdDCoqYyy46IFFSXa0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1PkB8Wy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edb40f357so22406505e9.0;
        Mon, 26 May 2025 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748295375; x=1748900175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3lnNb9yn9lATjxO6VHxHH72Z14fcdJiMP9it5w7LLU=;
        b=L1PkB8WyEvXlIckD8BhssUb7jk2uDsj3QrtI+hmgHVT4mq+jBxf9g84h7kQwMiD1DU
         NPosAfNtX4qW2fCrcGrSbiK+BF8JBXBSyxYPuwXCtHvOavXC0vnVVpqJNpDjq/61zy9V
         qCSzttUIZPly1gURauE7Kb7lpBzwM7ZF+JSa0XynO5pqci4JJ5gVMDFWFzLNzlyRzOHv
         cdtCPjt7df5HUhhgbR1nwuNJqcF+rVH+mwEwFQL7QZTepZAgBz1wVYLWDhOelPQR5pz6
         inrVm/tkrBdHxy+sTnZMGQy/K4nSscc1RWQZbmeSjDBIJGAkZ64W+0gHj2AjWTS6Jezp
         Wsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748295375; x=1748900175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3lnNb9yn9lATjxO6VHxHH72Z14fcdJiMP9it5w7LLU=;
        b=iqsCVSb3ms2BTud8m3YgoYZWPoRwWhi/+l6XB6jP9j+9gp5gKhh+ZjwMMnTMA22JgH
         hs10z2K6WcUfS/s5WC9EJ0xAqe2xYa+tgpE5TUwaRZpy//PqwAc0r8SD6wcA+Wpu04ci
         Y37dUqOZTHxzwOcvdiTB9erIXPMn9uYZ5Z6bWS5Fp9y9pXGO1hRKPXYtOn7AT1DBZ47v
         FNpk/M+RvN8EZBT5lK5UL1G4LRePXMsaYqBGaabT0MuytpHHvp3H7UCt4K980Sj7gLWZ
         9do3amBK0TtQ9nVwGb5dLfG35MR5jrUA/EsjQyOv4PildM5GsCum8Mvgf7da1JdIT5Io
         uCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEjJZW2mePX84WfR3NPhFmLsrCu0Lf+6QFfw6GC+ilGV8n9zBZiLF+b7RNntF7WhSxTK9O4VNOwBMuY3iQhXwwSuON@vger.kernel.org, AJvYcCWfWp+FOqfW3kj34T6aqr+xqczYZYLJMkfRyJPaZ6vH3JzOZBAcdE3xFx6cnCeqpYXPJAL5tjbrci794Ian@vger.kernel.org, AJvYcCXLvEI+8j+OUGeQfhiKXjImSr4eN/U5Tu+t9vLlRlu4fo3LY7RO19UY2dHedsE8nCZSQrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGOxRA7QofmsCDWeUZ/9twODpPcEJ5/gRv9OdPpV6vReFUGp7
	bl3TsWHtAVB2TDF8H7bCHzB48mqpXwLyMYV47Xntlbq0oaRLXyMGxLn/
X-Gm-Gg: ASbGncuzZx5ntjDLLGzTH4b+6JWrFgzIVpyHapzTr3G9yE1KwqNyoRvR4zsp+lwOIN2
	jMI2ixuAgwCfQniu4FzVWpBr2uIQxVLRmJq2xB/GLTl2Hg+HXKw6JrBszLAK0QxfQexqN6uU7z+
	KXpHdn75nefkHOtL3jYbplJNJ+UIkUDxmd3uXn2C5qy4UvQ+jGW8sdBugZRRd/yBOOQwYqJMRWy
	m2Fssb+itcHxzNQAi7qjUY1pWBNezjnKSHLe+JfL1A8LuHpJ/JNGrrz3vMidtlXHZGqxGRYNpUj
	ekBwHQlTGtR6gL0jolvdVnl1LOZmVhoeNerWrmYLMdwkED+HZfIWUnNtdCCZdSXXpzES
X-Google-Smtp-Source: AGHT+IHxqRVP+JNqfYwSCLXotoldvLJsltqFGQqa9blxvha54IDkfupAVNQtPor/kQw/8VqmUD2m7Q==
X-Received: by 2002:a05:600c:3e14:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-44c92a54b22mr86319865e9.23.1748295375146;
        Mon, 26 May 2025 14:36:15 -0700 (PDT)
Received: from krava (85-193-35-57.rib.o2.cz. [85.193.35.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4ce458830sm8315991f8f.14.2025.05.26.14.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 14:36:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 May 2025 23:36:13 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 01/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-ID: <aDTezSUdW6QvQ733@krava>
References: <20250515121121.2332905-1-jolsa@kernel.org>
 <20250515121121.2332905-2-jolsa@kernel.org>
 <20250520084845.6388479dd18658d2c2598953@kernel.org>
 <20250520141925.GA14203@redhat.com>
 <20250522234822.0410cabbbbfb58ef327805a9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522234822.0410cabbbbfb58ef327805a9@kernel.org>

On Thu, May 22, 2025 at 11:48:22PM +0900, Masami Hiramatsu wrote:
> On Tue, 20 May 2025 16:19:26 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > On 05/20, Masami Hiramatsu wrote:
> > >
> > > On Thu, 15 May 2025 14:10:58 +0200
> > > Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > > Currently unapply_uprobe takes mmap_read_lock, but it might call
> > > > remove_breakpoint which eventually changes user pages.
> > > >
> > > > Current code writes either breakpoint or original instruction, so
> > > > it can probably go away with that, but with the upcoming change that
> > > > writes multiple instructions on the probed address we need to ensure
> > > > that any update to mm's pages is exclusive.
> > > >
> > >
> > > So, this is a bugfix, right?
> > 
> > No, mmap_read_lock() is fine.
> > 
> > To remind, this was already discussed with you, see
> > [PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
> > https://lore.kernel.org/all/20240625002144.3485799-3-andrii@kernel.org/
> > 
> > And you even reviewed this patch
> > [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
> > https://lore.kernel.org/all/20240710140045.GA1084@redhat.com/
> > 
> > But, as the changelog explains, this patch is needed for the upcoming changes.
> 
> Oops, OK. So current code is good with either mmap_read_lock() or mmap_write_lock().
> But the patch description is a bit confusing. If the point is an atomic (byte?)
> update or not, it should describe it.

ok, I'll try to make the changelog more detailed

thanks,
jirka

> 
> Thank you,
> 
> > 
> > --------------------------------------------------------------------------
> > Just in case... I'll try to read this series tomorrow, but at first glance
> > this version addresses all my concerns.
> > 
> > Oleg.
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

