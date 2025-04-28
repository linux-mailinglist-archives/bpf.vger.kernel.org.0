Return-Path: <bpf+bounces-56843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94A6A9F240
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393AE461D54
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03A269D1B;
	Mon, 28 Apr 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq97mzZx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776F25E81D;
	Mon, 28 Apr 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846679; cv=none; b=dF6WS5AvZB00PUszLp2Cz+h6MhXYQ9lskMUFQcGCZE0rsGnP9Jcan1TGZtJ1LYIkGpDxuOPOtQ7gBNlXb+S3IYTp8rVD+dZ1DtxPiQtOI0CcGuGdl0zlGNf6cJnlK3P0VbQhR2jMqSQLaVs/0f1dEntIwvnYZm5AV+CBsgp4Tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846679; c=relaxed/simple;
	bh=M1B6PSqs3mLHM3mvD6fg7uTHF8T8whmyA7TzpyvoU5w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKk1/vl0be42dWsC4sBRdFpvdnazk96CRmIVNQB1VxdlM+by3IVXFsQVTQZf4zF8J+3qZdkHvGWV5PVjwWYQn5VVKiCsncMqdLd4NupG/dfBdl6w/v0ou4T6Nr75BHOCmIUtD9gfPP/1QvdyOWfTfr5j7knZPQf/R0wArqYvu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq97mzZx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso6905493a12.0;
        Mon, 28 Apr 2025 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745846676; x=1746451476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk+rQdyPHf5M/l5Mo66idLyM+oouzc6qIFIoc5ERgDI=;
        b=Mq97mzZx3EBC65z+NwmlagGytU20J1HaNF0lATWzGLEmuztqsHlTQtShIGQSK3iz6f
         vTKuymmvx66t5Q2ngSZplC8geXBoKsJt7R4YvXSY74epm9Q00ZyJxEEkOQVq6LwBdyV7
         /q2MY6vAIkWjJjCVOv5PYt/rWdd/iezOP9Hzc9r7NwQ+nv7BxX7r0Aey3YtuV4Wzds1C
         A6qey5NP41im0c6ZmEewjRsUateGojmaiRZ+YkZvNvYLNiiaT28nfO1SLU7r7vALEBBz
         /IPZK2B23tqDnyGn+2/G4Z59krTmkWp3ji1tYxBfdm+ha9g2aWeY1XLwMMSPlJ/L5h/f
         Ml5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846676; x=1746451476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk+rQdyPHf5M/l5Mo66idLyM+oouzc6qIFIoc5ERgDI=;
        b=hkHaWcLSYD8vxMkF8hO3AQ84IdjnWucsEBhV9FcNEYkJa0KTtWJOSd2n9pXf9sI0s1
         ENfYBjn4hst322eAaKYvsNfo7qPQI6htRKx69dwCAs+n7oT85LEBGxFMNXnFviq0EoHg
         mJCeoy4qC9Efz5irMt31jAQv+4ZYe1Pjzwce2NL9QNbrinnyqrSd7Ixb2J7NyrWokkIz
         DXOJL4+oh7Byqjd3vxHVxM/VORRPYKZgCZ5YFh0QNbXn3rBYhHsvmox6YQ2pjAM8zGco
         oHtGpg+zo/tl32qmR5WyGcy1MtjClPFHkECFu1he3QWcepbM+6cbqp8cp2HUvEJPZ1jz
         e4nA==
X-Forwarded-Encrypted: i=1; AJvYcCUpMzZ7CV07+5KFV9L1nMAV1hA9p9c21UmKJ9PNPlO8AjoOwdfX46SI7TIu1cCX6euUrmM=@vger.kernel.org, AJvYcCUvr2po5lmOQaZ4NrmNv3Th1tO17XZRoxoUf3/cuy6cRIsc/L3SIXhR2NFiixwZUcLDA82sfxaE70FIuT2tUTWDhroU@vger.kernel.org, AJvYcCXPFVub7RFZWa3iCa24TC66ZslV25WkBrPuLfVv6FJLE5Wx1WvUIUD/ZRE6tfVZ6H7qbU1NzFXsNfdiZYqG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1a7W7/qk+kwjwHNSTnSzYWipMuBP1XKH6YJDL/eQ8QF3NENE8
	7gqv4PSKrS5Cw58UWQEiLueIRoZd3C12JzHPFSEcGmkvTE2vwqf8
X-Gm-Gg: ASbGncvU6Wkhp9ke0ng61Y1yNPlTECKyAyiST1Mg7mixdBj+ykeav7omW0Dp2cH/WHX
	RUnZOFGPn7EBujYDnFurLyEN40FXZNVq5bYQoiLw/CVZAuGGEvM8XRVCFxcWXo9/8rGz1f4jLvs
	4tGJklLyNoxfB6xbhBYqAG3BWT1bv3gLiQFiSkxxeDtiM5Sp44RVOyWtQI0M9d6e4s6/dErUGL4
	tE3xW7DUCamts0BvPRbiWeg416r4sv3OONWqB2j/HkC5ImeN3ZxJzRUdT5RXD2SIPd/gPNfwe/s
	RALCx2QuQnDIFBbopY//UNH/75I=
X-Google-Smtp-Source: AGHT+IE5N/b2/FeEm/redeb6VyMziOkFUUGinKYlPihlM88gzw8Jgsm1pH2eGnQazv8Sl68tqkvv4A==
X-Received: by 2002:a05:6402:2b96:b0:5ee:497:67d7 with SMTP id 4fb4d7f45d1cf-5f723b1be6dmr9912967a12.34.1745846676052;
        Mon, 28 Apr 2025 06:24:36 -0700 (PDT)
Received: from krava ([173.38.220.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f6424sm6011635a12.42.2025.04.28.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:24:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Apr 2025 15:24:33 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aA-BkV6drOEY8KaC@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-11-jolsa@kernel.org>
 <20250427171143.GA27775@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427171143.GA27775@redhat.com>

On Sun, Apr 27, 2025 at 07:11:43PM +0200, Oleg Nesterov wrote:

SNIP

> > +void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	uprobe_opcode_t insn[5];
> > +
> > +	/*
> > +	 * Do not optimize if shadow stack is enabled, the return address hijack
> > +	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
> > +	 * the entry uprobe is optimized and the shadow stack crashes the app.
> > +	 */
> > +	if (shstk_is_enabled())
> > +		return;
> 
> Not sure I fully understand the comment/problem, but ...

the issue is that sys_uprobe adjusts rsp to skip the uprobe trampoline stack frame
(which is call + 3x push), so the uprobe consumers see expected stack

then if we need to hijack the return address we:
  - update the return value on actual stack (updated rsp)
  - we update shadow stack with shstk_update_last_frame (last shadow stack frame)
    which will cause mismatch and the app crashes on trampoline's ret instruction

I think we could make that work, but to make it simple I think it's better
to skip it for now


> what if
> prctl(ARCH_SHSTK_ENABLE) is called after arch_uprobe_optimize() succeeds?

so that would look like this:

  foo:
    [int3 -> call tramp] hijack foo's return address
    ...

    prctl(ARCH_SHSTK_ENABLE)
    ...
    prctl(ARCH_SHSTK_DISABLE)

    ret -> jumps to uretprobe trampoline

at the time 'prctl(ARCH_SHSTK_ENABLE)' is called the return address is already
hijacked/changed in any case IIUC you need to disable shadow stack before
'foo' returns

thanks,
jirka

