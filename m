Return-Path: <bpf+bounces-54768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A2A71B9A
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4990166132
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13341F30AD;
	Wed, 26 Mar 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRsAfEPt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AA158D80
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005760; cv=none; b=ZTBP048OTnnM3OqaiGk9vBmqfvsNMofoPyEUWdP9zUNy1pDPu28vP6anAvNspKCRnAbhvwtg6Mz+DDXT75rhuQZRfIwO06sjSruyvFmOwSyw25JJN0csgDk+UryW8JhSH0xhCjXEQ5yUsafKkN9TmJkj03A/MCgczGJ3dULyEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005760; c=relaxed/simple;
	bh=gHhkC74FYzw/gXxj96d5znm7fPsEAOAP8f680R7SsXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MgtPg3qzXWzxr5DLTUknixaQJsOnrAYCeKIi6g+KX8WRWebLnXRPjUvmXC43ERuXbSzhm5VITdom5Rf/Bu2i/wDYR2mqn/IFqSo2CCsf+/vMJscNptJDEc00HqmtA0+DV4dPiTZgSNk82f9W+N1TQxk8WJ0JvBlvhJyntDVm+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRsAfEPt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ac9aea656so1836299f8f.3
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743005757; x=1743610557; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fF58Ag1wphZzn6pMqlzMhuHlw+JS4kycZnZ4uyMNWo=;
        b=jRsAfEPtWNh9qkQy3ao2At3GCZ3eXqFVMJQR3/HVtQL34SJ+j8/NVdT/Y3LeByxnrZ
         lVjYC9ljs9Vw/NygDkyodGzt96VAyVvntureum0DyXg9LKriiERtCG1HzQEPSoUmYkOz
         0ciMjstKVjZMJUW36BRQms8ylsHu+tCJ9QuA+hB806nwdV8s6TwsO+6DCC2E3+KRBAHd
         v4XZFIZxBPCgF0xhEjDQcAfuBO/80LeqUBQf14M1ckEbZag9YaFdvWfdqQE3MMkIlWAI
         AFrmjCHUX8l+S3BSPm/SEt7+ruP3mPuslfJcUDtxJnt8o31S1a5oXN4Fcw2zUpspR4VK
         g1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743005757; x=1743610557;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fF58Ag1wphZzn6pMqlzMhuHlw+JS4kycZnZ4uyMNWo=;
        b=lW0ZHs5TbBoOXLrGP5iRbAulylJOiftS37IFQZAxo8CUzL1audg+ewZfIR9tdaqqUp
         In4byL2gb4Z0uvF3+pBpshlEp36dWrOYOZm3mlWhdy8kskNaNcGEVvMvyuujmSYIhRFl
         fdeoO1qj4r1hibfKjfuuA5kdv2OrUo1CGi0XjpfUcs8Zc/tPjvyxEXmBA6bvH41pSJcX
         O+YjrGzUc4vMLzSuaoeSqr+8oUj4zXJ6Gvq3LwYqR4UAs85FYn90ix+xUq2WNFw9QMYB
         6FrFkTO/9mxfaln5JIv462AVQOt8/y9U8bENrO8riP+JOJhXc5uc98qWQPJFpuw8QF0i
         GWXw==
X-Forwarded-Encrypted: i=1; AJvYcCWNTtJfOs9C/jtY+5LdO1Z4clyuX+8IFMGGXY2tc/rH525wftaKrhCkfi5X2E2LkCGCMyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytF7so/TAKtYGgJS2YtY8zvuveW+SBs/g7ZKS9Cdx0Bac68xNs
	4L72HdQ79eRlFeDLG4NCs8yAqIoa9ZMPjIWuGfB/kcpxvnEDkCGi3L2/0vXyGbKKlc8zT2qeChu
	/+heIRv5l3dKMIu/nQtH3L3q1MV8=
X-Gm-Gg: ASbGncu6wZLNce3xitSRHKDNAvY8Rc13R3kdrHTqebHttc/ckqXw/AyFd8NL5t6s6cB
	LtbSthtBJnE41Y45wFVSJ+O6fYoA9OwnrNKmtRmW+TfSAH97p9XhkZRmlBdXTSlqZ1pOe13AV/D
	w4LNmLhDDEPJQbsKjDbkEaraOQ
X-Google-Smtp-Source: AGHT+IER9kfdQW5+Pn9luuFIOejvnMqs+wW91dXCrH3q9YlG6wZRhXKWkpaamHwFIT2O7Q28L6XXmLU51RwOS6vIg3I=
X-Received: by 2002:a5d:5886:0:b0:391:3406:b4e2 with SMTP id
 ffacd0b85a97d-3997f940d74mr17043728f8f.49.1743005756652; Wed, 26 Mar 2025
 09:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQ+=x31Rcjh6-qX1C+d2q0LBRCH=1gPqfKOaMXYx_fkQjw@mail.gmail.com>
In-Reply-To: <CAADnVQ+=x31Rcjh6-qX1C+d2q0LBRCH=1gPqfKOaMXYx_fkQjw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Mar 2025 12:15:44 -0400
X-Gm-Features: AQ5f1JohkDRRRSCrvZoHTh5TBlQk9mNw7PfwquS3T_Q4qM-QMvtggO1IlqDxCnI
Message-ID: <CAADnVQKfkGxudNUkcPJgwe3nTZ=xohnRshx9kLZBTmR_E1DFEg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reentrant kmalloc usable from any context
To: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Hou Tao <houtao1@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> A year ago Vlastimil kicked off a discussion:
> "What's next for the SLUB allocator"
> https://lwn.net/Articles/974138/
>
> One of the proposed goals was to adopt slub allocator to use cases
> where bespoke allocators are currently used either due to
> performance requirements or context restrictions.
> bpf_mem_alloc, kretprobe's objpool, mempool were mentioned
> as initial targets. netpoll should probably be on that list too.
>
> Performance might be addressed by sheaves
> while context restrictions are more difficult to solve.
> bpf, kretprobe, netpool don't know the context where they
> might be called. Currently bpf, kretprobe handler preallocate.
> Preallocated pools pin memory to one subsystem make it
> unavailable to the rest of the kernel.
> This has to be fixed. mm subsystem needs to own, share,
> distribute the memory.
>
> Agenda for the discussion:
> - discuss and agree on problem statement
>   what is being solved, why, requirements of the solution
> - discuss pros and cons of the existing design that we
>   made a bunch of progress on
> - brainstorm next steps

Here are the slides from the talk:
https://github.com/4ast/docs/blob/main/Reentrant%20kmalloc.pdf

